Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D63516ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiEBL0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiEBL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:26:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB43BF61;
        Mon,  2 May 2022 04:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9VgflaABwc3vPvnOxFHnaX7ddN71cpg8+3dr5p5Rc5xMm6Obx7I6FOPVQACEFCFpSAwRVB4k3UmfIs63dKZx31E3AWQzPtmZIkLRUr1Dsp/ijrLcF6jlSnVJneml+Jg8y8ORTz6DQ5Qv+IXCIj1pzxqY5s2pGiIc2gIeD57sg25LDd8M/lHR4zXS2n9dkOaA/u5w/q2Q8SrqTsuqF7SpUiftwGy1zUo+QoQHUJ2u+u3oel3J9O+8e2BXyeYF/U+Iqsj6PhnO6NzdKA3z3y4XNBIQPHew9gJ+fW82IXFKbUxtEdrN3QK8z2aUqRYgQnq9Bj0eMQTj9+HsV4INAqjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiOn1Bvd2JS4uZGbMiNgbEi+ejK1K2prOL3ZlM9hfkc=;
 b=lh5kCYekNatdm8G0avHOMH9Bmj/QGrUBwUplZKADTk7LsqSynCgw/oqX/yO/L4CHVcPkKQSqM3Q5Ci1R+iJpLd1cJV1KNafN6SfCUIObB4SowgUdA7sYWX5BJqS6CntvI6JfTZHS3TFePrsi2gxXbT16UOrfY63Ab53CNgQx4b6r/nW72+R57wX5xztSz4wMsDfLNOYL/rvMHwmM9ozDPX8qEqnuYvKxb9RNrKpqCGd2VgEUXkXzkcM5+Yq0qIylKMYeAE2aMYIIc24mj8yFNFQHSUAHTayIuY0JaFyl9+CWHkXrRmPwkCPvCAMzlljo4xrEB1KXt8K8RVW5t8z0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiOn1Bvd2JS4uZGbMiNgbEi+ejK1K2prOL3ZlM9hfkc=;
 b=AhBa4OzFt0hgbFrkdl8qVSeQariEbcUucW+Rro0p+OS/TpX5pAAeH0ubsHZ4eyU25YMVLq/vDesgSBYV0wkQ0dAD3+2B8FTD5UB58SGI94Npm/t720023NDbcyHz66zadHZ1yHxSdC3eSRhVsZHPV8+k87gws5a1aoAe3k1c/Jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM6PR08MB4533.eurprd08.prod.outlook.com (2603:10a6:20b:b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 11:22:59 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d%7]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 11:22:58 +0000
Message-ID: <c892b25b-eb0d-40ba-629d-d173d8b834df@wolfvision.net>
Date:   Mon, 2 May 2022 13:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: enable otg/drd operation of
 usb_host0_xhci in rk356x
Content-Language: en-US
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
References: <20220425133502.405512-1-michael.riesch@wolfvision.net>
 <2087500.ItEYzMA54p@archbook>
 <ca670161-7133-631e-f4b6-b48c8fde669b@wolfvision.net>
