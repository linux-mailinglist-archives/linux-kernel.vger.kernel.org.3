Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350A54FBB27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbiDKLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiDKLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:46:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1677945AC6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:43:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s13so19744416ljd.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vdw4ZXHCV2Uqoc9GaWxbHE5SGjw8cSMUbAVvs7T22GI=;
        b=F20AJPCK1CUmmC/89HjK7NO6rVKSVy3xpQV7B137WtPj4PvbxYCWh7ZeWsyzMSxphb
         OSORHdz36qT/dybt+JqjzG125vybXdvRrnHsaEItWGI7ONrwjpdvqLsObj8g052BsYW2
         setyyqMFpM6YDU58chmeHDeXOS9hDx0narpJk/2lt0jLQ3Q7qUcU4OUy+Jhy2R+SX/U5
         dg/cZzI1tTxHa3Vl8N2wMEkp+s+986jop1ipS1pwaXcRr80ONdbU/B6Ve3KkC84CIWPk
         PZMMcbboGv6Jsu3PNaq3HwfXQ42oXfDKDmnJ+RQQe5vtaLv58+uzZJr/GO1G/wQ65Oa4
         /1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vdw4ZXHCV2Uqoc9GaWxbHE5SGjw8cSMUbAVvs7T22GI=;
        b=mu2u79WNLMcF8ZrqyQ/1Lxq62ZfCk3YFamab2yrNRDhu7lu9N+Bn0e9+q28HASD/XV
         9CPhwSMYuHk8yLNH1iAvLcl61L5y4SQxDm1Nv4XZbFVkq+cpRor0/3CV861qEVQ0XO0m
         ths0bb62vINPvzOjCIh75ZQqmmwEJLfW8BuG5lRv0yjK6M5jxqF6ZY/KRlLZL9AyY/67
         ZI+MxYys1Rns5vnPG/s4aclh2ykW18AqMYPLRWTKe/UckvqzdbwHMQT+NryiNvpEtY7c
         gxTjQzk5c9C9dRzmqpoRujEVShv6bELNGc7UnIp73tcT95ck8NuvbpQ2pOXV8RBTQvDI
         00jA==
X-Gm-Message-State: AOAM530moFwdZSOOfoxCdwpmsezdbrM1OSQ94YC8FPv89LJ9gm7KKq/C
        02Mly5w7ASWeciDR9bmTQqvh8aLObTSwcZHLw/b6xg==
X-Google-Smtp-Source: ABdhPJzd1j57QPZdoje//KcP9Tuy/PNpiFrQTI71gFTl5ZTAYthKpmeyoPyuscLcK59MdNdaagW07TWeRFQm8huBV9w=
X-Received: by 2002:a2e:b742:0:b0:24b:6370:1e00 with SMTP id
 k2-20020a2eb742000000b0024b63701e00mr2899689ljo.71.1649677427312; Mon, 11 Apr
 2022 04:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648461096.git.zong.li@sifive.com> <YlA1DwdIMoQ1dXZS@matsya>
 <CANXhq0ramPvr=CL2oPsPAnWiF9X0eYVt8HGAVWPE9mZ5PfhG7A@mail.gmail.com> <YlQHkeZhHvC/n0G5@matsya>
In-Reply-To: <YlQHkeZhHvC/n0G5@matsya>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 11 Apr 2022 19:43:35 +0800
Message-ID: <CANXhq0r15Z9NZj+xr7K_2Tt5VbK2r4+f7Fpg-f9BY98ufgKxcw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 6:48 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 11-04-22, 10:51, Zong Li wrote:
> > On Fri, Apr 8, 2022 at 9:13 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 28-03-22, 17:52, Zong Li wrote:
> > > > The PDMA driver currently assumes there are four channels by default, it
> > > > might cause the error if there is actually less than four channels.
> > > > Change that by getting number of channel dynamically from device tree.
> > > > For backwards-compatible, it uses the default value (i.e. 4) when there
> > > > is no 'dma-channels' information in dts.
> > >
> > > Applied patch 1 & 4 to dmaengine-next, thanks
> >
> > Hi Vinod,
> > Thanks for your help and review. For patch 2 and 3, does it mean that
> > we should go through the riscv tree?
>
> Yes
>

Hi Palmer,
Could you please help me to pick up the patch 2 and 3. Thanks :)

> --
> ~Vinod
