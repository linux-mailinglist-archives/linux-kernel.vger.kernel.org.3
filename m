Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A958F5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiHKCv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiHKCv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:51:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2DA883CC;
        Wed, 10 Aug 2022 19:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8FD3B81DDA;
        Thu, 11 Aug 2022 02:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9AFC433D6;
        Thu, 11 Aug 2022 02:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660186312;
        bh=7hnvScR6aK8rXCE8zN1Thl2XIsFX60XDRgsGKqvYKBc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m6xsYnjDhUIGm70AEo+Qry7UocFGihU4hjiboETu3Z4bSqHypRBpAYPLoHwy2Ov5f
         /hV9ltgRRYKaGXO3/CMsqEqsfJFvAOZxOBk125LmUi4U7fO6WXLuBzjVDeCnP2QKnD
         nM+ghVdKzdgzRyjQ/vB0YbQIvKubWlSbFVoyrof8RYn9D56oiVNY3zCEeFHOxUbn1S
         jkijKejDPWQ3IcWICbp8lSwZ2GPVK8oDVWmrEmrKda6wKBQEUr8RvO7qIWnzTCpsVU
         F32gbPvGqte6d73mjofii/Q1iaHl8FVpjyOvGD0yfu584l62DxNtITov/98D1kc+Wg
         QYp9iZXMpCjOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2859F5C038F; Wed, 10 Aug 2022 19:51:52 -0700 (PDT)
Date:   Wed, 10 Aug 2022 19:51:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3 resend 0/6] Implement call_rcu_lazy() and
 miscellaneous fixes
Message-ID: <20220811025152.GW2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <308db02b-b56d-2df1-ee33-7f66e6a85f63@joelfernandes.org>
 <87663566-ed67-fee8-4598-13591f2f072b@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87663566-ed67-fee8-4598-13591f2f072b@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 10:31:56PM -0400, Joel Fernandes wrote:
> 
> 
> On 8/10/2022 10:23 PM, Joel Fernandes wrote:
> > 
> > 
> > On 8/8/2022 11:45 PM, Joel Fernandes (Google) wrote:
> >> Just a refresh of v3 with one additional debug patch. v3's cover letter is here:
> >>  https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/
> >>
> >> I just started working on this again while I have some time during paternity
> >> leave ;-) So I thought I'll just send it out again. No other changes other
> >> than that 1 debug patch I added on the top.
> >>
> >> Next I am going to go refine the power results as mentioned in Paul's comments
> >> on the last cover letter.
> > 
> > Side note: Here is another big selling point for call_rcu_lazy().
> > Instead of _lazy(), if you just increased jiffies_till_first_fqs, and
> > slowed *all* call_rcu() down to achieve the same effect, that would
> > affect percpu refcounters switching to atomic-mode, for example.
> > 
> > They switch to atomic mode by calling __percpu_ref_switch_mode() which
> > is called by percpu_ref_switch_to_atomic_sync().>
> > This will slow this call down for the full lazy duration which will slow
> > down suspend in blk_pre_runtime_suspend().
> 
> Correction while I am going on the record (got to be careful these
> days). It *might* slow down RCU for the full lazy duration, unless of
> course a fly-by rescue call_rcu() comes in.

Just unload a module, which if I remember correctly invokes rcu_barrier().
Lots of rescue callbacks.  ;-)

							Thanx, Paul
