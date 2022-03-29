Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5E04EAF69
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiC2Omf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiC2Omd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:42:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1A32054;
        Tue, 29 Mar 2022 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zIKf6bif4RDbPYlDQUKM62ySUzavLcyc+3Q3rzv+J1c=; b=RO/j3CkUCQ/izmSyUmEJizd8Cf
        1Cgjr16QuOi8PAcsvNFgvTAu/GMs0TOEQWmrRs3tEy9Q2S5DEOTPTwd65cbdgKT1uJTcf1o/g0zvd
        cf7icO08tgTbRcqb7gVyl30Tp45dbXdovs1ZWZ8Kl8n9gRKyc6I5+IowA7M49M01bwp0jcQ9isD4V
        CXPTgVlBRVZH6mxgF3k7BDI9vM5H/qF2Qag3p7qq3aJ/SJxoS4OwiHjSSkxSU9mJoa0D8scqwOVbJ
        jCCFvYCpGDUwLDNsamfL/4OciTy65HFyn8pUmqpe3twMdnzQO8Kcynadh39xFz4XL1nVDycn5eT12
        7CkfaYHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZD1Z-00CWBB-1m; Tue, 29 Mar 2022 14:40:45 +0000
Date:   Tue, 29 Mar 2022 07:40:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai3@huawei.com>,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next RFC 2/6] block: refactor to split bio thoroughly
Message-ID: <YkMabVKr+7Mg53E1@infradead.org>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-3-yukuai3@huawei.com>
 <YkMKgwsZ3K8dRVbX@infradead.org>
 <e46db33f-84a6-6d23-9be2-7429fec71046@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e46db33f-84a6-6d23-9be2-7429fec71046@kernel.dk>
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

On Tue, Mar 29, 2022 at 08:35:29AM -0600, Jens Axboe wrote:
> > But more importantly why does your use case even have splits that get
> > submitted together?  Is this a case of Linus' stupidly low default
> > max_sectors when the hardware supports more, or is the hardware limited
> > to a low number of sectors per request?  Or do we hit another reason
> > for the split?
> 
> See the posted use case, it's running 512kb ios on a 128kb device.

That is an awfully low limit these days.  I'm really not sure we should
optimize the block layer for that.
