Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066C158B4B3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiHFJBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiHFJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:01:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D306247
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 02:01:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gk3so8643326ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DvA7gIYLKdSlMsij3HUvnX2FQpTb4BmvioirPFjs7cI=;
        b=m+5r+cX5H9Ep5iYGbILeoOvHfYSF5Wg/s+5Xkz38RMFUQhmigwChbijRwI21lYybpY
         vLOaTbP3y52FwjXH2gRa2V2Wc0YyIKGru5AM+Mh3+Xc3yJrDgmn/mS0lTOFOC+igk14R
         COG/f6RVH9F3hZnUhLCuD48hYU2+agdTjQelfDRGP15KVPIVkVCmT0h9YLBFjD//Jag7
         E234qd6FjSLva9SD/kHF2otu8fZaS1f0RfjA2wm1FlugBNTh/RUxyRO+eaezVdJu9Jwk
         XDN/TQr0uoWuVRxvVEwcGYJ1yRMvi/gMoJyQ2uHWw/sGu8DDdziCgCWd+1svXRz3MG0w
         UmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DvA7gIYLKdSlMsij3HUvnX2FQpTb4BmvioirPFjs7cI=;
        b=5+HOAUVCcJTyZo1Q1oIWRUO100/3xlbmrhk5iAII9cbAIcwFX8jvrTGT6jXxJOB2WL
         41s45qFX5UvjmJH52bo5y3kmRsgeFnmXL/mEjcM8ei/87PLTKUgwXyvDg1CRWGvbBQGk
         7MGQWqan9rG/Gk2OxvDfDHBCxU36kYUDZZkB9LpwInCGeRhhj5QfAsHYPOhG+mkaUBJa
         aj9TuabLRnIhflHf/DgzZG6pJBMBqGg8KWDslFr162zp2M16Lsvp0RjFU1P4VFK+iaqW
         ocKZ4rV3qeBbG6o2aU7sTWSr6dBwIX2qsty2dupqaHgtpkcJfsdfCL5UJivmN8NDM/d1
         6hhw==
X-Gm-Message-State: ACgBeo2jg3yGccmOC+E2fPwSg6wwKX36R+IQWUX0pu8LO1X9JvfZIudQ
        ogEtrp0ki4Alfh5ynlFWqIY=
X-Google-Smtp-Source: AA6agR5q3YeZ/o15o6tsAzRGwp/OESnBLi6FZGe1vnPyKN+v4Vxt1USE6yp5sSqsGR+nh6QJpGXr0w==
X-Received: by 2002:a17:906:7955:b0:72f:97d9:9796 with SMTP id l21-20020a170906795500b0072f97d99796mr7900853ejo.436.1659776468925;
        Sat, 06 Aug 2022 02:01:08 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id ee41-20020a056402292900b0043cf1c6bb10sm1196338edb.25.2022.08.06.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 02:01:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Aug 2022 11:01:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     ira.weiny@intel.com, Rik van Riel <riel@surriel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Message-ID: <Yu4t0jkpIY4grgxL@gmail.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 8/5/22 10:30, ira.weiny@intel.com wrote:
> > +static inline void arch_save_aux_pt_regs(struct pt_regs *regs)
> > +{
> > +	struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
> > +
> > +	aux_pt_regs->cpu = raw_smp_processor_id();
> > +}
> 
> This is in a fast path that all interrupt and exception entry uses.  So,
> I was curious what the overhead is.
> 
> Code generation in irqentry_enter() gets a _bit_ more complicated
> because arch_save_aux_pt_regs() has to be done on the way out of the
> function and the compiler can't (for instance) do a
> 
> 	mov    $0x1,%eax
> 	ret
> 
> to return.  But, the gist of the change is still only two instructions
> that read a pretty hot, read-only per-cpu cacheline:
> 
> 	mov    %gs:0x7e21fa4a(%rip),%eax        # 15a38 <cpu_number>
> 	mov    %eax,-0x8(%rbx)
> 
> That doesn't seem too bad.

It's still 2 instructions more than what we had before, while the 
fault-time CPU number is only needed infrequently AFAICS.

Thanks,

	Ingo
