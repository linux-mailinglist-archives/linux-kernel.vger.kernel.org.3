Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D3D4B1367
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiBJQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:48:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244775AbiBJQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:48:01 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70127.outbound.protection.outlook.com [40.107.7.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9520E9A;
        Thu, 10 Feb 2022 08:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9IVkzW7y97Aukh+HIduDGVjVa80hP0tYpEfFGyvObLEtUkawccut9VQQ18a+a6wwS2G7/CsCGuov1ft1ZXGeSy7rB9877brDoYEE1Ksqvwd799Usj6b3pF3YRZ8v7E7yzQv5sMTqBflN91fFAdH5HW9JhkBOb1I60IGf0TGeoOVmAJinjL+7dA3Ee1DD8c3oMPBEqSlFC7USGO2RQObvKEYZOBkWpN+xp0XizkpEjI7L4j9xm93V3XO6hawh4gU6ygxz0IuY4NDTHGETkyGJeXYMlT/ipvxYWmBvCwVlloFdW008pd6Gn2AsyQcvi4rqPPz4tzCkd37Lt6dqV25Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGdnmHcrSklDKQTu75tx/sVDZJBqyWUBddohJisTSdU=;
 b=XJ5u6gBLLa4jOrtj0JZrda62Zgg7B/9qJDwMuNSdLONGZyuZQtB9Z9o6xpV9YG3T7lni/AgTGEeV+j8EEpPq2m7ENp3f5xtmaH3aPdpDm7qGWLRMh71b1x5rziMBCDYFFKW8Z4y2Zau1rn9eA8+En2RNpUN+SKD3eNNMfDsOSiMnEE8gARCBtR66x7wEusStuMY+h6F5XaQ4k/5Fdn7GnQPGuT+cs8QZaMMEf9KFpkRW6Jw62p8HWuRP8DyB1ITuXdTHMIgP6qgOReiK9Ypd+jqNQqGtlX4uDo45vGvulxUHNCNhVcEwlOcdSgV2Wunw/1vo0VipsFWD4JnLpVATQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGdnmHcrSklDKQTu75tx/sVDZJBqyWUBddohJisTSdU=;
 b=WOCTcSCw2z8fmouAE0fOBHWq829XYXs+ixtoa543VLSfl7UhLMM39U4Nfaduhw+P0B5cWpGBCPqBDW19TKleoG2fdYwqwmXDKBDPTbSbhzRuHnrRPqP7wsbc+1JdPAvQVlL+xATeORYctNCS9eJHfR+GJAZmzQve+Fs/G2g0UmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by PR3PR02MB6441.eurprd02.prod.outlook.com (2603:10a6:102:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:31 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::dcfc:1278:ab19:ed07]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::dcfc:1278:ab19:ed07%6]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 16:47:31 +0000
Message-ID: <adb275f6-07bf-1468-b548-df944a25dbd0@axentia.se>
Date:   Thu, 10 Feb 2022 17:47:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v14 03/11] iio: afe: rescale: add offset support
Content-Language: sv-SE
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220208020441.3081162-1-liambeguin@gmail.com>
 <20220208020441.3081162-4-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20220208020441.3081162-4-liambeguin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::20) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b2349f-8e23-47ee-c33c-08d9ecb507ae
