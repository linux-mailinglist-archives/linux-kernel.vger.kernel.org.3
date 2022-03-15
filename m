Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3374D9BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244019AbiCONE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiCONE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:04:27 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130097.outbound.protection.outlook.com [40.107.13.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC6519C32;
        Tue, 15 Mar 2022 06:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8qzEa/hDdWF/TTFPeu5CanMYi9Fax1AY4kqKmhEz+TDlU5UH2HaJlLcp0OutXrrRGjUPq1v+3BZxXqW6X6mt21++n583ZIkq++cUszLZyS+vsUn2pmb6FdWzXMDieZzoa6apFsxSZO1vfdpxtJ+DXN0fKHcpBrRdS4mOigk2CkdItDSswBCCixEhU1dDM2h0EKUrRfmZoNMEzdBHkExY6VrotkNOfQG2kYV+iP89+fui3gjOPXG7xioxPRMPIaFABtCqE1xj0UdPgTbq7utTgV4mRWyntbch1r074DiYxSN7W0vzQtTtDiGs4AxPG56fY4E+IM6Ce67KCfb82duEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYhcQzb2ZwwD9RPkL0gE+RKFjJ5agc7pQ1kN2o+eaCg=;
 b=mClegyf45URvajmeXcfsa1bVOEqgQyM4KV8tua4WGwArDF+t+5pYMW/PSdPR/a4zwhfi0msZ1gIVU6KDBkggywP6wB8KDt1wYnjuOj0vwAm5EsQ6pnLjTlUYCYrBbr/rW/rtRAH6ddPcLJj86vcrBA4lKwjq/BZAVuniuL+I0p5Rw8e/iYpDa4c+Hb/MhTWkEfB0mWopnedwLR6cAS+z41tE0WjUB80h83mJ8SfIT4caoWuBe6HGIh8Wz0T2Sf7fkMDoqFltHOWTUY+fa1ZYcsCdbhNbEXY2SX2Q76qYikLdF2Ne5mskWZgmaPvVCLBR1TdUbu9E0c6bVJSulkGhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYhcQzb2ZwwD9RPkL0gE+RKFjJ5agc7pQ1kN2o+eaCg=;
 b=AA1ZDmknazl9NV2VcmtUj6fOOZNfSW3jSUZJenXijFLG66fz2iRrMIHKGmP17jUw2U6yJKAUV/6JQ1zdJl1eL12LzZ5Rd1FqaMtWoaFZJVHdxUJVLix1G7CFmB2kbV281z2LQ3D43jv5QOvsDJw96l0qrBtUdG+qr7sBIwxrKcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com (2603:10a6:20b:1b4::19)
 by AM6PR07MB4645.eurprd07.prod.outlook.com (2603:10a6:20b:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13; Tue, 15 Mar
 2022 13:03:11 +0000
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::e14c:59c6:7109:de9]) by AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::e14c:59c6:7109:de9%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 13:03:11 +0000
Message-ID: <292b2a9c-1f31-c3e3-753b-65a05d341574@nokia.com>
Date:   Tue, 15 Mar 2022 14:03:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
References: <20220222223610.23098-1-linux@roeck-us.net>
 <20220222223610.23098-2-linux@roeck-us.net>
 <51ea03f0-627b-2e9d-5972-2053fa12b9b5@nokia.com>
 <3dac349c-6470-1673-effb-354da2b52481@roeck-us.net>
