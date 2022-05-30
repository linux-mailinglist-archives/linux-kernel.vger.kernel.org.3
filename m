Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50E6537643
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiE3IMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiE3IMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:12:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320F02B25E;
        Mon, 30 May 2022 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653898354; x=1685434354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UW2XlZJzOKPS83cwNKMUi+nCO2c0h/TbOksSKi9tH78=;
  b=Q9+3yRoIAFY9NIyAzJg5DRzQ2s3lDRvwrctJLR/WGUME7byq2yqohPtH
   28zEWobtBkz731CBpusz1XlRK1rvwLKcjF83i1x8PW4MGDWbfCW+W0kik
   IK5pVr7w+Rh/m4DsFozGCa72iPZWEFuXrLF22PZzDi92aF4qVPY33Rc2X
   DQOd9cupunTuQ1RVzyu7H0Tf0+09PiYOxZibHktO1UtbRxDZaHv1fusjr
   H3eEYwUZUB0K2EVUB0TCnLxPIajQM8T/3vVfk3rbtTuPzQ5LpmUyOZ5T0
   2WAN+1201bxjdnhtfWOAzn0h1zJ2mbgTRNnoLqzM8WqfTzscuLcxKRRXk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="254806549"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="254806549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 01:12:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="605069646"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.117])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 01:12:26 -0700
Message-ID: <a8efe257-6a33-0f33-4aa5-000a19e2d046@intel.com>
Date:   Mon, 30 May 2022 11:12:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH V8 0/5] mmc: add error statistics for eMMC and SD card
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        shawn.lin@rock-chips.com, yoshihiro.shimoda.uh@renesas.com,
        digetx@gmail.com, quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com
References: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/22 20:53, Shaik Sajida Bhanu wrote:
> Changes since V7:
> 	- Patch set V6 rebased on Ulf's(Ulf Hansson) master branch instead
> 	  of Ulf's (Ulf Hansson) next branch by mistake. So rebased patch
> 	  set on Ulf's next branch now as suggested by Adrain Hunter.
> 

Looks good, thank you.

> Changes since V6:
> 	- Rebased on Ulf's(Ulf Hansson) next branch as suggested by
> 	  Adrain Hunter.
> 	- Replaced debugfs_create_file() with debugfs_create_file_unsafe()
> 	  as suggested by Adrain Hunter.
> 	- "[V6,5/5] mmc: cqhci: Capture eMMC and SD card errors" not
> 	  included in this Patch series as we don't have cqhci changes
> 	  on Ulf's(Ulf Hansson)next branch.
> 
> Changes since V5:
> 	- Considered all error stats enums to set error state.
> 	- Added missed tuning error related code changes which was
> 	  missed in patch set V5 as Adrain Hunter pointed.
> 	- Replaced DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
> 	  as suggested by Adrain Hunter.
> 	  
> Changes since V4:
> 	- Defined new macro to increment err_stats members when error occured
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
> Shaik Sajida Bhanu (5):
>   mmc: core: Capture eMMC and SD card errors
>   mmc: sdhci: Capture eMMC and SD card errors
>   mmc: debugfs: Add debug fs entry for mmc driver
>   mmc: debugfs: Add debug fs error state entry for mmc driver
>   mmc: cqhci: Capture eMMC and SD card errors
> 
>  drivers/mmc/core/core.c       | 10 +++++-
>  drivers/mmc/core/debugfs.c    | 79 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci-core.c |  9 ++++-
>  drivers/mmc/host/sdhci.c      | 59 ++++++++++++++++++++++++--------
>  drivers/mmc/host/sdhci.h      |  3 ++
>  include/linux/mmc/host.h      | 26 ++++++++++++++
>  include/linux/mmc/mmc.h       |  6 ++++
>  7 files changed, 175 insertions(+), 17 deletions(-)
> 

