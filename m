Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D2A4B4FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiBNMYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:24:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiBNMYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:24:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B5496A8;
        Mon, 14 Feb 2022 04:24:07 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:24:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644841445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h86e3ywIoIWlbZPAA6Jb40sJGWIa4y4aW4PEf5FISKc=;
        b=L1biZruAax2Ck/UnNbngqfbl/5zvAaOWQ/1WHg3B+3qCesTXtHg2+D2xyqghWD4zEywB7m
        JKL7v3hrMsFC+TkFd3FynvQ11b9hl6fuW0eyJb0nBHQV3amC2BMqKkIyY+VIpa9NCKCGHZ
        SE+JzHvDU+VCypv8RdBkot9lEqtMGk70CNLq6bkKkmWPtCOrRWz11i4uXIrZzOPyhKG3gI
        BvqZKBe70Nlb9IQRptJEJ6ugy61rDjCXtQmN4iplwU+0cnbhi7yv0eAqYkydBQIXbc+aC9
        4BSUMulHjVBT7zIasOROHnLauN6iGxGFdceIoAe5HkCqXOKs5+cHqdVm29XU1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644841445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h86e3ywIoIWlbZPAA6Jb40sJGWIa4y4aW4PEf5FISKc=;
        b=A5Yq4ovpwjdT2GKFmXxZ4tFEOHvQubrYC6ppNh99lBT7t8Yf8oJba7VokpclVC1I9ANn3m
        gEldm3YBuQO/euCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 7/8] kernel/fork: Only cache the VMAP stack in
 finish_task_switch().
Message-ID: <YgpJ41q35k+KCsk4@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-8-bigeasy@linutronix.de>
 <00f9c7a6-2d1d-f871-e9bc-00e2217f40f9@kernel.org>
 <YgpGnFlTS+2Ugfw4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgpGnFlTS+2Ugfw4@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 13:10:06 [+0100], To Andy Lutomirski wrote:
> 
> I think I could use the first few bytes of the stack as a RCU-head. Let
> me try that.

task::stack_vm_area and ::stack. Now I remember why I went for that bit.
But I do have (hopefully) a better idea now.

> > --Andy

Sebastian
