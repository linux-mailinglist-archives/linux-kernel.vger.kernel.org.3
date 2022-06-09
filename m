Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38015452A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbiFIRHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbiFIRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CC2E8BBC;
        Thu,  9 Jun 2022 10:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4168561A36;
        Thu,  9 Jun 2022 17:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5366EC341C0;
        Thu,  9 Jun 2022 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654794455;
        bh=ee5TZiNlW7vDizss9nf0y5vrWyHbm4ptXDn+z57/BXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3E+ZiKDLvoyP4DzfdYnYL4itaZqOWEFERshly86nHvB4ktXSUT4zhtfL6P+BTW9f
         6NrIeIdNoVr6SwR6YizswrCvZKS9i0iXZbEryoHZRbNk3vIY4bNvydAZCJJWz8ip27
         L5wTeHmr+I6amg2hyzkrvV9OHZvXgc8JnKyqhMVOw9BfW9Ikd0HiMCW3vYSqeFY2PA
         LNBZyn3Z8TSi5t910HFskQ8Zpt5iUA+56jT8zYSUBgne/SY055KskmPEBNZB0w54GY
         WVrmttEz60MLOpuFp7hMLzq5nFxJQyNJUvBP8kVeAUXA/hnrY4k6fbwfaUioqqoEEL
         SlQEyMY65XtgA==
Date:   Thu, 9 Jun 2022 22:37:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] mtd: nand: raw: qcom_nandc: reorder
 qcom_nand_host struct
Message-ID: <20220609170722.GA5081@thinkpad>
References: <20220609132344.17548-1-ansuelsmth@gmail.com>
 <20220609132344.17548-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609132344.17548-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:23:42PM +0200, Ansuel Smith wrote:
> Reorder qcom_nand_host to save holes in the struct.

You forgot to reorder other structs also as I requested :/

Thanks,
Mani

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 1a77542c6d67..7fbbd3e7784c 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -431,11 +431,12 @@ struct qcom_nand_controller {
>   *				and reserved bytes
>   * @cw_data:			the number of bytes within a codeword protected
>   *				by ECC
> + * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
> + *				chip
> + *
>   * @use_ecc:			request the controller to use ECC for the
>   *				upcoming read/write
>   * @bch_enabled:		flag to tell whether BCH ECC mode is used
> - * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
> - *				chip
>   * @status:			value to be returned if NAND_CMD_STATUS command
>   *				is executed
>   * @last_command:		keeps track of last command on this chip. used
> @@ -452,11 +453,12 @@ struct qcom_nand_host {
>  	int cs;
>  	int cw_size;
>  	int cw_data;
> -	bool use_ecc;
> -	bool bch_enabled;
>  	int ecc_bytes_hw;
>  	int spare_bytes;
>  	int bbm_size;
> +
> +	bool use_ecc;
> +	bool bch_enabled;
>  	u8 status;
>  	int last_command;
>  
> -- 
> 2.36.1
> 

-- 
மணிவண்ணன் சதாசிவம்
