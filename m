Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8346E8A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhLIMyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:54:15 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32894 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhLIMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:54:14 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J8v5Z49TnzcbTM;
        Thu,  9 Dec 2021 20:50:26 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 20:50:39 +0800
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 20:50:39 +0800
Message-ID: <26c3b5d5-c765-1650-568b-d054a92bcba9@huawei.com>
Date:   Thu, 9 Dec 2021 20:50:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] time: Normalize timespec64 before timespec64_compare()
Content-Language: en-US
To:     <john.stultz@linaro.org>, <tglx@linutronix.de>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <liwei391@huawei.com>
References: <20211202130707.3910459-1-liaoyu15@huawei.com>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <20211202130707.3910459-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any comments about this patch?
BTW, is it necessary to add set_normalized_timespec64 to timespec64_compare?

Thanks,
Yu

On 2021/12/2 21:07, Yu Liao wrote:
> Passing unnormalized timespec64 to timespec64_compare() may cause
> incorrect results.
> 
> For example:
>    wall_to_monotonic = {tv_sec = -10, tv_nsec = 900000000}
>    ts_delta = {tv_sec = -9, tv_nsec = -900000000}
> 
> timespec64_compare() returns -1, but actually wall_to_monotonic > ts_delta.
> This will cause wall_to_monotonic to become a positive number.
> 
> Use timespec64_sub() instead of direct subtraction to avoid this.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>   include/linux/time64.h    | 2 ++
>   kernel/time/timekeeping.c | 3 +--
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/time64.h b/include/linux/time64.h
> index 81b9686a2079..f74a36d253cd 100644
> --- a/include/linux/time64.h
> +++ b/include/linux/time64.h
> @@ -50,6 +50,8 @@ static inline int timespec64_equal(const struct timespec64 *a,
>    * lhs < rhs:  return <0
>    * lhs == rhs: return 0
>    * lhs > rhs:  return >0
> + *
> + * Note: Both lhs and rhs must be normalized.
>    */
>   static inline int timespec64_compare(const struct timespec64 *lhs, const struct timespec64 *rhs)
>   {
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index b348749a9fc6..dcdcb85121e4 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1306,8 +1306,7 @@ int do_settimeofday64(const struct timespec64 *ts)
>   	timekeeping_forward_now(tk);
>   
>   	xt = tk_xtime(tk);
> -	ts_delta.tv_sec = ts->tv_sec - xt.tv_sec;
> -	ts_delta.tv_nsec = ts->tv_nsec - xt.tv_nsec;
> +	ts_delta = timespec64_sub(*ts, xt);
>   
>   	if (timespec64_compare(&tk->wall_to_monotonic, &ts_delta) > 0) {
>   		ret = -EINVAL;
