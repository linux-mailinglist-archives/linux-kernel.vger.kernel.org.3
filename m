Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE446E84C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhLIMXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhLIMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:23:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9136C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WRms7OFbsFawbXtV+pXa+pyWfy66ScXQPyhJ0BttZMI=; b=hZXlDI4kNP0VHVbfOEpM+JV7VH
        9fOOZs9aWCtRILWELqnTtu4IrgzLumNz/mVxma5PpE+c3pN5wSQc8cMlsK0qKH/wTFtcqWUy7Wi2G
        uy6gAxUb6tbql9HKE5emPx/LM0bEJBNbw+85F6nz4dSh8yy0FbbRm9KF93hw4uOrEU3srsSW/GXCj
        VosqFz4rfjrjXOOXI14ecFk3Pc/WcLaWmO4cqHOJ5KywQuKzK1p5W8HI1+ua5jnTVIxK7du89/eXg
        M/9aRo8DgjYxMBOxCA/qHtW7KO64QU6WyxDchiLIhe2UdfmkTHFr8fUP94iQf/1tAX+CrsJfgkdIO
        QB0ppijg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvIOw-000MVo-1h; Thu, 09 Dec 2021 12:19:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 422963000E6;
        Thu,  9 Dec 2021 13:19:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 295492BB99CC0; Thu,  9 Dec 2021 13:19:53 +0100 (CET)
Date:   Thu, 9 Dec 2021 13:19:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/12] x86/mce: Correct the noinstr annotation
Message-ID: <YbH0acLmGq6PUMbJ@hirez.programming.kicks-ass.net>
References: <20211208111343.8130-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208111343.8130-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 12:13:31PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi folks,
> 
> here's v1 with the instrumentation "sandwiching" documented, as
> requested by peterz.
> 
> Tony, I'd appreciate making sure nothing in them breaks your injection
> workflows before I queue them. And it shouldn't but... :-)
> 
> Thx.
> 
> Changelog:
> ==========
> 
> here's a first preliminary (it is based on some random 5.16-rc0 commit
> and is tested only in qemu) of the series which correct all the noinstr
> annotation of the #MC handler.
> 
> Since it calls a bunch of external facilities, the strategy is to mark
> mce-specific functions called by the #MC handler as noinstr and when
> they "call out" so to speak, to do a begin/end sandwich around that
> call.
> 

Looked ok. I think some of the comments can be improved to clarify the
noinstr usage in MCE in general, but that's about it.
