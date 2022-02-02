Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0324A7721
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346372AbiBBRxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbiBBRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:53:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5587C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 09:53:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r10so292084edt.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UCJ1jUJ4zsq4RQrX6k+nXy4mHY8saVQioi5/XKVhkU=;
        b=LLr8ELYvbwUDr+aWKlSrG7aUEVXyzH50uh6oKTFF7ifbs0kTp+dePMb7OIOs/lJCtT
         qaJ8Z+yD1zBb3jPMgX+hcXZn8jnlqb+ScSFNJo0JtmS9p6QniJMseacEDgSDBtBsKBOU
         ZWAbLXI5JASZmkTiW0hegjZXUDbom39pQhwENiJcJAYXfMFJnASas543LR60wciqH+9t
         KobLEDbuFSmwRUoucGbr3iNZgHslL2pv1YGuXfqU3aUmB8ZtAG/av0CWvJzxEdGyFJng
         nefKqmCJBXsKClb/eskETv9fJXR90QdKQcDMyV0Dau4hVNITUOA4BtMNF9NCaZlxSzai
         jh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UCJ1jUJ4zsq4RQrX6k+nXy4mHY8saVQioi5/XKVhkU=;
        b=VmSTFvaeZhvVHnC5E/DjmBIEtmBoNp65WxafnrjbNny7ulS9+g97O/7eZSCjkjQSze
         aeWRpX8lBH+HeN1ktfaPYkTVXXDKR9d9doBWJ86AqT8gzX2u4ijmr9JOAfyJuA3t+tHP
         RaSWo+2HdLXk1+Pr7FwzOgVL39rj02sdX3nFRQu0Co3HT2F9FuZZOMQoqS2GxIaGdXHe
         VvJaBz69dbbLSrqRPj4bti3HoewaVB5nAeOeNZNCzBWr/ubvKq5IlqIH2u0SeG8IA0kA
         8WZhMSuXulSGGUizvFJfBHUa6qNrafQpcm4L0YRzGHQsgBVa6/dioh4Zt6fVZw1VF2in
         MWYg==
X-Gm-Message-State: AOAM531+1J5Fm4tc33ibiOAx2XwfBofEFQDrrxrn2FMgsV1Owq/XvENo
        ABmg/nRRUCr16hn4nYYlXOUQhGixBUuKKqDRsWNzwg==
X-Google-Smtp-Source: ABdhPJzPLQuBlKBdAk3DgJxcL7/Vai1iSQbErpTS/hjbkdjk5vyySChn7iBuszxnIeVrklMcRWdQdnaOS2CYaap+n8M=
X-Received: by 2002:a05:6402:1c95:: with SMTP id cy21mr31387969edb.170.1643824410275;
 Wed, 02 Feb 2022 09:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20220124120915.41292-1-angelogioacchino.delregno@collabora.com>
 <20220124120915.41292-3-angelogioacchino.delregno@collabora.com>
 <20220201183612.GC2490199@p14s> <91fff43a-c85d-2934-b54b-67ffe6fc2f29@collabora.com>
In-Reply-To: <91fff43a-c85d-2934-b54b-67ffe6fc2f29@collabora.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 2 Feb 2022 10:53:17 -0700
Message-ID: <CANLsYkyWqKw9-QGO6oRLsk7=Gp2gU1bpHUzJWxCpVmx7Smhkcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] remoteproc: mtk_scp: Use dev_err_probe() where possible
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 at 02:03, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 01/02/22 19:36, Mathieu Poirier ha scritto:
> > Hi Angelo,
> >
> > On Mon, Jan 24, 2022 at 01:09:15PM +0100, AngeloGioacchino Del Regno wrote:
> >> Simplify the probe function, where possible, by using dev_err_probe().
> >> While at it, as to increase human readability, also remove some
> >> unnecessary forced void pointer casts that were previously used in
> >> error checking.
> >
> > I am in favour of all 3 patches (please add a cover letter next time) but weary
> > about testing - do you have access to a Mediatek platform to try this on or
> > is it purely theoretical?
> >
> > I would definitely feel better to see a "Tested-by" tag by someone out there
> > with access to the HW.
> >
> > Thanks,
> > Mathieu
> >
>
> Hello Mathieu,
>
> I have multiple MediaTek platforms and I always test on all of them before
> pushing such commits upstream, so, even though this kind of patch is trivial,
> this is *not* purely theoretical and I confirm that this was successfully tested.

 I have applied all 3 patches.

>
> Regards,
> Angelo
>
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   drivers/remoteproc/mtk_scp.c | 28 ++++++++++++----------------
> >>   1 file changed, 12 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> >> index e40706b0e015..dcddb33e9997 100644
> >> --- a/drivers/remoteproc/mtk_scp.c
> >> +++ b/drivers/remoteproc/mtk_scp.c
> >> @@ -757,10 +757,8 @@ static int scp_probe(struct platform_device *pdev)
> >>      int ret, i;
> >>
> >>      rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
> >> -    if (!rproc) {
> >> -            dev_err(dev, "unable to allocate remoteproc\n");
> >> -            return -ENOMEM;
> >> -    }
> >> +    if (!rproc)
> >> +            return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
> >>
> >>      scp = (struct mtk_scp *)rproc->priv;
> >>      scp->rproc = rproc;
> >> @@ -770,21 +768,20 @@ static int scp_probe(struct platform_device *pdev)
> >>
> >>      res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> >>      scp->sram_base = devm_ioremap_resource(dev, res);
> >> -    if (IS_ERR((__force void *)scp->sram_base)) {
> >> -            dev_err(dev, "Failed to parse and map sram memory\n");
> >> -            return PTR_ERR((__force void *)scp->sram_base);
> >> -    }
> >> +    if (IS_ERR(scp->sram_base))
> >> +            return dev_err_probe(dev, PTR_ERR(scp->sram_base),
> >> +                                 "Failed to parse and map sram memory\n");
> >> +
> >>      scp->sram_size = resource_size(res);
> >>      scp->sram_phys = res->start;
> >>
> >>      /* l1tcm is an optional memory region */
> >>      res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
> >>      scp->l1tcm_base = devm_ioremap_resource(dev, res);
> >> -    if (IS_ERR((__force void *)scp->l1tcm_base)) {
> >> -            ret = PTR_ERR((__force void *)scp->l1tcm_base);
> >> +    if (IS_ERR(scp->l1tcm_base)) {
> >> +            ret = PTR_ERR(scp->l1tcm_base);
> >>              if (ret != -EINVAL) {
> >> -                    dev_err(dev, "Failed to map l1tcm memory\n");
> >> -                    return ret;
> >> +                    return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
> >>              }
> >>      } else {
> >>              scp->l1tcm_size = resource_size(res);
> >> @@ -792,10 +789,9 @@ static int scp_probe(struct platform_device *pdev)
> >>      }
> >>
> >>      scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> >> -    if (IS_ERR((__force void *)scp->reg_base)) {
> >> -            dev_err(dev, "Failed to parse and map cfg memory\n");
> >> -            return PTR_ERR((__force void *)scp->reg_base);
> >> -    }
> >> +    if (IS_ERR(scp->reg_base))
> >> +            return dev_err_probe(dev, PTR_ERR(scp->reg_base),
> >> +                                 "Failed to parse and map cfg memory\n");
> >>
> >>      ret = scp->data->scp_clk_get(scp);
> >>      if (ret)
> >> --
> >> 2.33.1
> >>
>
>
> --
> AngeloGioacchino Del Regno
> Software Engineer
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
