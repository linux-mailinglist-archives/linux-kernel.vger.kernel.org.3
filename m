Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216A052A10C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345733AbiEQMBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346240AbiEQMBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:01:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60139.outbound.protection.outlook.com [40.107.6.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49941D304;
        Tue, 17 May 2022 05:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXPiEB6GZYPGpTnR++wYm4jO3xl+2235x9ErNvgK18+1fuVe8IHivhLQ7fvi1JrnjPufDl1goucF8XUZuQrH9na6rhAdTqJC0vlHV5bZU1PCl6vYxc4I/eed/uvPYMKh/15eMUIBKpc4FdOsqJA84bHDhEX9Hyg+kzNsugd4V2M04HYgh/CQwDlGm0peUyttCk6XOyvkAsy0iFZeS5lL5fkE7nHv68EidFLiDqE9GozrN8GQjXJOiXVyBURDlNlEjMHQA6ASjTthoWgMCLNV+cgMEneI9s7oS1ZwDyp3dRs1bAXzEAY+Obi3rmHi5Llfw/roRPWtej59XsD0zTQ26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qclagXNExXA6z94vBsuYLxcxNwfsAzXajZX+B/4gqI4=;
 b=ERBem4Cmg0sz9keOoEjOByStMXEvJaWSTYIljSzfW51J0YXqTUjNOoccZHY5p7G7rZ7bu4iwsqPTOhg0JwsyaDnK4myPFDevTIEunZGT795qc7CvempF8hYx50Gbm1ZPEfe2Bz1TUrUB+4Z8Jn3rRfsveS33vkW+ieusomWpStTS96dEKVCU/lcKxgu5cV4+r7NWVAwXjWeO2RzewOh81FUIXBAIrjtI3QVsgcJuXmN+Ymo6HvixzM2NTavNX5NkFYXNxy9dAV+ILWdjeU2pWKkiUWXndtRAMRh1PT5CCQ8lPRoOQ7bgiMUuRVYNb9g+kdOStaCFT3u6IFKtUf7ffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qclagXNExXA6z94vBsuYLxcxNwfsAzXajZX+B/4gqI4=;
 b=pS8wfKNS4XkIOyJnDGs9eNF3Bcno01D2jO6TIaNYbi+/pStWhzXaXhxGvf7xqCi+pPkQv5zp8P69VoFVSKtfvV6IqBgsbp0wHyXNX7y4fBWPwnA6cjuSSjf4p47MlM3GILJrkE3cjz7XmQFmv0T959D8XOGjqfnS81HFdin2tqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB6PR02MB3078.eurprd02.prod.outlook.com (2603:10a6:6:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 12:00:51 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::dcef:9022:d307:3e8a]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::dcef:9022:d307:3e8a%4]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 12:00:51 +0000
Message-ID: <6a6b9fe4-d588-1150-5f83-d91c91be9924@axentia.se>
Date:   Tue, 17 May 2022 14:00:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/4] mux: lan966: Add support for flexcom mux
 controller
Content-Language: sv
To:     Michael Walle <michael@walle.cc>
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, kavyasree.kotagiri@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, nicolas.ferre@microchip.com
References: <e43d766f-ec63-93d7-6b19-05b32579e6e3@axentia.se>
 <20220517115327.4139280-1-michael@walle.cc>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20220517115327.4139280-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0003.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:12::8) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 413a35f5-cf44-4215-1a66-08da37fce38c
