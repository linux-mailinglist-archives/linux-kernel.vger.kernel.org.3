Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D85A59E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiH3D0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiH3D02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:26:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0341D86FC5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sj2YAf+jcJpwZgorIhbu6IO4GDMZ2Kf9QmWmBPLXWvU=; b=kSS0ivJZA881DO1pPuT5Jep76P
        EKfzIVdydNx9TKycdzueqIPeCY0HoFzlgRsNay+JdDbP6aJR9v6uZRcrHYsL/tGbgzlOBbIWQp0mr
        p3vq0+rO67wFe3vR5/P8o75ACPROvcJh6G/vVmldTrPI8muBkZK3tyrDE2w232PN4adJC9oDtpE+6
        rJ2hh9pTqRjpTxTH9zYRfKO9L0prazTDkP9iZXlscM5s9RfjJu4WMzzrocBq5GUDQTcZVOfbTHPaB
        MvOKYqDkqbDfQ5pKDo+NxdR7VoZqFWGN9ebgS0H67O7L656skRPc650HDxz77sSloGFJkgAT/wr7M
        CEJP/64g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSrtI-003dkn-T1; Tue, 30 Aug 2022 03:26:16 +0000
Date:   Tue, 30 Aug 2022 04:26:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH 5/7] mm/hugetlb: convert hugetlb_delete_from_page_cache()
 to use folios
Message-ID: <Yw2DWCHlivGge03V@casper.infradead.org>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-6-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829230014.384722-6-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:00:12PM -0700, Sidhartha Kumar wrote:
>  static void hugetlb_delete_from_page_cache(struct page *page)
>  {
> -	ClearPageDirty(page);
> -	ClearPageUptodate(page);
> -	delete_from_page_cache(page);
> +	folio_clear_dirty(folio);
> +	folio_clear_uptodate(folio);
> +	filemap_remove_folio(folio);
>  }

Did you send the right version of this patch?  It doesn't look like it'll
compile.
