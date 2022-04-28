Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C78513906
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349634AbiD1PyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349676AbiD1Pxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:53:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344301837D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7waCegNdmWV/+5cUIChqCcCO8D0VgzGnfltekIAPXpg=; b=F6PQsH3l294YWXulP6sAVhmifo
        LOH8oeGCcXdjyUar8wYcFbmNxU0b5meM7lMRecMAcsJmoxPEMr9GeJ/DR0RECAsojBRkPdGlFfJv2
        i2hBZRvjEJDHe0h6lQLRsPsjfIGtu3jgPyb61mgW/yImvndzeUhfvnsPSYE//9ZPcxRiNPePVFQsq
        SZ4wFzXbebBUCnw1Jt7DcJjJoU5R/A4cf9vG2k2i3QwfMWAZZ+u7aJhk66FmV5ucFeaU8ZQiW2TZy
        DSW+2YLiT7C5v7G+d9hZYKkRNUZ0TaaT1AejuZV2vdJuMt8rqDjdCAdzr4fGyeNUQ1SP5ORfKHc7d
        ESsMopSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk6Pa-007jU6-OH; Thu, 28 Apr 2022 15:50:34 +0000
Date:   Thu, 28 Apr 2022 08:50:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 33/44] kmap: Make kmap work for devmap protected pages
Message-ID: <Ymq3yrQ3rmgnbX1o@infradead.org>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-34-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419170649.1022246-34-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:06:38AM -0700, ira.weiny@intel.com wrote:
> index a77be5630209..32ed07c2994b 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -151,6 +151,8 @@ static inline void totalhigh_pages_add(long count)
>  
>  #else /* CONFIG_HIGHMEM */
>  
> +#include <linux/memremap.h>

Uuuh, I'd really prefer to avoid having to pull in memremap.h into
basically the whole kernel build.

