Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDCC58373B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiG1C6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiG1C6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:58:04 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C478F58B7A;
        Wed, 27 Jul 2022 19:58:03 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id x1so644188plb.3;
        Wed, 27 Jul 2022 19:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aQxaeeJ5JgMVcJcw8Ko279QSx3iejqMvsto3fG7z2rc=;
        b=gkP2nFAFpuydvUbt+AxS+JvNyKDUu8rmvSbryUi3h6yyNrnuTjcDoNi8U2PxTggK4U
         D+vxdH2wSAQcV45faeM32hdniRalbguR2x+NwB3W1gGknti2U1fh0WWZhEvsqK1yZBAp
         e1B4x0m7NDG2hnFQS0lxTyBVrKAHA8holQx5thBeWmIg3rCQidbGQHQj16bcAbljsbJz
         NrYRiFHIXLUZEeMmMm+lTcRulppsRUxPn1fIPatBsaN+opSdXZcDFQzT0rtuNuY/Kc6v
         bd+08rnDoQa+KWb9LG1R4xrgPnE26/q29WHeHaAzISsrNHN9l97cwpnwuAHZivu2vyad
         iTyA==
X-Gm-Message-State: AJIora9L2K5mXkbB+NVhP6ehpt7tsD5aHuGmL7YJfqkY84YIR8O77YCK
        d5A56Md3JKd6deSbPcFbDFk=
X-Google-Smtp-Source: AGRyM1vzNaQ3usdPkws9TvBM7VWRcatZbgUmBSHGre6iDPg8J6DngaQMIdNpC0DUbU1GPefINTER8g==
X-Received: by 2002:a17:902:d590:b0:16d:8a08:fa7d with SMTP id k16-20020a170902d59000b0016d8a08fa7dmr13863590plh.122.1658977083051;
        Wed, 27 Jul 2022 19:58:03 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7990b000000b005281d926733sm14543586pff.199.2022.07.27.19.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 19:58:02 -0700 (PDT)
Message-ID: <024d16ac-d685-0fcf-1ad3-e99946852b03@acm.org>
Date:   Wed, 27 Jul 2022 19:58:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        axboe@kernel.dk, snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
 <20220727162245.209794-1-p.raghav@samsung.com>
 <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
 <f2f29f97-5994-37f9-c922-31158c1c1b9a@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f2f29f97-5994-37f9-c922-31158c1c1b9a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 18:52, Damien Le Moal wrote:
> On 7/28/22 08:19, Bart Van Assche wrote:
>> On 7/27/22 09:22, Pankaj Raghav wrote:
>>> This series adds support to npo2 zoned devices in the block and nvme
>>> layer and a new **dm target** is added: dm-po2z-target. This new
>>> target will be initially used for filesystems such as btrfs and
>>> f2fs that does not have native npo2 zone support.
>>
>> Should any SCSI changes be included in this patch series? From sd_zbc.c:
>>
>> 	if (!is_power_of_2(zone_blocks)) {
>> 		sd_printk(KERN_ERR, sdkp,
>> 			  "Zone size %llu is not a power of two.\n",
>> 			  zone_blocks);
>> 		return -EINVAL;
>> 	}
> 
> There are no non-power of 2 SMR drives on the market and no plans to have
> any as far as I know. Users want power of 2 zone size. So I think it is
> better to leave sd_zbc & scsi_debug as is for now.

Zoned UFS devices will support ZBC and may have a zone size that is not 
a power of two.

Thanks,

Bart.
