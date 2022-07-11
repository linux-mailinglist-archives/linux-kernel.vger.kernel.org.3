Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2746570AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiGKTdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKTdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:33:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D597101C8;
        Mon, 11 Jul 2022 12:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+QC5AdPDP5/i3uNok6B27okm+VEIbSSF21lRCxLIXMBhDRw/LSlnceasudc0qDpq7eia7jJ/pMSfATM+2ru5cFz9P/Lpn8yKiuNrkp3U0rRDc6VnYdQ26s/3iQ+fI+f1CKGNjyM4v5BfjOSk1VQ0flxoNp+t5eOJ37gvSkMQZNz6FpL9YDip3KvJ3VSoD1oEo/NWnDv0yECRWT4nAtba+UmjYER6B7S0ur82nFWU4luvjywP293TfPENJ6Xa/R+pigYr3kyX/h3vDD443f0dy7afG8/rusH2YDldM7f27uv4jyizzMPlsqy5S85gdj0QJ7qNktU8tyK+0qKqC3jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP0D4NTRr/asZv3u7FeLQg8IG6J0jnr0WqLGNMamYd0=;
 b=KJEFQI6Zd8PSTGtXCbLZ90+x2gueX99tiVeIRlEESH1Eyh+e/H7lGby54jzwyxeUamhwZFWt9RTRNzZva/kP/noN6N2K6Ef9+3yovLZtCdYQVgi+oI17pDllhEePQ5jj/UwwZTGvEbm3YKkl34DQ9up1lZlKyz6Tcg8MbjG1VqEZ22h8HPrUjNcjXuhuToCiZSg3+NqZc3+youp0vgvP+9EMe9ILnHG6SKl5k5SOIBKRCMQA/Lk2LKob+l9prfDSOsP16iTc5uEorqTigqHOE2P/sW9FezvuYx1oahn7lZ6kqyjZOUpuICmR+Lzc+HHrkzHAGAez3DjUeThrQjv41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP0D4NTRr/asZv3u7FeLQg8IG6J0jnr0WqLGNMamYd0=;
 b=CW2hXnOVuqi4Eki+oak6dkboz98Uiva4oKeL/DLoOiu9utJGseRjCX58F53DWPS7HHXP6pEXeJWwuRPrSjKJPzS7wmwsOLFJr55clf/AOhlZiOJ/eOt6P0+/s+EfPp1P/6KEdZ0aBKdcUin3RIZsn5BkoGiJBkmlGCvN2sukV00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 19:33:50 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 19:33:50 +0000
