Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8849BF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiAYXbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:31:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42756 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiAYXa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:30:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 780D8612D6;
        Tue, 25 Jan 2022 23:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47102C340E0;
        Tue, 25 Jan 2022 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643153457;
        bh=vB572nhmJuqCEgij4Dpji3wv3pIEvKb1pTOhhC//V2c=;
        h=Date:From:To:Cc:Subject:From;
        b=bHeH3TlIs6solJO243CJerwTfQLCEsu1sOHUOUVN8WYqvXoL6fuKosKa+BFp6hwIj
         Db/S2MS8lFNYcuGhjxvoZvDlIMZjIf4Wvg6fgQWyWuMBHm0voOktjco69X2L2hf7x6
         BvQO2qVDYk0NuXbnrGSDt4QDvBkF7BbJ0U2zcRYYmJyuHgxestrUtm4nM2ZPhdGWcn
         qxWLMVfn2tGI+DJfupaqeeEmV2oZ2PMff/ibc4EUNld3Zp92126ALUhaVLto+K93Bb
         fO2qIHAtGiaqsPbZebrIgLkRGCFp2osK3GFRXShB/u5FnO8V7P7LxapLP5iBstGQ64
         hksE/cEPiagaA==
Date:   Tue, 25 Jan 2022 17:37:44 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] HID: google: Use struct_size() helper in kzalloc()
Message-ID: <20220125233744.GA81239@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/hid/hid-google-hammer.c:61:23: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/hid/hid-google-hammer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 0403beb3104b..ddbe0de177e2 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -58,7 +58,7 @@ static int cbas_ec_query_base(struct cros_ec_device *ec_dev, bool get_state,
 	struct cros_ec_command *msg;
 	int ret;
 
-	msg = kzalloc(sizeof(*msg) + max(sizeof(u32), sizeof(*params)),
+	msg = kzalloc(struct_size(msg, data, max(sizeof(u32), sizeof(*params))),
 		      GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
-- 
2.27.0

