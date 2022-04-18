Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523A4505E22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347515AbiDRSx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiDRSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:53:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E62915822;
        Mon, 18 Apr 2022 11:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 055BCB80EC4;
        Mon, 18 Apr 2022 18:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CACC385A7;
        Mon, 18 Apr 2022 18:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650307842;
        bh=ZUHtGIbbacXJsaEGrlloH94rXXIROUImW5cXopGA94E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pVY/ca2QGYXAxfaiNXrOjXrF/Cv+oANtUPQZ9ftGbux1DdwCCzASQDsVqFQWgihQ+
         Gg3kkjD8Sw4JoM1y5e+J4AtSxYGoBoMv3uWmo+dlx7m8O3znrWGTfMem0UaOwhFSxf
         C5pscSLCHlBUPGI76XgyJqn/hHHKn7QnpBZq7iKDPiT5S1ZtTok04581G2Gl0qV1ei
         cxkdxLeNcGpB9D80JTlVMjsIFSyYXaax8QY6KubCb4a4GOJluOCdyJJXzyM73yc2Yf
         97v+ZjkEduRsypmZQv2DF7U32Yb4j4Snsgn1gQFsoibpDu7Sl9DMzihfq1D2hOSR93
         nS95oNm2+AFJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3CA755C0848; Mon, 18 Apr 2022 11:50:42 -0700 (PDT)
Date:   Mon, 18 Apr 2022 11:50:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH] rcu/torture: Change order of warning and trace dump
Message-ID: <20220418185042.GA2420391@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220411151903.28167-1-anna-maria@linutronix.de>
 <20220411180915.GY4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411180915.GY4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:09:15AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 11, 2022 at 05:19:03PM +0200, Anna-Maria Behnsen wrote:
> > Dumping a big ftrace buffer could lead to a RCU stall. So there is the
> > ftrace buffer and the stall information which needs to be printed. When
> > there is additionaly a WARN_ON() which describes the reason for the ftrace
> > buffer dump and the WARN_ON() is executed _after_ ftrace buffer dump, the
> > information get lost in the middle of the RCU stall information.
> > 
> > Therefore print WARN_ON() message before dumping the ftrace buffer in
> > rcu_torture_writer().
> > 
> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
> 
> Hello, Anna-Maria!
> 
> Good point, but we get caught out either way.  Either we take the chance
> of losing the WARN() message as you say, or we take the chance of the
> activity in the WARN() message overwriting needed information in the
> trace buffer.
> 
> Would it work to shut off tracing, do the WARN(), and only then do the
> rcu_ftrace_dump()?

For example, as shown the the updated patch below currently queued on -rcu
for further review and testing?

If this is problematic, please let me know!

							Thanx, Paul

------------------------------------------------------------------------

commit cdbc93534da1bba3f498783473361b2f26dc65d6
Author: Anna-Maria Behnsen <anna-maria@linutronix.de>
Date:   Mon Apr 11 17:19:03 2022 +0200

    rcu/torture: Change order of warning and trace dump
    
    Dumping a big ftrace buffer could lead to a RCU stall. So there is the
    ftrace buffer and the stall information which needs to be printed. When
    there is additionaly a WARN_ON() which describes the reason for the ftrace
    buffer dump and the WARN_ON() is executed _after_ ftrace buffer dump, the
    information get lost in the middle of the RCU stall information.
    
    Therefore print WARN_ON() message before dumping the ftrace buffer in
    rcu_torture_writer().
    
    [ paulmck: Add tracing_off() to avoid cruft from WARN(). ]
    
    Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
    Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2b40a8f6d2a0..0885a66f9d76 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1369,8 +1369,9 @@ rcu_torture_writer(void *arg)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
 				    rcu_access_pointer(rcu_torture_current) !=
 				    &rcu_tortures[i]) {
-					rcu_ftrace_dump(DUMP_ALL);
+					tracing_off();
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
+					rcu_ftrace_dump(DUMP_ALL);
 				}
 		if (stutter_waited)
 			sched_set_normal(current, oldnice);
