Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB574F8DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiDHGF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiDHGFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:05:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1734641;
        Thu,  7 Apr 2022 23:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N0WCejp+v+kyXa7cm3NCWrsAo5fYHCElP+vP7DGqpkU=; b=hNcKPuqRNNbmPcChDNCCWTTrgS
        a34qrQmpXbirui9gVV1SrlYppFQpXwSJxzHPeu9ekJBzyqnp1DtqMKLgC4lFdc9daWW9jGvG2CiqV
        a7gmPwDv5LVEc4YMdRLh237xnQOZggoe4awfIcDdx96GyrYxP7BSta38ZxY5YrjWeG43WvH5Q4Q/v
        cJVQIqXKTDp/APn41qpqFnHT0tuh9G3xuGLTXHkMDY1lLaJOY7kn/+QGA64fsq29AXgO6DVJPxJUB
        /WGprhCkCaE9mYs2xI5YIihYciQf5xV+8dzGWZyg1mKbmZquNkoM0rLF6US0e57A+cN18EYPWcWbl
        Ujj4Jg+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nchin-00FE15-UP; Fri, 08 Apr 2022 06:03:49 +0000
Date:   Thu, 7 Apr 2022 23:03:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>, Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v1 4/8] md/raid5: Make common label for schedule/retry in
 raid5_make_request()
Message-ID: <Yk/QRWBOUhglpFn6@infradead.org>
References: <20220407164511.8472-1-logang@deltatee.com>
 <20220407164511.8472-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407164511.8472-5-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:45:07AM -0600, Logan Gunthorpe wrote:
> Cleanup the code to make a common label for the schedule,
> prepare_to_wait() and retry path. This drops the do_prepare boolean.
> 
> This requires moveing the prepare_to_wait() above the
> read_seqcount_begin() call on the retry path. However there's no
> appearant requirement for ordering between these two calls.
> 
> This should hopefully be easier to read rather than following the
> extra do_prepare boolean, but it will also be used in a subsequent
> patch to add more code common to all schedule() calls.

Hm.  Maybe it is marginally better, but I always hate gotos inside
of loop bodys.  What prevents us from factoring most of the loop
body into a helper function?
