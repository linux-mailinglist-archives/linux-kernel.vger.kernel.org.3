Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD45B53420F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbiEYRMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiEYRMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:12:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58A6C578
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA619B81E72
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C99CC385B8;
        Wed, 25 May 2022 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653498734;
        bh=M7O1KvFOnWHpUH/SeIbxBs641FWxON2L2DiS0ElqKes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hAwq605fjdy0WSolawr16YguVkRAsRLnwQJIGZuCWRMgLuL4JsZnVv12q3WyxZKIi
         ZVeA7HMu75GGajheowimTU79XVLoMKwG6LpR2Jhg8QPBwBBUzHKHlE8K6ppg1xQur/
         TlwRwsKlEMVcH9Aq9B07doMfytciHjqDJVM/fHDjS2lclJHJGwKgzb7tdwFo/YQMTB
         2ZGmWf9uu/aDZBvBtIIequ4wnwzFKVvR3RCcpezp481tdS7ba6J/OKD1QtPvhILsh/
         sWVqDguJpF6GEoNpe54wqbmkTnlm1SYYvTEZExZjiX7a7Ax4GxayJndA4Artv+Fxw0
         8SwnBbRVkCfkQ==
Date:   Wed, 25 May 2022 20:12:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH] memblock: config the number of init memblock regions
Message-ID: <Yo5jZ6C4LMBmPRSd@kernel.org>
References: <20220511010530.60962-1-zhouguanghui1@huawei.com>
 <20220510185523.3f7479b8ffc49a8a7c17d328@linux-foundation.org>
 <YntRlrwJeP40q6Hg@kernel.org>
 <73da782c847b413d9b81b0c2940ab13c@huawei.com>
 <YnypGu1Cu2xPQ1nA@kernel.org>
 <Yo5dCF/Y9ijrMj5Z@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yo5dCF/Y9ijrMj5Z@fedora>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:44:56AM -0700, Darren Hart wrote:
> On Thu, May 12, 2022 at 09:28:42AM +0300, Mike Rapoport wrote:
> > On Thu, May 12, 2022 at 02:46:25AM +0000, Zhouguanghui (OS Kernel) wrote:
> > > 在 2022/5/11 14:03, Mike Rapoport 写道:
> > > > On Tue, May 10, 2022 at 06:55:23PM -0700, Andrew Morton wrote:
> > > >>
> > > >> Can we simply increase INIT_MEMBLOCK_REGIONS to 1024 and avoid the
> > > >> config option?  It appears that the overhead from this would be 60kB or
> > > >> so.
> > > > 
> > > > 60k is not big, but using 1024 entries array for 2-4 memory banks on
> > > > systems that don't report that fragmented memory map is really a waste.
> > > > 
> > > > We can make this per platform opt-in, like INIT_MEMBLOCK_RESERVED_REGIONS ...
> > > 
> > > As I described above, is this a general scenario?
> > 
> > The EFI memory on arm64 is generally bad because of all those NOMAP
> > carveouts spread all over the place even in cases without memory faults. So
> > it would make sense to increase the number of memblock regions on arm64
> > when CONFIG_EFI=y.
> 
> This seems like a reasonable approach. I would prefer not to have to increase
> the default for EFI arm64 systems (and all that entails with coordinating with
> distros, etc.). The point below about other arch's not needing this is a good
> one too. This seems like a reasonable way make the defaults work everywhere
> while only paying the price on the systems that require it.
 
There's already v2 of this patch:

https://lore.kernel.org/all/20220517114309.10228-1-zhouguanghui1@huawei.com
  
> -- 
> Darren Hart
> Ampere Computing / OS and Kernel

-- 
Sincerely yours,
Mike.
