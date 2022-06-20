Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E1552849
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347760AbiFTXZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347700AbiFTXZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:25:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4D13D41;
        Mon, 20 Jun 2022 16:23:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655767384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bW3D6fQYGfq+LIKDb9Z3o0JUaxdED14t0XLDrOY7eGE=;
        b=0MFlDp+fgTDE8bBCTtUT18/CkQO+E7Xwyft0XBiN29o7FLIk/WE2N81Vv5OmlIfdDN0/KE
        AhVpxfDMW/n0tHyDElhcv0sTEaafym4f7eZBW8238jZRPHyf9g3KtWT7LOfRz3ugAVtJdc
        KAuoXrQJofP3eQXu6c3OFotAv3puGRtEI1UPGMCfgdeGjmhP7q8DCfGNsFgj0qwBj9wmmn
        EcjPoxZ4f7mkGdJqmfJ9S6Pr+yhyfujwRf81jSoN+bG/gxWRVyx4O8tWKl0N5EZkhCBX4Y
        ypC/4IlZWkJdLc7ftq5yuBV7ZyqM19ZjhgUurm40WOe5VeIRSEusjE+TWOLqTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655767384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bW3D6fQYGfq+LIKDb9Z3o0JUaxdED14t0XLDrOY7eGE=;
        b=Sxeyk7CewSWdRmO93S3lfQ2EPCEZdxQPQkZ1Yz73CbaU8YQEAeKXP7qFpFEWxEymEakMlV
        CSuJ4OL1MbbmppBw==
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH rcu 11/12] torture: Flush printk() buffers before
 powering off
In-Reply-To: <20220620225817.3843106-11-paulmck@kernel.org>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
 <20220620225817.3843106-11-paulmck@kernel.org>
Date:   Tue, 21 Jun 2022 01:29:04 +0206
Message-ID: <8735fyc42v.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-20, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> The rcutorture test suite produces quite a bit of console output
> at the end of a test.  This means that the new printk() kthreads
> are likely to be in the process of flushing output at the time of
> the torture_shutdown() function's call to kernel_power_off().
>
> This commit therefore invokes pr_flush(1000, true) to flush this
> pending console output before invoking kernel_power_off().
>
> Fixes: 8e274732115f ("printk: extend console_lock for per-console locking")
> Cc: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
