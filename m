Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98AC5789D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiGRSw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiGRSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:52:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E42613F;
        Mon, 18 Jul 2022 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658170375; x=1689706375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c0ZnVimJBtUWZW5UAl0hkii20Vq7jefbvdlIVd+RvNY=;
  b=MvvjCy55pYXgBFVEPNeE439HTOBgZ4rmtgCcwghhjOibXOrBK2Quw3yD
   mYCpeDNuJcu6wjGj3PrccthVbtaOMjNCaZm9TznC4uysLu4EOUZiI9uQX
   sUOSK2vtMyK3xMVpo9dZ+VQh2OT3e9XHFT8HtvlkNagRHvPGOHmfIbGGt
   OzToYD4SD/ZB6vpMwC5Cz/gA+XgTX1KqnbBaiOJP7EcVtGwtyCu2RdyWb
   fWj3/V1qPoR1qmBhzKqSnOGPoQW5CPa7ktzDcodRqVWTKvIIT1qFTUlmA
   /6ZD5RTzOVYr/epvY02xjo8pPs9WczAFrv7GUhRpSkzOwKpSa6hYxsyd9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="283862693"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="283862693"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:52:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="572529935"
Received: from bblaisde-mobl1.amr.corp.intel.com (HELO [10.212.195.115]) ([10.212.195.115])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:52:55 -0700
Message-ID: <b1476c7d-c514-227f-2735-092b5afb7d3a@intel.com>
Date:   Mon, 18 Jul 2022 11:52:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [tip: x86/urgent] x86/sgx: Set active memcg prior to shmem
 allocation
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220520174248.4918-1-kristen@linux.intel.com>
 <165419442842.4207.2566961916839377924.tip-bot2@tip-bot2>
 <YtUs3MKLzFg+rqEV@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YtUs3MKLzFg+rqEV@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 02:50, Borislav Petkov wrote:
>> -int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
>> -			 struct sgx_backing *backing);
>> +int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
>> +			    struct sgx_backing *backing);
>> +int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
>> +			   struct sgx_backing *backing);
>>  void sgx_encl_put_backing(struct sgx_backing *backing);
> So this is making the sgx_encl_get_backing() thing static but its
> counterpart sgx_encl_put_backing() is not and is still called by other
> places.
> 
> Perhaps something wrong with the layering or is this on purpose?

All three of the:

	sgx_encl_get_backing()
	sgx_encl_lookup_backing()
	sgx_encl_alloc_backing()

functions take a reference on the backing storage that must be dropped
with sgx_encl_put_backing().  The "lookup" and "alloc" were added
because there really are two different users:

	1. I want to *create* backing storage space (alloc)
	2. I want to find *existing* backing storage (lookup)

and those two logical uses need different cgroup accounting semantics.

As a further cleanup, it would probably be nice to explicitly document
that "lookup" and "alloc" also require a subsequent "put".  It would
also be nice to change sgx_encl_get_backing() to
__sgx_encl_get_backing() to make it clear that it's an internal thing.

So, I think the _code_ is OK as-is, but it could use some more love.
