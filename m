Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1B64E9C50
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbiC1Qed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbiC1Qea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:34:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0D62A17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:32:49 -0700 (PDT)
Date:   Mon, 28 Mar 2022 18:32:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648485168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s8R1rFpKPGiX8tjGMLwDE5ZH7Zajq5rA2088Om6hAHo=;
        b=eXTKy1Uso/VUNvAsvpJ137VDRkdojOQXWHib8tpLLwnH/2Z+7n5+FDi3Ta2Tvtk2ZyQDT2
        3DEogWfW4rVM4xIuKGBPO+jCd5HxcFD4VKTcSVRpVaLcvKhOyCwnK+0cdUEgSfhmPFZd1c
        KL3e8SxzHWt2anLOYVZz+BTtS4ue/GZ1KyPdpPM2nLR0QtqOdXrIH1S7GLMOgsfEHpiOnm
        3Kn6Ru3SUVkB8GYsgexhaxMoL5x1ou/n0hxt6I+PKIji3p0qZsRJiyT9EMmNcSkBUW+N49
        z3H6/WydomIyrcmxDf1q7QvqKD9cOacSIvDUuqLOQxqT29ZwIacCvWCVKmrz2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648485168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s8R1rFpKPGiX8tjGMLwDE5ZH7Zajq5rA2088Om6hAHo=;
        b=Ly+2vTanCidedkBsGTsZ8Po7DAmp4mhC1h9ppOeYA6tzf4slNkMND8z1bABgnhlI+zeqsU
        OPgk7cRmP4RyWcBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] signal/x86: Delay calling signals in atomic
Message-ID: <YkHjLkDsA4oYj9rU@linutronix.de>
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
 <8735j2xigt.fsf@email.froward.int.ebiederm.org>
 <87h77iw34u.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h77iw34u.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-28 09:41:37 [-0500], Eric W. Biederman wrote:
> I want to say the patch below looks like it was a perfectly fine debug
> patch to see if what someone thinks is the issue is the issue.  It is
> not a good final solution for the reasons I have already mentioned.
> 
> May I ask where the rest of the conversation was?  I can only find the
> single posting of this patch on linux-kernel without any conversation,
> and the description indicates this change has seen several rounds of
> development.

There was not feedback based on what has been posted to lkml.
This, was ended as this patch, was originally posted by Steven as
	https://lore.kernel.org/linux-rt-users/20120124191454.345715521@goodmis.org/

a few iterations later we got to v4 in
	https://lore.kernel.org/linux-rt-users/20120203183041.427463295@goodmis.org/

which got review from Oleg and then become Oleg's in v5
	https://lore.kernel.org/linux-rt-users/20120208005850.233662427@goodmis.org/

and was part of the RT queue since v3.0.20-rt36.

> Eric

Sebastian
