Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A349BD50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiAYUka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiAYUk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:40:28 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60299C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:40:28 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i62so9490298ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TobNMKU240Fj7f7MVAjfzomITTx2vGGl8ugxKX/S6BE=;
        b=CCPGuSm797PuQtUaHM9EKwIp/9sJqcwDjoWyuLCcLdvttr6bBokT7dxuyvK09meDOm
         5NPuDCf53GtbDCISAw2vgQB0ND9EPAUkKVlErS9XAn4Hp1aJiqrJ0+qNRuSbsfLdISXn
         ZFvRXmu0ir8JFtcPOfoV22y0wxZy/CRBMAKZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TobNMKU240Fj7f7MVAjfzomITTx2vGGl8ugxKX/S6BE=;
        b=jC7ZsPSO1y7JQB/VLBechFekMKefFO4Gu2AcvTIt9TU7GKm990BZ0TLlsWqQ1CvJMW
         cnluHQ/1VW0VhDGyO5Nc28YfgxIbA+QH2K02uVDYCaujg94vCeJ6fk08YL2Z8JgAL6Do
         sXDVzSJTJuua0b0I0ztWPV33FouHWcBw0+adZ2ywLSwtKX3+mPVQ4wAFVqdSTBvPBAVM
         dufcMDN3TPVwPrIewHRUGwhCxcbrfEWaMG28csSmHAuIiWdX2S8+mozaL6MWbX4RDr70
         OFACzEG6UQGhC8W4tVtmjE4/1eJKRWNVV0xm+z7j2oHRT40/voz5B/sdz/WoZ8yAzH7e
         RMiA==
X-Gm-Message-State: AOAM533nfM8wjcJ3rtAXGCMC+FPTp4yKUKCicL1S4MHnw1c9d1knMQJX
        kDAJV7DHNNzK5c6X0mw/Nv9nDQ==
X-Google-Smtp-Source: ABdhPJxDUt8PW94HBYYCkH6kK+Bn4St/ddjA5pSr7jZlBibsvFxWlk1D7AxUwQXlWExN6/fD15N+xA==
X-Received: by 2002:a05:6602:2d09:: with SMTP id c9mr12115862iow.142.1643143227806;
        Tue, 25 Jan 2022 12:40:27 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id q8sm374818ilj.12.2022.01.25.12.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:40:27 -0800 (PST)
Subject: Re: [PATCH 3/3] selftests/zram: Adapt the situation that /dev/zram0
 is being used
To:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        aleksei.kodanev@bell-sw.com, Shuah Khan <skhan@linuxfoundation.org>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639562171-4434-3-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7ec24b9a-4b98-ca31-9862-4b2d2df4b50e@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 13:40:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1639562171-4434-3-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 2:56 AM, Yang Xu wrote:
> On some linux distributions, if it used /dev/zram0 as default by zram-generate
> service, then this case will fail or report EBUSY.
> 
> To fix this, use hot_add/hot_remove interface. Also, move module check code into
> zram_load from zram.sh. We can use /sys/class/zram-control to detect the
> module whether existed.
> 
> After this patch, we still run case pass even /dev/zram0 is being used.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   tools/testing/selftests/zram/zram.sh     | 16 +----
>   tools/testing/selftests/zram/zram01.sh   |  2 +-
>   tools/testing/selftests/zram/zram_lib.sh | 75 ++++++++++++------------
>   3 files changed, 41 insertions(+), 52 deletions(-)
> 

This patch looks good to me. A few checkpatch warns to fix and also
it probably depends on the other two patches in this series.

Please fix and send v2 for all 3 patches.

thanks,
-- Shuah
