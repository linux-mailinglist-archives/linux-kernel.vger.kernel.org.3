Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435CE57A2E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiGSPXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGSPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:23:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8124F564E7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c9bLWd1eIP+e4V5D1L4BG6lCv4UzYp1WNkQVrUUxNW0=; b=RMLFIG0AqZXLjeQwLqkcXNb0qJ
        X6tACYuh+4mKivWUps4p4RGwGu0Mgs8veAIrTkj2Ze4/1pQo18woBvGs9Ab4AI2sdOCg2lFCu0un6
        XiwkE8I3jERQ8TegAfLi3XSXK6QV3diM8bjGLUH71lcpa2dLyGW3ZVbWHNKBwZtt1Un4bx/kZvAS5
        Fb5FIjWiHAKlhGV/iUkidpojD1JnjeuE+5GRao5XmcnQbQUP+f6PGqWujTbGjFx2WfcZGopgxan9L
        N6+ZVaPUjPRMFf2VrzBe2cws5YOB9dChn2p3OZcNDucQnEpQOHKuGbem3FGHIj5n9WTdr4qftrhGw
        wdorwe4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDp4L-00A0JV-0I; Tue, 19 Jul 2022 15:23:29 +0000
Date:   Tue, 19 Jul 2022 08:23:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keir Fraser <keirf@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <YtbMcBw4l0LAFn9+@infradead.org>
References: <20220719100256.419780-1-keirf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719100256.419780-1-keirf@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:02:56AM +0000, Keir Fraser wrote:
> +#include <linux/swiotlb.h>

Drivers must never use this header.  We have a few pre-existing abuses
in the drm code, but they will go away.
