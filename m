Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6D94C51B7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbiBYWrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYWq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFE7A218CF0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645829185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ECMRibCmxY2uk+moEdk5I29xEFgEUca90QSqL40U8Tg=;
        b=DrT+CNc/D1WvPiRc7fKE+94vpUjKQYSxfOh94SHcyxVqZ4FhmDY/+ipAwIT/KzZQ+7A/Oz
        k48/T7l8r9/E3Wwb0TmU1pD8T4GH4elkS9cPHayGXX0gJWlVJjjHD4idzFU4e68+EHvo8r
        ugF7dhXUAgEWfUxrbehUoO3YS9+hT/s=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-GgbO2ERROfK6gGuVRg5aEA-1; Fri, 25 Feb 2022 17:46:24 -0500
X-MC-Unique: GgbO2ERROfK6gGuVRg5aEA-1
Received: by mail-oo1-f71.google.com with SMTP id z9-20020a4a9849000000b0031a574e3571so3708717ooi.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ECMRibCmxY2uk+moEdk5I29xEFgEUca90QSqL40U8Tg=;
        b=f83K1O14M/kRUD9KaJHMXD4Tt1jIIjgGXExHlgLDNhZhmZgpnT/UUwd5QtMasi4oVf
         DHYiMvZp+ux4X4E1wYEJpp8F4qMW+HyDPpsP/7OGthGY6XZOFaIhXLWBK494Ip58ING/
         7AT3/fHq0v2jVbtNkZpR4N6SQSeqqNvqqZqKW6Niagg4KeL7GNpwzYn46q69j7wIWWZd
         xCqOwHyJ/+pdqZGJWZaruMK3RU4r8tW4qby8j70MjxnaydZNFzuTu1RJmT4VzfZ3S8YR
         QBNj2cgannh3qJg+qe6RhHpBZW8v69FXp8i17rZWlSnLD3EIQMAhR0LpFmO1Z9f2DwiO
         VkBA==
X-Gm-Message-State: AOAM530LbkIhe3fhhYE7Wfp50f5wU3BF/S3qFB4dSYmMgoGy7AkIy1NQ
        ClCFqCV/7pfpL45nHnjGRgndHNGihpic/IfO1h7YpAg86RAhcZUqfmz9Igdn5WXKim9llJ/LxNM
        kHtLdOiVpp7z2Mq7PSyM2YWY9
X-Received: by 2002:a05:6808:d52:b0:2d7:4e5a:6edb with SMTP id w18-20020a0568080d5200b002d74e5a6edbmr1104808oik.131.1645829183895;
        Fri, 25 Feb 2022 14:46:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpYvMRBIgSNaegalWfIFfTTpa/u71SqRBo8Aqj1L9/XxrVBqDTcHJHnjdkIDxjbEVToNpnXA==
X-Received: by 2002:a05:6808:d52:b0:2d7:4e5a:6edb with SMTP id w18-20020a0568080d5200b002d74e5a6edbmr1104786oik.131.1645829183686;
        Fri, 25 Feb 2022 14:46:23 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id u24-20020a4ae698000000b0031c286f2e0csm1701163oot.29.2022.02.25.14.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 14:46:23 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:46:19 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 16/39] x86/bpf: Add ENDBR instructions to prologue and
 trampoline
Message-ID: <20220225224619.foms7v6h2qd5qoe2@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.950111925@infradead.org>
 <20220224233731.7hdwbszv5c6fgx4y@treble>
 <YhjKmgIMmx+0Rt19@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhjKmgIMmx+0Rt19@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 01:24:58PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 24, 2022 at 03:37:31PM -0800, Josh Poimboeuf wrote:
> 
> > > @@ -2028,10 +2052,11 @@ int arch_prepare_bpf_trampoline(struct b
> > >  		/* skip patched call instruction and point orig_call to actual
> > >  		 * body of the kernel function.
> > >  		 */
> > > -		orig_call += X86_PATCH_SIZE;
> > > +		orig_call += X86_PATCH_SIZE + 4*HAS_KERNEL_IBT;
> > 
> > All the "4*HAS_KERNEL_IBT" everywhere is cute, but you might as well
> > just have IBT_ENDBR_SIZE (here and in other patches).
> 
> So there's two forms of this, only one has the 4 included:
> 
>   (x * (1 + HAS_KERNEL_IBT))
>   (x + 4*HAS_KERNEL_IBT)
> 
> If I include the 4, then the first form would become something like:
> 
>   (x * (1 + !!IBT_ENDBR_SIZE))
> 
> that ok?

I don't have a strong preference, but there's no harming in having both
IBT_ENDBR_SIZE and HAS_KERNEL_IBT if it would help readability.

-- 
Josh

