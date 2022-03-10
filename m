Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4415E4D4FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiCJRA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiCJRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AE33F47F6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646931592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qt3CDQJKVzIsT9TVSQg9SdqCzF9dYBE8SsUrYs4k4eA=;
        b=Gx3xvWw8ieAcmO26PI0DXfm8YamNc5DwAbOcxXIy6+APkTzq7mlbWHTn0nOOhdvoN3Q98Q
        aH1IjrykBmYspoYByy3ta5M/QSafDoy5Lsuhl19i1zmmUfzBcVTdK9ErHMlLS23CgH62AI
        u8hLEIkLQUBwzFJVRc5C5Sjna6vPa2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-u9DRl8NgPXa7BTYf6RKqKw-1; Thu, 10 Mar 2022 11:59:51 -0500
X-MC-Unique: u9DRl8NgPXa7BTYf6RKqKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DADF800D55;
        Thu, 10 Mar 2022 16:59:49 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEF82865A2;
        Thu, 10 Mar 2022 16:59:20 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id DD89F416D5CB; Thu, 10 Mar 2022 13:35:51 -0300 (-03)
Date:   Thu, 10 Mar 2022 13:35:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v11 10/13] KVM: x86: process isolation work from VM-entry
 code path
Message-ID: <Yioo59Rd52rUZ/+F@fuller.cnet>
References: <20220204173537.429902988@fedora.localdomain>
 <20220204173554.897857855@fedora.localdomain>
 <20220207154707.GC526451@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207154707.GC526451@lothringen>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:47:07PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 04, 2022 at 02:35:47PM -0300, Marcelo Tosatti wrote:
> > VM-entry code path is an entry point similar to userspace return
> > when task isolation is concerned.
> > 
> > Call isolation_exit_to_user_mode before VM-enter.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> > v11
> > - Add TIF_TASK_ISOL bit to thread info flags and use it
> >   to decide whether to perform task isolation work on
> >   return to userspace                                   (Frederic W. Weisbecker)
> > 
> >  include/linux/entry-kvm.h |    4 +++-
> >  kernel/entry/kvm.c        |   18 ++++++++++++++----
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> > 
> > Index: linux-2.6/kernel/entry/kvm.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/entry/kvm.c
> > +++ linux-2.6/kernel/entry/kvm.c
> > @@ -2,6 +2,7 @@
> >  
> >  #include <linux/entry-kvm.h>
> >  #include <linux/kvm_host.h>
> > +#include <linux/task_isolation.h>
> >  
> >  static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
> >  {
> > @@ -22,6 +23,9 @@ static int xfer_to_guest_mode_work(struc
> >  		if (ti_work & _TIF_NOTIFY_RESUME)
> >  			tracehook_notify_resume(NULL);
> >  
> > +		if (ti_work & _TIF_TASK_ISOL)
> > +			task_isol_exit_to_user_mode();
> > +
> >  		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
> >  		if (ret)
> >  			return ret;
> > 
> > 
> 
> Do you need this?

Yes, dropped it somehow, thanks.

> 
> diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
> index 07c878d6e323..3588d6071caf 100644
> --- a/include/linux/entry-kvm.h
> +++ b/include/linux/entry-kvm.h
> @@ -18,7 +18,7 @@
>  
>  #define XFER_TO_GUEST_MODE_WORK						\
>  	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
> -	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
> +	 _TIF_NOTIFY_RESUME | _TIF_TASK_ISOL | ARCH_XFER_TO_GUEST_MODE_WORK)
>  
>  struct kvm_vcpu;
>  
> 
> 

