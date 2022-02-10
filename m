Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67E64B10A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbiBJOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:41:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbiBJOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:41:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E70ABCD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644504112; x=1676040112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oKLvFFIPOkAhwdM4DVcD44a/FjVoxptg+i1dfhscPkk=;
  b=PYwekzKslZLgGFEEgJXdROOaxMlcOvH5tqGvKQQg2FdVcoAGpo60h9Dy
   T1L5tfoQ0CrElX0lB0/KgcPdi/WBjjdJFcSqVmAS4L/VaCJBQzzq6kIpa
   gJzYWh2TSx6K2Vi4pKzhcIhwsva9rRz8oPDz5On+IuP5a/7kTOtiQGV4l
   qutzxeRKObIWdS7aEmcF8jShYnbNHAz1DLrDwddnlfEezSRpyfNvWny9H
   56IcKOC/SzJ2CKaxHS1AKw5ClwiUe3IbALY3NnAJUeZ6uu3QvOyukSdKG
   y1Xsw9eeYk7rdwNdwb3aUhC6163TyDa5OJCn1P5kLGIy4UDR0+ltA9DMq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249254685"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="249254685"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:41:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="679165836"
Received: from barabano-mobl.ccr.corp.intel.com (HELO [10.252.41.18]) ([10.252.41.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:41:49 -0800
Message-ID: <cc1598d7-5029-197c-9abc-49043fdc11ed@linux.intel.com>
Date:   Thu, 10 Feb 2022 16:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 9/9] ASoC: SOF: Convert the generic probe support to SOF
 client
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        fred.oh@linux.intel.com
References: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
 <20220210105519.19795-10-peter.ujfalusi@linux.intel.com>
 <YgUZKgPacRNrFk/e@sirena.org.uk>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <YgUZKgPacRNrFk/e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2022 15:54, Mark Brown wrote:
> On Thu, Feb 10, 2022 at 12:55:19PM +0200, Peter Ujfalusi wrote:
>> Add a new client driver for probes support and move
>> all the probes-related code from the core to the
>> client driver.
> 
> This breaks an x86 allmodconfig build:
> 
> /mnt/kernel/sound/soc/sof/compress.c: In function 'create_page_table':
> /mnt/kernel/sound/soc/sof/compress.c:87:9: error: implicit declaration of function 'snd_sof_create_page_table'; did you mean 'create_page_table'? [-Werror=implicit-function-declaration]
>    87 |  return snd_sof_create_page_table(component->dev, dmab,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |         create_page_table

Interesting, we have this under constant builds for months and we
certainly are building things as modules.

Let me check and fix this.

-- 
Péter
