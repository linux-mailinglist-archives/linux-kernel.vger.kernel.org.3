Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39B4535D92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiE0Jpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiE0Jpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:45:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623BAFD345;
        Fri, 27 May 2022 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653644751; x=1685180751;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NZtPXWXbWh+J0k53O6m6YC3HuJ/c3n4H/bemFAIcbM4=;
  b=iXbpvEurwaBuDnkAK9sKwEXMaPopRBCrXeetrJnVqpq+G59Dvjc8brhY
   i7LUNjeqhrrYfGHJ3UX2MhL40dsDBTDZY4J7qV3z2qGgnJRuKnm0gjMlh
   BKCBVHyB3iCNF/HyhD8eXYhCbFs+iYacJqGvO+unxJcZRLjg8HgKTIGR5
   D0jHD69D8yUVbiprQCO6GIsQwj6KXmDOSepH8OQ6riLBYKoVoTAKc6pzh
   tDkBMFTBJz8P4el4TTqlA10oa3SW7/7Yi6oGuBNNmAgs22FNxS0t/BYIO
   Z9HDk2nVSd93RwkLgnJBH2YsnsPsAqNrATvb9+ejsWfMluWLGSWRRov8S
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="254310860"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="254310860"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 02:45:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="603783055"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.5])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 02:45:46 -0700
Message-ID: <3c56166a-772a-4fbc-8e3a-5ec669fd8b5d@intel.com>
Date:   Fri, 27 May 2022 12:45:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH V7 0/4] mmc: add error statistics for eMMC and SD card
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        chris@printf.net, venkatg@codeaurora.org, gdjakov@mm-sol.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com
References: <1653481701-19642-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1653481701-19642-1-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/22 15:28, Shaik Sajida Bhanu wrote:
> Changes since V6:
> 	- Rebased on Ulf's(Ulf Hansson) next branch as suggested by
> 	  Adrain Hunter.

I think maybe you re-based on the "master" branch not the "next" branch, please check

> 	- Replaced debugfs_create_file() with debugfs_create_file_unsafe()
> 	  as suggested by Adrain Hunter.
> 	- "[V6,5/5] mmc: cqhci: Capture eMMC and SD card errors" not included
> 	  in this Patch series as we don't have cqhci changes on Ulf's(Ulf Hansson)
> 	  next branch.

cqhci is in the "next" branch, please check

> 
> Changes since V5:
> 	- Considered all error stats enums to set error state.
> 	- Added missed tuning error related code changes which was
> 	  missed in patch set V5 as Adrain Hunter pointed.
> 	- Replaced DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
> 	  as suggested by Adrain Hunter.
> 	  
> Changes since V4:
> 	- Defined new macro to increment err_stats members when error occurred
> 	  as suggested by Adrain Hunter.
> 	- Called err_stats members increment function after printing the error
> 	  as suggested by Adrain Hunter.
> 	- Considered INDEX and END_BIT errors same as CRC errors as suggested
> 	  by Adrain Hunter.
> 	- Removed Null check for host in debug fs functions and Reordered
> 	  err_stats declarationas suggested by Adrain Hunter.
> 	- Removed err_state variable stuff and updated err_state debug fs entry
> 	  based on the err_stats members state as suggested by Adrain Hunter.
> 
> Changes since V3:
> 	- Dropped error stats feature flag as suggested by Adrain Hunter.
> 	- Separated error state related changes in separate patches as
> 	  suggested by Adrain Hunter.
> 	  [PATCH V4 4/7] : error state debug fs
> 	  [PATCH V4 5/7] : error state enable function
> 	  [PATCH V4 6/7] : error state enable in error case
> 	- Note: we are enabling error state before calling sdhci_dumpregs
> 	  we couldn't add the err state in error stats array as err state
> 	  is not error type.
> 	- Corrected Signed-off-by order as suggested by Bjron Andersson.
> 	- Moved error state enable code from sdhci_dumpregs to error
> 	  conditions as suggested by Adrain Hunter
> 
> Changes since V2:
> 	- Removed userspace error stats clear debug fs entry as suggested
> 	  by Adrain Hunter.
> 	- Split patch into 4 patches
> 	  [PATCH V3 1/4] : sdhci driver
> 	  [PATCH V3 2/4] : debug fs entries
> 	  [PATCH V3 3/4] : core driver
> 	  [PATCH V3 4/4] : cqhci driver
> 	- Used for loop to print error messages instead of using printf
> 	  statements for all error messages as suggested by Adrain Hunter.
> 	- Introduced one flag to enable error stats feature, if any other
> 	  client wants to use this feature, they need to enable that flag.
> 	- Moved reset command timeout error statement to card init flow
> 	  as suggested by Adrain Hunter.
> 
> Changes since V1:
> 	- Removed sysfs entry for eMMC and SD card error statistics and added
> 	  debugfs entry as suggested by Adrian Hunter and Ulf Hansson.
> 
> Shaik Sajida Bhanu (4):
>   mmc: core: Capture eMMC and SD card errors
>   mmc: sdhci: Capture eMMC and SD card errors
>   mmc: debugfs: Add debug fs entry for mmc driver
>   mmc: debugfs: Add debug fs error state entry for mmc driver
> 
>  drivers/mmc/core/core.c    | 11 +++++--
>  drivers/mmc/core/debugfs.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c   | 33 +++++++++++++++----
>  drivers/mmc/host/sdhci.h   |  3 ++
>  include/linux/mmc/host.h   | 26 +++++++++++++++
>  include/linux/mmc/mmc.h    |  6 ++++
>  6 files changed, 151 insertions(+), 9 deletions(-)
> 

