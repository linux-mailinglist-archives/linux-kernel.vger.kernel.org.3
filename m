Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E584F99F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiDHP4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiDHP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:56:32 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CAEECB09
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:54:28 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-de3ca1efbaso10145179fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/qt2kxYzvPSFybWE0vph5q3zSCF93j4cg+r2znVrEc=;
        b=nJYSFSwPoiZylu5Rvwor1W7DMfMJLiJi5Vjvfuuc1+qINKATI+9jEhVUHga2vPbT0I
         Or3XMCel3PUZ9F39JAd3RbPnoBDIBMWtnXEtL9k9L8CF9qICyNtSxLGQumrGUGjkkomM
         /wszEBfJYbFxRKW09cjdEdW5a9JjgpD0qp0iCbr5oWLod9cyDe84qjiC1whEAR9DpaU/
         cVFu728cxCFZJOStvhxvkwB5/ylyadlpSlB+yQJ4g8XIwyt3fuIxQMRSnmfYqPon9XnZ
         mMSKElHf/6JAoEO2JKyN+93C0XuDoyxBgq3FdKMX7eD8YLfJD3t9mskxw0eJhTtkDAEH
         fdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/qt2kxYzvPSFybWE0vph5q3zSCF93j4cg+r2znVrEc=;
        b=6MOe1kFwAq5SVao4su0+4DeyfxOoouVO8kVteEN1PJntZhklpmJsSMqf3afvWhE3VJ
         RQ/p1P9iXJF27H+KcKF44C/kDhHtL2Um92RLpuVSAFGK2gND/0NOItGezB2HZ6J49xy8
         unQ0hh0fyLoTDSEEPLy3pjFz0CooA1vb42OjgSJxbBUHbHDcpvGM1Q6Er4zTHffzmvaO
         NIAW9fU8vViTAIEm80jVb65OgGK+n8TzWDEy+w5Ng696VbJoiMiRLxZFtQYBqUvf0Yhy
         TYE4s1cZ+qnn5nG5g5TZZo3PT09qvFa44ye3QbTeRfh4akHNIVUfPZ5lUMIAAakTznZE
         PSdQ==
X-Gm-Message-State: AOAM532vtobHELfR0sonHuNGOJ2BPpZ3fY5yJQlk71ZMYOeYjXGteBpw
        62R0q21TY8PfdjC69r8UaH8vOhM2CItFfeIwr7BsQbN4
X-Google-Smtp-Source: ABdhPJw9FKlPrDwVUJRr0sLTm1ZkYMWhz0SCAA0CCiO2BPNqBy7HXjZPLKYYsoKecSvHWjdPQN9syqAueyQBM/LohEo=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr8346323oaa.200.1649433266869; Fri, 08
 Apr 2022 08:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220408154447.3519453-1-richard.gong@amd.com> <BL1PR12MB51576654D3EEB10F5DF862A7E2E99@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51576654D3EEB10F5DF862A7E2E99@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Apr 2022 11:54:15 -0400
Message-ID: <CADnq5_PmxGxrJG5uZkkFXQ1YbJbDZTvAqb2oYqdCE=NtqBojqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable ASPM for legacy products that don't
 support ASPM
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Gong, Richard" <Richard.Gong@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 11:47 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Gong, Richard <Richard.Gong@amd.com>
> > Sent: Friday, April 8, 2022 10:45
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> > airlied@linux.ie; daniel@ffwll.ch
> > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org; Limonciello, Mario <Mario.Limonciello@amd.com>;
> > Gong, Richard <Richard.Gong@amd.com>
> > Subject: [PATCH] drm/amdgpu: disable ASPM for legacy products that don't
> > support ASPM
> >
> > Active State Power Management (ASPM) feature is enabled since kernel
> > 5.14.
> > However there are some legacy products (WX3200 and RX640 are examples)
> > that
> > do not support ASPM. Use them as video/display output and system would
> > hang
> > during suspend/resume.
> >
> > Add extra check to disable ASPM for old products that don't have
> > ASPM support.

The patch description is incorrect.  ASPM works just fine on these
GPUs.  It's more of an issue with whether the underlying platform
supports ASPM or not.  Rather than disabling a chip family, I would
prefer to add a check for problematic platforms and disable ASPM on
those platforms.

Alex

> >
> > Signed-off-by: Richard Gong <richard.gong@amd.com>
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index bb1c025d9001..8987107f41ee 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2012,6 +2012,10 @@ static int amdgpu_pci_probe(struct pci_dev
> > *pdev,
> >       if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
> >               amdgpu_aspm = 0;
> >
> > +     /* disable ASPM for the legacy products that don't support ASPM */
> > +     if ((flags & AMD_ASIC_MASK) == CHIP_POLARIS12)
> > +             amdgpu_aspm = 0;
> > +
>
> I think it's problematic to disable it for the entire driver.  There might be multiple
> AMDGPUs in the system, and others may support ASPM.
>
> Can it be done just as part of probe for Polaris?
>
> >       if (amdgpu_virtual_display ||
> >           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
> >               supports_atomic = true;
> > --
> > 2.25.1
