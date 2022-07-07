Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0205D56A222
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiGGMgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiGGMg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:36:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2524097;
        Thu,  7 Jul 2022 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QfuCQfWw0R4Q88qq2d57w+fLKWKJ84NLA20PhY0262o=; b=kAlWH5ohaNATSdC1GQ+NF2V6wa
        41jRRwvfAUbq1hdmSbrCRtXj4idHyrlgsPxys7tc+KTCasciNhdDEIKsBbCW14UzM/iYRju60W6e0
        3OLUH4f4PnHF+cmu1zdW62QPubeaen4F8Kl7rqUKw5LRgrwWsMPHT1T7yQTVuiEVYlWeDpsIDoJj3
        mkpS6nTh/BWVvMakjPk0qHKzhcmrpEfmunYvnRN+uhV/CL/ny6AFL92yCQ4rBL32t3aOf8iRQq3Tz
        mseVv320eJqzcAFoCs6bM7UQFtHD7ImIZPNFyVD00AghM9/jdDazuTrHjbX3y/cJJHP4bTjXQnxR7
        1UgM5z7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o9Qjt-0098gu-Mm;
        Thu, 07 Jul 2022 12:36:13 +0000
Date:   Thu, 7 Jul 2022 13:36:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/crash: allow multi-segment iterators
Message-ID: <YsbTPShbZDgHUJ7G@ZenIV>
References: <cover.1657172539.git.agordeev@linux.ibm.com>
 <613f63d652bb4fa6fb3d2bb38762de6bb066b35a.1657172539.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613f63d652bb4fa6fb3d2bb38762de6bb066b35a.1657172539.git.agordeev@linux.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 08:01:15AM +0200, Alexander Gordeev wrote:
> Rework copy_oldmem_page() to allow multi-segment iterators.
> Reuse existing iterate_iovec macro as is and only relevant
> bits from __iterate_and_advance macro.
> 
> Fixes: 49b11524d648 ("s390/crash: add missing iterator advance in copy_oldmem_page())
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

To be followed by duplication of every change ever done to those macros?
Hell, no.  Do it the same way it's done for that _copy_from_iter_flushcache()
thing - i.e. an ifdef in lib/iov_iter.c and no duplication of that forest of
macros.
