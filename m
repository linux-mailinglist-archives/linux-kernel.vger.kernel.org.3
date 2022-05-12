Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD31524876
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351644AbiELJAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbiELI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:59:55 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10096.outbound.protection.outlook.com [40.107.1.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1411A53A5;
        Thu, 12 May 2022 01:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W72MlUZ5EA1fTERZqfcmt2gPr0JJQb5sGOKpIRSP5F7IjSDgDSWcmBNnWghcZZMRnfx5IvTR8eFa+OYxnXOfXI/3Me5LgeUFmBlBd+73QrwpoDJzaR5qdt6aPLnH46738lc6kFLZQaEdrk2UodzyrDeCesBoXUjzWJeIkkE7rC+NspJj/4VjFHjyo2Y2Lody21bOjkFecMjVOFdEfpgGKcJ2+aEGlvi6ROcjpcA/wVymcmusHFqfNQujLFDRjRkqJE7M1n71ixp5bioehh2Vt8sPmvo81l0p3ENFHoxVKEYk8H65CmMVdW27NcqaWqfwA8DaC0BCkiUKKGFbwaIDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDUyTTfK0KEHSqFhirnyr7bVIjnoVST9DYo8yd4lNP8=;
 b=B8MvqQEsfRhdCUkCPunY78CtaGwGfxbilg7PhWd2L+cMNx9A34iHxLPtpTvkDAL3bsreCiIYUrXsxYwsIwueYkFX57G/0G91KkE/SJPvDLh2hdVLFwLpDwP5F2+cFaYtnIShd1P/7fQhWu5fhnTq2zERL6IWoQV7sUVE1Nl2RfgiLo4YbkmYbI/nlo/BSgJSnw+qWQ/gl6NUwFFmveWmVCTfoRuY/rwFMbSDa4imrkuJv2Ct+LRRXLPHvghmoUe/XVxZZ3DOCxE/RJUa023LuH18wJHj5Q0Jmq7XDB/LcXBXp4It13GOY9gIwI8AMWtJ0KAeyhD6p8GXAN7YAAjdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDUyTTfK0KEHSqFhirnyr7bVIjnoVST9DYo8yd4lNP8=;
 b=R2K4PH9WZMv+jNnElKgBpcpuOjldhKqcGrMxteuYh4JCGT/+tdK1t6gQGr1VSM9wC1sYenOeZR7oifm2Gd7VbCQgzSgbhXISYVI2R+Z1AUz/Xns89Vgo34bvB3owMkrQZgkPu7dfqv3BeFS1Ait7g/7/+PfzqGrwEndKzAkEB+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM7PR02MB6370.eurprd02.prod.outlook.com (2603:10a6:20b:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 08:59:50 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 08:59:50 +0000
Message-ID: <06546c40-639a-01e4-ed99-4895edfe8211@axentia.se>
Date:   Thu, 12 May 2022 10:59:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 0/2] Add support for texas dac121c081 to the dac5571
 driver
Content-Language: sv
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <42db911c-5eba-0511-3e8c-8011a2a5b44a@axentia.se>
 <20220428204439.4ec2b4ae@jic23-huawei> <20220501190349.54aa48a3@jic23-huawei>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20220501190349.54aa48a3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::11) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 840e8551-e7dd-4a6d-beec-08da33f5c5c1
