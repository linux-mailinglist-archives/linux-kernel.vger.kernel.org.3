Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D15850E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiG2N1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiG2N1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:27:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB1468DF4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eCHNh6LIA9gROqbDgmH+94ZUhQ9hP1NXx31IFuMdPWs=; b=YG0E8TX0Hjc5KOEydvltqdXoI7
        MxeSDaw5iUawZAp0Ro9zRcqvwAvICwC2vtcMbH+8AIw2zVvxJK42HEW1LFuwsZlhymKVgmvZ8e/z3
        7oChMqWHO6rmpbqlV05cTfb354oLhilwEaNI8JmfVxoicyfJp9zDI9smPAiZAMdj+owm5nsccPD+X
        bb+dvxcElbxtXB1y5qpV5NYEo1tChNpmhkRM4/6WmlkVg8nQdnJY6CBQD+c5bsJ/FLE0shF81dzvm
        1xpvAP2eWPoNh2oxeWJ2II4w/BLMWW0J0ewVIMjYA7xQ4aRAu7b2Bb3zgg9IsXjOsbK3mtUG/YOs4
        vJ2+Kw0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oHQ12-0059BM-RJ; Fri, 29 Jul 2022 13:26:56 +0000
Date:   Fri, 29 Jul 2022 06:26:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eunhee Rho <eunhee83.rho@samsung.com>
Cc:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v0] f2fs: allow direct read for zoned device
Message-ID: <YuPgIByYgc6WSPDE@infradead.org>
References: <CGME20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
 <20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 09:25:17AM +0900, Eunhee Rho wrote:
> For zoned devices, f2fs forbids direct IO and forces buffered IO
> to serialize write IOs. However, the constraint does not apply to
> read IOs.

Asymetric capabilitis will cause a whole lot of problems for us.  Can
we figure out why direct writes to zoned devices are not supported and
just fix that instead?
