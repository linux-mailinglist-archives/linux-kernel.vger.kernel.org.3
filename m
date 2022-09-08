Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFABA5B1F6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIHNlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIHNlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:41:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27719E558F;
        Thu,  8 Sep 2022 06:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4zZhQv4DFskSIK72YOEqCkN2Jcq+P3WHWbrwQ3l4FfUvczTleIzuSsoB00O7TzppL20g2f4GRRxY0d43PKvOxSFhgSahUWr5Aa0Wq1Jc73EnBT4vfTRK+m2+xREVpJB6stpyVoQh3jrnfb3obiiATJAcsMoDzcPvm4LL9qI/XEYx8tZP3+RBkZhd1v3AR/AuVq922zvSVjctSe8sPVhlsEmMkXAUf2WQJR9F3nzhWM2ffV4JXd0J4PbJlQjpd+Jr9t5jQvI3xoxBYHsuOdjfApln97PzCcbaUKzcBw8JYIntqXCNtXADRiVYntfyB6bdOrbZ3Hbk26BhcSXSVuY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkAGQjH25/1GCDt3Hls258F4l64BN4RmMbX63D8p1rc=;
 b=fc+1Rovb70P50zK0pvHNUuJrfAFtVgylHCy2gTUg44fCByuF6bN/Ea8nxiVMPeIS/9d6lblum4YKfVvPbH0IHlxU6EuDhaMpAAdx9fcI89egJ8w3SillE91BRTs2U1Oo32R4LJK/7HMMhOi1x06V89/zp8h2+KCruMP7jpXWNpqN4tE2VjmdPf/zaPTbunt6UP1smzHyNlwDJTk8z6uhnEoi7nhbqTNdcTa1uFt1CR0TcqVW+6myTd+32FkqWL9AEWj6Q1Wgjnn6mPvgsvKXqxH2BDwO+aO4zdGmcpdI+uGmDsZnCDK6q+nDO8zqQAiO+KmuAAxx3r4mMj80eWLtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkAGQjH25/1GCDt3Hls258F4l64BN4RmMbX63D8p1rc=;
 b=1vGEwrm2cI2WpCZxIDmbpGCEtyzLMBGfPYxs8Hs3hv4zqwDX6EuI0XiT6VVcLpg95b/O35jjmwsUFDgf3XEiwO8ftWUD6ttKGho9CLxXYkHvCuPDZJA2iXd0Y5zYyc/hxxROfjq3DFzGKGMLoYdhzUR5iV3gNFlkqlBdvyRP6AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 13:41:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%5]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 13:41:06 +0000
Message-ID: <042f9e06-edae-87e9-413e-4ae4db6ab452@amd.com>
Date:   Thu, 8 Sep 2022 08:40:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 13/13] Documentation/x86: Update resctrl_ui.rst for new
 features
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257368995.1043018.8665350782054895088.stgit@bmoger-ubuntu>
 <Yxlqn0C8rDsLUHNv@debian.me> <Yxm1UJzpjW+AjXzQ@debian.me>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Yxm1UJzpjW+AjXzQ@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0399.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee3645eb-d7c3-4c09-0805-08da919fc786
