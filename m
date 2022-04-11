Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2730C4FB98B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbiDKK3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbiDKK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:28:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFFD22CCB0;
        Mon, 11 Apr 2022 03:26:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CCF2169C;
        Mon, 11 Apr 2022 03:26:44 -0700 (PDT)
Received: from [10.1.30.132] (e127744.cambridge.arm.com [10.1.30.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B34E3F5A1;
        Mon, 11 Apr 2022 03:26:40 -0700 (PDT)
Subject: Re: [PATCH v5 3/5] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, leo.yan@linaro.org,
        acme@kernel.org
Cc:     benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-4-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <39448754-adf5-f1ba-25e7-8ee3d76f0159@arm.com>
Date:   Mon, 11 Apr 2022 11:26:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220408195344.32764-4-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/04/2022 20:53, Ali Saidi wrote:
> Add a flag to the perf mem data struct to signal that a request caused a
> cache-to-cache transfer of a line from a peer of the requestor and
> wasn't sourced from a lower cache level.  The line being moved from one
> peer cache to another has latency and performance implications. On Arm64
> Neoverse systems the data source can indicate a cache-to-cache transfer
> but not if the line is dirty or clean, so instead of overloading HITM
> define a new flag that indicates this type of transfer.

I think it's fine to merge this and the previous commit rather than have
two commits with the same msg.

>
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>  tools/include/uapi/linux/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 82858b697c05..c9e58c79f3e5 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1308,7 +1308,7 @@ union perf_mem_data_src {
>  #define PERF_MEM_SNOOP_SHIFT	19
>  
>  #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
> -/* 1 free */
> +#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
>  #define PERF_MEM_SNOOPX_SHIFT  38
>  
>  /* locked instruction */
