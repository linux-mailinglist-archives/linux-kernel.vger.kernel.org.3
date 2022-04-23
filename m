Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B739650C93E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiDWKaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiDWKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C47E1BD59A;
        Sat, 23 Apr 2022 03:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408D060F4E;
        Sat, 23 Apr 2022 10:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958D3C385A0;
        Sat, 23 Apr 2022 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650709635;
        bh=ddKHEuTRbRut1OsQhp+YMuMz23onGUBMShLMqKxTwJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YJC/mBali+ZaOBUhChsdgZnicBb+bq6N7bb64+3OnZP+TROX50HxrR4xfieYO162x
         dhsCX3KlNWOAYKpEryeAQZvHfVEGdx6ZeVq+PfeOiiEeEKiKAb0SNrPkx3ucGF18R+
         0dtX4SEJb4GPT3zzGZZ2V0bhQtnNEtKkrhaMOzjCZQXPFaQOr8QtJjuw2JL++U03u0
         EaZ7eaANf8LaDkVOp68CUxX+JmnrMVZFSsUw4MDHdzjdey5M4Q4M3gFyoqTry8S8Vs
         FUSZAee2FGjz0SblW0KTs0Y1GuzYa6L095a67cWfXJUwp08vEMlcYCZC6t2W9HQ+Y1
         8AIu+DMm+RV8A==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1niCyv-006Mln-7Y; Sat, 23 Apr 2022 11:27:13 +0100
MIME-Version: 1.0
Date:   Sat, 23 Apr 2022 11:27:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: fully convert arm to use dma-direct
In-Reply-To: <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
References: <20220421074204.1284072-1-hch@lst.de>
 <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e3ff279d8f00fb38ee4e9ecda0e56038@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linus.walleij@linaro.org, hch@lst.de, linux@armlinux.org.uk, arnd@kernel.org, andre.przywara@arm.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, laurentiu.tudor@nxp.com, m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-22 22:17, Linus Walleij wrote:
> On Thu, Apr 21, 2022 at 9:42 AM Christoph Hellwig <hch@lst.de> wrote:
> 
>> arm is the last platform not using the dma-direct code for directly
>> mapped DMA.  With the dmaboune removal from Arnd we can easily switch
>> arm to always use dma-direct now (it already does for LPAE configs
>> and nommu).  I'd love to merge this series through the dma-mapping 
>> tree
>> as it gives us the opportunity for additional core dma-mapping
>> improvements.
> (...)
> 
>>  b/arch/arm/mach-footbridge/Kconfig                   |    1
>>  b/arch/arm/mach-footbridge/common.c                  |   19
>>  b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8
>>  b/arch/arm/mach-footbridge/include/mach/memory.h     |    4
> 
> I think Marc Z has a Netwinder that he can test this on. Marc?
> I have one too, just not much in my office because of parental leave.

I'm about to travel for a week. Can this wait until I'm back?
This is one of the few boxes that isn't hooked up to the PDU,
so I can't operate it remotely.

         M.
-- 
Jazz is not dead. It just smells funny...
