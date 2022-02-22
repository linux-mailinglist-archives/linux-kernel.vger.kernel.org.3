Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7AD4BF73F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiBVL3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiBVL3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:29:20 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C445119F3B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645529334; x=1677065334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=22s64pPkLyr+0ZWbGZKHvi8KgP+D+DT+YS06UkMmvys=;
  b=nFE9009oT9WDyOcTT6SJaecYWjMG1dyvO9m6dmDnZBWEPCANcUiJ57nr
   zr2OIWP1+j9Y4W+RqvYXZnBn9U/YEG0CagieShtBPgktnERjlFSLKwGZL
   jDIWMupSTX5zCueLLjuxK3JO/c/0/RjZ35Uoxof5cjOtWEhKRU/P6WYxL
   mOTBoC4a9bWPlIJRSC/FyRBFRJ3ZNbHZN7mivpkG/01an6YvRUnoCidxw
   nAN3otsQAz7PKo4x8VFmO3xQZTaOjN05DFL3jEEaRzTehXyBPjTuPupjn
   eDgieOtu4P+LKU0uYRgO+ZBimUOyQaB0F4aNxHT+Z4+SmhBJ9kFlJd87X
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,387,1635177600"; 
   d="scan'208";a="297744962"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2022 19:28:54 +0800
IronPort-SDR: 0k2W1jkPaj0PSiqO4Ili0qtcpFwk66PnL4gBWmp7/L1N621i3O/U2K6lFfyo1bS44uattcQiu3
 QpvoC1ITJ7FS+5NGw6Qwfuk4TBEO97x9EEVg7XM7eGEmk8GMH8dhpC7+dxWImMs2+MuFa+GnHE
 2ogotEdZmWUpue7KIJm5+wox/2aBEb9MYucrn2IkfsEaIWVBcqB5vWo3/QzV6RYO1sE7sf71AP
 rxBUsd+4pKBXHSYV58RgTmmDOnW70N3pBMLWIfY4lePw8o9db1UNPHJcYyZrgCjqPRgoDXJudT
 OltZYhdYPaNIT5z1xbWj90vG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 03:00:27 -0800
IronPort-SDR: 14GJXyR3UujfBPJ9vwjKG3oEC4gLr4tU2+Bir2oEmQBINI8FOnFzCynW3e4QmboSUkr8uu10wS
 6dQQncoiqKnAWcBvzCS+NiDtSYuCnx0XW5zjX6DjbjK0qHktOcPXyTtWqBreg0Ce190L8xeSWe
 Vy/LxcFkXOhZNuWS+9eZJ7e5UVtoMuZWdJREhsDsamJbm7289xhy+WXQSEG2AE2aX9A/AR85qE
 uhjGUF8qniRo9Q/zVNxPOQlsgg2colCXeNMp3Ki+gbKtu1BPCfnOcSFjjg7L2xxzfd2btQzDYu
 aXc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 03:28:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K2xkt09k1z1SVp2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:28:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645529333; x=1648121334; bh=22s64pPkLyr+0ZWbGZKHvi8KgP+D+DT+YS0
        6UkMmvys=; b=Hdt45hR/K/OF6n7XJxEICpDY65ZhiVrVNnkZEvRK4lAJXSuHHfN
        LRxo3L/XrQowA2Mi9D+4zL7Dn5m0nCQjvjIFjhgwahtZvbSYrmtQW6X1KqRU3hLm
        VepGBWBGmWMvL1qlKh3u3vUUFyDjSvXyoA9hkj19gXY6A89tY9Ea7cGEcG+2cLoD
        Ro3gs8uUpAL5kQi+e7bwb8VlcyH/jgyWfgO0gy3aQmQEnu/dQLSDpwy+nV5sVo51
        Al2ZCnhcvvJZhg4tudA9rFwBMgl5FS6N8zqfNraANBHSVuDTbf14ss+NcUpb2xDj
        MVS+SGPlGVUvmHNv88YvE3mBqyJx+uxTNcA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lrMUoVMjt7KT for <linux-kernel@vger.kernel.org>;
        Tue, 22 Feb 2022 03:28:53 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K2xkr0wdSz1Rvlx;
        Tue, 22 Feb 2022 03:28:51 -0800 (PST)
Message-ID: <276308f0-e45e-243a-0058-96c3cf6558f5@opensource.wdc.com>
Date:   Tue, 22 Feb 2022 20:28:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [mkp-scsi:for-next 93/154] hisi_sas_main.c:undefined reference to
 `sas_execute_ata_cmd'
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        kernel test robot <lkp@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <202202221427.OvZeGfzt-lkp@intel.com>
 <59b538b7-b4c5-8111-d2bf-7fb353ecb19b@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <59b538b7-b4c5-8111-d2bf-7fb353ecb19b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 18:10, John Garry wrote:
> On 22/02/2022 06:52, kernel test robot wrote:
> 
> Hi Martin,
> 
> Sorry about this. I'm missing a stub function. It is straightforward to fix.
> 
> Shall I just resend based on 5.18/scsi-queue?
> 
> I'm not sure where that leaves Damien's series.. it just seems easier to 
> try to take mine again first as Damien's would need to be rebased again 
> (if not based on mine).

May be just send an incremental patch on top of yours+my series ? But I
doubt there will be a conflict anyway.

> 
> Thanks,
> John
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
>> head:   2988062985d598d6871f47cb8eb70318af5b5b2d
>> commit: 13685dfbad9831580335dc6e2f7a3be14b769686 [93/154] scsi: libsas: Add sas_execute_ata_cmd()
>> config: ia64-buildonly-randconfig-r002-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221427.OvZeGfzt-lkp@intel.com/config)
>> compiler: ia64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=13685dfbad9831580335dc6e2f7a3be14b769686
>>          git remote add mkp-scsi https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
>>          git fetch --no-tags mkp-scsi for-next
>>          git checkout 13685dfbad9831580335dc6e2f7a3be14b769686
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     ia64-linux-ld: drivers/scsi/hisi_sas/hisi_sas_main.o: in function `hisi_sas_softreset_ata_disk':
>>>> hisi_sas_main.c:(.text+0x42f2): undefined reference to `sas_execute_ata_cmd'
>>>> ia64-linux-ld: hisi_sas_main.c:(.text+0x44a2): undefined reference to `sas_execute_ata_cmd'
>>     ia64-linux-ld: hisi_sas_main.c:(.text+0x45e2): undefined reference to `sas_execute_ata_cmd'
>>     ia64-linux-ld: hisi_sas_main.c:(.text+0x4732): undefined reference to `sas_execute_ata_cmd'
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>> .
> 


-- 
Damien Le Moal
Western Digital Research
