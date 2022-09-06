Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EF85AE5FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbiIFKym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbiIFKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:53:25 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE71BEA6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMq2PrzlqcnvrX8I6+u5Y8gGxBqAni1bfGKGB8Jz7kPrqIJXz502NkTT39OWmZv13YpYlYQ/1DJvXSLFQV3VpsrGlFNCJLzL19TP3i4IbpavLuJjmjKyA/8W2ayLDWoisTdIgosXqVcnPNsMlASaWsqqBAU3lNKfu5zZj6dC2d6aO9L3hdIdQM0afkQWrtCP52khLa5lSlGBWz4RqgvcspLsuzcPWMiTOpyWJFj7T6HZWA4qE237NwkRrcK0rAaEBtXuklf+HT6bs+slA1upuApNzJXKoLomEpuw9LdR7nDSM8+CmM8w4FUVil4X+coQAlw9ARlc7co8SoVjKvwMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZjILe+P3XEefcLTlpcavpl0Q5detxssd6k/IXhLg60=;
 b=crmFhiBiwg7UFALAYgNX+++HlmivCDIDovjZO3HgnKmXqi9l55iCipQ9i6RFRzzD9/QKRJXzFOi22X769U2MrUf84dBcJzFn+zUuTZaKEAucHw60Vli10re6qToC9WJQ7iWbqLLBTn21D5NqVBMuwdauCgBToo9IerrYeZpl91aPn3+rGqY2pAG4jcOip9D2xk/I+8Zw3T5g+pYS2vxwDyoth+My6jvU/PJIm2zKqbYJWpX0RJtVXe1tSRhRePfxn5np7fFUZhlV76kE42buJB5QeMrTzxyohZKrN1GC34JBhVKyXoAfKz1qvl6mVoQV75nV3fzjFRIa0Gm44CUfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZjILe+P3XEefcLTlpcavpl0Q5detxssd6k/IXhLg60=;
 b=iMyTzjk+zh7ByPu0XLCrR++ss5UpRxQs9vodfivzTMiai4SEM6lUMeDxZ5xEKb1TdOlXQJ8yTqHpiMGADMnOw8ZgzXZMy7z999jeOyYUWJ5jgeszv6v9Uxm0+JT+F+/zAp5TDiDA5HDxtIavvDuIosBM8t4AVx59Sn/BaM8TZk0YSQoEaQK5raiAnDDZumqT3B8wHaZq7yHH8Y22VPRsxEc98rymqxDyhsuaJajJl725CtkwMP6zp5cAKRwpUjHIZ77fAhb9HxjJPb93O82TILUUtuWpUngu6ZpybBLFUCfZl/ziw0pKgag3yeocxdqhbTbQjUEx20+/3s4EejqhgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 10:52:10 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb%4]) with mapi id 15.20.5588.012; Tue, 6 Sep 2022
 10:52:10 +0000
