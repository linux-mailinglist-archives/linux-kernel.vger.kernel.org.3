Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB87050972A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384658AbiDUGLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384641AbiDUGLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:11:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16046E0BE;
        Wed, 20 Apr 2022 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dbk1o55nyJG0iTgcHKzQ8jtanwMp7QlgPddqCfzuaRg=; b=vk9KsWteso4ZAUPkv0ulL0D2HB
        lIMgMwnQ1ff36xfrTtJPqcf2K22f8xeUgKb0dDyJFm5eD/nhYJCQvISyj8o+CY/4IxugYXPeOaOiX
        JWXhNDgF3qfT0wiJM8i3MMXtg4OWhe4XKUqqr7C9Qrl1lGwvDGTZ7HgRyoj+h92WMdMaYLN5huxUI
        ydIFKeAeKbVT8CFvV6y1r4DbvXpcDGuCiRH9k/ZtJET0GWuoYL9nlNHBWh5G7rYDULi2dy+DDhoR5
        VtlTCJui1Ojq+5IbrDYZ1HTSHbAEOnjJ6NQQEP1cLpqV2ZWyz2uaZ5VVTUGEARiJKJsTT00kq3dVf
        QN6rgD7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhPzJ-00BdNE-Gx; Thu, 21 Apr 2022 06:08:21 +0000
Date:   Wed, 20 Apr 2022 23:08:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 02/12] md/raid5: Refactor raid5_make_request loop
Message-ID: <YmD01SOLhOC5Ttvv@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-3-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:54:15PM -0600, Logan Gunthorpe wrote:
> Break immediately if raid5_get_active_stripe() returns NULL and deindent
> the rest of the loop. Annotate this check with an unlikely().
> 
> This makes the code easier to read and reduces the indentation level.
> 
> No functional changes intended.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
