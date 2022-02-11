Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972604B27BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350736AbiBKOUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:20:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348719AbiBKOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:20:49 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2134.outbound.protection.outlook.com [40.107.21.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13521D;
        Fri, 11 Feb 2022 06:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgaYfTkFCC3o269JmfwCtxo11LS4C5ZLKTb6opDei6O7TxvHRWwxMybX4b/yA1l4JtRkgaQshjeSucWv0lqpGlVP+cUqxQpvDhk4xBnF1m9TIgw4cHZktvFOj0xpZ+pMvJib8zjlAEIYXN6BzXhWIorNQHYx+QlizTjJPazV3d6faX6wZBUbNKBe5+xdFKTOTI6LtCIkf7SbQJK0NUkVM55SsDYT40jH+U+HVrzO9i5X+PRIx4q96AT3aOZTDInv5uoYrwmP87tNB73bYjA6QIivlU/Z7bC9TUqa7sNOoCBjBY8yxE/tIRqvicR0xaZRhHo3NMDFJI3Hog+j8ItW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIQLnck1KDyP6Do45ZOwDF0IDo+xuxIzdYbEMjNba6Y=;
 b=IsfU1C3ke6peOCaKXUoQZMwPScnho5by/m4tRkKvlBW79kgjBVJ1MFbHRES4btyDiZFRcaUx25pWUgG1etQQckTB/1jzYwzAp6ehHEAUvwgBusia1iuj8RjhT9PeSF/x39FWy5FT/1HZ94ssZTVepKj+LOZFyjXhv23RE+8ca6RCvtf5v8WWKKRfOsZv1hrQuEcP5nALSWQ8nFvtoVUayufRjuMoYS2b2GpZlfuKEcWV+zejF48/zuU99lhNfL0jLxApQQgBMY8KiE5ruexYBlwtTPoVaV/kcsPp2J2UsZ8GRTafIs7HkGsnAttbnKtTwTZNRo++AkDjbdRtviH+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIQLnck1KDyP6Do45ZOwDF0IDo+xuxIzdYbEMjNba6Y=;
 b=ndEuBk54MmYBtKqAmgfEMdTm61oczDuLfdrCAYFDKsHpDtq4bARg3H61svCZqh4n4jx0r+dwqqIoUrnapnaMUuFjWAbNSqeeLXOH0iXFNdg8jdPUKtIo7o8QDuEDs+NxQjT+oWU9HmfEpcdYP5BdUNDgm6/TJKTru9G24bcsFn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by VI1PR0202MB2688.eurprd02.prod.outlook.com (2603:10a6:801:9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 14:20:44 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::c033:9198:4c70:e66b]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::c033:9198:4c70:e66b%4]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 14:20:44 +0000
