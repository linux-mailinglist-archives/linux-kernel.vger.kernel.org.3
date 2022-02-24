Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC454C2FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiBXPdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbiBXPdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:33:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09C6F1C60D2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645716753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ov07aeoy4n0MdIMb+xro3Q6ITvxKv/fEAqXHKggDo7s=;
        b=Ws2zVts3faNMq+jW+TFGp5ZdzhM2XcKaUbN7jRydaHeiHVNribeMNdSJJeLKXaBgmUGGcq
        DKPJxhR5Kl9utU9UqrctYQeo5JMxECEVWsyCvFy0HKdew9Q41gK/MJaiByGBu0eAvmjdMx
        F5B/RWDFVhcsqeKvxxLKhI9rYAmBHfY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-kI9pSZKuOVKugS2WOl-jYQ-1; Thu, 24 Feb 2022 10:32:31 -0500
X-MC-Unique: kI9pSZKuOVKugS2WOl-jYQ-1
Received: by mail-ed1-f72.google.com with SMTP id r9-20020a05640251c900b00412d54ea618so893043edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ov07aeoy4n0MdIMb+xro3Q6ITvxKv/fEAqXHKggDo7s=;
        b=3Mi64lpeNg3DG+NfBVp8dHyh2zH8LkkI8ZAFx+nXc1SxnO1H23oYEuqgZGzPDsK7gd
         EskscnTQnPjj6WnWyRLGEFSqbEhvTPdPUJD3Oj8TUdOfiSzctJnJXoPtz7Io2OLWek+v
         gvcNsoaAYTZgdc/k+q840dUR36IICjW47OLwOjG1H59Ui45BHL7HCevC1zQQxlVvSSTQ
         Efj8jTuBiug30pkIeeYHvNOSufBs3dgICFPhVeHQNfVCXcML6WPVYObxssrLOd6ACXoi
         V7CkbL/Ib38RMzwBhQzHucLXPzsotArbEfpp0z5dflQBjXc58iusM3L/xYe6UYUc9pXc
         ebgA==
X-Gm-Message-State: AOAM530rkmvl74mrLAXlsglJNY8/HAwEAnG6OfNXSrTg9eKRX8NT8iCn
        yAHZxqcaMN7DxXNZZmEHElFbSs88THwmf13TP6oBzANzrWGuaT1bugMFRcHgrnJzl1/WRszvVhX
        ImcMxJsXWyXuZGMZhAMGlFmOZ
X-Received: by 2002:a05:6402:b37:b0:400:500f:f26 with SMTP id bo23-20020a0564020b3700b00400500f0f26mr2753976edb.301.1645716750312;
        Thu, 24 Feb 2022 07:32:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxG3AkEDtpC33QTqnNtNA2rgKSB7SYk60lL617XtZIitugauOCcRMH3QOSGx5CYB2jWFM/1jg==
X-Received: by 2002:a05:6402:b37:b0:400:500f:f26 with SMTP id bo23-20020a0564020b3700b00400500f0f26mr2753948edb.301.1645716750060;
        Thu, 24 Feb 2022 07:32:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id g20sm82251ejk.209.2022.02.24.07.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 07:32:29 -0800 (PST)
Message-ID: <202e0882-35a6-766b-6c4a-137abd199247@redhat.com>
Date:   Thu, 24 Feb 2022 16:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/6] Add TDX Guest Attestation support
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Mark Gross <mgross@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20220222231735.268919-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220222231735.268919-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/23/22 00:17, Kuppuswamy Sathyanarayanan wrote:
> Hi All,
> 
> Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
> hosts and some physical attacks. VM guest with TDX support is called
> as TD Guest.
> 
> In TD Guest, the attestation process is used to verify the 
> trustworthiness of TD guest to the 3rd party servers. Such attestation
> process is required by 3rd party servers before sending sensitive
> information to TD guests. One usage example is to get encryption keys
> from the key server for mounting the encrypted rootfs or secondary drive.
>     
> Following patches add the attestation support to TDX guest which
> includes attestation user interface driver, user agent example, and
> related hypercall support.
> 
> In this series, only following patches are in arch/x86 and are
> intended for x86 maintainers review.
> 
> * x86/tdx: Add TDREPORT TDX Module call support
> * x86/tdx: Add GetQuote TDX hypercall support
> * x86/tdx: Add SetupEventNotifyInterrupt TDX hypercall support
> * x86/tdx: Add TDX Guest event notify interrupt vector support
> 
> Patch titled "platform/x86: intel_tdx_attest: Add TDX Guest attestation
> interface driver" adds the attestation driver support. This is supposed
> to be reviewed by platform-x86 maintainers.

