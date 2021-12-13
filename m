Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC96C472AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhLMLG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:06:28 -0500
Received: from foss.arm.com ([217.140.110.172]:51752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhLMLG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:06:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEC826D;
        Mon, 13 Dec 2021 03:06:25 -0800 (PST)
Received: from bogus (unknown [10.57.33.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 656AE3F793;
        Mon, 13 Dec 2021 03:06:24 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:06:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v7 02/16] firmware: arm_scmi: Set polling timeout to
 max_rx_timeout_ms
Message-ID: <20211213110621.ipflrpex7ncympo3@bogus>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129191156.29322-3-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:11:42PM +0000, Cristian Marussi wrote:
> Use transport specific transmission timeout (max_rx_timeout_ms) also for
> polling transactions.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 3cf161f3bcc7..568562121f64 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -724,8 +724,6 @@ static void xfer_put(const struct scmi_protocol_handle *ph,
>  	__scmi_xfer_put(&info->tx_minfo, xfer);
>  }
>  
> -#define SCMI_MAX_POLL_TO_NS	(100 * NSEC_PER_USEC)
> -

While there are no users of SCMI polling now in sched context, it was added
and the choice of 100uS was that it was called in sched context. I will update
this and merge patches 1-5 as they are ready to go.

-- 
Regards,
Sudeep
