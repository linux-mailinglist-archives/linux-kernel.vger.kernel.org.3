Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08C253FBAC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiFGKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbiFGKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:44:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB74B21275
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:44:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id be31so27662703lfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtPoJ12oteBNc0kHoMuvW+v6Ds9Jjp/7GrDvRJFQi1Y=;
        b=rUYTt0nRUcgy2g58Upir6dVsFF4oJe8a+uuLzUV1nk2gTpV0Fq6jaxzgHdC2qrMCxB
         OasoiAeKELkgi9Arq+AyCuBZWThXJYkiQcpLzz9d04wN1TmneEOCjOJrcLOo+Y0StMx+
         hnxikTDEDlwgXlYU+D3193UAxMBJkocF+vwfs1Q3mX3BB0ayDXsdZN9nx5G1BHm4PSBD
         LGGBi5UKB5ITINpRyFRbDGZDDcLKiR6JuMAoiP+GXx1DS8J51u39KCQTVGvUpKbj4YFm
         pddaB97xGFjm75umbdWyHBU5DljCSc9boyzXph7fkA+MIgmpgIB64RF+TubqIAPVv0bg
         /Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtPoJ12oteBNc0kHoMuvW+v6Ds9Jjp/7GrDvRJFQi1Y=;
        b=qWZ8u4Z9TD1V+2xOWECrQQbbbWdZ7jlj1EuiN+qqVyMuMQxbTEXBJw4ILqUDmbO96V
         hoWv4VVYACQUxTH6to+cdd+T8gVUWInUBzZB8gqBwxaamH7F6sF1kKSJUsk8PLhDRRyZ
         UgikoEoqdeKnKMF87ITygAVpcUPilnt5uLnBDh8hd5eUdywcFpJ3DwR/D+a2Yl7mUVE5
         5m/WX9XiLyYH2oxlR9VpGTi0lC1drvlhZX5pHM0bkK2R2S74oe0h62Yhi49oKqDPMuLX
         4ejQk0Du0AsWixtEocKcQieA7GsWA5uBQ0MDnD+kURB/Ie6PC7KjIWEsI0Oyy7pyXHX9
         O2Yg==
X-Gm-Message-State: AOAM532ZqH6XmLaiiMJkdJO+fzUS4LyseN4co2VM9b2nl0ZzN8BcFQKV
        9VHOm+9LKIejKZZs467G0Rh0MjX1uSZ5FdXKAlyahw==
X-Google-Smtp-Source: ABdhPJzW7vimXP+fNczdUfWycVJCFAkXKrgixYEB9OIcsz1WOIhvya043//GeBabtgT+NvuzfAhjCWui2uQUwSVUGoo=
X-Received: by 2002:a05:6512:303:b0:479:1baf:7e5b with SMTP id
 t3-20020a056512030300b004791baf7e5bmr13446489lfp.184.1654598640330; Tue, 07
 Jun 2022 03:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220602132543.596-1-chevron.li@bayhubtech.com>
In-Reply-To: <20220602132543.596-1-chevron.li@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:43:23 +0200
Message-ID: <CAPDyKFo7FnC_F4biVkBmi7LBaRjkK2UADNFgzdzRmVw79Gr6iw@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc:sdhci-pci-o2micro:fix card detect issue
 because card detect debouncing isn't done
To:     Chevron Li <chevron.li@bayhubtech.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaper.liu@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 at 15:26, Chevron Li <chevron.li@bayhubtech.com> wrote:
>
> get_cd result is uncorrect during card detect debouncing
> we need to wait card detect stable before return get_cd result
>
> Signed-off-by: Chevron Li<chevron.li@bayhubtech.com>

Applied for fixes, by adding a fixes+stable tag, thanks!

Kind regards
Uffe


> ---
> change in V1:
> add wait card detect stable logical before return card detect result.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 92c20cb8074a..0d4d343dbb77 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -152,6 +152,8 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)
>
>         if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
>                 sdhci_o2_enable_internal_clock(host);
> +       else
> +               sdhci_o2_wait_card_detect_stable(host);
>
>         return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>  }
>
> base-commit: d1dc87763f406d4e67caf16dbe438a5647692395
> --
> 2.32.0
>
