Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F294C6515
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiB1Ixl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiB1Ixi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:53:38 -0500
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545BABA1;
        Mon, 28 Feb 2022 00:52:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V5j4Nby_1646038373;
Received: from 30.225.28.126(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V5j4Nby_1646038373)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Feb 2022 16:52:54 +0800
Message-ID: <4aef53b1-3e0f-92eb-4bd3-cdc4cd301866@linux.alibaba.com>
Date:   Mon, 28 Feb 2022 16:52:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] scsi:target:tcmu: reduce once copy by using uio ioctl
Content-Language: en-US
To:     Bodo Stroesser <bostroesser@gmail.com>,
        Guixin Liu <kanie@linux.alibaba.com>,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xlpang@linux.alibaba.com
References: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
 <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
 <eb08230b-c9a7-26ed-9431-9be3b9791385@gmail.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <eb08230b-c9a7-26ed-9431-9be3b9791385@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi Bodo,

> Liu,
>
> generally I like ideas to speed up tcmu.
>
> OTOH, since Andy Grover implemented tcmu based on uio device, we are
> restricted to what uio offers. With today's knowledge I think we would
> not use the uio device in tcmu again, but switching away from uio now
> would break existing userspace SW.
Yeah, it will have much work if deciding to switch away from uio.
I came up with a hacky or crazy idea :) what about we create a new file
in tcmu_open() by anon_inode_getfile_secure(), and export this fd by
tcmu mail box, we can do ioctl() on this new file, then uio framework
won't be touched...

