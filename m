Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C377C4D2767
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiCIDco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiCIDcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:32:41 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2068.outbound.protection.outlook.com [40.107.255.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141F15C653;
        Tue,  8 Mar 2022 19:31:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHbgYvOdYBii/ZqsLBrqTUvfANO8LQGqtnKSUTBgdgEQQd85x9LGNQHK2/BSArMu2Mk8DGtthCDvQUJ0wuP/99fn6nNlfuCEhfxRC0Qseb9omYZVIFdIDDS0VW0fw3kEzTtJ9nPwUaVp4lT1JXkFqEor4x8c4daJtrvKBJF0/fhwzXPv46UES/kTGfz0A4j1I+R03khNJ1xWMpIHYV1YAn3WIUYeHv//+F0vrPkGDt5A2n4o0v07XalrD8maUVg8Zh0NhPzqFimClE6am/BjYQIwoKk/Ugf7G8UGwBgMet2sXZuify6/IhOTC/GpzNK6qanVcs83tmMjA/23oUrDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2DwHTCjn1Eqv+FZnvcLKABblAIc69xNpmxwjZSgY60=;
 b=QZN6dly1s/B2HIRpOKUHACztaR+BRdgDolwY6QCoPTQmI/tnA5V2uNrHDbz6xVm90ZWGvy18eAz6uJum++jujcQSxLvCWvzctM7wVeBYvVCBaEBe17qEx+acFNe/s7jpN7adyCNCs07sP2hNM8zyauJJb0mUUIMtCOMphtpR7K7sep1j4d7Ke/O3706cqklkgMiLeBSF/dfRdgJ2uIwyJFwN/l/JamTU7dYZuWHW7zhbhazJm3ihjXIbaf6XzxPJySavLZ5Y3ZNS3AFi9CKNwH0M+iYsdVaij6vTrR0DV60rNAqb83arhnCBGaDrjQ5fxcV35o7MahEC2C6+y45JDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2DwHTCjn1Eqv+FZnvcLKABblAIc69xNpmxwjZSgY60=;
 b=rgKWE+7x6Rz7JhnBKNay5SG8X7qH9bgrjd0WImaH7EniWvkFT8dCm41WEcVnTHILS0Jf9PUACNPA8MFH/WSe4qCmMK/dyXXyI1LRbAUdxuZuBn6SQhP2Jj+sEAK9KvvEb928CycdnRheybYKhk6jl9LweDlLu64ath3BCaeSqqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com (2603:1096:203:b1::19)
 by TYZPR03MB5391.apcprd03.prod.outlook.com (2603:1096:400:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.3; Wed, 9 Mar
 2022 03:31:38 +0000
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e]) by HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e%3]) with mapi id 15.20.5061.019; Wed, 9 Mar 2022
 03:31:38 +0000
Message-ID: <559dfe1d-0f0b-c278-521b-c4f852207e76@nuvoton.com>
Date:   Wed, 9 Mar 2022 11:31:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/3] dt-bindings: clock: Document MA35D1 clock controller
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        olof@lixom.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
 <20220307091923.9909-3-ychuang3@nuvoton.com>
 <1646701660.895821.3624783.nullmailer@robh.at.kernel.org>
