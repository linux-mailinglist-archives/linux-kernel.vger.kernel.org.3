Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB044BEC99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiBUVZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:25:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiBUVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:25:25 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80108.outbound.protection.outlook.com [40.107.8.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B27312763;
        Mon, 21 Feb 2022 13:24:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P88GQg4ZSpxlF/omxUXduZ+rbn/hm/8aR31sa1HcO4DmwyrkRclLK9BZi+jFj4D0wWwyk1avbedwvn4hxux3i7idHFqypsiVquQCRbQ90Uu/Y+pc1pcz6kKAfeR4R4Ithnsz0jpa55rLXGeNipTxGZZkZF40DNUSZVmfn7V6jTC0TFHnusRrEGJE1aWhsVJmDKu5Ecf2Im2fIQRRZaxIWsnDx433YtLSKeTp4XLjAysPm6F7NFk6CLnM7P2ICu7X+hezl2PWEGDs19EiXFiBBDs/qrRfJRz4C4Ag6NiQb47y4J6kNNFNZZ79zMpKBXqYrK4AskMaTwPb1+yqX60YHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gkmhI8XLj07bbFVOSstD1s29zeHRwR+PKtsmMjMpSM=;
 b=TYUqSUJXXeh7mYuOqhkZ3kULf1bsGh40/7JNAr85XOEDAhoF/+5Bo0IFbc6BNxoVRd0rAc3UKlbGU6wFSvD0PLa5V6P8eeCBMb/fzyuV+F+2lMOchOX9cop3bhKUSxcJ+p2EN+gllkGbqDPyZkVSfLi+lSNMx59TFifXfrfxfWZgpCFS6blTu4pRtspWFH0zvjjpNUhMgkWruUttKVlTOVx7S2wZGTZY7JOpl0zWtSVU9/V7NlCj9veBQWt57EpqbgE1Fn8j78QXXf9lPhYLkqeBLKJxn8s34rlilOBxPV30n9iZ+6mFBgPlGUJZpNafBbX0zvh/lOGqQ5DPfojxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gkmhI8XLj07bbFVOSstD1s29zeHRwR+PKtsmMjMpSM=;
 b=lzPcdxLggxpRTbNfB+GL1p27qmTPf/yKFnLAXVh0FsJ3UcVO0AjitunqnSgFjJblR2YunrjBtADsSWJ3xUOBZn1A8hKBQ5wzuKUkNpc+jkF0rampzz2t5uDDE5JTY1Cgj7mPbGA5Nzb0c9zyo1Y7tBogaSh4YPM9L8mPGIMrMlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by DB7PR07MB4635.eurprd07.prod.outlook.com (2603:10a6:5:38::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 21 Feb
 2022 21:24:51 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::99a2:6f44:700b:b796]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::99a2:6f44:700b:b796%3]) with mapi id 15.20.5017.021; Mon, 21 Feb 2022
 21:24:51 +0000
Date:   Mon, 21 Feb 2022 22:24:40 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: add tmp464.yaml
Message-ID: <YhQDGHD3S0qwP2OB@localhost.localdomain>
References: <20220218150908.1947772-1-linux@roeck-us.net>
 <YhNWVLHYVtCvdGhi@localhost.localdomain>
 <66e6b131-274f-454b-44f6-17df879d71a9@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66e6b131-274f-454b-44f6-17df879d71a9@roeck-us.net>
