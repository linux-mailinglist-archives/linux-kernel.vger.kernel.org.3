Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C5542ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiFHLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbiFHLIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:08:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BED1C287F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:08:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8532C6160D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166B7C385A2;
        Wed,  8 Jun 2022 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686493;
        bh=UMfDSCsZHz1ZMzu0+7xplVRluayGlh2A7KTsd2h7WmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dn1BoIeXoBkNeOBhVdH53LyXtnFgSnPuWGMbvu3Bwl6X/5glCRJK5aAplHSnsE7Sp
         URBu2ZzBNgeJ6DHOBuyrR5YF57foeFG//Pvv27QppQsCNhPCng3HD9tXjObF+5TXUO
         ru6Ouk0DaN4F494COrfydlUyxfNfeie1odlqC67GoxZEev/UPFGD3K/XWzbiLsrpwB
         Napx+mt14WrwcwIu68xvKoita2twgphFgP3GQYdlwd9hUyqFjMLd1df9FThVHkoLUB
         QntBnvPhXzRmRkXR+ETgUjY22Ec/OToS0L+f+qojsFCW23FtKtQHk4r3DS2B3k3qnB
         HbTmV0ro50uzg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/23] platform/chrome: cros_ec_proto: handle empty payload in getting cmd mask
Date:   Wed,  8 Jun 2022 11:07:31 +0000
Message-Id: <20220608110734.2928245-21-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220608110734.2928245-1-tzungbi@kernel.org>
References: <20220608110734.2928245-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_get_host_command_version_mask() expects to receive
sizeof(struct ec_response_get_cmd_versions) from send_command().  The
payload is valid only if the return value is positive.

Return -EPROTO if send_command() returns 0 in
cros_ec_get_host_command_version_mask().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
No v2.  New and separated from the original series.

 drivers/platform/chrome/cros_ec_proto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 6a5771361383..9e95f9e4b2f8 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -458,6 +458,11 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
 		goto exit;
 	}
 
+	if (ret == 0) {
+		ret = -EPROTO;
+		goto exit;
+	}
+
 	rver = (struct ec_response_get_cmd_versions *)msg->data;
 	*mask = rver->version_mask;
 	ret = 0;
-- 
2.36.1.255.ge46751e96f-goog

