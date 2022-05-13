Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0019F5265DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380373AbiEMPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381817AbiEMPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A74F6663C5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652455162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTq9ilDcl4Oroc8d2FZa/UfstF2HBb6rd+7kKNOuUmo=;
        b=R2EmOTgTPnbAWeuLJhJc1DdYXtcFSUDKC7sHN0PvbCRXMorU2Y3g/czkgYES1DNwD1eYtf
        3IGOIpN08/SXyjsuNIxGKsVaT4vQWZBD3f0Yup2CY74/+S5NvABmCmGSLrDHoWxJ+It8xO
        rKWNlEgXzLyBepAFGUV0Gh9PMtlv7RI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-Q2qmxi0DNFCkWXNc6BRbpg-1; Fri, 13 May 2022 11:19:21 -0400
X-MC-Unique: Q2qmxi0DNFCkWXNc6BRbpg-1
Received: by mail-wm1-f70.google.com with SMTP id u3-20020a05600c210300b0039430c7665eso3141006wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=NTq9ilDcl4Oroc8d2FZa/UfstF2HBb6rd+7kKNOuUmo=;
        b=MlgrDLNjqRLaKRcZmAITggR/fP8I3tdWpQTGeCMrKtr+Pk7Oup1mxZrS36kkTjBtsa
         ublgktu+/AWzlcpa4fbq18KizFlOT1wsCoxewsEe3yGJNxX+rKKmPuWZXKIbkRui3Fog
         o329xEEOyll3YX0tRELzmDg+iWPC/pLM/E0zonZ5MN7sG5oGoKLyhC3E2POAeH7IiUzl
         0hmlw66BwnoKmFRKw/8FDNtRYi2Nsp1erzFnVuVS8lMxyR4NN3S39icQ/W2rWWj8uMLe
         BhXNLCJaapFiNh0m2DHzZXaWFxQsUoM2FxjucQYIkE14Pdz39vtvj3vz5noFAOU8CIkp
         KJ7w==
X-Gm-Message-State: AOAM530TedXdX0CC2fhVjfOh2NddQBLgVX5usSGrKiZrUbnFX0N81AsH
        4JCwXSCwZkc+3ciPR0cvtN8E5jmB//rE8CN252mJimf6fZvaZiZNoQverP9pod3mXQP7c9iTht2
        DRAPZfk1WAwqP74Iuq6c4KgkT
X-Received: by 2002:a05:600c:4994:b0:394:dcb:d66d with SMTP id h20-20020a05600c499400b003940dcbd66dmr15479892wmp.178.1652455160222;
        Fri, 13 May 2022 08:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJd+uqBnpkb5/EK2zAx8aimGhL05ytMmLYzIQgtxlp5FRqWBVZ0uL7X0KwWiNTjox0x0aKdg==
X-Received: by 2002:a05:600c:4994:b0:394:dcb:d66d with SMTP id h20-20020a05600c499400b003940dcbd66dmr15479859wmp.178.1652455159912;
        Fri, 13 May 2022 08:19:19 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0? ([2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0])
        by smtp.gmail.com with ESMTPSA id y2-20020a05600c364200b00394699f803dsm5604106wmq.46.2022.05.13.08.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:19:19 -0700 (PDT)
Message-ID: <167d30f439d171912b1ef584f20219e67a009de8.camel@redhat.com>
Subject: Re: [PATCH 6/6] mm/page_alloc: Remotely drain per-cpu lists
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Fri, 13 May 2022 17:19:18 +0200
In-Reply-To: <20220513150402.GJ3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
         <20220512085043.5234-7-mgorman@techsingularity.net>
         <20220512123743.5be26b3ad4413f20d5f46564@linux-foundation.org>
         <20220513150402.GJ3441@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-13 at 16:04 +0100, Mel Gorman wrote:
