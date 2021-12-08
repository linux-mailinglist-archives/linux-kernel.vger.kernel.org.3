Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A5346D488
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhLHNmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:42:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234372AbhLHNmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638970709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztz6KLLsrEQ05aQBRS4LY7DFjul40lWKNWaumF6dm64=;
        b=GGZMvOmtgippU6yse4yn0HL98qJfT2ziPFVrippO+Mr/0+LFQCGB9f1t1GhOKBmFs1WRfL
        0JB/zskoM9UeTJXwh9CRQjzSOPPXy0KmF9cY40rSy+wejHchaxdlrbDNl7v0K48j1SrcaB
        v5Bo+2h8aSjY7WyKdALxzw5yGkOG41s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-ennQOe1JMTet6QLLn-PtpQ-1; Wed, 08 Dec 2021 08:38:28 -0500
X-MC-Unique: ennQOe1JMTet6QLLn-PtpQ-1
Received: by mail-wm1-f72.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso1312818wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 05:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ztz6KLLsrEQ05aQBRS4LY7DFjul40lWKNWaumF6dm64=;
        b=a8JSSRO2lxtGMl2r6N8afx4bKAF8mO8YQeiOhKcNlRpV8c+MCqnujhX6wL486sZhBO
         aXA5lPkHVmU1r8z7b6WkoRGUFrDF5cQa8oubTz7p/h/eL0B5S6A2l4uv8g1JdkzrHA25
         1w226ysjkwBIIq1sR5tsmd4bylaUWxwKLh/q8xSik3GaFPp0pqcKgg0Lz7h+WDWf1cLE
         /MRfXsycYDzqpNG7Whqg6IAlpT9B6vgmB6KlSY9k+0z46tTQ4vuTixpp0UXpnSDyUELJ
         rPJKlhD/nVJcQOXmlF5rMgIyWizRBGQBlPjXWPYvZNcFnvy1cxM0XzT1522UnrfoCODa
         EcAQ==
X-Gm-Message-State: AOAM533KELKmsXbE62fvkbpqUFfGZ4xaA5Jb3bprYnu8Zj8NfWxHoZkh
        c11qxZ9eBQ68JuvJ6nKTnx9XN+bagOvtMAfQHSxc+oKPgDFk1z2WQKtZCyfz3VDulJdgw0RwXx8
        124cvM2gAUW9Wn3KQ4bb+8tvB
X-Received: by 2002:adf:9bc4:: with SMTP id e4mr59666334wrc.476.1638970707484;
        Wed, 08 Dec 2021 05:38:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEiEBye8AlwAU4IiEbbmZZ4AqYunkiArYw2vP4I8rJ9DE9g2ruUHD8bokG6X2z6aUs3h1v6g==
X-Received: by 2002:adf:9bc4:: with SMTP id e4mr59666301wrc.476.1638970707306;
        Wed, 08 Dec 2021 05:38:27 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62ba.dip0.t-ipconnect.de. [91.12.98.186])
        by smtp.gmail.com with ESMTPSA id p13sm5739804wmi.0.2021.12.08.05.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 05:38:25 -0800 (PST)
Message-ID: <9230f9cc-1001-e3ce-aa74-10b766c8cdb0@redhat.com>
Date:   Wed, 8 Dec 2021 14:38:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 4/6] crash hp: generic crash hotplug support
 infrastructure
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
References: <20211207195204.1582-1-eric.devolder@oracle.com>
 <20211207195204.1582-5-eric.devolder@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211207195204.1582-5-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> +	case MEM_GOING_ONLINE:
> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
> +			start, end-start);
> +		break;
> +
> +	case MEM_OFFLINE:
> +	case MEM_CANCEL_ONLINE:
> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
> +			start, end-start);

Any reason you don't handle this after the effects completely, meaning
MEM_ONLINE and MEM_OFFLINE?

-- 
Thanks,

David / dhildenb

