Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7592F561F91
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiF3PoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiF3PoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:44:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3557815A05;
        Thu, 30 Jun 2022 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IcWzBGmd5zZp0WxQBYsneB6E8zWmcy5CxnK6uyIIvQI=; b=pL3s9qUXp11qJa4cplmb32XiOV
        nHL1SXpsF1V39XAN4CQIo8fhSZZXisgoqg1CP7vvBIHUgWBysIfpRuL5QhGc3mAqm8orc/KNQKkTG
        92lZIO2pFb2dPC3FG+t0E16IDHAxpO7GREK4k41LKHcSEw3Zzx3uroYksGFMzKCDbJ4prwi0cyDup
        rGKvLO6rCqXqjbIQv+x1I9YYfzl4R4UlEV8EWtMMTvbBr0TfdyYp/GfWqsmigetu7yJEf4ZoOf4Fx
        mksMGAhfifaC8Lyvs6/wOk0X7vXmEuLjJE0vMVpotT/vSMBS7cvmXD9g0cwaDkl8O1YIUe2uy1gw6
        mRRpT3Pg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6wKA-00FI8t-RT; Thu, 30 Jun 2022 15:43:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 435FB30027E;
        Thu, 30 Jun 2022 17:43:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21DCD285D6B9E; Thu, 30 Jun 2022 17:43:20 +0200 (CEST)
Date:   Thu, 30 Jun 2022 17:43:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     will@kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, jacob.e.keller@intel.com,
        akpm@linux-foundation.org, linux-sparse@vger.kernel.org,
        cluster-devel@redhat.com, luc.vanoostenryck@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] refcount: add __cond_lock() for conditional lock
 refcount API
Message-ID: <Yr3EmEcO1AMFRlLA@hirez.programming.kicks-ass.net>
References: <20220630135934.1799248-1-aahringo@redhat.com>
 <20220630135934.1799248-2-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630135934.1799248-2-aahringo@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:59:33AM -0400, Alexander Aring wrote:
> This patch adds the __cond_lock() macro to refcounts conditional lock
> API. Currently sparse cannot detect the conditional lock handling of
> refcount_dec_and_lock() functionality and prints a context imbalance
> warning like:
> 
> warning: context imbalance in 'put_rsb' - unexpected unlock
> 
> with this patch and having the refcount_dec_and_lock() functionality
> inside the if condition to decide whenever doing unlock or not the
> warning disappears.
> 
> The patch follows a similar naming scheme like raw_spin_trylock() by
> adding a "raw_" prefix to refcount_dec_and_lock() functionality and
> introduce a macro for the replaced functions that uses __cond_lock()
> to signal that an acquire depends on the return value of the passed
> function.
> 
> A cast to bool seems to be necessary because __cond_lock() does return a
> non-boolean scalar type.

I hate the __cond_lock() think with a passions. Please just fix sparse
to not suck.
