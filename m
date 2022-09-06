Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02DE5AF647
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIFUoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiIFUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:44:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F228B9AF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=34l93la2gO+EHI9/WnpSj4Mpu+xDsxTXmdZM9558mAE=; b=J7eoFfDljRdXX9+fIK9yK8bK+w
        +fRy8NaTSMbIs99y/1lp5pAWtcYtfCzGXHIYMeNBzr6X8rwq6CM7G5CfMHCKygRM+T3R9ZyM97c7O
        ZByZeeuRWGPIPtzv1QIVfB+e6+XquVHrkYmpNleP94FtpgcEfBdx8MEJZjY2UnYnqroJmB32zZhCg
        VEU7sLA/FFG5f7rW7WyPYkgZrMYHh8hWbRErpl4Lj4QDAK2+BwqrBy0KPH8e+3ihHL1TKTcDm9X6N
        3kf9PynflBd7pQNciy7uJdKXnJHIuDzHnRqqjO6bw00Pj9EE+VfZuC1pzNPIMpyCpRDv9WCrZY26T
        u6/xFbWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVfQD-00Akd0-M0; Tue, 06 Sep 2022 20:43:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18238300244;
        Tue,  6 Sep 2022 22:43:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 000512B976538; Tue,  6 Sep 2022 22:43:46 +0200 (CEST)
Date:   Tue, 6 Sep 2022 22:43:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Message-ID: <YxexAl+i+6MGjf7K@hirez.programming.kicks-ass.net>
References: <20220906201743.436091-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906201743.436091-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:17:43PM +0200, Hans de Goede wrote:
> On an Intel Atom N2600 (and presumable other Cedar Trail models)
> MSR_IA32_TSX_CTRL can be read, causing saved_msr.valid to be set for it
> by msr_build_context().
> 
> This causes restore_processor_state() to try and restore it, but writing
> this MSR is not allowed on the Intel Atom N2600 leading to:

FWIW, virt tends to do this same thing a lot. They'll allow reading
random MSRs and only fail on write.
