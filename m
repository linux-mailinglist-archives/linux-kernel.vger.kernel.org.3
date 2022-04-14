Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802A4501A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiDNRf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiDNRfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:35:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EBEDD975;
        Thu, 14 Apr 2022 10:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRsUK0RTQz8chUQeQWKUUznxF/8jUHohX6zoaIDUoduZc4yCEPaEJ8qnm2PAdzKdoGqrk0MoPU9sELZPi2SWaD8LaOhz/Yy+Z/c02UIQyFm7RMpy0lnUSgIJduYOiL07VVtYM6y1F7xZXycI5ZXriBCuS3eWjWRmiXv9HciIBqXA3DQVo2Ecow1sZP+3Krz0rv+98n6rcMjpiso7z4ug2fQ6PtOjlDH0l5OcwYIECJ7rx3njLoW7of4SY7K3bYlkG2Zjhmb8dL15ovQuQBrLN8x9PuxHWS5I1LJ3HVjuTgmCLoP9CvtdKgYJjCtVBIMk0W1RvmjMWA8MctmhnyaxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENg3oGxjryeUuC8nTvFK8q5De8Be3vJpjV2SryavaPc=;
 b=lE1XyO5Zrtg+uXL+CfAadbncRBKS6RbMM2CGx9RCNaD5BUXrIY8KVGDzqQd0HkECxoRRaU0EZy24GTquFWHGNpHwf6gTakvqMdRFuKctLly9cAMwVFBJTbjik3PErN5GUgpPGnLt4KPYQiTuBxf4k5ZqqcVdidbuVzf2sK4pxUyv8GjQV2rtrtA7hjJPREqlCcu2U0jN/k++qcXKp7KFZdhQBG+Sl/7vSqq4B12AuMVB9xh4aifu5tulqomr6/vBrT5vg8w7hUFtcO2ceHIhDR6h+LAo10yAMfX9YslLSHBddJv52mkDQCCCz6tDVJnMJwSppUR7wiWqZJtsgloSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENg3oGxjryeUuC8nTvFK8q5De8Be3vJpjV2SryavaPc=;
 b=p+aBvMDfIDCspBxbZs8wcyqF2Py9pGsfHGAcUZwwAgOyK24Wq9ds8M285/pVH2SqkTWapbNVQMbNrzMeBMExuxdsIymD/QmuY+i7jeMc0TFgq8yfeFALd7A8nh+RGRjfh7K1c0RyvciYKFyS9+e25RpmRPhnPop9yBqq9wky8AI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 17:32:51 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c575:d06d:b1ba:c877]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c575:d06d:b1ba:c877%7]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 17:32:51 +0000
