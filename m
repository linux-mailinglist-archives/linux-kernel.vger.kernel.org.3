Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E608E5880BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiHBRHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiHBRHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:07:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948633340E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:06:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t1so22841869lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZXWj8bAr14o0Agc06qVEnrp82B9KIUIFNSkdgF3Gohc=;
        b=cBO7meugLJqyR+4TK+L2GvQ1jwGL7IEu5mBgrr0z7hLEJmgMGEus+W0LqYvkdEaxU7
         gWEFucqgGrc6ngDSOxBhjuO8b1xGU12K1m+wdKSbUky1Y6ACeFyS+G+q4VSo34iVs0p/
         ZLf8euyc/cxp8VDona9sw7igkjVYASpFKYzhJlkcdeuXBMq0tVNrdLnPOqfXB2LnJxz2
         lXYzIZXbEqjE5EJEQ4ESz767wYzWFLAWiqRR/E8OQ45TwsYNtH0+Jget0BeZPcB339Mn
         IKwOVtQ7Vk443URjhpJgugm6ZdwpYs8Slz59bjQF3mJ3RYMECgSo/DFnzEHVj7jPszFM
         y/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZXWj8bAr14o0Agc06qVEnrp82B9KIUIFNSkdgF3Gohc=;
        b=HTDl246Ol1cLYj/YgCMvEyf/GwVHBXrMM9Qz2nbMDup+lEeNhabFxZJaB2ATwWCzue
         ejV5jsFIRtMSV1GJsgXnkSwquUPzorBYffl4MmZj2KWHHPUWynab/vUIf7IF0+g79CI9
         arerdhqx6+KqlqLwWOvMOtp8kyL/fIgQD6TbOqFzODW2o6N6JP49QEJ5UXB9KvfYmbb3
         1LK8gJvlM+jqN4KuAkBG9HMiiDaOOBOsGfH+1twq4HEi//1uH/B+cV/hVZPCoKR7FzbW
         8sm12C66EZtoKqZp6W3ikoefD25S6nqzjh6YLmFKL23kXYfXhnTHDT2D6pFvbP4A3Ihs
         E5fA==
X-Gm-Message-State: AJIora+YslT69hK7Jn+n9STrcKlDBUNzvQ3uYwJ1Z81z3QwJkJRUz3v5
        OM65s/rDfxfzuFIXjVMPvwItUxuU7upWmjSsvb45xKZgz+sFAg==
X-Google-Smtp-Source: AGRyM1sPNLZq14qYNmP60AzGtHJUw6471TvUJfcxP5adnc8e8cgleoWQVR5+TC6UWESg14FbmxpVeNGf67+b9zKlVuM=
X-Received: by 2002:a05:6512:10ce:b0:489:cc6b:fad with SMTP id
 k14-20020a05651210ce00b00489cc6b0fadmr8328207lfg.299.1659460017708; Tue, 02
 Aug 2022 10:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
 <CAFTs51UAyc4Z5WUFdMXCTYR6zji6NwLeBxYsp9GQZvFdEtUm1w@mail.gmail.com> <500891137.95782.1659452479846.JavaMail.zimbra@efficios.com>
In-Reply-To: <500891137.95782.1659452479846.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 2 Aug 2022 10:06:45 -0700
Message-ID: <CAPNVh5dviLMLS5APS8M+n9cHups2zvoJvcguqnO0aPO8bi4DDQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] RSEQ node id and virtual cpu id extensions
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@aculab.com>,
        carlos <carlos@redhat.com>, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 8:01 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>

[...]

> >
> > We have experimented with several approaches here. The one that we are
> > currently using is the "flat" model: we allocate vcpu IDs ignoring numa nodes.
> >
> > We did try per-numa-node vcpus, but it did not show any material improvement
> > over the "flat" model, perhaps because on our most "wide" servers the CPU
> > topology is multi-level. Chris Kennelly may provide more details here.
>
> I would really like to know more about Google's per-numa-node vcpus implementation.
> I suspect you guys may have taken a different turn somewhere in the design which
> led to these results. But having not seen that implementation, I can only guess.
>
> I notice the following Google-specific prototype extension in tcmalloc:
>
>   // This is a prototype extension to the rseq() syscall.  Since a process may
>   // run on only a few cores at a time, we can use a dense set of "v(irtual)
>   // cpus."  This can reduce cache requirements, as we only need N caches for
>   // the cores we actually run on simultaneously, rather than a cache for every
>   // physical core.
>   union {
>     struct {
>       short numa_node_id;
>       short vcpu_id;
>     };
>     int vcpu_flat;
>   };
>
> Can you tell me more about the way the numa_node_id and vcpu_id are allocated
> internally, and how they are expected to be used by userspace ?

Based on a "VCPU policy" flag passed by the userspace during rseq registration
request, our kernel would:
- do nothing re: vcpus, i.e. behave like it currently does upstream;
- allocate VCPUs in a "flat" manner, ignoring NUMA;
- populate numa_node_id with the value from the function with the same name in
  https://elixir.bootlin.com/linux/latest/source/include/linux/topology.h
  and allocate vcpu_id within the numa node in a tight manner.

Basically, if there are M threads running on node 0 and N threads
running on node 1 at time T, there will be [0,M-1] vcpu IDs associated with
node 0 and [0,N-1] vcpu IDs associated with node 1 at this moment
in time. If a thread migrates across nodes, the balance would change
accordingly.

I'm not sure how exactly tcmalloc tried to use VCPUs under this policy, and
what were the benefits expected. The simplest way would be to keep
a freelist per node_id/vcpu_id pair (basically, per vcpu_flat in the union),
but this would tend to increase the number of freelists due to thread
migrations,
so benefits should be related to memory locality, and so somewhat difficult to
measure precisely.

Chris Kennelly may offer more details here.

Thanks,
Peter
