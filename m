Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC77568899
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiGFMpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiGFMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:45:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C4D21805
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:45:27 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdK2C1C13z6H7nW;
        Wed,  6 Jul 2022 20:42:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 6 Jul 2022 14:45:25 +0200
Received: from localhost (10.206.134.24) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Jul
 2022 13:45:24 +0100
Date:   Wed, 6 Jul 2022 13:45:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: drivers/iio/adc/ad7476.c:29:8: warning: Excessive padding in
 'struct ad7476_chip_info' (10 padding bytes, where 2 is optimal). Optimal
 fields order: reset, channel, convst_channel, int_vref_uv, has_vref,
 has_vdrive, consider reordering the fields or addin...
Message-ID: <20220706134523.00000555@Huawei.com>
In-Reply-To: <202207060054.o8GrfMhS-lkp@intel.com>
References: <202207060054.o8GrfMhS-lkp@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.206.134.24]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>    Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
>    21 warnings generated.
> >> drivers/iio/adc/ad7476.c:29:8: warning: Excessive padding in 'struct ad7476_chip_info' (10 padding bytes, where 2 is optimal). Optimal fields order: reset, channel, convst_channel, int_vref_uv, has_vref, has_vdrive, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]  
>    struct ad7476_chip_info {
>    ~~~~~~~^~~~~~~~~~~~~~~~~~
>    drivers/iio/adc/ad7476.c:29:8: note: Excessive padding in 'struct ad7476_chip_info' (10 padding bytes, where 2 is optimal). Optimal fields order: reset, channel, convst_channel, int_vref_uv, has_vref, has_vdrive, consider reordering the fields or adding explicit padding members
>    struct ad7476_chip_info {
>    ~~~~~~~^~~~~~~~~~~~~~~~~~
> >> drivers/iio/adc/ad7476.c:39:8: warning: Excessive padding in 'struct ad7476_state' (472 padding bytes, where 216 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]  
>    struct ad7476_state {

For this one and I'm guessing some of the other IIO cases, if there is any way to suppress the warning where we have specific
alignments specified then that would be great. These are padded to ensure the buffers are DMA safe.

Thanks,

Jonathan


>    ~~~~~~~^~~~~~~~~~~~~~
>    drivers/iio/adc/ad7476.c:39:8: note: Excessive padding in 'struct ad7476_state' (472 padding bytes, where 216 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members
>    struct ad7476_state {
>    ~~~~~~~^~~~~~~~~~~~~~
>    Suppressed 19 warnings (7 in non-user code, 12 with check filters).
>    Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
>    20 warnings generated.
>    drivers/iio/adc/ad7766.c:35:8: warning: Excessive padding in 'struct ad7766' (392 padding bytes, where 136 is optimal). Optimal fields order: data, chip_info, spi, mclk, pd_gpio, trig, reg, msg, xfer, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
>    struct ad7766 {
>    ~~~~~~~^~~~~~~~
>    drivers/iio/adc/ad7766.c:35:8: note: Excessive padding in 'struct ad7766' (392 padding bytes, where 136 is optimal). Optimal fields order: data, chip_info, spi, mclk, pd_gpio, trig, reg, msg, xfer, consider reordering the fields or adding explicit padding members
>    struct ad7766 {
>    ~~~~~~~^~~~~~~~
>    Suppressed 19 warnings (7 in non-user code, 12 with check filters).
>    Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
>    20 warnings generated.
>    drivers/iio/adc/ad7768-1.c:154:8: warning: Excessive padding in 'struct ad7768_state' (388 padding bytes, where 132 is optimal). Optimal fields order: data, mclk_freq, spi, vref, mclk, trig, gpio_sync_in, labels, lock, completion, samp_freq, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
>    struct ad7768_state {
>    ~~~~~~~^~~~~~~~~~~~~~
>    drivers/iio/adc/ad7768-1.c:154:8: note: Excessive padding in 'struct ad7768_state' (388 padding bytes, where 132 is optimal). Optimal fields order: data, mclk_freq, spi, vref, mclk, trig, gpio_sync_in, labels, lock, completion, samp_freq, consider reordering the fields or adding explicit padding members
>    struct ad7768_state {
>    ~~~~~~~^~~~~~~~~~~~~~