X-MS-TrafficTypeDiagnostic: DB6PR02MB3078:EE_
X-Microsoft-Antispam-PRVS: <DB6PR02MB3078794FA621C198E686F0C9BCCE9@DB6PR02MB3078.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYf0Wrj5jL8wKIpkEeQO5CsTb1qmxrPj8kpQKUAfoW3nT3rHPrOyupc+R5xpif4Js51TEobyy1205zfKnLuSRgcNPQKEY8QTgSg9DWRGSogOI24S6sKO+1V8+IqHr86NqhqFIYtL9JgD0uCypfzCJ4q5jMqLvpR4VprBg6dIrqdwYoEyJAHtG3UPAzNhM1+JwMNMmvQivO3n3Gu7n/roUB40Xq/g4Gp3jmoCHz6TgxkCq3levMiUT2YTyqVmFGrK67hOuzZ6kSbNV8mc6+v+GWkhqQoQt5uwk3t6MM2MX5pQQIpnptwD3/2HTqlNxFRCyLcyo+xYqkUI9c31QitiVcry2yu1kHp9LDmBStYICFRhkh1EqK+b4XPE16BYBf1psSm8O7kIx4Yseuax626N66M8efO9IBRIWxHyXtx37aXhsjgvZUTUQgSGE06wD/kowBD8m/5yKWe9BL01KAxWOWmTXAfrySfF44mVEecNdcNip1sHHymCVOpMSy2Ksdvmr4fAST60dwkFw+eTVlyzUiVlEUJoGRcolSLd6ounHU/2KCtoq/7S9czefpPOjIC1/NYuyliD85xIRFZOtMNSq+ZHtgmDtvUbOhjPLJhMXZvCpv5oDQNtqpKuFu7nDdw3S14id6V0gaL+XOwijPcmthVHzAJt9UdcPXkOXVuos+Hu7L9mPiRo2/pKkSLLk5ZxJiu5uELfUY5nVgPeordfz8LF2I5LDydgP5D5xEJckj1uxMUC+TobphPELWdcIO8ST5MTANuZbnr+ICHCpQKtjFWbfLtWkiyDXhae4ozopVbHQsxxip6p/4ZYR5cy+bf1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(39830400003)(396003)(376002)(346002)(366004)(41300700001)(186003)(6916009)(86362001)(38100700002)(8676002)(66476007)(4326008)(2616005)(316002)(966005)(6486002)(6506007)(6512007)(26005)(66556008)(2906002)(7416002)(36756003)(31686004)(66946007)(508600001)(5660300002)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGN5cEVvdldOSU5sV3V2K1FXR1Z4WnloSWRlS01XZFo1Z2Z5UEpaK29DNEdX?=
 =?utf-8?B?V0VON2pmZ1hkQXo1a1Jxenk1Q2xaekNiM0s2ZTJOK0JVM3Y4WE5RNWhrVnEx?=
 =?utf-8?B?Y0pKejRQVC9naTBJQ2psTnhnc1RaZmh4ekFZVU9SVzRaV3o1dC9BckRTUHNU?=
 =?utf-8?B?THYxWXpEV3pqcHpDbWFPRWU4SlU1RlFqc2h3Y04zam80OGVyVll1MktwK2s2?=
 =?utf-8?B?cm13L1F0R2pjcmY1MFR6dDZQZkZvb2R4ZnRCUnhZa1V2NGFDNk9zOTdncW94?=
 =?utf-8?B?K3BTZHQ3VjJOWG1LeWovR0VhYTFsZ05wcEgxZ08zK2k5U1JTZ0I1cEJmT1Zm?=
 =?utf-8?B?ZnR6Z05MalhiRmVwRUlMUUM3cGI1RFhsNUZ5MXZBclA3WmduT1dYWlMwNzlv?=
 =?utf-8?B?elJiSTBVSDlqcmpGMGV0WXpuNXo5LzBXcy9vbE9zbVRaWDBPaTRGbmZEdVFu?=
 =?utf-8?B?bVQ3UFVocFlVbUlYVXFzcHpVYjhqZWdFMGpWZEFJV256Wk94QU5xTVY4UjVC?=
 =?utf-8?B?dnVFL1czM0owZGZsNERYeHpRYWdGOXFiUGl0NnM4Si9pQ1JsNk9YSm0wZVBa?=
 =?utf-8?B?cE8vLzVDUXV4ZENqUmlaRGt3SW1Ob0U3anlCZzV3UjlmSlpwbXdxUlJOL1l0?=
 =?utf-8?B?VDMwRkhGNkJucVJoRVAxNkpzdy9tNzFqUHFTYkZUUk5BbytpdkFiaTNVcm1n?=
 =?utf-8?B?U3ZiRnpLYzFZVHJuSHVkTHI5SzNnQVZtKzZNTjB3Y0k3OHIwU2diV2x2aUFK?=
 =?utf-8?B?OXVUZjhzUHdUei9CUjRwU2dYK25TdjBXandmTzN0QjduM1lCb2lObTRLRzZR?=
 =?utf-8?B?Mk5seHI5eUFQNmttOURrYnlYMi8xQ292OEx0UzZLYys2QStVejlIU0VzZ3ZM?=
 =?utf-8?B?UkUwWkxQWXdZbnl1bHNJaklXbnBaUWwwUno5V3BVWTV4TXZYQjhyU0loNmsw?=
 =?utf-8?B?ZUJBVWx6ZlBCcW8xNmhyUHhRdDA2YXI0Ykc0OEZXbTUveThoZ0JhUU5YTGo3?=
 =?utf-8?B?UTRGMXFydmZTUGFyaW1UOWQ0M2k3NDJYNEtJZ3FtODFLV1hic0o2dTNhOHV4?=
 =?utf-8?B?dE1WUVUwUlZ2SGdsdEZSdU1tWk5mMlVRSWI4eWEzUDlFTGRuSzJPbEVnYmZp?=
 =?utf-8?B?dWpCWHlzNm5tZFJtdHNidTAvbHVwS1p1amptR2RybFFQbU9qamFJM0tUaUhH?=
 =?utf-8?B?b1JpTEhLUldKek1meHF6WE5Hb0Y1K2FxRjNKZTR1UitKYjRWSnFSZXU3R05T?=
 =?utf-8?B?MFFnQTZTZkxtZzBUODhyZkQxQllnUjdYR3FxOVBIcHg1dzhVN25TaTBMeWFH?=
 =?utf-8?B?NlRCb3lFdGRJTmdiU3pIV0hBR0RPcm8wSm9SWWRzZ3cwMkVROTZpYnlwdXFY?=
 =?utf-8?B?bFBZMm1HN0xZcy83bHFyZ0NORDJWUTZ2c05OaVhqNTI3VFVHN21wN2J6bEp1?=
 =?utf-8?B?bEVPRXV5ZFBKUlpFZFRzOFp4R25jcTZyeW55aUJEMmh3c1Z5bkVqc2FrLzVy?=
 =?utf-8?B?SHovQytpY1k2RlZQb0RtUU9sU3hoRWdrSjJsZThDdEx6b3cvdGdGVFcvVm5D?=
 =?utf-8?B?b3MzUzBRZnI4ckVGR1lWYmYyV3B4MnpjMDVEclJ2R2g4eWYrVnQ1Q2dESk50?=
 =?utf-8?B?RFUxOTcyb0Q1ck5BSjBnYXlqeUZkbjFDczkwblJUVVd3MVNNN3FWU0tBSTlz?=
 =?utf-8?B?eVY1SWNBZWRXMExOTEhueHM4ZVN0ZHg4QnJOYzZUczRzZm1KRG8vMzFKNC9Q?=
 =?utf-8?B?aytSOFA4R2h5U2htMDhhZ0NxR2dsbTdSQkJhYjhncCtOUnlKUDhHZEk4QjJP?=
 =?utf-8?B?VFB1VGd4cWNVQXpZZStHOCtrcTg1ZXMrTTE1dW9tNHBKWTlFMGQrcUJHeEtX?=
 =?utf-8?B?aVBCSHc2eEJ5U3ZYZTNoUnkyem1kaldFcSs4NzIydEtQUVVhU0Q1Nm42d1lQ?=
 =?utf-8?B?L1NGbnI2TDJKdXgxcFBGNXBsam9jVy84aDBIbkRydkV3Y0o2MWZVTTg4eUhC?=
 =?utf-8?B?dXdNUk52d0V5YkhaQmI5RkxxcVBSNElaNjd5NWVuOWFOWEM0bXdNR3grRGll?=
 =?utf-8?B?ZXBnZFpxWWt5UW5hSkRSMGdLTk1JSVZsTVI3TkhGTlR4UnNQNVE0Qnc0VmNL?=
 =?utf-8?B?NmJPMXRJTTcydlVaczNnOHBJeVc5TTJNQVYwbjRsQXBlNGQ4TStKUnhwb0xp?=
 =?utf-8?B?MnhDSWpoM0IySGdHeEU2MXJWMEEvOG5TU2VXbUI3cHNSSXpaQlFoNjc4dE1u?=
 =?utf-8?B?ZXIvMzNPaXdpd1RPdTc0NGFMbk5KVXl4L0NSYzZYd0k3c3BZbWpxYWFRYWls?=
 =?utf-8?B?SVlvOUJIVis0dEx3ZjViUElNZVFta2FHSUVsN0JpMnY0S1g2UEdSQT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 413a35f5-cf44-4215-1a66-08da37fce38c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 12:00:51.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syrjmbSv4HdMPZJA9Ycn89ELHampF0uuGcnH5fxyTYbI2U5gR9yQtU6axoeXxjGv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3078
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



