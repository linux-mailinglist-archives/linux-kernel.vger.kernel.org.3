Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0CC5977CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbiHQUUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbiHQUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:20:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB9A9F1A0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMF064gBMKrW3vYl0OLM8grAXqVC4+Rn+iBjc8gTE++UXwAELididtQffVDiJUhIMLVrlfTrGb+lNlV8RFOG7XxVCMeRXMlMEhS2I4XH7cU3/MCk3SUSCkjPgUfW/1pAOy5CVri7cPyHgl05b0y7JsQTcJhxk37xthtpRd4n6842CUW6IfcFjApgbRWg9dUMN7xI3/sSu6A1VdSFCGLrjHbO06QXbdCnDMgA+6xuuDyetpUCoMGI5p958A4gBVK+t/nndvAj2rtjDbDL5uPHlFVhA5/95H/MZKJjDAtGAkcLCKFPo2o+oR20VR6YRFKfPkFizfFu3nIrsv8UmR3wcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuqqDWez4jtw4njFeTi91fS504hTCepG9mQMuZgr9Vw=;
 b=SBpp/xLOvk6ehY58mmmqBkp29MgLxio/GOAfZ68Kj0DO8wvNIHbd52+FP5O3ElbIPkwtS4GLFvGQI9nOYXlcZpk82Vw/VLGAvPMqd/cJ4xZt++4FZINwtdDnSkFr7ziXhzHHzNu2zbGJw2vMT2A3DuTW7yPQjnZ2z+VAyuYru0srQDMH9wZYW2qbVlGsSnI6BsPExP+5IvWHrfy0F3jtW0zrvTvzX9w9uWTw1Sdluh8964uphZ5lgs8mEssdbC3NJn+I4hmIgDPKymreHuJhz1pKcQ2PVluN+z9cc3nLZ2FjEjlMNo9WpgJ/0Ca/BGi7WWqx/4hY1Yug0iKfyvSFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuqqDWez4jtw4njFeTi91fS504hTCepG9mQMuZgr9Vw=;
 b=cA41sGuaAbU0CCRZ05ob/JaM+lDcDTdw25WEfMITToS1jGAEVxwQ456CUAvgw/uZoYjiKGCvB9PvmAEtLfJ+Y9KdHMA/y01P/cVbRbsw8Z5RCh/jsjEHxUShTtGgHrIuNhUcpp7I1QDfJ+pmTHJZqU73HR71kcVdtM2cKvOBHbeLfx1rtl/GNIJxGhq5tjKS9ahQQKT+uRNZdubVQgQPf866g7AfrnIOtfFfU4d6wz3/Wo0JsXaOOfiMa8Kiav+GZmeEDC95RHQ3E/LueajVBRINAV2LofmGgbn/cYO+r6xmUuSXHZYreuUOwePJ3xiu+pyb/BEimyb7+ugUC2t8fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by VI1PR03MB4159.eurprd03.prod.outlook.com (2603:10a6:803:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Wed, 17 Aug
 2022 20:20:26 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2%4]) with mapi id 15.20.5504.019; Wed, 17 Aug 2022
 20:20:26 +0000
Subject: Re: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm nodes
To:     Michael Walle <michael@walle.cc>, biwen.li@nxp.com
Cc:     leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, olteanv@gmail.com,
        shawnguo@kernel.org
References: <DU2PR04MB89497E16D2E9A01BF763D92B8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
 <20220728093318.299798-1-michael@walle.cc>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <a575ac76-89f1-cf62-37a4-9f8190682910@seco.com>