> On Thu, May 12, 2022 at 12:37:43PM -0700, Andrew Morton wrote:
> > On Thu, 12 May 2022 09:50:43 +0100 Mel Gorman <mgorman@techsingularity.=
net> wrote:
> >=20
> > > From: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > >=20
> > > Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-c=
pu
> > > drain work queued by __drain_all_pages(). So introduce a new mechanis=
m to
> > > remotely drain the per-cpu lists. It is made possible by remotely loc=
king
> > > 'struct per_cpu_pages' new per-cpu spinlocks. A benefit of this new s=
cheme
> > > is that drain operations are now migration safe.
> > >=20
> > > There was no observed performance degradation vs. the previous scheme=
.
> > > Both netperf and hackbench were run in parallel to triggering the
> > > __drain_all_pages(NULL, true) code path around ~100 times per second.
> > > The new scheme performs a bit better (~5%), although the important po=
int
> > > here is there are no performance regressions vs. the previous mechani=
sm.
> > > Per-cpu lists draining happens only in slow paths.
> > >=20
> > > Minchan Kim tested this independently and reported;
> > >=20
> > > 	My workload is not NOHZ CPUs but run apps under heavy memory
> > > 	pressure so they goes to direct reclaim and be stuck on
> > > 	drain_all_pages until work on workqueue run.
> > >=20
> > > 	unit: nanosecond
> > > 	max(dur)        avg(dur)                count(dur)
> > > 	166713013       487511.77786438033      1283
> > >=20
> > > 	From traces, system encountered the drain_all_pages 1283 times and
> > > 	worst case was 166ms and avg was 487us.
> > >=20
> > > 	The other problem was alloc_contig_range in CMA. The PCP draining
> > > 	takes several hundred millisecond sometimes though there is no
> > > 	memory pressure or a few of pages to be migrated out but CPU were
> > > 	fully booked.
> > >=20
> > > 	Your patch perfectly removed those wasted time.
> >=20
> > I'm not getting a sense here of the overall effect upon userspace
> > performance.  As Thomas said last year in
> > https://lkml.kernel.org/r/87v92sgt3n.ffs@tglx
> >=20
> > : The changelogs and the cover letter have a distinct void vs. that whi=
ch
> > : means this is just another example of 'scratch my itch' changes w/o
> > : proper justification.
> >=20
> > Is there more to all of this than itchiness and if so, well, you know
> > the rest ;)
> >=20
>=20
> I think Minchan's example is clear-cut.  The draining operation can take
> an arbitrary amount of time waiting for the workqueue to run on each CPU
> and can cause severe delays under reclaim or CMA and the patch fixes
> it. Maybe most users won't even notice but I bet phone users do if a
> camera app takes too long to open.
>=20
> The first paragraphs was written by Nicolas and I did not want to modify
> it heavily and still put his Signed-off-by on it. Maybe it could have
> been clearer though because "too busy" is vague when the actual intent
> is to avoid interfering with RT tasks. Does this sound better to you?
>=20
> 	Some setups, notably NOHZ_FULL CPUs, may be running realtime or
> 	latency-sensitive applications that cannot tolerate interference
> 	due to per-cpu drain work queued by __drain_all_pages(). Introduce
> 	a new mechanism to remotely drain the per-cpu lists. It is made
> 	possible by remotely locking 'struct per_cpu_pages' new per-cpu
> 	spinlocks. This has two advantages, the time to drain is more
> 	predictable and other unrelated tasks are not interrupted.
>=20
> You raise a very valid point with Thomas' mail and it is a concern that
> the local_lock is no longer strictly local. We still need preemption to
> be disabled between the percpu lookup and the lock acquisition but that
> can be done with get_cpu_var() to make the scope clear.

This isn't going to work in RT :(

get_cpu_var() disables preemption hampering RT spinlock use. There is more =
to
it in Documentation/locking/locktypes.rst.

Regards,

--=20
Nicol=C3=A1s S=C3=A1enz

