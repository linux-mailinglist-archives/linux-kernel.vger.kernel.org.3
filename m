Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0611A4CF3A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiCGIdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiCGIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:33:49 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2F635D;
        Mon,  7 Mar 2022 00:32:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7Xq3vGySDcMPdOcl2+J0ZHVDba5ShuYAwf/IMTmfeuHQkJvTJXM7QE+nhM16c1jdoCzyXzjArCCtIsDQZw5yoqwOjgPbax/mulbr0SxrEm13NKCYPjvJBlGp7LWPiwxMkFSETRpkyeASm26BG6/3nEmzwFnFHxUVRX2AOrQZkCYFEtJimGMAh5rfONhsG09hudu1ZBFNv44eizg/nNyRabm64hMvKnq6EUQV3W4iMfCzJg7FU+nD+ydNIfiU1N+vVIMsqQ7nuySDVGdqS17sqf5mRiSj0PIsc2/tTOEcbO6nmZ1YDrVVI4XK/G7XbdELBOpqqjfurIBcXSqFSWEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejNFzhyq3rLVYygfcN1fEvoQOAGjXiqFUPdGEhfGMlI=;
 b=erg2WmoGaWqSAZZoWZS0NBC9oKpsFAwOzEkZM1R/d768E82TNSIqvEpYRCYB7eUZ3QDo8uhbGCjdGgYmagN4/4DUqodJ4jtb3+9bM7f0Re6Q7CpTwrFesuIZ8CDNbaMrq8wL5ufpHwwcmS6jw5aw7lOBdBOzNwImrxMJfNSaELhlC8k36Lv3hbvILd2u3df0KZPOC2h6t5aAu9plSvHvSOM3Z0byN08ttJA3/ZsHGX98emaD/7FieC85LGmprz8VWxnJe5zTYyUIiw1yY/Jc+IBHWUZRTSa3BgIhiPUEbjh3ksxkaFZmsRsiy5pC0uomfbVfWiDyY225Z9O2KUSLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejNFzhyq3rLVYygfcN1fEvoQOAGjXiqFUPdGEhfGMlI=;
 b=QBzxMHYseXHgieFQczn4WyYqAQciOtXQUnbxSOdpGOrKmJZZxxU8BQUvsixmXqORZ+RwCzZqRim0QF1WOOtMj/C+6rhtXb3i5Dm58+5yQBOJaMR0WFObg02xCbMRxLu3D3tjZ6cj3z8UbsVqFi1J7/aZa3I/Wf89nmCVwbuRjbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24) by
 BL0PR01MB4660.prod.exchangelabs.com (2603:10b6:208:75::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 08:32:50 +0000
Received: from SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6]) by SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 08:32:49 +0000
Message-ID: <51603aa7-4113-dba4-9a38-0a6683a1d249@os.amperecomputing.com>
Date:   Mon, 7 Mar 2022 15:32:36 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
From:   Quan Nguyen <quan@os.amperecomputing.com>
Subject: Re: [PATCH v6 8/9] misc: smpro-misc: Add Ampere's Altra SMpro misc
 driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-9-quan@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <20211224041352.29405-9-quan@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:203:b0::33) To SJ0PR01MB7282.prod.exchangelabs.com
 (2603:10b6:a03:3f2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd29670f-9adf-4f39-0f28-08da00150feb
X-MS-TrafficTypeDiagnostic: BL0PR01MB4660:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB4660613DD98D6C26EAE3CFEFF2089@BL0PR01MB4660.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgJXKxgCfy/EMPnIE7HrOEdj7KemYRQs5ZstODwyd7K9iI4ogLyl0ANbRws0gpP6BuHay3Rul9wQDVit5AZSpalDB2PiSNvb7mAeSVxEbkD1mN+vsLpP9MX7xSsMlvlAX3s9ycoG9CB3FwbksLiVJud463UZb78jeRPbmcGAtckTdhq5SsbmFDyEBZMCZstEj9LbpVDD1SAA20YFMB0Sh9TIUxnq8KLRYq1fms6AxwMrAUq/oj3hPkGGwFwcuVe7ZAYflS7Ic7dLGYPAheEDaSbpwcnLdzG7/lec2bKhSUt3SF4KoaQ6pWQhVVCtacHS6GttWkulCqdLVTLC55iIMRAvGuiSh09w8WRZUNql84YCE8LfmVuGviideBhKfkPCr4cd8qWHc2ZunNg8cZtDlnS3YG/cDRieBjSO78kMczMXDvnZDHhn7Xew06KJ7GW0cmCy06gzzbs1wf0vpgX0KEEhL1z5dS6U+4+esL4dEovwt4bU+5iE/FpdH+D0azNaNB9wBpdjLLoZ+Y+h4k114cFCpZToZcpbafoLG6pKsOrHnyyh35ytPTkZBzAkHBgMhJ4Q+a8aMulPZUSMB4b20ErPXbPhoaGkdfOjl2Djch73NKIZVwd41JieArSNFTKqb/uw8rr9c2v0fS2aHTu0J+kPKUTMNwi4DG75CdWkYE8m1Bzce88shU5SBct4BVahY386yCdDJrK9JwDP1jIgRpMDgEcXGExsTq52pXaPDThzVidI7aUhngid2kuUwyv/ZkFx4HIxI4MMWrWl4oH13X6XUE9sw9FbHrDgxSMPaNkq9VMDTWfGlPqQzmkkZiad
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(966005)(6666004)(31696002)(54906003)(316002)(6916009)(6486002)(66476007)(8676002)(4326008)(66556008)(86362001)(186003)(38100700002)(38350700002)(66946007)(5660300002)(26005)(6506007)(8936002)(53546011)(2616005)(52116002)(7416002)(2906002)(55236004)(83380400001)(31686004)(6512007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0h0NGpWb2xtZkpsZW41eHVITFdMMDFsUHpuVmYwMDdxMC9PZ01OdDhLczFu?=
 =?utf-8?B?ZDVTd0l6NU1vOFNXRFB0RDhEQU5HM3pQVS9ZNGg2NVVsNjRMNFQvS0NRQXpZ?=
 =?utf-8?B?anVtVzdGdlVNTXQ1VG9RVStBN3BzVXNic3RPRHJHa1pTblN0OC82UjMwMkgr?=
 =?utf-8?B?UzkvekZqM3JGNTkrKzNiZ2N4MzYzT0pURVFWZnhLcFQ4VFVvZDdIS1prcEhK?=
 =?utf-8?B?eUJMdCtUUXJBMDQ2eHErLzRQc0tyVmxDOFVHcVNtYldmUHJxTjE2ZnE5YnAr?=
 =?utf-8?B?bG1rcE9DUUNvcGl3MzFBSmNwSlFRNG5zQW9DQURJeGQ4eHh1Y2ZIRkFGSUlj?=
 =?utf-8?B?em9mVGVZbmpiV0h1bDQ4ZXRuRGRqUGkrZzl6VFJQamIrYXpHdmhSdEdpTGJp?=
 =?utf-8?B?cXJtQjA0QS9XWEw3NW9WSC81MTNsTGpsK1BybUhtdmtCSzBKVDJscmpUZjFJ?=
 =?utf-8?B?V3pSSTY0Z2x3dEpVaXJZRVVDb0ZrdTUwa2x3VkcybUxoZTBaTDMxdVFsOHZo?=
 =?utf-8?B?T2hXOFZ2akRFU1Qybis2cDhGMGEvbjhtRVp0QXkxMHd0ekFQZStSUkUzSjE5?=
 =?utf-8?B?aEJSUTc4eG5XUG5YRnlqVURmNW8xeHVQUTFKZHpDUisxNWdvakdhK3VyUnhB?=
 =?utf-8?B?WGV1NVA0eWwyTDVxeTJXRWZuRENwTnlIUC9CYmE1bUN3anFKdWhrSDV1ZXk2?=
 =?utf-8?B?OVlMblpsYUtIbXJYbkNpeVJlRzlFTVdKcHdhZEFyeWxsdjc1TDVBV1FneTRq?=
 =?utf-8?B?OXBXUDRvUStiTlJiK2pSLzY3Q1Z6WlJ3UmlvYjRBc2FrZEk5SjVtMUlQbXdI?=
 =?utf-8?B?d2gyYi8xM2JTVC9wQVQvKy9HcmZ0V09CMmRzcTJNbWFOK0JLL3N2RGxadW5T?=
 =?utf-8?B?YmE3M2o0TmJjcXIveDdWcTR3alZmejF0amRCL1JyVGc1Qzk1MjY1VHJWQ3FI?=
 =?utf-8?B?MFk0T1ZNMTU2WlF1Wng5QjY4NU5kYUxYUXBmY2FwckV0bGh4QVNWSzlSZkhD?=
 =?utf-8?B?MU84L01HcEdwdDREM1pkL3FaVjNHeDF0VlpwdWN2NUZsTkJjUmMxd05aek1r?=
 =?utf-8?B?MjFMUDFMdU5SWktOSGtJR2w3bGhraWhZemZ0TmxDdm1Xa1JaWHpxaVdxZkdP?=
 =?utf-8?B?aFBOTHFtTWducnAyblJLcytDV1dEMUY3TDFnR2dUUFFacWZBUDFpRVNWdC9S?=
 =?utf-8?B?d1RjWlFWS2g0Tms4cUFqM3BMSHBFRnRoUWxRN3BLNytlYU00cnRlei96Tmcx?=
 =?utf-8?B?b0ZBN2ROZjdmWUpHRG95KzhMSXNiV1lJNDdLeTNBYk5sWUp2bXVSNnpYYVNG?=
 =?utf-8?B?SVlGdW55TjM0UDc4enZIbmxlQ1BnMDZTS0R0OGFENnBuSWRmN2VMR1VkSm1w?=
 =?utf-8?B?NkVZWFp6bEtCYnRTNDYzTm1qbXhFZHJtUGpmR3YxL1JQVVdKUVVFdlpjU3Nn?=
 =?utf-8?B?dVMxbjc5c25PZGFSOHJHQTA2azR5NFVTMFpneldLaXVINVBPa0NkNkVIbnF0?=
 =?utf-8?B?UFI5Y1hxS1dOeE1mN2JzRFZGY2c0aUJEMWpyKzh3eTBTdnp0U29qSkVNWVlU?=
 =?utf-8?B?Zk9OeUVqS1lIc05QK2Q0d3AySmRZNE8wR2VxcUcvQXlTUHFnOFI3VzNjS3JY?=
 =?utf-8?B?UTdIU21HQldsaUtZeXhsb2RMSENjLzZZeEU1VUpjWkFuR1pyUVhiakIxS0xm?=
 =?utf-8?B?czhVVGRBMkZjWER5eG56Q2RWd3VoR0hJNDEyVkd3RnRxY0JkNkFDY2hJbFc1?=
 =?utf-8?B?ZnRQTXNqNURwSjl5N04rcEYwczVBc1RDRStRMnAyemFzaHNhZlFIYzRIYlVH?=
 =?utf-8?B?a3dxSkFZbjFnV0VlbDVaUDJObHk4cCtGZWZqcDMvRkNOMC9uVFV1WVVjR3Zo?=
 =?utf-8?B?eWxlZ0toZkQ4ZENjeTd3ZE9HdG9IeVVuVWZueTRCYURjaU41cnJXQ1FvbVZz?=
 =?utf-8?B?SVRxNUJKVFRnV0VKUGVpc3ZYWTFIcmtaWnVwOTYvQmtxVnRuS2x2VC95UVZB?=
 =?utf-8?B?QnRWVzJVakt5RDVXZjZkZEhETndtNEVLWjhrVkxyYzFSa1lqWjZJMW5qd2I3?=
 =?utf-8?B?eE9udVo1SVhjN3daSWNNa2tmeWV3Y0N1NGpNN3YrUzNYY1BkWS9TVi9taFhT?=
 =?utf-8?B?VkJwRWhaUlBLaEJ5dXVKTkF2bVIxTWJQYjlBQy9kQzczVVJUakNBbC96S3pC?=
 =?utf-8?B?YnZkVEpSeEJjWFRQanc2WjhvZWpTMFBuSkZ1eUppSEJmUkpDSnhGM1NNVUJr?=
 =?utf-8?B?OThkNEYrQWpwRVI2VlRqcVVRcVpBPT0=?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd29670f-9adf-4f39-0f28-08da00150feb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 08:32:49.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSCJDKdxqVXKHnEn5CG+upqMv8ua06Fva7R+8UskyGArnPfNaCaxGiPX7jteZ76CI7bhlM4WS6ds3wM3WLz573NRta5Ml3kw6ItWZgdDSns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4660
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Lee Jones,

This to reply your comment in https://lkml.org/lkml/2021/12/29/121

Thanks for the review,
- Quan

On 24/12/2021 11:13, Quan Nguyen wrote:
> This commit adds driver support for accessing various information
> reported by Ampere's SMpro co-processor such as Boot Progress and
> other miscellaneous data.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Change in v6:
>    + First introduced in v6 [Quan]
> 
>   drivers/mfd/smpro-mfd.c   |   1 +

[Lee Jones]
Please pull all of these patches out.

There are no build dependencies here.

[Quan]
Will separate this smpro-mfd and other child drivers in next version

>   drivers/misc/Kconfig      |   7 ++
>   drivers/misc/Makefile     |   1 +
>   drivers/misc/smpro-misc.c | 177 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 186 insertions(+)
>   create mode 100644 drivers/misc/smpro-misc.c
> 
> diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
> index a7cd64bf9eaa..5611dd30f8f4 100644
> --- a/drivers/mfd/smpro-mfd.c
> +++ b/drivers/mfd/smpro-mfd.c
> @@ -28,6 +28,7 @@ static const struct regmap_config simple_word_regmap_config = {
>   static const struct mfd_cell smpro_devs[] = {
>   	MFD_CELL_NAME("smpro-hwmon"),
>   	MFD_CELL_NAME("smpro-errmon"),
> +	MFD_CELL_NAME("smpro-misc"),

[Lee Jones]
Misc is a Linuxisum which are not allowed in DT.

What does this driver actually do?

[Quan]
This drivers is to report the boot progress to BMC and allow BMC to 
configure the Soc Power Limit of Ampere's Altra family processor.



