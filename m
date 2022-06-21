Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78268552CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346931AbiFUIJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345752AbiFUIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:09:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E313101DC;
        Tue, 21 Jun 2022 01:09:32 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655798969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XgTroZKzWSCpwvo3CTfHlk4Jov73sxDBHELQo+G81E=;
        b=ARSSP9NOcT0fnobyo7yiQrKF7AEpPpToZaqrbayXWZl2UrFrXG5ukS3xpExDoqx6HdiZou
        qRfhHrxmegJDdQ2uoP5QZBDCUab7CJYybKhuH0wVjkMg4iUAg5bJeKtfJqzqAIFSfqTA4r
        zXiq8fJViR0BrSeJuMjZcCPoESVg31P+lBzkoQZn/adralXe4b+uG9m03k0OjdS7eEk12x
        I9+A+q7GoGinhukVOR6+usnzPubVUZnlDIPqhLtjHkFlJLYuJwpomK52dSBD79xpyD6fn1
        /g8r8YhnYVynOlXjx/pC1thQoQG55xuYTYapgfOhvZN+ajOQBc/CEslDzmLkJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655798969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XgTroZKzWSCpwvo3CTfHlk4Jov73sxDBHELQo+G81E=;
        b=36221lbl9TxnZpkIYLvKp59sJxmYfvzIsQX+6cjShkueykLnKhpHgi/luOXl5YcwKj1iSh
        hVHlFV60CgvhSUCQ==
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 11/12] torture: Flush printk() buffers before
 powering off
In-Reply-To: <20220620232838.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
 <20220620225817.3843106-11-paulmck@kernel.org>
 <8735fyc42v.fsf@jogness.linutronix.de>
 <20220620232838.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 21 Jun 2022 10:15:29 +0206
Message-ID: <87v8suphdy.fsf@jogness.linutronix.de>
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
> But given Petr's and your recent changes that are now in mainline, is
> this still really needed?  (Tests now pass without it, though tests can
> of course be misleading.)

If all you are interested is if your rcutorture testing was successful,
then I would keep this change. Then, no matter what the kernel does
afterwards, you have your test results.

However, the kernel should correctly shutdown and it should flush the
kernel buffers on shutdown or crash. (It is a kernel bug otherwise.) So
if you also want to implicitly test this (non-rcutorture) functionality,
then you should not use this patch.

John Ogness
