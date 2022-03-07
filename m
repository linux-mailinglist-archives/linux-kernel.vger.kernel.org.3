Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31C4CFCBF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbiCGL06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241747AbiCGL0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:26:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB7E25CD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646650821; x=1678186821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6Qsj+nyRVcK7IzT3wVG7qxRlWjoeLyGnzJX6lFkAWE=;
  b=VxlpwxYnrsiv/N7lSWL9VsuiWm4k+UucyEJ0oQhciJ8m1o7SjHcHhHwX
   3vca84vSKnY0MWiTRDaSIINQhuh9JhktH2CNtjejzNbRAYIwGnChh7ZLq
   /SAYOZW+ObZEHL3/iXD7zdcreiYebM1JtZ/xmeXH5NGNRx0Kt1X+2P7Kv
   Hdlc2KQZwrrzpbiZ5E0FLqCodUayjLDKG3JN9L1C7QVsr4/bA49AZgKV5
   zLjVzBH+9w8Y5IDwa1br1bMakIIoor3wVz30TnxqodjTgzcXZETubWyyd
   acqs1JaUtui459sHhidbgmrTv94Ncf7LcxH6AZYUwC0mgmIrNMWKsEZbQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="340795983"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="340795983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 03:00:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643203519"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 03:00:19 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 227B0He0030077;
        Mon, 7 Mar 2022 11:00:18 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
Date:   Mon,  7 Mar 2022 11:58:10 +0100
Message-Id: <20220307105810.1747024-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr> <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 4 Mar 2022 20:46:08 +0200

> On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> 
> > This pattern is harmless but because it occurs in header files
> > (example find_first_bit() from linux/find.h [1]) and because of the
> > include hell, the macro GENMASK_INPUT_CHECK() is accountable for 31%
> > (164714/532484) of all warnings when compiling all modules at W=2
> > level.

Nice catch, thanks! I wanted to submit the very same fix, but
postponed it for some reason, and now here we are.

> 
> Have you fixed W=1 warnings?
> Without fixing W=1 (which makes much more sense, when used with
> WERROR=y && COMPILE_TEST=y) this has no value.

How is this connected?
When I do `make W=2 path/to/my/code`, I want to see the actual code
problems, not something that comes from the include files.
When I do `make W=2 path/to/new/code/from/lkml`, I want to see the
actual new warnings, not something coming from the includes.
It's much easier to overlook or miss some real warnings when the
stderr is being flooded by the warnings from the include files.
I'm aware there are some scripts to compare before/after, but I
don't want to use them just because "this has to value".
I don't want to do `make W=2 KCFLAGS='-Wno-shadow -Wno-type-limits'`
because then I'm not able to spot the actual shadow or type limit
problems in my/new code.
I fixed several `-Wshadow` warnings previously in the include files
related to networking, and *nobody* said "this has no value" or
NAKed it. And `-Wshadow` has always been in W=2.

> 
> NAK.

...

> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks,
Al
