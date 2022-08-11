Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61958FA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiHKKVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKKVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:21:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B20E0FE;
        Thu, 11 Aug 2022 03:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPKQddEofl4r1yeq4HLUJoEew5wI7HVte6QdVeArm7+/6qZxy0WNbIk0gE9xNLGvx9oSTritrrJ4CPB4z5NHl1DCByoThUS3Kaqb5iPQbfX2ydkJGrgscWcOcoEo7GRhZR/Cfkel34/H6yR68ZkzmEvHWSsal33SDfMzrmnfTzAcYjjBlpo/ODFFxSWH0G0Tfy3RVnw/5bWer6Ca1afHqK5f6ESStgwHMRaB/tM3yku9+XLc0jffREWMaSA+Iw4HnsTKJKzpVoYRIVe18SBK+rHML6MQUsoi+r28RL36ibp9kVmNFCtbx8RgOT7sfHoT6/tumK5YT5Z8ajUHSB2RNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rvigl8SyHGXgc6wu8J3t2+V3RiYM0DpRJYciY9emDqs=;
 b=PKRgv4B13vPnYr6gPhohIICnOhKVcK+1a/yQueqqAi7/OKU8xgP/6G83aBe5ZhxULyNFNE6oC+0tSesM99nPKv0qDgKgvwb9kA3SJG6tc8I49dYiCtc3HRF6pbEE9wL0rek7L36X7V83yp3XJ4MKqdyJ5OLuoU3pKVKs+DJyWZ+tuhVOD8dnmZbevWmei+aWImq4a0WLQBghbgFSDxfX9fl7PxD9uuPYE731AlDlj2fcDxPaVBIizYB0ygpgFT3QOcSdou3cuGeBzOEkcMVThe6GSqNg5WlC1kg4hhK9x/mhr38BEflZrbQBoJfhhAn+9QU9uSQP4BR35hGcPLQ4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvigl8SyHGXgc6wu8J3t2+V3RiYM0DpRJYciY9emDqs=;
 b=XstH4ov8+H0nfwTAMnmv+2bDRxZdEfoYR2agccXvlzBUgb2Q3i1G1spb/MvgNCM/l4KK8QgmogD5TEtbagoqf3thL4xFqr5kHk7nNN0goi+D+T9q/qDfKoIWcSVYkBpAEmhI2bGkWNMPHHoYYVnBWe3ct/Ix40/xbfamzTpODVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by VI1PR04MB5101.eurprd04.prod.outlook.com (2603:10a6:803:5f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Thu, 11 Aug
 2022 10:21:41 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::81a8:1bbf:5e16:9b4e]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::81a8:1bbf:5e16:9b4e%4]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 10:21:41 +0000
Message-ID: <c7946a7e-d823-d43d-a595-00e8f10829e8@theobroma-systems.com>
Date:   Thu, 11 Aug 2022 12:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 1/1] pinctrl: rockchip: add support for per-pinmux
 io-domain dependency
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220802095252.2486591-1-foss+kernel@0leil.net>
 <9b965d86-9b76-77a1-658e-3675c2138414@wolfvision.net>
 <7353767b-0c38-a5a1-d3ac-3d9151140fb8@theobroma-systems.com>
 <3152231.AJdgDx1Vlc@diego>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <3152231.AJdgDx1Vlc@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR0301CA0018.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d796c8c-b2c1-49a5-e1d8-08da7b83487f
