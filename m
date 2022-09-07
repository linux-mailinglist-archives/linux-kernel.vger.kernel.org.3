Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82455AFD6F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIGHY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIGHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:24:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B23A6AF0;
        Wed,  7 Sep 2022 00:23:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bz13so15496335wrb.2;
        Wed, 07 Sep 2022 00:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=pvlii7/LubMD6DsgRlKRU70IFMr/6G9pQDznjmqp8qU=;
        b=i6sUTE65cDDUQnCvos3MLz/CKYFFYIJ2bzlMxRaQGdYzSvfpdAAqgJxP7TXwV6MKzE
         l6dyi03dB8s8leGT4pRuOUJi+UJXETsIrQiuifoI7nhuRowRwjYDXXDuxzUT0YBVk+3B
         x0Xid5GM2gYyqPqvpWpqcO2OKnKxMxgaWGJAOGzwmnf5d71yN+HzF83hNMoFT5cahCaH
         DKgxb8R7g54sJE5k8ZawfzH8cWHKe3y2bdSY650Z6E3JSoIsoLAsUGJSJ/HwK8XMaOqP
         B2+XHgPeQCz72meq4PqwIVENV8QgNU84cWatm/lBEAxsBKEM4A2nAs7Ed/5bxdeM43il
         J+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pvlii7/LubMD6DsgRlKRU70IFMr/6G9pQDznjmqp8qU=;
        b=sFDx/BSoEWDR1wi7zFg678P0LloiQj6wb0pmcuTtt+81fZr0DHP5+/O9SL6NCiMaTU
         7e7y+ewSXBn7pr0bemxJORS/+UVxcPFnhTC/XeEkEamOS7oYt8hGXJ+q6Jvk2t6jf0jI
         Ur0gBan0XdoRdG8afhNVO6lffFfSMnr4Iip09NHh6CVDpcoBnOwDb+O03Tn5eMmKlZ5u
         eKMk9EBU4tEbRfqdbu3E7wyr4YjFtxxnp3xJrAgfy13UAc+GQreM1YZfG8TFPZaNvvBo
         QtROcjB7KL6MRfL45yLefDrqaoMmmCg7nwzfAxihDKXmajLuHWdcJa/FZS/7f6SfU5Aa
         /MzQ==
X-Gm-Message-State: ACgBeo0Ox4Jikpzt5O/1yoNci255TngIoIbDUZGxa8U8If1gHaERdhEB
        9NlRW0LfhCnG8kNoiP2Vm1k=
X-Google-Smtp-Source: AA6agR7dJ/PtKjWL/cUfEp6bVth8BTBwrjNN59bOAMx/E2kfLKWMRyMLS88/ymoevBSe5vtESO0piQ==
X-Received: by 2002:a5d:4e88:0:b0:228:c8ed:2af8 with SMTP id e8-20020a5d4e88000000b00228c8ed2af8mr1173480wru.412.1662535428209;
        Wed, 07 Sep 2022 00:23:48 -0700 (PDT)
Received: from gmail.com (1F2EF41B.nat.pool.telekom.hu. [31.46.244.27])
        by smtp.gmail.com with ESMTPSA id f6-20020adff586000000b00228c375d81bsm8821114wro.2.2022.09.07.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:23:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 7 Sep 2022 09:23:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] sched: Change wait_task_inactive()s match_state
Message-ID: <YxhHAPlwNwv3l6gY@gmail.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.856734578@infradead.org>
 <YxSBlPb/oZ6x0jfw@gmail.com>
 <Yxcm6oOTbmCbsHvj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxcm6oOTbmCbsHvj@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Sep 04, 2022 at 12:44:36PM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Make wait_task_inactive()'s @match_state work like ttwu()'s @state.
> > > 
> > > That is, instead of an equal comparison, use it as a mask. This allows
> > > matching multiple block conditions.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/sched/core.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3295,7 +3295,7 @@ unsigned long wait_task_inactive(struct
> > >  		 * is actually now running somewhere else!
> > >  		 */
> > >  		while (task_running(rq, p)) {
> > > -			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> > > +			if (match_state && !(READ_ONCE(p->__state) & match_state))
> > >  				return 0;
> > 
> > We lose the unlikely annotation there - but I guess it probably never 
> > really mattered anyway?
> 
> So any wait_task_inactive() caller does want that case to be true, but
> the whole match_state precondition mostly wrecks things anyway. If
> anything it should've been:
> 
> 		if (likely(match_state && !(READ_ONCE(p->__state) & match_state)))
> 			return 0;
> 
> but I can't find it in me to care too much here.

Yeah, I agree that this is probably the most likely branch - and default 
compiler code generation behavior should be pretty close to that to begin 
with.

Ie. ack on dropping the unlikely() annotation. :-)

Might make sense to add a sentence to the changelog though, in case anyone 
(like me) is wondering about whether the dropped annotation was intended.

Thanks,

	Ingo
