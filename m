Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160F359B94A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiHVGW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiHVGW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15282275C2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661149375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nn4jF27DFlQd4RWn0PQw34qeK9JpgLOLE2krBPtSffM=;
        b=fslQWwpRylkvCj+/Vvrw/mPfA4jq4fCn8ZSMv6ynoEZ17HvOGy6Di/Wo9iNasemIfhihrF
        wXec1+El+x5gurmb1e3uYUb3ZLmOO5C8Pfal1xKgFJFz9c4BE0SrTUsaFBc8HzL9hXrO0i
        amUNCwkM+KDQXVxStx9sezXh7uLekiA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-oWilpA_WMdKNbxA-Luhz_w-1; Mon, 22 Aug 2022 02:22:50 -0400
X-MC-Unique: oWilpA_WMdKNbxA-Luhz_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 566F43C0CD4A;
        Mon, 22 Aug 2022 06:22:50 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8911121314;
        Mon, 22 Aug 2022 06:22:49 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Stefan Hansson <newbie13xd@gmail.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: input: fix uclogic tablets
Date:   Mon, 22 Aug 2022 08:22:47 +0200
Message-Id: <20220822062247.1146141-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 87562fcd1342 ("HID: input: remove the need for HID_QUIRK_INVERT")
made the assumption that it was the only one handling tablets and thus
kept an internal state regarding the tool.

Turns out that the uclogic driver has a timer to release the in range
bit, effectively making hid-input ignoring all in range information
after the very first one.

Fix that by having a more rationale approach which consists in forwarding
every event and let the input stack filter out the duplicates.

Reported-by: Stefan Hansson <newbie13xd@gmail.com>
Fixes: 87562fcd1342 ("HID: input: remove the need for HID_QUIRK_INVERT")
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 48c1c02c69f4..871a185a0f1f 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1532,7 +1532,10 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 			 * assume ours
 			 */
 			if (!report->tool)
-				hid_report_set_tool(report, input, usage->code);
+				report->tool = usage->code;
+
+			/* drivers may have changed the value behind our back, resend it */
+			hid_report_set_tool(report, input, report->tool);
 		} else {
 			hid_report_release_tool(report, input, usage->code);
 		}
-- 
2.37.1

