Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CF64E496B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiCVW7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiCVW7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:59:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9E52AF4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:58:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647989890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KZmqIWUsNMYXl2gT3g4fFTJ6PZdhIsqispm8yUC9M3w=;
        b=bD5hxnD6T2R3jmD7zsUppaTtnMFJLEp0brDLhbSDaJYTpb+huVD+lVUZ69RHVvzRrts33N
        yahfL0q+//t/N22tD5GYhtHXeHwik4PKDooNwss+xATb96wqdgCmlvj9L1KlvPHKyWDOUB
        I1IJ+Aej6aQryELZ+kj6Gkfjsbtr0iENlDis4Ujawqd8klCfFFPlv1dlORfSfWCTBE2Xsr
        cEGmbREzmzLyZdWDjxumSv0oWujZxbsqZg8FnLOBeURnPdDpL/+Rw/48W0Tw1fjoOWOwa+
        KQltWnOE0nhk8NjNLWKWDDCc+sy3IzyYIEmdooC0xetyyEseTbpqwp8M4MScHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647989890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KZmqIWUsNMYXl2gT3g4fFTJ6PZdhIsqispm8yUC9M3w=;
        b=L+Feyt6w27UsVU/jSSP0J1vQ0JQYETrhrPbvq9ZKVVFUn3V+NUE4r94Irw6nAUwwM9zCgn
        Ikr0JR3PgirfWJDQ==
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Steven Price <steven.price@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2] cpu/hotplug: Set st->cpu earlier
In-Reply-To: <bc66bee6-7c99-b289-f5e9-ccaf03d5605d@arm.com>
References: <20220316153637.288199-1-steven.price@arm.com>
 <878rt2atre.ffs@tglx> <bc66bee6-7c99-b289-f5e9-ccaf03d5605d@arm.com>
Date:   Tue, 22 Mar 2022 23:58:09 +0100
Message-ID: <87wngla932.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22 2022 at 15:59, Vincent Donnefort wrote:
> On 22/03/2022 15:31, Thomas Gleixner wrote:
>> On Wed, Mar 16 2022 at 15:36, Steven Price wrote:
>>> Setting the 'cpu' member of struct cpuhp_cpu_state in cpuhp_create() is
>>> too late as other callbacks can be made before that point.
>> 
>> What?
>> 
>>          CPUHP_OFFLINE = 0,
>>          CPUHP_CREATE_THREADS,
>> 
>> The create threads callback is the very first callback which is invoked
>> for a to be plugged CPU on the control CPU. So which earlier callback
>> can be invoked and fail?
>> 
>> Thanks,
>> 
>>          tglx
>
>
> CPUHP_CREATE_THREADS itself can fail, before st->cpu is set.

Sure. But that does not explain the problem.

> Also, that value is used outside of the callbacks (cpuhp_set_state()
> in _cpu_up()).

And why on earth is this not spelled out in the changelog?

> But indeed this description could be refined a bit.

Indeed. But the description is not the only problem here:

It's completely uncomprehensible from the code in _cpu_up() _WHY_ this

     st->cpu = cpu;
     
assignment has to be there.

It's non-sensical if you really think about it, right?

That said, I'm pretty sure you can come up with:

 - a proper one time initialization of @st which solves your problem

 - a proper changelog which explains it

Thanks,

        tglx
