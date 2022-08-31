Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1CB5A7803
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiHaHsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiHaHrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:47:55 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86385A4051;
        Wed, 31 Aug 2022 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661932073;
  x=1693468073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aJUQjD5xtnOBGTEcIcJSA96Y6IzY+5A+14tz2WSnhO8=;
  b=Spax2XgkoZ637D3HAnBRnu1YYqWmdK43aQrEjMATZrX5wqr+pxD3f/uW
   siFSTJVg3jWpLPk4JgQqemMzn34/tE4SZUDEvKpCZ9dcPCfZZ4lh7UcOF
   Vnq3+912os+f+pGSPvkE9s861Gk26tJ86t99X1twPkZS5Jcz44mZ2ulTL
   O64TUOOg6CSMYs3WIrrgHcsX0lPGBa39SQum+SBjO7CaGPdPfLxH6MiJO
   toL5aGWzPS/z3D5xEtv4ir+XoxlSqigIi5Yx6TVtAUW+6S4EQ+R0kQaYp
   zg/XN9Ox34EzKa83wtMXRRp4jVDOw9vyEKJvxV1crBbUZnii0kFWGqE/Q
   Q==;
Date:   Wed, 31 Aug 2022 09:47:50 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     kernel <kernel@axis.com>, "lars@metafoo.de" <lars@metafoo.de>,
        Axel Jonsson <Axel.Jonsson@axis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: mcp320x: add triggered buffer support
Message-ID: <Yw8SJil96IT6fP0n@axis.com>
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
 <20220824104002.2749075-3-vincent.whitchurch@axis.com>
 <20220828182430.533bf8e0@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220828182430.533bf8e0@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 07:24:30PM +0200, Jonathan Cameron wrote:
> On Wed, 24 Aug 2022 12:40:02 +0200
> Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > Add support for triggered buffers.  Just read the channels in a loop to
> > keep things simple.
> 
> Just curious, but what other options are there?  A quick datasheet scroll
> through didn't seem to suggest you can overlap setup of next read with
> reading out the previous (common on SPI ADCs).

You're right that the hardware doesn't support any special method to
read out multiple channels; I can mention that in the commit message.
But I think you could construct a spi_message which a bunch of
spi_transfers which toggle the CS appropriately between them to read out
multiple channels in one go?  (Note that the variants have different
data formats, and many of the variants only have one channel.)
