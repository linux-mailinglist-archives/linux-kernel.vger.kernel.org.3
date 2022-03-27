Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B04E8851
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiC0PEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiC0PEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 11:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94BD24F16;
        Sun, 27 Mar 2022 08:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7678B61000;
        Sun, 27 Mar 2022 15:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9439CC340EC;
        Sun, 27 Mar 2022 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648393381;
        bh=e2KjtE5biO6qvO0Ppa5lM6lFh/vgjHDznklgdcn7Kz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S/wdiQp1Mp/6up6oqK/8Q/pLdtNvY3mzc+SVYr3Nyv4+va6P8CAQFCx+UUDptuk0X
         SFlYBbjXKfp+gZAw9oaupfDBXlaV3p++1rkiscRFoP7xSr5U5cZhgPET8c61YgKQ9F
         cnH5CXsUXh0g8S1ePsJT6LWYXGHiANJx4bL+bkRTsx3XLuHrNrcTxmUftww/qYRX8Z
         fHouUiA0lMKU/f3w2CVKdvTD8zlzBJqvOUkvrKkR63pQg0vEtMMFa9ZFQZZ39Si/la
         I7KL48MLZsk/xD06H7UFUF8Od0wvVHgdo/R9TLnw756ADasihyMgFFPkNVoTU/qqUc
         4SNunSOste4SQ==
Date:   Sun, 27 Mar 2022 16:10:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     <alexandru.tachici@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] iio: adc: ad_sigma_delta: Add sequencer support
Message-ID: <20220327161035.77427c93@jic23-huawei>
In-Reply-To: <20220322213002.00004ca2@Huawei.com>
References: <20220322105029.86389-1-alexandru.tachici@analog.com>
        <20220322213002.00004ca2@Huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Tue, 22 Mar 2022 21:30:02 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 22 Mar 2022 12:50:23 +0200
> <alexandru.tachici@analog.com> wrote:
> 
> > From: Alexandru Tachici <alexandru.tachici@analog.com>  
> 
> Hi Alexandru,
> 
> I just took another look at this and I'm happy with it.
> Will leave it on list for a few more days for others to
> take a look though before I queue it up.
> 
Applied to the togreg branch of iio.git though I won't push
that out, other than as testing, until I can rebase on rc1.

Thanks,

Jonathan
 
> Thanks,
> 
> Jonathan
> 
> > 
> > Some sigma-delta chips support sampling of multiple
> > channels in continuous mode.
> > 
> > When the operating with more than one channel enabled,
> > the channel sequencer cycles through the enabled channels
> > in sequential order, from first channel to the last one.
> > If a channel is disabled, it is skipped by the sequencer.
> > 
> > If more than one channel is used in continuous mode,
> > instruct the device to append the status to the SPI transfer
> > (1 extra byte) every time we receive a sample.
> > All sigma-delta chips possessing a sampling sequencer have
> > this ability. Inside the status register there will be
> > the number of the converted channel. In this way, even
> > if the CPU won't keep up with the sampling rate, it won't
> > send to userspace wrong channel samples.
> > 
> > 1. Removed the 1 byte .shift from channel spec in AD7124,
> > it confuses userspace apps (no need to shift right).
> > 
> > 2. Add update_scan_mode to AD7124, it is required in order
> > to enable/disable multiple channels at once
> > 
> > 3. Add update_scan_mode to AD7192, it is required in order
> > to enable/disable multiple channels at once
> > 
> > 4. Add sequencer support for sigma_delta library.
> > 
> > 5. Add sigma_delta_info values and callbacks for sequencer
> > support in AD7124.
> > 
> > 6. Add sigma_delta_info values and callbacks for sequencer
> > support in AD7192.
> > 
> > Alexandru Tachici (5):
> >   iio: adc: ad7124: Remove shift from scan_type
> >   iio: adc: ad7124: Add update_scan_mode
> >   iio: adc: ad7192: Add update_scan_mode
> >   iio: adc: ad7124: add sequencer support
> >   iio: adc: ad7192: add sequencer support
> > 
> > Lars-Peter Clausen (1):
> >   iio: adc: ad_sigma_delta: Add sequencer support
> > 
> > Changelog V2 -> V3:
> >   - ad_sd_buffer_postenable(), aligned (slot * storagebits) to 8 bytes
> >   - devm_krealloc instead of krealloc for samples_buf in ad_sd_buffer_postenable()
> >   - in ad_sigma_delta_append_status, check return value before setting .status_appended
> >   - iio: adc: ad_sigma_delta: Add sequencer support: added explanations on
> >   desynchronization checking and recovery
> >   - in ad7124_append_status() modify st->adc_control after write has taken place without errors
> >   - in ad7124_update_scan_mode() take cfg mutex only once instead of every time a
> >   set_channel happens
> >   - in ad7192_disable_all() modify st->conf after write taken place without errors
> >   - in ad7192_append_status() modify st->mode after write taken place without errors
> > 
> >  drivers/iio/adc/ad7124.c               |  86 ++++++++++++++-
> >  drivers/iio/adc/ad7192.c               |  64 ++++++++++-
> >  drivers/iio/adc/ad_sigma_delta.c       | 143 +++++++++++++++++++++++--
> >  include/linux/iio/adc/ad_sigma_delta.h |  38 +++++++
> >  4 files changed, 315 insertions(+), 16 deletions(-)
> > 
> > --
> > 2.25.1  
> 