X-MS-TrafficTypeDiagnostic: PR3PR02MB6441:EE_
X-Microsoft-Antispam-PRVS: <PR3PR02MB6441EB2BFA80B8CC882EC4F4BC2F9@PR3PR02MB6441.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SOOPChCp6FOmr2o9OuNUNVN5TbCJ0emhavXbV1sBz9JyJddgqz4CCi0ac4x2dyQS0d8LbKvcH6KpCPgVeJ5VWQj2KFtGIC3rSKP9yWaca7xrLJHfECAWksgPT0KxIuPLsEzl/6pwXnVH6ZwYCZPZa24PZG6/Lsbuf2LtoRhDy0P8k0leTep7d+Xvy345soOjam/umhoTRHdoVmdqVD8TlM61BRkRk4NhXps/DWIJvrQS4m+UntXTu1dy5EQIktzTUksuxrDuOExkMmmlWJ4sy/S+uL8H3VGqib3nq3Af9wM7tny2Thas2QfCS7eRr5+ftRd8i/Po1IBZfUiZdI2XGsA6B6UYjt1AJZ04V4taju828pZFzfBy4Ga8didGfFcCQIwpH9fIgHz3JmkhAFEgdRaqPCsEVNMALsiC36on3AQ7228bCZEtJvdud27SKca/GN0QDIMiJ3V7aQpp0Y9ezFm44hZK6z5hlt8WfkhNkKzpPqcDZSX4Qxf/5oOZwKCu2U2uE/N0IHsXCBIIOsUvz/sFYfSVuCZRKT9YsWgmRjFG15SohBXYiS2hz/JCLBoUBIHQTvNPumKzpKmvSGgczQTEQFZ5cN2rofQR2A9VB89V9Em25qmvD6Ie/ObTm+93ekefmnogtDWG+R0Ptu3AC5c49IH7w77iFAzw/zRcj16FJCZs2NSlRlkoiv6yOjpbafViFE217//XPwzp5vxAdu1+YjJCwpgBmkJZCqU2cM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(136003)(346002)(396003)(39840400004)(86362001)(2906002)(66946007)(66476007)(4326008)(66556008)(186003)(26005)(31696002)(38100700002)(5660300002)(8676002)(53546011)(2616005)(6506007)(316002)(6666004)(8936002)(36756003)(6486002)(31686004)(508600001)(6512007)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJuc1RDY2xXNy9LcDRmdEMyc0F0dkV6ZjljUHgvZFRHN1ZGSCs5TklMVjhR?=
 =?utf-8?B?YVBSaEl5ZmpsUExHN3dBVHA3eFdxbmkrUEh4SmEzQlNMQTRSeUlQZjZpZVk3?=
 =?utf-8?B?Q2g1aGhTUTZienphSDlMTGxIb3dUaGE3UGpCVUw4dlhRTStPZnN0Tnc5K0o4?=
 =?utf-8?B?YjJtWE5mZGE5QnVBT1JxTnFtckZKRFBRbXJnZ1Z1OC8wVHdUSHNlMnUyc1A5?=
 =?utf-8?B?OExmMEE1MVRSTUhaSWNtVEJ4OXBMSFY5SDVpR2lBZXhpSkV1cmVYNTIwcFYw?=
 =?utf-8?B?TC9yUjVleWM0bnYxdU1qbDV4NENESm5QVllOeXpiRjFKL1BFSzV6UmNwWXdL?=
 =?utf-8?B?WnRrVVdLRTV5STMxWU1NNzhXZGV4OVpKN2Q3anJaQmlGUVJqYXNkOGl0YTJS?=
 =?utf-8?B?WTZTT2lpbG80Ni9xMk1xWTg3czdJK0Rwa0FGazhpbkRYV2hhb2dQT2g1bEYz?=
 =?utf-8?B?NmZWdTlXbUhHbnRpZFNMaVpWT0dzcng5bytqZHh6TlZ4QnczZFU2VCs2NXRM?=
 =?utf-8?B?M091eWI3blNFU3VUZTVpY2d3ZjdrdGphVmQ4eWt1NnhjMVIyQzhZSnJzT3FC?=
 =?utf-8?B?Z21ocmVKTkNzT2RwL0JJUkg2U2hPS2tIQlJCb2lwZnpzSmFKUjd2dEw4QzZK?=
 =?utf-8?B?NFN5OEpiU0RKVUZkbjBhaC9lTS9UNTAwS0VpUGZ3OHhrbWtsZDhWVkI1TmZQ?=
 =?utf-8?B?dGJDYkNyL05lTnkrVldLYTJ6eFJ3RkMyQnBUaGRsY09YMjB4L3NQWHZRNDNU?=
 =?utf-8?B?TkRVOFROaHJCbnk2TkZwMmg1bEV6dHdCSnp0ZXROem82SitSSmtkTUlTUUVW?=
 =?utf-8?B?WU1nYldaamxsMXltT3VyRGltSDR2aVhGbzFhaVVQVjFXbmhabktTR1A1dVRW?=
 =?utf-8?B?dUFVanVVbmtBK1FwZzZUb0YvaVlKOVpTdXpkYXl1MmJrb3BFb2E2WjZxWmYy?=
 =?utf-8?B?bTFyN2Y2bUEyRkk2NjRHWXZ3b0xJVGxDcUREQUdPbk54Mk1OTVBRbURJdVI3?=
 =?utf-8?B?MDE1cy9vSFRmNnZzanRTOU5LZDluNXRvZnJUeHZDYXFRNDBGdkxNaUlFVHd0?=
 =?utf-8?B?dHJqQmFpMVpqV3FDMENiMTZKOGNnQzVOeUZBMmRVd1gwUlJTNGRwWjFRcUw4?=
 =?utf-8?B?dmxJc1NRd0c3R0Fvbzd1QzJiWFJvVDR3VTk1VVRiMGp0aUFrN2paY0xBTk1P?=
 =?utf-8?B?eXIzSGNBSmd0OUtuNGRJaVdIYXhVRVhJTmpkVGFJZ0h0OUdGQ2lqTlNYSWxM?=
 =?utf-8?B?blRjZmIzaG11OURJdHN3bFdZVHZuTTdPM1hFTFB5OXc1b1ZLdVBHcmthNFh3?=
 =?utf-8?B?enYzTFhJNm5KRG5hUkNCc3JPOExDRjhCdGF5eVQvOTdYQTZVT2JDVFBVenFw?=
 =?utf-8?B?WjNmVWI4Si9Hd05sb0cveVRxZWxBckRBMnZuY2lIa0ZMRnYzalhYUkgxd0xO?=
 =?utf-8?B?RkIxMWlCVGtSa3FZQllVTW1Jak1CeW9KVURSN2xVdENXUWpSYWZZSjE0ZDVs?=
 =?utf-8?B?TEtiYkMvRkpwOHl3YXBRZnc0Z1hSVm00bkMveitLak1iUGpUU1VvWjlwRFhl?=
 =?utf-8?B?dGhlQ0lwRDJUQk9iSlhtcEc1eTBGUk1RcUJSekZBc3NnVlV3Vkl4QU5uRXRI?=
 =?utf-8?B?cmVSMjY3UTVGNXl2Z2IwTlFsS0M3bERkc0JDMVRKc0tETUFXbHM4N1VUa1Zr?=
 =?utf-8?B?dWhzVUs5NEEwY21YTTZuUjZqVk9TdTZkbXk1MDJqa1EzUTlTMi9ibGlMSUJx?=
 =?utf-8?B?c0FPUFBkTklPbmc4eDhFU05UcHVRK3haVGVuR1pEVitDUDFGbGhaNTlyWVRy?=
 =?utf-8?B?cjMweGg3WG9TTjkxZHRKTzljTjlxdUUzZ2l1MjliSnI0L2x5MWZEOTF0ays2?=
 =?utf-8?B?MzhDVmczTExYL1doMmRwM0ZoYllSSXpMWUZwQzJad0l6UzVMa3JSZG1GS2Na?=
 =?utf-8?B?czhzdGt3ZkJ3elpaQzB0N2hveDZTVkJxYjBvMjVaNzRNOXcycFp1VlJXTytC?=
 =?utf-8?B?ZWt0c1V5WWhyQUhQRUFJWDRSSW1BSEpHNVR2RzA2SW8ySjZWWFJNVFlrWTJW?=
 =?utf-8?B?OXNiaWpkREtYVzVxdU9kdmp6MmJuUlh5R2ppSVNBODFteUp3dm13dU5GejYw?=
 =?utf-8?Q?KrIM=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b2349f-8e23-47ee-c33c-08d9ecb507ae
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:31.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfO3cvg39hZhpWRyx/BlJeIDtgbizvxZNhCU8mqme7kl6UIOPkACJ6uy6C36n8GD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2022-02-08 03:04, Liam Beguin wrote:
> This is a preparatory change required for the addition of temperature
> sensing front ends.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> Reviewed-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/iio/afe/iio-rescale.c   | 81 +++++++++++++++++++++++++++++++++
>  include/linux/iio/afe/rescale.h |  4 ++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index f833eb38f8bb..63035b4bce5e 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -3,6 +3,7 @@
>   * IIO rescale driver
>   *
>   * Copyright (C) 2018 Axentia Technologies AB
> + * Copyright (C) 2022 Liam Beguin <liambeguin@gmail.com>
>   *
>   * Author: Peter Rosin <peda@axentia.se>
>   */
> @@ -82,11 +83,46 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  	}
>  }
>  
> +int rescale_process_offset(struct rescale *rescale, int scale_type,
> +			   int scale, int scale2, int schan_off,
> +			   int *val, int *val2)
> +{
> +	s64 tmp, tmp2;
> +
> +	switch (scale_type) {
> +	case IIO_VAL_FRACTIONAL:
> +		tmp = (s64)rescale->offset * scale2;
> +		*val = div_s64(tmp, scale) + schan_off;
> +		return IIO_VAL_INT;
> +	case IIO_VAL_INT:
> +		*val = div_s64(rescale->offset, scale) + schan_off;
> +		return IIO_VAL_INT;
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		tmp = (s64)rescale->offset * (1 << scale2);
> +		*val = div_s64(tmp, scale) + schan_off;
> +		return IIO_VAL_INT;
> +	case IIO_VAL_INT_PLUS_NANO:
> +		tmp = (s64)rescale->offset * GIGA;
> +		tmp2 = ((s64)scale * GIGA) + scale2;

Same thing here as in patch 2/11, use NANO or the raw number. GIGA
has no connection to the usage.

> +		*val = div64_s64(tmp, tmp2) + schan_off;
> +		return IIO_VAL_INT;
> +	case IIO_VAL_INT_PLUS_MICRO:
> +		tmp = (s64)rescale->offset * MEGA;
> +		tmp2 = ((s64)scale * MEGA) + scale2;

And MICRO here of course.

Cheers,
Peter

*snip*
