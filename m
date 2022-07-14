Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECAB575262
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiGNQER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbiGNQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:04:12 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70107.outbound.protection.outlook.com [40.107.7.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D912A92;
        Thu, 14 Jul 2022 09:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbETKArh8rEU4xWyNTd8vygK14mK8c5t85ra6sm0cXaUDtAfXEGShQ8BTmQl96JGgmLZhd8kEfGl8SElpij2LlO7XRIYKe3mvwolPo5hs+xW8OU2LVTsur78o2q+aNr4GivpXgvSxL/cJDXg+uhHQlsyX2U1ygm/4FscAzfUmk3z/x0ivLcn/Ho6oT5H+Pv+X0K8vqMtpWk/ep7FOxaOvggtT68LhOkijqAlSrstqWofd2CiAHvRXa07BDdDYpibSueNTEbqtRgR2H65rv6nEc3Bl//NnZAInQtD21jM9F6IA+aogcVcChKxFcAG6JtWTRcKkCjNdg6bXmuJJ1+NOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCZtEb4DsASEQ/QNWy3OVxOSff9qdGC8BOnIW+8nrgM=;
 b=NWs5RHgFyPod3oOyrBFT5nlDilYfB4i6iGyjhSqErMSsFti4mWthq8Nd88c39ktRa0lVG7aLMinMvCri1/YAQJM2mu3D7qo8xrpSVD+gvAQ7fqj6tEJ0rj9La8OeMvvjYZQtp6nmNXygYPScxhJJFr4+gz4fspGxhhlMlvnebmgkRltxMY9i1GrChB6RTBxwLGDnuCM1K1+RmYD0EDR8wQlT+tA42FxZE63cxAG8zg5LZUnR88S/66oduvcKHhXleksY0hg2/hrF4VpCYqlZE3dYfTX8cVhxiQW0wQSBrwv9CL3XJgzsFoAAOxhzQzzjdusMbm4ZVNXPJQZJvlFA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCZtEb4DsASEQ/QNWy3OVxOSff9qdGC8BOnIW+8nrgM=;
 b=lPjiFhF70ppN5sswkLt9ikjllv+jZqlbRByBR/Am7A8mTuaaLSmN3r/UAhKok8S9PoT1nHh4cCbddRPnNDTDD55IX26YQwFRq5mIinF8iFojyP0z/6xEgyaUX5VFYbqzg9yzI1mIsynOYMnn9Edb8JeBZ2bP7T+hKOYix4RknQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::14)
 by AM0PR10MB1937.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 16:04:08 +0000
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d18:1684:44c9:8eff]) by AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d18:1684:44c9:8eff%3]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 16:04:08 +0000
Message-ID: <5a806f32-420d-82c3-9ca9-895abfbcc544@kontron.de>
Date:   Thu, 14 Jul 2022 18:04:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] arm64: dts: imx8mm-kontron: Adjust board and SoM
 model strings
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder@fris.de>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220713074118.14733-1-frieder@fris.de>
 <20220713074118.14733-2-frieder@fris.de>
 <CAOMZO5DCpxiYNXPOg+Cmc+6gBxZBp0oQ=wtGf14r8Y+_k1S2Sw@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOMZO5DCpxiYNXPOg+Cmc+6gBxZBp0oQ=wtGf14r8Y+_k1S2Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::14) To AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4f2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 807a4153-7859-434c-85ee-08da65b27b97
