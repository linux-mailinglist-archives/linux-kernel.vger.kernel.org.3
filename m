Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E63358211C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiG0Hbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiG0Hbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:31:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC6541989;
        Wed, 27 Jul 2022 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658907098; x=1690443098;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=z69HSat8Qj8N9Swm2OyvSJng4HnatU7uq+BtNwOD/fg=;
  b=laJvjcb396m+0dkvuv0KA1DVnU/0EY264MxMHg3KLLlOkqcQn1ZfoYNn
   avecNee2pyDFgr0wRPwCPPtbXekCyEESRaJi+6D20bEzweuxLqUGztHtU
   9/8vBt5UbZkTBHuU7JCCYvGvcGDkfCpbRnO9a39HjImC8YoTI/aslefek
   Yc5JyJNX2fcPWas+KwhGkmpvRXLPYqSY8fen1gzTnK1+Hn5tro5n12Fee
   57gq/PB54ZMsYxf8hdhmJGtjH2ACzPH97OZtmNTJcQBJZ0iCB7Ib5sAa0
   n8NfAsJym3oTydHvqAtUj9hstpzHC2vSupPHi2GlSTUWu1de82CkHXfrH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="267935419"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="267935419"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:31:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="659079055"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.171.125]) ([10.249.171.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:31:34 -0700
Subject: Re: [kbuild-all] Re: [PATCH v2 3/5] thermal: qcom: tsens: Add driver
 support for re-initialization quirk
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220724122424.2509021-4-bhupesh.sharma@linaro.org>
 <202207260755.tUajnfB4-lkp@intel.com>
 <f1e7ac3b-e3e3-4843-2a07-f9f05b49c2b9@linaro.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <55ee862c-ab22-04e3-c24e-7c9d099bb4da@intel.com>
Date:   Wed, 27 Jul 2022 15:31:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f1e7ac3b-e3e3-4843-2a07-f9f05b49c2b9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2022 7:38 PM, Bhupesh Sharma wrote:
> Hi,
> 
> On 7/26/22 4:40 AM, kernel test robot wrote:
>> Hi Bhupesh,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on rafael-pm/thermal]
>> [also build test ERROR on linus/master v5.19-rc8 next-20220725]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    
>> https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546 
>>
>> base:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git 
>> thermal
>> config: ia64-randconfig-r005-20220724 
>> (https://download.01.org/0day-ci/archive/20220726/202207260755.tUajnfB4-lkp@intel.com/config) 
>>
>> compiler: ia64-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://github.com/intel-lab-lkp/linux/commit/2356630fadc0a622264bf292b6930f8c728b0709 
>>
>>          git remote add linux-review 
>> https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review 
>> Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546 
>>
>>          git checkout 2356630fadc0a622264bf292b6930f8c728b0709
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 
>> make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     ia64-linux-ld: drivers/thermal/qcom/tsens.o: in function 
>> `tsens_probe':
>>>> tsens.c:(.text+0x6d2): undefined reference to `qcom_scm_is_available'
>>     ia64-linux-ld: drivers/thermal/qcom/tsens.o: in function 
>> `tsens_health_check_and_reinit.constprop.0':
>>>> tsens.c:(.text+0x10c2): undefined reference to `qcom_scm_tsens_reinit'
> 
> It seems you have missed picking up [PATCH 1/5] firmware: qcom: scm: Add 
> support for tsens reinit workaround before running the checks on this 
> patch which is a part of this series itself (see [1]).

Hi Bhupesh,

Thanks for the feedback, the bot applied the full patch set to test,
please see

 
https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546 


Maybe the bot chose a wrong base branch to apply which caused the
unexpected issue.

Best Regards,
Rong Chen

> 
> If I pick the PATCHes in the right order [PATCH 1/5], [PATCH 2/5] 
> followed by [PATCH 3/5], I don't see the compilation error being 
> reported (even with W=1 build options).
> 
> [1]. 
> https://lore.kernel.org/linux-arm-msm/20220724122424.2509021-2-bhupesh.sharma@linaro.org/ 
> 
> 
> Thanks,
> Bhupesh
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
