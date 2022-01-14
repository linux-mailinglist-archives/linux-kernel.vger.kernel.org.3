Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DFA48EF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiANRpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:45:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:12597 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230345AbiANRpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642182345; x=1673718345;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vF09JsXaSIHHoR3Wh7E3An0QrZE77BfGG2qEDHfIBYU=;
  b=g5GwjexJEdYco0cdqo2FrDonjdFHmqdP1VQvp9TPwQuIJ5jCf9J/IQwQ
   d0sq6UoNs9Lzg6xUlVwdGi5ztEPH8BXhiG+tAw1Y6LYS+0jk+SOuQ43tw
   FyWAmkv0OzPhNgeofqefVpjVhBgis5ywQQ89PMA0HOvL89wOk19fSj5G0
   McP2LmX6O8YKOlNl1o/ovKSt9+H0cXQIhMnMdRX9sBbvIqwlcfGbquRCV
   QIdaGZbKAJ7uXbPM41KeW0yL+bun+gTtZZHjjddpK4CyN25HxykO9DUAQ
   n8Jmuaa/G5x7NLliXnHcWzv/2DV52z3baWcX/LH07a5YJnEVNbH/zscI4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="224277401"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="224277401"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:45:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="491592076"
Received: from agonz1-mobl3.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.237.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:45:44 -0800
Message-ID: <886a50c8e97b5d2ef5b7c004a63365d2aa480f33.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] x86/sgx: Add accounting for tracking overcommit
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 14 Jan 2022 09:45:42 -0800
In-Reply-To: <4996667d-938d-0833-f5a5-bf5ec82f69ea@intel.com>
References: <20220107181618.6597-1-kristen@linux.intel.com>
         <20220107181618.6597-2-kristen@linux.intel.com>
         <171631a9-aaec-f590-3377-29c13fc6041e@intel.com>
         <3b169fde457f28e086c49c8a3b8d81ac539cfb59.camel@linux.intel.com>
         <op.1ft4sin7wjvjmi@hhuan26-mobl1.mshome.net>
         <bc370c39-d8c1-9371-2345-cf255ced9a1b@intel.com>
         <op.1fuaql06wjvjmi@hhuan26-mobl1.mshome.net>
         <4996667d-938d-0833-f5a5-bf5ec82f69ea@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-11 at 09:39 -0800, Dave Hansen wrote:
> On 1/11/22 08:33, Haitao Huang wrote:
> > On Tue, 11 Jan 2022 09:43:35 -0600, Dave Hansen <
> > dave.hansen@intel.com> 
> > wrote:
> > > On 1/11/22 06:20, Haitao Huang wrote:
> > > > If the system has a ton of RAM but limited EPC, I think it
> > > > makes 
> > > > sense to allow more EPC swapping, can we do min(0.5*RAM,
> > > > 2*EPC)?
> > > > I suppose if the system is used for heavy enclave load, user
> > > > would be 
> > > > willing to at least use half of RAM.
> > > 
> > > If I have 100GB of RAM and 100MB of EPC, can I really
> > > *meaningfully* 
> > > run 50GB of enclaves?  In that case, if everything was swapped
> > > out 
> > > evenly, I would only have a 499/500 chance that a given page
> > > reference 
> > > would fault.
> > 
> > The formula will cap swapping at 2*EPC so only 200MB swapped out. 
> > So 
> > the miss is at most 1/3.
> > The original hard coded cap 1.5*EPC may still consume too much RAM
> > if 
> > RAM<1.5*EPC.
> 
> Oh, sorry, I read that backwards.
> 
> Basing it on the amount of RAM is a bit nasty.  You might either
> really 
> overly restrict the amount of allowed EPC, or you have to handle
> hotplug.

My opinion is that we should keep the current algorithm for now as it
is pretty straightforward, and cgroups will eventually allow for more
control.


