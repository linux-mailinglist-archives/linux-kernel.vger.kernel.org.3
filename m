Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA454FAFEF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbiDJUBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiDJUBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:01:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F724BED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:58:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u19so3169448lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i/oSg9CrxJRnQxeUPmlx0mpM+OCUDcuxMV4Hy9i5v8M=;
        b=msO3gNXWzO1zO1DvK8KfVh+CKsuH7swYmYOgw9kzyO8qJa+4rHqQRFB0D7viyQiemH
         2k38cUCQWXSgzpkelkzGSgOT2YDyCwhozUt5hpeQlHh7/ZvLpaNePEyqmxhkbhZKOVjg
         LPT2GI/Js+asU6nC2//0lxbvP8cc7uQWMs8yWarGaNWuMt150FTCLya/UVeUoBT1mNdV
         w0Xidbn+t3FjKGcfAsQX3MvFwrvB/AZkc8giW3COeH+SWGbXd6gKXW4U3w5w8n2t5vrJ
         Zrym7h71MM6mEkfmsC4RRJOn1g6KhapTS2IypR1QdKWZW4rqq5lM1VNqvfYwTNvH9FRo
         Jiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/oSg9CrxJRnQxeUPmlx0mpM+OCUDcuxMV4Hy9i5v8M=;
        b=YyIs6DldlVDVlt74xcZlpFuBNEJRnIpErnWDUB6BSuw72Xo4BYOv6s0wqxxRGvjsmr
         OFX7/H687OzZQhy29v64r9Q1QX4YNbwtW0arwRqqUkwmtihjJ4x1nahQgEaw578O3Lwo
         owAYz5eENcr+R7Z7/vVDKC5Z3tqq+j8MzyWE3slnQnRcgJL88AgrbepRNRAD7gJ/y7HH
         pvVem+n3AswaFdr1iPA5gs4+/zlbC4eSIOkCL/sdUmGmeZEeHhDX0I23bGLB3O35s99G
         d7BzR7x6a0FQtedDiHr4dBXpoHX5gvQYd8NrLJdc/BW+EbVCmDbHFznca925juJe70q2
         VLMQ==
X-Gm-Message-State: AOAM530oox16E4zFkx20iMzrXO3KZE8beoFX9l15rws+hf6Grg6VxahV
        6Os3/uupRIFf0nabPJiM7bDLog==
X-Google-Smtp-Source: ABdhPJzZpveH/oCPtSdDoCQpCrvmjQzSll2tE6efunLOHYSaUHR8grFJDKHFw3V51hSWc70/OsuZkQ==
X-Received: by 2002:a19:9107:0:b0:46b:96e0:41c9 with SMTP id t7-20020a199107000000b0046b96e041c9mr4657386lfd.333.1649620735223;
        Sun, 10 Apr 2022 12:58:55 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b11-20020ac2410b000000b004457116a575sm3110709lfi.273.2022.04.10.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 12:58:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AD2D410446F; Sun, 10 Apr 2022 23:00:25 +0300 (+03)
Date:   Sun, 10 Apr 2022 23:00:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 14/30] x86: Consolidate port I/O helpers
Message-ID: <20220410200025.3stf4jjvwfe5oxew@box.shutemov.name>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
 <20220405232939.73860-15-kirill.shutemov@linux.intel.com>
 <YlK4SYXV6zbDa1Lq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlK4SYXV6zbDa1Lq@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 12:58:17PM +0200, Borislav Petkov wrote:
> On Wed, Apr 06, 2022 at 02:29:23AM +0300, Kirill A. Shutemov wrote:
> > There are two implementations of port I/O helpers: one in the kernel and
> > one in the boot stub.
> > 
> > Move the helpers required for both to <asm/shared/io.h> and use the one
> > implementation everywhere.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/boot/boot.h             | 35 +-------------------------------
> >  arch/x86/boot/compressed/misc.h  |  2 +-
> >  arch/x86/include/asm/io.h        | 22 ++------------------
> >  arch/x86/include/asm/shared/io.h | 34 +++++++++++++++++++++++++++++++
> >  4 files changed, 38 insertions(+), 55 deletions(-)
> >  create mode 100644 arch/x86/include/asm/shared/io.h
> 
> This complains with clang-13 here, config attached.
> 
> And yap, this is the damn include hell I keep talking about. That
> lib/kalsr.c thing includes the kernel proper io.h header ...

Right. <asm/shared/io.h> is enough for lib/kaslr.c.

What about this:

From 164de295599f8befa2ee1ff05dc03542c02b0800 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Sun, 10 Apr 2022 22:49:28 +0300
Subject: [PATCH] x86/kaslr: Fix build warning in KASLR code in boot stub

lib/kaslr.c used by both the main kernel and the boot stub. It includes
<asm/io.h> that intended to be used in the main kernel. It leads to
build warnings like this:

	warning: implicit declaration of function 'outl' is invalid in
	C99 [-Wimplicit-function-declaration]

Replace <asm/io.h> with <asm/shared/io.h> which is suitable for both
cases.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 1e8f93e18379 ("x86: Consolidate port I/O helpers")
---
 arch/x86/lib/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index 2b3eb8c948a3..a58f451a7dd3 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -11,7 +11,7 @@
 #include <asm/msr.h>
 #include <asm/archrandom.h>
 #include <asm/e820/api.h>
-#include <asm/io.h>
+#include <asm/shared/io.h>
 
 /*
  * When built for the regular kernel, several functions need to be stubbed out
-- 
 Kirill A. Shutemov
