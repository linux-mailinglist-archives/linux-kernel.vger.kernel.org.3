Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA515A01B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbiHXTCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiHXTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:02:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889A18B10;
        Wed, 24 Aug 2022 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661367732; x=1692903732;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bYVre1YznOFajN/3s4M8VKRS5YVUUpw3RPbdi4Ytvg4=;
  b=PnDReVvtJs8N5mdSMXvHBRLjHbp4PeUQTrPabnIxipbgR2mYYqRZBl0e
   S03cIPNNAKJprW7xqaaBr7hw4rigirNv23f5heiCRFdKwW1uFPyW4ajxn
   hHL4EVMpYMZPGOSMlLPHGBLDZKsYXMc9dP9ORX/ZHz35Bv/EL5B03gyrm
   REA0Hr3FoiA122n5wvKXvTfW29r4opVnBJPqyJI/1cisYERGHkVGHYCSs
   KdVkyEqFlll2m6IqBK51G1YyrQg9wJEF0sPDDOVPlLI+e3eevA8g2MuQF
   EfbH5GGZJCMsp7UkXNuOcI8Tck4aqOavCSp6xdPDyQVeTXSGJBx5l7H1x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="358024643"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="358024643"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 12:02:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="938027073"
Received: from skeshri-mobl.ger.corp.intel.com (HELO [10.212.154.182]) ([10.212.154.182])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 12:02:10 -0700
Message-ID: <08cda8cc-1a0f-9577-0e2d-ed6ccd10c174@intel.com>
Date:   Wed, 24 Aug 2022 12:02:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph
 updates for 5.20-rc1)
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
 <20220814225415.n546anzvud6sumux@box.shutemov.name>
 <CAHk-=wiOqbuzy7xzsLrN8LXKGGUUMH109wcKOXx_PV9PkHa=Zw@mail.gmail.com>
 <CAHk-=whSGBmH7zKvD-=qJLkWPSGZo1cM7GyLH=8cuide7+ri_Q@mail.gmail.com>
 <20220815041232.kypaxhhnvobgb35t@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220815041232.kypaxhhnvobgb35t@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/22 21:12, Kirill A. Shutemov wrote:
> But if somebody would try to be clever -- allocate memory and vmap() as
> shared (with proper VMM notification), but leave direct mapping intact --
> we have a problem. load_unaligned_zeropad() can step onto private mapping
> of the shared memory in direct mapping and crash whole TD guest.
> 
> The worst part is that for somebody who is not aware about
> load_unaligned_zeropad(), the vmap() trick is totally reasonable approach:
> it helps to avoid direct mapping fragmentation. We considered the trick
> for one of TDX-specific drivers.

This can also be fixed with guard pages.  It means allocating a
physically contiguous page to precede each one you want to vmap(), but
that's not the end of the world.

We're going to have to be *VERY* careful with any private->shared
conversion code.
