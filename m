Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A94C397B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiBXXDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiBXXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D79141986E1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645743754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HnOBb78GLVNNv6PC7YyfKNTBlpalqvUKFNmaAgPGZ4w=;
        b=V5LQystGpz7JopFUDSH26nk0J9qskdP+gh7FB8xAkgpz+21sCop5JycN7HvbAL6dpdc7gz
        jKdUQOZkPaeiCBlCqcWpYOpR7Fbj30m/X2g1e2DkrRNmh2gBd1jGUTKzmX719br+IuCWmE
        9aNSJzuen6q1TR4jp5WgEFbNo433BT4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-O400PZ9vP9yifiJL9qY6kQ-1; Thu, 24 Feb 2022 18:02:33 -0500
X-MC-Unique: O400PZ9vP9yifiJL9qY6kQ-1
Received: by mail-qt1-f197.google.com with SMTP id u28-20020a05622a199c00b002dd4f5801fbso818093qtc.14
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HnOBb78GLVNNv6PC7YyfKNTBlpalqvUKFNmaAgPGZ4w=;
        b=kdvnQThg47AGfMjvoHAXoTho0g1Wl0myWirXOMPkq/fWKbc/2ezOSpiWO5mJK9fCJw
         uIEzjyEAoHac99JJimqmh2xyfqcIe6FZKEhcH6px0TczZKa+RE2RecbD64vukdrgkSw7
         LMaJKH/mL4nxJQ2/5a2yuto3bUmvFA3s8FHzevwu0YBOdqHrElvWP2Vr7Z4VtkFM7BTx
         RrzzvQwLBnJlR/OawVXd78X0z75RrfiAX2ho3wuGy2tvxiPJLJ9J3mj9FaYB+K1q+TA5
         14WknoVlPf6W0GIe/f08aSOg40m4/BYz2Yrg3RSwy1WTMiPLXs2Lud3EtY6P4V9vibwm
         pCMw==
X-Gm-Message-State: AOAM532+/HKcxcDkMuOJ8iQqCM7ijsItfeq1KeNl2Sy0jQxMdRjCQ4Ut
        QNQIoisRT5aSGQlYbSqsUww+vnjq30ET2KGI/NzDOKd0TfYSnwcmpJCriWYzSlvJOckQ4UqaWOX
        R3/RZ9ekohmuHq4iBVf3p2SaD
X-Received: by 2002:ac8:5b56:0:b0:2dd:b428:d2cc with SMTP id n22-20020ac85b56000000b002ddb428d2ccmr4606687qtw.304.1645743753032;
        Thu, 24 Feb 2022 15:02:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDJa6bCuv/Wm/hhgnUbs1c8OBG3DCRoqXPrf4g4CA3NRDNyIPB+7iDl2jcE8mXoWOLm5O2BA==
X-Received: by 2002:ac8:5b56:0:b0:2dd:b428:d2cc with SMTP id n22-20020ac85b56000000b002ddb428d2ccmr4606659qtw.304.1645743752732;
        Thu, 24 Feb 2022 15:02:32 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm469853qkc.73.2022.02.24.15.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 15:02:32 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:02:03 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 13/39] x86/livepatch: Validate __fentry__ location
Message-ID: <20220224230203.a5z3mppfcywuvogq@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.776015583@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151322.776015583@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:51PM +0100, Peter Zijlstra wrote:
> Currently livepatch assumes __fentry__ lives at func+0, which is most
> likely untrue with IBT on. Instead make it use ftrace_location() by
> default which both validates and finds the actual ip if there is any
> in the same symbol.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/livepatch.h |    9 +++++++++
>  kernel/livepatch/patch.c         |    2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> --- a/kernel/livepatch/patch.c
> +++ b/kernel/livepatch/patch.c
> @@ -133,7 +133,7 @@ static void notrace klp_ftrace_handler(u
>  #ifndef klp_get_ftrace_location
>  static unsigned long klp_get_ftrace_location(unsigned long faddr)
>  {
> -	return faddr;
> +	return ftrace_location(faddr);

Now that ftrace is doing the dirty work, I think this means we can get
rid of klp_get_ftrace_location() altogether:

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 4fe018cc207b..7b9dcd51af32 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -19,16 +19,6 @@ static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
 	regs_set_return_ip(regs, ip);
 }
 
-#define klp_get_ftrace_location klp_get_ftrace_location
-static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
-{
-	/*
-	 * Live patch works only with -mprofile-kernel on PPC. In this case,
-	 * the ftrace location is always within the first 16 bytes.
-	 */
-	return ftrace_location_range(faddr, faddr + 16);
-}
-
 static inline void klp_init_thread_info(struct task_struct *p)
 {
 	/* + 1 to account for STACK_END_MAGIC */
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index fd295bbbcbc7..ed3464e68bda 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -124,19 +124,6 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	ftrace_test_recursion_unlock(bit);
 }
 
-/*
- * Convert a function address into the appropriate ftrace location.
- *
- * Usually this is just the address of the function, but on some architectures
- * it's more complicated so allow them to provide a custom behaviour.
- */
-#ifndef klp_get_ftrace_location
-static unsigned long klp_get_ftrace_location(unsigned long faddr)
-{
-	return ftrace_location(faddr);
-}
-#endif
-
 static void klp_unpatch_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
@@ -153,8 +140,7 @@ static void klp_unpatch_func(struct klp_func *func)
 	if (list_is_singular(&ops->func_stack)) {
 		unsigned long ftrace_loc;
 
-		ftrace_loc =
-			klp_get_ftrace_location((unsigned long)func->old_func);
+		ftrace_loc = ftrace_location((unsigned long)func->old_func);
 		if (WARN_ON(!ftrace_loc))
 			return;
 

