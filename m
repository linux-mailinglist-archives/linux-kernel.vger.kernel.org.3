Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8F3477A05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbhLPRJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhLPRJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:09:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA3C061574;
        Thu, 16 Dec 2021 09:09:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DEABB82365;
        Thu, 16 Dec 2021 17:09:42 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 51364C36AE4;
        Thu, 16 Dec 2021 17:09:39 +0000 (UTC)
Date:   Thu, 16 Dec 2021 17:15:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] Documentation:ABI:testing:admv1013: add ABI docs
Message-ID: <20211216171504.382214ee@jic23-huawei>
In-Reply-To: <20211206154845.268445-3-antoniu.miclaus@analog.com>
References: <20211206154845.268445-1-antoniu.miclaus@analog.com>
        <20211206154845.268445-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 17:48:45 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the use of the Local Oscillator Feedthrough Offset
> calibration.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6:
>  - update iio channels
>  - remove frequency mode
>  .../testing/sysfs-bus-iio-frequency-admv1013  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> new file mode 100644
> index 000000000000..3be68dd54ed4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> @@ -0,0 +1,38 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_i_phase

> +KernelVersion:

Please fill these in. We might need to update them, but better to be out by one cycle
rather than have them blank I think.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the Local Oscillatior path quadrature I phase shift.

As per patch 1 review.  The open issue here is phase has defined units as radians
but we don't know what the scaling of this is beyond vague hints in the datasheet.
So maybe we need to expand the ABI to allow for calibphase?  Much like calibbias in
general we'd assume that was of unknown scaling...

I'm fully open to other suggestions as I'm not particularly happy with any options
I've thought of for this.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_i_phase
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the Local Oscillatior path quadrature Q phase shift.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibbias
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the Local Oscillatior Feedthrough Offset Calibration I Positive
> +		side.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibbias
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the Local Oscillatior Feedthrough Offset Calibration Q Positive side.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_i_calibbias
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Negative
> +		side.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_q_calibbias
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Negative
> +		side.

