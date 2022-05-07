Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0147B51EA8E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbiEGWwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 18:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiEGWw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 18:52:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9911EC42
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 15:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF32DB8015B
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 22:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380BCC385A6;
        Sat,  7 May 2022 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651963716;
        bh=3hD1odyYF7+plVfTKfPnnOghRVD+Di4Bd0iPgA+Z/dA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SuHx4dpP+1BSmITPs2XpGR8bUMFnY40RpuUT7xlz8Lg54faCp+cj5/YEpaWDRohZ2
         +l7Fu55zT0NufMEdSXcG5PDJAIA13ILxZKHibHbDWI1yHKMtDbuvR/Jb1NeKOlCpD+
         hJzMM7nmt1h2yFB0b9wxFxP/7k/tSmTii/cSkluo=
Date:   Sat, 7 May 2022 15:48:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm] tracing: incorrect gfp_t conversion
Message-Id: <20220507154835.4d4d737d8eed579969f15938@linux-foundation.org>
In-Reply-To: <8b1cfefa-da7d-3376-cf04-1ff77dab8170@openvz.org>
References: <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
        <331d88fe-f4f7-657c-02a2-d977f15fbff6@openvz.org>
        <20220507123728.f20d977eba9fbb66bddee722@linux-foundation.org>
        <8b1cfefa-da7d-3376-cf04-1ff77dab8170@openvz.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 May 2022 01:28:58 +0300 Vasily Averin <vvs@openvz.org> wrote:

