Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0C570ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiGKT3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:29:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AED2A254;
        Mon, 11 Jul 2022 12:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAx/sdUNz1X1OoPIlQqwzvCgYVJoPO2FxlbKuunjc0bXdOTVNJNTF4622Yz9twBwWPSA8HoWMEsGNU1u5Nh1lJ2Ue1dBNws4sgpep9cHnSc2I+fsTXQs4dl511vBs5ZZA+1GaHYw3ZqiHmQOU5M8fst7w5Fi7WDtlhm/bVuJE8+wXqfAvT3pgA68Ak+4DQZQ9qiTIdttR6hKsPfzSmTJQ+QMxarE3PtT/S2vX5yVcIJ4OXYEyM16s2Dxt+kJmW33zbdevsBamQj85RJ6AW8c2sFbQ7/olbfm9xy8E45WKluguWuMtDgms17ha4iCaTyGyA06tOdH9rsK7UwRiARXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2ErswRyTShyyMgySegBtT7WwSxROjjV3re2iC6pbW4=;
 b=Mlds+hEjVqWdwETVqPRqeufZjKTuhxCnof1g6CZIOz49ItwUQBXP8mxwncWnKYzKB0ic+WQwzRJrP3xIOKEiKctAyXNbySqkA9Z3V4nIPHYfyILF0XWuuYo4MN2/IrxReUHV9G+pOfR9uCQNL3tmKDPsM3W6Wvz7eTxCqbvHa0y0hRqtLzcf92FwJd0uYUoCaHa4EJ+fbx1iO17/lkrjkroRITy7iJZu93mHQYSJa23DxiLl5Hapoi0KrATtXraNJ36sN2DhRlm9Oyv9KBWUu6H0aluXpyQHZpl3kfYXOhvu/DwAVsPYJEPCHWhI9pLDOv2hTj8ICf7A9XS1TSk0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2ErswRyTShyyMgySegBtT7WwSxROjjV3re2iC6pbW4=;
 b=iI4ADMbjCDoiIXC1+dgoZPYxobkIP5p3fHVir/pAAMIaXpuwsJX8HkRDtuZ53RRjbjGsyIK5GfHRBi1xC3iVXLbuGlwkPi08qF5+HAnR+XkLqNcjLIYAHlbdt6ScGyMyQuMO4/BU4hXfXtYTjuFZLclfO0RuEm5Pj3PUIIIwO7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Mon, 11 Jul 2022 19:28:58 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 19:28:58 +0000
