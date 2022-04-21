Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C09509A72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386545AbiDUIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386556AbiDUIRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:17:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D15C1F62D;
        Thu, 21 Apr 2022 01:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3305B8229E;
        Thu, 21 Apr 2022 08:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B63C385AA;
        Thu, 21 Apr 2022 08:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528873;
        bh=qvOB0ikvcyf8yw1Oo7pNju5ahvdIUh+2Ix9pkj27y0Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C8/36XvBwLlf/tCkvKdfxh2dlEfTwb3EENcYUs7KzlM9ndwHlgIvwLRtufU1yCfZA
         KYdJoOqqjcf9N6DXfaXdlsuqzcCkvpmJtduGtJ7I8h4CSVYQbm6k17H7d//HzRl1xT
         +iLV4x1sM5NxUm9HVTj4ysVMwzaZfVw/fvd6ju1sh2mrdEOi/o/+H0T6JRE/MDevo2
         R/mw1ENGqiMBVG71qRJyYQ2KhyHdxQyK+pHv+IZH9LJSr426ea/y1UGGoPMWSecBQI
         FIslay2JFfL+IFTCjL3SnfnfcRPlyyTQGhbaubsdobe5Qzj75cwt2eYys8zsmNhZKf
         2YEu9sdnJHjVg==
Received: by mail-wr1-f53.google.com with SMTP id b19so5489476wrh.11;
        Thu, 21 Apr 2022 01:14:33 -0700 (PDT)
X-Gm-Message-State: AOAM530q4Em9PwN+t9CPfCF+e8whFuTvA0xhGuBF8IhYZ4CZgPIwMAz1
        I+b4livSIjyNrHUGdUSJrFq02IR3RZIzy1VA7SY=
X-Google-Smtp-Source: ABdhPJwmmO+oW480q+9P9XgUMSnyEpeIXZk6a3NVVRJyO7eKIgGvUhnLJsU5orqLkWv0a3+Q7VPZ8SMJsIerFHk4Q8s=
X-Received: by 2002:a5d:64a3:0:b0:20a:7931:5b84 with SMTP id
 m3-20020a5d64a3000000b0020a79315b84mr19205164wrp.407.1650528872088; Thu, 21
 Apr 2022 01:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de>
In-Reply-To: <20220421074204.1284072-1-hch@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Apr 2022 10:14:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0mrbawriAE28pkFvdmMQKy3BUR72RtKiVwbEUNLxhx=Q@mail.gmail.com>
Message-ID: <CAK8P3a0mrbawriAE28pkFvdmMQKy3BUR72RtKiVwbEUNLxhx=Q@mail.gmail.com>
Subject: Re: fully convert arm to use dma-direct
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

On Thu, Apr 21, 2022 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> arm is the last platform not using the dma-direct code for directly
> mapped DMA.  With the dmaboune removal from Arnd we can easily switch
> arm to always use dma-direct now (it already does for LPAE configs
> and nommu).  I'd love to merge this series through the dma-mapping tree
> as it gives us the opportunity for additional core dma-mapping
> improvements.

Thanks a lot for completing this, it looks all good to me, and I hope that
Russell can test my assabet patch to make sure this doesn't break
anything.

I saw one opportunity for an additional cleanup patch that I commented
on, but that does not stop the rest from getting merged.

I also made sure that this passes the basic kernelci tests across all
arm machines.

     Arnd
