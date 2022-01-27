Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C810549DBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiA0Hvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbiA0Hvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643269905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vKF0TdKO5aLrjOXdwkWmOrj4HOBqyJ5h5J0cv79n6sQ=;
        b=TskWW7+P46ysF1NiJFRhsAu9lVvAkRZ4XgNB/N4+n3SlemgP5hFNMeNmTbgYho1ZvPCBOR
        NUUpbbG14nFZAsk/TCoAtrOc9PXtS6K83DZt7TfUV6WoGJqSz1Pya0zFyFOWauZJi2rp0E
        lWDdC11d4dEvFys2GHw3DjN4x5M3tCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-ciO0PeyfMQSyefdsrr_BZQ-1; Thu, 27 Jan 2022 02:51:41 -0500
X-MC-Unique: ciO0PeyfMQSyefdsrr_BZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75B1B8144E2;
        Thu, 27 Jan 2022 07:51:39 +0000 (UTC)
Received: from localhost (ovpn-13-51.pek2.redhat.com [10.72.13.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FC1B1059103;
        Thu, 27 Jan 2022 07:51:35 +0000 (UTC)
Date:   Thu, 27 Jan 2022 15:51:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 6/6] crash hp: Add x86 crash hotplug support
Message-ID: <20220127075132.GB13508@MiWiFi-R3L-srv>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-7-eric.devolder@oracle.com>
 <20220119102323.GB6349@MiWiFi-R3L-srv>
 <280485c9-4612-892c-0e3e-9e8b09e60cf9@oracle.com>
 <20220126091243.GB6588@MiWiFi-R3L-srv>
 <cf834659-3d8c-7ab5-ccd4-c877b0b9a2f0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf834659-3d8c-7ab5-ccd4-c877b0b9a2f0@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26/22 at 11:32am, Eric DeVolder wrote:
..snip.... 
> > > > > +void arch_crash_hotplug_handler(struct kimage *image,
> > > > > +	unsigned int hp_action, unsigned long a, unsigned long b)
> > > > > +{
> > > > > +	/*
> > > > > +	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
> > > > > +	 * is passed to the crash kernel via the elfcorehdr= parameter)
> > > > > +	 * must be updated with the new list of CPUs and memories. The new
> > > > > +	 * elfcorehdr is prepared in a kernel buffer, and if no errors,
> > > > > +	 * then it is written on top of the existing/old elfcorehdr.
> > > > > +	 *
> > > > > +	 * Due to the change to the elfcorehdr, purgatory must explicitly
> > > > > +	 * exclude the elfcorehdr from the list of segments it checks.
> > > > > +	 */
> > > > 
> > > > Please move this code comment to above function as kernel-doc if you
> > > > this it benefits the entire function. Otherwise should move them above
> > > > the code block they are explaining. For this place, I think moving them
> > > > to above arch_crash_hotplug_handler() is better.
> > > 
> > > ok, I will do that!
> > > 
> > > > 
> > > > > +	struct kexec_segment *ksegment;
> > > > > +	unsigned char *ptr = NULL;
> > > > > +	unsigned long elfsz = 0;
> > > > > +	void *elfbuf = NULL;
> > > > > +	unsigned long mem, memsz;
> > > > > +	unsigned int n;
> > > > > +
> > > > > +	/*
> > > > > +	 * When the struct kimage is alloced, it is wiped to zero, so
> > > > > +	 * the elf_index_valid defaults to false. It is set on the
> > > > > +	 * kexec_file_load path, or here for kexec_load.
> > > > > +	 */
> > > > 
> > > > I think this kexec loading part should be taken out and post after this
> > > > whole patchset being accepted. At least, it's worth to put them in a
> > > > separate patch.
> > > 
> > > This little bit of code that identifies the incoming elfcorehdr is all that
> > > is needed to support kexec_load (and the userspace changes of course). I'm
> > > happy to split as a separate patch, but I would think that be maintaining it
> > > with this series, then when it is accepted, both the kexec_load and
> > > kexec_file_load paths would be supported? Your call.
> > 
> > Hmm, at first, let's split it out from this patch since it's an
> > independent action to kdump. I would suggest we don't carry it in this
> > series. After this series is done, you can post another patchset
> > including this part as kernel patch, and also the code change in
> > kexec_tools as user space patch.
> > 
> > ......
> > 
> 
> OK, I'll remove the bit of code that supports kexec_load, so it can be introduced
> later coincident with the changes to kexec-tools.
> 
> In a previous message you mentioned making changes to the order of the patches,
> was this it, or is there more to come?

Yeah, replied to cover letter, please check it there.

