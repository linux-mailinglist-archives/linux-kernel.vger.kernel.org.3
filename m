Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21C4E924B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbiC1KHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiC1KHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:07:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364FB53B7D;
        Mon, 28 Mar 2022 03:06:01 -0700 (PDT)
Date:   Mon, 28 Mar 2022 12:05:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648461959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRISlRawsY/q0M9hXgY2Ak8V5Zf/qjZAd7pD8o0Pf34=;
        b=imraXrXwOIBRUqeX6f4kk2VW1BI7XdqTLWCh6CLQW6V6CMVM+9hBlrJ6DAYIkH71rWav0G
        IXRIU6OOw4S+LiTdD1RX1Wpy4EuK71bfrWNFiio9somxxHA2t3rJLH/WunI0ABbCvGlJwL
        d5umqSHYiqiX2cbry8XKb3qdw5DeaO1kyuEEC1z05ZKakIqZCrBAvRPWvRkRrb/mlB9LX6
        bSl1EbwKkPg4zJ2PPqN8xZYR4UVCyVXElopdq58lH1Lx3O1xUoByh7rXo3ZtCR5VG2RUHO
        J2YvPKpR0HWLDF2XirO671N350oKFrdxWVc4KEi+EVwDYo5ZYoXpUxH348JToA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648461959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRISlRawsY/q0M9hXgY2Ak8V5Zf/qjZAd7pD8o0Pf34=;
        b=IQl8AKJE/iMGjFgEy+MFcySwLY3ow/EFjnR3gfWJlXKvwT6lD82wvA+TcjjcQbcqG+nJs0
        0ePcw/0eObqTTzBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?QW5kcsOp?= Pribil <a.pribil@beck-ipc.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Esben Haabendal <esben@geanix.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] RT scheduling policies for workqueues
Message-ID: <YkGIhYKJG+w4L7ge@linutronix.de>
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-23 15:55:58 [+0100], Rasmus Villemoes wrote:
> This RFC is motivated by an old problem in the tty layer. Ever since
> commit a9c3f68f3cd8 (tty: Fix low_latency BUG), use of UART for
> real-time applications has been problematic. Even if both the
> application itself and the irq thread are set to SCHED_FIFO, the fact
> that the flush_to_ldisc work is scheduled on the generic and global
> system_unbound_wq (with all workers running at normal scheduling
> priority) means that UART RX can suffer unbounded latency.

Having a kthread per "low-latency" tty instance is something I would
prefer. The kwork corner is an anonymous worker instance and probably
does more harm than good. Especially if it is a knob for everyone which
is used for the wrong reasons and manages to be harmful in the end.
With a special kthread for a particular tty, the thread can be assigned
with the desired priority within the system and ttyS1 can be
distinguished from ttyS0 (and so on). This turned out to be useful in a
few setups over the years.

Sebastian
