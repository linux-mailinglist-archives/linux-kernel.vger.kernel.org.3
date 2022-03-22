Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFA4E484A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiCVVbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiCVVbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:31:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A69659381;
        Tue, 22 Mar 2022 14:30:08 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNPj61Gs0z687SH;
        Wed, 23 Mar 2022 05:27:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 22 Mar 2022 22:30:05 +0100
Received: from localhost (10.47.75.191) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 21:30:04 +0000
Date:   Tue, 22 Mar 2022 21:30:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alexandru.tachici@analog.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>
Subject: Re: [PATCH v3 0/6] iio: adc: ad_sigma_delta: Add sequencer support
Message-ID: <20220322213002.00004ca2@Huawei.com>
In-Reply-To: <20220322105029.86389-1-alexandru.tachici@analog.com>
References: <20220322105029.86389-1-alexandru.tachici@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.191]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 12:50:23 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>

Hi Alexandru,

I just took another look at this and I'm happy with it.
Will leave it on list for a few more days for others to
take a look though before I queue it up.

Thanks,

Jonathan

> 
> Some sigma-delta chips support sampling of multiple
> channels in continuous mode.
> 
> When the operating with more than one channel enabled,
> the channel sequencer cycles through the enabled channels
> in sequential order, from first channel to the last one.
> If a channel is disabled, it is skipped by the sequencer.
> 
> If more than one channel is used in continuous mode,
> instruct the device to append the status to the SPI transfer
> (1 extra byte) every time we receive a sample.
> All sigma-delta chips possessing a sampling sequencer have
> this ability. Inside the status register there will be
> the number of the converted channel. In this way, even
> if the CPU won't keep up with the sampling rate, it won't
> send to userspace wrong channel samples.
> 
> 1. Removed the 1 byte .shift from channel spec in AD7124,
> it confuses userspace apps (no need to shift right).
> 
> 2. Add update_scan_mode to AD7124, it is required in order
> to enable/disable multiple channels at once
> 
> 3. Add update_scan_mode to AD7192, it is required in order
> to enable/disable multiple channels at once
> 
> 4. Add sequencer support for sigma_delta library.
> 
> 5. Add sigma_delta_info values and callbacks for sequencer
> support in AD7124.
> 
> 6. Add sigma_delta_info values and callbacks for sequencer
> support in AD7192.
> 
> Alexandru Tachici (5):
>   iio: adc: ad7124: Remove shift from scan_type
>   iio: adc: ad7124: Add update_scan_mode
>   iio: adc: ad7192: Add update_scan_mode
>   iio: adc: ad7124: add sequencer support
>   iio: adc: ad7192: add sequencer support
> 
> Lars-Peter Clausen (1):
>   iio: adc: ad_sigma_delta: Add sequencer support
> 
> Changelog V2 -> V3:
>   - ad_sd_buffer_postenable(), aligned (slot * storagebits) to 8 bytes
>   - devm_krealloc instead of krealloc for samples_buf in ad_sd_buffer_postenable()
>   - in ad_sigma_delta_append_status, check return value before setting .status_appended
>   - iio: adc: ad_sigma_delta: Add sequencer support: added explanations on
>   desynchronization checking and recovery
>   - in ad7124_append_status() modify st->adc_control after write has taken place without errors
>   - in ad7124_update_scan_mode() take cfg mutex only once instead of every time a
>   set_channel happens
>   - in ad7192_disable_all() modify st->conf after write taken place without errors
>   - in ad7192_append_status() modify st->mode after write taken place without errors
> 
>  drivers/iio/adc/ad7124.c               |  86 ++++++++++++++-
>  drivers/iio/adc/ad7192.c               |  64 ++++++++++-
>  drivers/iio/adc/ad_sigma_delta.c       | 143 +++++++++++++++++++++++--
>  include/linux/iio/adc/ad_sigma_delta.h |  38 +++++++
>  4 files changed, 315 insertions(+), 16 deletions(-)
> 
> --
> 2.25.1

