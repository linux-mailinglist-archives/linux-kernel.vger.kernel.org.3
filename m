Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B10A464344
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbhK3XdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345503AbhK3Xct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:32:49 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D99C0613B4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:29:05 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso32529036otj.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBlLVo15vKPqye9C0Se/eW54Sxe3fPkQFnql5WhyrIs=;
        b=Doo/uGck2RIAxwwe7wWhZO3kqfsAXXSs3c32MiAee5Khs8Uujwm7H88hJyHFHwpYvU
         f+im8wrFVjJABWfIXR29qlzoG4sjc7F0axzVMa2IFoQpSHfZ3f9FyDdEf20MelvmAeaU
         Ft9r/jy4q95PexHdMpA197yzYAUp0j6p8CPPtCmD8i9L16htwhXeOfiuy/bucVvvliKh
         ntKjZfOI/fJCnAyXn7QkzUHqw4dO3W3eJiyJZet2Qvh/zae85gEvNXxW1v4r+gn8N5At
         TyRbQTRCvkU3pl0D+Bkzaqg5ZP61392qgjInqdi03nIfh7hS7vk4tSQKZBrEZGt7KC9d
         7aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBlLVo15vKPqye9C0Se/eW54Sxe3fPkQFnql5WhyrIs=;
        b=GgeZ+EvJO8hrTnWW2B8CfzI2Y+PAcs58OJKne3tpE9NvbZegPqzwwJbN3pOWB3lcyh
         stT9JXvXR0/q9KiupiAIGXiBlsrwGa0ttxEVXVzo1+9s6yDKoELkadBZpy3ZweTaF60K
         RTfSXiP8GHBSWT/4fPbtfGzv3nIkKZP3EtZ6Zai12WcaPJ/I03uJ1bdhVWohXvkoNPAe
         2o8GefUnJOb8OSuioSsMvVb7XL86TYhea0AVcWOfuPNDNUIWEF9Db46njaEgAkMtcVOy
         lOAYenF1SL5AO4o1D4RAau2e+gQUvD6hcWKPtnZkfyHAotcF1Jw215xkTXJnaglbBuz2
         bjlA==
X-Gm-Message-State: AOAM5331PSjK1+X5jstszMFjrSRYsxElxRYk6TF+CSZnvNs02/1LFj+N
        O9L1Ls7jZplfKYnK+4W6+TGthIT+yiXCw7Bo9s/c8S9qW8t8wg==
X-Google-Smtp-Source: ABdhPJzLxELQs1l3/djBy+u7jfnddSFDHxS5W0m4gFpSMy/Qz1MqvIpcAMo/zjFweww0GjSO0FW37OgB/c4+XiAtn4s=
X-Received: by 2002:a9d:662:: with SMTP id 89mr2223791otn.157.1638314943985;
 Tue, 30 Nov 2021 15:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20211126124746.761278-1-glider@google.com> <b740b48e-2675-d324-d35c-d96f973f24e0@intel.com>
 <CAG_fn=WVwh0593rX-+OwEHxEcHO9GHc-Tux=XzQs5F-T+os_5Q@mail.gmail.com>
In-Reply-To: <CAG_fn=WVwh0593rX-+OwEHxEcHO9GHc-Tux=XzQs5F-T+os_5Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Dec 2021 00:28:51 +0100
Message-ID: <CANpmjNPO1Sa6nrhFB0EjHF8jJivHyViz_vpBQEB78hMaY=HCfw@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu/signal: initialize sw_bytes in save_xstate_epilog()
To:     Alexander Potapenko <glider@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        chang.seok.bae@intel.com, bp@suse.de, dvyukov@google.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 22:39, Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 10:09 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 11/26/21 4:47 AM, Alexander Potapenko wrote:
> > > save_sw_bytes() did not fully initialize sw_bytes, which caused KMSAN
> > > to report an infoleak (see below).
> > > Initialize sw_bytes explicitly to avoid this.
> > ...
> > > Reported-by: Alexander Potapenko <glider@google.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > Tested-by: Alexander Potapenko <glider@google.com>
> > > Fixes: 53599b4d54b9b8dd ("x86/fpu/signal: Prepare for variable sigframe length")
> > > Link: https://lore.kernel.org/all/CAG_fn=V9T6OKPonSjsi9PmWB0hMHFC=yawozdft8i1-MSxrv=w@mail.gmail.com/
> >
> > Hi Alexander,
> >
> > Marco's SoB entry is before yours.  Was this authored by you or Marco?
> > If it was Marco, it's customary to add a:
> >
> >         From: Marco Elver <elver@google.com>
> >
> > at the top of the changelog to make sure git gets the author right.  I'm
> > happy to fix it up this time, I just need to know who wrote it.
>
> Hi Dave,
>
> Yes, it was authored by Marco. Thanks in advance for fixing this, I'll
> keep that in mind next time :)

I produced a diff, but Alex tested and wrote the commit message.

I'm happy to have Alex be the primary author here, he spent more time
on this. :-)
If you want it to be more precise, you could add a:

Co-developed-by: Marco Elver <elver@google.com>

Thanks,
-- Marco
