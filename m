Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5858CAB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbiHHOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiHHOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:48:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77099B851
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659970107; x=1691506107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F1+Sxy+1lBVaSJWXdDtSLWjWhaVqQLanyKvcu0Jexr8=;
  b=BW0msI/kjS3C1Oggp+Esk8m9anSBwyDFEB6OZT1RCuwrTwhNHKxJBKM1
   nPnBhNVxI+IyIsaYjwy/lBeD83gNZRUbXu7F6aK0N4CWiVH3SEk/Kz4ED
   wLiiHdLlP+pnrZ2FhNpemXt+NLqMv5Up/fGrhAJ2giWjFefNTSKrkI6fQ
   zj9k+NPPamA60TnezNtDNLtXBxM6nOhjC2FSfTNHXd/VXLGH8zF396zjy
   5KjpHmNZE9RE1V8nH2jlSaWzt3YdByyll+QCFZB5jMX+EwdNVgRPBDGLK
   GX9H4P5MP9tx+ZK21l8DwT8Wl3ExaylIbuO3VYJwcghlb/gObKfytdJEp
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,222,1654531200"; 
   d="scan'208";a="213140724"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2022 22:48:25 +0800
IronPort-SDR: 4qXkGcfVKs7Ls3vWyQICFFHPGK0VjEL60ti+0NH/KHS6CQJxBDTrNfNU8h/ZIRAVRIzJfpLdH5
 y5EJHWnIUtA46LUSdGnuWYYyEt3nevFV3ZYZZaprl2DGFP+ezmxKPVt9LVR4pG+QuucIpKKNIC
 uTKc72uP0VHK08QMOApycrJfdOMZIGppkmueMmCmQc2TV4SWnTpT30nMQVX41QGqSeIAJVkX12
 X0TxaOVl+tPxsTo2Ig/sR6NBRUswDgjv1mbEgs87r4KMOhDN8Ufdld1ivHaSIdLBbI8qcBIGqX
 cfPyO1EvEwYLsysEfmxC7SXz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2022 07:09:23 -0700
IronPort-SDR: kW/I4/Jr2m+Itf847fh+DJrvK8Ka1cpStxrnSPtLHHXTkyu7aCOV3Z0JicuMWCqDNyFOwtKcaq
 J42/4EqYkBBoS9z3kG2pzbx/kHGeJXoEnaLG+qNuMau3DknuTkGWOyN+7pLti1Zu2/jkxjbMSL
 x5MEzqhbeowMZR9acp2BgnX+5nxsFwzFOr1uQvQTUmQnO7f51OUosEWNVZYFe2oaDdjY+e09P8
 rahusEEU+TM5elpGuNkfTX8Z3iOYg2/GgBhGXq00qNnLrbNUwGKL8Nx8tMSRwEaW6rYL+1uFKR
 Dmg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2022 07:48:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M1fG14bKsz1RwqM
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:48:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1659970104; x=1662562105; bh=F1+Sxy+1lBVaSJWXdDtSLWjWhaVqQLanyKv
        cu0Jexr8=; b=W0863VK2Phuve7uXHL+nSiCCSldHWYV+RNQ2dKUW7RWPRAy2eDM
        NbRWuCdfFFwenN+cwk4Z8fy0qdA8mJpOBy7SxzB8KtAColW2pwJU2fF0ZruDGYsO
        2waeYmYmmiAZ6WZEAYU5rWHD4DoQClmLD3lnTcWGsSwKbtUzsU3krv49Ltu25sWJ
        lsBgDFtz+r2vNOub3fDEVOaqmj2v+VALCbhyHrVxs2t/gvxc6C+a4ZVb7gc7I2rF
        jeG4Goz7ITrI7vfHG1Y0sQOxyOpXguRI0D/v0wnPoUFQjwlvLmcFV71BG4j+CA8p
        7ea6eOVNl6XlO08AVh1++P/8TSSGbY3sUmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M0nBofMVXxut for <linux-kernel@vger.kernel.org>;
        Mon,  8 Aug 2022 07:48:24 -0700 (PDT)
Received: from [10.225.89.57] (gns5353.ad.shared [10.225.89.57])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M1fFz0RlZz1RtVk;
        Mon,  8 Aug 2022 07:48:22 -0700 (PDT)
Message-ID: <affa6eee-3b7c-105a-8f4a-35f1ed81f0cd@opensource.wdc.com>
Date:   Mon, 8 Aug 2022 07:48:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted
 blk_opf_t
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <202208061533.YBqXyzHm-lkp@intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202208061533.YBqXyzHm-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/06 1:00, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
> commit: e46b5970496705127f9ae494c66e0242773097e8 fs/zonefs: Use the enum req_op type for tracing request operations
> date:   3 weeks ago
> config: arm64-randconfig-s052-20220804 (https://download.01.org/0day-ci/archive/20220806/202208061533.YBqXyzHm-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e46b5970496705127f9ae494c66e0242773097e8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e46b5970496705127f9ae494c66e0242773097e8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash fs/zonefs/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
>    fs/zonefs/super.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, fs/zonefs/trace.h):
>>> fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted blk_opf_t
>>> fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted blk_opf_t
>>> fs/zonefs/./trace.h:22:1: sparse: sparse: restricted blk_opf_t degrades to integer
>>> fs/zonefs/./trace.h:22:1: sparse: sparse: restricted blk_opf_t degrades to integer
>    fs/zonefs/super.c: note: in included file (through arch/arm64/include/asm/smp.h, include/linux/smp.h, arch/arm64/include/asm/arch_timer.h, ...):
>    arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>    arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>    arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>    arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
> 
> vim +22 fs/zonefs/./trace.h
> 
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  21  
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27 @22  TRACE_EVENT(zonefs_zone_mgmt,
> ff07a02e9e8e64 Bart Van Assche    2022-07-14  23  	    TP_PROTO(struct inode *inode, enum req_op op),
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  24  	    TP_ARGS(inode, op),
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  25  	    TP_STRUCT__entry(
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  26  			     __field(dev_t, dev)
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  27  			     __field(ino_t, ino)
> e46b5970496705 Bart Van Assche    2022-07-14  28  			     __field(enum req_op, op)
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  29  			     __field(sector_t, sector)
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  30  			     __field(sector_t, nr_sectors)
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  31  	    ),
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  32  	    TP_fast_assign(
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  33  			   __entry->dev = inode->i_sb->s_dev;
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  34  			   __entry->ino = inode->i_ino;
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  35  			   __entry->op = op;
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  36  			   __entry->sector = ZONEFS_I(inode)->i_zsector;
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  37  			   __entry->nr_sectors =
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  38  				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  39  	    ),
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  40  	    TP_printk("bdev=(%d,%d), ino=%lu op=%s, sector=%llu, nr_sectors=%llu",
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  41  		      show_dev(__entry->dev), (unsigned long)__entry->ino,
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  42  		      blk_op_str(__entry->op), __entry->sector,
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  43  		      __entry->nr_sectors
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  44  	    )
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  45  );
> 62ab1aadcccd03 Johannes Thumshirn 2021-01-27  46  

Bart,

Are you going to send a patch to fix this or do you want me to do it ?

> 
> :::::: The code at line 22 was first introduced by commit
> :::::: 62ab1aadcccd037a7ced4ed99b4d46d2b4190183 zonefs: add tracepoints for file operations
> 
> :::::: TO: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> :::::: CC: Damien Le Moal <damien.lemoal@wdc.com>
> 


-- 
Damien Le Moal
Western Digital Research
