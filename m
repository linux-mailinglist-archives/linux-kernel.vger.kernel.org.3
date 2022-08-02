Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23924587D27
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiHBNdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiHBNdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:33:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B8A17A8C;
        Tue,  2 Aug 2022 06:33:21 -0700 (PDT)
X-UUID: bd5af5aef97c4ce797f25be4b413af80-20220802
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:8bf43c17-354f-4ee3-a470-c1b6138fc2f2,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:133c0f25-a982-4824-82d2-9da3b6056c2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: bd5af5aef97c4ce797f25be4b413af80-20220802
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 267675943; Tue, 02 Aug 2022 21:33:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 2 Aug 2022 21:33:14 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 2 Aug 2022 21:33:14 +0800
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release
 supplier
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220613120755.14306-1-peter.wang@mediatek.com>
 <b55d5691-0b2d-56bb-26ff-dcac56770611@mediatek.com>
 <CAJZ5v0gTpv2gt_Gm9rUd+8Jmp4=ij2=J20o7qO0sC-hm=w3=_A@mail.gmail.com>
 <12028598.O9o76ZdvQC@kreacher>
 <90b5f619-2dd6-817b-fe2d-f895be0b5b98@mediatek.com>
 <CAJZ5v0h8xNCV+1YwRA5wob6Vnvz8JFikv3pYMR_mUrXxzfc=tQ@mail.gmail.com>
 <f6ebfd39-a27a-8b1c-6a61-f9a63236961d@mediatek.com>
 <CAJZ5v0gChpusk6JuTG+Zhd_qGR1N+s97Avn4ybdp7Ggpv_uRaQ@mail.gmail.com>
 <7c3ec17e-296f-ab15-6055-fd59a7d8f036@mediatek.com>
 <5c9a3908-a2c6-76d7-db6d-d762503d640a@mediatek.com>
 <CAJZ5v0gSY7sJ2zsUsBeNFpT8XnL5yHd0inxh1+pXa9s1b9M50A@mail.gmail.com>
From:   Peter Wang <peter.wang@mediatek.com>
Message-ID: <80a67ef6-ea29-5b96-9596-6fbbb34c4961@mediatek.com>
Date:   Tue, 2 Aug 2022 21:33:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gSY7sJ2zsUsBeNFpT8XnL5yHd0inxh1+pXa9s1b9M50A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/22 7:01 PM, Rafael J. Wysocki wrote:
> On Tue, Aug 2, 2022 at 5:19 AM Peter Wang <peter.wang@mediatek.com> wrote:
>>
>>> Hi Rafael,
>>>
>>> Yes, it is very clear!
>>> I miss this important key point that usage_count is always >
>>> rpm_active 1.
>>> I think this patch could work.
>>>
>>> Thanks.
>>> Peter
>>>
>>>
>>>
>>>
>> Hi Rafael,
>>
>> After test with commit ("887371066039011144b4a94af97d9328df6869a2 PM:
>> runtime: Fix supplier device management during consumer probe") past weeks,
>> The supplier still suspend when consumer is active "after"
>> pm_runtime_put_suppliers.
>> Do you have any idea about that?
> Well, this means that the consumer probe doesn't bump up the
> supplier's PM-runtime usage counter as appropriate.
>
> You need to tell me more about what happens during the consumer probe.
> Which driver is this?

Hi Rafael,

I have the same idea with you. But I still don't know how it could happen.

It is upstream ufs driver in scsi system. Here is call flow
do_scan_async (process 1)
     do_scsi_scan_host
         scsi_scan_host_selected
             scsi_scan_channel
                 __scsi_scan_target
                     scsi_probe_and_add_lun
                         scsi_alloc_sdev
                             slave_alloc     -> setup link
                         scsi_add_lun
                             slave_configure    -> enable rpm
                             scsi_sysfs_add_sdev
                                 scsi_autopm_get_device    <- get runtime pm
                                 device_add                <- invoke 
sd_probe in process 2
                                 scsi_autopm_put_device    <- put 
runtime pm, point 1

driver_probe_device (process 2)
     __driver_probe_device
         pm_runtime_get_suppliers
             really_probe
                 sd_probe
                     scsi_autopm_get_device                <- get 
runtime pm, point 2
                     pm_runtime_set_autosuspend_delay    <- set rpm 
delay to 2s
                     scsi_autopm_put_device                <- put 
runtime pm
         pm_runtime_put_suppliers                        <- 
(link->rpm_active = 1)

After process 1 call scsi_autopm_put_device(point 1) let consumer enter 
suspend,
process 2 call scsi_autopm_get_device(point 2) may have chance resume 
consumer but not
bump up the supplier's PM-runtime usage counter as appropriate.

Thanks.
Peter





