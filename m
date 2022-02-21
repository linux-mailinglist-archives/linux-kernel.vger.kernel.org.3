Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED204BE5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348648AbiBUJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:20:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiBUJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:12:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE5F02408A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645434328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYLLwD8bJ4Pq61ytGnPJ+l31crIWDd1Z3kl4/7tNe/4=;
        b=Nl0tI8L/eX1Tn2R+aDCjTgHlxDdCHXltzbzPI1uCCDH+4zoq+XKQjuTfojQq5Eh/WJmje/
        VIjK4GYys6pxTG2x6D+51ppzG+SF1jcyWljaoBC5vGZSNEafGLlCWynpNGj1FvBPdm9ZnM
        qX118CsDm7RZ2XwgmZ4HPJLSFrSHBQw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-C4k9ojZVMomPara1XiAD_A-1; Mon, 21 Feb 2022 04:05:26 -0500
X-MC-Unique: C4k9ojZVMomPara1XiAD_A-1
Received: by mail-ed1-f72.google.com with SMTP id j29-20020a508a9d000000b00412aa79f367so6936195edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NYLLwD8bJ4Pq61ytGnPJ+l31crIWDd1Z3kl4/7tNe/4=;
        b=YmVhN3NIH9fMbFo6zE67el3DQ98uD9/o5GbX+Tq6DTq2CgWKBTQBFSb8Z/8aYO/Y4q
         gk8GdqYId2hrhVhda02zRGWdXX8D0w7OnyrlLRi8uBZOMK/Sx7IQmRNFvqJFRMctbG81
         YE5Dkq9cqcQp6ccsp1tBCITb4fYCoG8gMYUfBgVcRIU+2SRuCOVESbP7G8plZgh8LD39
         P/avYCSnEDuqtZx0ccU27eFd/5kL2EGn0no890ls74ubXDk5TnO4vc+wX6htSBTGFSyf
         qU269VXLKWjy3YaHWhu18OA62BGJ5Yvy8Gh04vfOqJpnbGKgxbjqPVeJEtixTqr3+3hz
         NmFw==
X-Gm-Message-State: AOAM530bnAZnvOjeZqL+lAC/taWAkFGOfjhN2g2wuAVddc9ScLVU2J7a
        RylnzwLM8D4/+XATpp0dEBJCbr2t9+OD7W5r5ujRMf66dzVJY9cg6sC+vIN7JiuVOnEWPmCbwmi
        QdCdfkzoNllDDSkjo/vUXm4Be
X-Received: by 2002:a05:6402:50cd:b0:410:5da3:b569 with SMTP id h13-20020a05640250cd00b004105da3b569mr20220310edb.188.1645434325285;
        Mon, 21 Feb 2022 01:05:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJ6zo5BL/OxFVP+iqo/I0uGmkJieugYJhKHOCIdg0T/R75w4YC0Dv+l9cjAI0fIIph8xqloA==
X-Received: by 2002:a05:6402:50cd:b0:410:5da3:b569 with SMTP id h13-20020a05640250cd00b004105da3b569mr20220286edb.188.1645434325018;
        Mon, 21 Feb 2022 01:05:25 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h5sm5021885ejo.142.2022.02.21.01.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:05:24 -0800 (PST)
Message-ID: <5ba6e52c-d7e9-39fc-cb84-963a403385ca@redhat.com>
Date:   Mon, 21 Feb 2022 10:05:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] platform/x86/intel: pmt: Remove bin_attribute mmap
 support to runtime pm
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        mgross@linux.intel.com, rjw@rjwysocki.net,
        srinivas.pandruvada@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220214213258.1929462-1-david.e.box@linux.intel.com>
 <20220214213258.1929462-2-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220214213258.1929462-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/14/22 22:32, David E. Box wrote:
> PMT devices need to support runtime D3. However, binary attributes don't
> provide access to open/release methods that could be used to control
> runtime pm. Therefore, remove the mmap operation. The data may still be
> accessed with read() calls.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V0 comments:
> 
> I expect that this is an undesirable solution because of the ABI change.
> I don't know if anyone is using this ABI outside of our Intel tools which
> are willing to make this change. I'd rather find a solution to keep the
> mmap support. I initially wrote a patch to simply add the missing open and
> release callbacks to binary attributes but this was thought to be too heavy
> handed in our internal review. I'm open to suggestions. Thanks.

We really cannot go and break userspace API like this. Even if you are
dropping mmap support from the Intel tools; and we assume that the Intel
tools are the only consumer, then we still cannot drop mmap support
because users may install a new kernel without updating the tools.

The never break userspace rule applies here and that is a very clear
and hard rule.

So please respin the series using the approach with open and release
callbacks.

If you want to get rid of mmap in the future you need to follow the
official deprecation process:

1. Announce that mmap is going away
2. Move the ABI doc with the mmap support to
   Documentation/ABI/obsolete with a note explaining what is being
   removed and why it is being removed. Since you are only removing mmap you
   will want to keep the testing version with mmap removed and have the 2
   point to each other
3. Wait at least 1 year until after a kernel with the docs in the obsolete dir
   has been released
4. Remove the mmap API and move the Documentation/ABI/obsolete version
   of the ABI doc to Documentation/ABI/removed

