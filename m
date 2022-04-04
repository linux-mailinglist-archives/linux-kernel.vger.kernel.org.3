Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0917D4F1226
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354445AbiDDJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355515AbiDDJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:38:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D6730542;
        Mon,  4 Apr 2022 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649064979; x=1680600979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z66BBs6gd1wX1NuShMNR221afgtnYZTW8DgJ5qOqV3Y=;
  b=eT2H/knZ5YlHmkJk+RzuJgnTRWX2TyaouWHm49QnsSONrCnPSHL+XXAn
   6+8oaezJ81FhVrvhuKGn3Mo3ldy5QZKtL0aEa2mHAueoWyByqjYjoaEGg
   lVR6TR9LEqTQpCYe/rDYKssj0yYTjW0lfWIvdaRzwtGeqpmb5fcAR8OHA
   LZZ08SO400FjgOULaH+uc90nnU9vl2+Ad9h9kSsn/7ripy2FGAlP2d+IN
   c0A/KCuQwTeLjtUODdwJpPKIui0nMiVXXPSpI8aQnX7mn1rLPQ03PHL7/
   T2f/SmCv8k9anbYwcJ1v41vJ0eST1/GFjO6TY0FE/PSNbReSXpaio4ptY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="247988806"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="247988806"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 02:36:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="504845794"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 02:36:15 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Apr 2022 12:36:12 +0300
Date:   Mon, 4 Apr 2022 12:36:12 +0300
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
Message-ID: <Ykq8DEz6/kQBMzmF@lahna>
References: <20220324072700.63787-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324072700.63787-1-jakobkoschel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Applied to thunderbolt.git/next, thanks!
