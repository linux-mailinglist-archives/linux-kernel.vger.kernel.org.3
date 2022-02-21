Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFEC4BD79B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbiBUIk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:40:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiBUIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:40:24 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB4C3F;
        Mon, 21 Feb 2022 00:40:01 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id bm39so4826730qkb.0;
        Mon, 21 Feb 2022 00:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s5B4YomWl6YcuDNS/5ZSy9Ee5vW/FUHQ9NrgrTJaP0M=;
        b=G2uKcFZ0slXRhBZZaZfMjHyLGeJ141r9JJ68bPGZoOtsFvYuhR9fkD7fjkNEHOjLEX
         dl/jfU86zpeUN3HRF+k1HBUSnOlTtf3IqyjhW/OiQCcK83KWtzDoLvaD//svUoUzxE6K
         YvGLIoQARJUdaWpBPMcFx/wRpYjSw3x7cg93I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s5B4YomWl6YcuDNS/5ZSy9Ee5vW/FUHQ9NrgrTJaP0M=;
        b=BbY5F0DeFVTIR8ihPtNiLZ9sknkG6+/+nKc6jrA6tCatT02C/qJjAzmN9Y3OpcWdLY
         uUqfVP1T/E1BR4fbBDGyGvxUD+p/DPqgaB1QSSJXklhhMyvrAtbNoIdnhjqXZqWGozlN
         oGHr4201pjvPsYwy7z39L3nvQEqFyH4RbD8BHjJvGbRLEFX1qleWxEZuxk9VnpYyh6Zg
         pPacwfdsTWgFbeA6vl1jUCDypOd+lUtcqp3dp3TvJuILmLRVbsHB49fQQQTF+ZtKYo3u
         0v8zvgZCYtAh4udT4WhNzSZJvMu8AhyY2kd4ySlOGdp7cccXIqd8lG7pt0Pjh/hZW1qR
         KVqg==
X-Gm-Message-State: AOAM53172Bdghvjrk9peFiesQSwy9+vbdRxo/9ppcf+pdoUwTCjDS/sm
        2nBA+07FT+Ehqo9ZWVrxH6Xj3m06Z1H2vDLxekY=
X-Google-Smtp-Source: ABdhPJxFJvuwWGC5GrFl1qj+qpwGu1Hw17FayDDh83qmi1ySNxF6NpZN0/Wvnp/61O2HQfqO5gnK9Vn7LIva3OI+Ewo=
X-Received: by 2002:a37:f903:0:b0:648:ca74:b7dc with SMTP id
 l3-20020a37f903000000b00648ca74b7dcmr3488000qkj.666.1645432800168; Mon, 21
 Feb 2022 00:40:00 -0800 (PST)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220125194609.32314-1-nick.hawkins@hpe.com>
 <CAK8P3a0ccoH_sNE9eWxQnWHEWNBPFL6k4k6mku=cHs_fRfnL-w@mail.gmail.com>
 <CA8148A1-578E-4621-9714-45AB391C353A@hpe.com> <2f4dd91a-e4ad-2559-f65e-914561de4047@canonical.com>
 <015EB9CD-ADB9-4C12-BD3F-78268E849884@hpe.com> <CAK8P3a3AUdQ94yu5An0-MhOuY2bOsr=zFWhtqVHk6E_+hBUCZQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3AUdQ94yu5An0-MhOuY2bOsr=zFWhtqVHk6E_+hBUCZQ@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 08:39:47 +0000
Message-ID: <CACPK8XfgbQvAN+RzXWV0zJ_s9u3huyqA-1rofpf__3ifyB_Vzw@mail.gmail.com>
Subject: Re: [PATCH] Adding architectural support for HPE's GXP BMC. This is
 the first of a series of patches to support HPE's BMC with Linux Kernel.
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 at 09:00, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 31, 2022 at 7:52 PM Verdun, Jean-Marie <verdun@hpe.com> wrote=
:
> >
> > - GXP is the name of the SoC. It has multiple implementations, which ar=
e currently compatibles. I don't think for the moment that we need to disti=
nguished them. We might have a GXP v2 coming up but not before a certain am=
ount of time which is far enough.
> > - This SoC is used to implement BMC features of HPE servers (all ProLia=
nt, many Apollo, and Superdome machines)
>
> Is there any more specific name of the chip that can be used to identify =
the
> exact generation after a new one comes out? The normal way we handle
> compatible strings for devices is to start with a specific model number o=
f
> the chip that integrates it, and then have later chips refer to the devic=
e by
> its new name, with the old one as a fallback. This makes drivers work out=
 of
> the box when the device is unchanged, but gives you a way to distinguish =
them
> if a difference gets noticed after both revisions are already used.
>
> As with some of points that Krzysztof and others made previously, the goa=
l
> here is to avoid binding incompatibilities in the future: anything that w=
orks
> in an upstream kernel should keep working in later versions, ideally
> allowing any combination of old and new dtb blobs in the bootloader
> with old or new kernel versions.
>
> > It does support many features including:
> > - ARMv7 architecture, and it is based on a Cortex A9 core
> > - Use an AXI bus to which
> >         - a memory controller is attached, as well as multiple SPI inte=
rfaces to connect boot flash, and ROM flash, a 10/100/1000 Mac engine which=
 supports SGMII (2 ports) and RMII
> >         - Multiple I2C engines to drive connectivity with a host infras=
tructure
> >         - A video engine which support VGA and DP, as well as an hardwa=
re video encder
> >         - Multiple PCIe ports
> >                 - A PECI interface, and LPC eSPI
> >         - Multiple UART for debug purpose, and Virtual UART for host co=
nnectivity
> >         - A GPIO engine
>
> Thanks for the description. This seems quite normal then, similar to the
> aspeed and npcm BMC platforms that we support already. You can
> probably drop some of the people on the Cc list, but I would suggest you =
add
> the openbmc list and Joel Stanley (Cc'd now) in your next submissions, Jo=
el
> would be the best person to review the parts that are BMC specific.

I had a call with some of the HPE developers a while back. It's good
to hear from you again.

As Arnd said, please cc me on your submissions and I'll provide
review. You can also cc openbmc@lists.ozlabs.org to reach a wider
audience of BMC developers.

After our call the other month, I took a look at your latest kernel
tree and started teasing out something that could be submitted:

https://github.com/shenki/linux/commits/gxp

Hopefully this helps illustrate what we mean about breaking down the
patches into small logical chunks. Don't take what I've done there as
correct, but it's an indication. Feel free to re-use.

I encourage you to take a look at the aspeed device trees for
inspiration. The way they are organised into generations - 2400, 2500,
2600 - illistrate's Arnd's points about supporting multiple
generations of SoC with the one code base.

Cheers,

Joel
