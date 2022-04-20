Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405C950864F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377806AbiDTKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiDTKvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:51:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18F318381;
        Wed, 20 Apr 2022 03:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650451713; x=1681987713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yiWtHyh0+dkP7vvS/980PY5qigFMLm0paOIezN2buEA=;
  b=nydwTQ2fk6jOPIuWHNDYmBHVdpwaaq6aLWjsNMcdRraSAvufjSpRgtM+
   dJVP13/UjdPMBKV1kgJNW9lT5KIn6c1fAb1BpTEqIIFjbA4Iz8e/DfCdo
   7DAC1MwKkROXhB5p8GaRdhIn7H6M5Thy6R5mvex4dSB5L8Q2vGZWYm7SF
   rg5nZpOqiX/+0VhKBZieXFdd2lepK56ALLPJ60G0LtqJBiUYjk/cEOo9H
   3DusgwqeyjW5AhoFaFLKseK+9CumDFQNA8lhrBvJ4/t+c+fo7O14eVDNU
   ZpQV4qHiMIYI/h17tCPqWNXfzfNdUNVT2/YHfovqlT8GFNhdQrg9y3MYM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350446355"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="350446355"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 03:48:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="593132230"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 03:48:30 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Apr 2022 13:45:32 +0300
Date:   Wed, 20 Apr 2022 13:45:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: linux-next: manual merge of the kunit-next tree with the
 thunderbolt tree
Message-ID: <Yl/kTEZxet0fLPj4@lahna>
References: <20220420151612.117f84b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420151612.117f84b9@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Apr 20, 2022 at 03:16:12PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kunit-next tree got a conflict in:
> 
>   drivers/thunderbolt/test.c
> 
> between commit:
> 
>   9d2d0a5cf0ca ("thunderbolt: Use different lane for second DisplayPort tunnel")
> 
> from the thunderbolt tree and commit:
> 
>   7aadf8433357 ("thunderbolt: test: use NULL macros")
> 
> from the kunit-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The fixup looks good to me, thanks!
