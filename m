Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1346F6DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhLIWd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:33:58 -0500
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:28929
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233656AbhLIWdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:33:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzAM2z+QVELH9Buk0Dw0879E1RcjhSDDPfDWxWkc/tU8pxchbb4zgz50+FwptJb27M6en/msrKbSISQKuNEPlNm+AHuN4JgfGqdVhrAeOuCMR6HmZbxgga2KntRGWcqNOJUAqp4JE/Vb9ifZ6GtKx3oNM8QrH/uQYvkvaAl6QFeoC+KUwNxvhQKf3wGJkf/fkIF1yg/wvcGwum/xtikLgmSFeShbBtCb57zTOXMxQ1VV7M/INDzwMFWBBVI4B2oxDJrLpT79CJ5wI6qAVrybc/vFWJcTYtrD9J4uQKuY1NIe3sXB39LkwUtDMZPWhciILe6tDnNgsBIfhxav9wOWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idTHdgN7uQpMTAr/i4jFScXb5lLFDWmeR5WQtgxWY7k=;
 b=RvSpiV0niqrDjOABOVKInLpDg9RgXPdvrkrWq+NiSz4UZH53bNZn9VWdGd6Bbr/l46sUwGSOX4t/vcqa/Ana5cOPXhlbvVIEHh57PCP+9UhAJVb8aS066Rg8497LdXualUxsxa/HF1bggI4TukGc4aDX9zSB/Lfh/9mpntRtZ6zU9+9oKJhj1dD0xiQ9Hco0VFuGJ4QJpcimpshRPyCiWAZIg74pFIiSNZOGwaYWpwA56maHGDoOiURQs3wV/ooeMHmReL0iOjCsK9urhUi7ZSi7q6y6lVHBayAJBv5qiDBuhtya691SkpTH9+s0ylEwgtXMjGCLlSTHZ7J4n9+gqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idTHdgN7uQpMTAr/i4jFScXb5lLFDWmeR5WQtgxWY7k=;
 b=sCG2yBBaNvNBTgUkf9UXYjV17ekQX3EJicfMKPOAfgP2yMCRIlO17IFrPSYNFkbNmj9IY6R3ujYhZAdm47+8NsSCQwpT1/+8RwrI39M47TZUvnQQPu7/GOskPWSvjtRQcSUa6U/d1Bu6+W9SUT4YWvmifeihS0ackK6xlROpvl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 22:30:14 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%6]) with mapi id 15.20.4755.021; Thu, 9 Dec 2021
 22:30:14 +0000
