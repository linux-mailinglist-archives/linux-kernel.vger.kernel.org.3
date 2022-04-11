Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35934FB743
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344330AbiDKJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbiDKJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1414D33361
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649668857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZDoaVa70ApFuJrDzsMYwod+in/0E4Gf7YVjPfVb2rU=;
        b=eSQBgF351jcmnKmz8T0dqPYEIfqbn7SybGAmg75cvmBt/XzD1kMatN+tB545s/x28UEW4A
        0Wt9ikrCTUMdrW4D6LrlRyCVv1iX3bDGhXYR1d2rMzPtcUErCKoDmaEO9fMfk+BUaZIQVm
        2tWvlqHjXn3BCY7NBR/8DbnH/4Ii3Xw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-wVCAF6TKPLK2-iOO08wXxw-1; Mon, 11 Apr 2022 05:20:53 -0400
X-MC-Unique: wVCAF6TKPLK2-iOO08wXxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC2EA29DD9A3;
        Mon, 11 Apr 2022 09:20:52 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E47241400C2B;
        Mon, 11 Apr 2022 09:20:51 +0000 (UTC)
Date:   Mon, 11 Apr 2022 17:20:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v6 4/8] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <YlPy8CKU4zHsx6Bc@MiWiFi-R3L-srv>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-5-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401183040.1624-5-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 04/01/22 at 02:30pm, Eric DeVolder wrote:
... ...

> +static void crash_hotplug_handler(unsigned int hp_action,
> +	unsigned long a, unsigned long b)

I am still struggling to consider if these unused parameters should be
kept or removed. Do you foresee or feel on which ARCH they could be used?

Considering our elfcorehdr updating method, once memory or cpu changed,
we will update elfcorehdr and cpu notes to reflect all existing memory
regions and cpu in the current system. We could end up with having them
but never being used. Then we may finally need to clean them up.

If you have investigated and foresee or feel they could be used on a
certain architecture, we can keep them for the time being.

> +{
> +	/* Obtain lock while changing crash information */
> +	if (!mutex_trylock(&kexec_mutex))
> +		return;
> +
> +	/* Check kdump is loaded */
> +	if (kexec_crash_image) {
> +		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
> +			a, b);
> +
> +		/* Needed in order for the segments to be updated */
> +		arch_kexec_unprotect_crashkres();
> +
> +		/* Flag to differentiate between normal load and hotplug */
> +		kexec_crash_image->hotplug_event = true;
> +
> +		/* Now invoke arch-specific update handler */
> +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
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
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +static int crash_memhp_notifier(struct notifier_block *nb,
> +	unsigned long val, void *v)
> +{
> +	struct memory_notify *mhp = v;
> +	unsigned long start, end;
> +
> +	start = mhp->start_pfn << PAGE_SHIFT;
> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
> +
> +	switch (val) {
> +	case MEM_ONLINE:
> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
> +			start, end-start);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
> +			start, end-start);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block crash_memhp_nb = {
> +	.notifier_call = crash_memhp_notifier,
> +	.priority = 0
> +};
> +#endif
> +
> +#if defined(CONFIG_HOTPLUG_CPU)
> +static int crash_cpuhp_online(unsigned int cpu)
> +{
> +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
> +	return 0;
> +}
> +#endif
> +
> +static int __init crash_hotplug_init(void)
> +{
> +	int result = 0;
> +
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +	register_memory_notifier(&crash_memhp_nb);
> +#endif
> +
> +#if defined(CONFIG_HOTPLUG_CPU)
> +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +				"crash/cpuhp",
> +				crash_cpuhp_online, crash_cpuhp_offline);
> +#endif
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif /* CONFIG_CRASH_HOTPLUG */
> -- 
> 2.27.0
> 

