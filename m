Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646775101FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352384AbiDZPin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348330AbiDZPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:38:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0966B879
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:35:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B0623A;
        Tue, 26 Apr 2022 08:35:32 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 343163F73B;
        Tue, 26 Apr 2022 08:35:31 -0700 (PDT)
Date:   Tue, 26 Apr 2022 16:35:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 02/22] firmware: arm_scmi: Make protocols init fail on
 basic errors
Message-ID: <20220426153528.bhskpchq2huhjtjk@bogus>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330150551.2573938-3-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:05:31PM +0100, Cristian Marussi wrote:
> Bail out of protocol initialization routine early when basic information
> about protocol version and attributes could not be retrieved: failing to
> act this way can lead to a successfully initialized SCMI protocol which
> is in fact not fully functional.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/base.c    |  5 ++++-
>  drivers/firmware/arm_scmi/clock.c   |  8 ++++++--
>  drivers/firmware/arm_scmi/perf.c    | 10 +++++++---
>  drivers/firmware/arm_scmi/power.c   | 10 +++++++---
>  drivers/firmware/arm_scmi/reset.c   | 10 +++++++---
>  drivers/firmware/arm_scmi/sensors.c |  4 +++-
>  drivers/firmware/arm_scmi/system.c  |  5 ++++-
>  7 files changed, 38 insertions(+), 14 deletions(-)
>
> @@ -370,7 +372,9 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
>  	if (!cinfo)
>  		return -ENOMEM;
>
> -	scmi_clock_protocol_attributes_get(ph, cinfo);
> +	ret = scmi_clock_protocol_attributes_get(ph, cinfo);
> +	if (ret)
> +		return ret;

Does this result in removal of scmi_dev associated with devm_* calls ?
Otherwise we may need to free the allocated buffers ? I am not sure
if the dev here is individual scmi_dev or the platform scmi device.
I assume latter and it is unlikely to be removed/freed with the error in
the above path.

Similarly in couple of other instances/protocols.

--
Regards,
Sudeep
