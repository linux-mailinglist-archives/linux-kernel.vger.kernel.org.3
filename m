Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919C6515B5D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiD3IP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiD3IPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7119C5E777
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651306320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fU7Z+q92leOT4vuuZNlugAe89BeML8kiQw/jyBkx1XI=;
        b=RZtyDv4jKEtG5KATdbTpSeVCUx86pFtcOf3nVpanmvIp3c6xgeSGJQukulG2oGMKKyIu/k
        dpN7RQA0oU6AsSAvVl8ue0lw9XL0pGfPxeMC2Sl7ysogtvo+XNYyEur6db0upXZTY+Gz2Q
        Fe/IrJPtBA47dRpaNdi1Y3IfoUu13iQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-HvdlGZasOsuJlDNzGVlXTQ-1; Sat, 30 Apr 2022 04:11:59 -0400
X-MC-Unique: HvdlGZasOsuJlDNzGVlXTQ-1
Received: by mail-ej1-f69.google.com with SMTP id l20-20020a170906795400b006f3f30daf18so1973303ejo.22
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fU7Z+q92leOT4vuuZNlugAe89BeML8kiQw/jyBkx1XI=;
        b=uSk9doCRu5m1E1+vZYmAAcxC0Bu+aRazGX1bKEFqEgoN3XywZap3Wj+imnPzK4YvT5
         ncm9CMT7IMLBw6dSoZMRoPkDi1/EoZmXGjKSsHaO0FAnOJ6KBaMJ65iBI4lFkgjuraHe
         2S4FwO6ZjBisfCdwZIKDtquQAus27fewUcVJ/HDZaZgKRoV09L1AuKCGaTfbxNxTrwWR
         QjLMlcfJ/PkY2at5J+WQ+SmYVP17y9riGmhLebPJOkK96SYti1OK0yjDBuZpocIQ+2ZQ
         OXXWV+dMvO05IaxEvLpxSe48xBLiVc9wK3aTYyKuMGyIewyZOajakqwaXR712kxo1DHD
         jqtA==
X-Gm-Message-State: AOAM530xLqLgJKQmXXChuVrK6LuHiOA0Sun9rII00zjqWfYWTKsfP45u
        oU1pcYl7h85Sb+aLDzkIW5F66SvNggESU+Uc9ahcHWrt1sE3MFTJZ0ztUAZjbW6Lb7Z03jl2Ct5
        aD2n63fmvmkvAFX1AQ8s/l/p5
X-Received: by 2002:a05:6402:1e92:b0:426:258:cf51 with SMTP id f18-20020a0564021e9200b004260258cf51mr3511807edf.124.1651306317889;
        Sat, 30 Apr 2022 01:11:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBc3Rhd7Z8pSjvvWd+/FVAfTZPTCiykZQah+JtLK3LoH9Jg7cxxGVABVZbwNuJkBwNepnmKw==
X-Received: by 2002:a05:6402:1e92:b0:426:258:cf51 with SMTP id f18-20020a0564021e9200b004260258cf51mr3511795edf.124.1651306317712;
        Sat, 30 Apr 2022 01:11:57 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id g14-20020a056402180e00b0042617ba6389sm3804614edy.19.2022.04.30.01.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 01:11:57 -0700 (PDT)
Message-ID: <0b18fbcb-97d6-fb82-25b4-1f288a65b78f@redhat.com>
Date:   Sat, 30 Apr 2022 10:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] KVM: SEV: Mark nested locking of vcpu->lock
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220407195908.633003-1-pgonda@google.com>
 <CAFNjLiXC0AdOw5f8Ovu47D==ex7F0=WN_Ocirymz4xL=mWvC5A@mail.gmail.com>
 <CAMkAt6r-Mc_YN-gVHuCpTj4E1EmcvyYpP9jhtHo5HRHnoNJAdA@mail.gmail.com>
 <CAMkAt6r+OMPWCbV_svUyGWa0qMzjj2UEG29G6P7jb6uH6yko2w@mail.gmail.com>
 <62e9ece1-5d71-f803-3f65-2755160cf1d1@redhat.com>
 <CAMkAt6q6YLBfo2RceduSXTafckEehawhD4K4hUEuB4ZNqe2kKg@mail.gmail.com>
 <4c0edc90-36a1-4f4c-1923-4b20e7bdbb4c@redhat.com>
 <CAMkAt6oL5qi7z-eh4z7z8WBhpc=Ow6WtcJA5bDi6-aGMnz135A@mail.gmail.com>
 <CAMkAt6rmDrZfN5DbNOTsKFV57PwEnK2zxgBTCbEPeE206+5v5w@mail.gmail.com>
 <20220429010312.4013-1-hdanton@sina.com>
 <20220429114012.4127-1-hdanton@sina.com>
 <20220430015008.4257-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220430015008.4257-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/22 03:50, Hillf Danton wrote:
> 	lock for migration
> 	===
> 	kvm_for_each_vcpu(i, vcpu, kvm) {
> 		if (mutex_lock_killable(&vcpu->mutex))
> 			goto out_unlock;
> 		lockdep_copy_map(&vcpu->v_dep_map, &vcpu->mutex.dep_map);
> 		mutex_release(&vcpu->mutex.dep_map, ip);
> 	}
> 
> 
> 	unlock for migration
> 	===
> 	kvm_for_each_vcpu(i, vcpu, kvm) {
> 		lockdep_copy_map(&vcpu->mutex.dep_map, &vcpu->v_dep_map);
> 		/*
> 		 * Or directly acquire without v_dep_map added
> 		 *
> 		mutex_acquire(&vcpu->mutex.dep_map, 0, 1,_RET_IP_);
> 		 */
> 		mutex_unlock(&vcpu->mutex);
> 	}

Yes this is exactly what Peter is doing, except that we're trying to 
keep one lock taken.  Thanks for pointing to lock_sock_nested().

Paolo

