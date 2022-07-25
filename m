Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C719457FD52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiGYKVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiGYKVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29798B84C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658744502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TBasacdOCgeyTRXs0rmM45vh9xBb7UFYHyR8k7XkxM=;
        b=TB378OmDba2MBA+x9lAKua736HM3AB527cSlp9xdQ9rD0EalA49ppTkcStw2cnaLdV7ujm
        2hwcJzujZzrcwxDgLXjLAJyx1WgG5sqcL/EahNNM6hnydoXYkFufo0gxqagXogQIF0W8UU
        vbJTrMo0pfLaZ8FX4dGAShRmxouiYsY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-oFflld4vNeWueXFOggtRig-1; Mon, 25 Jul 2022 06:21:40 -0400
X-MC-Unique: oFflld4vNeWueXFOggtRig-1
Received: by mail-wm1-f70.google.com with SMTP id v11-20020a1cf70b000000b003a318238826so3874772wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5TBasacdOCgeyTRXs0rmM45vh9xBb7UFYHyR8k7XkxM=;
        b=kQhimyBBCE7YObzCW1YPxN197swfKVyNzYBsZaMZBxP1oLPcKLBAWFXMEaT7Mgsdl1
         MYsLQR2m1gFX09r4ppc/jV0YMnu+93JxAWBhinzjJkA161X/XKvjQqEJmVjFyDv7NKGc
         vnNOjUb8kww1RrF9S7R5xN1KnqToDT94Z6rNPRj3Wi8PaTYT2KFcW9D/K4EROYjcBwtr
         E9bfFzaZgLUG7NX/bW5VL7VeNzpdgKNcLhqkDuV6Hr4d6Cp4Nsrv6y/wU0cUsN/xTKw4
         M2BfQowJul2BnpDGCgJelfV+Ey46QStiEj6nKeIqqFNgb7JtH2+wrbfXMkZrhqDMqurB
         wgdg==
X-Gm-Message-State: AJIora9vwKqxjuQ15Z11Nwncr+zTZH4u3MwCeYjKXThrmdCf+Xabe4wI
        FEXGyT4NFtk/sX8M+AVoEPsuoeUs1F7nvFNOIZYS631yJiLtdiURv/BaZiLPNStrAUO1lF8QbBt
        nH0jw2c6dOZ0hEFDuErcAJVTh
X-Received: by 2002:a5d:6dc7:0:b0:21e:4f85:fa3e with SMTP id d7-20020a5d6dc7000000b0021e4f85fa3emr7256236wrz.266.1658744499557;
        Mon, 25 Jul 2022 03:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vs2ufb9Het9pT+5RXC2eBgEE4mYeNOBwxZigOSoB8JZ05LSVIvt0ht0Mk3J4zNJuj27cmArw==
X-Received: by 2002:a5d:6dc7:0:b0:21e:4f85:fa3e with SMTP id d7-20020a5d6dc7000000b0021e4f85fa3emr7256214wrz.266.1658744499228;
        Mon, 25 Jul 2022 03:21:39 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id t20-20020a7bc3d4000000b003a3278d5cafsm17316566wmj.28.2022.07.25.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 03:21:38 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to
 exit()
In-Reply-To: <YtuEJLDkO/lATYeb@slm.duckdns.org>
References: <20220719165743.3409313-1-vschneid@redhat.com>
 <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
 <xhsmhv8rqfu6w.mognet@vschneid.remote.csb>
 <YtuEJLDkO/lATYeb@slm.duckdns.org>
Date:   Mon, 25 Jul 2022 11:21:37 +0100
Message-ID: <xhsmh8rohfq6m.mognet@vschneid.remote.csb>
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

On 22/07/22 19:16, Tejun Heo wrote:
> On Thu, Jul 21, 2022 at 02:53:43PM +0100, Valentin Schneider wrote:
>> > I think it needs something like task_set_cpumask_possible() which is
>> > documented as being usable in (raw) spinlocks and set the task's cpumask
>> > to cpu_possible_mask and let the later ttwu help migrate it to a
>> > proper non-isolated CPU or let it keep running.
>> 
>> I'll see what I can come up with, thanks for the suggestion.
>
> Alternatively, we can just kill all the idle kworkers on isolated cpus at
> the end of the booting process.
>

Hm so my choice of words in the changelog wasn't great - "initial setup"
can be kernel init, but *also* setup of whatever workload is being deployed
onto the system.

So you can be having "normal" background activity (I've seen some IRQs end
up with schedule_work() on isolated CPUs, they're not moved away at boot
time but rather shortly before launching the latency-sensitive app), some
preliminary stats collection / setup to make sure the CPU will be quiet
(e.g. refresh_vm_stats()), and *then* the application starts with
fresh-but-no-longer-required extra pcpu kworkers assigned to its CPU.

