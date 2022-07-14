Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277E6575406
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiGNR1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGNR12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:27:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2042.outbound.protection.outlook.com [40.92.42.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79573599D9;
        Thu, 14 Jul 2022 10:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZXkdJOubdXjG21vwIDQx+4UYSmM+8Wzq1NvZM1hSTFgrm+PsG1EKKSa0jPKsDjZTc0rSW9Eb9Qu+7oF0eDOS/59QrFMPDwF/zgcqAY+ixLHucwyedO3r41meVwHfgPRE0iAJvdktQpuHNIMfEFSyaf4nkzMRdXri9AwnUHnLiWUS5mj7fKf9w8YxP7R0LOVXKVDH9mFUfubZjwSKeZRa5lskZT9Ro1SDIyXA45kx83F+9/vdmKhX5lYCHSoCS+Isrva3x4c9OGvb0RI6eFPG/pH9wGSVXj7zUWruB7lbnYlNHILyBjn8M3C2K6zvf4TQlLteYwh6Ge23Jk3OdnPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMsqdZGWtNHrJ7HAQ7/OXzWTZfzSCEnbXJKz/b5LFTA=;
 b=mV50t43K50pI+KfbyAjxADDG6qwxukrrlYdMaeaAxSmSwTUEVzqkJwQt+KcUOnOgiUfMyGvxNw/qb75ivXFAnDLJOgisfDTkyZUOuZxwiJyuOXrbo0CbgLPaJl+Ydowa1Lmxvrv+4rbnTepPRyomAl6HTehTOhnhg2G5s4CNXBElhoz75ijLz77yOo11oJsDe+T5imTio6/+4Jr/0JQKaxbzX3l/RdWQA+xaeP56RakEHCN8EiASI26MYns44ggkWEfjcCC3P0UiDs9TegZ2anDTD4rSXxblY/ylPHDNX6lbaAefAN0OJi63mjiF0LkXd7j/B2sUeh43TKE823UP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMsqdZGWtNHrJ7HAQ7/OXzWTZfzSCEnbXJKz/b5LFTA=;
 b=c1QNgHkQrxo2i2PIySrAzudSoT8gZg/JQ3c61FB2xnEHDxEOZJePlcDhHYTXNdaYFF76p9sPUWHrIZvm8xtQ1uETTxQj5VKsV0VYVx6igCGxLWtiCBQnAElvVUG7lV7wnOSuGoXwv+2Lg7/6D15d1CxNKj2TPKcgx3epirhM+Zqp0UqT0dtgB65/GgX0vS+E1lWe5ESCQaxwhRnL5n6dy5CxjVfR+GSMyatgJvqmOXO37alv3MHIt5HckuBuNwpXhlB5w7uW1TS8qisNgR2Igc9GvcBFiuiYZv5f6pP7+TxrQdG96E5Jevdhe6A7aBpkOXXudcqk9BwpusHxCdOizg==
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by BL0PR02MB3891.namprd02.prod.outlook.com (2603:10b6:207:49::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Thu, 14 Jul
 2022 17:27:20 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 17:27:20 +0000
Message-ID: <BY5PR02MB7009FC653B20D32E8A17C3C1EA889@BY5PR02MB7009.namprd02.prod.outlook.com>
Date:   Thu, 14 Jul 2022 22:57:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 1/5] arm64: dts: sdm845-xiaomi-beryllium: rename
 beryllium.dts into beryllium-common.dtsi
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joel Selvaraj <jo@jsfamily.in>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220708111207.85249-1-jo@jsfamily.in>
 <MN2PR02MB7024359650A02554EF6ABEA5D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
 <Ys8wmeMYnKFa9Iqv@builder.lan>
Content-Language: en-US
From:   Joel Selvaraj <joel.selvaraj@outlook.com>
In-Reply-To: <Ys8wmeMYnKFa9Iqv@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [Yxp5tcZ1U60EsGVGHEgLJy8dgLVHpVfg51of2BknxxjkHB7p6dt2PLOBxLMRZGXV]
X-ClientProxiedBy: PN0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::14) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <029325b3-59c2-9f64-ae99-08b7a3dd8fb0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d393cc1-e3a8-4544-850c-08da65be1b27
X-MS-TrafficTypeDiagnostic: BL0PR02MB3891:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V80pDeSXDaBJaO5xlV+JSgL+69dZ1/7L1TIBvDjd0ShB+CCOv+oPQrkTz/0v11JArQuVm/d4nqkyC2KOosSeNblcCyt3KWEiUfrVjnU9YLZHakDvff4ha/i7JbJwHlzGg8g8SXNVsok3oEpFxBXwXPp7ItzcyEnkWE1ymu6kVpwFSG02/VCBY56zaynRO4B3Konu14N1tho/mDpyeju44GOssG5ls0alq7Uf5YYT2aCAlQXbnjvMkuXlsTEadndViIRHN/LVWsJJlWk5prOP1CN/STdlQAzNiBDsbgmtWSEwSpAiz5j+1dcQ6XPbNYIgln819qaObQCbHeNMns01sJ15bl3cMGauC3dE3ocPbUHpq0yFMC4hybjkz7yPdhweAiW2SBS8MEWSNuANJVklfWzNqri2JohdFRzbzk0VbEAZpgKlYJGcMwONPyIEI/CpXjeTTTFSYZ7IIcqXn5Vj+4SQPunTHJW6lqMbiGkqSNSlA3WiwhOy7LwM2THT3Q3B83iBQrqERCTcLfRCQuXQ7aucyCLVXSTmxFeinJDIrxqzznA5IG917J9zFFMEQ+r+59ffi8YLh0e3DkyFOlYTEF1OTtSlLPzHbUF5e1aYDIOrew03Npq4YaT+v0gnvE4W0B/llLudhbkSbmlno4uNxYyilihE8KpPVVbGsUNbwAlJORMdI3UvT0Ww0QExiOvncbueo6dJooA1ZUn38txJSEQ90HlG9x0SNr7hkzsl/3Q=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDlLTW1VdDJHbWpja04xNEQ4cm94TU1tcXpOSDR1OXM2bTF6aWYzVGZzTHBR?=
 =?utf-8?B?U0dFN2lZb3hmdFZQdVBlNCsvUVNITXhlMHN3d1hBQjdmSkNlRXNiWEx2UjdV?=
 =?utf-8?B?c3Y4WE1OZXYrWXU5cnZrK1ordnZuVWY4MVdPcDBSOUQ3bUs0WnNYd3VubTk3?=
 =?utf-8?B?b0tuSVIwVTR2cDd2VG13akE2bHM0aDUxYk1XOGxDRUZvc2dsTk82TGJEN20v?=
 =?utf-8?B?c3ZHbGdRWVFNYXJXZVZKM0liYTJzNldaUVF5SW02bVJvaW1iMHZ2Q1MyRU0v?=
 =?utf-8?B?bnNZYnBBUmdkbXRsaWFTckZlUDZSMUNYdFlWM3BISUNxbVlWMWs3RUFRMUxQ?=
 =?utf-8?B?S2J6V0I2VkJFTFZrZm4vRHhXdU9IL2ZxcGpQOFVyY3BkVHVSZ1dkc2RpbmE5?=
 =?utf-8?B?K1lLMk1naDAyOVNybm9VWnVJTDVUMDZTQ2dveXZNUXRMd1VVdXg1QzNkdEVQ?=
 =?utf-8?B?TW5LOHMwTStTdjdJSDdGWHRCaXhobkxqeE96R3lCYjhOZ0NIc0EyNlpjRUta?=
 =?utf-8?B?ajJGUTJkVXdhYzNQWjRPejU0QjhwZHNGUitHWnAzNTVjRXJMWG9zOC94Z3h6?=
 =?utf-8?B?TSs0aklVYVFQYit5cjhlUENCc24wYWlyOEt5Q1p1Qjd3b0FkS1BOWjUwQTZ1?=
 =?utf-8?B?VWxXSFM0bExYcGxkWFFycW5PclE2SzBoVURYcXA3UGV3bUxYWFdYQTh3OGpQ?=
 =?utf-8?B?SU45Rks0MkVDVkdtbG5KYVVwVnRSM3o2WUs3bC9qaU94Z00vYlhKVHlqUzhp?=
 =?utf-8?B?ekpzLzNrcHhWNjBROTZScWJyM1ByS2daa0dYNVg1LzVqeUhudmFtUTg3aTBP?=
 =?utf-8?B?Q3oyK0IvRElubjJZSWVueW9OUStGRUF2U1V2VmJ5Z1RPNDJObjhBSG02dVht?=
 =?utf-8?B?VmxYMy9mQWpOaGdiQmZTTDhEdWFDOUxFakFReGpmOVI4S3FSQkh1UnRlQjk1?=
 =?utf-8?B?cE5TRlJoYVVvYUw0SHAxcVZrV0xuNzh4eGozeUN1ODdiM1RLVWxmSWJIRGVC?=
 =?utf-8?B?VkhSRjhrNm5ZNXlSeTIvbWtpbFJqWHZwekFSNURienpicTBRNG1wbjhoYnAx?=
 =?utf-8?B?aFlucTZ6VnBqRWNMbS9XekpXaDEwLzF4S2xobWxOak5sMExsclpiNnRlMURo?=
 =?utf-8?B?NEtvMGNVZEZGbVJrTUdUZ2h0U29LMHhGbG11TTRZWnBVWUtabmExcjVwSFdm?=
 =?utf-8?B?T3NZeWxVZmp0WmFKemVMRlFjZ2dLYlY3Qy9VbUdMMXViUG9TWUoyMHNzS005?=
 =?utf-8?B?SjR6SEZRZnNhUTRRYlorWHdFbXhrbGx0T2pOSjZ3cUx1OUZzeURwL1ZlR1Ft?=
 =?utf-8?B?L0hSK1F0bFFNZWZEUFJOcVJyUWpSNDJHdnBydWdGMEhtSkx4ampocjF0dHBx?=
 =?utf-8?B?bDJlaWZ6RlFxeU90V3FhemczcTVhY0hXSUljMGJibDFrUmR0Q2kyUldRRGxy?=
 =?utf-8?B?ZkN5VTlXQ0RvOXNaYU5SanVaWktwaU1NOVNSWnIrMldST2RkVEZwemJTM0ZK?=
 =?utf-8?B?Y1FieUFTVHh6L0o5RFAzYnRSZTNnRld5VWNnbUhMcDl3L0FrdkhqREFGc1Yr?=
 =?utf-8?B?Y2QrWlNmMFlpOUc2aVJ6aUZHL1E4SUg1T0NNeER1K05rcjBOZjJUaVFUV0Qw?=
 =?utf-8?B?Q1VNUk5HdW1rc1crczF5dE1KM292T2I2YXJwK3E4QXJtQXpqSUI1REY3UE4x?=
 =?utf-8?B?TnlaMll1VjAvWjFvQnNHSE5Oa0t2UU1ZZCtyRUJtemp5UkFuOVF3ZkdBTEpK?=
 =?utf-8?B?ZDRaL2hUS2gvaDJQUDZEYU8vWDVzOEVYWkh5RkdOU1FUc1c1ejRteEhObEFI?=
 =?utf-8?B?aUR4OWJNM25tWmd1blR1UT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d393cc1-e3a8-4544-850c-08da65be1b27
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 17:27:20.6204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3891
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn Andersson

