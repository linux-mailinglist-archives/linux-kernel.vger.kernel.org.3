Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CE84E600A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348850AbiCXINy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348823AbiCXINk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:13:40 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36795D644;
        Thu, 24 Mar 2022 01:12:05 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 53F29210C5E2
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 07/21] ata: libahci_platform: Sanity check the DT child
 nodes number
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-8-Sergey.Semin@baikalelectronics.ru>
 <ab7f2a2e-0ca9-ed97-e4ed-bf8ef0ed69a5@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d651ccef-1ba6-3063-66d8-410b5517cc3d@omp.ru>
Date:   Thu, 24 Mar 2022 11:12:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ab7f2a2e-0ca9-ed97-e4ed-bf8ef0ed69a5@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 4:40 AM, Damien Le Moal wrote:

>> Having greater than (AHCI_MAX_PORTS = 32) ports detected isn't that
>> critical from the further AHCI-platform initialization point of view since
>> exceeding the ports upper limit will cause allocating more resources than
>> will be used afterwards. But detecting too many child DT-nodes doesn't
>> seem right since it's very unlikely to have it on an ordinary platform. In
>> accordance with the AHCI specification there can't be more than 32 ports
>> implemented at least due to having the CAP.NP field of 4 bits wide and the
>> PI register of dword size. Thus if such situation is found the DTB must
>> have been corrupted and the data read from it shouldn't be reliable. Let's
>> consider that as an erroneous situation and halt further resources
>> allocation.
>>
>> Note it's logically more correct to have the nports set only after the
>> initialization value is checked for being sane. So while at it let's make
>> sure nports is assigned with a correct value.
>>
>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>> ---
>>  drivers/ata/libahci_platform.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>> index 4fb9629c03ab..845042295b97 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -470,15 +470,21 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>  		}
>>  	}
>>  
>> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>> -
>>  	/*
>> -	 * If no sub-node was found, we still need to set nports to
>> -	 * one in order to be able to use the
>> +	 * Too many sub-nodes most likely means having something wrong with
>> +	 * firmware. If no sub-node was found, we still need to set nports
>> +	 * to one in order to be able to use the
>>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>>  	 */
>> -	if (!child_nodes)
>> +	child_nodes = of_get_child_count(dev->of_node);
>> +	if (child_nodes > AHCI_MAX_PORTS) {
>> +		rc = -EINVAL;
>> +		goto err_out;
>> +	} else if (!child_nodes) {
> 
> No need for "else" after a return.

   You meant *goto*? :-)

[...]

MBR, Sergey
