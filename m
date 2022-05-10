Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9050E5226A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiEJWJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiEJWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:09:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E9289BD9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:08:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so78700plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9wKOeHUc2xnhBn2gmB2Ek1IaCVg0XLzxAc3hNyfWilQ=;
        b=K2ASJuEd+iD69DLoR1SkVzlMzX/UTfBdn/8tDBQ/EVWLM4dHjtlT+uiOV6MEp7j4mW
         UGPc+jw7BrCbQvRcsUTyE/u8BV+0iBPiMJkLu3GLKxLsY7ULcriSxDZXYD/iH17Ua4SD
         1Uh00kSRYnnOqL7wyAOlfDKfayhL+wp642usM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9wKOeHUc2xnhBn2gmB2Ek1IaCVg0XLzxAc3hNyfWilQ=;
        b=nHmd5rT7PUI3m/d/+z5jaRKSgy6oidbMnsFY3LtpJ4jIqK/bZOqk/jEn+zlgK+gy0u
         VtysWmzsibca4/848nkezvD2TCiB9vkEjqdNfmKdGBB2jeCnlAIv/9vKGoHUHwoSpCRd
         qeM0rFUkb/PHjwmLEMzBLTG95H8Hla4AZsgj7nnduZydfrEw9nt3HDyeeHjm787w8jpC
         MLIIgdagA2rCqk/CxpQt183cx7nXOOAOe3xozvrG4kC3qr4ZNq5E918lhVAcCUV6h2S6
         3Qa9wk2q87F5rlnG1KA1bttkhkZvf4PqBhbSDcv7Pxbuc5kZWY5AhGgadv90Xd6mmQTm
         OvRg==
X-Gm-Message-State: AOAM530VXBGaAbRBy4ekERoZbL51lWrmOY91NoIeP0NqHPKq4L9YpBGp
        R/fOOVHLSmiWHEd0z6be6uljbg==
X-Google-Smtp-Source: ABdhPJy+LLX5xA/kUFaFAHebnTbvGLx+1zVxbGcEcO117WqJqHQJRLNgd3uF01bnDEg6dbT0zXcufw==
X-Received: by 2002:a17:90b:1894:b0:1dc:1028:aecb with SMTP id mn20-20020a17090b189400b001dc1028aecbmr1957870pjb.106.1652220538079;
        Tue, 10 May 2022 15:08:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k6-20020a63d846000000b003c14af505f9sm221971pgj.17.2022.05.10.15.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 15:08:57 -0700 (PDT)
Date:   Tue, 10 May 2022 15:08:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH V10 14/44] mm/pkeys: Introduce pks_set_readwrite()
Message-ID: <202205101504.5B5C693F7C@keescook>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-15-ira.weiny@intel.com>
 <202205091304.434A9B45@keescook>
 <YnraD8URWxWtaltF@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnraD8URWxWtaltF@iweiny-desk3>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 02:33:03PM -0700, Ira Weiny wrote:
> On Mon, May 09, 2022 at 02:38:38PM -0700, Kees Cook wrote:
> > [...]
> > Better yet would be:
> > 
> > 	preempt_disable();
> > 	rdmsrl(MSR_IA32_PKRS, pkrs);
> > 	pkrs = pkey_update_pkval(pkrs, pkey, protection);
> > 	pks_write_pkrs(pkrs);
> > 	current->thread.pkrs = pkrs;
> > 	preempt_enable();
> > 
> > Then cross-thread attacks cannot corrupt the _other_ PKS keys (i.e.
> > write the desired changes to target's current->thread.kprs and trigger
> > an update to a different pkey, resulting in flushing the attacker's
> > changes to that CPU's pkey state.
> 
> Unfortunately I don't think this entirely prevents an attack through the
> thread.pkrs value.  thread.pkrs has to be used to set the MSR when a thread is
> scheduled.  Therefore the rdmsrl above will by definition pick up the
> thread.pkrs but from an earlier time.

Ooh, good point, yeah.

> I'm not opposed to doing this as I think it does reduce the time window of such
> an attack but I wanted to mention it.  Especially since I specifically avoided
> ever reading the MSR to improve performance.
> 
> I'm going to run some tests.  Perhaps the MSR read is not that big of a deal
> and I can convince myself that the performance diff is negligible.

Yeah, given "loaded at scheduling" point, there's not much benefit in
read/write pair. I think my first suggestion about only writing to
thread.pkrs after the write, etc, still stands. I'll ponder this a bit
more.

> > While adding these, can you please also add pks_set_nowrite()? This
> > will be needed for protecting writes to memory that should be otherwise
> > readable.
> 
> I have a patch to add pks_set_readonly() but I was advised to not send it
> because this series does not include a use case for it.  (PMEM does not need
> it.)
> 
> Dave, Dan?  Are you ok adding that back?
> 
> Kees would you prefer pks_set_nowrite() as a name?

I think nowrite is the better name (in the sense that "read-only" can
sometimes imply non-executable).

> > 
> > With these changes it should be possible to protect the kernel's page
> > table entries from "stray" writes. :)
> 
> Yes, Rick has done some great work in that area.

Oh! I would _love_ to see this series. I was trying to scope the work
yesterday but gave up after I couldn't figure out the qemu PKS trick. :)

-- 
Kees Cook
