Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2EE4FBAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbiDKLSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbiDKLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5794D1A04E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649675745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=msXNJ8h0FYhrCrAYwO7HXeuuoij9Poi1tkT6dYtR+PA=;
        b=ij56sl8/trC4ztOY5eB0+bZWsTVrxL2Xxn5UibN4QB+DkCPjOflXPlxxzl0BfipF0nZj3K
        m9G6I7KcjRO3PZelrBM71bs5n8lZfquifArtvQGt9Fv/nkFGWGa/qpC+TCz1q9HaIWfcbQ
        tOIzE2Xu9ioiW/4u17orVPYDhVEVPyY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-Jz2AuREDMe-WFAyY5-UqBw-1; Mon, 11 Apr 2022 07:15:45 -0400
X-MC-Unique: Jz2AuREDMe-WFAyY5-UqBw-1
Received: by mail-ej1-f70.google.com with SMTP id dp12-20020a170906c14c00b006e7e8234ae2so1164438ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=msXNJ8h0FYhrCrAYwO7HXeuuoij9Poi1tkT6dYtR+PA=;
        b=I6q0pqYNgIdEuDoiBopPsakuu57YyGKbWV2Mpmq9YfcDQSvLXKRMK21loOYUdohKhe
         hajBNoVDpSBHwJT8IeFglWwntGJTxTbBwK6F6ZqSn2sKw8HykPLCkQIlhUUX7uocRgAc
         hjZ1f5NjrtDdastr+11Th6XLond327A79USpbGJhlwupPcTj/4pYGTUG95CLCAgafNuq
         000lyHmkxF+pLfzATXWT+w4OBYWXtJy7EELdQSyvHKXKewJmY+gt9Ao2/LFe3mValnTe
         4+zMCEQGK/ClllA14FXrBXX1ovI+q4XgMGF1uDPbKrHx7WuSgpz0LOzRJgRmFCn9LupF
         cbJQ==
X-Gm-Message-State: AOAM531FmYh02mtQVoX9s1LCDGjpeAxjF+uqN4zBnYdZ8zmsF1NfwdeC
        5ZvAg1CBxru4LKb+jDAWIHpShpe0+VE6ESt4zyoxfPtCjbIbZQAaJnSK0CR/Ps1e8rPTFMOGE7Z
        OCcg8pmDvfpDeeal1bNRs5Q/KLK0SYFnBUO5awOf6qJ0PWQXeIfrOVH3tAaFIoX9XGUUwJ21ZCi
        Qx
X-Received: by 2002:a17:907:7810:b0:6e7:ef73:8326 with SMTP id la16-20020a170907781000b006e7ef738326mr28715914ejc.429.1649675743781;
        Mon, 11 Apr 2022 04:15:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6SQkwbzBJ5GEmB126naOTwG4eR/zEXAMc9jswD0Z3i0ETMI1ZnBKUbmI9OlVL/DWbdnUWgg==
X-Received: by 2002:a17:907:7810:b0:6e7:ef73:8326 with SMTP id la16-20020a170907781000b006e7ef738326mr28715849ejc.429.1649675742799;
        Mon, 11 Apr 2022 04:15:42 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id br14-20020a170906d14e00b006e88db05620sm1488070ejb.146.2022.04.11.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:15:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/31] KVM: x86: hyper-v: Handle
 HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently
In-Reply-To: <Yk8gTB+x2UVE34Ds@google.com>
References: <20220407155645.940890-1-vkuznets@redhat.com>
 <20220407155645.940890-4-vkuznets@redhat.com>
 <Yk8gTB+x2UVE34Ds@google.com>
Date:   Mon, 11 Apr 2022 13:15:41 +0200
Message-ID: <87h76z7twi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Apr 07, 2022, Vitaly Kuznetsov wrote:

...

Thanks a lot for the review! I'll incorporate your feedback into v3.

>>  
>>  static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>> @@ -1857,12 +1940,13 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>>  	struct hv_tlb_flush_ex flush_ex;
>>  	struct hv_tlb_flush flush;
>>  	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
>> +	u64 entries[KVM_HV_TLB_FLUSH_RING_SIZE - 2];
>
> What's up with the -2?

(This should probably be a define or at least a comment somewhere)

Normally, we can only put 'KVM_HV_TLB_FLUSH_RING_SIZE - 1' entries on
the ring as when read_idx == write_idx we percieve this as 'ring is
empty' and not as 'ring is full'. For the TLB flush ring we must always
leave one free entry to put "flush all" request when we run out of
free space to avoid blocking the writer. I.e. when a request flies in,
we check if we have enough space on the ring to put all the entries and
if not, we just put 'flush all' there. In case 'flush all' is already on
the ring, ignoring the request is safe.

So, long story short, there's no point in fetching more than
'KVM_HV_TLB_FLUSH_RING_SIZE - 2' entries from the guest as we can't
possibly put them all on the ring.

[snip]

-- 
Vitaly

