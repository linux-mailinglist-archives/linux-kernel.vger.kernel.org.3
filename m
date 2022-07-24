Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC20C57F2BD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 05:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiGXDQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 23:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXDP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 23:15:57 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E325218E39;
        Sat, 23 Jul 2022 20:15:56 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id o12so7576500pfp.5;
        Sat, 23 Jul 2022 20:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nKGwcrelsEZupWACxvdUNfP/QKldPa0SZqbW/2eTGi0=;
        b=mdp3hndAm50IKluNO0up14/JDjWVHCJgck4tflwzawrrxR9s57L6+VA5TPpsQJRaiU
         B0WbMChW92dGGsK7S1IoGRued2bEoOaI25qD/w06XJPct3Of+/QTcKGSCNrPpbY5T21k
         1CUd0S5DJvaUyJy1L4uCkBpyzU6k/ka9/vAjqOORaTRz3MO0VOVtQPdoeIp5fwa0d4lh
         xgqzTQydioxkZ5nsTjO30C8VfXSaShB0wU43FkTtmxb8WDgoSYhUl21oBuLhdoBcNNMh
         Yji8vCueYo7EwkUDjIzdXAbfwJvwFj2waTch1eU1bCjP8F7HlowpW0LlRu2KQf3PMQbU
         b4Mw==
X-Gm-Message-State: AJIora/nXbCdfaJisNuptQhhutFebpzlLq0RZRzWlXJtjoQ8LUhm1jU4
        UVXrR9U1+5E07l9YoiMD+G0=
X-Google-Smtp-Source: AGRyM1v8GS3NAEbMfA7oYo8GhA6nHNjOtt6ODR8BwC94CSF+uANeItCgqHFh6Z1q52+Whk0noZffEA==
X-Received: by 2002:a63:4a12:0:b0:419:9ede:b7a0 with SMTP id x18-20020a634a12000000b004199edeb7a0mr5839786pga.167.1658632556159;
        Sat, 23 Jul 2022 20:15:56 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 202-20020a6302d3000000b003db7de758besm5916981pgc.5.2022.07.23.20.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 20:15:55 -0700 (PDT)
Message-ID: <c57c04f9-f3d6-05cb-15f7-772efb355cb0@acm.org>
Date:   Sat, 23 Jul 2022 20:15:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Can Guo <quic_cang@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65756C5A6C5F674B19091F7DFC939@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB65756C5A6C5F674B19091F7DFC939@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/22 14:23, Avri Altman wrote:
>>   static inline
>> -void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>> +void ufshcd_send_command(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
>> +                        struct ufs_hw_queue *hwq)
>>   {
>> -       struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
>>          unsigned long flags;
>>
>>          lrbp->issue_time_stamp = ktime_get();
>>          lrbp->compl_time_stamp = ktime_set(0, 0);
>> -       ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
>> +       ufshcd_add_command_trace(hba, lrbp, UFS_CMD_SEND);
>>          ufshcd_clk_scaling_start_busy(hba);
>>          if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
>>                  ufshcd_start_monitor(hba, lrbp);
>>
>> -       spin_lock_irqsave(&hba->outstanding_lock, flags);
>> -       if (hba->vops && hba->vops->setup_xfer_req)
>> -               hba->vops->setup_xfer_req(hba, task_tag, !!lrbp->cmd);
>> -       __set_bit(task_tag, &hba->outstanding_reqs);
>> -       ufshcd_writel(hba, 1 << task_tag,
>> REG_UTP_TRANSFER_REQ_DOOR_BELL);
>> -       spin_unlock_irqrestore(&hba->outstanding_lock, flags);
>> +       if (is_mcq_enabled(hba)) {
>> +               int utrd_size = sizeof(struct utp_transfer_req_desc);
 >
> Maybe we can map some designated ops, so all those if (is_mcq) can be avoided in the data-path.
> Also maybe we can constify sizeof(struct utp_transfer_req_desc) which is used now few times.

Hi Avri,

Since conditional branches are significantly faster than indirect 
function calls I'm fine with keeping the if (is_mcq) conditionals.

Thanks,

Bart.
