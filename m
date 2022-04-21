Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ED3509A22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386394AbiDUIF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386395AbiDUIFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872461CFFE;
        Thu, 21 Apr 2022 01:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 232BE61ABA;
        Thu, 21 Apr 2022 08:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C1BC385C5;
        Thu, 21 Apr 2022 08:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528154;
        bh=85ztGE8SAOJYsSsE/m/ye56564WWRnDCXfBI1VMh6w8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gx80Hh2cCildDpD/QBFdHR9o5EQI4TZJNxY+M5H7fSxIckh3WEkeA61atMMdcjAs3
         S1eAqplyh6FpSWhZlnE0zDt0DMoZ8vQJuuaC4Dyt6mtvcJHJGQlslG5tWAyufFpN7U
         +m0rH/jQNDvZtdE/ERPjRIKmMtCRfEgSCJgh2GuB0cb3cWfOQPdDoOuidIcQKuG0iY
         Sm9In6QEX7I7ZUBytG03Y7EH+G6pbZrkiy+sLch/OlLXMVfSl9zmTeQMB6R8FT7Xr5
         vWGQ0s3//ga4gycac/gtSC/F4l8SxARO/sZm4JlDqEsV2KSP7jzaKcflBXrbYPAdoM
         n/ugXKlhfRznQ==
Received: by mail-wr1-f53.google.com with SMTP id i20so5451740wrb.13;
        Thu, 21 Apr 2022 01:02:34 -0700 (PDT)
X-Gm-Message-State: AOAM5336s/lqLWJqUNhdXZXKtbE1EVKn3nShpPnB/r7QTkBTeoLYM1ET
        lCvzBB9vXlUTwTgdpgXr3jqQWrak8iOCQkcIclk=
X-Google-Smtp-Source: ABdhPJwd18r+4oxvbBvNk4Ssn0sgurWbN+G4WyUL66cAw98TCXAYMvuBOOjMpSguCZLqOVEc5MnPUhcs76UVW8oNVSU=
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id
 g3-20020a5d6983000000b00207a226df4bmr18349140wru.192.1650528152748; Thu, 21
 Apr 2022 01:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de> <20220421074204.1284072-6-hch@lst.de>
In-Reply-To: <20220421074204.1284072-6-hch@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Apr 2022 10:02:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2M-R+S9SFe2ti3j41qy3KCVgc-povo6GwDQn_Dj_AB4A@mail.gmail.com>
Message-ID: <CAK8P3a2M-R+S9SFe2ti3j41qy3KCVgc-povo6GwDQn_Dj_AB4A@mail.gmail.com>
Subject: Re: [PATCH 5/7] ARM: use dma_to_phys/phys_to_dma in the dma-mapping code
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
> Use the helpers as expected by the dma-direct code in the old arm
> dma-mapping code to ease a gradual switch to the common DMA code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
