Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDEC4D3183
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiCIPL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiCIPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:11:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B38C7D7A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:10:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EFD6B82201
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31437C340E8;
        Wed,  9 Mar 2022 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646838652;
        bh=P2x4+Ep7O5rS0M2KrtqxlQ9I5htAqM8Deh5DCXksjwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCPE9eLnYiohiFAKw8Zwg1qWKkUALo0MqDBqAorJzlDiaI4z0gXHlU3dVEo0fIGM8
         cfY8e9bKcD6+ama1Yce3X5TcvdBVXnxC6UtfD1kfnDp/oLzjgWOdHD+RpdoUiC2QtQ
         Xwp5IRApWgQThZdzEYT0aXR/58P/VeqsrqE4GO7ef7lfe4TGP/tZ1JOnl1cTME2BBT
         Elhz24BtPeNvcVovfbnAn/JWAh8STPRLa1SIpvZQljnGcIYlb8ZSX8UitM3BmGbL1Q
         oitt2yzYHv4pxt+Bpw8OlA7mXlWdKn2T/94X0ufbNNTu3XN4GwhXkrHnAmCBpgl401
         xatSbL4MDIKrg==
Date:   Wed, 9 Mar 2022 17:10:45 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Add tests for memblock allocation functions
Message-ID: <YijDdTRajbCfkfZo@kernel.org>
References: <cover.1646055639.git.karolinadrobnik@gmail.com>
 <YiZMQz/wLlCQMFbW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiZMQz/wLlCQMFbW@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 08:17:39PM +0200, Mike Rapoport wrote:
> Hi Karolina,
> 
> On Mon, Feb 28, 2022 at 03:46:42PM +0100, Karolina Drobnik wrote:
> > Patches are on top of memblock/for-next.
> > 
> > This series adds test coverage for memblock allocation functions that return
> > virtual addresses:
> >   * memblock_alloc
> >   * memblock_alloc_try_nid
> >   * memblock_alloc_from
> > 
> > These tests are a part of memblock simulator, a user space test suite that uses
> > the actual memblock code[1]. All the tests are run as one, monolithic test, that
> > exercises both basic operations and allocation functions of memblock.
> > 
> > To simplify implementation of the memory allocation tests, reset_memblock() was
> > split into two functions - reset_memblock_attributes() and
> > reset_memblock_regions(). The former sets default values for region array names,
> > allocation direction flag (bottom_up) and current memory limit. The latter only
> > resets region arrays and corresponding counters.
> > 
> > In addition to these, the patch set introduces a data structure that simulates
> > physical memory, test_memory. It is a simple wrapper around a pointer to the
> > memory block allocated via malloc(), which is added to memblock as available
> > memory. This is required because the tested functions interact with the memory
> > before allocating it.
> > 
> > Patchset structure:
> >   * Patch 1 splits reset_memblock() into two functions -
> >     reset_memblock_regions() and reset_memblock_attributes(), and updates
> >     basic API tests to use the new definitions
> >   * Patch 2 adds test_memory struct and functions to add (or release) dummy
> >     physical memory
> >   * Patches 3 - 8 add test cases for memblock_alloc, memblock_alloc_try_nid and
> >     memblock_alloc_from for both allocation directions (default top down and
> >     bottom up)
> >   * Patch 9 adds README and TODO files
>  
> Except for few minor comments about README and TODO these patches look good
> to me.

I went ahead and applied this series with some formatting fixes.
