Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF4E4A2A7C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348474AbiA2AQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:16:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:12777 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235979AbiA2AQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643415414; x=1674951414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ib0+KQqGLzivGEVkAmTrUFi1+1QJrYHHbJ0KiLhCotI=;
  b=TeokYAJi4mE/I3Lz5iGaOkGWLFPdzaMt5pYszfxuGH0/5StvscYQTy64
   m6f6Ve5EG4oK1+zludPYvmvCXCo82FL7OHA/prGd6FPGNs7DUoQgTzSPI
   GRqHqZuGRVQFtmT7MVo4mEYGvNb9ApOdkJmcjBWePhD6BdY35dKdGzKhr
   5c1CX9nDGKCCDss33yvjKuvcVdPKkNt8BeMYpHYmj2BrtIe4WNE0+okm6
   wk2KPygZz5cyy8dDDDRGsI4xaOxR68LIelCQ9liq+SIjT1s9YWMbl0sUt
   h+J/wadfMn6r/vXSFlvPKD28mGqUW7PlBp/3+mW9q4VweKvXLE8sn9bJw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247170668"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247170668"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:16:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="536342085"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:16:53 -0800
Date:   Fri, 28 Jan 2022 16:16:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 14/44] x86/pkeys: Introduce pks_write_pkrs()
Message-ID: <20220129001653.GM785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-15-ira.weiny@intel.com>
 <f438ca4e-29ce-209e-0dd9-cdb757dbfd4a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f438ca4e-29ce-209e-0dd9-cdb757dbfd4a@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:12:06PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > Writing to MSR's is inefficient.  Even though the underlying
> > WRMSR(MSR_IA32_PKRS) is not serializing (see below), writing to the MSR
> > unnecessarily should be avoided.  This is especially true when the value
> > of the PKS protections is unlikely to change from the default often.
> 
> This probably needs some context.
> 
> The most important pks_write_pkrs() user is in the scheduler, right?

This is also used during exceptions, twice.  Those are probably more important.

> 
> So, this is really about optimizing that scheduler code for the common
> case where, even when changing threads, the PKRS value does not change.
> 
> Can you explain a bit why you expect that to be the common case?

Yes.

Ira
