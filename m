Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602DF49EE29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiA0Wj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiA0WjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:39:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A69C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=huzZ2QGJecRKdg+K0K2zU9hS+JR+Iha4VJtCOeMYbS8=; b=Foa/egyURXw2P8f4N1yEOQT8B+
        ul7ZW1HG6YV1jkVrn3SbIFHNWCgDCezoff7JBJ+mnsiVvoATA1+OOKFs3c4ie3itT0Lymn4QbEEML
        ioqY8Euw0uKN2qzfZWMFt9MhrIJGYF8wSnURwaqBYM5IUSWZLNwGYCchmhSrDJZi+3KMUavl+b0cv
        akymDbu+Xq+slndmmfvkWBwUMWscJvIFB7SmBWSpTVphi2UDa6eJ4GaXWXBya8TM8+qyaGtxg6Rsi
        WeCyArwcxwLNnmvFT4Zkz89fyKfEWI5reB3XKY+NbC2ueWtAlg1VjZoClvwTe0UoTBWHFe5BfVfvC
        +7+SLjTw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDDQG-005jk6-Vm; Thu, 27 Jan 2022 22:39:21 +0000
Message-ID: <aa0b1b37-de0b-c859-5d9b-9de406c770b9@infradead.org>
Date:   Thu, 27 Jan 2022 14:39:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drivers/misc: add transfer ioctl for HPS
Content-Language: en-US
To:     =?UTF-8?B?U2FtaSBLecO2c3RpbMOk?= <skyostil@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dtor@chromium.org, evanbenn@chromium.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-3-skyostil@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220127083545.1020423-3-skyostil@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/22 00:35, Sami Kyöstilä wrote:
> This patch adds an ioctl operation for sending and receiving data from
> the ChromeOS snooping protection sensor (a.k.a., HPS). This allows
> userspace programs to perform a combined read/write I2C transaction
> through a single syscall.
> 
> The I2C wire protocol for the device is documented at:
> 
> https://chromium.googlesource.com/chromiumos/platform/hps-firmware/+/
> refs/heads/main/docs/host_device_i2c_protocol.md
> 
> Signed-off-by: Sami Kyöstilä <skyostil@chromium.org>
> ---
> 
>  MAINTAINERS              |  1 +
>  drivers/misc/hps-i2c.c   | 81 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/hps.h | 20 ++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 include/uapi/linux/hps.h
> 

Hi--

If your next patch version continues to use an ioctl, its magic "number"
('h') should be documented in Documentation/userspace-api/ioctl/ioctl-number.rst.

thanks.

> diff --git a/include/uapi/linux/hps.h b/include/uapi/linux/hps.h
> new file mode 100644
> index 000000000000..2c1bd174cd02
> --- /dev/null
> +++ b/include/uapi/linux/hps.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + *  Copyright 2022 Google LLC.
> + */
> +
> +#ifndef _UAPI_HPS_H
> +#define _UAPI_HPS_H
> +
> +#include <linux/types.h>
> +
> +#define HPS_IOC_TRANSFER	_IOWR('h', 0x01, struct hps_transfer_ioctl_data)
> +
> +struct hps_transfer_ioctl_data {
> +	__u32 isize;			/* Number of bytes to send */
> +	unsigned char __user *ibuf;	/* Input buffer */
> +	__u32 osize;			/* Number of bytes to receive */
> +	unsigned char __user *obuf;	/* Output buffer */
> +};
> +
> +#endif /* _UAPI_HPS_H */

-- 
~Randy
