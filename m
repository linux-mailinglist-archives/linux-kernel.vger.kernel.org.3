Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59365466015
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345222AbhLBJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:07:05 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:5431 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240807AbhLBJHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638435821; x=1669971821;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=os1qwHb0uqRnU8y0E2AVtQVizNfytwLJnbdqf6zS+ew=;
  b=RWa2KQ1s8QqGJFBPM31jp5gXHekv6E3UogisM2bfASu19TICtUgLEipN
   HhdjkY7TUBT60TgCeXukiF+v6+4VcK1SfK9STsOhhC/ahv3Y2Gf3CU4DZ
   Dvw5AZlJ4W59xYNbHzTjeskmBSSG2ZRbBu3oXuTpkUoZfW1Vaaj8mfOrP
   zsCTaRfaiiVvJiw+Pd7kt4IgVf9rhDW4UgRQRNXbNvtXHVcySuYMyv9OW
   61MfzboxApGKb4uYZ04EFNxAonqI7TXg9DcT/GMXW4JoVcyOb0PZtB5wk
   RTLUE3w8YrrTbTElH04P+rm9sM7zhpCsmNpG2pMKeiA3+zCpfzIrmgvf5
   g==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631570400"; 
   d="scan'208";a="20804426"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 Dec 2021 10:03:37 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 02 Dec 2021 10:03:37 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 02 Dec 2021 10:03:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638435817; x=1669971817;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=os1qwHb0uqRnU8y0E2AVtQVizNfytwLJnbdqf6zS+ew=;
  b=Xury+C6WPRqi/aNMi/USlC1x/sBhdojDwNQYy4RhKzpbQO6t1NjR61Gd
   3iD7RU3Dbm0k0PE4LvX0EQRyMRTZbVkjB+0E9gqT1kYHwEVh7fpYAwn4t
   RMtE5Wwj+bhfzU/+von+wHa9glfG0oD54NUUNGzxLKOhUvMyZFOFBfodo
   MgOXsLJiJ5Pem0xxIh+7G/J6+Xf2dLsNeqLDeBV/1PptfkNZ1DyT95X9D
   rgok8g3qdRQF1DpsC4wdnR7hNqDoMRSUt+Bjwbc8ZufWDQHZfH530xnIB
   fj0fB4+XfQfzzw1RbNtgGoNcOiCm3mmU8GTTctkpVwi6a7Wr3xO2euCaL
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631570400"; 
   d="scan'208";a="20804425"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Dec 2021 10:03:36 +0100
Received: from schifferm-ubuntu (unknown [192.168.66.22])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id D0343280065;
        Thu,  2 Dec 2021 10:03:35 +0100 (CET)
X-CheckPoint: {61A88BD4-1B-3C7FD1AA-EED18422}
X-MAIL-CPID: 80B20F2BC484A7A2D458A5C7509C07E6_4
X-Control-Analysis: str=0001.0A782F18.61A88BE8.00D9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Message-ID: <1f870126804ce354803b3b274765a571b0a8440f.camel@ew.tq-group.com>
Subject: Re: [PATCH v2] drm: fsl-dcu: enable PIXCLK on LS1021A
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Dec 2021 10:03:16 +0100
In-Reply-To: <ab3c62c9b4fa8f4507050a4b329ea30d9c7dcddb.camel@ew.tq-group.com>
References: <20211005141041.2988-1-matthias.schiffer@ew.tq-group.com>
         <ab3c62c9b4fa8f4507050a4b329ea30d9c7dcddb.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-08 at 10:11 +0100, Matthias Schiffer wrote:
> On Tue, 2021-10-05 at 16:10 +0200, Matthias Schiffer wrote:
> > The PIXCLK needs to be enabled in SCFG before accessing the DCU on
> > LS1021A,
> > or the access will hang.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> 
> Hi,
> what is the status of this patch? I found it "archived" in the dri-
> devel patchwork, should I be looking somewhere else?

ping


> 
> 
> 
> 
> > ---
> > 
> > v2:
> > - rebase
> > - remove unnecessary argument of fsl_dcu_scfg_config_ls1021a()
> > 
> > 
> >  drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 25
> > +++++++++++++++++++++++
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
> >  3 files changed, 29 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-
> > dcu/Kconfig
> > index d7dd8ba90e3a..9e5a35e7c00c 100644
> > --- a/drivers/gpu/drm/fsl-dcu/Kconfig
> > +++ b/drivers/gpu/drm/fsl-dcu/Kconfig
> > @@ -8,6 +8,7 @@ config DRM_FSL_DCU
> >  	select DRM_PANEL
> >  	select REGMAP_MMIO
> >  	select VIDEOMODE_HELPERS
> > +	select MFD_SYSCON if SOC_LS1021A
> >  	help
> >  	  Choose this option if you have an Freescale DCU chipset.
> >  	  If M is selected the module will be called fsl-dcu-drm.
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> > index 660fe573db96..b6b1cb75fc41 100644
> > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> > @@ -50,6 +50,23 @@ static const struct regmap_config
> > fsl_dcu_regmap_config = {
> >  	.volatile_reg = fsl_dcu_drm_is_volatile_reg,
> >  };
> >  
> > +static int fsl_dcu_scfg_config_ls1021a(void)
> > +{
> > +	struct regmap *scfg;
> > +
> > +	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
> > +	if (IS_ERR(scfg))
> > +		return PTR_ERR(scfg);
> > +
> > +	/*
> > +	 * For simplicity, enable the PIXCLK unconditionally. It might
> > +	 * be possible to disable the clock in PM or on unload as a
> > future
> > +	 * improvement.
> > +	 */
> > +	return regmap_update_bits(scfg, SCFG_PIXCLKCR,
> > SCFG_PIXCLKCR_PXCEN,
> > +				  SCFG_PIXCLKCR_PXCEN);
> > +}
> > +
> >  static void fsl_dcu_irq_reset(struct drm_device *dev)
> >  {
> >  	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> > @@ -108,6 +125,14 @@ static int fsl_dcu_load(struct drm_device
> > *dev, unsigned long flags)
> >  		return ret;
> >  	}
> >  
> > +	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
> > +		ret = fsl_dcu_scfg_config_ls1021a();
> > +		if (ret < 0) {
> > +			dev_err(dev->dev, "failed to enable pixclk\n");
> > +			goto done_vblank;
> > +		}
> > +	}
> > +
> >  	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
> >  	if (ret < 0) {
> >  		dev_err(dev->dev, "failed to initialize vblank\n");
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> > b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> > index e2049a0e8a92..566396013c04 100644
> > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> > @@ -160,6 +160,9 @@
> >  #define FSL_DCU_ARGB4444		12
> >  #define FSL_DCU_YUV422			14
> >  
> > +#define SCFG_PIXCLKCR			0x28
> > +#define SCFG_PIXCLKCR_PXCEN		BIT(31)
> > +
> >  #define VF610_LAYER_REG_NUM		9
> >  #define LS1021A_LAYER_REG_NUM		10
> >  

