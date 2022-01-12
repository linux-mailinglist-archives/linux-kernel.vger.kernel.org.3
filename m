Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0C48C30C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352838AbiALLY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352832AbiALLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:24:41 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E044C06173F;
        Wed, 12 Jan 2022 03:24:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id br17so6922477lfb.6;
        Wed, 12 Jan 2022 03:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NbhOvUkO9g131jLa1g16YTEMtyTYHn9ZvHoBdZ3P+9E=;
        b=TXxz5pdv0WTMvF9sFpXKkRYZj0cRwOO9fREIzpnSZTMMi+Cg/YywiZv1l0KCLx83QG
         OGgVYHCmc5UjWFvlFxXdCrrL+NT8LiwVayJ9R+hu7SbZBm9Qyye8yvCfQHKeG3DyamQg
         JINGIml2JzTMSoNMiaxmCJ7scCoTUv1hUe3281wW+ra1n4HDJU6IxbrBrEy5ApdCm9UJ
         O6wpVBqQQk3qv7KgchM1Qw2yhFL/4Em1bTwAgiXbwO/oCgjvk7LIO8xYFxcghq1hSgqS
         O1ie4goI+UpEdBZsjCAM0xRRMnO64J7bdWtFhsZ2UY5Oj94JIr6lgygdveDVz3fk2hAQ
         x6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NbhOvUkO9g131jLa1g16YTEMtyTYHn9ZvHoBdZ3P+9E=;
        b=ie9VPMOD/G5iwHxAv4mel3ukDzgvqg0T+xxOS4kGSCkFNhM7TlXfdwieLxHRY2ooPm
         WvW/uv9pZeKuMhqkvF9mj3GjKtoTC6aRylKHEXN6e4uMMvXYWtVhnOg5AZo4CeZXCwVk
         isbXkzMax7kCpjDgFWgefAPkUZUKDSu9AWouJRx1frd4TaIo0tIRjnE0Vbblo4aZ///+
         tf5j4rCeY8nr8GBNsMnWRGGMPCPv2LTuyrMCfQiTCB0J8PjqOfhogegYOmLdboImYTHL
         ccZZkqE3zBnqHGqAyFJKjNgaZaTUFdXnozFPTFmLLBxHqYzKgurUD7j/k/ByOWIbuMSQ
         Iqgg==
X-Gm-Message-State: AOAM532NkiZrpL6izl5YgdTkpScmFNvocR/30+ULCnkiTmVUHvUgmN9n
        LcxAVPxq5Ge2E1uLs2wm5vc=
X-Google-Smtp-Source: ABdhPJyf5aunjokJX6KtWkI+sbtwB39whmA1C2n4n2vD74x0zZFX84Fz71b5DvHpb8qGMCMXb9Aqzg==
X-Received: by 2002:ac2:44d6:: with SMTP id d22mr6414152lfm.590.1641986678598;
        Wed, 12 Jan 2022 03:24:38 -0800 (PST)
Received: from [192.168.2.145] (94-29-62-108.dynamic.spd-mgts.ru. [94.29.62.108])
        by smtp.googlemail.com with ESMTPSA id i9sm1611371lfe.26.2022.01.12.03.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:24:38 -0800 (PST)
Subject: Re: [Patch V1 3/4] memory: tegra: add mc-err support for T186
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
 <0b584dfd-04f6-d7f7-f08a-003b89e557f5@gmail.com>
Message-ID: <b250e2f5-b095-3767-519d-40e42e0a832b@gmail.com>
Date:   Wed, 12 Jan 2022 14:24:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0b584dfd-04f6-d7f7-f08a-003b89e557f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.01.2022 14:22, Dmitry Osipenko пишет:
> 11.01.2022 21:45, Ashish Mhetre пишет:
>>  #define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
>>  #define MC_INT_WCAM_ERR					BIT(19)
>>  #define MC_INT_SCRUB_ECC_WR_ACK				BIT(18)
> 
> I don't see where these errors are handled in the code. Is documentation
> that explains these bits publicly available?
> 

MC_INT_SCRUB_ECC_WR_ACK shouldn't be a error.
