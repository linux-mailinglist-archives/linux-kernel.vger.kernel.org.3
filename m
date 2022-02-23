Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7272B4C0DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiBWHzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbiBWHzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:55:20 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE360CEF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:54:53 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id k2so13576904oia.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dOf41jW+SbVxhrNgz/1309Tg2LU9yaMsGenvPEV/hds=;
        b=EUjrDNavl6Xdtl07S0e5hH3teF2X2AhpcVme19R0H3iVxCWiRydUjt/+G0zgRplcPd
         yFyubejfq8Jso17iqo51SDmkeg1VpdhyH4cUkBpDovOle+BiVmkolS7AW6xC7DxRmZ7+
         imZu0Z+Vt59zi3NaxL9ORm8Siw1J4ryXDHaDpmUq6Nd68SmatDw8kGdooSvQDbx/9fIH
         PuBM6emXs4NY+CSRCUEbflKrSDLYTHHxyN9xX4kGU3XPUuMB876ECuE0K7iKrbIT7kZN
         8N4u6tmRKqlhcMnrl0hethQCKcyOUpOPyPduFKsInWXA0M6alADLmuorUSg5XiGYn0YO
         0xQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dOf41jW+SbVxhrNgz/1309Tg2LU9yaMsGenvPEV/hds=;
        b=IAlB5uN+r1IAQtoQk5XmQOklhzeGkvqz9aSitqqCf7to996yS71oXKjrmn2C4Y1hjk
         MI5cQJoIXIuJF1jfrQYzXg6Teub/KYVDntLAB2bIH2/oohH1Szs4v1JyXMnKnpq5RwP5
         USghmKXIN8HVtYcxYANPcsJbQhlESwsWkIr7Q2nD8rT8JJnmjT3lFHWPfGNz+QfL0n93
         4K9OXz08JfiBIA7xchbxP+xq/nxZB8dX9B5I6lPjeTi4MB1uyVuHXl+3tggUKDC/YgCA
         Qe0IcCZ12+5AtoKhBi3juBIUkqQWs5eUEvxT3n8+JPxZWTwPe46e4o5D3VWiu5pyxddv
         GjhQ==
X-Gm-Message-State: AOAM531+ZSEOfzhwMOnZlvuvgLWEl2oDFyi/LjkstdZfnrrUdvqq7J3K
        RrckXtdOyAjRZxirPHxo0NIyE8zBSq+UTc4+o7M=
X-Google-Smtp-Source: ABdhPJxjbzdSoGPV5R73HMKFxIT7yvBlahcGc6kTONGd0JvJRrzuvp93wkkbbWYhrImD6EpMJj/Z78nMMfOr43GBdjo=
X-Received: by 2002:a05:6808:1710:b0:2d3:f699:b876 with SMTP id
 bc16-20020a056808171000b002d3f699b876mr3912306oib.281.1645602892805; Tue, 22
 Feb 2022 23:54:52 -0800 (PST)
MIME-Version: 1.0
References: <20220222024651.36675-1-qiang.yu@amd.com> <2998de6b-bff2-4ef5-135a-1269f948c486@molgen.mpg.de>
In-Reply-To: <2998de6b-bff2-4ef5-135a-1269f948c486@molgen.mpg.de>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Wed, 23 Feb 2022 15:54:41 +0800
Message-ID: <CAKGbVbu7a_Q3wehsC+7p6N_rG06T508Q2T24tHZtnvu6AJmm0Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: check vm ready by amdgpu_vm->evicting flag
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Qiang Yu <qiang.yu@amd.com>, David Airlie <airlied@linux.ie>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 3:47 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Qiang,
>
>
> Am 22.02.22 um 03:46 schrieb Qiang Yu:
> > Workstation application ANSA/META v21.1.4 get this error dmesg when
> > running CI test suite provided by ANSA/META:
> > [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-16)
> >
> > This is caused by:
> > 1. create a 256MB buffer in invisible VRAM
> > 2. CPU map the buffer and access it causes vm_fault and try to move
> >     it to visible VRAM
> > 3. force visible VRAM space and traverse all VRAM bos to check if
> >     evicting this bo is valuable
> > 4. when checking a VM bo (in invisible VRAM), amdgpu_vm_evictable()
> >     will set amdgpu_vm->evicting, but latter due to not in visible
> >     VRAM, won't really evict it so not add it to amdgpu_vm->evicted
> > 5. before next CS to clear the amdgpu_vm->evicting, user VM ops
> >     ioctl will pass amdgpu_vm_ready() (check amdgpu_vm->evicted)
> >     but fail in amdgpu_vm_bo_update_mapping() (check
> >     amdgpu_vm->evicting) and get this error log
> >
> > This error won't affect functionality as next CS will finish the
> > waiting VM ops. But we'd better clear the error log by checking
> > the amdgpu_vm->evicting flag in amdgpu_vm_ready() to stop calling
> > amdgpu_vm_bo_update_mapping() latter.
>
> later
> > Another reason is amdgpu_vm->evicted list holds all BOs (both
> > user buffer and page table), but only page table BOs' eviction
> > prevent VM ops. amdgpu_vm->evicting flag is set only for page
> > table BOs, so we should use evicting flag instead of evicted list
> > in amdgpu_vm_ready().
> >
> > The side effect of This change is: previously blocked VM op (user
>
> this
>
> > buffer in "evicted" list but no page table in it) gets done
> > immediately.
> >
> > v2: update commit comments.
> >
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Qiang Yu <qiang.yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 37acd8911168..2cd9f1a2e5fa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -770,11 +770,16 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_devic=
e *adev, struct amdgpu_vm *vm,
> >    * Check if all VM PDs/PTs are ready for updates
> >    *
> >    * Returns:
> > - * True if eviction list is empty.
> > + * True if VM is not evicting.
> >    */
> >   bool amdgpu_vm_ready(struct amdgpu_vm *vm)
> >   {
> > -     return list_empty(&vm->evicted);
> > +     bool ret;
> > +
> > +     amdgpu_vm_eviction_lock(vm);
> > +     ret =3D !vm->evicting;
> > +     amdgpu_vm_eviction_unlock(vm);
> > +     return ret;
> >   }
> >
> >   /**
>
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
Thanks, will submit with the typo fixed.

Regards,
Qiang

>
> Kind regards,
>
> Paul
