Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26327511B34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiD0OQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiD0OQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:16:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E392E532CD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:13:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q12so1537031pgj.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DhokFBZ8F+taIE1k9mg2zZtCYLVYVOeEuTezkpT79r0=;
        b=P3+JotLgiip8RxPVXYAXVXxK/wRp63a4Wo/GDeeUArGs0ys+6YbeQav72knUKSjSgG
         XMAWMCV+T7fbSun5DsZP6df1JmVvkUJAPmZNsMs1M7c5fBo06US16QTLJ7iqgKnfgTZe
         9G8GJJzxHyGGpNJi+WihEAk01SV57ERNAWrWJ5fEcVw2gzCLu5bNBz6ThMUDpck3b/hv
         JHmwNeUg+H6/4bBEt5l++B5tjifB3FMsjZDhG4aHNH9KFGJOAWVcXhsBVUBMgP1OSQcC
         2CQbs3h/RzvPILD7JMzwc9ggQ4jxbFRshk6tACwUSAKJuAIM+sHLdXce0zHTfY0E4XLT
         aI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DhokFBZ8F+taIE1k9mg2zZtCYLVYVOeEuTezkpT79r0=;
        b=d6ulsq4Ihabj+jLOYNdErZ+a2n8R3vfleM7iR567Kha1BUZfIEQ5UqYhf7mjQO+aDT
         ujplvfsNyBTU65d4zAGp345Y6vP760H8eYcGcUY5XnCPs9h+llqBkcGtVdJ/rOLNHEDK
         pO/kJTbJ+5AjXtKyZMpxM3ISNLO3EO/9Qh0q66JNBTi0VkMW/dIp0yJNh7jfJdykaRu6
         JhO31g3/GllVp3i9bZGKlnhC3aDye5ttcq/UqpqsL213+sw3DYXfi59TKT05YuPejQUd
         2U36uA/u4VnInqlm8Apzaybl+icdOoPip+gFnatSJvHASV8skmbsc7VINOLBTRzUA5FO
         7SeQ==
X-Gm-Message-State: AOAM530SxOOVx20ezJNGvz3p9cBcRdO7oMwPgs1mPDAax/0CmoHUhHIy
        E3IYTeWNKaVY3mKQMkhUA3KrFg==
X-Google-Smtp-Source: ABdhPJzwqnRqzlvetnWaWNh50u652unG7bmUQL7VOe8oZll9/mfsDqCxv7Fg9ArlskIvhhOuWvfmqA==
X-Received: by 2002:a63:18c:0:b0:3aa:d794:7c44 with SMTP id 134-20020a63018c000000b003aad7947c44mr21425027pgb.126.1651068794150;
        Wed, 27 Apr 2022 07:13:14 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id x129-20020a623187000000b0050835f6d6a1sm19002767pfx.9.2022.04.27.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:13:13 -0700 (PDT)
Date:   Wed, 27 Apr 2022 22:13:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] interconnect: qcom: Move
 qcom_icc_xlate_extended() to a common file
Message-ID: <20220427141305.GB560849@leoy-ThinkPad-X240s>
References: <20220416154013.1357444-1-leo.yan@linaro.org>
 <20220416154013.1357444-3-leo.yan@linaro.org>
 <e7a8ce84-3029-ea90-628b-1072bd49baf4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a8ce84-3029-ea90-628b-1072bd49baf4@linaro.org>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:00:24AM +0300, Dmitry Baryshkov wrote:
> On 16/04/2022 18:40, Leo Yan wrote:
> > since there have conflict between two headers icc-rpmh.h and icc-rpm.h,
> > the function qcom_icc_xlate_extended() is declared in icc-rpmh.h thus
> > it cannot be used by icc-rpm driver.
> > 
> > Move the function to a new common file icc-common.c so that allow it to
> > be called by multiple drivers.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> > ---
> >   drivers/interconnect/qcom/Makefile     |  3 +++
> >   drivers/interconnect/qcom/icc-common.c | 34 ++++++++++++++++++++++++++
> >   drivers/interconnect/qcom/icc-common.h | 13 ++++++++++
> >   drivers/interconnect/qcom/icc-rpmh.c   | 26 +-------------------
> >   drivers/interconnect/qcom/icc-rpmh.h   |  1 -
> >   drivers/interconnect/qcom/sm8450.c     |  1 +
> >   6 files changed, 52 insertions(+), 26 deletions(-)
> >   create mode 100644 drivers/interconnect/qcom/icc-common.c
> >   create mode 100644 drivers/interconnect/qcom/icc-common.h
> > 
> > diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> > index ceae9bb566c6..bbb3d6daaad1 100644
> > --- a/drivers/interconnect/qcom/Makefile
> > +++ b/drivers/interconnect/qcom/Makefile
> > @@ -1,5 +1,8 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_INTERCONNECT_QCOM) += interconnect_qcom.o
> > +
> > +interconnect_qcom-y			:= icc-common.o
> >   icc-bcm-voter-objs			:= bcm-voter.o
> >   qnoc-msm8916-objs			:= msm8916.o
> >   qnoc-msm8939-objs			:= msm8939.o
> > diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
> > new file mode 100644
> > index 000000000000..0822ce207b5d
> > --- /dev/null
> > +++ b/drivers/interconnect/qcom/icc-common.c
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2022 Linaro Ltd.
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/slab.h>
> > +
> > +#include "icc-common.h"
> > +
> > +struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
> > +{
> > +	struct icc_node_data *ndata;
> > +	struct icc_node *node;
> > +
> > +	node = of_icc_xlate_onecell(spec, data);
> > +	if (IS_ERR(node))
> > +		return ERR_CAST(node);
> > +
> > +	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
> > +	if (!ndata)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ndata->node = node;
> > +
> > +	if (spec->args_count == 2)
> > +		ndata->tag = spec->args[1];
> > +
> > +	if (spec->args_count > 2)
> > +		pr_warn("%pOF: Too many arguments, path tag is not parsed\n", spec->np);
> > +
> > +	return ndata;
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
> > diff --git a/drivers/interconnect/qcom/icc-common.h b/drivers/interconnect/qcom/icc-common.h
> > new file mode 100644
> > index 000000000000..33bb2c38dff3
> > --- /dev/null
> > +++ b/drivers/interconnect/qcom/icc-common.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2022 Linaro Ltd.
> > + */
> > +
> > +#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_COMMON_H__
> > +#define __DRIVERS_INTERCONNECT_QCOM_ICC_COMMON_H__
> > +
> > +#include <linux/interconnect-provider.h>
> 
> If it's just for the sake of the function prototype, you can replace
> #include with forward declarations of two used structures:
> 
> struct icc_node_data;
> struct of_phandle_args;

Will fix in next spin.

Thanks,
Leo

> > +
> > +struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
> > +
> > +#endif
> > diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> > index 2c8e12549804..9a0ac85d2a84 100644
> > --- a/drivers/interconnect/qcom/icc-rpmh.c
> > +++ b/drivers/interconnect/qcom/icc-rpmh.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/slab.h>
> >   #include "bcm-voter.h"
> > +#include "icc-common.h"
> >   #include "icc-rpmh.h"
> >   /**
> > @@ -100,31 +101,6 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_icc_set);
> > -struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
> > -{
> > -	struct icc_node_data *ndata;
> > -	struct icc_node *node;
> > -
> > -	node = of_icc_xlate_onecell(spec, data);
> > -	if (IS_ERR(node))
> > -		return ERR_CAST(node);
> > -
> > -	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
> > -	if (!ndata)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	ndata->node = node;
> > -
> > -	if (spec->args_count == 2)
> > -		ndata->tag = spec->args[1];
> > -
> > -	if (spec->args_count > 2)
> > -		pr_warn("%pOF: Too many arguments, path tag is not parsed\n", spec->np);
> > -
> > -	return ndata;
> > -}
> > -EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
> > -
> >   /**
> >    * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
> >    * @bcm: bcm to be initialized
> > diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> > index 4bfc060529ba..84acc540a5f7 100644
> > --- a/drivers/interconnect/qcom/icc-rpmh.h
> > +++ b/drivers/interconnect/qcom/icc-rpmh.h
> > @@ -131,7 +131,6 @@ struct qcom_icc_desc {
> >   int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> >   		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
> >   int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
> > -struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
> >   int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
> >   void qcom_icc_pre_aggregate(struct icc_node *node);
> >   int qcom_icc_rpmh_probe(struct platform_device *pdev);
> > diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
> > index 8d99ee6421df..23045cf17e37 100644
> > --- a/drivers/interconnect/qcom/sm8450.c
> > +++ b/drivers/interconnect/qcom/sm8450.c
> > @@ -12,6 +12,7 @@
> >   #include <dt-bindings/interconnect/qcom,sm8450.h>
> >   #include "bcm-voter.h"
> > +#include "icc-common.h"
> >   #include "icc-rpmh.h"
> >   #include "sm8450.h"
> 
> 
> -- 
> With best wishes
> Dmitry
