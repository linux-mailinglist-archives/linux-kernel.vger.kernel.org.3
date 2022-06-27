Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999B555E21A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiF0ORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiF0ORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:17:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70115.outbound.protection.outlook.com [40.107.7.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B5113EBC;
        Mon, 27 Jun 2022 07:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grKKNCPI1/sxuQe7aY7/UF1WN4W22E9ccHn2gErhunSfMJ1qsDj+XA1IN+5jVoKiNMA+U8bi4T0VGU3I2gQkT0YHj94o0lGQ3hZEVIvFV4PkLcT23cP9jOTzYKMYddq7KxeT4hJVoFFrHE7B2KP4dKQ0hd+Jnamjv2t0NeUpE6KeT+pufWRfp7YVnwfaKzHLCcN0GostIsSX/Ail6lvM05OrrB2PrFv9D/PaRZxuizOUnfjkImQOAUBkiqbnOe62+P1US+KBrIKsGQ9lV2YPaGj6O/YLpkR1t8VMNmP0s8Db+9QFMv5dVx/hHPRjVzHmwuFER4CmzoMU/oG3HSnmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMZz0P+6dRslXzUfyWFzD/pdx+bbyUqsHjl3YR6TwLs=;
 b=AvMqPuhymqgJ+JgBaRSygJqUYoOYpd+fSTcBnLMDdxmXvbZJbv9BQrryEP2BQ2VUoiIHn8COeAH05Uqt4G+j+5bSBpsXH8yGjo4yTG5oUyuYiqyIKvnnbnlAfnIJv2UxY4mJpIUtLdxcNLKbXrrbqGWAPGnU8ipGhDu43DffaQo/qudXcSoXTvKBX7TbrHI3izWtpXUgsPojolKOXFxg9cFPZvByMAgrQYtrxAw8RYIQyuiqKpdC08dVhjwlZAWFbpZQ+ktU9+KDo6TNiXtBE4fW9JGSjcQO75Bv717XJlm8O9A+uYjftyK1bEyGKYGekWFo2e6lYZ/49lyiu8y7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMZz0P+6dRslXzUfyWFzD/pdx+bbyUqsHjl3YR6TwLs=;
 b=e9JCbHgw9MDSUBn4l31o23Fd82s6eH0vK/uQt3I98IF8qovwXP7ICGRfcpXWmIMpkth9IW2/HiPTbtX7k1Z40jxlY4wFjHW0+WG2fXJixAXmnJKP+TRBUr/zNph0bKIPylUZzvX83l1A8S09ZLNzDFxvmQ1NCVQgV6jCVEwW+Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by DB4PR03MB8659.eurprd03.prod.outlook.com (2603:10a6:10:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 14:17:45 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::1580:fba1:651e:7914]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::1580:fba1:651e:7914%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 14:17:45 +0000
Message-ID: <5ff65346-ba7b-c440-a7e7-73c84fe13165@syrmia.com>
Date:   Mon, 27 Jun 2022 16:17:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 07/12] clocksource: mips-gic-timer: Always use cluster
 0 counter as clocksource
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
 <20220525121030.16054-8-Dragan.Mladjenovic@syrmia.com>
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
In-Reply-To: <20220525121030.16054-8-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0024.eurprd08.prod.outlook.com
 (2603:10a6:803:104::37) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c0044d-ecdc-4388-a1d2-08da5847ce45
