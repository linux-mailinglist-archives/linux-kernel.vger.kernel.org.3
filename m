Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DCE48C895
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbiALQiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:38:08 -0500
Received: from mail.efficios.com ([167.114.26.124]:39872 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343550AbiALQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:38:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BD4AB2578BE;
        Wed, 12 Jan 2022 11:38:06 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xlU9B2-5QPf1; Wed, 12 Jan 2022 11:38:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1213225799F;
        Wed, 12 Jan 2022 11:38:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1213225799F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642005486;
        bh=g9f7dG+bhNKpizysyUoQp+wUex1LU175g8hrrfqMfiE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oUYGLzxW7kN56OZ3buj3XtfWITjaoWI4Whuj09aFDuNpCxf41LWDicIYOsE4RzCRP
         eDgfgqqtkCeldPgTgPEaEFUqkkgyy78gpIa/8wYnoTVJ9F5xzki7wcS1QszL4civ9J
         W5vrl0vHHZlqoCsJkWxDZKIWxXtzhE3VOUlZl1LYqa4+GbmyhzeO7CBxeW+Lw0f2VW
         vkWkaqco9iprqHDk34QxgLQlaUbBqgWbe4m1ccE8jpWrYK4R+UvvyTaPXEV/0E7TEo
         JQtTK41GfzGtrdQK53SKVnQwmBp9hMIiBQwYi1TdY3JhULh7RTkCRdqnSIeeucKjk4
         aHspZZCsAePwg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D9n8D_sJ4JYi; Wed, 12 Jan 2022 11:38:06 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 01062257B05;
        Wed, 12 Jan 2022 11:38:06 -0500 (EST)
Date:   Wed, 12 Jan 2022 11:38:05 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Message-ID: <396330808.24806.1642005485899.JavaMail.zimbra@efficios.com>
In-Reply-To: <87sftt6j0u.fsf@mid.deneb.enyo.de>
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com> <87a6g7ny0j.fsf@mid.deneb.enyo.de> <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com> <87y23l6l2j.fsf@mid.deneb.enyo.de> <Yd71+Da44h9Ge0+s@hirez.programming.kicks-ass.net> <87sftt6j0u.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: SzHVQlW/ZeENurobLuAlPowCMIU0hg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 12, 2022, at 11:00 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Peter Zijlstra:
> 
>> On Wed, Jan 12, 2022 at 04:16:36PM +0100, Florian Weimer wrote:
>>
>>> You could perhaps push a signal frame onto the stack.  It's going to
>>> be expensive, but it's already in the context switch path, so maybe it
>>> does not matter.
>>
>> Please no! Signals are a trainwreck that need change (see the whole
>> AVX-512 / AMX saga), we shouldn't use more of that just cause.
> 
> If it's a signal, it should be modeled as such.  I think it's pretty
> close to a synchronous signal.

Florian, just to validate here: is your argument about AVX-512/AMX or about
rseq abort-at-ip ?

Am I understanding correctly that you would prefer that the kernel push an entire
signal frame onto the stack rather than just push the abort-at-ip value
on abort ? If it is the case, are there advantages in doing so ? Tooling support ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
