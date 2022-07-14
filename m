Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C536757412C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiGNCCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGNCCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:02:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2091.outbound.protection.outlook.com [40.107.93.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DD518B36;
        Wed, 13 Jul 2022 19:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/aV4NV5Cv4dP5ki6kpmvnuafSRQ7J9z+HMy/W0ir81BDfseo5LxMkWr+ILYfIRo5bL/YsdR7PBP+p0Ng43ZWh+JBtQDuV0dhfOzzGOUQY4DePVtwFB7WcFbhEVFZarr4RMvKXeOiiGnM8tbe4blOzTR576AeDKyJFBAGjQPpZoMZkYH/k1wv45J2tbfTuGGNwQR/ThHXNCjdO8748sneBfR+fnhHWkaNpRywCgMqbci5Z4TL8JfCXvDYV0RSzzLcxHCuxmYpjroKFw8BZUp35zcgtU98V/rEnHkuzE7Hl6mTCLhdbGwdH9N8Tjq3I8eXPOoutM4Cxu9c1yRD5v1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JumgzQBhMOZqnK0bV0Y/HCeuvi7ZyVJAJ8105Zl0ya4=;
 b=X4i3xtz3OxsToakz2LLx1B8dpRtNWaOQM7tRWWwwAkHqL9845ti/aMVGgL0TN33adwbA0KZVeZdZZNkFR2DuDZR2DBIeeVVmn7Rfu/t6vYqL6YzEA8TvVV2tUj9b9WSwEPsp4eHaxF8ZX58xieIu2yXG7ri0Phjv1maX3b5JaiTHV3F6u9QYIcgyT03fPuBY8BVWliDeEqy5D0hZl6Y8ug4LVXato17imdqru5oXf3IvvGnBvEv1Rwz0WsWE7q5yYphMAjaRHksw/bXXC/7eiiHvNuouk0TfI+eAzQplgps0BROp0lalHYsU2THr++w9siFYuBBKSUJPLHoVXU99gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JumgzQBhMOZqnK0bV0Y/HCeuvi7ZyVJAJ8105Zl0ya4=;
 b=ZybJZe/QfMKhqsvfo53zWl9SxGK+BLtZ2/BNVJ9c6tutD6JO0MlQUk2ksvkyqYfsQP+LwMNC7Hbk7Pf9TNdckYCbyifEOy4Pv/IrLscV5pvNHDQyOiNYtiLWYqlpjLQlngX5u8RYrkRdl/xrIbPM+ktl+GUd53avvk+9nwYmrbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN0PR04MB8190.namprd04.prod.outlook.com (2603:10b6:408:15d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 02:02:42 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 02:02:42 +0000
Date:   Thu, 14 Jul 2022 10:02:38 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v18 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Message-ID: <20220714020238.GA4276@anxtwsw-Precision-3640-Tower>
References: <20220713084139.2810115-1-xji@analogixsemi.com>
 <f9e1ad3b-d6ed-7392-2fd9-ca6ff0417b16@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e1ad3b-d6ed-7392-2fd9-ca6ff0417b16@linaro.org>
X-ClientProxiedBy: TYAPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::24) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99098bb-e042-49f6-4314-08da653cefcd
X-MS-TrafficTypeDiagnostic: BN0PR04MB8190:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPy+GD+kjh6FugYGvItqE0eKAQAvqRVzdzET3xceEtNfhCWiSLFWn1P2zYLzh+i7VuLLIvnfdFO2wkL1ShAYWiAIjYzWgJmNHwhbbHpynOP3fHmLBv+Xwnc+xSExFRp2HUVKJDzl1unhX/YTNlUY/ctBttgBlgYnH0Weu0Z9QegHwmZyqPIIFvYdRDpX9ZwdLYZCmp9YCbn5U7uELcGDmUryHcL7aVeiErzB3q1ShDHWuXlqPygCSWlewa++SacKXXbZbvH5J9mQ8Uarqf0yMra6D2IJqx3jvSPcic9g6OTfs1ch8mRDWb6nJ6jMmLzNtU946ICkDtGm6vaw9iTz9aSm5m1Xox/+FJPcB4CUwI4obVYQ5sUwonWnQCbUzaMfWtHSX6zGZEUNPghiqZN1Coraf2ZGxhbkQYBIx961r0yPTpCC7i31RV2wH0Z47sN3gxDAd4nB4XOab0kD4Nfh5LLh7fRaQYo9W/AiV/R1UsZTmTcOS2FJ6cKh1oLuCnPKysxmOLykwP6AisofgJaDQ2NbFPXriNuPmabngQ4vYFDnX3J+TE/wWk/dGgN/9Ncu6/IbcJ7ZbvOlvZfDuZtNPCM+Wwmp8CPm+suI9HtV+x7UhyRLhXJY+Rji+h3FRa4PZ9is7lJG5kTiHMEXzCrtyamAI/UX8eH+Vz8WdQqxCzw50KvoBb5YZtehLso8yOnAnRRQS+ah443wfx2Yg/w9rvMnOmPjq3b2eJyDMwQF8TLlLVFniiTLncTJJPxzszmVyfdXE4RT3ITUvUxKxiz0PO1BlY0jc6ViGL/a3MZhcPNrCQIQNV3KL4TE23FuNJZJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(396003)(39850400004)(136003)(366004)(26005)(478600001)(6486002)(33716001)(2906002)(41300700001)(6506007)(6666004)(52116002)(55236004)(53546011)(6512007)(186003)(5660300002)(4744005)(8936002)(9686003)(33656002)(6916009)(86362001)(38350700002)(38100700002)(316002)(1076003)(66946007)(4326008)(66556008)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDMs5tO6O9o8cjuk0ZioxtU1H3GgKZJDarWe+kJXuRn/Wzjv19CRPRMP3rPd?=
 =?us-ascii?Q?v8DGi9lpV/hpAv8CjMbHMgJvmWtyVp37BJLfKuqSBOkrooHDSXlz4kMxaXS5?=
 =?us-ascii?Q?RUJSKD5Pztv+n9REfba5yeEC9QwtLFL8sNeF3hG+kwlKUSWF1IAqRh5rsWAr?=
 =?us-ascii?Q?QtBm0DZuuBM3ccP5lpTNvho83epkpJBMohcVvxN1A8fAyf4l623YIWflS6aL?=
 =?us-ascii?Q?CszPQAZxlnQLtA6Ozm7g8Fx9X8YXtYiWhKNMlJMoWxK6Kx129KPuQSaSZjW9?=
 =?us-ascii?Q?iQAC3YPzQlQsdR0HOCArmBtHLZinY3DmBxIAN7rneKJpnIbXBvGseB0LWap2?=
 =?us-ascii?Q?ZiKzfdyHHJ7WMs5HsniCFl9gY7U1Bsk8MQDxlVuv0wpF2YL7zZLkq8vDU5OH?=
 =?us-ascii?Q?HRGdRlWhDUsLPmtupcvfRF+0Ks+LMUbLvFS9bH4c5mvuMa1upF6ES4iYVc30?=
 =?us-ascii?Q?7qhe+j89Lw9WaEc2P0CoqqjsFtfsElQ2ekGDne9XA1vRyiJ6uTlgAsbV3jEf?=
 =?us-ascii?Q?eeHTEluN+AlBaMHr/rlaGeLByZSncgyf+4HTOywnYnHMMaDWsTItSz8Z/wXw?=
 =?us-ascii?Q?zKcUcg7/O3d00JEbfc+DnJzU/6MTST8QlmfGuy7GW/u6qeVfQlv4/zSNcGl4?=
 =?us-ascii?Q?msEak6Ws6aQG3TrREWbmeu1dxOqIOuYtBG3eoxvdHi8LD2f/DHYamw9x9216?=
 =?us-ascii?Q?JkD5RDP8wxiOxLhzd4D6MIcqJoSY/lnaqA3sAWS9Air9/b/qvTAcLDbeb7Py?=
 =?us-ascii?Q?/piSCaIpNM3T7vS3TD1nCp0+bl6Z0EKDxEPmqKqU9kOuwtk7Nu3Q958RNsFI?=
 =?us-ascii?Q?G9CsifEBDkbTPqEE+qGeC0i2GFC4zAjWec1Yb9ZR3+llSI5zltR0WX5s/pb8?=
 =?us-ascii?Q?amUPgv5vzyVYNjxWWEaIU/0VNoimOD68rNGdqiPYF0cAsD1X8ed9RBBpnthH?=
 =?us-ascii?Q?PfyE/reDetSdNvaySqsjLKNovifxKQ8OS/5nQ6/aeoMthoziO4PdDH1UedF0?=
 =?us-ascii?Q?VB9JI1hX5k33yuGGhCMf6nuNn7T+Rpmy1kzfJZatYJfVBEOBGXyFQrZhuLmL?=
 =?us-ascii?Q?KPLHi6Ykhlc7RZkQeHfshWM6hEzzidbnnmCmxdV9o+Yr0REKeSYiC+JeqlkP?=
 =?us-ascii?Q?EqNP4zGVR0Anm1G/T33QYyzURdTZWzzJ2Q9mhWK8CuMyjFKHZ2YEvFldV9oL?=
 =?us-ascii?Q?2oluL050wHNazmzrvxkD5LaWhhLAIgzHUVUISppLbG2uu/jWobqOCwkV/3mp?=
 =?us-ascii?Q?AyKzYu6K5aqBHkMy0fwHXxM5SAABz40xNc7heginnGWD/aU0zwphRjKpUYbw?=
 =?us-ascii?Q?vtxoibmoTfKzeEgObC7VgNQmbFHTmW62kbY/Rug4E5UkrsHePHnY+N9v2U91?=
 =?us-ascii?Q?X+60t/+welCheymnqs6C9xT0XXCnwcrWHv2B9sau+IXYrRXQ+9Qe+OGA/tgl?=
 =?us-ascii?Q?cUzJuWtS85VAj2+s+NePxJMYQeNrTWFdD+Yo6UJcQMm1K9DiP2ML1NJCUew9?=
 =?us-ascii?Q?i3J2gF1cyu3dSpZPA1fCgKDcgS7KiWz1599D6JJeFwPFP04faquhtftzIUn9?=
 =?us-ascii?Q?fmytqiChDKDEpjdG0IGGVRPSHsNy9GY9PorsKReJ?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99098bb-e042-49f6-4314-08da653cefcd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 02:02:42.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71zf19XQJfKMAJjMxquUKBM+VjKpEzo4FiunvTucZ3fSW+hz5HHi9xtTRdfOOCqGjY9oTDN7cJZlE+8ewrZOUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8190
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:28:16AM +0200, Krzysztof Kozlowski wrote:
> On 13/07/2022 10:41, Xin Ji wrote:
> > Add analogix PD chip anx7411 device binding
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > 
> > ---
> > v17 -> v18 : Change node name from "usb_typec" to "typec"
> 
> Node name was anx7411, not usb_typec. What are you changing here? The label?
Hi Krzysztof, sorry, I'm confused by your comment, this patch followed the
other dts example in other yaml file and passed the dts checking by
command "make dt_binding_check".

Do you mean change the the node name "anx7411" to "typec"?

Thanks,
Xin
> 
> Best regards,
> Krzysztof
