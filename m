Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B3853C523
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbiFCGnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiFCGnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:43:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3112C38BD7;
        Thu,  2 Jun 2022 23:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IUcPna+EySde5FQ/pymtri4xChWHHQ7giF64IAhaMA4=; b=a0RFnlADOnApturORJiYza6QIz
        OiQt3VI6t03MrRHa1xapufXjkKvAhWl8hzb1Nenk6eENKn13o7pCz2dOjrDR2MadA02MjoI8xpUTs
        7tcFejKRczPR3PInUIRRUz1gaGBUamgfDgge9i6sk8w8MC+2KvoGKE8gliBqpB7fVZk9gKCphUWD2
        RLPu2Y7qZEFqDHK5hdjxIwObUO799HGRwMYxpjuKlar6r8KV6hGSw906cHvQlWysigfjHD6QLMuwF
        tZAmltZCY02wyA3wemdMwaIAGObWHYsra29xeLVsgAMF7XrcCT8TT9rZH3vaVzMieNFgwFk7gxtdZ
        3jU6WW3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx11V-0064Pz-Hz; Fri, 03 Jun 2022 06:43:05 +0000
Date:   Thu, 2 Jun 2022 23:43:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v3 05/11] md/raid5-cache: Drop RCU usage of conf->log
Message-ID: <YpmteYBT71dYY7t0@infradead.org>
References: <20220602181818.50729-1-logang@deltatee.com>
 <20220602181818.50729-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602181818.50729-6-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 12:18:11PM -0600, Logan Gunthorpe wrote:
> The only place that uses RCU to access conf->log is in
> r5l_log_disk_error(). This function is mostly used in the IO path
> and once with mddev_lock() held in raid5_change_consistency_policy().
> 
> It is known that the IO will be suspended before the log is freed and
> r5l_log_exit() is called with the mddev_lock() held.
> 
> This should mean that conf->log can not be freed while the function is
> being called, so the RCU protection is not necessary. Drop the
> rcu_read_lock() as well as the synchronize_rcu() and
> rcu_assign_pointer() usage.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
