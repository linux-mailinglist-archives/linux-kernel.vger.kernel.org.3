Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868AD508027
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359287AbiDTEh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiDTEh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:37:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F810CD;
        Tue, 19 Apr 2022 21:34:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E88F67373; Wed, 20 Apr 2022 06:34:38 +0200 (CEST)
Date:   Wed, 20 Apr 2022 06:34:37 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>, "hch@lst.de" <hch@lst.de>,
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
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220420043437.GA1123@lst.de>
References: <20220415142055.30873-1-sven@svenpeter.dev> <20220415142055.30873-7-sven@svenpeter.dev> <20220419053157.GA31530@lst.de> <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com> <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:52:15AM +0200, Arnd Bergmann wrote:
> > I just checked again and 64-bit accesses seem to work fine.
> > I'll remove the lo_hi_* calls and this include.
> 
> If you remove the #include, it is no longer possible to compile-test
> this on all 32-bit architectures, though that is probably fine as long
> as the Kconfig file has the right dependencies, like
> 
>       depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
> 
> I'd prefer to keep the #include here, but I don't mind the dependency
> if Christoph prefers it that way.

So thre's really two steps here:

 1) stop uing lo_hi_readq diretly which forces 32-bit access even on
    64-bit platforms
 2) stop using the io-64-nonatomic headers entirely

I definitively want 1) done if the hardware does not require it.  Trying
to cater to 32-bit build tests on hardware that has no chance of ever
being used there by including the header seems a bit silly, but if
it makes folks happy I can live with it.

> 
>        Arnd
---end quoted text---
