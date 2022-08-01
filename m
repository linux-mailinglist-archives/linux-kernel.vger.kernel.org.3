Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86871586EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiHAQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiHAQs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:48:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A942C5FF4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659372538; x=1690908538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eohDWPXCcxFFZZHAs87ACrmger6AY+1swPyoVmOXD6k=;
  b=dN1YpWkH0ijDco88rtGDWBzXOc1D1W++X54dazW9UpdnkBe9dUjjRgNV
   C5fLw04d4Ib/20RkdumXMNV8Ga9LhsYzlWuUKojU/Iyz6AywCCczXurvA
   M0M8GDvtBexIdS0MylqFjvgbvWF3Bs1h1KW4MvBgTn7KvFMOCU9Vn3oWl
   v9QkDdOzjuIAzOyRV6HVJUuDtE8mtO4S2EhbUhc1iK5nSAEQZSX0Ey7Ux
   bENai0z2VNR2tC9A7mCBQbwEQ/n3rbRRN1nIf2+c3b57PHEsJdZe+rJvh
   47i9EnRlqIC0MtldH9WLyuboLzYH1+OYs2YXZpOOG+fXOTQ8kdh8Aewrd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="350901227"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="350901227"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:48:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="630315721"
Received: from cdthomas-mobl2.amr.corp.intel.com (HELO [10.209.57.155]) ([10.209.57.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:48:58 -0700
Message-ID: <e6e7fef1-0dff-ef72-8a17-8ecec89994ca@intel.com>
Date:   Mon, 1 Aug 2022 09:48:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/8] x86_64: Harden compressed kernel, part 1
Content-Language: en-US
To:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <cover.1659369873.git.baskov@ispras.ru>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <cover.1659369873.git.baskov@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 09:38, Evgeniy Baskov wrote:
> This is the first half of changes aimed to increase security of early
> boot code of compressed kernel for x86_64 by enforcing memory protection
> on page table level.

Could you share a little more background here?  Hardening is good, but
you _can_ have too much of a good thing.

Is this part of the boot cycle becoming a target for attackers in
trusted boot environments?  Do emerging confidential computing
technologies like SEV and TDX cause increased reliance on compressed
kernel security?

In other words, why is *THIS* important versus all the other patches
floating around out there?
