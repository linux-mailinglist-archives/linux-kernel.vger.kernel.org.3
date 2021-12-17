Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A7847810D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhLQACf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhLQACe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:02:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8766C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:02:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so960338pjw.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+TWI3NdoNEI/W58gxrEveVnOlB/fmsoP457cxxKc4GM=;
        b=Wuwh9KeJHOoHWTjwiNijDb8lgNSRFB3yBQld8C+YIiPp9VBl21SgJ8lqpz1ob4yxrs
         zzVFjMxDNz8ORDK5AOP1XV9XNxMw4z0AOhXGzlVvhCP9YQRx/lrsSx2cGOuJuDi88xC6
         Cxo6Bh1GtjROxDF/GWwDvyVh0onoX7OCA3T4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+TWI3NdoNEI/W58gxrEveVnOlB/fmsoP457cxxKc4GM=;
        b=EEP4btvXIpyGGrs6RdMLWEwopjBU5bEpGpXrqfYHjF3GMhBp7dLIZV7ja2esO/Yp2H
         EJAIE0T6AgQRg6iaOFdzF4+irsc9am+38iMFlKgonNPVOtLmYRetCtkd6KNMnVPK6HUs
         uB4fakyh3icV12X2/7ke1QAmazhWxG6cCvU9O8LWA2mmYos/U1YewhbE+FOEcFYiLh3D
         J8hhp5vQdHYNqlEBQzZdkzPwwv9WSzFRSCFwDTmdlNsCRR0y+/pAb+Eq5EUVmiI8c+P1
         J13BypeuSQUSIK69fY1GfiQA4LSdoZGfnef38V23fMLTjF6PMPAgk5u9SzVxwqE4IyfI
         bu7g==
X-Gm-Message-State: AOAM530eKm+gTfNySCFdsz6SsCWNxKBJdqIGRGyblmNLkYwh7TkbN9P9
        oAq1j4mT2FK7NtxpHzfTJDMCe4Xj/HACeg==
X-Google-Smtp-Source: ABdhPJy4R+wFcLq1BReRs1eq5kMz6GOIayIjcN1jTXrKcXnbbH5zYSCrCaPJcfdcgXeb0IS8lOXPXg==
X-Received: by 2002:a17:903:300c:b0:148:ac76:b30a with SMTP id o12-20020a170903300c00b00148ac76b30amr233863pla.125.1639699354227;
        Thu, 16 Dec 2021 16:02:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pj12sm9809809pjb.51.2021.12.16.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:02:33 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:02:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lkdtm: avoid printk() in recursive_loop()
Message-ID: <202112161602.C05B8282D@keescook>
References: <20211007081235.382697-1-ardb@kernel.org>
 <163362596339.2313433.1892710945535449841.b4-ty@chromium.org>
 <CAMj1kXFWE68Pozk4Kwqk_vYW96mrvz+XkbjXm-rTo=7ZA_BwTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFWE68Pozk4Kwqk_vYW96mrvz+XkbjXm-rTo=7ZA_BwTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 12:16:19PM +0100, Ard Biesheuvel wrote:
> On Thu, 7 Oct 2021 at 18:59, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, 7 Oct 2021 10:12:35 +0200, Ard Biesheuvel wrote:
> > > The recursive_loop() function is intended as a diagnostic to ensure that
> > > exhausting the stack is caught and mitigated. Currently, it uses
> > > pr_info() to ensure that the function has side effects that the compiler
> > > cannot simply optimize away, so that the stack footprint does not get
> > > reduced inadvertently.
> > >
> > > The typical mitigation for stack overflow is to kill the task, and this
> > > overflow may occur inside the call to pr_info(), which means it could be
> > > holding the console lock when this happens. This means that the console
> > > lock is never going to be released again, preventing the diagnostic
> > > prints related to the stack overflow handling from being visible on the
> > > console.
> > >
> > > [...]
> >
> > Applied to for-next/lkdtm, thanks!
> >
> > [1/1] lkdtm: avoid printk() in recursive_loop()
> >       https://git.kernel.org/kees/c/700fa7d22233
> >
> 
> Ping?

Eek, I didn't send my -next pull to Greg yet. Done now; thanks for the
ping! :)

-Kees

-- 
Kees Cook
