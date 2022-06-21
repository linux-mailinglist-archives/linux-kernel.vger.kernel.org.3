Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF43D553E18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355374AbiFUVrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiFUVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:47:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DBA186E1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:47:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655848065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MW31G5kbLu7/Ci0H2MhhDew+fQAgETw4RoigY7kMdHg=;
        b=XDBfijn0gdcFhbScEOcVU21nKf/td+AsNM2biCOYygacdDxoAJwlaYC3i4lAJUwVIbl59Z
        Y7XFJ51Xt4ocAQk5T43Nh0WKqIgNGlaJRmDWqgAz7fkLSJk5h46BI90fhi/SsBjwUPakXi
        XELp0SGBxFqUrIeJb1PArKIsHoJThxp5fbErz6X8tKlriCTSqeOING9LztUr7KGuhRaLHf
        ERuE/N/rWVFsCvImB2T2gZPSWlRRGkVCLPGZdwHBHJDtmfTnTneBXgPhRaRVf0Eg3v0l1R
        tlgAAJSQDoWU6nAR5dXughhiH6pPdo7xGnTtZGEf0ta8f/ZUpI2t/8cMY7Sz4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655848065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MW31G5kbLu7/Ci0H2MhhDew+fQAgETw4RoigY7kMdHg=;
        b=reFnj+hQ8X0HNAgyXwNbv8GWk81hcdrqWxrZ71D00HbfBDtrheru8sdeIBDhJCUCE/udWG
        QeSgrlQQgahjp4CA==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] printk: allow direct console printing to be enabled
 always
In-Reply-To: <YrAC8F8lDc1JNkoq@google.com>
References: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
 <20220619204326.556923-1-Jason@zx2c4.com>
 <87letsw8en.fsf@jogness.linutronix.de> <YrAC8F8lDc1JNkoq@google.com>
Date:   Tue, 21 Jun 2022 23:53:44 +0206
Message-ID: <875yktadtr.fsf@jogness.linutronix.de>
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

On 2022-06-20, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> would it make sense/be possible/etc. to look into possibility
> to address that "deferred kthread vs IRQ" race by moving prb entries
> emit to the same IRQ handler that emits chars from uart xmit buffer?

I think this is an interesting idea. We could have a function that would
allow serial drivers (if they had a console on them) to flush any
pending printk messages for their console.

Each driver would need to call this function for themselves. And also
the driver would need to ensure that it is not holding any locks that
the console-part of the driver will need. And it would need to be best
effort, because the related kthread may already be in the process of
printing. But in general I think it could be a nice feature to improve
the sort-of-synchronous behavior of printk for drivers that use it.

John Ogness
