Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861B5099CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386262AbiDUHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386293AbiDUHxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC76325;
        Thu, 21 Apr 2022 00:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED79361B83;
        Thu, 21 Apr 2022 07:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA37C385C1;
        Thu, 21 Apr 2022 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650527410;
        bh=scrBCeJL1OsZjxal/hOOJR8xrKpdhNNc3BiRG6d2EkQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I53ZD6Ob3R8QcG8tmbBFOshAoeh0KWTCN+0xytPix2nry7uRQ548WOA6mgeTA8b60
         xqcd8bPRZq0d9NGREbKcENA/6rrZ++7viLpgU63REWPzgO8q9prVkcA/bzV7MqTM58
         sUmxO6IoWO0a7H1x5VJkkaFc4lpZjiYA6noI7uY3mGaa0VeH955HVnMBGSpEbC8CAP
         RSs7zWjx/m1FtilWmdqSWcPG8debp7PnluxDXjtK3iWbHqmoQNSc7t0ehoBzQTENv0
         9QatR/d4pEc4EkMNyUjBndFN83NNoQCS6otBb5tlBjEwZo7+fypytHRD8fIwU/Q/4/
         PgYcCLLU9pZKg==
Received: by mail-wr1-f51.google.com with SMTP id s25so547584wrb.8;
        Thu, 21 Apr 2022 00:50:10 -0700 (PDT)
X-Gm-Message-State: AOAM530FfqQfrAh5WqtgnBcKDmL7d8U1P59eapo92IbHGxJmLudy8S4M
        QWF4Eyy07Y8oD586OwQO9nBQOJ0gntH1UG0RyUE=
X-Google-Smtp-Source: ABdhPJzRVJ/OmeGnrqJE761/+0TPqsFFrrS+icRdgf4Xe42e9Mrpm76xuvHw8bwt5K0xWAFGMv08ylmpsjeKAOckTf8=
X-Received: by 2002:adf:e106:0:b0:20a:b31b:213d with SMTP id
 t6-20020adfe106000000b0020ab31b213dmr3918734wrz.219.1650527408610; Thu, 21
 Apr 2022 00:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de> <20220421074204.1284072-4-hch@lst.de>
In-Reply-To: <20220421074204.1284072-4-hch@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Apr 2022 09:49:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Mv++CCGf2BuC-wS4VGb+ZhfnJqVwJkK-VcYAqfiPi8A@mail.gmail.com>
Message-ID: <CAK8P3a2Mv++CCGf2BuC-wS4VGb+ZhfnJqVwJkK-VcYAqfiPi8A@mail.gmail.com>
Subject: Re: [PATCH 3/7] ARM: mark various dma-mapping routines static in dma-mapping.c
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 9:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> With the dmabounce removal these aren't used outside of dma-mapping.c,
> so mark them static.  Move the dma_map_ops declarations down a bit
> to avoid lots of forward declarations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
