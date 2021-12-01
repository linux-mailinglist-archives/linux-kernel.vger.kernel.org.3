Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC9E4651AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350977AbhLAPdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:33:46 -0500
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:15873
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230118AbhLAPdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:33:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLOnE22rHRLG7x+RhWf2h1n5ylm36/YZB40KoGTobB6+J0722dwNH1eey9HwbkTnO60E2WA59LPuoX6qFJQBV0IfRfeKOwltBvOmdsoBxFDARVb5gyKGMZf6WYAVXKdkPgSbFWksLKTEuPiD7Zn6gQrrIU9CN1GtP9FODtHSM/tWzRsv1QCiO+pHIi1cxoe4AY0LWxKyUrPIsm3LataPQIADEINzM1YI8EklPErIFcQbMZJiEtgJgY8TzpBw1EXtXHrIyP8ZCaZi7eMPLS57gxpiEot91qEBDw+T0GSS6sxUJ5HS5SrpxV+dUuKH3FqNtqES4SGxB4J6nfKXcTR7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpQLekvxwLuNkNcuwq2fxFIMBTFST5v2RGxVtAx/a0o=;
 b=VcBVCQ2KZtmSeZcoNbg5aHctcElfqMme2YL9NPE2ol8rrEfI/KgWgH2YFynisqul0Y7L7utjbDKTsZW41hwgbrp8QY7j4rujLqzMFTzTKV08+hHqpVQo0Yif1XApjpDhvFNlM2sMe7opRGe69lDlX1KgEl3Csa/Wl+ONlRj/4MOphtwxVqIvR9QjHGHEsVjgO5VJY+Ls8sgw9oGxXBrOHl6ctsivDzXshyICt7p4uhF70zm0iDHbBk05YfjFgrgoyrzawB3iPMvMtIUi7lNk+kyJYWZSfBjnFCMsn1EZeo9T9Nhnz0ZrmrLH47TAMM8K5YkNB/CKXa3pL9IVRdpFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpQLekvxwLuNkNcuwq2fxFIMBTFST5v2RGxVtAx/a0o=;
 b=AoTEo7XLPxOufrzGcjsm2rY3hw3rJ4TimRa3L3SRLxeTv21+BzKZ0JQNQwjcI+QZ2674Tkz2McNFZVchP3iVxuMLLk+F5n97mtqete0KvsmpP+M62MBFPn60ChqFBJI2gQYv1CpssY3N3n+V90Kmm6vF7Hyk+C7SK3iIMDkdJoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3460.namprd12.prod.outlook.com (2603:10b6:408:48::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Wed, 1 Dec
 2021 15:30:19 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 15:30:19 +0000
Message-ID: <25f7b261-3f2a-942d-8d3f-d501d9dc9612@amd.com>
Date:   Wed, 1 Dec 2021 09:30:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 11/13] perf tools: improve IBS error handling
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, mpe@ellerman.id.au, maddy@linux.ibm.com
References: <20211201010217.886919-1-eranian@google.com>
 <20211201010217.886919-12-eranian@google.com>
