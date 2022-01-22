Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7085A496D1A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiAVRcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 12:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiAVRcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:32:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E565EC06173B;
        Sat, 22 Jan 2022 09:32:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F9460E04;
        Sat, 22 Jan 2022 17:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C475C004E1;
        Sat, 22 Jan 2022 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642872742;
        bh=hZL9e2fcveQw3TicWaRCiKPaKgmA1DgHicUzxI0Dw8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SUK51qchn793KaARg4Q+7kk2KNs2DmSuTfz+w9movpGRLUcrTziC1SB8j/tfQ6u3K
         CgHwpZ/7Ad0RBQBUPzLOnsVi8RPEUVB2Zsa+9QBpH24V2l4SWbSJqosDb9tEMDafxL
         6dbhNB98sx645C2XGXH/WzSqyf5KQiNAcCBHA/FWGG06wGWsjrAut82rYZ5fx/VFG3
         8xbiybKiVkd2+FriRm/iAO2wh1LYfhtnqw6GxNKerzuTbSIOgxl7yMNhlZjkc+g8l0
         wShNrheKPdaNS6XSgIpbGkMKvOufkZPIOKtvWrJLYgi5xWrBJbyHF4MfPsI8OXySok
         XpVvJEC5CxQcg==
Date:   Sat, 22 Jan 2022 17:38:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] Documentation:ABI:testing:admv1014: add ABI docs
Message-ID: <20220122173831.2d2c2b0d@jic23-huawei>
In-Reply-To: <20220119081838.70210-3-antoniu.miclaus@analog.com>
References: <20220119081838.70210-1-antoniu.miclaus@analog.com>
        <20220119081838.70210-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 10:18:37 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the use of the Digital Attenuator gain.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
One entry that should be in the generic docs rather than here.

Given the documentation generation scripts don't support multiple
entries for a given attribute name an that one is 'standard'
we should just add it to the main file as otherwise the chances
are very high of accidentally getting duplication when it
turns up in another driver ABI doc.

We may need to move some of the others later if they turn out
to occur in multiple drivers but they are obscure enough to
be fine in this file for now.

Thanks,

Jonathan

> ---
> changes in v3:
>  - add description for calibscale in I/Q mode
>  .../testing/sysfs-bus-iio-frequency-admv1014  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> new file mode 100644
> index 000000000000..77c1691e6910
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> @@ -0,0 +1,29 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_coarse
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_I) with coarse steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_coarse
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_Q) with coarse steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_fine
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_I) with fine steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_fine
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_Q) with fine steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale

This particular one is normal ABI, so should just be added to the list
in sysfs-bus-iio alongside all the other calibscale entries.


> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (I/Q).

