Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B94F585536
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbiG2S7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbiG2S7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:59:12 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A76280F79;
        Fri, 29 Jul 2022 11:59:12 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d3so5394714pls.4;
        Fri, 29 Jul 2022 11:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=RiqO48yaPZ+CfEFjvhoLhJAO12nRLRmmsWgYJFVv/AE=;
        b=6ixg2CMzrrYEoAFP0Qrs8lP5+VA8+2tBsgAVXQDt2SYLfLyX8cCaGc4hb2Ni4HN+XS
         P+WHr+4/Iynvbnn4a1GoLDYx84q3COoZ69pD6JWNQYLPWjOplnBK4qVLhqrPDniGS/QK
         7bBobYVLKNdwNBqqRubDQlKeEfzj1ZfAUtPdZUlA5Nxm91qhbwmQZoBHPb8SdcBkE0M2
         t19IYPFOLRofStV5LYUH0iLp97ZDPq3wv0lGT+4pA+eFMnhYgO7FIB/mgCDf9trGdA7f
         5JhMNBiamJnfwJB3PAEO8PdER+urCGygCxFdwuutLGkDP2ge0HmLQ6Vepd258aSqrwJL
         XCKg==
X-Gm-Message-State: ACgBeo0CQIY+bJMHp4+lvYtZEPq3OvIamy0JP5qx+r24/u3OIlUwINDY
        Xaq0WdjHqr0osi3Sml3Rxlk=
X-Google-Smtp-Source: AA6agR6GCPPYWjtyI4ZWuCQkoIibuGbGH2JQOdO+k0zAwbVaNR9kVlObJr1kmspp7C6pQ+ygu8FKNA==
X-Received: by 2002:a17:90a:1588:b0:1e0:a45c:5c1 with SMTP id m8-20020a17090a158800b001e0a45c05c1mr5683854pja.65.1659121151395;
        Fri, 29 Jul 2022 11:59:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f090:7a49:3465:6a5? ([2620:15c:211:201:f090:7a49:3465:6a5])
        by smtp.gmail.com with ESMTPSA id y63-20020a626442000000b0052ab92772a0sm3309032pfb.98.2022.07.29.11.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 11:59:10 -0700 (PDT)
Message-ID: <afefc312-4996-e5f2-b33a-6a987b20961b@acm.org>
Date:   Fri, 29 Jul 2022 11:59:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>,
        John Garry <john.garry@huawei.com>,
        Can Guo <quic_cang@quicinc.com>, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, quic_nguyenb@quicinc.com,
        quic_ziqichen@quicinc.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <f93045ec-569c-bd09-3617-d7d7aca4e5cd@huawei.com>
 <ea33dee8-673c-0716-1640-28df7c983ca7@quicinc.com>
 <10288041-8c3d-7e3a-9049-10b9fcd8baed@acm.org>
 <6da1447d-01d6-222e-fc98-7e96b154d2d0@quicinc.com>
 <59e835e6-b694-07c5-16a1-5f7774fc4177@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <59e835e6-b694-07c5-16a1-5f7774fc4177@quicinc.com>
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

On 7/29/22 09:43, Asutosh Das (asd) wrote:
> I went through the change and fwiu of your proposal is to use 
> host_tagset = 1 if HC doesn't support EXT_IID capability.
> That way tags would be shared across 16 HWQs (4-bit IID encoding the 
> queue-ids).
> That would also mean that the hba->nutrs would have to be adjusted such 
> that the tags(8-bit) don't exceed 255.
> 
> Summarily,
> if EXT_IID is not supported:
> host_tagset = 1, maximum configurable hba->nutrs = 16, maximum 
> configurable nr_hw_queues = 16.
> maximum number of outstanding commands to host = 16 x 16 = 256.
> 
> if EXT_IID is supported:
> host_tagset = 0, maximum confiugrable hba-nutrs = 255, maximum 
> configurable nr_hw_queues = 255.
> 
> Please let me know if I'm missing something.

Hi Asutosh,

I recommend to always set host_tagset = 1. The performance overhead of 
host_tagset = 1 compared to host_tagset = 0 should be negligible for UFS 
devices. This will simplify the UFS host controller driver and will 
allow us to limit the total number of outstanding commands to the 
maximum number of outstanding commands supported by the UFS device. I 
expect that we will need to do this. If more commands are sent to the 
controller than what the UFS device can queue, the host controller will 
decide in which order commands are fetched and sent to the controller. 
We want the host to decide in which order commands are queued and not 
the host controller. As an example, adding support for HCTX_TYPE_READ 
queues will only work as expected if the number of outstanding commands 
is less than or equal to what the UFS device can queue.

For host_tagset = 1, we can combine the 4 EXT_IID bits with the 8 bit 
task tag and create a single space of 4096 (2**12) tags. The block layer 
sbitmap data structure has been designed to minimize contention even if 
a single sbitmap data structure is shared across multiple CPU cores.

Thanks,

Bart.
