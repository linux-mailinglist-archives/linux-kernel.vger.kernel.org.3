Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ED24AEE2D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiBIJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:39:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbiBIJdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:33:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33EEE05B1D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:33:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ka4so5414659ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZL5nsQJzlN6imps4+YiPtBhsGzf6yOFUap6AeTuCeNA=;
        b=w6PJpjf74O74HjyL1Gj6ROIaBJicmTqsiYlGYWEZsKsyUkNTjPNiEpbRnjVh+P4NeF
         WlM66ApstCsJi6ZyBn3sXMuPEvWWu9hqIoq0CHsKjOhhmk57u11PUNb7Tc641bueGcUk
         9LLibEfyVfbOUR+kUcZK4aJ2ZuYGTKgO5jIEs7s8SfOBSP23gnWBPPukSS/QDNq35+Hk
         Xq7tL8k+texo1S/u6BHcgF26AT61xhUe1vSg/e0Bv2U0318F4dDfkPTQpCDm6PuvVX+B
         z8YMPepM9hBcUvms1dGNM9hVicB4rzQ4GmkI4EUXUw9gjUO/BEJg/RmlFoakrfEac+4H
         s7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZL5nsQJzlN6imps4+YiPtBhsGzf6yOFUap6AeTuCeNA=;
        b=P8ZhpVUDg1vxD/z5zP/NtlXFKj3Yf87qVmnVebjefR6DsBlc5XsH1X8MqNW9FvR1bd
         lgkz2nyYIq2Fp4wZwTO/ZihbiuVyUsvhdD2teuyMg7R9x3i3ovHmOaD7oETSMuU5FI6P
         FlnprZ11aH4h1RwF1ByFCdT1KxUrLFMq8ND21jtC+cmpqL95F84CHYPIO1p/8YXuy33i
         7hcV2B93iiuhTE9WTmxcfExTJgb0m11i1lu7blcter4LATRwT5iAV309lGktbOc01sMI
         9PmJrtSqFWjYlKOYFxpmfodUqdhGyCmw2jVvCMT13NU+ods8kNMhUGlkC87o6nzd8cEz
         fCzA==
X-Gm-Message-State: AOAM532H0/N+lyFFdOx+7c8+6BnIjnvu4KcK+egJuu6iD68AgLtcwx4i
        Ehl8nTyvtMacYyzJmdQpfX6ULw==
X-Google-Smtp-Source: ABdhPJwj2ogtAm01Cn4fpJI3qhVdtBFd94vapf/jKbUe9O7RLyxnsCzDlZd5IAM4WWK17xSSvSr2/A==
X-Received: by 2002:a17:906:7948:: with SMTP id l8mr1126088ejo.636.1644399188930;
        Wed, 09 Feb 2022 01:33:08 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.65])
        by smtp.gmail.com with ESMTPSA id g9sm5796897ejm.152.2022.02.09.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:33:08 -0800 (PST)
Date:   Wed, 9 Feb 2022 17:33:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 1/4] coresight: etm4x: Add lock for reading
 virtual context ID comparator
Message-ID: <20220209093304.GA334894@leoy-ThinkPad-X240s>
References: <20220204152403.71775-1-leo.yan@linaro.org>
 <20220204152403.71775-2-leo.yan@linaro.org>
 <6b91293a-1149-2c77-04a4-421a45d4e1e0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b91293a-1149-2c77-04a4-421a45d4e1e0@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Feb 09, 2022 at 05:47:24AM +0000, Suzuki Kuruppassery Poulose wrote:
> Hi Leo
> 
> On 04/02/2022 15:24, Leo Yan wrote:
> > Updates to the values and the index are protected via the spinlock.
> > Ensure we use the same lock to read the value safely.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > index 10ef2a29006e..2f3b4eef8261 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -2111,7 +2111,9 @@ static ssize_t vmid_val_show(struct device *dev,
> >   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> >   	struct etmv4_config *config = &drvdata->config;
> > +	spin_lock(&drvdata->spinlock);
> >   	val = (unsigned long)config->vmid_val[config->vmid_idx];
> > +	spin_unlock(&drvdata->spinlock);
> >   	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
> >   }
> 
> 
> I have queued this patch.

Thanks!

> For the rest, we would need to wait until the helper lands in the rc.

The helper function patch has been landed on the mainline kernel,
it would be safe to merge the rest patches.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7e4f8545b497b3f5687e592f1c355cbaee64c8c

BTW, I think you could pick another two refactoring patches:
https://lore.kernel.org/lkml/20220204135051.60639-2-leo.yan@linaro.org/
https://lore.kernel.org/lkml/20220204135051.60639-3-leo.yan@linaro.org/

Thanks,
Leo
