Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51904B7B24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbiBOXTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:19:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbiBOXTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:19:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F40FC1C9E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBDFF6157E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089C3C340F3;
        Tue, 15 Feb 2022 23:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967148;
        bh=J5G/TINlmHc23UCskGemF0ZvApVh+Wj1ZO+IX7y1D3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGrdR1E/KH+AeDsVyrFHW8Lf66dTFhArd0d35Ld3UN3ACRj3SlNDq2OKDfjocxvKG
         5sep/hL+eJr5/xwLyUYV71xQpXCAURWd4gtYKcjo75S0J6Kuz05rvfcb6r5MVtjDai
         ejk49b09sIg+W7qRjl67rMDSm5EoZUJoTWVMkKTIKnjlu467rBYg8d64s2KHOyi7c5
         OaK0TWhkveLDH3OIBs4sdXDgOQBXQLJAoUc3lC64r30xfDwsu7jFgTYzuBhvmuBIAP
         MfcEeJ2NPJrxAqcKSyAETtK3EXCblaTs2sVUKHigRcfrgGOrnxBv6xvO4MuD3sytFQ
         SKTeNGvTixWYw==
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Dennis Zhou <dennis@kernel.org>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 00/49] bitmap: optimize bitmap_weight() usage
Date:   Tue, 15 Feb 2022 23:18:33 +0000
Message-Id: <164493593823.3069697.15308947342224952378.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 14:48:44 -0800, Yury Norov wrote:
> In many cases people use bitmap_weight()-based functions to compare
> the result against a number of expression:
> 
>         if (cpumask_weight(mask) > 1)
>                 do_something();
> 
> This may take considerable amount of time on many-cpus machines because
> cpumask_weight() will traverse every word of underlying cpumask
> unconditionally.
> 
> [...]

Applied to will (for-next/perf), thanks!

[12/49] perf: replace bitmap_weight with bitmap_empty where appropriate
        https://git.kernel.org/will/c/95ed57c73bbc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
