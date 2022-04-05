Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E844F4986
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442019AbiDEWTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445129AbiDEPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:42:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41514190B79
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y/i7pByZo0Q5olsOgInKdWMXyGn8q2jQ0GfVe7p0oik=; b=ftiz1A9VHWBq7s/mE3EkDzqx7Y
        9tSf0/IrvUc01zYMZckJXWm86IjPPXDwHdy/3bXBQdTEmJ8IU05MedVPXzc0ERiOX0VdxII5m/OW/
        FM8ALFPZa+A+tG7yekcxkn+QgWc6+LotRYZHpK3Me0qFCGxSZRUczN592fmHOP4brIuaiS8PM9uJY
        28BEwhzaS8D0DxIC6SRtfmBJKUbg6X8tV7Az6AD02Es7IJiui2qZ7FFmcY8xlth1oi9J8fpilYx24
        B7Myvmx0B3qH6Pxrf8GhjWGdePadc4uPuO44eQ0DLqTLmSpq6U4qpuZFP5YiYPWkcg5vLhzyV2ei8
        EwphxMNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbjq5-001sDn-0Z; Tue, 05 Apr 2022 14:07:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CD1630031E;
        Tue,  5 Apr 2022 16:07:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B53F2DC79000; Tue,  5 Apr 2022 16:07:19 +0200 (CEST)
Date:   Tue, 5 Apr 2022 16:07:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     linux-kernel@vger.kernel.org, Lewis.Carroll@amd.com,
        Mario.Limonciello@amd.com, gautham.shenoy@amd.com,
        Ananth.Narayan@amd.com, bharata@amd.com, len.brown@intel.com,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, keescook@chromium.org, metze@samba.org,
        zhengqi.arch@bytedance.com, mark.rutland@arm.com
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Message-ID: <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
References: <20220405130021.557880-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405130021.557880-1-wyes.karny@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 06:30:21PM +0530, Wyes Karny wrote:
> +static inline bool early_mwait_supported(const struct cpuinfo_x86 *c)
> +{
> +	if (c->x86_vendor == X86_VENDOR_INTEL)
> +		return true;
> +
> +	if (c->x86_vendor == X86_VENDOR_AMD && cpu_has(c, X86_FEATURE_ZEN))

What about Hygon? For some reason you guys don't co-ordinate and we end
up getting endless 'make-same' patches, sometimes separated by years :/

> +		return true;
> +
> +	return false;
> +}
