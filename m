Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B8F4DBC10
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355823AbiCQBKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiCQBKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:10:37 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8DE11D303
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:09:21 -0700 (PDT)
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx3888ijJiA4cKAA--.31540S3;
        Thu, 17 Mar 2022 09:09:17 +0800 (CST)
Subject: Re: [PATCH] mm: add access/dirty bit on numa page fault
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220316010836.1137084-1-maobibo@loongson.cn>
 <93302a47-9fda-25c7-4212-41b8dd027696@arm.com>
 <3756661c-d710-7bf6-76ab-39ac44f8e8b3@loongson.cn>
 <dad20ecc-efcd-4d3b-9d60-b5ad0b2c2c4b@arm.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <4bb3e4ef-29f9-448b-22ad-1ae7c2d008ff@loongson.cn>
Date:   Thu, 17 Mar 2022 09:09:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dad20ecc-efcd-4d3b-9d60-b5ad0b2c2c4b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx3888ijJiA4cKAA--.31540S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4DuryruFWftw18uFyDKFg_yoWDGwc_ua
        1F9w4qk3WDtFnFk3Wvvr45J39xXa1DJry5tr4jgryIg343J3yUGr93WrZYqFs8GFsrtFWU
        Grn0vr43Z3ZIqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
        PpnJUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/16/2022 05:42 PM, Anshuman Khandual wrote:
> 
> 
> On 3/16/22 12:33, maobibo wrote:
>>
>> On 03/16/2022 02:43 PM, Anshuman Khandual wrote:
>>>
>>> On 3/16/22 06:38, Bibo Mao wrote:
>>>> During numa page fault, dirty bit can be added for old pte if
>>>> fail to migrate on write fault. And if it succeeds to migrate,
>>>> access bit can be added for migrated new pte, also dirty bit
>>>> can be added for write fault.
>>> The current code does not set the access and dirty bits when ever
>>> applicable i.e on FAULT_FLAG_WRITE, on the pte (old if migration
>>> fails, new if migration succeeds) ? Did not this cause any problem
>>> earlier ? I am wondering how this might have gone unnoticed.
> 
>> On arm/x86 platform hw will set access/dirty bits automatically,
>> however on MIPS platform access/dirty bits are set by software in next
>> page fault, it is relatively easier to watch on MIPS platform.
> 
> Could you please update this in the commit message as well ?

sure, will do. 

regards
bibo, mao

