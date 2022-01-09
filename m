Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D223488C3A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiAIUTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:19:54 -0500
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:60384
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229883AbiAIUTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:19:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzFN6x6exnRJhY59DjajXGG6j9M66kwNgBebiplc2XEj+zSbEzj91nWaKl+koUls44BokWLhcc/QWsANmtviNDPm9r/2DGItM4FKVqG6uBPzH2hvGSazoJfcxJZm6+IxFwE0Vb5ZL5lUu50XWBcDCymFa7XIJgPRXxb/bVt4sWgly8WZeE11a2R1aKuvN6MFT1YDAy5lgwdF1uooMhWtnIZ0Ps1C1F9L31rfZSE4SGxMI+EGRft/fuq/IVrbLClTcjS4U0+2Oua+jcKOXCLpExspAb9REXngpwkJEMpvsBFoz95GFzpi/KRcY3pe3U0dPGi0ryzXroFtOXTxjtgusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOkyrvQnJLhxUPT3tkKiotIJl1+QazCHznJ884V0zpY=;
 b=MlNLzHUCz4vg3wfBrm544QHgTOXT31YQDns6ZFz0dGFCKc0hviD4VpLmIenFBRw2Nv+044wjtlt1CD1Q0wQ1lb88WFpAcRibIXmE/gpxATEpnHNgXe/vj/wK/4nT3B6983b7OsqZeE9qT2khyOn7T+i8WIs4LkxGQsA/sOQKsoceE6i0szzcBMYatIcQOb3M+GeOskuL1SceYa7ApMGTMJzZnsbJZO9vJSlAJBFkAOXZgxmZejyiYI26OYpEt2fKeGq8pEZ007CZ+s4ClQum80o5lhUsfPMfiRWhghjtElbhIKTxK6JFZQ+f+l+qNJIThtAkBsi+eTu36T9SHWL6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOkyrvQnJLhxUPT3tkKiotIJl1+QazCHznJ884V0zpY=;
 b=iCzbZ6v6ik8VGIDLVLhqrifMothgP+PIpM9smmwQsqKXAqqIxdbnE+akEQEpOZKarzFAavmgS7KoUYVIeuk8+C8LgJ0J2Z16a1bvpzo3UGbrRtMY+eN6gF++LS42u9L5sefMGg6K+rUFb9IHtvjLgshsXl7fx1FmND5KZcDLme4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB3931.eurprd02.prod.outlook.com (2603:10a6:10:49::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Sun, 9 Jan
 2022 20:19:49 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Sun, 9 Jan 2022
 20:19:49 +0000
Message-ID: <25cab0ad-f282-9cf8-df8a-1d288cb80cd1@axentia.se>
Date:   Sun, 9 Jan 2022 21:19:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v12 06/16] iio: afe: rescale: expose scale processing
 function
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
 <20220108205319.2046348-7-liambeguin@gmail.com>
 <CAHp75VdVBQPG0Qbo9H5Sro0-Uhr683WhWor9P2MXZ5a18HfRgA@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <CAHp75VdVBQPG0Qbo9H5Sro0-Uhr683WhWor9P2MXZ5a18HfRgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0050.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::18) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b8bf9e5-5609-4192-13f4-08d9d3ad62cc
