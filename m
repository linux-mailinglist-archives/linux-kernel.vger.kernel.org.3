Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145D74B2F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbiBKVRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:17:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiBKVRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:17:23 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC35C4E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:17:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHm0Cgy+tO1CpckvUuzSf1y1ibNoHcxv31ikQnnZtGQuNo8+TCs+c7NqAGBEq4mCwZNLLbAuXKtFEaHQKY/Irr2VITuSB1dY9gv8bEJ2nAsbsIRkYHpmW1+wIGGJTgf4OsuxDdp1NqSqT+FRMOhJMQs21oirwkH1dApQ/A/kkWQljhTo4/KVy+N8mM+zsE28nj4GO2rhaWfrRC+7e6Sa698OV5NuQyqEIWPAxHZjHjrX3/FJFrteIaWUBYFMVtQwxb71yNygNHvBYnoucPC5O6Yzhl+OgISPQ6euP6BPaK6yB2jY/ovA4i15vgexjqkHTNqnEIdD1m2UHlk/iV6k2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b30vooIpkWfttXeFR814vptJ4ieatNc0XyztovUtmKU=;
 b=ocfymycCMDf5tw8swcrkK6ycKYkbsPl6cmIcI+1dMnB55Iibtwt4l1pp28GX61gH92sCF9A5qrMKqINoad5ULL10Df2qS1Q/8QEtzGERedyEXBBnB5tJK+X4J/6/Qr0WfjHVNZV7flitL8x3icGWUZsoGduTbXc6/6Op0uZpB+39eJxcO+8eKdX4APF59qDcXHxuJltwqlknrFZRYlG+usi7kKKDf+DRs89IzHQYIY7ZluNhpGS2w6PrHONOoMvytfFdrE9Hg9tuQwj/zwCSiJrpYYF704um45ZEWXon5q043VZDd2BuiF7eMA1dKPmp42ujdFUYcYS/chnbTLIREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b30vooIpkWfttXeFR814vptJ4ieatNc0XyztovUtmKU=;
 b=Hy49ZMPPSmkNKBE1mWkqhDMC0UfgIMk8TV9RXDiE56Sfanrn3NauoXFmVpNwlwA7XTs9vL5UL5AKzWB1OI5NNfd55MyKB/7K7298bfnUWbtKWTOOHm8F78RIYJxcEaUd7ZKhooilNx8KheWM5hpJQoGHeadU216FKdPwvBU10Ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 21:17:18 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%7]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 21:17:18 +0000
