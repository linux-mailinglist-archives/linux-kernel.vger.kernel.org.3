Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB56B5A85D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiHaSiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiHaSiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:38:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB322A404;
        Wed, 31 Aug 2022 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661970914; x=1693506914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oZ81GBOoxsRgNamHItqt8q6nDc0jiyU7IDPS+Ea0r+4=;
  b=LWusMo6P62gbPWSXVorSKmkVHwjSUUNBLDvsPBLmfjp5LXO/JKezxHju
   lIBcN0KN8zMYsVBfR902fplhM/W+9qwRS+xt5AH26jksyc1hsfIBVAtVc
   YxfeJHvFnlSHoJ9Mw0R/niMv1gWtvxrYmNnmxG/UC8l6xIOkBUeB9928/
   6lowxvXYPuGtt1DbxXvkYMGtQ2Ud3KhOGplo3Hki6mX4pWxPUOWdiLDno
   WomEeT9SFyWJohnhVlQxAirP8cl/l6zb6n1PC6W8rd/hZTzxA8cju/XAY
   SG+pVvq1xtyEnqCgK9NU8kCgf1A0Xqt2pHjNAuBk3DQfbls+iH+0fnSN3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296798210"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296798210"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:35:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="612191393"
Received: from nkrobins-mobl2.amr.corp.intel.com (HELO [10.212.220.19]) ([10.212.220.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:35:11 -0700
Message-ID: <ea61a9ee-96dc-4f23-9de3-34e033391abc@intel.com>
Date:   Wed, 31 Aug 2022 11:35:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Content-Language: en-US
To:     "jarkko@kernel.org" <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-2-jarkko@kernel.org>
 <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
 <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
 <Yw7EX5GCrEaLzpHV@kernel.org>
 <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
 <Yw7LJa7eRG+WZ0wv@kernel.org>
 <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
 <Yw7OEh7QP8tb7BR1@kernel.org>
 <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
 <op.1rrt4aecwjvjmi@hhuan26-mobl1.mshome.net> <Yw+oR3FKlwbeOl6I@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yw+oR3FKlwbeOl6I@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko, Kai and Haitao,

Can you three please start trimming your replies?  You don't need to and
should not quote the entirety of your messages every time you reply.

On 8/31/22 11:28, jarkko@kernel.org wrote:
>> Will it cause racing if we expose dev nodes to user space before
>> ksgxd is started and sensitization done?
> I'll to explain this.
> 
> So the point is to fix the issue at hand, and fix it locally.
> 
> Changing initialization order is simply out of context. It's
> not really an argument for or against changing it
> 
> We are fixing sanitization here, and only that with zero
> side-effects to any other semantics.
> 
> It's dictated by the development process [*] but more
> importantly it's also just plain common sense.

Kai, I think your suggestion is reasonable.  You make a good point about
not needing ksgxd for vepc.

*But*, I think it's a bit too much for a bugfix that's headed to
-stable.  I'm concerned that it will have unintended side effects,
*especially* when there's a working, tested alternative.