From:   Agathe Porte <agathe.porte@nokia.com>
In-Reply-To: <3dac349c-6470-1673-effb-354da2b52481@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0101CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::23) To AM7PR07MB6916.eurprd07.prod.outlook.com
 (2603:10a6:20b:1b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7f9ab4d-767f-44e1-ca14-08da0684283b
X-MS-TrafficTypeDiagnostic: AM6PR07MB4645:EE_
X-Microsoft-Antispam-PRVS: <AM6PR07MB464533CAAFBD605EE48CC6859B109@AM6PR07MB4645.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Gtlrj+79b4pRji3lpSy+h8Er/SZO0bDH+vg9hgdb+RqLf9stVY3tKwJ00o/XAupY5v3No9W8Evfz6k/NqmHNFzaYfeLU7pYpDmuO8ZU+9EEdtVElqjHNo+5etzHjTD1xpkiBCTW3FO4FvqwLATnpQShP5/32Ajy04fj88tE35iIlllI+U/rwDpo1iRaky6fcag8v/XcLmUgJbosfsy45TZqI1SdtZ5hj78k3shCPDgQMbhmAKQjttuH2zocy0yaQS2aRCuKZ5fr2Dste1bwUBNuUKJrFhDGbDUDyE7gRnaui1gD4wCCQAoBGgUIeQtnnQHKVB9z++N1H8VAUdHiNXH6Ym8u4/Jz8udQB4CxJpvKgiMLgaSpVPVSURaAMIc+dlhVE+SeoMlbQpz7GArw7wPgrym6D1w5v9WAShrcTvuXYnAfJ1fwirfCONGxKCmCWCB818vq5w9vmnynzqYVTjBK4DNZHuk9VqkZ2Q46t+O6vn4t7sy2iZaZPcR+9B9/fS7TY9TAvJAZGiCR4/5WwVxAmQpln7aEH4yH3mnxOY6Hhzga0HyEDp5AQ7q+qeGgd1mRd1/1GUon9a3dmWNSIoAFCXl1cIczwugqaBISB/WdCgi6YT2QR7XtoJ4bd4oKyfciLgN8PIargXscEuEgkUTaWkhUYkvaoWAG+KfoujcQaFjGc9YgoiruGy803ExIG3nBKmo+Px4cYqpIT019eIOIs/eQYaZ7N03BaWJ7wVVqPqIylX/scJKoKC3Qvs4s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6916.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(2616005)(186003)(107886003)(54906003)(110136005)(6666004)(6506007)(316002)(38100700002)(6512007)(26005)(83380400001)(6486002)(508600001)(2906002)(44832011)(5660300002)(31696002)(8936002)(86362001)(36756003)(31686004)(4326008)(66556008)(66476007)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBLS2JFeU41ZnlRVFR1a1l5ZlVIYnFMVjBXcWtOTkwxdlVuYjNTWnJpR1FV?=
 =?utf-8?B?Z1dxVHVLZktHQ0pIMjBtNnRzdHlwakgxVDYwbnBBZzRRbnQ0aEhuL3kzSEgv?=
 =?utf-8?B?SG9wL2xhK3VUTHRWaC85N0trcXIycnBQZHpub2R4aStpZGJSei9OUXppT2JE?=
 =?utf-8?B?MDB6VlphVFF6RUtQUXhJenlFcC90YmhUekdhY1MvK2hCK3prdGllNHl6NGNt?=
 =?utf-8?B?NDc2Ukt3ZnFFdnYxa2pyQUppSkkvU3dWM3Zkd2xJZnZ5cFRSdFljM1hPVWJa?=
 =?utf-8?B?cUFKbndhWWU0T0JPUU13NVc3NnJGWWtrSEhrQU15ZndvNzltcGJBVmJZMHdF?=
 =?utf-8?B?KytHVys0ZHZIVXdza2NYdWxiM2RJTmM1QmNDM2pMUjdLMHowMW0reEphaUF5?=
 =?utf-8?B?dGE5aTVIUko3ZzF1RW5PWkpWNkhIRmt3MGd5R1BPdkpZdS9KY24rdXlCbi9S?=
 =?utf-8?B?WHNHUlhNdTBnQVJGMGhIdGNpWUxzcGsweUhFakhaV041V1RrOEZYQzZRT0Mx?=
 =?utf-8?B?eEROb3Z4aXdMTFYwSmFaNDJvRTRQYWhqVXEvcGdIMjBpSGxkaEk4Z0RDUkFU?=
 =?utf-8?B?YjlVSXlTWnoxL1ZQcksrcDlTY2hPTStucHBBT3gzcEtHek8zaldkTmgra1Bt?=
 =?utf-8?B?eWc3RCtCcDI3RzNhM2hZWWRCaWE1Tjc3eGRjMHVGUzFzQ3RGa1BJOFB1bFJz?=
 =?utf-8?B?dUFLaU1Cc0pid2N0MkRZaWlLVFB0cE5KY3QzMldaZXRjU1VBNFU1YjJrdWFC?=
 =?utf-8?B?VGRzcGlyazZaRDZpYXJiaHBQekhiSVJhRk9ybm9uSW1MN3hoT0dsOFVDVVFO?=
 =?utf-8?B?d2VUNXRNVHRHTzhtZWNJTVNhSGZ2UGJLV25zLzVFNFpxNGNtNE12eHRqMDkx?=
 =?utf-8?B?UEVjVEpnVVVSODlXejQ3VXgzWjNPZ2hmYmJ1c2tKOFJDSEpxczBvdnhIT0NC?=
 =?utf-8?B?TEhadEkwbmwyK0MvSTdiUXlYTG9paW5NZVZFNGF2VW10VmdBMFpNT3M5NE95?=
 =?utf-8?B?UGZjUlBIVTBUMitDQmd5dFNxc2M2aXV5aEJYOXRYZjFnMFdtWGhrNWloVVpN?=
 =?utf-8?B?ek42RWtqMXRTMTFUV3dQWUNIOG9SUlRVU1hBL0V4VjBiWjF5RXBmWFJoYmov?=
 =?utf-8?B?ZDM5Y2ZlWmdRVUtCMFdQZVNoYVdTRE9Jd3hqV0JEeUttR0YyWXpEeWNPVnNo?=
 =?utf-8?B?SnlKYndBeXVUdFd4UTQ1NFJFNDd2UnZuQnVWVFlIYlVMNTM0djV3Q2pQOHpE?=
 =?utf-8?B?dDU5Q1Yxc2lnMU91Y3hoRUdIRWlHWWJNRjU3VmxLbzVuNGl0Q2crdGFVNkZu?=
 =?utf-8?B?RHBTWlRvVmQ5Z0tHQkplcnFkK2xkTklhMEFRbVVXUjYxU01SdURwQkZBVkZV?=
 =?utf-8?B?Nk5UY2V3ZWhKZzk5YmhaSXNiV2UxdTErQWFmWlN5TW00SlNudlZpeVU4bXV5?=
 =?utf-8?B?bVZmZis1cjAyWGVJV2ExZStEY0wyM3dGK2tzSHN2VWVHSFhNbW9ZOHN4REor?=
 =?utf-8?B?cVA1V1RpWG5Cb0pqL1hFcFF0REhiWDY3NXBJWG91SlRTb0VFNlJCS05SbGFX?=
 =?utf-8?B?eUpNUGdOYXZqVWRQbld2c0UzSXl0YXF3c1JNOXEzUTdhbndON1NhUzBZOWRU?=
 =?utf-8?B?RkpxVlNHc1VsTlNybDRtUVpWUmt5NjlsMlZVaWdTTzJ5aDBnSG9FRmNHSGxF?=
 =?utf-8?B?UGx4R3BQOXV4ZFRlWFNCNUJMYk96Yk1XekN0VVlUVkI2KzM0MjJwNjZ0OTBN?=
 =?utf-8?B?QXJMTklWMGlVejlXOUJPU1JUQ0dEMFhkNFhBdktxdk1SQ2ZINlhJdCs0VW1H?=
 =?utf-8?B?Z3U4SUovSW5uTnEvZjBPekdWSWNZTGJKRWVPWk92OFI2NWRSQ2IvcnkzbVpN?=
 =?utf-8?B?TjZDTlNBNU1BQlBCMkZwalMwNUJ1VGNWb0VwVTcvcy9oTyszU0dnMGxaQnNn?=
 =?utf-8?B?bDR3S3NkdmxnU3FqQmR4K051TW85cWVpSjcwWVhYRDRUK3pQL01kQzgwZGIx?=
 =?utf-8?B?VnN2dWFCSWt3PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f9ab4d-767f-44e1-ca14-08da0684283b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6916.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 13:03:10.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzo9USwqV+W78ofehazM5Are93OU41tV95d1CaaNBq5UUhh/E9V/pw+WXPkG6NCngih8LrU6iJxqU5Z1nBTa4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB4645
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Le 3/15/2022 à 2:22 AM, Guenter Roeck a écrit :
> If of_property_read_string() returns an error, it will not set the 
> pointer
> to &data->channel[channel].label, which by default is NULL because the
> data structure was allocated with devm_kzalloc(). That means 
> tmp464_is_visible()
> will disable the label attribute. I don't see a problem with the current
> code.

Thanks for the explanation. I agree that there is no problem on this point.

> There are lots of examples in the kernel where the return value from
> of_property_read_string() is silently ignored. Not a single one of
> those uses a (void) typecast. I don't really want to start making
> such changes just to make static analyzers happy.

I have to disagree here. Because something has always (not) be done in 
the past should not be a reason to (not) do it in the future out of pure 
habit. I did not suggest to add the (void) casts in existing code: I 
agree it would be a burden with no real added value.

But making static analyzers happy seems justified *for new code*. It 
also makes *other developers* more confident, because with the cast we 
are sure that not checking the return value is very intentional.

Please enlighten me if there are any downsides that I did not think of 
and that would block this one-line change.

Best regards,

Agathe.

