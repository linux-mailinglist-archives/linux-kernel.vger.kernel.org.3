Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40C5395D7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346288AbiEaSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346867AbiEaSFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DEE7A45B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A24961120
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 18:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6816DC385A9;
        Tue, 31 May 2022 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654020318;
        bh=q/QrzhxSevkZMdXBh3GLbF1bFU+ZLYHCVAWkr3URa/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n5wVDE7/Ehb1Ic4NuM1EWvqZoBVnybTrXH81d5QOba6d5k3QkkopLkhcnm8rmeYY2
         xglHfBcxGoJRYpksAQqyJEQ9hHG2ppmlgaipLVHgJmdOE/Crm9WB0xXqo1HrBSXH2G
         A7j256zUbBTza8+NcmO0Aupy0YQyDYUL2wfA5O4o=
Date:   Tue, 31 May 2022 11:05:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alex Sierra <alex.sierra@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alistair Poppple <apopple@nvidia.com>
Subject: Re: [PATCH] mm/migrate: skip unsupported ZONE_DEVICE page in
 migrate_vma_collect_pmd()
Message-Id: <20220531110517.51b839799201e9e75684375a@linux-foundation.org>
In-Reply-To: <20220531122530.17996-1-linmiaohe@huawei.com>
References: <20220531122530.17996-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 20:25:30 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> For now we only support migrating to un-addressable device memory. Other
> types of ZONE_DEVICE pages are not supported yet. So skip those pages in
> MIGRATE_VMA_SELECT_SYSTEM case to save useless effort.
> 

https://lkml.kernel.org/r/20220531155629.20057-4-alex.sierra@amd.com
just made similar-but-different changes here.  Please review those.

Normally I'm merge your fixlet ahead of the larger changes and redo
Alex's patchset.  Because Alex's larger patchset might never get
mainlined, so your fixlet would then get lost.

But in this case, your fixlet doesn't seem important enough to be
churning things around in that way?

> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -157,6 +157,11 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  				goto next;
>  			}
>  			page = vm_normal_page(migrate->vma, addr, pte);
> +			/*
> +			 * Other types of ZONE_DEVICE page are not supported.
> +			 */
> +			if (page && is_zone_device_page(page))
> +				goto next;
>  			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
>  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>  		}

