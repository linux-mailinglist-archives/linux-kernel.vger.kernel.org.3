Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3095811DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiGZLYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiGZLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:24:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B232073
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47125B815FC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035FAC341C8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658834671;
        bh=4PdZ0rH+0fNx9Gect/caVUluiuvP8ychzpfEjwgKEKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MJTMpfHhsv2czrjR/uVb9Ig2HS3GKfQU946PK+cCZ2QHnJ1Cra8rT+3bsRYjSWcGr
         ivzGKyUws5M9+oTssuZDhS8W9qTdbWyB+Bd9LQENIAs3HWiI6nHADRBn17OZkKkN6N
         K6eS3drPtrc8um9a+0PZuC6LQc5580Xh2ZjmkkVzqBE/FQomhvPKDvohMzZ3+0pTdx
         pRzxtL/QAsG7gjQ1o7srha1qoyjIK9MzPFWNpnI/OR0Cg/rPmVkObGCFkztbjUUIHH
         QWFfcVr7NWIYAyBxRRJ4g4fzqNrsOGvi33131SjgGpyf0UGqxM/OgMJqsi0plAahW+
         mOKyhSYrNeKFQ==
Received: by mail-yb1-f174.google.com with SMTP id d124so7346308ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:24:30 -0700 (PDT)
X-Gm-Message-State: AJIora9CLmjuD+0zSrOoIs3EumfVQT2wQAwunORrXRoOqp90wcWAC5Ew
        SOoSfW6ZP8krDrQ37Peo7UYtf1ihURG3j0jLJGI=
X-Google-Smtp-Source: AGRyM1vjZV7u4VWBn5M7U2snemReSre/cUu79z979YMUqs6Ra6hkwVHayJu1aZNYtZ4EyfkZyBqnVdRC+gc10fNqvSc=
X-Received: by 2002:a25:3085:0:b0:66e:4440:f42e with SMTP id
 w127-20020a253085000000b0066e4440f42emr13258899ybw.403.1658834670079; Tue, 26
 Jul 2022 04:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf13JA+5vuAKqvBSs3MkcF-gbE_8vd9nSvStQga55vW80VA@mail.gmail.com>
 <20220725065308.2457024-1-jiho.chu@samsung.com> <Yt5cFBgiTLwGXv17@kroah.com>
 <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcms1p5>
 <20220726020952epcms1p59c06fabb55776e195dcbeac549c98ef7@epcms1p5>
 <8b69b813-d030-2666-37f1-a731b1d52f4e@linaro.org> <CAK8P3a3xhAcokq1p0_PzK2JzR9BGNcaohA_nan9nS9NioW4_rQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3xhAcokq1p0_PzK2JzR9BGNcaohA_nan9nS9NioW4_rQ@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 26 Jul 2022 14:24:03 +0300
X-Gmail-Original-Message-ID: <CAFCwf13uLM3kr20dBZV3u3xLwwMXdt=7p7y9HhR+ocknsz=cLA@mail.gmail.com>
Message-ID: <CAFCwf13uLM3kr20dBZV3u3xLwwMXdt=7p7y9HhR+ocknsz=cLA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Samsung Trinity NPU device driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiho Chu <jiho.chu@samsung.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Yelin Jeong <yelini.jeong@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 26, 2022 at 8:59 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 26/07/2022 04:09, MyungJoo Ham wrote:
> > >> Hi,
> > >> Why isn't this submitted to soc/ subsystem ?
> > >> Don't you think that would be more appropriate, given that this IP is
> > >> integrated into application processors ?
> > >>
> > >> Thanks,
> > >> Oded
> > >
> > > This series (Trinity-V2.3, V2.4, A1, ..) is being integrated to multiple SoCs,
> > > not limited to Samsung-designed chips (e.g., Exynos).
> > > It's a bit weird to have them in /drivers/soc/samsung.
> > >
> > > CC: Krzysztof and Alim (Samsung-SoC maintainers)
> >
> > If it is not related to Samsung SoCs (or other designs by Samsung
> > Foundry), then it should not go to drivers/soc. Based on cover letter,
> > it looks this is the case.
>
> Agreed, and I also don't want to add any drivers with a user interface
> to drivers/soc/. The things we have in there mainly fall into two categories:
>
>  - soc_device drivers for identifying the SoC itself from userspace or
>    another driver
>
>  - drivers that provide exported symbols to other kernel drivers for things
>    that do not have a proper subsystem abstraction (yet).
>
> This driver clearly does not fall into those categories. As long as there
> is no subsystem for NPUs, the only sensible options are drivers/gpu
> and drivers/misc/.
>
>      Arnd

Thanks for the explanation, I wasn't sure what the criteria for
getting into drivers/soc is,
but now it is clear.

Oded
