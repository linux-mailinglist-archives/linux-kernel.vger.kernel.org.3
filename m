Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722D649D175
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbiAZSJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:09:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236949AbiAZSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643220585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuZuCSoJ7IOU5R0KlMC3hriY2wg4jAss4q/D4xsgQ7E=;
        b=drm60M67+H1Oe25A0auAuaHLmjmBy/1Td/b1kTHJrCT//FHEHZEC3jAxdcw3qNS+Nr4R35
        Us841PNqQbSijciijhBMIL9Hx+OlN/NxexPUgVX0tlAG+XgAGxgsViXxMbjULiXEtSSxr3
        4mi303m2Z11OWqLRCjPz4/snCcQ/Lew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-pHznS-IqPpWydbDGSn3rSw-1; Wed, 26 Jan 2022 13:09:42 -0500
X-MC-Unique: pHznS-IqPpWydbDGSn3rSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A33486A8B3;
        Wed, 26 Jan 2022 18:09:41 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9710A74E8D;
        Wed, 26 Jan 2022 18:09:40 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C71E2416D8BE; Wed, 26 Jan 2022 15:03:45 -0300 (-03)
Date:   Wed, 26 Jan 2022 15:03:45 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v8 01/10] add basic task isolation prctl interface
Message-ID: <YfGNAXOpwTfKH01L@fuller.cnet>
References: <20211208161000.654492429@fuller.cnet>
 <20220120174301.GA213170@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120174301.GA213170@lothringen>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 06:43:01PM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 08, 2021 at 01:09:07PM -0300, Marcelo Tosatti wrote:
> > +int __copy_task_isolation(struct task_struct *tsk)
> > +{
> > +	struct isol_info *info, *new_info;
> > +
> > +	info = current->isol_info;
> > +	if (!(info->inherit_mask & (ISOL_INHERIT_CONF|ISOL_INHERIT_ACTIVE)))
> > +		return 0;
> > +
> > +	new_info = tsk_isol_alloc_context();
> > +	if (IS_ERR(new_info))
> > +		return PTR_ERR(new_info);
> > +
> > +	new_info->inherit_mask = info->inherit_mask;
> 
> Ok then it might be worth mentioning in the docs that the inheritance
> propagates to all the descendants and not just the immediate children,
> unless the inheritance is explicitly reconfigured by some children of course.

v9 has:

**PR_ISOL_CFG_SET**:

        Set task isolation configuration.
        The general format is::

                prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);		

	...

                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
                  (requires ISOL_INHERIT_CONF to be set). The new task
                  should behave, after fork/clone, in the same manner
                  as the parent task after it executed:

                        prctl(PR_ISOL_ACTIVATE_SET, &mask, ...);

                Note: the inheritance propagates to all the descendants and not
                just the immediate children, unless the inheritance is explicitly
                reconfigured by some children.

> 
> > +
> > +	if (info->inherit_mask & ISOL_INHERIT_CONF) {
> > +		new_info->quiesce_mask = info->quiesce_mask;
> 
> Looks like if the parent has oneshot quiesce features configured, those
> will be inherited as non-oneshot.

Good catch. v9 has:

+       if (info->inherit_mask & ISOL_INHERIT_CONF) {
+               new_info->quiesce_mask = info->quiesce_mask;
+               new_info->conf_mask = info->conf_mask;
+               new_info->oneshot_mask = info->oneshot_mask;
+       }

> 
> > +		new_info->conf_mask = info->conf_mask;
> > +	}
> > +
> > +	if (info->inherit_mask & ISOL_INHERIT_ACTIVE)
> > +		new_info->active_mask = info->active_mask;
> > +
> > +	tsk->isol_info = new_info;
> > +
> > +	return 0;
> > +}
> 
> Other than that:
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

OK, with the fixes above, i'll add your Acked-by to patches 1 and 2.
Let me know otherwise.

