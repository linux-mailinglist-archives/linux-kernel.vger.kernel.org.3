Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A24FF01D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiDMGuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiDMGuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:50:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9FE2C676
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649832466; x=1681368466;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=XhEjKmrtLUPMf9LLvjO1S6Dih4fMyLMUlExLoCSKsT8=;
  b=MlB2ZPUh6BTV9MBkWVYT+0gTHj2WSEDF3kzjND3/DShR5lLq5oqPd9bY
   7EIJbKYh2yzaq5D9zpDgKpMlxbI1n25Gt2Dy8GoPtitzDaBlHx6Jibq+B
   Mwy96JMCtw1++JXOwtVoFs2GFLU7cF4Z2wM4rfST10v6TVx6q2osWX1E/
   kUq6ef5YY6VD2QKm2grTkyzolIAUs1lk2o/x4jOz87iHIoQv80I20QAnd
   z0sKr5ZtWqIgILk6ARyfQTWJ5vwz/ZCh8MtbB1rL5cA2JL4oyFc427hR3
   9GWKLISx5OTz0ZRUBXX4hrSGPdEx0UwKtRoVW6Kr4h2sQEy31o88fHpd6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="325496973"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="325496973"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="700133137"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2022 23:47:27 -0700
Date:   Wed, 13 Apr 2022 14:47:17 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v5 02/13] mm: Introduce memfile_notifier
Message-ID: <20220413064717.GB10041@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-3-chao.p.peng@linux.intel.com>
 <20220412143654.6313-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412143654.6313-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:36:54PM +0800, Hillf Danton wrote:
> On Thu, 10 Mar 2022 22:09:00 +0800 Chao Peng wrote:
> > +
> > +void memfile_register_backing_store(struct memfile_backing_store *bs)
> > +{
> > +	BUG_ON(!bs || !bs->get_notifier_list);
> > +
> > +	list_add_tail(&bs->list, &backing_store_list);
> > +}
> > +
> > +void memfile_unregister_backing_store(struct memfile_backing_store *bs)
> > +{
> > +	list_del(&bs->list);
> > +}
> > +
> > +static int memfile_get_notifier_info(struct inode *inode,
> 
> Nit, s/get/lookup/

Thanks.

> 
> > +				     struct memfile_notifier_list **list,
> > +				     struct memfile_pfn_ops **ops)
> > +{
> > +	struct memfile_backing_store *bs, *iter;
> > +	struct memfile_notifier_list *tmp;
> > +
> > +	list_for_each_entry_safe(bs, iter, &backing_store_list, list) {
> 
> Wonder what serializes list walk with list del and add above.

Yes, this needs locking if we want to support backing stores as modules,
as Sean pointed out, at this time this is not quite meaningful so I will
remove unregister also the register should be done at kernel init time
so the walk here is actually on a readonly list.

Thanks,
Chao

> 
> > +		tmp = bs->get_notifier_list(inode);
> > +		if (tmp) {
> > +			*list = tmp;
> > +			if (ops)
> > +				*ops = &bs->pfn_ops;
> > +			return 0;
> > +		}
> > +	}
> > +	return -EOPNOTSUPP;
> > +}
