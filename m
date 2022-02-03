Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252464A7F31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbiBCFzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:55:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51590 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiBCFzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:55:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2135tXVE030887;
        Wed, 2 Feb 2022 23:55:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643867733;
        bh=JD/mD2wLKgToLdLuGwh6h0fFTpWKbSM/tDxw4N2Xe04=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CslY0Mmho/NklB4Be1zldSHxH4hX/1YOqfIdjozXRmSAWoLG5F/RskIxgFrRoJJHj
         pB2TksB2iTlKmfv3oaBNY6qpqPTIwZb4phsMva9MmCypUNb5zs57siyAwlFb6N5HIL
         CO76fqhZsHVKhOSTBZd+QtY3+EPkcgSP/63Nmwos=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2135tWg0014908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 23:55:33 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 23:55:32 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 23:55:32 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2135tT1E101255;
        Wed, 2 Feb 2022 23:55:30 -0600
Subject: Re: [PATCH v2] phy: cadence: Sierra: Add support for skipping
 configuration
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220128072642.29188-1-a-govindraju@ti.com>
 <YfqT444YoGBIturt@matsya> <1d5c41a8-24aa-3cfb-fff0-c2695102aa91@ti.com>
 <YfseaJADVocxqnOu@matsya>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <3444e347-2603-6f5b-94de-09642c41fc27@ti.com>
Date:   Thu, 3 Feb 2022 11:25:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YfseaJADVocxqnOu@matsya>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 03/02/22 5:44 am, Vinod Koul wrote:
> On 02-02-22, 20:14, Aswath Govindraju wrote:
>> Hi Vinod,
>>
>> On 02/02/22 7:53 pm, Vinod Koul wrote:
>>> On 28-01-22, 12:56, Aswath Govindraju wrote:
>>>> In some cases, a single SerDes instance can be shared between two different
>>>> processors, each using a separate link. In these cases, the SerDes
>>>> configuration is done in an earlier boot stage. Therefore, add support to
>>>> skip reconfiguring, if it is was already configured beforehand.
>>>
>>> This fails to apply, pls rebase and resend
>>>
>>
>> On rebasing, I am seeing no difference in the patch and I am able to
>> apply it on top of linux-next/master commit 6abab1b81b65. May I know if
>> there is any other branch that I would need to rebase this patch on top of?
> 
> It should be based on phy-next which is at
> 1f1b0c105b19ac0d90975e2569040da1216489b7 now
> 

I have posted a respin of this patch after rebasing it on top of
phy-next. One aspect that is not clear to me is, phy-next branch does
not have the following commit which is present in linux-next master,

29afbd769ca3 phy: cadence: Sierra: fix error handling bugs in probe()

When the respin of this patch(v3) is merged with linux-next/master
wouldn't it cause merge-conflicts?

May I know how would this be handled?

Link to v3:
- https://patchwork.kernel.org/project/linux-phy/list/?series=610903

Thanks,
Aswath
