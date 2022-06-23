Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C8D557770
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiFWKIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiFWKIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:08:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05B7B44756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:08:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF97712FC;
        Thu, 23 Jun 2022 03:08:42 -0700 (PDT)
Received: from [10.57.85.4] (unknown [10.57.85.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 291B53F534;
        Thu, 23 Jun 2022 03:08:40 -0700 (PDT)
Message-ID: <2f66f488-687c-033c-a5a2-9d54633838cd@arm.com>
Date:   Thu, 23 Jun 2022 11:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Add error path for loop of
 mm_dts_parse
Content-Language: en-GB
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-3-yong.wu@mediatek.com>
 <e2091397-b6e2-7296-1378-dc10b24c6ef4@arm.com>
 <b2ea919315d0084adb465378e6970dbfa4f0829e.camel@mediatek.com>
 <521ed82e-f213-f635-6f5e-3e35ff8cc020@arm.com>
 <a53c4a4d9922c9a3fc774976494dea6da1bd8daa.camel@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a53c4a4d9922c9a3fc774976494dea6da1bd8daa.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-23 02:54, Yong Wu wrote:
> On Thu, 2022-06-16 at 11:31 +0100, Robin Murphy wrote:
>> On 2022-06-16 11:08, Yong Wu wrote:
>>> On Thu, 2022-06-16 at 09:59 +0100, Robin Murphy wrote:
>>>> On 2022-06-16 06:42, Yong Wu wrote:
>>>>> The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if
>>>>> the
>>>>> i+1
>>>>> larb is parsed fail(return -EINVAL), we should of_node_put for
>>>>> the
>>>>> 0..i
>>>>> larbs. In the fail path, one of_node_put matches with
>>>>> of_parse_phandle in
>>>>> it.
>>>>>
>>>>> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow
>>>>> with
>>>>> the MM TYPE")
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>> ---
>>>>>     drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
>>>>>     1 file changed, 16 insertions(+), 5 deletions(-)
> 
> [snip..]
> 
>>>>> +err_larbnode_put:
>>>>> +	while (i--) {
>>>>> +		larbnode = of_parse_phandle(dev->of_node,
>>>>> "mediatek,larbs", i);
>>>>> +		if (larbnode &&
>>>>> of_device_is_available(larbnode)) {
>>>>> +			of_node_put(larbnode);
>>>>> +			of_node_put(larbnode);
>>>>> +		}
>>>>
>>>> This looks a bit awkward - could we not just iterate through
>>>> data->larb_imu and put dev->of_node for each valid dev?
>>>
>>> It should work. Thanks very much.
>>>
>>>>
>>>> Also, of_find_device_by_node() takes a reference on the struct
>>>> device
>>>> itself, so strictly we should be doing put_device() on those as
>>>> well
>>>> if we're bailing out.
>>>
>>> Thanks for this hint. A new reference for me. I will add it.
>>
>> In fact, thinking about it some more we may as well do the
>> of_node_put()
>> unconditionally immediately after the of_find_device_by_node() call,
> 
> of_node_put is called in component_release_of in the normal case, thus
> we shouldn't call of_node_put unconditionally. Right?

As it stands, yes. However I'm also figuring that we could just use 
component_match_add() there, and probably also switch to 
component_compare_dev as the the comparison, since we've already 
resolved the larb device, and it is the device itself that we're 
interested in here, rather than just its of_node.

I *think* this idea could end up with simpler code overall, but as 
always, feel free to ignore the suggestion if you think it wouldn't make 
enough difference to be worth the bother.

Thanks,
Robin.
