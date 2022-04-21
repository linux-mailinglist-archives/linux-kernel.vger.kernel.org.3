Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CA509755
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347427AbiDUGRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384888AbiDUGRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:17:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F9760FA;
        Wed, 20 Apr 2022 23:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6wrGU8o71vWtNnk/kofBHxfJB1Q7EczXs0qoooO1IXc=; b=R6vTLyps/2RQ8i8deon6o5x28/
        Nmkg7WFrw37n9SlCLaWOeIDDmw6E1+C4K3RmmkitiEpn+xwJG/qpTOvCtzxDjQpE6on9WTzdmJc5L
        HMbaTy6Og2hq4F6wWGYEffCqCgzKwPgPS/nXS0ik9rDleUFR9ahHXMi8bC55PRrkSelxUXlNvh8Yf
        oX+yZ/lFv26B6e0zE2xtqCAWPRV0sMgN91hMEuxVFbQ0zeToW8DFX7B4+siLAThMDbhbKaNElpkO2
        WOQLRuvgTk5Kls0bv02Ovqtc+/L0PHdX7RONo2YNBI4njsw+USkXwqxZATbizv6ZS7kZWZh6igTGY
        Wut5pWhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQ5k-00BebM-6L; Thu, 21 Apr 2022 06:15:00 +0000
Date:   Wed, 20 Apr 2022 23:15:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 06/12] md/raid5: Drop the do_prepare flag in
 raid5_make_request()
Message-ID: <YmD2ZC2dJxz8F6/T@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-7-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:54:19PM -0600, Logan Gunthorpe wrote:
> prepare_to_wait() can be reasonably called after schedule instead of
> setting a flag and preparing in the next loop iteration.
> 
> This means that prepare_to_wait() will be called before
> read_seqcount_begin(), but there shouldn't be any reason that
> the order matters here. On the first iteration of the loop
> prepare_to_wait() is already called first.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

