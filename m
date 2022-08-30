Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3AB5A6260
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiH3LrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiH3LrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:47:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C989F77B;
        Tue, 30 Aug 2022 04:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0DD0615BA;
        Tue, 30 Aug 2022 11:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F76EC433D6;
        Tue, 30 Aug 2022 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661860033;
        bh=g5DHhb3WYH2VRGeBT7qIxCLQYRhsp9ZL2ahxFimGZlU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=et29pG53iNLdhy5k/I0YbxDfjrWbqAyBpobl6C+YnzAnuNFMM1f3o/qTbWqgCPkMp
         m9ATaMeA2jhCPHVZPSmXUpcakJKogiD1JLX9ifucD+oc/P1qOnJrEZwX4S9/7g45n0
         ZZxCxi1EXzPJdlUqBl6SHbogqeHDNvr5hKk+6KTVDBsUCo8GjWAXh8zjzu7uumLmxs
         vDA+1+58r7Z1X+xvORrgy/oXyWL4KxSUce1RfrXKZB1ICrxUbWUQBeEoSRfd6jMOgD
         J9udLAZJVIp5N0plVTCOSN8OhqXDcIU4vdYpY6qS2+aCxeD4Insjtt1TNANOE+fICg
         fWBxXgjdBxk+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CBEEF5C0531; Tue, 30 Aug 2022 04:47:12 -0700 (PDT)
Date:   Tue, 30 Aug 2022 04:47:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220830114712.GT6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <20220829203131.GP6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105002.GB70936@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830105002.GB70936@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:50:02PM +0200, Frederic Weisbecker wrote:
> On Mon, Aug 29, 2022 at 01:31:31PM -0700, Paul E. McKenney wrote:

[ . . . ]

> > Another test would be to look at which callbacks are being invoked
> > on each grace period.  We have to have a substantial number of grace
> > periods having all lazy callbacks before call_rcu_lazy() has any chance
> > of helping.  This would need to happen on a server platform because
> > Android and ChromeOS data might or might not carry over.
> 
> Also that yes.

What would be the best way to collect that data?

Please keep in mind that unless/until we have some clear empirical
indication that call_rcu_lazy() really would help the world of systems
running without rcu_nocbs, moving the call_rcu_lazy() implementation
from the bypass list to cblist does nothing but increase risk to system
that get no benef from call_rcu_lazy().

							Thanx, Paul
