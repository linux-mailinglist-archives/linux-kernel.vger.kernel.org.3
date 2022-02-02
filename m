Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34594A6E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbiBBJ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:59:27 -0500
Received: from relay039.a.hostedemail.com ([64.99.140.39]:33832 "EHLO
        relay5.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiBBJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:59:24 -0500
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 41606120372;
        Wed,  2 Feb 2022 09:59:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 80BC22B;
        Wed,  2 Feb 2022 09:59:07 +0000 (UTC)
Message-ID: <b7f445008e9921f41df36077a7e28562675e8417.camel@perches.com>
Subject: Re: [PATCH RESEND v2] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
From:   Joe Perches <joe@perches.com>
To:     maninder1.s@samsung.com, "apw@canonical.com" <apw@canonical.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>
Date:   Wed, 02 Feb 2022 01:59:21 -0800
In-Reply-To: <20220202095225epcms5p271da4783d86cb7c51d12d80f097aea44@epcms5p2>
References: <4ee87d70d5348949787b2d747f90ecffa3119d0b.camel@perches.com>
         <20220202071405.1872044-1-maninder1.s@samsung.com>
         <CGME20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919@epcms5p2>
         <20220202095225epcms5p271da4783d86cb7c51d12d80f097aea44@epcms5p2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80BC22B
X-Spam-Status: No, score=0.32
X-Stat-Signature: 83dafdtptao487u8pnz4gt1xg3nxk94h
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+lUGzFSr7Pg8vY7XOFeKjB1HBlTbeI2XE=
X-HE-Tag: 1643795947-725066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-02 at 15:22 +0530, Maninder Singh wrote:
> Hi,
> 
> 
> > >  printk_deferred and printk_deferred_once requires LOGLEVEL in argument,
> > >  but checkpatch.pl reports it as warning:
>  
> > When did that occur?  Please reference the specific commit.
> > When printk_sched (now printk_deferred) was created it did not
> > allow KERN_<LEVEL>.
>  
> > see commit 3ccf3e830615 ("printk/sched: Introduce special printk_sched() for those awkward moments")
>  
> I think with below commit:
> 
> 98e35f5894cf208084688ec0c7bb7b713efc997f (printk: git rid of [sched_delayed] message for printk_deferred)
> 
> earlier it was passing hardcoded KERN_WARNING to all printk_deferred messages, but now it switched
> to normal printk behavior.
> 
> -       if (in_sched)
> -               text_len = scnprintf(text, sizeof(textbuf),
> -                                    KERN_WARNING "[sched_delayed] ");
> -
> -       text_len += vscnprintf(text + text_len,
> -                              sizeof(textbuf) - text_len, fmt, args);
> +       text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
> 
> 
> I did not search that earlier, because we were fixing some issue in our local module code with printk_deferred
> and then checkatch reported the issues, so thought of fixing it, becaue without level
> pritk_deferred messages was shifted to default loglevel as done by normal printk.
> 
> So I thought it was designed to pass loglevel from starting stage and checjpatch reports falsely.
> but seems checkpatch needs to fixed with that commit itself, because earlier it was not required to pass loglevel.

Most of that should be in the commit message.


