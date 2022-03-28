Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6CB4EA33E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiC1WpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiC1Wox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:44:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C050A8EE3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648507391; x=1680043391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dGBkA2wzKCxxRszSguxFPvOan/QZFJYt4C3EW6Xk4W0=;
  b=R4ZILREbKJEX4UM+ZUZx23mAjQ7WFW5NZpeDRtDvdmGshYmeLfeXMZ62
   fF/rgCJ71ZTjR7NM4j9U9E9QZVRojvJSYB8JLo+5HtY7jauF72KoT0p9z
   K19aZ/HN8JKOTiU2gntStkpc7v4VLTE8BnxH1SkELlQvZxYCX1vNthZ0M
   PnXsJxJYMttB9/32nODTRJgTYzKugsSUyMz/cqUYajv3+Rs/u1N4sGHXx
   JmAoARI+InCDFjyXRTQKhsGJnd/DxOChnYEx5wzHLKmFEl0n39VdvrG8V
   JthmnHvC0Gb+WJCzS+2B+NbB1jciu9IbjUI+zDz+lEtxzKb+EJaPcmHw0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="322301424"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="322301424"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:30:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="546137025"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:30:09 -0700
Date:   Mon, 28 Mar 2022 15:30:04 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Paolo Bonzini <bonzini@gnu.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [patch 0/7] x86/fpu: Cure supervisor mode (ENQCMD) fallout
Message-ID: <YkI27CuLsDFcPWpS@otcwcpicx3.sc.intel.com>
References: <20220324134548.432837672@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324134548.432837672@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Thu, Mar 24, 2022 at 02:47:07PM +0100, Thomas Gleixner wrote:
> It builds, boots on host and guest, but is not yet extensively tested.
> Testing with a AMX + PASID enabled machine has not been done at all as I
> don't have easy access to such a beast.

I run many copies of dsa_test [1] (i.e. multi-threading and multi-tasking)
to stressfully exercise FPU PASID state context switch on native.
No issue is found so far.

1. https://github.com/intel/idxd-config

Thanks.

-Fenghua
