Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240284C2D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiBXNpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiBXNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:44:58 -0500
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net (p3plsmtpa06-08.prod.phx3.secureserver.net [173.201.192.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2229426F4E6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:44:29 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id NEPynxQ5Itbo2NEQ0n87OC; Thu, 24 Feb 2022 06:44:28 -0700
X-CMAE-Analysis: v=2.4 cv=M8iIlw8s c=1 sm=1 tr=0 ts=62178bbc
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=dryZNVXSxjYntoBgU78A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Thu, 24 Feb 2022 13:44:26 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220224134426.ai7demvrupzy6lu5@ava.usersys.com>
References: <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
 <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
 <20220219154616.pwsvh445x3vn7ltf@ava.usersys.com>
 <Yhd5olg9CjXSAf2s@fuller.cnet>
 <20220224130014.rmhtx3xlepybuxn2@ava.usersys.com>
 <YheE0joXm53Hxn4J@fuller.cnet>
 <20220224132816.qsfa66ao3xdjdxxx@ava.usersys.com>
 <YheK2oesh/cxvi6j@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YheK2oesh/cxvi6j@fuller.cnet>
X-CMAE-Envelope: MS4xfCEzHm3PJhNGG/t1WGRX1uIq4CTw1/ohvmRt+lOAbOWx+NaU1T9Xe8vUdDEkhfCci4DYz4STHFa4a2B5oVghjtutom7a5mLDK8h/zj7y+umS91dotgLF
 dWgst43fXC+M5LGpz7TSb30O2DWLp3SdPtJrgQuGQxBLU6QNZ0iIy+BYbkm3UlBfKE0Ha/TPw1nVs6793xclOU5/eMdudGsOLaFLnHsJIH/DUs/h9clvJusQ
 LJdITso7ZAFguPkXroY7Etr7XVmk6FjBicAoU6k4ekfVVuWYosFzpSfJdYSWY8CNHnqmUEZwuNsp6pIYIivlZxKqSb60kdYRnpOM3JvhIVt3Q5g4EbobKal9
 iM9cqm2xnuvsyPQu62yLYuHv5cgHApSPqtfnUzS4qE+fg7WTLP06acJg9q6wqgYYL+OrTsQw
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-24 10:40 -0300, Marcelo Tosatti wrote:
> On Thu, Feb 24, 2022 at 01:28:16PM +0000, Aaron Tomlin wrote:
> > On Thu 2022-02-24 10:14 -0300, Marcelo Tosatti wrote:
> > > If the per-CPU vmstat_update is limited to happen once per second, that
> > > shouldnt be a significant performance impact?
> > 
> > Perhaps not. Albeit, is the interrupt worth it? 
> 
> Its a requirement for correctness right?

Yes, this is true.

> > Then again it could indeed
> > be a long time before the idle task is selected and a return to idle code
> > were we'd check for any remaining differentials with the aforementioned
> > patch.
> 
> Or a long time before userspace returns to kernel.

Indeed. I'll put together a patch for comment.


Kind regards,

-- 
Aaron Tomlin
