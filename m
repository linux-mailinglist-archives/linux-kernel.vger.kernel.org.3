Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB351BA44
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbiEEI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347493AbiEEI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:29:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479FABC28
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BD161D62
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC0EC385A4;
        Thu,  5 May 2022 08:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651739123;
        bh=xFZaEfusF51fcI6minBqpSu8EX5dZ7pi25JoflQQgiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4/+gXch9nu8BJWq4mU3INHk/WhcLE51aUeUrL8ghk5CQ2i5Ci5RNJkyK/CvRJhuP
         TFVTMdk+6pOV5bMyZiJ/ihnzvXrHGQEK8ASEcx4mvmIkZTzaGrBLM9QnxO1sZ4fXqV
         Z8TPwuy5aIvdsKRkZqCv9ChyqTj/6gYbSqwWYXlGOrkjbZE93xlOLYielgxlMjzz7G
         fVs5iOsGR+p/J96t36y2st4/p5q9mUWHSdsUUEwdoQusLGHNKhHg9kSi5/cdZl0v0R
         fmhqg4/32gWECO6n6MHa6UG/satNGQVbSXbzrFrBY8198qrGmEdeBtI1CfFHK/0yzv
         rYtwa2gyo0fmQ==
Date:   Thu, 5 May 2022 09:25:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        alex.popov@linux.com, linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH v2 01/13] arm64: stackleak: fix current_top_of_stack()
Message-ID: <20220505082517.GA21170@willie-the-truck>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-2-mark.rutland@arm.com>
 <YnKsvNtIlE6cZEOa@arm.com>
 <202205041200.147A737@keescook>
 <YnLaOw49WTbhmflw@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnLaOw49WTbhmflw@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 08:55:39PM +0100, Catalin Marinas wrote:
> On Wed, May 04, 2022 at 12:01:11PM -0700, Kees Cook wrote:
> > On Wed, May 04, 2022 at 05:41:32PM +0100, Catalin Marinas wrote:
> > > On Wed, Apr 27, 2022 at 06:31:16PM +0100, Mark Rutland wrote:
> > > > [...]
> > > > Fixes: 0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Alexander Popov <alex.popov@linux.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Will Deacon <will@kernel.org>
> > > 
> > > I thought this was queued already but I couldn't find it in -next. So:
> > > 
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > Should this patch go via the arm64 tree for -rc6, or should I just carry
> > it as part of the overall stackleak series?
> 
> I'll leave this up to Will (we take turns in managing the kernel
> releases) but it doesn't look urgent at all to me since it fixes a
> commit in 4.19.

Agreed, and nobody has actually experienced a problem with the current code
afaict, so I'd prefer to leave this with the rest of the series rather than
run the risk of a late regression.

Will
