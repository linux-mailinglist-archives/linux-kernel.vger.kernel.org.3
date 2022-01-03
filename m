Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02654483156
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiACNRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:17:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiACNRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:17:13 -0500
Date:   Mon, 3 Jan 2022 14:17:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641215832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EfKZrFqVyZ2KnKNACe7A+XVNznQOd3fjQmbJwtLKxd0=;
        b=uZNQSGWGQ7CdagbgT1W+VciJtfugoQI4pdoTivpVCHkiwwcIeDZEAr/SFgOShUWcGoqAw5
        2hPSfl1qYriobrtDkwRDlsk945kdFbDkuPclOM2d3WXnDIvnnd1CDqCBwUa5XG8j0JGQHX
        lJZudGFxFYg35xAHX5p2RUCntM96BhKIAIQ/daQyjOp8U5031mJ3qhU/gGxohbVP9FXAth
        0YbH8SkoQ7iN0WwNylVXoooN6deK1X4PA0ifKccsKnCEgtw95FRd3j6kfw3MjhhAxUwgN0
        XKOMaNOaAtaip9ogVlvtC21AVhPeT9Zx3P8RQtt4ehxGq9Vq4SHNs6MC3NLwXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641215832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EfKZrFqVyZ2KnKNACe7A+XVNznQOd3fjQmbJwtLKxd0=;
        b=aUMbQcUqIADOUEuTNSmkctVy6w2LtORe3TPpdf+gXxXKlUNZAK+R4GEpskZsF2tmjboIob
        DWc7GgoVtPC9qUDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: per-cpu rcuc kthread are created only when
 rcutree.use_softirq=0
Message-ID: <YdL3Vx6pq6YCL1kx@linutronix.de>
References: <20211228160510.2893362-1-qiang1.zhang@intel.com>
 <20220101164426.GA2408833@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220101164426.GA2408833@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-01 08:44:26 [-0800], Paul E. McKenney wrote:
> On Wed, Dec 29, 2021 at 12:05:10AM +0800, Zqiang wrote:
> > In non-RT kernel, if the RCU_BOOST is enabled, the per-cpu rcuc
> > kthread will be created, however under the rcutree.use_softirq=1,
> > the RCU core processing only in softirq context, the rcuc kthread
> > doesn't do anything, so remove RCU_BOOST interference.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Looks sane to me, but adding Sebastian on CC for his thoughts.

Yes, it makes sense. invoke_rcu_core_kthread() is only invoked for
!use_softirq so it makes to create the threads based on this condition.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> 							Thanx, Paul

Sebastian
