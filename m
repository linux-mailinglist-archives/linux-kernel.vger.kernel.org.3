Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DF04E235A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbiCUJcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiCUJcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:32:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8050554B7;
        Mon, 21 Mar 2022 02:30:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647855056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/jbJ+hlrmhBqwAxQYwBxLE0FutwoN2QmvQOGRzH0pko=;
        b=IADmSlZ6RCvbQq0Vnz5tUBbtX9STyzztEG5j7/VUQJUMjtbuXTp5qsIn7k3F8bVky6iCyi
        77P+ex1h+Fa3dkpXn8YmON2VAYMbdrLUbelKySpjdbFid5QING2fE11Fo/5qf34TT8gbgr
        ASV1H34T0gBBUuzO5MLrGEf6RXW9MvjWzmidHRSnAU9QJbk3+ZwxU2UvQfkw0mexV4V5hr
        ctQaCi63OHYvjhkRQxsnmNjn6pTpRjnWsLcMkPRBUepKKZoNi5Tq6UCU3Bz5akttG5QJjA
        vB+D8TX7PwvvgrvKCtJOtqEcTG3hBjWcVYxFlo0y2vRV9a9n2vSzMIpDIWZ6cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647855056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/jbJ+hlrmhBqwAxQYwBxLE0FutwoN2QmvQOGRzH0pko=;
        b=40Pn5fOwZzkrht8DcMsuGmZay1AWQZCxZkrofxArFbCux0MHYc4swe6xRjNeppdTg5Pz6b
        EpvNCmRsjz/LhVBA==
To:     Schspa Shi <schspa@gmail.com>, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de, schspa@gmail.com
Subject: Re: [PATCH 5.10-rt] printk: fix suppressed message print when
 reboot/panic
In-Reply-To: <20220321053815.71316-1-schspa@gmail.com>
References: <20220321053815.71316-1-schspa@gmail.com>
Date:   Mon, 21 Mar 2022 10:36:55 +0106
Message-ID: <87a6dj3b5c.fsf@jogness.linutronix.de>
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

On 2022-03-21, Schspa Shi <schspa@gmail.com> wrote:
> Update printk_seq for suppressed message.
>
> Affects 5.9-rt and 5.10-rt
>
> When message is suppressed, printk_seq should be updated, otherwise
> this message will be printed when reboot. This problem was introduced
> in commit 3edc0c85d154 ("printk: Rebase on top of new ring buffer").
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Nice catch. Thanks.

5.15-rt also has this issue, although the fix is slightly different. For
5.15-rt, writing to con->printk_seq (via latched_seq_write()) requires
the console locked. Would you like to post a patch for 5.15-rt as well,
or would you like me to do it?

5.16 and beyond does not have this issue.

John Ogness
