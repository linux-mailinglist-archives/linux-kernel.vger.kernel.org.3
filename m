Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D2550D91B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiDYGEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbiDYGDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:03:46 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10090.outbound.protection.outlook.com [40.107.1.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A73C396A6;
        Sun, 24 Apr 2022 23:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6GpxGnNr7kJfod2Yuize9Q6dNbw5rM9WeZlXrR0wg807iecVC2YiRkccjO8XS0dPYeHzgBLmBN4EydJ3J+pINYcEY+FF+tXllaFT5I1sA1cmDP5wmKBBcZmx13PZ4AoknEBGw0jIuMLCvks1WNUmd7GXVH9hsXvv6RpcHYjHmOj0B/f+T/oxS4ggq1zfjuF6WtX7qYf2O2bSGdouejDQDQaI3j46FCTkISlFxlMPw4L/J48y4q/BFU8PNmbej9QHcyLdatKx5wS/q3ODAVKrgPMtqHZA+rb1fS9aSFzZJzi7ShqadQispkGPAHfLc6SeQ+VdibzluzqjxgYa74L0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o6xn/yFQ8X809/qUvTIFT4tMNk/WdQUd21fafpdbeo=;
 b=cAwXQwRc7JbAHxzBODZpyQve78Eq0xhrNneqQi80iUk65XNRyAHx31ink8x63pEXCCiMLICtB9Cj6PjkMkxRGkFHbmiI+cnVoRPooKWX8yoYnosqbj+ZAbM6vI05t1p7tJDKfEClPF3o1HMDiLA43epCkQsakRhhj1uNu4iy11q971Yhp93zE0XcL1dwe1CBB3kynck/VlbPrCu4tMvcaSXNGDABdCMdIV5ID00FX6H8pMRO/IdD1Kkc4u3uPOGGg1R9r2EBmL8UTDABoe1IolecxW0M61HqgkUOvp/tFrP2bnobJrulUYuu0Dw+L5pDYxI8G5dW4Q1YSPUxRk1KUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o6xn/yFQ8X809/qUvTIFT4tMNk/WdQUd21fafpdbeo=;
 b=MpIeNO3bnnZCX3K5bQ4vcRXDSJFFWqfiwZ4tdYgizyMb12go6yEMAYJ7QB3X43CnUjYhfmSlA/uw/YVzZrZ8c8ZnDeSE8VziwV2cn/f4Tt0kYJC/4G5W8EM4+bP57MYBU8qkIOV2VOW9EO+ZAb2qhVJYs1XqWlBXvTQ9VFD6Y8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM4PR02MB3025.eurprd02.prod.outlook.com (2603:10a6:205:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 06:00:37 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 06:00:37 +0000
Message-ID: <b657ebf9-e2e3-6d3f-e7e9-c660e860e54c@axentia.se>
Date:   Mon, 25 Apr 2022 08:00:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/2] Add support for texas dac121c081 to the dac5571 driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0035.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::9)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 585f7221-9d32-4f33-33c1-08da2680eb67
X-MS-TrafficTypeDiagnostic: AM4PR02MB3025:EE_
X-Microsoft-Antispam-PRVS: <AM4PR02MB302593EDF57DB52413159C6FBCF89@AM4PR02MB3025.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0M20RHYDf5RVsdRM0eM4SIpOHGAzY9qFrES4FkVJUr2EZGGNcNiVOu9dZ1ryqCS5jpYYRrXVW2emFHp5CKp/7kwusVwAmo6ZAihXloIWWOt5qdiswMlsmWtJ7mzWvOUK/sh09AvoGauyaTa242mCFAYNF7khEDDw0KGS04w0c4a0rGDYQgERSoDW1B42NZTwu2SsRnI3EwvRsp+ZLCbaFb300yNa3EVduSP8cGtVNFmH5XO0nK3hCS+8GdjZUt+tLfKQeSjhEN6BEmqc1X/WrKPaExR4a65eQsYsGWmA0vOHGQJSxgtwcrVDaHDSMZIbsApY8Ng2Ed5oFI8hR6bHo5x92VJ9sdnIESFi6zHFuTDXhE71t7c1HLm4MSswF7OMKJHapBoB4Bc2PwDaWbVokh6shlSVCcpUg2b9PklJexDtUADm/4/sO150wlzvM8jjJu+CJjHHYGyW/4WvWLShFdrth/ikCwcjGV2d+GDMoHaMj6KGiKGJTWrbeykBJHK54FMIJ8xQT0mGQnFmXRApsc3NHJImWw328RNcOXRlkcsV2qE8cTIKmcawS/bwhtxnGGMc5vx1tSPpebpq56nL3stjL56VqYyFkO47RHEvWK11B8t6NndaiCYaa7ynCr8CzQXVXd922Y333KAGXTq8NuHugUYe5C28LUs7lZibhB0jNGpOXZERkoiIK7m9sUp7+bYbfn+JDOsnkn9c0KWJirVtamSo2+2f44CpV6Mu89X75KgXnPYrQXHOkrTKTv0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(376002)(396003)(136003)(346002)(508600001)(316002)(8936002)(36756003)(5660300002)(38100700002)(83380400001)(31686004)(54906003)(6916009)(2616005)(66476007)(66946007)(8676002)(66556008)(86362001)(31696002)(4744005)(186003)(4326008)(26005)(2906002)(6486002)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1dOczBkWlhoTmVzQXBhT25jeDI5ZEJSa0p1aml3M2dWazIzSDEwYndKUVN0?=
 =?utf-8?B?THFrSFVFaXhKbzNJZVBsVmtHTGZxRFNRa1c2UHczK1dGWHo5dU1FN3pRNks1?=
 =?utf-8?B?c0M3c1dZdDNDb2VGYU1LYlFNbkFVSEVyaCtaZE84THRxQnJCUHZRVTNQMk5U?=
 =?utf-8?B?SDdma1YxbG1LSWY4L0U0cGhZUUFwblFnS1AxZUl2SElkRkpBY2IwdUwrMnpz?=
 =?utf-8?B?ZWRCZTRNTndLOW9mUTlDVEI0YTd5MU9NeGFiTXNCUnZZWWxNZ204S28rS1p0?=
 =?utf-8?B?R0NvQmJJakhPaTY2ZitEemxTMHo2cWN2OHpMcTVzVDRpZjRqUGpDMEpvRkRj?=
 =?utf-8?B?bXBoT2k5L2wweWdDd0JNazY0TEJLVHlTR003TUNVVHJIRFV5Q2dKc2IrRzZa?=
 =?utf-8?B?SFYrVEZlOGRyY2hDR3h2dWNXYWxWOW5oV1JnOEh4ZnhoOWtqNGMvaHczZy9Y?=
 =?utf-8?B?b2pXdFpSdS9sV0tUekw1cXRTdzRieVBQL3draXVyYzJMSklUUDBJTWNlSEFR?=
 =?utf-8?B?dWhwZVMya0pibnNQSU14dHBnTGNNeDN3T29XbHQvM2FzY2M5bUhoeTlSbHd3?=
 =?utf-8?B?SEJTdExLVkhRWmVEc2twWEFFSXdiUFRYSXJPMjdhV2Z3WG5JcUdEcmxqOFJL?=
 =?utf-8?B?NW1yL1dYYVRoVFJ2YWVCenB0YkFuZnFweHV2TFd2ZXRuUHdYbnI5TUFXck9m?=
 =?utf-8?B?OGY3UFkxYmNkSTJ1YmRoQXgyODJJZ21VeUx3c0RYUkhjbnFwZlhmT3NiQmRF?=
 =?utf-8?B?Ukl0aE1xbWlabnBSaXpXM01XVTRZWG8vc2tyVThFVHJDWG5ZVDJ2RkVqUWF4?=
 =?utf-8?B?K1VlZzIxS1ZrYm1NWGQ3QjFBUWgyTkdiOWZGdTFaV1lWRnRsQ1gxYU9GN2Nw?=
 =?utf-8?B?SEpPdmVic28xNjhWNFR0SFI4SGpJZk44TW5oNVBFclpDMEU0bSt1L1FZOGVW?=
 =?utf-8?B?czg5NG1odWk0S0ZkUEx2OVpoNldjZlpmU3hSVHJvdlo1c3JyVzcrS1BEaks1?=
 =?utf-8?B?dHViNUtuYmZwYTdodlZkUVlvbXJvaHdkSUxvblNqL3pMMStWWVcvMTBUZWoz?=
 =?utf-8?B?bTBEcWlHVXROWVUxbk9PcmhKbW1vbXJLMzRNTkxBUmtQeGd4bDZDVjZENC84?=
 =?utf-8?B?OWhNYng3b0hSQWJ6Z0VqSW1QNHVveE1Kb1dKZEh5ekJsdy9DOWJyOFl1Uksx?=
 =?utf-8?B?aDNybkhVbmZ4bFFLS1BZVmhLT0JWazJUUWRhSDlvUDc4a0RuaVhER2UzMzhU?=
 =?utf-8?B?d2xTNDJmRFAzRTE2cnVVbTFNb2pmR0lMdy8xK0FKcGRKbmV1YkZzcnBjZHg2?=
 =?utf-8?B?K3VrdHl3THZwd211ZkVNMFBpOXRsWHBDWTdMRE1ocG1uakNqK2k1NytMTjUv?=
 =?utf-8?B?MVEzMWhMTC9SZlVZaERTYUYyKzdubC9ZRGxTRjhPTTR5c3JzMkNhM0N1WlZZ?=
 =?utf-8?B?alN1NWRNUVJiMG9HYWl6VlhMTmpOaW5NeFdMeDIyVFphckxmdzBoUkttWmpP?=
 =?utf-8?B?Z3F6Tm0xMnRKVUc3azFZTzJrT0xGc04zQjZVVklrb0JVckRnM3RhQTNCTUdH?=
 =?utf-8?B?aTRjWFBwQ2dDL2NHck41MGs5RFNRblh3NmJxRWZRV2UvK3k2eSt6UHBSalJO?=
 =?utf-8?B?MXc4ZzJ4VXZUTzRXSTJhRXJBYjV3dVBwV2ZURUpOeVBLbVg2TGh6ZktybHFk?=
 =?utf-8?B?NFZ3azBmNkRabW5YN1hPcU41SW9NRGVlemt0cklxbHl1Z05vRG5CeVpkSk9F?=
 =?utf-8?B?Z1p4MWNXeS82ejR1YmNFVndVQ1NRRTI1YlJHbkxiNzN5Mm05SFBEdkpWRVdC?=
 =?utf-8?B?THBueEorbFMzWElaNzBESVZESlRiQUhhOUtxRk5CWHhDSWtCbDUzMy9IRTBu?=
 =?utf-8?B?RW1XUVdnMXRWYUhsUFVDOGlxSnFIbEM4TWw4emdpQzY0cFByUVUvTlNHZWhr?=
 =?utf-8?B?cFBXZHZqL0p2REN1QnRycHNwek1QdGIyQWV3SGNGaEdqSUlYbkxNM2NacXdW?=
 =?utf-8?B?bkpWRlNrZi80SHJ1QkF1WGFDK3k5UlAzVEdvQVhoZHdlWFBRM005MTZ0WWZk?=
 =?utf-8?B?elFnTkRJV2wyaFdjUDV2NVRZRlBLTThWUmNXa2RtUjVESzg3cWFPTG9UL1JZ?=
 =?utf-8?B?WWE0cDZlcDQwaWZmaU9QQStKY2tQUWtKeStMcXFJd2JMWnZaRDNnSlIvOUho?=
 =?utf-8?B?b0Z3eXVSTWhZYWJWRExNdk9IMFByZHJDY2V5YjIrRzhieHJIK1hSUi9XWENj?=
 =?utf-8?B?RkxoYzRMaUJ2QUFXbUpPWXVyWWpYbmlrd21PL1VVQkwydWhJN1RHbUJKdUdl?=
 =?utf-8?B?bUlYSU5oZ1NoMjVmdTdnZXgxalVPOWE3MTJ1cU5vYUs2QXBKZlVCQT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 585f7221-9d32-4f33-33c1-08da2680eb67
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 06:00:37.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaquyZehyjNrKEQEWvQy2Vbu8B2cvowagLtGh4VyvvbwxHuHTd7zOpzD1LGnhTtu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB3025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The new chip works much like the other chips supported by the driver, so
this is just adding another compatible to the list.

Cheers,
Peter

Peter Rosin (2):
   dt-bindings: iio: ti-dac5571: Add ti,dac121c081
   iio: dac: ti-dac5571: add support for ti,dac121c081

  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
  drivers/iio/dac/Kconfig                                   | 2 +-
  drivers/iio/dac/ti-dac5571.c                              | 3 +++
  3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.20.1

