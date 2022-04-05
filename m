Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6034F513D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446925AbiDFB5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454778AbiDEP7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C7B91B8;
        Tue,  5 Apr 2022 08:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zfd6oaVa6DNJV9keE8A0qSGh/BVdiSvA5k0Pn9hi/k9Dsc23xVPIJf4NH3O5qVZN5paHRQXxfhTg++IX7Gxn0L1mv7Z4UOQgaSsIN+qL6hgy7djFQxHhqN/0bzqax905JeCKZYcHAzz2ABIPmhhZVWqDVYqUwdMMH5O4A0DFOaSCDSAlvlNBUOlONV+jx3ehSZpubxOPDS0xUgcNdOnnjypkX/SVr8+DCt+3smUR1IAh6CKtTUaH2IHEu3HCzAi0PJtEJYqqxjjvixo1CybSm7VNfq/ykj/VirrFQ2JrFPH2yM/n5VvrkO1Mlj8x9Jzn8aSq6eWbYSpgn0movLOehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FKoL/tsDBkDE/EhIco2+obGB7G4lV2QgSaPT/LsEyg=;
 b=CN8SdPiNRpRA4BICabdJGwXB0ieAnwLu0T5+B1sEAYcohSYalGcYSEW2HR73t6jKaKs/3xWdtTaqpkth3y62FHxlBCGSDVU+wGBwlc+czJbGFgFr1bw2oUWUwCnqbfRBVU4nV1oN2jjX00kreAUuYhLpY9FGbIu36J2rQOa0GiKvmc3fQfaZlybOlJzWxYjW4bRdwp0DIGKhToG1suCO+O36d+zYyhuRZcFb+TvkkJqwVTXdBvmqacWOKIWLHYg39t0L3VPmnT7kYfW2ohFQeCQI1pwRqFydglLGBB9uzEsVIEr3cMLvPTc5DgjQ8dMBEozdS9zeUxJ3ilgY6ClR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FKoL/tsDBkDE/EhIco2+obGB7G4lV2QgSaPT/LsEyg=;
 b=AUreYJn0mf07hm234vmDm0uDxnlpIAbrLTcJVvixTWYvZY2mqVAX99eYuEtB8mjuI9UutAWVhwvkk4Yq26fAt5mU54oXw9W1FPTBKAy/n/hVgCI+Mz7QTQFgJup8JE4vJYas1sUk46ZEOBLTg30+3SvBEQtfFMhbEFTaXcvCIvNVPOoihpaC54ETMSQBigdzIsfKg7DciSuskAavtdXD8DHjrTB2Vf488G3S2nFMhmrdemgIqvnQtogE8KcAYg0vvJlw3uOFXCgqvSu8Lt4rTE/5kV/BsEutWYF7laMtyquvssTrPeNoKAyi+cLB0ruiaCbyUPKpn+xcPk8wUzETtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from VI1PR03MB4973.eurprd03.prod.outlook.com (2603:10a6:803:c5::12)
 by AS8PR03MB7096.eurprd03.prod.outlook.com (2603:10a6:20b:290::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 15:06:14 +0000
Received: from VI1PR03MB4973.eurprd03.prod.outlook.com
 ([fe80::2ca2:213d:e44b:cf71]) by VI1PR03MB4973.eurprd03.prod.outlook.com
 ([fe80::2ca2:213d:e44b:cf71%7]) with mapi id 15.20.5123.030; Tue, 5 Apr 2022
 15:06:14 +0000
Subject: Re: [PATCH 0/4] usb: phy: generic: Support enabling/disabling VBUS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220114170941.800068-1-sean.anderson@seco.com>
 <ffee044a-d34f-6be5-1fa9-c14cf3bb30de@seco.com> <YkxaIK/y+7H8HgwZ@kroah.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <4737966b-a72f-8f4b-e9bc-a38a3f96b6da@seco.com>
Date:   Tue, 5 Apr 2022 11:06:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YkxaIK/y+7H8HgwZ@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:208:239::21) To VI1PR03MB4973.eurprd03.prod.outlook.com
 (2603:10a6:803:c5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06f27745-e772-4a2c-85e9-08da1715d411
X-MS-TrafficTypeDiagnostic: AS8PR03MB7096:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB709652924F840EED9C1E968F96E49@AS8PR03MB7096.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Nl7IYQN6kbeKT39FcdbIhIDL5bI7DmC1+pPGHESoETgMk9lVSvj/wckWQGsCLKpRRqt+C0h0nQ14AKz2ZnrshOGtSaYwxIbd/6iHWxiQrkKkJhug54dcEFTkGqQSCWQL5zaAJaiO7PFjejBOYXzjOqtX52szJnHaOPyWQekmMsd3UycRLD/YZp6pSmsT4aBegPDn/hDcy2pgPgDGJpzhJwjkV62b4OBb1NwW+gIZzD832xPLUuHsO2rgFJr5xhzSbhYF+PBsI5m/CBBzDT/Jq677lMilMzbmHWabqpjbWddCs99n51rnRtk/TJuib+G8m/PwvlDpu+Fe/tmITK5jYB1REWbqEzYS+5Bdx3gnd8Kj0UDPU2KFTFqnPUaWPJuHbq2L/e6CE2ryUI9Sa8EIXKLad9qerZDZWQ8XOcHXcOooxGqeFynWEh8bTw9aiRdHPBgw9PgKPpsoX1ezJS9FNZvfrpOrd/cjC6i+HxA2O+uEisOG7JUniVd9kEruMjp/K9UxPbDHHXxH5eV48pk8EvxGs6EyUDa09jDzbj/BU0af7jsIaLithn81ENYTvR8CkVTR/1LYzUDjSyQmomRRLvY7NTZAGoXY9ANMwAQ6cF2LJEBWid5xZoiOkdxlE7bwVfwy00Yj3/XuWL6ijDG46FPoj26uXF7hijCEMQ6hpdKsfzA/C8LK7KJNyqIqw4Xw98yDEjZwvjSqOgaTpWJ6klLlSMKX55AwQb+tzrQmsx0Jh6v+uaxhl29Co/KImtHT6w7Z5hYv0RKiLkOnkPR1TPvamLg7q1P49mIlVuCoCIQOS9KZbqDtbewCsBxTuukH6kGTAdZXt/qBX1lxKlSSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4973.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(66556008)(66476007)(186003)(4326008)(36756003)(8676002)(54906003)(66946007)(31686004)(6916009)(83380400001)(316002)(86362001)(508600001)(31696002)(8936002)(5660300002)(6506007)(2616005)(6486002)(6512007)(38350700002)(38100700002)(2906002)(53546011)(52116002)(44832011)(6666004)(41533002)(41080700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEt0Tno0aDZzOHVEVEs5MzBXbVZjTXBrclg2S21EWlFCTkVYMXBzYXBaVXZL?=
 =?utf-8?B?UFV5TFYwZWhhMjgycU9uNUZ1TlZ4L0gzTWhyK0tRZHNqNDRYREcvM1JNeGhR?=
 =?utf-8?B?aURpRWFhUENEVVBUZXhMWi9FM0hzdnd5bGlpUVhHbGlKZno1ZFJwMTZnZk95?=
 =?utf-8?B?U3M3bzdUQ3pqMWM1NS82aGZZSGFiK29OV01JYXVWczZhblRxTlRIYXZWRG5W?=
 =?utf-8?B?M2ZLbi9DY3VIa2ZQMWZJeU03L2ZGUHhoK0d4RGVucjZ3QUxNVjdxZ1lmVjc2?=
 =?utf-8?B?bGRMc0Yrc0hJL3NsUEhvaG9RTTZTRmM3Um01b1QvTllodkMxRUdoS3JmcFI4?=
 =?utf-8?B?d1Q4aHkzV1pCQTBJd0txaGNabVFBdGRtbE5ERVgzWTFtWklyRmx6Qm1xTHNt?=
 =?utf-8?B?SytUa2VzbEF2MFQ3eG9ocFlBQ1NwR3o0SFpFUjR4cGlYZTNodkpsSnhRbG81?=
 =?utf-8?B?TEJkaFl6L1piRVFKaUw3by9tdndRTlZNekVjSENwTGdiWVpTQ2NwN3BuTjhY?=
 =?utf-8?B?MExsby9Fb216cTRXQzdINzlLWTFWMlhOc0srMGFxQWRrL2tYczUxQU1BT0JP?=
 =?utf-8?B?NVovZmF0eGN4SjVyNzVIbkpvNWlNRkZkT3RwSmNwL3JHTmU4SXI4Q1p4eTA1?=
 =?utf-8?B?TUxrT3hBMGlVQkorTUc2WGFuU3JxTXdicnoyUzlLK29kTUhCL1h6YU9uWFcv?=
 =?utf-8?B?Mmx2d2k4SlRTcWljU3YvS215YU1XMy9aUXk1NTcwTTN4TVJTczdnTkhMVHVy?=
 =?utf-8?B?a3dJajlyZFNqYjN2c2FuRWIvQVlSdmsyM2FnZ0xjelBRSDdUT0NxOWRVTjFs?=
 =?utf-8?B?VXlSQjFUSlY1KzR1SE01Zmg2Q2MwVXRsRFlxT1p2SHViYU1jQkpRU2VCZE9q?=
 =?utf-8?B?WDJNSVozdzd3aDlOTjBqLzlhNUxsS2liWFJ6cXFtaTJIT0tQdi9NN1hSdVpE?=
 =?utf-8?B?RUpZTlFWc0ZhNnRqb3prQStnQWE2aUppMUo1RUNjbjVJOUVBb1lBbEpodjBZ?=
 =?utf-8?B?QlRtdUcrWS9NOW04QjJIRGRuaS8rNGNvVjdsVTVmdCtmRG8zMlJLR0pQSloy?=
 =?utf-8?B?OUl5Szg3Rk9ndFZETFNKTVNvZGJEZ3hGNGR1dTMxc24zNDlNVjlDTFNOeUhh?=
 =?utf-8?B?TjBYSUFXRWkwREhvOXFWOVVucFdjUUhlSkNlUisyUkQ1c01mYUhPcTVHOXJp?=
 =?utf-8?B?aVNzRFI3ZVpiMncxSUZKU0VYNS9paFpsM3NQWTU4U3p5TTNQT1hOWVRmMnFY?=
 =?utf-8?B?T0xBYUJuTXdiWkNZS3lKRmM4RlJpNkNsb1I4N09VTFNTSXlWYzJPM2taem9i?=
 =?utf-8?B?eGNpUkozbzkza3F3bWR6TWUxQ21ZL2V3ZHgzYVRIR2JnenU0d2o4WjFkMUYw?=
 =?utf-8?B?VitzaDZjT2FiQUVBQXBFOWEwUWwxUFBtZUx3SkI0Y1lzOU5tV3E2eUJhdXRF?=
 =?utf-8?B?RUNoS0k0em5FQjlVb0VPWVdUSmg1VHBqQjU1K3ViZHExSTNpMUQ5aTQ5VW9H?=
 =?utf-8?B?Yk9aMnFXYWFSUVB5Tlo3YWJHajJjYStHZEFkMGdqN1NXMFRVM1BUalB1ajhz?=
 =?utf-8?B?bUhBci9nVlQ2ZzJVUi9MUkk1SGdHbkxKS3FCWGFoSmdlcVpKeXRSK0w0dzFp?=
 =?utf-8?B?ZDEyMGhSMkRFQTE2SUZocWVEVHFzRXlFY0lMRVc4NjdHS0tLcXdIREJUaXVv?=
 =?utf-8?B?R2F1ZVdFMU9odEJ1WTI2c0FjZ2psOHB2OWY5Yk93ZFRmTkdDUExWSzBMTldF?=
 =?utf-8?B?aDZOYkNzOVJGS3p5dTdBSjF1MS9HMDRtSUJ1NlZvMkEwV2ZuOHFsS0Q5QnVh?=
 =?utf-8?B?NnFrVG8vN2JBZkN3NGdaNkQyUTBOemRHZGU4ZnlkS2pTOTd0aGozNmdVOHgw?=
 =?utf-8?B?S3dCbHh0MWxHZGxyeUsxYkYxVUtYcFFnS1FXZ1dmdis3cU15OE9TZ0t3V3Rl?=
 =?utf-8?B?N1hmbkxySS9HU3dLWjMzbzNFZUxGQUIzTkE1cllTdmdvTlVzemN5dFljSS9q?=
 =?utf-8?B?b1NSY2w5ZXVsV2E5NnJJd3lzYnFnK3RlUHNtSWEzemkreGQ2SHpyUm1JcVRz?=
 =?utf-8?B?MjdSV1QxWGhhanJ6ZEVueTN1TVNrbldxT3IyUE9rYlV3U1g2RmUzQ09ObklR?=
 =?utf-8?B?VVptdFpHSTcxb01OYmZubFpsMVM5RkxYK1A0OTlidzkvdGtWdDMzVTBYZWIx?=
 =?utf-8?B?YnJxM04ybEd0dDdXV0pnbHVwbzFtSWtKbVVwZDhDQWpCUHBZMmYxb3duNndS?=
 =?utf-8?B?QWF4ckRKNmRIQmdFcmdIWnN5T0ZQb0xlTkdRSTVscENDOTUzU294T2VMTlhK?=
 =?utf-8?B?TFBTZ0R3dUFpTFNYdkRFSzNOWVJISWRBVWh0cndXTkltbmNyQTN4NUppWFlv?=
 =?utf-8?Q?nBcLANJdBD5b2wVY=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f27745-e772-4a2c-85e9-08da1715d411
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4973.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 15:06:14.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbF6xRdxBOzoLoFLsVgkLk1nrNUEel2/cH635rEEYP603b0mp9yndpOinHPzSZ6/VUVSeQBAggwN2AdiMebWFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7096
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/22 11:02 AM, Greg Kroah-Hartman wrote:
> On Tue, Apr 05, 2022 at 10:51:34AM -0400, Sean Anderson wrote:
>> 
>> 
>> On 1/14/22 12:09 PM, Sean Anderson wrote:
>> > The generic USB phy has had VBUS-related code for a long time, but it
>> > has always been broken, since the regulator was never gotten from the
>> > device tree. However, the support itself seems not very useful, since
>> > e.g.  usb_phy_vbus_on/off has no users and usb_phy_set_power is only
>> > used by gadgets to make sure they don't draw too much current. Instead,
>> > use the VBUS regulator to implement otg_set_vbus, which is called from
>> > several drivers. This results in a change in semantics of VBUS, but
>> > since support was always broken I don't think this will have any affect.
>> > 
>> > 
>> > Sean Anderson (4):
>> >   dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
>> >   usb: phy: generic: Get the vbus supply
>> >   usb: phy: generic: Implement otg->set_vbus
>> >   usb: phy: generic: Disable vbus on removal
>> > 
>> >  .../bindings/usb/usb-nop-xceiv.yaml           |  8 +--
>> >  drivers/usb/phy/phy-generic.c                 | 55 +++++++++----------
>> >  2 files changed, 31 insertions(+), 32 deletions(-)
>> > 
>> 
>> ping?
>> 
>> When this was submitted I got an email saying that the merge window was
>> closed... but I think it has opened and closed again during the
>> intervening time.
> 
> It opened yesterday.  Please give us a chance to catch up.

Ah, sorry. I thought this series had just gotten lost.

> While that happens, please take the time to review other changes on the
> mailing lists, we can always use the help.

Noted.

--Sean
