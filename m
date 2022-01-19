Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAFA49364A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352418AbiASI0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343541AbiASIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642580758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EXUe/gcOzGi0ldd56Z8LJh96ZBuuH+9JFhXJdv3cSjw=;
        b=MQc4Wm1OxnZAgzkiohcHwmfXt5iRsP/CV9w5q8y4Xl/ONiALcNk0fxBoV4HfpGDjnQ5TMn
        GYZSXF+zV5T+oPT4ds4Sb+UryaNFhVoEjEUdrE0ZXJ7KkH3RcfCvahbDiRK6nyG4BoOhQM
        eFAMW0k07Ho4sw2MtXEuSB145HhR8ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-tR3pnNSvP7O0sBT3DdA_kg-1; Wed, 19 Jan 2022 03:25:53 -0500
X-MC-Unique: tR3pnNSvP7O0sBT3DdA_kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E2081923E20;
        Wed, 19 Jan 2022 08:25:51 +0000 (UTC)
Received: from localhost (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D12F519D5;
        Wed, 19 Jan 2022 08:25:46 +0000 (UTC)
Date:   Wed, 19 Jan 2022 16:25:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC v2 3/6] crash hp: definitions and prototype changes
Message-ID: <20220119082544.GA18398@MiWiFi-R3L-srv>
References: <20211207195204.1582-1-eric.devolder@oracle.com>
 <20211207195204.1582-4-eric.devolder@oracle.com>
 <20220119082306.GA5158@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119082306.GA5158@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/22 at 04:23pm, Baoquan He wrote:
> On 12/07/21 at 02:52pm, Eric DeVolder wrote:
> > This change adds members to struct kimage to facilitate crash
> > hotplug support.
> > 
> > This change also defines crash hotplug events and associated
> > prototypes.
> > 
> > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > ---
> >  include/linux/kexec.h | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 0c994ae37729..068f853f1c65 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -221,8 +221,9 @@ struct crash_mem {
> >  extern int crash_exclude_mem_range(struct crash_mem *mem,
> >  				   unsigned long long mstart,
> >  				   unsigned long long mend);
> > -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> > -				       void **addr, unsigned long *sz);
> > +extern int crash_prepare_elf64_headers(struct kimage *image,
> > +					struct crash_mem *mem, int kernel_map,
> > +					void **addr, unsigned long *sz);
> >  #endif /* CONFIG_KEXEC_FILE */
> >  
> >  #ifdef CONFIG_KEXEC_ELF
> > @@ -299,6 +300,13 @@ struct kimage {
> >  
> >  	/* Information for loading purgatory */
> >  	struct purgatory_info purgatory_info;
> > +
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +	bool hotplug_event;
> > +	int offlinecpu;
> > +	bool elf_index_valid;
> > +	int elf_index;
> 
> Do we really need elf_index_valid? Can we initialize elf_index to , e.g '-1',
> then check if the value is valid?

Sorry, please ignore this one, I will add this comment in v3 thread.

> 
> > +#endif
> >  #endif
> >  
> >  #ifdef CONFIG_IMA_KEXEC
> > @@ -315,6 +323,15 @@ struct kimage {
> >  	unsigned long elf_load_addr;
> >  };
> >  
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +void arch_crash_hotplug_handler(struct kimage *image,
> > +	unsigned int hp_action, unsigned long a, unsigned long b);
> > +#define KEXEC_CRASH_HP_REMOVE_CPU   0
> > +#define KEXEC_CRASH_HP_ADD_CPU      1
> > +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
> > +#define KEXEC_CRASH_HP_ADD_MEMORY   3
> > +#endif /* CONFIG_CRASH_HOTPLUG */
> > +
> >  /* kexec interface functions */
> >  extern void machine_kexec(struct kimage *image);
> >  extern int machine_kexec_prepare(struct kimage *image);
> > -- 
> > 2.27.0
> > 
> 

