Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E8151319C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbiD1Kxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiD1Kxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B261AD8C;
        Thu, 28 Apr 2022 03:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0CF061E7B;
        Thu, 28 Apr 2022 10:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393A5C385A9;
        Thu, 28 Apr 2022 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651143022;
        bh=F8pll2L1NRF/wbb47dvFuHRxvVRWhslxfz73G6ce3bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2ra8+BGeyS3+ko4UKKDgnKQgZofYFx78EBpNdemiGmvXPNYyl6ZfvzTBiUeT3dvU
         2Hd0/n6iQwQJVjdQ4DscTKQg5rVIILkxKNHpJK426fJrTY+lEHONfybX+MNDIIM50O
         m0O/uVKOLU8yoViJGGhwZo/aYzyqSosKSfOHbfCs=
Date:   Thu, 28 Apr 2022 12:50:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
        will@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCHv12 8/9] serial: qcom_geni_serial: Disable MMIO tracing
 for geni serial
Message-ID: <Ympxa0ZY0VxZGEjA@kroah.com>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
 <3fef68a94e4947d58a199709929d30e0e2bf2e44.1651139070.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fef68a94e4947d58a199709929d30e0e2bf2e44.1651139070.git.quic_saipraka@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:25:31PM +0530, Sai Prakash Ranjan wrote:
> Disable MMIO tracing for geni serial driver as it is a high
> frequency operation for serial driver with many register reads/
> writes and not very useful to log all MMIO traces and prevent
> excessive logging.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 1543a6028856..5b48e6c2bf3c 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1,5 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */

I strongly disagree that adding a single line here warrants a copyright
update.  If your lawyers will sign off on this change, I am willing to
reconsider.


> +
> +/* Disable MMIO tracing */

Please say why in the comment, not just what.

thanks,

greg k-h
