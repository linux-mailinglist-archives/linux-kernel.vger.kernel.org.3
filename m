Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFC45AD3AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiIENSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiIENR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:17:57 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50139.outbound.protection.outlook.com [40.107.5.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D93DF03;
        Mon,  5 Sep 2022 06:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9MANNeysOLPtzqpR7eiWlN1cbX0TiY11ZzgXdszzpmzack98RC4YqYJoR/RuWmBqz5zYlnAd++OD3p2eSWQ6eaF3Guv1OD1Eee72RPd24ixx5/ZJDBa7YWnGiDLj3jNFdCAcdWaayfeLcFVlkHl+WjaFcuzeXhXHb3znhM405VO1a+1P+B8MK5gZHcV0+R/3favai1rqQAyiakhpJBHFl1Yh2m9iJyj303OT64L2hhVRacWDI3TSTTOb6HG0a525wdl6kFuPFqaiNoIDvzW2BOIi7RoNX0M0hCg9k7wDV0NHOSYyb1Bq2TVJQVc0+K6yVVj1mTrOEkbC0v3iULjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RytWkr5qFEdpnGonwbb9NLGDXKjiVOXHjliTOdogPU=;
 b=RyY+TKUOxg1tN1n4C5BuL9sXbOQ+OrZ7DWBlM6fk1rlNJ5lZSLu9cCtvTLIfAMJqmWbMvhXOINnXExojBFXQETn5fS6/itGjRXQexeDIS7Qy10C/lnPZ4YsfYlHZ042Yj+3bBRtn85nTRvopphKC4mK4+ivpxbrVh6V5gEGtnfuxs4Qvasb2IPSmwUsLsJf0D10QZop2hjXgLkPKEj3m1+2vnyVbB60cmM5Lud26RjreTc6xPjQldtLDpHCl1S4FlZy5z9BZRGCNvBfGLMF1M9O/W7UvJJVr73FNNuPLXvBeTG3mHSZvwMUhb3GuLm+QgB4Gy2SWmxOxjeHek2a56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RytWkr5qFEdpnGonwbb9NLGDXKjiVOXHjliTOdogPU=;
 b=EW5MiUde4tO2CmQ8LKjMsVUJN1keDu1FWmYu6hfwpXrUJ1U7yruFDG4sBG7hm9CWqs19MXmOL6WUyOCUAWC16WCTBR378q71isPRZm7MQQwPMDbx1vgnOq11rPwSBPN9MH00qPbIVkJzZmeeJFfaRdtiyMKSK9qglMZFM5TJkLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by DB8PR10MB3723.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Mon, 5 Sep
 2022 13:17:51 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84cd:fa2:ffc0:456e]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84cd:fa2:ffc0:456e%7]) with mapi id 15.20.5588.016; Mon, 5 Sep 2022
 13:17:51 +0000
Message-ID: <5472f57c-9805-4021-fbc7-38363aab0e88@prevas.dk>
Date:   Mon, 5 Sep 2022 15:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next v3] rtc: fsl-ftm-alarm: Use module_init and add
 module_exit
