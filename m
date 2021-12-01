Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25590464D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhLALjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349066AbhLALjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:39:05 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE113C061748;
        Wed,  1 Dec 2021 03:35:44 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n26so24112213pff.3;
        Wed, 01 Dec 2021 03:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Z4WQqmeaGpnZzOnCBpMy2YHyb8jWMqFdB9iSsR8JDZw=;
        b=DUt+K4hzjK/C2xWlwPPyRIbJoLxQ0ys6Cz7ttLmsd7pjZ9x90BEEPtp5ShAkibhjvB
         V0hIqNnPOALUqz9sHMyXdjwqA5bYstKbnRilifPGxaRMHmHk0+BIXTilQCPTrK5u3Qqs
         PjN5v2mjFOxIR8a5tpOTmQnbw4TPuDncRQg1NKAauDGHagGdDk1OmHoJS+q8jnbqF/sN
         lQxO5PNAEvc28jYppxSQLFLPui4+EciUPc+rOk4EFqdJegrysyAYtUyTgjEHDMHwe05f
         WSWhpyxIygfVG3qJT+S0mY5f2DRfRJfCeUxYxXZISzIoS817u5My2PFoke7VNeayfslZ
         Q+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Z4WQqmeaGpnZzOnCBpMy2YHyb8jWMqFdB9iSsR8JDZw=;
        b=QMVlsK2GaFES4BAgzEAco93PraqwB8ApyrvDzQ428kCO/N39HY7/dgqQbZMR9wAhNa
         0rA7crLEWPcMRLMbiLIvHzZvFFLwm8zQBDFaDlPS8sMhEj+vqZPRvSnaaSo7AnoVSjHl
         YPiqxqof7Uy1Tq/oMc840Etdr4Gxn2H8JGX5I1EvHJ5cwGk3xcFBc9vSamPb8rVsen95
         wIEMhYPOsjfS2t8+5iRN3AW9ool6BYCNMxlqWS0F1GqyGHlRpbmQFbn2z8+IWqHXJpVm
         oR8rPLW9appoVRnV+Q74pHa5NPnxb2c66/7WbTk479RuDNt6JOhrv96370cAaZbSnhnW
         /85A==
X-Gm-Message-State: AOAM532lV3KWHu1EegB7m8dLFIBCZuR+Cw9wjLinYE7LeJDOSELomsan
        EzksHAtfGOjaMGy4zIiijH4=
X-Google-Smtp-Source: ABdhPJy9I57xDV8Owfjb6jhN1qfzkOEVJH8qnu5CgGe/ILqLMmFfmv675flfBFJVBpGjHBVE0VlsHw==
X-Received: by 2002:a63:1945:: with SMTP id 5mr4173377pgz.99.1638358544070;
        Wed, 01 Dec 2021 03:35:44 -0800 (PST)
Received: from ?IPv6:2400:4052:6980:3800:dba7:2b1f:3f26:a5ec? ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id w19sm1128150pjh.10.2021.12.01.03.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 03:35:43 -0800 (PST)
Message-ID: <f3c254d39d5fefad9a2b47856030d8254e1af1f8.camel@gmail.com>
Subject: Re: [PATCH 04/17] media: atomisp: pci: do not use err var when
 checking port validity for ISP2400
From:   Tsuchiya Yuto <kitakar@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nable <nable.maininbox@googlemail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        "andrey.i.trufanov" <andrey.i.trufanov@gmail.com>,
        Patrik Gfeller <patrik.gfeller@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Wed, 01 Dec 2021 20:35:39 +0900
In-Reply-To: <20211111183812.0f33fdaa@sal.lan>
References: <20211017161958.44351-1-kitakar@gmail.com>
         <20211017161958.44351-5-kitakar@gmail.com>
         <20211026092637.196447aa@sal.lan>
         <1a295721fd1f1e512cd54a659a250aef162bfb6f.camel@gmail.com>
         <20211028123944.66c212c1@sal.lan>
         <af7cdf9de020171567c2e75b713deb2ed073e4e3.camel@gmail.com>
         <20211101141058.36ea2c8e@sal.lan>
         <ab48bd8c69273e8b18ff652f3615b2698a777092.camel@gmail.com>
         <20211111183812.0f33fdaa@sal.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-11 at 18:38 +0000, Mauro Carvalho Chehab wrote:
> Em Thu, 11 Nov 2021 23:34:23 +0900
> Tsuchiya Yuto <kitakar@gmail.com> escreveu:
> 
> > Sorry for a little late reply. This is hard to explain...
> > 
> > On Mon, 2021-11-01 at 14:10 +0000, Mauro Carvalho Chehab wrote:
> > > Em Mon, 01 Nov 2021 22:38:55 +0900
> > > Tsuchiya Yuto <kitakar@gmail.com> escreveu:  
> > 
> > [...]
> > >   
> > 
> > > > This is not directly related to this series, but how we should reduce
> > > > the ifdef usage in the future? Here are my two ideas:
> > > > 
> > > >   1. (my initial idea) remove `#ifdef ISP2401` part and make ISP2401
> > > >      part completely irci_stable_candrpv_0415_20150521_0458
> > > > 
> > > > this way does not require (relatively) much human work I think.
> > > > 
> > > > But as Mauro says, the `#ifdef ISP2401` part (irci_ecr-master_20150911_0724)
> > > > is basically an improved version.  
> > > 
> > > No. What I said is that the if (ISP2401) and the remaining ifdefs are because
> > > of BYT x CHT.  
> > 
> > I need to elaborate on this. Indeed some of them are really because of
> > BYT x CHT, but others are stuff from irci_ecr-master_20150911_0724.
> > 
> > What I meant when I mentioned "remove `#ifdef ISP2401` part" is that,
> > removing things which was _initially_ inside the `#ifdef ISP2401` on the
> > initial commit of atomisp.
> > 
> > Also I believe we can remove more `if (IS_ISP2401)` and `/* ISP2401 */`
> > things as well as the some remaining `#ifdef ISP2401` things.
> > 
> > I added about this below and hope it clarifies things...
> 
> It is clearer now. Yeah, we can touch on whatever is inside the
> ISP2401 ifs, as we can now test them. Touching things for ISP2400
> is harder, as we depend on a test platform.
> 
> > > The worse part of them are related to those files
> > > (See Makefile):
> > > 
> > > obj-byt = \
> > > 	pci/css_2400_system/hive/ia_css_isp_configs.o \
> > > 	pci/css_2400_system/hive/ia_css_isp_params.o \
> > > 	pci/css_2400_system/hive/ia_css_isp_states.o \
> > > 
> > > obj-cht = \
> > > 	pci/css_2401_system/hive/ia_css_isp_configs.o \
> > > 	pci/css_2401_system/hive/ia_css_isp_params.o \
> > > 	pci/css_2401_system/hive/ia_css_isp_states.o \
> > > 	pci/css_2401_system/host/csi_rx.o \
> > > 	pci/css_2401_system/host/ibuf_ctrl.o \
> > > 	pci/css_2401_system/host/isys_dma.o \
> > > 	pci/css_2401_system/host/isys_irq.o \
> > > 	pci/css_2401_system/host/isys_stream2mmio.o
> > > 
> > > Those define regmaps for 2400 and 2401. I was able to remove a lot
> > > of things from the old css_2400/css_2401 directories, but the ones
> > > there at pci/*/css*/ia_css_isp_*.c are a lot more complex, and would
> > > require some mapping functions to allow the same driver to work with
> > > both BYT and CHT.
> > > 
> > > The better would be to test the driver first at BYT, fix issues (if any) and 
> > > then write the mapping code.
> > >   
> > > > So, we may also:
> > > > 
> > > >   2. continue unifying `#ifdef ISP2401` and `#ifndef ISP2401` parts
> > > > 
> > > > but this way needs more human work I think though. And if we go this
> > > > way, I also need to rewrite this patch as mentioned in the commit
> > > > message.  
> > 
> > What the idea #1 want to say is, let's remove things _initially_ within
> > `ifdef ISP2401` (so, except things which were added inside it later
> > upstream) including formerly within `ifdef ISP2401` things, i.e.,
> > `if (IS_ISP2401)` and things commented with `/* ISP2401 */`.
> > 
> > However, I don't say we can remove all the ifdefs like things formerly
> > within USE_INPUT_SYSTEM_VERSION_2, USE_INPUT_SYSTEM_VERSION_2401, etc.,
> > which later removed/integrated into `ifdef ISP2401` on some commits [1].
> > We may temporarily revert those commits when we want to distinguish
> > between what were formerly within there and what were not.
> > 
> > Such ifdefs were added by them as a real hardware difference. Thus, I
> > agree that we still need the CONFIG_VIDEO_ATOMISP_ISP2401 stuff to support
> > both ISP2400/ISP2401 at the same time.
> > 
> > This is what I meant "reduce the ifdef usage" in a previous mail. So,
> > I'm not talking about if dropping CONFIG_VIDEO_ATOMISP_ISP2401 is doable,
> > but talking about just how to reduce the code.
> > 
> > [1] 641c2292bf19 ("media: atomisp: get rid of version-dependent globals")
> >     bd674b5a413c ("media: atomisp: cleanup ifdefs from ia_css_debug.c")
> > 
> > Anyway, if you agree or not on what I'm saying, can I send this patch
> > without code changes in v2, i.e., looks OK for you regarding the code?
> > I'll remove the commit message about
> > irci_stable_candrpv_0415_20150521_0458 vs irci_ecr-master_20150911_0724
> > in v2 anyway, which needs to be discussed further later.
> 
> No need for a v2. The /17 patch series was merged already, plus some
> patches from the /5 that made sense to apply.
> 
> Ok, there are some followup patches that could be added, but please
> send those in separate.

