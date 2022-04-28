Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C157513500
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347165AbiD1N1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347035AbiD1N1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:27:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73E2AD10E;
        Thu, 28 Apr 2022 06:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXf2upM7YzOgHLal8AWwn2mafBD/fT04g7Qqm3mq7Fxg54PvuE+sZ6U7ooGW/GtoHagZh7F5jrnZWmMv7jEKX1/3emyf1csy6CyY0xUoJS0aOG/+8X+b/s2nThXnPSG/peILCrcElXFdEOwYPzZ1cSD3kG5SjB2kTnP9H7rQ+mLqEbCvnJ9dNshqlRAOQbOXIsZK/aCkYknfxzcbrwmIHPNJ7ZaNW8wJrgeHhK76PONIwfSMrSi6XeP6uM0sZhs8xGZTIkcZbdT9qRUXic5/Mb1jo/C1ihTcmUlvRZS46unSmWoctFCiPj3RpddAZNKbtH/4RX7ZTfiUcvu0nEHYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeGd/p8KTpLIXGQEz6HnxxbaJ45AV/lahAOwOAYh8jY=;
 b=LKvQQkbRrueNQ9R/N+9agwRt2mONHeJLYNI5Pjk39eHl4Dxjz3A1emI0j3K/807H5oOyD4vBt1E0rHppmd4VmzIHHebRdrQCcf/HcAW0QWAaE6GgFdtd5l4NC4J1AweGfi6yD4YwcFRNbqgfKf8ULEq5NYB7I0cMrT0XrFH7DJHTUWN87qwJyEG3HX0zOSwEUhnfHPzpRXyMqEwifX8CJOuwhSKtFxI/Ypb+gJhcR1EnVSgrYeBnxckcFK+ST1ANEgz07r/Xh46vWXtXPk0lIm8HoLqqhaguKBIPdTgwB52UhEJrmLLXPSAJYxXuaRlOLNjKUPfpRzYi/3GAZaftDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeGd/p8KTpLIXGQEz6HnxxbaJ45AV/lahAOwOAYh8jY=;
 b=2VWkC0uXZNqbNVQYC/1TtyHr6zxi4Si+clyrLYTRmUbk9sV8w6UWCEvzXAx8fOl/jeT9fCaCEyCuyiYdDqdFMEQVWUd7pzSxAc26Irg0UYS7D1LmdasnLlyr7AZ6kgCkmdAB53wcKpulvC0JxIIYqT0/cidZTB4/wS+u6uPyR18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by GV1PR08MB8010.eurprd08.prod.outlook.com (2603:10a6:150:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 28 Apr
 2022 13:24:17 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d%7]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 13:24:16 +0000
Message-ID: <ca670161-7133-631e-f4b6-b48c8fde669b@wolfvision.net>
Date:   Thu, 28 Apr 2022 15:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: enable otg/drd operation of
 usb_host0_xhci in rk356x
