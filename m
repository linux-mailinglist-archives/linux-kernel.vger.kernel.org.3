Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0216158AFCC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiHESfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiHESfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:35:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10655D45
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659724514; x=1691260514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fQgkM0I77hhrK0bNqR1N2VYcwPL7X5dAPZAJQSyDdF4=;
  b=C+9L/VH1gO39sSBa2JDh9eaAqxHbzMW6m6EONq6j4MaVrwP5vl5r688E
   oZIatQ/jhd2TQhvdAnE9pUXdvUQQFzBzZbIKgqBA5vAH+kiNXj7iK3ACx
   cXeV696TPNj2+6kM6AdpIb2315lE/jSDEI+6Mo8Zd40q7qUEiUiuOQneV
   nrzIgVuMQdiJXFSzLic4hZTZysZEHBHxJ7OE2frEaFsV1Vad5YfY1y7SN
   /FQ9cXITlF5ARtUzRaIi35d6FaPHWuuWyQnurtWcru3QpL87ULrcPQ0ik
   Is/YWJrdAnBN12V4BHVnUrrHtyPcRg0zBvpUE3ak32Zh3dg8JSVRhBaaw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="351983237"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="351983237"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 11:35:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579592613"
Received: from rderber-mobl1.amr.corp.intel.com (HELO [10.212.217.71]) ([10.212.217.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 11:35:13 -0700
Message-ID: <1660cdf4-96c1-b6bb-a3be-d02c7a3affb9@intel.com>
Date:   Fri, 5 Aug 2022 11:35:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [patch V4 09/65] x86/fpu: Sanitize xstateregs_set()
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
References: <20210623120127.327154589@linutronix.de>
 <20210623121452.214903673@linutronix.de>
 <CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com>
 <4812abd6-626c-67e4-7314-be282cd25a4a@intel.com>
 <CANaxB-w1+zCupiS5HyofGhVD7TKqZCoRjv9VZiegROiPkMY3NA@mail.gmail.com>
 <291808ee-d5ab-a7b2-33e2-62a449e90cbf@intel.com>
 <37ba2de3-26b3-12eb-6a9d-c0f0572b832c@intel.com>
 <CANaxB-wFSTO+CCv2wCZb3JXwo1j8okiR2qAOMYcOiL8mn6WaTw@mail.gmail.com>
 <6f7db66e-c486-4687-bd8e-75478df06a28@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <6f7db66e-c486-4687-bd8e-75478df06a28@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/22 11:24, Chang S. Bae wrote:
> On 8/5/2022 5:12 AM, Andrei Vagin wrote:
>> gVisor test passes with this change too. Chang, are you going to send
>> a patch?
> 
> Oh, sounds good then.
> 
> Will post patches. But I guess I need to revise them a bit.

I've also got a series that Andy, Thomas and I were poking at last week.
 I'll try and get it out the door today.
