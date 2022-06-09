Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165CE54410C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiFIB3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFIB3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:29:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6DA2A71D;
        Wed,  8 Jun 2022 18:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kb9NdH3aEdJglgOsM6C/hti5wcYFoPrJYMOTrGcNyPiGgtuB6Z9SsjWVg8vptWDXA04yw2lcrYJ5oFGwR0ELyLlbjJfSgswKKKEMxFYW7NB5MBQDYCwxB6tCvEU8yDdUVL/GDiLCNRqYBBB8M8RaNJRQSUpsaSnEBvXW6FtJYjtSsNTN91pEGDy6Y2carIL2DPrGG0I71a8jMJlhfiZEbb5yKYjodZeFUs80IbUjFSbmC73WC3efSSclJZBN50GcElslyPCgF8a3PEqpfb9RNW4s2u6S0U+2qbMxNi9I5HHNO98blrZPKnQ74CDDjOXOpDcYCKQnupDxFWgv8ofZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnyvwJe/Ho37mK04/9Sm0JrVZdxf3Glq27k3BeIa4vM=;
 b=O6Sho8RVSvUSA2j6QYBKh1CaP1/0Y96pylxzCxaOUVXzH9q1DC5b9v0w8UKilz9QzLzZcNispE9EUhvfJfpUWtaad0WMBDgDpMsBtz9iJDl7RIkyIlzID8qPd5NfDAKy0XQmj/zo1HMZ+5sjgB8iynt3ws2bY0iQOPUCiBi4yACdyGK4L9JSFIF3A9FWSaZLlohq2t10N52ZWN+14F+K7pxUubYKhZr6TOmUOEvZ35kQt17dvmHNmlT3m9DiFFG3Kd86zt0/PYYwGUTYwng+r69OGdoIDr5l8npc7lpq07RPxGrRE9EKc4yT8iBqOgjmsOAgRfX/naEJbPOTGGcNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnyvwJe/Ho37mK04/9Sm0JrVZdxf3Glq27k3BeIa4vM=;
 b=S9vQnskJQj2gmMtsGC/6ygMRKwuLc3ISd0cFWzW+7ATltfrAd6mzEnsaRxRjUMCGOxetps3371stXQ0tSDQ+zPfQ9ifrgz3em04K6VCWawUrrpsKZV9PjTF4QX8+dQw4HJXEh7l8ThW8MOuJeOCgLZMXFpi6E0FNX7SQAz7hM+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CH0PR08MB7443.namprd08.prod.outlook.com
 (2603:10b6:610:f6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 01:29:46 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ccb4:7984:aaf2:e18f%6]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 01:29:46 +0000
Date:   Wed, 8 Jun 2022 20:29:38 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: input: Increase maximum keycode
 value to 0x2ff
Message-ID: <20220609012938.GA191119@nixie71>
References: <20220608211207.2058487-1-robh@kernel.org>
 <20220608211207.2058487-2-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608211207.2058487-2-robh@kernel.org>
