Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB0F4E5265
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiCWMqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241429AbiCWMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:45:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD647B575;
        Wed, 23 Mar 2022 05:44:28 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNp0f68fNz686sn;
        Wed, 23 Mar 2022 20:42:42 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 23 Mar 2022 13:44:25 +0100
Received: from [10.47.85.68] (10.47.85.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 12:44:24 +0000
Message-ID: <d3829e58-a835-eeec-e1a5-d282a610b228@huawei.com>
Date:   Wed, 23 Mar 2022 12:44:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: perf version issues
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <8a75f3b1-2b99-1233-3a70-070311b6ebc1@huawei.com>
 <YjotZExyiwhnX6ev@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YjotZExyiwhnX6ev@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.85.68]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 20:11, Arnaldo Carvalho de Melo wrote:

Hi Arnaldo,

> $ git cherry-pick cb66befccba18fac
>    [perf/core 8ff6a6c06a90a362] perf tools: Fix version kernel tag
>     Author: John Garry<john.garry@huawei.com>
>     Date: Mon Feb 21 21:16:49 2022 +0800
>     1 file changed, 4 insertions(+), 9 deletions(-)
>    $ make -C tools/perf O=/tmp/build/perf install-bin
>    $ perf -v
>    perf version 5.17.rc8.g4e666cdb06ee
> 
> Now it doesn´t notice it and there is no automatic rebuild triggered, we
> stay with the cset from before the cherry-pick:-\
> 
> $ git log --oneline -2
> 8ff6a6c06a90a362 (HEAD -> perf/core) perf tools: Fix version kernel tag
> 4e666cdb06eede20 perf tools: Fix dependency for version file creation
> $
> 
> Anyway, your patch works for some cases, so its an improvement and I'll
> apply it, we can continue from there.

After some experimentation, I find that only .git/HEAD changes for a 
cherry-pick depending on whether we're on a branch or not. As such, as 
you have seen, we may not rebuild after a cherry-pick, which is no good.

As far as I can see, only .git/index changes in all circumstances, but 
we don't have a dependency on that.

TBH, using .git files as Makefile dependencies doesn't seem to work well.

Maybe we should output "git log" and check versus what we have in 
PERF-VERSION-FILE and re-build depending on that.

Let me check this further now.

Thanks,
john