Content-Language: en-US
To:     Zhang Jianhua <chris.zjh@huawei.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220905062613.1119008-1-chris.zjh@huawei.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20220905062613.1119008-1-chris.zjh@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0080.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::22) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c30ba2-4630-4737-6361-08da8f4108fd
X-MS-TrafficTypeDiagnostic: DB8PR10MB3723:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMAsbvdMSq5RjhpG8PN9Q8GPGPya2T7JlEZra+G4+m/Xuaw6Cr86Vei0MUdzDUapHhzhkZHlQUBfK7331zVVbxJCyejVCc2cobTLmhag2RI0XCKcORH3hcKnXkYXbuNGhGoP7LBi5P7vN+FlK7CKP1svq0k+ctOQqFSD2vfyRDYXvsdF8CmZ4X571KfQD8oVuqt0MN1M4WZqjBM3WBrlJHvvgjylXJtCWHpdQXc+9y+sF58CnGOkK963tkh2gbWhOKPjXmRoKwA7mPZ5prbZFeaANlM/I9yFK9JT55wgQE9OXsT05WSHbq+MRWZesmsxsamb8ZL+zRhtaXiS045S06jGepOvkDCDhq73F7QmRzyxPGi3tIlD51jwWNZZGrmgBF+MRci1VkiXcipDCFZOa3hAq6Cm4PJqzEtwP2RvGH9N9iqQ04qdbo3T8yUeZ5Z/jYqsDGwC30PVbnLX2M/duB75RJGK0Malc/Ql1AuDafqey84SRm+1WDCytokPd6cGTpr31Sqbz74olkUmxuJMTAIqaqvU1hcn0S5wzURXEszNNTPpJSHT3AOi388TS4G3ru90gwwJDxCeUR2fqjcQsN7bQ6qJP0iUXTNz/C6RvhjbzTyP/SIFDfwdiNXSGHj0GefsMj+NXnJJ0TDLCBDvb47NHTN6YfjRNm1lZb5ASoxcdMjLwuh7yRMCnr0OqS0nI9Kb02DYFHrcNjGWdIIF4L0m1Bqvwh75CwPCbae3b7d6cG93o0dhBMcVK3qFgEet7esP7eW4M3SUyf8GC1P1haiILmoAbNN8h0Y3sWBii2gJCtOLunI7LSDygUUPx+6UY3I212NjHr4VH0RWdIRO4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39850400004)(346002)(376002)(136003)(26005)(41300700001)(6506007)(6512007)(478600001)(4326008)(66946007)(66476007)(66556008)(2906002)(4744005)(86362001)(31696002)(36756003)(31686004)(316002)(6486002)(52116002)(38100700002)(38350700002)(2616005)(186003)(8676002)(5660300002)(44832011)(8936002)(8976002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REtmSzg2cEtTcysxUmFmYTJUb2lJRG1nMnNoZVUzTWs1QnFwQk1oU2QxaWIr?=
 =?utf-8?B?UzYybExqSEtlUGh2em5OWkNPYU5qeVhuY2MvRXpJZmJlZnpmUHJOOXBlQi9v?=
 =?utf-8?B?bUU1a3JaWGtpN05wcW5KbjZkdG0ranZEWFk4Z2l2SzBkVnpKVFVkaVl5ajlK?=
 =?utf-8?B?bWd2WUNaTXlKVHhoZmg5WUtYcFpJbmNSL1p3c3h3VXZ1ODVFU1RETEJNYS9l?=
 =?utf-8?B?NzhHRjdVRDc1T1hVNEZlY1VsMkFjaGV0NFk5Z1pZTHVRdjJpSU9iKzlJNWZ0?=
 =?utf-8?B?Sjgxd1hiMG1pUTNuWGlTSDhxaG9NTkR1KzJxK1A2clB6WjIvSG4vMUh5WEVm?=
 =?utf-8?B?Yzc4VmwzemwxSjZMNVdQNVZOSDlnRzVjY1BWZlg1aExBMnEvKzNWTk8wNEJR?=
 =?utf-8?B?M2NVeDBhVkFPVVF2T1VrZml1bTlBRkl1RHZkRmZIVDVDQ1V0T05TSmR6MUh4?=
 =?utf-8?B?MDFRaWpLeUxCQ2k2Uy96Z2kxdkM2M1A5dW53S0NhZlhMTmd1YWFNNnZvRGRr?=
 =?utf-8?B?elZtOGx0Y3dUS3pESHBQLzBONk5UeURwKzVEN1BzbzZ5cytveDR3YzhWanVq?=
 =?utf-8?B?ckJLSVVtSTZuVWNFa1R5VzJEZzZjbVNMRkpJSVZPdEluWHEwYU5jSW1CcXR3?=
 =?utf-8?B?clVMSUxaaVRweUw4SWRtc1F6VUlWUHJReTFlVFFpZTk4SkFoTnJXL2J0Sm53?=
 =?utf-8?B?YXRVU0JHVWFCaVBMRW9HOHR4ZnhibWNLVjNwczErdERQbU9EVWpZQ29lcWEv?=
 =?utf-8?B?N1VkM0Q3VkVHSXVxc3dnV041RnU2cTFkc3d5WXkvTTg3QkdZL1diUTg2Q1BK?=
 =?utf-8?B?eHZQeXZ5dzFzd3ZOaW80ZlZZU1QzZ1N3VFJXZWF5czBFcE81VnNZSTJtNE1a?=
 =?utf-8?B?cDV5MS9hd20xUkNoQlp1Z0gwb0gvNUEyaWNEeDZkQTVIc2JmQ3VZUUJBcC9S?=
 =?utf-8?B?bjZINnNWaHhDb25VMUxYM1M0aFpKbEtOS1dxVlNzbE1zWTNuMWJLSm43T0VS?=
 =?utf-8?B?cXRDSnlIVkovdnRpdmUwTjhwQ2dtdEZPam5EWHdYNEIyMUdnYzE3MGNBVEpx?=
 =?utf-8?B?N3YzWHMrTW1pZURZSy9TdldnR0wwN0t2K0NXTVppa1hma1MzWXhnV0Nvcldk?=
 =?utf-8?B?RnBVQXlGbGpCMTQ3d1FuNkNlUW11WFd2MnZ0Rm9LdHF1MlRUNUFJQ2ttTEFD?=
 =?utf-8?B?QXJXSmNqRWhVTTNJS1VHK1lFYUo4YmlJdEUxMlUxV3dodTJMaXJ1OFdtekkv?=
 =?utf-8?B?L3IrRmlYU2VQQjgybG51aWFSWW1DTmJRajZjQTA1UENKMmFXdFZoYWRkVjd6?=
 =?utf-8?B?WHh5V1ZOOFZVZjVzNmdWTlozQ1h3d1hRTUZYRGxhLytDMlA4cFpmR0lJbGlv?=
 =?utf-8?B?eWFtcFc3V1hhWTcrL2ZZN3oxdWtNbUdkZzVzb1VOTzdzRVlOU1lRaWxLNHdE?=
 =?utf-8?B?MTJoK1FoZ2lHd3cxaFc3bjNPVytiZGhzZzAxRFJ5VGhmR1c3TE9TbzB6ODFL?=
 =?utf-8?B?U2J3YVczbTdGKzY1WTlEWU5hVVFYSENtd0ZQSXRXV25pNjEzK2lQWWZ3czRC?=
 =?utf-8?B?dlI5Tk9WcEtueVZHRlIzSVZZRmpjeE9nRlFicVU5ZTJ5K1NDWmJkaEhSMVdV?=
 =?utf-8?B?bDdVdmNQd1drMkVUOGc2QldtZk80Z2pPT1AyaGJtK2FMb1FhK3VmQTlpQzhw?=
 =?utf-8?B?am9uM1lZR3BiSzhWMmpSQW93ZmtTWHJXR0lyUDhLRGR6ejlpc1U3M1djUXZq?=
 =?utf-8?B?bHQwZno4dFBLREpTSlRWMUxublRoTXAxdE8xNUZsY1Q1QUlMYjFnUUQ4MEp6?=
 =?utf-8?B?T3NwSzVvYk5IcUZpaFQ5SDhEWTNKL2RtSU1aZm9ubDFURmNPYUFSZldjVjYy?=
 =?utf-8?B?VHBTZmU3S0FrTkdTMXRwL1lveU9GMTVUcXJqRUIrUGZYUDdQQWkrMDVTRldC?=
 =?utf-8?B?c0FPQi9ydFNLYkdEdmRiR0htanQrZ3J1VFF2SlNHZ1BNVXIrZFdaSkNXZmpq?=
 =?utf-8?B?SkZHN1ZyM0xudzMvUVlSM2IxR1d1V1MrWDR6QTlBQ2JoNWRXd3ZnVTQ4SEpj?=
 =?utf-8?B?T3lrYWJsMjV0cThvRXJ5YWFrSklqeXg2WFZzOXk2SVQxNWdnMWFWRHNlVURF?=
 =?utf-8?B?KzE5SWRWa2NsVkh3aldpdEorOHBlaU1WaDdZbjcycnNDYXBXUkdORVRpUkE0?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c30ba2-4630-4737-6361-08da8f4108fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:17:51.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+A0yVc7ZOUQXmtTI+9iio5hAb0BFE2vdDJkwU+hFSR5wtN5aVjZCIrPgUfyQ8iAgcn5T8Xtt1VHCf7EQBjcYVGYckki7Wjb74MFvPbC+YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3723
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 08.26, Zhang Jianhua wrote:
> fsl-ftm-alarm driver can be built out of tree, so change the
> macro device_initcall() to module_init() for standard usage.

"out of tree" usually refers to modules that are not part of the
mainline kernel.

"can be built as a module" is more accurate and less confusing.

> fsl-ftm-alarm registers a platform driver in module_init function,
> however there is no module_exit function to unregister it, and it will
> occur resource leak, so add ftm_alarm_exit() function for module_exit.

It seems that you can avoid a lot of boilerplate using the
module_platform_driver macro. The single line

module_platform_driver(ftm_rtc_driver);

should/could replace the ftm_alarm_init/ftm_alarm_exit functions and the
explicit module_init()/module_exit() lines.

Rasmus
