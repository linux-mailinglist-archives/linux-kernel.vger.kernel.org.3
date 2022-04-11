Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889EE4FBB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbiDKLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiDKLx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:53:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9F53150B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649677905; x=1681213905;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+dgU86UwUCyAYn8649X0AQlN4MKbtuA/88ovTvxs994=;
  b=PdGArVJzvcyKp0ypUDxpzW7KHAmfmWtZSEd/UWIRLt/BLPGGTtUD2c5S
   78SBPeMN3+CJDUV+EdjN7yJQTrfG/Bedo2uc+inRCj3uA9WeTMKnP+4Xa
   Mi9ns2gk3WBcro9GaSzlxxd2eaCvSKjEYf7HXeoTl+oKXxLVjYG+KZVDg
   2VBAIAY0oINffuohzdD2sEqczffbP+3tEroNpIbtMKiCVuG9+qdD7KT05
   2CNjWQYaBIJSxt9BRx0gKBZPlHPDgGwEDZEJGuOaumRNhULo01RvSQ8Ag
   kL1a5jp+c+sN3hIn7opBA1asVF/kPu28uNr0oWCXx38tiQhi6s4yOp3JJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="260942918"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="260942918"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:50:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="551106292"
Received: from leichu-mobl1.ccr.corp.intel.com ([10.254.213.5])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:50:45 -0700
Message-ID: <4b7923585e07b0238545ebb997af92eeadcdaf78.camel@intel.com>
Subject: Re: [PATCH v2 1/9] mm/vmscan: add a comment about MADV_FREE pages
 check in folio_check_dirty_writeback
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, hch@infradead.org, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Apr 2022 19:50:42 +0800
In-Reply-To: <20220409093500.10329-2-linmiaohe@huawei.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
         <20220409093500.10329-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-09 at 17:34 +0800, Miaohe Lin wrote:
> The MADV_FREE pages check in folio_check_dirty_writeback is a bit hard to
> follow. Add a comment to make the code clear.
> 
> Suggested-by: Huang, Ying <ying.huang@intel.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c77d5052f230..4a76be47bed1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1436,6 +1436,9 @@ static void folio_check_dirty_writeback(struct folio
> *folio,
>         /*
>          * Anonymous pages are not handled by flushers and must be written
>          * from reclaim context. Do not stall reclaim based on them
> +        * MADV_FREE anonymous pages are put into inactive file list too.
> +        * They could be mistakenly treated as file lru. So further anon
> +        * test is needed.
>          */

How about something as follows,

	/*
         * Anonymous pages (including MADV_FREE ones) are not handled
by	 * flushers and must be written from reclaim context. Do not stall
	 * reclaim based on them
	 */.

Best Regards,
Huang, Ying

>         if (!folio_is_file_lru(folio) ||
>             (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {


