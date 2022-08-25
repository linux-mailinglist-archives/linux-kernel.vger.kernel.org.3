Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F975A1903
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbiHYSsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbiHYSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:48:17 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766CF1EC6A;
        Thu, 25 Aug 2022 11:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYt9VZJt5DzrTEnvJtkie0bkPzkdBpkqCOsX/qpxgVHaU1WqardOWZvElUugklh5xC2DB2Ndlvfh6cwTLsWmHK/8boMNpoGXrNz+EcURyt48l1ND0K5jW6a82XEj7ihq0gHv0osBn3NsXdUADemdG1MLAwtVBBPChRpDVmIxciWe8L38ldgxAa223K02mgy2QdDi4C9Qr6fFZNYfDYDKdGVpGsVQfwtjTP8o1xCF1lBl5hWYt3wgqqYkTD521fAyzePBsCARWORzDoolrYHnvvcO1yO85A7sk4o/VdHelbupa2RW7SzsPdS6xZkxIKNt/3YDCRRBkmMQNR4aOTggAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaVsALK9inLtnrnSmMl0J+RR42iHPcC/WtiHDRRNs/Y=;
 b=DIYvLDtx4hy2QI0rFGiTebHYZDgoekj4OX35HsJByQltWCYWhyjqHlGeHp6LMtU7aKTQteztFeP7NngWGNEy2sXoOW5hhCck6sRPUItC36TEWAGo2UstERdDowS5qnq/TFh1LwuoRzBMSCEjLF1b0DFs1yCjeDsPmCvX9IURUbglsSoIPLHd/tJsp8C75YMrQrKDnEjKMuorqDEqlA5P31iOo4MnyDCnrCA1jzJHRKEDmL7N2bNLSkE7iibgvio32ZY4lzZlLpY8K3Q6Il1majSUrDFnZmF6yyTAn0UOz4QYgd9g0rOCwj/xFNW+zAka/DbvrqRw37vFgsbx2kE+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaVsALK9inLtnrnSmMl0J+RR42iHPcC/WtiHDRRNs/Y=;
 b=2q91JgwRNfoPhGvCICAkcX0V4GlT6SHlM7PVzsNDmHgVKFn75KD37hYLmRNIb6E6NlqRDudLDlziCF8YQajObe+/KUyGEFRglmz03aebvJycPvMfvFwL4bqcF1RCg109c++Gjgp+vY2QE5QfNab3nU/0XMe9NfUcKJyRp+IUHVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB5699.namprd12.prod.outlook.com (2603:10b6:5:35::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 18:48:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 18:48:12 +0000
Message-ID: <018786de-1609-27e0-85ab-bcc7fdaefed0@amd.com>
Date:   Thu, 25 Aug 2022 13:48:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <12054041.O9o76ZdvQC@kreacher>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <12054041.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:610:4c::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04e6334a-b347-4643-0182-08da86ca5d08
X-MS-TrafficTypeDiagnostic: DM6PR12MB5699:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZ++cEXElYGJ7iYV2iEC/5wO23x5ERQBQTX8IPtIzXe7+pn+Y8wkx2j4DslentKzb8rLpwVcsZM0qfvbpIok5IPyvnbkJx6brbOcEceVQ2OGo60OC0COWMxX3dSC28gloJi/s52EeTDRVg8vJC8KhXJOl471BceV2DPy01kjXuVYikNqiu61b4w6UHFYJGREfoQnr2pCRaJttpp8SM8xB9xX59wa8Ua/+TA6zlLFFn0T+EeZxwZUXHCh8HID9/WcpNI1cZlwHXNkZ5RyGl1Uapb/X75AQ17ozo/eFqTUN0BZfSoL8l19C8m5QTl6BtbsXQ8/br+4KE3+24hGkrFV1oZPvEYZPliaQnohpw3O3ZBpSa+/nPeQplIXGkLzs9w3Z/+MFLuCZaH7at/mFZdpwEEMESoHSeaKDY/8xSKogBpmUNzgEW+WifaPr6Kn//50HQ1BKeBhPUdf/AwUh1BjUDT+hD8iv9RprC1F20Ak75SCfSuWRHzPnePtKgpgsE6wF3O6FLM/o0kTRUGnuLz1UdEFEmgGYAt46q2y2TUzb21+7z2nt4gS5u1Q/Txy3ZRjMsAAuAjm00CrHjqlFgj7k4eoemN8ITXqRoZQVlIBZI9dPZNELe0Yz/wo8VnoIR3DrLrI/hNRd37uVrYwAaErNMIYo3/oCv1Vg4LJPvCUDLQGpOuKOqOBfU7yyUo4wfOO3uUUyTH8/Oy2i9+DJE4CgAHOByQPa/B29wRhCfd+4KIq5Uz6NI66T4q4vv/zUDEJQqnj3yKgM24vTg2m2mUtCcj8xb8A59C3f8r6wjC8kutfLDjwInYUtRaKIqeyegtMXGs16sMf7BvRBeHUDe2QjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(54906003)(110136005)(66946007)(66476007)(316002)(66556008)(8676002)(38100700002)(2906002)(26005)(5660300002)(8936002)(4326008)(86362001)(6512007)(36756003)(41300700001)(2616005)(31696002)(6506007)(31686004)(53546011)(6486002)(186003)(84970400001)(83380400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1FjNTA3ZjFlZGYzR2p0bnVEU3JqYUZNUEZ6L09WNG5FN0RaWEg5TFg5ejN1?=
 =?utf-8?B?NkVtTnVqcitmNWY3U2F2R0RGYVhsbmJVYmVPTTJ1UEJDaWZtRTNpaldvSmk5?=
 =?utf-8?B?UU1tS0FYck9Qclh3QmlVTk5pbEFsMzRYR3ljWEtTOUFTRTk0SXdmREdJbnZN?=
 =?utf-8?B?cDhKUmZKWENhMHBzUHdGSlNPMkJlRnRseXVRaDU2NFZTc2Z0YzFjQ1lvQlRX?=
 =?utf-8?B?YmVBemtyVVlVUDNNODlUSzBnZGtXcUdsVVIzNzBLa0M5b2psN3VuaUtNdk45?=
 =?utf-8?B?TlBTcWZUdUJ5bXBhSzI0eDFPUXhENmdDd0w2dmJXWC9JVG40RmhuTERKaHB4?=
 =?utf-8?B?a2ZRRW45azVwRzlWYVNGVWRsMEU5ZU9ZWUNIZGRWNEJVUzdPVkVCa05RQ0VK?=
 =?utf-8?B?Qm5xall1R29ZNC9IYnVTcm5HZzZ6NGNEMmRLMUxwdkpSY0VZdVcxNWNDNEVo?=
 =?utf-8?B?MXF5L2VDVENMclovblhBek5ZaVM4SlQxYVpScHExTmFiMElUY1hiZmlEYXJC?=
 =?utf-8?B?RWxSVXVFTzA3eCtySGJzZWxsQjJaMFVnV1hLbWd6U244czFKdFltMVJVaEVy?=
 =?utf-8?B?UU9rLzV6Qlo4Um8xNGwvRTR0ZXd5NlFYWlUydWxqVUR6ZDYwWXlYM1c0UFFw?=
 =?utf-8?B?dGgwVzJFVUoxV3JiVGJTdUo0L0tUNi80R1pHWFN6MWQ0M1dPeTVJTldXdG5t?=
 =?utf-8?B?M0xPaWlLb05iWDNXVjZFYmhnaXVEaUx2U3p2T3FxRzF1SzRFUUY1T2tqUVBy?=
 =?utf-8?B?S0hwSDlJWm1WWkNZSytpRnNwOVNUM2Y1cFlhZXRwV0RnYnJjWFlSWjM4NDBY?=
 =?utf-8?B?aEs5eE1JUldlYVlLbFlKWEFBTEQ3TW5GbzVQMTg3azA5MnV0bFkzNVBJWkFn?=
 =?utf-8?B?N3VHRkhBc2RRbG9VUktOU09rb3R1NkNUL1RmZFpTR0FDL2Q5clJoZXBkeENH?=
 =?utf-8?B?WXRPNXFVTllTTGFReVN2V1dwYjBzSHM1NktoVmNTL1JNb2RXNFN6RlROMlBw?=
 =?utf-8?B?eXlMK2ZjVVYrcDhnZ2FhZWowckdNdVVqeXlaWDE4WUdnWGE1NmNYOWl2RzlB?=
 =?utf-8?B?TjJ6YWVJUXB1a3VhU0RQWWNaY0UzQ2VLMjVwZW41SkRPa0NhZEpWM282V2Zw?=
 =?utf-8?B?K2dWTHcxVFFYWFNQeWZjcmNjS2N3U0tBejBydUxuOG5mQ0o3RkRNRno0akhR?=
 =?utf-8?B?U0pCbmxNSGRXbU0wMHcrdnVNNzNSOTMrU0RSckhXa045YzVWZE4zUWE3MnJ3?=
 =?utf-8?B?NFNESjBzNmNDMXlPM0QzaHQ1dkQ2NXlDMy9BUTdtamxpTmNrbG52TW94c0dl?=
 =?utf-8?B?RzU4VVZJa2RyVXEwSmY1bng3MjFpRmRPUzAxNndLUHNwQ24zNWkvUDd3a3Fk?=
 =?utf-8?B?c0NuNDRzQjU5YTVxdUtGZ01Jd0htU1N5Y3ZTaVNzWlNhV2RqQXdYMjJzSjdO?=
 =?utf-8?B?QkhBRzNjZm4zdm1XdmFRWm1wQ1ptdE5jb3FUR2FnVEJ4b2pPSlZSS2ZqOGVk?=
 =?utf-8?B?RFhuemEzY0ZlcDQyVHBXRTdBMC9LMUY5L1hWVDBwaWFlN3Vudzd1M0Q5eU9q?=
 =?utf-8?B?NVNXeWNqNmFLT3JmVERyVTBiSlJVSzFGYWFUVnRzejQwYmlQOERjUExOaWpa?=
 =?utf-8?B?ZVJSTHBTeko1YS9FTjd3ZTBuT0owTXEybXlsT0dLYUpnMTNzWS9sRGlaZGVV?=
 =?utf-8?B?d3pXTHN6UUU5bjlWV1RGVCtwSC83cHJOY0grMXp3N0hXcjVadUJOVUhLY241?=
 =?utf-8?B?TEVKNTkwYXhNMnk2dUJjaEkycHdVNUo1SFA4WFdjZElKcG8yQVpTRzN4T0dj?=
 =?utf-8?B?TkdYcXRqTTFUQTRYWkp6SG1XSndka3ZxdEVkKzk1ZFZDUk9ZOCtydndFWWcx?=
 =?utf-8?B?dUxXbnNiWGN4K08vcUc5TjV2QUdoczhnb2l6d2JYUDBQY1BWUVNucUVmc1Ev?=
 =?utf-8?B?Nythc29WcVN3WnFFMUovVExqOVNzRU43VTRZcVp1Sy8xMlVydEhWTVFlOTZH?=
 =?utf-8?B?dnZ3SThkZnJyWHlManJpbVhuTDlRQWxsWGNOcUlsUDdTbFlHVFZMakMzeENu?=
 =?utf-8?B?Y1RZOEFGU3E3YlMxMnJPQnFZb0d2ZzFNVmZPbnIrZlJmRlc2TzVkS1hVTXNu?=
 =?utf-8?Q?KO307NQslMRIBZA0IIPcpy/SY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e6334a-b347-4643-0182-08da86ca5d08
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 18:48:12.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLHNtbOmsz4ljvL0Iq0sz09Z/TtRwARJNJQt/6DN1mgScSTMKpsJKuQHU6RKTOZtvr03ADkTee0At6UeXIiGsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5699
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2022 13:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> use low-power S0 idle on the given platform than S3 (provided that
> the latter is supported) and it doesn't preclude using either of
> them (which of them will be used depends on the choices made by user
> space).
> 
> For this reason, there is no benefit from checking that flag in
> ahci_update_initial_lpm_policy().
> 
> First off, it cannot be a bug to do S3 with policy set to either
> ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER, because S3 can be
> used on systems with ACPI_FADT_LOW_POWER_S0 set and it must work if
> really supported, so the ACPI_FADT_LOW_POWER_S0 check is not needed to
> protect the S3-capable systems from failing.
> 
> Second, suspend-to-idle can be carried out on a system with
> ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
> policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER is
> needed to handle that case correctly, it should be done regardless of
> the ACPI_FADT_LOW_POWER_S0 value.
> 
> Accordingly, replace the ACPI_FADT_LOW_POWER_S0 check in
> ahci_update_initial_lpm_policy() with pm_suspend_default_s2idle()
> which is more general and also takes the user's preference into
> account and drop the CONFIG_ACPI #ifdef around it that is not necessary
> any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> 
> v2 -> v3:
>     * Use pm_suspend_default_s2idle() instead of the check being dropped.
>     * Update the changelog.
> 
> v1 -> v2:
>     * Adjust subject (Damien).
>     * Drop #ifdef CONFIG_ACPI that is not necessary any more (Mario).
>     * Update the changelog.
> 
> ---
>   drivers/ata/ahci.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/ata/ahci.c
> ===================================================================
> --- linux-pm.orig/drivers/ata/ahci.c
> +++ linux-pm/drivers/ata/ahci.c
> @@ -1609,15 +1609,12 @@ static void ahci_update_initial_lpm_poli
>   		goto update_policy;
>   	}
>   
> -#ifdef CONFIG_ACPI
> -	if (policy > ATA_LPM_MED_POWER &&
> -	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> +	if (policy > ATA_LPM_MED_POWER && pm_suspend_default_s2idle()) {
>   		if (hpriv->cap & HOST_CAP_PART)
>   			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
>   		else if (hpriv->cap & HOST_CAP_SSC)
>   			policy = ATA_LPM_MIN_POWER;
>   	}
> -#endif
>   
>   update_policy:
>   	if (policy >= ATA_LPM_UNKNOWN && policy <= ATA_LPM_MIN_POWER)
> 
> 
> 

