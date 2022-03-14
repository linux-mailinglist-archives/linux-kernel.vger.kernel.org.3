Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F191B4D8C37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbiCNTUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiCNTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:20:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BB6E01C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647285568; x=1678821568;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=p+7wxMHOLu381tgfLsoOkZa/Lm4AHERLCRbtcI3ncR8=;
  b=kDESL6x17gO96uB91JKyvRGiihuwNn6B1DYCl0IFRGLudjnFS1eJGEF8
   wsN9YG/7g+I3er31aaXXfuMoX1KClwsTaSg2ZpqfFs+2lFMFnUUA9CFxj
   N5IVJQkQVYgZqclRnzguiTkuGJEB4bCanFkertmHakD9YJVsqmLifzjAe
   2q8qYyUHQ+i67GZRMF0FW91/U3vm9BtNCrni4AFAaribsWRf8TTqcoFXY
   Zy8MIlrEryEQkvu76Mml95psxbOMYn0gQdLJ5bTIpjWhsWNF+wXDcMCfQ
   CP0Tj/tWBoLXMB3DrriM2VZN5co9MtxACq2eTDI2FHJwdkNbucAFSkHKc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256078338"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="256078338"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:19:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515572133"
Received: from zborja-mobl1.amr.corp.intel.com (HELO [10.212.239.199]) ([10.212.239.199])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:19:28 -0700
Message-ID: <40b468cb-5144-77f0-963a-67e81d2e3aa4@intel.com>
Date:   Mon, 14 Mar 2022 12:19:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 0/8] Add hardware prefetch control driver for arm64 and
 x86
In-Reply-To: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 02:19, Kohei Tarumizu wrote:
> The advantage of using this is improved performance. As an example of
> performance improvements, the results of running the Stream benchmark
> on the A64FX are described in section [Merit].

I take it that there are users out there today that are sufficiently
motivated by the increased performance that they just do "wrmsr 0x1a4
0x1234".

You talked about this in the "[Merit]" section.  But, that's a _little_
unconvincing.  I don't doubt that there is *a* workload out there that
can benefit from hardware prefetcher tweaks.

Do we really expect end users to run their workloads and tweak these
values to find something optimal for them?
