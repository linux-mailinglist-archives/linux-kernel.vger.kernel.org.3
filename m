Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E94EDC26
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiCaOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiCaOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 878A81E3FA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648738429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I22K+0AWk04cNGfWA9Hth1qEi92pTMOHvjJAicv6x14=;
        b=itsNFNcxwZDZOlFr0r0kwzI9GVwzlZzDsfRV+SaDzVfATCoDo4MtXMVIotDF8aFRQ6r4RJ
        oi6nwI2/5kiPtwQkh4j3QN3Ks8V9pBdpy+Ho/EFhfie5IspogObxOnBbE2Uh/1XkPKJsOA
        GzJTpi3NgtiRg2svKLcvghUmx9NI2cQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-RmpnAkKPP1qo9QPp9XDWfg-1; Thu, 31 Mar 2022 10:53:46 -0400
X-MC-Unique: RmpnAkKPP1qo9QPp9XDWfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B66543C14854;
        Thu, 31 Mar 2022 14:53:45 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84D871400B18;
        Thu, 31 Mar 2022 14:53:45 +0000 (UTC)
Date:   Thu, 31 Mar 2022 10:53:44 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arch/arm64: Fix topology initialization for core
 scheduling
Message-ID: <20220331145343.GF17613@pauld.bos.csb>
References: <20220330155611.30216-1-pauld@redhat.com>
 <66f29bee-e26c-b40e-c3af-79d5297565d8@arm.com>
 <20220331132103.GB17613@pauld.bos.csb>
 <e93a7d66-7e43-d2c7-ad85-fb24d50effc5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93a7d66-7e43-d2c7-ad85-fb24d50effc5@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:37:50PM +0200 Dietmar Eggemann wrote:
> On 31/03/2022 15:21, Phil Auld wrote:
> > On Thu, Mar 31, 2022 at 11:04:31AM +0200 Dietmar Eggemann wrote:
> >> On 30/03/2022 17:56, Phil Auld wrote:
> 
> [...]
> 
> >> Ah, the reason is that smt_mask is not correctly setup, so we bail on
> >> `cpumask_weight(smt_mask) == 1` for !leaders in:
> >>
> >> notify_cpu_starting()
> >>   cpuhp_invoke_callback_range()
> >>     sched_cpu_starting()
> >>       sched_core_cpu_starting()
> >>
> >> which leads to rq->core not being correctly set for !leader-rq's.
> >>
> > 
> > Exactly, sorry I was not clearer.  smt_mask must be setup correctly 
> > by the time sched_core_cpu_starting() is called. (Maybe I should crib
> > some of the above lines into the commit message?)
> 
> Yeah, maybe, it wouldn't hurt I guess. IMHO mentioning stress-ng's prctl
> needs PR_SCHED_CORE support could also be handy since today's stress-ng
> packages don't seem to have this yet.
> 

My scripts clone it so I did not realize that was not in prepackaged versions
yet.  But that said, that's really just a way to tickle the problem. Anyone
using core scheduling on such a system will hit this (at least the WARN part,
the actual crash was harder to create w/o all the threads and tasks stress-ng
uses). 

I can send a v3 with a further commit message update.


Cheers,
Phil

-- 

