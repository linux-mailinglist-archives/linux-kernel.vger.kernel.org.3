Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3304748F344
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiANXzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:55:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:16440 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbiANXzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642204545; x=1673740545;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EaBxO/MhgDtShxcOfsdwvluceGYoVqaQXzNoi48cIZA=;
  b=HuhCwB68VZKlqKnVOs2h6DyIt753fSiZ+GiOI7Cn5gYaX32bRh29DFTA
   6Ccc7mS87fKbiWATjoCjSBhh8u+40P7+R2xC9EaTAGQhJYUv21CeGZQz7
   IxF7abaZJ7KWectV3SlPyrG4juL4gi9tVrWEdmdmtrEv+71MJyoskrJHw
   FqB/nOuEgB3C8umHrSlcDswjKsV4puAugrmpo/92Ok+hDRHuLabB/n5yq
   vF79/ugVHemk/cnPA7sQ1+4YHeFParlBFIIvQx1YAk4hV32YpAXJ2qs22
   oK0z0aASCZGv86dYnYRro9QCVqhCQUzdlHHjv1Jd7f/toXjBHwDMscIRk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="305082538"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="305082538"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:55:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="491688046"
Received: from richasha-mobl.amr.corp.intel.com (HELO [10.251.12.158]) ([10.251.12.158])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:55:44 -0800
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-3-kristen@linux.intel.com> <Ydm2Qk8JFwgdueZa@iki.fi>
 <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
 <YeIMqd+o//M3vB6e@iki.fi>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 2/2] x86/sgx: account backing pages
Message-ID: <3b7e79ea-18f2-afe2-be4e-401524b481f7@intel.com>
Date:   Fri, 14 Jan 2022 15:55:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YeIMqd+o//M3vB6e@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/22 3:52 PM, Jarkko Sakkinen wrote:
>> I can understand your hesitation, but I agree with Dave here that
>> wrapping the function makes the code more clear. I would prefer to keep
>> this the way it is.
> What if sgx_encl_get_backing() was changed as "static inline", if the
> only motivation is encapsulation?

What would the purpose be of adding an 'inline' to the function definition?