Message-ID: <52f808a3-7e2d-7ae2-ca62-400137a0b92f@amd.com>
Date:   Thu, 9 Dec 2021 17:30:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Potential Bug in drm/amd/display/dc_link
Content-Language: en-US
To:     Yizhuo Zhai <yzhai003@ucr.edu>, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CABvMjLSXpg00KKkqXH35C7Op0xC3mPaOAhj_xbAOEXL_4Ys_aw@mail.gmail.com>
From:   Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CABvMjLSXpg00KKkqXH35C7Op0xC3mPaOAhj_xbAOEXL_4Ys_aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by YTOPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 22:30:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec3c3246-6086-40df-2801-08d9bb637841
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5444BD3F55D113C3C1EECFC58C709@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAIdr4bDJ0hUmK6sRmbgk91aWmPKRO8ReduxofRynKFfJSSd8CA5J1Z+8Oaup6YDBLTi21lFXEplVmtDG84TuOlxSbsh/CdI+Xu3fZWOxaXwW8FcflGxnslTg9uZakpAii4AV5yl8+/pMiOgq0iCvsITtgZ/lKI/iQDhkQQPOvuhM7ICcb7tjw4SNE8UF/5WxUiQjAUvazX1hmUygMJp8XMwxnEUwEu3oxBwfs2xF5GYqh8mSCs0AF+tOiB7etlRymTbPwq4ip+jHtpDj7G/g49KMJZ9aMDHOQIKLTbKDsoKvRmMBjPDhcwRPeZJR0ZXfmW7GMj+dWZpiCKrl7Dsjg4mTqIlsEsYowSilUU7lq7FJLdPetd9/Ck4PhxlI4WlcG57Q4DrtetJGHptMPbgw3mJGsDot4zlWzxA3Ex8mOzSkKNBoclLubgtp9Cu/FQaPnm1im8cQ9cVekIjcXTbMRmnEH9bxnxE/C+FYm89ag3ZS3UCEGeRDnNPIxl0B2pLPnnvr6UCE1CFhPJHOIP+TVHgjv3NdBjC+6BKjUn9KPP6dAUmjjBkUw5Lzr06YAfGDArvFXz2Lz+Cf6WHvB7YTArd45bujVMoopVc11r4cBKmHOhbIDr1u0PisrKrVRcMnF3Baz7VLmwSiixvUUJU6dHnsP0P88eBKrN+eUJ+j+2tbY85vXP1s9rNmTUuZORwIhJX21I2yTRQXV8O4sesPhECEBO5lrGPQcZQwgmOXtjBIR6bS5gzPjfjLAdA0Gsf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(16576012)(316002)(53546011)(110136005)(66946007)(8936002)(26005)(66556008)(6486002)(8676002)(2616005)(186003)(86362001)(31686004)(2906002)(31696002)(6666004)(956004)(508600001)(36756003)(38100700002)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW12R2VCdTRvYXBrOElIc3ZtdmtzMGRJMFh2NVVMaThqOUZneHBhN2tEK24z?=
 =?utf-8?B?SVMvSUV1MkpTUkRsUk9QYnRvbVZINnVWQmMxREs4ZlhCRlFVUTVPTU1uU2E2?=
 =?utf-8?B?Rm5ZMzJadDBNZVhGdFJNUTJpWHRpSGdmZFNOZUNaVjU4Z0trQURpSzRIREFH?=
 =?utf-8?B?SjJUaWhwcTc3anNWUzVONC9PM0JuSzRGdVg1K01BWFYyTmFuTkFYdXhCZTR5?=
 =?utf-8?B?V2x2Vnkza0xkMnNEVndOUGR0b3k3RlBldDF4K2JJQ3oyMldsQlRHekNVN3Rk?=
 =?utf-8?B?enFYNHgzL2d3ZnJ5R3RuaGxvRHV3S1RkeGFqSkcvK3VyMTZwT0JrdGIxQitt?=
 =?utf-8?B?MVBGN09kZnRTYXlSdy9VRUlvV0lQTDZzbGNtWmNQS0Y1WjNrK2RmaXkycDdj?=
 =?utf-8?B?MHVoR2FYK1p5aHRZaG9pcGk3S3B0SmNmWWxzTmpValFOQ1ViR0tOODJSTWZw?=
 =?utf-8?B?eDlBMDVKNEIzRTE0L04yQnRCYTlnTFVKRHBhZm5oWEZsSWhJNEJyWWw5MHVH?=
 =?utf-8?B?T3Q5dzgvdElNSzV4Rmk5OFd3RzRycUVXWlpld3RCK1UxZWRlZE9zeHh6SXhy?=
 =?utf-8?B?ZERLejkxMkVPK0VFZlVHMGF3eWNXZjJtbFNheElFVlZiTmIrVVUreFR1YUhD?=
 =?utf-8?B?bm1MWnIweUd6cmpNZGF0ek4xSUhGQ2NjK1dpbmNqeXRSYjJSV2ZTRkhKckFr?=
 =?utf-8?B?aFRIZGJldlpoOG9CVUxObGZUbTJRVTdyaVhwRmJKVmlYT24wWi9HeWVQYldQ?=
 =?utf-8?B?QkQ2WWRnRjJlMUQwSnNzbXBHdWN6bmdMMUp1WnlMRTkvMkFWUDRvcGRGRVA5?=
 =?utf-8?B?cXM4UC9FR2s3dlBEY2hqL21CY3hRTldQbEI3V210blZwYUNKWElQVTE1bTc3?=
 =?utf-8?B?dVUrbk9tSXJ2elJXR0FTL0hzRUxVbjRXWTl4TW5YOFpLaDdLN3pDM21CZS9H?=
 =?utf-8?B?QmZqV0VSUWRFZVF4bmdYeXFjT1JJQkxXbytpYlpRazAwb3ZrUWVsa2pxcER1?=
 =?utf-8?B?c2RERkVqMzd5SEFqbUJZTlVDKzhHMGdJS1RmS1piTnp1YjVlMENaK2h6U1Zj?=
 =?utf-8?B?cFo5LzJzMTQ0OGd0N2RsTnA4UXRtK1JLaCtsNTBLWVM5a0hHSkpzVHJMRXhJ?=
 =?utf-8?B?aTJJYzExM0NKd21tSFJPcldCMzZjTGpoTXpqMWVnN2dmWGpKeXRLVE43YzlQ?=
 =?utf-8?B?T0dUQzgzWHZlQWdINTdtQTZLRjBDbWhvNGIwV2ZodzBKZlZvclF5TTFnTnl2?=
 =?utf-8?B?NzBtaHZOQU9hQ1k1eXpxaXB1ZlowcWYzamxKOXIzVU5aTTJzdXJrVFE0Y1gy?=
 =?utf-8?B?cHViV0dVTzdubFVFd2ZIWWZMUG4xenJLeGRHYmd6b2c3VERBeWJmbE9lanVC?=
 =?utf-8?B?cTFQQzJLcVN0UXFweDlyZDNUWjNTSGxFY0dzTmVjdFRSRFFRMTdyWGNjdWNX?=
 =?utf-8?B?WWUwN04wOE9OSml0R1d4YmcwU3k2bTQyWFp6bUJyY0F2Y2NmUUlmZWRYYWlS?=
 =?utf-8?B?cGV4SUdJR1VBcndJL2RYZGJTOWY3dHljQVV6aDRZNFdwYTBnWTlpVk4rUXNM?=
 =?utf-8?B?Vk9KRVI4VGl0ckRTWE1zYzBOMHQ0dHhWTWdLSXlRbjVOM3EvN2xNOEJSYlNC?=
 =?utf-8?B?aWM5ZVl5K3V2T0UrMU9RMS9sQ1hybG9TTUo0bE5pNkplUEppOWZWOENhOE9q?=
 =?utf-8?B?NzlGdDZNMmd2QlhWQ3U4L3lZbUZXQzZqNm5BOUwyRFZYanVFQWxHTkxQV3JV?=
 =?utf-8?B?LzBQTW5WMGxKeUZFWms3bUViWEpyOFJoNmE5YitLL3dmWWxNcCsxSlN2Nncy?=
 =?utf-8?B?aWN0RzFrUVk4QUkrN3N3OTZxNW5NWDhBd3IwUlRjRCtoYmRvQnpvYS8rSjBh?=
 =?utf-8?B?Z0hCd2FVVVBuTHRPbjdKSUZBMXcrZXF5Q0JMWXc1b0diSlB1S2hIRTN6ai9s?=
 =?utf-8?B?QjlCdnlVR09SdE1pZWRHbk0zNFhMZjNLVUVrY3FvVyswWG9VbEdWV1NldmdV?=
 =?utf-8?B?R2grdHJWZFNzVzZ2NllaYXZodWhKVGZYSXEwTGl1bEhDKzY5UnVLQUlUWThm?=
 =?utf-8?B?MStvZ3lEcmlOTmdjU3FQaHRBK0ZOdlFoQ0ZEb2NkT1VHenpXdWpETXd4bWQ0?=
 =?utf-8?B?cEo3RE8yYm5IdmxqaEx3ZGt3Vm84NW9YcWtlRTY5a3hmZHZYQ1p4b0dDMHJq?=
 =?utf-8?Q?RrMLc6aLrZbOCiCn6fNEE7o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3c3246-6086-40df-2801-08d9bb637841
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 22:30:14.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zh8UjqcdW6pEvj2JvznLYI67xiTLRGmWh4KQLDB8lw0b2i1AQvujn/HImZjvqerY2YrSmASfxoDRvcdi3rSZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-12-09 03:02, Yizhuo Zhai wrote:
> Hi All:
> I just found a bug in the cramfs using the static analysis tool, but
> not sure if this could happen in reality, could you please advise me
> here? Thanks for your attention : ) And please ignore the last one
> with HTML format if you did not filter it out.
> 
> In function enable_stream_features(), the variable
> "old_downspread.raw" could be uninitialized if core_link_read_dpcd
> fails(), however, it is used in the later if statement, and further,
> core_link_write_dpcd() may write random value, which is potentially
> unsafe. But this function does not return the error code to the up
> caller and I got stuck in drafting the patch, could you please advise
> me here?
> 

