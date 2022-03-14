Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D694D7FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbiCNKUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiCNKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:20:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7552243480
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=c30h96xDQEJXmMxMwPWq9YMjV0yJxJ26L1hJt0krjT0=; b=BmHZE3Fv+9w7tfWnrAYMoY7b6c
        YEnF1RVgS/i+K8PEuWF2JNL8/UoTvABubixh/D/8PFqNimei6toyiFGemgxSO7h4eikEV7LxATbrY
        zm7wn7BYlIPcbQBnDbVEL/SnyqRAsjjSCs7xaIMqAcQC7zBghJ/xEfMI3lVbjUE3pYOvEQFL5r823
        /igOr6Ds89gbTF1Omt5lMeM2oR+MBJnVEVYu3XPXXcKxuxj+6w8mNWdxO5irw1r02MgW606leW0DX
        WY2sLGu1AOp2EtgSVd6yLMvJPY9GGEsMOErGbUI2+XYWkZrxx6J3LC4VD2SwcHDGOV31rnD5BGNsl
        teVAP8Fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nThnI-000ns7-1Q; Mon, 14 Mar 2022 10:19:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 567F73001FD;
        Mon, 14 Mar 2022 11:19:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16892344C779B; Mon, 14 Mar 2022 11:19:13 +0100 (CET)
Date:   Mon, 14 Mar 2022 11:19:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Message-ID: <Yi8WoC40tb8ulrmd@hirez.programming.kicks-ass.net>
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <Yisxg3izMrGVahOQ@hirez.programming.kicks-ass.net>
 <SL2PR06MB3082047700A8440BD0DE80DEBD0F9@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB3082047700A8440BD0DE80DEBD0F9@SL2PR06MB3082.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 02:37:48AM +0000, 王擎 wrote:

> > If you want to represent L2, use the new fangled cluster level or
> > something, that's what it's there for.
> > 
> > That is, you can represent the above like:
> > 
> >        DIE:    0-7
> >        MC:     0-3,            4-7
> >         CLS:    0-1,1-2,        4-5,6-7
> > 
> > But if there is cache at MC, LLC is what it is.
> 
> There is no CLS support for LTS now, any plans to backport?

-ENOTMYPROBLEM
