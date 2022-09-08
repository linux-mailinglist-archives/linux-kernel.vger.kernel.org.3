Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079F95B22F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiIHQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiIHQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:00:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770EF7B78F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:00:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so2790434pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uUAptloKXsUhc5RdRAer9UcXRS270T3TKnFTRNXj8IE=;
        b=VnRpsbSsELxB/oSot/2j6eMfU1heBpPQFSiokJNJsEWZBKYql0eypvaIz7fux1H30h
         QzFWu7cN+1JV/mlix7z8lnMHYZr/5e/gEPossmBKL0emMirrVmB3bXBvmDL73cPu0z53
         Pru5E/dNRV/NAi6Tw0yI/PqWmgogcEZPpba0j24fz+iBDcjTGQRR/7eI30j/VKnESigD
         mmHKtaIvtjUDKqQj+RqJijWLFKyADgguZbtG/MOLRnJRIWdJjz08mUE6eED6pMM/O1Oe
         yym8lYFktVwoxGdFGVagt1570kxrtVwQZ3non7YVMkoS6+ZXgbBCxGyVpqZ3dmet+HRr
         tvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uUAptloKXsUhc5RdRAer9UcXRS270T3TKnFTRNXj8IE=;
        b=xX5EgUaE8M7KcH0wJyRLaQmbPjG3Z4pbZXtoncVWaGo3cL3VRA49UjJbBxH1mMNWLz
         IbDbzH9Wvjb4H5JIGPcyYqeWT7fobJlXCAe5joL6r6y+AmfvoeqtWkViI78anxz7DYkC
         gQ5csl/LCaM+JQJ9ZBt+H7Dm9sjdzX6AHpR9Tp2AAqrZpqYEnVf4vC7JldOgMqbjJn6s
         DhzyU+aIZDMeaQbK/7fVPS+0Ptzna68j+K12b53chr1mNM8L8evedJlvOOEWn2C77/m5
         Zg9YywCeGDfnKAF8G4qFlEuq356fL1A5gMhdm8D3Vgryenp0g3nCLMGFjWbiYjHmAwTt
         9rWw==
X-Gm-Message-State: ACgBeo0Jl57FHN+AZWTukgR/lKgZP7I7dy1+i4yiUJgIaugW7VKNSGdl
        vXBP5NBsHZv2ZQRd/yUYoHguvZQ0D4R90Ow7cYz2up3dLRmsrQ==
X-Google-Smtp-Source: AA6agR5madP3qGyz1BQfqw3nC2KML73nEGwhEuS5oVy2zsJA6zOqe6vCk5VeGmvO8XNL96AqFkx91ucSEd3mQ9kQCv4=
X-Received: by 2002:a17:902:9887:b0:172:7090:6485 with SMTP id
 s7-20020a170902988700b0017270906485mr9826023plp.63.1662652821976; Thu, 08 Sep
 2022 09:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
In-Reply-To: <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 8 Sep 2022 09:00:10 -0700
Message-ID: <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> Hi Tim,
>
> On 9/2/22 01:23, Tim Harvey wrote:
> > Greetings,
> >
> > I've found that the bd71847 clk driver (CONFIG_COMMON_CLK_BD718XX
> > drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847 C32K_OUT
> > pin) which is connected IMX8MM RTC_XTALI which ends up disabling the
> > IMX RTC as well as the IMX WDOG functionality.
>
> //snip
>
> > This happens via clk_unprepare_unused() as nothing is flagging the
> > clk-32k-out as being used. What should be added to the device-tree to
> > signify that this clk is indeed necessary and should not be disabled?
>
> I have seen following proposal from Marek Vasut:
>
> https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d6d0831bf43d5f293e35cb27f3021f278d0564
>
> I am not sure if the discussion is completed though. I guess it was
> agreed this was needed/usefull and maybe the remaining thing to decide
> was just the property naming.
>
> Best Regards
>         -- Matti
>

Thanks Matti,

Marek - has there been any progress on determining how best to keep
certain clocks from being disabled?

Best Regards,

Tim