X-ClientProxiedBy: MA0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::20) To DU2PR07MB8110.eurprd07.prod.outlook.com
 (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c36eb6ad-fa58-458b-ef85-08d9f58098af
X-MS-TrafficTypeDiagnostic: DB7PR07MB4635:EE_
X-Microsoft-Antispam-PRVS: <DB7PR07MB4635F9BF53B3250DECB400EFEF3A9@DB7PR07MB4635.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTnf7KKWHXfJe5l5M9BHpmATuGsMPYiN1TFXTi+zOH5yer1AVumN4/JlsxeC5nFti6XuKO5w8QuZGME4Vv4hng9zqUj7LBf52yyhszL32OA1+fBMCjONtjrQ1aIROX8YrKqDPO9adkDNzGgiCBf6GDF7Jl8Mka3TpmhmSp9u2gtyASLBvMe5yzJ6oOgHp5jhRe8oFB/pGgwCFNIlCpYewrsnD8oCdw2g1nr76vNInpyGGDOBqkicSV77bN8Zxs54gUfsuUbFdBqTuf6j0Gi1nc4N5nXDVpNdeRlacdPlZJgXpoGQqeTA/Zrnt+ce+gUSJTvCNGhBZaz+Z0ZNelR2MFO72iAOyGJbu84LFq7rpiaR4/Syy6AKVrxCSs+rAODle0JrTg1YeTKAopRGoYteI/5hdHkpAeoVtB9oc+r1qJhE6c0ZHYA5gDI7PD88ALgw2cZL1JJf4UCvJS8OPgNxIc2E+isOdnB3ZIs6tAXIDFHj1KacH2jM7Pud65SZon6KOtqOigAICf6M4cObJXiPNOaEjk/RQW9BLlj0+iHYlQqXj5RrOMYGnwVWu/3UIJtS2dDJ4jhM87bA2oyl3InLAhVy3syGxQCMomMJTYPcdG/BZN+X1H/pTruvT9AFHefC6eAVsFFB2/e3yI1nlAPz8HquC6TW+6PYbewALdnTl9QheDl1Oog4q/JRqT/wbynaInKdvWTDBcs8Up5CItytGoR8rVNpc9HwHnyoFbTy/qoLjAz+gGxNcEQYzE6XuQa9xwkTU83pAuzwIKu+n0ItXivp9kuU2Ms3xvF8PM5dPjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(508600001)(9686003)(316002)(6512007)(6506007)(6916009)(6666004)(54906003)(66946007)(52116002)(6486002)(8676002)(66476007)(66556008)(4326008)(966005)(5660300002)(2906002)(8936002)(44832011)(86362001)(83380400001)(82960400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHpGcHptZk5Cbi9aTzBNMVc2VG83cU8xbERhNnZJWEpOYiswc3M5eDdoY3R2?=
 =?utf-8?B?QVE3eHB5S2k1SGtYbjFQcXM1UGtYVnR3NmJxK0NHL05LNzdtU1RpeWJPS3Z2?=
 =?utf-8?B?eG8yc25VMGw5UmJ0ZFgrb2x6c3hGSk1iNkJINVJMdXZwZGdTZVNZZmhtK01D?=
 =?utf-8?B?Q056MGRYMEpGS1FPRXljNWlHUzZBclNFQ3VKQlBXeGJVdUdwV0J2bUpITXE4?=
 =?utf-8?B?VmdOS0liajhHNkV0MzNVZXVUTXBDMnA4N1NLYzg4MVJEQjJQZU10c3pJQ0Zm?=
 =?utf-8?B?azNBdzNGL09zbFdtUHVMeitxYWhxQlZLOWJzU3owS05uNUxhR2N4T2FwOGMz?=
 =?utf-8?B?NDcrVkUwUnIyOXkzZnN0d1RqdFl1dnM1QXJjajAxaEEwUERIMmFYNzJEOUsx?=
 =?utf-8?B?UEx1NDRaaTA5dUp2bG0yOFQvU2xVMWZYLzdDeFptZFhJQXRvMm5GUkp0Zk85?=
 =?utf-8?B?NkU1UWhBc2hXOURiTHova2swbVYraEQyWXBta2JyZlcxNEk1OUxjSVowZklW?=
 =?utf-8?B?WWUzeFVMcGZ4VklLVHlUekJ0d1owaGNsTnlMSkN0dVNTSjlsejB4T2pyUkVw?=
 =?utf-8?B?Q2k1MGQyS2lYamtlcDlRc0NjRkZOMVdZT2dZdVNtUHZ5MWVEU2xHamJsOC9C?=
 =?utf-8?B?WUhSWjBrUCtrTUhVSW1vby8rdzNYUFdhUnRwTHZCWHJ6d1J4WG1ZMWFhckI3?=
 =?utf-8?B?d2FKVm10emMwdzZHeFhFenZsVlI2ajFkMVdIZnhYUDJjRGFmdS9Gd2hIUjR3?=
 =?utf-8?B?ZXlIM2RvRmFDTGh3R2FqdmsxQzBOaHVzUWlZam5TVklLK0ZMbE8rWTN5Vm9L?=
 =?utf-8?B?Y3kwWVh0ZldYRGJzTFo4ZFAzVEZYdldjV0VQU1laUUpQYmUxelNHOUFlWGNo?=
 =?utf-8?B?UnZtTG1iOXdWZGRKcUVLSlMyVENFTSs5WEU4TDVzQU1vcytsQnA4OUM2bEZy?=
 =?utf-8?B?c2xGQko5YnQ1SGp6bWlkYzJVK2Y3WHphbm5TWW9VUjZscGx5VkcrZXliZFBR?=
 =?utf-8?B?UmRDbCtydHhwV1E1bVNRVXhqVlF0Z1FFcGUvV1U1OGd3S0FCbloyODNIRGtX?=
 =?utf-8?B?dzc5SDc4WEtKZ2RSRlZ5NTIzcnFnU3R1cklibXpleHNtNmdCNk5mcDF2VDkr?=
 =?utf-8?B?Q3EwYnl4SUpURWRoUEM4Z1Z0dDNyLzhHMnNQOXltM0F5RjV6MFRtKzBkYitI?=
 =?utf-8?B?cXUrNk4yOUJhSlYrOGFzTy90RjZNeGhUblF5K1hjbGVWV21KNUFZUGQ2R1VG?=
 =?utf-8?B?MEJ0RVNzdlpxVTB3eW9rczlmUkNWS3JmNVk5UjltamRjb2txVzlpSnBJYjdY?=
 =?utf-8?B?TFBBMWlLcXlIV2tiWnF5dEVCaTVpb001a2VIb0ZUYWR3UDRVNXkvbS8welBy?=
 =?utf-8?B?WWZ3NlRQak5qM3BVNm5pU2xrUmRCaEpOS3JyK2NCYjFGWjFiSGR1RUxlMjZG?=
 =?utf-8?B?bmx0NGR0Wi9zaWdwdXdSNE9YM3Z1Umo3c3YwMUl2U25aN1pMREREZUVaNjJM?=
 =?utf-8?B?alNuaG9ia3VPcFV1T2ttZDU1Umw1bmpuZFo2VGcrRnhCY0NDbFlGc051ZU4v?=
 =?utf-8?B?bmZMK3JlNzVQZStMNS9KT3lOR1VJeGVhKy8xalNxSitwS1JFZUc3OEgrK29w?=
 =?utf-8?B?aE03NUV4UXU5QlN4Q2dsV2poWVNjNjZYSllieHJGa01xWW4zeTNuTElWRGx0?=
 =?utf-8?B?TU5LUHRCTTBkNDc5Si9rN0owZmxvNG5zajhvbWdvR0ZabnBBakFOUjNZTlZa?=
 =?utf-8?B?dFhhUmtwYzZXWW5UaVdyTUFhRGVGM3JhSTZhTzZWNXlpYmFVSXZSK0VVN3Bx?=
 =?utf-8?B?OStlbXlCTytWdHprb3V4Z29zVVZMM3RLZ3JUaG94cEozMXFicjgwa2RZTStL?=
 =?utf-8?B?dEtEVmZhZFNOQldoYzVNbUxIM095TUNUTktRakZIS2VyK2VJbnFheUlwQm9R?=
 =?utf-8?B?Skl0RkJjaEo4ZmRWSFg3MUk1L3ZOTnU5UEU0RzFOWjkzeGo3U3V2NXYrcUlK?=
 =?utf-8?B?Q0ZtaGVpOUVOdk0zNldSQ2tWWkdQMlJmeUNDS0tiYWtWZ0x5c0VnbVRqNHpy?=
 =?utf-8?B?UTNDWUlGVnpka1RIcVBjOVZ2T1huTVp2ajJXdkdXeDlabWZtRWQ2dUtOUk1Z?=
 =?utf-8?B?LzU4Rkx6dUkwSkM4c3Y0SG5UQVpPL3Q3c0tjbmRqcG9DcHM0RjI0T1E2S0lS?=
 =?utf-8?B?ZllISmFLSWtVTHZjemlFcVRIZkVXLzBTd3NxUVBieGptTVIvNGF5b2J6MHIx?=
 =?utf-8?B?OWZKOG8yUVhLWk5uTlEyblhzR2Z3PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36eb6ad-fa58-458b-ef85-08d9f58098af
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 21:24:51.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFvfBXlglyk0AiZtgp+AnK9ZHx3IAHs6wWa+LcABQgAUXQRpTEEs0eWORE8SdQ28eglNnS/Cp3ypBuoeDUtSk8vl1ft8uceA+4oE1hl9Rmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB4635
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Mon, Feb 21, 2022 at 08:16:15AM -0800, Guenter Roeck napisał(a):
>>I still thing we should have the same format here and in tmp421, for
>>consistency. If use the same property name, "ti,n-factor" but on tmp421
>>you have use 32bit value while here you have to use 8bit (which is weird
>>in DT, BTW), it might be confusing.
>>Back when we did this for TMP421, there was some discussion and we
>>settled on this approach, why do it differently now?
>>
>
>I seem to recall from that discussion that there was supposedly no way to
>express negative numbers in devicetree. Obviously that is incorrect.

Well, I would still argue it *is* correct. DT only support unsigned
numbers and, really, only 32 or 64 bit. See the chapter 2.2.4 Properties
in:
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4-rc1/devicetree-specification-v0.4-rc1.pdf

Devicetree also supports array of bytes, and this is how we get the
/bits/ magic but this is just a syntactic suggar. The same is true about
negative values. Just decompile your compiled DTB and you will see.
To put it in other words - DTS does support negative values, DTB don't.j

>In addition to that, I strongly suspect that the tmp421 code as written
>does not work. Its value range is specified as 0..255, but it is read with
>	err = of_property_read_s32(child, "ti,n-factor", &val);
>and range checked with
>	if (val > 127 || val < -128) {
>                dev_err(dev, "n-factor for channel %d invalid (%d)\n",
>                       i, val);
>                return -EINVAL;
>        }
>
>That just looks wrong. Either the value range is 0..255 and checked
>as 0 .. 255, or it is -128 .. 127 and must be both checked and specified
>accordingly. This made me look into the code and I found how negative
>numbers are supposed to be handled.

It worked for me when I tested that. I could redo the test, if you are
unsure. The code also looks good to me. I wasn't convinced for this
format in yaml but after the whole discussion we had, we settled on
that, with Robs blessing :)

Here's the actual discussion where all this was considered:
https://patchwork.kernel.org/project/linux-hwmon/patch/3ff7b4cc57dab2073fa091072366c1e524631729.1632984254.git.krzysztof.adamski@nokia.com/

I'm not saying the way we do this for tmp421 is better or even right,
all I say is that it would make sense to be consistent and not redo this
discussion every time we have this problem.

Krzysztof