Message-ID: <44cc479c-c90b-0197-6903-5b4b4b52fe08@suse.com>
Date:   Tue, 6 Sep 2022 12:52:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 5/5] DO NOT MERGE: full sensehat device tree overlay for
 raspberry pi 4
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Joel Savitz <jsavitz@redhat.com>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <20220823174158.45579-6-cmirabil@redhat.com> <Yxa135HNrFztZe3F@debian.me>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <Yxa135HNrFztZe3F@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7071249-3d84-4f98-3754-08da8ff5d98c
X-MS-TrafficTypeDiagnostic: PA4PR04MB7902:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rp8Axk5FIkOvtpgA7CizcugRs1cfdQ+Isr7FO7pvUtCmjF8Uj69XO1dAkDiXpOcXiZRfFVQvhrEgP/vyIBoVeiT8/GYA0uvYu0VWZfd4fV/hbYulTWmVS0GK45A7yZW5RUj2F7KsYWpd6PhzwIpJr2fy1wQQHz8ncu1MaRWr0W9lVfNVLG7Rc+6RMAIaqc2FneweUg3HsCrsxEjXroxPqAb97ada+D2d97RPSQYbC55oCEHVdg8ymJ67hdqBk0g98pBhpe5KLbS1kuFkAaib+ekYEGR1HYT1pTKq2M68XvrrpFVCiOsGIo072eTKDt94IwYav8T9KO4OcNXtHx5Q3/HPWea88p3TOZMrwUPcIwYJ4svFgaEo3qUP9FZONKgDrSLi7pYCVdrTM+w1AM5KPPMNLmMdg4TWiKnjUziQTg6z1pY/b/pikGJpzBat6y1X4uL7U4EU/N5C0nyUFUiiN35cidSPuQ3LR6t+OmyNgUrzYjz61ksJihI9SC3F7a5festlSjVoEqFRpB92TLCSJ+h3H70kLTSGggrumJ2zLiBy0Ndk1NTx5S6XSlQWn6QEPcPHVxlMJwnYnwV4fpGjmGxFq1MEtX6bp3JSKdJQuZd3/XyvOK4+fhlOmMSk8S2A6vGo0E4YKHQV7RrteHvzen1N6xEvmhjwrMK+Z3HA+w5b9W5bTShzbtEFrSSdSm0OmDT3D1W8StbE6x3loygP9w2pUtZRpR9qPT6J6mYuyhqfCjOF11hNGhFPR9VFsZZzL1BoVOzCwZi4gbDC5sM9kJrXoxZ9SY+LUzxXDWLAHrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(366004)(39860400002)(376002)(31686004)(38100700002)(36756003)(186003)(110136005)(2616005)(54906003)(316002)(66946007)(6486002)(6506007)(478600001)(66556008)(8676002)(4326008)(8936002)(66476007)(86362001)(31696002)(53546011)(5660300002)(7416002)(4744005)(6512007)(26005)(2906002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRxQm5QbWk2bkJiL29uRmtieUpQYk42L2thTVFPWFEydDhpZCtpLzZ2MERU?=
 =?utf-8?B?UEdxVnRRR1F6Ym1HdjVSN29ERVMyVTduam1Rcms1RE11a1RSTmR3U0Rsc2hy?=
 =?utf-8?B?L3NFMTkvZ25Pa3lIOTNodUxiRkNyUVpWUmZYRkZHWGJDaENMeHl0clRmZC9h?=
 =?utf-8?B?WDJVL1lSQm05eFQ0Z2RHKy9ERlhUaWdEd0VxeFFPc2Q1UmV4c29jdUt5NVpo?=
 =?utf-8?B?Qi9sc3hxT2pNTkRDUHp6cExQYXF4N2NOVkNteGRPY0lDZDRla2lDYzhXWGFx?=
 =?utf-8?B?VVRqSHJaT1dkanhxYU1EYWtiM0dLTjdDa1dqSWUzajVpTS9KWU1QZjlYajJG?=
 =?utf-8?B?SGxxcW5BUVdCN1ZwSkh0aklQczE3WExaNnc2RE11NVFVYkRLMGJpdmEzVEov?=
 =?utf-8?B?QW9nb3Q4UTZJZUJsb29QSW5EUjNFSEU0ZU1LRWp1SFp6RFJwMjJTa1lCUTlK?=
 =?utf-8?B?N0xKeHVwa1lGbkJEZU5UUFNXcEVjQUZzbXBCZVd0QzNzVDNiYTdvb1B3Mzhr?=
 =?utf-8?B?WVZ3OGJJa1d6d3R0NTk4SWt6K1Y4VERCbWh5b25MMVphNWM0dG1zMm1wUmd4?=
 =?utf-8?B?Yk1tOGtXNjF4R0FlS2dSeEhTTHhiRit4K2ZuNjJ4RlVRaXFXWHVLckZDM2Zh?=
 =?utf-8?B?NXg5YWVFT083TkRleEJZTC82ejBCRElNdi9uU055RHNWdDRLOThPT0RtUnMx?=
 =?utf-8?B?emVmcjJ5WmtubE1oMXRpcEtsV1NYWkFSaWtHSlJNVEptajF1YXRsQ3JJSXhL?=
 =?utf-8?B?N0JGTGIvaVNKbGVMdWo5T0NwdTBla1MvYmx1NFZnYUNUSlJjM3RaMnFRYll0?=
 =?utf-8?B?TjVMKzdVRElsbFVIWDZPa2hFWWt3V3AwRElyZ0dkZkwxVjZoMmFTS0taZEZh?=
 =?utf-8?B?VDNDaEN2N2RlakhKZzEvNm9PcTBpZklzdUxhTlNjZHR3dXd2YUg1Z0RQaTdW?=
 =?utf-8?B?Q3E0U2NDZXFXNlpWZ3U2WTRXMVM1S21NUVZsOG9pN1QwM3J2TWRTWDBGMTRO?=
 =?utf-8?B?K1p3WVk4N2Y0T3RQa3huRUh4NnZoNlVvblRuSTBDenRUNTI5bXQ4U28xVFg3?=
 =?utf-8?B?QzdFZEkvUkI0b3ErTWNuTDJIMzBmcDd3bHRJc3BXVGhPK1pzaGNWVTRHenJH?=
 =?utf-8?B?NmZIT2N6VzNpU2RhTmJ2bkRXbkljRHFaaVM5THpwM0VDNWtHRHBPWkxTaHBO?=
 =?utf-8?B?ZXJLeVBidjlZK0pXdXFyTndvQXpZN0F4aVk3MFYwQTFEVDgybXFnTDBlY1hT?=
 =?utf-8?B?N1l0WExRRTk0d3NVcm5nV25IcHBnY0Fqa1JWcCtxSmlTWmZaWnpqTUxMQkdw?=
 =?utf-8?B?Mk9iL2ZFcWlPVFJoUjlZaWovaXRidXFhQTBhWVZQc1FwN0FwV0hBMGlWT0Fy?=
 =?utf-8?B?Y2pOUXc1MFdRN1l2VjBpaUE0UmNFWG1XL1U0UnJrRWY1K2ZPNjJCdDc2ajRw?=
 =?utf-8?B?ei93aXBWc1R0NEJzZHNIbEZ6MHlUOUVJQ0RXRTBFK0NwRG4wR01pS1lmdHBn?=
 =?utf-8?B?cVY1OVJDSWpNbk5XNm5WcW5FeFpSVDlpM2NGQlBNT2U0QTdrYno0aXBudjEz?=
 =?utf-8?B?YmczaWQ1eGJTdURTMmhlUXl6dUVhKzFqRjQvckdrbTIxVVlOTWpzdUEvYTlZ?=
 =?utf-8?B?NTNDakd3dlJVME9RK29LUmd4Q01UZG1WeXR4YmZoZ05lb3RVYXo1U3N3MUdT?=
 =?utf-8?B?WC9EMDdGY2QrNmZwSE1XMmNuQlpmVmxMTjU2WUI5aTZCUEdrUVp0Z3g4U0Jk?=
 =?utf-8?B?N1hvNXJkb2ExeXB1aHZHOCt3VmVXQmhjdHVJWFgzcC9vcVFLbjF4S3dtOWJM?=
 =?utf-8?B?d0hJTFVXNzBRQlVxOVN6cUgvZzFFOHBUZjNkOVhKVFNHNEo4bklmN0xPSjFs?=
 =?utf-8?B?dWJBTEJyRVVZQUMyMVg1ZUlDTlU3Q0dsSDMvQm1TYlpHYVhnUkd0RHk1U3hw?=
 =?utf-8?B?Q2Z3NUxZd1VsWWtCTWV6NkRHeU1NMTFtZ29DRlcrRFV0aUwzWWl5R0lVUlpR?=
 =?utf-8?B?Ykt2T2hCSS9kbVZzSmRsS1dKR1hOQ3ZIQ1FGK0ZnRSszZlp4VG9td0NNbGZv?=
 =?utf-8?B?YUtCSVhaUDBIYllMbkxRMktMMk13MkpIWGZkL0FwZG0zR1h2d0hpWTMzelFQ?=
 =?utf-8?Q?wilx0LY5CqFblopj2Ank+iMFf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7071249-3d84-4f98-3754-08da8ff5d98c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 10:52:10.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUET5GoktIMdbU+jtrnizg2iSWu2HcoQyyZNDFxcXPAFco8Q2sENyJ6Np+uTsqML4a7V1wgNMK5r+OKO5Iz7ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2022 04:52, Bagas Sanjaya wrote:
> On Tue, Aug 23, 2022 at 01:41:58PM -0400, Charles Mirabile wrote:
>> This patch shold not be merged - dtbs files are not stored in the
>> kernel tree. We just provide this file so the code can be tested.
>>
> 
> Hmm, if this is DO NOT MERGE patch due to build artifacts (in this case
> dtbs), then how testing of this driver can be done with just DT source
> (like other drivers)? Does providing custom overlay needed for testing
> it?
> 

As it's a extension board to the RaspberryPi the DTs are not included into the 
Linux kernel. Instead an overlay is build which can be loaded to the base DT via 
a special mechanism of the RPi FW.

Adding this file helps anybody who wants to test the drivers to do so without 
any hustle.

Regards,
Matthias