On 14/07/22 02:22, Bjorn Andersson wrote:
> Applying this patch would cause the tree to fail to build until the last
> patch is introduced. This would cause problems for people trying to use
> git bisect to find regressions in the git history.
> 
> Could you please respin this patch such that it continues to build the
> currently supported board and then you could add the new board/variant
> in a separate commit.

Ok. Understood. But I am not entirely sure how I implement this? Since
except for display and touchscreen, everything is almost the same. So I
wanted to move the common bits to a common dtsi. Here is the cover
letter where I explain a bit on the situation, if it's missed and not
noticed.

Link:
https://lore.kernel.org/r/MN2PR02MB702415D7BF12B7B7A41B2D38D9829@MN2PR02MB7024.namprd02.prod.outlook.com/

Here are few things I think I can do, kindly let me know which seems
more ideal.

1. Don't create a common dtsi and leave the existing dts as it is and
just create a new dts for the new variant.
sdm845-xiaomi-beryllium.dts - untouched. represents tianma variant.
sdm845-xiaomi-beryllium-ebbg.dts - new dts, represents ebbg variant.

2. Create new common dtsi file and move all the common bits to it. Then
create new dts for ebbg variant.
sdm845-xiaomi-beryllium-common.dtsi - new, has the common bits
sdm845-xiaomi-beryllium.dts - use common dtsi, represent tianma model
sdm845-xiaomi-beryllium-ebbg.dts - new, use common dtsi, represent ebbg
variant.

These two approaches keep the existing dts valid even after the patch
and doesn't break build. But I wish I could rename the existing dts to
sdm845-xiaomi-beryllium-tianma.dts as its more appropriate. So I can do
something like:

3. Create new common dtsi, create new tianma variant dts, create new
ebbg variant dts. Finally, when changing the Makefile, delete the old
sdm845-xiaomi-beryllium.dts. We can explain in this commit, that it has
been renamed. This way, if someone git bisect, it can point to this
exact commit where it breaks and know that a rename has happened.

Kindly help me choosing an ideal approach or suggest a better approach.

> Regards,
> Bjorn

Regards,
Joel Selvaraj
