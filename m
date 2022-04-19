Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A97506325
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbiDSEX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDSEXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49AE1EAE4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F45A61170
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DE2C385AE;
        Tue, 19 Apr 2022 04:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650342043;
        bh=SkMyO5ksvmtWgBk5Fo1VJ5mXQrgD0cTZ5AqLxQU89Eo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b+olHbyuknbDEbqf8tnzIOD9Hpco+gBk9i99p/Gr8p5ADUSS2r6IzyA2mVYDV5zOJ
         ZZXBvLzr6gRe8dKVwqq784JDZwLpfhFrQ/vyn8ms2n7XcrLDgynBUYxFtj1LwBBm55
         MRj4EaOPgqbBhWlUvrpgYIg0QW3EN9rTlTMvGfbA=
Date:   Mon, 18 Apr 2022 21:20:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] kasan: Fix sleeping function called from invalid
 context on RT kernel
Message-Id: <20220418212042.ae77c3c7ad51d95e59d6f78a@linux-foundation.org>
In-Reply-To: <PH0PR11MB5880FAABCE50894AE6A77528DAF19@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220401134649.2222485-1-qiang1.zhang@intel.com>
        <20220415113456.2f24660a610e4f35fd72970a@linux-foundation.org>
        <PH0PR11MB5880FAABCE50894AE6A77528DAF19@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Apr 2022 02:47:43 +0000 "Zhang, Qiang1" <qiang1.zhang@intel.com> wrote:

> >Note that it incorporates the changes from your https://lkml.kernel.org/r/20220414025925.2423818-1-qiang1.zhang@intel.com
> >
> >btw, how are we supposed to test PREEMPT_RT builds?  I had to patch arch/Kconfig.
> 
> The attachment is a config file and I test with linux-5.17.y-rt branch (https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git),  I have been tested.

OK, but it's a problem that we're adding CONFIG_PREEMPT_RT code to the
mainline kernel without providing for it to be at least compile-tested.

Sebastian, is there something we can do here to increase the coverage
testing?
