Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED84D3BC5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiCIVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiCIVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:12:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839E3F8A0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:11:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 211DCB82370
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFD5C340E8;
        Wed,  9 Mar 2022 21:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646860263;
        bh=sBuyhvUAnFQeXAka1XmpYSCshXDRmw2bd/h+Q/FytNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tD2jTSRgKKI/vAbwwyYumcQWeDeVSpoBb8OTICEzQtypPKOdVLz3tNHhvWc+G0cKY
         rHFM+/b4MYGHaxPVcP2Y8J7w8FmdEh6KshdRWYz+gr/mdcjWvdrmihY+zNdxcy/d5u
         OZg8L5d78JrStLl0njx4lM2cpmSUKaviTEuVAekFN7HpmOI15da4U/uYM3vJpPyNjY
         QfFVw1zh5AnJz1iVsHHR8jbK/ahBzvGaZJbKvPrZvkYBeb/8Hgdv3RMMwTiFtK4UMn
         2cS2bEKQWjiJo+whT2mLqMzBK8NaF/sbCyVgu8Z8QVUIFsNRrnu1Y3/tjtfY6MA1lC
         qTkzpAYtYMrCQ==
Date:   Wed, 9 Mar 2022 22:11:00 +0100
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
Subject: Re: [PATCH 04/19] context_tracking: Rename
 context_tracking_cpu_set() to context_tracking_cpu_track_user()
Message-ID: <20220309211100.GB68899@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-5-frederic@kernel.org>
 <20220305140321.GW11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305140321.GW11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 03:03:21PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 02, 2022 at 04:47:55PM +0100, Frederic Weisbecker wrote:
> > context_tracking_cpu_set() is called in order to tell a CPU to track
> > user/kernel transitions. Since context tracking is going to expand in
> > to also track transitions from/to idle/IRQ/NMIs, the scope
> > of this function name becomes too broad and needs to be made more
> > specific.
> 
> The previous patches did: s/context_tracking_/ct_/ on these names, and
> this one makes it longer still?

Right, in fact I added the renames afterward and forgot to update that patch.
Will do.

Thanks.
