Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78F5822FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiG0JWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiG0JWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91C49286D0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658913727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ZDlzRAMkegVPWxPq2KKHnYuVwCp3gEAY1Uf6P/ipZc=;
        b=JIaRbjBteXFecqhNf9vt2vyJ+verepWcI2WdlUOzdKTa36dX4Tf+d7S2abxzSbHlQEM0YM
        enNmpbJZG0cjFcddnlwqhy0eCKFEUfCUcDxqKDTuPGkdzo6k5MB4R1RvGXliwzUi+y5YvN
        p41eKcdLtYK5tE9jNcx7NxfPQ9MqVnE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-XF3JgDIkMZegRIMMgSRpkA-1; Wed, 27 Jul 2022 05:22:04 -0400
X-MC-Unique: XF3JgDIkMZegRIMMgSRpkA-1
Received: by mail-wm1-f70.google.com with SMTP id i133-20020a1c3b8b000000b003a2fe4c345cso921396wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+ZDlzRAMkegVPWxPq2KKHnYuVwCp3gEAY1Uf6P/ipZc=;
        b=RVg46Uac/lbzNWIG0/2BKkHqnjr/1bP3YmljudykOV4gyQRpIzr2jiKz+M7cf0SyMi
         huc7Fg8Gx8c0TfWfcaZSVTnSZa7Ev3nG8MOtbui346LzftqWFbI4nDbJfoh+wJhaljZ7
         MrE7rX+p9DcvsjIJ00kmIxvNNtdDr2QvvWkkMSZ9yms7gvT92puXsvEOhaQtloikKcD8
         9wlo8Lb8cb11tGHscYWd8akqkdo8uroeqIh5nJv+haluapp5luPsFu4En6Ejt7p0BZcn
         DkfuEdNQ1JPgtMCLnYrpDHlaatLTCJCDWrtXk+AeaigbM86KM8EpW2FHzTQ2fDRyOO3k
         hD1Q==
X-Gm-Message-State: AJIora/XLtoODSV21Dics6J4Nr099Kpr6dvv12i+5re2XL5muWeQqYWE
        yk9/rN35SnJSnR18PS2m8O7xf2c/AYz0a9Th7FzpDR4M+ssX02j9kChHglW1lTmLN47+H3QkLOK
        QyCIdH6m0ZaQ9u7kgrp7KmQI+
X-Received: by 2002:a05:600c:3586:b0:3a3:2c03:1088 with SMTP id p6-20020a05600c358600b003a32c031088mr2459912wmq.64.1658913723012;
        Wed, 27 Jul 2022 02:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uK3nKOJMY+w+L8erO9nzxjZBp/9/TrE6wqLlw+9o8CnC3Ya2S3KHqm/00ORL09WVnUmFxTMw==
X-Received: by 2002:a05:600c:3586:b0:3a3:2c03:1088 with SMTP id p6-20020a05600c358600b003a32c031088mr2459897wmq.64.1658913722753;
        Wed, 27 Jul 2022 02:22:02 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b00397402ae674sm1705562wma.11.2022.07.27.02.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:22:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to
 exit()
In-Reply-To: <CAJhGHyDQ537NatcsTFAsTz=pKadnCtTYfvK_tXE=Z5oRp5FQyA@mail.gmail.com>
References: <20220719165743.3409313-1-vschneid@redhat.com>
 <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
 <xhsmhv8rqfu6w.mognet@vschneid.remote.csb>
 <YtuEJLDkO/lATYeb@slm.duckdns.org>
 <xhsmh8rohfq6m.mognet@vschneid.remote.csb>
 <YuAkroXHF+Zg45KU@slm.duckdns.org>
 <xhsmhmtcvehmx.mognet@vschneid.remote.csb>
 <CAJhGHyA3gRmL=VCq2TAcc+TgBHCAizADJeukNRGmisa29U969g@mail.gmail.com>
 <CAJhGHyAEHFbcqzVbBRHoFcRYJ+M9cf87WwV2u=V4=Acrgp-gkQ@mail.gmail.com>
 <CAJhGHyDQ537NatcsTFAsTz=pKadnCtTYfvK_tXE=Z5oRp5FQyA@mail.gmail.com>
Date:   Wed, 27 Jul 2022 10:22:01 +0100
Message-ID: <xhsmhk07yewqu.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/22 16:55, Lai Jiangshan wrote:
> On Wed, Jul 27, 2022 at 2:30 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
>> >
>> > >
>> > > What hasn't changed much between my attempts is transferring to-be-destroyed
>> > > kworkers from their pool->idle_list to a reaper_list which is walked by
>> > > *something* that does unbind+wakeup. AFAIA as long as the kworker is off
>> > > the pool->idle_list we can play with it (i.e. unbind+wake) off the
>> > > pool->lock.
>> > >
>> > > It's the *something* that's annoying to get right, I don't want it to be
>> > > overly complicated given most users are probably not impacted by what I'm
>> > > trying to fix, but I'm getting the feeling it should still be a per-pool
>> > > kthread. I toyed with a single reaper kthread but a central synchronization
>> > > for all the pools feels like a stupid overhead.
>> >
>> > I think fixing it in the workqueue.c is complicated.
>> >
>> > Nevertheless, I will also try to fix it inside workqueue only to see
>> > what will come up.
>>
>> I'm going to kind of revert 3347fc9f36e7 ("workqueue: destroy worker
>> directly in the idle timeout handler"), so that we can have a sleepable
>> destroy_worker().
>>
>
> It is not a good idea.  The woken up manager might still be in
> the isolated CPU.
>
> On Wed, Jul 27, 2022 at 6:59 AM Tejun Heo <tj@kernel.org> wrote:
>>
>> I mean, whatever works works but let's please keep it as minimal as
>> possible. Why does it need dedicated kthreads in the first place? Wouldn't
>> scheduling an unbound work item work just as well?
>>
>
> Scheduling an unbound work item will work well.

I did play a bit with that yesterday (pretty much replacing the
pool->idle_timer with a delayed_work) but locking discouraged me - it's
quite easy to end up with a self-deadlock.

Now, I've slept over it and have a fresh cup of coffee, and it's been the
least intrusive-looking change I've tried, so let me give that a shot
again.

