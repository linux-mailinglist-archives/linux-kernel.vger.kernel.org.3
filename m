Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6044A5A40F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 04:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiH2CMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 22:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiH2CMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 22:12:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF483C8DB
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 19:12:18 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGDPZ5tDLzkWjQ;
        Mon, 29 Aug 2022 10:08:34 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 10:12:11 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 10:12:10 +0800
Subject: Re: [PATCH -next v3 2/5] frontswap: invoke ops->init for online swap
 device in frontswap_register_ops
To:     Vitaly Wool <vitaly.wool@konsulko.com>
References: <20220827104600.1813214-1-liushixin2@huawei.com>
 <20220827104600.1813214-3-liushixin2@huawei.com>
 <CAM4kBB+-f+TF4=q5SdxHiKPdtAO7KWDGac9vNQb9rR0rUUjYrA@mail.gmail.com>
CC:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <98b709b5-6a0c-0d6f-0aa7-24c68aaf26aa@huawei.com>
Date:   Mon, 29 Aug 2022 10:12:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAM4kBB+-f+TF4=q5SdxHiKPdtAO7KWDGac9vNQb9rR0rUUjYrA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/29 4:47, Vitaly Wool wrote:
> On Sat, Aug 27, 2022 at 12:12 PM Liu Shixin <liushixin2@huawei.com> wrote:
>> Since we are supported to delay zswap initializaton, we need to invoke
>> ops->init for the swap device which is already online when register
>> backend.
>>
>> This patch is a revert of f328c1d16e4c ("frontswap: simplify frontswap_register_ops")
>> and 633423a09cb5 ("mm: mark swap_lock and swap_active_head static")
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Sorry, is this the revert of 2 patches at the same time? I would
> rather not do it like that.
>
> Thanks,
> Vitaly
Thanks for your advice, I'll split it to two patches and resend it.
>> ---
>>  include/linux/swapfile.h |  2 ++
>>  mm/frontswap.c           | 47 ++++++++++++++++++++++++++++++++++++++++
>>  mm/swapfile.c            |  4 ++--
>>  3 files changed, 51 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
>> index 2fbcc9afd814..75fc069594a5 100644
>> --- a/include/linux/swapfile.h
>> +++ b/include/linux/swapfile.h
>> @@ -6,6 +6,8 @@
>>   * these were static in swapfile.c but frontswap.c needs them and we don't
>>   * want to expose them to the dozens of source files that include swap.h
>>   */
>> +extern spinlock_t swap_lock;
>> +extern struct plist_head swap_active_head;
>>  extern struct swap_info_struct *swap_info[];
>>  extern unsigned long generic_max_swapfile_size(void);
>>  /* Maximum swapfile size supported for the arch (not inclusive). */
>> diff --git a/mm/frontswap.c b/mm/frontswap.c
>> index 620f95af81dd..449e6f499b88 100644
>> --- a/mm/frontswap.c
>> +++ b/mm/frontswap.c
>> @@ -96,11 +96,58 @@ static inline void inc_frontswap_invalidates(void) { }
>>   */
>>  int frontswap_register_ops(const struct frontswap_ops *ops)
>>  {
>> +       DECLARE_BITMAP(a, MAX_SWAPFILES);
>> +       DECLARE_BITMAP(b, MAX_SWAPFILES);
>> +       struct swap_info_struct *si;
>> +       unsigned int i;
>> +
>>         if (frontswap_ops)
>>                 return -EINVAL;
>>
>> +       bitmap_zero(a, MAX_SWAPFILES);
>> +       bitmap_zero(b, MAX_SWAPFILES);
>> +
>> +       spin_lock(&swap_lock);
>> +       plist_for_each_entry(si, &swap_active_head, list) {
>> +               if (!WARN_ON(!si->frontswap_map))
>> +                       __set_bit(si->type, a);
>> +       }
>> +       spin_unlock(&swap_lock);
>> +
>> +       /* the new ops needs to know the currently active swap devices */
>> +       for_each_set_bit(i, a, MAX_SWAPFILES) {
>> +               pr_err("init frontswap_ops\n");
>> +               ops->init(i);
>> +       }
>> +
>>         frontswap_ops = ops;
>>         static_branch_inc(&frontswap_enabled_key);
>> +
>> +       spin_lock(&swap_lock);
>> +       plist_for_each_entry(si, &swap_active_head, list) {
>> +               if (si->frontswap_map)
>> +                       __set_bit(si->type, b);
>> +       }
>> +       spin_unlock(&swap_lock);
>> +
>> +       /*
>> +        * On the very unlikely chance that a swap device was added or
>> +        * removed between setting the "a" list bits and the ops init
>> +        * calls, we re-check and do init or invalidate for any changed
>> +        * bits.
>> +        */
>> +       if (unlikely(!bitmap_equal(a, b, MAX_SWAPFILES))) {
>> +               for (i = 0; i < MAX_SWAPFILES; i++) {
>> +                       if (!test_bit(i, a) && test_bit(i, b)) {
>> +                               pr_err("init frontswap_ops re\n");
>> +                               ops->init(i);
>> +                       } else if (test_bit(i, a) && !test_bit(i, b)) {
>> +                               pr_err("inval frontswap_ops re\n");
>> +                               ops->invalidate_area(i);
>> +                       }
>> +               }
>> +       }
>> +
>>         return 0;
>>  }
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 469d9af86be2..d383b282f269 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -51,7 +51,7 @@ static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>>                                  unsigned char);
>>  static void free_swap_count_continuations(struct swap_info_struct *);
>>
>> -static DEFINE_SPINLOCK(swap_lock);
>> +DEFINE_SPINLOCK(swap_lock);
>>  static unsigned int nr_swapfiles;
>>  atomic_long_t nr_swap_pages;
>>  /*
>> @@ -77,7 +77,7 @@ static const char Unused_offset[] = "Unused swap offset entry ";
>>   * all active swap_info_structs
>>   * protected with swap_lock, and ordered by priority.
>>   */
>> -static PLIST_HEAD(swap_active_head);
>> +PLIST_HEAD(swap_active_head);
>>
>>  /*
>>   * all available (active, not full) swap_info_structs
>> --
>> 2.25.1
>>
> .
>

