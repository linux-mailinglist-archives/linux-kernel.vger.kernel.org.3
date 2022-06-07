Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7BD534BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346697AbiEZIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbiEZIbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:31:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E1BC1EFD
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:31:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t6so1232113wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Jmqqor+JTEI0R4a/DkT42jCnQETEVaAlxof7FaryNdo=;
        b=dDiqMHtv64xskgDGIds+v3plHZeEFmT2vEISE1pJj7UdgQps3oLxHiqijtANJpt4Hf
         2LdtVP4KkVo4HxaD0x/XhDzt+o/sq4HqWyqzNNVepCf6mzd7HEArxN5hzDAnjgNWt3+U
         drcPc0yJyL5bMWMMJvAFUD/M+8Xrxm2zNzvBxgmLSW+LwBpBWhLHpjPL5CVEjXFZODFo
         OcnJL45UwryxZNZJf51SZlGs3cRHoN/2U1tVIepu7WV5PlH/jRpTPqYaEcNf0B1FojCv
         R3M8iiX7XRTIf8uUVhOoloQ4RySV7kuuHxgAyx37+7mTSDlTOQ7XK+sU/EJXFx5+jdAU
         jEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jmqqor+JTEI0R4a/DkT42jCnQETEVaAlxof7FaryNdo=;
        b=dI20AC0uuAyDGKm4TcP89OpkTTMAZ6/c4OY0g3pPVyn8X5+Fyn1pPu5MzknWjHGHV2
         jgU3YNAKWyCGo2arwoDFGMwoZoPcJV79LPguChCK+WhYTBMG8X4AkpPf31dI1Bot/ppM
         GKfIAdRq3H7h7/LvPNLwAdu51XYdT4wNaM0pjDwJGzxu9ZvbQAHFdaJwKt0G0lDNPsNi
         3Xw2yaFsSuCpQww2cqMCuo5FGPEptrde9K6T5AoTF0MUwvKfoN3iuFWyC8OzXqlVYtm5
         cjAp0lsFZHGRPR3oB6hQQDTpKE0r3jthybOtyrAkQjDm+NPj8jAYsbX6CtTRkLaBgdDT
         iHXQ==
X-Gm-Message-State: AOAM531bw2TYg83Cx6wVDtk83D8HVjkzAZIBgdWnkWNiEDWgmOsGVl+A
        TWHCEx8vsaQOQMCdp6b6C0sCTA==
X-Google-Smtp-Source: ABdhPJz8qwMcfJrgol5cMUSkP80H+gA0sbUCANx/+OkeENig34vB3UtUuzD6sB8axWf65N747DQSvg==
X-Received: by 2002:a5d:5945:0:b0:20d:132e:7e99 with SMTP id e5-20020a5d5945000000b0020d132e7e99mr29817990wri.578.1653553900132;
        Thu, 26 May 2022 01:31:40 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d4bd0000000b0020e5e906e47sm1112751wrt.75.2022.05.26.01.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 01:31:39 -0700 (PDT)
Date:   Thu, 26 May 2022 09:31:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        hao.wu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, marpagan@redhat.com,
        lgoncalv@redhat.com, matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v21 1/5] mfd: intel-m10-bmc: Rename n3000bmc-secure driver
Message-ID: <Yo866ekAg3+9TBQ6@google.com>
References: <20220521003607.737734-1-russell.h.weight@intel.com>
 <20220521003607.737734-2-russell.h.weight@intel.com>
 <20220526075413.GB148394@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220526075413.GB148394@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022, Xu Yilun wrote:

> On Fri, May 20, 2022 at 05:36:03PM -0700, Russ Weight wrote:
> > The n3000bmc-secure driver has changed to n3000bmc-sec-update. Update
> > the name in the list of the intel-m10-bmc sub-drivers.
> > 
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> > v21:
> >   - No change
> > v20:
> >   - No change
> > v19:
> >   - No change
> > v18:
> >   - No change
> > v17:
> >   - This is a new patch to change in the name of the secure update
> >     driver.
> > ---
> >  drivers/mfd/intel-m10-bmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > index 8db3bcf5fccc..f4d0d72573c8 100644
> > --- a/drivers/mfd/intel-m10-bmc.c
> > +++ b/drivers/mfd/intel-m10-bmc.c
> > @@ -26,7 +26,7 @@ static struct mfd_cell m10bmc_d5005_subdevs[] = {
> >  static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
> >  	{ .name = "n3000bmc-hwmon" },
> >  	{ .name = "n3000bmc-retimer" },
> > -	{ .name = "n3000bmc-secure" },
> > +	{ .name = "n3000bmc-sec-update" },
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> Hi Lee:
> 
> Is it good to you? If yes, could I apply this patch to linux-fpga
> and submit along with the other patches in this series?

That's fine.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
