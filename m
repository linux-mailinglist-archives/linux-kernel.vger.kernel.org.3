Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5157E5AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiGVRfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:35:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB0DA474;
        Fri, 22 Jul 2022 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658511313; x=1690047313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IuuPH99jalwAgwdF9bn4eQQXgiS+OOi3ixR9llJ2zEw=;
  b=rpt5CLngf45kdsufnqMLsCR+5ZicNZRmLQ+Z50iTCg/ceuTZWeUH+vjO
   QfxKJVozIPIPNZO7Kpv2z4izchJMoxaYmwJ2KUA/gCAtIbNv3WAiTk5yk
   YCKSf5wAxlGIjIRwBKoLcI4ZxMP0cmTad54hCIbBPZ8e/eGNw3D/KTZwr
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jul 2022 10:35:13 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 10:35:11 -0700
Received: from [10.110.117.123] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Jul
 2022 10:35:11 -0700
Message-ID: <4838bb09-d5a8-9b6a-9011-5394b8869695@quicinc.com>
Date:   Fri, 22 Jul 2022 10:35:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Avri Altman <Avri.Altman@wdc.com>, Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65750EE12401C4F69B352E5CFC909@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <DM6PR04MB65750EE12401C4F69B352E5CFC909@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri
Thanks for taking a look.

On 7/22/2022 12:31 AM, Avri Altman wrote:
>> +static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
>> +{
>> +       struct platform_device *pdev = to_platform_device(hba->dev);
>> +       struct ufshcd_res_info_t *res;
>> +       struct resource *res_mem, *res_mcq;
>> +       int i, ret = 0;
>> +
>> +       memcpy(hba->res, ufshcd_res_info, sizeof(ufshcd_res_info));
>> +
>> +       for (i = 0; i < RES_MAX; i++) {
>> +               res = &hba->res[i];
>> +
>> +               res->resource = platform_get_resource_byname(pdev,
>> +                                                            IORESOURCE_MEM,
>> +                                                            res->name);
>> +               if (!res->resource) {
>> +                       dev_info(hba->dev, "Resource %s not provided\n", res-
>>> name);
>> +                       if (i == RES_MEM)
>> +                               return -ENOMEM;
>> +                       continue;
>> +               } else if (i == RES_MEM) {
>> +                       res_mem = res->resource;
>> +                       res->base = hba->mmio_base;
>> +                       continue;
>> +               }
>> +
>> +               res->base = devm_ioremap_resource(hba->dev, res->resource);
>> +               if (IS_ERR(res->base)) {
>> +                       dev_err(hba->dev, "Failed to map res %s, err = %d\n",
>> +                                        res->name, (int)PTR_ERR(res->base));
>> +                       res->base = NULL;
>> +                       ret = PTR_ERR(res->base);
>> +                       goto out_err;
>> +               }
>> +       }
>> +
>> +       res = &hba->res[RES_MCQ];
>> +       /* MCQ resource provided */
>> +       if (res->base)
>> +               goto out;
>> +
>> +       /* Manually allocate MCQ resource */
> Did you consider to force providing the MCQ configuration?
> 
>> +       res_mcq = res->resource;
>> +       res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
>> +       if (!res_mcq) {
>> +               dev_err(hba->dev, "Failed to alloate MCQ resource\n");
>> +               goto out_err;
>> +       }
>> +       res->is_alloc = true;
>> +
>> +       res_mcq->start = res_mem->start +
>> +                        mcq_sqattr_offset(hba->mcq_capabilities);
>> +       res_mcq->end = res_mcq->start + 32 * MCQ_QCFG_SIZE - 1;
> Shouldn't there can be MCQCap.MAXQ queues and no more than 32?
> 
Yes correct. Will change it in the next version.
> 
>> +int ufshcd_mcq_init(struct ufs_hba *hba)
>> +{
>> +       struct Scsi_Host *host = hba->host;
>> +       struct ufs_hw_queue *hwq;
>> +       int i, ret = 0;
>> +
>> +       if (!is_mcq_supported(hba))
>> +               return 0;
>> +
>> +       ret = ufshcd_mcq_config_resource(hba);
>> +       if (ret) {
>> +               dev_err(hba->dev, "Failed to config MCQ resource\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = ufshcd_vops_config_mcq_rop(hba);
>> +       if (ret) {
>> +               dev_err(hba->dev, "MCQ Runtime Operation Pointers not
>> configured\n");
>> +               goto out_err;
>> +       }
>> +
>> +       hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
>> +       hba->nr_queues[HCTX_TYPE_READ] = 0;
>> +       hba->nr_queues[HCTX_TYPE_POLL] = 1;
>> +
>> +       for (i = 0; i < HCTX_MAX_TYPES; i++)
>> +               host->nr_hw_queues += hba->nr_queues[i];
>> +
>> +       host->can_queue = hba->nutrs;
>> +       host->cmd_per_lun = hba->nutrs;
>> +
>> +       /* One more reserved for dev_cmd_queue */
>> +       hba->nr_hw_queues = host->nr_hw_queues + 1;
> Is it possible, since MCQ memory space is *added* to the UTR & UTMR lists,
> That we'll keep using the legacy doorbell for query commands?
> Wouldn't it will simplify the hw_queue bookkeeping
> 
Umm, I didn't understand this suggestion. Please can you elaborate a bit.
When MCQ mode is selected the Config.QT is set to 1.
So how would we keep using the legacy doorbell for query commands?

> 
>> -#define ufshcd_hex_dump(prefix_str, buf, len) do {                       \
>> -       size_t __len = (len);                                            \
>> -       print_hex_dump(KERN_ERR, prefix_str,                             \
>> -                      __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE,\
>> -                      16, 4, buf, __len, false);                        \
>> +#define ufshcd_hex_dump(prefix_str, buf, len) do {                     \
>> +       size_t __len = (len);                                           \
>> +                                                                       \
>> +       print_hex_dump(KERN_ERR, prefix_str,                            \
>> +                      __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE, \
>> +                      16, 4, buf, __len, false);                       \
>> +                                                                       \
>>   } while (0)
> Should this be part of this patch?
> 
No it shouldn't. Will remove this.
>> +#define UFSHCD_MCQ_IO_QUEUE_OFFSET     1
> Maybe add a comment above: "queue 0 is reserved for query commands" or something
> That is if the query commands don't use the  legacy doorbell
> 
>> +static inline bool ufshcd_is_hwq_full(struct ufs_hw_queue *q)
>> +{
>> +       return (q->sq_hp_slot == ((q->sq_tp_slot + 1) %
>> +                                     q->max_entries));
>> +}
> Isn't sq_tp_slot is already % q->max_entries ?
> 
This function is unused in this patchset and I will remove it in the 
next version.

> 
> Thanks,
> Avri