static int tcmu_open(struct uio_info *info, struct inode *inode)
{
         struct tcmu_dev *udev = container_of(info, struct tcmu_dev, 
uio_info);

         /* O_EXCL not supported for char devs, so fake it? */
         if (test_and_set_bit(TCMU_DEV_BIT_OPEN, &udev->flags))
                 return -EBUSY;
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
tcmu device can only be opened once before closed.

Regards,
Xiaoguang Wang
>
> Before we start thinking how the same performance gain could be reached
> without a change in uio device, please let me know why you use file
> backend on top of tcmu instead of target_core_file kernel module?
> Wouldn't target_core_file be even faster for your purpose?
>
> Bodo
>
>
>
> On 17.02.22 03:29, Guixin Liu wrote:
>> Currently the data needs to be copied twice between sg, tcmu data 
>> area and
>> userspace buffer if backstore holds its own userspace buffer, then we 
>> can
>> use uio ioctl to copy data between sg and userspace buffer directly to
>> bypass data area to improve performance.
>>
>> Use tcm_loop and tcmu(backstore is file) to evaluate performance,
>> fio job: fio -filename=/dev/sdb  -direct=1 -size=2G -name=1 -thread
>> -runtime=60 -time_based -rw=randread -numjobs=16 -iodepth=16 -bs=128k
>>
>> Without this patch:
>>      READ: bw=3539MiB/s (3711MB/s), 207MiB/s-233MiB/s (217MB/s-244MB/s),
>> io=104GiB (111GB), run=30001-30002msec
>>
>> With this patch:
>>      READ: bw=4420MiB/s (4634MB/s), 274MiB/s-278MiB/s (287MB/s-291MB/s),
>> io=259GiB (278GB), run=60001-60002msec
>>
>> Reviewed-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/target/target_core_user.c     | 171 
>> +++++++++++++++++++++++++++++-----
>>   include/uapi/linux/target_core_user.h |   9 ++
>>   2 files changed, 157 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/target/target_core_user.c 
>> b/drivers/target/target_core_user.c
>> index 7b2a89a..afea088 100644
>> --- a/drivers/target/target_core_user.c
>> +++ b/drivers/target/target_core_user.c
>> @@ -122,6 +122,7 @@ struct tcmu_dev {
>>   #define TCMU_DEV_BIT_BLOCKED 2
>>   #define TCMU_DEV_BIT_TMR_NOTIFY 3
>>   #define TCMU_DEV_BIT_PLUGGED 4
>> +#define TCMU_DEV_BIT_BYPASS_DATA_AREA 5
>>       unsigned long flags;
>>         struct uio_info uio_info;
>> @@ -642,12 +643,17 @@ static struct tcmu_cmd *tcmu_alloc_cmd(struct 
>> se_cmd *se_cmd)
>>       tcmu_cmd->se_cmd = se_cmd;
>>       tcmu_cmd->tcmu_dev = udev;
>>   -    tcmu_cmd_set_block_cnts(tcmu_cmd);
>> -    tcmu_cmd->dbi = kcalloc(tcmu_cmd->dbi_cnt, sizeof(uint32_t),
>> -                GFP_NOIO);
>> -    if (!tcmu_cmd->dbi) {
>> -        kmem_cache_free(tcmu_cmd_cache, tcmu_cmd);
>> -        return NULL;
>> +    if (!test_bit(TCMU_DEV_BIT_BYPASS_DATA_AREA, &udev->flags)) {
>> +        tcmu_cmd_set_block_cnts(tcmu_cmd);
>> +        tcmu_cmd->dbi = kcalloc(tcmu_cmd->dbi_cnt, sizeof(uint32_t),
>> +                    GFP_NOIO);
>> +        if (!tcmu_cmd->dbi) {
>> +            kmem_cache_free(tcmu_cmd_cache, tcmu_cmd);
>> +            return NULL;
>> +        }
>> +    } else {
>> +        tcmu_cmd->dbi_cnt = 0;
>> +        tcmu_cmd->dbi = NULL;
>>       }
>>         return tcmu_cmd;
>> @@ -1093,16 +1099,18 @@ static int queue_cmd_ring(struct tcmu_cmd 
>> *tcmu_cmd, sense_reason_t *scsi_err)
>>       tcmu_cmd_reset_dbi_cur(tcmu_cmd);
>>       iov = &entry->req.iov[0];
>>   -    if (se_cmd->data_direction == DMA_TO_DEVICE ||
>> -        se_cmd->se_cmd_flags & SCF_BIDI)
>> -        scatter_data_area(udev, tcmu_cmd, &iov);
>> -    else
>> -        tcmu_setup_iovs(udev, tcmu_cmd, &iov, se_cmd->data_length);
>> -
>> +    if (!test_bit(TCMU_DEV_BIT_BYPASS_DATA_AREA, &udev->flags)) {
>> +        if (se_cmd->data_direction == DMA_TO_DEVICE ||
>> +        se_cmd->se_cmd_flags & SCF_BIDI)
>> +            scatter_data_area(udev, tcmu_cmd, &iov);
>> +        else
>> +            tcmu_setup_iovs(udev, tcmu_cmd, &iov, se_cmd->data_length);
>> +    }
>>       entry->req.iov_cnt = iov_cnt - iov_bidi_cnt;
>>         /* Handle BIDI commands */
>> -    if (se_cmd->se_cmd_flags & SCF_BIDI) {
>> +    if ((se_cmd->se_cmd_flags & SCF_BIDI)
>> +        && !test_bit(TCMU_DEV_BIT_BYPASS_DATA_AREA, &udev->flags)) {
>>           iov++;
>>           tcmu_setup_iovs(udev, tcmu_cmd, &iov, 
>> tcmu_cmd->data_len_bidi);
>>           entry->req.iov_bidi_cnt = iov_bidi_cnt;
>> @@ -1366,16 +1374,19 @@ static bool tcmu_handle_completion(struct 
>> tcmu_cmd *cmd,
>>           else
>>               se_cmd->se_cmd_flags |= SCF_TREAT_READ_AS_NORMAL;
>>       }
>> -    if (se_cmd->se_cmd_flags & SCF_BIDI) {
>> -        /* Get Data-In buffer before clean up */
>> -        gather_data_area(udev, cmd, true, read_len);
>> -    } else if (se_cmd->data_direction == DMA_FROM_DEVICE) {
>> -        gather_data_area(udev, cmd, false, read_len);
>> -    } else if (se_cmd->data_direction == DMA_TO_DEVICE) {
>> -        /* TODO: */
>> -    } else if (se_cmd->data_direction != DMA_NONE) {
>> -        pr_warn("TCMU: data direction was %d!\n",
>> -            se_cmd->data_direction);
>> +
>> +    if (!test_bit(TCMU_DEV_BIT_BYPASS_DATA_AREA, &udev->flags)) {
>> +        if (se_cmd->se_cmd_flags & SCF_BIDI) {
>> +            /* Get Data-In buffer before clean up */
>> +            gather_data_area(udev, cmd, true, read_len);
>> +        } else if (se_cmd->data_direction == DMA_FROM_DEVICE) {
>> +            gather_data_area(udev, cmd, false, read_len);
>> +        } else if (se_cmd->data_direction == DMA_TO_DEVICE) {
>> +            /* TODO: */
>> +        } else if (se_cmd->data_direction != DMA_NONE) {
>> +            pr_warn("TCMU: data direction was %d!\n",
>> +                se_cmd->data_direction);
>> +        }
>>       }
>>     done:
>> @@ -1973,6 +1984,84 @@ static int tcmu_release(struct uio_info *info, 
>> struct inode *inode)
>>       return 0;
>>   }
>>   +long tcmu_ioctl_copy_between_sgl_and_iovec(struct tcmu_cmd *tcmu_cmd,
>> +            struct iovec __user *uiovec,
>> +            unsigned long vcnt,
>> +            bool is_copy_to_sgl)
>> +{
>> +    struct iovec iovstack[UIO_FASTIOV];
>> +    struct iovec *iov = iovstack;
>> +    struct iov_iter iter;
>> +    ssize_t ret;
>> +    struct se_cmd *se_cmd = tcmu_cmd->se_cmd;
>> +    struct scatterlist *data_sg, *sg;
>> +    int i;
>> +    unsigned int data_nents;
>> +    long copy_ret = 0;
>> +
>> +    if (se_cmd->se_cmd_flags & SCF_BIDI) {
>> +        data_sg = se_cmd->t_bidi_data_sg;
>> +        data_nents = se_cmd->t_bidi_data_nents;
>> +    } else {
>> +        data_sg = se_cmd->t_data_sg;
>> +        data_nents = se_cmd->t_data_nents;
>> +    }
>> +
>> +    ret = import_iovec(READ, uiovec, vcnt, ARRAY_SIZE(iovstack), 
>> &iov, &iter);
>> +    if (ret < 0) {
>> +        pr_err("import iovec failed.\n");
>> +        return -EFAULT;
>> +    }
>> +
>> +    for_each_sg(data_sg, sg, data_nents, i) {
>> +        if (is_copy_to_sgl)
>> +            ret = copy_page_from_iter(sg_page(sg), sg->offset, 
>> sg->length, &iter);
>> +        else
>> +            ret = copy_page_to_iter(sg_page(sg), sg->offset, 
>> sg->length, &iter);
>> +        if (ret < 0) {
>> +            pr_err("copy failed.\n");
>> +            copy_ret = -EFAULT;
>> +            break;
>> +        }
>> +    }
>> +    kfree(iov);
>> +    return copy_ret;
>> +}
>> +
>> +long tcmu_ioctl(struct uio_info *info, unsigned int cmd, unsigned 
>> long arg)
>> +{
>> +    struct tcmu_dev *udev = container_of(info, struct tcmu_dev, 
>> uio_info);
>> +    struct tcmu_data_xfer __user *uxfer = (struct tcmu_data_xfer 
>> __user *)arg;
>> +    struct tcmu_data_xfer xfer;
>> +    struct tcmu_cmd *tcmu_cmd;
>> +
>> +    if (!test_bit(TCMU_DEV_BIT_BYPASS_DATA_AREA, &udev->flags))
>> +        return -EINVAL;
>> +
>> +    if (copy_from_user(&xfer, uxfer, sizeof(xfer)))
>> +        return -EFAULT;
>> +
>> +    tcmu_cmd = xa_load(&udev->commands, xfer.cmd_id);
>> +    if (!tcmu_cmd) {
>> +        set_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);
>> +        return -EFAULT;
>> +    }
>> +
>> +    if (test_bit(TCMU_CMD_BIT_EXPIRED, &tcmu_cmd->flags))
>> +        return -EFAULT;
>> +
>> +    switch (cmd) {
>> +    case TCMU_IOCTL_CMD_COPY_TO_SGL:
>> +        return tcmu_ioctl_copy_between_sgl_and_iovec(tcmu_cmd, 
>> xfer.iovec,
>> +                                 xfer.iov_cnt, true);
>> +    case TCMU_IOCTL_CMD_COPY_FROM_SGL:
>> +        return tcmu_ioctl_copy_between_sgl_and_iovec(tcmu_cmd, 
>> xfer.iovec,
>> +                                 xfer.iov_cnt, false);
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +}
>> +
>>   static int tcmu_init_genl_cmd_reply(struct tcmu_dev *udev, int cmd)
>>   {
>>       struct tcmu_nl_cmd *nl_cmd = &udev->curr_nl_cmd;
>> @@ -2230,6 +2319,7 @@ static int tcmu_configure_device(struct 
>> se_device *dev)
>>       info->mmap = tcmu_mmap;
>>       info->open = tcmu_open;
>>       info->release = tcmu_release;
>> +    info->ioctl = tcmu_ioctl;
>>         ret = uio_register_device(tcmu_root_device, info);
>>       if (ret)
>> @@ -2838,6 +2928,40 @@ static ssize_t 
>> tcmu_nl_reply_supported_store(struct config_item *item,
>>   }
>>   CONFIGFS_ATTR(tcmu_, nl_reply_supported);
>>   +static ssize_t tcmu_bypass_data_area_show(struct config_item 
>> *item, char *page)
>> +{
>> +    struct se_dev_attrib *da = container_of(to_config_group(item),
>> +                        struct se_dev_attrib, da_group);
>> +    struct tcmu_dev *udev = TCMU_DEV(da->da_dev);
>> +
>> +    if (test_bit(TCMU_DEV_BIT_BYPASS_DATA_AREA, &udev->flags))
>> +        return snprintf(page, PAGE_SIZE, "%s\n", "true");
>> +    else
>> +        return snprintf(page, PAGE_SIZE, "%s\n", "false");
>> +}
>> +
>> +static ssize_t tcmu_bypass_data_area_store(struct config_item *item, 
>> const char *page,
>> +                        size_t count)
>> +{
>> +    struct se_dev_attrib *da = container_of(to_config_group(item),
>> +                        struct se_dev_attrib, da_group);
>> +    struct tcmu_dev *udev = TCMU_DEV(da->da_dev);
>> +    bool bypass_data_area;
>> +    int ret;
>> +
>> +    ret = strtobool(page, &bypass_data_area);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    if (bypass_data_area)
>> +        set_bit(TCMU_DEV_BIT_BYPASS_DATA_AREA, &udev->flags);
>> +    else
>> +        clear_bit(TCMU_DEV_BIT_BYPASS_DATA_AREA, &udev->flags);
>> +
>> +    return count;
>> +}
>> +CONFIGFS_ATTR(tcmu_, bypass_data_area);
>> +
>>   static ssize_t tcmu_emulate_write_cache_show(struct config_item *item,
>>                            char *page)
>>   {
>> @@ -3069,6 +3193,7 @@ static ssize_t tcmu_free_kept_buf_store(struct 
>> config_item *item, const char *pa
>>       &tcmu_attr_emulate_write_cache,
>>       &tcmu_attr_tmr_notification,
>>       &tcmu_attr_nl_reply_supported,
>> +    &tcmu_attr_bypass_data_area,
>>       NULL,
>>   };
>>   diff --git a/include/uapi/linux/target_core_user.h 
>> b/include/uapi/linux/target_core_user.h
>> index 27ace51..c02a45e 100644
>> --- a/include/uapi/linux/target_core_user.h
>> +++ b/include/uapi/linux/target_core_user.h
>> @@ -185,4 +185,13 @@ enum tcmu_genl_attr {
>>   };
>>   #define TCMU_ATTR_MAX (__TCMU_ATTR_MAX - 1)
>>   +struct tcmu_data_xfer {
>> +    unsigned short cmd_id;
>> +    unsigned long iov_cnt;
>> +    struct iovec __user *iovec;
>> +};
>> +
>> +#define TCMU_IOCTL_CMD_COPY_TO_SGL      _IOW('T', 0xe0, struct 
>> tcmu_data_xfer)
>> +#define TCMU_IOCTL_CMD_COPY_FROM_SGL    _IOW('T', 0xe1, struct 
>> tcmu_data_xfer)
>> +
>>   #endif

