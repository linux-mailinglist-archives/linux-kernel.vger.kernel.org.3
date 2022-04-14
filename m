Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36500501779
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbiDNPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352018AbiDNObq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:31:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492F3C12F1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649946170; x=1681482170;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wcOZ08M12WSd63gaezIShH6Ul4Xo33/RqAiEoJUbfpM=;
  b=BAuk0CLRAF68TyhSajEVm41chwDHij6U3D6swD+wNJQF2QLFHCcSiQrH
   eYZy+66ZDjJ4eGVx3qx+t6Eku2HiPg+Wc1fz6PdfOz82UTz3fLicTmk0q
   iWeE1zQkHN9MjXx3ObL3euDXerQpoROdmTMkPY85Di+LvT/CfqBRq7uYV
   /149n+CcmE+xqToJFaquQfAGzXlOEDqydbl0bY6SYOlhiF2KaTuqx/JnM
   WJN198PEVpp77XMqnNBe5qLY7nIzqRfHUoPwGkn0NVi2dx7DE74/8oLhC
   bAMdEyiAzxyGR5n7rfFMYhwfbj+94Cz7z/fKX45jnmPh1IpY9DtmPO8W8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262383629"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="262383629"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 07:22:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="573817803"
Received: from nplaweck-mobl.ger.corp.intel.com (HELO localhost) ([10.249.149.236])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 07:22:47 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 0/1] add support for enum module parameters
In-Reply-To: <YlgfXxjefuxiXjtC@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220414123033.654198-1-jani.nikula@intel.com>
 <YlgfXxjefuxiXjtC@kroah.com>
Date:   Thu, 14 Apr 2022 17:22:47 +0300
Message-ID: <87a6cneoco.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Thu, Apr 14, 2022 at 03:30:32PM +0300, Jani Nikula wrote:
>> Hey, I've sent this before, ages ago, but haven't really followed
>> through with it. I still think it would be useful for many scenarios
>> where a plain number is a clumsy interface for a module param.
>> 
>> Thoughts?
>
> We should not be adding new module parameters anyway (they operate on
> code, not data/devices), so what would this be used for?

I think it's just easier to use names than random values, and this also
gives you range check on the input.

I also keep telling people not to add new module parameters, but it's
not like they're going away anytime soon.

If there's a solution to being able to pass device specific debug
parameters at probe time, I'm all ears. At least i915 has a bunch of
things which can't really be changed after probe, when debugfs for the
device is around. Module parameters aren't ideal, but debugfs doesn't
work for this.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
