Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F15B5B1E4A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiIHNOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:14:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F980D741B;
        Thu,  8 Sep 2022 06:13:50 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MNffn2sX8z67NB8;
        Thu,  8 Sep 2022 21:12:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:13:20 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 8 Sep
 2022 14:13:20 +0100
Date:   Thu, 8 Sep 2022 14:13:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <bp@alien8.de>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <20220908141319.00000f01@huawei.com>
In-Reply-To: <631940536d040_2736529437@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
        <20220907153016.f7cd4f42a337fedae8319f28@linux-foundation.org>
        <631940536d040_2736529437@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 18:07:31 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Andrew Morton wrote:
> > I really dislike the term "flush".  Sometimes it means writeback,
> > sometimes it means invalidate.  Perhaps at other times it means
> > both.
> > 
> > Can we please be very clear in comments and changelogs about exactly
> > what this "flush" does.   With bonus points for being more specific in the 
> > function naming?
> >   
> 
> That's a good point, "flush" has been cargo-culted along in Linux's
> cache management APIs to mean write-back-and-invalidate. In this case I
> think this API is purely about invalidate. It just so happens that x86
> has not historically had a global invalidate instruction readily
> available which leads to the overuse of wbinvd.
> 
> It would be nice to make clear that this API is purely about
> invalidating any data cached for a physical address impacted by address
> space management event (secure erase / new region provision). Write-back
> is an unnecessary side-effect.
> 
> So how about:
> 
> s/arch_flush_memregion/cpu_cache_invalidate_memregion/?

Want to indicate it 'might' write back perhaps?
So could be invalidate or clean and invalidate (using arm ARM terms just to add
to the confusion ;)

Feels like there will be potential race conditions where that matters as we might
force stale data to be written back.

Perhaps a comment is enough for that. Anyone have the "famous last words" feeling?

Jonathan




