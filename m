Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309CF5AB53C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiIBPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiIBPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:31:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF77F4936;
        Fri,  2 Sep 2022 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LWi1NrY2/7cJMZdtMXH/O4pRfZOaLxdRq+GMfQXVvRQ=; b=Xv3sPjQRmqKS1aW/0flFzEXOKF
        YeFzZj81isOzd57n7rr1POEqSH4mN90s7zgHGD8EUU//0PYExrjy8v7tJTN9obAgKv5WHTMOsUlcL
        eqrJspMGV6DHYIBHP+F5i0Gz7ToByvO/rFL3+NypQJaLUH/+XL3LdU/mQGj7GcuR3plhfbxFnR3Tc
        ZD5FQ15unahGX7PWrxBvJ8tG6rOogtRN1KT8DgO2uuVLUNX3jqgHAxxGMiHMrbsZw2fowHy06zPPB
        ApupSFMb/0IN4VaAjY+dBM+GpgbTNYooKyq7vxT+qRHn3L+leIVOBYvPHASIA2ztDCBkMMtaK6q6b
        p4MlMVSw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU8Lq-0077ZP-UO; Fri, 02 Sep 2022 15:12:59 +0000
Date:   Fri, 2 Sep 2022 16:12:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 08/10] headers/deps: mm: Split <linux/gfp_types.h> out of
 <linux/gfp.h>
Message-ID: <YxIdeiL0iOsN3zv8@casper.infradead.org>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
 <20220706174253.4175492-9-yury.norov@gmail.com>
 <YxEZYUCA0b8Cd1/S@casper.infradead.org>
 <YxFmAcrDkFuIsuOu@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxFmAcrDkFuIsuOu@yury-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 07:10:09PM -0700, Yury Norov wrote:
> On Thu, Sep 01, 2022 at 09:43:13PM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 06, 2022 at 10:42:51AM -0700, Yury Norov wrote:
> > > From: Ingo Molnar <mingo@kernel.org>
> > > 
> > > This is a much smaller header.
> > > 
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  include/linux/gfp.h       | 345 +------------------------------------
> > >  include/linux/gfp_types.h | 348 ++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 350 insertions(+), 343 deletions(-)
> > 
> > You move a lot of kernel-doc.  Where do you change the rst files?
> 
> Ingo - nowhere. So I did it in the next patch:
> 
> 7343f2b0db4961d ("headers/deps: mm: align MANITAINERS and Docs with new
> gfp.h structure")

That's not the right way to do it.  Don't merge a patch with bugs and
then fix it up in the next patch.  Just fix the patch.  This is covered
in Documentation/process/.