In-Reply-To: <ca670161-7133-631e-f4b6-b48c8fde669b@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::15) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff5330a7-8aa7-4999-b944-08da2c2e1c79
X-MS-TrafficTypeDiagnostic: AM6PR08MB4533:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB45332FEC4E33A512E217C977F2C19@AM6PR08MB4533.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3PdfH3YHTfJDe0XMGaF86JvocFunmKR7KdT+xxbGVyyfq0huco0kpeB7wv1UdVQhL9/JIgVp32Cst7rCLFmj3r1aVTED5b5W7BOGXs1tKujRGfS97JFhDSwFoq8ckgpxaWeKEF8109L0phQPDFupAikfC4g3VRkZhoolLKNAQxylcxlKmneTlUwaxxbbwKAGxonUadEkAqE2xIfYPzJWCVDxq82DCDZCCDvC+Vm/ofn68Ppk3ilP/H/nrGX0UAZyT4AIqvX4eFciu8XiwHr/4fn0b+3+mkPhfS2F0LNBroJAsi2t0pXWxwbbvAkEwE0pTwh7ClqttS3902EkVnLaxZjdhovrtn+LWWrTK9oyBAc9A02eQsGcGvQ4d46JiZrrGrvD47J/1EB8j0KgwQufC+ExIuaRuwSs0koBqqDLFoWf3yG5cEMEMd4ed7lNYx1AnofDmasnI4QlsFf2lkC3peAMUsPkTu3tUo6bzqTMtSKcfA6L999eb3CxzmXA+5WQyaC3je78gQypyHMQcHICrSXWwiVWCm+BPtWr5oZPlfp+x+jOv0HF08Fe9jrhaiCI7vqd3L0AWD8FlTT1bHgd91tKf7LHxYQbhxslm4oLeUd/JEAoMU+uJXl7y8Z4qjYpAPhcr2BMApHDGb4L7GeVhNovywM2eGpUEJadBL8snjytmJ+DSqYm7DxsbszhKVV5XFf3W9XT9//M4qE/cyzc5VrClvWZFfXiZ47OAZpZLQph9HCLgWHLxPyxdqyhN1TE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(346002)(366004)(376002)(136003)(39840400004)(4326008)(66946007)(53546011)(52116002)(8676002)(66476007)(66556008)(6512007)(6506007)(6666004)(316002)(36756003)(38100700002)(54906003)(2616005)(186003)(83380400001)(86362001)(8936002)(7416002)(44832011)(5660300002)(31686004)(31696002)(2906002)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGVxanU4R29zdmVGazY4TTBkSE9kVnhoYzFYb3F5WVdKaFZUN0hVbkp3OXR2?=
 =?utf-8?B?cU9raCtYR05yOE4xMUN6Nko2YUtTQ3hCL1pTVVBaWTR5Y1JpQm00Vm9oQnFu?=
 =?utf-8?B?bFd6SXNlNm9RWlNaSnFvbWhDUzdTaG9nVDBqNTBrTjJkZE5rdDBLRkNSZU1z?=
 =?utf-8?B?U0xscDhTMzBUMFNNT29RcVVwU3p0b1d2KzduZ1Q5QnNxd1Uvci9QcWhjT1hZ?=
 =?utf-8?B?eGs0WWdVaTFQaytodlhsbmVtcHFpTDY0NEh6a2FEbkIxVDR6WkRzQVFjTVlx?=
 =?utf-8?B?SzlMeTBIV3dtOGZPTU9OZGIyVEZhTG9yU2pVSVpnSkNaTTFaY0xoUjFLYUE5?=
 =?utf-8?B?UUt4b1FWaWtBS1NFblVaUmloam5mUkE1T0JCWmxwVFcvZWM2RkV6OXJTR1VT?=
 =?utf-8?B?d3p2dDRrSWZnOHRVbk9Mb1ZUb2NaZFRURWpJSzZmZ3gyRURPMmdpWE9wMVdp?=
 =?utf-8?B?cHIyMVZGeUc3VDIxcUxZWXV4YXJ4Vk5FQmd2amVvOW10QTlNMytPWittYml6?=
 =?utf-8?B?QklRdmFKRld4ZmFqUXNsSm02UHBaaHdFOEJUdGJsSHFSWUU0eFFSVk1BRWJY?=
 =?utf-8?B?RjJzRnYvYnVoVTJkbGZiZ2hsMnVoSkN6S3ZKKzhEcC9LczdtRzhlbFJDbXg1?=
 =?utf-8?B?eG5GWm1oR09MeDV6ZjNYdlVVYUdyTFp0QkNqbVZySWloS1NxbWlGTkZhazl3?=
 =?utf-8?B?dzloMm16MGovUjRpMlNPVFUxYjdBVW45Y2ZlU3RHNERzVlYwVDBGaERjdkNO?=
 =?utf-8?B?UkpsUXRsQTlzOWk0WStUZzk2YXgxYlNsMW5tL2J3Z2RVRFhUcGNGcVBVc3pJ?=
 =?utf-8?B?RGk2dFB1czhQQVF0dVRZREtLSDVhMFZmL08wdDd4Z0J5MEttUXoyNTVDejVh?=
 =?utf-8?B?VVhTTGFpQ3JxZ05sVWRJaWVpSzF0SlAvTjNnVUx3ejRJZGZ4Q1BOSDQxdVdh?=
 =?utf-8?B?aS9kUmVmampXTmNDbVJRdlI2cmdXMVNReGxDN3FDS0ZhUXMxYVNuVFhnOTcx?=
 =?utf-8?B?bFowaUdNd1hlLzh6TXlTWklLdkxjTVB0dnNwdGVScng2M2o3SnhEUmhmU3Ns?=
 =?utf-8?B?U0kvNFJFOStwakduaGdrd2hQL2tyTlozK3hXRHVGM2tSV0dycVhrMGZEVHR6?=
 =?utf-8?B?TXpldjBkZy80SDNteFkzM3JTYXlycXJKUktwM1FHaGVqVXVYcGhZV1Q1Sy9Q?=
 =?utf-8?B?VXU2dzcyajdaZ1YzVkw4OERIbmpUak1FTk1WTi9jUWV5ZWd6WFdhbkdSQkhi?=
 =?utf-8?B?cHpPOTFYblFoMDBHUDlBcG5XYXdQKzRObldNcHNraThWM2MveHpxVmIrTkFD?=
 =?utf-8?B?S0pOcUI4M1JRSFU3aUJTQUMvM2dkdnBKN0FYN1lEejNPQTBQb2xqZGFwdEZD?=
 =?utf-8?B?NVdXZjltQUliWkN0SWJzbTVBTU1lN2EveDZncTc2c25sZmpseVUrTU5FaWZ0?=
 =?utf-8?B?SkVaTTZEOER1ZzJwRndyeVNnT1NudU9mRE1sdC9NaXV4d05vUGVzR1VjMCty?=
 =?utf-8?B?RXRsS0doejhqa0FrSzIvMEkyRk0vK05VVkdQNVIyODZ4NWt4SkxXS1RvK21y?=
 =?utf-8?B?NGpFa2I1VStwVkJFQzkxbXh6WEMyWDhmY011Rkl0bndRZUJodUtUWFZTczBo?=
 =?utf-8?B?YVpod0Z5aU00MUhkR3B5RUZMNE9vZmN0dU9aYjQwZCtLdHhyblVqNlZPWDZy?=
 =?utf-8?B?OUZEK05kdFVZOXd2OEVYWW93TzllZU9JYmNQUXZ3dDFYc0VLMUlvVFlKL3d4?=
 =?utf-8?B?eUVFK0lZSjlmRElScGRleU1PdEowQlkrTkhFU2swZG5OdDFVTVJpLzFsa2Vn?=
 =?utf-8?B?YmxjUTdNYmN1eGVVOWY1N1RNTXRzL3VTWXF3aG9NOFd2ZTB3NXpyWmowZTBp?=
 =?utf-8?B?ZHRud3BjOWNjbnFCcXp4elJ5K0JMb1ZwK0QyVm5aSjZOa0hxMjJ3QXpmeUxT?=
 =?utf-8?B?OUhZWlVwMEJKTFE4eGo1VFp6M1hKSUhBMkMzM0xFakFldUswRlRkazZSbnUr?=
 =?utf-8?B?ZUh2OFpMN0huZHVoOHZyb3VPbUphUWYzQ1BQenFnSWJZMG5FbUZBb05sTlg4?=
 =?utf-8?B?RFNMTU5qNFMzQmtHajJJL1VSak43VXUyWXdNcGhaRE1TVHAxN0pWR0o3QzdL?=
 =?utf-8?B?cUkxbjEyUTdHNmZtMFJqMXBvSzlPMFF1SEtQVW0vdUxxSVgxTjlGd1hDYWd6?=
 =?utf-8?B?MFROUDg0RTM0Ykl0UHk5Sk54NVlzUzdwYjY1aDlzejcxdGpMTU5zZ1VmaFpP?=
 =?utf-8?B?N2RmM1hmL0gxOWJSL0p5MHpIU2l2WjRQS2ZwRGRqaGhsMjZPVE4zNi9IY2NU?=
 =?utf-8?B?U1BhUlJ5bVp4WWRHS2swN1dnK0tmRkdKcGVrY2VaSjBZNXlJTk52aGhJUkd6?=
 =?utf-8?Q?J4mln+I6wvKeow1F3kAfCwk2tp2Bv7Yt+Nb+aJe6MPHY2?=
