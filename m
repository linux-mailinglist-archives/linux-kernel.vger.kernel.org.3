Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9566958599C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiG3Jb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiG3Jb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:31:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9999B1C925
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:31:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LvzZP1YTpzWfD9;
        Sat, 30 Jul 2022 17:27:57 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 17:31:53 +0800
Subject: Re: [PATCH v3] mm: memory-failure: convert to pr_fmt()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
CC:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220729031919.72331-1-wangkefeng.wang@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e699cd23-3eeb-7920-accd-b30622efa551@huawei.com>
Date:   Sat, 30 Jul 2022 17:31:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220729031919.72331-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/29 11:19, Kefeng Wang wrote:
> Use pr_fmt to prefix all pr_<level> output, but unpoison_memory()
> and soft_offline_page() are used by error injection, which have
> own prefixes like "Unpoison:" and "soft offline:", meanwhile,
> soft_offline_page() could be used by memory hotremove, so reset
> pr_fmt before unpoison_pr_info definition to keep the original
> output for them.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I'm sorry but this patch will make pr_info in try_to_split_thp_page looks like below?

Memory failure: Memory failure: 0x1b8200: thp split failed
or
Memory failure: soft offline: 0x1b8200: thp split failed

Thanks.
