Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F27058CF6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244432AbiHHUxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiHHUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:53:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830F515FD1;
        Mon,  8 Aug 2022 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659992023; x=1691528023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Ue2xN40eUBwKJ8OkKXT1hJPXDlo2/nde1JLXmk8FQ0=;
  b=JRy9JnRdmx0Ol6vN/h9Rz9SDrbOYz7nKUQwFOk/Dq+O2PIFPUgwgO42v
   tV0OGCMxWrudP5V8h6YN5PloEtQOlowdSNR4DlaBk7gwnLIvCGfT7RDz5
   CU4FFLNcdYcFVydxQh43z61l9fZxwnJMgrlwrZQxlwvZg8mI2S277IGo+
   IEfc3Q9F87RIy9B2tOv3oF3EF75jT+iCVLt4TWKnGqe/6kmWWZaK/VUc8
   +93faYhO6I47XanyDRrF5Y0IiJEzyKixxNSrGw34VhNQRo5o3yyZA+bYW
   XwX3cZPgDYsm39AxVBIY5kECH9KyiS1Zy6c51PEahqPgbV4TNC+OsNP0E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="354690526"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="354690526"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:53:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="850224595"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:53:32 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 00C38200F1;
        Mon,  8 Aug 2022 23:53:30 +0300 (EEST)
Date:   Mon, 8 Aug 2022 20:53:30 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-acpi@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [ACPI] 1d52f10917: BUG:KASAN:use-after-free_in_strlen
Message-ID: <YvF3ynw8CmisQAR6@paasikivi.fi.intel.com>
References: <Yu+z9IMoxRrDTjpd@xsang-OptiPlex-9020>
 <57f48ba3-d01c-f3d8-8e33-65d3cd9a349e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f48ba3-d01c-f3d8-8e33-65d3cd9a349e@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Mon, Aug 08, 2022 at 06:54:49PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On 8/7/2022 2:45 PM, kernel test robot wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-11):
> > 
> > commit: 1d52f10917a751f90e269a0ed9b6cca60dbe0300 ("ACPI: property: Tie data nodes to acpi handles")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: xsave-test
> > version: xsave-test-x86_64-c2e44fa-1_20220609
> > with following parameters:
> > 
> > 	ucode: 0xec
> > 
> > 
> > 
> > on test machine: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 16G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> The crash below occurs right after a "Can't tag data node" message from
> acpi_tie_nondev_subnodes() and I'm really unsure why acpi_attach_data() has
> failed here, because none of the arguments is NULL.
> 
> Can you have a look at this, please?

Thanks for forwarding this to me.

Faulty error handling code appears to be the direct cause for the crash. It
releases buf.pointer which was still being used by the properties --- even
if tagging data nodes failed (for whatever reason).

It'd be cool if someone could send me DSDT/SSDT from this machine. I wonder
if there's a data node that is referred to from more than one location, and
whether that could lead to two references to the same acpi_handle. I'd hope
this could be disallowed in DSD Guide.

I'll send a patch soon.

-- 
Kind regards,

Sakari Ailus
