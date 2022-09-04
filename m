Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794E45AC590
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiIDRDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDRDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:03:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CE2B273;
        Sun,  4 Sep 2022 10:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C5C960FC4;
        Sun,  4 Sep 2022 17:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A857C433C1;
        Sun,  4 Sep 2022 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662310987;
        bh=EcXPP6Y1c06oVCwaXq53q7wHe38vVS+n7PCI/+LSJlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r6SEjWAgDGaLrHQguYgL/Gh3uSkNLN/+SuAki6ImXRJ4SxfKHpNg0XOK1i24G1EiX
         yiFzDzS7NvW0fg61wG+3JDJVZUqAZm2D5S7fXS2RSHcpnwvR1XcAMeE4jdcDFUa7De
         ICIceCPpLVgapZLRKtdMVFNHrOKa9VzbQk9y3+cav6RdMoQzzIrc9HZHwGBFTpmEXw
         bG6fRSrov3nOnvYIeMkAVJo0qsFdMrp6EaXyuoZPG3EwE2D9PEzRbcSUPEW5/pSeZ8
         twHu53h8YbvX2VdyqWp/6g1eHIzCU8OsB4+1kaGECTi+Bnj/h7qiDV2+N5484zxi3l
         TKUbU2eptjHOw==
Date:   Sun, 4 Sep 2022 17:29:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel <kernel@axis.com>, "lars@metafoo.de" <lars@metafoo.de>,
        Axel Jonsson <Axel.Jonsson@axis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: mcp320x: add triggered buffer support
Message-ID: <20220904172900.099ed1d0@jic23-huawei>
In-Reply-To: <Yw8SJil96IT6fP0n@axis.com>
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
        <20220824104002.2749075-3-vincent.whitchurch@axis.com>
        <20220828182430.533bf8e0@jic23-huawei>
        <Yw8SJil96IT6fP0n@axis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 09:47:50 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> On Sun, Aug 28, 2022 at 07:24:30PM +0200, Jonathan Cameron wrote:
> > On Wed, 24 Aug 2022 12:40:02 +0200
> > Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:  
> > > Add support for triggered buffers.  Just read the channels in a loop to
> > > keep things simple.  
> > 
> > Just curious, but what other options are there?  A quick datasheet scroll
> > through didn't seem to suggest you can overlap setup of next read with
> > reading out the previous (common on SPI ADCs).  
> 
> You're right that the hardware doesn't support any special method to
> read out multiple channels; I can mention that in the commit message.
> But I think you could construct a spi_message which a bunch of
> spi_transfers which toggle the CS appropriately between them to read out
> multiple channels in one go?  (Note that the variants have different
> data formats, and many of the variants only have one channel.)

That might be a little more efficient on a suitably advanced
SPI controller, or where the overhead of jumping between drivers
is large, but in many cases it won't save that much.

Would need an experiment on a platform someone cares about to decide
if it is worthwhile.

Jonathan

