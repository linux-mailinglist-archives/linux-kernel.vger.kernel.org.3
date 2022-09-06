Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAB45AF5B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIFUU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiIFUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:19:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4574BBA9E4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:17:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x1so8029032plv.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=hWB9slcYwP2VmWl1LPqyRezAmYmLuLNmb+c8lUEUpJw=;
        b=aVLAGQztiiEZT9g/oIw0tbOv4wDZuuhTdLD8dkimdnHimZyy/A2xvYTC30XFcy/5Oq
         qnL3cBMNLZY4AoYKS2rwsm5bTddwRLfCmSB/dfZ6+FCeoeu7m52TvNvuca78nRK+psDZ
         Ea14tBuRdZgXTg6VxbC3Sm1yQTEvR9BV4ZevWE9Bj3KON4LuvZ1sX1ZgoLKufdswL7f1
         Ykej6q2jVNuECUZi6l57snUxD4QiwXa2O+YWmnk3glcRISN8Pcg6qMUFj2KeMUpzXqWn
         uKJY3ekJBCbEpqNiOkxudhgtvYQOkXiZ9gdri0op8tva3aOzHIGAeGjhmjhgM0kqrk7J
         nafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hWB9slcYwP2VmWl1LPqyRezAmYmLuLNmb+c8lUEUpJw=;
        b=CUeHV2krukvT2F4hdqVib+Z5E6ETUZ9JmKNhC6DMET8HjOj4oSon8Sq0228NL/qlTH
         tQ8ViGWNq6PxS7hmjf0lgKQbH+ddOZWiRw5bO7ry/y1SFuxB8X+2spwoZTf7KngjSnD6
         1pT/stTcPpcwFChLPcx8Qlebn4+EkYCVG1+HcZtu+2qute03QmqjLHG1c+Qx4KhAkRt2
         +dtBLpSXq43fmVtIOfA5oSQaDhHDqsgMtl3T1hz45f3wyruy1YfeOxODsWFmgYAezvpF
         8k5mga7E5YRTQtH/wLyB71UIXvXn40IMgxP4MYhPSsmt9QZpCjZoWKD8dtnGbTAi9GnH
         QJUg==
X-Gm-Message-State: ACgBeo1zcb9vx9de/yPj6bhxVjBAVHSPbJqCZaqP6zmiC3gV4Srs0OK9
        6LbHbHn4jMWVxX2WOq0qiDH9NA==
X-Google-Smtp-Source: AA6agR7LhafKa5Nv1FqEJg3a0DDqCuP7aynhBww/aEou/6EENnvU8IULAvRWdpUt6JfQ0aOWZTHAaw==
X-Received: by 2002:a17:90b:3901:b0:1fd:99f6:68c with SMTP id ob1-20020a17090b390100b001fd99f6068cmr26532549pjb.5.1662495447359;
        Tue, 06 Sep 2022 13:17:27 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b7-20020aa78ec7000000b00537fb1f9f25sm10723603pfr.110.2022.09.06.13.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:17:25 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:17:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: cti-sysfs: Mark coresight_cti_reg_store() as
 __maybe_unused
Message-ID: <20220906201723.GA70736@p14s>
References: <20220901195055.1932340-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901195055.1932340-1-nathan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 12:50:55PM -0700, Nathan Chancellor wrote:
> When building without CONFIG_CORESIGHT_CTI_INTEGRATION_REGS, there is a
> warning about coresight_cti_reg_store() being unused in the file:
> 
>   drivers/hwtracing/coresight/coresight-cti-sysfs.c:184:16: warning: 'coresight_cti_reg_store' defined but not used [-Wunused-function]
>     184 | static ssize_t coresight_cti_reg_store(struct device *dev,
>         |                ^~~~~~~~~~~~~~~~~~~~~~~
> 
> This is expected as coresight_cti_reg_store() is only used in the
> coresight_cti_reg_rw macro, which is only used in a block guarded by
> CONFIG_CORESIGHT_CTI_INTEGRATION_REGS. Mark coresight_cti_reg_store() as
> __maybe_unused to clearly indicate that the function may be unused
> depending on the configuration.
> 
> Fixes: fbca79e55429 ("coresight: cti-sysfs: Re-use same functions for similar sysfs register accessors")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/hwtracing/coresight/coresight-cti-sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 478b8d38b744..6d59c815ecf5 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -181,9 +181,9 @@ static ssize_t coresight_cti_reg_show(struct device *dev,
>  }
>  
>  /* Write registers with power check only (no enable check). */
> -static ssize_t coresight_cti_reg_store(struct device *dev,
> -				       struct device_attribute *attr,
> -				       const char *buf, size_t size)
> +static __maybe_unused ssize_t coresight_cti_reg_store(struct device *dev,
> +						      struct device_attribute *attr,
> +						      const char *buf, size_t size)
>  {

Applied.

Thanks,
Mathieu

>  	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	struct cs_off_attribute *cti_attr = container_of(attr, struct cs_off_attribute, attr);
> 
> base-commit: 0a98181f805058773961c5ab3172ecf1bf1ed0e1
> -- 
> 2.37.3
> 