X-MS-Exchange-AntiSpam-MessageData-1: 77g12r15KLUNrWnkSSiCgLVHAVLF05SDaYqPYeX95tIkl4SRS/NDTluT
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5330a7-8aa7-4999-b944-08da2c2e1c79
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 11:22:58.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4T+WtVcONad+enujJBW9XsDA8VLqEhR9YHF7gtFZ7OMsIV/Kwi0b+0ZhGO2yXrizkeGwcGQso2Q5Eq95aiGtcoGbhTvuJu9L/jaxs0WpbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4533
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On 4/28/22 15:24, Michael Riesch wrote:
> Hi Nicolas,
> 
> On 4/28/22 13:15, Nicolas Frattaroli wrote:
>> On Montag, 25. April 2022 15:35:00 CEST Michael Riesch wrote:
>>> This USB 3.0 controller is capable of OTG/DRD operation. Enable it in the
>>> device tree.
>>>
>>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>>> index 55e6dcb948cc..f611aaf2d238 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>>> @@ -266,7 +266,7 @@ usb_host0_xhci: usb@fcc00000 {
>>>  			 <&cru ACLK_USB3OTG0>;
>>>  		clock-names = "ref_clk", "suspend_clk",
>>>  			      "bus_clk";
>>> -		dr_mode = "host";
>>> +		dr_mode = "otg";
>>>  		phy_type = "utmi_wide";
>>>  		power-domains = <&power RK3568_PD_PIPE>;
>>>  		resets = <&cru SRST_USB3OTG0>;
>>>
>>
>> Hi Michael,
>>
>> according to official specs[1], only the RK3568 is capable of using the
>> USB 3.0 controller in OTG mode. For the RK3566, OTG is USB 2.0, if I
>> understand this correctly.
>>
>> So I think this should be an override in rk3568.dtsi.
> 
> Thanks for pointing that out -- will change in v2 (I'll wait a bit,
> though, as I hope that patches 2 and 3 will be applied as they are ;-)

I have sent out v2 and got Peter's valuable comment in return that the
v1 patch is actually correct.

> [...]
>> [1]: Compare page 17 of the RK3568 datasheet to page 16 of the RK3566
>>      datasheet

These data sheets can be quite confusing, which is why I seem to change
my opinion about how things should be from mail to mail :-) Let's see if
we can figure it out together:

The Multi-PHY Interface section mentions a "USB 3.0 xHCI Host
Controller" for both RK3566 and RK3568. Additionally, on the RK3568 a
"USB 3.0 Dual-Role Device (DRD) Controller" is present. On the RK3566,
on the other hand, a "USB 2.0 OTG" is mentioned (extra item outside of
the Multi-PHY Interface section).

When I read your mail, I mistook the ehci/ohci controllers for the USB
controllers in charge for USB 2.0 OTG and found your comment to be
correct. However, they are related to "USB 2.0 Host" on RK3566 and
RK3568. Also, since it is explicitly stated that "USB 2.0 OTG" is a xHCI
controller, it becomes apparent that usb_host0_xhci corresponds to "USB
2.0 OTG" on RK3566 and to "USB 3.0 Dual-Role Device (DRD) Controller" on
RK3568.

Long story short, I agree with Peter and the patch at hand (v1) is the
correct one. Sorry for the confusion!

Best regards,
Michael
