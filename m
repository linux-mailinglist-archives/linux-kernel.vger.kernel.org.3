Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808034EF96C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350924AbiDASAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350814AbiDAR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:59:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0528F81B;
        Fri,  1 Apr 2022 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648835886; x=1680371886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hq5DKbyMQWiEpKptaUPukm1orUxGRlNXS+XrcMujQ2g=;
  b=c654WxW4PC+IrGZd9D01w0ewlz6HoUsZahN7yBVO6Gvouc3pR8yLQg6p
   2foHnOWmZG8BqapEJvfctzW5oethL/+Fg//pGSLEPWSkm1oWNUw579BIY
   rlUgxGNnF9W2s9aEb07r/ofYUoXEpYVVysbK/N9dsFgb9mp3wO1XKFkFz
   74qmYVPW2bi9Uqk3VL4k7k1r/X4UOGaYZ9shkEpMGRgxLacLnYmghYZyM
   ekTx7sHal6uk3nW6qZbz3y0M6/qNLbrzAoOY1q5c2D0bmD/9iZnfE8k2s
   ZqBxmJR2o/acDz0rtOMCUmYi5Oav8HlL6ImZCd4bPnY7uZVotNSGKnrLY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259026482"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="259026482"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 10:58:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="567678388"
Received: from dajones-mobl.amr.corp.intel.com (HELO [10.212.134.9]) ([10.212.134.9])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 10:58:05 -0700
Message-ID: <ee82ed75-03f5-1962-6888-11491c9569c8@intel.com>
Date:   Fri, 1 Apr 2022 10:58:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/3] x86/fpu: Make XCR0 accessors immune to unwanted
 compiler reordering
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com
References: <20220325022219.829-1-chang.seok.bae@intel.com>
 <20220325022219.829-2-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220325022219.829-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 19:22, Chang S. Bae wrote:
> Some old GCC versions (4.9.x and 5.x) have an issue that incorrectly
> reordering volatile asm statements with each other [1]. While this bug was
> fixed on later versions (8.1, 7.3, and 6.5), and the kernel's current XCR0
> read/write do not appear to be impacted, it is preventive to ensure them on
> the program order.

I thought you *actually* saw xgetbv() be reordered, though.  Was that on
a buggy compiler?
