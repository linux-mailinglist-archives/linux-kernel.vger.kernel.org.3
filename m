Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FD51822A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiECKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiECKXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:23:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A55E1F609;
        Tue,  3 May 2022 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651573181; x=1683109181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WWmxPy/hQ2RBcT44220QL2peVg+5TXMnh7tgawaw6vI=;
  b=kJOxOQAjcnr6H9LLH46SGSQox9DVoRsBHPMLb3GEYl/9IErwvUjkco5Z
   qXJFSROm3hqORnpfifbBi4nyVNyWUht4BcCDUYIks5OYFHJk52nyvM1tT
   UBsdUFcDI1UBL3OJSGlAwlMcVBcjgAsbqL90IZBcj3npuMdgRhEYM/uSz
   0mLCIrbwztMtg9zVrD5CN1vLO6SrwIN8PRjKIsDAhAIbuGke86b75NW2K
   dxUs/RC9rRqjdfXyMByj6SxNf514M/LJ9H3sYJsGVY0i7UHzLKAwg/1K4
   j2MyRlk/gs3lUF0Jv2ZuZZZTeNFli7Z74DHHnIpAXBHwrF9HjgW6oJOkl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247989941"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="247989941"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 03:19:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="599008141"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 03:19:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nlpd1-00BOyD-2M;
        Tue, 03 May 2022 13:19:35 +0300
Date:   Tue, 3 May 2022 13:19:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Allen Pais <apais@linux.microsoft.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/1] firmware: tee_bnxt: Use UUID API for exporting
 the UUID
Message-ID: <YnEBtk4ltlsep5/m@smile.fi.intel.com>
References: <20220412113250.57997-1-andriy.shevchenko@linux.intel.com>
 <e9c81a3d-d03a-5b13-ee14-9ba6103093f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c81a3d-d03a-5b13-ee14-9ba6103093f7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:38:41AM -0700, Florian Fainelli wrote:
> On 4/12/2022 4:32 AM, Andy Shevchenko wrote:
> > There is export_uuid() function which exports uuid_t to the u8 array.
> > Use it instead of open coding variant.
> > 
> > This allows to hide the uuid_t internals.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v3: rebased on the latest vanilla, added Andrew since it has no move for 1y+
> 
> I don't think this is going to be picked up unless we designate a entry in
> the MAINTAINERS file, I don't mind taking this via the Broadcom ARM SoCs
> pull request if this does not move.

I saw your patch has been picked up to up-to-date MAINTAINERS record.
Can this one now be picked up too?

-- 
With Best Regards,
Andy Shevchenko


