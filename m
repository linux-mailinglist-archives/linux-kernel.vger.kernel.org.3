Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E52513523
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347169AbiD1NdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiD1NdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:33:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7CAC91B;
        Thu, 28 Apr 2022 06:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22F8A60DF0;
        Thu, 28 Apr 2022 13:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35295C385A0;
        Thu, 28 Apr 2022 13:30:01 +0000 (UTC)
Date:   Thu, 28 Apr 2022 09:29:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCHv13 9/9] soc: qcom: geni: Disable MMIO tracing for GENI
 SE
Message-ID: <20220428092959.175b48ae@gandalf.local.home>
In-Reply-To: <3b2fb1e02f7a9836b2388b9f2ce2184c5a0cd444.1651149615.git.quic_saipraka@quicinc.com>
References: <cover.1651149615.git.quic_saipraka@quicinc.com>
        <3b2fb1e02f7a9836b2388b9f2ce2184c5a0cd444.1651149615.git.quic_saipraka@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 18:14:12 +0530
Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:

> Disable MMIO tracing for geni serial engine driver as it is a
> high frequency operation with many register reads/writes and
> not very useful to log all MMIO traces and prevent excessive
> logging.

This states what it does but does not really state why. Are you using MMIO
tracing in other locations and this is causing too much noise?

What is the real issue. Just saying "excessive logging" is not sufficient.
That would be a reason to disable function tracing ;-)

-- Steve


> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 28a8c0dda66c..a0ceeede450f 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>  
> +/* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
> +#define __DISABLE_TRACE_MMIO__
> +
>  #include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/slab.h>

