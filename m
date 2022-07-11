Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6F570DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiGKXCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:02:03 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC65FAE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:02:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id c18-20020a17090a8d1200b001ef85196fb4so6561260pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6HZTXRLqo/8phSSGx4LtiryFoKC4QXTfVKLTgEMjAPM=;
        b=o3liI5oKlmf3CRZ3JudkUyA+S45s1xuUjQgg4qUAgzbUSSujxg49gSp0NnUZkgYNbR
         rHpUSfdNJjROD77RNYHlkBV5fo8d1/p8YdE1na4Ny48l+efsyWXQBNtnscRZExG1oYRb
         qEZ4Sf/+/R9glUdZqMpAImdqO9UMG2fyRv1SCg5Fk5v7dPr5D9GPf0ghw9lOpDQ0Ft48
         +fEFM56q6B9ddNI9k8LzGZGsf1q3f7tZHqkeGZZ1UICHTPTvG69YFHVOp8QKJz4PEn0W
         Ta/uaowo7hlglqqOdTBFbdM70PUUhgFgKc1Vy6+Ddgl24GW5avbvTKjdiPgPGHYxTM2W
         BkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6HZTXRLqo/8phSSGx4LtiryFoKC4QXTfVKLTgEMjAPM=;
        b=lbj0S3Mt/xpIjjPNMgnuUmnk4Z/lKSyr7Vs3mt2djH6NYiTmwnWw7MdWJAdLLHfLfk
         ShkRwTpnpcRF+n6SLJTGU6BaFdQ9dAYvBTNQ9xCbVKAs1Eab2d+OY1iiqC2AkBCbBFV+
         iy9tkZfhetzQyLpIz1g3GS4oqnQ+tjNshntVsoi5Ha+gN9gfmkNjqyvyooY6EpJP7Xpp
         J5UOy8vbV4Olo1tiTibrpNDkTk+rr4NaZ/Xstxj51eBG6tWEO89crDx6IcjqdoKlIl/z
         s77tqumszIoSpUGjDaFUfYjLZ0qyNVypqX3IhwLTTP17Ddo0yp/nMCNNZ8CXFxX9nGVF
         Je2g==
X-Gm-Message-State: AJIora/zXf8ArI4TGFbGGtn5sD9JKpYIEo9kTWQ/SCQkz+2IVLiaWkLY
        EzIM/6JApFUUreulc0WCTW2vMgyWOFwxBEv0oQ==
X-Google-Smtp-Source: AGRyM1s8GAUw6oJb4kdKctccEL9cc/33sTeAzDqLpBI9KS5As9yYb495GOej4rAX/0fCqnwT+cLLAWkWWXzBrvAh8w==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:4bd0:f760:5332:9f1c])
 (user=justinstitt job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP
 id t9-20020a17090a024900b001e0a8a33c6cmr31669pje.0.1657580522068; Mon, 11 Jul
 2022 16:02:02 -0700 (PDT)
Date:   Mon, 11 Jul 2022 16:01:48 -0700
Message-Id: <20220711230148.2130871-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH] ntb: idt: fix clang -Wformat warnings
From:   Justin Stitt <justinstitt@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>
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

When building with Clang we encounter these warnings:
| drivers/ntb/hw/idt/ntb_hw_idt.c:2409:28: error: format specifies type
| 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
| "\t%hhu-%hhu.\t", idx + cnt - 1);
-
| drivers/ntb/hw/idt/ntb_hw_idt.c:2438:29: error: format specifies type
| 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
| "\t%hhu-%hhu.\t", idx + cnt - 1);
-
| drivers/ntb/hw/idt/ntb_hw_idt.c:2484:15: error: format specifies type
| 'unsigned char' but the argument has type 'int' [-Werror,-Wformat], src);

For the first two warnings the format specifier used is `%hhu` which
describes a u8. Both `idx` and `cnt` are u8 as well. However, the
expression as a whole is promoted to an int as you cannot get
smaller-than-int from addition. Therefore, to fix the warning, use the
promoted-to-type's format specifier -- in this case `%d`.

example:
``
uint8_t a = 4, b = 7;
int size = sizeof(a + b - 1);
printf("%d\n", size);
// output: 4
```

For the last warning, src is of type `int` while the format specifier
describes a u8. The fix here is just to use the proper specifier `%d`.

See more:
(https://wiki.sei.cmu.edu/confluence/display/c/INT02-C.+Understand+integer+conversion+rules)
"Integer types smaller than int are promoted when an operation is
performed on them. If all values of the original type can be represented
as an int, the value of the smaller type is converted to an int;
otherwise, it is converted to an unsigned int."

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: This patch silences the -Wformat warnings for this file (which is
the goal) but in reality all instances of `%hh[dux]` should be converted
to `%[dux]` for this file and probably every file. That's a bit larger
scope than the goal of enabling -Wformat for Clang builds, though.

 drivers/ntb/hw/idt/ntb_hw_idt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 733557231ed0..0ed6f809ff2e 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2406,7 +2406,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
 				"\t%hhu.\t", idx);
 		else
 			off += scnprintf(strbuf + off, size - off,
-				"\t%hhu-%hhu.\t", idx, idx + cnt - 1);
+				"\t%hhu-%d.\t", idx, idx + cnt - 1);
 
 		off += scnprintf(strbuf + off, size - off, "%s BAR%hhu, ",
 			idt_get_mw_name(data), ndev->mws[idx].bar);
@@ -2435,7 +2435,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
 					"\t%hhu.\t", idx);
 			else
 				off += scnprintf(strbuf + off, size - off,
-					"\t%hhu-%hhu.\t", idx, idx + cnt - 1);
+					"\t%hhu-%d.\t", idx, idx + cnt - 1);
 
 			off += scnprintf(strbuf + off, size - off,
 				"%s BAR%hhu, ", idt_get_mw_name(data),
@@ -2480,7 +2480,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
 		int src;
 		data = idt_ntb_msg_read(&ndev->ntb, &src, idx);
 		off += scnprintf(strbuf + off, size - off,
-			"\t%hhu. 0x%08x from peer %hhu (Port %hhu)\n",
+			"\t%hhu. 0x%08x from peer %d (Port %hhu)\n",
 			idx, data, src, ndev->peers[src].port);
 	}
 	off += scnprintf(strbuf + off, size - off, "\n");
-- 
2.37.0.144.g8ac04bfd2-goog

