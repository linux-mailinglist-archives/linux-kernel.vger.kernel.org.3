Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B06A4FBF55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244525AbiDKOik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbiDKOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:38:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A78288
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649687783; x=1681223783;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=YZSVAZRsUUEFlaaidv4vr1KoJx4NYOFjDRgt6QosIts=;
  b=DH4cwhyshuDne3i0nvCFEM9oMF+l1AFwVvYfax1FTCjHd5fEC5wN8kSV
   avJxhFo8vRMCEQtU1uM0pN6hd4NhygArVSlHHOs81/t168HSAJMXbUzBz
   MqS7M9n2U7BOVgLzYKqi1M1tl05iI92mptiGJajzP2a7n7OivDKaRAAFu
   KGzk7IcuAs5OLFKyP9AzVkS/50zp8hLTPezZxE4t4cqbUT6Z9oEfc/ViA
   KLGMRzsShXH4ceD5ZjC5AidUdIVQWHjQ8LlNk61sJfRzKXeng6HYEGtvI
   Td4Lty2u7sHy9nQXGU55OjNKR6Sazg7okRIdpbVoEoO1wXWhODX18ZevZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="287138868"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="287138868"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 07:36:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="525557138"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6]) ([10.212.113.6])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 07:36:21 -0700
Message-ID: <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
Date:   Mon, 11 Apr 2022 07:36:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        jean-philippe <jean-philippe@linaro.org>
Cc:     Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 07:20, zhangfei.gao@foxmail.com wrote:
>> Is there nothing before this call trace?  Usually there will be at least
>> some warning text.
> I added dump_stack() in ioasid_free.

Hold on a sec, though...

What's the *problem* here?  Did something break or are you just saying
that something looks weird to _you_?

For instance, if we have:

	nginx: ioasid_alloc()==1
	       fork(); // spawn the daemon
	       exit();
	       ioasid_free(1);

and then a moment later:

	lynx:  ioasid_alloc()==1
	       fork();
	       exit();
	       ioasid_free(1);

There's no problem.  The original nginx process with ioasid==1 exited.
The fact that *some* process called nginx is still running doesn't mean
that it still has a reference to asid==1.

Are you sure the nginx process that allocated the ASID is the same
process you see in ps?
