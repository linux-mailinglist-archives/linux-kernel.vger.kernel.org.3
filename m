Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBF4E6F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355619AbiCYIrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiCYIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:47:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B309CA0C5;
        Fri, 25 Mar 2022 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T7pdbWvLAdj2T/2YUhcrDdhOefAmuEMMDdJwIQjsm7U=; b=z1SY1fpL+fTJ3B9r7dG+L5rr0l
        F/IMZPAr3TfYiog9TO4Db0kDa1wqsWcsO0pPm6WE/jPy8RSHibUYQ+ZdS5W5Vj9AqT1J4CIgRxium
        yyi3ZzrOmu+znQGg+NfhOoP6NygOfLaZ15A0Ukp9VzHaYo2YvxKA/6o3WkxF4Ap1nNAkf4lsquekD
        HiBCw8y+BSxeM1RIhzVlH7wOFkwyKcBJp6DkhX4UuRVgODwwcFdNfeS0mfufAoWrQF2XihDK+m4hq
        pW3/sYgMrw9yMmot8t57tFoBuTUhB4sT7m7Rx+U7r/xjjq2K/J6yve7d0794CI9Db19jqe26klZeF
        N52F4UDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXfa9-001SCK-NK; Fri, 25 Mar 2022 08:46:05 +0000
Date:   Fri, 25 Mar 2022 01:46:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, mpatocka@redhat.com, snitzer@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 2/3] block: factor out common code for part_stat_show()
 and diskstats_show()
Message-ID: <Yj2BTUIEooYX/IaA@infradead.org>
References: <20220317112653.1019490-1-yukuai3@huawei.com>
 <20220317112653.1019490-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317112653.1019490-3-yukuai3@huawei.com>
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

On Thu, Mar 17, 2022 at 07:26:52PM +0800, Yu Kuai wrote:
> part_stat_show() and diskstats_show() are very similar, just factor out
> common code.

Well, it doesn't really "factor" much, but creates a big and pretty
unmaintainble macro.  I don't really see the benefit here.
