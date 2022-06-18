Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2765D5504DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 14:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiFRMs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 08:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiFRMs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 08:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888721D1;
        Sat, 18 Jun 2022 05:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F2960B1F;
        Sat, 18 Jun 2022 12:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5A9C3411A;
        Sat, 18 Jun 2022 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655556534;
        bh=cex7iYQQACfKhOLJ8XVWX6jRVF4mEBzs7Qu/iRF1V2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dz1RsUTOigl7wW6tRhiN2uHxcm7YhUtlYbJDhXeWqF7H38ogejBbdoloxKtHrIJKL
         q8QdXQcH6rzPMD/UrPF7uAXT+DST2GkwKcW5B6n5rq3Dc6YsHZl/yyDfhEzPr3x1Qo
         NbToNg6XAip9XiGbgSGDtsZEv4lww3vaqemAnMIXBwL47mLDYKw04fidQ4zmw4nR5m
         wX3+26mh0e5QzvmqLWq7BkvzYGBduCj4YhkChVa7NpzKE6QmVkUMi0WDD7moEQz0xF
         Q86Vl2l4w4DV5QDgq1jI9+dQSrZt1W6+39uJH2G1ouLVOz48TCfF4UQGLcswBlbLDH
         ++JN4S+4qysRQ==
Date:   Sat, 18 Jun 2022 13:58:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v14 02/10] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <20220618135810.34f3df8f@jic23-huawei>
In-Reply-To: <20220429220904.137297-3-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
        <20220429220904.137297-3-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 23:08:57 +0100
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> Some PMIC functions such as the RRADC need to be aware of the PMIC
> chip revision information to implement errata or otherwise adjust
> behaviour, export the PMIC information to enable this.
> 
> This is specifically required to enable the RRADC to adjust
> coefficients based on which chip fab the PMIC was produced in,
> this can vary per unique device and therefore has to be read at
> runtime.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---


> +/**
> + * qcom_pmic_get() - Get a pointer to the base PMIC device
> + *
> + * This function takes a struct device for a driver which is a child of a PMIC.
> + * And locates the PMIC revision information for it.
> + *
> + * @dev: the pmic function device
> + * @return: the struct qcom_spmi_pmic* pointer associated with the function device
> + */
> +inline const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev)
Missed this in review, but build test of the rradc patch threw it up.
this should defintely not be inline as it's exported.
Same for the header definition.

I'm doing a quick test to see if I can apply this series with relevant
tweaks. Will get rid of this inline as well.

Thanks,

Jonathan

> +{
> +	struct spmi_device *sdev;
> +	struct qcom_spmi_dev *spmi;
> +
> +	/*
> +	 * Make sure the device is actually a child of a PMIC
> +	 */
> +	if (!of_match_device(pmic_spmi_id_table, dev->parent))
> +		return ERR_PTR(-EINVAL);
> +
> +	sdev = qcom_pmic_get_base_usid(dev->parent);
>  
> -	if (subtype == PM8110_SUBTYPE)
> -		minor = rev2;
> +	if (IS_ERR(sdev))
> +		return ERR_CAST(sdev);
>  
> -	dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
> +	spmi = (struct qcom_spmi_dev *)dev_get_drvdata(&sdev->dev);
> +
> +	return &spmi->pmic;
>  }
> +EXPORT_SYMBOL(qcom_pmic_get);