Content-Language: en-US
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
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <2087500.ItEYzMA54p@archbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1406e51a-32c5-4cfe-2ccd-08da291a64cb
X-MS-TrafficTypeDiagnostic: GV1PR08MB8010:EE_
X-Microsoft-Antispam-PRVS: <GV1PR08MB8010B53E858AAF5A636DA52FF2FD9@GV1PR08MB8010.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0eua/jlVo3o9vOpdSPtJNbb5U/Qk/VK6e8KaJ/l5DzU/hsjZ7pT/TdXzL5B6lRmfE91jlpCt9QITJENyoPJE0Kq9kTCxXd9gJ449RfFlmkGJapfOvbZyB/Jqcwpe66hLkTnzjaRvPkGzaIEDWMy3WyWQU4O6UvfrKA2COZrQK5a+yUsGiEyK9/xx/cLcaX4K5M2S+Oc2WoIpom9p4u4YdbTboL5mdgRY6iuqH8Nolg/T12kD6vqrpD7y/6KQLqo7hNIM26EVryM17mqgHljg7vClDN8FTDHKTpXBXjwp3DIqn37UEaFKK17Sbuj3AKyDpqNsccpJJjbusjwZGYxVxNpRDIzNuGocpo/RWo0Crf49nYbjISCdyOjTfeC1+Rx3iqT0nddEKndb9zJTjO7aosrF9fLo8UfAdZnp7FgitXoImTsoLGBUt4xzM+7BayH711e6vU7ag4ovLwHzZ6lrGWqAGSI6699g5lyXKpmP96yvi0WesfTj6j0mFvPMCfARna6nCRvy/c4zYbmp1mRKnN3dCvUyNXTc3b8IenzVtmxfdnsIBNQTVdfLZZa34/IwH6JKIliAEDAl1INBcF3Wc8MpFKyJI71CceQ0ZiAHC7qJXiTY9tCpukgzSBuWjCIP3cX3VQxOk+Zwzlhy/N+oxPypOp+C9yaRXfscTmH9oZ9PD9xYk54U9Gq9U8CbVGseR3bZ/37V+yTG6aMPYECgIHC9p4/yXIx7ma+fYuMHDLth3ydOtlDYqtidPIvyIniwhOBgoghXtyGmxRQW3iHhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6512007)(5660300002)(54906003)(7416002)(508600001)(86362001)(66556008)(66476007)(4326008)(31686004)(8676002)(66946007)(316002)(2906002)(44832011)(36756003)(8936002)(6506007)(6486002)(52116002)(26005)(2616005)(38100700002)(38350700002)(83380400001)(186003)(31696002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVN1Tm1pMUxzQmFkSXhzcmtLZ3d3b01iS1lXVGt0QzJOTjFNT3I0SXd5WHl1?=
 =?utf-8?B?TkxqRjJJZ2h6c0Z1ams0QzltNWFLcWdjSWUzZzhmblJGdUlFbTlSa0FMQWdU?=
 =?utf-8?B?OStsTnI5NVFEcUhqOWFYamExNThrRjRZTVVjQVlyQUFaZ2s4NDhMMXVQRHVo?=
 =?utf-8?B?dUs0c09qKzVXbituK25ZS3Y0cTA0R28wRDdwM3JpcnFlOUlZMlN1VWE0eHpr?=
 =?utf-8?B?czNGQ0FMSlp0ZldyOTlKWXFVK0hDNkl3dS9vSngra1oyUGF1QzlhWlFNVVBB?=
 =?utf-8?B?ZUlxaWxpVlpVTVk4Y1RHWW1IblZOV0hqTTg2cWE3UlJmMXZTN3p4dHBXLzZN?=
 =?utf-8?B?b1NXRHcxU2FGd29YMndBRFlvRzZOK3RtOWRXRFUzTnNRKzZJLzhGUGtTVUpv?=
 =?utf-8?B?WTFJM1JLR3g0Y0ZLbUdjeGh0V2gvbVhLYmZ4cXFNdnN2QlB5Tm9RQ01TSm9T?=
 =?utf-8?B?eGFTNVN1Z1g2dUU5dENBU1BIQi9KeWFvbVhaQzk4S1ovVW5obkE1QTFPUzUr?=
 =?utf-8?B?VTNYS25uUlI4bnM5Z0E3d3I1L1Y3Z0YvV2lCU09aS2hyVmkzTXFrNWYyN2cy?=
 =?utf-8?B?OStLYmFVcnpzMlNUS2tkWjZ6eE1YeUJjL1l2Mk1oV1QyTElzYSszTTE0eWl1?=
 =?utf-8?B?Zng1KzNReGU1U1Q5SjMxdWpIT0paSTl5MzBpV2lkazZaaEcxV0tJdENlQnR6?=
 =?utf-8?B?T1NnYnFQeXZqV09ya0Fkb0I5R3F4UlZwTTRLOXFlWjJOZWlQekU4dDdpdDJJ?=
 =?utf-8?B?VnplbzV0ZGxxem5NeWhNM2tZZDZTcXZDL1ByeEphcTZMMlhjNVFGSjdtSVVY?=
 =?utf-8?B?dDlBNkhNbElTN241WEd6UXJGQXJQV0NwYytVSlVDOGxjNXRra0xnZjUxUWZY?=
 =?utf-8?B?NHhvQm9oazd6UUJTT2cwbzdTRDRyMHhGN0NJK3NhVDQyUHBMeFg3a2JseGhp?=
 =?utf-8?B?ZStCREdyQWJkNXpvRHlUVW5CRHAvNlc0NXN6NTVMd3R1K1ZjQnlBQVpqTG0x?=
 =?utf-8?B?Y3F6aDloS1MyQzd5N3UxY3BDVlNuVUtrK0VmRnpoY2k4aXJtcXJSWnZnbUc3?=
 =?utf-8?B?cDlHVVBrOGVjbnUydEdRcTg5NTVtZ2puUlpNbFBnVjBvNVZ0NFBxZGdMaXE5?=
 =?utf-8?B?dXIwQkNkOHp4MTVZbEtCQmJlSzZYQkQ3WWhEcTB5aG1tMmxueHI0UzYyeXNq?=
 =?utf-8?B?Y3JCZ3V0czdCMFNRNUlPSjFVUUtINXBWK1RwNHpxRitDMWZpZjI5K244T3lR?=
 =?utf-8?B?NVdvUGJEdkJuT1lvSUxZS3I4RGlLTjFhd25FdlFNQ0tRTW80V3RWOWxsZnJV?=
 =?utf-8?B?NUxNemhGb21ZaVd4bnZEZDlUYnVMTGpiRW9oZU5iQXA1WjlOblJIYnhQQkov?=
 =?utf-8?B?ODBMSUN2QmswSE5DaFJSUktQOGRVU1M2NU5uc01mR3BvOFoya2NJTWVLNFlB?=
 =?utf-8?B?alZnT0NBS3BwdGljVTFxR3FaL3ZFNlYwNEZuaEFtU0oxMWJZcFlLekRwLzh4?=
 =?utf-8?B?eUt5bGRhbWJVbmpLZmRHYURXTFpId25VSUhGbzhmMVdIbW56MWI5ODNESjZV?=
 =?utf-8?B?NHpjVFBYeXBQTGloSFlGL21RTG1JdTZtSlA1WVhKdkUzbi96eW5vUzNlYUda?=
 =?utf-8?B?UUYwWGgxWmR1cER5MG1tSCsrRU00UU56ZGlmSHN3Yi9ReXV5TGw5cXl0Zys4?=
 =?utf-8?B?cTJHL0lUWDlDbmZSblEwbUtab05GRS9KMnhxejVkbDdqRkVNK1A5YzE4Sndk?=
 =?utf-8?B?TmdJamlpYjFpNU55SlI3ajJmTWRNS05hRm5CTUwvYitVQ0V1RW00MytPSDFQ?=
 =?utf-8?B?QWRnelNqMWhJMUw0YWVKd3VCUzVCT1l6RjJEaEpwZlRVaVhVM29TNm9MaXE3?=
 =?utf-8?B?Yit3c1NwTnYvbWVwdFE1TlN5Wm5JYlZnUldDblNlMXIzUCtDS0dVTHZVT1dO?=
 =?utf-8?B?UHZsbDk3dWYxMUlNUWdIaTJsOHU1OGxQNFNNRGtDejNsb0dpQVh2d3BoRk1R?=
 =?utf-8?B?aGV5RGdsTWNKcGtIelNrR0w2T3Ntc09QVmJBRVRzZkJrRldnOW9qcENtcWFk?=
 =?utf-8?B?NmNPUzdZb1E0d1FDR0tUb0ZKaGpkNTVDZ09sQVVpbTVwS3RLSkV6djZtc0Z1?=
 =?utf-8?B?MDRrV3RZemZsd1ZiLzlZbkkwZlkyb1E0VG83b0JJUVltRlZXeUhzR0FmUDJ1?=
 =?utf-8?B?aGp2TkR4dldjODBiQUJjbkhLblZJeTBMNi9kYVZ1NzhNT1BFc2FvZHhNb2xn?=
 =?utf-8?B?YnRGMGVidDI4THVMalppeEwrTUo5S2tVYkJPMXhyNko3bGY0NG91WG1lbjdB?=
 =?utf-8?B?MDZWa3kxaDZGMmduMkdKdXp6UGhwdGR1clZrbGZkdDVlL21mcW5leWhYR0xM?=
 =?utf-8?Q?hOWzwePrXlRlfLKM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1406e51a-32c5-4cfe-2ccd-08da291a64cb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 13:24:16.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/e+pgsXuigdPY4zPLLUpQ7XGYjz4pSFTWB0HvSi9Xwgh4uNcXMQ7Aoqv+K87ElRXxy4p9k8XXFsRxMcS6qugsyoZG3/OGO4X0p26BQgJVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 4/28/22 13:15, Nicolas Frattaroli wrote:
> On Montag, 25. April 2022 15:35:00 CEST Michael Riesch wrote:
>> This USB 3.0 controller is capable of OTG/DRD operation. Enable it in the
>> device tree.
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> index 55e6dcb948cc..f611aaf2d238 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> @@ -266,7 +266,7 @@ usb_host0_xhci: usb@fcc00000 {
>>  			 <&cru ACLK_USB3OTG0>;
>>  		clock-names = "ref_clk", "suspend_clk",
>>  			      "bus_clk";
>> -		dr_mode = "host";
>> +		dr_mode = "otg";
>>  		phy_type = "utmi_wide";
>>  		power-domains = <&power RK3568_PD_PIPE>;
>>  		resets = <&cru SRST_USB3OTG0>;
>>
> 
> Hi Michael,
> 
> according to official specs[1], only the RK3568 is capable of using the
> USB 3.0 controller in OTG mode. For the RK3566, OTG is USB 2.0, if I
> understand this correctly.
> 
> So I think this should be an override in rk3568.dtsi.

Thanks for pointing that out -- will change in v2 (I'll wait a bit,
though, as I hope that patches 2 and 3 will be applied as they are ;-)

Best regards,
Michael

> 
> Regards,
> Nicolas Frattaroli
> 
> [1]: Compare page 17 of the RK3568 datasheet to page 16 of the RK3566
>      datasheet
> 
> 
