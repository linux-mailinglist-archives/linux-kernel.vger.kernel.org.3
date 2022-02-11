Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F04B2432
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiBKLWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:22:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiBKLW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:22:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34699E75
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:22:29 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644578547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eky0MB5+y4J6zcW+DJJS7LaFLiPykRaa7iwNzImqn7s=;
        b=ai8H/apU17eDHCRCTgKYlcriiWaKeZ15h6xLgTifsomZXeMe+ncR+ChFNnaC4PFEnZ9md4
        rrQtK4mUkC4gVBAlF7vlU8aAx+BlnMkxOC3Xbc0pOwkugK3b/l2Uj7kKxoRXELifWUrS6d
        r9qR7AP+Qf6rYID/1hXVuR96Nr2iT6VEwe6Wht9vet3PdxhnE710sWlS0Kswp7TGV3bo+d
        TpfwqPH+13Ouy+HKwdOX6a1Wm1nPckwSK151tjCF0RWtE6YyMf6FQ/113qtJB3zg0b5WO6
        d4eh/+B5m0Uriwoh4nGcEGUt3XEu+JjCj3FVslwrGe00dB34t+cY80Ke24f3hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644578547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eky0MB5+y4J6zcW+DJJS7LaFLiPykRaa7iwNzImqn7s=;
        b=US+J5RE7/Cz360KzDTrLLj2ZUtox99ERnwXtLI5Lr+hwoZepAM1qPNcQuDQoYOSz9S7w6Y
        mbVVVGkQ/KsMgwCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] printk: defer_console_output: use atomic update
In-Reply-To: <YgUzm5POctivsjUg@alley>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
 <YfzP50vDiJiaRVCr@google.com> <87bkzj3t77.fsf@jogness.linutronix.de>
 <YgUzm5POctivsjUg@alley>
Date:   Fri, 11 Feb 2022 12:28:27 +0106
Message-ID: <87leyhd4wc.fsf@jogness.linutronix.de>
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

Hi Petr,

On 2022-02-10, Petr Mladek <pmladek@suse.com> wrote:
> The patch has been committed into printk/linux.git, branch for-5.18.

Sebastian also pointed out that the use of __this_cpu_xchg() is the same
problem with the same variable for the same reason. We should fold that
change into the patch as well. The patch will followup this message.

@Sergey: I dropped your Reviewed-by since the code changed.

John
