Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9341F517758
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387100AbiEBTZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiEBTZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A92F7C;
        Mon,  2 May 2022 12:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F187614C8;
        Mon,  2 May 2022 19:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80095C385AC;
        Mon,  2 May 2022 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651519324;
        bh=0aG9zi/eAzvshX4pChfzjtI5FyTMCAi0+HUAcCHP7jM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FNh9+lraT0Fyzxuk6PsRFMVdYRljF/irwK3mBNIIIrg4SIsAn4ceziEF6s0PMYJMY
         4KFW2+g1hP10yCZHT5A/v1CUXtFTbqJL7jezx1SAb37JLMLH+Ogrg5LrOC5xIYS3tZ
         FGL+0GWtShgxCALi1KMJaxSS3r1R0LQwlEQEtgmH72Yf3FUrEFdbTBA43w4SuVPtee
         0qKMoBmIRzx98G1fU9OsKqVaoEboOZfjePoddAWH6Iw/3PqhbPBjAYYKbnjIpnCsBr
         xtAZ3R1IjVY8cflDeLBTmSFlHqthVAjbypEj817GYf2pUncnZ7SToXVa4T243yvl2v
         uZEg1jeSHzn9g==
Received: by mail-yb1-f171.google.com with SMTP id i38so27641640ybj.13;
        Mon, 02 May 2022 12:22:04 -0700 (PDT)
X-Gm-Message-State: AOAM532tpwWlEH4gmYk60MnvWozG9RAYexg4CJHdle2Lb632DfpBeZTL
        OiOPAlJqD1Ajsk8hBx34XcFaLQSQuqDdblXyWgc=
X-Google-Smtp-Source: ABdhPJyNocrkocyw/Rl1W7raRpoFO7LtpbwSGKzdnLpoapTUgqvZ2HvsJmPGgyMH50BFkSJO7u5VKl2ISlcAeK2ibaQ=
X-Received: by 2002:a25:cdc7:0:b0:648:f57d:c0ed with SMTP id
 d190-20020a25cdc7000000b00648f57dc0edmr11240069ybf.480.1651519323588; Mon, 02
 May 2022 12:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220502164330.229685-1-hch@lst.de> <20220502164330.229685-5-hch@lst.de>
In-Reply-To: <20220502164330.229685-5-hch@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 2 May 2022 21:21:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2MCVYz9LF7dKR=qt4OddhZMyYVk2UGWeF62QzJ9OADHg@mail.gmail.com>
Message-ID: <CAK8P3a2MCVYz9LF7dKR=qt4OddhZMyYVk2UGWeF62QzJ9OADHg@mail.gmail.com>
Subject: Re: [PATCH 04/10] ARM/dma-mapping: remove the unused virt_to_dma helper
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 6:43 PM Christoph Hellwig <hch@lst.de> wrote:
>
> virt_to_dma was only used by the now removed dmabounce code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
