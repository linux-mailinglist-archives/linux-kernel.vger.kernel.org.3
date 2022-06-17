Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE78654FBA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350673AbiFQQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382641AbiFQQxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:53:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F207649C9E;
        Fri, 17 Jun 2022 09:53:34 -0700 (PDT)
Date:   Fri, 17 Jun 2022 18:53:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655484813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=giQdDv8p0YqkjTRJ/+bMp26gGyp0dRqL/fs20UthWLo=;
        b=4knjidennpLmK5EdIueesjrOBlk4jXwtLAq2P1eAl3AnTdC4GnjfBV9eRR1iSNUMeUR4Ak
        bKIizBa9cpTZqhp7nR7WOcrDB+WWinuuQm3fxNNel9yqsS7k3iPEHuAzBufuPF7pfov0jk
        9Fw4FfkoB9OPVVx72yP/P1j8kSFdTCJOQ5/SsQlREeeyxvcN1zcBL3FXNZzR3gn5NDwAvb
        D0f+pd8SqS676/BDvxRSjs4RWRI7cLO8e2176dTK5twaivPWi7t1JKxdxiJdalQaNnaMVU
        6+GNyby9/yb5LbgFUlYsg7bsCy+UIwNX1j7jZTXXmjdPfwddHq7q/0mhqNv0pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655484813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=giQdDv8p0YqkjTRJ/+bMp26gGyp0dRqL/fs20UthWLo=;
        b=oT4dJHHBw+WW1QEdjaKsyt0kh2/dZWwsWY0fYKfKddIp8nq/B3rppmyWB50dBdyBbxlxzA
        EWkZU775Hz0oykAg==
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
Message-ID: <YqyxjDz4fB3LuRgJ@linutronix.de>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <YqyZ/Uf14qkYtMDX@linutronix.de>
 <xhsmha6ab6zm3.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmha6ab6zm3.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17 17:09:24 [+0100], Valentin Schneider wrote:
> Those were pretty much my thoughts. I *think* panic() can be re-entrant on
> the same CPU if the first entry was from NMI, but that still requires being
> able to schedule a thread that panics which isn't a given after getting
> that panic NMI. So for now actually doing the kexec in NMI (or IRQ) context
> seems to be the less hazardous route. 

most likely. Just get rid of the mutex and we should be good to go ;)

Sebastian
