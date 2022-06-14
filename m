Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA0C54AE86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbiFNKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355778AbiFNKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E247ACC;
        Tue, 14 Jun 2022 03:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B938A60EAA;
        Tue, 14 Jun 2022 10:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC191C3411B;
        Tue, 14 Jun 2022 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655202805;
        bh=ACx3upsZaaL84t/hdNR790ZYbJczEEwd+6WWrOK0Up4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ulIOCLnXY/qzFR/iAkuSG8Rs/itqDHhek3LgPCMHtwEn57aMoZElelMjzqID8LBv7
         t22yqFN4/yCDG/hzRWC28tu+c2sCdcVM21+BeliXO1dDOAhbV5OLOKP0Y/Vvz0nXxw
         H1T0TMGWOmLzFCspFfYNIRSy6A7lZ/Qv4rQR8O8vVqfsDQX3VZNn0/w0ACBLccR0bn
         HawitHBEW0vl4ileoXil8chNZIxn138HOAVFxMMqTiRp5hrWNSNEBWjmDAFf38HZOt
         dQFOY0eWcSPXLjxnLvRvtnzGJKX9dOshv2qOEjeL6RaSDoXVwVxNHz2jpCXOs3K32z
         hrkSJFUaumsPQ==
Date:   Tue, 14 Jun 2022 11:42:34 +0100
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
Message-ID: <20220614114234.7e9dd1ac@jic23-huawei>
In-Reply-To: <20220501182829.1edc181f@jic23-huawei>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
        <20220429220904.137297-3-caleb.connolly@linaro.org>
        <20220501182829.1edc181f@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2022 18:28:29 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 29 Apr 2022 23:08:57 +0100
> Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
> > Some PMIC functions such as the RRADC need to be aware of the PMIC
> > chip revision information to implement errata or otherwise adjust
> > behaviour, export the PMIC information to enable this.
> > 
> > This is specifically required to enable the RRADC to adjust
> > coefficients based on which chip fab the PMIC was produced in,
> > this can vary per unique device and therefore has to be read at
> > runtime.
> > 
> > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>  
> 
> ...
> 
> > +/**
> > + * qcom_pmic_get() - Get a pointer to the base PMIC device
> > + *
> > + * This function takes a struct device for a driver which is a child of a PMIC.
> > + * And locates the PMIC revision information for it.
> > + *
> > + * @dev: the pmic function device
> > + * @return: the struct qcom_spmi_pmic* pointer associated with the function device
> > + */
> > +inline const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev)
> > +{
> > +	struct spmi_device *sdev;
> > +	struct qcom_spmi_dev *spmi;
> > +
> > +	/*
> > +	 * Make sure the device is actually a child of a PMIC
> > +	 */
> > +	if (!of_match_device(pmic_spmi_id_table, dev->parent))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	sdev = qcom_pmic_get_base_usid(dev->parent);
> >  
> > -	if (subtype == PM8110_SUBTYPE)
> > -		minor = rev2;
> > +	if (IS_ERR(sdev))
> > +		return ERR_CAST(sdev);
> >  
> > -	dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
> > +	spmi = (struct qcom_spmi_dev *)dev_get_drvdata(&sdev->dev);  
> 
> Shouldn't need the cast as dev_get_drvdata() returns void * and you can
> implicitly cast that to any other pointer type.
> 
> If this is all that comes up in the series I can fixup whilst applying.
> 
> Jonathan

Hi Caleb,

Now Stephen has acked the spmi changes, only remaining ack needed
is Lee for mfd.  Given it's been a while, perhaps best bet is if you
do a v15 just wrapping up those minor tweaks and ping Lee to take a
look at it when he has time.  On off chance Lee just want's to pick it
up and push out an immutable branch (rather than me doing the same,
I'll give tags for the IIO effecting bits)

Thanks,

Jonathan

> 
> 
> > +
> > +	return &spmi->pmic;
> >  }
> > +EXPORT_SYMBOL(qcom_pmic_get);
> >    
> 

