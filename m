Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3644E4B2B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbiBKRNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:13:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352010AbiBKRNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:13:23 -0500
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C09BD6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:13:20 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id IZTkni5cbeHnVIZTlnZbwN; Fri, 11 Feb 2022 18:13:18 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 11 Feb 2022 18:13:18 +0100
X-ME-IP: 90.126.236.122
Message-ID: <ea4efad6-a15c-3749-f177-640396b52857@wanadoo.fr>
Date:   Fri, 11 Feb 2022 18:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 07/49] KVM: x86: replace bitmap_weight with bitmap_empty
 where appropriate
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-8-yury.norov@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220210224933.379149-8-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/02/2022 à 23:48, Yury Norov a écrit :
> In some places kvm/hyperv.c code calls bitmap_weight() to check if any bit
> of a given bitmap is set. It's better to use bitmap_empty() in that case
> because bitmap_empty() stops traversing the bitmap as soon as it finds
> first set bit, while bitmap_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/hyperv.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 6e38a7d22e97..06c2a5603123 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -90,7 +90,7 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>   {
>   	struct kvm_vcpu *vcpu = hv_synic_to_vcpu(synic);
>   	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
> -	int auto_eoi_old, auto_eoi_new;
> +	bool auto_eoi_old, auto_eoi_new;
>   
>   	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
>   		return;
> @@ -100,16 +100,16 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>   	else
>   		__clear_bit(vector, synic->vec_bitmap);
>   
> -	auto_eoi_old = bitmap_weight(synic->auto_eoi_bitmap, 256);
> +	auto_eoi_old = !bitmap_empty(synic->auto_eoi_bitmap, 256);

I think that you can also remove the "!" here, ...

>   
>   	if (synic_has_vector_auto_eoi(synic, vector))
>   		__set_bit(vector, synic->auto_eoi_bitmap);
>   	else
>   		__clear_bit(vector, synic->auto_eoi_bitmap);
>   
> -	auto_eoi_new = bitmap_weight(synic->auto_eoi_bitmap, 256);
> +	auto_eoi_new = !bitmap_empty(synic->auto_eoi_bitmap, 256);

... and there...

>   
> -	if (!!auto_eoi_old == !!auto_eoi_new)
> +	if (auto_eoi_old == auto_eoi_new)

... because this test would still give the same result.

Just my 2c,
CJ

>   		return;
>   
>   	down_write(&vcpu->kvm->arch.apicv_update_lock);

