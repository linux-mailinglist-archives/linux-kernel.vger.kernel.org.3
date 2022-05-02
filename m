Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF651761C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386744AbiEBRtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386738AbiEBRtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AD9B6448
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651513536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpWtnU28DeMLlZx+0CF26u0/lqm9paj6qvzL5cYPTzY=;
        b=aoix2u2FzHT9dSo6N3teaaUWMwq+ZukKFyXTsSiXahBXq5p+Cq5uzPaWTq+fUCQjADmlNM
        mnW3BaknatT5ZEtTZV8y+MNf7LrUFwMRL07skCceyc0NNEqhhsfB9AtcECt6rsZ/Q/1bET
        gSpKXAwFNcf0UtmOO4huGCa2R5o14yg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-8DZ1PbNdONGRTdkr9khnLA-1; Mon, 02 May 2022 13:45:35 -0400
X-MC-Unique: 8DZ1PbNdONGRTdkr9khnLA-1
Received: by mail-ed1-f72.google.com with SMTP id b24-20020a50e798000000b0041631767675so9095077edn.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZpWtnU28DeMLlZx+0CF26u0/lqm9paj6qvzL5cYPTzY=;
        b=kQwcAqqgthBTJppj5DTMAFkeVpQ085iA0vFFJoKKI8qe1sHhRId73TVxqdsnXR0YIW
         9ftVSgNqOpKfWMHm66H3lqY2Xg74HEEQRoVMoVlStpT5+QerAt+koBLLoXXCpuVjQFcX
         UUv4YMS3x8xzjh/dBjbyk1HNHziAMSx3mwMOCFbIZN5EGu5Yx7uYZSzmuxaEFJiLMCKW
         BxDJXvhDB8aZWBakVSYLEc6X8D1OME9fuCRul2QA43/ANPRCKEdcSfrs6x3ltCxUnm4y
         VSzTx0whHkAs/q6C52ftN77Ko9dfCnXOgVNNggeA9mVffvsMLJAZIwx2oBtbXUp2wA57
         9/yg==
X-Gm-Message-State: AOAM530i7XlOIOJZQLkIZ7xLIe9xswht/4Vks16cYDCsNw4ZrMErwVnd
        fFs+vuJrqYlu0Y5Vy6MQG/rfw3h01topir4ZMwsS+xHo9hlBSTtOoQnd9q3m1Fme+RJxbu7pSLi
        qQgEtUucT4gY9xsimk9vHhICU
X-Received: by 2002:a05:6402:b4d:b0:425:ec4a:a37e with SMTP id bx13-20020a0564020b4d00b00425ec4aa37emr14220527edb.292.1651513533711;
        Mon, 02 May 2022 10:45:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVrLFuHmAYZ/x2elNEJveRt7ttFsZaihrGxO8iC2geGMkN3uJQP2EAc8iuaFAz0U/8B26UUQ==
X-Received: by 2002:a05:6402:b4d:b0:425:ec4a:a37e with SMTP id bx13-20020a0564020b4d00b00425ec4aa37emr14220501edb.292.1651513533309;
        Mon, 02 May 2022 10:45:33 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id mm9-20020a170906cc4900b006f3ef214dd9sm3776233ejb.63.2022.05.02.10.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:45:32 -0700 (PDT)
Message-ID: <93a99e53-abf6-db1b-f610-e94cd8d93a5c@redhat.com>
Date:   Mon, 2 May 2022 19:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4] KVM: SEV: Mark nested locking of vcpu->lock
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>, kvm@vger.kernel.org
Cc:     John Sperbeck <jsperbeck@google.com>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org
References: <20220502165807.529624-1-pgonda@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220502165807.529624-1-pgonda@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 18:58, Peter Gonda wrote:
> svm_vm_migrate_from() uses sev_lock_vcpus_for_migration() to lock all
> source and target vcpu->locks. Unfortunately there is an 8 subclass
> limit, so a new subclass cannot be used for each vCPU. Instead maintain
> ownership of the first vcpu's mutex.dep_map using a role specific
> subclass: source vs target. Release the other vcpu's mutex.dep_maps.
> 
> Fixes: b56639318bb2b ("KVM: SEV: Add support for SEV intra host migration")
> Reported-by: John Sperbeck<jsperbeck@google.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Gonda <pgonda@google.com>

