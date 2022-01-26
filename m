Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB88D49C4D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiAZIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:03:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229947AbiAZIDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643184210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fvJKg4WXAsf4HyeNc2iRJbr6i32jqgjlV0BRc9+sMuY=;
        b=Md//PrjVjM8Suf4XvK/hvvsCtWwjd+19biHd6O2dgmjnr1frziNjTJ3jbEhrcpgMMXAMGd
        t9qRFfYj8kRfjX6cXJdbHbS37ZJkCC4rkELD0fOEtfxj4zeyG9il2rFV0UX4Iyl1mG3658
        JwdFZMJSN4NULnBvRU6xPzlPll4TWrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-Y93SYE7sNGmYh9zEO9s0FA-1; Wed, 26 Jan 2022 03:03:26 -0500
X-MC-Unique: Y93SYE7sNGmYh9zEO9s0FA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACA3F1006AA6;
        Wed, 26 Jan 2022 08:03:23 +0000 (UTC)
Received: from localhost (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D6AB4DC3C;
        Wed, 26 Jan 2022 08:03:03 +0000 (UTC)
Date:   Wed, 26 Jan 2022 16:03:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 3/6] crash hp: definitions and prototype changes
Message-ID: <20220126080300.GA6588@MiWiFi-R3L-srv>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-4-eric.devolder@oracle.com>
 <20220119082645.GA6349@MiWiFi-R3L-srv>
 <8af14bc9-7aab-433b-f741-494b3857226f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af14bc9-7aab-433b-f741-494b3857226f@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/22 at 07:48am, Eric DeVolder wrote:
...... 
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 0c994ae37729..068f853f1c65 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -221,8 +221,9 @@ struct crash_mem {
> > >   extern int crash_exclude_mem_range(struct crash_mem *mem,
> > >   				   unsigned long long mstart,
> > >   				   unsigned long long mend);
> > > -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> > > -				       void **addr, unsigned long *sz);
> > > +extern int crash_prepare_elf64_headers(struct kimage *image,
> > > +					struct crash_mem *mem, int kernel_map,
> > > +					void **addr, unsigned long *sz);
> > >   #endif /* CONFIG_KEXEC_FILE */
> > >   #ifdef CONFIG_KEXEC_ELF
> > > @@ -299,6 +300,13 @@ struct kimage {
> > >   	/* Information for loading purgatory */
> > >   	struct purgatory_info purgatory_info;
> > > +
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > +	bool hotplug_event;
> > > +	int offlinecpu;
> > > +	bool elf_index_valid;
> > > +	int elf_index;
> > 
> > Do we really need elf_index_valid? Can we initialize elf_index to , e.g '-1',
> > then check if the value is valid?
> 
> These members become part of struct kimage, and when the kimage is
> allocated, it is automatically zero'd. Wrt/ elf_index, 0 is a valid index,
> and so it needs to be qualified. I initially had used -1, but that required
> code and was fragile as I had to find the right place to do that. Using the
> boolean elf_index_valid, the problems with -1 vanish, and for free! I also
> found when examining the code that reading 'elf_index_valid' was better than
> 'elf_index != -1', more clear.
> 
> Let me know what you think.

OK, I am fine with it. Will see if other people have comment.

