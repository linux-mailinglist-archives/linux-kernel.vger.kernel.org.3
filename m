Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9D5A18A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiHYSRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbiHYSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:16:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04FB81F5;
        Thu, 25 Aug 2022 11:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL9hi1weX3/rRPUYkgQuO4xsrse+mZPrefsD+EGlzHLCNK6Bkumwln05mRKAaijiW6ZMsExZKOLf8KQ5DLphrhXNtyrRr2725Z4nYeAI97rFsAM671LIBrMMT3TCVY4t6Sls9ruznuOZFqzvump00q/a+avNA1QSzYYtwc80Xw7saqc8GI8TgTCQngjURBF89x69QHfOvuyC9xWwNIOEX8HsMc6NME0+/eyXePHs1EeB8R6Bn3QoRI/Dds9RFHvt1Y5n3DIBirNMkU1vmpHZHzJx+SxtKAtT1xMayltseVZq4igObm7XxC86/kzMhfiUnypoZDhI/773SGCk4ED+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfqDOHd98gZsMegWS838sZh6rhLFgJfar3N1RDk2qFA=;
 b=cgI5Me0iIL30ErjAJeCVeoIrin+eazR6PL2J0Kd1ee1AyvAsp7IeHEltTI3PV43R26ytpwD3mGaLfXHYGtxriej1PWU98mjGGoYip3lPVxAzVTBFSL2o/so0TmqI+1PtWASREB8unN7fncOEa0AnqMEWu40mBd3cBYX9ecEho/JBAQ+A5F6DrLf29aLCbFtUiWvYSaVtbfDPQJZDM8jj31fiB7uq447OzMV3tFIwwd454JpRD5+jy0nQt0QGY4cK0eaGQXejTR80hsHZSs00bci6f/vkwwf5v4RhEnSL4XViiQBm6GDGxcRAWUoQ+SCwSuAGUff3+X2unGkAn1em0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfqDOHd98gZsMegWS838sZh6rhLFgJfar3N1RDk2qFA=;
 b=d9JfJrexVaulpun2BGm3pX4RrcP6EzTKe2wbTMDSXTGAB22erVndDb3DHT1bZaGdtmEF1Ip85kESpgpHWuywk4iOGL5QE4WiWRMR7vjDVDGs3iaXiYUsJCbnvY7whqYJxBZ0OMDCeD75ldMyTWN1XFRzXL9PGviHQUg3td2ZHdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4812.namprd12.prod.outlook.com (2603:10b6:5:1ff::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Thu, 25 Aug
 2022 18:16:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 18:16:21 +0000
Message-ID: <ecb5a2dd-47b2-e5e1-5254-42bd5d018578@amd.com>
Date:   Thu, 25 Aug 2022 13:16:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5607133.DvuYhMxLoT@kreacher>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <5607133.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2a40e04-f1b9-4eb4-d635-08da86c5e9b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4812:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6H9ErqImEUOU14HcI0mkrvTXOsgB6Vm7xz/f4xZ+EJmpVbXmOYNYpeglnXviAdAV2q7XrT58TURNpOymXBqZM++yk5iyC1yQrp5fWcb7xT/dBrqBIKLkSiaUlhsYvQYHX7ozfQ71DPrFbeoTIyUDlITMin7PxGcgNXtNxc70PTDjtT6IYaMQczsaQzNNhQBHjpxjsbZxOEw1+5DWFy64gmrOcgg5P3hicK6n16bFQRXdlEYqOMlqLyZkAS1xyntu1eb8JEVG3Czycgz/tuA+xYNnA3QBkCSJrJMB0OtaXrUXSh7HlVfE2sqJ8YdNwqXDXSP73W2FrQPPe5qx7m3c9F+deybGfgBjeLIWFzq9W29YTkWWcxShFASZV3ffivfgA5dDdLCO+e/+sBmZ5aJ+mAB1pLR9cGw1meE5Y69V202/0kN59oMEmr0+DLLVcXG0tZSMlSLyOKNFfftsmgP038RRF7Hkjq2R4vG+5RuILCQKi7xQbMXbk6fBg874OP7NDlYNgYJ9LhQbzuNyM9RuXkuBDnxacDkO9iUK7ghcqkUGK/LopuFiDP2vOm+Ibjh9y9JK6QnzbwdX6Y+KKyc/Pu7njCuQ0kvEb3g5ebmc3pMCTKKHtZaFpEBjdWvQlA054UhW2JeQVsRcC56n58mCYRiW4yVgiKVkvJAbm+c5BNGGQkyWV2le3BFuzxvXi+et8TIFI+/ymjWGml8PFv5WcJKZa/ZmwfUa0pyXlCwt7GtG4NLKzmAopkkFyLRCmyvym5lIs9Mk1+u/MuuhbDpG2tV1ok8S6EX/uYDUz/RyaX1O7AHhK3DU9X09B4Yl7tktE54U54Q1+nzUyTv8zGwFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(84970400001)(5660300002)(8936002)(26005)(83380400001)(6506007)(4326008)(53546011)(6512007)(36756003)(54906003)(66476007)(31686004)(316002)(66946007)(8676002)(66556008)(86362001)(31696002)(2906002)(6486002)(38100700002)(186003)(110136005)(478600001)(2616005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDg2NXNPaTdFcDFwYTB0MEJTUExMWmJnWG5UWVhvbHVCVGVyK2tIcDVnSC9K?=
 =?utf-8?B?Nm51dmh4T2FPRUY5UmtuVFVzSGNOTCt4L1ZCclNLU295cjdlK1RTWXhraUJw?=
 =?utf-8?B?YnlhS091NEJ1V2t1b3RuYWJsOTcvRzgwRnZNdWVWaWxPUlF2cC92SVVKY1Fw?=
 =?utf-8?B?akpUSUNNYWcrV09VZHdBODZ5NTMvWlVMYk5na09tMkRhRURzdFpwL1BGMUNj?=
 =?utf-8?B?d2VDT09xOGlGYzNLcWVoRkVyN1FOQTQ0aXZOQWt5NHduc0NxaHhxS3JwNWN1?=
 =?utf-8?B?b1lTWmhEMXVhWVN0TGdlN1M5RmNBWVAvM2RZaFh1NkhFZFk4RDJoK3Y4V0Vn?=
 =?utf-8?B?NkFzbDFlaVA5bnNsTU5RbVc3b25keFUreGxkUk1hTk5uWEpNRThpaVJaUVps?=
 =?utf-8?B?RVo4aHYvdzZQVmx1VDBTS0pFRkE1VjNKd3hkWXJKTnNXN2VuZFRocGhwYmFS?=
 =?utf-8?B?YUZ6b0RJU3BHT1FEcFp5STJyeG1NOFB1dkJ4NkZZRWlXYmlXUHVXbDl4b0ZN?=
 =?utf-8?B?bDFmdzN0ZXNOTUJkTm5VdS9qWkcydlZ6Ym5hN1NoMklMQXdEQVpkZGIxVXJo?=
 =?utf-8?B?eTBOQ3JGTXlTZnAvMHdOL050N2NrNkFabk1mMUVBQTEydjc4VzZzdTdOWnIw?=
 =?utf-8?B?a2JlcmZiRXNYeGlPOXZrRTZnR0Q3U25MR1lUc0FQL2xIY2dQMVNnaEZVZG42?=
 =?utf-8?B?cmxBQWh5eUR5RlpZREZYMStnOURpWWowY3FaRjFBSFl3M2htczNMd3M0OEV4?=
 =?utf-8?B?bWFaT3R2bGMyL3dmd2c0SFgraWphY08zby9YZXpXMUc0cjRSM2NudnVELzVj?=
 =?utf-8?B?QmFMay9FZ2F2eE9aZktxbzRDM2hnbi9DaVUyNGJjR1dCTVRIM0dpOU5DZG1i?=
 =?utf-8?B?bHUxckVDeEY1R0FUTFBLRTcweHNwNnUyQW5vSXRwcGN1ZUFJNTVaZkp3ZTJG?=
 =?utf-8?B?Wlk3QjNnZ2JnN05OVGgxeEdPOEgyVmdNQlZ4V1hqTTMwcHVvVXJ5Z3lIS0Zo?=
 =?utf-8?B?c0dqQWJHU0hHT3pLWW1rTkJjVDNMOEtMY2oveWp0bDVjTDdZTVFIOStKbmdJ?=
 =?utf-8?B?d016UFkvbnV4RWQ2em5XYitXYU84WmFIWVNrVUZDVjVHSTBZZFhsL1RCcE1L?=
 =?utf-8?B?MmwyVU85WnNtU1ZFSW1iODA2T3Z2YTJJSG94b3lVd2NSUitOdzhnSG1wQTJq?=
 =?utf-8?B?b3QyV1VMZUkwZUFwYnhKTmVPUjJXYnVkc2JOK1BhYS8xNHd0MlNjMjV2aklG?=
 =?utf-8?B?Z3JycEg0TzhWN0QrRGNxTG5lSHR1TEs1ZmswRmVwYTN3ZlllUS9hVVhIZklW?=
 =?utf-8?B?dzE2cUhIanpaRW5MVDZ0aGl5RVZoOHNCQmpwbWlpeENqVzhXRXVLWnNXU0Y0?=
 =?utf-8?B?WGpxdVNKUnhvWTR0dXViU0llSDNFNDUwTkhOZndTcUtpaGlhOFROd2VWSVBq?=
 =?utf-8?B?cy83SThUVE1kNkhkZFpwTHdDTjB1ZXlrTHhiWFB6K1djU0kwQXIvc3Q4RTFv?=
 =?utf-8?B?VGx3djFNbVZKUnM0TXBUcFI0SE03ZTBvVFFTVHZOSUV5M1kvUWFvRnN1ejJh?=
 =?utf-8?B?TzZTbXErcGVFVkVwQ0ZrSXU0SUJvZnZVbytXQnNqQ3NEMk1ZQ0w0MjNaZ0NW?=
 =?utf-8?B?RWFJd1NHNWV1c0ozWEpMbEwvYzJ3MVBwcUowa1NFZ0pkc3BjRU1icERpNjNy?=
 =?utf-8?B?M3NINnROR0s5SHJWTWtGRmY1RW5pcE00SDh4b1BsM25va1dLK1VDSW9FWHNF?=
 =?utf-8?B?ZnlmVCtkNUVUOVI3djRZNFRBM1A0SHFEOGlhekp6WEU4TER5c0h4ZUwwcDY4?=
 =?utf-8?B?SmFQOXZ0aVIzYjRlVk1CS1h5QnRqeDJWbHdiT2o0WWVlZVoxOEQ0R0hkYkht?=
 =?utf-8?B?RnJUcmRtdEVNQ0VJYnc2U1lYTmxSbmJ3RllrOGdybkZDNnpKUjJkelprdmU4?=
 =?utf-8?B?Zjc5eGt2cFZJQnQwTFMzN0t1ZVZOdEY1Lzdpcm4yczZlRm9ZUGdXMUJKL2xi?=
 =?utf-8?B?b1RTS0NPVG01TFA5Zm1lMmtUOGFLYlRKZTNMUlltTDBMeVIyMWJHY2FpbUts?=
 =?utf-8?B?MTQzeGl2NmtsQ0haS2RuZ1JKeWVQenZNTWhsSkFEbzNTRDJYakhkamNTbFBL?=
 =?utf-8?Q?NHCu1I2VB2qnsk4hNUVQEfHJm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a40e04-f1b9-4eb4-d635-08da86c5e9b5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 18:16:21.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZsxEolXLY28HfodWWfY9gEPF2vkTiCgrlhe+/hAry5ju6YWVpv1VrHQaMcCmpFnYrgM2NdvKmKjqNRjbW7o8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4812
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2022 13:01, Rafael J. Wysocki wrote:
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
> Accordingly, drop the ACPI_FADT_LOW_POWER_S0 check from
> ahci_update_initial_lpm_policy() along with the CONFIG_ACPI #ifdef
> around it that is not necessary any more.

Looking at the source commit for this behavior:

b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with SLP_S0")

It was trying to set a policy tied to when the system is defaulting to
suspend to idle.

To try to match the spirit of the original request but not tying it to 
the FADT, how about using pm_suspend_default_s2idle()?

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
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
> +	if (policy > ATA_LPM_MED_POWER) {
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

