Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAD47EE6A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352521AbhLXLCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbhLXLCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:02:35 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2617C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:02:34 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id v6so13203245oib.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRkmRcWICaT3K2xvivfj413v6vpyCItI+k2BNDZU4sE=;
        b=LGfFibG61EBVMIUGE4EqFFQNIHatHmN6b8E/NsQ2pUtXiUXu3UuoGDwIt5WOiWbe0j
         D1Jmcwev+0HJmL0rXD8M8YgHeTOwDbVr+Bsj0n7byXrVorgphdMS0ZF7f0ZYdMCGRPQ/
         gb6WVTQ9DiDwDvBFabGoJWyF2IA4Vf71Z7G02I8f0haH43aQGldKVCF9GlDHCT6tzEG7
         upVjwMfYvDvkton7b5k831fGo4fF3jBRJcP9u4L51KA8mXPe0acnpgapeh5DSrLCypjX
         HsdaP+q8RNsCunRaffv+sIHlAZX9DrTdVKAMBjLStdZHwsOujRWwOsffPzMPyL4TJyt1
         7BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRkmRcWICaT3K2xvivfj413v6vpyCItI+k2BNDZU4sE=;
        b=gflPBWWeHK92wpMsQoG29fG9je002xPeA1ciIgrUax32JNce1f9Turq7xV9LIM0pXQ
         P5M4JqSGV/UVB5cVzu41aAdlhnFfSmG8k1ql9by7OsZf2sxazRLvfnMfvlGZusuYmttP
         HJCUnHX5aia1IiZLq1c6Uy5Ws2/UiRESO+SRdJ3qz49aFl51SX0Fosh75AUcyfAprCV2
         /w+Rvs2gjxYdfaYhVRvkBlHEwgF6dfcaLo9hwBK7j7BJZ+bAdcG2AAKdpBcv2Qf1iitR
         9yKwrsG1A+LK5HyVRDKltY3GV4b8+VN+WqMOI5b6g2dgzve8CXYgFFIM7SRqziqjvhqb
         aRFA==
X-Gm-Message-State: AOAM532FrG42qtO58NZG/+5FqvVPEZ4CPUXteLOKa27rLqZXUuaPkPHr
        tqFylFzQTdIdahAJwa2DzjLCkQ4vEiWOznm1NsYKyUYFkSs=
X-Google-Smtp-Source: ABdhPJw06dgPfwzlWiKFI8d4NDKavUrrwfkOMaM+Il5BMucDkf8Q9kywuWGWWxWEH3D+0Dc1xQMO/5NQaDcL3jSIuaU=
X-Received: by 2002:a05:6808:1925:: with SMTP id bf37mr3900617oib.7.1640343752831;
 Fri, 24 Dec 2021 03:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20211222075406.57191-1-qiang1.zhang@intel.com>
 <CANpmjNOmaSxqTjUd8y=A+sK0jGg6c00t8uvmOey+QrJsDamsmQ@mail.gmail.com> <PH0PR11MB58802F642473BA6213446AB7DA7F9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58802F642473BA6213446AB7DA7F9@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 24 Dec 2021 12:02:21 +0100
Message-ID: <CANpmjNPU9Yw3RtsSrn0ZfdKQ7XUEp-Ecu9Wcx4HGhH3D+6-CrQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: record kasan stack before enter local_irq_save()/restore()
 critical area
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "Miao, Jun" <jun.miao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 at 04:23, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
>
>
> On Wed, 22 Dec 2021 at 08:54, Zqiang <qiang1.zhang@intel.com> wrote:
> > The kasan_record_aux_stack_noalloc() only record stack, it doesn't
> > need to be called in local_irq_save()/restore() critical area, and the
> > global spinlock (depot_lock) will be acquired in this function, When
> > enable kasan stack, locking contention may increase the time in the critical area.
> >
> >I think the change itself is harmless, because
> >kasan_record_aux_stack_noalloc() doesn't care if interrupts are enabled or not when called, but the justification isn't clear to me.
> >
> >What "locking contention" are you speaking about? You're moving a
> >local_irq_save() which disables interrupts. Yes, it might be nice to reduce the time interrupts are disabled, but in this case the benefit (if any) isn't clear at all, also because this only benefits non-production KASAN kernels.
> >
> >Can you provide better justification? Did you encounter a specific problem, maybe together with data?
> >
>
> Thanks for reply, Yes, this only benefits non-production KASAN kernel.  In KASAN kernel,
> there may be a lot of call stack recorded, in addition to locking competition, the find_stack()  will
> also take a long time.

But there's no locking here, it's disabling interrupts. Yes, a lock is
taken inside kasan_record_aux_stack_noalloc(), but that's not one you
can do much about.

I don't mind this patch, but I think there might be some confusion. A
better explanation (in commit message or otherwise) would help make
sure we're not talking about different things.
