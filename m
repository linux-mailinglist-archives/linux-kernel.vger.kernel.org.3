Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09670498714
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244725AbiAXRip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:38:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:37041 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235570AbiAXRio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643045924; x=1674581924;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=vPNTBoYL3mQlTowJCIE+opIrXBijwuuIm5WDA377RCk=;
  b=R4zib/AlAhy4TyBArxkCdrSh/eUrWFAhZg9H9D4DtsqXfj2WQjEW1BFw
   b8mOiwvmpaGgYG23OSmVFxxBAC0moecJ9myns3vNUX/dNjz7LujbXKXVV
   aXNo3VS33PrqWRy2uEutH94gTILgLCboUEVkqSPHx8WKHkjstemDQd38Q
   7O9Cu3ssf/P2/X5uGtmRbJDsFeOs+VoeI8TGRQqtlPYxQ013NRslLTQCs
   IJvhNAF0r5ez0Pu5O84cUtpAgN5N9wWEw8k/Kv3V1H5R9wAGe45NOU4hR
   ha0/e5AZt5PV6QuhZImZ2CeuPPAwnvBDxuP7uUZ0WNjYaODdNQpxbYlTF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233465149"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233465149"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:38:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="580464712"
Received: from jncomo-mobl.amr.corp.intel.com (HELO [10.251.27.220]) ([10.251.27.220])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:38:43 -0800
Message-ID: <bd7c111c-8bd4-9c4d-4715-c0fb5fd034ee@intel.com>
Date:   Mon, 24 Jan 2022 09:38:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220123015807.45005-1-kuniyu@amazon.co.jp>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/boot: Avoid redundant address overlap tests in
 memcpy().
In-Reply-To: <20220123015807.45005-1-kuniyu@amazon.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/22 17:58, Kuniyuki Iwashima wrote:
> -void *memmove(void *dest, const void *src, size_t n)
> +void *____memmove(void *dest, const void *src, size_t n)
>   {
>   	unsigned char *d = dest;
>   	const unsigned char *s = src;
>   
> -	if (d <= s || d - s >= n)
> -		return ____memcpy(dest, src, n);
> -
>   	while (n-- > 0)
>   		d[n] = s[n];
>   
>   	return dest;
>   }

The ___ naming is pretty cruel.  Could we call it memmove_no_overlap() 
or memmove_unsafe()?  Surely we can put some *useful* bytes in the name 
rather than padding it out with _'s.  No need to perpetuate the 
____memcpy() naming.

Also, is this worth the churn?  It probably saves less than 10 
instructions, all of which are ridiculously cheap.  Is there a *reason* 
for this other than being a pure cleanup?
