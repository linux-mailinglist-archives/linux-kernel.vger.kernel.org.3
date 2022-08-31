Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CA35A75E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiHaFpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiHaFo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CED5F9C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F130615F4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0688C433C1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661924694;
        bh=X4PxFntXm9Nca5RV5Kx6R9cYdqAMo4VWRPIFXi/6A9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AId5APbpWjvsqGbHljWBuKPy3aCwhBvRXYYxxVwOmh7JNTGGPVXpAnGAhGjBhcgBE
         OZcwa/vTp1opRyIsHkLgf+9FCFc3yhXXV9m1pqypG9Hyo3cJWGGzMcPWvvuTqGmoi/
         AU6HcvfEH0OQR3XiddD+vpd1Wf0rWFYn1nki1GGHaagxoRgWC9lj6+ajWannPohsrf
         mIEvNpwVjTm23XL9cnvEUeG1Ra7knOt4R6XarUHBrv/LPIEQC/q/Z8RqFvT6vBJ8gK
         eeuqW/QuIztJh6WaAlUBogvf8lTYRMg87TWSr3dlrqHx9Et11v16aehQlwGrQjZQ9n
         x40V9mDJzic7A==
Received: by mail-ua1-f45.google.com with SMTP id x15so4686703uat.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:44:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo2biB5o9IdN1TsQIBev5Ht5YqwyoGYc2Os1YAlppUHo4fxR43ef
        nYAdImsUl8yum9w7zNTFMYsGMlwF9pGortXcGJQ=
X-Google-Smtp-Source: AA6agR4CUWBBgX1i1ccifEvmTEI5b+tzXxFJ6cRSh8wIAakBnT/ciBFH8W1og/QTWRuqiwczjZ5vIGXyEP5BDziULXg=
X-Received: by 2002:ab0:2095:0:b0:39f:881e:51b6 with SMTP id
 r21-20020ab02095000000b0039f881e51b6mr4786047uak.23.1661924693646; Tue, 30
 Aug 2022 22:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104806.128365-1-xry111@xry111.site> <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
 <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name>
In-Reply-To: <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 31 Aug 2022 13:44:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
Message-ID: <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao and Xuerui,

On Wed, Aug 31, 2022 at 12:38 AM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 8/30/22 21:05, Huacai Chen wrote:
> > Hi, Ruoyao,
> >
> > Thank you for your contribution, this whole series will be queued for
> > 6.1. Though lkp reported some warnings, I will fix them myself.
>
> And of course add my Tested-by:
>
> Tested-by: WANG Xuerui <git@xen0n.name>
>
> (I've run the v6 actually, but there is not substantial change from v6
> to v7 so the status should stay good.)
With this series applied and ARCH_WANT_LD_ORPHAN_WARN enabled, we get
loongarch64-unknown-linux-gnu-ld: warning: orphan section `.got' from
`arch/loongarch/kernel/head.o' being placed in section `.got'
loongarch64-unknown-linux-gnu-ld: warning: orphan section `.got.plt'
from `arch/loongarch/kernel/head.o' being placed in section `.got.plt'

I think we should add this lines in vmlinux.lds.S
        .got : { *(.got) }
        .got.plt : { *(.got.plt) }

But put them to which patch? Patch 2 or Patch 5?

Huacai

>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