X-MS-TrafficTypeDiagnostic: VI1PR04MB5101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEvcBupDCSIyYcDzRZofiAS0n2prlh7irRpzqGd5dHeBWbtL7W4wjCx6VTG5LvyWqTteL8jTU70J6z9h03en4gWdpIm6Fgg9vnRPjRRMGo0miI3S7hy3KoSrXq7YSfl+XBZKVhLg1z9iLB8lG9RDwvtTi/r2W9Jr8lQLTK2FZ5hoU2fE2CKPIt87ej/IgyYHo/+97d6xzkA2wggpQcVBG/cUPna+mnZneaKAeZakVdvdbZSVbSMqSNfCYnwrtuGA96D60ObWBIH2VaLcKH+tjBeF8TfboVe58dXFMdhItj/3i2MXt8qTr7fbNBdYUTgHDyClmHwrlSc5UIHnuw/VljoJ0ehPUnt4CzhIShqO1vAFYpQYbjiWepX9mzSHoWSh0YqHoOefdbiehANt5vKG2KBiRUlQHDesyiAHIv75YtoE6hE2Rg1vJEJp+ijkUhbbsxAFTbJdKecSn2GVFwgFtjKrcmEjyc7PdEioXnQx8cXY6VKxCJA7pARk1tehH5k9Nlil19YuIpBT9nR4X8FOvPDxyaCxq6ZCy/t7NTeKRTBWIXwzyUcTGT3TVjpCpLzfd5VhRDQ8Ksq1/60XcAoFxxc8Iv4UCB14GFqRDUKDahDBQ+3ayDGWbboRMPmBD6PIpngi47v5NXy7jFkm7MRK04aAm6Rf2ncz+6rBupcznUEpvy7DIzuToq6+zHhlcifP1V2LN5Hjmkw9fc7mROWznRAgpVrDpa5QlRsrN5Zz16KmCBV3CbGEC+5MAiVzTIw01Fnel0P5CNv59//ETaJbNvfOhMCSW25NfAqeNP8tPrm3s0xfsj8QMjX0xSRBom2k+uhpjtzcgflFtD6rrUBA5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39840400004)(376002)(110136005)(316002)(31686004)(38100700002)(36756003)(4326008)(8676002)(66556008)(41300700001)(6512007)(66574015)(26005)(2616005)(83380400001)(66946007)(66476007)(5660300002)(6486002)(186003)(8936002)(53546011)(6506007)(86362001)(31696002)(44832011)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkp6bXgzQU95WVRNejB5NTJDOTBDTmdpbnhqWUpLTDdCdXZzVmtKak9CS0pw?=
 =?utf-8?B?ZHJZM3lVT05ubVR2eTFERkxSNG1iNUtRRHJQT0lKUGxXTHc0aml0YnNGSkxV?=
 =?utf-8?B?Q1JIQnlLTUJrK2hKbGVIaGhpOGt1THlmTkQrRjR0MmdPWGhDU2tOT2J1ZEZV?=
 =?utf-8?B?R29ma0hPdUZyTmdZREkzWGVLSXZodTF2VXR1WWFTNWkyU2thOXB5L0JkVERz?=
 =?utf-8?B?TTNwaGpDRTJNSnY0K3FwUDkvZEl5QlUwQ0RIMFNhenVKbHc3eTZHck14cXBT?=
 =?utf-8?B?bzhTeUdiWFNIVjR2bmJnNnplbTh1ajJyTHIweERXS0tGT2p2Z3BkUGVpNDJj?=
 =?utf-8?B?OUVtWjVIaDBtL2xVNW4xU0FsQ3JrVlFSZXVROUhYcHBLZlhwcTMvdTdITmZ4?=
 =?utf-8?B?WmZhV3JYK2Z3ZDNIdjF0aW1Pd2FHbEJmMmxPa25adFRXK0N3Mm9zVzdSRU80?=
 =?utf-8?B?UEpHRjM3TzQ2b3lVQXZPYXN1aDZveUxGYnZFWTlRSlkxKzlEeFozWWtUZGcr?=
 =?utf-8?B?TXVuQU9ZL0FUZDF2QnhTV2pnNHhSbUE2WnFheWxQTElFQmt0QTU0UDRXQTZz?=
 =?utf-8?B?QlZvUWJkNFR5Q0Zsd3krczNIbS9YNTU2MkI5czV0bE9MU2RPcDdibjJvaDBD?=
 =?utf-8?B?eExSazVDd3VDMlUrUmFHeHlYK25CeUtUcFE5dzg3NzNHb1Frc1M3R3lQeUVh?=
 =?utf-8?B?a1J0T1VIVDl1SjVLUGd0V0dpYzdhZ3BEOHYxK2NnQWdadGtsVVpIRDlkMzNw?=
 =?utf-8?B?Um1YaWcvQlVWYzVPODg1QksxWDFmSHNITWtaS1A2YTBkUC81VzZpVHZ0bUtQ?=
 =?utf-8?B?Y1c1ZTl5WjRmc0orRlJPdkVyMmVCMGRmQVJJWGhzbnpNSVRwUUQ5cHhyaC9U?=
 =?utf-8?B?WmlPTWRaVHNWQi9mekNlQzBIdTRkSWV1ZzFwUDdlMG5OSm5XeElLWXUwMHNo?=
 =?utf-8?B?azNFTi9vSDIrditNWkhoSDhqVzBqcWc0SzV3cVZsZFBPY3U1R2ZhN0N1dVdD?=
 =?utf-8?B?VEVSR3IrQTVmSG1Ic3lmU09QNlhPMC9jVWM0QkpwQ3hBL1kwcUtjeFVxYkJz?=
 =?utf-8?B?RGx2eks1cXp0SXF0VFlaUmE2Q3FtVDNTbkRra0VKaVJHazJTVUVGb2ZZUTY0?=
 =?utf-8?B?MjhlS1MwZDZqUmdoL3VOcjFsRHd2OUJQSFl0Sk9IQklhSVpZdG5nc0J3ajg4?=
 =?utf-8?B?eDdWOTdpT21hUzN2ejZjVEhtRFZmaEhneklwUU5McFBUNlI1czBKZld3Ylda?=
 =?utf-8?B?N2NMcEZCYjh5OG1EQU4yU2lBQW8wd2ZSNy9Ub0R2MUp1RnY5MFdCMW9qWXBn?=
 =?utf-8?B?VDh2Y1NoZno0aE5EaWNpSUhyZEpzTklxSWx3bEt5aGJMVWVkckgzV1VIeXdT?=
 =?utf-8?B?VDBpSGh1b0hqbHRySFpOelFLdkVtQUNvRVRzaGhFVlUza1ZvVm5FZVY0czJH?=
 =?utf-8?B?dllCTC9Ca0JueEpSUUdTajUzYUV5L3VkYTFNRG03aHlLbGFrMWV2SkdEb3NF?=
 =?utf-8?B?bEFibzl4VlU4YTc5MG13TWZMUnNzRklLVG1DbTRIYU94NHpGb1FrVm83OE5Y?=
 =?utf-8?B?NzMvMy9BVFdHNG1xK2pFelNieTd3dlRoV1RocFpqYXQwa2UyTWc1c280cjlQ?=
 =?utf-8?B?V0pmbGZuaDdSYkFQeWVDWGdVWGNIRkUrcTFja3B6RjZMNGdScFN6WklxcXJ5?=
 =?utf-8?B?cjE1Q2Zaa2paNXN4Zk8xRmhlYi9jNitacVhOOHNVKzYrcWhHL2ZCVU01aU9H?=
 =?utf-8?B?Z1FDdDQrQWNJK21kOUVvbUQ3SU1IZGdRd3hock9TK3kvUGNQWDkyemwvd3RZ?=
 =?utf-8?B?aHZWZ0FCSVJYdlJpdUJJaXN2Z01hbmNibXhES3lFSkFJL0NKUWZyV2tLM0Uy?=
 =?utf-8?B?QzNBNTFSYzJwaXM1SEVPT2w5MStjeGRBMS8reXl4a0dwTElyZXNnVlZLZXE0?=
 =?utf-8?B?Yk02c09BZERrbFRIc3JHUnZPMmkwRFpSWnEyTFZzdDZsdnBWdTVRdGppR1NT?=
 =?utf-8?B?NlVXVlN1UzJUdmloODFScDlaWTdwYUFFNXd2eCtTUTNIY0kxc0s1NVhJNWV2?=
 =?utf-8?B?VTFKdDNISnBucEpRNFp2MEdXSHZZYkpxY0lpVHdzOE5iNU9ua2E4OS9XT21q?=
 =?utf-8?B?RmZTV3JhdU82TGc0dGt4VHkxamphT0RGeEpsVHVjWVo3c3hmZTVuTGFZUzhF?=
 =?utf-8?Q?3BNtjmxMnYdYZkZUrxV9iK8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d796c8c-b2c1-49a5-e1d8-08da7b83487f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 10:21:41.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0d9O5Qr0hmkPDRlBz7EhvnDsUsZSck7ZB7UeC9z6nXhD3JDfvWSKcK5oP1chO6zNM8qUQzoyk/Yo0tTqhbH1xh939/Mj01UAd+Pih9WwDFO0t8b7r+NqrScbdZsswFl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5101
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 8/11/22 11:26, Heiko Stübner wrote:
[...]
>>>> In order to make this dependency transparent to the consumer of those
>>>> pins and not add Rockchip-specific code to third party drivers (a camera
>>>> driver in our case), it is hooked into the pinctrl driver which is
>>>> Rockchip-specific obviously.
>>>
>>> This approach seems reasonable. But just for my understanding: Does this
>>> mean we need to edit e.g. rk3568-pinctrl.dtsi, iterate over all entries,
>>> and add rockchip,iodomains = <&corresponding_io_domain>;?
>>>
>>
>> That would have been my hope yes, but it is not possible for one of the
>> boards we have based on PX30.
>>
>> All pinmux listed in the px30.dtsi today belong to an IO domain. This
>> includes the I2C pins for the bus on which the PMIC is.
>> Adding the rockchip,io-domains on each pinctrl will create the following
>> circular dependency:
>> pinctrl depends on the io-domain device which depends on
>> regulators from a PMIC on i2c which requires the i2c bus pins to be
>> muxed from the pinctrl
>>
>> Since the PMIC powering the IO domains can virtually be on any I2C bus,
>> we cannot add it to the main SoC.dtsi, it'll need to be added per board
>> sadly.
> 
> though you could also add the main props to the dtsi and use a per-board
> /delete-property/ to free up the pmic-i2c, same result but less duplicate
> dt additions and less clutter.
> 

