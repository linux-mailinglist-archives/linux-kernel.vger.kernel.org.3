Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151EA49273E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiARN1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiARN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:27:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9030C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 05:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S8lJ6hT05IScVfaZWCLS3w0gUdsjMZ1JnIANvQPP7fM=; b=VRSgdevRxq3XobfoPWZXq+HbFs
        Ez7ah4iB/NkloIdMlY2A17KMTerGSoXOXw6wT53ihcGl9mS6YVwmysCNrQbzRlFQDwKOFH0AxBG+f
        21WggbLVBoBw393fOgwbowfbZZH4mXLONiG1VCtWPPgPzM8+nZIyKc1A3taEjo4n3lTnL2E+UtXSW
        G1+d6BafPDCeFGdhHavJyb/TVIjp7NjR6rxkGNpW1jZvfb4E262h/bodvAMSkWLYplknftmBHbugc
        kKWtm7gdkedWDjzhR2VwsAJO1pS1ogtIEDOx3gC7SXxLTX49ax4RdmmkkrMypaPrfb5kjNOJ92cJj
        eH8pJloA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9oWP-009FJG-Uw; Tue, 18 Jan 2022 13:27:37 +0000
Date:   Tue, 18 Jan 2022 13:27:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Mark Hemment <markhemm@googlemail.com>, hughd@google.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        rientjes@google.com, mhocko@suse.com, surenb@google.com,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: Re: [PATCH v3 RESEND] mm: shmem: implement
 POSIX_FADV_[WILL|DONT]NEED for shmem
Message-ID: <YebASTShsELnoiVj@casper.infradead.org>
References: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
 <CANe_+UipVZRZeWqzXezacPaVb9UeC6a_ZhQp8GkrvftbRktotg@mail.gmail.com>
 <2c66ba2e-1c65-3bdd-b91e-eb8391ec6dbf@quicinc.com>
 <61212ffd-3505-04d7-5403-932a10d676e7@quicinc.com>
 <Yd7VZId4IlKd4VpC@casper.infradead.org>
 <eb056201-a6e2-a58e-dd77-666f124d1896@quicinc.com>
 <a31bdd1a-0fd8-7303-dc97-a2cf156f1d83@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31bdd1a-0fd8-7303-dc97-a2cf156f1d83@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 05:05:40PM +0530, Charan Teja Kalla wrote:
> Hello Matthew,
> 
> > Yes.  This should obviously be an xa_for_each() loop.
> 
> In one of your patch[1], where we used xarray iterator, though most of
> the entries found requires to call xas_pause() but still endup in using
> xas_for_each() rather than xa_for_each(). Then, Should this code be
> changed to use xa_for_each()? The documentation also says that "The
> xas_for_each() iterator will expand into more inline code than
> xa_for_each()."
> 
> [1]https://patchwork.kernel.org/project/linux-mm/patch/20200819184850.24779-4-willy@infradead.org/

How do you know the distribution of swap and non-swap entries in that
region of that xarray?
