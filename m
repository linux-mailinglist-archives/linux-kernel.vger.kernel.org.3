Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480BA54ED25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378746AbiFPWLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFPWLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:11:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD03B61296;
        Thu, 16 Jun 2022 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655417462; x=1686953462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ulGVt/Fg7JPQd5zppcun4FREfJet3CM9109arLOZJME=;
  b=bxS2j0+mKoMtEI7ywC4nvTG+a1fvh31T4pPQZbfSv5Pc18fb92WU8vFH
   xZoqbnNGHYVMeIbETo5jTLPwj7P1xulgVGNHosPddQbM6PH/vTyF3EH13
   wGyG9Ssna4541ZVXU8BQ+lLfMiwESr/8juxMtz97hGpeJ88pvMjFXBsKC
   k123vh9bNTXEHr9RrDbQZ+m5gHhD77u+kN3+WXq4SOKsPPx3ROQgs0jQv
   FojqWje4Sq+HY6P9bkf8o/pRZeZi26W0F3/86hL9us83ne+nHuBD8fqvk
   isNFtDCFM3p/BtXAYMCFSf1RSUOf9kT2PXFC3MW7ITwIuVJwSHl7DXO9P
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280396276"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280396276"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:11:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831757106"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:11:01 -0700
Date:   Thu, 16 Jun 2022 15:10:41 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220616221041.GA1529592@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220616194334.pvorvoozt4rrzr66@offworld>
 <20220616203400.GA1529208@alison-desk>
 <20220616214740.7pyjagx3gosni7mw@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616214740.7pyjagx3gosni7mw@offworld>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David - you make lots of good points, one quick comments at end...

On Thu, Jun 16, 2022 at 02:47:40PM -0700, Davidlohr Bueso wrote:
> On Thu, 16 Jun 2022, Alison Schofield wrote:
> >I'm headed in this direction -
> 
> I like these interfaces, btw.
> 
> >cxl list --media-errors -m mem1
> >	lists media errors for requested memdev
> 
> But in this patchset you're only listing for persistent configurations.
> So if there is a volatile partion, or the whole device is volatile,
> this would not consider that.
> 
> So unless I'm missing something, we need to consider ram_range as well.
> 
> >cxl list --media-errors -r region#
> >	lists region errors with HPA addresses
> >	(So here cxl tool will collect the poison for all the regions
> >	 memdevs and do the DPA to HPA translation)
> 
> I was indeed thinking along these lines. But similar to the above,
> the region driver also has plans to enumarate volatile regions
> configured by BIOS.
> 
> >
> >To answer your question, I wasn't thinking of limiting
> >the range within the memdev, but certainly could. And if we were
> >taking in ranges, those ranges would need to be checked.
> 
> My question was originally considering poisoning only within pmem DPA
> ranges, but now I'm wondering if all this also applies equally to volatile
> parts as well... Reading the spec I interpret both, but reading the
> T3 Memory Device Software Guide '2.13.19' it only mentions persistent
> capacity.
> 
> >
> >$cxl list --media-errors -m mem1 --range-start=  --range-end|len=
> 
> I figure this kind of like the above with regions being very arbitrary
> and dynamic.
> 
> >Now, if I left the sysfs interface as is, the driver will read the
> >entire poison list for the memdev and then cxl tool will filter it
> >for the range requested.
> >
> >Or, maybe we should implement in libcxl (not sysfs), with memdev and
> >range options and only collect from the device the range requested.
> 
> I wonder if the latter may be the better option considering that always
> scanning the entire memdev would cause unnecessary media scan wait times,
> specially for large capacities.

This is not a Media Scan. This is only reading the existing Poison List.

> 
> Thanks,
> Davidlohr
