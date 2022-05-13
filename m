Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D652598E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356214AbiEMB7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244677AbiEMB7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:59:14 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9C3E17909B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:59:11 -0700 (PDT)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxCtlru31ipZATAA--.3480S3;
        Fri, 13 May 2022 09:59:07 +0800 (CST)
Message-ID: <28f69c51-0778-56f3-62fd-172b60a039d8@loongson.cn>
Date:   Fri, 13 May 2022 09:59:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge
 page
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>
References: <20220317065024.2635069-1-maobibo@loongson.cn>
 <3a441789-b3e4-236e-2e44-e7a1c7258a94@redhat.com>
 <YmrB/7ehG2kj2RMn@xz-m1.local>
 <20220512173620.2f5175c7a321e6ccea6e58e9@linux-foundation.org>
 <8c1fc6d4-7d3a-85dd-ebd9-fc8e221f1878@loongson.cn>
 <69c4f018-2012-8af5-569b-289d2a8a80f5@loongson.cn>
 <20220512184908.0852e1efcb6fd78aea52b557@linux-foundation.org>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <20220512184908.0852e1efcb6fd78aea52b557@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxCtlru31ipZATAA--.3480S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWrGw1xJFWkCF45XrWDJwb_yoWfKrX_Xr
        4UuF1DJw4UJFW8ta9xK3s3XFsrt3yY9r15ua4UX3W2qa4qqFW3ZF12gF92k34rWF42kwsF
        ga4ktayayF9I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIkYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07beAp5UUUUU=
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/13 09:49, Andrew Morton 写道:
> On Fri, 13 May 2022 09:29:07 +0800 maobibo <maobibo@loongson.cn> wrote:
> 
>>
>>
>>>> and/or changelogging.
>>> Sorry for the late response, the mail is filtered and I did not notice that. The result is not so obvious after bandwidth is improved between nodes, it is only about 1% improvement for specint2006 for 32 core on my box.
>>>
>>> Now I do not see negative effective about this patch unless user wants to keep some cores separated from khugepaged daemon process.
>>
>> Can we provide an extra parameter to let khugepaged daemon scheduling binded to node or freely? If can, I will provide updated patch.
> 
> It has always surprised me that we have a single khugepaged thread.  If
> we had a thread per node, you'd be all fixed up, yes?
yes, it will solve this issue if there is a thread per node, also it can speed up huge page scanning. It should be useful for some workloads in short time like specint.
> 
> Ditto ksmd.

