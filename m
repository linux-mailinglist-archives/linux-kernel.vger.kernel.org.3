Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15713464E58
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349437AbhLANDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:03:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231522AbhLANDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638363585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sg8l2MRrVgwVYF/kylOGA8bx10bbph5Fc99GNmoeU0E=;
        b=I81yP3Wf2NgcZLy+J1JAiMeATjtgPLDtLGi+8kVDF42UmPI373qPH4Vh2iXgo5AVlcSzgt
        8ipC5bec+qDZnUg4sMuGc/3QgY0xedQ+uOvnAxPUsQ0McIm5E4YzTEgfwbCI1OaeEKZgRO
        rIPX1KpR4gt2s6JSAFAhir7VPTUHn6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-BTzpM1ctP6maZHaVhwnGmg-1; Wed, 01 Dec 2021 07:59:40 -0500
X-MC-Unique: BTzpM1ctP6maZHaVhwnGmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5CC681EE82;
        Wed,  1 Dec 2021 12:59:37 +0000 (UTC)
Received: from localhost (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3BAA45D66;
        Wed,  1 Dec 2021 12:59:05 +0000 (UTC)
Date:   Wed, 1 Dec 2021 20:59:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        akpm@linux-foundation.org
Subject: Re: [RFC v1 0/8] RFC v1: Kernel handling of CPU and memory hot
 un/plug for crash
Message-ID: <20211201125903.GQ21646@MiWiFi-R3L-srv>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
 <20211124090227.GA8026@MiWiFi-R3L-srv>
 <200f923a-d196-7475-99e3-63ff3e73b28e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200f923a-d196-7475-99e3-63ff3e73b28e@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ akpm

On 11/29/21 at 01:42pm, Eric DeVolder wrote:
> Hi, see below.
> eric
> 
> On 11/24/21 03:02, Baoquan He wrote:
> > Hi,
> > 
> > On 11/18/21 at 12:49pm, Eric DeVolder wrote:
> > ......
> > > This patchset introduces a generic crash hot un/plug handler that
> > > registers with the CPU and memory notifiers. Upon CPU or memory
> > > changes, this generic handler is invoked and performs important
> > > housekeeping, for example obtaining the appropriate lock, and then
> > > invokes an architecture specific handler to do the appropriate
> > > updates.
> > > 
> > > In the case of x86_64, the arch specific handler generates a new
> > > elfcorehdr, which reflects the current CPUs and memory regions, into a
> > > buffer. Since purgatory also does an integrity check via hash digests
> > > of the loaded segments, purgatory must also be updated with the new
> > 
> > When I tried to address this with a draft patch, I started with a
> > different way in which udev rule triggers reloading and only elfcorehdr
> > segment is updated. The update should be less time consuming. Seems
> > internal notifier is better in your way. But I didn't update purgatory
> > since I just skipped the elfcorehdr part when calculate the digest of
> > segments. The reason from my mind is kernel text, initrd must contribute
> > most part of the digest, elfcorehdr is much less, and it will simplify
> > code change more. Doing so let us have no need to touch purgatory at
> > all. What do you think?
> 
> Well certainly if purgatory did not need to be updated, then that simplifies
> matters quite a bit!
> 
> I do not have any context on the history of including elfcorehdr in the purgatory
> integrity check. I do agree with you that checking kernel, initrd, boot_params
> is most important. Perhaps allowing the elfcorehdr data structure to change
> isn't too bad without including in the integrity check is ok as there is some
> sanity checking of it by the capture kernel as it reads it for /proc/vmcore setup.

Well, I think the check has included elfcorehdr since user space
kexec-tools added the check. We can do the skipping in kexec_file load
in kernel for the time being, see if anyone has concern about the
safety or security. Since agreement has been reached, can you split out
the purgatory update and repost a new patchset with the current
frame work to only update elfcorehdr?

Any by the way, I think you have written a very great cover letter which
tells almost all details about the change. However, pity that they are
not put in patch log. In your patch log, you just tell what change is
made in the patch, but the why we need it which is the most important part
is not seen. Most of time, we can get what change has been made from the
code, surely it's very helpful if patch log has told it and can save
reviewers much time, but it's not easy to get why it's needed or
introduced if not being involved in earlier discussion or any context.
And as you know, cover letter will be stripped away whem maintainers
merge patch, only patch log is kept.

Thanks
Baoquan

> 
> > 
> > Still reviewing.
> 
> Thank you!
> 
> > 
> > > digests. The arch handler also generates a new purgatory into a
> > > buffer, performs the hash digests of the new memory segments, and then
> > > patches purgatory with the new digests.  If all succeeds, then the
> > > elfcorehdr and purgatory buffers over write the existing buffers and
> > > the new kdump image is live and ready to go. No involvement with
> > > userspace at all.
> > 
> 

