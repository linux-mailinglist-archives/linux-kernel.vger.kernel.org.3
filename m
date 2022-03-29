Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899524EA7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiC2GQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiC2GQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:16:07 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7ADD9549A;
        Mon, 28 Mar 2022 23:14:23 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 6261E1E80D78;
        Tue, 29 Mar 2022 14:13:47 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BrCJMHfyAm77; Tue, 29 Mar 2022 14:13:44 +0800 (CST)
Received: from [18.165.124.108] (unknown [101.228.248.165])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id EB7331E80D75;
        Tue, 29 Mar 2022 14:13:43 +0800 (CST)
Message-ID: <0f4cf955-ca2b-626f-867e-5a0ecfe68ca1@nfschina.com>
Date:   Tue, 29 Mar 2022 14:14:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] KVM: arm64: vgic-debug: remove unnecessary type castings
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        kernel-janitors@vger.kernel.org
References: <20220328103836.2829-1-yuzhe@nfschina.com>
 <87h77ifbbd.wl-maz@kernel.org>
From:   yuzhe <yuzhe@nfschina.com>
In-Reply-To: <87h77ifbbd.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/3/28 21:36, Marc Zyngier 写道:

> On Mon, 28 Mar 2022 11:38:36 +0100,
> yuzhe <yuzhe@nfschina.com> wrote:
>> remove unnecessary castings, from "void *" to "struct kvm *"
>>
>> Signed-off-by: yuzhe <yuzhe@nfschina.com>
>> ---
>>   arch/arm64/kvm/vgic/vgic-debug.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
>> index f38c40a76251..927e5c1f650d 100644
>> --- a/arch/arm64/kvm/vgic/vgic-debug.c
>> +++ b/arch/arm64/kvm/vgic/vgic-debug.c
>> @@ -82,7 +82,7 @@ static bool end_of_vgic(struct vgic_state_iter *iter)
>>   
>>   static void *vgic_debug_start(struct seq_file *s, loff_t *pos)
>>   {
>> -	struct kvm *kvm = (struct kvm *)s->private;
>> +	struct kvm *kvm = s->private;
>>   	struct vgic_state_iter *iter;
>>   
>>   	mutex_lock(&kvm->lock);
>> @@ -110,7 +110,7 @@ static void *vgic_debug_start(struct seq_file *s, loff_t *pos)
>>   
>>   static void *vgic_debug_next(struct seq_file *s, void *v, loff_t *pos)
>>   {
>> -	struct kvm *kvm = (struct kvm *)s->private;
>> +	struct kvm *kvm = s->private;
>>   	struct vgic_state_iter *iter = kvm->arch.vgic.iter;
>>   
>>   	++*pos;
>> @@ -122,7 +122,7 @@ static void *vgic_debug_next(struct seq_file *s, void *v, loff_t *pos)
>>   
>>   static void vgic_debug_stop(struct seq_file *s, void *v)
>>   {
>> -	struct kvm *kvm = (struct kvm *)s->private;
>> +	struct kvm *kvm = s->private;
>>   	struct vgic_state_iter *iter;
>>   
>>   	/*
>> @@ -229,7 +229,7 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
>>   
>>   static int vgic_debug_show(struct seq_file *s, void *v)
>>   {
>> -	struct kvm *kvm = (struct kvm *)s->private;
>> +	struct kvm *kvm = s->private;
>>   	struct vgic_state_iter *iter = (struct vgic_state_iter *)v;
> How about you fully get rid of the unnecessary casts then?
>
> 	M.

I don't know what you exactly mean. I follow the kernel-janitors/TODO List to get rid of the unnecessary casts.
And I checked all the code in the arch directory and found these issues.

