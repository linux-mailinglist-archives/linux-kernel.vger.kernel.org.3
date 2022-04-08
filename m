Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FFA4F9060
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiDHIJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiDHIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAD7F2DA9C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649405242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t9bfIQkql2j9TcUCqmraCaFGU4s4Y5bRorgJzCIZGMc=;
        b=G41w+SAn+EmYpaAkEM3ESi8qEDTz5kUe7GcL0ngxfDWPiAg/+YmcAiZ8S5Xd8eR3Kdnhhj
        qP/NDZg4yci0K/BcDPUAk9wNL1ijasnm33j5oVSu2q69I0hxcPUsXionaOHgwkGTtYkFRT
        f+HcUE+cBpFvapFzzyk7qJdmPtXk8S4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-jFMIjZk2O0CNauJWX87WiA-1; Fri, 08 Apr 2022 04:07:19 -0400
X-MC-Unique: jFMIjZk2O0CNauJWX87WiA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C20123C11CE0;
        Fri,  8 Apr 2022 08:07:18 +0000 (UTC)
Received: from localhost (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D18B54ACB0;
        Fri,  8 Apr 2022 08:07:17 +0000 (UTC)
Date:   Fri, 8 Apr 2022 16:07:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v6 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
Message-ID: <Yk/tMnoYN/p6vxxT@MiWiFi-R3L-srv>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-3-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401183040.1624-3-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/22 at 02:30pm, Eric DeVolder wrote:
> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
> 
> CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
> the elfcorehdr buffer/segment.
> 
> This is a preparation for later usage.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7340d9f01b62..8b51d3196b82 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2072,6 +2072,32 @@ config CRASH_DUMP
>  	  (CONFIG_RELOCATABLE=y).
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +config CRASH_HOTPLUG
> +	bool "kernel updates of crash elfcorehdr"
> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
> +	help
> +	  Enable the kernel to update the crash elfcorehdr (which contains
> +	  the list of CPUs and memory regions) directly when hot plug/unplug
> +	  of CPUs or memory. Otherwise userspace must monitor these hot
> +	  plug/unplug change notifications via udev in order to
> +	  unload-then-reload the crash kernel so that the list of CPUs and
> +	  memory regions is kept up-to-date. Note that the udev CPU and
> +	  memory change notifications still occur (however, userspace is not
> +	  required to monitor for crash dump purposes).
> +
> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
> +	depends on CRASH_HOTPLUG
> +	int
> +	default 131072
> +	help
> +	  Specify the maximum size of the elfcorehdr buffer/segment.
> +	  The 128KiB default is sized so that it can accommodate 2048
> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
> +	  region of memory.
> +	  For example, this size can accommodate a machine with up to 1024
> +	  CPUs and up to 1024 memory regions, eg. as represented by the
> +	  'System RAM' entries in /proc/iomem.
> +
>  config KEXEC_JUMP
>  	bool "kexec jump"
>  	depends on KEXEC && HIBERNATION
> -- 
> 2.27.0
> 

