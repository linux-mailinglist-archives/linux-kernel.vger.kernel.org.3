Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1795754F9ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383067AbiFQPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiFQPNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:13:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742A4220F0;
        Fri, 17 Jun 2022 08:13:05 -0700 (PDT)
Date:   Fri, 17 Jun 2022 17:13:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655478783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wiu9PNjZtU75kIkIdHT6F9YTnsKXty0kUhXe7MZj/OY=;
        b=VWsUFRPGgm0fCvp7HHY7pbSwdK24YjbQEDDPhkEAbehRCbREWJMzfhCBrLLK5m6E5KAcg3
        s1imxbWmxgANfm+OdObHWUwrjG41h+XpIBjR/glouGvos/nuuA1c5mS8J+ORbVbD4vzgIe
        Y+K8U3lc5Zjv+RK0YaQAzd5tXQpZX9M3+RR2Bg9prOimxiSXzliW+S7eVR/G/Sq4B9WC6u
        6bbULRMq7dEuONqAlzPEzvy3OP2RboABzozdc/0jLYBgCEmMxAQQKdlEW6U6bXrGTDSFtm
        bhAr0zL+bTgMOtWoqk+BW/cGduuC/hexfOwfJs85yM66l4IK2tQ+sBScJs1mzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655478783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wiu9PNjZtU75kIkIdHT6F9YTnsKXty0kUhXe7MZj/OY=;
        b=5AJqEuLIJ5X0bNh+w9zDdl7BaWRhqliITi6SMcLGKXdiIjQ3+jnqt4RIpdbrpACZf5DNdE
        E2KAP1r1XKwMeBCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Message-ID: <YqyZ/Uf14qkYtMDX@linutronix.de>
References: <20220616123709.347053-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220616123709.347053-1-vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-16 13:37:09 [+0100], Valentin Schneider wrote:
> Regarding the original explanation for the WARN & return:
> 
> I don't get why 2) is a problem - if the lock is acquired by the trylock
> then the critical section will be run without interruption since it
> cannot sleep, the interrupted task may get boosted but that will not
> have any actual impact AFAICT.

boosting an unrelated task is considered wrong. I don't know how bad
it gets in terms of lock chains since a task is set as owner which did
not actually ask for the lock.

> Regardless, even if this doesn't sleep, the ->wait_lock in the slowpath
> isn't NMI safe so this needs changing.

This includes the unlock path which may wake a waiter and deboost.

> I've thought about trying to defer the kexec out of an NMI (or IRQ)
> context, but that pretty much means deferring the panic() which I'm
> not sure is such a great idea.

If we could defer it out of NMI on RT then it would work non-RT, too. If
the system is "stuck" and the NMI is the only to respond then I guess
that it is not a great idea.

Sebastian
