Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB16852A3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348089AbiEQNyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348129AbiEQNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:54:46 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAF24C42F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:54:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i24so16944026pfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hxCz8qFJl1d7hHxqcVamwqBk//vAbJimyLly9GCnKI=;
        b=riq1xk5q0YgWYKXzXPguRcCsM0+VTO1y7eIyaMS49ZOlWO0TmrpePr1BvcyZR6cqlz
         g++20MP4NUnvS8jeSzQraLOsI2yQYmlXjU6GMSBrcdZBPIBT2YUKJDDYNRKGbWjq/e5i
         xJk2cEqFW8vrhOKVxIefon2MbhEA8llpUFRW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hxCz8qFJl1d7hHxqcVamwqBk//vAbJimyLly9GCnKI=;
        b=IaB5e0R8fGgoX9Vl4By+hFFAa6jcR7Uy06kqFLvMUYFcum9kAeoq0B4kQ6qnLTz1U0
         0gayayp9pj9bYLf2skXFQAvE3j0wa3Ac8PeMl85G91/pfO+wp8kYHBBYa9KbGSlZr8GF
         5PjywBcwPbhr57MNGhNLPazWOb0otnlFwnekah5Lnj0UTgFHUh6gEx0AstDVKlPd/3uu
         SFI81hDOQ/GXkar7tUnjbC5wVa5wQO8ssARQ9LalTNQr6PguacT3Rrchz4Qkp0BqrylT
         tpIR153ZbXPk9Yd7dQIEyvqrOMPX5tzDDwox6fkSHhTBNu4rd07WyuyqVXPfbGpNa5so
         +5rQ==
X-Gm-Message-State: AOAM530iwilq2lUMnfcpGVi+dpcjYtOo0VVhqFIw3KihkhG+lLIIlYqX
        iIdKNP6nwNEl4s/rB0EVm/7PhiXPpDXtMvfbntVTmQ==
X-Google-Smtp-Source: ABdhPJxcVXd5rP7wLs8+pVlrfBwoBKnNHSpR/3Kdud5yWPKX14PCnvlYqR1yfJ7JSkYonCPbyrGV/sWgFgtL1M49WLk=
X-Received: by 2002:a63:cd01:0:b0:3f2:7f8d:14e8 with SMTP id
 i1-20020a63cd01000000b003f27f8d14e8mr6309251pgg.491.1652795684638; Tue, 17
 May 2022 06:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220517133540.2456987-1-michael@amarulasolutions.com>
 <bd342e6be1723daa3787c7088c3510d0@denx.de> <CAOf5uw=QxFM=CCFLZ=fZCfn9BBz1aFpkPQuED1uHxHRABwMHMQ@mail.gmail.com>
 <7e434e2426ab61476e5f58db764cbd9f@denx.de>
In-Reply-To: <7e434e2426ab61476e5f58db764cbd9f@denx.de>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 17 May 2022 15:54:31 +0200
Message-ID: <CAOf5uw=-AmHfw48csFQ_1U1Aj2B4yEAMoLT_-iHDC=EwALJwkA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx6ulz-bsh-smm-m2: Support proper board power off
To:     Fabio Estevam <festevam@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Simon Holesch <simon.holesch@bshg.com>
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

Hi

On Tue, May 17, 2022 at 3:50 PM Fabio Estevam <festevam@denx.de> wrote:
>
> Hi Michael,
>
> On 17/05/2022 10:44, Michael Nazzareno Trimarchi wrote:
>
> >> You missed your own Signed-off-by tag here.
> >
> > It's fine, I can add Tested-by: Michael Trimarchi
> > <michael@amarulasolutions.com>
>
> If you are transmitting someone else's patch, then you need to add
> your own Signed-off-by to it.
>
> This is explained in Documentation/process/submitting-patches.rst:
>
> "Any further SoBs (Signed-off-by:'s) following the author's SoB are from
> people handling and transporting the patch, but were not involved in its
> development. SoB chains should reflect the **real** route a patch took
> as it was propagated to the maintainers and ultimately to Linus, with
> the first SoB entry signalling primary authorship of a single author."

Done, thank you

Michael


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
