Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C872B54E21A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377119AbiFPNgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377107AbiFPNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:36:54 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20A80255B5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:36:52 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH0zyMatiP2lGAA--.240S3;
        Thu, 16 Jun 2022 21:36:50 +0800 (CST)
Subject: Re: [RFC PATCH v3 3/3] LoongArch: No need to call RESTORE_ALL_AND_RET
 for all syscalls
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1655288973-6066-1-git-send-email-yangtiezhu@loongson.cn>
 <1655288973-6066-4-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7ULiOUP-7RfLvQb2mOKt7NtqKUxipkfXdbkPGgzEptrQ@mail.gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>,
        LKML <linux-kernel@vger.kernel.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8ca2304f-37ac-131c-1564-1aede2a47b74@loongson.cn>
Date:   Thu, 16 Jun 2022 21:36:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7ULiOUP-7RfLvQb2mOKt7NtqKUxipkfXdbkPGgzEptrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxH0zyMatiP2lGAA--.240S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF48KrWkKFyUGry3CFyrtFb_yoW3uFgE9w
        1DKrs7Gw1DJr47X3Z8GF1rXFnrtaykur48urs7W3ySy34UXrWfArnrKFykJ3ZrJrWfZr17
        ur4jg34Fvr1YkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUa385UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/16/2022 08:52 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Wed, Jun 15, 2022 at 6:29 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> In handle_syscall, it is unnecessary to call RESTORE_ALL_AND_RET
>> for all syscalls.
>>
>> (1) clone and clone3 call RESTORE_STATIC_SOME_SP_AND_RET.
>> (2) rt_sigreturn and rt_sigsuspend call RESTORE_TEMP_SOME_SP_AND_RET.
> I doubt that you have not tested, it is obvious that rt_sigreturn need
> RESTORE_ALL.

Yes, your guess is right. :)

I have no workable machine to update the upstream kernel now, only 
compile test.

I will try my best to find a workable machine and then test it,
there is a good test case written by Rui Wang [1].

This patch is RFC, any comments will be much appreciated, thank you.

[1] https://github.com/hevz/sigaction-test

Thanks,
Tiezhu

