Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285EA4AC933
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiBGTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiBGTDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:03:22 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E26C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:03:19 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id om7so614268pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zweFrYRkCzguHpFVOCBPGa3h4HNGTtGroD9vGrjNJbI=;
        b=ykQz/txh8PHkGPgZ8Ects4oRlUbvZXFBniPRUT6dXw4otCDVProVp3AgvdMT1QG7LE
         9V42K9AVJIncDnBwtE9S36ZSauhRJb8rhD0ZjwoXqV+5VCGJB7Y5TyBsZYVIU19Hg4fN
         1oOiUvZm/GM7DAtoRoUScPI4QWaX6iB22dF807RNkXRzzauWlKLXwdRkk4tvBJuvgib5
         /D11AK+R2vEFZdmhtYaS87+7wfC6acratRbbv9G8wmAPedH3PFsUvL7ThphnIXB1Pr4r
         uyEiz0Ot0cXU5r64nNpx3KkuNC6iAannQ3JUAu/CZNVdZL1StCAMmcLxP2SS7wv/Zh4s
         6AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zweFrYRkCzguHpFVOCBPGa3h4HNGTtGroD9vGrjNJbI=;
        b=IzU36EfDgbTD21Tlwz/jGJvRfGpu5wJZcGyOsmVwXBcDTX2htSvTGMeRw69rARKvwv
         gGu5qxqWn5dPo4Zm6VYiWYR2EijjZ5E6PAuBNILOKGH6LnFbSUTMbOqqEUiMuUjEote6
         KMI1q0mq3UijTW8dH7Okrw7Cj03ll+B2AbUJgkvvXBHFV3xB6PRABtXVA1+BTprbBPF7
         KvZV7GM+lvyexwqbtSRxCntp0IEOPXIdsgSoPnRc5ZFeuwLGKVhOdD5JEb47Re0yFkSu
         EZoZJdMH3YioUtK3zj1iTkxO9lYvljqN3J1hSZJebP9IDKdP6uSs3q7mWsvJiOGZUgIh
         iPNQ==
X-Gm-Message-State: AOAM532r0mii6RQmf6hpHYo2+WBIjW1d9nZx0algWiR5LgyGPctCczX9
        L1AJV+j4yfVuv+BEcN21PSrkvw==
X-Google-Smtp-Source: ABdhPJy2ruqmawn7O3pRdBnhzMLuaQ4nwJkyZuEtP+ONUhmVb96zPPlst8w9ZJm5eEaQ5FQebQOphw==
X-Received: by 2002:a17:903:11c9:: with SMTP id q9mr726574plh.144.1644260598836;
        Mon, 07 Feb 2022 11:03:18 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y41sm12964976pfa.213.2022.02.07.11.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:03:17 -0800 (PST)
Date:   Mon, 7 Feb 2022 12:03:15 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        leo.yan@linaro.com, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/15] coresight: Make ETM4x TRCEVENTCTL1R register
 accesses consistent with sysreg.h
Message-ID: <20220207190315.GC3355405@p14s>
References: <20220203120604.128396-1-james.clark@arm.com>
 <20220203120604.128396-8-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203120604.128396-8-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:05:55PM +0000, James Clark wrote:
> This is a no-op change for style and consistency and has no effect on the
> binary produced by gcc-11.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../coresight/coresight-etm4x-sysfs.c         | 25 +++++++++++--------
>  drivers/hwtracing/coresight/coresight-etm4x.h |  9 +++++++
>  2 files changed, 24 insertions(+), 10 deletions(-)
>

I like what this patchset is doing.  I have reviewed up to here today and will
finish tomorrow.

