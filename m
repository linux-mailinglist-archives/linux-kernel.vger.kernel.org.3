Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC47546809
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiFJOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiFJOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:05:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C5D21B112;
        Fri, 10 Jun 2022 07:05:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u12so53721495eja.8;
        Fri, 10 Jun 2022 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbP9gsqB3qLAoNU77kEBLK9K01UViT8sDRAizGOWGnQ=;
        b=nWkjQLJG1m1S4r5WE2Gtw3EP/pIxjJTHgF1eR8+KokXXsSNNpb+SqC94VTcD0tAMp3
         tkefAzAetwJHDH0kmJ24rFsU/5cVNdS+HmLXBqyfZHdCJSzPGrYFZ+CiwmIjrt2VFFjO
         xCuFSR8HaLcnWttMLCYSLjvH/J4NgGKk7sgLQJbCSIaUdFhpFRip6jwyCCspYMD5ZMuB
         ya848z4SH/f4Uralab+xCGDpPzTAt7O294CzkXjb4pj7qCEVzUXU4Rit5EzWc1Sc39Yb
         OoWIOUVgZ1uEDRlPM6LKkrSXL1AkCoVY/mi6aFcPn3wPYc5s3QeDbEpR4edSLelxDVRT
         Zgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbP9gsqB3qLAoNU77kEBLK9K01UViT8sDRAizGOWGnQ=;
        b=Y5fXsNsnTucKuVdZWkb4ewN9X+e1l3+addHk6G8UzIhKyd2aFMGoiHThRBiW3hVBpK
         8yti8jP47UNQ8IrTpKMVcq3iLpK9JFHs8byRz0x+mib2wsk7l73jjOxuZot3riUSZMXg
         sZn94Uc5B0h9qXbiNA5v5X70mJ6WTGrqrT/ncGZqTUuTZjcvw8bmCD64I8Tzsxv5+O5r
         3bgEwOJZCgcYQRZSmlnAaT4CgG+HbLCEOb15GV/0UQYl/KPSFTuvdrdHcbZ9wQA1R3aW
         MWojWKdzQnDgjEyn/600RjDWsGUMrnJi2sIlq3msvsmHwqxpXArw+rq3qA8/RtSknvAe
         dtPg==
X-Gm-Message-State: AOAM533YyMCMijcvEV84w8CT/1hRLYvJC5oBKmZP2DD6tWAdWB+UvtQq
        G4V1dBzZrq17YoqY9Vf09hXUgEr6VDowMZzMiOM=
X-Google-Smtp-Source: ABdhPJwdT1ddg6Z7ftgUrjujTENenz0urdV1b3U/bCuWXcAIRq+FIlp8WEY+sC9/bq1VeoLtxTiU4RFuGbwHqkQXIL0=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr40122920ejc.579.1654869945337; Fri, 10
 Jun 2022 07:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220609121334.2984808-1-david@protonic.nl>
In-Reply-To: <20220609121334.2984808-1-david@protonic.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:05:06 +0200
Message-ID: <CAHp75VeA72YLPbPipx+MQCHdkgXy5dnCbADm=CMjgA5NpJE44g@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix per-cpu stats access on 32 bit systems
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 2:29 PM David Jander <david@protonic.nl> wrote:
>
> On 32 bit systems, the following kernel BUG is hit:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-mesages

-- 
With Best Regards,
Andy Shevchenko
