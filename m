Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2555A4A7826
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346713AbiBBSl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbiBBSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643827318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvlTL8SOIBEnoLADrPhexPMo06dhYqvvFf7mqlCkN+M=;
        b=XlUn8cewMm7JlfBGJ1BSPPNy7b1ZeVa4/i9DgXAyZ3t1CmTjPTqdxMwSWPQupt1vv/R7Vy
        fg+V6aW34viA7CxiHlxQB+6BS5cLqldbYT9FDE4vCNh0zZkXW8ZM+K7c0jMshXNSsaC+74
        Aqm1gnu+GVCeHLkIaJy5XSR9SVa32g4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-rb38Fz9TNbO11eU0S6GB5A-1; Wed, 02 Feb 2022 13:41:55 -0500
X-MC-Unique: rb38Fz9TNbO11eU0S6GB5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8373110626E1;
        Wed,  2 Feb 2022 18:41:12 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19D3084D19;
        Wed,  2 Feb 2022 18:41:11 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 1BF03416CD79; Tue,  1 Feb 2022 15:31:59 -0300 (-03)
Date:   Tue, 1 Feb 2022 15:31:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     =?utf-8?B?5ZCRIOaZr+S6mA==?= <oscar0225@livemail.tw>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v10 1/10] add basic task isolation prctl interface
Message-ID: <Yfl8nwIOM0ZSiXZY@fuller.cnet>
References: <20220127173037.318440631@fedora.localdomain>
 <20220127173206.358254456@fedora.localdomain>
 <F94506EB-DA71-43F1-9126-8FBB134F6104@livemail.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F94506EB-DA71-43F1-9126-8FBB134F6104@livemail.tw>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 04:22:07AM +0000, 向 景亘 wrote:
> Hi,
> 
> On Jan 28, 2022, at 1:30 AM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > 
> > Index: linux-2.6/include/linux/task_isolation.h
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6/include/linux/task_isolation.h
> > @@ -0,0 +1,91 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __LINUX_TASK_ISOL_H
> > +#define __LINUX_TASK_ISOL_H
> > +
> > +#ifdef CONFIG_TASK_ISOLATION
> > +
> > +struct task_isol_info {
> > +	/* Which features have been configured */
> > +	u64 conf_mask;
> > +	/* Which features are active */
> > +	u64 active_mask;
> > +	/* Quiesce mask */
> > +	u64 quiesce_mask;
> > +
> > +	/* Oneshot mask */
> > +	u64 oneshot_mask;
> > +
> > +	u8 inherit_mask;
> > +};
> > +
> > +extern void __task_isol_free(struct task_struct *tsk);
> > +
> > +static inline void task_isol_free(struct task_struct *tsk)
> > +{
> > +	if (tsk->task_isol_info)
> > +		__task_isol_free(tsk);
> > +}
> > +
> > +int prctl_task_isol_feat_get(unsigned long arg2, unsigned long arg3,
> > +			     unsigned long arg4, unsigned long arg5);
> > +int prctl_task_isol_cfg_get(unsigned long arg2, unsigned long arg3,
> > +			    unsigned long arg4, unsigned long arg5);
> > +int prctl_task_isol_cfg_set(unsigned long arg2, unsigned long arg3,
> > +			    unsigned long arg4, unsigned long arg5);
> > +int prctl_task_isol_activate_get(unsigned long arg2, unsigned long arg3,
> > +				 unsigned long arg4, unsigned long arg5);
> > +int prctl_task_isol_activate_set(unsigned long arg2, unsigned long arg3,
> > +				 unsigned long arg4, unsigned long arg5);
> > +
> > +int __copy_task_isol(struct task_struct *tsk);
> > +
> > +#else
> > +
> > +static inline void task_isol_free(struct task_struct *tsk)
> > +{
> > +}
> > +
> > +static inline int prctl_task_isol_feat_get(unsigned long arg2,
> > +					   unsigned long arg3,
> > +					   unsigned long arg4,
> > +					   unsigned long arg5)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int prctl_task_isoln_cfg_get(unsigned long arg2,
> 
> I think this line should be "prctl_task_isol_cfg_get". 

Yes, fixed, thanks!

