Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F704B535E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355154AbiBNObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:31:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiBNObm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:31:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639D41991;
        Mon, 14 Feb 2022 06:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644849094; x=1676385094;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=TCvN5c5+MpHRPW/ZD+5q8UT9550dKUoLFTp3U6+05Rw=;
  b=bG/XaRjcqhoc6plrAsdfnY5LAOc5uSPS9WW/kykTzkYNC05VC8VD46/X
   14ki7lUbxC9D/KusS7sBnztG2WgiLuSd2Pqn1EPXsB6cMvvOpMGQuNsfE
   naVLnGCaMxjuw7zIpHRTdy7MEcnzRZzLFmpDyQ2+MAaLW1KoPozjwTeVK
   AhPIbN60dA9IcRGOW/zjcrJ8qdW+J/XXkKvQTKrCwhv8YRr5ypGE9Ga6D
   rJlp9cfTRVxIbGvCglGqmoxsK5Fa4ICnZJYSsICNlZ9/ENfggjGfsWdfh
   c2mVmLNPZSK97vYUu1lCWq0rtKskoOuYPXGGGrb0eZdIQXHfPe57q1NB3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="233647302"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="233647302"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:31:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="495679213"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2022 06:31:29 -0800
Message-ID: <366a3afc-071f-ae77-d06d-25ad750976dc@intel.com>
Date:   Mon, 14 Feb 2022 16:31:28 +0200
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
 <3f2938f7-2a9e-60e8-5237-fe7ebc3b4296@intel.com>
 <000001d81fcb$3b962f30$b2c28d90$@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <000001d81fcb$3b962f30$b2c28d90$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2022 06:44, Kiwoong Kim wrote:
>> The error handler really should have exclusive access.  One of the places
>> you change does explain that:
>>
>>  		 * Hold the scaling lock just in case dev cmds
>>  		 * are sent via bsg and/or sysfs.
>>  		 */
>> -		down_write(&hba->clk_scaling_lock);
>> +		if (ufshcd_is_clkscaling_supported(hba))
>> +			down_write(&hba->clk_scaling_lock); 
> 
> 
> Yeah.., I saw the comment but didn't get why.
> 
> Is there anyone who knows why it's necessary for all SoCs?
> At lease, I know there is no reason to forbid concurrent executions of dev cmd and power mode change.
> 
> If there's nothing, how about adding a quick to ignore it?

Is it worth it?

The error handler really should have exclusive access.
Have you considered, for example, races of ufshcd_reset_and restore() and dev commands, tm commands, UIC commands.
I suspect more locking is needed not less.
