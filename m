Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447F352576A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358998AbiELVxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358984AbiELVve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:51:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC0035A8D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652392293; x=1683928293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mUHbs3CGqeDWe+cfjYsXwi1cDVhyW8WsG1CjemSY2+o=;
  b=SHPELwRpuG++G6KEMsBeu/VkTm0tb5+mzlo4iZ9RKS1T8bvTP7K0K3Rc
   5AkSYiPPr9MqEjAajrdcCFoDbQ5ycFjS0/FdpTaTWOjCeu041sw5TkMwT
   JvW7878q0MS529W/lihb3geKzU8uINZEwrsZjIcWGRs2uxvnBcNyv1qDk
   q7oT2xEJFxSrsNCtCAGh4icV99PVtli93Z3NrbtG7E/FlkUyii7V0sWl/
   DyczuoMGQRNatpjeIyHwyTnmL0/KqnTfJKr8tzlPLZB+juGY9KkBu0rBy
   WQDc9O1VHhlx4sPcq4H3WFaWT0qfU/k8pk/Q8dV5amk9YQiXZFaKV58F4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="268980896"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="268980896"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 14:51:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="572707221"
Received: from wdwickar-mobl1.amr.corp.intel.com (HELO [10.252.130.245]) ([10.252.130.245])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 14:51:32 -0700
Message-ID: <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
Date:   Thu, 12 May 2022 14:51:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <875ymav8ul.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 12:39, Thomas Gleixner wrote:
>> It's OK for a debugging build that runs on one kind of hardware.  But,
>> if we want LAM-using binaries to be portable, we have to do something
>> different.
>>
>> One of the stated reasons for adding LAM hardware is that folks want to
>> use sanitizers outside of debugging environments.  To me, that means
>> that LAM is something that the same binary might run with or without.
> On/off yes, but is there an actual use case where such a mechanism would
> at start time dynamically chose the number of bits?

I'd love to hear from folks doing the userspace side of this.  Will
userspace be saying: "Give me all the bits you can!".  Or, will it
really just be looking for 6 bits only, and it doesn't care whether it
gets 6 or 15, it will use only 6?

Do the sanitizers have more overhead with more bits?  Or *less* overhead
because they can store more metadata in the pointers?

Will anyone care about the difference about potentially missing 1/64
issues with U57 versus 1/32768 with U48?
