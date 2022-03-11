Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732814D62B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349017AbiCKOB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349018AbiCKOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:01:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90C1C4B38;
        Fri, 11 Mar 2022 06:00:17 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KFSFp1xr9z67yL5;
        Fri, 11 Mar 2022 21:58:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 11 Mar 2022 15:00:14 +0100
Received: from [10.47.87.13] (10.47.87.13) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 14:00:14 +0000
Message-ID: <a007c783-49a2-4ab3-a592-9f37ea41eaae@huawei.com>
Date:   Fri, 11 Mar 2022 14:00:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf parse-events: Fix null check
To:     Weiguo Li <liwg06@foxmail.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>
CC:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <tencent_DF39269807EC9425E24787E6DB632441A405@qq.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <tencent_DF39269807EC9425E24787E6DB632441A405@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.13]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 13:06, Weiguo Li wrote:
> We did a null check after "tmp->symbol = strdup(...)", but we checked
> "list->symbol" other than "tmp->symbol".
> 
> Signed-off-by: Weiguo Li <liwg06@foxmail.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   tools/perf/util/parse-events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9739b05b999e..dfb50a5f83d0 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2193,7 +2193,7 @@ int perf_pmu__test_parse_init(void)
>   	for (i = 0; i < ARRAY_SIZE(symbols); i++, tmp++) {
>   		tmp->type = symbols[i].type;
>   		tmp->symbol = strdup(symbols[i].symbol);
> -		if (!list->symbol)
> +		if (!tmp->symbol)
>   			goto err_free;
>   	}
>   

