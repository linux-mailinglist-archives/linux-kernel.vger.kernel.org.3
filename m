Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0B74B6D89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbiBONd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:33:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBONd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:33:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21347106C8A;
        Tue, 15 Feb 2022 05:33:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w10so13430268edd.11;
        Tue, 15 Feb 2022 05:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e88mzJq5T4Ep1vY8Ltp2xH21oXjOq8yNARi+vE4AkUg=;
        b=Xv8yo4/9bDnUwgw+qx2EgD8/nSSPRUP//8ZTVtUsHHheJa9aZGCMT0G9c1AhF93njH
         SfrjNxT7TXWQnF576csumwRMRSMojd5p0Q8+YbZMgtMdy+zDyCIwEFtgnPabxTjEQ60I
         rk7vABGD1syXBxVjRQ9Oy7E5UPWT7ccl2rglyuVKGtQPNcZVHTFw9lxpgngt6xsotdVS
         jQgJBDayFoGFRlbBrQjCXVX12I23EXqxeBY4olIODjn+OU8MZg5grD2M0MFlCY8/71Us
         G3BjdrlLbehhEaD8FzpVd63Yq5OTkQDtDP3BoWGCKyCOoGJM0ZuC7ktNQEawSEjMoJWb
         /C3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e88mzJq5T4Ep1vY8Ltp2xH21oXjOq8yNARi+vE4AkUg=;
        b=b2iY5YfE2r9rX+IEnw93h/y3w42FLBXPepWKxSe39g+iIVHf2aC13AP/fzQwfAXRRo
         iHxLXtmwYXi4pyDvNKCK1nx/wBoXrIGv881n7cplGB/ZwFo3MKzsOsVP7E9CI+/22g5q
         c4NE5Elqp9LP+5C/RDqE2sb6IeYxE8hsloGmsaGXnZwBEs97SFdhMbBqiPLf0RMGT6zf
         3Vlt+fhJ20xqKjOVGheYzHpvUdieEjquC64Dc0wQtdaO95X/JmKB+k7ysGn7eERErJxd
         jqmCykPSwATjxSHgkoPbxiRrZJD9YCYPqzeJVLB5W0zkHO0VRgvPGYteL2SiyZETYcvs
         3SRw==
X-Gm-Message-State: AOAM531WMXWNzcRhubnX2CWxnoqSHhPkapAFvv0JJkujLVqzWhyoobcc
        2HQuk+540t8cnOv9I8F4VxE=
X-Google-Smtp-Source: ABdhPJwL6WIHr9UQkaV1qQhq92tMeRxgqPMMA3BbIcGbzUcok6XCM0jG350bhblnE/7Pji08n7OEUA==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr3945723edd.65.1644932025655;
        Tue, 15 Feb 2022 05:33:45 -0800 (PST)
Received: from [192.168.178.40] (ipbcc1fa42.dynamic.kabel-deutschland.de. [188.193.250.66])
        by smtp.gmail.com with ESMTPSA id f14sm1780043edf.67.2022.02.15.05.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 05:33:45 -0800 (PST)
Message-ID: <2fea1ce0-0818-69b2-1fc1-03e624f56ceb@gmail.com>
Date:   Tue, 15 Feb 2022 14:33:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] scsi: target: tcmu: Make cmd_ring_size changeable via
 configfs.
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Guixin Liu <kanie@linux.alibaba.com>,
        martin.petersen@oracle.com
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com
References: <1644912216-97633-1-git-send-email-kanie@linux.alibaba.com>
 <202202152052.AEF7jHIH-lkp@intel.com>
From:   Bodo Stroesser <bostroesser@gmail.com>
In-Reply-To: <202202152052.AEF7jHIH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

since CMDR_OFF is defined as "sizeof(struct tcmu_mailbox)", we could
fix the warning by using %z. OTOH, the fields cmdr_off and cmdr_size
in struct tcmu_mailbox are defined as u32, as well as cmdr_size in
struct tcmu_dev.

So I think we should add a cast to u32 in the definition of CMDR_OFF.
That should allow us to use %u on all architectures. Additionally
it avoids expansion to long during calculations where CMDR_OFF is
involved.

Btw: in my comments I asked you to remove the "\n" in the sprintf for
DataPagesPerBlk. But of course we need a space instead to allow
proper parsing of the output.

Bodo

On 15.02.22 14:05, kernel test robot wrote:
> Hi Guixin,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mkp-scsi/for-next]
> [also build test WARNING on v5.17-rc4 next-20220215]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Guixin-Liu/scsi-target-tcmu-Make-cmd_ring_size-changeable-via-configfs/20220215-160505
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220215/202202152052.AEF7jHIH-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>          # https://github.com/0day-ci/linux/commit/7f77700542b8196c546ef10656dda7a107d8d1ad
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Guixin-Liu/scsi-target-tcmu-Make-cmd_ring_size-changeable-via-configfs/20220215-160505
>          git checkout 7f77700542b8196c546ef10656dda7a107d8d1ad
>          # save the config file to linux build tree
>          mkdir build_dir
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/target/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/target/target_core_user.c: In function 'tcmu_show_configfs_dev_params':
>>> drivers/target/target_core_user.c:2627:41: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
>      2627 |  bl += sprintf(b + bl, "CmdRingSizeMB: %u\n",
>           |                                        ~^
>           |                                         |
>           |                                         unsigned int
>           |                                        %lu
>      2628 |         (udev->cmdr_size + CMDR_OFF) >> 20);
>           |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                                      |
>           |                                      long unsigned int
>     drivers/target/target_core_user.c: In function 'tcmu_cmd_ring_size_mb_show':
>     drivers/target/target_core_user.c:2743:37: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
>      2743 |  return snprintf(page, PAGE_SIZE, "%u\n",
>           |                                    ~^
>           |                                     |
>           |                                     unsigned int
>           |                                    %lu
>      2744 |    (udev->cmdr_size + CMDR_OFF) >> 20);
>           |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                                 |
>           |                                 long unsigned int
> 
> 
> vim +2627 drivers/target/target_core_user.c
> 
>    2616	
>    2617	static ssize_t tcmu_show_configfs_dev_params(struct se_device *dev, char *b)
>    2618	{
>    2619		struct tcmu_dev *udev = TCMU_DEV(dev);
>    2620		ssize_t bl = 0;
>    2621	
>    2622		bl = sprintf(b + bl, "Config: %s ",
>    2623			     udev->dev_config[0] ? udev->dev_config : "NULL");
>    2624		bl += sprintf(b + bl, "Size: %llu ", udev->dev_size);
>    2625		bl += sprintf(b + bl, "MaxDataAreaMB: %u ", udev->data_area_mb);
>    2626		bl += sprintf(b + bl, "DataPagesPerBlk: %u", udev->data_pages_per_blk);
>> 2627		bl += sprintf(b + bl, "CmdRingSizeMB: %u\n",
>    2628			      (udev->cmdr_size + CMDR_OFF) >> 20);
>    2629	
>    2630		return bl;
>    2631	}
>    2632	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
