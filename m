Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B31C513114
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiD1KQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiD1KQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:16:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E659B3C51
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:07:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4699D1477;
        Thu, 28 Apr 2022 03:07:37 -0700 (PDT)
Received: from bogus (unknown [10.57.11.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1E0D3F774;
        Thu, 28 Apr 2022 03:07:34 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:07:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 04/22] firmware: arm_scmi: Validate
 BASE_DISCOVER_LIST_PROTOCOLS reply
Message-ID: <20220428100729.qlzl5lkkn2r5u3ra@bogus>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330150551.2573938-5-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:05:33PM +0100, Cristian Marussi wrote:
> Do not blindly trust SCMI backend server reply about list of implemented
> protocols, instead validate the reported length of the list of protocols
> against the real payload size of the message reply.
>
> Fixes: b6f20ff8bd9 ("firmware: arm_scmi: add common infrastructure and support for base protocol")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/base.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index f279146f8110..c1165d1282ef 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
> @@ -189,6 +189,9 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
>  	list = t->rx.buf + sizeof(*num_ret);
>
>  	do {
> +		size_t real_list_sz;
> +		u32 calc_list_sz;
> +
>  		/* Set the number of protocols to be skipped/already read */
>  		*num_skip = cpu_to_le32(tot_num_ret);
>
> @@ -202,6 +205,24 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
>  			break;
>  		}
>
> +		if (t->rx.len < (sizeof(u32) * 2)) {
> +			dev_err(dev, "Truncated reply - rx.len:%zd\n",
> +				t->rx.len);
> +			ret = -EPROTO;
> +			break;
> +		}
> +
> +		real_list_sz = t->rx.len - sizeof(u32);
> +		calc_list_sz = ((loop_num_ret / sizeof(u32)) +
> +				!!(loop_num_ret % sizeof(u32))) * sizeof(u32);

Any reason this can't be (loop_num_ret - 1) / sizeof(u32) + 1 ?

--
Regards,
Sudeep
