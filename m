Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0FB48EF8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbiANR4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:56:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:35461 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236840AbiANRzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642182955; x=1673718955;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=v8Ozza0tymQgUc+3naLOKoeYD5ZJqBwVXdu/+vjab4M=;
  b=nVw8K7bRFVG0ZQiQpq6wl2T/iPB4ZcWGSicb9ZXmxTgU2S4MueLfmHwc
   SGzC+paeMd7YqX8ThykdPnnNmtsvSaWn23rq/YBIiMCToqr4fk9P1oMPL
   zB2YdZSzShsNxOLSVt8C7DVHylgJmGWrrjgfG8jTRwnVpupyG2Naxm9Os
   8YKj5Nu16CdzRmt0yM8/+8IwRCLm2JEm8gxWI6xwderf1WLHGq0T2uxH8
   kcpBB649cRTO4l2ZiBAameGBHMo/epph8sP0NbwNIcdLeTwlaZQJUDu1F
   ++fmqf/SUlFKSqJUafWRXDx9I/XYdHq6fZyo4tFbNtiyJLmTGvLJoWelO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="330644744"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="330644744"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:55:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="491594520"
Received: from richasha-mobl.amr.corp.intel.com (HELO [10.251.12.158]) ([10.251.12.158])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:55:52 -0800
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-3-kristen@linux.intel.com> <Ydm2Qk8JFwgdueZa@iki.fi>
 <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 2/2] x86/sgx: account backing pages
Message-ID: <ed190b80-75cb-3137-1d64-1a87e1ac930e@intel.com>
Date:   Fri, 14 Jan 2022 09:55:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/22 9:51 AM, Kristen Carlson Accardi wrote:
>>> +int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long
>>> page_index,
>>> +			    struct sgx_backing *backing)
>>> +{
>>> +	return sgx_encl_get_backing(encl, page_index, backing);
>>> +}
>> IMHO, sgx_encl_backing() should be open-coded here.
> I can understand your hesitation, but I agree with Dave here that
> wrapping the function makes the code more clear. I would prefer to keep
> this the way it is.

I'd also like to see sgx_encl_lookup_backing() and
sgx_encl_alloc_backing() diverge more in the future.

For instance, sgx_encl_alloc_backing() could ensure that the page does
not exist in the file before doing the sgx_encl_get_backing() call.
This would ensure that it truly *does* allocate a page and does not just
return a previously-allocated page.

sgx_encl_lookup_backing() could ensure the opposite: that the page
*DOES* exist in the file before doing the sgx_encl_get_backing() call.
This would ensure that it does not allocate a page in a case where we
expected an old, existing page to be present.
