Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817BB487C69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiAGSrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:47:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:18598 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbiAGSrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641581233; x=1673117233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AVOvGHK2+PnzQnmj0+JK64mUWQbsspK8z0DDBKDHByY=;
  b=NwLFs2yUAleMWdx2jxeOyaId1gHtGAFIuscNR0L6W1NaY5Mi6BpwcqWu
   yXeR9yw+Yk7AGJBWnNkAwRHuciBNniA/FVyCDOcdKYaKz81fydghGuVjR
   FsR2sVY8T9UghSVEcVuB+ydxM24NO7T7ovQkmCWqtiL4bL3GUWXEZynJa
   wxhutdwO9p9qc8Y3tESKK68FgRZbS6EbFT+frZgFPx7eUTRDz3y0QqBnL
   +GO6KHvN75CKsVd8tRTqkcOsqmNvAICd1QtTd1BEinZc6f7S4vRzBLB9x
   ELWI3oWOVP/JHx27TztDEwoggnXcwSMeeWiKvT0OALWCdNTVejSRQHZ3s
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="223618549"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="223618549"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:46:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="473403501"
Received: from kcmojjad-mobl.amr.corp.intel.com (HELO [10.209.72.209]) ([10.209.72.209])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:46:51 -0800
Message-ID: <171631a9-aaec-f590-3377-29c13fc6041e@intel.com>
Date:   Fri, 7 Jan 2022 10:46:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 1/2] x86/sgx: Add accounting for tracking overcommit
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-2-kristen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220107181618.6597-2-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 10:16, Kristen Carlson Accardi wrote:
> The overcommit percentage value is 150, which limits the total number of
> shared memory pages that may be consumed by all enclaves as backing pages
> to 1.5X of EPC pages on the system.

Hi Kristen,

Could you give some background on how this value was chosen and how it 
might impact userspace?
