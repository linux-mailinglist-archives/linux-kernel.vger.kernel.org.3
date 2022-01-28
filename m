Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B044A04AB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbiA1XxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:53:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:11466 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244951AbiA1XxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643414004; x=1674950004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nYA95kQjyUG9ZfYCyAL8OLIznlSzVYP7TooUb1ysFxc=;
  b=PDYrV2Dx/XKRDng0DFxLbQ4KUYOaiVDwrdn+oh7fYJw8d4ptIzvJHAbg
   nji0HzvS+u/nwS/walu0R1oUS+yzOcEXReXFiHN7Q0aoCsYQJKoiq5h7U
   Qm7BAlR9d7g/AsiwJwOhMmTo9q5TtxphepEo+ZIzwqVCUgUyBUDGaH3tx
   ijx6doulHfdwlgJTLRoRCOkGSBnbJimb63xXUuZZ7FQOCDXWUL0gFXm+6
   fxKlA+zZWLLcgDnruMKQaJyW80dy2DlZ34YI2tpafvx31+YkK2MvdNOaz
   4Wkjoeb1I0RdmHBPkWby2+Ai4zEHFub85fWZF1xg9ZH0MyFbMwHw/fmH6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247167898"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247167898"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:53:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697255394"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:53:23 -0800
Message-ID: <97fc1205-4270-1924-d3b3-19708ada648c@intel.com>
Date:   Fri, 28 Jan 2022 15:53:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Subject: Re: [PATCH V8 09/44] x86/pkeys: Enable PKS on cpus which support it
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-10-ira.weiny@intel.com>
 <f9db9626-de92-65a4-57f1-cf94511dd137@intel.com>
 <20220128234103.GL785175@iweiny-DESK2.sc.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220128234103.GL785175@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 15:41, Ira Weiny wrote:
> On Fri, Jan 28, 2022 at 03:18:29PM -0800, Dave Hansen wrote:
>> On 1/27/22 09:54, ira.weiny@intel.com wrote:
>>> Initially, pks_setup() initializes the per-cpu MSR with 0 to enable all
>>> access on all pkeys.
>>
>> Why not just make it restrictive to start out?  That's what we do for PKU.
> 
> This maintains compatibility with the code prior to this patch.  Ie no
> restrictions on kernel mappings.

But, compatibility with what?  At this point, there are no non-pkey-0
kernel mappings.  So, PKRS can be set to anything as long as the two low
bits are clear.

