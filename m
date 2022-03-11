Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020704D5F37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347747AbiCKKOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbiCKKOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:14:03 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C44931BF92A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:12:58 -0800 (PST)
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxusylICtiOUoHAA--.3045S3;
        Fri, 11 Mar 2022 18:12:53 +0800 (CST)
Subject: Re: [PATCH] mm/khugepaged: sched to numa node when collapse huge page
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220311090119.2412738-1-maobibo@loongson.cn>
 <52412f08-829a-6c29-60c6-a24c866e6253@redhat.com>
 <d2883450-1278-877e-e273-bda5a5728465@loongson.cn>
 <caf087b4-b184-c45e-e212-87f0a573a4d0@redhat.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <9d8b5ced-5350-9201-079f-47cbb4f587b3@loongson.cn>
Date:   Fri, 11 Mar 2022 18:12:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <caf087b4-b184-c45e-e212-87f0a573a4d0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxusylICtiOUoHAA--.3045S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKryrKrykZF1kZF45CFyfJFb_yoWDKrX_uF
        4DCw1xu34UZ3yxJFs5t348XrnxJa1kX3s5Jry5Jws7X34fXFZIqF429rW0vwn3K3y3Cr47
        u3sIva1fJrZIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUcVWlDUUUU
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/2022 05:55 PM, David Hildenbrand wrote:
> On 11.03.22 10:51, maobibo wrote:
>>
>>
>> On 03/11/2022 05:20 PM, David Hildenbrand wrote:
>>> On 11.03.22 10:01, Bibo Mao wrote:
>>>> collapse huge page is slow, specially when khugepaged daemon runs
>>>> on different numa node with that of huge page. It suffers from
>>>> huge page copying across nodes, also cache is not used for target
>>>> node. With this patch, khugepaged daemon switches to the same numa
>>>> node with huge page. It saves copying time and makes use of local
>>>> cache better.
>>>
>>> Hi,
>>>
>>> just the usual question, do you have any performance numbers to back
>>> your claims (e.g., "is slow, specially when") and proof that this patch
>>> does the trick?
>> With specint 2006 on loongarch 3C5000L 32core numa system, it improves
>> about 6%. The page size is 16K and pmd page size is 32M, memory performance
>> across numa node is obvious different. However I do not test it on x86 box.
>>
> 
> Thanks, can you add these details to the patch description?
Surely, will do in next patch.

regards
bibo, mao
> 
> 

