Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1B56AC48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiGGT5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiGGT5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:57:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503645C9FB;
        Thu,  7 Jul 2022 12:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0uHmbU/2NwcWVBFdaDhlE+uJhE5kdr5kZ0XXOOWQoor/SlYWxovT52kcae33aYSrTK0KkUZ4+qjdecdB3qHyOHXVkDkYudKPpRMytcqRvYhRwJZZAOCB6EanZ2TGWPQiPo188QGgmcY3q+pCRTu1NGsr+/brlPpiFFBHqb/vS+vJdiOB5C4iDdATBRn9xO5sBwe1roUM1915LRcdFgcKVihTqCirExnBSwCy7nCHloJ+sP1e1zI1s7EvL67Egze3B3UfdsisYt100jXBW8/rkbHXPUli5yIpdcKvQcTa1sCHuNJ5RAQiGpHxg0KkBBkGmnw6lkRMEO+RkGuL6Yn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACB9iBXddRZ0jNDzdTGFhYI6JAtoXztnfWpt3O8cAKg=;
 b=eM0CArgXU1/jj5kfumUuXtzmhrpAlkyG2IGOhOdhFXTjsihfK7RGvVORxZ06EbRsjJ2v3Tb3oEVDq2BpasAyHgnFenNuAQqple+PYnvoc/Jq/SXzz/Q9KpgAxx5b5Xhhh62VFlfI1P5YyUySltow/eK7rt89qcD2TT7r+mLE8KfuK2GXxODAK+LiTK4uSl5GaK5r3727hzsVv0NbO3GAGLzyCP0MBpSWoZQE1ayS9FDmsbmpnf35kqKIfMV0Zdv7IvgkP3QN6w+cUJphXJTEJoavOImBaWERmI2OamVlwCP/znD95k/zwXYUiFpTHDLhIEFrn/RL4HkUb1VyCi4Kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACB9iBXddRZ0jNDzdTGFhYI6JAtoXztnfWpt3O8cAKg=;
 b=2DAme6Qu7z4VxMzw2CIYUHUI2ELc7UDmSdEAhukC2svrQBNehbIbc3k8xXcn6scJOx4ko0fgUa0QESDn92bQcddtrhye1q+80v/NItBfW5vBTs+j9e8Wgy+rUwJufc+v0odma7olohW2N3PcLT0m9ioH4rqU+n8XeRgtUFiv3zY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 19:57:01 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1%3]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 19:57:01 +0000
