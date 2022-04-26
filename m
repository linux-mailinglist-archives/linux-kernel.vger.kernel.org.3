Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2A0510AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355248AbiDZVKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbiDZVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:10:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C4C6D4D9;
        Tue, 26 Apr 2022 14:07:36 -0700 (PDT)
Received: from mail-yb1-f174.google.com ([209.85.219.174]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5g68-1nmBA42FC6-007AW5; Tue, 26 Apr 2022 23:07:34 +0200
Received: by mail-yb1-f174.google.com with SMTP id e12so6387048ybc.11;
        Tue, 26 Apr 2022 14:07:34 -0700 (PDT)
X-Gm-Message-State: AOAM5333hHcrAqr3ltIOI0nhglaWifkix2IIqdobSkfTn7jp3ihX4Una
        qmLcIpOUk0k5cHbyt9vD8CC72sFWsGJs1fBSZZQ=
X-Google-Smtp-Source: ABdhPJxSSDDOtEn7aGJKzNZ9mnCcpZOReFbUpWu56qgp9Lnx/3jQsTHsY7svsF5iLlzz6Yj5mPVQ8TSE4yoAsZQQ/cU=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr22931175ybx.472.1651007253244; Tue, 26
 Apr 2022 14:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev> <20220426201539.12829-7-sven@svenpeter.dev>
In-Reply-To: <20220426201539.12829-7-sven@svenpeter.dev>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 23:07:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a263ojCtYRec2RwvvcY1H1k7chqXyRhovrWRXh=hFYgfQ@mail.gmail.com>
Message-ID: <CAK8P3a263ojCtYRec2RwvvcY1H1k7chqXyRhovrWRXh=hFYgfQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] nvme-apple: Add initial Apple SoC NVMe driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Janne Grunau <j@jannau.net>, DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:arb0CGNHCglXbagvdX5x1MHN00MkpYocjWb0DiOfHRMghEjZSOW
 8vGc8Y7WJFBr43ppWWkHQ/e/mfviQlRLB/VaOUbeYD9hVmRDqsLS9E3zfztjjEsXZUG671M
 cqybp6QUcfq5S+FDE5+ZR2fTE+S3fgQceTl+vhal9J3upBOKSqEOchhMrTg7rvrqJaq8iQW
 tqFurIqI24z8dWg6tgvXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KsJOKjXs5rg=:ynkaV/C4zsaWMdABQ4ptOD
 Dgq1QegXU7HurSbd6ePPRnrdadMDcBXH5u+zHUe9Cx4rtOYUfivFU+K0Irt1EIlGYdL8+M0pE
 lw9wifuTFQijFe82isz5sMdr43wCqElqJq6y4h1QvOgE5zheEZZ5RELLDB0DVtpImpFOUTSW5
 S7F3fgj88t66HWHv+Cx7jbPDeeQ088K1Y3gIjM9TZpyoPbF0ZWXharfisUebUyKatvoAbhf9N
 W0jrovaTHe0LWCdArtp0VHWtWWoxOgMRDTU939nYCkbBoF5dfI0Souoxzk5kGgKbVLSEdjQF1
 BhhHE182Q6rJPm+v9JrgwsAUS368wAqmU8lKiY1x2w+s99GHpLyaSnGWhQWqthFGp4VnZV/bX
 w8qa743WFTjLRb9LZZBbu0dQOuEvFrLeGqHUZBMsHFDHM2upsVgL63NWF4RGtEBVdqFth20bB
 z6pdCPliS+F6iJXQtqkM/1GVJjC9vA+KAuc9X+vjTvTyByakRnGTa60MTydpjCUIuUcrLxJz+
 5DwiudPOX9SuU8jeapRtF3ZgA1GvQMzpx8KaH/YWECUsWDtV76SKu/ppBDS3GDlJpJkbZ1CKg
 i8vIF0DIVWbgaRnNwQCw5YwVd3r4isvA4I4a759qB4CfDyPrzfToJbw4ijAByS/80SNbPxRt7
 OK0FEPfNU0j+h1SUgswoo+jGQu5/F2yE7W6vFMcndl9hhsKMXDHCnjhVFBxpDfD1Wh/LT8Oqe
 Y/+lizqYh5qs3mbFxYG+0mNSjEnvkb/4WF0WdA2r5HNskHu0BXiuwsOXaNbfyEqK6mAA242rm
 Ta2QTnhXhr7Fpi8upNA232ZRNk+v84lY1XoE82rVCb7381ECVA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> Apple SoCs such as the M1 come with an embedded NVMe controller that
> is not attached to any PCIe bus. Additionally, it doesn't conform
> to the NVMe specification and requires a bunch of changes to command
> submission and IOMMU configuration to work.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

I did not do a detailed review of this again, but the previous version seemed
mostly fine already.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

One suggestion for a very minor improvement:

> +#ifdef CONFIG_PM_SLEEP
> +static int apple_nvme_resume(struct device *dev)
> +{
...
> +}
> +
> +static const struct dev_pm_ops apple_nvme_pm_ops = {
> +       .suspend        = apple_nvme_suspend,
> +       .resume         = apple_nvme_resume,
> +};
> +#endif
> +
> +static const struct of_device_id apple_nvme_of_match[] = {
> +       { .compatible = "apple,nvme-ans2" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, apple_nvme_of_match);
> +
> +static struct platform_driver apple_nvme_driver = {
> +       .driver = {
> +               .name = "nvme-apple",
> +               .of_match_table = apple_nvme_of_match,
> +#ifdef CONFIG_PM_SLEEP
> +               .pm = &apple_nvme_pm_ops,
> +#endif
> +       },

You can now use "static DEFINE_SIMPLE_DEV_PM_OPS()" to define
the pm operations without these #ifdefs.

       Arnd