> On 5/7/22 22:37, Andrew Morton wrote:
> > On Sat, 7 May 2022 22:02:05 +0300 Vasily Averin <vvs@openvz.org> wrote:
> >> +	{(__force unsigned long)GFP_KERNEL,		"GFP_KERNEL"},		\
> >> +	{(__force unsigned long)GFP_NOFS,		"GFP_NOFS"},		\
> > 
> > This got all repetitive, line-wrappy and ugly :(
> > 
> > What do we think of something silly like this?
> 
> > --- a/include/trace/events/mmflags.h~tracing-incorrect-gfp_t-conversion-fix
> > +++ a/include/trace/events/mmflags.h
> > @@ -13,53 +13,57 @@
> >   * Thus most bits set go first.
> >   */
> >  
> > +#define FUL __force unsigned long
> > +
> >  #define __def_gfpflag_names						\
> > -	{(__force unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
> > -	{(__force unsigned long)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
> ...
> > +	{(FUL)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
> > +	{(FUL)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
> 
> 
> I think it's a good idea, and I regret it was your idea and not mine.

heh

> Should I resend my patch with these changes or would you prefer 
> to keep your patch as a separate one?

I did the below.  I'll squash them together later.


--- a/include/trace/events/mmflags.h~tracing-incorrect-gfp_t-conversion-fix
+++ a/include/trace/events/mmflags.h
@@ -13,53 +13,57 @@
  * Thus most bits set go first.
  */
 
+#define FUL __force unsigned long
+
 #define __def_gfpflag_names						\
-	{(__force unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
-	{(__force unsigned long)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
-	{(__force unsigned long)GFP_HIGHUSER_MOVABLE,	"GFP_HIGHUSER_MOVABLE"},\
-	{(__force unsigned long)GFP_HIGHUSER,		"GFP_HIGHUSER"},	\
-	{(__force unsigned long)GFP_USER,		"GFP_USER"},		\
-	{(__force unsigned long)GFP_KERNEL_ACCOUNT,	"GFP_KERNEL_ACCOUNT"},	\
-	{(__force unsigned long)GFP_KERNEL,		"GFP_KERNEL"},		\
-	{(__force unsigned long)GFP_NOFS,		"GFP_NOFS"},		\
-	{(__force unsigned long)GFP_ATOMIC,		"GFP_ATOMIC"},		\
-	{(__force unsigned long)GFP_NOIO,		"GFP_NOIO"},		\
-	{(__force unsigned long)GFP_NOWAIT,		"GFP_NOWAIT"},		\
-	{(__force unsigned long)GFP_DMA,		"GFP_DMA"},		\
-	{(__force unsigned long)__GFP_HIGHMEM,		"__GFP_HIGHMEM"},	\
-	{(__force unsigned long)GFP_DMA32,		"GFP_DMA32"},		\
-	{(__force unsigned long)__GFP_HIGH,		"__GFP_HIGH"},		\
-	{(__force unsigned long)__GFP_ATOMIC,		"__GFP_ATOMIC"},	\
-	{(__force unsigned long)__GFP_IO,		"__GFP_IO"},		\
-	{(__force unsigned long)__GFP_FS,		"__GFP_FS"},		\
-	{(__force unsigned long)__GFP_NOWARN,		"__GFP_NOWARN"},	\
-	{(__force unsigned long)__GFP_RETRY_MAYFAIL,	"__GFP_RETRY_MAYFAIL"},	\
-	{(__force unsigned long)__GFP_NOFAIL,		"__GFP_NOFAIL"},	\
-	{(__force unsigned long)__GFP_NORETRY,		"__GFP_NORETRY"},	\
-	{(__force unsigned long)__GFP_COMP,		"__GFP_COMP"},		\
-	{(__force unsigned long)__GFP_ZERO,		"__GFP_ZERO"},		\
-	{(__force unsigned long)__GFP_NOMEMALLOC,	"__GFP_NOMEMALLOC"},	\
-	{(__force unsigned long)__GFP_MEMALLOC,		"__GFP_MEMALLOC"},	\
-	{(__force unsigned long)__GFP_HARDWALL,		"__GFP_HARDWALL"},	\
-	{(__force unsigned long)__GFP_THISNODE,		"__GFP_THISNODE"},	\
-	{(__force unsigned long)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},	\
-	{(__force unsigned long)__GFP_MOVABLE,		"__GFP_MOVABLE"},	\
-	{(__force unsigned long)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},	\
-	{(__force unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
-	{(__force unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
-	{(__force unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
-	{(__force unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
-	{(__force unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"}	\
+	{(FUL)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},		\
+	{(FUL)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, 	\
+	{(FUL)GFP_HIGHUSER_MOVABLE,	"GFP_HIGHUSER_MOVABLE"},	\
+	{(FUL)GFP_HIGHUSER,		"GFP_HIGHUSER"},		\
+	{(FUL)GFP_USER,			"GFP_USER"},			\
+	{(FUL)GFP_KERNEL_ACCOUNT,	"GFP_KERNEL_ACCOUNT"},		\
+	{(FUL)GFP_KERNEL,		"GFP_KERNEL"},			\
+	{(FUL)GFP_NOFS,			"GFP_NOFS"},			\
+	{(FUL)GFP_ATOMIC,		"GFP_ATOMIC"},			\
+	{(FUL)GFP_NOIO,			"GFP_NOIO"},			\
+	{(FUL)GFP_NOWAIT,		"GFP_NOWAIT"},			\
+	{(FUL)GFP_DMA,			"GFP_DMA"},			\
+	{(FUL)__GFP_HIGHMEM,		"__GFP_HIGHMEM"},		\
+	{(FUL)GFP_DMA32,		"GFP_DMA32"},			\
+	{(FUL)__GFP_HIGH,		"__GFP_HIGH"},			\
+	{(FUL)__GFP_ATOMIC,		"__GFP_ATOMIC"},		\
+	{(FUL)__GFP_IO,			"__GFP_IO"},			\
+	{(FUL)__GFP_FS,			"__GFP_FS"},			\
+	{(FUL)__GFP_NOWARN,		"__GFP_NOWARN"},		\
+	{(FUL)__GFP_RETRY_MAYFAIL,	"__GFP_RETRY_MAYFAIL"},		\
+	{(FUL)__GFP_NOFAIL,		"__GFP_NOFAIL"},		\
+	{(FUL)__GFP_NORETRY,		"__GFP_NORETRY"},		\
+	{(FUL)__GFP_COMP,		"__GFP_COMP"},			\
+	{(FUL)__GFP_ZERO,		"__GFP_ZERO"},			\
+	{(FUL)__GFP_NOMEMALLOC,		"__GFP_NOMEMALLOC"},		\
+	{(FUL)__GFP_MEMALLOC,		"__GFP_MEMALLOC"},		\
+	{(FUL)__GFP_HARDWALL,		"__GFP_HARDWALL"},		\
+	{(FUL)__GFP_THISNODE,		"__GFP_THISNODE"},		\
+	{(FUL)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},		\
+	{(FUL)__GFP_MOVABLE,		"__GFP_MOVABLE"},		\
+	{(FUL)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},		\
+	{(FUL)__GFP_WRITE,		"__GFP_WRITE"},			\
+	{(FUL)__GFP_RECLAIM,		"__GFP_RECLAIM"},		\
+	{(FUL)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},	\
+	{(FUL)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},	\
+	{(FUL)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"}		\
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define __def_gfpflag_names_kasan ,					       \
-	{(__force unsigned long)__GFP_SKIP_ZERO,	   "__GFP_SKIP_ZERO"},	       \
-	{(__force unsigned long)__GFP_SKIP_KASAN_POISON,   "__GFP_SKIP_KASAN_POISON"}, \
-	{(__force unsigned long)__GFP_SKIP_KASAN_UNPOISON, "__GFP_SKIP_KASAN_UNPOISON"}
+#define __def_gfpflag_names_kasan ,					\
+	{(FUL)__GFP_SKIP_ZERO,		"__GFP_SKIP_ZERO"},		\
+	{(FUL)__GFP_SKIP_KASAN_POISON,	"__GFP_SKIP_KASAN_POISON"},	\
+	{(FUL)__GFP_SKIP_KASAN_UNPOISON,"__GFP_SKIP_KASAN_UNPOISON"}
 #else
 #define __def_gfpflag_names_kasan
 #endif
 
+#undef FUL
+
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
 	__def_gfpflag_names __def_gfpflag_names_kasan			\
_