Message-ID: <359a0e0a-b118-450e-67d8-a784d1a43cca@amd.com>
Date:   Mon, 11 Jul 2022 14:33:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 07/14] cpufreq: amd_pstate: map desired perf into
 pstate scope for powersave governor
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, Ray.Huang@amd.com
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220709141901.835903-1-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220709141901.835903-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0272.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::7) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c9194bb-80b0-405b-7965-08da63744827
X-MS-TrafficTypeDiagnostic: MN0PR12MB5763:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhwk1eNNspISf/zhuKDOmhYogJat7II1Go94ptvW0DqtqfTJDEXh8Y4Lq1yIa2jC37ETp1xarr9yJezUEieW3+B0H3Q65oI7H7VQV43Q+UT5iC+04XCvKpKcfGXZNe/DDFf4Uic9sBlgAFHJ6KSWIRbw4ykZT2Jxw4CvhYitY+Vg5iK0MhzOXvrCXT80CVW2z19ETMmSunH77B6njTjI7T0/pLpuufCo+GPM+aI6m+3abhBy5nQpn7oOEemHg4KbzUqh8xK7/4d8KwyhNjQ/stWcLtc44SHjNsgbI7mJtnS5wUJtMV7V2Gg7Hi18ntpKtk0mP116k2H/XTU7Wo1yY5qgOd8bLl67Mc321EXGw2dmYnEJg/e27w0hKSxJyXNAJq1z1Las7/jPWD1eEmizKqu4MkLjDlnvKpb5gHJhNpkIAk1qZkdcBMGbNr1II/eEGZDO9LqEQa5c6BO3kr3fot52iqhB0Qrw9qe5R9pxDUvL85JgKdG/xE9U+ZGJ6WEVleox+7abbfudHL63LeglOsIlp3tWIAfyXkQqyfNyo5S7IkbFAAjYSRVH2UxhfpbW8oUz/FPsRkQokmt4NbrdHgttvqz06aRFQVcV8X/S5uDDWgufkq9PjADyG2TkYqwFjyOUg+8FU9YnFs1aOCSV91Q3anJn30z6RfDqgUSbUV8UpXmGLkf7wYsMb9CyHbpt0xDyECgtlcHYP/ick2LMxRVVSJJDcdxDgYTt1cMaC+hEEQ7lzoPNF6qlGYjapuI+Hb7EWbldUKc5DffJcIIOvlWlBxSBxNt4kYAaENer9o5E1KkFtGuhd3Dd20od5VV5mH3Cejvz8Mc6CN0yada3kjvBAHTEyhKoJDo2bnnqRRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(66556008)(4326008)(66946007)(8676002)(478600001)(66476007)(38100700002)(2616005)(6486002)(41300700001)(6506007)(53546011)(6512007)(83380400001)(186003)(8936002)(2906002)(5660300002)(6636002)(31696002)(31686004)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUpSZU9tYmwvNll3Z3ZDOWo2b0w3Y0x1bUFmcG1yZ3RIZVRVc0JiOEVOUyt5?=
 =?utf-8?B?YjcrVTZDSkVDRW5TaHd5UUR5Z1J5aUVGYXF6VDVXK1p0VjVmYVZ1cFVycitj?=
 =?utf-8?B?eVJ2TGk3YTZjazdMWC9qOFpPWlhlU1FIOFRLeE9yRWt6TUFmRmEvQXIzeDZo?=
 =?utf-8?B?emZnbTJNekYvTG0vMnNDTXRQa2Zjc3BSTm1VT2Frc1BKN3FOWndmd0FRbkxE?=
 =?utf-8?B?UytYNEZIdHNXZ2ZzaHV4b0xhNkt6YVFSUEFwelJ3aFZWaG4yY090Ym4zT3Zs?=
 =?utf-8?B?anByM1d5eWNNVmJTZjdOK3BaN1RvbXQ5TG9rYUl2Sjg0ZTEvN3RGWDcwUmhB?=
 =?utf-8?B?am12c1lzWUdnTzY2OE91TDI2Sk42ekdtZnhLcGh2TGZKaW9QWGlWc2wrS2FH?=
 =?utf-8?B?SFBGN2xEWjNEcHphdkNhRmNJY2tnTGpSMHl2QnlvYVR3VXFrQTZTNUlwTE02?=
 =?utf-8?B?T2NOTjV3WmFwUnhHcmZrUCtDZGtpR1c2eHBIUkdiNXczcGNiNkFHTHIrOXRD?=
 =?utf-8?B?OTR6QUwvaUZweWpvVWNINVd6dG5kVkovZWxRaC93MlR0ZGY5SS9YYmtydTJJ?=
 =?utf-8?B?Y01OZ1BkUlNwd0xwRTdDSFBxbDBVRGtDUm9TRlc1dzhiUkNEbXNacHh3ajlQ?=
 =?utf-8?B?aFd6bWtKblJYbHhkN0l3ai9wVWVKTUw3Vi9yN3NVOTVXV0xWUEZ0YnBhWnMz?=
 =?utf-8?B?ZnhNYWRhY2wyU2d5VU5ycG9zTzhzcEhPMmIwZHEvdFhkSTdZbVU2VEVQWWt1?=
 =?utf-8?B?OHBEUTNTVXdBaEFrSWR2ODZCSTlnSGFsbjYvTmQzSVFjaUZvZ3I3R2EwOWFC?=
 =?utf-8?B?R1hrbkVOTld3QzlScExLYVlPcmFjSnhCQjVDN3ROMDByRjBVUUZKZEdiVWZM?=
 =?utf-8?B?cUEvQzFhb29vOXBlTWxkTUNUdFlSWC9ubDlYK2xObjJXdlp0dUpZQ0VNcXNZ?=
 =?utf-8?B?SitNbGVma1hMWE9CSTU1NkJDVHQwWWwzUmplMHo2SGlsNVZIcXRrRjFmczA5?=
 =?utf-8?B?YzRtK3VzdFRlUHFBYkIrQ3dJVXh5Z1ZpZGNaNTlIZ3FHVlkvR1ZKMDRyNFls?=
 =?utf-8?B?bE03Y3d4Tmg3QXdMc3JFYTEzVzJxeHY1cE5lQ3ZPR1U4SklCUjF4WXNDc3Uv?=
 =?utf-8?B?aUFpcjViSk1HWURwMHQxV09qbWttSENKQTBlUDByYjg2YzRoeVVLeFVDZ1pu?=
 =?utf-8?B?clBMd0pBUmJwNnFVNGlyaUJ0aEV2M0lJdzhQUElpT1JVMmFhTVZKakhjZDBD?=
 =?utf-8?B?RkpRVFZyTWxLZ2JoUUFNSWtoUE1RN1cySDd6S3BxZ1o5THkvZnJUMUlOZHNK?=
 =?utf-8?B?MCtXYWNiNmM0MDV3anQ3Uld5bS9HdnhJRWVqYkliUXhnRnA2WW51eFhIVmRO?=
 =?utf-8?B?QW01N2hFdVkweWYwaVY0Z25hZU9LVnN2QkxVOHNNZ2Z6VVYwRUF1Mkh1NGhL?=
 =?utf-8?B?ODFtZXBHTlhZV2FqVHB3bTlZb0I4U1E3UXJVTXQ5TFhXWUFtbzJmdGdpdnZ6?=
 =?utf-8?B?cW1FbzJEMG53b3dnSUUvMS9EM21UWk5lVDVoY0lSNldoQUlxYUZmcUtsSmtx?=
 =?utf-8?B?RVJMdDFzMkoxckFDR2JGd2Q2czVMMGh1Z0pZOGtwdldNajBOZmlCdGNwVlVk?=
 =?utf-8?B?SEtDQnNKQ2V3Qk5NSkRiRHM2a1dFb010Um54UEJwczBLbkpjUmJBTzVOcURQ?=
 =?utf-8?B?YWNYQzJ2YkpXQUFIVCtpellxRjdWOFZUK0x3NG92bkI1MCtpVkZYMXpDcFZP?=
 =?utf-8?B?TG91SzV2emNpakR1RFIxcDhFMEFyOW5aeGVxSjdnbEhsNWZYV2t1dm1mUVJX?=
 =?utf-8?B?VDdmNlpXSmlyOVFRYUN0aUdrd1hxU3M4bGg0Z21iQmloV21NQU9iL2Z0eEM5?=
 =?utf-8?B?YXZkbW42dDRDM3hNOUJYb0pBd3VDYlpkOUI5eGU2Ty9xdTlHMDV1cVJqT3ZZ?=
 =?utf-8?B?SHI0V01HdlMwVloxTDVLc1g3Zm9va2syL2RqVWVLQnZVNlpZbWlqdDBBQXB5?=
 =?utf-8?B?SG5nTjlSMXJHOFNKckUzZXVldGxjSDdiSHFrS0VHNUpyV3MxcndkQ0haTUpz?=
 =?utf-8?B?WjJvM3FsR3ZmOEhYQ245V0Q3Zzk4bGlXT05tNUEvSGo3M0crYU5vUTVWcnhl?=
 =?utf-8?B?NXphdkNpQzFySks3d1QxZ0toV2UvbUVSOFo3WWprT1cyREZLWFN5TWRQMFpJ?=
 =?utf-8?Q?skR4e/zL8DTKmIZFAq03VcyaknbDuiDyWgLU7ww0o5WX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9194bb-80b0-405b-7965-08da63744827
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 19:33:50.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Muoc7Cz9VZRCYoKM+Y4kurIrvVQyrkp5Daa8IUDgr0z/qU/pnuuH6Q5YUN+PO/U0WtvozPRYZuyQm7KN4OCK6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 09:19, Perry Yuan wrote:
> The patch will fix the invalid desired perf value for powersave
> governor. This issue is found when testing on one AMD EPYC system, the
> actual des_perf is smaller than the min_perf value, that is invalid
> value. because the min_perf is the lowest_perf system can support in
> idle state.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7c51f4125263..8a2b6ad9b8c0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -265,6 +265,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>  	u64 value = prev;
>  
> +	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);

You should also update amd_pstate_adjust_perf() to remove the clamp_t() call now
that it is done here.

-Nathan

>  	value &= ~AMD_CPPC_MIN_PERF(~0L);
>  	value |= AMD_CPPC_MIN_PERF(min_perf);
>  