At a quick glance this looks ok to me, but I really know very little
about TDX. I assume the rest of the series will be reviewed by someone
with more detailed knowledge of TDX as such I believe it would be good
if the platform/x86 patch is also reviewed as part of that.

Since the platform/x86 patch depends on the other patches I believe
it is also best if the entire series is merged in one go by the x86/tip
maintainers here is my ack for this:

Acked-by: Hans de Goede <hdegoede@redhat.com>

> Also, patch titled "tools/tdx: Add a sample attestation user app" adds
> a testing app for attestation feature which needs review from
> bpf@vger.kernel.org.

I think that tool should be moved to tools/arch/x86/tdx regardless of
moving it, tools are typically reviewed together with the kernel side
and this has nothing to do with bpf.

Regards,

Hans

> 
> Dependencies:
> --------------
> 
> This feature has dependency on TDX guest core patch set series.
> 
> https://lore.kernel.org/all/20220218161718.67148-1-kirill.shutemov@linux.intel.com/T/
> 
> History:
> ----------
> 
> Previously this patch set was sent under title "Add TDX Guest
> Support (Attestation support)". In the previous version, only the
> attestation driver patch was reviewed and got acked. Rest of the
> patches need to be reviewed freshly.
> 
> https://lore.kernel.org/bpf/20210806000946.2951441-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> 
> Changes since previous submission:
>  * Updated commit log and error handling in TDREPORT, GetQuote and
>    SetupEventNotifyInterrupt support patches.
>  * Added locking support in attestation driver.
> 
> Kuppuswamy Sathyanarayanan (6):
>   x86/tdx: Add tdx_mcall_tdreport() API support
>   x86/tdx: Add tdx_hcall_get_quote() API support
>   x86/tdx: Add SetupEventNotifyInterrupt TDX hypercall support
>   platform/x86: intel_tdx_attest: Add TDX Guest attestation interface
>     driver
>   x86/tdx: Add TDX Guest event notify interrupt vector support
>   tools/tdx: Add a sample attestation user app
> 
>  arch/x86/coco/tdx.c                           | 170 ++++++++++++
>  arch/x86/include/asm/hardirq.h                |   4 +
>  arch/x86/include/asm/idtentry.h               |   4 +
>  arch/x86/include/asm/irq_vectors.h            |   7 +-
>  arch/x86/include/asm/tdx.h                    |   5 +
>  arch/x86/kernel/irq.c                         |   7 +
>  drivers/platform/x86/intel/Kconfig            |   1 +
>  drivers/platform/x86/intel/Makefile           |   1 +
>  drivers/platform/x86/intel/tdx/Kconfig        |  13 +
>  drivers/platform/x86/intel/tdx/Makefile       |   3 +
>  .../platform/x86/intel/tdx/intel_tdx_attest.c | 241 ++++++++++++++++++
>  include/uapi/misc/tdx.h                       |  37 +++
>  tools/Makefile                                |  13 +-
>  tools/tdx/Makefile                            |  19 ++
>  tools/tdx/attest/.gitignore                   |   2 +
>  tools/tdx/attest/Makefile                     |  24 ++
>  tools/tdx/attest/tdx-attest-test.c            | 240 +++++++++++++++++
>  17 files changed, 784 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/tdx/Kconfig
>  create mode 100644 drivers/platform/x86/intel/tdx/Makefile
>  create mode 100644 drivers/platform/x86/intel/tdx/intel_tdx_attest.c
>  create mode 100644 include/uapi/misc/tdx.h
>  create mode 100644 tools/tdx/Makefile
>  create mode 100644 tools/tdx/attest/.gitignore
>  create mode 100644 tools/tdx/attest/Makefile
>  create mode 100644 tools/tdx/attest/tdx-attest-test.c
> 

