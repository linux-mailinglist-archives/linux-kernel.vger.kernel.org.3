Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803FC4A4803
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378711AbiAaNY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349080AbiAaNYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:24:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7422DC061714;
        Mon, 31 Jan 2022 05:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gLpx9hy/oiTEly0zb70xuTv8+vbtKCxmHi4U36k1x0I=; b=VhFXysylwTUhplXWCWTvvNJTfw
        wNNPEko4h4jazxU2xoTkBfinjKWRend9jxNmttkHXb7NNR8+Qp9FuUzlBWxR7HxaeiB9KoWWQG5Cy
        TcF9W8RkRcQGIEJkVtY+V4tIUFTAYroBqLhiHQRcRRiORQ2g83hdFUVfYpIakJNSTt5mBTZ+rz+KI
        n+iAjZRlRUHBg8ucSU/k0YEwH2qnciKsdps63WU4pTUdOGTrnySLHSHa6Hqe4bu8TBobo0mtx6saM
        KmBEFq+1VAVmfEYuJwgXZzVeDuEYEQLRWHolLzGBhtOUlF4RT06YYSN3iMqv7gwq+pXGhnEeZLHk+
        4YnjY/bw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEWfU-009tds-5Z; Mon, 31 Jan 2022 13:24:28 +0000
Message-ID: <747b437d-6d7d-e35f-c7e8-79f81ad2e691@infradead.org>
Date:   Mon, 31 Jan 2022 05:24:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] staging: media: atomisp: Use BIT macro instead of left
 shifting
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        kitakar@gmail.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, tomi.valkeinen@ideasonboard.com,
        joe@perches.com
References: <YfVstOJ38OTtd43n@smile.fi.intel.com>
 <20220130180655.22970-1-mosescb.dev@gmail.com> <20220131073624.GH1951@kadam>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220131073624.GH1951@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/22 23:36, Dan Carpenter wrote:
> On Sun, Jan 30, 2022 at 07:06:55PM +0100, Moses Christopher Bollavarapu wrote:
>> There is a BIT(nr) macro available in Linux Kernel,
>> which does the same thing.
>> Example: BIT(7) = (1UL << 7)
>>
>> Also use GENMASK for masking
>> Example: GENMASK(3, 0) = 0b00001111 (same as (1 << 4) - 1)
>>
>> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> 

>> diff --git a/drivers/staging/media/atomisp/pci/ia_css_env.h b/drivers/staging/media/atomisp/pci/ia_css_env.h
>> index 3b89bbd837a0..b9ebc14441a1 100644
>> --- a/drivers/staging/media/atomisp/pci/ia_css_env.h
>> +++ b/drivers/staging/media/atomisp/pci/ia_css_env.h
>> @@ -18,6 +18,7 @@
>>  
>>  #include <type_support.h>
>>  #include <linux/stdarg.h> /* va_list */
>> +#include <linux/bits.h> /* BIT(nr) */
> 
> This comment is not required.
> 
>>  enum ia_css_rx_irq_info {
>> -	IA_CSS_RX_IRQ_INFO_BUFFER_OVERRUN   = 1U << 0, /** buffer overrun */
>> -	IA_CSS_RX_IRQ_INFO_ENTER_SLEEP_MODE = 1U << 1, /** entering sleep mode */
>> -	IA_CSS_RX_IRQ_INFO_EXIT_SLEEP_MODE  = 1U << 2, /** exited sleep mode */
>> -	IA_CSS_RX_IRQ_INFO_ECC_CORRECTED    = 1U << 3, /** ECC corrected */
>> -	IA_CSS_RX_IRQ_INFO_ERR_SOT          = 1U << 4,
>> +	IA_CSS_RX_IRQ_INFO_BUFFER_OVERRUN   = BIT(0), /** buffer overrun */
>> +	IA_CSS_RX_IRQ_INFO_ENTER_SLEEP_MODE = BIT(1), /** entering sleep mode */
>> +	IA_CSS_RX_IRQ_INFO_EXIT_SLEEP_MODE  = BIT(2), /** exited sleep mode */
>> +	IA_CSS_RX_IRQ_INFO_ECC_CORRECTED    = BIT(3), /** ECC corrected */
>> +	IA_CSS_RX_IRQ_INFO_ERR_SOT          = BIT(4),
>>  	/** Start of transmission */
>> -	IA_CSS_RX_IRQ_INFO_ERR_SOT_SYNC     = 1U << 5, /** SOT sync (??) */
>> -	IA_CSS_RX_IRQ_INFO_ERR_CONTROL      = 1U << 6, /** Control (??) */
>> -	IA_CSS_RX_IRQ_INFO_ERR_ECC_DOUBLE   = 1U << 7, /** Double ECC */
>> -	IA_CSS_RX_IRQ_INFO_ERR_CRC          = 1U << 8, /** CRC error */
>> -	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ID   = 1U << 9, /** Unknown ID */
>> -	IA_CSS_RX_IRQ_INFO_ERR_FRAME_SYNC   = 1U << 10,/** Frame sync error */
>> -	IA_CSS_RX_IRQ_INFO_ERR_FRAME_DATA   = 1U << 11,/** Frame data error */
>> -	IA_CSS_RX_IRQ_INFO_ERR_DATA_TIMEOUT = 1U << 12,/** Timeout occurred */
>> -	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ESC  = 1U << 13,/** Unknown escape seq. */
>> -	IA_CSS_RX_IRQ_INFO_ERR_LINE_SYNC    = 1U << 14,/** Line Sync error */
>> -	IA_CSS_RX_IRQ_INFO_INIT_TIMEOUT     = 1U << 15,
>> +	IA_CSS_RX_IRQ_INFO_ERR_SOT_SYNC     = BIT(5), /** SOT sync (??) */
>> +	IA_CSS_RX_IRQ_INFO_ERR_CONTROL      = BIT(6), /** Control (??) */
>> +	IA_CSS_RX_IRQ_INFO_ERR_ECC_DOUBLE   = BIT(7), /** Double ECC */
>> +	IA_CSS_RX_IRQ_INFO_ERR_CRC          = BIT(8), /** CRC error */
>> +	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ID   = BIT(9), /** Unknown ID */
>> +	IA_CSS_RX_IRQ_INFO_ERR_FRAME_SYNC   = BIT(10),/** Frame sync error */
>> +	IA_CSS_RX_IRQ_INFO_ERR_FRAME_DATA   = BIT(11),/** Frame data error */
>> +	IA_CSS_RX_IRQ_INFO_ERR_DATA_TIMEOUT = BIT(12),/** Timeout occurred */
>> +	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ESC  = BIT(13),/** Unknown escape seq. */
>> +	IA_CSS_RX_IRQ_INFO_ERR_LINE_SYNC    = BIT(14),/** Line Sync error */
> 
> The comment is kind of messed up.  There should be a space after the
> comma and just /* Line Sync error */

Yeah, all of those /** should just be /*

thanks.

-- 
~Randy
