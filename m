Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6422054B877
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244311AbiFNSUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbiFNSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:20:36 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357D46B08;
        Tue, 14 Jun 2022 11:20:36 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so9813579pjb.3;
        Tue, 14 Jun 2022 11:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/w8Hp9XqpCFglm0lyCJJnMaxnR+g0jbmO4+b2w/JSEA=;
        b=aUR6+LbwguqtVd8CspF8pjqvN00xuMeteRsLjJ/UuEGLK4TyGbN10O8UQvFy+hh1fI
         ImL1yV2DOsCnthQEQll1d9ATLnvcaHtBn4JALUnI4egjh417gghgjPiv2fO77IfBvzyn
         SlxhSdyNSrecpvnSMni+eYznHcaxP6zJcWML57yzRN178cEmp1OaH4pFZ49TU96jySy2
         qXgDDH0RrhH66Mm/apZj8rHb1StxrvgsGEgrv8PmyH/3r0pS4WsJf+MAQmSsuk6Bbcsi
         k5U5cVd0LF4SKDqibuBs0gROdkGkmnx2hzkJJBhl8VlGval9h3N3ZyriSynJLk4SyikV
         aXDg==
X-Gm-Message-State: AJIora82nNrdZPZYESCNIMlUzSbjp+b/0lDZPaQ5XPVeOYX0dmMDCEsC
        kb04E1FDlFCTadXflZisGkk=
X-Google-Smtp-Source: AGRyM1uJtzcJD6jkzWIeq/vhd/KNLcj/xUnXcUTKXqqen7ST4pnXiahyp/FN/iEDVttrDcmSasNgPQ==
X-Received: by 2002:a17:902:c40d:b0:164:1a71:f7c0 with SMTP id k13-20020a170902c40d00b001641a71f7c0mr5453260plk.90.1655230835619;
        Tue, 14 Jun 2022 11:20:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id c25-20020a637259000000b00408b01faf87sm1439646pgn.67.2022.06.14.11.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 11:20:34 -0700 (PDT)
Message-ID: <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
Date:   Tue, 14 Jun 2022 11:20:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 00:01, Damien Le Moal wrote:
> On 6/9/22 19:29, John Garry wrote:
>> +	/*
>> +	 * This determines how many commands the HBA will set aside
>> +	 * for internal commands. This number will be added to
>> +	 * @can_queue to calcumate the maximum number of simultaneous
> 
> s/calcumate/calculate
> 
> But this is weird. For SATA, can_queue is 32. Having reserved commands,
> that number needs to stay the same. We cannot have more than 32 tags.
> I think keeping can_queue as the max queue depth with at most
> nr_reserved_cmds tags reserved is better.
> 
>> +	 * commands sent to the host.
>> +	 */
>> +	int nr_reserved_cmds;

+1 for Damien's request. I also prefer to keep can_queue as the maximum
queue depth, whether or not nr_reserved_cmds has been set.

Thanks,

Bart.
