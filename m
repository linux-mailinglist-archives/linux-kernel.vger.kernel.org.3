Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69B53C01D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiFBVAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiFBVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:00:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8412F34BB6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZMC0JMDJpU3Ea9On6JN2DLeBQ12wi64TMeGJm440bio=; b=LAGghuKhpFoBNIGZFIztX+f9Ct
        foa5z/E10Sydt2cFotdonoOIEyichjxplkMFoJR4Zh0cVptSTtlnkVnzwpLUvKqyl80ZgMDuNkk8T
        AHjt6nFNx+MGQi6tfrecRdCs9rjQvqh86Wynas+Dzig2h6MGksLjv8pe6nkDHz42r6tXjI65AMSLw
        /4O0CMEfCWrhKWGX9MuGpwkjhJiTeus/MBwBIMKobPjnvF0chObg9W/kgsW8OGrFr16e4WzO/o6m/
        tEwJ0LpQIhHr27Uwss4XxPY0famMei6ZHdDivwiBOlTy3RbVRy4PM3lJftVICipyoPgax2Kn6ce+D
        Vjxrn2kg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwrvG-007QUZ-FK; Thu, 02 Jun 2022 21:00:02 +0000
Date:   Thu, 2 Jun 2022 22:00:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 5/7] mm: thp: kill transparent_hugepage_active()
Message-ID: <Ypkk0pRHwBrI9Cj/@casper.infradead.org>
References: <20220602182159.248387-1-shy828301@gmail.com>
 <20220602182159.248387-6-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602182159.248387-6-shy828301@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:21:57AM -0700, Yang Shi wrote:
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 79d5919beb83..f315c70d5256 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -209,7 +209,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>  	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
>  }
>  
> -bool transparent_hugepage_active(struct vm_area_struct *vma);
> +extern bool hugepage_vma_check(struct vm_area_struct *vma,

Please remove the 'extern's.  They add no value to function
declarations.

