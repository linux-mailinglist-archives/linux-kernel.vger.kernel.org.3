Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9FF582707
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiG0MuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiG0MuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:50:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC7CE015
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:50:21 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LtD996yjkzmVGh;
        Wed, 27 Jul 2022 20:48:29 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 20:50:19 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 20:50:19 +0800
Message-ID: <e765fb3f-109c-d1f6-81ec-618143d7ea70@huawei.com>
Date:   Wed, 27 Jul 2022 20:50:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: drivers/bus/fsl-mc/dprc.c:494:9: warning: 'strncpy' specified
 bound 16 equals destination size
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <202207272044.M4FM7xVg-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202207272044.M4FM7xVg-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/27 20:23, kernel test robot wrote:
> Hi Kefeng,

Hi， it seems that my patch won't lead to this issue，but I could change 
strncpy to strscpy_pad to fix the warning,

https://lore.kernel.org/lkml/20220727125432.160233-1-wangkefeng.wang@huawei.com/T/#u

>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   39c3c396f8131f3db454c80e0fcfcdc54ed9ec01
> commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
> date:   8 months ago
> config: arm64-randconfig-c023-20220727 (https://download.01.org/0day-ci/archive/20220727/202207272044.M4FM7xVg-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout dd03762ab608e058c8f390ad9cf667e490089796
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/bus/fsl-mc/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>     drivers/bus/fsl-mc/dprc.c: In function 'dprc_get_obj':
>     drivers/bus/fsl-mc/dprc.c:453:9: warning: 'strncpy' output may be truncated copying 15 bytes from a string of length 15 [-Wstringop-truncation]
>       453 |         strncpy(obj_desc->type, rsp_params->type, 16);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/bus/fsl-mc/dprc.c:455:9: warning: 'strncpy' output may be truncated copying 15 bytes from a string of length 15 [-Wstringop-truncation]
>       455 |         strncpy(obj_desc->label, rsp_params->label, 16);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/bus/fsl-mc/dprc.c: In function 'dprc_set_obj_irq':
>>> drivers/bus/fsl-mc/dprc.c:494:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
>       494 |         strncpy(cmd_params->obj_type, obj_type, 16);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/bus/fsl-mc/dprc.c: In function 'dprc_get_obj_region':
>     drivers/bus/fsl-mc/dprc.c:567:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
>       567 |         strncpy(cmd_params->obj_type, obj_type, 16);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +/strncpy +494 drivers/bus/fsl-mc/dprc.c
>
> 31c889653c10ddaf drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-03-05  460
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  461  /**
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  462   * dprc_set_obj_irq() - Set IRQ information for object to trigger an interrupt.
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  463   * @mc_io:	Pointer to MC portal's I/O object
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  464   * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  465   * @token:	Token of DPRC object
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  466   * @obj_type:	Type of the object to set its IRQ
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  467   * @obj_id:	ID of the object to set its IRQ
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  468   * @irq_index:	The interrupt index to configure
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  469   * @irq_cfg:	IRQ configuration
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  470   *
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  471   * Return:	'0' on Success; Error code otherwise.
> e9bf3f206bd5e61e drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-24  472   */
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  473  int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
> ba72f25b2588e1ac drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-25  474  		     u32 cmd_flags,
> ba72f25b2588e1ac drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-25  475  		     u16 token,
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  476  		     char *obj_type,
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  477  		     int obj_id,
> ba72f25b2588e1ac drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-25  478  		     u8 irq_index,
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  479  		     struct dprc_irq_cfg *irq_cfg)
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  480  {
> 5b04cedeca188874 drivers/bus/fsl-mc/dprc.c         Ioana Ciornei    2018-03-15  481  	struct fsl_mc_command cmd = { 0 };
> 9989b59961a8ad55 drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  482  	struct dprc_cmd_set_obj_irq *cmd_params;
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  483
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  484  	/* prepare command */
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  485  	cmd.header = mc_encode_cmd_header(DPRC_CMDID_SET_OBJ_IRQ,
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  486  					  cmd_flags,
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  487  					  token);
> 9989b59961a8ad55 drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  488  	cmd_params = (struct dprc_cmd_set_obj_irq *)cmd.params;
> 9989b59961a8ad55 drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  489  	cmd_params->irq_val = cpu_to_le32(irq_cfg->val);
> 9989b59961a8ad55 drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  490  	cmd_params->irq_index = irq_index;
> 9989b59961a8ad55 drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  491  	cmd_params->irq_addr = cpu_to_le64(irq_cfg->paddr);
> 9989b59961a8ad55 drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  492  	cmd_params->irq_num = cpu_to_le32(irq_cfg->irq_num);
> 9989b59961a8ad55 drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  493  	cmd_params->obj_id = cpu_to_le32(obj_id);
> 9989b59961a8ad55 drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22 @494  	strncpy(cmd_params->obj_type, obj_type, 16);
> 9989b59961a8ad55 drivers/staging/fsl-mc/bus/dprc.c Ioana Radulescu  2016-06-22  495  	cmd_params->obj_type[15] = '\0';
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  496
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  497  	/* send command to mc*/
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  498  	return mc_send_command(mc_io, &cmd);
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  499  }
> c9d57ea0b6fb0bc0 drivers/staging/fsl-mc/bus/dprc.c Laurentiu Tudor  2017-11-17  500  EXPORT_SYMBOL_GPL(dprc_set_obj_irq);
> 1ee695fab32e25ff drivers/staging/fsl-mc/bus/dprc.c J. German Rivera 2015-09-23  501
>
> :::::: The code at line 494 was first introduced by commit
> :::::: 9989b59961a8ad55d92df4588b556f0c6c838ec7 staging: fsl-mc: convert mc command build/parse to use C structs
>
> :::::: TO: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
