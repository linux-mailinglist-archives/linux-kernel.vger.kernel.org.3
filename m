Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0755F4D0635
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiCGSSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244701AbiCGSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:18:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00F33A2A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:17:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A6FBB81662
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4266C340EF;
        Mon,  7 Mar 2022 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646677066;
        bh=dMWp6dfQJtApHFoFC3z+P98pDL4OG/wx5oadmxcaPis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OIxM0K85f+JVS/L67FAjImn0M27vXFzXTv1ztgL0e7bGZpqH0SyHoVLe68pcrUiFy
         dcAha3/uiXXtm1sY8TTz5KJEbybp29slUmowOOYI7RxDEIv9oWTTa2phq8uesmGcYt
         ktEHg7rUPBvc/e+l3MiBoPMLAblYN1Nx1YBQ0+fImgSLu2PLysP9Hc2pa1rKY8NTK0
         m7+9Wdh0UxTUyIo7fW4Rd0cHYneXA0FmsRW/9r0rTkKoNSA6xTzDUVBoPzYx9bTzvE
         Tv6XF3aifzczfQ7pWghfSGy7Hr2ATtx+/uXvef9A9lWNQH/CExZ7rFq/5kV2HpdYJT
         xK3IFyenJYE8w==
Date:   Mon, 7 Mar 2022 20:17:39 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Add tests for memblock allocation functions
Message-ID: <YiZMQz/wLlCQMFbW@kernel.org>
References: <cover.1646055639.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646055639.git.karolinadrobnik@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karolina,

On Mon, Feb 28, 2022 at 03:46:42PM +0100, Karolina Drobnik wrote:
> Patches are on top of memblock/for-next.
> 
> This series adds test coverage for memblock allocation functions that return
> virtual addresses:
>   * memblock_alloc
>   * memblock_alloc_try_nid
>   * memblock_alloc_from
> 
> These tests are a part of memblock simulator, a user space test suite that uses
> the actual memblock code[1]. All the tests are run as one, monolithic test, that
> exercises both basic operations and allocation functions of memblock.
> 
> To simplify implementation of the memory allocation tests, reset_memblock() was
> split into two functions - reset_memblock_attributes() and
> reset_memblock_regions(). The former sets default values for region array names,
> allocation direction flag (bottom_up) and current memory limit. The latter only
> resets region arrays and corresponding counters.
> 
> In addition to these, the patch set introduces a data structure that simulates
> physical memory, test_memory. It is a simple wrapper around a pointer to the
> memory block allocated via malloc(), which is added to memblock as available
> memory. This is required because the tested functions interact with the memory
> before allocating it.
> 
> Patchset structure:
>   * Patch 1 splits reset_memblock() into two functions -
>     reset_memblock_regions() and reset_memblock_attributes(), and updates
>     basic API tests to use the new definitions
>   * Patch 2 adds test_memory struct and functions to add (or release) dummy
>     physical memory
>   * Patches 3 - 8 add test cases for memblock_alloc, memblock_alloc_try_nid and
>     memblock_alloc_from for both allocation directions (default top down and
>     bottom up)
>   * Patch 9 adds README and TODO files
 
Except for few minor comments about README and TODO these patches look good
to me.

The only think that I'd really like is to wrap the lines longer that 80
characters.

(scripts/checkpatch.pl --max-line-length=80 can help with that)

> [1] https://lore.kernel.org/linux-mm/cover.1643796665.git.karolinadrobnik@gmail.com/
> 
> Karolina Drobnik (9):
>   memblock tests: Split up reset_memblock function
>   memblock tests: Add simulation of physical memory
>   memblock tests: Add memblock_alloc tests for top down
>   memblock tests: Add memblock_alloc tests for bottom up
>   memblock tests: Add memblock_alloc_from tests for top down
>   memblock tests: Add memblock_alloc_from tests for bottom up
>   memblock tests: Add memblock_alloc_try_nid tests for top down
>   memblock tests: Add memblock_alloc_try_nid tests for bottom up
>   memblock tests: Add TODO and README files
> 
>  tools/testing/memblock/Makefile               |    3 +-
>  tools/testing/memblock/README                 |  114 ++
>  tools/testing/memblock/TODO                   |   28 +
>  tools/testing/memblock/main.c                 |    7 +
>  tools/testing/memblock/tests/alloc_api.c      |  742 +++++++++++
>  tools/testing/memblock/tests/alloc_api.h      |    9 +
>  .../memblock/tests/alloc_helpers_api.c        |  393 ++++++
>  .../memblock/tests/alloc_helpers_api.h        |    9 +
>  tools/testing/memblock/tests/alloc_nid_api.c  | 1167 +++++++++++++++++
>  tools/testing/memblock/tests/alloc_nid_api.h  |    9 +
>  tools/testing/memblock/tests/basic_api.c      |   49 +-
>  tools/testing/memblock/tests/basic_api.h      |    1 -
>  tools/testing/memblock/tests/common.c         |   33 +-
>  tools/testing/memblock/tests/common.h         |   21 +-
>  14 files changed, 2550 insertions(+), 35 deletions(-)
>  create mode 100644 tools/testing/memblock/README
>  create mode 100644 tools/testing/memblock/TODO
>  create mode 100644 tools/testing/memblock/tests/alloc_api.c
>  create mode 100644 tools/testing/memblock/tests/alloc_api.h
>  create mode 100644 tools/testing/memblock/tests/alloc_helpers_api.c
>  create mode 100644 tools/testing/memblock/tests/alloc_helpers_api.h
>  create mode 100644 tools/testing/memblock/tests/alloc_nid_api.c
>  create mode 100644 tools/testing/memblock/tests/alloc_nid_api.h
> 
> 
> base-commit: f30b002ccfee8c60c8feb590e145c0b5e8fa4c67
> --
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
