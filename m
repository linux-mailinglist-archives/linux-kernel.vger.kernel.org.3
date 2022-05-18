Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6270B52B385
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiERHdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiERHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:33:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01364880CB
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OSnS9Gc8JFL+vsVD6+x2CBXZoMLLZDp5qoKeoDP2gxA=; b=ayjs67fDG9+njrHbDEJTD9Wpn+
        VfAbhXrt8x9HPt6bho0wfOK+tWDf7fjXj8G4RLKd5dc0b1p8x+ilq5A7AtI5f1yhYST6I0NI5UZKz
        73B+bwrgwHckQsuq/5T09mhlu4nBzsrhS7wDDkhYppgGq64NAE3TDa+H3CD5YlnzmewQ015Bx9okK
        DTqg8Ni3QfQgPdFmEezZHKT8FlcB4BWofb8rtIxoR4b2ef0qpVY+SN4tD3pYeZ8rBCDxF+ttcSusm
        q91Uo4Sgx8Du8i91hpDZE/+wCBUhxry0SG7ENO5Q3RSEeOOKm4VboHdSk2/44h1oM36yQ/YYoWnno
        2BpUPT+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrEBk-0006Rr-K7; Wed, 18 May 2022 07:33:44 +0000
Date:   Wed, 18 May 2022 00:33:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 33/44] kmap: Make kmap work for devmap protected pages
Message-ID: <YoShWMGVj9ZJbWqT@infradead.org>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-34-ira.weiny@intel.com>
 <Ymq3yrQ3rmgnbX1o@infradead.org>
 <Ynxh/5jewIuGwb5d@iweiny-desk3>
 <YoQl3yLa4iDCjicO@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoQl3yLa4iDCjicO@iweiny-desk3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 03:46:55PM -0700, Ira Weiny wrote:
> Ok there is a trade off here which I'm not sure is a good idea.
> 
> In order to make kmap faster I carefully placed the devmap_protected() call
> completely inline.[1]  This specifically checks the PGMAP_PROTECTION flag in
> dev_pagemap.[1]
> 
> I see only 2 ways of not including memremap.h in highmem-internal.h.
> 
> 1) Make this check a function call and place it in memremap.c
> 2) Move struct dev_pagemap (and it's dependencies) to another header.
> 
> Number 2 negates any positive effect of splitting the header file.
> 
> Number 1 is going to force some overhead on all ZONE_DEVICE pages if PMEM is in
> the system.
> 
> Do you think the extra run time overhead is a reasonable trade off to
> eliminating the header?

Well, given how big these devmap helpes are it seems like they should be
out of line anyway due to the code size impact.  It would be great to
compare the code size for the cases of:

 1) baseline kernel
 2) devmap protection inline
 3) devmap protection out of line

And maybe you need to add linux-mm and Thomas to get a few more
opinions.