Thanks for highlighting this.

Unfortunately we frequently ignore DPCD error codes.

In this case I would do a memset as shown below.

> The related code:
> static void enable_stream_features(struct pipe_ctx *pipe_ctx)
> {
>      union down_spread_ctrl old_downspread;

	memset(&old_downspread, 0, sizeof(old_downspread));

>     core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
>                          &old_downspread.raw, sizeof(old_downspread);
> 
>         //old_downspread.raw used here
>         if (new_downspread.raw != old_downspread.raw) {
>                core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
>                          &new_downspread.raw, sizeof(new_downspread));
>         }
> }
> enum dc_status core_link_read_dpcd(
>     struct dc_link *link,
>     uint32_t address,
>     uint8_t *data,
>     uint32_t size)
> {
>         //data could be uninitialized if the helpers fails and log
> some error info
>         if (!dm_helpers_dp_read_dpcd(link->ctx,
>                link,address, data, size))
>                       return DC_ERROR_UNEXPECTED;
>         return DC_OK;
> }
> 
> The same issue in function wait_for_training_aux_rd_interval() in
> drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c

I don't see this. Do you mean this one?

> void dp_wait_for_training_aux_rd_interval(
> 	struct dc_link *link,
> 	uint32_t wait_in_micro_secs)
> {
> #if defined(CONFIG_DRM_AMD_DC_DCN)
> 	if (wait_in_micro_secs > 16000)
> 		msleep(wait_in_micro_secs/1000);
> 	else
> 		udelay(wait_in_micro_secs);
> #else
> 	udelay(wait_in_micro_secs);
> #endif
> 
> 	DC_LOG_HW_LINK_TRAINING("%s:\n wait = %d\n",
> 		__func__,
> 		wait_in_micro_secs);
> }

Thanks,
Harry

> 



