Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44F8554CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358422AbiFVOSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358277AbiFVOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:18:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CD13CFFF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E1F4B81EB6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E50FC34114;
        Wed, 22 Jun 2022 14:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655907451;
        bh=zRN8pMikC873iNt1UJIlldjE9fXl+iAWKj+fmNVfc4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BL1Gxil96ejsriMZjrrBOYuKst8H/GStZG+U7S+PB9tgm1raxZ3FEJZF6NQWqs0lP
         FZHE2HSITFEisrke+GN2B4gwihEPE6H5pX2MRQqNLGVzPkHJyLvfJilvUZBpjlpYMk
         MYmSLdEyAFvq1w/9O6PuwLQ54Im1bxHmwMi0TIFPYNxcqCOTeZRTx6RdF3aNJwDllc
         uW/ypMZ29kksalATXvIhNnWHibxCPy0UKxZY4OZzymQzWBiI+Z0zDXAIkV1gXcJxfp
         +gnwU/e9Gl8L52aeHYKSGp2/TSKR2lhg4a8jibYV5PUoXICCGfCuQg+zKfT3XMAXhv
         GlyrJA3lu7dug==
Date:   Wed, 22 Jun 2022 09:17:24 -0500
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG
 Makefile options
Message-ID: <YrMkdPjftJz2J7Vx@kernel.org>
References: <cover.1655889641.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655889641.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rebecca,

On Wed, Jun 22, 2022 at 04:29:05AM -0500, Rebecca Mckeever wrote:
> These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
> simulator, which can be specified when running make. These patches also
> implement the functionality for these options.
> 
> VERBOSE
> Usage:
> 
> $ make VERBOSE=1
> 
> Passing VERBOSE=1 will enable verbose output from Memblock simulator. For
> each test, the verbose output includes the name of the memblock function
> being tested, the name of the test, and whether the test passed or failed.
> Since all the tests in Memblock simulator run as one monolithic test, this
> output is a quick way to get a summary of test results.
> 
> MEMBLOCK_DEBUG
> Usage:
> 
> $ make MEMBLOCK_DEBUG=1
> 
> Passing MEMBLOCK_DEBUG=1 will enable memblock_dbg() messages. These
> are debug messages built into several functions in memblock that include
> information such as the name of the function and the size and start and
> end addresses of the memblock region.
> 
> Rebecca Mckeever (4):
>   memblock tests: add user-provided arguments to Makefile
>   memblock tests: add verbose output to memblock tests
>   memblock tests: set memblock_debug to enable memblock_dbg() messages
>   memblock tests: remove completed TODO items
> 
>  tools/testing/memblock/Makefile               |   4 +
>  tools/testing/memblock/README                 |  10 +-
>  tools/testing/memblock/TODO                   |  14 +-
>  tools/testing/memblock/internal.h             |   7 +
>  .../testing/memblock/scripts/Makefile.include |  10 +
>  tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
>  .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
>  tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
>  tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
>  tools/testing/memblock/tests/common.c         |  58 +++
>  tools/testing/memblock/tests/common.h         |  54 +++
>  11 files changed, 913 insertions(+), 356 deletions(-)
> 
> ---
> Changes
> 
> v1 -> v2
> PATCH 2, in common.c:
>   Remove #ifdef VERBOSE around prefixes and related constants
>   Add __maybe_unused to prefixes
>   Move PREFIXES_LEN_MAX, DELIM, and DELIM_LEN so that they are
>     immediately after the other constants
>   Add #ifdef VERBOSE around definitions for test_*() and prefix_*()
> 
> v2 -> v3
> PATCH 1:
>   Add Reviewed-by tag
> ---

The patch changelog in a cover letter usually goes before the commit list
and diffstat. 
 
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