X-MS-TrafficTypeDiagnostic: AM7PR02MB6370:EE_
X-Microsoft-Antispam-PRVS: <AM7PR02MB63704C21BDBB673320C98848BCCB9@AM7PR02MB6370.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkn2dwJC4xBanuSW9FuAyIHLc9ro6kDUn9T62nXwJFtIUA2g2z1UA+VldV5FimiiCZqJjSucxGwoAxb3TsnSWgdXdQK44fzaCAcG61Uvt15R61GuyXSNE6W5ZZFRIPfsuSRuGMIWUzyCHPMvXmw13W7zOwub2QvEy89IT/fsrHoxbb6XOcKkgGV0iFPjknvflkQBy80ncUtA8eJbf8qTMtlYKNO3DcStCah5HEidSXKwesjI2w7U/QszmFsTJsSIVkWtZK3hLiQ5oI9rD/rbw+zixw+3e6ATu2c/dgGERKxBZzhZ548pYnx/3yNNc6tUk0cQ+g+k7x76Tmf+SmG+L+JL0c8u2OCFjhaGzByLcsWVtThuG57Gk3uaus6F9MnniAe8TZn5hbf3OKzyaIV+lTQIPrCsC9DxVfBJES+/aCE6HDf2LBEH6SzETPqPUrd/MCuvwo9AOPS84jTcMrQRT5llm/Rjpi0ePGLTHihlMOJotk8G7MQG01WS/Ti4b9wlj2fCS3s2JjP+rkTodlz+CG3DjzR1Lbq1dLumNFRk+CVHpks1TdQJLkXsi9uZn8iCLNVf+tCu5WUHKgs9Sp9YJwTpXI+5wP1Oyn1eli36E8OslF/+Wbg/m4g9b3/yXPRv0hK0RZcR6lZpn/LsKPQYys4zXB6hfAonpW9CoL+beNANQm0qmuBe4lALYlhod2kNfa1L77tdHth+VIP7OlQnuz0FjKjOpDkuKtIxsZsCYQgNEHlf5PO2Q9w67PqNE+SZvAefoGYHODCwmjRHfz/mdzr43aa4dV8fUqqz0caAmEUSLRM3Lo7AtCnB70jimNd2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(39840400004)(376002)(366004)(396003)(2906002)(4326008)(508600001)(36756003)(38100700002)(66556008)(66476007)(5660300002)(8676002)(6512007)(66946007)(26005)(31686004)(6506007)(2616005)(186003)(8936002)(316002)(6916009)(83380400001)(54906003)(966005)(6486002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1h1Z1FjMnlobzhoRG9melRSYUJvTUhUWmd3WHVnaDhndmFXSFZZY0ZDRTJW?=
 =?utf-8?B?S2xCZzNJZnlnMjdBOHI4enJaMCthMG95bTJsZkMvQ0psS0FVM1Blb3FsMUpB?=
 =?utf-8?B?MUNVVkdjZjVEOHhtVDU2OU84T04vU1JGOUE3dXAzZEVLQ1pvRmRLNnlVcFBY?=
 =?utf-8?B?Uld5R2N4UVdUWmlxTWh2akFlSzluTkpzZENMejhCOGREcTQ4UHAzalA5WUUw?=
 =?utf-8?B?R2gxWk1SNHZPQkhUc1hRN2FIMlNlam8zWTNnbmlQNUZQS21CZFVreFNJNTM3?=
 =?utf-8?B?ZVVhN1ZkY2cvem9lNDlKVkR3OFUwdmdaem5WMXMrRHhLWmptRnp6WkZtMmNw?=
 =?utf-8?B?c1Z2bldMZG1kVS9QZWZUQWluOHlxaU5sS0x5SnA5dS8xbm9tSFYzSzZXN2x2?=
 =?utf-8?B?bzJEV1FsWEhoUmFnNWJKemk4S0g0VC9sbmg5bjg3WkxLYzNpSFJPeVo5N2VH?=
 =?utf-8?B?UkZxdXFJcTBwZXoxZFR2NUdBWEhtSlJiUW13RC8reFV2QkUzQjFMOEt3eWNP?=
 =?utf-8?B?MCt4SldRVFlhNUJ4NUxieTVEN2xTUS9NUnVIcG0yak9UR25qZEJMZ1QreTBk?=
 =?utf-8?B?WXl3NHExUlFaa1RhdEt2NlRzWmdoQzFqWkwxZ0x4dVZLdm5CTGQvS3cwRFhX?=
 =?utf-8?B?Unl4bUlvTEV2Qk9FU0R5dnVwS0lzWDh0ZFFjTy8vL1p3WkQyVlJic3EwR0ZM?=
 =?utf-8?B?SkRvWGRLUVBDMWV2bjVDSkFxc3RqL1lFRHBsdzZ3eWtzUEgrT25lTTByKzZ4?=
 =?utf-8?B?NzlsblowUnZSMzdaZ1p2dXB5NXRJZkFSK2hxcXdUdGxTUVJUZFdwU0JzMjlZ?=
 =?utf-8?B?UVVrcnpWL3FaNmZ1WkxOakpZVlZDcGZqQitHbkNhZEQ5c014WjFWRFZKV0VI?=
 =?utf-8?B?SkI2VjAvZzRhM240RmNGdzhaR1p3bnBieFlGZ2xkampuaGxaSXRvRzVJMWJi?=
 =?utf-8?B?VmU1eDMrakE0VFVNbkVBaVhwZ2pUTkZKN2ZNRnpHa3A2empiU251ekplZWw5?=
 =?utf-8?B?c3FkNDhuVnJlb1VqcTN2cWZuaFFjTGRxTXhaRzNBY085V1BMMWlFRFd4dGhL?=
 =?utf-8?B?azZWYkZMYmNZZkt3dlFPZmdHWUhFNjJEYkF2QVdraW95SUpXVUpoTVVPMUN4?=
 =?utf-8?B?aTdyaGtIdGJoREZVWUhieWJzUzd1TDk3WnpqRmRLdFNwVzBwOU95a1o3bE1x?=
 =?utf-8?B?VXg2RVphNEROTC8ydENpckJwWndSc0JNT3JuQkQvWUQ4WllVTEhyN2s2RUgx?=
 =?utf-8?B?aW1TSUxUMEpvaUpBbUppSWRaVE9NT0JRM2JneG55YnJjWDZ2RkM3RXFuNHQv?=
 =?utf-8?B?c3ltQ3YwVHRyQ1hCL1ZzVXVqelVlV1RSekFUUDVOd0dzQUJza244dm9USnV1?=
 =?utf-8?B?aXdYVmlYUmRWUkxPZ2NwVDJLMUFibEpLbE5iUUxhai94azZDR0ZhSjdhZ05y?=
 =?utf-8?B?NmlLWVh6MzlIUUtoZzhoeDRKSnI3QjRpdzlSWEY3QXBqNUZ4UjVxMTVVQzd4?=
 =?utf-8?B?bW04Y29vbXJLWkgxRlI4aGVtejBnRmNJZ0V4TFhQM3UvZHA1cTNDMmRLVlFu?=
 =?utf-8?B?RlRrMVFWNG9aZlNhYitNbzJBMnlVd2pGRFJsOGp5Q2xtZUxKSlYyK1lBdXJL?=
 =?utf-8?B?RVRPeGlXSWJ2ZmpHallmOVA3NzZmRklTQjk3Q0pIczdkdG5hNFNrZWhya1Ur?=
 =?utf-8?B?RHZoTDZ1SVhCNmhOTFRKVUU5anhLTmFnRUZBcjZ3SHNiZXhtN2t4TW1UV0Y1?=
 =?utf-8?B?dWdRMzRPWCtZYlUyalJtN0RmU25rT0hqNlZZZ0NSRHhaK2dLRnFOOW1JMVZJ?=
 =?utf-8?B?aHRsbDFVNHRLVG1NMS9jUTlEQ0Y4RGZyTXJvZHU1bk5RYXUvVVpOa1cxcFYv?=
 =?utf-8?B?N2k3QituWWVhWEs3RU5ObzFxcG53V1psM0FpU2J5OFRxZTJZQ1EyL0JITWR6?=
 =?utf-8?B?UGhvTXpjN1FFWk83cGs4RHNoZjhwMy81VS9YUU05eU85L3NQQkx6aTlhVWZ5?=
 =?utf-8?B?ay9nR0o2R29YUnBmZ3lzQjhHcmdibXMzaHM1SitQajB4NVBDaU95VjcvVEpG?=
 =?utf-8?B?ZHhJTTBqM2g2Ni9sYmNqVVZzQ0JTR1pRbW14Q1JaRmdDSXNidmRnNXViZTRM?=
 =?utf-8?B?djQ0c1dwOEpKWktwL3k0SVZaK0xnM2hhb01rV1hsTjRvUUxldkVpaU50cnpq?=
 =?utf-8?B?eUMvaHBxZm9aQXpmV1FWRXJpaXVmMS8xekdrZStSLytscnZLemdHSmpsbFRi?=
 =?utf-8?B?Q3hpWDI3SmRLQi92Q1FMVFc2RzJEeGpQZHI4Ylc0aGtHUVpRUWZWblY2MUJN?=
 =?utf-8?B?cENWZ01KYWNNdGhxV2FhRDU1RlNQcDhSUnNHWDBvOGN5NWp0cmUrUT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 840e8551-e7dd-4a6d-beec-08da33f5c5c1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 08:59:50.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlasRBHnLMQDJY24eXbgL8pssI6vxSZ1VEb6hbmZ3hHkQllu8/4gjE9j5XsWL+MO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6370
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

2022-05-01 at 20:03, Jonathan Cameron wrote:
> On Thu, 28 Apr 2022 20:44:39 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Mon, 25 Apr 2022 22:46:30 +0200
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> Hi!
>>>
>>> The new chip works much like the other chips supported by the driver, so
>>> this is just adding another compatible to the list.
>>>
>>> Chenages since v1:
>>> - Guenter Roeck noticed elsewhere that my mail setup was botched and
>>>   that my patches were clobbered. Hopefully fixed. *blush*
>>> - added tags from Sean Nyekjaer and Rob Herring  
>>
>> Applied.  Thanks
> 
> Backed out temporarily because they have crossed with a fix (that I'd
> forgotten about) and were requiring a non trivial merge in linux-next.
> 
> https://patchwork.kernel.org/project/linux-iio/patch/20220324234340.32402-1-laurent.pinchart@ideasonboard.com/
> 
> Hopefully that will get resolved in my upstream fairly soon and I can
> fix this one up whilst applying it myself.

Looks like it might be time to bring this one in from the cold?

Cheers,
Peter
