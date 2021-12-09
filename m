Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5646EA56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbhLIOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhLIOwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:52:46 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF63C061746;
        Thu,  9 Dec 2021 06:49:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d10so12440677lfg.6;
        Thu, 09 Dec 2021 06:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iZsjpEQisLwXWoTUZrMGpEP/rg7ykKTtHEohB5VlKjo=;
        b=N5KjOh0h/gLmW6AEoNGbcGu0XY6tfmxd2fVt19IudyLQZCPO23kvIhHZjj9RgVCzyK
         PFGRZ85o8bF7psna2RyZOBS2hzIbsJYXHYD8AH6ZNCGCEa5mYwmN9FWKuMDxJQqrHXQM
         743HfXGZ9R/aAXXd9IW+jzuB/Jlcmu4Iqe1S3OG+vG1ha27rCfLQJR7BYPCwGaPlg09+
         wuLAjWxSuPZTlb5vZtDbCv2ZCLHgI4mxCRsMsMI11tzS88TP6qnRdT5dtbYtbMW4ff/H
         eZe17X/svYezyTqC/NlXCrsyNNjQynURycwCmoL0GZhAksKqbIxdnr1B9O61yUsShwNU
         rbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZsjpEQisLwXWoTUZrMGpEP/rg7ykKTtHEohB5VlKjo=;
        b=JrspClLegu9e3djZPfjkJ/tW2dQTRWbaoVzxX4Wo8fO5FvuIiTeWuuCvTPjq5umwOQ
         xQ/chfe4unTyHCvuIoup3Yb6NeEhktYqeT4JKEh3ZOp8xRr5LZdjenO9AzmgfOzatSJl
         TSw8IKRvbCRt9v5z1tbI0zP6pvr0W2lBkb0khX9pH+QcMhOaItO64z3rFdtcUewmJG8s
         9ntQJGzdyz+oVb5Nanfxsnk/bGaHey0J00TY8k7PMu8UHSO9ncjcJi12t61JCewjp+TG
         x28yQ4lL9ABUNdMGq/2Fr1bH4VUo1tlwslVMUg+1MO1C9X/kC9PdgbxYkSj1xvXdJqY7
         99yA==
X-Gm-Message-State: AOAM532Hs8jZscU/2l+5Z9aBNd/lwn6faU+ZGrIYLIc2tlY8RAKICR3X
        M59bpHLs9zhMb6i5sYoneVaxVcNlcMk=
X-Google-Smtp-Source: ABdhPJypck+AA6tuc9nKMOs2vH1DUNXy2B1oE3nA2AC6Mpu9/HK1zrngQhEiSxB38uM0iykfpGgPAA==
X-Received: by 2002:ac2:52b5:: with SMTP id r21mr6236723lfm.127.1639061350601;
        Thu, 09 Dec 2021 06:49:10 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id b6sm1834ljr.103.2021.12.09.06.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 06:49:10 -0800 (PST)
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
Message-ID: <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
Date:   Thu, 9 Dec 2021 17:49:09 +0300
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
> +static unsigned long pd_pt_index_iova(unsigned int pd_index, unsigned int pt_index)
> +{
> +	return (pd_index & (SMMU_NUM_PDE - 1)) << SMMU_PDE_SHIFT |
> +	       (pt_index & (SMMU_NUM_PTE - 1)) << SMMU_PTE_SHIFT;
> +}

I'd change the return type to u32 here, for consistency.
