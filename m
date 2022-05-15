Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AEE527A6F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiEOVgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiEOVgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:36:38 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AB713DF0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 14:36:35 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 099445A0DA2;
        Sun, 15 May 2022 21:36:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 665145A1583;
        Sun, 15 May 2022 21:36:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1652650591; a=rsa-sha256;
        cv=none;
        b=LgdPE8NOMB4Kh7lUuUn6Yw14uARfgc/aEN3BEwLlhw7lQnMgI6kdxgKr1TkXeZgKL23aVv
        EGSVJeNeuOfJr1EsoFNX5xjLsZhCozyEh1/NyPhjXZtcc/CgFKRwq6tnp6qy8OMoaNle7S
        qNc5+ULhTs7wXlkqqhnppZKUWkoluEhoJZisSd7ujZmx2BPwcCH3h8Azb9XBeqd18tW0R4
        GQrJs3b3NFZmGZaEREB4h+eSdCyqVqjF8WKITXhiD3W8iH7hGIppsCvZq+PNYXB0Jr8sYA
        e/aDE1PIgk5jFLNgcY9hkPWgY763G7Px4HSm7Eie5rs/aqu7y4d7UAoKNAPXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1652650591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4YrQnMDt0+5+4+E+HKFDCXkGSxW5eIifGAL66j7/sxI=;
        b=lo7GakGCNHdSAZBc3f7ORE+4gDRNNIsk7q5ZUmErD+KJv5dwAl/DYkd5V0SWf5O2uCR+sa
        yT1MIsDQAg2ZGUeXrpzvYK4g94p+cfdL4s12IfZgYQMBSSQRJf/OrcbceDWFChOGyeIO5N
        KiekEBpFeb/Z2IQ0Kvbj2nS1mUZfvNpDyHTgiU5N/+ILbUtX2Kb5kawXy5h2vHAxu9EqYS
        o7/bNCwGRLsFU+Qrvt9QytGcW0JX0EgLt14nXmfRqCb3pgddYh1bvt7vf15esLiZE/hn4Y
        vDzncrjInisiC760hSrBjdpteL9TfRV91OMU1eSD1TdGOJ0A1myprrBbIsxxkw==
ARC-Authentication-Results: i=1;
        rspamd-554c8f6c56-mmrs7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Madly-Madly: 71319b7470d107b1_1652650591872_3404003711
X-MC-Loop-Signature: 1652650591872:2864187479
X-MC-Ingress-Time: 1652650591872
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.45.17 (trex/6.7.1);
        Sun, 15 May 2022 21:36:31 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4L1bL54MSTzlR;
        Sun, 15 May 2022 14:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1652650591;
        bh=4YrQnMDt0+5+4+E+HKFDCXkGSxW5eIifGAL66j7/sxI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=lI69PTyrU+cc5IeqSeZ1Ce9igsVBvOFWig9gIrxzNLxnkg0WSpk2J2n865MtjDlej
         FXnZ3nJIqlY4bZWaTlFGAUX9T7/fKTXTek2zl7z06usWKHX8qygkHQuVVCP9anfc+b
         /wbT7Sx+TTlua3THNaj2XyrMyfm1c8cBahKI/w1D+9aSNaE0K2pTe7bV9+YHGeHMSc
         U+ki61r28TrdOlu9mKQ+V/4Ubs3YKgNv684Mz24p5R8lpW7XjdPumHAH8wUvuO2F8i
         6B/HkcEeiOIn+VQT3NxNj/Qvitdr/C02gc7tBJHZaOWxKNepe1BbCfTJXOCnNxhnI/
         sl1T47TnGm7LQ==
Date:   Sun, 15 May 2022 14:24:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Christophe de Dinechin <dinechin@redhat.com>
Cc:     trivial@kernel.org, Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 0/3] trivial: Fix several compilation errors/warnings
 with GCC12
Message-ID: <20220515212404.3nfnalivgsyyu7ii@offworld>
References: <20220414150855.2407137-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220414150855.2407137-1-dinechin@redhat.com>
User-Agent: NeoMutt/20220408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello - What is the status of this? Currently gcc 12 (tumbleweed) is unable to
build Linus' latest because of splats in the scheduler headers...

Thanks,
Davidlohr

On Thu, 14 Apr 2022, Christophe de Dinechin wrote:

>Compiling with GCC 12 using defconfig generates a number of build errors
>due to new warnings, notably array-bounds checks. Some of these warnings appear
>legitimate and relatively easy to fix.
>
>Note that this series is not sufficient for a clean build yet. There are
>in particular a number of warnings reported by the array-bounds check
>that appear bogus, like:
>
>| In function ???__native_read_cr3???,
>|     inlined from ???__read_cr3???
>|         at ./arch/x86/include/asm/special_insns.h:169:9,
>|     inlined from ???read_cr3_pa???
>|         at ./arch/x86/include/asm/processor.h:252:9,
>|     inlined from ???relocate_restore_code???
>|         at arch/x86/power/hibernate.c:165:17:
>| ./arch/x86/include/asm/special_insns.h:48:9: error:
>|    array subscript 0 is outside array bounds of ???unsigned int[0]???
>|    [-Werror=array-bounds]
>|    48 | asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
>|       | ^~~
>| cc1: all warnings being treated as errors
>
>The error above is for an instruction that does not obviously address any
>C array, in particular since the asm constraint is "=r" and not "=rm".
>
>Consequently, the series here only addresses a few low hanging fruits that
>appear legitimate and relatively easy to fix.
>
>Christophe de Dinechin (3):
>  sched/headers: Fix compilation error with GCC 12
>  nodemask.h: Fix compilation error with GCC12
>  virtio-pci: Use cpumask_available to fix compilation error
>
> drivers/virtio/virtio_pci_common.c |  2 +-
> include/linux/nodemask.h           | 13 ++++++-------
> kernel/sched/sched.h               | 11 +++++++++--
> 3 files changed, 16 insertions(+), 10 deletions(-)
>
>--
>2.35.1
>
>
