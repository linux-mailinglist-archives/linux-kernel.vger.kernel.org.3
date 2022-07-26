Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A0581B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbiGZUgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiGZUgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F02E5FF8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658867771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u6lCMOJBxFXFYmVcVNt/zc0jKT+n1PEiVlC/ff/AZGk=;
        b=gA661EJuxGw6qRJUrUxiL7QpmAKRhw4vHOHlcEjn7fp2g/FtkUXCsZUN4uzr9bpeKUyzU2
        l05fcIA5KgPBhLuB72IHiEifpiSw7tj0o5DznjG7vIutZGlsA40Deu9FO/xVPpBpT7KJtX
        iH5RDUFGcKznJZa3q1iXgU0LQzePvbw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-HQZTz32qPjKAgOrSi5m_vw-1; Tue, 26 Jul 2022 16:36:09 -0400
X-MC-Unique: HQZTz32qPjKAgOrSi5m_vw-1
Received: by mail-wr1-f71.google.com with SMTP id o8-20020adfa108000000b0021e903fb612so1085535wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=u6lCMOJBxFXFYmVcVNt/zc0jKT+n1PEiVlC/ff/AZGk=;
        b=XOZV/lhW8crjIi2G//J0V6nl8I3PrGQKCITs4QcF/gz/h9SIKkgL3MuwrC3YHly+VN
         0rwCzppXYHceR09aiwp+9jtEkfO2F/3s6nmib0UvhM4hpEh4ZjTf7hcY1px/ZeGsjC+C
         Dge9+pMj8EWEYXtKLrYMFjvvtiNMI1ybBwBAgXV4F+1g0hFobF2wUAhhZJ5+uuKGWwpR
         SWgoIkNG6kWX/HJoCf1M1RN5SGRI6m5n9bFIXBzgGWh8EIBTvoVTRXRA7wDyYXfjI/H5
         4KmynJm74mIWV+RfkpVHKeWuph5hPURAV1EJIwDupjkMnJm90HSYRyiHHACGlnZc7EQO
         xR2g==
X-Gm-Message-State: AJIora/nRcr7zBT0ukHy1KWR1iszqQzSHD+V9zql3WVCGOEBIL2uKX5/
        v3hTSyL3dDSVax35rQ+pCYXAamQfNX5NEBC4SDglwXlPISfGzqcBN4gcb7Qw04WxSpZkzxKRy/F
        MDJsrjX6BviM78OUB4T6ulTft
X-Received: by 2002:a5d:6b89:0:b0:21e:b591:2b80 with SMTP id n9-20020a5d6b89000000b0021eb5912b80mr2143817wrx.33.1658867768661;
        Tue, 26 Jul 2022 13:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vAc4fJua9Ro/vxC/7kJgMBamDKNST3wUAXyOWoBgnK5RIuARyr3qU0uXWQIteyzohsPdnhWA==
X-Received: by 2002:a5d:6b89:0:b0:21e:b591:2b80 with SMTP id n9-20020a5d6b89000000b0021eb5912b80mr2143804wrx.33.1658867768400;
        Tue, 26 Jul 2022 13:36:08 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003a17ab4e7c8sm27632453wmp.39.2022.07.26.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:36:07 -0700 (PDT)
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
In-Reply-To: <YuAkroXHF+Zg45KU@slm.duckdns.org>
References: <20220719165743.3409313-1-vschneid@redhat.com>
 <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
 <xhsmhv8rqfu6w.mognet@vschneid.remote.csb>
 <YtuEJLDkO/lATYeb@slm.duckdns.org>
 <xhsmh8rohfq6m.mognet@vschneid.remote.csb>
 <YuAkroXHF+Zg45KU@slm.duckdns.org>
Date:   Tue, 26 Jul 2022 21:36:06 +0100
Message-ID: <xhsmhmtcvehmx.mognet@vschneid.remote.csb>
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

On 26/07/22 07:30, Tejun Heo wrote:
> Hello,
>
> On Mon, Jul 25, 2022 at 11:21:37AM +0100, Valentin Schneider wrote:
>> Hm so my choice of words in the changelog wasn't great - "initial setup"
>> can be kernel init, but *also* setup of whatever workload is being deployed
>> onto the system.
>>
>> So you can be having "normal" background activity (I've seen some IRQs end
>> up with schedule_work() on isolated CPUs, they're not moved away at boot
>> time but rather shortly before launching the latency-sensitive app), some
>> preliminary stats collection / setup to make sure the CPU will be quiet
>> (e.g. refresh_vm_stats()), and *then* the application starts with
>> fresh-but-no-longer-required extra pcpu kworkers assigned to its CPU.
>
> Ah, I see. I guess we'll need to figure out how to unbind the workers then.
>

I've been playing with different ways to unbind & wake the workers in a
sleepable context, but so far I haven't been happy with any of my
experiments.

What hasn't changed much between my attempts is transferring to-be-destroyed
kworkers from their pool->idle_list to a reaper_list which is walked by
*something* that does unbind+wakeup. AFAIA as long as the kworker is off
the pool->idle_list we can play with it (i.e. unbind+wake) off the
pool->lock.

It's the *something* that's annoying to get right, I don't want it to be
overly complicated given most users are probably not impacted by what I'm
trying to fix, but I'm getting the feeling it should still be a per-pool
kthread. I toyed with a single reaper kthread but a central synchronization
for all the pools feels like a stupid overhead.

If any of that sounds ludicrous please shout, otherwise I'm going to keep
tinkering :)

> Thanks.
>
> --
> tejun

