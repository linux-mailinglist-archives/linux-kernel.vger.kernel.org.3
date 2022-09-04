Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703935AC696
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiIDVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDVPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:15:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AFE1F63E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XsVMlt5hm6DrJhRld1OYvrTBNBmsOauY0XUQEvP4qQk=; b=U00f1HZ1fphnydaMdTK3Bvd2P+
        y4veYWAISIY8EZF9zrLMhxxsm7mAe1XToDWjJW6R9TKnK+wbESAQvVYDkMjohZBrlYXP+MUe3aLfS
        VWWuNqtB+s+CZVKwBCkeqY6bwfxA4HF6CCBnuv6L/yFJK3H8V2j2rGEH3JxN05q+aWz+/lDcrh4gZ
        6IOLVSmgNPT6rnZrnSKH4nxcr1nydiQL19uuE6vscIOj6TjV13Hy7aT9JVjfGNmLRv3EhTaBgiBPv
        0OAPbpY2K377e//uCadaS4vFraHJyouODSRmnSKLl1XaAgsruX0OSclx5AnzVe29PsUpkL7u9AEtY
        rgHo763g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oUwxa-008we9-Ri; Sun, 04 Sep 2022 21:15:18 +0000
Date:   Sun, 4 Sep 2022 22:15:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Cheng Li <lic121@chinatelecom.cn>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use mem_map_offset instead of mem_map_next
Message-ID: <YxUVZpsmukNW5NyK@casper.infradead.org>
References: <1662300161-22049-1-git-send-email-lic121@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662300161-22049-1-git-send-email-lic121@chinatelecom.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 02:02:41PM +0000, Cheng Li wrote:
> To handle discontiguity case, mem_map_next() has a parameter named
> `offset`. As a function caller, one would be confused why "get
> next entry" needs a parameter named "offset". The other drawback of
> mem_map_next() is that the callers must take care of the map between
> parameter "iter" and "offset", otherwise we may get an hole or
> duplication during iteration. So we use mem_map_offset instead of
> mem_map_next.

I think we should go further and get rid of mem_map_offset().
nth_page() is now more efficient than mem_map_offset().
