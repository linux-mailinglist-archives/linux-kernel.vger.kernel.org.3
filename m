Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3FC550317
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 07:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiFRFzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 01:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiFRFzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:55:52 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D32B3C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 22:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655531752; x=1687067752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FDvypuKshD2tJX7p4O/SIVh6mhDa1g35QqNCGSIqRG0=;
  b=JaitdLC0uRdPU/cU8EkDf2UHxrFXRGkvFYIFxoDXU4P9IAxg8WCmbRuc
   ADbCHbIXMsXksmsH4lP2fi2vOJQwqXtFiloaug/HOE1yAm23SdLc5I4m9
   Y3BnBk4DlGSANqVHP1n6LOQeBGYN96lTAE/SY2/0gvu18yhiesbGjCqQJ
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Jun 2022 22:55:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 22:55:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 17 Jun 2022 22:55:51 -0700
Received: from [10.216.6.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 17 Jun
 2022 22:55:48 -0700
Message-ID: <5ec7b561-551b-f02a-9b7b-65d05ccdabbc@quicinc.com>
Date:   Sat, 18 Jun 2022 11:25:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: mm/madvise.c:1438:6: warning: Redundant assignment of 'ret' to
 itself. [selfAssignment]
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Michal Hocko <mhocko@suse.com>,
        "Minchan Kim" <minchan@kernel.org>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202206180617.UzO7ymnD-lkp@intel.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <202206180617.UzO7ymnD-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 6/18/2022 4:34 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
> commit: 5bd009c7c9a9e888077c07535dc0c70aeab242c3 mm: madvise: return correct bytes advised with process_madvise
> date:   3 months ago
> compiler: mips-linux-gcc (GCC) 11.3.0
> reproduce (cppcheck warning):
>         # apt-get install cppcheck
>         git checkout 5bd009c7c9a9e888077c07535dc0c70aeab242c3
>         cppcheck --quiet --enable=style,performance,portability --template=gcc FILE
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> cppcheck warnings: (new ones prefixed by >>)
>>> mm/madvise.c:1438:6: warning: Redundant assignment of 'ret' to itself. [selfAssignment]
>     ret = (total_len - iov_iter_count(&iter)) ? : ret;

Other way to avoid this warning is by creating another local variable
that holds the total bytes processed. Having another local variable to
get rid off some compilation warning doesn't seem proper to me. So,
leaving this warning unless you ask me to fix this.

Thanks,
Charan