From:   MS10 YCHuang3 <ychuang3@nuvoton.com>
In-Reply-To: <1646701660.895821.3624783.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To HK0PR03MB4833.apcprd03.prod.outlook.com
 (2603:1096:203:b1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf977ef3-3543-49d8-f364-08da017d51a7
X-MS-TrafficTypeDiagnostic: TYZPR03MB5391:EE_
X-Microsoft-Antispam-PRVS: <TYZPR03MB5391AA6B0404148A5818FFAB9E0A9@TYZPR03MB5391.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: St61Cec0bkd1+huCYb9bN6lztxcMxleOz4IoLQitwrXui2kOh7tNd7cV8NRB/JHlqif3TzJZKnK+yEvs0FfWNU7Gq/dDOu8zLcpsbhbJ2fIj7z1lmpJOA/+QlaMvVwAAIDfb59orEHvtnOsdHkwcl2JM2YSafT+ziCy2nGycsv4L1GlLj/PuCvXYLUtHND98uY+ftLGfQBoKCvh9RAKfd2sKUTpx5ebyWIFuSgelWXUAPJzfuWbMXiPxgNb7IT8TGob6KL2IHn7OiKi6jEHc+lDxp0NMw+P2bihEKUrhI14opZrst8SPq/MkGPaQR92YlAfgfB0XN0I0KLsqM/OYd770hQDRdSxdI/0ARfpCv7DMCmoHSpqeDr5a3IH92SOn9DpG/WHyBZfDatf5U8FVHgdARUI2RCNuwfLR/4tmlt2RjzmCCzWU1DuccaxQvBCNbpciZ3VnGEtToP3gqZa7fq/+po0AoK2Ay5jGAWu/0t5bH5GBfY0F4y4XEL9MMbagVSPP32ZUlqCltvX9mHwWBnn9UfmgqqUf76TpUCmiZtCBVD9Y8Gmd1M25Ib9gt5POiWhB7dzOdQaP4o921bdmzUvT0H8l0kDGwQu+IsnqMoUnNfJFXkCZBkAtjz32S09fLxR1S8DlOre/CLHIxLquUn1eVKPZvac3aW/JCnEkuwPVLHpelvh4XQNzS8Cq98roCI9MC9TvST4G6E1PWLo59vW9okKkFRhc/tWrsZy7HTnPfsPZvxXoJjYWAYILAZNxNMiUm9mYz77BBaISpAT6+aVHoYt8wcyL88OD1y6oK2ucigzr10nuulJtPFcRx+HDM/hhvPbo+LoWf/ynfG1PnaNAzAno63iM1UU1SCmLiRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB4833.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(36756003)(26005)(6506007)(186003)(2906002)(31686004)(83380400001)(52116002)(508600001)(6486002)(966005)(31696002)(5660300002)(86362001)(7416002)(66556008)(2616005)(66946007)(66476007)(316002)(4326008)(8936002)(6512007)(8676002)(38350700002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmMycm9Ma3ZGRmtBKzFoZllMRUFSSjh3UUowWU9hTlR2dHpyamJjQjIvV2Z6?=
 =?utf-8?B?aGs2V3lZcVpWcjU3YWhiZzZnSjdBZWtaeUZQMlNYUmRWNEhmRW5RY01XQ2lt?=
 =?utf-8?B?Q3Q2QUpXV0JJZ0l2SWFyVWhpZ3lTZ0puOWVIZ1FMVEY0YUplbWdzZkpqQTFN?=
 =?utf-8?B?azBTQ3FSZW5HbWhFYWJKVnVubjNid3ZUNVVkbVpDOUpZM1BHNk11dVFqSzFN?=
 =?utf-8?B?RnNBc215R3AzWU1IUmdsYzIxZVdla3V1Rkw5aHF2cjU5TUpjdCtNLzg1VUJt?=
 =?utf-8?B?L0EzK094eExrRVRvaWRJWlFZZjJDMThXeExNY2hzWUE4T1I0NlRVczZnVHJy?=
 =?utf-8?B?SGZGOCtGc21FeTBFUW1lOXkybjFQZStQY1ZsaG5zRGFNZXFkVmE0NFBodlVm?=
 =?utf-8?B?NDV3VUt2WGRJR25mRlltT1ZOWnBWcUVNVVVDdk5QZW9uS21lMVdFRXcybmJJ?=
 =?utf-8?B?ZUs5ejdGTjdoYURaTVJiL0l5VVVEV1laOGNGVVJRdEJ1K3lqM1JMekFoMWY1?=
 =?utf-8?B?K2FNVFltdlRMendOOGZ4ZHhSWHh1WG5lL1dUSWRzS0tpOVBSTU85dk1kbjR6?=
 =?utf-8?B?NlBHMVhrSThHa1h3eDhEMkEvU0JrNFBlRzhnOWhGb0g1aE5HK0tCck5HVlph?=
 =?utf-8?B?eEI4M1REY28wdTdoQ3BRd2JlczluTGNKNzFSVzBSNmpvOE5Ka3V5MkR2L3Y4?=
 =?utf-8?B?OE5GL0xVUDZXWGtTTitvaXNIbWhSVWxRV0dyR2xNeXdBUGFrTXJHTXE1MTZF?=
 =?utf-8?B?aUVHUkpidFNldG03MVEzSkwwbWNsREZqRjRVZUJmTUlFWkQxZmVoSTdTc2d1?=
 =?utf-8?B?RmRxUVRuQmZtczQxNnhHTEI1RTVnQURSWTlVYStKQUYzYmV5Z21lZjJTWUxt?=
 =?utf-8?B?amNZNWMyd1pRS1p0T3g2Ym9vWWFIVWJzOFFlSW1sMnZWYzd5ZXFRYTBnQzBs?=
 =?utf-8?B?RUpZRWI1K0NWNjFZVVhtWDV5cW1YTEVJMTNORXR4OFB6R1hMNmhFOWFvQy9P?=
 =?utf-8?B?K3JMVDR3SDlQRlllRHNEMjk3TFpUYlBldndlcWhwcjFsSnpmV2JPam5WNkRY?=
 =?utf-8?B?cXVyZEd4L2RUdkVkNkdOdzdUb0FRNmRTSnFSbDhsZkkyTndObEhZbERpRkV2?=
 =?utf-8?B?VXlUNDlZRTlVeHFRaUJHdkN5c3dwaExuWG9wOXY0Z242dDZmbk16a3g5TFdO?=
 =?utf-8?B?c1VpdnJXb29KQ3RrcDVUMnUxNDhlNCtwb29pSUtEdU9sdnRjZm03R1dscllW?=
 =?utf-8?B?dmhKNWFOWnRxWnU5NGRrT0VKU2hGbitwR3NlMFNLNHA3OTZZeWE5dWlwSXJE?=
 =?utf-8?B?OHI2di9aWm5uWGQ1U0FMT1BtaTV3QmtJdS9iY1Yza01wYkxwdEtEVDVCWFMr?=
 =?utf-8?B?UVp2b3RaVkZoQUlYWWFUbXpTRzhpTzk4NjEycEZ4TXM3a1kvQWNBRkw0ZzhE?=
 =?utf-8?B?SmMxOFBUdWVtazZIQlJ4SzEyd3JKcXNta0N5ZS82NWw3bVkvaFFUUkVGUkNt?=
 =?utf-8?B?aTI0cDZmNGs1dzY5dkhPUVEzMXlJMU9LQ0daakMyT3BkTktoMTB2eXY1WGJH?=
 =?utf-8?B?eE5rMlVkZ1l5SGZYZUVKYzZibGl4NjRjb3BuMzB3eDlqcElqYmRQTVdmc0RG?=
 =?utf-8?B?b2kzaGJuekpvWEIzckxTVnVBT2JFbmVISDVtK3R2OEY1dlpyN3AzYUNURnRT?=
 =?utf-8?B?ZGh0N3lIaUJXZ1FpV2lkRW5jS2VxdHNFQ0JiLzN6MTdWMS9uSmg5OWZmSXVq?=
 =?utf-8?B?NnNmTWttMGtkSStZVXkzTnA5Q0laaGhoSkJpaGxYd1ZubEJlSVNEN1lUQ3Ni?=
 =?utf-8?B?eUU2Ly9zWldMQ1ZFc3lKRk5Wd29BZk5zTjNLSTMxRU5XalRQeEdrUUw0ZG5M?=
 =?utf-8?B?bHJsY0t1d3NmZnEvNU1DMjdqdGhVLytieVdOUjA0SHVZMTJwbldzQ3U1Vndw?=
 =?utf-8?B?KzBIYWVpcjNSeUZBTEFrcVZBZUxtdDdnZU55Ky83T3ozZGIyZ3QrNDgwNHBn?=
 =?utf-8?B?QVFMQTJBYnJnPT0=?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf977ef3-3543-49d8-f364-08da017d51a7
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4833.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:31:38.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/yST6R/Hoy39wC+9C9CJEVVraVlCcDA39ra1ALsIO4RFxV2dwDID0CLuI4tNVcqrSiz5RPo5kBiZJL37MJjYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5391
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/8 =E4=B8=8A=E5=8D=88 09:07, Rob Herring wrote:
> On Mon, 07 Mar 2022 17:19:22 +0800, Jacky Huang wrote:
>> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 66 +++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma3=
5d1-clk.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cloc=
k/nuvoton,ma35d1-clk.yaml: properties: 'clocks' is a dependency of 'assigne=
d-clocks'
>       from schema $id: http://devicetree.org/meta-schemas/clocks.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cloc=
k/nuvoton,ma35d1-clk.yaml: ignoring, error in schema: properties
> Error: Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.example=
.dts:24.37-38 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings=
/clock/nuvoton,ma35d1-clk.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1398: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1601972
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.

Hi Rob,

Thanks for your review and guidance.

I will run the check script and fix errors before re-submit.


Best Regards,

Jacky

>
________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.