Date:   Wed, 17 Aug 2022 16:20:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220728093318.299798-1-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:610:b0::31) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af73958e-0a31-4505-2b0e-08da808dec07
X-MS-TrafficTypeDiagnostic: VI1PR03MB4159:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FK4NHAcrez7tUypECicsVZZHJtZKt+hSqzZccfKnQ29c4vEHeAW5s2wVd/PHIR8i5H44CvEovfjNmRJyvKGHE4CgJ6jx02gwbhfWok5CH6JTHk1nF8CqfhGLEMEmVEXkfJoAfMySS1bNF8v9Ku6a0Hgc96DT7ciWNBRFrK/OizFCgKi9cDktMnmasGokXfGhPs7NGukbWGEOLCLWAd6q8O1eAuehr0mm4GRWHEfdVAJ2ojaLDQJ8FcQF2uJg19UzPOB0mpgHy9i10NwENyNql1gEl5w8JcHRM6LNZN6XBWk0/4BKpcS6Xq+jzEurf2Ax5GPJKMOPStfLvAUIHRRknIyME9Zr19PQil3fqF5YuWyv4v2XRe1SkNIJCGs5FBq0KtA1Pcu/Wuzyd9vAd33vTjx6sZQHI53EvN3aGnLofyhQTBmIkT4FquT3cjhRr6BjjyhiRc1gi5xhZAFL56dkNJVHO1JB+/VSN8SJGWGPSanbOEMduObrSwyTBjSKnLScnBd3ppPMLayFQjuNsJ3ZUVPEkZnrVfcElZXIEFClTLEvzqpYQ7MXhesL3FlqRx8CdmNK0L4IQG0zdSymoCsGqFgqrmiHrS+KcbrHtr+iem32LvtjK5TnOgEq5GEGYJp1Fx+BqVfuNUxu4tlAo0QNo0gixEVZ+bwV5u8T+KW4t31LfAUklhrPK1gwCV6kRFKGTB1jUgvJ/pFPkHYfB7PhOUk0VFJ6dFsw4Ldvc4Om0BLlx4NYSTcNd9iyy2g8O15ETH7qSsV8hJXlnS4960ejpUT2yojcPK0ncU/0F6LCA7lLMUV/ZzKDYGtBV1B2KVlEF8AxCzspXsK6lRKZW/kgcqFe4pR9qIjZcZ/xFuplfZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(136003)(346002)(366004)(396003)(376002)(83380400001)(53546011)(52116002)(6506007)(6512007)(26005)(2616005)(186003)(38350700002)(38100700002)(8936002)(5660300002)(44832011)(4326008)(8676002)(66946007)(66556008)(66476007)(2906002)(478600001)(6486002)(966005)(6666004)(41300700001)(316002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTFXNlV4QVJ3SFpkU3Boc2dobkFQN1dGeDBqL0s0MFlDOHhZSUN6QkRHVzdU?=
 =?utf-8?B?L3FnT2tsU0RRdTFLZXZGMzdiVnloTTBnT081SFVzYUE1N3lKVENKRWdWTFNo?=
 =?utf-8?B?dmYwK21teGtLWXVOekNCNUx2Qmk0UjlHSGMzZ1ZmZDdyenlQLzdsejdsVlow?=
 =?utf-8?B?aVFoMWVpaHd3eGtRMW5LeXA1Zm42UHNmSVk1RmpoS29xTHZPVDNqKzZRcERl?=
 =?utf-8?B?QzVwYTI2M3MrSzFucHF6c24wUlBvQVlTT05pdC9rcWdITkMwamRHS3F1aSs2?=
 =?utf-8?B?NWViQ3dsb3lOWHFwSnhoY0VjbjZKd1gybG5sL0N4Uk1Ha1c5cFEvNDUzSndI?=
 =?utf-8?B?aUd0MWtmRTM1K2Mrd2lQT2xUakpqTkpZNFBTbEhIVFJSVjJwYWVnVnMyTlBl?=
 =?utf-8?B?ZDA2Q0xBa2VaajB5ZkJ5Si9LRWJKaVpTT0tYdW1NcVRTQ0kyckZBSXNIQjhX?=
 =?utf-8?B?aUtRWXVGN29mS2xNQjlQYytsSXV5Vkc4NUlkMVpsTHRPLzRxZzU3Q0FuVklk?=
 =?utf-8?B?Um8raHFLQnhtN3ppTm5ETUpNeEpuelEzdU02M0R3VVo0dmhhRDhKZ0RvVjRW?=
 =?utf-8?B?OTVXaS9QRVVvYTRpNEhrOHROWUhxT1MzS1EvelNOYXp6UlFNemRlaEhQWFZZ?=
 =?utf-8?B?M1dxenpZNTVZTFZWQmdlOGE4SXJpNzd3UE81N1Q1TDJkRW1vVlVLZExMcitX?=
 =?utf-8?B?SGg5YjdmQmEyNTJTK3V1NDhnbjloUEtzVitvZGp1NVRSczBuZXBFZ3ZUM2do?=
 =?utf-8?B?Z1VyQTRWMFlWM0lURHdqWDduOXJLckxFeWdXTzhUUTZXekRrdnp3MHlmd2lh?=
 =?utf-8?B?K2JjZ3pwWUxzTXJhNHkrOXp6U0lhbStiTGhwem1sS0NIY0RpbGI5WURySFQ2?=
 =?utf-8?B?SmxTTlp1NWdKdDhQL3hESXB1YkVRbTJ4bEtkQzlEZ3lwQm9BdklqMUJSV29Q?=
 =?utf-8?B?cjM2RXdnUHdxdmI3eE90bkpsb2ZRSXR4cTVHejVuWS9EVWRzbWVuZDVzVUdP?=
 =?utf-8?B?WHZ5L1E2c0JmSHFXMWx6eTV3SWJBcU5jYjdCazcrSzI1M3Y1WWpGRnJyOTh1?=
 =?utf-8?B?Nm1WMWZubGorenlHYVNZakdmamFpRTFJTzFYZ1lUYU9RamVyaHV2MC92Sm5O?=
 =?utf-8?B?UFZ2NE9qYVRzNVV1T3FGV0YyYjF6SzJvVzdOUVlnbmM4aEFuNDB5VkFRWU9T?=
 =?utf-8?B?TVFyZGhaSGk4UmNGTEJEVXJZTmdMQXRJNmRKWmxvcWVmS0Y0RDAxcHRpbC9o?=
 =?utf-8?B?MGl5RDRNM3hLdXVjdlU4WDFSNW0wQWpMUXZaeHNwYWlqUzhTNkMwMEZib3JD?=
 =?utf-8?B?VkZHRENCZ04ySVA0Z21PL2Y4NFBkZmsvdnpDU2EyOUlVSytscVh5Z0NmZjZG?=
 =?utf-8?B?dG5JaUk2clZqR2Zscm1EK2NvL1Q4bzZpVU45Ump2S0NzQkJIazFvOVRwUVpv?=
 =?utf-8?B?YW1IRTR4V3VYYVBhVi9tSEZ5YnFrdUxjNXJvOWNoUlRYc0YxTUdwdXlLOW5E?=
 =?utf-8?B?Rk5xRUZJalZmQTdqNHN2TkxpY1JsRzdxVjR5RlI0cW94RDRXQ3lTaFdCc2M0?=
 =?utf-8?B?STdtN1lnenNidFRhem45T2YxQmlYZWZqbW8zekxzU0FYSU95QW5HbEI4cnhI?=
 =?utf-8?B?RFdUZmRYaytZOXM3WDkxdTVHWm05Uy9xTHVreWxqRmYyckpRVS9jNWU1SjlJ?=
 =?utf-8?B?RnlnNndmWWFoYzZLenJQNTF1Ynl2Vk95NlRaZHozMkhZZDl2eENLaFNtTU84?=
 =?utf-8?B?UkJaZktnSkpaSmhaaGxjMXFlWFZxNnVmcERYY095T2FYRzB5V3JWcnBYaW0v?=
 =?utf-8?B?MFM4a1lQWXV4QjZiK09HSHJXUWJpUVlCZkNqWEJqa1dXTHQzV1huZmRDK3dy?=
 =?utf-8?B?OVpKQXNvM3I1by81VHZmMVYxRlNBaitJaE9NbzhsR3RaTDJkUVFwajM5UGsw?=
 =?utf-8?B?cnBsOWM1RmF0MTJlUmUydmcxS0dCM2J2MnZaN1A2SXQzMU8rNkhvZlRWM3VR?=
 =?utf-8?B?elpUZm40UEh4R3hhbFJkVU5uczRMUFVBYjViTFgzekI5MmVsa3k2dmo2WnZ3?=
 =?utf-8?B?akprbVZkaWJraFpTSkVsYi9JcVJSY0hOUTdJRGVKc2lpMlNsZ3kyL3pnVWIv?=
 =?utf-8?B?UlFNU0tLNFpEczNCNC94TjhFMVFoRS9JWUxwSXpZc1VZSzZvd2M0VUFhSTRs?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af73958e-0a31-4505-2b0e-08da808dec07
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 20:20:26.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iqm2RmMBlOn6yxJsHukU4a50t+sDWSj4TQCyoE1OeMPcEpsB0GgfQghYhSEBmOJeOwS1TFwUsup2rUY2oc0bgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 7/28/22 5:33 AM, Michael Walle wrote:
> Hi,
> 
> sorry for digging up this old thread. But I've noticed some
> inconsistencies here while syncing the device tree with u-boot.
> 
>>> On Wed, Apr 13, 2022 at 06:07:20PM +0000, Leo Li wrote:
>>> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1210.21-1219.5:
>>> > > Warning
>>> > > (unique_unit_address): /soc/pwm@2800000: duplicate unit-address
>>> > > (also used in node /soc/timer@2800000)
>>> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1221.21-1230.5:
>>> > > Warning
>>> > > (unique_unit_address): /soc/pwm@2810000: duplicate unit-address
>>> > > (also used in node /soc/timer@2810000)
>>> >
>>> > Well, this is similar situation as pcie.  The flextimer controller can
>>> > be used as timer, PWM or alarm.  We have separate drivers and bindings
>>> > for these modes which resulted in different nodes for the same
>>> > controller.
>>>
>>> I think the mfd framework can address the situation where multiple drivers,
>>> with multiple functionalities, want access to the same memory region?
>>
>> I know mfd is used for device providing multiple functions at the same
>> time. I'm not sure if it can help dealing with the one function at a time
>> scenario.
> 
> Funnily enough, I had the same concern:
> https://lore.kernel.org/lkml/92eaa24876a823aa5833435f51095812@walle.cc/

(a bit late, but I didn't see this the first time around)

One alternate approach is to do something like commit bc1ce713a084 ("pwm:
Add support for Xilinx AXI Timer"). Both arch/microblaze/kernel/timer.c
and drivers/pwm/pwm-xilinx.c are drivers for the same device (and have
e.g. the same compatible string). They determine whether to bind based
on whether #pwm-cells is present or not. This avoids having two nodes
with the same address, since one node can be used, with an overlay (or
an included) used to specify the function. It would be better to defer
this to when userspace can have a say, but timers are probed very early
on, so we can't do that.

For the pcie device, perhaps you could use #address-cells?

--Sean