Message-ID: <c6db97f0-59a1-ee1e-c1f2-6bd999d72105@amd.com>
Date:   Mon, 11 Jul 2022 14:28:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 13/14] arch_topology: remove the acpi_disabled check
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, Ray.Huang@amd.com
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220709142019.836919-1-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220709142019.836919-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:610:118::9) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28f9d835-2ada-4008-52ac-08da637399da
X-MS-TrafficTypeDiagnostic: DM4PR12MB6206:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuEJtpni1dOx/U/SCV1I/i39T5E7YUiDWpa5avfjKoITDcMNaklmuCuNSPyUGKNOup4E7fMbEUCp+1tVTdwiS3C+DuZkY0lkrw5//lpuMMHELyIiKixyJaOiX4Boa27FXAzisd9UJjQ1yOxP67s0Ojdk8B+PKfa/8XFMYl/hproPybOYFWnvweFE0ezOaPO5A/P0Whl1f33HJTwj1rLlzlsUcK5GbZvy5LXdHrVdWq8gVtUHUm90Mdov4mWAI5SSDyzrxbTp+0f9GtKTORdncWGDZDJqany0TRhJkEZ0jItQ4+wvVnM/hV1xbNM0QZZ18pZKFo5mkqh7vswDInSA73+CTmQW5ng8Rq7iuFYLTTcpcfEdu4iLLq+kci2OA51FAy6bKglH9zUprR8o9YMZ7PGCgU8fbR0iIYNho2xSGLyZyB2l6XJGEj1HgGukoLzL3OG/X5Q5cWLPf9rxVoVEmA9pjWobDSNFF74WmKD+8X3Ean38gOPXMkwfkbkoYoteT3Isd6T7i/oV/qZES3ljiq7ob3JUNJ27VT36EoFIUetDNhSBG/Ofi5TOUOai483ggkKhRRIS6BIq/lwy2h6J5uM7TnBX9/vJcf6TK0A6DQQHjSE8CaUu2U3YLj+H7wr91TaNjrL3+so85ZJ3nf2qCaZu4mFrGLaRc0YHGmq/GK6TNvKpvJxhNHthbsr8tjQnqRD/kiyXsQ7E6vCvj2xpRtlya4VQFQ0CDBRA3Ms6kdrqDiNuT/toBDneETC7yGvh/CfsouKKNv17mo3rgv79JxoV1Pv+HOMZhfZFRhvwI8PHLOBEOfIAVfrYOgncFJZdAlJoHKOuMzS1o7TBU4ASI4viRep3gWUQgT4/YsROE3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(4744005)(2906002)(6506007)(6486002)(36756003)(31686004)(83380400001)(316002)(4326008)(53546011)(186003)(6666004)(8936002)(5660300002)(478600001)(8676002)(66556008)(66476007)(66946007)(31696002)(6512007)(6636002)(38100700002)(2616005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUgrM3c0SElOcTY3aWhIaXZ4dDU5b3d5bmVyRGcydEwwWWRBbFhPNGJCc3kr?=
 =?utf-8?B?ZWd3azdWMEI3UmFkaFdYOGRqa0E5aWVrK1ZkVkJTQ0Z2eDRxVzVZeVdaamxQ?=
 =?utf-8?B?Y0Y2R0VKUjBoU05GWTB6NG14RER1eEFwdmZ2MVcxYjlqQUlMamx3eDg5N3ky?=
 =?utf-8?B?NXQ4RHhKVytsRmJqZ3lPc3drNlJwUlp1eVJkRkwwQnpycEtlOWlpMXlhYzh3?=
 =?utf-8?B?Sng4YlRDVFYwYytMM2RlOFlwRWtaZ3E2MGVKUTFCY0kyU1liOUZQTFNubE9n?=
 =?utf-8?B?b21lS2xxVHdoYlQxWjh6WG1WWFpaRjBHcVREZWhpUUp4MnJWeVFyUmp1WEdt?=
 =?utf-8?B?OTN0a2FHYzZndG1yRVlBa1dpaEMrNmphZXcvMnJMOGZqTmFEdHdkdDBvcU9L?=
 =?utf-8?B?ZDVDRXlNQW8xSWxOT0JYNnVpWHZwY1RIeHM2WnMzS2swUkdmR1I3bFRsc21a?=
 =?utf-8?B?N3ErSVhoc0dRUmp5U1EyWjJoeEIvaVl2ZVJsbmRIUFVvWE01UTRtN2Rsek56?=
 =?utf-8?B?SHkxemdiZkVrWHRUbGpyVTdSWWtOUDZhR1FvL0RCZU9aYUtOSDMxNVJGVGlv?=
 =?utf-8?B?ZzdjQmVZVVN2b3RlZk9oSDg3enhackZwcTBpTWNrZStHblRvRENycUZxMWp0?=
 =?utf-8?B?ZE5MK1dSRVNLckxTa25yNE4zUXZGMlhSaFVvOWhGVTN0dUZqa3FTNmVBeVRI?=
 =?utf-8?B?TmZWTmI2SlREcFBtY01KL0RrUGJHNFhpUm85b2xQWllSQTFiQnp0N1pOMk9Z?=
 =?utf-8?B?TjNNMktuSEJXMVgyU2FRUzVSUzJjZXFhcUVhRDlLazRGN1h4QlJMN2F0VDcx?=
 =?utf-8?B?RzRaVjNoMEZkbXRWMlhiamM5QXNrZWhmaWVGY1NaVFRYRS95dmlIRjdaY1Fm?=
 =?utf-8?B?dTFHYlZBMEtIMUFIVWNaWXJOcnVEdkN4SzJMSDJkRTFxS1haNlVhZ3A3cVJ1?=
 =?utf-8?B?cGxjWG9LRDlOSkVIY3JvNC9VMEE5YnpnUVNZVk9Zam0xM3NWRFdKa0o4amQ2?=
 =?utf-8?B?Szg3TjhVOWswOHd5bDRrMDNMcVUwa0NaR1VyNmdKa1JrMEdqUkJWR09CcElZ?=
 =?utf-8?B?SXc1VlFiMUxhQng4Qk5FOXBBQndiZ0JmcDNpd2pBODYxV1cxaHJEMk5Eb0cr?=
 =?utf-8?B?Sm9Bby9oYnRNTm5heEhHdjBNb01tTTB5TXcwZkpCS1dQMExOSFY2akhERU5G?=
 =?utf-8?B?Z3N5Wk1FWldoYS9xZko5d3FqeTV5SEdJMTdJdW4rOE16TFcwYXgzRk1RQlI2?=
 =?utf-8?B?Z0tIZk5uSkxibVQreVNSRGdxbEt3Y0loMFBMdzF5SDhKZmMrTThGWHdra0ZO?=
 =?utf-8?B?UU5DODg3MHJHVzJEL0pIOGlyVzBYZmttT0hHTTNFZkp4cTkvQkJBbWZLUzBq?=
 =?utf-8?B?UnV6U3NjWmR2RFk2V25OU3g5dDFJWWprMUozaFZYVnN0WXBLMnhqR3o3WENV?=
 =?utf-8?B?VndiS2tPVTVwZVN4aytDMnZMNkJ6U3lsdXB5WElsZ0VadDNacm5FcFlINTBH?=
 =?utf-8?B?WGFPWWJualB0UFVlVi9DQWlwb2ppZnk4dVpyUExvZ0dpbWxIak1mZFhXR095?=
 =?utf-8?B?aVZZUG15VGduSThtNitxeWJrV0tQaUhxQ0VBQnpwd3BqdnQ0bzRPV1ZFYUhO?=
 =?utf-8?B?aDE2M1lGVVEwRWRqUHQyUkIrUUlCMlExQ3ZIZ2FpVzRMWjRLSDM5Y3laMVRH?=
 =?utf-8?B?R0xtNUJVNk1GdUd0cUFpUDkvOFhaK3B6c2lXZzVvaWtRRHRzZjRZMVZkbm83?=
 =?utf-8?B?RFJmaWprUEtZczFCTHZjYitDTlM0ZW9JNHBvaFFHNDc3Z1l6anY5RjlMZGdn?=
 =?utf-8?B?TlN2QXlscFB1SWdOQ3UrQWdhOGVJcldPWWJRMHRKUVRHTWVqa1lQZnd6MWxs?=
 =?utf-8?B?Q2wxcmVtOWNHamErbTNsSWVpMStQMFlweGhrbXRQYjNjVHEvR2dBTXpYOFk4?=
 =?utf-8?B?bGl2OCtMMjFkK2NtYTVBd3RXZ1p0ZlRhQjNCMzgvRVNUdVRuM3k3akY0aU9h?=
 =?utf-8?B?L3hmS2JheTUxYit1TTRucmpjNGpoZzQ1aHFmd1I3Vm16bjNaQUlSK1I3ZDdl?=
 =?utf-8?B?YXN4WkhMakt1MEovTEZGNXl1RWVHQVM4bDdaQ216aHV2a3d1ZjZxblQ4SHE1?=
 =?utf-8?B?c1JLYTFSYVo5ZHl5Tm05RTFCcnJXVnNNN1lJVkhWcUtMQ2hFZi9Gb0x1ZVlH?=
 =?utf-8?Q?StUqh8Lv+xexj7W7qDFmHaX7RilpRupwX6YW0cRxmPol?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f9d835-2ada-4008-52ac-08da637399da
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 19:28:58.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYp/c935Q9AHJtqZged2m6npr4z2z6O+KYe5bK2sn1hCwQUvKBtg0xMO6m4Y4nDXz1nZlAFDTLwedopKgUXxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 09:20, Perry Yuan wrote:
> "acpi_cpc_valid" function already includes the acpi_disabled check and we can
> remove the duplicated check here
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/base/arch_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 579c851a2bd7..73a8cb31529d 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -352,7 +352,7 @@ void topology_init_cpu_capacity_cppc(void)
>  	struct cppc_perf_caps perf_caps;
>  	int cpu;
>  
> -	if (likely(acpi_disabled || !acpi_cpc_valid()))
> +	if (likely(!acpi_cpc_valid()))

I think this should be included in Patch 11/14 where the acpi_disabled check
is added to acpi_cpc_valid().

-Nathan

>  		return;
>  
>  	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
