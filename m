Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D75A5452
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiH2TJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiH2TJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:09:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADEC7E827;
        Mon, 29 Aug 2022 12:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2400BB811C1;
        Mon, 29 Aug 2022 19:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A24C433C1;
        Mon, 29 Aug 2022 19:09:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fxxJbh2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1661800175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=se7iHVBPmFGtUkY2jW1ypnd8OsfvW6M/G2Rrn6yTXLg=;
        b=fxxJbh2CmEGHAFmQppyVLivVtInkWs+D4yIevizSiev6bXgUAUU1sNVOdtQRANPUecF1zA
        1A3kCvGzbuHfFYxKjl45J1aD3UTeL6QaGEDyhyj/NmWRlkRDHESTCErFlK6lNEHIiba/pi
        1IXCxdMFAko30+Sa+D1qzFRcshvTO1w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 53fce227 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 29 Aug 2022 19:09:35 +0000 (UTC)
Date:   Mon, 29 Aug 2022 15:09:30 -0400
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Langley <agl@google.com>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
Message-ID: <Yw0O6pQ7oKHGmQ0O@zx2c4.com>
References: <YwgCrqutxmX0W72r@gmail.com>
 <Ywzr2d52ixYXUDWR@zx2c4.com>
 <Yw0Ah5m/2HDDvCjS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yw0Ah5m/2HDDvCjS@gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:08:07PM +0000, Eric Biggers wrote:
> I'd much prefer it being set unconditionally by default as well, as making
> everyone (both kernel and userspace) turn it on and off constantly would be a
> nightmare.
> 
> Note that Intel's documentation says that CPUs before Ice Lake behave as if
> DOITM is always set:
> 
>     "For Intel® Core™ family processors based on microarchitectures before Ice
>     Lake and Intel Atom® family processors based on microarchitectures before
>     Gracemont that do not enumerate IA32_UARCH_MISC_CTL, developers may assume
>     that the instructions listed here operate as if DOITM is enabled."
> 
> (It's a bit ambiguous, as it leaves the door open to IA32_UARCH_MISC_CTL being
> retroactively added to old CPUs.  But I assume that hasn't actually happened.)
> 
> So I think the logical approach is to unconditionally set DOITM by default, to
> fix this CPU bug in Ice Lake and later and just bring things back to the way
> they were in CPUs before Ice Lake.  With that as a baseline, we can then discuss
> whether it's useful to provide ways to re-enable this CPU bug / "feature", for
> people who want to get the performance boost (if one actually exists) of data
> dependent timing after carefully assessing the risks.
> 
> The other way around, of making everything insecure by default, seems like a
> really bad idea.

Right. It's actually kind of surprising that Intel didn't already do
this by default. Sure, maybe the Intel manual never explicitly
guaranteed constant time, but a heck of a lot of code relies on that
being the case.

Jason
