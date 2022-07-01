Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B028A563CC2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 01:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiGAXVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 19:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiGAXVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 19:21:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81F871BCF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:21:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b129-20020a25e487000000b0066e1c52ac55so398521ybh.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r1hNWMzTHbP1T3u0oJfFG4ATF129b7TBwtFs10zIbH0=;
        b=AfniH5QTWUN+wqcSlLlKuJx5yJp8JJHk89CfEEMl5lQ1ICN/xG92kx5WNxs+hwMLDj
         y1MPwtf1lGA1NblcuJoqXrs4bHlUiq1iRR4w2azrECLCuIIInWJydMnwbeDO9A1gacJ3
         6MGIh5dly4GfP0UxK6LkaOJEKAyc0fb9wkYVNqLZI/LJvBlKOBg9aYrMP5pGDiKej7u1
         +TSLG69EXbh9UkRVy1yh07pPtZuKzomVtNA3mYLLapw8CWSLayla3G2XPDgskRdknVyf
         NEpGzNbVutswz0xnFL6MooUMFGxU0t5boARFQ0DJRPTPIgfUU9whtp2A/smT/aBmeW2C
         fGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r1hNWMzTHbP1T3u0oJfFG4ATF129b7TBwtFs10zIbH0=;
        b=41SFVZIZMoMYZvUMKDfXLtHYY4CN8l8Bedo4dUYZ3lWN6cxi/yGpXri0OfiGpG2ls2
         oiyaZCCbTNCvAuKYnOa10zACM8M/Xl0Yp6zj2mMJNSAijO1y+d827O2U6sBAbAXJeKPC
         k6vYMfSsCZyQwSlBen2HZoSw9dEqyWwLg0rZZq8QVV0oemr4t8mUZkyZnPGi5goVVMTJ
         54/AUUY9QJAmCP5NOP/2qYi2mOPUjO4hpANfUxptkCSbISJLVX3bbl9b4zek+RFstZor
         nBAJzB9dVvTI9yJE5DIdvi7bGiP7dnv5h32qq7fKhJEpSZD+bMG/IlsTkDpqwo80D/s9
         4TxA==
X-Gm-Message-State: AJIora9SLvjZFdopDGBaga1hw2K+Vj0fKVTZsOqVw5kg3tYI2pknGMkf
        YsS67WEn2fMWjI+5Qh0w3JHzabhpZPRZmm6sJQ==
X-Google-Smtp-Source: AGRyM1vS8lR6ohgVW9YKUmSTvCAVBF+D2wOLXwW/aqjioj8VQIMa9zehx7RkG7my6+BiriAauGh24+9hI4ngKzSURg==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:a7a5:71:ddd5:892b])
 (user=justinstitt job=sendgmr) by 2002:a0d:f9c1:0:b0:31b:726f:9ef2 with SMTP
 id j184-20020a0df9c1000000b0031b726f9ef2mr20290827ywf.252.1656717710164; Fri,
 01 Jul 2022 16:21:50 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:20:31 -0700
Message-Id: <20220701232031.2639134-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] eeprom: idt_89hpesx: fix clang -Wformat warnings
From:   Justin Stitt <justinstitt@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

see warnings:
| drivers/misc/eeprom/idt_89hpesx.c:570:5: error: format specifies type
| 'unsigned char' but the argument has type 'u16' (aka 'unsigned short')
| [-Werror,-Wformat] memaddr);
-
| drivers/misc/eeprom/idt_89hpesx.c:579:5: error: format specifies type
| 'unsigned char' but the argument has type 'u16' (aka 'unsigned short')
| [-Werror,-Wformat] memaddr);
-
| drivers/misc/eeprom/idt_89hpesx.c:814:4: error: format specifies type
| 'unsigned short' but the argument has type 'unsigned int'
| [-Werror,-Wformat] CSR_REAL_ADDR(csraddr));

There's an ongoing movement to eventually enable the -Wformat flag for
clang. See: https://github.com/ClangBuiltLinux/linux/issues/378

The format specifier for idt_89hpesx.c:570 and 579 was `0x%02hhx`. The
part we care about `%hhx` describes a single byte format, wherein the
leftmost byte of our u16 type (of which memaddr is) is truncated.

example:
```
uint16_t x = 0xbabe;
printf("%hhx\n", x);
// output is: be
// we lost 'ba'
```

There exists a similar issue at idt_89hpesx.c:814 which involves the
CSR_REAL_ADDR macro. This macro returns a u16 but due to default
argument promotion for variadic functions (printf-like) actually
provides an int to the dev_err method.

My proposed solution is to expand the width of the format specifier to
fully encompass the provided argument (which is promoted to an int, see
below). I opted for '%x' as this specifies an unsigned hexadecimal
integer which, with a guarantee, can represent all the values of a u16.

As per C11 6.3.1.1:
(https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf)
`If an int can represent all values of the original type ..., the
value is converted to an int; otherwise, it is converted to an
unsigned int. These are called the integer promotions.`

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index b0cff4b152da..42eac114edd7 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -566,7 +566,7 @@ static int idt_eeprom_read_byte(struct idt_89hpesx_dev *pdev, u16 memaddr,
 		eeseq.memaddr = cpu_to_le16(memaddr);
 		ret = pdev->smb_write(pdev, &smbseq);
 		if (ret != 0) {
-			dev_err(dev, "Failed to init eeprom addr 0x%02hhx",
+			dev_err(dev, "Failed to init eeprom addr 0x%02x",
 				memaddr);
 			break;
 		}
@@ -575,7 +575,7 @@ static int idt_eeprom_read_byte(struct idt_89hpesx_dev *pdev, u16 memaddr,
 		smbseq.bytecnt = EEPROM_RD_CNT;
 		ret = pdev->smb_read(pdev, &smbseq);
 		if (ret != 0) {
-			dev_err(dev, "Failed to read eeprom data 0x%02hhx",
+			dev_err(dev, "Failed to read eeprom data 0x%02x",
 				memaddr);
 			break;
 		}
@@ -810,7 +810,7 @@ static int idt_csr_read(struct idt_89hpesx_dev *pdev, u16 csraddr, u32 *data)
 	smbseq.bytecnt = CSR_RD_CNT;
 	ret = pdev->smb_read(pdev, &smbseq);
 	if (ret != 0) {
-		dev_err(dev, "Failed to read csr 0x%04hx",
+		dev_err(dev, "Failed to read csr 0x%04x",
 			CSR_REAL_ADDR(csraddr));
 		goto err_mutex_unlock;
 	}
-- 
2.37.0.rc0.161.g10f37bed90-goog