Looks good, thanks!

Paolo

> ---
> 
> V4
>   * Due to 8 subclass limit keep dep_map on only the first vcpu and
>     release the others.
> 
> V3
>   * Updated signature to enum to self-document argument.
>   * Updated comment as Seanjc@ suggested.
> 
> Tested by running sev_migrate_tests with lockdep enabled. Before we see
> a warning from sev_lock_vcpus_for_migration(). After we get no warnings.
> 
> ---
>   arch/x86/kvm/svm/sev.c | 46 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 75fa6dd268f0..0239def64eaa 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1591,24 +1591,55 @@ static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
>   	atomic_set_release(&src_sev->migration_in_progress, 0);
>   }
>   
> +/*
> + * To suppress lockdep false positives, subclass all vCPU mutex locks by
> + * assigning even numbers to the source vCPUs and odd numbers to destination
> + * vCPUs based on the vCPU's index.
> + */
> +enum sev_migration_role {
> +	SEV_MIGRATION_SOURCE = 0,
> +	SEV_MIGRATION_TARGET,
> +	SEV_NR_MIGRATION_ROLES,
> +};
>   
> -static int sev_lock_vcpus_for_migration(struct kvm *kvm)
> +static int sev_lock_vcpus_for_migration(struct kvm *kvm,
> +					enum sev_migration_role role)
>   {
>   	struct kvm_vcpu *vcpu;
>   	unsigned long i, j;
> +	bool first = true;
>   
>   	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		if (mutex_lock_killable(&vcpu->mutex))
> +		if (mutex_lock_killable_nested(&vcpu->mutex, role))
>   			goto out_unlock;
> +
> +		if (first) {
> +			/*
> +			 * Reset the role to one that avoids colliding with
> +			 * the role used for the first vcpu mutex.
> +			 */
> +			role = SEV_NR_MIGRATION_ROLES;
> +			first = false;
> +		} else {
> +			mutex_release(&vcpu->mutex.dep_map, _THIS_IP_);
> +		}
>   	}
>   
>   	return 0;
>   
>   out_unlock:
> +
> +	first = true;
>   	kvm_for_each_vcpu(j, vcpu, kvm) {
>   		if (i == j)
>   			break;
>   
> +		if (first)
> +			first = false;
> +		else
> +			mutex_acquire(&vcpu->mutex.dep_map, role, 0, _THIS_IP_);
> +
> +
>   		mutex_unlock(&vcpu->mutex);
>   	}
>   	return -EINTR;
> @@ -1618,8 +1649,15 @@ static void sev_unlock_vcpus_for_migration(struct kvm *kvm)
>   {
>   	struct kvm_vcpu *vcpu;
>   	unsigned long i;
> +	bool first = true;
>   
>   	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (first)
> +			first = false;
> +		else
> +			mutex_acquire(&vcpu->mutex.dep_map,
> +				      SEV_NR_MIGRATION_ROLES, 0, _THIS_IP_);
> +
>   		mutex_unlock(&vcpu->mutex);
>   	}
>   }
> @@ -1745,10 +1783,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>   		charged = true;
>   	}
>   
> -	ret = sev_lock_vcpus_for_migration(kvm);
> +	ret = sev_lock_vcpus_for_migration(kvm, SEV_MIGRATION_SOURCE);
>   	if (ret)
>   		goto out_dst_cgroup;
> -	ret = sev_lock_vcpus_for_migration(source_kvm);
> +	ret = sev_lock_vcpus_for_migration(source_kvm, SEV_MIGRATION_TARGET);
>   	if (ret)
>   		goto out_dst_vcpu;
>   

