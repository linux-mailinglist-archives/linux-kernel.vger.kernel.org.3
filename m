Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F475774D4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 08:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiGQGzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 02:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiGQGzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 02:55:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDB81705E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 23:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X4YZxvL1EUK5zhn+ks8Yss/ZUVWfxwbXjHz41gAwFVw=; b=JX8CEv3QH/31axHpg2Wm9uMOla
        FHVr5hLJ6aBBuPRYA0tMoC3JboIa0n7Am8wYtpolZ28OEyc1+FP+vSZgixrJC1z9V7uAF7VP65Nqn
        6oBkQmkl8WCnf/HCW9aagifKhsFRxcmMwY/qVtjRyxAaVP52XSWpGzKuPOiDo9dS2IafW2nH0hPz4
        WrCqRJpXQWtkpwv925R6W1McIWExRNgrysnz4IIXAk//Q6Sa1GbA3yO5r7RkwCe8OO2ogrI5h8VDb
        gdCGUlF5CPaV1q0E2E6dCiUIRZlnfwBqYC721FOnGzRe/7O/gQhyq7vNAWXddShgxx0Uz6KDFr3Y5
        H+GpUeKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCyBU-005PCY-Gr; Sun, 17 Jul 2022 06:55:20 +0000
Date:   Sat, 16 Jul 2022 23:55:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] f2fs: Use memcpy_page() in f2fs_copy_page()
Message-ID: <YtOyWOKFN9ramUyb@infradead.org>
References: <20220716204353.22049-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716204353.22049-1-fmdefrancesco@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 10:43:53PM +0200, Fabio M. De Francesco wrote:
>  static inline void f2fs_copy_page(struct page *src, struct page *dst)
>  {
> -	char *src_kaddr = kmap(src);
> -	char *dst_kaddr = kmap(dst);
>  
> -	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
> -	kunmap(dst);
> -	kunmap(src);
> +	memcpy_page(dst, 0, src, 0, PAGE_SIZE);

Please remove f2fs_copy_page entirely and open code this in the only
caller.
