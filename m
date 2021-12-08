Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EFA46D611
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhLHOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhLHOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:53:15 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1246EC061746;
        Wed,  8 Dec 2021 06:49:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c32so6111088lfv.4;
        Wed, 08 Dec 2021 06:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A6AQ5RwsLshkjaFWGygq+igXovLHIdNbBW/Y1yrIsSE=;
        b=edtbly6D/+OT8HwkDGJjQMmmvUukDQwJxH9sektWgq+2vtrnEXgDPIuLQDZbMCzUjT
         ehn3E69bsJvREITJaO6njTL6s1x0unRO/pDj5eudgb+6zzMSYv3dPxkgMZzFs58zY1oH
         1CiuLQr49p3v0K9geojMUA5KnICmmtlfVD5zYwcUTCdA4zMsgiPkrWOxT+J+0+ZwZD/T
         9qhv/qCNra5Uq8URmoQm9J3TtV17adJ7RIBeg7Zxc/RVQcDZ9picNCW8lMy7hwwS38FW
         v1rUR6yoWqRklJCsHsPFMZZaxxSzeqfNI/VaCCKTkM3QoJeKMdLvSDyGxF9zSZxx6pwQ
         ko8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A6AQ5RwsLshkjaFWGygq+igXovLHIdNbBW/Y1yrIsSE=;
        b=GW+ap7PWCCmD4xwLibbTcW8BlLOBD292WUuyAJN/0vVRv8ptjUHMY1rHvrQGu3D8Od
         xJ3kkmlrfOjpo3ar7bz0ijBaQNT46EXuistk1J9//m9FCGr+yf0iXyjPpBkrnvU70LKR
         XttqD923gS6T1ZnelJW050bKJkX7jtnm3guGT1m+WfIDLQvOsPTe7gQalxr1YhTT6P2e
         kGfDPpoXd1AQZiyxONKA9VxTRTgHt22Morou5/1RHQbmJsTR/LxIW4oPwLkXwGmEUxxL
         GIeL9fbbOS3lrMaFcuH+mPdEN99nbwROxLSfV6cB6oG9mv+ejECnIemuHIo9I1oX005A
         Ax5w==
X-Gm-Message-State: AOAM5316P2ZKTawHVAX11ZAArAyD3ynGY2f5RANvP7R6obFAWn7lEUw/
        Up74MpAS7KCRhzRPUiTwkzMbd7ZFNJc=
X-Google-Smtp-Source: ABdhPJwaNMhyxPX38YKJFrCYdx3ruEto3eCjl/TlMxD+eADMt56U216NfdKzrYehTDrBsbArMabrMw==
X-Received: by 2002:a19:dc1a:: with SMTP id t26mr47903524lfg.315.1638974981163;
        Wed, 08 Dec 2021 06:49:41 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id w15sm272697lfe.184.2021.12.08.06.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 06:49:40 -0800 (PST)
Subject: Re: [PATCH v7 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
To:     Nicolin Chen <nicolinc@nvidia.com>, thierry.reding@gmail.com,
        joro@8bytes.org, will@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211208084732.23363-1-nicolinc@nvidia.com>
 <20211208084732.23363-7-nicolinc@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ccb06bfc-8ba3-b3b2-b550-d8c491082ef5@gmail.com>
Date:   Wed, 8 Dec 2021 17:49:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208084732.23363-7-nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.12.2021 11:47, Nicolin Chen пишет:
> +		seq_printf(s, "\t\t%-14s | %-4s | %-10s%s | %-10s%s | %-11s\n",
> +			   "PTE RANGE", "ATTR",
> +			   "PHYS", sizeof(phys_addr_t) > 4 ? "        " : "",
> +			   "IOVA", sizeof(dma_addr_t)  > 4 ? "        " : "",

Can we change IOVA to u32?
