Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFB14A62B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiBARka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:40:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:11335 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241596AbiBARkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643737224; x=1675273224;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=w8HMLRlvFY4B4RAgkNDRGRRjjPKUPof7Fu2+mcJLrrs=;
  b=S0Fma3YH2Vn64uO76yjzMn5aQT/EYA+ostS20wnq4Bcu6ptkKI/wryzB
   RuVeM29V1P6ntnJiCFKiatesom8UKinwfw0u9XqI7FsDbTpS2KuEk3ST9
   wr164hStx9v7+RU4Z4sxt3U22ehfJoUShMK4vfK74ChGHUSP6PM16gOuN
   MDlNlRxHgnP8X2B8TQYXWZN3db8KW31q+Gidpu1N99b5Y6E2Lfms0feOc
   JmWmMO2p6yNHmDW84Gln+x730RIZlQjRsCvokjBtkvEYpHvNRQGJK3o/l
   wbzeFUbx4wguCrJTOFJ5NwkZnVEWSD4CIK/YUdlWRtTpcmTXais7ZGc1M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="235142146"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="235142146"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:40:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="583109790"
Received: from kssimha-mobl1.amr.corp.intel.com (HELO [10.212.228.15]) ([10.212.228.15])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:40:09 -0800
Message-ID: <87f171f1-c44b-5103-f9e5-20a6b5c257dd@intel.com>
Date:   Tue, 1 Feb 2022 09:40:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-17-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 16/44] mm/pkeys: Introduce pks_mk_readwrite()
In-Reply-To: <20220127175505.851391-17-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> +static inline void pks_mk_readwrite(int pkey)
> +{
> +	pks_update_protection(pkey, PKEY_READ_WRITE);
> +}

I don't really like the "mk" terminology in here.  Maybe it's from
dealing with the PTE helpers, but "mk" to me means that it won't do
anything observable by itself.  We're also not starved for space here,
and it's really odd to abbreviate "make->mk" but not do "readwrite->rw".

This really is going off and changing a register value.  I think:

	pks_set_readwrite()

would be fine.  This starts to get a bit redundant, but looks fine too:

	pks_set_key_readwrite()
