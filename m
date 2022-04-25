Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0850E1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiDYNbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242010AbiDYNaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:30:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D04091E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H7R9p0jqKi7IyAfu9QDTZpmTUdknj0kaCCRV1aoBUQk=; b=hf1suSMghz2ceMZPIZYlFREg21
        DyAubvSopa9rdwlzusFAfK1XFLaHcgnbfLL5klVqhUEq+S5TSEYikXChvvwGMmG2wQNiXjbiUoO0X
        TH1YgHxX3+UBU6m79HgHi4tzAXHToH9njB0IeZeU997ZydzYx0EUEodScuxmfGqjKzNcrnrBnSFza
        dyiCroLwfiwNLQ5tG1Z/D4KTxbMN0b5TPCdr2yGr2kO5AhZrjTrv4SQAA6BnDzjXhD3RO+T/E5Vw8
        lwk460VchNXCm6R+0+GhLFcQtpoZKC+WPcn+vCM8H5mE7UeLUrPK2qgHM8b6ElVMXrdLTPMpodEVy
        f4ldO+FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niyk2-008YA6-3M; Mon, 25 Apr 2022 13:27:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50130980C1C; Mon, 25 Apr 2022 15:27:00 +0200 (CEST)
Date:   Mon, 25 Apr 2022 15:27:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Aaron Tomlin <atomlin@redhat.com>, frederic@kernel.org,
        mtosatti@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220425132700.GK2731@worktop.programming.kicks-ass.net>
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
 <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
 <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 02:09:06PM +0200, Christoph Lameter wrote:
> On Mon, 25 Apr 2022, Aaron Tomlin wrote:
> 
> > Yes, in the context of nohz, this patch should ensure it, if required, when
> > the idle tick is to be stopped.
> 
> What I said was that it is generally useful. Even in the non NOHZ case.
> 
> Folding the vmstat diffs *always* when entering idle prevents unnecessary
> wakeups and processing in the future and also provides more accurate
> counters for the VM allowing better decision to be made on reclaim.

I'm thinking you're going to find a ton of regressions if you try it
though; some workloads go idle *very* shortly, doing all this accounting
is going to be counter-productive.
