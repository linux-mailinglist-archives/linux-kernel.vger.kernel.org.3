Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3349300D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbiARVlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:41:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:64795 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233335AbiARVlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642542104; x=1674078104;
  h=to:references:from:subject:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=82vTBvRwSqUF/1jlnm0X+PDvb31yaJjN2/Eq92CGb1E=;
  b=NPxZPSFN07r7frgSkuWXnjdJLmsvJzqiYo6XlUnpgF4t4FiRXInkTSe8
   mMZEESwpqpTfctOmm57+SWhCHrEhh7JFnpQYyxAHgiNWkEfFBlVTRLahg
   T6dT7496lffzu+8t0UEx68DQbdTw3GP3X+Xckcx8mILW6QDAQk9B71q94
   Yxt3gYE2ytSMNqE3JwRRBEUivInMDmyJZtATZDT2toJJ7GJ8h4/fTBi3T
   XEx6D5oa8LEJ4DOQIKuvaUFGkE3ROKE4i/S9L4lb8oCDYQjqmBQFqO61v
   4wXfOBmPcpPZQYe53itRAXmmkr55HyT4cP72eRE46S5dQaLvxTSSSiUVg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="308262826"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="308262826"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 13:41:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="764726247"
Received: from ssrikan2-mobl2.amr.corp.intel.com (HELO [10.209.52.128]) ([10.209.52.128])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 13:41:43 -0800
To:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        willy@infradead.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, rppt@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1642526745.git.khalid.aziz@oracle.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <eb696699-0138-33c5-ad47-bfca7f6e9079@intel.com>
Date:   Tue, 18 Jan 2022 13:41:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover.1642526745.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 1:19 PM, Khalid Aziz wrote:
> - Starting address must be aligned to pgdir size (512GB on x86_64)

How does this work on systems with 5-level paging where a top-level page
table entry covers 256TB?  Is the alignment requirement 512GB or 256TB?
 How does userspace figure out which alignment requirement it is subject to?
