Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8080A4705BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243485AbhLJQeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbhLJQeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:34:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB8C061746;
        Fri, 10 Dec 2021 08:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2+bdmvJdEvPYzTwSQ6+YZVVgXjBRdV07Ohd2Ex/cYo0=; b=ve6q2IhNsKn1dgrmkvXroLy59P
        REzND4EWEnPkECYGxlGztoqCGt0OTU8A7fXmzz2fpSb0KTTJAeeGTeVp3+n6QX7bHeBA1spr2K/cG
        +DgpyISPfyrdVA3ccE1mQ8RwlponI+wCT4WFJVZCSO39BCARSk4mVylKqJfcT0bXtHctWVL/Gw1Y8
        VmZrN9yMcoERrvvQfueXN4yxfMGazwLMHCck81ZkzGSqA52N+bXwhtK4ooz/Nr6zMeIbDhtXB2Rti
        fUl7lPWBfBiAaImw/Gy0fclEmQa8//Sj/LTtqkPDNopEHaP3gHSlGtbLnMf5trgpar0ugcLKykhb5
        kfBFAxNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvinF-00AUEi-7t; Fri, 10 Dec 2021 16:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D39B3000E6;
        Fri, 10 Dec 2021 17:30:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3ED312BF8DA3A; Fri, 10 Dec 2021 17:30:45 +0100 (CET)
Date:   Fri, 10 Dec 2021 17:30:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM: runtime: Add safety net to supplier device release
Message-ID: <YbOAtbjF2MdtPCRc@hirez.programming.kicks-ass.net>
References: <11889065.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11889065.O9o76ZdvQC@kreacher>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:10:13PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because refcount_dec_not_one() returns true if the target refcount
> becomes saturated, it is generally unsafe to use its return value as
> a loop termination condition, but that is what happens when a device
> link's supplier device is released during runtime PM suspend
> operations and on device link removal.
> 
> To address this, introduce pm_runtime_release_supplier() to be used
> in the above cases which will check the supplier device's runtime
> PM usage counter in addition to the refcount_dec_not_one() return
> value, so the loop can be terminated in case the rpm_active refcount
> value becomes invalid, and update the code in question to use it as
> appropriate.
> 
> This change is not expected to have any visible functional impact.
> 
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
