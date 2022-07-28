Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DEE5840C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiG1OOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiG1OOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:14:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5DB642F;
        Thu, 28 Jul 2022 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nXX/1YHq2TsMnhQqeM+NuFCn+OKgy8tv053unKPt3R0=; b=ta9JJEQZKGgBVxJI6tJt3dr2ds
        RUia5KN/UmAeshBO1MpbxTl2OlzB5QsePDR+VO08ajYNYaAqtXNSK9dtVNH/1u7FQnueNHt23qhyw
        fI51m09kIvOptLurZyTNCn+xlhD7PO6PyK3xMmjOo2zImS/UqF67N/3Sn8GZXsVZ9+MMVQ/IUwgl6
        JGFwbxKmKSDyrba/Bo+babp+ZqrjusLR9FjyROTgl24Wl1LMcUVJVBigsLEw+BUyjmq6PNxQwr2t5
        fwHvesz3WA+zCkZbbz5LUNZ4P7dmEl27V+52reX5HlbYlc3C5epK58ukerVUPYx+y9Zz8sAaviyXl
        7IkzOtpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oH4HU-00A2G2-Vs; Thu, 28 Jul 2022 14:14:28 +0000
Date:   Thu, 28 Jul 2022 07:14:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH 2/5] md/raid5: Make is_inactive_blocked() helper
Message-ID: <YuKZxFVaZp2AyQq1@infradead.org>
References: <20220727210600.120221-1-logang@deltatee.com>
 <20220727210600.120221-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727210600.120221-3-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 03:05:57PM -0600, Logan Gunthorpe wrote:
> +	int active = atomic_read(&conf->active_stripes);
> +
> +	if (list_empty(conf->inactive_list + hash))
> +		return false;
> +
> +	if (!test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state))
> +		return true;
> +
> +	return active < (conf->max_nr_stripes * 3 / 4);

Wy does this reed ->active_stripes without even knowing if that is
needed?  In fact I don't see the point of the local active variable
at all.
