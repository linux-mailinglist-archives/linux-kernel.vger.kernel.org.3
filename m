Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9005E474661
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhLNPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:24:41 -0500
Received: from relay035.a.hostedemail.com ([64.99.140.35]:56589 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232642AbhLNPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:24:40 -0500
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 6F553207AA;
        Tue, 14 Dec 2021 15:24:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 23EE420025;
        Tue, 14 Dec 2021 15:24:33 +0000 (UTC)
Message-ID: <b1cb1fd9be34d2fcec2578e06facc4168de4f554.camel@perches.com>
Subject: Re: [PATCH] sched/fair: fix boolreturn.cocci warning
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>, cgel.zte@gmail.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Tue, 14 Dec 2021 07:24:34 -0800
In-Reply-To: <20211214091446.383ec08e@gandalf.local.home>
References: <20211214113845.439392-1-deng.changcheng@zte.com.cn>
         <20211214091446.383ec08e@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dzmnykyjgqc6d55qfzms77xyr53w5mnp
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 23EE420025
X-Spam-Status: No, score=-3.40
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19SrzT1XjbmvCr68Mwxdh4486s+cBVGdhc=
X-HE-Tag: 1639495473-273755
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-14 at 09:14 -0500, Steven Rostedt wrote:
> I'll save Peter Zijlstra time from replying to this.
> 
> On Tue, 14 Dec 2021 11:38:45 +0000
> cgel.zte@gmail.com wrote:
> 
> > From: Changcheng Deng <deng.changcheng@zte.com.cn>
> > 
> > ./kernel/sched/fair.c: 9781: 9-10: WARNING: return of 0/1 in function
> > 'imbalanced_active_balance' with return type bool
> > 
> > Return statements in functions returning bool should use true/false
> > instead of 1/0.
> 
> This is a stupid warning. In C "1" is the same as "true" and "0" is the
> same as "false". 
> 
> This is a bogus error message and something not needed to be fixed.
> 
> Please remove these checks from your scripts.
> 
> NACK

Perhaps it is more a change for consistency than a fix for correctness.

$ git grep -P 'return\s+(?:true|false)' kernel/sched/ | wc -l
209


