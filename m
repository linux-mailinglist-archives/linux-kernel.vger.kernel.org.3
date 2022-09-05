Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB05AD66B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiIEP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbiIEP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:26:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC22E9F7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uplnyYpk3INJufSvSlwxeNSTQlXrZkSXonYNwz6iYNM=; b=qNiIUbe9pcC2Mgcn0CDsgRJGJe
        MfJpPV+a7WqyQuY141JBCJ+S9C8TipGUk5/rFJXiVaoMHUv9276itWCyIuNcUwqIuDQ7cFvERRGiI
        uuscuHbk1bKFTLF7x3X7DKhlDno6T0Vv4XFXK2IfAaely1IqoZocr+lLK5VZ95ugzKZQBZBSRXAKz
        zDKFckrcQg9mAqlWZeiegQupTgdCsfguFYlKWIXOy+l+M7gFaLkBYAxy2YLzfSNPcQjt+NHR8bTP6
        w90QXIbM2SXgHp+ZerIUpawE/BXHs6BnV/kSwfk19kb3E99ICMcQjbeyenpszf6+Xhzv54cOs7k0T
        F5y9Q1tA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVDyr-009at3-47; Mon, 05 Sep 2022 15:25:45 +0000
Date:   Mon, 5 Sep 2022 16:25:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Cheng Li <lic121@chinatelecom.cn>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: use mem_map_offset instead of mem_map_next
Message-ID: <YxYU+XqR4wu4EHHY@casper.infradead.org>
References: <1662358159-22780-1-git-send-email-lic121@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662358159-22780-1-git-send-email-lic121@chinatelecom.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 06:09:19AM +0000, Cheng Li wrote:
> To handle discontiguity case, mem_map_next() has a parameter named
> `offset`. As a function caller, one would be confused why "get
> next entry" needs a parameter named "offset". The other drawback of
> mem_map_next() is that the callers must take care of the map between
> parameter "iter" and "offset", otherwise we may get an hole or
> duplication during iteration. So we use mem_map_offset instead of
> mem_map_next.

Per my previous email, use nth_page(), not mem_map_offset().