From:   Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20211201010217.886919-12-eranian@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0056.prod.exchangelabs.com
 (2603:10b6:208:25::33) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by BL0PR0102CA0056.prod.exchangelabs.com (2603:10b6:208:25::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 15:30:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fea0011-6ec1-406d-e056-08d9b4df7a8d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3460:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3460C7AA429C03BB12D5963E87689@BN8PR12MB3460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJvmE4QoL+/NPMPj86rZyUG53j54+OkI8e1iL1dEoz2LWEEcA1E/cE3uYCrL+C7aSuuzj3eslMk/bGgQJIs8IsoP0RzoSsIk31fa9CTaluI4mk0/6rmdydyFcbNO1fMNu72uyxyq+9x6LGe0cqIH1oRoAuXEZeeT3WRvL58+kUgkh5k1llCdZKWl8q9w1aOOrLOR7eAEsjGekfAyfFGicn67ADkFwpi383G+b+ehZJzRHxmU+BejnjNoAOEcDwb6alrWK+aXav4GfCeZ2W5u0jhR+Hxwkv6zbwbNDjdn661RLOswZQbs5MU8slb97FowWXmONm8oVJ8gVXaPv4aOL7JDSkzxf/a/EtsdAgztU4Eplk//TEl8iTWsyCWNC4ehMq25QEVEdFHTfZR0bna/nVo8GlkGYTjIrCjiwbP7+CEo81jE7KBaJhCmpayJXDGePBelNeD0ZjdiMT/2ySbBulTz9BHZ518Y6HXkBRnvYYbemHHWH1Euc8H/AgPmqckqxfsKjbD++ZTVXLW/73mxYYf4+WvUuCuI6JA90ZArwVuL96oGslgaZRn1JAdf/Vvc9gBYOOM2Q2D/iqda8Gl0Qz3MUseI3mswsUDzD3pa+1nNRGimLxV4DC1+BKggMRk9p/oddfTOV10ArUz1SM6m0IE5/EDY83sdxjHG2rrRnw/AD55vNQ6dklSbI56lgc8La3ervUZM1wHUkJfZjLC7Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(186003)(66476007)(66556008)(66946007)(6666004)(38100700002)(31686004)(508600001)(2616005)(5660300002)(53546011)(6486002)(956004)(16576012)(86362001)(8936002)(44832011)(4326008)(8676002)(31696002)(316002)(83380400001)(2906002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkcxaGJYVlM3SlBSdGFHUnptb3ZmY0w5bHVHem1sVk56OUlSRlAzN3NWam9s?=
 =?utf-8?B?cHRxVUh3ckVWb0hlUEdNcElSSmpKUk9WcHNEMnd4YjVnRnVNaW5jTnVRaW9t?=
 =?utf-8?B?SWtPUDhISVdiTklNMldSdEx6dU5ub1QvVnJ2d1Z0dGdkYjhMY3ZBbTRBL3JX?=
 =?utf-8?B?SE5JS3BrUERtT1c0K1FDUkZZNVRrclBXWjR2TzVEL3cyQ2dZZVdmdk9DcExj?=
 =?utf-8?B?Z3h1TU1IS08wWC9uYnJZQW8yaGZTbXV1ejZRQlNuUUZXRGd5VndiWEVEREpE?=
 =?utf-8?B?SVh3cXZ0cG5VT1dIYWluaFM3djdEblVtRGdzNzJDUFNoQ3RRSnVwemlCVDlE?=
 =?utf-8?B?MnJWU3dWZDZjUEgzK2RuUy9kbUd0ZVV4VGtHdkJhdk1hOWVOS2FCN25HbEVT?=
 =?utf-8?B?WEI2ZENFeFE0WE1EM0pUMk02cmw3SnNLQnBrWXh3ek1ta1BGNkx1RWVxdk5z?=
 =?utf-8?B?dDhGcWxnaUhRYXNaeHJiQmFOK21tSm0wdFVOR2V6WGxNc0xTM1Jka1VGYVRn?=
 =?utf-8?B?UUZoT2NnaFpuN1ZZVmdrM1BKL1JpK25QWDJ2aWY0d2ljdWJyUUg4cmM3dGIz?=
 =?utf-8?B?c2R4T2s4cW9CcURjQXhhc28wdTU4MUQ3eXRzQWkvY2RIejJEbVNubjdkZm5q?=
 =?utf-8?B?MHJ0TGJNclFRa3YzemhFZXZNNmR3aytsMENLcUpnNFVzNTdRZ0dZUDZZcEJw?=
 =?utf-8?B?c0YrSlhHZkdsZk1ESjRDYVB6d2FoMUM3ODZNSmtybGZrVmJiMFAzL1h1akJL?=
 =?utf-8?B?eWJZd01GdGlWYXQ3QU9QVWRpMDJhUk4raDEyejJkQzJGTG5UbGp0bHJvN1lo?=
 =?utf-8?B?ZGwzTUhEQy9SaWhwZkFRemx4cXdWMm9qUXlLbnFrM0U5eG1uZjRZSmdtT1E3?=
 =?utf-8?B?ZDFteXVYcHdFNTg3WVorN1VRZXBCWjZLUHBZRTRDMGtuYUc2L3lhdVFKSEtM?=
 =?utf-8?B?MTF3S0s5N2FHaGFZZWtSYTZUT2xvdmJGem9ncUJGbWphU2orU09UZ2NpKzd2?=
 =?utf-8?B?Ly9lcEg1MGUyQkNZQy9zTDdTTUZLcDBPVXVTNDZUZ1NDZXNtbTFtblRuNnYw?=
 =?utf-8?B?TlJqSWM5RlZQNEttZ09hYldvWjgyR2c3djRNZUNvU0VkbmVFNXNnMlVmc28v?=
 =?utf-8?B?R1NSaFNuSlBGbGN2aW5TWFNueVhyeGozRnRzRHBmRzB2SEZLN0RtQ3JSV2lL?=
 =?utf-8?B?cFVCNFJCY2RBbmZXaWNMODlSSmZyekVuWFV2M1VQMmxVQXVzb3UwbWIyL0U3?=
 =?utf-8?B?ZGVUMFc1cjNjTFoxcHAvN1JQUXEwNTNiWkhINGRyajZuRWZrUVNMMzJlajhY?=
 =?utf-8?B?c29ZT3dsSHpPVjhiSEhQWjdCY2xQMGZ3ZHMxMW5MU01zVFpsMmlaSG0yRS9h?=
 =?utf-8?B?dS9NSDZrN3psYnNsQ3UvRG5HNGkvZzZ3VkRGTEtPN2kwOGlQSUkvaDk5dlpS?=
 =?utf-8?B?eDRkaVN2U1E4eldGNkhybjhYSFo1cWRSYTZGc1FnSnpoS2ZEekhYS0ZGYnFE?=
 =?utf-8?B?YWhnV0dyTUh4SVBPdjNXWThUMXBXQjJjVUlhMCt3bkFQbGVCTVF3Nm5uTExZ?=
 =?utf-8?B?V3RYRlhuczFwbDlRV3k0Z0IrTm9iZGJVR2gxOTZFalZzTW9GLzcwaU1iempZ?=
 =?utf-8?B?VkxqaHcxU1c3eERhcjB5eTRHcWNzQmlFWk9XTEQ0QmZlb1N6Uk9aYUZTTFhB?=
 =?utf-8?B?MUltZ3ZYandzcmhiNWpLZXNlUUtONFJ0cUVPUUpvbHNKRXVJb1p5U09OOGVT?=
 =?utf-8?B?Mk5mYTdXQTRjY1paQWhJRXJRT0JMaE8raEduNmd5RzNtcTNoZ20yTG5OWXI2?=
 =?utf-8?B?SWJhK3h4ZVBiOVJXN0JVcUlOT0N6M3lsRHo3RlZlTU9IUDZKV0FnUkh5MFBy?=
 =?utf-8?B?Q0l6ZzhmWnkyVGdWdEZzcTU0alJhM0x4RXYwa1IrOEpkRDBEaUE4NTdOY0Q5?=
 =?utf-8?B?TVRqWWNOd3o1VFEzRHBCQkdlNzFSRGx2dHhzdWxoak1Rbk5CQUVzOFk2U1Ri?=
 =?utf-8?B?T2l3Y3pyaWVmcmhLYzc0YTBiYVN1a0doeDdEM0RxbHpPTmpCZEc0Q3JpR05G?=
 =?utf-8?B?bnJMcjVHZzVVREh4NEZ3U0lJTVpqVFhJa3N3QUtXV2FFN0g4dWdXMFUrbWEw?=
 =?utf-8?B?WG9WMFRrWGVvRkFrK0VUOWUvRk84dHY0RDNYRHBPYjUxOUVRV25CcWt2aU1E?=
 =?utf-8?Q?pdFa/yMQ9pGIwRB+HGIwn3Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fea0011-6ec1-406d-e056-08d9b4df7a8d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 15:30:19.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOKaJ+NyLk6d/8VAWl6Oavrce8odoRC3XJZt8AyMiNv7z/simSKMevusQFg3bHDoDMQMyp9Wpmyiode0LnBJsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3460
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

This v3 looks like it's the same as in the v1 of the series,
which got nacked by acme.

Please use the newer patches provided.  Instructions to do
so haven't changed since then.

Thanks,

Kim

On 11/30/21 7:02 PM, Stephane Eranian wrote:
> From: Kim Phillips <kim.phillips@amd.com>
> 
> This patch improves the error message returned on failed perf_event_open() on
> AMD when using IBS.
> 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>   tools/perf/util/evsel.c | 42 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ac0127be0459..39e9063c0a80 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2852,12 +2852,52 @@ static bool find_process(const char *name)
>   	return ret ? false : true;
>   }
>   
> +static bool is_amd;
> +
> +static char *fgrep(FILE *inf, const char *str)
> +{
> +	char line[256];
> +	int slen = strlen(str);
> +
> +	while (!feof(inf)) {
> +		if (!fgets(line, 256, inf))
> +			break;
> +		if (strncmp(line, str, slen))
> +			continue;
> +
> +		return strdup(line);
> +	}
> +
> +	return NULL;
> +}
> +
> +static void detect_amd(void)
> +{
> +	FILE *inf = fopen("/proc/cpuinfo", "r");
> +	char *res;
> +
> +	if (!inf)
> +		return;
> +
> +	res = fgrep(inf, "vendor_id");
> +
> +	if (res) {
> +		char *s = strchr(res, ':');
> +
> +		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
> +		free(res);
> +	}
> +	fclose(inf);
> +}
> +
>   int evsel__open_strerror(struct evsel *evsel, struct target *target,
>   			 int err, char *msg, size_t size)
>   {
>   	char sbuf[STRERR_BUFSIZE];
>   	int printed = 0, enforced = 0;
>   
> +	detect_amd();
> +
>   	switch (err) {
>   	case EPERM:
>   	case EACCES:
> @@ -2950,6 +2990,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>   			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
>   		if (perf_missing_features.aux_output)
>   			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> +		if (is_amd && (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3)) && (evsel->core.attr.exclude_kernel))
> +			return scnprintf(msg, size, "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
>   		break;
>   	case ENODATA:
>   		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> 
