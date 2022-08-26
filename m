Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7646E5A25EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbiHZKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343773AbiHZKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7973D2914
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E16B60B91
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135C7C433C1;
        Fri, 26 Aug 2022 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661510164;
        bh=+izqYcemwkG2wEvEGbT2LOTMB+U6MjsFZ3z5zG1Ndww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LkotBogPwuFdvjFwu489hKIrwIrO+dZF1iE8Fc/TPUc9tB6HIKl5SjTuBI5+ZDvRy
         jBgBJfAhgUb8NuF9KoWLwZen3hcR3YekdW1KrtaNeFXAWuZI4WgTWrHZbXVRW3du1V
         ErS8uKkSXzcs+7T+323H04TyjJ5aeBxgRNHkpHLWXeBcME1NJtY3Lu7TvJ9nE/Acoy
         acoQVNwXwFSn7wWWXsPcpLHh7BwYhfDFrgQ6z3nyjJpLNilWsNvBf8cBDd/iXfZ7YN
         5WruHb9EeBmfpzfGEjgImE6WI5zmWMeThVSSnnNLRgmWQ5yr5SamO0IJJul6WiFvxM
         k0Lvof1UxzrRw==
Date:   Fri, 26 Aug 2022 11:35:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, rf@opensource.cirrus.com
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-ID: <20220826103557.GA19505@willie-the-truck>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <Yt6u34sigPEkeZ0Y@FVFF77S0Q05N.cambridge.arm.com>
 <Yt605xj898VSAsA3@casper.infradead.org>
 <YuPwLq+D8k53GZa3@smile.fi.intel.com>
 <YuPwgmHbcQYsA4Kp@smile.fi.intel.com>
 <Ywd7h68eYwGDYBtJ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywd7h68eYwGDYBtJ@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 03:39:19PM +0200, Petr Mladek wrote:
> On Fri 2022-07-29 17:36:50, Andy Shevchenko wrote:
> > Actually kstrtobool() has been designed as a generic parser that should have
> > lowest priority. It means that the code that uses it should take care of any
> > other custom cases _before_ calling for kstrtobool().
> 
> Makes sense.
> 
> Jagdish, could you please send a patch fixing the "rodata" early_param
> in arch/arm64/mm/mmu.c?
> 
> Please, also add:
> 
> Cc: stable@vger.kernel.org # v5.19+

I have a fix already queued here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/fixes&id=2e8cff0a0eee87b27f0cf87ad8310eb41b5886ab

Sadly, it's missing the stable tag, but we can always send it manually if
the robot doesn't grab it.

Will
