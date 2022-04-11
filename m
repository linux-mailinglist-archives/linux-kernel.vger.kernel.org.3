Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8454FBFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347559AbiDKO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347547AbiDKO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:57:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6296167F7;
        Mon, 11 Apr 2022 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tyW8OjGHVsmy+4/pM+unxwF6ndD9L4IorupExZYMsoM=; b=mJVQPCF4DdjMPE9i4Ff8tniU8Y
        jD1nadxvHSMVFxH9OzPSkihbfM+E9Erku6wdyZwZOVurmjAXDkO1viQNwAiAZLpu1Vrv0tgzfJyJu
        dOiuC8GnSO1GeVM+7Wn8qlNdugBC8alqZ/w/tlewhIZTtEx5gNdvKxbw6HCZaeDlG+pk7GJWznKd7
        Gdyon5Nk+lzhwo7qP5vysjqft7Zogjke621Kw16we20NQmDRWRYTDwHmwtUZTfEsO8SkJOAEttkTz
        sOZ79i0DafUmImsxSBE7FSXfioIm597BLKHtAKAfAt2kDjTPVtrs0boB5wQOYWzummUorSWQP39vf
        +TcCW22w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndvRg-009S79-Qb; Mon, 11 Apr 2022 14:55:12 +0000
Date:   Mon, 11 Apr 2022 07:55:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zixuan Fu <r33s3n6@gmail.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] fs: xfs: fix possible NULL pointer dereference in
 xfs_rw_bdev()
Message-ID: <YlRBULlBDO7LnbVi@infradead.org>
References: <20220411113145.797121-1-r33s3n6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411113145.797121-1-r33s3n6@gmail.com>
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

On Mon, Apr 11, 2022 at 07:31:45PM +0800, Zixuan Fu wrote:
> In our fault-injection testing, bio_alloc() may fail with low memory and
> return NULL.

Well, in that case your fault injection seems to be completely broken.
Please take a closer look at how bio_alloc is implemented and
documented.
