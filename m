Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916E4B49AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbiBNKAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:00:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345256AbiBNJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:56:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63206A05E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:45:20 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644831918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRLdNRcIWUyRKQCuOcC0f9nXgqucHuOoTf3yNXF7dLU=;
        b=JRcf7lddoPJliX96m/PgzaNVltRjiQqLlsC4bSh0X1jIPRoi3iwr92qtcxLmqjWv/hhEqR
        Ui+/x8TBqC74cJDV2IM30JsTf9mjzSvTHEE9aeBuUCQw3atK3K/RoP9k/NXKUCXptRGvIk
        IUcclxZVYKqQdNfcq2iI2DuVn87IgBn1EHCXzIvv9nwhRcf6D4ZXk33p78pF9gFxjq6Fkf
        eAadQS8qq3Fn6ay5Y3zrLqjOY/CiJuEM4ebhCu5sREhH69HtXqBrETc4ijAuX5ahGlSdvF
        p/wwibGZbH1iSLcHv2r/O3cX31rvtMKDI6Hr1Ru71GJlj8ZB/ubCatrEaE04kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644831918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRLdNRcIWUyRKQCuOcC0f9nXgqucHuOoTf3yNXF7dLU=;
        b=EmttaSzrcxkwQ6QhdUhPkTAOp+TfSsbxUTDxKES2FQ3n2y66FmNm6z9jsSmMF25dg0Oxfg
        aUOdvSOKxc0Up1Bg==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
In-Reply-To: <Ygn7ZFnFL4QiQHRg@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
 <YgZaMkUU5Ve2GV9D@alley> <Ygn7ZFnFL4QiQHRg@google.com>
Date:   Mon, 14 Feb 2022 10:51:18 +0106
Message-ID: <87mtit4w9d.fsf@jogness.linutronix.de>
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

On 2022-02-14, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> printk has been using enter/exit naming for a while now (starting with
> nmi enter/exit, then printk_safe enter/exit and soon direct
> enter/exit); so may be we can follow suit here and use
> printk_cpu_sync_enter() and printk_cpu_sync_exit()?

I like this suggestion. So it would be:

printk_cpu_sync_enter_irqsave()
printk_cpu_sync_exit_irqrestore()