X-ClientProxiedBy: SA9PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:806:28::31) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66bc0eeb-ab47-455b-9b0d-08da49b7886b
X-MS-TrafficTypeDiagnostic: CH0PR08MB7443:EE_
X-Microsoft-Antispam-PRVS: <CH0PR08MB744303A59231518A7AC82E15D3A79@CH0PR08MB7443.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0NztEJbOnWJCCxBTixMOIWhotMZxG+6MupmCothCpUBJ5Kt0Jn6+b6HrrKNzLdygY5IFWKhh5rxDOP40niaBRnH68pJQ5urqQdjaEdlmqZ24yLJLhtn0CcOiLsj0WOGSIVPwe4evLPbDFE1pK4SiD7sTAqdqSTtZngr7zf6FPINMZnqYjmUoH6VQG54tBifeILFLBYzwEPTPSVNuC0jFRPXMdo1wtjdC8SRXiYyvdYLEJhJI1PoLm32705ZhMCh2mEb+V2v+g/VULnLA9vi+c3Od3Qu3TTt4SmiacI7C9vwZrkeTMyQFQ0KiWxAzmCu1LPox8RRV7wFP4mEHRYu/MtHACDioCbfWtHDHxLlIjDE0MwVqObuXfHQN9fbTP84wdiu2nABHwFreAuVUKAxGA32QNSvmajkuI6IXjRmLm605ZDFsNA5Wxaa8uz9ksS/Lw4gSTwYTPJj4n5XmyQxiIeF0NS8W1UsAX/CjQ3CGmxs7NafrwhWnPRIWY0QhNYcnJZkK9OZ9Xcp/Y2/utbFsJ666B8w0n4zCTsu9Z5li6jQfR1qN1VPYEwhZjH17miLHXAFbg2O3BXRVYNjfDhE6Wxce5oZQewXlalWBGWs90ltWKIkrp6REdITKSbGW7/T1GSAAz7psDiU/zL1YhVe3jaEw5CqXuxfoYNl2dzvYTLTJpWWPlME6Mkxi8dJ2N1M+5WSTWZWdvNlULR7oWeOOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(396003)(346002)(136003)(366004)(39830400003)(9686003)(26005)(52116002)(6506007)(8676002)(4326008)(66946007)(66476007)(66556008)(5660300002)(7416002)(41300700001)(38350700002)(38100700002)(186003)(1076003)(33716001)(8936002)(6486002)(2906002)(316002)(83380400001)(6512007)(508600001)(6666004)(86362001)(33656002)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8muF8UIDqklFH39gtKgTpEsPva5WOQDcxwTgWiL7swHDjVcCKzOhuftAS/WO?=
 =?us-ascii?Q?Q6PW3K7tfT5sx2g0aHZpnmAW0iHyo/Stsg7HvzF3gdI7UUxbaOXIRAt23T4h?=
 =?us-ascii?Q?n1//JpZ6Be2dfgSLKJDCGxNMkr/vuAsIwvlcS3mpomTcd4Jhr1BZlVBscVMo?=
 =?us-ascii?Q?y5KqO9sH3P/bMf+gW1MymFO3Nrhj4lY1PYtnmC8VRkIHF33ufbyZNI+Cs9vS?=
 =?us-ascii?Q?N0qZsrus9VdSvUJSooMWkrKoHUoTqV1WAhAteIETuaCU70s5jQeRD9C4s3uo?=
 =?us-ascii?Q?G/nEjJlvaB/wdjwPkghlp5s1fQDM8tbB1oQdWN23DZSUBv37l314zhC9BO21?=
 =?us-ascii?Q?ggqitMZoT2q6EO0NKzqAenEanUIWKaxQ6yu1b6S/ZF58Fs16WbENcjybiadn?=
 =?us-ascii?Q?OTJc9wYkTKPtX4AHTXVUBvSqvjfizcV46+Z+Jnr8rVaG02pubRgd8ob9xlzT?=
 =?us-ascii?Q?5Ig2z6CMgJjeFUfvGG8J92BOWo3W0AmnvAo6uWIAnIJREe45oMCpcB8a74iQ?=
 =?us-ascii?Q?e1Y42gyBdXR+Ns4BNqhJelE3RwCyoJFmVqvbMmz9QJT9581+PyFwo0iBjUIv?=
 =?us-ascii?Q?Ttxr2NJWXkOFQbDYc9sZmSDPPWLr46YN/jaNnR239SqgKQ6HJOMndZ/MRXmk?=
 =?us-ascii?Q?zF7NyfnwrZtpZOFcznVgKMoVM/H4mkp60q79H132z3QRLKZpXLiX/W5xLEcx?=
 =?us-ascii?Q?9XdkxHDxIRqmLhpj+kVbwAGeNYuOAMPL6BYPRaiYzhL68ewHcxAGVQz14Vw0?=
 =?us-ascii?Q?jBeHYVxP6/sH/40AZOEuw8/EdGZAXPcLimuDsL5QhI5LuVOw0nmM5UAUx9uC?=
 =?us-ascii?Q?AnqN/7PXNmOpjPENH1jbKfTB4MG1kTLivDu//veq5xm0Wku9EIkLzTKbR0ZG?=
 =?us-ascii?Q?E+99x6JT5QWS3jT5mOejJylpuqbx8zVIei33CTIRKNeBYLqC6t2rxfRt8pKh?=
 =?us-ascii?Q?dzmqanJkX1u570gX4WhAs79QXsEOtIDBNyC6Fr1N3MZK+EkLuGZqWdRclgkJ?=
 =?us-ascii?Q?rljIaNW8cIo5NuK+RlxmmIQpGsH2a++bGSPyeRoKxfpOwawwpGrfh2yH6xmQ?=
 =?us-ascii?Q?hKIGncIXfBd6J3w4RrNVR6VwfjC/+tlh+WqVPpl6OILWHFWVcyDfH6tOYQev?=
 =?us-ascii?Q?AIZi798IkFAlVwclShBwRT1sIUJCiqX9yMelC4BgC5f3jUpwZHvJ+VP4LSkN?=
 =?us-ascii?Q?TL6fZ2/I1VkQ9bBWAShV7Qbo7bqsR0gyhMG+Hy+ib98kJs6wbWBifOXMlBu/?=
 =?us-ascii?Q?6CYc6S5ppaqT2s8AhWWbwsdCBIn1i/2zPKe1HvJPnON5BBBXnQmuWvFB1SUm?=
 =?us-ascii?Q?nTjsI9jIWJlHRUX2olYrYUOJ1mznBDIzso0lzJ0KS/5Fks+osXxCJRj1H2Oe?=
 =?us-ascii?Q?1MbnXS/SVMmQJblJWYDeYk8blbZwldH+L5cJalCGg7VVl0PgQd6KWC1gRZDk?=
 =?us-ascii?Q?Mlmh/gyv7FVLiv0VPFQNcAoFvS+x4Ba92zwGD2Q5LZtg6pZLrRRtn6a4FLIx?=
 =?us-ascii?Q?fi9txE27h1ASaJm2WINygCl6ygOxbMXBW1/mY8sJHN0NPdZqAxigwrri9EIX?=
 =?us-ascii?Q?v9AOXCnksOzzguCWCJynONY2kFa3uA8z73cPDT0W34gbQsyJNWKrrkHTtXZh?=
 =?us-ascii?Q?2pZaaxJSQWrOo2hywqKef6Z4G+w34Fr57SEiIkcJyisxaLRL8ZNL+4jveeQz?=
 =?us-ascii?Q?U1dqYQMeRe+zHp49NNz78VoIJzwNOuCrjk3bPcBn+SqGrBlq+KF5iiHCbt4N?=
 =?us-ascii?Q?PJkpNqJ1fA=3D=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bc0eeb-ab47-455b-9b0d-08da49b7886b
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 01:29:45.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkCzFtWqfQMyxoaJoiD0ngJgJBV9tcQ5ib7IRYmczdz4dPp6CRv3zaKkkzKtW8IuxQDhX5i3WfLzW4Wv16EcKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB7443
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jun 08, 2022 at 03:12:03PM -0600, Rob Herring wrote:
> The maximum keycode value for Linux is 0x2ff, not 0xff. There's already
> users and examples with values greater than 0xff, but the schema is not
> yet applied in those cases.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

As the creator of a few said examples:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  Documentation/devicetree/bindings/input/input.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
> index d41d8743aad4..43d2f299c332 100644
> --- a/Documentation/devicetree/bindings/input/input.yaml
> +++ b/Documentation/devicetree/bindings/input/input.yaml
> @@ -21,7 +21,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      items:
>        minimum: 0
> -      maximum: 0xff
> +      maximum: 0x2ff
>  
>    poll-interval:
>      description: Poll interval time in milliseconds.
> -- 
> 2.34.1
> 

Thank you for driving this series.

Kind regards,
Jeff LaBundy
