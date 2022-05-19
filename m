Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713B152DE91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244783AbiESUoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiESUo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:44:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04507A815;
        Thu, 19 May 2022 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652993068; x=1684529068;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6hFppb/e9rJtKSA/JHWaDssY9mHf4YuE/Bk76q7Ido=;
  b=KbmQeoUSZ6ztPxaiGFWmwIAR1xVhzHMxROfHFR0UoBpCQ4GiHH4mBYog
   ZCxegp4QtuBizMvbFi2vkWwRmdx95K/rUqCj1O2HbXI06zPqKk5iXbLzV
   NouKHofYpPfMSSo5cr7PxO1AHJ2/EgYRR7RwNUEeOym7vXffle7VSRWu8
   MYpiabMRICXOGJpEIy/jlRYuo4p8boi41cyLE1grT5lge/5+hdxsjxr7o
   ElC5UDq5Rw+MpgpK1NghdxHzd/EsFdLPczAxRwGeqbLY+9TMkzzUJI37s
   +Xh8kTFDHxCz6pfwosMZ0N/VtnuD2aez1rOeT1IB8D5Ne0DfWJTL/RTOF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272336272"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272336272"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:44:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="701358036"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.148.227])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:44:27 -0700
Message-ID: <c5cae6916a74251187eef3e46a42212177f42253.camel@linux.intel.com>
Subject: Re: [PATCH] x86/sgx: Set active memcg prior to shmem allocation
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     linux-sgx@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 19 May 2022 13:44:17 -0700
In-Reply-To: <CALvZod40TpW0rX1jvj6GZWtr=nscJFkw_zdvZjbh7GPgd8pLWQ@mail.gmail.com>
References: <20220517164713.4610-1-kristen@linux.intel.com>
         <9c269c70-35fe-a1a4-34c9-b1e62ab3bb3b@intel.com>
         <CALvZod40TpW0rX1jvj6GZWtr=nscJFkw_zdvZjbh7GPgd8pLWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-18 at 22:43 -0700, Shakeel Butt wrote:
> (Fixing the CC list and sending again)
> 
> On Tue, May 17, 2022 at 09:47:13AM -0700, Kristen Carlson Accardi
> wrote:
> [...]
> > +int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long
> > page_index,
> > +                        struct sgx_backing *backing)
> > +{
> > +     struct mem_cgroup *old_memcg;
> > +     int ret;
> > +
> > +     old_memcg = sgx_encl_set_active_memcg(encl);
> 
> This function is leaking memcg reference. Please change
> sgx_encl_set_active_memcg() to sgx_encl_get_mem_cgroup() or something
> which will return the memcg with the refcount elevated. Then use
> set_active_memcg(returned_memcg) here.
> 
> > +
> > +     ret = sgx_encl_get_backing(encl, page_index, backing);
> > +
> > +     set_active_memcg(old_memcg);
> 
> mem_cgroup_put(returned_memcg) here.
> 
> > +
> > +     return ret;
> > +}

Thank you for your review. I will incorporate this fix into my next
version.


