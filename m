Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC74468F09
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhLFCRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:17:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233696AbhLFCRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638756848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z2tF09mtqgD2eJWh5yotOfJsY9SZ1q0wufIK2Ea7XE0=;
        b=a2lrXw2APgW9U9aSeFO2BiJmXYjux5yUI1q2niwb01Zm1/YxDp0VRcJ0fZR1aQm4PyDnga
        MTEWE6cdj+b46vUe9dvBqSeXV1igoGY8qiHY/1l4fyp5t1IUs48LOJPL0nVQAo9C4ww2as
        MYyKRwzNoGj7wJkAgoxceCNtcp/xysk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-NyjQ0MoYN5eV7O4vuoCiHg-1; Sun, 05 Dec 2021 21:14:05 -0500
X-MC-Unique: NyjQ0MoYN5eV7O4vuoCiHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 038C518C89C4;
        Mon,  6 Dec 2021 02:14:04 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FC3D5E24E;
        Mon,  6 Dec 2021 02:13:58 +0000 (UTC)
Date:   Mon, 6 Dec 2021 10:13:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH V2 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <Ya1x4VQymqhy9FDD@T590>
References: <20211129034509.2646872-1-ming.lei@redhat.com>
 <20211129034509.2646872-3-ming.lei@redhat.com>
 <YaoyuzPutBjLuVNt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaoyuzPutBjLuVNt@kroah.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:07:39PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 29, 2021 at 11:45:09AM +0800, Ming Lei wrote:
> > kobject_put() may become asynchronously because of
> > CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> > expect the kobject is released after the last refcnt is dropped, however
> > CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> > for cleaning up the kobject.
> 
> The caller should NOT expect the kobject to be released.  That's the
> whole point of dynamic reference counted objects, you never "know" when
> the last object is released.  This option just makes it obvious so that
> you know when to fix up code that has this assumption.

Yes, so CONFIG_DEBUG_KOBJECT_RELEASE needs to be fixed.

> 
> > Inside the cleanup handler, kobj->ktype and kobj->ktype->release are
> > required.
> 
> Yes. Is that a problem?

Of course for CONFIG_DEBUG_KOBJECT_RELEASE, which delays to call
->release after random time, when the module for storing ->ktype and
->ktype->release has been unloaded.

As I mentioned, the issue can be triggered 100% by 'modprobe -r
kset-example' when CONFIG_DEBUG_KOBJECT_RELEASE is enabled if the
1st patch is applied.

> 
> > It is supposed that no activity is on kobject itself any more since
> > module_exit() is started, so it is reasonable for the kobject user or
> > driver to expect that kobject can be really released in the last run of
> > kobject_put() in module_exit() code path. Otherwise, it can be thought as
> > one driver's bug since the module is going away.
> 
> Why is module_exit() somehow special here?  What is so odd about that?

After module_exit() is done, the module will be unloaded, then any code
or data stored in the module can't be referred.

> 
> > When the ->ktype and ->ktype->release are allocated as module static
> > variable, it can cause trouble because the delayed cleanup handler may
> > be run after the module is unloaded.
> 
> Why is ktype and release part of module code?

Lots of driver defines ktype and ktype->release in its module static
variable.

> 
> What module kobject is causing this problem?

Any modules which defines its ktype and ktype->release in its module
static variable, which is pretty common.

> 
> > Fixes the issue by flushing scheduled kobject cleanup work before
> > freeing module.
> 
> Why are modules special here?
> 
> And if you enable this option, and then start unloading kernel modules,
> yes, things can go wrong, but that's not what this kernel option is for
> at all.
> 
> This feels like a hack for not a real problem.

I think it is caused by CONFIG_DEBUG_KOBJECT_RELEASE, that is why this
patch is posted. Otherwise I'd suggest to remove
CONFIG_DEBUG_KOBJECT_RELEASE, which supposes to not panic kernel since
there isn't anything wrong from driver side.


Thanks,
Ming

