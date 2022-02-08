Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9734B4AD136
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiBHFpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiBHFpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:45:52 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B759CC0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:45:51 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id u13so19484191oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=XrBR3Z6sNHBE3F8dS7ks+pwfdAB/4VMPu38anB8K2BA=;
        b=p9JkK0YzQQCGtJ6AxXMsB49RdW+J7x3blhxceHThDWZBxnE6MCt4V//+J1Z6LNmB1t
         PpucP0cIkv/zwbb2LbCLz+dal3lSnt7nJHIrMlB7QkAN1vMh8SZ+UQUzthyx2EsvTl0/
         TG0rD1hC1P734j4fErus88jPbeItXvuUsCTSz4e3tN9GdPr+0pIi5zYVkiyvg+99MRT/
         c1iUA1B6jpvsSSHYFPyP8wZz5JcOWqaMcR79NFC4uJ6jT3/dBDRkZ7Gho6NRtzsBdM14
         ueiHe8P73t5z2NxlDmgepqZv3/mLbmcjb0tkieX/jCwY4p6X4LmMmun3KYgp5Vzkon7E
         gKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=XrBR3Z6sNHBE3F8dS7ks+pwfdAB/4VMPu38anB8K2BA=;
        b=BXuhy55vEmBIO2p26X8As53fP1lTGggMzmPmnw0DWGfScnK1ANMSdhrpk5V1cGyKKH
         Si980v3Sc0Z7alkDbAiVJxjReoHwr+i+wu7ZrEJu9UZqjmRUCdDwhgMmKMUc3G3wmmhx
         9GNjDRTyTK8a58vlBpo/FBcxBvg3v6K3Cv2fBAdQJkwKefx0hXXomvMWM4k/e1cy3ZAG
         hOKXeSWXKtMA3UXuIfSVqGrnURIghuz/eubUiVPmEC55MB4BfJ78Je7rQZclnrUv/N35
         wXsq4mIiyoMIgNHAHrcY9wj5ogasZWFWXzi/YUjRZjYC2hiBHxsWmthbm6PINV5UsQLP
         RP7g==
X-Gm-Message-State: AOAM531PMpwgU1MIfKbiVV1q6csOX5nOuVJv/IIVyuA6g81ECNBVrJkj
        57RhxzSJWRy+oTV9chEVPkN9iA==
X-Google-Smtp-Source: ABdhPJxOL2ViOxybjwTVZdwTsQaqqI8/jkdRK366oK8j4WUiWhRBFz/DyC2tpkClQaIqMOImPiv57g==
X-Received: by 2002:a05:6808:252:: with SMTP id m18mr1080870oie.285.1644299150912;
        Mon, 07 Feb 2022 21:45:50 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s11sm4704743otq.69.2022.02.07.21.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:45:50 -0800 (PST)
Date:   Mon, 7 Feb 2022 21:45:36 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Borislav Petkov <bp@suse.de>
cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: x86: should clear_user() have alternatives?
Message-ID: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

I've noticed that clear_user() is slower than it need be:

dd if=/dev/zero of=/dev/null bs=1M count=1M
1099511627776 bytes (1.1 TB) copied, 45.9641 s, 23.9 GB/s
whereas with the hacked patch below
1099511627776 bytes (1.1 TB) copied, 33.4 s, 32.9 GB/s

That was on some Intel machine: IIRC an AMD went faster.

It's because clear_user() lacks alternatives, and uses a
nowadays suboptimal implementation; whereas clear_page()
and copy_user() do support alternatives.

I came across this because reading a sparse file on tmpfs uses
copy_page_to_iter() from the ZERO_PAGE(), and I wanted to change that
to iov_iter_zero(), which sounds obviously faster - but in fact slower.

I realize that dd'ing from /dev/zero to /dev/null, and sparse files on
tmpfs, are not prime candidates for optimization; and I've no idea how
much clear_user() normally gets used for long clears.

If I were capable of compiler asm, with alternatives, and knew at what
length ERMS becomes advantageous when clearing, I would be sending you
a proper patch.  As it is, I'm hoping to tempt someone else to do the
work!  Or reject it as too niche to bother with.

Thanks,
Hugh

Hacked patch against 5.16 (5.17-rc is a little different there):

 arch/x86/lib/copy_user_64.S |   26 ++++++++++++++++++++++++++
 arch/x86/lib/usercopy_64.c  |   36 +-----------------------------------
 2 files changed, 27 insertions(+), 35 deletions(-)

--- 5.16/arch/x86/lib/copy_user_64.S	2022-01-09 14:55:34.000000000 -0800
+++ erms/arch/x86/lib/copy_user_64.S	2022-01-22 16:57:21.156968363 -0800
@@ -392,3 +392,29 @@ SYM_FUNC_START(__copy_user_nocache)
 	_ASM_EXTABLE_CPY(41b, .L_fixup_1b_copy)
 SYM_FUNC_END(__copy_user_nocache)
 EXPORT_SYMBOL(__copy_user_nocache)
+
+/*
+ * Recent CPUs have added enhanced REP MOVSB/STOSB instructions.
+ * It's recommended to use enhanced REP MOVSB/STOSB if it's enabled.
+ * Assume that's best for __clear_user(), until alternatives are provided
+ * (though would be better to avoid REP STOSB for short clears, if no FSRM).
+ *
+ * Input:
+ * rdi destination
+ * rsi count
+ *
+ * Output:
+ * rax uncopied bytes or 0 if successful.
+ */
+SYM_FUNC_START(__clear_user)
+	ASM_STAC
+	movl %esi,%ecx
+	xorq %rax,%rax
+1:	rep stosb
+2:	movl %ecx,%eax
+	ASM_CLAC
+	ret
+
+	_ASM_EXTABLE_UA(1b, 2b)
+SYM_FUNC_END(__clear_user)
+EXPORT_SYMBOL(__clear_user)
--- 5.16/arch/x86/lib/usercopy_64.c	2020-12-13 14:41:30.000000000 -0800
+++ erms/arch/x86/lib/usercopy_64.c	2022-01-20 18:40:04.125752474 -0800
@@ -13,43 +13,9 @@
 /*
  * Zero Userspace
  */
-
-unsigned long __clear_user(void __user *addr, unsigned long size)
-{
-	long __d0;
-	might_fault();
-	/* no memory constraint because it doesn't change any memory gcc knows
-	   about */
-	stac();
-	asm volatile(
-		"	testq  %[size8],%[size8]\n"
-		"	jz     4f\n"
-		"	.align 16\n"
-		"0:	movq $0,(%[dst])\n"
-		"	addq   $8,%[dst]\n"
-		"	decl %%ecx ; jnz   0b\n"
-		"4:	movq  %[size1],%%rcx\n"
-		"	testl %%ecx,%%ecx\n"
-		"	jz     2f\n"
-		"1:	movb   $0,(%[dst])\n"
-		"	incq   %[dst]\n"
-		"	decl %%ecx ; jnz  1b\n"
-		"2:\n"
-		".section .fixup,\"ax\"\n"
-		"3:	lea 0(%[size1],%[size8],8),%[size8]\n"
-		"	jmp 2b\n"
-		".previous\n"
-		_ASM_EXTABLE_UA(0b, 3b)
-		_ASM_EXTABLE_UA(1b, 2b)
-		: [size8] "=&c"(size), [dst] "=&D" (__d0)
-		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
-	clac();
-	return size;
-}
-EXPORT_SYMBOL(__clear_user);
-
 unsigned long clear_user(void __user *to, unsigned long n)
 {
+	might_fault();
 	if (access_ok(to, n))
 		return __clear_user(to, n);
 	return n;
