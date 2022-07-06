Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B02569120
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiGFRxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGFRxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:53:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288311DA7F;
        Wed,  6 Jul 2022 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wIX3xKGkHpy5joBvYNCPfPDTfzV+c1/g7GJKc6QUDtk=; b=gEt5kyoNliPVilPC0D90PK4vJo
        S4k1NidEXXLSSp+GXXKr1ocUWr9QZvoWNrpI7kT5EFzYHa/qAZebjZFi4uUcTD4BRAWplc2YGuOkn
        vjh98+S83dHEmiOj1NFLkmxLED09BvIvTSlCGfS0/IZtO+wyUR2l7JA0nFXiJipnqO/nxRdb1i4vF
        P+wIBQ5eff14eaCW1NbyfLafWY9brSPtl/nBcQo7OvBAz21c4EEcfeGPEJZO7WZAnRy7IzymWKXeZ
        A/pVz/oOZHj2kHJ1BXfH4m55/NGtAdQPmZdEK3J5pZo8WJXd4EM4kot2yUigHGexwpm/HS00HqM3q
        AeSI/uMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o99DF-001qad-79; Wed, 06 Jul 2022 17:53:21 +0000
Date:   Wed, 6 Jul 2022 18:53:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 01/20] rv: Add Runtime Verification (RV) interface
Message-ID: <YsXMEeqGr2vdJCa7@casper.infradead.org>
References: <cover.1655368610.git.bristot@kernel.org>
 <60548902dbccaa7ba420e40e46835693e27f643f.1655368610.git.bristot@kernel.org>
 <YsXLDvjHqOxYtckg@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsXLDvjHqOxYtckg@geo.homenetwork>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 01:49:02AM +0800, Tao Zhou wrote:
> > +struct rv_monitor {
> > +	const char		*name;
> > +	const char		*description;
> > +	bool			enabled;
> 
> Can the 'bool enabled;' be put at the end like the definition of
> structure rv_monitor_def. If '8+8+sizeof(bool)+8+8+8' not the same
> as '8+8+8+8+8+sizeof(bool)', I mean is it possible that after the
> end of stucture there is a int or char not require to align to 8 as
> an example from my nonsense.

That will make no difference at all.  C doesn't allow other variables
to "fill in the hole" at the end of the structure like that.  For
example, one could legitimately do 'memset(&rvm, sizeof(rvm))',
and that would wipe out those other variables as well.