2022-05-17 at 13:53, Michael Walle wrote:
> Hi,
> 
>>> +struct mux_lan966x {
>>
>> Why is the file named lan966, but then everything inside lan966x?
> 
> So I was about to reply to the bindings but since that question
> came up here, too, I'll do it here.
> 
> IMHO the name "lan966" is super confusing and if I followed it
> correctly, it was just invented because the DT guys don't want to
> have a wildcard in the compatibles. But LAN966 isn't a real product,
> just LAN9662 and LAN9668 is.

No wonder I failed when I searched the web for "lan966"...

So, as you were told in the thread you point at below, you name
stuff after one of them (and not some random thing that doesn't
exist), but then handle both in the same file(s). Like you would
have if one was introduced first and the other came later.

Cheers,
Peter

> 
> I'd really prefer to have a consistent naming. I've said it once
> [1], having "lan966" (over lan966x) feels like cheating and is even
> worse, because everyone would assume there is a thing named LAN966.
> lan966x might lead the reader to think twice what the 'x' means.
> 
> So I'd prefer to have lan966x in the documentation and the drivers
> and just "microchip,lan9668" or "microchip,lan9662" in the
> compatibles.
> 
> -michael
> 
> [1] https://lore.kernel.org/linux-devicetree/d18291ff8d81f03a58900935d92115f2@walle.cc/
