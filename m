Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9303846EA46
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhLIOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhLIOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:50:56 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C3C061746;
        Thu,  9 Dec 2021 06:47:22 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m6so605409lfu.1;
        Thu, 09 Dec 2021 06:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FB6FkU9Ub0Mnerpu4sSrMAvDQxD5IPFH9I0yMO2mX38=;
        b=ieFcHWWy/CcJtGSE1jtUOV3ItL81dg7fmRKEZi7xPPzBFVY37Mp6ZMUpOsyem/Wa1L
         4D4U4oVgSexf+ACjuCpwQ0Qmnznp/8q0+kK3x7FxotxnrxQh/StEHGke17yfozYMT1Mo
         EAe2tFhpaaQErTzUjYC3d/SKpxXlk0bVlyrACaLWq9/F3p4kdjzpUmoYV6BtL10B1yjF
         /EHLqO0jr8eiFFMv+SA4FPnh8uKHXom8x2dMpWb73xsOxfqo6kV/QEczMhUhV3AoJ2jz
         G5XfUKQOKCl5auzTYHyvPYZcYHbw371aVIIDtmGmF+CASWk+4wudcSV5wduxw162QWQq
         RJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FB6FkU9Ub0Mnerpu4sSrMAvDQxD5IPFH9I0yMO2mX38=;
        b=OescWmml0/x6lSg75O6DufSA0aPay3j8c5zYprNYRI7yahdjLeXq9P0kfEArpJza9K
         JRx9IfkD33JOJHyincOothqRqFqqNehGC4aRzAqpuXWcIICZTTyVnLh+z8ycIWNTFd6B
         4fJf71Bo4JR1YI36VhkBXDqcGnt3spuOvdHRX4O3rDutKpKrF6QgRzqU2uhbl7mxzi7l
         AOIjaqzxiyyf2qdmATTxOdOMcydM0R4IBBH1+sB3T2jR1/bcFc6+oI4Q0sBgkNgq1DLV
         GjW2/3ITITKfdjIHmG7YNibBKvV3G3RJ6iFOjdij7doLuTwDjiC2mZlEdoNFRIakHq9n
         sI9Q==
X-Gm-Message-State: AOAM530MLLmu38+U/2dhTbTGN5cHzrRrG814lDmLO+VQcXtxZSJQ7QXE
        5AIROTy97MWWBvOYuhWeEQwciG5gf8k=
X-Google-Smtp-Source: ABdhPJwDEOi37hF+qJvO27fOFsc4jz56KQd1J7cFcn4v7akIUINwKPqpT4s1QxBIu4a9QLxlC8Z74g==
X-Received: by 2002:a05:6512:31d1:: with SMTP id j17mr6262758lfe.395.1639061240018;
        Thu, 09 Dec 2021 06:47:20 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id c25sm3292lja.38.2021.12.09.06.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 06:47:19 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
To:     Nicolin Chen <nicolinc@nvidia.com>, thierry.reding@gmail.com,
        joro@8bytes.org, will@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
Date:   Thu, 9 Dec 2021 17:47:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209073822.26728-7-nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.12.2021 10:38, Nicolin Chen пишет:
> @@ -545,6 +719,15 @@ static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
>  		if (group->swgrp != swgrp)
>  			continue;
>  		group->as = NULL;
> +
> +		if (smmu->debugfs_mappings) {

Do we really need this check?

Looks like all debugfs_create_dir() usages in this driver are incorrect,
that function never returns NULL. Please fix this.

> +			struct dentry *d;

The file name is wrong here.

			if (group->soc)
				name = group->soc->name;
			else
				name = group->swgrp->name;

> +			d = debugfs_lookup(group->swgrp->name,
> +					   smmu->debugfs_mappings);
> +			debugfs_remove(d);
> +		}

This now looks problematic to me. You created debugfs file when the
first member of the shared group was attached to AS, now you remove this
file when any device is detached. The shared debugfs file should be
refcounted or something.