Message-ID: <64d7f4f7-3c05-7f37-d9eb-72d9d079f8f8@amd.com>
Date:   Thu, 14 Apr 2022 12:32:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-cpufreq
 when loaded
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Rui Huang <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
 <20220414164801.1051-5-mario.limonciello@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220414164801.1051-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0242.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::7) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77c5848-6829-4d0c-b418-08da1e3ccd07
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0234:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0234801CFB0B2253A08961A1ECEF9@DM5PR1201MB0234.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzKKYpNm6fhdT/h4hiMyMMmSeqyfZndzT6uvEdhJR1pAhr0yjxMzFDQZcdhgO+wJOLoqsi5kQsmK1DLMWBcVvubKp0g4n2Vs13DKES7KQJAbDJqGK/MUUqpVNL4RIjJ85gheHdjaVuA0xOQCfvvejyCjhixx9pjjdNeLvjha0FI3KZIrRBXingE+jBF8QqXjl2URd1UAllDmDcNLBoQ4h3sG8/NuWTgtull/454XXO8yOxmtUPhS0b2TVuwLG8Z4D2n9B1KdHw09AL6YCfusXKGfcvqRB8Bh3PUTExyaqgG5D3RXdExHpkny3AhYzOYby8SRr4PciS4HS8LDfahxesN3NcTHaIA59REGy3E5CX5vsli9C3BCPtV+XHMBYQ/y5fkAVwkfz5X0jcRiOu4C71w5lP42IisRqLTpwMsbL/rPXh7NlJ0eRwEsLsWQmWdJuKDtHAlDxSrXaDl91Xf9dfzDQTPuyhA8eeGRr1JFjcRZY+WkJVKPVDvLPjtFILWLu1pILugyIUnSzkeAEKqSLrBMinrhScm3ZbmOiCTFD59ayIUcJOcy8ETeqQaq6q/IwWS1jfLllMaCeFtuBHgxpX+oO9ROY3FSYhw26FP3k1ABBYyfkFlxIgQQty5MuUgHSdyqJvDPKJRGRZX34N8XuZB5F120CIjwK3/3XXlZ5Rwn4QmP7iiqXFw4Q74/kWBiz2RXtE37xIN7aedQ7L/VcbF1OXOwaUy0HUBzHZ72nFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66476007)(316002)(2906002)(31696002)(54906003)(66556008)(110136005)(4326008)(66946007)(38100700002)(8936002)(508600001)(2616005)(36756003)(5660300002)(53546011)(6506007)(6512007)(6666004)(83380400001)(31686004)(186003)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRLZlB5alRoV2R1Zk9UakpGNnlNOFRCeDlRM2o0eVE2MUI3akY1SEMyb2FT?=
 =?utf-8?B?VDlvdnpnVXB2Qk9zSnNIT0NIMTRvaTJjbWhIL2pMcnhoOFFCcGJ3UXNnWkoy?=
 =?utf-8?B?M253TGJHRisxV2dqYjA4aEd1QWdUQzJFNEVHbjBrVklKVW03VnIzSVB4ckI5?=
 =?utf-8?B?MGlSM1Fhc2RrTXloVFR3TjFCc0xmWTRnanNwa3JSeUpaZmpRdVdHT2pNY3pX?=
 =?utf-8?B?cmROWTVlaGZBNW85L1RteU9yYWRseXplTkJyWCtJdkdRK2RZZVF1ZGtVVUVq?=
 =?utf-8?B?V1pmSmVOZXZ1dGNPMUdsRERRY0RROUxUTGpFYnljUnF6a3hpOXhjS1o2K0Za?=
 =?utf-8?B?NHN5L0VqTTlQWGsvNGUybVFvcG5uT3I2UHpWay9UaWw4c1F6MklPOXBSWkZ0?=
 =?utf-8?B?T1ZYUkd0TzNNTVlJMlJhQ2k2WC9YWEtkMFM2dDJkWFltK1pEbVBERHdRazM3?=
 =?utf-8?B?aUNnNGVZa1YzQnBkSGE3elNSb25sSnRFTm9ZSlh1RFJ1eFRjMW1tNkNXNVJs?=
 =?utf-8?B?cEdHZVRHVHExR1pkRTJadzJEVFBPWEVpd05NQWJOWHZvTHB3eS9Pc0pQOTlY?=
 =?utf-8?B?V01yZW9valVDbkk2VkhoN09lbUVUSkhDVDVqNmxyS3NDSXBhdUFUT1NvRzZW?=
 =?utf-8?B?VUpUZXFBLy9WQ0p0TkkxZkhVOEFyU3RKSVB3YUlvUzBMMlgwaXQ4RkVtMElL?=
 =?utf-8?B?c05vNUZtdER6TDM2Sm5maUxWOUhuK2k1aVlvcGVIMmNGUzk2T0VHWm5sYnls?=
 =?utf-8?B?Qi9CSUdHR1JldGgyQnZvVElNZEtCSnkvcnpZc1dOZWM5R245ZFFheTFXcnRP?=
 =?utf-8?B?WE55K3NHRnVROWJEK1Fxdk1VN0ptREF2SldPZnN1YjM3eXRBaHNGNkZ0VWtm?=
 =?utf-8?B?VFFabHgvSVpoMnFIYUxwSUtKdW9lSkZuUDdTaExtUUYveFQ3SU9scDM1cHg5?=
 =?utf-8?B?WlNVMXBuVmViTE5XTU9jZHdwQVNlcTZpZ01CYTZCdVB6djBrb3lreU9nUUlR?=
 =?utf-8?B?UXplYnpWZTkxWmtHT0NNRWY0bS81bDA3bms5WVpCeHZpOU55M3hSbkdpbC9S?=
 =?utf-8?B?RkhvbnREVVlHM0dEdWxWaVB6NmhiUzZ5bzhMV3BaWXhsWVQrRFZDbVRJNkVL?=
 =?utf-8?B?WXB3QXhJN2JTS3RvNVptcXVnTGJCajJ0RFhjSlFZaGhJQnBkQWk1VHd2TGlE?=
 =?utf-8?B?VlRDOXFOMFp0eU1NSG5pT2k1WFhoZUFhK2tya1I4VFlNL25sTTZodU5hKzB3?=
 =?utf-8?B?RjhHMnNDYzJSZjR3M2tEdzVBN2NPd2VVZ0hQRHdOdUVEMzQxRVlheHBHV0U1?=
 =?utf-8?B?akRlc2ZGbXp0QWxkbmF2K01mVzJudGwwWmNlaUw0ZmxnR3kzZXFLYjY3ZmFU?=
 =?utf-8?B?bWFFdGNtbFNhOVBMVXJ3VnA1R2ZPRjBrVm1BTm96bWFHQUR1UlJiMVBmbU5R?=
 =?utf-8?B?SzNSNG9wTVhvQnRpYVJxTHVaNUFGVWhhUWs0Rk1QbVQ5cHgvMDdJOW9oN2px?=
 =?utf-8?B?UnMvQjBoRWRDc0QweTQwclFWYUx4U0RsYTdwVjlldVNQWS81a0NNTmNkY3Va?=
 =?utf-8?B?YitTSmRQQzZCRmJyYTFOVmZnSml6N1dyY3NoRUNwYW5Ta3VGbGJtd0d3Tm14?=
 =?utf-8?B?QWorUkhFNWVxUi9IRzhTUFhrWUZWcGpvR0c0T2lIRWxhZTA4cGFIK0dTLzFF?=
 =?utf-8?B?TjJvVVM5ZU43MTN0NUsxOTlSRVUrL05HNlEvaVpVQWlmbDdyZVJXckM2Z1l0?=
 =?utf-8?B?Uk83b0RpVUFmcko2Y3pxMkFlbGgwNkV0REVVZDNWSDFFYmkyUlZhcElXVkVl?=
 =?utf-8?B?eHdxZ29DSHM4Nno2ZXNlTnJlbjVXbVF2MEpoMW5acDlhOUZzWjA0cDd2SXpJ?=
 =?utf-8?B?R1RDd2U3QlJHbEVEOGZVY3ZHSkRXOThSN3BneGZzdkg2bWF6WmY3L0k3QmpQ?=
 =?utf-8?B?VHlTTG9CVm5QODBYeFA3alJILzhmdEkzZEc3cEtKYlNwRUc1emYyWVFEVWlZ?=
 =?utf-8?B?Y2FZdTBaaVpzRC90dkR0RXFyK0F1ekgrdUZ5dzJjNlFEV1ZoTlZGN1FhNllq?=
 =?utf-8?B?Tmxna1VxVExBQU9nT2hTeHR6S21Ia1kwT3VxNEhDMUNwZTRvS0JDaEduSjFs?=
 =?utf-8?B?Wk01NmhQR2Z5aGpmejl1UDdnUkZpaStJVml5cmorSGYxSlpqdm5HSzNNV3R1?=
 =?utf-8?B?THJqSUhKTjcrMzg5MENtUFJLVExmeFAvSWlDZlQwUXEvSS9tSkhSV1RpQWM0?=
 =?utf-8?B?VXFUN3BqUDFTYjVmMTByZ3dya1JINkZWczdmQklGVUhxWEN0QnQ0bUhaNVVO?=
 =?utf-8?B?UEhjVk1YNzNWRW5oTFYzOWtwMFdnaEtRQlNoZk9KRlNsb3FWeDRzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77c5848-6829-4d0c-b418-08da1e3ccd07
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:32:51.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRxV1bi3vCMbb2M6rU7EyUkUrSnhlgLxsX1E2kZzNBS1bpvaSONdmWYKvg+k2T7eRyW9bcBA/NOyqFWnd0bIvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0234
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 11:47, Mario Limonciello wrote:
> `amd-pstate` can be compiled as a module.  This however can be a
> deficiency because `acpi-cpufreq` will be loaded earlier when compiled
> into the kernel meaning `amd-pstate` doesn't get a chance.
> `acpi-cpufreq` is also unable to be unloaded in this circumstance.
> 
> To better improve the usability of `amd-pstate` when compiled as a module,
> add an optional module parameter that will force it to replace other
> cpufreq drivers at startup.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Rebase on earlier patches
>  * Use IS_REACHABLE
>  * Only add replace parameter if acpu-cpufreq is enabled
>  * Only show info message once
> v1->v2:
>  * Update to changes from v1.
>  * Verify the driver being matched is acpi-cpufreq.
>  * Show a message letting users know they can use amd-pstate.
> 
>  drivers/cpufreq/amd-pstate.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d323f3e3888c..8ae65a2072d6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -63,6 +63,13 @@ module_param(shared_mem, bool, 0444);
>  MODULE_PARM_DESC(shared_mem,
>  		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
>  
> +#if defined(CONFIG_X86_ACPI_CPUFREQ) || defined(CONFIG_X86_ACPI_CPUFREQ_MODULE)
> +static bool replace = false;
> +module_param(replace, bool, 0444);
> +MODULE_PARM_DESC(replace,
> +		  "replace acpi-cpufreq driver upon init if necessary");
> +#endif
> +
>  static struct cpufreq_driver amd_pstate_driver;
>  
>  /**
> @@ -643,6 +650,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  
>  static int __init amd_pstate_init(void)
>  {
> +	const char *current_driver;
>  	int ret;
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> @@ -666,9 +674,19 @@ static int __init amd_pstate_init(void)
>  		return -ENODEV;
>  	}
>  
> -	/* don't keep reloading if cpufreq_driver exists */
> -	if (cpufreq_get_current_driver())
> +	current_driver = cpufreq_get_current_driver();
> +	if (current_driver) {
> +#if IS_REACHABLE(CONFIG_X86_ACPI_CPUFREQ)
> +		if (replace && strcmp(current_driver, "acpi-cpufreq") == 0) {
> +			acpi_cpufreq_exit();
> +		} else {
> +			pr_info_once("A processor on this system supports amd-pstate, you can enable it with amd_pstate.replace=1\n");
> +			return -EEXIST;
> +		}
> +#else
>  		return -EEXIST;
> +#endif
> +	}

A couple of thoughts. First, should this also provide a path to restore the acpi_cpufreq driver
if the amd-pstate driver fails during init some time after calling acpi_cpufreq_exit()?

Which leads me to wonder, should there be a more generic cpufreq_replace_driver() routine that
could handle this?

-Nathan

>  
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
