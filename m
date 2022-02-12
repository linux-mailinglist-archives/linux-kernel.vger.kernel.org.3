Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4284B3285
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 02:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiBLBta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 20:49:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBLBt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 20:49:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE1D99
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 17:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ioyl46v/RncsoetIf9/GZiz5iMAc8fsJjCsfw/rRoqs=; b=tCQwBYQswc/aiVmvIQQ/dGaf5I
        fTMc2ARQ3Iu1urMPU0Ai1AmqGnM7WqS66CpjqV/3gwqULlA8jw1UbfsO+JdgRuVMQKJZ+JWj7RZ+g
        ogVheOaRImtrC+02f0BA4WnqN4bwc3SOP9Az6D+cmvSz4BuvKLhxeTGVlpwyLV3NsrPgUDHzmy6UF
        Bb3Drind7CmDXOOUtL5vdYFNRxbY2FYOAq5Sl3xAb6tqIEPnVbyC5uQgPSESzNpTLv66Tq6OoDJ9u
        z5+RL2wWAfao0cQq0iSKYrmfVRJefu3ywmOdbF2LfoN+ldFTbdPEv22Sn1B96BMIWt3iHyPSBXhXa
        2rm5379g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIhXN-00Atng-BT; Sat, 12 Feb 2022 01:49:21 +0000
Date:   Sat, 12 Feb 2022 01:49:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/75] mm/vmscan: Turn page_check_dirty_writeback() into
 folio_check_dirty_writeback()
Message-ID: <YgcSIaDdPmhf/OZa@casper.infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-35-willy@infradead.org>
 <YgDPmt0M1BZCCrFn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgDPmt0M1BZCCrFn@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 11:51:54PM -0800, Christoph Hellwig wrote:
> > -	mapping = page_mapping(page);
> > +	mapping = folio_mapping(folio);
> >  	if (mapping && mapping->a_ops->is_dirty_writeback)
> > -		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
> > +		mapping->a_ops->is_dirty_writeback(&folio->page, dirty, writeback);
> 
> This adds an overly long line.

Yeah, I'm planning on taking care of it in 5.19 by switching
is_dirty_writeback() to take a folio.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
