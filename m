Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAA85927A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiHOB7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiHOB7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:59:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A84612ABC
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660528773; x=1692064773;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=kA7lDKgziz+W9ciW3E//tMKB+dBOyRW8yX0jMyo2XGo=;
  b=bYr3LvQ8Ib3mMfEWtXfO29B1m33aDSLq6iVc/O4HwoOuaaYf69N51Qp3
   aASs2j0c2MjAZmVxn6kOMKLbRRPPwXZFdz3dEorr0RUmj78FdobNalgVw
   Pxa+MsJiqbDvqeqK/BnPEBiCkL+hWBsckDo4knptVAvf+dFiAQN1hTFzL
   92iwLR16cdhHQlZnP2u7oBZ71724TSEFBuIxq1aW/orlbQHhawhNURQvL
   TszQM7/CVfMtTNgK3H3cHMI6S93yc9JgU+GcJTWI4iRfTeLbQhLEybbWO
   nt/20j2LWFUdkythSO1ebVQlx1tiKizEawidVns4tNrkSVIH0R2Eu/bfW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="289441331"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="289441331"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:59:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="582716835"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:59:30 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <david@redhat.com>,
        <linmiaohe@huawei.com>, <songmuchun@bytedance.com>,
        <naoya.horiguchi@linux.dev>, <alex.sierra@amd.com>
Subject: Re: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220815010349.432313-1-haiyue.wang@intel.com>
        <20220815010349.432313-2-haiyue.wang@intel.com>
Date:   Mon, 15 Aug 2022 09:59:27 +0800
In-Reply-To: <20220815010349.432313-2-haiyue.wang@intel.com> (Haiyue Wang's
        message of "Mon, 15 Aug 2022 09:03:48 +0800")
Message-ID: <878rnqe074.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiyue Wang <haiyue.wang@intel.com> writes:

> Not all huge page APIs support FOLL_GET option, so the __NR_move_pages

move_pages() is a syscall, so you can just call it move_pages(), or
move_pages() syscall.

> will fail to get the page node information for huge page.
                                                 ~~~~~~~~~
some huge pages?

> This is an temporary solution to mitigate the racing fix.

Why is it "racing fix"?  This isn't a race condition fix.

Best Regards,
Huang, Ying

> After supporting follow huge page by FOLL_GET is done, this fix can be
> reverted safely.
>
> Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array racing with memory offline")
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>

[snip]
