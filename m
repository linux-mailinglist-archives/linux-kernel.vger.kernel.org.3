Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F1349E911
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbiA0RcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:32:06 -0500
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:11680
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244622AbiA0RcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:32:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpWQMml9L5CIUO91pYgQXCw2qDrv938qt/H7G+f7rF1emwvZd1NECcDaZVy+UEdAvR2vfTZVNQFK9EaArkrdY6AuIimdqq8HvOHo4F97l3GAmIZ1GPmWJdGeht4Na+JG103QLrw6Izyoi3p6YDIxxAEKxH4d0HG41Ii0qKMLR2IpRSQNFe20kbgAXX18JY35hRHmU9HT1AQqN+wSP+NqHWI48OYraCCKMpCKjwUbZPLYdpSnq0pP7VwK+NovOraYN79GAxLIi/vjQ/b2KK2TsulC2vE/QmQu0/iEM1g1xfYtKGyihDMvb+gEaA9x4DvdZctdE8cL5pEGwo8Ifw5/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dk8gGogatYy1mjGzBFi8T8Of9bqqyRz/nlmM5kA8Ew=;
 b=YlITjbRgFfbgAY4sF11Rk+QkiBSFzd/dra06LUbeKrb0h4BJ8M3tvwrwSVc/Qn9DN14ANvEQ9tfcZC79CO4dC2MmFAffcPaaqPMweGAmn12HTB0jFYjHLruegvcpbTPO09KURhqiVA44pZIXSXNd+lsi2sU86gbzrOvO7ROfHecGPldTzoSxP1/6GUcGZA4v3PXwt9NFOn4nBcQnxp/HhzHWxaf5V9q+zjVunxrOmCkCB4AdVoBpSgMIIf+LgU/IngJ1jSd00F+nhcMS4BTNtVFXtpFY08NlElFrnFqObqkGWvlusBPEWKAnzknrT6Yp7pxLKruR2yeHcw0HpWskQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dk8gGogatYy1mjGzBFi8T8Of9bqqyRz/nlmM5kA8Ew=;
 b=HxisrEMmeqZ4gsulm5qmkHXxnMVw1WAOSFe5vx67hZkwdm/EYjgfvn2Q5DGSPBfTunQMiuw/HL9EuR+CvqtVAeO8qt13qq2QKBu576N7OcWROx+Im37m33/mgxwoCeKJ6x2LvdtxIwfwvIafN7AfHLw0puzAiqFADmbhbLpKWHcc4YH7CdKNDv4jMYjxBLDGsutfjN3nWcEkEtgv32uOp7KcLN3/xOZXRn9wYf6mQiiRqgE3Qx+8ImvDs6KJB7gEHEWHDBZdE5qZQ1xcrstC4KpMCFEYXq0lTP7WEuaxEULx6zAfFaWl06xOjLEyBc8NIeoIDqsT45VFlWzqPONoAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB5953.eurprd03.prod.outlook.com (2603:10a6:208:15c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 17:31:53 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 17:31:53 +0000
Subject: Re: PROBLEM: encryption test failures since "crypto: mxs-dcp - Use
 sg_mapping_iter to copy data"
To:     Christian Eggers <ceggers@arri.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <2126453.Icojqenx9y@localhost.localdomain>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <414858de-f279-c5ce-83ca-5c28d6c847b1@seco.com>
Date:   Thu, 27 Jan 2022 12:31:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <2126453.Icojqenx9y@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:208:238::23) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3b52554-d3e2-4ecd-62af-08d9e1bae8ad
X-MS-TrafficTypeDiagnostic: AM0PR03MB5953:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB595365FF15C8CAB2DD0A33DA96219@AM0PR03MB5953.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:272;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vDtf1hJPY2gDbSe+2Ra5elDlgjMTBtEWSSnPF0x60yTD8VjKa4LONbD0NpDFWBNKdnpOWHPTdELrdD/6YSG0Hh5r64ksGxEHa8kmQmGlohwMAlEUsv9DYmPmrq+lWP9CPUsY5Zf+KW+yyGBbU24lSiBYgklyUIPPaU/KO8rOLFgOmjstkarLrU0oUlY1fXnUw8aWgYNvllUyZnMXYQgyeG7vGBGDscXoylTXwYoL9qo6AcD85MSOJDaQEoJQiMcn8FfkJ5INi6nnqVMYYEd7ciET371361gZUc1nW7B3uP08rjWJWBwLyjs6dOWzuZBiFPzOe6k+Yjo38BXaYoK1tLrw6csYGYs2phuQWskP2Mtk1SBJbt19WhyffO6lJlJ6gJrrjy75P2OiwiXPhS5Fc9E02odOlMO5DAdUYuN0fMQXWYYhQ/R8I5BkjDsHpu/hVwsnCojihB4NCcA1Yjjwy9DmPrsPBXEYaJvzCosDFiU3LTFLBzhQovBcAp2UqtqvnSsvt1wNo/N5Y6AzNLB1XlthA/xOvtOZJ8GBy1YTUY8KHSpQ+d7ebxr1u1MIzXloODDdk8mRRZ6wjgt/xYIucfgt/BcoVcK7wSAVa9j3/9GkjkDkbiAbOF+Guyp+rjeHgNCO6ID1w/cwdRq77VeUZHhOwxixzpbpw6A18t6fuYauTe6kiSN8uG9UHpFxVFCArG57EXYsDD1qxDoXyeoXp4RTFvmcW9CN8vJ8bQt+RM81as5jjkvGZrFHmQ3/K929p+aat9+be/anexJdFTL85245kiBoVs9L3/7J9zwH3BSneDd0SvKOvkSuWDp/8QVpM5viFhF4RopV2PVCxrI01c6N1n84uI5vU370ItbVUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(8936002)(66946007)(36756003)(8676002)(5660300002)(66476007)(66556008)(110136005)(7416002)(4744005)(38350700002)(38100700002)(31696002)(316002)(4326008)(86362001)(508600001)(2616005)(26005)(186003)(966005)(6486002)(44832011)(52116002)(6512007)(31686004)(53546011)(6506007)(2906002)(6666004)(83380400001)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVtVXQxQkE1TXlESWZYVUwyZDdzWnlYeXQ4WmhjSXFuSTQxWW1rUktPeDFa?=
 =?utf-8?B?a1k2L3dRZi80L3JOaGZXNU9NUEJlWVp5SkZzaHorOTJ2eWlCU1BJVmxyNmdZ?=
 =?utf-8?B?TjliUjUzV0dUZzhUb08zSDdnUEFJd0hoR3lEN01PSU9YS1UwYXFwaG9mV1pt?=
 =?utf-8?B?ZDd0MnhqR0JEVXFrRWRyazhTTnAxekRRRnhhai9DVDJGam1sQjRDaDVmcTZi?=
 =?utf-8?B?bElNcVV0U1ArZVJMWTN1a3FwVlRvbkc5VTJJUzV3dVVWSXYrZFhwNTRwZVli?=
 =?utf-8?B?dStsSDlMLzRENC8rY2tsTmRQNWpHNnFEUXhKYjZsNUFDQzZmSGlwUGhzN1JK?=
 =?utf-8?B?d3psazlDMzdhQ2dWK29lc0JZM2F3cmRpZ1RHcE81TlNtWFE1UnI4M0lpUlNk?=
 =?utf-8?B?KzU0ek9xU0lVUnl0VHRrVmowTUdtdG12UUtqMHNOaGhQSVdrY3orRlZ1dlVO?=
 =?utf-8?B?NzRJMnZOYXVXdVA4MFNiRi91T3BkaWJ3UHVEQWJzZlBVTXVvamNCdTVOTjFW?=
 =?utf-8?B?Z0w3TmVpN3hZeERFeVJQK0txOTg5TWI4UXRvOWlWSWhVZlB4Q1E4RnczMDJ1?=
 =?utf-8?B?VzFEd2pRR1ZiYkNWOUZxQUt2Njl1eFVSTTZxcm1LTE05dmZTMVVNTVFsTGcw?=
 =?utf-8?B?M3VVaXRlNFBWMnpGT0lGbDh0VzdERjMxSkJJTmc1eHlTZjdEQlhwY3pndEs4?=
 =?utf-8?B?UzdQcWhuZTJPZmNUMzI4YllYM1h3K3JEYllwL3lRQU1PaDJiQ1czTGFMOTRo?=
 =?utf-8?B?S2xzRHk2VVBRbnBVN1hteXdFRTExOUVRcFU5SCs4SWE2SlhSSHhDWGViZXpR?=
 =?utf-8?B?bi85Tm9kK3o2cXYvM3J0cUhZOCtJNTJWbzlNS3RydTkrRS9aQzJlS2I4aVNx?=
 =?utf-8?B?Tm5ZT2gvVFQvc2xlbXBQenhaeXErSHlWSVZqcnBzNlpWT3doVGh0OWkvQnlm?=
 =?utf-8?B?ejRQWkJMWFVtMk8vZC94eTZPY1RBdldtUU5VNUhBbzlpZkwzTlh6YVpFNXNl?=
 =?utf-8?B?bUhENllmSlZjMVBQTzhLdHVvb1Y5b2ErSTZNL0ZXMThGbmg2OWpWeTN6dDc1?=
 =?utf-8?B?LzRwVlZtSnI3SHBzRWJldDBEaExpZnRUc2ozRzJVMjhwc1BkNFA3UWZIcjhF?=
 =?utf-8?B?dEZhMHNzN0hUOVVDVTlnMU9lcFRQNDJUYVN2MGp1aEhUNXBvQnJCK2JrQkQw?=
 =?utf-8?B?VklxS0ZyYzNXR1VSbjBvSnp1bHVza2x4YXN2WXVFRXl4ZytGNVh2bkkxRnVH?=
 =?utf-8?B?R2ZEbmYzeDYrUEQ5U0hMZklzWW84SEVqNmZZTG8rUXRRb2swT2VyWFRoS2ZK?=
 =?utf-8?B?MUxBUlp3cDJmeXhOaDN0dXFVYXFvL0Jvdk9CeHRKYnBXZk1icFY2V09kSEht?=
 =?utf-8?B?WDVSSjE4dWkxRVZ6ODRZa0VsamtHS0R6TjhGZUw0WEVITTNYR1o2ZGdjTE45?=
 =?utf-8?B?TXA2M2s1cC9HS211WU9qYjFEVTgzVGR2aFlWSUR6U0hXSVZHTVNzbnE2WHRV?=
 =?utf-8?B?R2Z6dWdidXZpZ0laSXRBeERUdlowWSsrZjJWT1VYdVF4VzNaRDVvTnpSRU1i?=
 =?utf-8?B?T1N6VDlzc1orNkxjb1FDSEplS204bVpSb2JFVVdnSjdNKzZVTForekxldEs0?=
 =?utf-8?B?YTg0YmxXZmxqcWxRb1NhMUpISGtHalo4NlFjWHpFVXI4S2phZm95c3VLTWxr?=
 =?utf-8?B?VjFacmtkckdXN3NBQ1M1KyszOEk5MGNxdGl5T29yc1BUK2l6dzdaZ3UrSzlm?=
 =?utf-8?B?TUp1ZkZ0T3l4alQrYlpJU0VWcGtGTGlMZGt1MzJSK1dKK2dXRVh1Uk5kNDBE?=
 =?utf-8?B?RnJaRTFpTkhweVNNbTIzYlExRFg1aG9NcXNXbWVrVDVSd3dMSkliTUNSZW83?=
 =?utf-8?B?Zm5mOHV2SkJnV0ExTGZibVJVa0xZNHE0L0JpSWlYRVE3bVhGaGZhU1MzbVNy?=
 =?utf-8?B?NG5jUVVNT01oMEtzRjRZUUNvdENUa3ZKYlozRy96cnB1Y1ZnT2VtK3BScXF2?=
 =?utf-8?B?bUdzV3A5MUhUYXpyVmEweEhBRENpajNpMVdocUs5Zm5URm1MTDdrYU05SUd1?=
 =?utf-8?B?M3VCUjJsMnA0MHVGSFY2Wjl3WlRvOS8wOTY0SG5MT3dFdDlEbStXdS9rOEo0?=
 =?utf-8?B?UE45OFN4ODZranJIMG8rY0M5THBFWk9rTndXTTJDUXBKV3RkdGhWbEtwV0ho?=
 =?utf-8?Q?/O2O3Lx5DDdpHgO+BMt/Lu0=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b52554-d3e2-4ecd-62af-08d9e1bae8ad
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:31:53.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6etF7MPITHgle9BQJHiNJXx5qT3aroDlLXslbmG9z54kNVfrvC4dOkckEasSzLsoxdVldsLc+6W/h3//f8PurA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5953
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 1/27/22 12:23 PM, Christian Eggers wrote:
> SoC: i.MX6ULL
> 
> After upgrading from v5.10.65-rt53 to v5.10.73-rt54 I get two additional messages on boot:
> 
> ...
> [ 3.786333] alg: skcipher: ecb-aes-dcp encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
> [ 3.789020] alg: skcipher: cbc-aes-dcp encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
> [ 3.793741] mxs-dcp 2280000.crypto: mxs_dcp: initialized
> ..
> 
> After reverting the commit
> 
> 2e6d793e1bf0 ("crypto: mxs-dcp - Use sg_mapping_iter to copy data")
> 
> the error messages above disappear again.

Can you try applying the patch in [1] on top of your revert?

--Sean

[1] https://lore.kernel.org/linux-arm-kernel/20210701185638.3437487-1-sean.anderson@seco.com/
