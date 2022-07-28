Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF665844EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiG1RYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiG1RYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D52CE5FAED
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659029061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTCAQ/2O9rI/7HtP9wa4OSuDQhJYkbO4HcHfXDMOkEc=;
        b=Xo5iGVdz2emTlwcGPL9VlQjCaQ6ulwWTyqtNbzscX09yLdmMyd8r6F5pO8RqVT6EHu/Q1J
        gboYztbnmkFDOf50kRR+jCVmn0s8Uo2D32kgGc3h4WHyRR3CA59W9DlKD3IAsJRNnrGoMe
        l3M/4jX9wHU6BYCsgSD6bWSfmIkvLUo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-oopDrEpmOi-e2t_pJFAKtA-1; Thu, 28 Jul 2022 13:24:19 -0400
X-MC-Unique: oopDrEpmOi-e2t_pJFAKtA-1
Received: by mail-wr1-f72.google.com with SMTP id m2-20020adfc582000000b0021e28acded7so599072wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=BTCAQ/2O9rI/7HtP9wa4OSuDQhJYkbO4HcHfXDMOkEc=;
        b=J7273pA2tMNPlqDT1FIvW86O0EfgwKGabeqlCItkzEy2DQZa2m0+Z3t8JEAkBxNzOP
         n5qUz1rxMXnSxKy9AfSf9AcR9JwqTFBjlps+Btr/eFmurFkTxPQrktTRbCQ+nkePix+K
         UiYyr97kcfWJBRsq90BeGNFu6nlD/hApbtzGk7th9e0Q9bZXLtMMOY662eLyWr2WNyhS
         eFJUqbB/hPPMjgyead3b0P6Nzy91UA3fc+/Q67FtQfukgApZy88+z4pMFX5yF0aulrIj
         0GbT3kH4NHmTNTPCMTe26tJhIorC4+ZCCUZZYHvWCyuU1qqfZYPSpONMusEiJOyyIBY2
         PDnQ==
X-Gm-Message-State: AJIora+L2K0eDrjCJpF2q6Uw3A7DXHMp6nfjjOuaC2MNOSowQFC+qnX2
        pKHoLgxCJIAHdDxpG5vs7VMQrL3AiRaF2af6dfL8F8Et2UopLk2YPHMsJwVgQCPPb0WSKAUsF18
        9ODeDrcazzjW/5eFbHL6Q01cd
X-Received: by 2002:a7b:ce87:0:b0:3a3:19bf:35e0 with SMTP id q7-20020a7bce87000000b003a319bf35e0mr291365wmj.120.1659029058581;
        Thu, 28 Jul 2022 10:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t3YZybr+YnX6CcQA+ryVcN/sTw+U4A0+0EYIenQp5eA6drZXWQb/MeyYub2TCAaLfoxlf52w==
X-Received: by 2002:a7b:ce87:0:b0:3a3:19bf:35e0 with SMTP id q7-20020a7bce87000000b003a319bf35e0mr291356wmj.120.1659029058427;
        Thu, 28 Jul 2022 10:24:18 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c2ccf00b003a327f19bf9sm7315026wmc.14.2022.07.28.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:24:17 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] workqueue: Unbind workers before sending
 them to exit()
In-Reply-To: <YuK6zzmlFJ376UeD@slm.duckdns.org>
References: <20220727115327.2273547-1-vschneid@redhat.com>
 <20220727115327.2273547-2-vschneid@redhat.com>
 <CAJhGHyCeraX1jcea9kt_FBC561zBgECuw5qx8TAdCG0EHnT6kA@mail.gmail.com>
 <xhsmhedy5ecdg.mognet@vschneid.remote.csb>
 <YuK6zzmlFJ376UeD@slm.duckdns.org>
Date:   Thu, 28 Jul 2022 18:24:17 +0100
Message-ID: <xhsmh8roddubi.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/22 06:35, Tejun Heo wrote:
> On Thu, Jul 28, 2022 at 11:54:19AM +0100, Valentin Schneider wrote:
>> On 28/07/22 01:13, Lai Jiangshan wrote:
>> > system_unbound_wq doesn't have a rescuer.
>> >
>> > A new workqueue with a rescuer needs to be created and used for
>> > this purpose.
>> >
>>
>> Right, I think it makes sense for those work items to be attached to a
>> WQ_MEM_RECLAIM workqueue. Should I add that as a workqueue-internal
>> thing?
>
> I don't understand why this would need MEM_RECLAIM when it isn't sitting in
> the memory reclaim path. Nothing in mm side can wait on this.
>

Vaguely reading the doc I thought that'd be for anything that would
directly or indirectly help with reclaiming memory (not explicitly sitting
in some *mm reclaim* path), and I assumed freeing up a worker would count as
that - but that's the understanding of someone who doesn't know much about
all that :-)

>> > Since WORKER_DIE is set, the worker can be possible freed now
>> > if there is another source to wake it up.
>> >
>>
>> My understanding for having reap_worker() be "safe" to use outside of
>> raw_spin_lock_irq(pool->lock) is that pool->idle_list is never accessed
>> outside of the pool->lock, and wake_up_worker() only wakes a worker that
>> is in that list. So with destroy_worker() detaching the worker from
>> pool->idle_list under pool->lock, I'm not aware of a codepath other than
>> reap_worker() that could wake it up.
>
> There actually are spurious wakeups. We can't depend on there being no
> wakeups than ours.
>

Myes, I suppose if a to-be-destroyed kworker spuriously wakes before having
been unbound then there's not much point in having the unbinding (harm has
been done and the kworker can do_exit(), though arguably we could reduce
the harm and still move it away), but let me see what I can do here.

> Thanks.
>
> --
> tejun

