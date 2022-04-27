Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB39E511AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbiD0Owv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiD0Owq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C86113EF2E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651070973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S8aF0VPL+4RQxQVtMfo2MXRnGizw2GrCzAZka9s1hOs=;
        b=G19+4oyUuDeDaMlw+9isrJr7y5Wz7Nd15BR8TrcyLrFqpng6wewFUB7L0X9nDvUkytxgFT
        n/oWqccr9vvrhr9FL1oVxQ8M4UC5Xy13Q697mGaZxW5ePc8DfeyCYejItQSFswyeMLDRrl
        ZZwVQWdcw75pYDMlwAv3twQLPTE5iXs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-Y_zw08UAN02MVwYp7h4qaw-1; Wed, 27 Apr 2022 10:49:32 -0400
X-MC-Unique: Y_zw08UAN02MVwYp7h4qaw-1
Received: by mail-wm1-f70.google.com with SMTP id bh7-20020a05600c3d0700b003940829b48dso444167wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S8aF0VPL+4RQxQVtMfo2MXRnGizw2GrCzAZka9s1hOs=;
        b=UWosbDpUtP/DycuRm5kaVywkhBvEfhj8xZP3f8gZxiksBZlfZORglkRoWBeHl5mur0
         NHdKY8/kPlnbLUUrox1Ce8iCiK0GB3ChD4ng1xTkFsjtSnZlQYcfzud1dmDYWvYvFIWO
         rBvydkhZKUCjevDq6KA3HrBkpfo1NZ8gRo0DLsjM3sEK+upnCZpTUXrVe/CdwsnLPMge
         W4dL+VXEHDZhw7Z6TqJnKrGc1RH50rieKx0MhybMu3I56Tr16fn57iYNv+CxtdlKGgHc
         oRXXW2VAmni3YH6Hgam7nFRWfLum6YYflaiZVerCVaN6V6YZuZA7Dki5qVq+BoX33tbJ
         qMrg==
X-Gm-Message-State: AOAM533cffLM70asdGSmaBZ1kOloJkOGN23lqCm3IMeuvmKPVBNemnbr
        PQ6d7TsBLZVl6Z8b39LgitQxZ0vM9jO9k8Im6B0Sz0ObdfbAdXiNgXeIDxDt02RKgLJQAyw2gPj
        9FV1ZbvL32NbSsjz1f1F3IjY=
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr26699628wma.108.1651070971381;
        Wed, 27 Apr 2022 07:49:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHKXnL5bdu2mcDHhShjxqFTABJ09lFyznMIxEOecs7P5FwwJkvPf6gtu0Nf8qzIhsHmQki6g==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr26699608wma.108.1651070971212;
        Wed, 27 Apr 2022 07:49:31 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n4-20020a1ca404000000b00392965e41d6sm1707631wme.39.2022.04.27.07.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:49:30 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:49:27 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@gentwo.de>, frederic@kernel.org,
        mingo@kernel.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220427144927.c5as3sa4mheawea5@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
 <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
 <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
 <20220425132700.GK2731@worktop.programming.kicks-ass.net>
 <20220425141717.vw2jfnn3zp6c5ib2@ava.usersys.com>
 <Ymb018EaVlOUfx87@fuller.cnet>
 <20220427115020.kyaxc5j67lq5zrfq@ava.usersys.com>
 <875ymuy4h8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875ymuy4h8.ffs@tglx>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-27 16:40 +0200, Thomas Gleixner wrote:
> On Wed, Apr 27 2022 at 12:50, Aaron Tomlin wrote:
> > On Mon 2022-04-25 16:21 -0300, Marcelo Tosatti wrote:
> >> Is there anything that prevents a nohz full CPU from running an
> >> application with short and frequent idling?
> >
> > I'm not sure I understand the question; albeit, if I understand correctly,
> > yes: the scheduling-clock tick, if it was stopped.
> > Yet I believe this behaviour is correct. Consider the following example:
> >
> >   When a CFS task is moved/or migrated to a nohz_full CPU that was
> >   previously idle and had its tick stopped, if its the only task on the
> >   run-queue then it is possible that the idle task may not restart the
> >   tick (see __tick_nohz_full_update_tick()).  Thus once the CFS task exits
> >   manual intervention i.e. a reschedule IPI to wake the idle task, would be
> >   required to run again, on the same CPU.
> 
> When the task exits and the tick was stopped, why should idle restart
> the tick? There is nothing to do, so what?

Hi Thomas,

Indeed. As per my response, I do not see an issue. Perhaps I misunderstood
Marcelo's question, no?

Kind regards,

-- 
Aaron Tomlin

