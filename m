Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B615875E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiHBDTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiHBDTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:19:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D6422CF;
        Mon,  1 Aug 2022 20:19:19 -0700 (PDT)
X-UUID: d854270fb5ce4d4287c9eee988725f98-20220802
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:a0fc4b1d-dcdc-4afb-8363-75be426cd6d0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:a0fc4b1d-dcdc-4afb-8363-75be426cd6d0,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:51d905d0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:1b35f9da6b07,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: d854270fb5ce4d4287c9eee988725f98-20220802
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1551468664; Tue, 02 Aug 2022 11:19:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 2 Aug 2022 11:19:10 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 2 Aug 2022 11:19:10 +0800
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release
 supplier
From:   Peter Wang <peter.wang@mediatek.com>
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
Message-ID: <5c9a3908-a2c6-76d7-db6d-d762503d640a@mediatek.com>
Date:   Tue, 2 Aug 2022 11:19:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7c3ec17e-296f-ab15-6055-fd59a7d8f036@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Rafael,
>
> Yes, it is very clear!
> I miss this important key point that usage_count is always > 
> rpm_active 1.
> I think this patch could work.
>
> Thanks.
> Peter
>
>
>
>
Hi Rafael,

After test with commit ("887371066039011144b4a94af97d9328df6869a2 PM: 
runtime: Fix supplier device management during consumer probe") past weeks,
The supplier still suspend when consumer is active "after" 
pm_runtime_put_suppliers.
Do you have any idea about that?

Thanks.
Peter





