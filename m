Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC957445B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGNFMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiGNFMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:12:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF4DA4;
        Wed, 13 Jul 2022 22:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LO28MeHGd3VlejoddzjXnjPgM61v02soZCtoYcsp59o=; b=iiakchctaJplEbbHCV8rzevk1n
        /gKfepGRT2hdaskDC5Q17mTD4iBmWULLPGgmEAbtdwjLJDbbaPwoRRtq+34bA4ag72vdGYJAMptqK
        Ekw7KQw35EjZOaWdhgNaXO3YjaosRsmTd7sDTDzGq9MD4Ro0d1Zfyxc5sp1JT04a5Q+2t2TxH8hKp
        febvYHBD1wvAA4uc83+E9twcxFCy6wFrRqJSczLG1SH09LuagBKg+Ufw27gfkeQsf5C5Uh8kRHQzR
        zVOMqtbGqNw93ZdRI5mk/EmHycKvHqoavVZEucHMFXFoarLFKYlS77YAWiDM1ovcA2SIBwnJfk7LZ
        /pMC+ztQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBr8t-00Axwc-09; Thu, 14 Jul 2022 05:12:03 +0000
Date:   Wed, 13 Jul 2022 22:12:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/20] block, blk_filter: enable block device filters
Message-ID: <Ys+louzW6t13oUpD@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
 <YsWHHcCfSVFklh4M@infradead.org>
 <ff78a1ee-8bc5-6e8e-040f-978cd07eacfe@veeam.com>
 <YscXTGXumE5Ust15@infradead.org>
 <aec88137-070e-7c1d-215f-86a1e6d4b10a@veeam.com>
 <Ys6y1AYTl8r/i3UX@infradead.org>
 <51e3fc9e-5b46-ab23-bbf8-5d0ad9dada29@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e3fc9e-5b46-ab23-bbf8-5d0ad9dada29@veeam.com>
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

On Wed, Jul 13, 2022 at 03:47:23PM +0200, Sergei Shtepa wrote:
> >> 2. Can the filter sleep or postpone bio processing to the worker thread?
> > I think all of te above is fine, just for normal submit_bio based
> > drivers.
>  
> Good. But I'm starting to think that for request-based block devices,
> filtering should be different. I need to check it out.

As long as you filter in the submit_bio stack you handle both submit_bio
and request based (blk-mq) drivers.  So I don't think we hould need
to handle them any differently.

> I have a lot of work to do to improve the patch.

If you have any questions or want to get feedback on iterations not
ready to post feel free to ask me offlist.
