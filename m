Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001DE525962
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376360AbiEMB3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355338AbiEMB3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:29:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6559A28ED34
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:29:12 -0700 (PDT)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxMNpjtH1iHYgTAA--.7956S3;
        Fri, 13 May 2022 09:29:07 +0800 (CST)
Message-ID: <69c4f018-2012-8af5-569b-289d2a8a80f5@loongson.cn>
Date:   Fri, 13 May 2022 09:29:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge
 page
Content-Language: en-US
From:   maobibo <maobibo@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
References: <20220317065024.2635069-1-maobibo@loongson.cn>
 <3a441789-b3e4-236e-2e44-e7a1c7258a94@redhat.com>
 <YmrB/7ehG2kj2RMn@xz-m1.local>
 <20220512173620.2f5175c7a321e6ccea6e58e9@linux-foundation.org>
 <8c1fc6d4-7d3a-85dd-ebd9-fc8e221f1878@loongson.cn>
In-Reply-To: <8c1fc6d4-7d3a-85dd-ebd9-fc8e221f1878@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxMNpjtH1iHYgTAA--.7956S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyUKw47Jw47Cw1UtF43Wrg_yoW8ArWrpF
        W8JF4UKF4DJFyrGwn2vwn8Zryxt397trWUXw15J348Ar90yrySqFWxA390ka9rWrs7GF4j
        yFWYqasxAw1avaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU5IksPUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/13 09:19, maobibo 写道:
> 
> 
> 在 2022/5/13 08:36, Andrew Morton 写道:
>> On Thu, 28 Apr 2022 12:34:07 -0400 Peter Xu <peterx@redhat.com> wrote:
>>
>>> On Thu, Apr 28, 2022 at 05:17:07PM +0200, David Hildenbrand wrote:
>>>> On 17.03.22 07:50, Bibo Mao wrote:
>>>>> collapse huge page will copy huge page from general small pages,
>>>>> dest node is calculated from most one of source pages, however
>>>>> THP daemon is not scheduled on dest node. The performance may be
>>>>> poor since huge page copying across nodes, also cache is not used
>>>>> for target node. With this patch, khugepaged daemon switches to
>>>>> the same numa node with huge page. It saves copying time and makes
>>>>> use of local cache better.
>>>>>
>>>>> With this patch, specint 2006 base performance is improved with 6%
>>>>> on Loongson 3C5000L platform with 32 cores and 8 numa nodes.
>>>>
>>>> If it helps, that's nice as long as it doesn't hurt other cases.
>>>>
>>
>> Quite a bit of doubtful feedback and we have yet to hear from the
>> author.  I'll drop the patch.
>>
>> Bibo, please resend at a later time if you feel the patch remains
>> desirable.  Please attempt to address the feedback via code changes
>> and/or changelogging.
> Sorry for the late response, the mail is filtered and I did not notice that. The result is not so obvious after bandwidth is improved between nodes, it is only about 1% improvement for specint2006 for 32 core on my box.
> 
> Now I do not see negative effective about this patch unless user wants to keep some cores separated from khugepaged daemon process.

Can we provide an extra parameter to let khugepaged daemon scheduling binded to node or freely? If can, I will provide updated patch.

> 
> 
> regards
> bibo,mao