X-MS-TrafficTypeDiagnostic: AM0PR10MB1937:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4ozduTVvNbHFnICdasSWW4LBPv50PPJFA0SEwCDw2bSIjLe5xfAHKcz3ZV5m1E8Vc5vcqSkB0q+YF+ay8ikxHPO1+96/sX6xkX40H810SsN4QKTWVf1q40RnyBarjY2n9InBMUARKo1ACwdgalPy/9q93ePWkSYxvsGafwnv0/s1KshM5d1RdiuSD2Ep86d4/VkOXnyb3msMdAzjJxsSIwmOiajokF24Y9xqPhi9AG1k+hhLLxY8yr7snc1g3jUbkrKnbP+0n6nMgMkKyualWiCO+EdG6XGSDcDJ/P8G9NvbjkyFwbDdZaJ9lXBcb28UXggSIukPdi+pv9Fsl+fXT7K1wAtYweDO7JOCWXfvH4T/RKz0b4MfIq6qEcVBC8gF5LqkgTivHwu7Tz3ORoeiNPVqYUlfk+vvF8KBNi4XRWCSyU9z3TuSBjVYA2AX217c2nOoov1DfCtB6rT+l8aq5WX4dsfXwlX1BIOmmaTGVwzqJff0tm6+aHVrCcp71TKbAqhTklgi2Q38kVBRggdOgVDKutzk4I9Fqoxkt4LoB6Kq+crhpxw5KotYuxkLA1CR77LCtlIPgq+8hRuNAt3nvj0pGR7Gc/OmjaLJDeptVVJGB3yBSi+w586QBuJWqyme4vZmRo7putW3C9UbZFHAKTDI1/Eh98dmnkpFX36BBs3vV3rPxNXst/n2Eygtfoooups5TP+nsjlegKnBtJn37KRdZv6NOZDdclzUFU3zbeh7UuPUpXmOa7cq9Vqxdv8qE/kI7IdpJsiF9+Nh1Ykd4VJ2N4CUvoycW7tIAzG38L6sd6n7JNQWzouq4inP73IWkysFCdLid56WDiLMpbRd4WRMfYhY9b/S42A59HYnndumTs0lx2uZUovRqMgmg+rk5WaRQzg0/i+EPrU549PcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(83380400001)(7416002)(66556008)(8676002)(2616005)(4326008)(38100700002)(31696002)(66476007)(66946007)(186003)(86362001)(8936002)(110136005)(2906002)(6486002)(316002)(53546011)(478600001)(966005)(54906003)(5660300002)(41300700001)(36756003)(44832011)(6512007)(45080400002)(31686004)(6666004)(6506007)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enVVUDNnb0c2VjNDNmJEZkhnWjV2MGIyUm9HeDJlS1NZQ3RyeWV1c2I5WWNt?=
 =?utf-8?B?c09uOE5ZZGhCVmJ5dlEwNFhOV1dmNlE1VmRoQWd0aS8yTDRmTVZPM2Q5aHpE?=
 =?utf-8?B?N05wdGVJVThNMU9GTGhoaWhRN1hmaVNQb1RIeURJZGN5eHdwREN2OU9vUkg1?=
 =?utf-8?B?THkxdzVWZy9rZDVFaDVGeTRYejhERDhrZW82bmFsWXpIVks1R2phd1JmWkRw?=
 =?utf-8?B?YUpXNHdVSWEvYUhzUDRrWXlkbGdEZHg1cHpZamFrRGdxWmhCSjJickRQZDVj?=
 =?utf-8?B?cVJHTjI3L21aMlR2ZHI5SEdLaUlRdnZuYmo1OWppNWd0SWVxOXNLTGQwZFFv?=
 =?utf-8?B?K0NlUnVXMHdxVVgrZDR3T3l6cjI0UFhqaHdQbjB5WGFwTGFQRVVOc3JQblFD?=
 =?utf-8?B?TXBja1hEVnBGcStsZHFWSVZvOW5vVm9oNFpyUzNaaS9naVFudy9mUVZyYyt2?=
 =?utf-8?B?VEFBTVljVDRHSGh3RklLalVlNisvWWF2R0U5amlsTWp0Yzg5a3JvaWUwOWRK?=
 =?utf-8?B?SE42M3J3ZE9qMG1FVW9LOFFLbEFHWXNEaEE2ZTAvRWh2YzdxUlRsOGpJS2hS?=
 =?utf-8?B?WjYvLy9zRXkzLzNLK00yQThjVmhMQlNlaXBUcVBpYlp1ekpEdlNTb0RwUjhk?=
 =?utf-8?B?eEYzMzgxQ21ZeElaRnFMa3V5OVlsNlZxQ3Rna2I3RmR5WTlGd2tFMEhPSkZC?=
 =?utf-8?B?aUlZdlhnb2p6b3lZdlc5OEhubVc5cysvQk4zT014NUQzZzZqM3NNcjEyczgw?=
 =?utf-8?B?d3hlMURGeEl5NmZ1S3BRMHJURHhVTE5kRVFDbzdWYnBRTjZncWZmRHJVaWdp?=
 =?utf-8?B?Z21LWnFEUENFSlI1UGdKWjFFY2FjbnJGSXdXZTQxWjAwZmg2VTd4RkZZL3R6?=
 =?utf-8?B?TkhzSktBWG5Oa2RHdGcxdktLOFFpTkNqUDlMODlIRWJtU2hweXpRckZta21M?=
 =?utf-8?B?T1pIZUxaUWZsUkthbE5WeXhrNjJJcnBsTmhlUm9XQjRrOGc4ZDBFR2dCOFJ6?=
 =?utf-8?B?SXRvWCtWZ0s2UVZrdkdKaFZwREtScFBmdTE1OStTcWJHR1dVWmF3SlBueDZ3?=
 =?utf-8?B?cDhXUTh2TDcrRVBIV0JSQjNuSUIwZFJlYkw5dlp1STVWYW5aU3NNTUg2WnlR?=
 =?utf-8?B?WERpSmZ2ZnRtdkRMcm1Kd2QrUDhFRHVxOERneHRnUXNaYUNLemlyL2JqaGY4?=
 =?utf-8?B?Ris5SWRNZHQ3eWhUOEZpTjdEYXpqQmlIZHJzL2RjYTRvZDFMN2UyV1VnOUwz?=
 =?utf-8?B?MUtUYVdBNVlScmFHU3FZdnpEaE1MMlJOaWtwRWJiakF4QmV6ckxiTFBTODR3?=
 =?utf-8?B?T2ovYUc1RFRuclRyckpOblJjTkdZQnRZU295ZW41bXlWRjVZRmhtbndxQkNt?=
 =?utf-8?B?UCs0b3pmSDFNL2tjeGdpRHg3NVNRTEU3TkJST2dFeE5BNkNVM29Xek9xTXZI?=
 =?utf-8?B?WFhQd3JFc0s1NHVUbkpFWW80YlJ3U2lLU1krNFd6SFlsSU5FWW1VSWM5QzdC?=
 =?utf-8?B?NjNiL3IwZENNRFFzaTYraHNyVGk0ZkM5a05rdVY2MFpIRGNhM0F0Z1RqN1pK?=
 =?utf-8?B?VUJIYTMzQU45WHBtQzU5anZrMXZoZFZKcFBXMFgwb3RFR3JwVWQyZDZqaGIw?=
 =?utf-8?B?bk9tS2cxbjh1MFZQdTBUWHJnYk9wVVhnZEMwVzRud3R1M1N4QWtKTTRXcmx1?=
 =?utf-8?B?dkZxSGQyM0xqSGFOZEswM3N3Q2R6ay9zdC9odm85b2lpd3NSNjMwTFc5UlBF?=
 =?utf-8?B?Tm1qdDF6QjdJdzVzRnl5ZEUwbEl6SS92MUM5cW5laUV5emkzQk15bkZoc2lS?=
 =?utf-8?B?aGpXVkV5Zm9QWlBRVGVCVDNkWGt5aHBpS001VklpcnREQ09Lb1g4Zk9aME9O?=
 =?utf-8?B?Uit6bjFzSWl0QzY2UGJLQ0twNDZWUngvRXA3TndkN3pJZ1JmcFYrR0xXdWJ3?=
 =?utf-8?B?ZGhhNlZZaDIweTl3MEJXVTVYd0U0TUd5Z283WUVadmtVcEJxR0dRWjdqTFVl?=
 =?utf-8?B?VVh3V0p4QUQ4SzM4cEYxU2svUlNxWXpLQ2xqN2tYTVZvZS9WMEpmNjVsMVNV?=
 =?utf-8?B?cXhWRTRxRW0vSjB2QmoyNFhYMFFMTkIrRGFIMGdJY1lNcFZlZHRjU3ZzRERE?=
 =?utf-8?B?M2J2YUd5bmtUSVBMT0orN0hKblU4WnRoZHFDQ1lIRkUxaUhudDY5TnlmY0o1?=
 =?utf-8?B?ajErL29WRHVCNzlaS0JKOVBHYWdNWms5NE1zK1FidkV3ZUdxLzhGUGpxYkkw?=
 =?utf-8?Q?a+HPcC+HqaILoHrJm4lu4IpCB3Ov8a7BYp92vLkWp0=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 807a4153-7859-434c-85ee-08da65b27b97
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 16:04:08.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+mwK673fh+Pj15JNS9/VYbY6zLLE3HPg5pKe4p9fhQWb3MZxs9aKtToQR3h2jC7EqcAi2dAOJpvvOZW9bjBbaI0pOXffO8SiE0y/cIf+Hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1937
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.07.22 um 17:53 schrieb Fabio Estevam:
> Hi Frieder,
> 
> On Wed, Jul 13, 2022 at 4:41 AM Frieder Schrempf <frieder@fris.de> wrote:
>>
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The official naming includes "SL" (SoM-Line) or "BL" (Board-Line).
>> The legacy identifiers are kept in brackets and are still used in
>> file names and compatible strings.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The series looks good, but I cannot find patch 6/6 in my Inbox, nor in:
> https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-arm-kernel%2F20220713074118.14733-1-frieder%40fris.de%2F&amp;data=05%7C01%7Cfrieder.schrempf%40kontron.de%7C709a770b51c5406920bb08da65b0fbe4%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637934108060565672%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=X2I7oQ9P1nDjB9VIGImp6G5%2F92u9b3dkLv1EQfKCjwk%3D&amp;reserved=0

As patch 6 only covers the bindings, get_maintainer.pl didn't add you or
the linux-arm-kernel list on CC. You can find the patch on the
devicetree list or on the devicetree patchwork:
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220713074118.14733-7-frieder@fris.de/.

I will add you to the recipients for the next iteration.
