Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1550B577
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446805AbiDVKp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446804AbiDVKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:45:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E4B2619
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:43:03 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MAEJ1S010784;
        Fri, 22 Apr 2022 10:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=vIeD8Z2V/2oCs6VkOdLN5CH5TWXYC4i53djqXydyCj8=;
 b=stJy4Z0H/OOGlDtzc6iyjZQKpqL/P4Cl5ZFG2yEPKdoOHDYLxJI9++/c7+Y7vj7YFMQ+
 w3gzGu5rnSI8wIu0SWJF4ua9RnlKpFV7/1TsQIifOZoI4Qr7IVH525MOldi9A8Q4TVPf
 oGEUBYuVkZDvp3zCQJAA1OpiPWIbTc3pJXNfA8sL8dl+sM0sr1J1qDRMIiXaQrjjOLrd
 BqIoPu3oU1HVi99lLrfWtLV8Fq6zq8q5LE0bkv+Rz/i9WyMIDchxzFsW3DMgYt3V68Mx
 q7w9DXXruvnNmT4MpZNDrDy1sOTot9l6Gal0W9pfaIcDz4k8PZy4RrAP6bQHw31Wthlc gA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjswfdprm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 10:42:49 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MAFJEg004256;
        Fri, 22 Apr 2022 10:42:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3fgu6u5s0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 10:42:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MAgiic38338920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 10:42:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCB404C040;
        Fri, 22 Apr 2022 10:42:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EBCE4C046;
        Fri, 22 Apr 2022 10:42:44 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.24.148])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Apr 2022 10:42:44 +0000 (GMT)
Date:   Fri, 22 Apr 2022 13:42:42 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [stable:linux-5.10.y 2705/5321] WARNING: modpost:
 vmlinux.o(.text+0x8cc4): Section mismatch in reference from the function
 __arm_ioremap_pfn_caller() to the function
 .meminit.text:memblock_is_map_memory()
Message-ID: <YmKGohqgR21F1zpX@linux.ibm.com>
References: <202204220723.zOZ7gZGT-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204220723.zOZ7gZGT-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RuD25pj2vcAE6UeM0Lhh0FpchBErkswj
X-Proofpoint-GUID: RuD25pj2vcAE6UeM0Lhh0FpchBErkswj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_02,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=813 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:37:19AM +0800, kernel test robot wrote:
> Hi Mike,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
> head:   1052f9bce62982023737a95b7ff1ad26a5149af6
> commit: 8dd559d53b3b2de960ca1ec1359f5a9b4a12e181 [2705/5321] arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM
> config: arm-hackkit_defconfig (https://download.01.org/0day-ci/archive/20220422/202204220723.zOZ7gZGT-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=8dd559d53b3b2de960ca1ec1359f5a9b4a12e181
>         git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>         git fetch --no-tags stable linux-5.10.y
>         git checkout 8dd559d53b3b2de960ca1ec1359f5a9b4a12e181
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux.o(.text+0x8cc4): Section mismatch in reference from the function __arm_ioremap_pfn_caller() to the function .meminit.text:memblock_is_map_memory()
> The function __arm_ioremap_pfn_caller() references
> the function __meminit memblock_is_map_memory().
> This is often because __arm_ioremap_pfn_caller lacks a __meminit
> annotation or the annotation of memblock_is_map_memory is wrong.

In 5.10 the hackkit defconfig does not select ARCH_KEEP_MEMBLOCK which is
required for memblock_is_map_memory() to function after boot.

In upstream kernels ARCH_KEEP_MEMBLOCK is always selected by ARM after
commit 5e545df3292f ("arm: remove CONFIG_ARCH_HAS_HOLES_MEMORYMODEL")

So the fix would be either to backport 5e545df3292f or unconditionally
select ARCH_KEEP_MEMBLOCK on ARM in 5.10.

(the same applies to 5.4)

Greg, what is your preference?
 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

-- 
Sincerely yours,
Mike.
