Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C954EE76B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 06:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbiDAEsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 00:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiDAEsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 00:48:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84621017EB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+YeRyrIelAzlbv0mk7sknMueE1AFF77dV1ezjSpjf9M=; b=Jzo+Ql7PmZZzg7nbMNgS36Km8B
        rNxsS1ptqZ0SUy/718K1NPLLR/hkT0vxorgavG8Aodstw9jCrZxYGMX5V/xwLv5XNCs1FdFQBuosm
        ZJCigRKoASOHqDycPeS1jIXUoQtaETniiUa8Q/q3bS9juyXSjgd0oCZmjT2ytw8HPP945ZFoYqmdC
        hyVT80mvY/ip9Y/FmjvBIFYGp19meuX7gAc+9kfYSb080Ld0G0HZd35j4jvIdrYbzqK9fPlIU9Fbk
        1BzdKS2HyakUBOnWMMNDBQOXvgSGrH30AxhJCS0lO5+QLplp/v1XEwFULVNJ1k11n71mRBbtEHc1r
        C6gQpkdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1na9Az-004Tk9-PQ; Fri, 01 Apr 2022 04:46:21 +0000
Date:   Thu, 31 Mar 2022 21:46:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     hch@infradead.org, rpeterso@redhat.com, agruenba@redhat.com,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Cluster-devel] [PATCH] gfs2: Add check for mempool_alloc
Message-ID: <YkaDnfLS8T0HszoV@infradead.org>
References: <20220401033755.1892644-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401033755.1892644-1-jiasheng@iscas.ac.cn>
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

On Fri, Apr 01, 2022 at 11:37:55AM +0800, Jiasheng Jiang wrote:
> >> Fixes: e8c92ed76900 ("GFS2: Clean up log write code path")
> >> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > 
> > Please explain how it could fail to start with.
> 
> I think that for safety, the cost of redundant and harmless
> check is acceptable.
> Also, checking after allocation is a good program pattern.
> Therefore, it should be better to check it although it is
> hard to fail.

Please take a look at the implemetation and documentation of
mempool_alloc again.  Thewhole point of that function is that it will
not fail for allocations that can sleep.
