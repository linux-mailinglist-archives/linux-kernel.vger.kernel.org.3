Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC658FA2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiHKJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHKJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:40:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D5174E3F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEFA66119D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48850C433D6;
        Thu, 11 Aug 2022 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660210838;
        bh=q/v3dg67akdikMYOPlR6gnL028wD7LycKf4a1kmvX/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E7ayhDL52bXNsVrHoUoyQ+wAZTeoQifLoV2Q4j53SPWNLt+B4oGEld0OCpWBv3m4M
         MRdCcNQWMkMOgnqbkXIzXYESAxfuPjpP+i2xyIJcAYz1D+AnKjugGeK6JaVExqybUk
         cSsdrpQsrNWpdG1iGGCltAJ5ZnhZKrKb0CNPv+4r2suTy+mSRhOcRi/RK4SMR++KdR
         FO8pQAEGor1lVJorzA00qlrJwehxOXAQZiIb0dNzstoMxS/0wRLpzYd4MwvAqZ1SQY
         +HR5qDsEBw9/k1atUUZwnGqjRyET5xfAfkHQg799YyQUybMgCLVqgUIb5EEmdYkMVu
         aBdCEWsDlCDPw==
Message-ID: <33d41fbd-a2ed-d2ef-4395-e18aac7c0d28@kernel.org>
Date:   Thu, 11 Aug 2022 11:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v6] mm/page_owner.c: add llseek for page_owner
Content-Language: en-US
To:     Kassey Li <quic_yingangl@quicinc.com>,
        kernel test robot <lkp@intel.com>, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, minchan@kernel.org, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220810013218.27416-1-quic_yingangl@quicinc.com>
 <202208101628.o6qUzx50-lkp@intel.com>
 <54f974fb-f334-78cf-d5f5-198810cc77b4@quicinc.com>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <54f974fb-f334-78cf-d5f5-198810cc77b4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 05:02, Kassey Li wrote:
> hi, Vlastimil:
> 
> 
> On 8/10/2022 5:02 PM, kernel test robot wrote:
>> Hi Kassey,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on v5.19]
>> [also build test ERROR on next-20220810]
>> [cannot apply to akpm-mm/mm-everything linus/master]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:   
>> https://github.com/intel-lab-lkp/linux/commits/Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220810-093417
>> base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
>> config: parisc-buildonly-randconfig-r004-20220810
>> (https://download.01.org/0day-ci/archive/20220810/202208101628.o6qUzx50-lkp@intel.com/config)
>> compiler: hppa-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          #
>> https://github.com/intel-lab-lkp/linux/commit/d2decd69a8d5756c1706092c805a4c8af14df471
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review
>> Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220810-093417
>>          git checkout d2decd69a8d5756c1706092c805a4c8af14df471
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross
>> W=1 O=build_dir ARCH=parisc SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from mm/page_owner.c:16:
>>>> mm/../fs/proc/internal.h:51:9: error: unknown type name 'proc_write_t'
>>        51 |         proc_write_t write;
>>           |         ^~~~~~~~~~~~
> 
> # CONFIG_PROC_FS is not set in some arch, so we can not directly include the
> header file.
> +#include "../fs/proc/internal.h"
> 
> how about add an extern  ? or do you have other suggest  ?

Hi, I replied to v5 after the bot reports:

Sorry, my suggestion (to reuse mem_lseek() from proc) was wrong as the
kernel test bot just showed us. mem_lseek() may be unavailable without
CONFIG_PROC_FS.
The easiest way is to add a page_owner specific lseek function back as in
the early version, but make it correct for SEEK_CUR. Thanks.

