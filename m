Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286C9536ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 07:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355788AbiE1FDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 01:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiE1FDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 01:03:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FB2C3D00;
        Fri, 27 May 2022 22:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nU2UQDrRrTNgZCGlx3+Juyg9gJKqa9hFvsLcatF4nYk=; b=HqAA4MktGO1WMudvYma9Q5OBoR
        WgN6YSaxtPq6Naw9oAM/KxoqZkaAB0g/rKEE5aSlqLTCiRokm7eYH+PU+AxrxvTIAZ+gLY10zgbzN
        x0iaC+BgxU2ZAqsRHsswWxy9XrcEsKHFH38ftS1MaXged/qeSavGaRzSbR4rAuR4X4nUgKxJPErG9
        Y9nNFyEWEkO3DFJrt1tTyZ75poO8I4sJtdOUu86PGLF6YHA49WPSztat8ddJ58nRfjZS9WhsCBJJS
        wU16/5hH37wJKBAdlbbOw063jkQ7LCrTPDG/jt68ZFrdHa55r99Z0dChsVNMNsm9AFKABdG0F69Q6
        FgnVpuFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuobW-001SZy-Fk; Sat, 28 May 2022 05:03:10 +0000
Date:   Fri, 27 May 2022 22:03:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] f2fs: add sysfs entry to avoid FUA
Message-ID: <YpGtDhV7V7gDk430@infradead.org>
References: <20220527205955.3251982-1-jaegeuk@kernel.org>
 <YpFDw3mQjN1LBd2j@gmail.com>
 <YpF1gPrQY3UFsgwC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpF1gPrQY3UFsgwC@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 06:06:08PM -0700, Jaegeuk Kim wrote:
> I think there's still some benefit to use FUA such as small chunk writes
> for checkpoint.

Did you measure if there is?  Because some SSDs basically implemented
FUA as an implied flush after the write, in which case it would not
really help there either (but also not hurt).

But as the previous two maintainers already said - this needs quirking
at the driver layer, not in the submitter.