X-MS-TrafficTypeDiagnostic: CH0PR12MB5369:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yflRNopWID3GgP+5zVe5E08ozqxJDeqPd2p4fO5JAEvSaIS5CIdrW5ft0d8pJxk6nkANyNNdkYQnf7j1gKH7bdou5KRGr0+9VVP+eTzrPvolcYqx8za1GNf3L3n00aoDERWr/LjGoXGsnJIGdsbtXOYdCenegzfbiXVtH64JtKaylATyHeUptxZb2Zzq5aluVf6NG+ZeWRNqopodXlpA3BerauPyXOo1Uk5eiC2z2KJbD1pU/MiMBN1eXHgoaTEfDdmp4QFYvXrELjIai5n1sNjYetXE0dnDpAMPkYqAEGyDG0ywC+f5S78SQckM+0jJ2RTEIvSk27Lqkb3vOesyfsZ4a6NpbQ1uwsziPyDY5pxi0LDYF7beLzwmlfwHQ78joCbX5A+U7n+X5lxJWtnyBsOS+JPZJj8wOel+5VPaaJymSlBSzDFQrvaM7RQMiBkuQB3AZ7+rHNIE4nm+ZBI736K2yENmW4PafNpdoZAFqwfCacYpCSCmken0L9bGYxqm4dVE60iTxXGHHoeOzbv2iXGxkLAcCyvjlph7jeLCmWl9lJCLwL8zaRF+quyxBtLUXrg6HKFwcsaIAY1mVn5lmY8qX2g04d/qWsi5AWql7PMkYEwgtJAVHpuCFlEswNJ9pWROvxGkCgVc8+0NZn1RmSsweocO2hs2qqtuNSgMTYMDBF0gtTiiQ/gFPtKLkyWszklWjxXmKU4gRw5LL65v3DodRZjtrs1i/AmKkzo3QLO5slIOTzSHUPQUkpa5WR2ijbUp8c1rVmTv9B0ArufRlrxpb3l9bpx9Yjvds0SAgIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(86362001)(66946007)(31696002)(66556008)(4326008)(66476007)(8676002)(316002)(6916009)(83380400001)(6506007)(53546011)(41300700001)(6666004)(2616005)(26005)(6512007)(186003)(478600001)(6486002)(38100700002)(2906002)(7416002)(5660300002)(3450700001)(36756003)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJ3NTlaeUF1YnNWM1lpUVBqU3BrMzlBMHF5YzljYWsySWxXSzhiMnZPR3Br?=
 =?utf-8?B?czBDMUFmSkh2ZXpJbE0zeXVNM3huRFlWSjlMWllTZzdUWmZ3TWFxS3NVcWFy?=
 =?utf-8?B?OG1FWEwya0xnbU1uUlpEZlFLMk1nZEhUUFJUQmd6TXlESnhDT1YzU3FVZ0w1?=
 =?utf-8?B?WUQvaEJES2FGeXo5Q1Y1ckROdGhYTGJwemMxTDZ2TGplSHIwSEl1aGNBTGJX?=
 =?utf-8?B?Ymk2Qm5hZko1dU4xbWlwemE2SWUrZGtMZjVoZ2NSd1RacG1EdS9YbjVrUzFl?=
 =?utf-8?B?QmtOMDNkdmU1RUNCaEpRMk9mMS9JclR2bnMwYlQ0Vnp3RUQ1c2huQzNBWUlY?=
 =?utf-8?B?SWJRK28zV3EvV2FlMlpSV1FSbDE5TzBYZVRtZHhsSVZoVDhYNUR0UmRIaElK?=
 =?utf-8?B?M2hKMnVXYlZnaHUveWFsSFhhYzlhWHBheGV6dTBZRWxtNUU2czdrY2RWRC8w?=
 =?utf-8?B?OEZPd3hiVi9BMlJsSjExeVBqN2FJQzV0R0pmWHM3RjVCNk9YRkdDKzF2c0xH?=
 =?utf-8?B?K0JqcGRhVkZJMzFOSVJDNDg2ZDNlQ01zcGpHVGZQeWRvdnlZMG8vNXBlL0tT?=
 =?utf-8?B?UVI2aWRHRHRxeWdZVkZkbVAyQ3VYODdONTdzeVdkWnVuL1Q1K0oxMFpreEk5?=
 =?utf-8?B?UnpjT0dVdTZrMmdiZFdOY1pXVm9ra2xNWkYrbnY3anBtRzUvQjE5UnFJaFJN?=
 =?utf-8?B?aHNxd2txQlZQa2owZGI0TXAzd0pqZDdtU0lvcVVYRGp6RHdiaW9kc3ViYVM2?=
 =?utf-8?B?NzJueFE2VWJKYUtoRmRKSi85bUxyVW1xSHpMYmxZazdRREtjMjd2ZlhsTUdv?=
 =?utf-8?B?Z1FrcWphOGFlNXZOcVlUd1I1QSs1MW5SWHBLWWsrUWg1QitiSVo1TDdZOXJG?=
 =?utf-8?B?RkcxK3h2QlVLTkdMT2FtZG9xcmc3ckNGODhkSzJ0WGRlOVpieHZZKzV4bEFK?=
 =?utf-8?B?Y0J6cmovVmFBRkdlbkt6RmR0eXUyK3JEODJCZUFjL2tLdUNPZ0hxZFhITjl4?=
 =?utf-8?B?Z0pNNDR1MS9IQ3dXcis3Q0VUK2hRZGJqTCtvRlZrT3dYMnZ2MUVzdVA1MFBZ?=
 =?utf-8?B?U2tkQ2ZOcitwQWc4V0MzbFdYelIzM0ZRaU41NDhENm4vMEVkVXBGREV2eGd6?=
 =?utf-8?B?M2phS1cwaFpBUjdpWklmbXEyWjVHb1YvYjhGQ1B3TmpMVnRSeDBZZGhSRXBW?=
 =?utf-8?B?K21VdzhhTDgvS2VBZDdXWjlJUVc5cFM5TG9SUklZRGdHOEtvalkydFNXOVd5?=
 =?utf-8?B?YlNsd1AvYk0wQ0ovMDc4Mkl0bk9UbEdrcG5pNzlEZGxDc1dCUzlqcElWckFm?=
 =?utf-8?B?U0F3TkEyNnVVSnFLTDZxb0JGRUpVRFU5RjRucVdVWHQ0bGRJZk9SLzVuRDFY?=
 =?utf-8?B?MVdJVnY0bUxCRlVJNWdmeHJDdGJuejF0ZkloN0RRcjN6NWV1SkFBZzkrTUZE?=
 =?utf-8?B?dVhrY1JJSldZLytJSk4wcGQvNC9acXZvY3VtTktSYWJWS0RXOC9RMURTNnds?=
 =?utf-8?B?L2RNakRvRDhqU0hhSzI1SnY5RExZdmNMaDhjRVV0SUhPNENabC85WUJzMExp?=
 =?utf-8?B?MlZuSEVpUUVmd2c3WElLTENoS2NHUEZxdVNYdmU1b0xTSHdrQXZET2pQWCt6?=
 =?utf-8?B?S1FyRk9Uai91VitIVkVuYk9lUlJ2VVEvUEpqZGFrUXl1azdtcnJXcGx1by9t?=
 =?utf-8?B?V0NoeWc5aUkrMTFMZFU3bGFiNjBlNERVT1p3MEJTTDJBbFZMTUtxYVFudmJp?=
 =?utf-8?B?N0crNERkVllBUWRMeVU0MUUzNkR5VmpxVFZvVXVQNnNKK2lZWFZVOStRUVlq?=
 =?utf-8?B?Y3BlM3o0MUJjOEFPNXpZc2xIZml5dXY4MnNVbmkvcUNuV0FnUWx6OWR0M0JG?=
 =?utf-8?B?dkY3Z1FmNzU2ejJ3QjNLUUpZTTNPT1lsSjduS3NYbC9PUkhsM3pJVXc3K0lq?=
 =?utf-8?B?UG1HOVhFdEc4bFJ4WmdsMHlCU3lDOGErZnRqRmMvRW1mejQ3U0FicldYL0lP?=
 =?utf-8?B?TDREY3htNDFINjFwZUIyVVpFeFJaMmNrbUl5cUt3bzVvblhNWUF6RjRma1Zw?=
 =?utf-8?B?ZWliVy9vZkR5VGVBU0pITzZqUUYxaDFKT3R0eUxyNzN2QzRHSXFlMzR3eDNN?=
 =?utf-8?Q?Ycv8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3645eb-d7c3-4c09-0805-08da919fc786
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 13:41:06.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBFceNLGErd7DthNFKO+0bAxiwkfVAyc5vuEvzYGfiWy9l3xSLmLJIC/dTuCI9gx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/8/22 04:26, Bagas Sanjaya wrote:
> On Thu, Sep 08, 2022 at 11:07:59AM +0700, Bagas Sanjaya wrote:
>> Use code blocks for terminal output above:
>>
>> ---- >8 ----
>> t a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index 56581587c1a331..6474cf655792bf 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -163,23 +163,23 @@ with the following files:
>>  "mon_features":
>>  		Lists the monitoring events if
>>  		monitoring is enabled for the resource.
>> -                Example output:
>> +                Example::
>>  
>> -                # cat /sys/fs/resctrl/info/L3_MON/mon_features
>> -                llc_occupancy
>> -                mbm_total_bytes
>> -                mbm_local_bytes
>> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
>> +                   llc_occupancy
>> +                   mbm_total_bytes
>> +                   mbm_local_bytes
>>  
>>                  If the system supports Bandwidth Monitoring Event
>>                  Configuration (BMEC), then the bandwidth events will
>> -                be configurable. Then the output will be.
>> +                be configurable. The output will be::
>>  
>> -                # cat /sys/fs/resctrl/info/L3_MON/mon_features
>> -                llc_occupancy
>> -                mbm_total_bytes
>> -                mbm_total_config
>> -                mbm_local_bytes
>> -                mbm_local_config
>> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
>> +                   llc_occupancy
>> +                   mbm_total_bytes
>> +                   mbm_total_config
>> +                   mbm_local_bytes
>> +                   mbm_local_config
> Hi Babu,
>
> The suggestion diff above looks corrupted, so here is the proper one:

Sanjaya,

Sure, Thank you.

Babu

>
> ---- >8 ----
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 56581587c1a331..6474cf655792bf 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -163,23 +163,23 @@ with the following files:
>  "mon_features":
>  		Lists the monitoring events if
>  		monitoring is enabled for the resource.
> -                Example output:
> +                Example::
>  
> -                # cat /sys/fs/resctrl/info/L3_MON/mon_features
> -                llc_occupancy
> -                mbm_total_bytes
> -                mbm_local_bytes
> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                   llc_occupancy
> +                   mbm_total_bytes
> +                   mbm_local_bytes
>  
>                  If the system supports Bandwidth Monitoring Event
>                  Configuration (BMEC), then the bandwidth events will
> -                be configurable. Then the output will be.
> +                be configurable. The output will be::
>  
> -                # cat /sys/fs/resctrl/info/L3_MON/mon_features
> -                llc_occupancy
> -                mbm_total_bytes
> -                mbm_total_config
> -                mbm_local_bytes
> -                mbm_local_config
> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                   llc_occupancy
> +                   mbm_total_bytes
> +                   mbm_total_config
> +                   mbm_local_bytes
> +                   mbm_local_config
>  
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>
> Thanks.
>
-- 
Thanks
Babu Moger

