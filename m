Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93AE516698
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353025AbiEARYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352805AbiEARXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:23:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE7E614E;
        Sun,  1 May 2022 10:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5377A60F55;
        Sun,  1 May 2022 17:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8364DC385B0;
        Sun,  1 May 2022 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651425616;
        bh=tHHxRDQDtWRjj5+yflIBb+axcnk5v0Qd22de8ghVlbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mIQJGI+scSXSB7jbTDKA+XP5efWhavRxTmsYxijmpkMDUhQQNLlwMF/ZZuNl2dq2j
         bFLkg+1hnJXjFvLRlL1UM5A/eljwuz7wKoYqi2TVde33gGC/SF0Leq13qLnpKbllQZ
         /kuDeBnMFXcQuvhve+t/eP4pizEnB9Z9WFg+bGwTLwwWMQbSYs7SBHLTswVz+GUkqx
         JG8jHHN6tsqiNDHk2g2KNbMEq8SuZqLefoBPpf99XZtPrAVDa2rvuaJUmwdnT+/2Ll
         9XVeElLkssH0QKWLk6Mob0jj7gBh3DRB6Wp2nR6v2f4PdrVMbB8E5dq7/jkyzRxUm/
         78tUH/1KLR3QQ==
Date:   Sun, 1 May 2022 18:28:29 +0100
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
Message-ID: <20220501182829.1edc181f@jic23-huawei>
In-Reply-To: <20220429220904.137297-3-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
        <20220429220904.137297-3-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

...

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

Shouldn't need the cast as dev_get_drvdata() returns void * and you can
implicitly cast that to any other pointer type.

If this is all that comes up in the series I can fixup whilst applying.

Jonathan


> +
> +	return &spmi->pmic;
>  }
> +EXPORT_SYMBOL(qcom_pmic_get);
>  

