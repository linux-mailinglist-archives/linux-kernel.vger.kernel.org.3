Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482164B2EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353001AbiBKUkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:40:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiBKUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:40:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B686CF5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644612029; x=1676148029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hMLogYdTPwvN7aEbRQDmMTbRpetFKlJo+PCjc3Htt4g=;
  b=SXognhXi0CDvq8MU6uuX9RkYNbtNYpJafy92aDqEjK+lVEXFrr0Sev5/
   41nW0Aw317JTl6ThxQkTtxfxCWRTNb9KQWsGYwFjJMFPP+LczuZxBihP8
   yDu1z4ZUXJVfI4FwMOqNpp/NgoQoTgwO2xE2ANTpXV/3Zjh8LfJkwN0/O
   GcxBSafkGxNmU0ByMbxvskPDE9sAgUk5T8FTw61enzPI+Ro3sqD9CWL05
   ow+5ussW9LjG0CP7DyO10yJe0GK8QTrR9becHxSonSPqlSLWubaKcxFrK
   j2J9FLGFWH9oMnPITUF1f/l7GzyQaTHTHIG1Oj49HL/scfg+1zggDvF1w
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="336228442"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="336228442"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 12:40:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="488738173"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 12:40:28 -0800
Date:   Fri, 11 Feb 2022 12:40:28 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 18/44] x86/fault: Add a PKS test fault hook
Message-ID: <20220211204027.GS785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-19-ira.weiny@intel.com>
 <2a7b0a94ea52952927c29bfc32f0085cbdfe5747.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a7b0a94ea52952927c29bfc32f0085cbdfe5747.camel@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:56:57AM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > +                * If a protection key exception occurs it could be
> > because a PKS test
> > +                * is running.  If so, pks_test_callback() will clear
> > the protection
> > +                * mechanism and return true to indicate the fault
> > was handled.
> > +                */
> > +               if (pks_test_callback())
> > +                       return;
> 
> Why do we need both this and pks_handle_key_fault()?

I debated this.  And I convinced myself that it was worth the extra code.

For this series, when testing pks_handle_key_fault() this may get called if
something goes wrong.  And when the test code is not configured it is a no-op.
So I don't see any harm in keeping this as a general handler.

I mentioned this when adding pks_handle_key_fault().[1]  I could make a note of
it in this patch if that would help.

Ira

[1] https://lore.kernel.org/lkml/20220127175505.851391-30-ira.weiny@intel.com/
