Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E4F47CBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhLVD11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:27:27 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:27546 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234027AbhLVD10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:27:26 -0500
X-QQ-mid: bizesmtp50t1640143633tc58mi2c
Received: from localhost.localdomain (unknown [118.121.66.4])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 22 Dec 2021 11:27:12 +0800 (CST)
X-QQ-SSF: 01000000008000D0K000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8e770YOXNoRcis8idCOUq04m9DzcfbEYSd7OLEwyBwlodVcSnAPy
        syAhQqjIQpB5CngmdBtkfgCdEg4nhzagz2/BIOHAUvYpbHeBPkVZS3FuDuj6DRNsBcw3dnV
        4Mq2HCasd81NKOz5U+wRW4mihp03dAjWeVXwPA08uh9laQeiWARdRhldPJjH9fwEs7Njymp
        EibdJFB/W8uouKUaaB+qx1I9O2JO+fHnbybRA5DVZ/Llqk+POsDW/pMiCAxwbHZQtK4aQZ8
        uklZ6rU9uu7rPecHeuh+1dPshTYGQAw2w1YIzaP9QAatqObnZIMMABmIlS02S0usn2oGmEW
        twJdAKX
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ipmi: ssif: replace strlcpy with strscpy
Date:   Wed, 22 Dec 2021 11:27:07 +0800
Message-Id: <20211222032707.1912186-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy should not be used because it doesn't limit the source
length. So that it will lead some potential bugs.

But the strscpy doesn't require reading memory from the src string
beyond the specified "count" bytes, and since the return value is
easier to error-check than strlcpy()'s. In addition, the implementation
is robust to the string changing out from underneath it, unlike the
current strlcpy() implementation.

Thus, replace strlcpy with strscpy.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 48aab77abebf..ba779f1abb5b 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1354,7 +1354,7 @@ static int ssif_detect(struct i2c_client *client, struct i2c_board_info *info)
 	if (rv)
 		rv = -ENODEV;
 	else
-		strlcpy(info->type, DEVICE_NAME, I2C_NAME_SIZE);
+		strscpy(info->type, DEVICE_NAME, I2C_NAME_SIZE);
 	kfree(resp);
 	return rv;
 }
-- 
2.34.1

