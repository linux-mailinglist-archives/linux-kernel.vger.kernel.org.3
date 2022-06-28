Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBB55C8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbiF1Mic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiF1Mib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:38:31 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC3B2DABF;
        Tue, 28 Jun 2022 05:38:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1F9A63F38A;
        Tue, 28 Jun 2022 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656419905;
        bh=PlJGMxqqZX0JynyKbbC2D1kesVnUtHM3lue6u6DvQ60=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=T9srd950/DVx1FwCt2QdEgiWz9YJ+ah9UjHwSZFXz7n9STBn5q6jXx3fRu10QzKah
         +FzKoQPiSGlrRvhRQqbTVa/i9IsqM558XH8GV+Pa7aPJkSnUJBTEtd7DgKVITzH/2Q
         7K1YmrlnQyDVD2gmLqt+d3GgYei8XmMTRrMXj5xPHRQQ6mUY92OuSb7YmYy1SOIKRp
         hb2UhKAXrBVSjmZp1KLCtea+lo6YIYzQWVcKCba6CmwrGs4uApNFblc6vlgHbMouOF
         +x9O3QP9WqHKZoREzp4cOyl0qJj1IJprvq2sNj7HHwIFjkc0oPHmpRStynbVOPgTBH
         w9Ac0+y/lFP7A==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Ignore Sanitization Mode event
Date:   Tue, 28 Jun 2022 20:37:26 +0800
Message-Id: <20220628123726.250062-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After system resume the hp-wmi driver may complain:
[ 702.620180] hp_wmi: Unknown event_id - 23 - 0x0

According to HP it means 'Sanitization Mode' and it's harmless to just
ignore the event.

Cc: Jorge Lopez <jorge.lopez2@hp.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/platform/x86/hp-wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 0d8cb22e30df9..bc7020e9df9e8 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -89,6 +89,7 @@ enum hp_wmi_event_ids {
 	HPWMI_BACKLIT_KB_BRIGHTNESS	= 0x0D,
 	HPWMI_PEAKSHIFT_PERIOD		= 0x0F,
 	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
+	HPWMI_SANITIZATION_MODE		= 0x17,
 };
 
 /*
@@ -853,6 +854,8 @@ static void hp_wmi_notify(u32 value, void *context)
 		break;
 	case HPWMI_BATTERY_CHARGE_PERIOD:
 		break;
+	case HPWMI_SANITIZATION_MODE:
+		break;
 	default:
 		pr_info("Unknown event_id - %d - 0x%x\n", event_id, event_data);
 		break;
-- 
2.36.1

