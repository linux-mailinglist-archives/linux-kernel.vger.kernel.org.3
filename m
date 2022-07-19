Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B66457A296
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiGSPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiGSPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 122FD4D167
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658243031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hO0GcOh2yvTNG+WhHrYEQsIpzVdakt9pGpX73qoC2no=;
        b=G+jsYVwEJD8QF8HrAzwfKYNMmnoWQP6ixSvRTp1Tf+4x6kRt7z0WXX7pzlV3IRs3vkUACi
        mLDf1WHxDU5p1H6Yo4tHggP3+tdBCO/G8ExbiJOUwourCn62NfF2CDMBNi/OCi3w51Gh+L
        i6WeC6Xop/yJ9irRC5AUTRi7MfxrWWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-aILb4swFM5i5n6AjkanRlg-1; Tue, 19 Jul 2022 11:03:41 -0400
X-MC-Unique: aILb4swFM5i5n6AjkanRlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D59E882345;
        Tue, 19 Jul 2022 15:03:12 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0417C40E80E0;
        Tue, 19 Jul 2022 15:03:11 +0000 (UTC)
Date:   Tue, 19 Jul 2022 11:03:10 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/2] cpuhp: make target_store() a nop when target ==
 state
Message-ID: <YtbHrmDem1v++dBL@lorien.usersys.redhat.com>
References: <20220711211619.112854-1-pauld@redhat.com>
 <20220711211619.112854-2-pauld@redhat.com>
 <xhsmhk0896ujo.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhk0896ujo.mognet@vschneid.remote.csb>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:34:03PM +0100 Valentin Schneider wrote:
> On 11/07/22 17:16, Phil Auld wrote:
> > writing the current state back in hotplug/target calls cpu_down()
> > which will set cpu dying even when it isn't and then nothing will
> > ever clear it. A stress test that reads values and writes them back
> > for all cpu device files in sysfs will trigger the BUG() in
> > select_fallback_rq once all cpus are marked as dying.
> >
> > kernel/cpu.c::target_store()
> >       ...
> >         if (st->state < target)
> >                 ret = cpu_up(dev->id, target);
> >         else
> >                 ret = cpu_down(dev->id, target);
> >
> > cpu_down() -> cpu_set_state()
> >        bool bringup = st->state < target;
> >        ...
> >        if (cpu_dying(cpu) != !bringup)
> >               set_cpu_dying(cpu, !bringup);
> >
> > Fix this by letting state==target fall through in the target_store()
> > conditional. Also make sure st->target == target in that case.
> >
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> 
> One nit below, otherwise:
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>

Thanks!

> > ---
> >  kernel/cpu.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index bbad5e375d3b..305694a2ca26 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -2326,8 +2326,10 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
> >
> >       if (st->state < target)
> >               ret = cpu_up(dev->id, target);
> > -	else
> > +	else if (st->state > target)
> >               ret = cpu_down(dev->id, target);
> > +	else if (st->target != target)
> 
> Should we make this:
> 
>         else if (WARN(st->target != target))
>

If you think that's important I can make it a WARN, sure.

I'll try to remember to keep your Reviewed-bys this time if that's okay.



Cheers,
Phil

> > +		st->target = target;
> >  out:
> >       unlock_device_hotplug();
> >       return ret ? ret : count;
> > --
> > 2.31.1
> 

-- 

