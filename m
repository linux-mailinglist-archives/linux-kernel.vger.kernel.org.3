Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09413533488
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbiEYBDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiEYBDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:03:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D206D66230
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653440586; x=1684976586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CcOHb3vpXN7sCmMzC85HB1Ml46FJnpQ5DCMPfsAqDJ4=;
  b=grELVhR+oY0sLPNKgXAJohMjgTNefPzJS+uGbXAtoUiQqvpZQQMovQyo
   Gap33RLRrncHn4CkCmFG62/jWBjdaKE6e43ymYTvaKw8woFgiWwdCmkn2
   RrxRSu+/4t7LmgnvqFxj0malSR89HYhC1BjEL3EHTcFe/VSnioSnUGOGu
   Gy7WiTKAbY6RWZW+LZ5j2cVHfY9OGWYi/Muq49rYk5jraUbBE1LTCcJDA
   tC1fMKeYuXYUs5vtcX9rwBCRpIPnb0Gc3L2ppUW+npiZ5M8I2bgahUNHs
   koZCRsOwpBe3yAH7z4k5M9BVB9mE3wG5PNZ6+YIyZal/Yh5vY0wSWeUgz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="261295578"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="261295578"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 18:03:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="703695444"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 18:03:06 -0700
Date:   Tue, 24 May 2022 18:03:04 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Message-ID: <Yo2ASBAElqrQvzh3@agluck-desk3.sc.intel.com>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-4-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524185324.28395-4-bp@alien8.de>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 08:53:24PM +0200, Borislav Petkov wrote:
> +	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);

Seems harsh. Updating microcode to the latest is arguably the
way to make sure that your CPU stays "IN_SPEC" (since the microcode
may have a fix for a functional issue).

-Tony
