Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C3C52D6F0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbiESPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbiESPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808653B03C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122CC61A8E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEC3C385AA;
        Thu, 19 May 2022 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972770;
        bh=sN6737t3oQ8GbyzK/fJ5Nidy/v02C1iyPu7km5RPR4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZQbBr4kCg5yrgMqgMEBWLoTPl1uhhyoq45EBXroIjF0YNO9Zlj/GhX+P6X9mKn9p
         g4wxIbf3JcgKTNImBfG3AwZ3rcL50h2MFv6QUZMvxbov5n/AuqF9LubjPOSiEPDmaP
         LGFZMfVneFAUW87vS++tl4/+UX95jJVEJxq8DchOpXl6y+lDF7a26xZH69HOi2FX/z
         F7/JacK193He71IxKr0qJX4ppQCgMTbjODgSP+7h1Nfp04Egb4O/e286L3/2obo5PO
         DYLOPebEiKbqyzzpqGFHTQTw7phdyQNudsuIa0rBUUquPUsHf9EBZniUlTGIQS/mN5
         uuSiZAj3y3ajg==
Date:   Thu, 19 May 2022 17:06:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     nicolas saenz julienne <nsaenz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 21/21] rcu/context_tracking: Merge dynticks counter and
 context tracking states
Message-ID: <20220519150607.GC618878@lothringen>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-22-frederic@kernel.org>
 <adf7fca9aab320abc7a0c364b3e99709e0d99548.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf7fca9aab320abc7a0c364b3e99709e0d99548.camel@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 05:31:32PM +0200, nicolas saenz julienne wrote:
> On Tue, 2022-05-03 at 12:00 +0200, Frederic Weisbecker wrote:
> 
> [...]
> 
> > diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> > index edd9f8f5b753..0841435620cf 100644
> > --- a/include/linux/context_tracking_state.h
> > +++ b/include/linux/context_tracking_state.h
> > @@ -10,12 +10,20 @@
> >  #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
> >  
> >  enum ctx_state {
> > -	CONTEXT_DISABLED = -1,	/* returned by ct_state() if unknown */
> > -	CONTEXT_KERNEL = 0,
> > -	CONTEXT_USER,
> > -	CONTEXT_GUEST,
> > +	CONTEXT_DISABLED	= -1,	/* returned by ct_state() if unknown */
> > +	CONTEXT_KERNEL		= 0,
> > +	CONTEXT_IDLE		= 1,
> > +	CONTEXT_USER		= 2,
> > +	CONTEXT_GUEST		= 3,
> > +	CONTEXT_MAX		= 4,
> >  };
> >  
> > +/* Even value for idle, else odd. */
> > +#define RCU_DYNTICKS_IDX CONTEXT_MAX
> > +
> > +#define CT_STATE_MASK (CONTEXT_MAX - 1)
> > +#define CT_DYNTICKS_MASK (~CT_STATE_MASK)
> 
> Nit: These macros only work as long as we don't introduce new contexts. It's
> maybe worth a comment.

Ah good point, forgot that.

Thanks!
