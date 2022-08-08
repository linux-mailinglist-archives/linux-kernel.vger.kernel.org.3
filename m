Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7858C69D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbiHHKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiHHKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36A206389
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659955270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MJLPOegk0UFvhgGoFsMnh0SPzQgLjSOmQFmdJ12d4pE=;
        b=UWkddwi3Zq/XNfSa+xv85keVZrx1gdpiiNkTXd6rV+wArpBrTaHBcs9b0DVf+v0zSXIUo4
        WEQijwXliacx4ObLjNbT5mXUNcONOTVx7XnE/DbzU9YqFksHL1aYHVKPhkNzOOOJv4esI+
        FU2WOzxnBJCwXEn4EbDNQddw/ZUeNE8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-Nc3ZIis2O86ADhrOetFMjw-1; Mon, 08 Aug 2022 06:41:07 -0400
X-MC-Unique: Nc3ZIis2O86ADhrOetFMjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4192A8041B5;
        Mon,  8 Aug 2022 10:41:06 +0000 (UTC)
Received: from localhost (ovpn-12-221.pek2.redhat.com [10.72.12.221])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 380041121314;
        Mon,  8 Aug 2022 10:41:04 +0000 (UTC)
Date:   Mon, 8 Aug 2022 18:41:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v10 7/8] crash: memory and cpu hotplug sysfs attributes
Message-ID: <YvDoPTSkYo6dg+Di@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721181747.1640-8-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> This introduces the crash_hotplug attribute for memory and CPUs
> for use by userspace.  This change directly facilitates the udev
> rule for managing userspace re-loading of the crash kernel upon
> hot un/plug changes.
> 
> For memory, this changeset introduces the crash_hotplug attribute
> to the /sys/devices/system/memory directory. For example:
> 
>  # udevadm info --attribute-walk /sys/devices/system/memory/memory81
>   looking at device '/devices/system/memory/memory81':
>     KERNEL=="memory81"
>     SUBSYSTEM=="memory"
>     DRIVER==""
>     ATTR{online}=="1"
>     ATTR{phys_device}=="0"
>     ATTR{phys_index}=="00000051"
>     ATTR{removable}=="1"
>     ATTR{state}=="online"
>     ATTR{valid_zones}=="Movable"
> 
>   looking at parent device '/devices/system/memory':
>     KERNELS=="memory"
>     SUBSYSTEMS==""
>     DRIVERS==""
>     ATTRS{auto_online_blocks}=="offline"
>     ATTRS{block_size_bytes}=="8000000"
>     ATTRS{crash_hotplug}=="1"
> 
> For CPUs, this changeset introduces the crash_hotplug attribute
> to the /sys/devices/system/cpu directory. For example:
> 
>  # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
>   looking at device '/devices/system/cpu/cpu0':
>     KERNEL=="cpu0"
>     SUBSYSTEM=="cpu"
>     DRIVER=="processor"
>     ATTR{crash_notes}=="277c38600"
>     ATTR{crash_notes_size}=="368"
>     ATTR{online}=="1"
> 
>   looking at parent device '/devices/system/cpu':
>     KERNELS=="cpu"
>     SUBSYSTEMS==""
>     DRIVERS==""
>     ATTRS{crash_hotplug}=="1"
>     ATTRS{isolated}==""
>     ATTRS{kernel_max}=="8191"
>     ATTRS{nohz_full}=="  (null)"
>     ATTRS{offline}=="4-7"
>     ATTRS{online}=="0-3"
>     ATTRS{possible}=="0-7"
>     ATTRS{present}=="0-3"
> 
> With these sysfs attributes in place, it is possible to efficiently
> instruct the udev rule to skip crash kernel reloading.
> 
> For example, the following is the proposed udev rule change for RHEL
> system 98-kexec.rules (as the first lines of the rule file):
> 
>  # The kernel handles updates to crash elfcorehdr for cpu and memory changes
>  SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>  SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
> When examined in the context of 98-kexec.rules, the above change
> tests if crash_hotplug is set, and if so, it skips the userspace
> initiated unload-then-reload of the crash kernel.
> 
> Cpu and memory checks are separated in accordance with
> CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
> If an architecture supports, for example, memory hotplug but not
> CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
> attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
> attribute file will NOT be present. Thus the udev rule will skip
> userspace processing of memory hot un/plug events, but the udev
> rule will fail for CPU events, thus allowing userspace to process
> cpu hot un/plug events (ie the unload-then-reload of the kdump
> capture kernel).
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>  Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>  drivers/base/cpu.c                             | 14 ++++++++++++++
>  drivers/base/memory.c                          | 13 +++++++++++++
>  include/linux/crash_core.h                     |  6 ++++++
>  5 files changed, 59 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 0f56ecd8ac05..494d7a63c543 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -293,6 +293,14 @@ The following files are currently defined:
>  		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
>  		       kernel configuration option.
>  ``uevent``	       read-write: generic udev file for device subsystems.
> +``crash_hotplug``      read-only: when changes to the system memory map
> +		       occur due to hot un/plug of memory, this file contains
> +		       '1' if the kernel updates the kdump capture kernel memory
> +		       map itself (via elfcorehdr), or '0' if userspace must update
> +		       the kdump capture kernel memory map.
> +
> +		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
> +		       configuration option.
>  ====================== =========================================================
>  
>  .. note::
> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
> index c6f4ba2fb32d..13e33d098645 100644
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -750,6 +750,24 @@ will receive all events. A script like::
>  
>  can process the event further.
>  
> +When changes to the CPUs in the system occur, the sysfs file
> +/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
> +or '0' if userspace must update the kdump capture kernel list of CPUs.
> +
> +The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
> +option.
> +
> +To skip userspace processing of CPU hot un/plug events for kdump
> +(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
> +file can be used in a udev rule as follows:
> +
> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> +
> +For a cpu hot un/plug event, if the architecture supports kernel updates
> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
> +the unload-then-reload of the kdump capture kernel.
> +
>  Kernel Inline Documentations Reference
>  ======================================
>  
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 4c98849577d4..bd470236d9a2 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
>  static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
>  #endif
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +#include <linux/crash_core.h>
> +static ssize_t crash_hotplug_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
> +}
> +static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> +#endif
> +
>  static void cpu_device_release(struct device *dev)
>  {
>  	/*
> @@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
>  #ifdef CONFIG_NO_HZ_FULL
>  	&dev_attr_nohz_full.attr,
>  #endif
> +#ifdef CONFIG_HOTPLUG_CPU
> +	&dev_attr_crash_hotplug.attr,
> +#endif
>  #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>  	&dev_attr_modalias.attr,
>  #endif
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index bc60c9cd3230..63c1754a52b6 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -483,6 +483,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(auto_online_blocks);
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +#include <linux/crash_core.h>
> +static ssize_t crash_hotplug_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
> +}
> +static DEVICE_ATTR_RO(crash_hotplug);
> +#endif
> +
>  /*
>   * Some architectures will have custom drivers to do this, and
>   * will not need to do it from userspace.  The fake hot-add code
> @@ -887,6 +897,9 @@ static struct attribute *memory_root_attrs[] = {
>  
>  	&dev_attr_block_size_bytes.attr,
>  	&dev_attr_auto_online_blocks.attr,
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +	&dev_attr_crash_hotplug.attr,
> +#endif
>  	NULL
>  };
>  
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index c9705b6872e7..3964e9924ea5 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -109,5 +109,11 @@ static inline void arch_crash_handle_hotplug_event(struct kimage *image,
>  {
>  }
>  #endif
> +#ifndef crash_hotplug_cpu_support
> +static inline int crash_hotplug_cpu_support(void) { return 0; }
> +#endif
> +#ifndef crash_hotplug_memory_support
> +static inline int crash_hotplug_memory_support(void) { return 0; }
> +#endif
>  
>  #endif /* LINUX_CRASH_CORE_H */
> -- 
> 2.31.1
> 

