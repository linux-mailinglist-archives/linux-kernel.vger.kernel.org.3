Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107AB5391ED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbiEaNjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbiEaNjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:39:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BB24A3FD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:39:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id br17so21529362lfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Woo8oKshTzh9S1tak5uSOyrCGP/mtqNmhpMc/8wYggk=;
        b=OFDvFn31/wu3lfug6gv87ucAtyVKBEO1I/1Waqyh6F/j07OSi00oe9ClePLZr0WYLg
         zQhIMZivQm3z839Yi58bpaO1eRHB0x1WEjHxLeF0jIw0IW8SRCJvovpfJyg5b1jL8LJ3
         y8LbfXr13DKxczo+6XDURGzTbhgPmR1BKmkJFRpv2nAYnRzG20EykhRe3301dYV3bRr/
         +F7kSINIQUlyoD4LI7WBkEOEIgQXy+Zae5Van3EdCeQdh+Bpg76eBdbjmxcgAIxQd0LD
         it7KiUWsght1Sg99iMODMylbXiiYmb/DJlmslxA2w/0hRZwD2ry4DSneh98C0pL9jpwR
         B1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Woo8oKshTzh9S1tak5uSOyrCGP/mtqNmhpMc/8wYggk=;
        b=1LcMTLp5nYsq8AHbPvS5ZE8SvyaSt3KpcrioGCCNDk+yj4udlNzXJWqzatUap6DY6m
         QBWcmjuSYhfSM6/vqZ/YhmDz3l25Syl7u8eG6JTDK2kAVYUt93NXPTDhEBf5gw8fjff4
         u6Uiac8cFyw41ZCFCaLP05whT5yPWPmPwI2CS8Dx5KA7LSrA4w1mZk5EVbjLDp1TriN7
         8gBnEmpe1jYY/lJ3E/+MU5Py5gnI3x/fwRXhjwHnJ6mNKXr4+nxDKr4MRLHa25GVHCla
         NfDqiyMJrhXaMZF0/0d7lJFR5xbrc61BXWr7u/Y2H+HcEUGh2/asHRGJ7/pcpjaG5gkW
         NtPg==
X-Gm-Message-State: AOAM532P0Xb20xaMyoK4mf22OD9Nie9zc+TF/qz3H3QBQwhfn/JfK0t2
        RusteUFyOVKoK7pgfsgMBqrT3KMh2nHOPK+Vd63Z4w==
X-Google-Smtp-Source: ABdhPJxn1r3MgXJ2C/wc5i1LUO0VYa92fq0hsD61WN7c9DWQuUy4e52MgQnLD+H3DWIDUT8Kmcg4eTj8+At65oR2rc8=
X-Received: by 2002:a05:6512:3b0e:b0:478:7c53:4d0a with SMTP id
 f14-20020a0565123b0e00b004787c534d0amr28793645lfv.373.1654004354233; Tue, 31
 May 2022 06:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220520114242.150235-1-benchuanggli@gmail.com>
In-Reply-To: <20220520114242.150235-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 May 2022 15:38:37 +0200
Message-ID: <CAPDyKFoQP=4OSwcjj6bJOxDXvrWjqwi-MpvpMe4L5ftWwkEhFQ@mail.gmail.com>
Subject: Re: [RESEND, PATCH] mmc: sdhci-pci-gli: Fix GL9763E runtime PM when
 the system resumes from suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, victor.shih@genesyslogic.com.tw,
        kane.chen@intel.corp-partner.google.com
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

On Fri, 20 May 2022 at 13:43, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> When the system resumes from suspend (S3 or S4), the power mode is
> MMC_POWER_OFF. In this status, gl9763e_runtime_resume() should not enable
> PLL. Add a condition to this function to enable PLL only when the power
> mode is MMC_POWER_ON.
>
> Fixes: d607667bb8fa (mmc: sdhci-pci-gli: Add runtime PM for GL9763E)
> Signed-off-by: Ben Chuang <benchuanggli@gmail.com>

Sorry for the delay, I have been out traveling. Unfortunately this
didn't make it for v5.18, although I have queued it up for v5.19 and
added a stable tag.

Thanks and kind regards
Uffe


> ---
> Hi,
>
> Sorry, resend this patch because typo two email addresses.
> Sorry for Adrian and Kane.
>
> Best regards,
> Ben
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index d09728c37d03..d81e5dc90e15 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -972,6 +972,9 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
>         struct sdhci_host *host = slot->host;
>         u16 clock;
>
> +       if (host->mmc->ios.power_mode != MMC_POWER_ON)
> +               return 0;
> +
>         clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>
>         clock |= SDHCI_CLOCK_PLL_EN;
> --
> 2.36.0
>
