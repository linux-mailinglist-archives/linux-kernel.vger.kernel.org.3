Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952AC508542
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377355AbiDTJ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiDTJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:56:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C8D396B3;
        Wed, 20 Apr 2022 02:53:42 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0WsG-1nszeC33K8-00wUNe; Wed, 20 Apr 2022 11:53:40 +0200
Received: by mail-wr1-f53.google.com with SMTP id q3so1481796wrj.7;
        Wed, 20 Apr 2022 02:53:40 -0700 (PDT)
X-Gm-Message-State: AOAM530a/T3lSNfIKRsxeiVCK8oaNYEpwuvSxl+frYqz8Je0+Zyf9IOR
        S5oFJlWXV8Z5ubJe15Gi0/zvaOoVwsJT3Kmb7PA=
X-Google-Smtp-Source: ABdhPJwJPuI7Y1qtWlrDJp9C+nSYUzTzOJUfqs4AGk8MfQmW4nHphkYeGXo9SzAnynjyQA61TRt2Y+NXKTusJSUq7H8=
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id
 g3-20020a5d6983000000b00207a226df4bmr14835629wru.192.1650448420348; Wed, 20
 Apr 2022 02:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220415142055.30873-1-sven@svenpeter.dev> <20220415142055.30873-7-sven@svenpeter.dev>
 <20220419053157.GA31530@lst.de> <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com>
 <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com> <20220420043437.GA1123@lst.de>
In-Reply-To: <20220420043437.GA1123@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Apr 2022 11:53:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2-p=eW8jA=HVztFTq7mUMidRKcyFC_7RB5_8O2NmBxpg@mail.gmail.com>
Message-ID: <CAK8P3a2-p=eW8jA=HVztFTq7mUMidRKcyFC_7RB5_8O2NmBxpg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
To:     "hch@lst.de" <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sven Peter <sven@svenpeter.dev>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:816o8NH4smk9xfdzu6kCPxedQC6MYvOmwcVAbVdzj7to6Gi8MuY
 34AqD823jo4l1xY51ow8pjqGOnCwHLvpklvzdpYPLCXoBg7ImPJAJNLZXNA3iv3RfcA9TTM
 DX76xM413HBnSJuLLsaW4Sz3jLxc2Vgzj9s+AH3/bj9OT+T9ziVBT1HWVh1VycKMJjp70Ov
 TLYt594k4CUi49bZMjjeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W8kT3m4c+HM=:CHhKPCMv2U7cyBdKsKGrqP
 5Sy/wV6mPVX9VZFjjTK0EzSgRdLu+bLxI3eYcruHby/Gu2nGd6TlcCQuZjLlPtxbOq7sv5mgr
 7jxZRH491TmFjWlFoSEq3kDK+n0ns4xc5P4+MtkAEnSfqP1prAgxNeVne/Uj/Wdbs2mETjRli
 aPdWi0rHeAbSM57p0dRUwcyNyuoeuvjR/BbHSgw4DxbJrlEv9csg/zP5Jv+rdBAf/SM8Cqw/p
 ecb6WQ47H01kXTzrHjahn1gzuHwRFv/WuIMVdmOk9bTPNnukG7IXAo9ZLPfJX6XmgyMzxsFls
 qNxSFpv792vX9E6mDWspfP86KkHlS72dzHDMOfBcp3b6K+y8772Y4tCN2GQo4m7auHYcYXhli
 4uTdpoS1rk0b8+Tp3vkxmlpGG9o35caZ9oN1mM5MSHk/oC7vImasBu1Dp0XyEfChOOYGujh4p
 O5qsRyc3WbRf1drhXg+7v/VP1MaxMAG0XvNiHZvDkmX7Xsomnf9qDOpDBuVbeXZk0gcNMsUSm
 +KUpPI8CtytDxlhKnSTHEnSFN84DAg/KvQDGqz10jfS0R9xF5KB9HoZW+kaMyrHkWwacjqRfF
 JEMy6i7kYPihT+AXAeXcVWdWjxXjj+/hkWQ8xvkvqbcPFQXzWo1exEyVTsfkIdCESwcqKz67z
 vUrAdisAKWotAKrV112mOQ/JFN+pw56I2NcXdJoYUbVVgTWTjl+fTngdLlJSRflZcxY3fbceR
 df9s3PwhfEXL9hiF0DR4VkWsD0jmxrq2jGBcDnrZ6dP/HAeerJqmpV5TD8S/yHAQs50WLdHT+
 vd0dxq9U1/TNknkeFKYSvVqVrPlYrR2TRXzT219vC0hIFA8O/Y=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 6:34 AM hch@lst.de <hch@lst.de> wrote:
> On Tue, Apr 19, 2022 at 11:52:15AM +0200, Arnd Bergmann wrote:
> > > I just checked again and 64-bit accesses seem to work fine.
> > > I'll remove the lo_hi_* calls and this include.
> >
> > If you remove the #include, it is no longer possible to compile-test
> > this on all 32-bit architectures, though that is probably fine as long
> > as the Kconfig file has the right dependencies, like
> >
> >       depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
> >
> > I'd prefer to keep the #include here, but I don't mind the dependency
> > if Christoph prefers it that way.
>
> So thre's really two steps here:
>
>  1) stop uing lo_hi_readq diretly which forces 32-bit access even on
>     64-bit platforms
>  2) stop using the io-64-nonatomic headers entirely
>
> I definitively want 1) done if the hardware does not require it.

Yes, of cours.e

> Trying to cater to 32-bit build tests on hardware that has no chance of
> ever being used there by including the header seems a bit silly, but if
> it makes folks happy I can live with it.

As I said, I don't have a strong opinion either, it's either a trivial change
in Kconfig or a trivial header inclusion and I'd pick the header one because
it's more obvious what this is for without adding a comment.

      Arnd