Message-ID: <8a8980e1-97a4-1061-db76-8592b1f21111@axentia.se>
Date:   Fri, 11 Feb 2022 15:20:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v14 02/11] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     jic23@kernel.org, andy.shevchenko@gmail.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220208020441.3081162-1-liambeguin@gmail.com>
 <20220208020441.3081162-3-liambeguin@gmail.com>
 <fbb84b08-5d3d-3684-fdee-5ce367280857@axentia.se> <YgVNAj7kz1QbKkhy@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <YgVNAj7kz1QbKkhy@shaak>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::8)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b18062c-e784-48a5-d1ce-08d9ed69b08e
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2688:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0202MB268870FC22DBD91A2240D37EBC309@VI1PR0202MB2688.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOhUe8dVUywDBu5JVwxms3cnmFHcl9sfD5+P6AS3GmUD20pAqNukaSqIYZnrp5iIz8G2L3/2vsck+CW6lm7Gc38/6znzrX9d+1MsUtOtMCvnaIb2CkgyyJaElJ+5c4kZWMKs1VAgWJw10t+6ZBH8mHLPFOw53fLKvaEy8qgjs80D5G1FdnmHiO1TD6ddyLuyuJoG/cXIKFCZtEMIegJiumKhxwxw9q6GEuvRbkW7kgxDPV4avZY2/qihflr4GucA6pK2Vz2pC9hU8BcDiUtGnUZtpjs24GVNEKEa84sY4bIBTopqLoii2y8rTBjv6wdRgrUjSg1ZWLQkfo/kyYCESwogz15R+YmeqqoIWZuVsqyNBDDrgGxFPantCDXYU3/k7QXwAELkYVDDDlJpGcuGHp1WGsgkxGjuRpbde4GNlI3avEssjeOxK2w7ZaGZrno6E1+NGgEQJoTn2EcebXhlQZtI9vH12QxzVEXwl/FUyggmKyrq6SFIwrkiVOxgJWwrgbtE0Pvq15hkme1WZ0mmTy5Sz58X41cLMWug4l2tuDOY5xy7XrXA1loWtdLycm/jfYyi1ioBd0OmuvaqAQ9VhCGJecO8bxT5h6WhhoFgGa7yan3ghBILikPIWzV+bL91Ehyja6THG9ERyceQYpLhpNCp+J4Pct9EFASz+pYdxsFwPbiJLbO84hN5sLDBM8xZ+ndaXOce0YQlOUHyq7rrUUOLQPJn+PFJN78w4JhwOL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(396003)(136003)(346002)(39830400003)(5660300002)(38100700002)(4326008)(316002)(86362001)(508600001)(4744005)(6486002)(8936002)(66476007)(66556008)(66946007)(8676002)(31696002)(6916009)(186003)(26005)(53546011)(36916002)(6506007)(6512007)(6666004)(2616005)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3Z0WnJYMHM2SElrZkdLYWQrdHl4dlJlbjcwUHo4bTRIYm1EN2tFQ0JkRFNG?=
 =?utf-8?B?cmpWT1djVVJPSFFLTVJGZ3ZYbnhGZTJ6b0dHMitzTWxteXFXdklQTmlMeHVi?=
 =?utf-8?B?NnExaldodTQrWExMbzJFeUVGKzMxSm1IMUJFWCtuWFZyZDY5eFJQaEh2TFVr?=
 =?utf-8?B?WklhYStmdE5taUtaYVZhcmp2OTFXQkdOUUdlcGtOWXhFSXRRV3IzMjFMcURa?=
 =?utf-8?B?OWZCamQzTm5HWCt4anJsZTNENFhpaHlXc0tZei96b05saENWSXh3eXFVcUQy?=
 =?utf-8?B?TEpDY2xIMkNCQzRBTWtWclk2MzhzRG1iTWJMbnptRVFzM1BlSDI3dU5MTEx6?=
 =?utf-8?B?K1BNRWFGRTcrejVFU09yTTJYYTY4d1ZTRjNlcEM2dkQ1bkE4Y0ZrWnRWeXdX?=
 =?utf-8?B?MW5LYndBOWtrVGhPaDFUclA4MS96cmhyS3dDVEhSaXBNaGZFTmJwbmd5Vy9E?=
 =?utf-8?B?T3FaeEpiZzFJSzRCMEpvTjVTK2xxYUxlTmlvaVFmNUtDZ3ZjREh1bHNsKzZ0?=
 =?utf-8?B?bFNHUW5SVGF1Z3JRekpPNWF3TGhtd1JEY1pZQTdha2p1TlIyTW92bkFTdmxB?=
 =?utf-8?B?UTdqUUVEaDJOdHQ5V2hic0xaazU4d1dQdWkvRTRNQlFzMFRFVXZBbk8rYzZG?=
 =?utf-8?B?NVhiUVJXQ2duWFVJMzM4a0dMRnF5UEY2VFkzNHlJWkJ4OXZPZ1dkVitNNjc2?=
 =?utf-8?B?WW5LbmM4T1lodHV1dTlnTkxvN2lhYmU4SU9iak5mUWRwL1VYcHNRVHluNlVk?=
 =?utf-8?B?Snd1ZUovdTZKWE9nZncrUzJOVUVNcjNuTHM3eGdZYTRWdE9ub002cHhIbXhE?=
 =?utf-8?B?MDd5eGxjZVFMNEVxYTVuUGFvN2YzVU5aQWw3cXlyZ2VvZTBuemVtUXpRby9x?=
 =?utf-8?B?S0pLdzFObS9qdkhqRm9lMUlSZkJOTG9Ub1hNQnIrT2l4ODgrb0VvSXRGZHZT?=
 =?utf-8?B?dkc3Sk1jWVRjMVFBbGN1MUZhOTJKNnJzMkZ1b3V0SmJnU0ZsbytDOWJmNlFD?=
 =?utf-8?B?Wi8zVVcxRWFlK1k1U2FoZHFpYWhON04yTm8wSFhPY2JrdW5oMmNIRmlPSjFD?=
 =?utf-8?B?cGxEZUFJc1VUU0lJdUc1OEpYT0lWQXp5MjB3VFExVnh6T2JxM0hkL09hSExP?=
 =?utf-8?B?UmgySktXeklQR1Z3cVFJaGJoaEpYYWNmMlpMMUJXazFHd0R4V2U1dGhGZitR?=
 =?utf-8?B?NmtFNzI5VHBFald1WTRPbkt2UWpZVG04aEFMMFlnNk1nWWtQMmY2c011WUhV?=
 =?utf-8?B?L3I2Zjd1VzIxNVAwWjY3dlY1MkFzOG95N0VzQmhkZExCRm1vWDdWNStBcXI3?=
 =?utf-8?B?NThPVWR0cFNSbWpuWU9JenMvTlhWc2xRdnVkWXE5YUZ1cm1RQVl6T09MZnYy?=
 =?utf-8?B?SS9xU0xhdWFsRjl1cUlPSFZCUXROdjgvcytqVGZ4aklOODJTb1BDek1pQkJG?=
 =?utf-8?B?MzFzTGdBRDAzN090OWpPTVZydU1zL2c4TFVJeEkzeFNvcVlISHJzU2pHTlU2?=
 =?utf-8?B?QUdQMFhYUU11WTlvTEhyZm01OEdwbEFJQ2pxSittckR0UnNnT3JNU0dodldN?=
 =?utf-8?B?MDcvTFFLZ3pUWm1HZlBoWFBDdkJONXpvc0NNenY3QW51U1RuMmdoWGRSdWV2?=
 =?utf-8?B?ZWVQTUN4WVlMV3JDZzhibHRiUlZiZitpNXhiK1o1YVRmT0hrbjhSMGFDeGpT?=
 =?utf-8?B?emErYWdubFVqVDhBYys2SEVTeWdVc0FZQm1rVncrZ2hVSXlTUnlaTFV5QWxt?=
 =?utf-8?B?VmhSczBRNnlPZWM5REUwMnhnOUszaFZHZzlZQ2JldHlOemdlT2x5WGlqVndw?=
 =?utf-8?B?L3BVaHBGMEpQaW1wTnlqSXBqaXBNNWFUL0ZQaUNpTUJkaXJPd3dsYk9TUjdN?=
 =?utf-8?B?dkd4eHh4bGZUY1Riakg3UXZHa2hjNEV0R1hrdlVKaWF4NWUvVVBpWjFQWXh6?=
 =?utf-8?B?Z0taam0yelg1WEhjaEpLMG9peE0xVlFtVDhEWVVFTnBlNU9XdXQrekdmUThw?=
 =?utf-8?B?QkxXQWZFaVpwNXlXejZ3WWJlZkdLT2J4NFJQYU5QWVhveTdrZnI4VzN2bkp5?=
 =?utf-8?B?R1c1SlkxTkJBd3BXbHBTZjUyNThPMWcyZ3NITXVKWnNXUm1JRGhXVEpVS0Vt?=
 =?utf-8?Q?I7pI=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b18062c-e784-48a5-d1ce-08d9ed69b08e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 14:20:44.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8p+FJ+0n8mAW50qjQxekPpIPzFpB5C5+qG0LKcujskasFlGUfdgsZE/Cv2iCKfBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-10 18:36, Liam Beguin wrote:
> I like that the macros make the number of zeros more "obvious" in a
> sense, but honestly at this point, I'd rather go back to not using them.
> Depending on who you ask, one way makes more sense than the other, at
> least with the raw values, there's no ambiguity.

I'm fine with not using the macros in this series, obviously. While I
can tolerate them, I do not get a warm and cozy feeling when I see
them.

Cheers,
Peter
