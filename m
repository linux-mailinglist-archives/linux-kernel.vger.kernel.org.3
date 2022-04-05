Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB94F4B9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575331AbiDEXDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452288AbiDEPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:54:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8382812ADD;
        Tue,  5 Apr 2022 07:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3i3w9lXfTh21+2aVU3FjF2FwHOzJgwuqxbo28sg44D/jyHoURdzypQGiNw/pXCO+28gRHqoEiDQYYF59Pfw7xiwSgRmkVqf2zDvZ4rd5Yyec7hY+YoOgWmLUXhySMlAMbimAL20uRA6nnwb1FEqCs4WvK2S1mcLnGmWn3osMCBZPMz/I7wS2SGTpc9rMkdywL9TvXMAQOxcLL2gjoYNqVBweiWzBI7oQ+F4P+42/ZcqIOE76uKkTBw+W5GDKXO/KZDzKYQosvDvOcurWoobk/V29/Ha1/3keUvDLdiO0p4/TIh4WO8/SwcgKZ1L2SyHXV3xhihgRC2/tkBZv1dyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsYupKu2aWZqZ4cS+o7TMjqusw1mLKFK2UeLzTfjeJk=;
 b=iGrVBLFOH+C2XwgsAPqN4ng6Jkri8lCiAin05rRpgf7j5ZbmDFzHKXWSkQLFWI1BFp2RhlwRADJD9U6h4W3IjtN9ZUppNEVgWNRzeE8oGNPlbDSHR4stQQuEq0TZkcqJMvfnA8vvI4+6lEc0Dn5MV+uatDuVCaFNa7V4rmYz0GRn6Q0Fom+ZEvEs8Ri5uo5Luljoey7aYUCqQRZ+7Bq3lXCdW2AjvEUsabqGIDga1EHtC1+UFLoAlI0wscJLfmhqrCT6SkNIGPMFFjkDVW796bDTOtdLzAMrXK2I3BiebVWwh8hvwbptnIpKInWwo/NM7izsAY0cbUcP/7aZPgmduw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsYupKu2aWZqZ4cS+o7TMjqusw1mLKFK2UeLzTfjeJk=;
 b=r51nuTDemzvDtqBVSs/vQVa9Ghc9VUVgkIgOSmfaBaPadOwQ4CmNHWf1RIf9Dy/q07tbs8IJF2YtpUkugHE7K9LaXBy1FR1qrPZnGCURi4oN6MHWCJnwBixVZ1pxrXxWDgAG0pVpbb0XCep56WVJ/sk1iRggA8JkMHC7crn+4by9tqKFnqkFwTlnjSmG92tdsYi4awZa5jNsJhOz0BYKloJS6H3xSCEAGMFQ1YNC5Xt3E8Cav7GmN3BUC+U66gJWjW8FJo7J+roIle2u8TksP+td2LtYDpoCOv3eSb2HBuyE4EaGvds92CrwCah5H1NyrZIcJ/Dns8z+/it/STsbUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from VI1PR03MB4973.eurprd03.prod.outlook.com (2603:10a6:803:c5::12)
 by VI1PR03MB6207.eurprd03.prod.outlook.com (2603:10a6:800:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 14:51:40 +0000
Received: from VI1PR03MB4973.eurprd03.prod.outlook.com
 ([fe80::2ca2:213d:e44b:cf71]) by VI1PR03MB4973.eurprd03.prod.outlook.com
 ([fe80::2ca2:213d:e44b:cf71%7]) with mapi id 15.20.5123.030; Tue, 5 Apr 2022
 14:51:40 +0000
Subject: Re: [PATCH 0/4] usb: phy: generic: Support enabling/disabling VBUS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220114170941.800068-1-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <ffee044a-d34f-6be5-1fa9-c14cf3bb30de@seco.com>
Date:   Tue, 5 Apr 2022 10:51:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220114170941.800068-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To VI1PR03MB4973.eurprd03.prod.outlook.com
 (2603:10a6:803:c5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 968ecc32-c7e1-4e0d-7d30-08da1713ca94
X-MS-TrafficTypeDiagnostic: VI1PR03MB6207:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB6207B2CA459CA4D1CA75AEF496E49@VI1PR03MB6207.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiQ7O14j+jOSNQbo/+CxsSmfvPcUmh/6O8dvIau8LdpWQwxvcb8oWQcce8o/adln2FxqjCakiupSehZdUr16BlKaryxlY6ctg8Q46PUHLxHiQ3XemTbNb7c1uHlsAjo0xqUW0iMy8x+gcz8Gh/uzLPQBix1YdjfHcFsTuEnjn3tD4djUkt0mcO54zyUW31wnHGjjVM0J9LNcdr2ZmDU5u2XfhmozfBXC2X77lmOZwUKrFaY58aQAuPmcg5At9ZNaDx0N7RZGqGUesz5M2TLm2derksxIDe/ZMPrOwP3O7xE0dUcGKmHddebS0tFygnpG5U+Ajjghqb6ahTN2t9cf7ZWaKIcGrfxVOuB/isEbcUyVl77dLMiOfB7Uiu8x3JsCz3j+gYlnw/DOsojXxsoT6MtWWVHHQaDmPRRkgwyhaVa4vS88xQN+TwyhLVUl+0148rhDJ4QG0vX27X4YSXLLhzLkm5dGw3lsPNNnFfoXFOzOVQFVSz0YrU586X5e3qhlm2eDnRpSll3I1XYXIfHYUn3B9IWIqkG5DbBjisTXo82w0BhNvGiFq7EHta7lzRx5fbFCv8Qwc9ETmWjJCCYgKyIMSVJmG+79FFi/Mayvv+dYOXKrcIXezbkGtLJrfrajY4BrdyA2AaCE0u5RKxrGBVMXiGQp3Moc7p5iMfT10+nwUba+wKg7/d8goP9AQbH6CtuKpQFWpmEpT2NqKQilfQ2QYgRw/3MuUK2ePP+SuX/xN7z6kGwO4mLxXrL/6+0yVLgv8pvvdTFztiy4Pk/VddD996ruFNgd3L8nenF9R5DFMN9l6+IOSf3MY1APnzq7oYXQq+DwBfklHZHtLikNnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4973.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(186003)(8936002)(44832011)(2906002)(26005)(2616005)(5660300002)(6666004)(6512007)(6506007)(38350700002)(52116002)(31696002)(53546011)(54906003)(508600001)(66476007)(66946007)(4326008)(66556008)(316002)(6486002)(8676002)(86362001)(38100700002)(83380400001)(41533002)(45980500001)(43740500002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzMvbEZJTHE5RlplUnYvRjhHL1YreGdnNHREOTQwYzZpVzdySGl6VEhSZUVa?=
 =?utf-8?B?Z2EvbEYvSmlxMzUxVU1QdVFySWR0QXdWNVc2bGZSczlKekw2TXZNaW5FY3FB?=
 =?utf-8?B?b2Fub1huRkZzamJHYTI2bW9LbncvVzJEc1BSbHZtRVJWMWhVNjQxQzNGMzc2?=
 =?utf-8?B?YXRxM1M2eTVqSmJOSnhEQmRtSmRaTnZ3UFhtN01meGFVcjI1ZWc0SGlCYkIx?=
 =?utf-8?B?elJMdlY5Zy9tSzkyaTlqTldmSStTeVpzQlBXMUppNmcxUDdUZkgxWkJxR2JY?=
 =?utf-8?B?V0hCaWl3bm1Gd2dBTUNLcEk1dDZoU2Z1WTBDdkJXL3lGMUxlWDZib0laLzUz?=
 =?utf-8?B?enQ2cXQ0NEZOMVNtYTZ5cm1TVmlDekpCMFlsY2lHemE2dXRrRnFaMGJFU0cx?=
 =?utf-8?B?WjNIbGlMbjNoOENZWWNqd3cvampsamFsamh5RTBIQ3FxOEIrVGx3Z3FGcjdx?=
 =?utf-8?B?cDV0SXpJaUFoS09KQTJ4Q1hPSmJqalcxc0JFR1lUSzVIVUxKMHBydVBLaVZG?=
 =?utf-8?B?OFJwNkJOVm5UUjM4NDhSRGFPelVmaWVXSmgwOFF3OTlQbmRQaEFaazdieEQr?=
 =?utf-8?B?KzJzamZUdktpMSs0Mk9GRHRXVTlqSWVyVm9Nb0pqQXhpcm5VNzBlRXExOEh6?=
 =?utf-8?B?TUdYMWtOSFNhOWptS21zWGNQRllNV3BRc1NYOUZ5aE5vekU2NjVCUGZxV2kr?=
 =?utf-8?B?SmhoeXArRHpDSUExTnM3ak4wck1sWTdjbWxQS0grRXZyZUlJcHRtUnhHcWFI?=
 =?utf-8?B?QXNlcktrc0lOckNpQTlZV2g5a2hJbFRMbHc2TkVzd0kvMm0yNHp5dTl5M2F4?=
 =?utf-8?B?UXd6enIvQ09qdFY1TDRRUHEwdXdkVUxDdThvQlZXMWVBUjJzTWpBQ1E0Tkd6?=
 =?utf-8?B?M1MvdXkxalVxNHNMR2VzNzZibmpzemRleEVjRE4yd0VjaHBhKzhVWHFaakVE?=
 =?utf-8?B?a09UOFdsUE8xd0JreVVObkVXWVNCQkp1WUVqSmdYWDNJWFFMZ2tyME9WUk5O?=
 =?utf-8?B?YWFRQ091aVEvWFUzVzMyUFRtMURIT0FNYmlBMlZWTlZNSVk0c3NNZDQyUzJI?=
 =?utf-8?B?VGdRRjdQK01pL2Q3OTNEcXRXZDlXTGJLd2pTcTBGQURmUjNPR3lMNzE1UVBN?=
 =?utf-8?B?WnBiV0ZUa0RLM3gvRGFQTlpDbnJjWTNLaHB0VUFyMGkrMzJFOHhMWVhvTVBY?=
 =?utf-8?B?Mkg1Z2N0WWp1L0h2enYycWJ2UFY3SXh6NGVxaXhvNThiQVdTemtJcExOQVM5?=
 =?utf-8?B?Q0JKbFJLOFNuam1qelUvMmplemoxaEFnY2d2RUNRei9Db0xOMXRzVzFZTHJk?=
 =?utf-8?B?ZnBxWnl0TXZzZGRhSVpBaDVIdXQzVldJS2xqSTRmcGMvUlkvL1dOdDhMZno2?=
 =?utf-8?B?WDBpcnFDVnczTEY5NlVwNkZ0Zkdmd3pEQ0FHVmZnVXlEenVhcUVBbGpFVU9G?=
 =?utf-8?B?RjVJeHRQU1dWVllhQkdPT1NBOElmUnJNWWxyZUJQS2pWSll0TVVDTkgvSVdF?=
 =?utf-8?B?ZlhJK1J1Y3A5SUlIMEErNWJqYUFxa1FnNTdkWElLSkdpOXdXV2VGUk5oaHE4?=
 =?utf-8?B?RmQ4WVRlZVpFdnJWbXNRZXV4N3hDTThheTNvdG1Tb1U3THlPd1MwY2JhclRQ?=
 =?utf-8?B?ZERrS0lIeXU4YlJNN0ZPNVFIcEw3d1VJTElXYjhCazlhU3VIWVJWQWEzOW5G?=
 =?utf-8?B?My9zRjkxbFZRRXhmNnRuWlJnWHpXRGhGajBCaGRUNTBiS3ZubnJqR3BMZXow?=
 =?utf-8?B?NytkUi9vTmNUekZzS0hHZFVWMkt5dFNERzBkUlRDalBRYk5TZFZsS2xkbHhk?=
 =?utf-8?B?MmN1amdFYzhvUlNMT25idVVvN0N3VUhSZzJIUUhlbC9CSXJSWWQ5ejFpdXhQ?=
 =?utf-8?B?T2d2blRDcWJsc2hLblF2anZ6azRiL1JxbTg1dGh0d3lJcVo0dmx4K0VyYTFI?=
 =?utf-8?B?bUpCTFJabXNmOFVrazM0TUg4NWM0a043UG9HQXhiSWFrNEVyb29pQlBFRUdS?=
 =?utf-8?B?aXQ5T2hkcnZUcU5OVGJUc0piZnk2U05DUHVabTJjc1VhcFA4ZE1EUk54WllS?=
 =?utf-8?B?UzRYTnBhZC9LdFNtUE1UQVZDdGFwblNHM1JwcERaLzZTclVUTXVsNW9QUkww?=
 =?utf-8?B?UFByQ0N6akJSSStLcFZZc0dqeTBlOTRPcGVtS2FDNXVrZEk3TXN4V3NrZGJi?=
 =?utf-8?B?TEErQTRjcmlPNm5wT0RMcjJvL0FaUE1raFNFQ3ppc1BRWnJKZTNkOW40K3Zm?=
 =?utf-8?B?bEJibCtCcHhlNVFhTkFJZEtMUXYybEEwZ2pSd0Eva2pab24rZ0ZpWCtZTDdv?=
 =?utf-8?B?cjFmNWhENWF2SWhoZFZVdHhjeEFNOXE5b2ljQmt3ZFIvYWQ2YnhONkx2Q1hr?=
 =?utf-8?Q?y8Zcq47KsouQnhDM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ecc32-c7e1-4e0d-7d30-08da1713ca94
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4973.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 14:51:40.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URDJ5FPbBxKRz1XI6hpqb+mReeppzQtfJNGdEr7CxKdS9yVtxL3NMIlN071dqV9JC8iJ5z6eI/Ze5T9xKRwtIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6207
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/22 12:09 PM, Sean Anderson wrote:
> The generic USB phy has had VBUS-related code for a long time, but it
> has always been broken, since the regulator was never gotten from the
> device tree. However, the support itself seems not very useful, since
> e.g.  usb_phy_vbus_on/off has no users and usb_phy_set_power is only
> used by gadgets to make sure they don't draw too much current. Instead,
> use the VBUS regulator to implement otg_set_vbus, which is called from
> several drivers. This results in a change in semantics of VBUS, but
> since support was always broken I don't think this will have any affect.
> 
> 
> Sean Anderson (4):
>   dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
>   usb: phy: generic: Get the vbus supply
>   usb: phy: generic: Implement otg->set_vbus
>   usb: phy: generic: Disable vbus on removal
> 
>  .../bindings/usb/usb-nop-xceiv.yaml           |  8 +--
>  drivers/usb/phy/phy-generic.c                 | 55 +++++++++----------
>  2 files changed, 31 insertions(+), 32 deletions(-)
> 

ping?

When this was submitted I got an email saying that the merge window was
closed... but I think it has opened and closed again during the
intervening time.

--Sean
