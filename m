Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BBE544194
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiFICpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFICp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102AC4093F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 19:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB3761BA9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07309C34116;
        Thu,  9 Jun 2022 02:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654742724;
        bh=liHYB5MjVloFW14PtZqTFqJy0vZgK1FUxsXJ/i8hDL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YbmYAzZzENyPQ4133WMT4e3SjZHXYCPw/M3z0SeDVFqcpo6npi47pwYW0M4oqI9PN
         /yE5mvS0tscWf5CbgvBB3f2ipzPCYMUZ9n7ijbPKyXGO1gEIv9ijex8tvkRGvpTK4T
         O7RC0Struzvj8Fg0vNm4b9wJNhF9ZIHlv4NwhrQtnI8l3Tgiyr8L1XVQJzj3p4/XVm
         01oES7OU4ebv8Kv2PF8rKnH3d4qH+REG5gmr+lQwByCf0jd+DqcTO9JV2bOguji7mr
         XJN5mOzwmjYZU6UMFNlJtCYsDHYQr6K9x4R7j2fJwVe6lKxoCjP+CrJ4v5SaRjDw+R
         uojf9yZo4TjrA==
Date:   Wed, 8 Jun 2022 19:45:22 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     peterz@infradead.org, jpoimboe@redhat.com, bp@suse.de,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [REPORT] RESERVE_BRK() doesn't work for some cases
Message-ID: <20220609024522.7zaqp4rm3j6dhmdn@treble>
References: <1654738251-23522-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1654738251-23522-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:30:51AM +0900, Byungchul Park wrote:
> commit a1e2c031ec3 "x86/mm: Simplify RESERVE_BRK()" changed the behavior
> by compiler and assembler.
> 
> Some strings obtained just by __stringify() cannot be interpreted by
> some assemblers.
> 
> It might need to allow to put input for size within inline asm.

Yes, this was reported already.  I'm posting a v2 fix tomorrow.

-- 
Josh
