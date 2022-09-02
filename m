Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7EB5AB1DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiIBNnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiIBNnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:43:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B0A0FF0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:19:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA7641516;
        Fri,  2 Sep 2022 06:03:17 -0700 (PDT)
Received: from [10.57.16.88] (unknown [10.57.16.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D90B73F766;
        Fri,  2 Sep 2022 06:03:09 -0700 (PDT)
Message-ID: <54e034aa-4012-e6f1-c0f3-325d8fe0f4c1@arm.com>
Date:   Fri, 2 Sep 2022 14:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] coresight: cti-sysfs: Mark coresight_cti_reg_store() as
 __maybe_unused
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220901195055.1932340-1-nathan@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220901195055.1932340-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2022 20:50, Nathan Chancellor wrote:
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

It would also be possible to fix this by wrapping the definitions in
#ifdef CONFIG_CORESIGHT_CTI_INTEGRATION_REGS. That way the maybe_unused
isn't needed and it's a bit cleaner.

Either way, thanks for the fix.

Reviewed-by: James Clark <james.clark@arm.com>

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
>  	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	struct cs_off_attribute *cti_attr = container_of(attr, struct cs_off_attribute, attr);
> 
> base-commit: 0a98181f805058773961c5ab3172ecf1bf1ed0e1
