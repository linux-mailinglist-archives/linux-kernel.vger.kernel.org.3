Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE4488C47
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiAIU0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:26:02 -0500
Received: from mail-eopbgr10094.outbound.protection.outlook.com ([40.107.1.94]:45630
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbiAIU0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:26:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtQ3KhMkVXBP5Jzg0qhJ7xVAuIEffyUC0yDIH7qGjjDufvEHvUQYeB+4GLluwGiCOrY2qureO5j6H5scX5zpdNezJ98k6r0ZpxTcgVMIDnYxGEhapr4hxfJQwd2jYVOQAEtGSEI8ctjFMTtkIbhwIi3y554hABF0h8dXeYDKFehPEw3fi7RrWsX+QCnAiufnK1JX5Ok76ffARqDt2eIbEZMAHTJK5x+jxQOL8OXnMqRPODoiUpKEv6PnRdaOi6bByUx0A6sGHwl7Nb+W7v9LziMp8PQBDTuW32enxIbV8X4YDNlHzGGQoXzX3lgFoeNY3/Q3h+kPOedSdf2X029OlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr43MfAhF009QbN8ApYpxJgfzu9ur9Za9dxMRDhoRJU=;
 b=Y8pOnyZ4EEDrYlJ9EzOs+cGh/8DODzcLSnWa6uIzX1vyV9l1+2oe5hHNgWaxBOHu2qWuGET+Uf1dSmMdeF7yLq7K7B8ZZjrxcyoh8cDZJe1oYlcQTqvPieTIOF+2LGVfIfa1IwxtBmvGaQiTYGeV8n85W8HBWAvs+FjoqkkdNNolid7wW5losvZ02xzqyC5rlF3ikpNmQ7qY69mr6Uv60jmBSoxJY/WwudMfps9WzjeyMuGFZ5PM9GqQDA7NKR3CFWB7akq8v755IvGYFEEi0jW0Dme2XurF/yDGBoaF0qckq3MTWZjOTkjIWbJNJQ59cD0MjAC3jjXSRCcyd53PsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr43MfAhF009QbN8ApYpxJgfzu9ur9Za9dxMRDhoRJU=;
 b=S+P3SWYSkGCt7W9wKPo76Hrb8amUirX+SyzFhixviOb41RrJosfJuy1oiJ2zNcWpAjk/dgcAY5Ww3DO4WAMI3WqcvQIEWA4IIYF67nb51jk3n/n98XN+vCts4PNJKZ5R6p2D0iUTQ3sWjUUeG/TbcUE0pIQgcHu2H+CsnaJtXN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2614.eurprd02.prod.outlook.com (2603:10a6:4:1e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Sun, 9 Jan
 2022 20:25:57 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Sun, 9 Jan 2022
 20:25:56 +0000
Message-ID: <0eaf35a7-20cc-408f-5df1-978cff99f629@axentia.se>
Date:   Sun, 9 Jan 2022 21:25:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v12 06/16] iio: afe: rescale: expose scale processing
 function
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
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
 <25cab0ad-f282-9cf8-df8a-1d288cb80cd1@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <25cab0ad-f282-9cf8-df8a-1d288cb80cd1@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::10) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0139814-f1bd-47b0-61ee-08d9d3ae3de9
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2614:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB261427973E673586408A40C2BC4F9@DB6PR0202MB2614.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jnl2XoFHUOX05CqzPIH7X2kyHhTOIAQgwdCFGjO+LiLroTdE5gR9xYNjz9qxAFkYQiXWhKX0iH2Ch/ozV/D7ut6+NRrYD/PCMe5onCg7vxdTgoKMH2O8F34LYwG3HGkprx4p9Zn8WnN66iWCau5DQXh5ewQwFR6pyvLHI7QapqU+lDX/LtGbUnZkFy8wYbs6fumhuZxO/TICjPBsOXnvT+7dgbPPhkcRiioap+WryLJRlejQ6J3CtmYH6+uSQWCGM/DAolJu0ZTvuOieIBEbq4DvIVp+Da4Qamb4vBygNe1zxEhjTOpGHHLWheD5YbXt4NfhGEwVe8fCpAbwKvFv+QwBjFqDZzOTCLpSX5Kd6HiDwzu7wcBk67oh5kPN6sokcJqTAqrmOup3Bq9jUspNoFoYMm9XyzV0SaRGr6gjHQxk28zHRoXEcVLYj/LdwnnJAb057B3agaHHruWspve0GfRvnGQ71lT/wHKPKd7Cu3xAgg9jTicmmTWb/mz8oOBAzoNcNtuxxJGcoVw5CJ10m5IyLdWXjYIvyUztzOPiEA/zQ/2q8N4p+fWQy/oRuPLSfJ1cR7la6z1+6Mm5ZZB5rc0xBAjYr5grhEPJ2+iNemonUkN6HmermZFhhjhbt9QC/kzyOF2c4PhFb9XtRd67i+A2xWMlsC/TRGwUAQRZHz8NmruL4BohdlP8+n7ZxwecPOxFDLpJoGb1E3lQw81RSGtIN0eYBisp6Qlyq96OSKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(39830400003)(376002)(316002)(2906002)(86362001)(36756003)(83380400001)(31686004)(6506007)(6666004)(53546011)(4326008)(5660300002)(66556008)(66946007)(186003)(2616005)(66476007)(38100700002)(36916002)(8676002)(110136005)(54906003)(8936002)(31696002)(6512007)(26005)(6486002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldmTnRhZW4zMVB6d0ZxUFBIUnBtQ2NUM2UrNWg5ZWowY24yQUZYQlVSR2RC?=
 =?utf-8?B?MHIzVEVPR05YTXhOSVBOdHpOdVdlY1RLb3VGRnZrdktRMjVwaUsyZEpNdVBx?=
 =?utf-8?B?bm9CSll5UE44OTh5a3FoekpRZXFYT2ttQVdKaGhvbmRvcW13WUZleEY2RUZu?=
 =?utf-8?B?Y2ZaZEp6V3dvczVicW1SbWZTRUw0c2VydU9hckQzMlhPY0lZU3ZhaHdENkl4?=
 =?utf-8?B?VzNRMG5yd3AyTk03WTlpTDBnUFZrTXFYbmFNNXd2UmJOamNCemkxUjJBeGdJ?=
 =?utf-8?B?eHJtRmVXUVlhTUpoZ2tZWmtNRjYxdlpKV08yWHZkcWxJVFNLWGdOYVBvL0V2?=
 =?utf-8?B?RUU3WjY2cGFVb1NJY0hQVkcxd0h1VFk0djZGa2hMaWx3N3R3VTZReGFXZWxj?=
 =?utf-8?B?aHdVdFFiUE5wQy9FZ0E4bFBsaFB2Ui9jbS9LeDRvK2ppaDloT0FYZ29lQ2FX?=
 =?utf-8?B?eTA1QjlTaG4rZXZmOGgreXdYT0daMFVPL3Z0Z2d4d2ZFVENMMlpBYlFFWXh2?=
 =?utf-8?B?SU9CODNDK093SXJ2VjlMNmdFMk8xWm5Qc2N4WFFxMlNBZlVkb2R3TWR1UWt4?=
 =?utf-8?B?dEV4VE9FL2Jpak83WU1FL2p4M3hEckpMSUJMQ1c0NDhEKy9FS2I1cGlDTEJB?=
 =?utf-8?B?eDc5VzZVL1g0ZldnRzZnSXV0T0lRT0tQUWdTa01LWGVLVGdETVd1d2dCZ2pF?=
 =?utf-8?B?b1VlbmVMaXdnaThhcVk4dC81d1lnL0hGY08zSVAvMTlxWFlIR3FsWTZ1dk5k?=
 =?utf-8?B?dFhjVUJvMGUveUcxUHhzckkwa0dqTlo2ZHhGOHNMUnA4dktzbkhta0JMaXlh?=
 =?utf-8?B?Ty9pMTlJMGFsTElKRmRwQm0yLzlnbDdSWk4yNGNvbGlwcjJaUnBqVjlPc1Jp?=
 =?utf-8?B?eFpjb29XZ2xQbEFQbGZvQmZWa3MwWExpV3JWa2NUVWtEd1ZFcXNzRjRpNHIr?=
 =?utf-8?B?eGdqNWxuOXd6YlYzUHJ0WWlHL0FtTG0wYUhqNFBpSm9uMVdXNXVOaUhOaURC?=
 =?utf-8?B?OHdmVEx5K2V3VHlIRVNnVGVrZjR3cXhIM2FCb25nT2lKNGFCVU44VmRjWDJh?=
 =?utf-8?B?ZGN4SlpFTG1DQmp3ZFpUNXFvSFVlVk9KcnFHeTYydUI0UFBFdFhXWGdyam11?=
 =?utf-8?B?MUVwV2Q4VjFGSVlLcmlQdm5UOEZuYmxEaE5KYkNqMHVCOG9lWU9xQ0ZCMmdR?=
 =?utf-8?B?dGVmeC95NjVocEJBUU9CSXJjTHlFbW1VMkJiZ2t5c0F0S0IzY2prMDRnU1lO?=
 =?utf-8?B?cFc5OVIya1VRaDEzWWZoRGc5NC9PcXM0UHc2MTRVZmlrdkF3STZEUFFBMWZJ?=
 =?utf-8?B?MmE5TGZVd3RkaFZXZXJCcDMxaUoyK3d4K1FrRlVVNTFRZTNNbmMxajZIZkVw?=
 =?utf-8?B?RGZZckUwemE2bExPZ0F5bVNPSEYyWHdHSTJmSzAyRGNaT2Uvek5FMEovVkNm?=
 =?utf-8?B?WUJZKzQ2M0FWeDNNYnEraS81WHVWQ1NUT1FraENpbmhoQm00QzJ1R1RMWjNh?=
 =?utf-8?B?U2dkRGh6QzlIeSt1K2ZpaDExdVFpbzZZbDlrbTBab2dHSVN3RWVIeWdjK3dE?=
 =?utf-8?B?QXRhZEVidU1yWDNJQzFKN2QzalVya1ZUbFM1djFHVGR3WnFmbm5INGMvaTdl?=
 =?utf-8?B?VlRqRW5BZ3RBRmdKWDl6NlFjZldsZjh1WFRobDBJREk1TEo3dlRGN0hiVjNx?=
 =?utf-8?B?WUg0Sll3bjRpbytoa1lmdzhxOWd6NExzME1WeTdmUTVPQk5TQmY0eW8zY05L?=
 =?utf-8?B?WmdjTFBKeDNhK2hneldra2JxM3hhSFJ3d25KejNQTWpCNFMyN3o4UFc0amF3?=
 =?utf-8?B?bkV3a1Z4WW1DdmVxdm5ibDlCRmpjczVQMjBYU2tDSitnbVp2ZURUUGMwOGZh?=
 =?utf-8?B?SU5ZMms0ZkV0QllUVTBnTlh2Y1pmL2ErMTArL2EwNTY4YUJWR2wyOS9uWDhS?=
 =?utf-8?B?VG5odktpdldJVHdxVnNjd0tlR2w2aVBWMk1Mck0zUVFkMHdqTWJ4K2dvaTlW?=
 =?utf-8?B?R3JvNnBnNjhoUHhlV1UxcVpMTUhxdThhYUVGYUJId2tWaU9idXNrQmVUdi8z?=
 =?utf-8?B?d2VoY0M2dVlGMWl4ckZBUnRVelBSVC82MXU3cWthRlVBc01IcUdDeStoNE8w?=
 =?utf-8?Q?jmuw=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c0139814-f1bd-47b0-61ee-08d9d3ae3de9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2022 20:25:56.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDt4lMU3vb1anYpCsi7tVyMdn1759ubnOOycloR10+xJMUSpayuC/dBCFnGzjtG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2614
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-01-09 21:19, Peter Rosin wrote:
> On 2022-01-09 14:07, Andy Shevchenko wrote:
>> On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
>>>
>>> In preparation for the addition of kunit tests, expose the logic
>>> responsible for combining channel scales.
>>
>> ...
>>
>>> +/*
>>> + * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
>>> + */
>>
>> Despite the Rb tag by the author of the code the above is wrong.
>> Please do not steal others work :-) (The smiley due to my believe that
>> you have done this undeliberately)
>>
>>  * IIO rescale driver
>>  *
>>  * Copyright (C) 2018 Axentia Technologies AB
>>  *
>>  * Author: Peter Rosin <peda@axentia.se>
>>
> 
> For the record, I did notice this myself but did let it slide. It's only
> a trivial header, and is it even copyrightable? Shrug...

Oh, and by the way Liam, feel free to add a copyright line to the
iio-rescale.c file somewhere in the series if you like (if you didn't
already). You've certainly deserved it...

Cheers,
Peter
