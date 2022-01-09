Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689C5488B36
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiAIRdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiAIRdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:33:05 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8961EC06173F;
        Sun,  9 Jan 2022 09:33:05 -0800 (PST)
Received: from [81.101.6.87] (port=47180 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6c3x-0006sT-IU; Sun, 09 Jan 2022 17:33:01 +0000
Date:   Sun, 9 Jan 2022 17:38:53 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] Documentation:ABI:testing:admv1014: add ABI docs
Message-ID: <20220109173853.3f9192ec@jic23-huawei>
In-Reply-To: <20220103092201.21576-4-antoniu.miclaus@analog.com>
References: <20220103092201.21576-1-antoniu.miclaus@analog.com>
        <20220103092201.21576-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 11:22:01 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the use of the Digital Attenuator gain.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../testing/sysfs-bus-iio-frequency-admv1014  | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> new file mode 100644
> index 000000000000..385bf5b4b399
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> @@ -0,0 +1,23 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_gain_coarse
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_I) with coarse steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_gain_coarse
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_Q) with coarse steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_gain_fine
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_I) with fine steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_gain_fine
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_Q) with fine steps.

I guess it's horribly optimistic to wonder if these can be expressed as a single gain?

I'm going to guess no as they are basically 'twiddle' functions with frequency dependent
gain characteristics. 

My gut feeling is these are meant for for calibration tweaking so is calibbscale
as currently defined applicable?
"
		Hardware applied calibration scale factor (assumed to fix
		production inaccuracies).  If shared across all channels,
		<type>_calibscale is used.
"
you'd still need the fine and coarse postfix unfortunately.

A nice thing about calibscale is it's defined unit free as it's normally a tweak
on an input amplifier or similar.

Jonathan


