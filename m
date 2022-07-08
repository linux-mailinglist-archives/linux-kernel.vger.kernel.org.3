Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3E56B40B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiGHIEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbiGHIEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:04:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F988048A;
        Fri,  8 Jul 2022 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rmp5G6vHPz8jBiOD5JA28ORVQFrjzvX/1JW4d9qp04s=; b=LAlSn1iqreBWIix6My/aDS6Q/L
        HR4U2riupSczgF0sIB8Q8jo7HKYnDmfAo0lHO+kiuXXNdjsVmaKykHg/akDHYJaXQ1oUPjXbV//3T
        phwsavr1Ko39mwTfHhQ8a1ZBLs++x77pebkPj/qPsVSWz8wYEWV3+1nKbsJSnOfgLJOG9Fwqivf1e
        ALxw5RK7DfKDEKZj/vdx7SWT5pgyzF4qXxjtjTw12dK6OyPMRClSifdf5i5L1b9SSH36zvGT7I0sJ
        56Urr9rBTo+UpLk8LmgltvF2qQt1SjdYcIvc2206PjLP47kpdTavNbal65G8081FrtnFAe5OTUmWx
        lWhIcBrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9iyi-002MH3-AR; Fri, 08 Jul 2022 08:04:44 +0000
Date:   Fri, 8 Jul 2022 01:04:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/20] block, blksnap: snapshot image block device
Message-ID: <YsflHHP9e0Sc79Wq@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-16-git-send-email-sergei.shtepa@veeam.com>
 <YsWKhjDV18DeyEZ8@infradead.org>
 <49039d2b-e4bc-62a1-7b4a-a78001a2f430@veeam.com>
 <YscW1Byo0PQq5C84@infradead.org>
 <f68a45b1-c986-bc77-d956-e6bafe821d52@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68a45b1-c986-bc77-d956-e6bafe821d52@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:58:25AM +0200, Sergei Shtepa wrote:
> There was a goal to use the kernel innovations whenever possible.
> Of course, it makes sense to return to bio based if it allows to
> achieve better performance. This is not a matter of principle.

In general blk-mq is designed for hardware drivers, while the
bio based interface is for stacking drivers.  There are some
exceptions: dm-mpath is a stacking blk-mq driver, but one that
just passes I/O through, and there is a bunch of hardware drivers
implemented as bio based ones, although I suspect most of them
would end up being improved by switching to blk-mq (or in most
case by just deleting them).
