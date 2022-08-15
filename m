Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA24859299A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiHOGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiHOGcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:32:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F54C13E34
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:32:33 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F6IVKC020298;
        Mon, 15 Aug 2022 06:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WLj5KD8YQD68yvOc+h+k5mFZY0rB7PPhZf2wVO5047E=;
 b=Ozwx1BZ/9pmChhejFIijrm/tdFxFDkMfl9ZJHrIb1Kq+PWSw3cmTf93CHG3vNZ0xdmRp
 94KdX6lVGBgt/Dkm27CmdDGkXjbVOEk9H0HW8ljL6JgtWtW3WX3ow2iLVR/Guvf5CALp
 EtHyAETHFAM+z/i/hd8ZQXLM03qCHVBFF5TVHagdqn0mKEozHQYsjAkul4p0k1AtTuZR
 Esks1gdaREevoKYhSTVINrFTkLxImcI1iEP9q7LqRjY9pEJx71H9ZKwidOjBSVXgM4Qa
 zhIcsOL56dSCu5BaWIpGU0dM19kYMBTUZswo30ZAGrSjbLGPO5sK1fEGG5dIVPncuD5Q 4w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx420magq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 06:31:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27F6VY9N027053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 06:31:34 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 14 Aug
 2022 23:31:31 -0700
Message-ID: <0190ae72-4f93-0b7e-9a73-7656dfed29f8@quicinc.com>
Date:   Mon, 15 Aug 2022 14:31:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v6] mm/page_owner.c: add llseek for page_owner
To:     "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        kernel test robot <lkp@intel.com>,
        <akpm@linux-foundation.org>
CC:     <kbuild-all@lists.01.org>, <minchan@kernel.org>, <vbabka@suse.cz>,
        <iamjoonsoo.kim@lge.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20220810013218.27416-1-quic_yingangl@quicinc.com>
 <202208101628.o6qUzx50-lkp@intel.com>
 <54f974fb-f334-78cf-d5f5-198810cc77b4@quicinc.com>
 <33d41fbd-a2ed-d2ef-4395-e18aac7c0d28@kernel.org>
Content-Language: en-US
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <33d41fbd-a2ed-d2ef-4395-e18aac7c0d28@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rh9J_LavLEotDI1MPuh7rcaJVwWmRa-3
X-Proofpoint-ORIG-GUID: Rh9J_LavLEotDI1MPuh7rcaJVwWmRa-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2022 5:40 PM, Vlastimil Babka (SUSE) wrote:
> On 8/11/22 05:02, Kassey Li wrote:
>> hi, Vlastimil:
>>
>>
>> On 8/10/2022 5:02 PM, kernel test robot wrote:
>>> Hi Kassey,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on v5.19]
>>> [also build test ERROR on next-20220810]
>>> [cannot apply to akpm-mm/mm-everything linus/master]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url:
>>> https://github.com/intel-lab-lkp/linux/commits/Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220810-093417
>>> base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
>>> config: parisc-buildonly-randconfig-r004-20220810
>>> (https://download.01.org/0day-ci/archive/20220810/202208101628.o6qUzx50-lkp@intel.com/config)
>>> compiler: hppa-linux-gcc (GCC) 12.1.0
>>> reproduce (this is a W=1 build):
>>>           wget
>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>> -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           #
>>> https://github.com/intel-lab-lkp/linux/commit/d2decd69a8d5756c1706092c805a4c8af14df471
>>>           git remote add linux-review https://github.com/intel-lab-lkp/linux
>>>           git fetch --no-tags linux-review
>>> Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220810-093417
>>>           git checkout d2decd69a8d5756c1706092c805a4c8af14df471
>>>           # save the config file
>>>           mkdir build_dir && cp config build_dir/.config
>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross
>>> W=1 O=build_dir ARCH=parisc SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>      In file included from mm/page_owner.c:16:
>>>>> mm/../fs/proc/internal.h:51:9: error: unknown type name 'proc_write_t'
>>>         51 |         proc_write_t write;
>>>            |         ^~~~~~~~~~~~
>>
>> # CONFIG_PROC_FS is not set in some arch, so we can not directly include the
>> header file.
>> +#include "../fs/proc/internal.h"
>>
>> how about add an extern  ? or do you have other suggest  ?
> 
> Hi, I replied to v5 after the bot reports:
> 
> Sorry, my suggestion (to reuse mem_lseek() from proc) was wrong as the
> kernel test bot just showed us. mem_lseek() may be unavailable without
> CONFIG_PROC_FS.
> The easiest way is to add a page_owner specific lseek function back as in
> the early version, but make it correct for SEEK_CUR. Thanks.
    OK， got this point.
> 
