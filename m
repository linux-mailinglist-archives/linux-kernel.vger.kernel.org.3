Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83E4578940
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiGRSIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiGRSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:08:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06FA2F009;
        Mon, 18 Jul 2022 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658167725; x=1689703725;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nW6+aTOUp8V8dOJLuYT41htSmHJVh62MKwZHT7NcAAM=;
  b=mEEt+df+m/sWVL1z1gTl2DwgdWwgCggnet6xTnM4cwiUJv9rhgrclcKG
   B42A3EYmodKBh9sZ1LkggjiL8PswK69UpEj2Vq5zDsZmsAKseXWxnhcpx
   WyfH5vZcGsBlSfpm010cMvDoWTBSHi8VWVSpGjjPhdaYLJRxcUjfDM5DB
   jezT4GU4nJmT4tv+T1HHjwbU45dzO0eAo50ePYLg+yP/BKojYWq4hUc/L
   X8R02ruqn4SPhry4OrHd+z/0ajcnF2ftykekgu+maVd6JGKrrKqEQ1YH5
   fW1NDN9Kp5QL9YcP9MZf6f9qJ42qfpYH+Y9KoVIGqxhKXyEMZJczGXxek
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="283853763"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="283853763"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:08:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="773832349"
Received: from mvemla-mobl1.amr.corp.intel.com (HELO [10.209.87.21]) ([10.209.87.21])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:08:44 -0700
Message-ID: <2616c28881ccba4e44cf24105ada117f954c0d30.camel@linux.intel.com>
Subject: Re: [tip: x86/urgent] x86/sgx: Set active memcg prior to shmem
 allocation
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jul 2022 11:08:26 -0700
In-Reply-To: <YtUs3MKLzFg+rqEV@zn.tnic>
References: <20220520174248.4918-1-kristen@linux.intel.com>
         <165419442842.4207.2566961916839377924.tip-bot2@tip-bot2>
         <YtUs3MKLzFg+rqEV@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 11:50 +0200, Borislav Petkov wrote:
> Just what I think looks like a discrepancy I noticed while merging
> tip/master:
> 
> On Thu, Jun 02, 2022 at 06:27:08PM -0000, tip-bot2 for Kristen
> Carlson Accardi wrote:
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.h
> > b/arch/x86/kernel/cpu/sgx/encl.h
> > index d44e737..332ef35 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.h
> > +++ b/arch/x86/kernel/cpu/sgx/encl.h
> > @@ -103,10 +103,13 @@ static inline int sgx_encl_find(struct
> > mm_struct *mm, unsigned long addr,
> >  int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
> >                      unsigned long end, unsigned long vm_flags);
> >  
> > +bool current_is_ksgxd(void);
> >  void sgx_encl_release(struct kref *ref);
> >  int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
> > -int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long
> > page_index,
> > -                        struct sgx_backing *backing);
> > +int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long
> > page_index,
> > +                           struct sgx_backing *backing);
> > +int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long
> > page_index,
> > +                          struct sgx_backing *backing);
> >  void sgx_encl_put_backing(struct sgx_backing *backing);
> 
> So this is making the sgx_encl_get_backing() thing static but its
> counterpart sgx_encl_put_backing() is not and is still called by
> other
> places.
> 
> Perhaps something wrong with the layering or is this on purpose?
> 
> Thx.
> 

Hi Boris,

This is intentional - sgx_encl_put_backing() was not changed and will
continue to be used as it previously was.

Thanks,
Kristen

