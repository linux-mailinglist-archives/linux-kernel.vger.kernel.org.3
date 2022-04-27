Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7AD5110EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357998AbiD0GNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357994AbiD0GNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:13:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F992CC8A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651039830; x=1682575830;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Xsmzpfs2gKjq0TcuQXIkZffXbq8rph1B7NCGu2V/ac=;
  b=lIfqb/XmiwzsRzZ5PQtSmCUNfUq99dfOOJq5r0a8C0O8YmGw8YENulay
   IdehNYqs3K0H868PeJRfQtiU049fZ7y/3NQakRqkYsPFgQICXJqWjmme4
   feC0k8gKPlotBHUIPVW7ZtsGt5jEGBJXfd6MpJzymyMDPl1lmF6wzPJpw
   OFmZXzxqUCqV9JI6cu0YJIWG/4dLB+2whRro+6HFEvbwDO5Q8u1EBrn93
   a8kZm/LA4uEgzlCI47/j+22+Ag/VUoGwsxXWrwXNbEOIFUQFcm2LnN8Kk
   /DvqJdLXNk6qBrYkxNfyQeeT0TRSgk4ah0g3AmECckcHOdrqVgKpH6wlI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265635519"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265635519"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:10:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580400044"
Received: from kang1-mobl1.ccr.corp.intel.com ([10.254.212.35])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:10:27 -0700
Message-ID: <75adcfe33483d5e30855226b6efcd8dcd2f52925.camel@intel.com>
Subject: Re: [PATCH v3 3/6] mm/vmscan: activate swap-backed executable
 folios after first usage
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Joonsoo Kim <js1304@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Hellwig <hch@lst.de>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Apr 2022 14:10:25 +0800
In-Reply-To: <CAAmzW4NV9_LiGsN3Qn3uv19ZLFn9zZ3hdLFy1HOgbec5Or0Ccw@mail.gmail.com>
References: <20220425111232.23182-1-linmiaohe@huawei.com>
         <20220425111232.23182-4-linmiaohe@huawei.com>
         <20220425140711.0c1898862fc817135bbbc56e@linux-foundation.org>
         <6b74e6f3799032d4f12bae0d97a453dc85d03028.camel@intel.com>
         <5a108252-4eb8-e353-da3d-a96b8799fadf@huawei.com>
         <CAAmzW4NV9_LiGsN3Qn3uv19ZLFn9zZ3hdLFy1HOgbec5Or0Ccw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-27 at 13:08 +0900, Joonsoo Kim wrote:
> Hello,
> 
> 2022년 4월 26일 (화) 오후 3:58, Miaohe Lin <linmiaohe@huawei.com>님이 작성:
> > 
> > On 2022/4/26 10:02, ying.huang@intel.com wrote:
> > > On Mon, 2022-04-25 at 14:07 -0700, Andrew Morton wrote:
> > > > On Mon, 25 Apr 2022 19:12:29 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> > > > 
> > > > > We should activate swap-backed executable folios (e.g. tmpfs) after first
> > > > > usage so that executable code gets yet better chance to stay in memory.
> 
> Missing activation for swap-backed executable page is the intended operation.
> So, I disagree with this patch until some numbers are provided.
> See following discussion.
> 
> https://lore.kernel.org/all/20200316161208.GB67986@cmpxchg.org/T/#u

Thanks for your pointer.  Now I understood more about this.  I agree to
keep the original behavior unless we can prove the change with numbers.

Best Regards,
Huang, Ying


