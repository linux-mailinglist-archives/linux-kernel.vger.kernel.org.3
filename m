Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF393588E34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbiHCOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbiHCOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:05:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B782530F57;
        Wed,  3 Aug 2022 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659535501; x=1691071501;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yg5mD3Dj0CS+uFzrjjVlpHk1BBsTLHtsoJkssWr5R3w=;
  b=Okch79AIhz+1CYySR46P70UuutIewSUIFebnvZhU3TUUABUNsVGEb4jg
   /+naCNGvEzRbC4Knb75PAybOxXTbLoVniyqJksqWshri7zvqOwdOmeqLg
   mk/dAirsQYRJq7PugdK6C7FQv8ACKvLBeF9ZA2U5X0U/1UIc61LqX6TfO
   kqtN+qMdqxh/9V9sKcHndUM52/+wIjSj/tY9L1oJXvD4xjSgOkKNN0Ict
   D17DV4YeLWMyQFyvSGOZV6hHuDZvP76Euqq/VXzQLLc5EeQ+iZ2g0e+Ea
   5QYBlRPI4BcY9vFnEn1vAePasA0XlwfNgZX89EeUQWV9qIpnoTGWN8DxX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="269450184"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="269450184"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:05:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631160602"
Received: from buichris-mobl.amr.corp.intel.com (HELO [10.209.124.150]) ([10.209.124.150])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:05:00 -0700
Message-ID: <973736db-2480-bbaa-d2ce-6e1b6dd2ed0c@intel.com>
Date:   Wed, 3 Aug 2022 07:05:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/8] x86_64: Harden compressed kernel, part 1
Content-Language: en-US
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-hardening@vger.kernel.org
References: <cover.1659369873.git.baskov@ispras.ru>
 <e6e7fef1-0dff-ef72-8a17-8ecec89994ca@intel.com>
 <893da11995f93a7ea8f7485d17bf356a@ispras.ru>
 <e8342722-20f8-a566-59c5-8e8f7f271d98@intel.com>
 <29312ea704885f1b8d3c229e1f22dad7@ispras.ru>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <29312ea704885f1b8d3c229e1f22dad7@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 16:45, Evgeniy Baskov wrote:
> Partially. We do have known issues because kernel PE image is not
> compliant with the MS PE and COFF specification v8.3 referenced by
> the UEFI specification. UEFI implementations with stricter PE loaders
> (e.g. mentioned above) fail to boot Linux kernel.

That shows me that it's _possible_ to build a more strict PE loader that
wouldn't load Linux.  But, in practice is anyone using a more strict PE
loader?  Does anyone actually want that in practice?  Or, again, is this
more strict PE loader just an academic demonstration?

The README starts:

	This branch demonstrates...

That doesn't seem like something that's _important_ to deal with.
Sounds like a proof-of-concept.

Don't get me wrong, I'm all for improving thing, even if the benefits
are far off.  But, let's not fool ourselves.
