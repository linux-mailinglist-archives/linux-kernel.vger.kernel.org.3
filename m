Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114204C4DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiBYS0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiBYS0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:26:37 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00068.outbound.protection.outlook.com [40.107.0.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D899226834D;
        Fri, 25 Feb 2022 10:26:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx7FSPYnntmf1H/kIegpYB90FKT8D4400rSz2r9Cv3TrewX1OV8sg2XkkPsj0b9nNw8GM7DLwPXQybFRRbHkVI5MzK0rxkv0Y8cuChEaHPDOcEbrmDbUGNAifvdAK9ktUSQFYd/DsuVxyj0TjjBn9IVl//zFpM/X1bpBkglplmME7QFHkUazi7ouGfbUtJLKiSKgiFsnae3139PBzWcNfXQ8MrieUF695bDZRHuNITK3FP66bY1vRJRMAFzJ6xdnor/3x8FN4TZRUN9MJ6umcii9yO2mh9CokpsmdsPK6IHWaSUM6RL9yMNLJLgzrRqbRQaO9B3zabEdbDvbfhLmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk3XPuQ49yrkvRrZjHekSmYWEv/f2nTvcRa74o+UchU=;
 b=Wks1Mr4HNGv+uDbC0mbpOWAFSYGmu76GLj6GrV53DGefI7WWvkb19QWOzijxL851J2vXgi/+TBl7ySTmIvEzeMQJ/Y1jPDEyD2WfWrMxJYGZ3gvcQSRmJxkB6rUJ6DansCSAnoTId77cDr6dLEv0oXWHb2qI+xmiBbWbscIrfK8cjrvT7HJZB+en4E3l9NbWHPMfaGFSzFxYm1M7ZuVGZGeZ7MwMRgZY/WN2xWBUmkvWFv/iAYDN0RD75Fvi+Cq7PN/u61St9eKg80QqT/Ym92C59Ehkbq79RtzpuLM2jlEUs/+zCsdEWzIcoooZuBDgNp8YOnQYF/VH5ENlz9RXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk3XPuQ49yrkvRrZjHekSmYWEv/f2nTvcRa74o+UchU=;
 b=CALRaErWaDthseEbPkMpaSe/vPVVs5k/ay6lhkko98U2sy4Nls5yetLckMlf6CQl3+HF0mu67MQ5ZzKtYdULzZicw0w0ypp83aSqcMJi9LTHyFMYrzFEleseIJeytxUZ7/0nsm0oqLI4AWAYXTrgGgbcE0Ovq+gc40KiKSycmBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR0802MB2430.eurprd08.prod.outlook.com
 (2603:10a6:800:b1::13) by DB9PR08MB6537.eurprd08.prod.outlook.com
 (2603:10a6:10:250::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 25 Feb
 2022 18:26:00 +0000
Received: from VI1PR0802MB2430.eurprd08.prod.outlook.com
 ([fe80::64e4:7dff:b30e:da60]) by VI1PR0802MB2430.eurprd08.prod.outlook.com
 ([fe80::64e4:7dff:b30e:da60%5]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 18:25:59 +0000
Message-ID: <4bc8533b-cc60-a524-551c-5edd29905506@wolfvision.net>
Date:   Fri, 25 Feb 2022 19:25:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1 7/8] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220225145432.422130-1-pgwipeout@gmail.com>
 <20220225145432.422130-8-pgwipeout@gmail.com>
 <2f1f09c0-9b7e-5145-fb25-a5f1fe4d0ab4@wolfvision.net>
 <CAMdYzYqRsOji3PfxK_FgOUbg4KomC+LnWgkTXS7=YRKTuPYVow@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <CAMdYzYqRsOji3PfxK_FgOUbg4KomC+LnWgkTXS7=YRKTuPYVow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0159.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::8) To VI1PR0802MB2430.eurprd08.prod.outlook.com
 (2603:10a6:800:b1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d382b78-b9b7-4282-bfaf-08d9f88c4563
X-MS-TrafficTypeDiagnostic: DB9PR08MB6537:EE_
X-Microsoft-Antispam-PRVS: <DB9PR08MB6537049B8A2D98A507FB22FBF23E9@DB9PR08MB6537.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g08HTCY75vu+H7A7b4yjUA//bYRBVAb42qt+8eti4XjbPV6ihGFrmJGp0kL5JwFgn5JMVmLpFer29nHowBW5exLu6TqgzEECljeLxoiQ9a/4aoSN63vC7zGbAmcCli9ZtjFksGv3m018NRRF430dZ8vyod6jc7NyIXlf7ZYUQo+i3czHeGvDXdCu605sHSOkIZSYgeQRDFS+wi+ju/2NdrgqHO8dKDvEOgO+mJik//ZPG0be38Ll8L4wIg3ZZEYDRQtXI5nX1xVlw1+O62tHq7ZGbd7OWrQOfcR8ki9QS0aYV9r2lYElAuY1bTL7rbwX3vRjC56kvLkl+0gMnErkbaJwBZ4JbXQK0SRf08TZjAjeHqdQKUtSl+/W5b9qAycSGCl9BK8Xe0hlv/dKH2BOBG/7S5PstOxHl7szopCG/pLbeZAKcrULZQDdWiZkSfJJ2WDjG74YBjuPMICJaO8EVFQxlmRxhVRHcW8b0q8uUK0sLxPdvdcAKjsxARaZy0ZeZj+ToBC9XMdSxa0ApLh7AxehHVvbA1oc4WyFUG9j4brtWhn5rWc76xd2v8B+qIrF2gwFlpexnb07DfX8c4OyBCjuy58NItQoYLR2YxD0ztRBjT73iFES6w6diMkdRKQvV3ij3c11sOkxRra7Ff6IWmKpC8w2z6OkP3o6o7m2QWfFi39MWyo9S7QdkZnp9ZKeHeZFjFIiKSWFbzKaieJRWY02zjJjimZ+82p1YTtpRBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2430.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(39850400004)(346002)(136003)(376002)(396003)(44832011)(4326008)(38100700002)(36756003)(83380400001)(8936002)(5660300002)(31686004)(2906002)(6512007)(66946007)(66556008)(6486002)(6916009)(316002)(52116002)(8676002)(508600001)(186003)(66476007)(53546011)(86362001)(31696002)(54906003)(6506007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akRzdXBQQ1FENmpnQUpIajdBWVhpd2hpUC9NS2dTVzZEb2F5cjA5ZkljZFdv?=
 =?utf-8?B?TncxQzN0R1hZck5vLzhKcXErSjdRNXVuU1Z2Z0FFNVFTcm5QaC9maENWN3py?=
 =?utf-8?B?NkxPTzNGQlhZeWIrNGNHK2FUN0xudVlocGV3SXppKzFnSjk0K2JNSHlDYTF3?=
 =?utf-8?B?OWZzaVY5cHVnbHlwYWllamk5VVNwUXJhV0dONUNjYU1ZcTc5RndBempjTkxP?=
 =?utf-8?B?KzAvR0o0ZC9nczM3T3ZmZHhhVStiYmJEbEJlNXcwb1BMc2dKNmlQNkRxY0Ey?=
 =?utf-8?B?SjJiUzVZQ2FFRTJCa2l3enNSaTdrbEdZc0lEOEs3S1hQb0VsdXI5dkNlRXBL?=
 =?utf-8?B?V2R3eGUwUlhkelN0MWVIaTFzOWNwbUtYUU5JT3dKT2lxRzJYRFhtK2J6NUFJ?=
 =?utf-8?B?N083dVpTMXlPano3UE8xODdsWTNTb1hTRUNONUE3ZGVuaTEzcUR1cnpDaEs4?=
 =?utf-8?B?UmxSYzNhWllhSjBiQ0NIYXFoUVVKUWlKYkp6ME5JU2dLT3RGdDFlNDVCKzRv?=
 =?utf-8?B?c1RxNDQrU0lQNUh1bVVyUjBJNzd4aE5RU2RVVXBZVSswWnp3QzRadGFCUFov?=
 =?utf-8?B?dUc1VCtzc1Q2Y0FCeWdqSWtpbVV2S0ttd2dYMWwxTjNEeVdldm1SUXNTcGZw?=
 =?utf-8?B?U0YyaFN2a28rVitLcmNVbXZKKzVDSHR1M1FXM3VpdU5UT3FEb2YyaWhvU3VZ?=
 =?utf-8?B?dFF5aGZmdnQza1BoWVhkTnJ4cUJmUy9tOEl5b3N5RHZ5YXl0TDVaaXBmM0R6?=
 =?utf-8?B?SWJrT1ZOUmVYUC95UnJsU25UMEdybFluWE5xV3c1OExZc3FKSGYzdlhZOHZj?=
 =?utf-8?B?dWZLbUVmVHVFY2lsc0VrRitvU3hCZGVVQXZRWGEwdFFPRHFsYURNTjdObWcr?=
 =?utf-8?B?ZWNDTy9pWUFvbmVVdE1GZ3NiR01FSllDZHlIUWRSL2luZEp6cjZMWjMycjdv?=
 =?utf-8?B?RlMrbktVYktlOTg2TTVVa0QvOFc5RXEwVU84Q0JjQlE0WW5ObStybGU5ekFu?=
 =?utf-8?B?NVU2S21PYXhrV2ZLclFaSWViOEZZb1BmSm5hMTVnU2Y0dlpndXV1WGpzQ0pV?=
 =?utf-8?B?OGhwVndta0V5TGFJZVZGZGdqTllLMllWOTJYYlYvcWE1NkRWR2o1R25qZTlO?=
 =?utf-8?B?NUtSTmRXMlVOVjBFUk81cFpQRE1aTXVlUGFrOTE2aW1hMnM3UGxHRFVxSHI0?=
 =?utf-8?B?M053OVRrMzNnT3doZGlYOEd2bVR2SzY2YkxFNXVSNmF6RXNvaENwaGk0TTMx?=
 =?utf-8?B?WFhDbDMwb2JuT3lnQ3ZKS1RlVGNoN3BFV0t1TWpQVllrRTZKS0NTK1VSQWNa?=
 =?utf-8?B?cDlTS0l0dTBnNjRKeEthN1I1TjV4T3RKb1VScXArNER6RnBBRnN0YUdYVDAx?=
 =?utf-8?B?c3ZaVEZqWlFHNDYvRHBXVjJwZU1Cc2lMdThuSTVSbHRFcnhjOThLbW8zeUZJ?=
 =?utf-8?B?NGs2Q1l2anJzNldHZWp5NFFwQ21maE1xMnF1TWJZeE1NbFFVUUc3Rjk3UjNp?=
 =?utf-8?B?TC9KUUVaN1g1QWR4SjJMMmFoS1FPT2RwdlkzZ3N6WklEZG0wa3lkWXFUY1Jv?=
 =?utf-8?B?cmMzeXVOaG1oenlLd1dtVjQ0RU5vSjcrWnZHaXBJd0YwazdpTkc3VHZHM05p?=
 =?utf-8?B?QUwyVk5lKzFDbktra3dKOVZhd1ZiWWlDc2gvN3hUVXQ5eURUMWticHZYRmdo?=
 =?utf-8?B?RVRtWHhYMzJHZnkzZ1NYTi9qVUdqYUdEU1RTSys2RUZYNzU3U295MXRTaStT?=
 =?utf-8?B?MHRMbHFQL0szWlJFdEo0dGZ0dDQ2dDhoZi9iLyt0dnk5S0UrdG80RlVzZWlU?=
 =?utf-8?B?NS9IMTA1OGhvVE9iSVlRM0hQU1FZWGVHSElTVHlGTyt5bWpRYU5FNzdFSS9n?=
 =?utf-8?B?VVdvMGlHSmpqSkZrbVhWc0tUSG9pK0s3M0lxZkFpM0t4NlVjYXEzaGswWG5s?=
 =?utf-8?B?eEZtLy96VFkySVhyUVd6eWFLN0k0b3FBNDVrclpQV1Zsd2tTMm0zdTBQMTF4?=
 =?utf-8?B?VlBaR2xwYWh1ZmZZWWMwaGwrOU5JMVovOGIxK21MeWdVcmZUUUZPWGJoOEgx?=
 =?utf-8?B?OU1zcmNLQnBuVG1EQmMrZ3E2YWUyMGRacEt6bEU5cVJxMkZEMkhTOGExY1JG?=
 =?utf-8?B?cmw5MUFEczJoL0RYOENwSDhxS3lDYUFIUGZNL0J1dUw1ZnVjRUk1VVpVSk1r?=
 =?utf-8?B?b3l4NWJHM3lyanJ2THN2K1RsR0tOY3plRE0wekFJc3VteVd6aVZ4aFZWbFZo?=
 =?utf-8?B?M1d6WE52UTBlenNHZnE5T3cvSzM4K1lhOHl4RGF3K1BYczRwYURkTlVCYzBW?=
 =?utf-8?B?L3UrbStCd3p1SitjbnJ4NE9seHNYU3pJUnEvM0dWOCs2RXNPRUJSdnlMUWdk?=
 =?utf-8?Q?UdoFfiiv4efySRCw=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d382b78-b9b7-4282-bfaf-08d9f88c4563
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2430.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:25:59.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJyweyvIrkhNpBOwtmcssyS/KHYATvXfeUi+xjelfCMbz5dV0Emlx8+kY+5U/6QRQrjVFcRDBFjcOjgq2FUwAPkK6MP4O6X+A8GT+nEOb0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2/25/22 18:59, Peter Geis wrote:
> On Fri, Feb 25, 2022 at 12:01 PM Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
>>
>> Hi Peter,
>>
>> (It should be noted that there was a slight mishap in communications
>> between the two of us resulting in two series with the same goal. Now
>> let's clean up the mess :-)
>>
>> Thanks for your series. Seeing that it contains more patches than mine
>> it probably makes sense to use your series as basis. Please Cc: me in
>> future iterations of this patch series and consider my comments below.
> 
> Will do.
> If you'd like I can also pull your enablement patch.

That'd be great, thanks! I'll help testing of course :-)

>> On 2/25/22 15:54, Peter Geis wrote:
> [...]
>>> +             dr_mode = "host";
>>
>> Based on the description in the commit message above it should be "otg",
>> right? Boards are free to overrule this, of course.
> 
> Currently the usb2phy does not support OTG mode correctly.
> There are patches in the works for this, but at the moment it's safer
> to default to host.

Ah OK, makes sense!

Best regards,
Michael

> 
>>
>>> +             phy_type = "utmi_wide";
>>> +             power-domains = <&power RK3568_PD_PIPE>;
>>> +             resets = <&cru SRST_USB3OTG0>;
>>> +             reset-names = "usb3-otg";
>>> +             snps,dis_enblslpm_quirk;
>>> +             snps,dis-u2-freeclk-exists-quirk;
>>> +             snps,dis-del-phy-power-chg-quirk;
>>> +             snps,dis-tx-ipgap-linecheck-quirk;
>>> +             snps,xhci-trb-ent-quirk;
>>
>> In my first version I had all those quirks as well, but are they
>> actually necessary? I decided to remove them all to have a fresh start
>> (also activating them did not seem to affect my test setup).
> 
> I'm now curious about this, can someone weigh in on valid ways of
> testing each one of these in a way that is definite?
> 
>>
>>> +             status = "disabled";
>>> +     };
>>> +
>>> +     usbhost30: usbhost@fd000000 {
>>
>> Please reconsider the this name as well.
>>
>>> +             compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
>>> +             reg = <0x0 0xfd000000 0x0 0x400000>;
>>> +             interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>>> +             clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
>>> +                      <&cru ACLK_USB3OTG1>, <&cru PCLK_PIPE>;
>>> +             clock-names = "ref_clk", "suspend_clk",
>>> +                           "bus_clk", "grf_clk";
>>> +             dr_mode = "host";
>>
>> Here "host" clearly makes sense, as this controller is not capable of otg.
>>
>>> +             phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
>>> +             phy-names = "usb2-phy", "usb3-phy";
>>> +             phy_type = "utmi_wide";
>>> +             power-domains = <&power RK3568_PD_PIPE>;
>>> +             resets = <&cru SRST_USB3OTG1>;
>>> +             reset-names = "usb3-host";
>>> +             snps,dis_enblslpm_quirk;
>>> +             snps,dis-u2-freeclk-exists-quirk;
>>> +             snps,dis_u2_susphy_quirk;
>>> +             snps,dis-del-phy-power-chg-quirk;
>>> +             snps,dis-tx-ipgap-linecheck-quirk;
>>
>> What was said about quirks above holds here as well (although one quirk
>> not documented in the bindings is missing here).
> 
> Same thing here, I'd like absolute testing to determine that these are
> not necessary, since downstream (the oem) felt they were.
> 
>>
>> Best regards,
>> Michael
>>
>>> +             status = "disabled";
>>> +     };
>>> +
>>>       gic: interrupt-controller@fd400000 {
>>>               compatible = "arm,gic-v3";
>>>               reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
>>> @@ -297,7 +341,6 @@ pmu_io_domains: io-domains {
>>>       };
>>>
>>>       pipegrf: syscon@fdc50000 {
>>> -             compatible = "rockchip,rk3568-pipe-grf", "syscon";
>>>               reg = <0x0 0xfdc50000 0x0 0x1000>;
>>>       };
>>>