That is also a possibility, yes. However, this means that it'll make the 
bring-up of a new board slightly more complex since it'll just not boot 
until you have this /delete-property/ in your board dts. Remember that 
the current implementation basically forbids *all* pinmux (well the ones 
with rockchip,io-domains.. but that would be all of them in most cases) 
to be used until io-domains is probed, which very likely involves boot 
media such as eMMC which require some pinmux to be done. (I had this 
issue on my device already, so not hypothetical).

[...]
>>>> @@ -2684,6 +2693,16 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
>>>>    	if (!size || size % 4)
>>>>    		return dev_err_probe(dev, -EINVAL, "wrong pins number or pins and configs should be by 4\n");
>>>>    
>>>> +	node = of_parse_phandle(np, "rockchip,io-domains", 0);
>>>> +	if (node) {
>>>> +		grp->io_domain = of_find_device_by_node(node);
>>>> +		of_node_put(node);
>>>> +		if (!grp->io_domain) {
>>>> +			dev_err(info->dev, "couldn't find IO domain device\n");
>>>> +			return -ENODEV;
>>>
>>> Again just for my understanding: The property is optional in order to
>>> provide compatibility with older device trees, right?
>>>
>>
>> Of course (at least that's the intent). If it is omitted,
>> of_parse_phandle will return NULL and we'll not be executing this part
>> of the code. However, if one phandle is provided and the device does not
>> actually exist (IIUC, the phandle points to a DT-valid node but the
>> device pointed at by the phandle is either disabled or its driver is not
>> built). That being said, I don't know how this would work with an IO
>> domain driver built as a module. That would be a pretty dumb thing to do
>> though.
> 
> I think this should work even with io-domain "disabled" or as module
> when slightly modified.
> 
> I.e. for disabled nodes, no kernel-device should be created
> (grp->io_domain will be NULL) and for a module the device itself is created
> when the dt is parsed (of_populate...) and will just not have probed yet.
> 
> Together with the comment farther above of having the io-domain link always
> present we should get rid of the error condition though :-) .
> 

It is not possible to have a rockchip,io-domains entry for all pinctrl, 
because at least a few needs to be removed, the ones related to the 
regulators used by the io-domain devices. But I guess you were talking 
about the check on grp->io_domain pointer?

> 
> 
> Hmm, while going through this one thought was, do we want more verbosity
> in the dt for this?
> 
> I.e. with the current approach we'll have
> 
> &io_domains {
> 	status = "okay";
> 
> 	audio-supply = <&pp1800_audio>;
> 	bt656-supply = <&pp1800_ap_io>;
> 	gpio1830-supply = <&pp3000_ap>;
> 	sdmmc-supply = <&ppvar_sd_card_io>;
> };
> 
> and pinctrl entries linking to the core <&io_domains> node. This might bite
> us down the road again in some form.
> 
> Something like doing an optional updated binding like:
> 
> &io_domains {
> 	status = "okay";
> 
> 	audio-domain {
> 		domain-supply = <&pp1800_audio>;
> 	};
> 	bt656-domain {
> 		domain-supply = <&pp1800_ap_io>;
> 	};
> 	gpio1830-domain {
> 		domain-supply = <&pp3000_ap>;
> 	};
> 	sdmmc-domain {
> 		domain-supply = <&ppvar_sd_card_io>;
> 	};
> };
> 
>         pcie {
>                 pcie_ep_gpio: pci-ep-gpio {
>                         rockchip,pins =
>                                 <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
>                         rockchip,io-domains = <&gpio1830_domain>;
>                 };
>         };
> 
> 
> I.e. linking the pin-set to a definition of its actual io-domain, instead
> of only the general io-domain node. Somewhat similar to power-domains.
> 

I like this (well, not the "modifying existing bindings" part though). 
This could allow io-domain driver to be more of a bus kind and "probe" 
each subnode individually, allowing to break out of circular 
dependencies. E.g., I could have some supplies provided by fixed 
non-controllable always-on regulators, and some by some controllable 
PMIC. Though this wouldn't have helped for our design since the PMIC is 
providing the power to the IO domains pins of the i2c bus on which the 
PMIC is (so whatever we do, the HW representation will always include a 
theoretical circular loop). This would maybe allow us to mitigate the 
issue I talked about earlier with the need of removing some 
rockchip,io-domains to break this circular dependency.

> The code itself could be the same as now (except needing to get the parent
> of the linked node for the io-domains), but would leave us the option of
> modifying code behaviour without touching the binding if needed down the
> road.
> 

Would I need to support forward compatibility of the DT? i.e. having 
rockchip,io-domains DT property work with the io_domains phandle AND 
sdmmc_domain phandle?

Cheers,
Quentin