Message-ID: <56dbbd52-93bd-2c70-3862-3b62231a4024@amd.com>
Date:   Fri, 11 Feb 2022 15:17:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] x86/cpu: clear SME features when not in use
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20220211210255.9820-1-mario.limonciello@amd.com>
 <20220211210255.9820-4-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220211210255.9820-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6aef122-5a20-4576-60f0-08d9eda3e283
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32104AC1D2937A03E8360248EC309@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZKtQDD4yaLZErUG0dJl8jzC9kc0rUwTI/uvG4XSC/BQSLIJQbo+I/JjrlXGuZtovP6HU9YD+lRPK2kCwqw3g/XK6VcmGz/3KNct3mEFKvNkwkVnp55LvOGS8iAsfyzJWmqIP/nW2oXF4xtR4Zu1XFLhSysOWnaaeo75VoJbPGW/jsJzfi4/WRVKqH+TZNTsSHW7oUJcbGLipQrKi6lKzhDjquE5+olzDlpoV27yjDoCniWohhC75YTpVVG/eMjCgs58Dm6xtEjHnpPUmW5yEbHsRg9yn9mYYdRmnrY1t13zs/JuRj8AKZU2wSC213J3wVEcm0k58o4Abyjc+5vVLdWyFJvh3NsPRu9fnC3Wy5JIddLMuOSPYoucCp6FsAQeT9LIMosrIzZa9l8akMkBf+YrwlSEcjHR04GILEV/iCpwm1dR80ZJND8Z2Uc7rdkRUX0xjjoZd8K9COVXXDpZqTLDhts/2GJK9G3r2hIWpHt3s6yh2Kqb9uqmJcHEtmfKE6rmaBd1LmR+XQt+TlS+fJIkjV9yiPuecS3KqmOTBPvzi+njt6g3mi/7xasDm7tRp97THaMEM83Bav0yJw/r+U6nHiE63APLiYfKm9MNxQj5kyafKxGm3wstsCW2TiNOkFF4tsc5Z+1OiDL9sA5ou3sY13Hz8gzs+fO+1KmUkSvTPbFoODH5EWoCWFp1PhDhPKFPmh9JbJJJGO/1K6//EEW3bx2MTQTKt6nOPjr/EXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(66476007)(316002)(66556008)(8676002)(4326008)(6486002)(508600001)(31696002)(8936002)(26005)(186003)(5660300002)(31686004)(36756003)(2906002)(6512007)(83380400001)(2616005)(38100700002)(110136005)(54906003)(53546011)(6506007)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3o1ZnkzWHBjY3ZVc3dFU2F6VTVEZHZNMXFjUzBTOFZEbXpaZVZEK0xjUmFs?=
 =?utf-8?B?cWNHVzhTWVZrL3NXcWpPL1YzTml6NU9hK2x1RWE0UXFvK015OW81a1FlamdF?=
 =?utf-8?B?MStOQUMvNmlLR0FFd0NZc3c3cmplaTlJSFBFZWpoVDQxWW1KVXZUVDdpdWxx?=
 =?utf-8?B?L1A2T25vY1lGQkNlbUJZWjBnd04vYWlaUkpHMlpLSUxUQ1JOOHZMOUM2bTVP?=
 =?utf-8?B?Z1hlb0tkTGROYnNweGxBOWg1aUdXTVcrcm9qdWlXaGJDS1JTbDN2dG5hVVJM?=
 =?utf-8?B?UE4zWUFkbU9BZXEvQ3JjY2pBM2VNWDFTbkthV3IwVEVOYlZIdFlvOXp0WThk?=
 =?utf-8?B?VmI1dTIwZFhVNTB0dzZ0TENiTjRTV3NmMEVTMTI1akRpcVhxRGQ2VE1GVG5R?=
 =?utf-8?B?SHIvT1h1SUdMS2Q0TWsrd0VjYmk0Z3JlWXZxUHhaMmZaeGNJUHZwNTgySDVz?=
 =?utf-8?B?SUljOTFXWjlHWTZKUkdydTJsSDhndUQ5eXFSeHJZMFc1SkdBdHN4V05tOXRG?=
 =?utf-8?B?eko5aXVSTVNXV3RDVnRPa2RWWW5UTklqOTFVY0toR1AyNkttYnhNWlVpSitq?=
 =?utf-8?B?S0QvRTRNaDNQWGJVVFNXVnFMKzY5VENEMjlqWXY2b2xEempmdTNRN1BsRzAv?=
 =?utf-8?B?aWpLVk9oTlZsV3M1d1p3dDRtOTUwdlBmOEl2SGU0enFqa2JQRUhjeUhHc1Jj?=
 =?utf-8?B?UW1yM09HWGQ3OUFvNGcraGVjM3Q3NmJPeWN4bjNrbnVLaDkySHJjdUhpYWJP?=
 =?utf-8?B?QUZXbHRWN0FXY2tLMlVDak1QM1JoVVc1a2NSejJiQVFMVGVQNUIxUVZrWm85?=
 =?utf-8?B?eFNUQ3JjcTFUanAzZlZRNzEvZjQvZGF0YU9CQStEak80V05hRXBZdUo4QVR3?=
 =?utf-8?B?WHhyc0NGUTl6cUJOdVZITkZKSExteDBPQWRWaUUyZk5SeFJ4bkk2MStTUEUz?=
 =?utf-8?B?NEtSSmlZRTBYcDNWV3lXcU05ZjBFY1lvKzhQQmFqc0srb2R2UmpGbW5MMkNF?=
 =?utf-8?B?d0hISWxGVzVhWTgxOG5hd1I2Y2hPdHkzUG9USWVRZ0YxSGpubWlWRTEyTTBm?=
 =?utf-8?B?RTNlanVKc3RDZGszRWNxazZQVjVjSzZsemMwZHU1QTZPbVRlYXkzRVJ3UWJQ?=
 =?utf-8?B?SUsrUjlYWE96U3NqVHM5cExpWXBpUVR1K2hFOGVmaUx4MTZ1ZDBYeTZFS0FI?=
 =?utf-8?B?WTlFYzYyWnl2Z0FydEtSYmhtVjd4djkrOVV2QjNYNW14R2E5dVhIeUsycTVV?=
 =?utf-8?B?TXpNVTlFeTVXTTJkOWpjTTRaWGY5cVdRV1o1aXl4cFFjWEMwalhHbTRCVzg5?=
 =?utf-8?B?RVJOazlZQkF6WXJIV2pHdjBrMWxkazFydWdocWJMcDBVZUZGdkxaSjlKcFRI?=
 =?utf-8?B?ekJHUEdIeXgrayt3ZUEwQVRNb1ZGR3ovVnliTDkzWHZFOEpoNWRNUE5xL0lv?=
 =?utf-8?B?M28yWGNLRkdRT1dUOGNMelNOK2x4Wkgyd081RDBZTzF6SHBaek1uRFU0NHJQ?=
 =?utf-8?B?MjdydC9xSkEwcENDb0ZUN1cvRlpNTjJCQXArdE51dGM4NUdwWnpvOVVyamFq?=
 =?utf-8?B?SXo3ZWd5Wmg5T3J1eHVwdlFUTjUxZ2ZYcm5wMDFLUkFMd2pZdkY1REtrdWh2?=
 =?utf-8?B?Z0VIZVZ0cmtreXc1Y016bi9xZk1iRVpJclJldFY5cVdVNEZ1VTNzMFloRFFs?=
 =?utf-8?B?NHQ1RCtHZllzOE9FUDVYdHJXVmRISWVuOFMrVVV0eG9BMU5iU1NzbUxEeVFt?=
 =?utf-8?B?Snh3Q3VwMUVNTnlWbFZZbzNpSDBCTnBtMFNDRGdSeGk0ZzByTXVmRDZRcnBr?=
 =?utf-8?B?bmxMK09UQXRmM1ZIRytORlZFT0F3S3JZZk9KWE5ac1lWajJTeDBFRW9iSjc3?=
 =?utf-8?B?WnVhVFArSWxCQi9mSjc3UjRBZHltSStqMTNhVHhyTGdFaGZVeUJGVXJwTFVz?=
 =?utf-8?B?bUx1eC9uUUpSci9Vd2FuR09EVkV0WUFJTWlDNmZkejcxV2crRWFMRDNFcnRT?=
 =?utf-8?B?K1N4UGQwOEVnRVVyUm92VjNiV2N2MS9OU0VrVGVxbDZoVVhjUU00bXBKRnpK?=
 =?utf-8?B?RlovZGIwSms0SmU0cnZOUXlLVnJkWnFoRTFjcTErR3U3N3pSVStlanJtTnNT?=
 =?utf-8?B?bk80aWdPbUZacVI2Ri9LbGprem5ZZVYrM0U3Z0xLT1h5c2tLeXJXVGZoSElz?=
 =?utf-8?Q?A6uiF72imLwrspzUNdzYf0w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6aef122-5a20-4576-60f0-08d9eda3e283
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:17:18.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkD8vlY7n57HFx59GNCMi9Xf8G66Bx9HC8Fy7i0Nwky9RoZuRDn47TuUAn0KUSAUcGm8M6X4K/Z9H0rvSBnxTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 15:02, Mario Limonciello wrote:
> Currently the SME CPU feature flag is reflective of whether the CPU
> supports the features but not whether they have been activated by the
> kernel.
> 
> Change this around to clear the features if the kernel is not using
> them so userspace can determine if they are available and in use
> from `/proc/cpuinfo`.
> 
> As the feature flag is now cleared on systems that SME isn't active
> use CPUID 0x8000001f to confirm SME availability before calling
> `native_wbinvd`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

>   
> +		if (!sme_me_mask)
> +			goto clear_all;
> +

This is incorrect. Just because host memory encryption is not active 
doesn't mean that SEV guests can't be run. This should only clear the SME 
feature bit.

Thanks,
Tom
