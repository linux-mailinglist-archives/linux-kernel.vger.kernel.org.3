Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5584EF99D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348134AbiDASSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350993AbiDASSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:18:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E90A17941F;
        Fri,  1 Apr 2022 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648836979; x=1680372979;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=SkDJz/bB0BuJ0EYcysr++p5neR48hYNr+QtKG3BG1fA=;
  b=L8T5qVnDub3S/KEXzqonKlLYDs0BaMGZ/pw2wRd6kjHhX/yb4aKId9jS
   VduSz+gLSQ/rh4Gl5oc2oYcA3b1dB/+u5y7wB1/NcnwuWFea3vc0JHBz9
   Cg6HUpnMSn/YyeqRitlq7kLgYokMQpF5ahP4Rr2JBEvue5k23jEkUtU/v
   ad2R3BcV6dKtJSXIIUaViHKmWQqCkgI0/yPZTQ1dGr41AahAnQo0M0pGa
   Pv2Ri7ZBjk2bkNAMu8x0TAoXCPdQ4vz5iSHNOrmuuPc4Jk1I+o3pJXIZd
   s5088Bok8HOCvTcCttHftZTV3jE8adDrm3Fc7guW2afzcwESnMNN6dCra
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="260382948"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="260382948"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 11:16:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="567691604"
Received: from dajones-mobl.amr.corp.intel.com (HELO [10.212.134.9]) ([10.212.134.9])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 11:16:18 -0700
Message-ID: <1cb5ccc3-a84d-06da-a8e8-d9d3d8418d25@intel.com>
Date:   Fri, 1 Apr 2022 11:16:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com
References: <20220325022219.829-1-chang.seok.bae@intel.com>
 <20220325022219.829-2-chang.seok.bae@intel.com>
 <ee82ed75-03f5-1962-6888-11491c9569c8@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/3] x86/fpu: Make XCR0 accessors immune to unwanted
 compiler reordering
In-Reply-To: <ee82ed75-03f5-1962-6888-11491c9569c8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 10:58, Dave Hansen wrote:
> On 3/24/22 19:22, Chang S. Bae wrote:
>> Some old GCC versions (4.9.x and 5.x) have an issue that incorrectly
>> reordering volatile asm statements with each other [1]. While this bug was
>> fixed on later versions (8.1, 7.3, and 6.5), and the kernel's current XCR0
>> read/write do not appear to be impacted, it is preventive to ensure them on
>> the program order.
> I thought you *actually* saw xgetbv() be reordered, though.  Was that on
> a buggy compiler?

Actually, reading the gcc bug[1] a bit more, it says:

> However, correctness here depends on the compiler honouring the
> ordering of volatile asm statements with respect to other volatile
> code, and this patch fixes that.
In your case, there was presumably no volatile code, just a
fpu_state_size_dynamic() call.  The compiler thought the xgetbv() was
safe to reorder, and did so.

So, I'm not quite sure how that bug is relevant.  It just dealt with
multiple "asm volatile" statements that don't have memory clobbers.  We
only have one "asm volatile" in play.  Adding the memory clobber should
make that bug totally irrelevant.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602
