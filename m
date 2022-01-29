Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AACE4A2A75
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbiA2AMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:12:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:35447 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235611AbiA2AMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643415135; x=1674951135;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=MExqca0eBTiYdRmMMe4XFo+NmvcENhAOdnnHHuo1BWg=;
  b=RVuoD50ZHAg0dh3uc0T8RzGNjSiuo81aGmySBs31Up0RFoIUMuaTCY/o
   eqiomYX7lhcxhdL6Kpu2X50O3dmgWahzSM7vuw4J4+i9bepeDd5v5Bjcl
   WrF1VI0QMqb70HcsfSVb7pyl7NxsKHuKT2EIfbr1mVd1SO82sFcPmXjAd
   dLal8b4qnO5AQjPgkYUONRzOJyC6uW/6j3LEmWzVcHthWbOaqEU9De2fm
   mA1HVfViagZ+QhRqW1jvgxaYBr3D/hJBhE7B4ihUtqI390+BoIX4IOSH3
   vnKeJK+qxOl5eVs22xZpzP6JUEU09PXKPn9+Z2Q/MBHFEoMh7nAMWhDRy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246061296"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="246061296"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:12:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697260847"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:12:09 -0800
Message-ID: <f438ca4e-29ce-209e-0dd9-cdb757dbfd4a@intel.com>
Date:   Fri, 28 Jan 2022 16:12:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-15-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 14/44] x86/pkeys: Introduce pks_write_pkrs()
In-Reply-To: <20220127175505.851391-15-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> Writing to MSR's is inefficient.  Even though the underlying
> WRMSR(MSR_IA32_PKRS) is not serializing (see below), writing to the MSR
> unnecessarily should be avoided.  This is especially true when the value
> of the PKS protections is unlikely to change from the default often.

This probably needs some context.

The most important pks_write_pkrs() user is in the scheduler, right?

So, this is really about optimizing that scheduler code for the common
case where, even when changing threads, the PKRS value does not change.

Can you explain a bit why you expect that to be the common case?
