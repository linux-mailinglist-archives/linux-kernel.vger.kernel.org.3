Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7486534116
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiEYQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiEYQLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:11:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24699B41DB
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:11:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so30800288wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CPLQ14WaiCX+ILz1Hrgp1Qbb/fI6CZrPndnwjE4cb0=;
        b=bjg0YEnXgGSPysZv/QsYyuc6SlwU0HsbcG+2lJ5biIG8XUTtXJ0IXRooICluaTFiZW
         x/71ssLox5GE5C/gYtX7JF+/RAI1gXUQZcbiWYoiX7XPUpEHQ0sMkLug5EA1s1kKTfw2
         i5e8L5FPS6gqKufi+55OhSiYsUZ7FmsPvniCP8tIr7XAgRFWXc8WFXY9tFnH0EIMo/Cs
         QHgcL9TGiij1Y1zK9tGsBql9Y5Ng4cmMrDJMzD+xLcSsG5KEL4ihtvtyLPWiXDtFoMuq
         vEifY77fl88ZfD27gYLuc3vVulnB2AaWjw2MPlkVaAWdUEtXHk0H5UBf75+ExeCEDjvf
         x6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CPLQ14WaiCX+ILz1Hrgp1Qbb/fI6CZrPndnwjE4cb0=;
        b=t0ONvMuh81I5YAZp9sU8n6hcT3KPT3hoYz0VkwMFECAjSuImhVcUWKWPBD73Iumd/M
         rtY34FJj4hG923c+qXwNrfuIdFULGsdB6tcv8Tg6J0GlaoGk58BKMMPmC87pQ2mANI1C
         lW76WG71zM4e8PYQ9WTVZPBwROUrhmlupg+3u55bJ75CypmSV0y650zme63ViwDSwiaD
         UmsiAYa1pfNuzoklhOTLm7nQeHtN9dVQ5QiMQC8D8PDY9rqZRLlHg/TuCl3kVR2G8VEF
         043f02X+qbIDlRMXZcBdUKkIThLpvkhWXad850LxetR6l4QZwbA1T48BrmwcPzerlcax
         oQkA==
X-Gm-Message-State: AOAM533qfX3cg+iYBPbTsD3Pgi9ldP0pWfjXoIKe8Z8eKUG7z0m8fcFH
        u5Q/17cW0oB+in16XtH1lk7sqiFlVlagWU231g/YyA==
X-Google-Smtp-Source: ABdhPJya9POSR16TPN0e/q8mW1cFMbbUYlTzpoiumLvvphZabXWlEbHKhIWt0nAFBXWP7vgbnXf7hUJ4jmzGIiL3yGc=
X-Received: by 2002:a5d:5954:0:b0:20c:4d55:1388 with SMTP id
 e20-20020a5d5954000000b0020c4d551388mr27861460wri.90.1653495063669; Wed, 25
 May 2022 09:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-10-brad@pensando.io>
 <CAK8P3a1RdHTngDVqg4KnVA3N8EjDfbpQ=cEcz_CK8NmG2EgYLQ@mail.gmail.com>
 <3c8e94e1-fb8e-0d8f-4e79-b8313a1da5cb@intel.com> <CAK9rFnwsMd1+oQ8cg8Biw7HM=R6aOudfK7Ja+E+iGVgfrvC9Gg@mail.gmail.com>
 <CAK8P3a28ef+DgcKrMG03b5Og-W+afieoqF1zvNkXdG22qA8i7g@mail.gmail.com>
In-Reply-To: <CAK8P3a28ef+DgcKrMG03b5Og-W+afieoqF1zvNkXdG22qA8i7g@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 09:10:52 -0700
Message-ID: <CAK9rFnzBDgBCFN+UJJnpkEPFGwbjkwAcjGjM2E_yF43iMDs+2Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] mmc: sdhci-cadence: Add Pensando Elba SoC support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Apr 7, 2022 at 1:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 7, 2022 at 7:06 PM Brad Larson <brad@pensando.io> wrote:
> > On Thu, Apr 7, 2022 at 12:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >
> > > What is the relationship between cadence and pensando elba?
> >
> > Pensando licensed the cadence controller, its 100% cadence IP.  The
> > integration issue we ran into was with the accessors where we have the
> > workaround.  The initial patch added a separate Elba driver file but
> > the feedback was the Elba support didn't justify doing that and to add
> > to sdhci-cacence.c.
>
> I looked back at the earlier reviews now, I think the main problem with
> versions 1 and 2 was that it had the abstraction the wrong way around,
> so you added the complexity of having multiple files, without the benefits.
>
> I still think that the cleanest approach would be to have it the way I
> suggested in my reply to v1, with an elba specific platform driver
> that calls into the generic cadence code, but the generic code knowing
> nothing about the front-end.
>
> Then again, it sounds like there was already an agreement about
> the approach you took here, so let's stay with that and hope we don't
> get any other chips with the same IP block in the future.

Thanks for looking this over.  I won't change for now in the patch
update in process.  This will likely get another look as I've added a
node to the device tree to enable an added reset driver which can
hardware reset the emmc.  The current cadence sdhci driver does not
include this and I've currently added filling out
mmc_host_ops.card_hw_reset like below, yet one more thing different
for our platforms not in the common driver.

@@ -404,6 +550,17 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
        if (ret)
                goto free;

+       if (host->mmc->caps & MMC_CAP_HW_RESET) {
+               priv->rst_hw =
devm_reset_control_get_optional_exclusive(dev, "hw");
+               if (IS_ERR(priv->rst_hw)) {
+                       ret = PTR_ERR(priv->rst_hw);
+                       if (ret == -ENOENT)
+                               priv->rst_hw = NULL;
+               } else {
+                       host->mmc_host_ops.card_hw_reset = sdhci_mmc_hw_reset;
+               }
+       }
+
        ret = sdhci_add_host(host);

Regards,
Brad
