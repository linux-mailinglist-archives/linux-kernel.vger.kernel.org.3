Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736844D0438
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244230AbiCGQgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiCGQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:36:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214B8A6F1;
        Mon,  7 Mar 2022 08:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tEpagJj9t2o6OBo2LyfR78mC1PBCzGopqSpUCsiMZj8=; b=mgLq5vWcrbHbqiR1CIRlDBbC1g
        vM1ubvNcbK3M8PCoJWLMzo3gSOluj7/rCcw7pLHRPVO860CDISJ6STa1uly8hoktHdm2uPe1uDcFC
        3Ak/yIdl+4Bh6iy5AKiLZYxzj7fANOYl7ZFaZJDwOoj5FJpNHPg04sUzOqPo9IScToRtej51OxplV
        2jQLJv4FGmTSRL/SErTy/dFT8pFGBQ7Z1j+/b3flYSsmUbGbbsaymgQUSITK6kMIhElaugocayadJ
        BnU+2agxFd9yLoTqG4llKUBSA0FiOnGWX0R26bvNANdmvRHI/s1ucv8GvgwIlGuj9h/HXP2wGtT3F
        rcharuow==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRGKI-000r2h-Pq; Mon, 07 Mar 2022 16:35:14 +0000
Date:   Mon, 7 Mar 2022 08:35:14 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v3 1/4] mm: hugetlb: disable freeing vmemmap pages when
 struct page crosses page boundaries
Message-ID: <YiY0QkE+efo1hyda@bombadil.infradead.org>
References: <20220307130708.58771-1-songmuchun@bytedance.com>
 <20220307130708.58771-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307130708.58771-2-songmuchun@bytedance.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 09:07:05PM +0800, Muchun Song wrote:
> If the size of "struct page" is not the power of two and this
> feature is enabled, then the vmemmap pages of HugeTLB will be
> corrupted after remapping (panic is about to happen in theory).

Huh what? If a panic is possible best we prevent this in kconfig
all together. I'd instead just put some work into this instead of
adding all this run time hacks.

Can you try to add kconfig magic to detect if a PAGE_SIZE is PO2?

  Luis
