Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811C25A2315
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiHZIeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343534AbiHZIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:34:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A98D51CC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:34:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so433492wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qQYhF9Tm4lqCbd2L4pV2F+K+GFROrI4ntq7bX+5OTak=;
        b=Ol1GmYh7Vrd7PozWRW05PvKd2zYLkHfHcZZI+LjPyHk66q4uTrqkGfLsU8mlYRPJ+b
         SFG6yqUMTW8A0CYFqMZT4LIYU8SMxQxeifiq/Ko2r/DZ1h36PwzktVkWIMmX3C5R/Fa8
         4i+Bg3dHWS9MAAqlJ6a+a0mX4Xb1oD0vY50IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qQYhF9Tm4lqCbd2L4pV2F+K+GFROrI4ntq7bX+5OTak=;
        b=UdE8h23RL+w79mAtzaRiSkZJN2St4jlubBC3YJiL8JxrwmP9HghT/O73qpdckvBnKV
         rtj8ogeLgsN5mhFSn9ux6/hMPxpsBfWTuB5mcRzaVtsVGE3dJQIJf5s7X2vVE1E3lwuS
         ZjwOH3wXdmzuv9u9xZ1NFTVv2PgL50CwImBTO85dGfiOgn4iZ4ljU7Xf6kx0cJNtwJ4D
         eaDy7k48KQnuHUCB3wRmoM3xVaLQM2UGAgq0ZA/Hm299VTQhe06E+LPzUBbQF8Bw4Rr2
         WdMEOG2UTYSMbxhwho2faNJ01SABm9JbIKkx6S6qfKVG1QvZ0gtQWCYC9CKkVn3z062s
         O7kw==
X-Gm-Message-State: ACgBeo2/GyGU2GwOoT6KjsR+v6QU4g+XCCkOufPp36xJpBsLKCG/e5cO
        uCWmHWj8fNL+mlkWkw2MGG1v3A==
X-Google-Smtp-Source: AA6agR4dmpmWH/4wWhB3Ip/1u/6xX+Ad0VGHS09lrBQgi5HKAdDipFcpTBkO5crU4fj7ZBBiycr1MA==
X-Received: by 2002:a05:600c:a0a:b0:3a6:71e5:fb70 with SMTP id z10-20020a05600c0a0a00b003a671e5fb70mr4460241wmp.141.1661502851310;
        Fri, 26 Aug 2022 01:34:11 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-49-118.cust.vodafonedsl.it. [188.217.49.118])
        by smtp.gmail.com with ESMTPSA id a17-20020adffb91000000b002252e5a6841sm1294323wrr.57.2022.08.26.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:34:11 -0700 (PDT)
Date:   Fri, 26 Aug 2022 10:34:08 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v5 2/4] media: amphion: tell and handle
 contiguous and non contiguous format
Message-ID: <20220826083408.GC3151@tom-ThinkPad-T14s-Gen-2i>
References: <cover.1661390673.git.ming.qian@nxp.com>
 <7e6a945b898254679bd93e7e001e7c24b5aea0ef.1661390673.git.ming.qian@nxp.com>
 <20220826072047.GA3151@tom-ThinkPad-T14s-Gen-2i>
 <AM6PR04MB634128ED70894F35B629C69AE7759@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <20220826082717.GB3151@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826082717.GB3151@tom-ThinkPad-T14s-Gen-2i>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 10:27:17AM +0200, Tommaso Merciai wrote:
> Hi Ming,
> 
> On Fri, Aug 26, 2022 at 07:47:47AM +0000, Ming Qian wrote:
> > [snip]
> > 
> > >> diff --git a/drivers/media/platform/amphion/vpu_helpers.c
> > >> b/drivers/media/platform/amphion/vpu_helpers.c
> > >> index e9aeb3453dfc..019c77e84514 100644
> > >> --- a/drivers/media/platform/amphion/vpu_helpers.c
> > >> +++ b/drivers/media/platform/amphion/vpu_helpers.c
> > >> @@ -59,6 +59,36 @@ const struct vpu_format
> > >*vpu_helper_find_format(struct vpu_inst *inst, u32 type,
> > >>       return NULL;
> > >>  }
> > >>
> > >> +const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst
> > >> +*inst, u32 type, u32 pixelfmt) {
> > >> +     const struct vpu_format *fmt;
> > >> +     const struct vpu_format *sibling;
> > >> +
> > >> +     fmt = vpu_helper_find_format(inst, type, pixelfmt);
> > >> +     if (!fmt || !fmt->sibling)
> > >> +             return NULL;
> > >> +
> > >> +     sibling = vpu_helper_find_format(inst, type, fmt->sibling);
> > >> +     if (!sibling || sibling->sibling != fmt->pixfmt ||
> > >> +         sibling->comp_planes != fmt->comp_planes)
> > >> +             return NULL;
> > >
> > >I think to preserve code style you need the following solutions on this if
> > >statement:
> > >
> > >if (!sibling || (sibling->sibling != fmt->pixfmt) ||
> > >    (sibling->comp_planes != fmt->comp_planes))
> > >         return NULL;
> > >
> > >I think I have suggested to you this solution on the v4. But never mind we
> > >need this :)
> > >
> > >Thanks
> > >
> > 
> > Hi Tommaso,
> >     The parentheses are unnecessary, the checkpatch.pl will report the following style problems if I add the parentheses:
> > 
> > CHECK: Unnecessary parentheses around 'sibling->sibling != fmt->pixfmt'
> > #11: FILE: drivers/media/platform/amphion/vpu_helpers.c:72:
> > +       if (!sibling || (sibling->sibling != fmt->pixfmt) ||
> > +           (sibling->comp_planes != fmt->comp_planes))
> > 
> > CHECK: Unnecessary parentheses around 'sibling->comp_planes != fmt->comp_planes'
> > #11: FILE: drivers/media/platform/amphion/vpu_helpers.c:72:
> > +       if (!sibling || (sibling->sibling != fmt->pixfmt) ||
> > +           (sibling->comp_planes != fmt->comp_planes))
> > 
> > total: 0 errors, 0 warnings, 2 checks, 10 lines checked
> > 
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> > 
> > 1.patch has style problems, please review.
> > 
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> Sorry, my bad. I don't check this using checkpatch.pl, but checking the
> others driver code, you are right. Thanks for clarify this.
> 
> Then, Looks good to me.
> 
> Regards,
> Tommaso

Forgot the tag:

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

> 
> -- 
> Tommaso Merciai
> Embedded Linux Engineer
> tommaso.merciai@amarulasolutions.com
> __________________________________
> 
> Amarula Solutions SRL
> Via Le Canevare 30, 31100 Treviso, Veneto, IT
> T. +39 042 243 5310
> info@amarulasolutions.com
> www.amarulasolutions.com

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