Thanks,
Mathieu

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 4c29ab4464a0..cfa6f72a1e39 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -384,16 +384,16 @@ static ssize_t mode_store(struct device *dev,
>  	/* bit[11], AMBA Trace Bus (ATB) trigger enable bit */
>  	if ((config->mode & ETM_MODE_ATB_TRIGGER) &&
>  	    (drvdata->atbtrig == true))
> -		config->eventctrl1 |= BIT(11);
> +		config->eventctrl1 |= TRCEVENTCTL1R_ATB;
>  	else
> -		config->eventctrl1 &= ~BIT(11);
> +		config->eventctrl1 &= ~TRCEVENTCTL1R_ATB;
>  
>  	/* bit[12], Low-power state behavior override bit */
>  	if ((config->mode & ETM_MODE_LPOVERRIDE) &&
>  	    (drvdata->lpoverride == true))
> -		config->eventctrl1 |= BIT(12);
> +		config->eventctrl1 |= TRCEVENTCTL1R_LPOVERRIDE;
>  	else
> -		config->eventctrl1 &= ~BIT(12);
> +		config->eventctrl1 &= ~TRCEVENTCTL1R_LPOVERRIDE;
>  
>  	/* bit[8], Instruction stall bit */
>  	if ((config->mode & ETM_MODE_ISTALL_EN) && (drvdata->stallctl == true))
> @@ -534,7 +534,7 @@ static ssize_t event_instren_show(struct device *dev,
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	struct etmv4_config *config = &drvdata->config;
>  
> -	val = BMVAL(config->eventctrl1, 0, 3);
> +	val = REG_VAL(config->eventctrl1, TRCEVENTCTL1R_INSTEN);
>  	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>  }
>  
> @@ -551,23 +551,28 @@ static ssize_t event_instren_store(struct device *dev,
>  
>  	spin_lock(&drvdata->spinlock);
>  	/* start by clearing all instruction event enable bits */
> -	config->eventctrl1 &= ~(BIT(0) | BIT(1) | BIT(2) | BIT(3));
> +	config->eventctrl1 &= ~(TRCEVENTCTL1R_INSTEN_MASK << TRCEVENTCTL1R_INSTEN_SHIFT);
>  	switch (drvdata->nr_event) {
>  	case 0x0:
>  		/* generate Event element for event 1 */
> -		config->eventctrl1 |= val & BIT(1);
> +		config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_1;
>  		break;
>  	case 0x1:
>  		/* generate Event element for event 1 and 2 */
> -		config->eventctrl1 |= val & (BIT(0) | BIT(1));
> +		config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 | TRCEVENTCTL1R_INSTEN_1);
>  		break;
>  	case 0x2:
>  		/* generate Event element for event 1, 2 and 3 */
> -		config->eventctrl1 |= val & (BIT(0) | BIT(1) | BIT(2));
> +		config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
> +					     TRCEVENTCTL1R_INSTEN_1 |
> +					     TRCEVENTCTL1R_INSTEN_2);
>  		break;
>  	case 0x3:
>  		/* generate Event element for all 4 events */
> -		config->eventctrl1 |= val & 0xF;
> +		config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
> +					     TRCEVENTCTL1R_INSTEN_1 |
> +					     TRCEVENTCTL1R_INSTEN_2 |
> +					     TRCEVENTCTL1R_INSTEN_3);
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 55e756020a94..eb72b81bbf85 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -211,6 +211,15 @@
>  #define TRCCONFIGR_DA				BIT(16)
>  #define TRCCONFIGR_DV				BIT(17)
>  
> +#define TRCEVENTCTL1R_INSTEN_SHIFT		0
> +#define TRCEVENTCTL1R_INSTEN_MASK		GENMASK(3, 0)
> +#define TRCEVENTCTL1R_INSTEN_0			BIT(0)
> +#define TRCEVENTCTL1R_INSTEN_1			BIT(1)
> +#define TRCEVENTCTL1R_INSTEN_2			BIT(2)
> +#define TRCEVENTCTL1R_INSTEN_3			BIT(3)
> +#define TRCEVENTCTL1R_ATB			BIT(11)
> +#define TRCEVENTCTL1R_LPOVERRIDE		BIT(12)
> +
>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> -- 
> 2.28.0
> 
