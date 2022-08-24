Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1659F7DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiHXKeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiHXKeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23718051E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62979617E1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C492EC433C1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661337246;
        bh=sqdzEmFPorpibtqiIKyXAvvtyzPLjjIAm6st1qRuEP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ibm7uZeZpozGDcOyH0qYIA+GSPXbalQzWfyLG8M5ZU36L8fGe6ZBHXyMTwZfeAxsn
         mxF9cTCOOoGUyqXXBjMqEnaQJB6QqZe01z9ZoHEyvlVv8HTPYCjDfEsCwFV0pe1DSo
         btoyrKhXINe8uEZThbSbfuHnestDcqsXKDiGJeY8WvlbycQCsg05ugU/6qTFZW6+oh
         +CfVljkkLsitQirHZ9rd4RMXqv+Ok/weKIuSeK8Hdo9HAttsOwDMDzk2iSJW8r7tuQ
         3+SxBqvFzgG+diYBvMp2T1RUI3Y7Q0iuAchjBqTgIuELcxjGadjlJ1mk7bk8cl+UsE
         THo3qJ+AsdtXA==
Received: by mail-ej1-f45.google.com with SMTP id d21so13315297eje.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:34:06 -0700 (PDT)
X-Gm-Message-State: ACgBeo0wpgeygFteNxZPgeFpnSmOiiZLSQ/YeEUaMz3rVcuPY6TeubS8
        QP3pXn49EYZaWc0w1Qq6vmy/VUefD1zZ14S5eFU=
X-Google-Smtp-Source: AA6agR6frIDr03GkKykCqVlPgN1O1/4JwZ0Wqth/+Sxbkw/OH+O2DBdaO9c/TwE+N6K30wAIMwFo/cJV18fpAchNB9w=
X-Received: by 2002:a17:907:7610:b0:73d:afe8:9837 with SMTP id
 jx16-20020a170907761000b0073dafe89837mr2514038ejc.606.1661337245051; Wed, 24
 Aug 2022 03:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220818211550.3272321-1-arnd@kernel.org> <20220818211550.3272321-2-arnd@kernel.org>
 <20220821055326.GA25950@lst.de>
In-Reply-To: <20220821055326.GA25950@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Aug 2022 12:33:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a02KZQZTEV3pMyQcrv_szeoc4Yw8dbYGPiG0b806f6wzg@mail.gmail.com>
Message-ID: <CAK8P3a02KZQZTEV3pMyQcrv_szeoc4Yw8dbYGPiG0b806f6wzg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: footbridge: remove addin mode
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
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

On Sun, Aug 21, 2022 at 7:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 18, 2022 at 11:15:47PM +0200, Arnd Bergmann wrote:
> > The recently added phys_to_dma() functions are now trivial and
> > could probably be removed again as a follow-up, if anyone knows
> > how.
>
> The normal way to that would be with a call to dma_direct_set_offset in
> the init code.

Ah good, that is what I was looking for. Unfortunately it seems that the
platform does not itself create any 'struct device'. The DMA masters
are either ISA devices, which I think go through a dummy device an
should also use offset 0 (the same offset seems to get added
in dma-mapping code but subtracted again in the ISA DMA API)
and in PCI bus masters.

Is it enough to just call dma_direct_set_offset() on the PCI root
device, or do I have to add a pci_host_bridge callback to get
called from pcibios_bus_add_device()?

>  But for that we'd need to find someone to care enough
> about footbridge to test it.

LinusW, MarcZ and RMK all have one of these, I'm fairly sure
one of them can test the PCI side, though possibly not
the ISA DMA ones (parport, floppy, ne2000, and soundblaster
in case of netwinder).

         Arnd
