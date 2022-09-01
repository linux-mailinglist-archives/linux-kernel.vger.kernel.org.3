Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B75A931A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiIAJ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiIAJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:28:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FAA12CB18;
        Thu,  1 Sep 2022 02:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or7hXatlR15jFcXzEUTMyydZWIML+XmMDI9rHquE9KuqXnmBaA+5Ccp6zJMz4gWE3p/xSk1q39W3c0iY09KFFgwm0tDuwudgjohg0mnRmTu9EusbbPo6YoTnFFBwP8lHhHBkjCzcdKKq48b0ADMSNNSwgdzph9GuOJQFPgcw2baaupp4O54DjAqVjh+3FNVjYZmRwCs0OqgEC/Wp6Qw8XVB/SafCsrEh6X0fspyihcVfSavvwx4nBAnycmJMinyoWK8l0oyRLxuVjWfHiRBNldMzzqCNJOFRmjbqYq1FIrqSnBLOw2Ccdj0L/rnxfzQiHr3chNgtyTXN7sjM0V+EEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdNRaj/Qh07cYe4bRa4FDywoJL+OOBQ/bQAMl4BV4GM=;
 b=DuMiKps7tZ/QPuOoSx8U3lZHxr4PsjmjEztoBdGEJX5hpHTe9UdGwa/XYVTQThYJ3VbC7Mqzm778M3s1iJtulJmN1aRgsmgqxsPTbkptjMjzrplOJXwaBklcxjiwbs9DZJ4fpF21BsPlJY0xyYMYl/UjuLCS9zfjfAKFXLYxxNbfQ2QTA/cMABH9WrCy30JbUu9PztbBmnoUMIYZ3NU5wspnyCC06JMMGdC/0laqCdgGJ89rdKSelJi/z+2DOR21WWiHQcNmrHxe/Vgh0zv+mO34H/fOqCxUBQKacXJdZIcpXxYCywTSsdguMyfY2wXfAai2/9o6ry9XYOnfyX/pNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdNRaj/Qh07cYe4bRa4FDywoJL+OOBQ/bQAMl4BV4GM=;
 b=NnErVZIwj9J3T43hXILCt2BtsiAPyTFVQXNOlibKdc0ifh/ELr7pDcR5mQ8H9bs6kcKk2uLPi74H7SWjqxkbBsau/csxKJCrBBi5KRXmVtuVSkhHvsafkpgjl4fh1sc4GfeUOtvvwdoGD6HpnsVKjiKfM4x52EVk5d0YvVd+mrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6613.eurprd04.prod.outlook.com (2603:10a6:20b:f4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 09:28:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 09:28:23 +0000
Message-ID: <2a36d661-18cb-6980-4748-2f17a43c81a9@oss.nxp.com>
Date:   Thu, 1 Sep 2022 17:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Content-Language: en-US
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
 <3ca7cd75-4b62-2380-adb0-646bbeb647a2@pengutronix.de>
 <Yv4A9Rgna2bzAuvj@EPUAKYIW015D>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <Yv4A9Rgna2bzAuvj@EPUAKYIW015D>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b7a0bd8-aa00-4c06-e8d2-08da8bfc50b8
X-MS-TrafficTypeDiagnostic: AM6PR04MB6613:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PCXuHWoDWhbOTTJYK7/LyTayvo7p7KdnC0WbUQ9AzdhQ7u2GF33jVEqMyVTQz5apB4yzTxrdukcYqE/cU9IVJDeHOwSUDueiRCrNLHSceeG0TaWcX7k+UroKrteZircP0DhKt7nseeGAzmSqR28gWMFZ3FNdztU49DmtF4xKslGvx/JHxDR5TVRRLcL/j+ipeD6IfuKhOcF7Nx2veWx/wjRu3zRYfxB7cIjfqskTpGaXPUhELeyBh654HhRGxOy9MY9f5pLCHEyMmP1GaKvSX1Yr7vkNOjR41861H6p+27HW+0TJnXSP8ovf29WpVLmLoyEov6kLat6Dj2nnUr4z8fVdQ406bAhoBdH6HJyw2ljvAIu4Bg++9rkxBgQYrlNUK9uB464e6/KUlB7N+bjKDxfh5xtikxezZjkAAgpmGRjsj1qvnCFhWGc43MbB2PohNe9sPA2VnkqNjbB8EH++KJsoZIQgUJdTvcaOH/Onenxdy8gm9cICjRl7qDNQC+VPda0ikOoVLNG6WR/QC8+spzFh9Ymsf6prcKFqSncDpG+umcwa+slGfbpFZO9pYUNaV1nX+5H+zrdmQJthx7vukjFtayBavPY/Ljb6y++H2x2brKHIEgdb3IX0ii1Zno258ipYK14yyPDdaD/9x1b/Ftj82xU3ZwuuIHSRNzyfTPgs+niHQamD4yX9Fgk8GP6e8cwcvoOssaVVY/uihbUGKhDBCIGEVPENfN76rOZmrM8h1vR2WZHZtXwXKtyxy+Or/Ys9j8RXJbAsO33hIpyYIAzyu02saoU9lDwAVtd8H9QeWTn4iHFP3x2/hFIhLEZlNFyX7Z0iJZxqiucJABtZIIR0ciCc9oX95qPG+csaLrECxWGi8j4wR3AdL+L3BRBmohJUjkPV4fcF59piYPWVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(86362001)(52116002)(31696002)(53546011)(5660300002)(31686004)(7416002)(44832011)(6666004)(186003)(6506007)(8936002)(41300700001)(110136005)(316002)(54906003)(38350700002)(8676002)(6512007)(2616005)(38100700002)(83380400001)(2906002)(66946007)(66556008)(4326008)(6486002)(478600001)(966005)(66476007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG5ZWjdRK0FlWWhUc3h3KzVHQzNoenBpeXM3Ykx6RVhSTXVsVUhVUTdlQzNB?=
 =?utf-8?B?bWErNkdYcEtYNTNjUTRGcUlDei9oaDNQdG5kVW11bXM5NkJLeUcyMVA3K1du?=
 =?utf-8?B?M2lZTUNuZG9DQSt2SjAzbzVoaU9GUERmQVgzcnRYMHczNTVNUjQxa3hNdzU3?=
 =?utf-8?B?RFpHd2xzNjlRS3E0ZTl4M2R6THRpTE40VWhRWDZ6T1V6bWJzL0R6MW5uVVc2?=
 =?utf-8?B?aFFKWFpmZUdWVVkybFlzd05UMFIwK3JEQnpsa2ZXUTBZR1FSNnlpaDFoRGVC?=
 =?utf-8?B?cVRpVzB2T0J0R2RjNlZaMEpDTXk1dkFxQ1F0QXcvLzJnSFdOaTZWeGZxcW9G?=
 =?utf-8?B?WnhmbnU5OHlnZFgyVXdoSG9NVHo0dXoydW5yQmg5Y0VGVmpIK2JhdEhEWjVr?=
 =?utf-8?B?N2lNU3dodkU2TWJOeUVkTFVpbzRMNk5lWnZnLzNCRW1kRVpaM0pKSjROamla?=
 =?utf-8?B?ZFBmYTNERXdIY3NPQmN5UGgvK2FKa0Z5eDkwZHRFRGtsWHVlQmZXSXo4QW92?=
 =?utf-8?B?VkJnQklSMTl2UENTazFtQXVFNEE2KzZta3hKdUdvbzNLUGtHTS93ZmkrME4r?=
 =?utf-8?B?ZmZuS0dpY01FNllBRkhLS21VSm9rVG9LcVhrNXZjRWQvVi96VGc2Y3U2UlBj?=
 =?utf-8?B?SWFEUmJSemRQbHRoME9UNzRWM1pGZHkvcGI2aXNXemZoRHVJQzdlcmx2VCtq?=
 =?utf-8?B?S0t6bWlEWFZDd3BSdkNSZmxjMHBOUGZLMXBzYWtyNkNBYms2blRwSFAwdDhn?=
 =?utf-8?B?Tnc0M1d6bkI5dS9lcmJzMDh1Q2VNVVJjbVlkd1lrMDZtbHgzMWRRdzJOZS82?=
 =?utf-8?B?NUpDRlpPOGZUd25YQ3NZSXJDQXkxMG9uUXZHMUZRK1B6WEVCMWpZamNVQ3V1?=
 =?utf-8?B?b0lhaWRyNUwyS0lFWVg1ZFFyRkw0aFo0cXY5ZWhsRUFhTnlGemdUbzRGajAy?=
 =?utf-8?B?TFNkeW1zMit4SVlrWWdPTXArRjYxZFFnbk5JbTZSU09lSEZSWXNVS0x4aGpZ?=
 =?utf-8?B?Q3dyeTg2U09rUTVFWFlwUmRNTFBvSmNOQ1hJenAxZFM1T1BhQnFOcjdUQWJ6?=
 =?utf-8?B?WWxNK0NzenZvbjFQbUpNQ2c1QjhhTnhhQUU5a1EwTnpORWdydlBCRFFDNTQ2?=
 =?utf-8?B?d28yTkVrN1A5VkZ1OHZXdjU2bEVROGVvcGlRN3JiOXU5WmhycHRkMHRaMExD?=
 =?utf-8?B?Nzh0TEVQNjdyZS9LRXJQU3lITmJUUnpUa2cxR1EzU3B3Y1hpZFV3N3BRazBN?=
 =?utf-8?B?Mk5oQlJlQTlROFVxSU1EbC9TTklWemFQVENjK29kd2FMTUNCQzFnMTRJM3B0?=
 =?utf-8?B?RXpFTzYzSEF1RmdQaXNlWGRaUnppTC9RQnp4RWY0WXloM2I5WjA0UnN6dWg0?=
 =?utf-8?B?c05wdko4SUFTWjFVNmk4VWQwVWx5anZ5WUZHYVh2dkNIUU9TcDZ0N2p0WVJH?=
 =?utf-8?B?MHBIZXpKRlRoTVBLMlE2cW00dzI3aEVhZDJMYXVtYVRWQm9FNE1PWiszMks1?=
 =?utf-8?B?QWJoWWtXOVAxajJXK1hPRHlPUDBqcnc1S0I2b2pUTEtSZ1VCQ0E4UG1aZ29O?=
 =?utf-8?B?Ui9acnVRU1J1RG9HK29mVnZuMllYZjRtdFFWb0lmVHpLbkJYTkRhWklmQTRi?=
 =?utf-8?B?bTJWVGd0ckJ0UjBoQzNZQnQ0ZXA0S2M2UjExNHR6OUVnS2hPdXJybnBobzNQ?=
 =?utf-8?B?TkZJejZ4L2c1TWpkWjFkMk4wU3lZL2ZOcm5TbjhURW0vYWk5RHFWbDBwb2RF?=
 =?utf-8?B?Q1FMd01mTWNNRGtOeTVJb3AyY3F2QkZoWitOWStKV1oyU0VzSzRzMkhCSDZ5?=
 =?utf-8?B?cmR6NiswbDBjY0ExTmM4NEJyMitXWTJTQ0N0ekRTellwS0wzeUdHMHJqRUtJ?=
 =?utf-8?B?b2FPdndlUzFKb2FzQ3BOZGFNemNjTG12Q0NnUGlKZkxQQ0FXdmY3cjhYRW5k?=
 =?utf-8?B?Q2I0d0hKUlNJbjdQSVlQMXFTUVJZRTZsYjAyd09TRHhoMTZhNUh5S2x3a2VQ?=
 =?utf-8?B?clh6dGJNdElYZEFPdlJFWHBPS2pzbnNTVFV4ZzZROW50d1M3amo1THcraEx1?=
 =?utf-8?B?dnhYcU81MFN2NmZFSWhrbmtCTTNkbXF4bnh5SmhKak15NzJzTHU2TGNaRlBp?=
 =?utf-8?Q?biYCD4ANu7kfXKbxMEBlXA2kE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7a0bd8-aa00-4c06-e8d2-08da8bfc50b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 09:28:23.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSDn/8+DkHv5M6U+XaZP+ZgZc8dssDado3/cp0g5W7J+OwQiXBrX4etupa8jqZ2k2etSQxfsd9AtzcVXlbQ8ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6613
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 5:05 PM, Oleksii Moisieiev wrote:
> On Mon, Aug 15, 2022 at 06:37:23PM +0200, Ahmad Fatoum wrote:
>> Hello Oleksii,
>>
>> On 07.07.22 12:25, Oleksii Moisieiev wrote:
>>> Introducing the domain controller provider/consumenr bindngs which allow to
>>> divided system on chip into multiple domains that can be used to select
>>> by who hardware blocks could be accessed.
>>> A domain could be a cluster of CPUs, a group of hardware blocks or the
>>> set of devices, passed-through to the Guest in the virtualized systems.
>>>
>>> Device controllers are typically used to set the permissions of the hardware
>>> block. The contents of the domain configuration properties are defined by the
>>> binding for the individual domain controller device.
>>>
>>> The device controller conception in the virtualized systems is to set
>>> the device configuration for SCMI (System Control and Management
>>> Interface) which controls clocks/power-domains/resets etc from the
>>> Firmware. This configuratio sets the device_id to set the device permissions
>>> for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
>>> There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
>>> determine device_id is not covered by the specification.
>>> Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
>>> Given parameter should set the device_id, needed to set device
>>> permissions in the Firmware.
>>> This property is used by trusted Agent (which is hypervisor in our case)
>>> to set permissions for the devices, passed-through to the non-trusted
>>> Agents. Trusted Agent will use device-perms to set the Device
>>> permissions for the Firmware (See Section 4.2.2.10 [0] for details).
>>> Agents concept is described in Section 4.2.1 [0].
>>>
>>> Domains in Device-tree node example:
>>> usb@e6590000
>>> {
>>>      domain-0 = <&scmi 19>; //Set domain id 19 to usb node
>>>      clocks = <&scmi_clock 3>, <&scmi_clock 2>;
>>>      resets = <&scmi_reset 10>, <&scmi_reset 9>;
>>>      power-domains = <&scmi_power 0>;
>>> };
>>>
>>> &scmi {
>>>      #domain-cells = <1>;
>>> }
>>>
>>> All mentioned bindings are going to be processed by XEN SCMI mediator
>>> feature, which is responsible to redirect SCMI calls from guests to the
>>> firmware, and not going be passed to the guests.
>>>
>>> Domain-controller provider/consumenr concept was taken from the bus
>>> controller framework patch series, provided in the following thread:
>>> [1].
>>
>> I also was inspired by Benjamin's series to draft up a binding, but for a slightly
>> different problem: Some SoCs like the i.MX8MP have a great deal of variation
>> in which IPs are actually available. After factory testing, fuses are burnt
>> to describe which IPs are available and as the upstream DT only describes
>> the full featured SoCs, either board DT or bootloader is expected to turn
>> off the device that are unavailable.
>>
>> What I came up with as a binding for the bootloader to guide its fixup
>> looks very similar to what you have:
>>
>> feat: &ocotp { /* This is the efuse (On-Chip OTP) device */
>>      feature-controller;
>>      feature-cells = <1>;
>> };
>>
>> &vpu_g1 {
>>      features-gates = <&feat IMX8MP_VPU>;
>> };
>>
>> The OCOTP driver would see that it has a feature-controller property and register
>> a callback with a feature controller framework that checks whether a device
>> is available. barebox, that I implemented this binding for, would walk
>> the kernel device tree on boot looking for the feature-gates property and then
>> disable/delete nodes as indicated without having to write any SoC specific code
>> and especially without hardcoding node names and hierarchies, which is quite brittle.
>>
>> There was a previous attempt at defining a binding for this, but Rob's NAK
>> mentioned that a solution should cover both cases:
>>
>>   https://urldefense.com/v3/__https://lore.kernel.org/all/20220324042024.26813-1-peng.fan@oss.nxp.com/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxHzHFDBt_$  [lore[.]kernel[.]org]
>>
>> Having implemented nearly the same binding as what you describe, I obviously like your
>> patch. Only thing I think that should be changed is the naming. A domain doesn't
>> really describe this gated-by-fuses scenario I have. Calling it feature-gates
>> instead OTOH makes sense for both your and my use case. Same goes for the documentation
>> that could be worded more generically. I am open to other suggestions of course. :-)
>>
>> Also a general gpio-controller like property would be nice. It would allow drivers
>> to easily check whether they are supposed to register a domain/feature controller.
>> For devices like yours where a dedicated device node represents the domain controller,
>> it's redundant, but for a fuse bank, it's useful. #feature-cells could be used for
>> that, but I think a dedicated property may be better.
>>
>> Let me know what you think and thanks for working on this!
>>
>> Cheers,
>> Ahmad
>>
> 
> Hello Ahmad,
> 
> I'm very happy that you are interested in my proposal. It will be great
> if we produce common binding to suite both our requirements.
> I agree that binding should be renamed, but I don't think feature-gates
> name would fit my case.
> IIUC both our cases requires different devices across the system to
> provide some information to the controller device. This information
> could be used to identify the devices later or to make some
> controller-specific configuration. In this case I would prefer name
> "device-feature" or "bus-domain", suggested by Linus Walleij.
> Also I like your idea to add dedicated property. This will make bindings
> more clear.
> Summarizing all above, I would suggest the following names:
> 
>   feat: &ocotp { /* This is the efuse (On-Chip OTP) device */
>       device-feature-controller;
>       device-feature-cells = <1>;
>   };
> 
>   &vpu_g1 {
>       device-features = <&feat IMX8MP_VPU>;
>   };
> 
> What do you think about this?



For i.MX8MP, Uwe suggested:
	/ {
		fuse-info {
			compatible = "otp-fuse-info";

			flexcan {
				devices = <&flexcan1>, <&flexcan2>;
				nvmem-cells = <&flexcan_disabled>;
				nvmem-cell-names = "disabled";
			};

			m7 {
				....
			};
		};
	};
https://lore.kernel.org/all/20220324111104.cd7clpkzzedtcrja@pengutronix.de/

Regards,
Peng.

> 
> Best regards,
> Oleksii.
> 
>>
>>>
>>> I think we can cooperate with the bus controller framework developers
>>> and produce the common binding, which will fit the requirements of both
>>> features
>>>
>>> Also, I think that binding can also be used for STM32 ETZPC bus
>>> controller feature, proposed in the following thread: [2].
>>>
>>> Looking forward for your thoughts and ideas.
>>>
>>> [0] https://urldefense.com/v3/__https://developer.arm.com/documentation/den0056/latest__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxH59KKjhc$  [developer[.]arm[.]com]
>>> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/20190318100605.29120-1-benjamin.gaignard@st.com/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxHy1kyyWZ$  [lore[.]kernel[.]org]
>>> [2] https://urldefense.com/v3/__https://lore.kernel.org/all/20200701132523.32533-1-benjamin.gaignard@st.com/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxHzVdVT4B$  [lore[.]kernel[.]org]
>>>
>>> ---
>>> Changes v1 -> V2:
>>>     - update parameter name, made it xen-specific
>>>     - add xen vendor bindings
>>>
>>> Changes V2 -> V3:
>>>     - update parameter name, make it generic
>>>     - update parameter format, add link to controller
>>>     - do not include xen vendor bindings as already upstreamed
>>>
>>> Changes V3 -> V4:
>>>     - introduce domain controller provider/consumer device tree bindings
>>>     - making scmi node to act as domain controller provider when the
>>>       device permissions should be configured
>>> ---
>>>
>>> Oleksii Moisieiev (2):
>>>    dt-bindings: Document common device controller bindings
>>>    dt-bindings: Update scmi node description
>>>
>>>   .../bindings/domains/domain-controller.yaml   | 80 +++++++++++++++++++
>>>   .../bindings/firmware/arm,scmi.yaml           | 25 ++++++
>>>   2 files changed, 105 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/domains/domain-controller.yaml
>>>
>>
>>
>> -- 
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | https://urldefense.com/v3/__http://www.pengutronix.de/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxH_HqFmwM$  [pengutronix[.]de]  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
