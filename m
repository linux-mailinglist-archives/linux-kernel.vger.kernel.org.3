Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D9B5A56E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiH2WQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiH2WP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:15:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADD6B8D2;
        Mon, 29 Aug 2022 15:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16E00B81366;
        Mon, 29 Aug 2022 22:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03645C433C1;
        Mon, 29 Aug 2022 22:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661811353;
        bh=dpIHaDhHoFKo6/MX17tyLWkh2Hv4zXMxhNZYFsjlI8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/ro6VFr/E6qnli6n/2RvedLyGFJYeUxe/qF8oNM8LibI3OHdZtf6Av34FZw9iu8U
         /2bZ8AUNKcKTMHfsy7KVa541trWvPnJJlDOcMiXFMdfwT42MiDBqYlj2AyM8BScpHI
         V49MSgwMv7BAmctKPdl+y60x2joaN//KD0AGXastMO+3pjgQGAic+fP7IBCBCCxab4
         WCEiKsj4J/y5BxW312xEm5qgtzh+mG4g+/NlG9GEsjc9wafh4bOPWoV4Q8ZKToC1Ef
         WjZ+kKT4Wg7wA2812ToPp0Id5dat8vHPhf80HmTznNlNSOX5SAKWUq8+2OtT/Mq3EX
         qLQtQXsGibgWg==
Date:   Mon, 29 Aug 2022 17:15:51 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v3 1/4] firmware: qcom: scm: Add support for tsens reinit
 workaround
Message-ID: <20220829221551.uch6jdtaglzebu23@builder.lan>
References: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
 <20220804054638.3197294-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804054638.3197294-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 11:16:35AM +0530, Bhupesh Sharma wrote:
> Some versions of Qualcomm tsens controller might enter a
> 'bad state' while running stability tests causing sensor
> temperatures/interrupts status to be in an 'invalid' state.
> 
> It is recommended to re-initialize the tsens controller
> via trustzone (secure registers) using scm call(s) when that
> happens.
> 
> Add support for the same in the qcom_scm driver.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/firmware/qcom_scm.c | 15 +++++++++++++++
>  drivers/firmware/qcom_scm.h |  4 ++++
>  include/linux/qcom_scm.h    |  2 ++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cdbfe54c8146..93adcc046a62 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -858,6 +858,21 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>  }
>  EXPORT_SYMBOL(qcom_scm_mem_protect_video_var);
>  
> +int qcom_scm_tsens_reinit(void)
> +{
> +	int ret;
> +	const struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_TSENS,
> +		.cmd = QCOM_SCM_TSENS_INIT_ID,
> +	};
> +	struct qcom_scm_res res;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +
> +	return ret ? : res.result[0];
> +}
> +EXPORT_SYMBOL(qcom_scm_tsens_reinit);
> +
>  static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
>  				 size_t mem_sz, phys_addr_t src, size_t src_sz,
>  				 phys_addr_t dest, size_t dest_sz)
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index 0d51eef2472f..495fa00230c7 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -94,6 +94,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>  #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
>  #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
>  
> +/* TSENS Services and Function IDs */
> +#define QCOM_SCM_SVC_TSENS		0x1E

It would be nice if this 'E' was lowercase.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Thanks,
Bjorn

> +#define QCOM_SCM_TSENS_INIT_ID		0x5
> +
>  #define QCOM_SCM_SVC_IO			0x05
>  #define QCOM_SCM_IO_READ		0x01
>  #define QCOM_SCM_IO_WRITE		0x02
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index f8335644a01a..5c37e1658cef 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -124,4 +124,6 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  extern int qcom_scm_lmh_profile_change(u32 profile_id);
>  extern bool qcom_scm_lmh_dcvsh_available(void);
>  
> +extern int qcom_scm_tsens_reinit(void);
> +
>  #endif
> -- 
> 2.35.3
> 
