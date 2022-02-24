Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAEF4C2C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiBXNCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiBXNCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:02:21 -0500
Received: from p3plsmtpa12-07.prod.phx3.secureserver.net (p3plsmtpa12-07.prod.phx3.secureserver.net [68.178.252.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B57329BC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:01:50 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id NDkinwwSF4g5nNDkjnn3CQ; Thu, 24 Feb 2022 06:01:50 -0700
X-CMAE-Analysis: v=2.4 cv=FvbAQ0nq c=1 sm=1 tr=0 ts=621781be
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=1lnWF7C_TSq6DCnCXLMA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Thu, 24 Feb 2022 13:01:48 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220224130148.xfpfmybrtayjncor@ava.usersys.com>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
 <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
 <20220219154616.pwsvh445x3vn7ltf@ava.usersys.com>
 <Yhd5olg9CjXSAf2s@fuller.cnet>
 <Yhd6UxWH3FQHg+eF@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yhd6UxWH3FQHg+eF@fuller.cnet>
X-CMAE-Envelope: MS4xfFBGZKM6OSunN06Tbm0Ztuibn0pwdeWrky4QSfM+VrazJuNvuSs6abyyBknpFpM+JZ6MJsNyGCzM4n2izYj9SjYxwtwkrIW71V7FVHu00c03zcm6oCB2
 9jhyX1Qvrp17MncCXR8QXvHhgKcb0InD5siT1lafNsWD4zN8/aOUD2TZkJgLnRW10jyiUcco3NftAHFOYuS20v1IuKQeWtw6iZAIsfGxUdXA5dpsBXLwPSr1
 518IyejJKIrzmiuoGw/iRvQ26lrwEbAONLZ2AEjDF9aRE7QaLJZU8A4JSN3YhOu2m1rr1fUd8w8t9xms1a4zyYMzTPYHAoxikCBImzZnCYzWr14J3rmbPxmV
 j+6tzaGQdjvzQ2seksPBcRLZAvAjmDVH2eMcS5Gb3J1/3o0nUBw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-24 09:30 -0300, Marcelo Tosatti wrote:
> > > > > 2) What if we are running task A in kernel mode while the tick is stopped
> > > > >    (nohz_full). Task A modifies the vmstat and goes to userspace for a long
> > > > >    while.
> > > > > Your patch fixes case 1) but not case 2). The problem is that TIMER_DEFERRABLE
> > > > > should really be about dynticks-idle only and not dynticks-full. I've always
> > > > > been afraid about enforcing that rule though because that would break old
> > > > > noise-free setups. But perhaps I should...
> 
> Can't grasp the sentence above "The problem is that ...".
> What rule?

Hi Marcelo,

That statement was from Frederic.


Kind regards,

-- 
Aaron Tomlin
