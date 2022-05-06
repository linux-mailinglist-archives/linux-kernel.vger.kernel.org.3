Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEFB51D569
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390838AbiEFKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345998AbiEFKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:15:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12CB50067;
        Fri,  6 May 2022 03:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D398CB834C4;
        Fri,  6 May 2022 10:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5933AC385AA;
        Fri,  6 May 2022 10:12:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Az7pofcI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651831927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NAoAz+/NOez2wGCZnQTdc84GHGEoenuNAoJcJZeRVQQ=;
        b=Az7pofcI41WEDQEkaDFKsyK/l+H5K035XX1Zlw7cVmGSiWp1sw7iHY6RTHd0bXlluRFZ0S
        VP71J/0tLE6/dPmlFU3Wh3cel6YX/4H655NDAmEkqAy03x4QfKYUvBRHCg09dE76/d3hB2
        VJDBa7Lz/XODxHu/OjVsqYI963BzDRs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0c0eb92d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 6 May 2022 10:12:07 +0000 (UTC)
Date:   Fri, 6 May 2022 12:12:04 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        linux-crypto@vger.kernel.org, nathan@kernel.org
Subject: Re: [timekeeping]  3aeaac747d: PANIC:early_exception
Message-ID: <YnT0dDFtq7HnRC7n@zx2c4.com>
References: <20220506032023.GA23061@xsang-OptiPlex-9020>
 <8735hnhz1q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735hnhz1q.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, May 06, 2022 at 09:59:13AM +0200, Thomas Gleixner wrote:
> +/**
> + * random_get_entropy_fallback - Returns the raw clock source value,
> + * used by random.c for platforms with no valid random_get_entropy().
> + */
> +unsigned long random_get_entropy_fallback(void)
> +{
> +	struct tk_read_base *tkr = &tk_core.timekeeper.tkr_mono;
> +	struct clocksource *clock = READ_ONCE(tkr->clock);
> +
> +	if (!timekeeping_suspended && clock)
> +		return clock->read(clock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(random_get_entropy_fallback);

I tried to address this already in
<https://lore.kernel.org/lkml/20220505002910.IAcnpEOE2zR2ibERl4Lh3Y_PMmtb0Rf43lVevgztJiM@z/>,
though yours looks better with the READ_ONCE() around clock, and I'll
send a v8 doing it that way. I didn't realize that clock could become
NULL again after becoming non-NULL.

I'm not quite sure I understand the purpose of !timekeeping_suspended
there, though. I'm not seeing the path where reading with it suspended
negatively affects things. I'll take your word for it though.

Jason
