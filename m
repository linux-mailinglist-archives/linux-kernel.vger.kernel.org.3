Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C376A4FC3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiDKSLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349085AbiDKSLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:11:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F05B6C;
        Mon, 11 Apr 2022 11:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBA12B817F4;
        Mon, 11 Apr 2022 18:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80238C385A4;
        Mon, 11 Apr 2022 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649700555;
        bh=w6PoLjw8G+naEx79XURY52W6ATgEyDErTxZAGt5VmOw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vu9plXhPWPeAxFemuyozy1NFs+/TZ4ahvK/3iMhbkl3TQubVGermfxgjn5r3UyuQ+
         bGaIP5MuqkX85+7b0X/E2OP7pDKi6ApTCLQFGhqzpXqunfkGu2mlh2ywbGJZaeYaBn
         YAXqIs5Pt+iu1x5yojduy92aBiPWkFxnOOY7hB8SOC0CZhEDDdC71Orkokj6zhWWaI
         9vcycgEX+l/xZKzsoq+2yO6m6xXG+CPH99++CDyvy40T6xj0U3Q+QjuzU6W1AhqSiK
         +Ks2PBn4r03kU4qZVnpvnwy9V9Q1bXfn1DrKJsQgErP47dJmUUNon7TKszpmw8TsRm
         eJGX09HANXq9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1BF625C03AE; Mon, 11 Apr 2022 11:09:15 -0700 (PDT)
Date:   Mon, 11 Apr 2022 11:09:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH] rcu/torture: Change order of warning and trace dump
Message-ID: <20220411180915.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220411151903.28167-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411151903.28167-1-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 05:19:03PM +0200, Anna-Maria Behnsen wrote:
> Dumping a big ftrace buffer could lead to a RCU stall. So there is the
> ftrace buffer and the stall information which needs to be printed. When
> there is additionaly a WARN_ON() which describes the reason for the ftrace
> buffer dump and the WARN_ON() is executed _after_ ftrace buffer dump, the
> information get lost in the middle of the RCU stall information.
> 
> Therefore print WARN_ON() message before dumping the ftrace buffer in
> rcu_torture_writer().
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>

Hello, Anna-Maria!

Good point, but we get caught out either way.  Either we take the chance
of losing the WARN() message as you say, or we take the chance of the
activity in the WARN() message overwriting needed information in the
trace buffer.

Would it work to shut off tracing, do the WARN(), and only then do the
rcu_ftrace_dump()?

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 55d049c39608..cbbe37d7701e 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1287,8 +1287,8 @@ rcu_torture_writer(void *arg)
>  				if (list_empty(&rcu_tortures[i].rtort_free) &&
>  				    rcu_access_pointer(rcu_torture_current) !=
>  				    &rcu_tortures[i]) {
> -					rcu_ftrace_dump(DUMP_ALL);
>  					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
> +					rcu_ftrace_dump(DUMP_ALL);
>  				}
>  		if (stutter_waited)
>  			sched_set_normal(current, oldnice);
> -- 
> 2.20.1
> 
