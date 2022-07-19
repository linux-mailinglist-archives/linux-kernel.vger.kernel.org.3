Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA53157A3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbiGSPwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbiGSPwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:52:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D470B5F50
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+h0WoIM0GD65cK906eJ1giltlZaSU/VsCeCwldoHsOg=; b=qAXQMW8EOeD/uqldsIJVJlIcGm
        t626hE0k0nFaCJq44GByF/8jtj/QxuoThGeKDA00ZfPpRpUPTphNj0G2Vp06ec0ahVSOd1z68DEsY
        Ww22F3HI+MtlLAQ/LLXocnSWCs0iHEVtLvPhHfSDeFSnqyRPZj1pm+sRIbii6MMs1DTZ+ftc8tDbo
        4FzvuMdXqcbL/Qi7/bcB5p125RMJh7huddmA0BtgRMyggCpybRyGScoxeqzeC7Har7ENHFfiENIdh
        3/2WZPGxysuW7KHpSGeNjDHKkkoM6lyMWBD53lCSapWhedYLFIwyBIiWBHdxjdyyqmclH4btl/VCG
        ilB6t61w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDpVq-00AGSF-Od; Tue, 19 Jul 2022 15:51:54 +0000
Date:   Tue, 19 Jul 2022 08:51:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keir Fraser <keirf@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <YtbTGjRw65QEKkQA@infradead.org>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org>
 <YtbRwO40CmIRWOUR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbRwO40CmIRWOUR@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:46:08PM +0000, Keir Fraser wrote:
> However, if the general idea at least is acceptable, would the
> implementation be acceptable if I add an explicit API for this to the
> DMA subsystem, and hide the detail there?

I don't think so.  The right thing to key off is
VIRTIO_F_ACCESS_PLATFORM, which really should be set in any modern
virtio device after all the problems we had with the lack of it.

> Or a completely different approach would be to revert the patch
> e41b1355508d which clears VIRTIO_F_ACCESS_PLATFORM in the balloon
> driver. MST: That's back in your court, as it's your patch!

Which also means this needs to be addresses, but I don't think a
simple revert is enough.
