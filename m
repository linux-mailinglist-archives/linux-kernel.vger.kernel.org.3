Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4FA524855
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351735AbiELIxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351791AbiELIwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD32860AAE
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652345526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRUrrbn46YFSuaQYIxb11X45btKrKxb5jX9PfEqK6iQ=;
        b=LTmmHmto6RzKHluJ0gnZCkVEq3NUVDwYZPLQnjhEHfCRjveKyCaxNlnY2k4DUCIMpKXgZp
        PU12siLSdQcyje8B3OMEjqBeaK2TBkbXzq7u7X9tGw6xFN3jF/u7wt2PpB/0KgQDX1D8t3
        OdZNul7W63w6o+BbJDa67cdXF2/QVb0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-5kHlNnFYNtmENw_QPgotDA-1; Thu, 12 May 2022 04:52:05 -0400
X-MC-Unique: 5kHlNnFYNtmENw_QPgotDA-1
Received: by mail-wm1-f72.google.com with SMTP id u3-20020a05600c210300b0039430c7665eso1417765wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=pRUrrbn46YFSuaQYIxb11X45btKrKxb5jX9PfEqK6iQ=;
        b=WicwgLtw8ZvrgOZY6dhIos/wWPsNJfW0i40Nn1EProRMJku05iXhVrxM0MHAGZATEL
         isF442zACYFdNU/qIssR6svWOdpO4xR9IunU9/Asendt2XcjUTlUhFlr/iNgydwVZS8P
         vafsCdpLTK+j4XnjSd/hL4FYNsPIyTJHvFzJrORwEIalXkQajrKe1jWsp/QCQ0vGXvrG
         paRMW9cPndZDQzuumMqRAQEes5NvgW+6BjMwlKHW6WL0y7f8Rbpp9fJ84tJ6vj1/d3Ux
         pZOg1tFOMLAAzLhXEGeaV9TtVjDA272accVJDmYRcouoMk8lKus9wjCpbus8xzMUZva2
         7cNg==
X-Gm-Message-State: AOAM532SrDXPtj8yGzfLqFDsKkvRFhVtUckNJJP+WwrwR6q8c4421dre
        xdMp7ORElyfPJ56Hulqry9usQtnYanIobrPGT3H7HabWDfpzesVK+x317XpdjAIv+B0lWjb/YHh
        FWgyMKs8rukt9GUb/knVWeI0z
X-Received: by 2002:a5d:680a:0:b0:20a:e5ed:9b5e with SMTP id w10-20020a5d680a000000b0020ae5ed9b5emr25985099wru.110.1652345524194;
        Thu, 12 May 2022 01:52:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMVtHw9rX1p6C4zMlTb2lbqIKfVc/UgkmyKdcE4lDfD61c5s1s+UpB0cPOGx0svZMH0rPIwA==
X-Received: by 2002:a5d:680a:0:b0:20a:e5ed:9b5e with SMTP id w10-20020a5d680a000000b0020ae5ed9b5emr25985088wru.110.1652345523917;
        Thu, 12 May 2022 01:52:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id a7-20020a7bc1c7000000b0039429bfebeasm2026402wmj.2.2022.05.12.01.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 01:52:03 -0700 (PDT)
Message-ID: <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
Date:   Thu, 12 May 2022 10:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <20220505184603.1548-4-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.22 20:45, Eric DeVolder wrote:
> CPU and memory change notifications are received in order to
> regenerate the elfcorehdr.
> 
> To support cpu hotplug, a callback is registered to capture the
> CPUHP_AP_ONLINE_DYN online and offline events via
> cpuhp_setup_state_nocalls().
> 
> To support memory hotplug, a notifier is registered to capture the
> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
> 
> The cpu callback and memory notifiers call handle_hotplug_event()
> to handle the hot plug/unplug event. Then handle_hotplug_event()
> dispatches the event to the architecture specific
> arch_crash_handle_hotplug_event(). During the process, the
> kexec_mutex is held.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

[...]

> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
> +							unsigned int hp_action, unsigned int cpu)
> +{
> +	WARN(1, "crash hotplug handler not implemented");


Won't that trigger on any arch that has CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG?
I mean, you only implement it for x86 later in this series. Or what else stops this WARN from
triggering?

> +}
> +
> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (!mutex_trylock(&kexec_mutex))
> +		return;

This looks wrong. What if you offline memory but for some reason the mutex
is currently locked? You'd miss updating the vmcore, which would be broken.

Why is this trylock in place? Some workaround for potential locking issues,
or what is the rationale?

> +
> +	/* Check kdump is loaded */
> +	if (kexec_crash_image) {
> +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
> +
> +		/* Needed in order for the segments to be updated */
> +		arch_kexec_unprotect_crashkres();
> +
> +		/* Flag to differentiate between normal load and hotplug */
> +		kexec_crash_image->hotplug_event = true;

1. Why is that required? Why can't arch_crash_handle_hotplug_event() forward that
information? I mean, *hotplug* in the anme implies that the function should be
aware what's happening.

2. Why can't the unprotect+reprotect not be done inside
arch_crash_handle_hotplug_event() ? It's all arch specific either way.

IMHO, this code here should be as simple as

if (kexec_crash_image)
	arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);

3. Why do we have to forward the CPU for CPU onlining/offlining but not the
memory block id (or similar) when onlining/offlining a memory block?

> +
> +		/* Now invoke arch-specific update handler */
> +		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
> +
> +		/* No longer handling a hotplug event */
> +		kexec_crash_image->hotplug_event = false;
> +
> +		/* Change back to read-only */
> +		arch_kexec_protect_crashkres();
> +	}
> +
> +	/* Release lock now that update complete */
> +	mutex_unlock(&kexec_mutex);
> +}
> +
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +{
> +	switch (val) {
> +	case MEM_ONLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block crash_memhp_nb = {
> +	.notifier_call = crash_memhp_notifier,
> +	.priority = 0
> +};
> +
> +static int crash_cpuhp_online(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> +	return 0;
> +}
> +
> +static int __init crash_hotplug_init(void)
> +{
> +	int result = 0;
> +
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		register_memory_notifier(&crash_memhp_nb);
> +
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +									"crash/cpuhp",
> +									crash_cpuhp_online,
> +									crash_cpuhp_offline);

Ehm, this indentation looks very weird.

> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif


-- 
Thanks,

David / dhildenb

