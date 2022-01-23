Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246644975C9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 22:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiAWVpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 16:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240234AbiAWVpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 16:45:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C9C06173B;
        Sun, 23 Jan 2022 13:45:53 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 64061D41;
        Sun, 23 Jan 2022 22:45:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642974351;
        bh=SUGQ4I/NfdTXsFSCHUc16iN2+6Zmi855cTdPMbrW0xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lemnulwLjp4/JNUpfjeKFYDBS+1W2dBX6VSsIU6t6TLuOxLLf8I20kgVO5+BKNGPm
         WBUnOrUKT0HfLUgxCMd34crq2Zm8GagdJEjaktk4mOlaYrWoyn6C/ZEt1oOsS3R4i1
         edcu4cfpyewLZtZypNuVS/b2Hvhi4LoQT6qo4OhA=
Date:   Sun, 23 Jan 2022 23:45:34 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: vsp1: mask interrupts before enabling
Message-ID: <Ye3MfnICIv0PeqT9@pendragon.ideasonboard.com>
References: <20220120081530.799399-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120081530.799399-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the patch.

On Thu, Jan 20, 2022 at 11:15:30AM +0300, Nikita Yushchenko wrote:
> VSP hardware could be used (e.g. by the bootloader) before driver load,
> and some interrupts could be left in enabled and pending state. In this
> case, setting up VSP interrupt handler without masking interrupts before
> causes interrupt handler to be immediately called (and crash due to null
> vsp->info dereference).
> 
> Fix that by explicitly masking all interrupts before setting the interrupt
> handler. To do so, have to set the interrupt handler later, after hw
> revision is already detected and number of interrupts to mask gets
> known.
> 
> Based on patch by Koji Matsuoka <koji.matsuoka.xm@renesas.com> included
> in the Renesas BSP kernel.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
> v1: https://lore.kernel.org/all/20210926155356.23861-1-nikita.yoush@cogentembedded.com/
> Changes since v1:
> - move interrupt masking to a dedicated routine
> - update comments and patch description
> 
> > I think I would rather see the code to reset them done in
> > vsp1_reset_wpf(), rather than in probe directly as that is what we are
> > doing, and is I believe already in the call path.
> 
> First, vsp1_reset_wpf() does not get called on driver early init.
> 
> It is normally called from within vsp1_device_get() when device is powered
> on, but vsp1_probe() calls vsp1_device_get() when vsp1->info is not yet set,
> and in this case call from vsp1_pm_runtime_resume() to vsp1_device_init() 
> is skipped.
> 
> I've tried to add extra vsp1_device_put() / vsp1_device_get() calls to the
> probe path, and dumped related registers in vsp1_pm_runtime_resume() after
> return from vsp1_device_init(), and got
> 
> [    2.477315][    T1] vsp1 fea28000.vsp: VI6_DISP_IRQ_ENB(0) = 0x00000100
> [    2.483933][    T1] vsp1 fea28000.vsp: VI6_DISP_IRQ_STA(0) = 0x00000121
> [    2.490556][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_ENB(0) = 0x00010002
> [    2.497088][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_STA(0) = 0x00010003
> [    2.503618][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_ENB(1) = 0x00000000
> [    2.510148][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_STA(1) = 0x00000000
> 
> which shows that
> (1) WPF interrupt is not cleared by WPF reset,
> (2) also DISP interrupt is enabled and pending, and driver does not seem
> to control it at all.
> 
> Given that, I think it is safer to explicitly mask all interrupts before
> setting the handler. I've moved interrupt masking to a separate routine.
> 
> > (But I'm reallly ... reallly concerned that the hardware is not really
> > getting reset when it should, and that might merit some further
> > investigation).
> 
> The documentation for WFP reset bit has notes that under some situations,
> reset is postponed for a long time, and reported via interrupt. I'm not
> sure what exactly goes on there, but I'd assume that such logic implies
> that interrupt subsystem is not reset.
> 
> I agree that not having exact understand of hardware state is not good.
> But, given that no signs of misfunction have been detected for a long time
> (the patch was in vendor BSP for years), I think we can assume it is
> "safe enough".

We could also use the reset provided by the SRCR registers in the CPG.
In the meantime, this patch seems to go in the right direction, it fixes
the problem without being too intrusive.

>  drivers/media/platform/vsp1/vsp1_drv.c | 34 ++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
> index c9044785b903..92a95e2c21c7 100644
> --- a/drivers/media/platform/vsp1/vsp1_drv.c
> +++ b/drivers/media/platform/vsp1/vsp1_drv.c
> @@ -550,6 +550,16 @@ static int vsp1_device_init(struct vsp1_device *vsp1)
>  	return 0;
>  }
>  
> +static void vsp1_mask_all_interrupts(struct vsp1_device *vsp1)
> +{
> +	int i;

This should be unsigned int as it never takes negative values.

> +
> +	for (i = 0; i < vsp1->info->lif_count; ++i)
> +		vsp1_write(vsp1, VI6_DISP_IRQ_ENB(i), 0);
> +	for (i = 0; i < vsp1->info->wpf_count; ++i)
> +		vsp1_write(vsp1, VI6_WPF_IRQ_ENB(i), 0);
> +}
> +
>  /*
>   * vsp1_device_get - Acquire the VSP1 device
>   *
> @@ -819,13 +829,6 @@ static int vsp1_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	ret = devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
> -			      IRQF_SHARED, dev_name(&pdev->dev), vsp1);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to request IRQ\n");
> -		return ret;
> -	}
> -
>  	/* FCP (optional). */
>  	fcp_node = of_parse_phandle(pdev->dev.of_node, "renesas,fcp", 0);
>  	if (fcp_node) {
> @@ -855,7 +858,6 @@ static int vsp1_probe(struct platform_device *pdev)
>  		goto done;
>  
>  	vsp1->version = vsp1_read(vsp1, VI6_IP_VERSION);
> -	vsp1_device_put(vsp1);
>  
>  	for (i = 0; i < ARRAY_SIZE(vsp1_device_infos); ++i) {
>  		if ((vsp1->version & VI6_IP_VERSION_MODEL_MASK) ==
> @@ -868,12 +870,28 @@ static int vsp1_probe(struct platform_device *pdev)
>  	if (!vsp1->info) {
>  		dev_err(&pdev->dev, "unsupported IP version 0x%08x\n",
>  			vsp1->version);
> +		vsp1_device_put(vsp1);
>  		ret = -ENXIO;
>  		goto done;
>  	}
>  
>  	dev_dbg(&pdev->dev, "IP version 0x%08x\n", vsp1->version);
>  
> +	/*
> +	 * Previous use of the hardware (e.g. by the bootloader) could leave
> +	 * some interrupts enabled and pending.

I would add

	 * TODO: Investigate if this shouldn't be better handled by using the
	 * device reset provided by the CPG.

to avoid forgetting about it.

If you're fine with those two changes, there's no need for a v3, I can
handle this when applying the patch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	 */
> +	vsp1_mask_all_interrupts(vsp1);
> +
> +	vsp1_device_put(vsp1);
> +
> +	ret = devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), vsp1);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to request IRQ\n");
> +		goto done;
> +	}
> +
>  	/* Instantiate entities. */
>  	ret = vsp1_create_entities(vsp1);
>  	if (ret < 0) {

-- 
Regards,

Laurent Pinchart
