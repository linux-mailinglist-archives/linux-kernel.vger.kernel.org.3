Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AAB5378F0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiE3KJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiE3KJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:09:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CA7B9CA;
        Mon, 30 May 2022 03:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12E20B80CEE;
        Mon, 30 May 2022 10:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA09C34119;
        Mon, 30 May 2022 10:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653905356;
        bh=/kppvhYwD8/XAUtnmJGkTh0/Ss6kFj/Di0BL20r+ByY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FJWwmKAoz1OhR0fCXaw00w8fpI0D5h7Kf9X+efPrrCEfyMERp9hKgiUrJosKGQitv
         Vytjn5kzWtH/P8LCemSknMl+TzlBPTf8NLWRxki0Ax406pk05vMK3XS4yOLFhlmrP9
         kT/9NExxMXxolh/idTx4hsJYae4PHtqR23Q+V8zSuRIw/fXjhkDek8ZSezuf8rvtwW
         fAzUR1/z1tNvy7Xj+2xIoirIHAuO0zGXWLWffCb9AH1ZJKYagw5++jDVJOSE8SqKFz
         zJ+qKBIVcC5EY6UtT0qolpuQqng4eczB3h5CJmd2yyrS+4VoWdS0tYpuUhEdnIYnfw
         tFGFa8WI1UWbw==
Received: by mail-ot1-f43.google.com with SMTP id e11-20020a9d6e0b000000b0060afcbafa80so7406146otr.3;
        Mon, 30 May 2022 03:09:16 -0700 (PDT)
X-Gm-Message-State: AOAM531SnS3dnRwh1/wMhThx3QKXH9f3X8fb+7ekiiPe8ocq/QUEU9e8
        K+ztaQvkA6qPDsT+oLI3LTfrw2lexZc9VOLXIAQ=
X-Google-Smtp-Source: ABdhPJxlYII5iC3+bAlEIZXSUojaOxYZF3pyifh19p4ELiRg5+9LGZcvlwIiQk+X/1RMsijPyi+2Rn3qVYB6vhveKJk=
X-Received: by 2002:a9d:76d5:0:b0:60b:1882:78bd with SMTP id
 p21-20020a9d76d5000000b0060b188278bdmr13976917otl.71.1653905355895; Mon, 30
 May 2022 03:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEF6KV=3CXhaRKygBs9hvun7=bKRua5NbWOrksaZBgtCQ@mail.gmail.com>
 <49eb2888-712e-7c81-313b-aec58e906778@foss.arm.com>
In-Reply-To: <49eb2888-712e-7c81-313b-aec58e906778@foss.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 May 2022 12:09:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEj6eGT8LszJTgBAec3Aq9tgsPC-cByGJ1vEXKny3Ui5Q@mail.gmail.com>
Message-ID: <CAMj1kXEj6eGT8LszJTgBAec3Aq9tgsPC-cByGJ1vEXKny3Ui5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Removes the x86 dependency on the QAT drivers
To:     yoan.picchi@arm.com
Cc:     Andre Przywara <andre.przywara@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        qat-linux <qat-linux@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 at 11:58, Yoan Picchi <yoan.picchi@foss.arm.com> wrote:
>
>  > On Wed, 18 May 2022 at 17:55, Andre Przywara <andre.przywara@arm.com>
> wrote:
>  > >
>  > > On Tue, 17 May 2022 10:11:09 +0200
>  > > Ard Biesheuvel <ardb@kernel.org> wrote:
>  > >
>  > > Hi,
>  > >
>  > > > On Mon, 16 May 2022 at 12:16, <yoan.picchi@arm.com> wrote:
>  > > > >
>  > > > > From: Yoan Picchi <yoan.picchi@arm.com>
>  > > > >
>  > > > > This dependency looks outdated. After the previous patch, we
> have been able
>  > > > > to use this driver to encrypt some data and to create working
> VF on arm64.
>  > > > >
>  > > > > Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>
>  > > >
>  > > > Are you sure the driver is safe for non-coherent DMA as well?
>  > >
>  > > That depends on your definition of "sure".
>  > > We indeed tested this only on a server with coherent PCIe.
>  > >
>  > > I skimmed through the driver, and it looks like to use the DMA API
>  > > correctly:
>  > > - I see dma_alloc_coherent() calls for DMA ring buffers.
>  > > - There are dma_map_single()/dma_unmap_single() pairs in other parts.
>  > > - Accesses to the BARs are capsuled via macros, using readl/writel.
>  > > - Access the the SRAM BAR is also only done via those macros.
>  > >
>  > > I didn't go through the driver systematically, and of course the
>  > > interesting parts are the ones you don't see easily, so I am eager
> to hear
>  > > any other opinions on this topic.
>  > >
>  > > Ard, do you have anything special in mind? Is there something to
> look out
>  > > for, specifically?
>  > >
>  >
>  > If it uses the DMA api consistently and correctly, and works as
>  > expected when running under a SMMU, things are probably fine
>  >
>  > > The few cards we have access to are in some server in the data
> centre, so
>  > > I can't easily walk in with, say a RockPro64, and test this there.
>  > >
>  >
>  > I suppose this implies that you have tested with SMMUs enabled.
>
> Sorry for the delay, I was away for a few days.
> Actually, our previous attempts were with the iommu set to passthrough,
> but I
> just tested without the passthrough and it works the same way.

Thanks for confirming.

So this looks fine to me as far as un-x86-like DMA topologies are
concerned. I do agree that big-endian should be forbidden or tested
thoroughly as well.
