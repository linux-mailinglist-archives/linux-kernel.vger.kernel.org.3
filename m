Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8FC584045
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiG1NrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiG1NrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:47:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9497161DA4;
        Thu, 28 Jul 2022 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659016023; x=1690552023;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CZja/uwthCUFDrIQap+P+xmHljMJZLA/BFEZZ78HIFk=;
  b=oGDqGyQEYo1A6CB7LSc3/tQJrxRQWusJVYm9LamKG7CMt/LPzFDQHZ3N
   U3VMyxsPX18AAX5aS7tnOz/bQu0D5BbqoxjE8EeouotREt9diLPv8Qmle
   xSivt/V/bgLNt3rhgihKoz0Ea4juqAQa56KPu4ZQ8mngHhQYH+uief3Oj
   vHPmUcKaH0r25ibj0OhY9vbK/IaqzA3yZAzPMs4ebm/F4gWJ3AHv9rfm1
   BuXWG4tIfUHyDnTBajx2C1nHvxF7fD3gx0LDYX1Y91laCJGICtDb4RgTF
   PIz9/oaSEYkbsms/TD16+oLmdnRe63MR/LsQgajRwzhM5SjJNH8/8sG3W
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="268278650"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="268278650"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 06:47:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="551313622"
Received: from bbandar7-mobl1.amr.corp.intel.com (HELO [10.209.124.46]) ([10.209.124.46])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 06:47:01 -0700
Message-ID: <fbf213f2-f118-ccfa-3faa-ec8b2182595b@intel.com>
Date:   Thu, 28 Jul 2022 06:47:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/sgx: Improve comments for
 sgx_encl_lookup/alloc_backing()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org
References: <20220720182120.1160956-1-kristen@linux.intel.com>
 <YuJBjq/4dALm//rf@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YuJBjq/4dALm//rf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 00:58, Jarkko Sakkinen wrote:
> On Wed, Jul 20, 2022 at 11:21:19AM -0700, Kristen Carlson Accardi wrote:
>> Modify the comments for sgx_encl_lookup_backing() and for
>> sgx_encl_alloc_backing() to indicate that they take a reference
>> which must be dropped with a call to sgx_encl_put_backing().
>> Make sgx_encl_lookup_backing() static for now, and change the
>> name of sgx_encl_get_backing() to __sgx_encl_get_backing() to
>> make it more clear that sgx_encl_get_backing() is an internal
>> function.
>>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> The rename is unnecessary.

Well, it was done to address some reviewer confusion:

	https://lore.kernel.org/all/YtUs3MKLzFg+rqEV@zn.tnic/

I wouldn't call it unnecessary.  Heck, I'd argue that the one of the
main reasons that this code leaked memory in the first place was the
naming and lack of comments.
