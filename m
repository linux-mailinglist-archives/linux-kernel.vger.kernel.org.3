Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB525769C9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiGOWTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiGOWTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:19:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDE92FFC0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657923542; x=1689459542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xnWTDDkvZxK97nPFhgEOirEMn9dek1e45fh3eUTV/c4=;
  b=mG7EPNTNec1GgdDkeA2q9myJ9ijRzKlbl+VHaUXBd+ZWBM0Xc7Y4lCxj
   FdZfcFoBz1DqffKCpDH1PnpB+LoghD9W61vb8c4mR9n2TM1JaXykp0HpR
   C/5r5AfyYIYpiGVXOilW6Q+/nVuPPwcgUQVce00uhnA3N831VAz2WkEUt
   Thwgq1q5L3JmjR3Um2lEuX4aA740sX9mVELhfVlyLNHSNajQfHQQWEPmc
   zGKY6eexLWjTh0rhcm0io69KuO57q0/xY02ERNhYkqyowppu067QAlfa2
   QkdY801vH1ykGTc+z1HfOnLj5z5ONmCdI20V1ksH0nCumT4xmEhOkoysE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="286647291"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="286647291"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 15:19:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="629267300"
Received: from kjhoig-mobl.amr.corp.intel.com (HELO desk) ([10.209.99.4])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 15:19:02 -0700
Date:   Fri, 15 Jul 2022 15:19:01 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, lkft-triage@lists.linaro.org,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable
 to RETBleed attacks, data leaks possible!
Message-ID: <20220715221901.xm3c4w4idqt67uja@desk>
References: <CA+G9fYv0N0FcYRp5irO_7TpheLcUY8LRMQbcZqwEmiRTEccEjA@mail.gmail.com>
 <Ys/bWIk0F5srkkpF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ys/bWIk0F5srkkpF@kroah.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:01:12AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 14, 2022 at 02:15:07PM +0530, Naresh Kamboju wrote:
> > Results from Linaro’s test farm.
> > 
> > We are booting the i386 kernel on an x86 machine.
> > With Spectre V2 patches merged into Linux mainline we have been noticing
> > RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable to
> > RETBleed attacks, data leaks possible!
> 
> That's funny.  I don't think that's a valid combination that should be
> cared about, but I'll leave it to Pawan to comment if it is something
> that is "real" to be concerned for.

Intel is not aware of production environments that use 32-bit mode on
Skylake-gen CPUs. So this should not be a concern.

Thanks,
Pawan