Message-ID: <c25cbc3f-11c6-aca6-af7d-a4d7aa91e1ae@amd.com>
Date:   Thu, 7 Jul 2022 14:56:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 07/12] cpufreq: amd_pstate: map desired perf into pstate
 scope for powersave governor
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, Ray.Huang@amd.com,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com
References: <20220707170022.216202-1-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220707170022.216202-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:208:329::25) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1583cd3a-1fdc-452f-537f-08da6052db65
X-MS-TrafficTypeDiagnostic: BL3PR12MB6643:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnojGnY9egfYei91/6+U67L08FA4+t036vSiJrOXqw4zWNYCR0M2SNFaMBFApMFM1AZwMFQS6/CUb9i4QVmzPB8NDqPJUmyuBm2PlWlZuoyhyyEX3gMmA9h2nIubwHwPAeC/gnZiqwxT2GFoU2NWnDI52DdDC+tiEeOZKSMrPTcmDxqflSEnmuwOpnZ2a8HRRBnjBsv94mmYlJ6nO79t3Edg/AKGk2NIm+vJc9pSWZrEdrd8EMEGZqh/PJTcMoiH2fQAKe/X+UrxfMJXNs4Wdmp2qeFZ5seqG+sdUYcuS7eldk3Iph7ZVBbjsNm/bO1p2j7S2d8eYnsbypJ1i1EID1GZqee54FDn1saQGafMCmpiau21KY2OuujPOYhDC2NPNpYMhgLKAIjRlVkIdDffQQyDsZWaiqsylo7MchPBCaZSetmKf3KnvEwT0uKb3U/QmVRUJVl68J27f6aaFIsGuB0lMCK3BPQI53jhGr90YKjaQk4e/DbkXbCJ6zGUM5CVLxFuWmWDi/M11CVIGC7/6M3C0UiyqrhHPzzNwQ3e3kuPlR/HV1HhLNApBuHCxcWn/LTaZQ2nzxbA4eB95t703wPN7owwf/2UgLVG5SyJnNSYwQ6XC3jkJfwIbo9IOM8oDDZPa0Dyc8KmNG7SNRwWzX+Up3WVqris+SnLX7UtILyH+5LWA10q3kUZBN43RDDHlgGExGisq4/jCjGuH4I//esg+bFWOaYpJ8+XSFD80PzySPOHoVVIqtLikd4VQCr6QJtr+4a3MrC+eNXLQwVP21l5ELIW8B4Cco+TKXBmVYqEq5Z3OzTw+XITxJmEtB453Wl3KDcUYuh781ppfzdI3QCT2Kt/vw8DP1DkWnjYi2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(26005)(2906002)(6506007)(6666004)(41300700001)(6512007)(478600001)(8936002)(6486002)(5660300002)(53546011)(2616005)(31696002)(83380400001)(110136005)(186003)(38100700002)(31686004)(66946007)(316002)(36756003)(4326008)(66556008)(66476007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHUwd016eHlZcjExMWpXbVpzVzFkOXRPMkV4ajN0aHdwUFJ1L0gzbkkvZ1Ft?=
 =?utf-8?B?aU94MVc2UkhOU2llSnVEZi8zbmxhMWZCNWVaOGNXeFE5ajVMMjhWNEkwN3B5?=
 =?utf-8?B?ZkZWbXNPNGs4U2thaVpNdnc3eUpFa2hoYkEwVDRQdU43M0xQOUNiOUFLcG12?=
 =?utf-8?B?UjQwZXRQeTNRYmRmcnhFcFRSZTZzcTE5Q2xFdUtkNFlCdFNHNXl2Z0hEZlJB?=
 =?utf-8?B?WjhlczVMMGQvL05tRnU5ZHAvMENDRno5MTN4SnJEbDdPa0JURFRHWXdDaWNu?=
 =?utf-8?B?NDZOWHhsWm1zWHhsdWxRZk50OEE2c2tRTFZaMEZ0aHA3TlJRQkpHdHRQS2l6?=
 =?utf-8?B?UFljSC9JcGZ3YVZVQU0rZTZZOElsc1g3WGNUa3cza0lrMGVyNUg2NFYwUnUy?=
 =?utf-8?B?OEM5K09WNmFkYmwyK1RLSGJCODBrVFlTR2gxTzhsQVVJN082aFh1akZQcStY?=
 =?utf-8?B?cUM0cUlBZXVyVkkyaTVHc1hlclpTVnhqSTE4cUY1VGI2Z24rSFFDYlh3U2Fu?=
 =?utf-8?B?L21kZHVucVk5K2tyWC83RTFzcDE1YkJueWk4UysvMk4rRlkwcW9JcHZVcnpn?=
 =?utf-8?B?cXh4RnhlQ0h1dDRscElQWjRmeFJxYkhGendtRzdnSldveWJYdUZlM2ZEVjZO?=
 =?utf-8?B?SiswMFhLcEpNZjNYbW9iRG43Vm1aWS9EZFY4MzkrUU1iRGZsQ0c1dTA1U2RN?=
 =?utf-8?B?WldqTk9JemZBTzZVeG9SWUpBaTE5RjNiMWtnM2k4S2ZkWXBmVmFQWWZiZlVS?=
 =?utf-8?B?VjdrM3kyR3p3LzcyVzljR0xTSU1obExISzZ0UFVqYU1HWnhMb0hmM244TkN4?=
 =?utf-8?B?TTVEU0VpNjROdE9OUW1MaUtITXRrelhlV0FYcWNoa2syQ1pFMVFjeE9OUllT?=
 =?utf-8?B?Ny9pQkh5S08vRXZYWWI3Q0wreFlNRU9BOFBkTTg4RlRxV2YvSXVvdFBBdlNG?=
 =?utf-8?B?YUJHWURHc1owYXRmb2R5ZVpjVy9HZ3I2c0kwNFdlUGVCbm9WaEQxRkpRZzRZ?=
 =?utf-8?B?SnR6SS9sNjdLNExPSkxBT2V1M0lXVXhLTCtMM2F5cHYxMzNndThNMnRkSG9B?=
 =?utf-8?B?SkRmZC9ScURTTjZmaXhCQTY0SHhPVnUwRm10azAydkczNVhYVk13MHFUcVhY?=
 =?utf-8?B?UWswelpCa1Q1Z0piQ0RFcllhMHpHa0VKWFZ4U1R6aUNiRzg5MVY3NlcrSThU?=
 =?utf-8?B?SkFuVGhhZkZ5QTVhQ3BrSGJpSUFiWUplVEFxdTdoWDNrbmFDSWJkek5HQ0w3?=
 =?utf-8?B?WFVncFJFc0cxdFgwd3I2bGZuZjVsYjJ1dGpENDhvR09SLzhOTEhEUWgwQlc5?=
 =?utf-8?B?UUlDQmdrNmI5K0I0MllLZDBQMTJOM29zMW9OeGhZc25qYmZnNUtuOEMzVzIx?=
 =?utf-8?B?ZGgyQS9oaVgzY2tKaXpTSVMwcUd3QjNaeUVIdVRSMVhlWWhJQ21Jekt2VlBO?=
 =?utf-8?B?d1hod25ZQU9SanhDNytZQ0kvZVNrV24zWXRmQzRGK25XK1crL0xHczBkU3Nq?=
 =?utf-8?B?YlVKZFZZem84OVZSN2MyZG9MMzI0ZUFORmtkY3NkZVplVUlwUysxNnEyWklv?=
 =?utf-8?B?b0ZROFJ2WnZURVdCRTBZOWFVZE5TZzkwL0JZZUtNaWROMjF0d2s3VlNWeDZu?=
 =?utf-8?B?eDRZbHRMT1gwaWtYSURsdjNoYmF2aHoxK1B4UElib05CeHZPS1RZT1pxLy96?=
 =?utf-8?B?K2FBdzRSZUh4YlUwRGhHMU41MGk5WHBKVTExOWNtZDkxVjhmWUY4dkpCVGxX?=
 =?utf-8?B?eDQ5dnoxL0tocE92K1oycHQySDBqbzE1L0RtODVNelpaV0FrckVIUWVZRllF?=
 =?utf-8?B?dDdtREJUaTErdnJsbVIzNGQrY0t5WlhGTGJHTUsrZ0VrVVZMM20xb3pvc1h4?=
 =?utf-8?B?N0ZXUkwzbGQ3b0duaGtOcElMenJsMFlBWEx3Vmd2a2Fhc1hGMGR0Kzl0aVdN?=
 =?utf-8?B?OU1ZSFBVWTk3ai9tZmRSb3RuemdvQWttZVpKNnhlS3JTcjRwOFViRU9JTDlZ?=
 =?utf-8?B?eUpweDZ1WGtDaWlySUdNTEpEbnVrZkd3d1JyRE5uYXZNRXZjT1pCaXZBRStl?=
 =?utf-8?B?WFRnV3VVVlpWYlkvWm5uenZPWlFONmJpWE1qNjk2QW5lTWtNcGtFK2M1bXV5?=
 =?utf-8?Q?qyuLJjAx0TujGIAddq1zCABRE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1583cd3a-1fdc-452f-537f-08da6052db65
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 19:57:01.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P436tF9BSGtdqh0Y56m1pCqKqVECI7/joHd+5hUXTZXkhhEOszXHNiL9Aujnu4JggcRxDz4sZCw8CJ62tBc9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 12:00, Perry Yuan wrote:
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
> index 7c51f4125263..154eed849f38 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -317,6 +317,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>  	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
>  				     cpudata->max_freq);
>  
> +	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>  	cpufreq_freq_transition_begin(policy, &freqs);
>  	amd_pstate_update(cpudata, min_perf, des_perf,
>  			  max_perf, false);

The clamping of the desired perf value should be moved to amd_pstate_update(). The
only other caller of amd_pstate_update() is amd_pstate_adjust_perf() which already
clamps the desired perf value before making the call.

-Nathan