OK, thanks. I'll prepare the followup patches as soon as I can.

> > The following notes are about what I have done until now for removing
> > such tests. (More elaborated version than cover letter). You don't have
> > to see them, but I hope it might clarify things...
> > 
> >   ## `ifdef ISP2401` added in the initial commit of atomisp
> > 
> > The `ifdef ISP2401` was the result of merging two different version of
> > driver, added on the initial commit of upstreamed atomisp. And for the
> > `ifdef ISP2401`, I confirmed I can remove (almost [1]) all of them against
> > the initial commit of atomisp [2][3]
> > 
> > [1] here are the three exceptions:
> >     ("NOTE: ifdef ISP2400/ISP2401 usage in aero-atomisp")
> >     https://github.com/kitakar5525/linux-kernel/commit/1a8488cdd31ad38a3805824700b29d1e5213d3f2
> > 
> > [2] ("atomisp: pci: css2400: remove ISP2401 ifdefs")
> >     https://github.com/kitakar5525/linux-kernel/commit/dd6723fc5b9fe040e33b227b509a7e004243edce
> > [3] ("atomisp: pci: remove ISP2401 ifdefs for main pci driver")
> >     https://github.com/kitakar5525/linux-kernel/commit/1734341f84a96945af7635f6fff061db910f746f
> 
> Ok, if there are more if/ifdef ISP2401 that, if reverted will keep the
> driver running with the firmware we're using, I'm all for it. Just send
> the patches ;-)
> 
> > 
> > Here is the kernel tree if someone is interested:
> > 
> >         https://github.com/kitakar5525/linux-kernel/tree/mainline+upst_atomisp@a49d25364dfb_first
> > 
> > Especially, here is one of the part where this patch is touching
> > for example:
> > 
> >         --- a/drivers/staging/media/atomisp/pci/atomisp2/css2400/sh_css_mipi.c
> >         +++ b/drivers/staging/media/atomisp/pci/atomisp2/css2400/sh_css_mipi.c
> >         @@ -416,26 +362,16 @@ allocate_mipi_frames(struct ia_css_pipe *pipe, struct ia_css_stream_info *info)
> > [...]
> >         -#ifndef ISP2401
> >          	port = (unsigned int) pipe->stream->config.source.port.port;
> >          	assert(port < N_CSI_PORTS);
> >          	if (port >= N_CSI_PORTS) {
> >         -#else
> >         -	if (!ia_css_mipi_is_source_port_valid(pipe, &port)) {
> >         -#endif
> >          		ia_css_debug_dtrace(IA_CSS_DEBUG_TRACE_PRIVATE,
> >          			"allocate_mipi_frames(%p) exit: error: port is not correct (port=%d).\n",
> >          			pipe, port);
> > 
> > By removing (almost) all of the `#ifdef ISP2401` things, (although we
> > still can't remove like former USE_INPUT_SYSTEM_VERSION_2,
> > USE_INPUT_SYSTEM_VERSION_2401) we can reduce the number of ifdefs.
> 
> Sounds good to me.
> 
> > 
> > 
> >   ## `ifdef ISP2401`, `if (IS_ISP2401)` and `/* ISP2401 */` in the recent
> >       atomisp
> > 
> > That is for the initial commit of atomisp. For the recent version of
> > atomisp, we can still remove `ifdef ISP2401` things (again, except things
> > which were added inside it later upstream) as well as the former
> > `ifdef ISP2401` things, i.e., `if (IS_ISP2401)` [1] and things commented
> > with [2] `/* ISP2401 */`.
> > 
> > [1] ("atomisp: pci: remove IS_ISP2401 test")
> >     https://github.com/kitakar5525/linux-kernel/commit/397e543e493dfd60d91e2b5cc164da342b26906c
> > [2] ("atomisp: pci: remove `/* ISP2401 */` comments and its contents")
> >     https://github.com/kitakar5525/linux-kernel/commit/b3928e3c1a709853971715ce35459b9b79e708f2
> >     These commits were made against
> >     bd674b5a413c ("media: atomisp: cleanup ifdefs from ia_css_debug.c")
> >     where I randomely picked.
> > 
> > Here is the kernel tree if someone is interested:
> > 
> >     https://github.com/kitakar5525/linux-kernel/tree/mainline+upst_atomisp@bd674b5a413c_before_get_rid_ver_globals
> > 
> > I confirmed capture is still working here on surface3 (ISP2401). Compile
> > tested for ISP2400. As you can see, there are some WIP and FIXME commits
> > on top of removing such tests though. (The others are backports).
> > 
> > Especially, here is one of the part where this patch is touching
> > for example:
> > 
> >         --- a/drivers/staging/media/atomisp/pci/sh_css_mipi.c
> >         +++ b/drivers/staging/media/atomisp/pci/sh_css_mipi.c
> >         @@ -553,10 +548,7 @@ free_mipi_frames(struct ia_css_pipe *pipe) {
> >          			return err;
> >          		}
> >         
> >         -		if (!IS_ISP2401)
> >         -			port = (unsigned int)pipe->stream->config.source.port.port;
> >         -		else
> >         -			err = ia_css_mipi_is_source_port_valid(pipe, &port);
> >         +		port = (unsigned int)pipe->stream->config.source.port.port;
> >         
> >          		assert(port < N_CSI_PORTS);
> >         
> > 
> > So, we can also remove a lot of `if (IS_ISP2401)` and `/* ISP2401 */`
> > things as well as the remaining `ifdef ISP2401`.
> > 
> > 
> > 
> >   ## WIP: removing `ifdef ISP2401`, `if (IS_ISP2401)` and `/* ISP2401 */`
> >      against the latest atomisp
> > 
> > And here is the branch where I'm working on removing such tests against
> > the latest atomisp:
> > 
> >         https://github.com/kitakar5525/linux-kernel/commits/mainline+upst_atomisp+remove_unneeded_tests
> > 
> > It'd be the best if I can show you working one, 
> 
> Well, send the ones that were already tested, and won't cause
> regressions to v4l2grab and camorama (e. g. it shouldn't cause
> generic V4L2 generic apps to break).
> 
> It would be nice to also not break nvt and other original apps for
> this device, as it could be useful later, in order to be able to 
> test the other pipelines, as currently only the preview one seems
> to be working properly, at least with generic apps.

Got it :-)

> > but it currently has
> > seemingly include issues on ISP2400 vs ISP2401 (as well as many WIP
> > commits I added):
> > 
> > 	drivers/staging/media/atomisp/pci/runtime/isys/src/isys_init.c: In function ‘ia_css_isys_init’:
> > 	drivers/staging/media/atomisp/pci/runtime/isys/src/isys_init.c:29:9: error: unknown type name ‘backend_channel_cfg_t’
> > 	   29 |         backend_channel_cfg_t backend_ch0;
> > 	      |         ^~~~~~~~~~~~~~~~~~~~~
> > 	drivers/staging/media/atomisp/pci/runtime/isys/src/isys_init.c:30:9: error: unknown type name ‘backend_channel_cfg_t’
> > 	   30 |         backend_channel_cfg_t backend_ch1;
> > 	      |         ^~~~~~~~~~~~~~~~~~~~~
> > 	drivers/staging/media/atomisp/pci/runtime/isys/src/isys_init.c:31:9: error: unknown type name ‘target_cfg2400_t’
> > 	   31 |         target_cfg2400_t targetB;
> > 	      |         ^~~~~~~~~~~~~~~~
> > 	drivers/staging/media/atomisp/pci/runtime/isys/src/isys_init.c:32:9: error: unknown type name ‘target_cfg2400_t’
> > 	   32 |         target_cfg2400_t targetC;
> > 	      |         ^~~~~~~~~~~~~~~~
> > 	[...]
> > 
> > The full output of the make error is here:
> > 
> >         ("NOTE: issue: some undeclared errors")
> >         https://github.com/kitakar5525/linux-kernel/commit/a932d16681f941161385659b9d0316a3a4975e86
> > 
> > 
> > 
> > Regards,
> > Tsuchiya Yuto
> > > > >   

