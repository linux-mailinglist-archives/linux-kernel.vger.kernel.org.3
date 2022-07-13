Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972AA573D57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiGMTr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiGMTrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:47:53 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E8220F50
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:47:52 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10bec750eedso15332765fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8D95/yVq1YOPcWb/WH+y2oBHLQ7lhx2cc7uibhPQelU=;
        b=dH8hhAHOKfY4Js+RT7XzGfmxv9ffH4ZqgZ0Gj1n09yPcYZA72LaVZKIw5nHwp/l0/D
         2VF2TEZCtUHVVdRpCzGGzO9qdD5nZ/NIUKiuDm1LE4lufnEaOQt6+jQ+MbKQFEcQfqEv
         Hd7UGwzzcsz8A95Bg/16g4AJvOhLT1EbzzR9ddEd4BvXFQxlY6DJpwLl6A+d2u+dJBH1
         xbgrV9ucMHI8k9iwiyj9K+rPumk5LeGQf2IUX+DhxnWrLcUgkdVEBlJppzLBYmNaKrjm
         dMQRD8u9+/mZiaKxZZRF5yqLEVI6jnB+sxrv2XTIC7bNzvLvemoIT2nc284A6Lg2+nv+
         hYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8D95/yVq1YOPcWb/WH+y2oBHLQ7lhx2cc7uibhPQelU=;
        b=MBW6Wh3+6xBCMneXEGMvATZ+RubRx8ZOX2LW0F6QwEka2/L+a6oN3RjLTcjqGIArxd
         RuIKqkl8NE6iVMhp3rh5UvbBtPBoE5/aMIn3JX5hn/KAm5u8Pf75Cx8gjpFfB6zzgX54
         qV04u5//KgMOXVCFXCJLIKyZlEmiqzEqeGxOYg8/eFDivDaQ/kpmh4jA65M34tLOqq4k
         KuBMxvScap9zLc1Zq1BGNqAaCaOx7e6E9JMY4OxqJ7FDatY8GzFVXhNdPOwNeM6CfTUC
         Fmm4fm8ekwPj7D9B/G/2sC6jo+ydh7lXZ75lhFJ5OP7MJtSZv66mpV3hK41XJed+qX6M
         kZjQ==
X-Gm-Message-State: AJIora/BLbd53PZwB5FDDp3RVDEv+nfnrM7Lu/i+Tzy6KJ9iZyHJFex9
        12h0cQ/4Imo1CJKr4uFxN16+DQ==
X-Google-Smtp-Source: AGRyM1uH/VRp/joNX/6VEBMrEKeWbVj0WND0pXItrY4oNfwPUuy3tkv8Jx3nhK5VMUAKTBfnmrCUgg==
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id ba11-20020a056870c58b00b0010bd21dad5emr2693156oab.287.1657741671470;
        Wed, 13 Jul 2022 12:47:51 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m20-20020a0568080f1400b0032e5d0b5d5fsm5703551oiw.58.2022.07.13.12.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 12:47:50 -0700 (PDT)
Date:   Wed, 13 Jul 2022 14:47:49 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        david.brown@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konrad.dybcio@somainline.org
Subject: Re: [PATCH] thermal/drivers/qcom: Code refactoring
Message-ID: <Ys8hZYB/exrovqoY@builder.lan>
References: <20220712173127.3677491-1-carlos.bilbao@amd.com>
 <Ys5KdVQmA9YTmfCT@builder.lan>
 <e871f27d-2bfe-62e3-a5fa-8e1fe52e856a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e871f27d-2bfe-62e3-a5fa-8e1fe52e856a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Jul 09:10 CDT 2022, Carlos Bilbao wrote:

> On 7/12/22 23:30, Bjorn Andersson wrote:
> 
> > On Tue 12 Jul 12:31 CDT 2022, Carlos Bilbao wrote:
[..]
> > > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> > > index 2fd94997245b..d2d78c7e20c8 100644
> > > --- a/drivers/thermal/qcom/tsens.h
> > > +++ b/drivers/thermal/qcom/tsens.h
> > > @@ -6,6 +6,7 @@
> > >   #ifndef __QCOM_TSENS_H__
> > >   #define __QCOM_TSENS_H__
> > > +#define MAX_NUM_SENSORS		11
> > This only seems to apply for the three cases you have listed here, e.g.
> > tsens-v2 (which also includes tsens.h) has max_sensors = 16.
> 
> This should be an array with an enum for the versions.
> 

As the numbers are used within each c-file, some defines at the top of
these would probably be a good idea.

Regards,
Bjorn
