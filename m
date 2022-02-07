Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDFC4ACB0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiBGVQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiBGVP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:15:56 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA05C06173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:15:56 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id x193so18592077oix.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OobE6i7gIMfg4XFPq2mt3VscXgZfAtapsVYwcALM9Kc=;
        b=THD90P/x+7OXkXfQgKxZwvuLFl98w7iNmiBPjN4Ohbd8qVNuZsx8HWUnEr2oeRg0bM
         +ejAu/jNLP6+QxZwJXSaM6gcmUm8+Ys4VNJ1ag7fE8U6A7odgXO8TJR3SRg1uV+DqQLK
         fJ2RVbkVPIOW06tXisnEHU16QLILzSryYaZ93aLE1/PfSns7oLMi2pr3QWFEYH4+PD6X
         eIl4D+ULSOqcPo3uMG6aK7Pwc5sZGXxJgtLeNRl4d3sTNdoAQH6Vi2PJuV1p4BjAn2m9
         Bpry8EuRVjmMSq99PJdUzvItDNKdfhnDAZ7hV/Tzem/KMiOT793BLNxluAkpAulQBWlY
         vUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OobE6i7gIMfg4XFPq2mt3VscXgZfAtapsVYwcALM9Kc=;
        b=gBM9G6O4cfXgJ11yekcBEQc4xugo1FC4Dw/p/hsUPAm4XD5eHqJVZMx9VC/WL2lyIy
         Eq8xFPYpf38j6BdrnM4LSnqt3hf0JAeILAmXX0wdfw5w53xhqxZsataKDKhb1bbsUyha
         xdmz/OVBPu7Bmc+X4kZYbhmFTIdzu2Zr3JtSPHPCqEgoC5M91pMgZ8b65V2gKHS359mY
         rIjl9WvDlbC4pFB0muplObvPqV33JunFB9tXP7ylt7MYNlFWJVpOTdzndGYI/tpFvQY0
         7fRm/VnrLF//Wl8H2RPaTyoZvgcOyvUvg+YLnxyJD9jxOCCK6iEyJDdLKZQJA94G/Dr+
         SAtg==
X-Gm-Message-State: AOAM531lsetmM1W5BGMy/SAuy3IeOY2crpdXti+485lqjiR2Hs0Jm7bn
        taaJXYUiuE7mZrY4SlGpLREGNOpJhQSNWvJYY5E=
X-Google-Smtp-Source: ABdhPJy0bAxTrvw72wAxN/d14eYdF+KNvKxwijohy8ZvMiJBQd6GMzYwqRPpVLSh5YbT4tpNXPax1NgR3jIPFhxGNvk=
X-Received: by 2002:a05:6808:159e:: with SMTP id t30mr412394oiw.132.1644268555404;
 Mon, 07 Feb 2022 13:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20220205150008.1968218-1-trix@redhat.com> <DM6PR12MB261982BB4DBCC90F70381121E42C9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261982BB4DBCC90F70381121E42C9@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Feb 2022 16:15:44 -0500
Message-ID: <CADnq5_Mx8kMjLMTxD+db_ssTX8O35MzSfAyeL2NaHDMay7+bzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix error handling
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     "trix@redhat.com" <trix@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "Powell, Darren" <Darren.Powell@amd.com>,
        "Chen, Guchun" <Guchun.Chen@amd.com>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Feb 6, 2022 at 10:04 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: trix@redhat.com <trix@redhat.com>
> > Sent: Saturday, February 5, 2022 11:00 PM
> > To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> > airlied@linux.ie; daniel@ffwll.ch; nathan@kernel.org;
> > ndesaulniers@google.com; Lazar, Lijo <Lijo.Lazar@amd.com>; Powell, Darren
> > <Darren.Powell@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>;
> > Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org; llvm@lists.linux.dev; Tom Rix <trix@redhat.com>
> > Subject: [PATCH] drm/amd/pm: fix error handling
> >
> > From: Tom Rix <trix@redhat.com>
> >
> > clang static analysis reports this error
> > amdgpu_smu.c:2289:9: warning: Called function pointer
> >   is null (null dereference)
> >         return smu->ppt_funcs->emit_clk_levels(
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > There is a logic error in the earlier check of
> > emit_clk_levels.  The error value is set to
> > the ret variable but ret is never used.  Return
> > directly and remove the unneeded ret variable.
> >
> > Fixes: 5d64f9bbb628 ("amdgpu/pm: Implement new API function "emit" that
> > accepts buffer base and write offset")
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index af368aa1fd0ae..5f3b3745a9b7a 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -2274,7 +2274,6 @@ static int smu_emit_ppclk_levels(void *handle,
> > enum pp_clock_type type, char *bu
> >  {
> >       struct smu_context *smu = handle;
> >       enum smu_clk_type clk_type;
> > -     int ret = 0;
> >
> >       clk_type = smu_convert_to_smuclk(type);
> >       if (clk_type == SMU_CLK_COUNT)
> > @@ -2284,7 +2283,7 @@ static int smu_emit_ppclk_levels(void *handle,
> > enum pp_clock_type type, char *bu
> >               return -EOPNOTSUPP;
> >
> >       if (!smu->ppt_funcs->emit_clk_levels)
> > -             ret = -ENOENT;
> > +             return -ENOENT;
> >
> >       return smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
> >
> > --
> > 2.26.3
