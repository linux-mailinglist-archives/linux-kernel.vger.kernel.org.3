Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436A5576CB6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiGPJLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGPJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:11:39 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589301D0FF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 02:11:38 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D9C4222239;
        Sat, 16 Jul 2022 11:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657962696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQGL23JsPeSeAEQf+zFFrbIZAmWH8zEFfmNMuLuPhpc=;
        b=adivtjJ8EP/gIxSf5jgl/wyTKIUeMTPJctYdpQUagTsYiY/I1+k09dm4e8QVscwkFtWpm+
        we9xa/wMvvkraVLkJjqGs+PspYY7dJflaK+RM5eSb6N0qX+4xNhnv1EWOyXJztxj4c3Fhq
        h9nP3QjkbhljrVJjDoG+Lapm6FDmjYQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 16 Jul 2022 11:11:35 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Graeme Gregory <quic_ggregory@quicinc.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: winbond: add support for
 W25Q512NW-IQ
In-Reply-To: <20220716000643.3541839-2-quic_jaehyoo@quicinc.com>
References: <20220716000643.3541839-1-quic_jaehyoo@quicinc.com>
 <20220716000643.3541839-2-quic_jaehyoo@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <52fb683e27b3208d07d9f9d1ab44148d@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-07-16 02:06, schrieb Jae Hyun Yoo:
> Add support for Winbond W25Q512NW-IQ/IN
> 
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> Link: 
> https://www.winbond.com/resource-files/W25Q512NW%20RevB%2007192021.pdf
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks again for finding the real issue here!

Reviewed-by: Michael Walle <michael@walle.cc>

But also see below.

> $ hexdump
> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp
> 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
> 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
> 0000020 6f00 7074 7420 7365 ff74 ffff ffff ffff

Did you noticed your SFDP data changed compared to:
https://lore.kernel.org/linux-mtd/20220710145721.1207157-1-quic_jaehyoo@quicinc.com/

Which makes me wonder if you ever had an offset 0
with the OTP_INFO(). For Winbond the first OTP
region is actually the SFDP.. So you might
accidentally modified it.

-michael
