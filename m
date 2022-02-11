Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D284B2E61
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353204AbiBKUY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:24:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiBKUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:24:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D9CF1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rJ8Rr0aYRoZgo11H3udzzloosGSyeuau76fk78CV/RA=; b=wNPAqI3K7RAjqsj5l0aMEIJ0vR
        U3J4N4JAXSeKdLrEW5MhTEY39aG49n+C/LWkVSRnefcdVJtt33S7MpUNZkc8ESl525YyRg1jVZi/o
        j25X8oLWL+iqhjeBIDIz/fDOiWsQt+MAQCG8p8YgitFcT/tAAcF1JqfcrJDUhn/ky1g1ZBr1webPC
        c8zAIxAa6KyS49gOAhKhFqS8fFQxxHYlh0zMhx2PX6gD8JfJkxvj06Ctjp9KYOqf5ZjOii49JZGmX
        l0eRaLNFG4EEMHxMiouss/0OIRqAhTxzbVRqNiPFwq6tdhgfzoLU5lsE+IuWUnzVfc8UOxiY0a/fy
        uTc11xOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIcSt-00Ai75-Rp; Fri, 11 Feb 2022 20:24:23 +0000
Date:   Fri, 11 Feb 2022 20:24:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/75] mm: Add lru_to_folio()
Message-ID: <YgbF9/RCoZdnYe2j@casper.infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-32-willy@infradead.org>
 <YgDPLh6l2n47DpLE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgDPLh6l2n47DpLE@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 11:50:06PM -0800, Christoph Hellwig wrote:
> On Fri, Feb 04, 2022 at 07:58:08PM +0000, Matthew Wilcox (Oracle) wrote:
> > Since page->lru occupies the same bytes as compound_head, any page
> > on the LRU list must be a folio.
> 
> Any reason to not turn this into an inline function?

Good idea.  Done.