Regards,

Hans






>  .../ABI/testing/sysfs-class-intel_pmt         | 24 +++++++-------
>  drivers/platform/x86/intel/pmt/class.c        | 31 -------------------
>  2 files changed, 12 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-intel_pmt b/Documentation/ABI/testing/sysfs-class-intel_pmt
> index ed4c886a21b1..4182f67dcef8 100644
> --- a/Documentation/ABI/testing/sysfs-class-intel_pmt
> +++ b/Documentation/ABI/testing/sysfs-class-intel_pmt
> @@ -15,10 +15,10 @@ Description:
>  		The telem<x> directory contains files describing an instance of
>  		a PMT telemetry device that exposes hardware telemetry. Each
>  		telem<x> directory has an associated telem file. This file
> -		may be opened and mapped or read to access the telemetry space
> -		of the device. The register layout of the telemetry space is
> -		determined from an XML file that matches the PCI device id and
> -		GUID for the device.
> +		may be opened and read to access the telemetry space of the
> +		device. The register layout of the telemetry space is determined
> +		from an XML file that matches the PCI device id and GUID for the
> +		device.
>  
>  What:		/sys/class/intel_pmt/telem<x>/telem
>  Date:		October 2020
> @@ -26,7 +26,7 @@ KernelVersion:	5.10
>  Contact:	David Box <david.e.box@linux.intel.com>
>  Description:
>  		(RO) The telemetry data for this telemetry device. This file
> -		may be mapped or read to obtain the data.
> +		may be read to obtain the data.
>  
>  What:		/sys/class/intel_pmt/telem<x>/guid
>  Date:		October 2020
> @@ -43,7 +43,7 @@ KernelVersion:	5.10
>  Contact:	David Box <david.e.box@linux.intel.com>
>  Description:
>  		(RO) The size of telemetry region in bytes that corresponds to
> -		the mapping size for the telem file.
> +		the size of the telem file.
>  
>  What:		/sys/class/intel_pmt/telem<x>/offset
>  Date:		October 2020
> @@ -51,7 +51,7 @@ KernelVersion:	5.10
>  Contact:	David Box <david.e.box@linux.intel.com>
>  Description:
>  		(RO) The offset of telemetry region in bytes that corresponds to
> -		the mapping for the telem file.
> +		the size of the telem file.
>  
>  What:		/sys/class/intel_pmt/crashlog<x>
>  Date:		October 2020
> @@ -61,10 +61,10 @@ Description:
>  		The crashlog<x> directory contains files for configuring an
>  		instance of a PMT crashlog device that can perform crash data
>  		recording. Each crashlog<x> device has an associated crashlog
> -		file. This file can be opened and mapped or read to access the
> -		resulting crashlog buffer. The register layout for the buffer
> -		can be determined from an XML file of specified GUID for the
> -		parent device.
> +		file. This file can be opened and read to access the resulting
> +		crashlog buffer. The register layout for the buffer can be
> +		determined from an XML file of specified GUID for the parent
> +		device.
>  
>  What:		/sys/class/intel_pmt/crashlog<x>/crashlog
>  Date:		October 2020
> @@ -72,7 +72,7 @@ KernelVersion:	5.10
>  Contact:	David Box <david.e.box@linux.intel.com>
>  Description:
>  		(RO) The crashlog buffer for this crashlog device. This file
> -		may be mapped or read to obtain the data.
> +		may be read to obtain the data.
>  
>  What:		/sys/class/intel_pmt/crashlog<x>/guid
>  Date:		October 2020
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index 1c9e3f3ea41c..85fc159961c1 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -68,36 +68,6 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
>  	return count;
>  }
>  
> -static int
> -intel_pmt_mmap(struct file *filp, struct kobject *kobj,
> -		struct bin_attribute *attr, struct vm_area_struct *vma)
> -{
> -	struct intel_pmt_entry *entry = container_of(attr,
> -						     struct intel_pmt_entry,
> -						     pmt_bin_attr);
> -	unsigned long vsize = vma->vm_end - vma->vm_start;
> -	struct device *dev = kobj_to_dev(kobj);
> -	unsigned long phys = entry->base_addr;
> -	unsigned long pfn = PFN_DOWN(phys);
> -	unsigned long psize;
> -
> -	if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
> -		return -EROFS;
> -
> -	psize = (PFN_UP(entry->base_addr + entry->size) - pfn) * PAGE_SIZE;
> -	if (vsize > psize) {
> -		dev_err(dev, "Requested mmap size is too large\n");
> -		return -EINVAL;
> -	}
> -
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	if (io_remap_pfn_range(vma, vma->vm_start, pfn,
> -		vsize, vma->vm_page_prot))
> -		return -EAGAIN;
> -
> -	return 0;
> -}
> -
>  static ssize_t
>  guid_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -263,7 +233,6 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
>  	sysfs_bin_attr_init(&entry->pmt_bin_attr);
>  	entry->pmt_bin_attr.attr.name = ns->name;
>  	entry->pmt_bin_attr.attr.mode = 0440;
> -	entry->pmt_bin_attr.mmap = intel_pmt_mmap;
>  	entry->pmt_bin_attr.read = intel_pmt_read;
>  	entry->pmt_bin_attr.size = entry->size;
>  

