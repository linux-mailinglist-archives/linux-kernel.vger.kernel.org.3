Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F065B4B2570
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349929AbiBKMPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:15:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241636AbiBKMPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:15:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34088F26;
        Fri, 11 Feb 2022 04:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644581716; x=1676117716;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/9uPAgvddq/OIc20PN1mMJ5/HsF2FnVn3dqQvYZrO/k=;
  b=GUzsK+Gma1zVOP0dS+X590qob+xADoCO2AdrAYjQAlgJByKmyH/IM/y7
   4bGo1fXP4M0x4zLAPUPw2MKSaRb7O8r/a9cmIofgfAwqdPCrSEIE3UHwJ
   eUQlD98iHbAh1jTYe1xOrS/b8ql4dX49QkpZ6/rsvTSx69nIM25PDetH2
   gfEfJxh/sEisA+0eFCV+juf4+KwZR5cgBgtMAsXmcv0EssKCcFC83Oppp
   1NjIRLkROOJmY8HQ0Og4GNgHYxiIiQdiRp//i1bJiVC6IDVxBJV/2wtTt
   sjBg2+qyVNxiktDM83bD3n8HAgKj7WNU+igAo0NaNMeTd5Ys+3riG4C1e
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249928898"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="249928898"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 04:15:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="526939904"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2022 04:15:11 -0800
Message-ID: <3f2938f7-2a9e-60e8-5237-fe7ebc3b4296@intel.com>
Date:   Fri, 11 Feb 2022 14:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>,
        'Avri Altman' <Avri.Altman@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com,
        vkumar.1997@samsung.com
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
 <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
 <DM6PR04MB657519E60FAFA19434531CE2FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <007101d81eed$4d120a60$e7361f20$@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <007101d81eed$4d120a60$e7361f20$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2022 04:15, Kiwoong Kim wrote:
>>> I think it looks hardware specific.
>>> If the feature isn't supported, I think there is no reasonto prevent
>>> from
>>                                                                                          ^^^
>> reason to
>>
>>> running other functions, such as ufshcd_queuecommand and
>> It is no longer used in queuecommand since 5675c381ea51 and 8d077ede48c1
> 
> Yeah, you're right. It's just an example. I just want to tell that the lock also protects things that are not related with clk scaling directly.
> 
>>
>>> ufshcd_exec_dev_cmd, concurrently.
>>>
>>> So I add a condition at some points protecting with clk_scaling_lock.
>> But you still need a way to serialize device management commands.
>>
>> Thanks,
>> Avri
> 
> The dev cmd execution period is protected by mutex.
> And actual ringing a doorbell is protected by spin lock.
> 
> Is there another reason to need clk_scaling_lock even with it?
> 

The error handler really should have exclusive access.  One
of the places you change does explain that:

 		 * Hold the scaling lock just in case dev cmds
 		 * are sent via bsg and/or sysfs.
 		 */
-		down_write(&hba->clk_scaling_lock);
+		if (ufshcd_is_clkscaling_supported(hba))
+			down_write(&hba->clk_scaling_lock);
