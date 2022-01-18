Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2446D49304C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbiARWGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:06:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:44801 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233791AbiARWGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642543582; x=1674079582;
  h=to:references:from:subject:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Ewi5p/l47EcBj4eeeaDbN5CQqDZhKqbM07MsfSAesJM=;
  b=HuKCM/lI+c7+eMIY15XjzZEdXBGqR825cloYWvG5V610nQxh3L9qswAj
   7u0+RTHO5/OIKJgJfUiNuTMshGP6rsyG6ZC2VbI5uTd334b4qJPj05ArF
   XGjjsEzC3FSACYnY2ws5/wjf3MmOHMJYj3cPh5KeMemmrE8JHVp7H+5xn
   a3pTwCuEgBxv/ufzt5Bx3QgdtPhxJ/mMION6mIXI70yyk8pf60Lmhg7qI
   S/zfChFiXvGE07oHsJVpjt/vmjJZGPOJsgqiex4X49TsGwalY0JhUmJFt
   f4qW8GZDqduubhbBiqrLONq5YiboFQhJiU8XqCzrmSlIGpNm2ZjSIiwYy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="242487294"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="242487294"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 14:06:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="764732546"
Received: from ssrikan2-mobl2.amr.corp.intel.com (HELO [10.209.52.128]) ([10.209.52.128])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 14:06:21 -0800
To:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        willy@infradead.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, rppt@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1642526745.git.khalid.aziz@oracle.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <e0196efb-9c55-c0f8-c663-b4af44b8ffa4@intel.com>
Date:   Tue, 18 Jan 2022 14:06:20 -0800
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
> This is a proposal to implement a mechanism in kernel to allow
> userspace processes to opt into sharing PTEs. The proposal is to add
> a new system call - mshare(), which can be used by a process to
> create a region (we will call it mshare'd region) which can be used
> by other processes to map same pages using shared PTEs. Other
> process(es), assuming they have the right permissions, can then make
> the mashare() system call to map the shared pages into their address
> space using the shared PTEs.

One thing that went over my head here was that this allowing sharing of
relatively arbitrary *EXISTING* regions.  The mshared'd region might be
anonymous or an plain mmap()'d file.  It can even be a filesystem or
device DAX mmap().

In other words, donors can (ideally) share anything.  Consumers have
must use msharefs to access the donated areas.

Right?

( btw... thanks to willy for the correction on IRC.)
