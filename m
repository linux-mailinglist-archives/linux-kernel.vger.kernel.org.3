Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3162B5A17D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbiHYRRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbiHYRRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999F1BC136
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E8CE61CBE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91456C433B5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661447860;
        bh=9HJauqwB3EauAroaJ3FWvo7a3FQNmpwd8gmCOKX2Ebw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TbLZoq8/FJEGlKcwFPDMyCozxt/qn0I2yE3joHW8skxnGBXYs3faPdIWTVeMc0Fw9
         bR5rTObL57LfpoGEfg1NVdQIYfKury41REbW1S358eMS0/MhzhUj9h3I4tPMTQC8vS
         xxXLpVtNbcvCEoXkEdJNw+B647jvV5LkzJafjXbkmiWkEwa5TJjxq+XX3VoDniVCcp
         iv0nYCieHtzEhXNDJ+rR9Ky5xWLmu7fdS3ZuvDdovxhliM4rd/3MXDiJsv+6mH6YUE
         +jCc8hkqNXLy8iX7Y3tXuS9ntHxlTNDJ5+C8N+RS5ypENWXyiZw65bJoG3rxSW5dm1
         wRRc4oTuNRecw==
Received: by mail-ed1-f45.google.com with SMTP id b44so6718411edf.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:17:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo1CWDrcxi1twoO3i95QwfUhbWOz7Y9+WAp29/gLF9I6Cykc/cYM
        YtPvLA5b+vg3EKKDbXsH6MxVgY6yLX9kPrehHpM=
X-Google-Smtp-Source: AA6agR7oHeOZkjRl1I6uSblkdEMGXMOkWFbEyTUCIIO+wKnJFqaKBxtwoAtAUUkM2q8yf1ejce8X7g/DfTu0vKEnpPw=
X-Received: by 2002:aa7:cb06:0:b0:446:7668:2969 with SMTP id
 s6-20020aa7cb06000000b0044676682969mr3980374edt.206.1661447858773; Thu, 25
 Aug 2022 10:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220821055326.GA25950@lst.de> <20220825091752.3535657-1-arnd@kernel.org>
 <YwdQjEJBUwGJB/YK@shell.armlinux.org.uk>
In-Reply-To: <YwdQjEJBUwGJB/YK@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Aug 2022 19:17:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3xXQ7SbAsFAe637PkpL8_2NYstjOLj35D+QPyy-GzKGg@mail.gmail.com>
Message-ID: <CAK8P3a3xXQ7SbAsFAe637PkpL8_2NYstjOLj35D+QPyy-GzKGg@mail.gmail.com>
Subject: Re: [PATCH 5/4] ARM: footbridge: remove custom DMA address handling
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
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

On Thu, Aug 25, 2022 at 12:35 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 25, 2022 at 11:17:52AM +0200, Arnd Bergmann wrote:
> > -/*
> > - * The footbridge is programmed to expose the system RAM at 0xe0000000.
> > - * The requirement is that the RAM isn't placed at bus address 0, which
> > - * would clash with VGA cards.
> > - */
> > -#define BUS_OFFSET           0xe0000000
> > -#define __virt_to_bus(x)     ((x) + (BUS_OFFSET - PAGE_OFFSET))
> > -#define __bus_to_virt(x)     ((x) - (BUS_OFFSET - PAGE_OFFSET))
>
> ... and this tells you why that is with ISA devices.
>
> So, one hell of a big NAK to this patch, sorry.

Thanks for taking a look. Apparently I misread the interface, and I assumed
that the __bus_to_virt() BUS_OFFSET in set_dma_addr() would
just cancel out the dma_map_single() in isa_enable_dma().

It turns out the logic is actually simpler and we just convert between
virtual address and bus address three times. for most drivers.

I found one driver (cs89x0-isa) that uses isa_virt_to_bus()/virt_to_phys()
instead of dma_map_single(), but that is probably never used here.
Once we move the DMA offset into the device, all other ISA devices will
also get the default zero-offset, but I think that will be fine as long as the
"isa_dma_dev" that is used for the final translation has the correct offset.

I'll try to come up with a new version tomorrow.

       Arnd
