Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC855C19B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbiF1Bkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiF1Bkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:40:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD81CB3F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:40:38 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LX6dv4rtLzShLw;
        Tue, 28 Jun 2022 09:37:07 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 09:40:34 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 09:40:33 +0800
Subject: Re: [PATCH] arm64: mm: fix linear mapping mem access performace
 degradation
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        <baolin.wang@linux.alibaba.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
        <jianyong.wu@arm.com>, <james.morse@arm.com>,
        <quic_qiancai@quicinc.com>, <christophe.leroy@csgroup.eu>,
        <jonathan@marek.ca>, <mark.rutland@arm.com>,
        <chenzhou10@huawei.com>, <anshuman.khandual@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <rppt@kernel.org>,
        <geert+renesas@glider.be>, <ardb@kernel.org>, <linux-mm@kvack.org>
References: <1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ad348d23-6e7f-f66b-07bc-60e57d15c441@huawei.com>
Date:   Tue, 28 Jun 2022 09:40:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/26 19:10, Guanghui Feng wrote:
> +void __init mapping_crashkernel(void)
> +{
> +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> +	    return;
> +
> +	if (!crash_mem_map || !crashk_res.end)
> +	    return;

All the code related to crash_mem_map can be removed now.

> +
> +	map_crashkernel(swapper_pg_dir, crashk_res.start,
> +			crashk_res.end + 1, PAGE_KERNEL,
> +			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +}

-- 
Regards,
  Zhen Lei
