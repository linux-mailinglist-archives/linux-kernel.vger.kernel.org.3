Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9F4E632F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbiCXMVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbiCXMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:21:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9560C35262;
        Thu, 24 Mar 2022 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648124399; x=1679660399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ZFdlgkUlrg1RA91ERKHsxNCJjmhkRGWCp0W1Zaki/Y=;
  b=nnlwdpRcLsjLo2Du/2k2x2MC3WjPhThQ3zV9lvjOU9HgsNjzcE0QILDq
   w9wndo0vRYJXP0F1/c2Vf1t3gNHIPXNpjYaTlKdKikPHRTU8fJdZHOu8d
   f7S+OROnQhRVU/lgEFUKaTrFmQMBJlQsSn4FxmuU1X5+V0Sk8GVcRN3h1
   gP1JOLnfH0PNt8qB6URAIpN8tr9Ha8n0HXVVdaUyncyw/gtuePSuHZDIs
   tWZYFOOWv+gahtQvtuk4DIgOvOSItZ5cN6b/2/Nvh1iGPoziUBH1DpB6n
   xzLm1CekQgzgGYfxgt+AfRkOo8SjY4Hn7Q0DZKVe05Ny14FD+hr4vu0Rr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="321561461"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="321561461"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:19:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="649834499"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:19:55 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 24 Mar 2022 14:19:52 +0200
Date:   Thu, 24 Mar 2022 14:19:52 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] thunderbolt: replace usage of found with dedicated list
 iterator variable
Message-ID: <Yjxh6Md0F955FC4A@lahna>
References: <20220324072700.63787-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324072700.63787-1-jakobkoschel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

On Thu, Mar 24, 2022 at 08:27:00AM +0100, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Looks good to me. I will pick this up to Thunderbolt tree after the
merge window closes.