X-MS-TrafficTypeDiagnostic: DB4PR03MB8659:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JMlaMNljFVtA1/nRkxk4sX5HgpeuGW95cL44tQ2oLp/9sYlIQue+aaipnw4CRCEunDwRkTVs/Mw5QkokgLoaPgLsB2udLFObPvY0w3eKaODvJdzEcnOrq5K7D13epLSNfh3W+vyDFT0rw1uPS1gAzCiLCc2oGhHmQubHo6o+bsymIKX7rQJKKGCnGDlC28ODQWKh3xNGdZjqwa4OIbS2gm1H4oPb4dr2sCBd/u+DajlnzMi3UCmchC6JATszvo8RZA6LFZDsiV61M50tNb0WMatWHMSb4fZqVbp4OmNH6cjfs+ni3t4FyeUKe0Zfwh3oVjiJGZ8jhZUStAKfLjDaX0T/ZgLr8PuboHEZyM2XsaTJqqzjG0BwboWWg9PXDk2H8tmWbJvmwM1Oia4Geln1726OmaYBBd8o+xreGJZwghp6TrYvxTpptKcVAnXQBwBCurUzKQrNrG5JuRVLe/ws5h6w9fxFH9RcHaro4g1cF5WpBxsy+Jm/KOpB2wOijhVYCOPyQEMX5Wi60S3eIfho2bdDNQDOzgqQLR/senQGuywE4xXm5EEWQ3nPXUutYzAx1d2WoM4lcM2f5JM8tMqS3MN6DpOByqXcNgerFPHm6Yy4P1j9iy/QppMAcp4MsV7buDQPHzCsOxkgZFchHEdnpeL+4OskRCirnSRA25z3mYXKWxeIYAfuK2SRJDZHKzdu8vr+m77MflNfazw/jQsdXgJlOqwpqfCI2O4+2svjD8Fv4bpexayeK9ha1H+KP93kPr2DcAbsds8xmNVdXOWubLXHR6rko7sUPPjabonO/s5OVOsAvSxwuqZ5dXYKuhCwSkpu8AlKa4lWoj9chy5bdvPgNt/LrENISPpeci+zpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(396003)(39830400003)(346002)(186003)(6506007)(31696002)(53546011)(2616005)(41300700001)(52116002)(26005)(6512007)(83380400001)(38350700002)(38100700002)(8936002)(86362001)(5660300002)(36756003)(31686004)(2906002)(316002)(7416002)(4326008)(6486002)(478600001)(54906003)(6916009)(8676002)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZpekYrT3djNDdzcDQwOWlHbkNkSnJZUUNRaFhpT1Fka0JVYTlDNVJPR1Nl?=
 =?utf-8?B?ZzVqdkE2VHpET0JBVVNpNE80RWVsbVZrdDNtRWxxMlp0VTAvYTlMOXVldmxF?=
 =?utf-8?B?dDJsY3hzRWZ2OVFxRmF1VlFPNlY0VHVPcVcwWlZMbDJXcS9WZ1RuNG13TW5z?=
 =?utf-8?B?NmRjS3BhOXFsZk5jYUd4TDN0djIxdmd3ZWY1U2NqZkNscG0zTTdaalVIdXM3?=
 =?utf-8?B?WmFsSFlTbk1FMHlqMjBteVhaeDR3S1Fka0hvYzk1M2ZFM3A2VGVZMEFmc3Bq?=
 =?utf-8?B?WlpVQnZLT0JaMTArcG4zOXFKdmQ3Vjdmb0NsOGJYb2ZFbVU3NVBra2FwcEJI?=
 =?utf-8?B?OE5hTlhHdmtDYXhyRFp6Y2txN2dLRFZLdG5ubTJGdkpMa3UrYkdCUWw1ZlVH?=
 =?utf-8?B?akt4a2NlellUOWIrRWkyQmk4NElGRFprS3dVWktKcHd5SWhwQW8xUjNUQTY4?=
 =?utf-8?B?QkVpY0hjclpuWXZ5aGIzUFZ5UktjL1o1NWd5dWpUUksxUk9rMDFUK0JxbzJy?=
 =?utf-8?B?cVdOaE9jWGFwY2YxcXVFL3ltalNkZXIvOTd1Rzhsd2d1K05MN3U4REdwK1dv?=
 =?utf-8?B?YVRtMmRFYW40M1RBYUMyN3VTWUh3NTE0dlhJeGNrUytQaUJhMkVmYW5GSDZL?=
 =?utf-8?B?Snp1bE5FQ0E0K2EyQVB5QkNkYU9uQkNMOFIwc0MvL2lrUlJHdjcxWWVlNjZR?=
 =?utf-8?B?ZjJSekl4UWVNYkV5US9HUFBuZ2tSSnhIRXVSTmcxN0ZmeEtucFVrZnRRRUxC?=
 =?utf-8?B?ZzJ3Mi95NlV3OFMrRUFUWS82UzIwQmlwQ0NBUzZyQ2trU2c2SVYyc1BZUjRT?=
 =?utf-8?B?R3kwSEd0MyszempUcTcyVWVjcG9RSU1nek11T3prZFRGb3RYZkRjRGkzR1Bi?=
 =?utf-8?B?TU81bW9xRS94d083WThENzJpQXpqQlVQTjlaSlJZLzJMY2JaUTBScUZOSkRG?=
 =?utf-8?B?Sm1KczhGSHpvallLQUhrckdpY3FmNWo1cHpHcHRLZFMvSXBhMTd6bEJqME8r?=
 =?utf-8?B?a1hvanloemdYa2crbUtBYjA5L21YZEdVakZ4aHorS3l1UGdYbkhHMjVhRUR0?=
 =?utf-8?B?Z29NSnZ4UWtGaXhnWGFWdUxydkJuamFCTERsVWhMTDhjcU5OaW1acWNiUEUx?=
 =?utf-8?B?VjlLUVIvblBBUDJMRVd5TTBNeW5nQ3RKdWs4NzJybHY0ekFUSHI1OVVvczdR?=
 =?utf-8?B?QzJNMTF2UEQ3MVpjRS9yVTcwOFdWUWRxWnU3QWg1WmJNRmcyZG1VdXNJWW16?=
 =?utf-8?B?V2UwellSR0JEaUZCYmFPa2ptTzFpZ1VabnJXYk00alFIRGltdkttcmVXNlhn?=
 =?utf-8?B?ZTFWNGlPcTRIYUJybjhQWVV5TWswTDlMLytxU1NqeWZHNU5DM01iRDBvaUdv?=
 =?utf-8?B?UVVRbmliVUwweStQL3NqNFMyT252cGFQVm9WR2hhTnZzYXVjQU4rR3lXOEZ0?=
 =?utf-8?B?dEROV0dXU1pQUXNydDQ3Um9Dak9iNmtNcnN0TkRpWEdOVldyWUVnTjU4Mzdm?=
 =?utf-8?B?bXlGQlNNR0ZGcHkzRlZtNUpXMk9BNWdIMWl1S3E4cHp3NVR6M0dob24ybE5h?=
 =?utf-8?B?UVFhMER0VGtIc3VtZTExeGxLT2M2R2h4TFBVNjl2L3BJWVlhQVkzYmV1dnJ4?=
 =?utf-8?B?VFFIV1ErT0ltaldOT2JhZW44WjBWUUUxMi9SNVNsTFpNYkVnQTljRW9WZnhJ?=
 =?utf-8?B?V1ROQ25uTnpETkZ3Y2doTFA5WWl4d1FLcnk2MlNKNG0xYjYxSVA0eUtnclpp?=
 =?utf-8?B?SmZ2NFNPSEVWK0NQTFlUMjd6YVFIQmJ5aFNkb3VCWFczbmVHa200azR4VDlw?=
 =?utf-8?B?aFRvWVFvQ1JOQyszNG5WSVZFcjMvdCthZm5LdXhBYk84M1lLR3NIZlN1TFdU?=
 =?utf-8?B?ZXlMWC9SVDhPbGt5RXNjWW1ITTVpbFI1Q3hqaE14MC9UUVFoQy9aeVEwQjJC?=
 =?utf-8?B?UkFieTZyMUN5K1VpbjlWWmtQOTc3dmdlakE4MHVFa0VES3dwOURqSlg0MUxF?=
 =?utf-8?B?RXJQRlVSQ3lFMDNkVUJuNFM0NlNrSGVMaUpUWHRxVFZwM2JGajhBK1ROWFdU?=
 =?utf-8?B?NTZvWkZWQkVmbHdNclo3S1hXZDBNRDVqNnFZdFhxQlhMSmRVWVVzQW1BN0VW?=
 =?utf-8?B?ZzVCZWZxaWhzNC95cko2SEdGTGgvdnBVeVJwcWFhV2ZHZkNmdTE4ekRMWjVV?=
 =?utf-8?Q?R4oydSPoFeq/rnVhZ19R0v8=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c0044d-ecdc-4388-a1d2-08da5847ce45
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 14:17:45.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwmkNiyHAaEqxzgilEKHPKXs96Z6d3TFuVvYgu6s3BJrZPe84kX5rKozaA8pLV/sTfUpBvJOhMl/YoaBWsldH3vCL9m9O4nuogE7Jaaqukg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-May-22 14:10, Dragan Mladjenovic wrote:
> From: Paul Burton <paulburton@kernel.org>
> 
> In a multi-cluster MIPS system we have multiple GICs - one in each
> cluster - each of which has its own independent counter. The counters in
> each GIC are not synchronised in any way, so they can drift relative to
> one another through the lifetime of the system. This is problematic for
> a clocksource which ought to be global.
> 
> Avoid problems by always accessing cluster 0's counter, using
> cross-cluster register access. This adds overhead so we only do so on
> systems where we actually have CPUs present in multiple clusters.
> For now, be extra conservative and don't use gic counter for vdso or
> sched_clock in this case.
> 
> Signed-off-by: Paul Burton <paulburton@kernel.org>
> Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
> 
> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
> index be4175f415ba..6632d314a2c0 100644
> --- a/drivers/clocksource/mips-gic-timer.c
> +++ b/drivers/clocksource/mips-gic-timer.c
> @@ -170,6 +170,37 @@ static u64 gic_hpt_read(struct clocksource *cs)
>   	return gic_read_count();
>   }
>   
> +static u64 gic_hpt_read_multicluster(struct clocksource *cs)
> +{
> +	unsigned int hi, hi2, lo;
> +	u64 count;
> +
> +	mips_cm_lock_other(0, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
> +
> +	if (mips_cm_is64) {
> +		count = read_gic_redir_counter();
> +		goto out;
> +	}
> +
> +	hi = read_gic_redir_counter_32h();
> +	while (true) {
> +		lo = read_gic_redir_counter_32l();
> +
> +		/* If hi didn't change then lo didn't wrap & we're done */
> +		hi2 = read_gic_redir_counter_32h();
> +		if (hi2 == hi)
> +			break;
> +
> +		/* Otherwise, repeat with the latest hi value */
> +		hi = hi2;
> +	}
> +
> +	count = (((u64)hi) << 32) + lo;
> +out:
> +	mips_cm_unlock_other();
> +	return count;
> +}
> +
>   static struct clocksource gic_clocksource = {
>   	.name			= "GIC",
>   	.read			= gic_hpt_read,
> @@ -204,6 +235,11 @@ static int __init __gic_clocksource_init(void)
>   	/* Calculate a somewhat reasonable rating value. */
>   	gic_clocksource.rating = 200 + gic_frequency / 10000000;
>   
> +	if (mips_cps_multicluster_cpus()) {
> +		gic_clocksource.read = &gic_hpt_read_multicluster;
> +		gic_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
> +	}
> +
>   	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
>   	if (ret < 0)
>   		pr_warn("Unable to register clocksource\n");
> @@ -262,7 +298,8 @@ static int __init gic_clocksource_of_init(struct device_node *node)
>   	 * stable CPU frequency or on the platforms with CM3 and CPU frequency
>   	 * change performed by the CPC core clocks divider.
>   	 */
> -	if (mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) {
> +	if ((mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) &&
> +	     !mips_cps_multicluster_cpus()) {
>   		sched_clock_register(mips_cm_is64 ?
>   				     gic_read_count_64 : gic_read_count_2x32,
>   				     64, gic_frequency);

Hi,

I was expecting some comments on this, but I'll ask first. We now taking 
a conservative approach of not using gic as sched_clock in multicluster 
case. Is this necessary or can sched_clock tolerate a fixed delta 
between clocks on different cpu clusters?

Best regards,

Dragan

