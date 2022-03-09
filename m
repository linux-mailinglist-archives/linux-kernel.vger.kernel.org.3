Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563704D3BDF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbiCIVOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiCIVN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:13:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921001705F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:12:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47879B82234
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66022C340F5;
        Wed,  9 Mar 2022 21:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646860374;
        bh=Aq2cE5bVYMPYuQs4z0VI/ELJ+mN0tJzboPpC/8+mX+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPwnwg6NN61z8/UG6/RtCRhDOPLLqK4GqqeJxYaLQ3Y9SS3jE3AB7kf0uGS61QGkc
         GD4QPwmVTYxJn83VaCgYjqZN1PDf0uLK8XRoZ0xBc2i948Bzk83gXjm7UrEoRW+Kk1
         pFtah/Ve2eGgNx3cYp4m8stHKAx5Ml083B+waIhy/MrQ+lgHlBkrl07OcSrJD1qgDJ
         N3NtjvIYLc4K8YH1VRjCPOqw+DMj24rTod8r1Op+hxpMIi/8RVGSXavvBkHYHzx63B
         wpw2xF7H/kaCBx6c6bbKXT7Q6gkiQih+vCU6DmBKleJXZj5hYeusI9IMqZGYsNUX3+
         Su1oTKrBfTNMw==
Date:   Wed, 9 Mar 2022 22:12:51 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
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
Subject: Re: [PATCH 06/19] context_tracking: Take idle eqs entrypoints over
 RCU
Message-ID: <20220309211251.GC68899@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-7-frederic@kernel.org>
 <20220305140526.GX11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305140526.GX11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 03:05:26PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 02, 2022 at 04:47:57PM +0100, Frederic Weisbecker wrote:
> > The RCU dynticks counter is going to be merged into the context tracking
> > subsystem. Start with moving the idle extended quiescent states
> > entrypoints to RCU. For now those are dumb redirection to existing RCU
> > calls.
> 
> s/to/from/ right? You're taking them away from RCU and moving them to
> ct.

Right!