X-MS-TrafficTypeDiagnostic: DB7PR02MB3931:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB393175524E119BCF273E22B8BC4F9@DB7PR02MB3931.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6iHnXjhMJ33NGDybXCM3RES/1wiZr1JU/38+LWJollQRS24JHQ1ngzUzSrR8eevZl37ChLI2zWPgfbRnKsjs8h8ESL9hgxbqkZh5RVxyW7N7C2mqWoh8VZzZQC0CMwSHbpEWBMfT8dcrKOU5pngR9JAmUzgseVQyx/WHoLIk6bHqVq5Xb1oChvUi+KqwU3uO7zL9rJtSYgSyTUGSdnAlofh5Hpw1iwG1Op2q3amTCGekFiwz6YcA7w0RqEd0mlqLTd4pKiAxNT/6GaOLTe4Fd14jQ3Bm733OuLs85w5WfDkXJEobYwGVdSRE6olSAJHdCdk95OdC9/oHhlRQNLbhkH1ihCJoO+rrIx0TA4qomCkDK0zPzf5NH9E7gabT3FTfim1DoeBjUJ0yGv0ELoR3io997X3vMosftGQJAdL4m7CimtB2p4zGck8Fc8ST3jPc8zFJD3LnkcWzCcpHBBTG2mo524S2dR1DtGwUQXuRuy5i00UfmIEls86eMKTffBtpJTEk5TScOJG9aKVc8+ZORpqixM3poOwxVoxZta7sIKxtLW9nAXXOIwW3zUE9HOpeahrpTfMUWu0WQs+c8I0GBG+vswykqs/Dny+sYW4z1xrF3evvfuP3+sNcyapfh1k1rgA9n9hJ8hDtqEdoBeQ/fnXlbn5RszNlcvvGXfRNEdsneNQvpOiJMhkO3UCTJpBqbDTtyb7Ah96tDlCTVZRTomn2j40ee136+Qjw1ufUyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(396003)(39830400003)(6506007)(186003)(66946007)(86362001)(316002)(110136005)(6486002)(53546011)(66556008)(4744005)(54906003)(83380400001)(8676002)(31686004)(38100700002)(6666004)(36916002)(5660300002)(66476007)(2906002)(26005)(8936002)(508600001)(36756003)(4326008)(2616005)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2N0VDlvaVc2YTM3ck1uMUVmaEg0eVEwaVQvZ1k1Y01EQ2liNkpudnBnMExu?=
 =?utf-8?B?VU5hQlgydGo2WEZibWIveEtCSjM0VEx2YWM2SzFrTzBkVko1VmxHeTRnd0h4?=
 =?utf-8?B?eHNvaXZDeFFtMmZXUVVHaURNWjNaN1FKTmpKTC9QcFYwdlpwdGR4Vld1Q3hh?=
 =?utf-8?B?N0VNNmQ1OGZuUnBqMEVHR0VUdmxWVFE1L0dSamNSOEJ4QzM4KzMwZktOSHVQ?=
 =?utf-8?B?SUlUdG13L3dkSWxlVzNQYWJMb0RtQUtmcnIxRGFlNm5QTFRWbko0bk9kWEhu?=
 =?utf-8?B?RFpKbU1xTmxLakZVR0VDZTk0QkVIRTBNMFBFQmNCOE54dncxcXVMalVHY00w?=
 =?utf-8?B?SlBjd1hrUHlLT1hpSlhmN0dmaXE1YzFjOXN4OXUxeUVmQ3UxZkNGMWM2OEJo?=
 =?utf-8?B?NDlXNW9pZTNGOFo0Skp0VHpkdkFUem5pZ29nWlB5N2s4TURtbm5uam5pTzcx?=
 =?utf-8?B?MTI4cXVvS0ltZmhqcW1tMVRlNHMybVB1dkRsRUZ4RzE5cjdXOHd4Z0hTL3Zm?=
 =?utf-8?B?eGhLOVhaVkZ1R0NIOXhCMVp0VTUvbkxqZ3prbFN6Lzk3c3c4c0ZCSGxCd2Nt?=
 =?utf-8?B?WU9wRVh1QmdYbjlzSEFybEZVWVFsKzhpUXIwSTRpZ1R3cjV5R3IwbCs0aXh4?=
 =?utf-8?B?TVFmVDNmRm5vbC8raHp3eUlkaHZhV1hjS3c1VmVKN0JFeWtKemQvaUpHZFhM?=
 =?utf-8?B?MFBiOEkxdk1HR0YxcExna2wvUHQxYjkzR0RkdGlDSWlzdldNZlpFWmtqekM3?=
 =?utf-8?B?UTlKeXhXMGkrNEpYMGpQalU1ZnlKMTVORThhU2hLVTVyenB0bTl5Tkd3djdI?=
 =?utf-8?B?UEdJdC9pTndQdDdsR0pTWU9Fd3RrRDd6em9KNHpOUForaEd5OENFdlFPeUtx?=
 =?utf-8?B?L1podDFFeUlVdEpMV1hzb0VMaXNqUzBHUGZtUGowdkM3Zy9jdE93SEZYd3lY?=
 =?utf-8?B?cGprdVQzUlhvN01ERFBRUlQ0MVlaemhFMzVqOTd5T3A1aG9JWTAzMFBoZmlH?=
 =?utf-8?B?ZHlndEcxcjVBeFBnMmNWY3VZak8yWEpsdURPWW03N3JQeDkzUkg3blBzVk1N?=
 =?utf-8?B?aDVUclFEWUdZV2VFQVF1U3UrSldjK1RZRVlyVFdPNFo5dmZ2RVZ4TkVCbWFa?=
 =?utf-8?B?VVdpWHRHM01WVHRiK1lNZnp1UFV5ekNDNFR4TFVERW8rUUhPdkJCNjR0OVpa?=
 =?utf-8?B?czU1aktjTkpOcHE0cTR1QU9GV2F6WE5NRlM1M0hpcGFtVElYRzBNWGJpaEhv?=
 =?utf-8?B?ZVlvUjhmSW1TbDlmY3FOTWVOTkZWeHpIeklZbE1ycWdhVW9WVUtQejFaOUpF?=
 =?utf-8?B?ellpT0cvRllrejVFRW1PNWgzTXFBdnNZeHA4UXVEUTlwU3ZCdEovTW9UZHh6?=
 =?utf-8?B?Ujl5TFFULzFWZ1ZsWGdYSjJObzJKWUVBcm56YitzMVNhSldUTHg0YVpENUhP?=
 =?utf-8?B?VzMzenBQWlMzMEpXUDZhb0FpaWdsdXdCSHB5MVhDQzF1cEhWR215b09menpW?=
 =?utf-8?B?TlZaOVJzU3dITEVXWHQxMVdvWVN3Z3lkTldDcHNUOXJjNGx5aU83V2RPR1V1?=
 =?utf-8?B?YUhLSnNoTUgvWDB0YmNpZk1TRnRsY25zMTFUSHVRWlFGNWtjeFliTC9ZK1M4?=
 =?utf-8?B?UkdrVm82VGFsVFNXTk9qVU5vR2VER0c4elp3SnY3MHlYU0JxNkRTOEM0QkNt?=
 =?utf-8?B?dEV0Wlc5b3QwRElMeHFDa3ZjdGczSmFsR3psOG83ZUZrdStqMFhxWTA2NEhT?=
 =?utf-8?B?YzQ5ZmhNc0JZNDRKaTZhM3JHbFAvRHhjb3FkMTVtYUJ2MzJ1MVNTQ2gzdVh6?=
 =?utf-8?B?N0Rjd05ESW8xS2FwaTJBSXJsUm04SllQUjhGN1RnbmZjd1piRjMxL0pEZTY2?=
 =?utf-8?B?NDdhR05NTWpNRGFNOGRDclZERzdocE5BRm4wb2kzSVVMK0ZrUTNMd05ReDlY?=
 =?utf-8?B?aURlVnUxbFh2N3NLT3RmZmE4NDg5Z1pDZ1hwTmtDUjBvUGtiRmVuZHQwZUQ3?=
 =?utf-8?B?NEZNMVpBeE9VZ3EvQTFZZ1RNcGdsREI1Y0RJWXF2cmRTS2xPQm40YTF3QkJ1?=
 =?utf-8?B?OENlZi85Ui90SkZ5eVpOb3V6Y3Y5WGdGZWllMlZ2Q3A3eGdDaTBkNUFHL0x3?=
 =?utf-8?Q?WFm4=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8bf9e5-5609-4192-13f4-08d9d3ad62cc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2022 20:19:49.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuGrG+7S08rva5rmncGejY1JRbFRrjhQ2XMgvD3ugN5k/wNRBa4UbF+htcWguQz8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3931
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-09 14:07, Andy Shevchenko wrote:
> On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
>>
>> In preparation for the addition of kunit tests, expose the logic
>> responsible for combining channel scales.
> 
> ...
> 
>> +/*
>> + * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
>> + */
> 
> Despite the Rb tag by the author of the code the above is wrong.
> Please do not steal others work :-) (The smiley due to my believe that
> you have done this undeliberately)
> 
>  * IIO rescale driver
>  *
>  * Copyright (C) 2018 Axentia Technologies AB
>  *
>  * Author: Peter Rosin <peda@axentia.se>
> 

For the record, I did notice this myself but did let it slide. It's only
a trivial header, and is it even copyrightable? Shrug...

Cheers,
Peter
