Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE347F3DD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhLYQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLYQkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:40:23 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F5C061401;
        Sat, 25 Dec 2021 08:40:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b13so44359246edd.8;
        Sat, 25 Dec 2021 08:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvHTGwqShy3hjMvmtaAwJYoEX+P78Ut4H0sUbTm8lso=;
        b=iENjbrLVZUof27VmWudySLa2ouYhhY0CzMXaEF6EsMj0j1ML4hGW17P4dcOLJByYba
         bhQ633WQLfHbBoy7VNUoVtCuTHMMQeEcmgnAb3dfvh/Yo+9qg57NEtXZVKiVLd7Oe8ts
         GLlN5FPJ7PdWgnMxkzDrCsSMGnILXgP3B8oe3bYlHiYnjWaAOHMCzacUmU6pMm/ViJcu
         NmmTzEXoHs4wSRHbrm49oQ+yeId2slSIL1WeFt2bpG5EyE892KyasG88Cg9XMtMxTvvH
         iWXjqZDxx+BxZRo3v4I+hXVwxGrRrxxPmhzgaWMVhrMLhq65IG7K2Zg98heEmJ/4Dx71
         uhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvHTGwqShy3hjMvmtaAwJYoEX+P78Ut4H0sUbTm8lso=;
        b=LGPSnZljfH9QrSTqpnSpJ13QC3daf7benHGoQF0nAPRoxd5qcfz4S/MxLUNcUnUlf5
         cqU1/z6/w1a5oxEHhzR1PJ7F8BPh4iuujte9inze/5jVBpCVxVPiO4IItEuXeSkVe7tB
         R5KUU0R9rwLb7X+5MxtfWITsRU8wicn+1w8mRAGiLYPAjBAg9evBrKDwHJ1VTOyLDBpg
         1X2XYrREQTKup5fZU8U0Hgv1nGpoJj0a4psVygbSFbvVXtNPatbnylbtDUTZ23gjjpji
         pN7En0/XJ4jjuFzruQUmzLQYuc3JzIkLjZExvPjCnOz8lrAMX3N4qdYnNfQmaDop9dqy
         ZbEg==
X-Gm-Message-State: AOAM533cuiyOKQ7wnu6ysvwWW2E6WFMEbZW2yQ+7wLS55aSzUbi4EGws
        HZE9ooGwwMrmpr0DAMHSyCfP+oxFy2Iv0pMRwVQ=
X-Google-Smtp-Source: ABdhPJy4oBphBfV2bHRMc1/oUxVumCIvAY1Al2p+aXHvYdN4RsFIbKxDyNHCH8T1dOC6HnETWsWxzTRFim+N/ZEHMsE=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr8373984ejj.636.1640450421911;
 Sat, 25 Dec 2021 08:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20211208132042.3226275-1-gsomlo@gmail.com> <20211208132042.3226275-4-gsomlo@gmail.com>
In-Reply-To: <20211208132042.3226275-4-gsomlo@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 18:39:45 +0200
Message-ID: <CAHp75VcPgN5Q=Zk2g3Xj+WcxS1JG=nyoDrtWFL=96-rpPhkW2g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     gsomlo@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 6:15 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> that targets FPGAs. LiteSDCard is a small footprint, configurable
> SDCard core commonly used in LiteX designs.

...

> +       int ret;
> +
> +       host->irq = platform_get_irq_optional(host->dev, 0);
> +       if (host->irq <= 0) {
> +               dev_warn(dev, "Failed to get IRQ, using polling\n");
> +               goto use_polling;
> +       }

This is wrong. It missed the deferred probe, for example.

The best approach is

ret = platform_get_irq_optional(...);
if (ret < 0 && ret != -ENXIO)
  return ret;
if (ret > 0)
  ...we got it...

It will allow the future API fix of platform_get_irq_optional() to be
really optional.




--
With Best Regards,
Andy Shevchenko
