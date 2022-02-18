Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4316B4BB98F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbiBRM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:58:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiBRM5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:57:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99DE33363;
        Fri, 18 Feb 2022 04:57:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12A5B60AFD;
        Fri, 18 Feb 2022 12:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465C5C340E9;
        Fri, 18 Feb 2022 12:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645189020;
        bh=rUxvNFgonoAuLA33gOMyiOrfFD2DvpL2w4FzX9GKdIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niE6ZUuTmbQ7TRwS9gYorjiGlxQb8rljzceGARLh7tGeLXTs9TFaUCJkWCoU1Sma7
         l+nBaT/VqiXvGcYTiRGpzA4pb5QN5k+Cz5Arb8I1bMj1711KbWeLmURFw42Mdz40Ox
         wF9ziwHlVac83VEZzG0Q5neclS3ps67WoM3lhGa5HzgkhGsLWTSs07Y+zPzyipyp3B
         h7A0+VGFoNUw9IWI77Ixu4nkZpGxHHHS2CCjqScsbS+j8LEKB5/GXN9UUN7N+Ti1nY
         +t/RSApmUFCIcul8JFJpbmCrvuFk9Dhm7ELlh9ukrLNeF0r1YKaxSI77TCww+ht3fv
         vrm89y0ZMIbYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1C7D4400FE; Fri, 18 Feb 2022 09:56:58 -0300 (-03)
Date:   Fri, 18 Feb 2022 09:56:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, elver@google.com, dvyukov@google.com,
        will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, tmricht@linux.ibm.com, irogers@google.com
Subject: Re: [PATCH v2] perf test: Skip Sigtrap test for arm+aarch64
Message-ID: <Yg+Xmt27POS2y2LI@kernel.org>
References: <1645176813-202756-1-git-send-email-john.garry@huawei.com>
 <20220218104611.GD56419@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218104611.GD56419@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 18, 2022 at 06:46:11PM +0800, Leo Yan escreveu:
> On Fri, Feb 18, 2022 at 05:33:33PM +0800, John Garry wrote:
> > Skip the Sigtrap test for arm + arm64, same as was done for s390 in
> > commit a840974e96fd ("perf test: Test 73 Sig_trap fails on s390"). For
> > this, reuse BP_SIGNAL_IS_SUPPORTED - meaning that the arch can use BP to
> > generate signals - instead of BP_ACCOUNT_IS_SUPPORTED, which is
> > appropriate.
> > 
> > As described by Will at [0], in the test we get stuck in a loop of handling
> > the HW breakpoint exception and never making progress. GDB handles this
> > by stepping over the faulting instruction, but with perf the kernel is
> > expected to handle the step (which it doesn't for arm).
> > 
> > Dmitry made an attempt to get this work, also mentioned in the same thread
> > as [0], which was appreciated. But the best thing to do is skip the test
> > for now.
> > 
> > [0] https://lore.kernel.org/linux-perf-users/20220118124343.GC98966@leoy-ThinkPad-X240s/T/#m13b06c39d2a5100d340f009435df6f4d8ee57b5a
> > 
> > Fixes: Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
> > Signed-off-by: John Garry <john.garry@huawei.com>
> 
> I tested this patch on my Juno board:
> 
> root@Juno:# ./perf test 73
>  73: Sigtrap                                                         : Skip
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

