Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6705B2427
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiIHREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIHRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:03:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1343EA63F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S72PXY7em62V5ORzoBo68HbWhNjf9hfLKLeX6cFiRBw=; b=X1xuCy4RuMs5gUYI1iEwbPB2FI
        xQqAjy+a28O2Ik8P/N6sTMrFVGAbbkg2PANdVLnLBKLnS2eFZhXrfBIb5VX0s4IquBcbSZAk9RXhE
        TDZTcNpKLPdZfNTBRFCegJ7xrStOXFEos7XicKF1W41myg1Eo7UwO0atKEtjw2Ds/Y5zIIRHrejXY
        84RB/2tPV0hJAh+y/7UGVOOEjVnwJHrv10tbtrF57tLs1hMCcg3uLEi9ZbDB5BjOooXTKtnNfCtlz
        893sVtbNOwKEO9tKdlKG8LGT1WZIiYnbk8q+ybi97wLGzCbbOAOjyA5riVeTom/lO66RwMSQxkghO
        deBbyHgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWKwL-00CW3s-4L; Thu, 08 Sep 2022 17:03:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0708B3006A4;
        Thu,  8 Sep 2022 19:03:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECFD42B9A6AC0; Thu,  8 Sep 2022 19:03:41 +0200 (CEST)
Date:   Thu, 8 Sep 2022 19:03:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH] locking/rwsem: Disable preemption while trying for rwsem
 lock
Message-ID: <YxogbSDYhsmp3CNC@hirez.programming.kicks-ass.net>
References: <1662028090-26495-1-git-send-email-quic_mojha@quicinc.com>
 <Yxn87KDv1h4mwbIL@hirez.programming.kicks-ass.net>
 <0aafd6bd-6c4c-bb77-7b33-a6d04ee6e5b3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aafd6bd-6c4c-bb77-7b33-a6d04ee6e5b3@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:18:29PM +0530, Mukesh Ojha wrote:
> Hi Peter,
> 
> Thanks for your time in reviewing this patch.
> 
> On 9/8/2022 8:02 PM, Peter Zijlstra wrote:
> > On Thu, Sep 01, 2022 at 03:58:10PM +0530, Mukesh Ojha wrote:
> > > From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> > > 
> > > Make the region inside the rwsem_write_trylock non preemptible.
> > > 
> > > We observe RT task is hogging CPU when trying to acquire rwsem lock
> > > which was acquired by a kworker task but before the rwsem owner was set.
> > > 
> > > Here is the scenario:
> > > 1. CFS task (affined to a particular CPU) takes rwsem lock.
> > > 
> > > 2. CFS task gets preempted by a RT task before setting owner.
> > > 
> > > 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> > > RT throttling happens for the lock as the lock was taken by CFS task.
> > > 
> > > This patch attempts to fix the above issue by disabling preemption
> > > until owner is set for the lock. while at it also fix this issue
> > > at the place where owner being set/cleared.
> > > 
> > > Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > 
> > This is not a valid SoB chain.
> 
> Since this patch of adding preempt disable() at rwsem_write_trylock() is
> originated from Gokul.
> 
> Would be adding him in
> Original-patch-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> 
> Convert myself to the author/SoB.
> 

Oh, my bad, I missed From is actually Gokul. So yeah, all good, ignore
that.
