Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE03C506469
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348782AbiDSGbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbiDSGbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:31:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B617A23BFC;
        Mon, 18 Apr 2022 23:28:36 -0700 (PDT)
Date:   Tue, 19 Apr 2022 08:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650349714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cv5jZ7dxFa/VdklP7GQ+1SDL4Zimqvxof2UzYY6p/Wc=;
        b=mHK1iN4FuDQg3xyFJqGihvPpO4jB0fgLE4VuB3fzQPzFmlAYZu0xZDXxHSWivi1nCNYYRq
        ESEdOmUPzgRe/ET7oxLrcPEz6w/d9T9SP+clONnapWqMuu+CJVLe6jP+s8cQ5OB/krn1ei
        x4DWGw/ykTygrtRH/VtUgEJIXD/VXdd8CglAVmgkqM52X4zQzYN9SUYVfPgMXUdQX/Gg0B
        YGm3vNE5Czv29w1xYhpayoHSpFuZMG1jg4U7SUhIlBhO4h2jds0hwMGpriwCom9qpOC8uS
        NFtIUVWpXBIiNLryTQCrwxR2ziuk8lMZS2ptQ6uUi7UrXK1Uv/o679gL1X1FOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650349714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cv5jZ7dxFa/VdklP7GQ+1SDL4Zimqvxof2UzYY6p/Wc=;
        b=F9mAbriKsor1oJ3Mm1r4bUufvShI/FarerqXwSeFS6c9pEclkwRermJcB1rnpeVnNUBA2E
        Gi1whjlB7rzyz6Bw==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH] rcu/torture: Change order of warning and trace dump
In-Reply-To: <20220418185042.GA2420391@paulmck-ThinkPad-P17-Gen-1>
Message-ID: <alpine.DEB.2.21.2204190826500.1508@somnus>
References: <20220411151903.28167-1-anna-maria@linutronix.de> <20220411180915.GY4285@paulmck-ThinkPad-P17-Gen-1> <20220418185042.GA2420391@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022, Paul E. McKenney wrote:

> On Mon, Apr 11, 2022 at 11:09:15AM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 11, 2022 at 05:19:03PM +0200, Anna-Maria Behnsen wrote:
> > > Dumping a big ftrace buffer could lead to a RCU stall. So there is the
> > > ftrace buffer and the stall information which needs to be printed. When
> > > there is additionaly a WARN_ON() which describes the reason for the ftrace
> > > buffer dump and the WARN_ON() is executed _after_ ftrace buffer dump, the
> > > information get lost in the middle of the RCU stall information.
> > > 
> > > Therefore print WARN_ON() message before dumping the ftrace buffer in
> > > rcu_torture_writer().
> > > 
> > > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
> > 
> > Hello, Anna-Maria!
> > 
> > Good point, but we get caught out either way.  Either we take the chance
> > of losing the WARN() message as you say, or we take the chance of the
> > activity in the WARN() message overwriting needed information in the
> > trace buffer.
> > 
> > Would it work to shut off tracing, do the WARN(), and only then do the
> > rcu_ftrace_dump()?
> 
> For example, as shown the the updated patch below currently queued on -rcu
> for further review and testing?
> 
> If this is problematic, please let me know!
> 

Hi Paul,

sorry for the late reply - I was busy with other things last week...

This solution is totally fine for me!

Thanks,

	Anna-Maria

