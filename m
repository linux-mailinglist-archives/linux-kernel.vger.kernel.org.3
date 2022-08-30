Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0507F5A624D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiH3LoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiH3Lnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:43:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7375C345;
        Tue, 30 Aug 2022 04:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buux+e1XW8bupaWBI0dtVWBeFssKw90ewhTpS0195bcec0E489msEtaxKlzc1KBTKWY1vlzkDMSqN1JSUj6bVi+gGpqnlpSCgFKIYbSdpWc6bEdW0VxZf00JWMEQ4nAmLV2dZzoLS/YaLB5e4IUICpo3QBa6PKkVjvs0bCpbEE8hPzkylzwqev6nNSU7UKbMPJaZ3nz/PcoFlloMX2zKlWsV3jgw2AknX/CKEL3o1OBAAJ9J+ZkDwaXY3iVmpQhVwFkufuUYbTWX4KsaQspsmHI9wUIXrZU2J9PQCwfHaLL9ceJChmGNbXHt1KTAPOvdv+H88ZwqcprYd6m30snIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUEyeX0Pa+lr+AKuT4D9J0k+71g5Yxg3eLh1D1YK8iA=;
 b=RWszRB+G10mS5tUUlRB83NUqjR6rnN0qYyfhn0sNBJy5H7bU1EE3a3n6fTUV+hiihYUf5Wb4t4mDXQOlSuur8ezDG37siGQ1nEZVLx0Crvvs/zard+41ewO+fHzQIVop/ie5XAZGLFnfnVGZ+iG21P5rzUzBrosMSm+uotW8+yQzW0OOe7DbEXMd6GcXg6QgTsczzZmL/tGj5sDky8JZhSjguTPfAe5YBj01QUZUdVAMlz29XwYX3WMsDa4FUtld9VJYQgnNJaEZq9EwuBmkVyZ3kxpnyP4EgLvYCd/j0J5XuI8cWSAUgr8iL3R40pCaRQn7Y2mKs+t3xVRx+dPEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUEyeX0Pa+lr+AKuT4D9J0k+71g5Yxg3eLh1D1YK8iA=;
 b=z/SnFvlDZ8bUPIMgkdAX0+H779JwenMHPQ1beCnJTFeCOKBqePMPA4uZ+QTUUygvo3bI6o4YE963vVT04zL73sRUEslxtvUsbO4nXvIfg1p0fvdMDYyHqa9LmT2uCYLwwN3zPTaaMWzuNIFvaptVIwDxPonDP5I6JBcf0owN7s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 11:42:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 11:42:35 +0000
Message-ID: <88b5f4aa-d238-efb6-82fd-e227c42cc10c@amd.com>
Date:   Tue, 30 Aug 2022 06:42:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/4] ACPI: s2idle: Add a new ->check() callback for
 platform_s2idle_ops
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20220829162953.5947-1-mario.limonciello@amd.com>
 <20220829162953.5947-2-mario.limonciello@amd.com>
 <CAJZ5v0iF1_MUptawLL4DD0RqZpysH2B+Pk5sj_=gLv9AOVdy=Q@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0iF1_MUptawLL4DD0RqZpysH2B+Pk5sj_=gLv9AOVdy=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:610:54::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2948ce1-05b5-400c-1bd9-08da8a7cbb57
X-MS-TrafficTypeDiagnostic: CO6PR12MB5394:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Eg/krIGECG4ZvD9H0AVvt+I1sligb7bYdWneVW2fHo2cTJEf3Nuu//bmVguyn7qvtWF3JGAL+gwZG+CO/uoTN+GFWjHFsZkD4A7Su2wBBEyhsIht57vyDKjhpu3io3PLdIfTdW27K852IaESukaH7Zc525WWbHiM9DGJSHFYMhCUoWqeruFe4bWNM7xlP8hWLsv1FWDeyVLjt6DCpXjtybihRg6io5ln/VjCx/AwF8IHW6fxahOfgx04Gdx/7Vc+ga9FsSGLfawMdJOuPBuJJHZsVdAK9G/Zh4eVR3PJ7GGqTOHU7CyPvrqWDKYfbPAwTbNh3WJVyqrM24RH6gLVJZtaqv0c4wL0IDhMip885bqQbBprTub2Jmg0VLN8UfSKCyn7+0xWfvKTl1KXwkQyPqkzpW7UpJo05zkouz/gBAKQ9E2cAousbE+L5nJ0qHzfhW7OGiBaMtGtUEo6z92k/a7ygX121wE5t7osBUGsb86QMjJQnVCwMXd4LGjD8ra2OSuq7Urq2RbVt0DsNgpzyWhzhJq/k670O3rmVyudSycHmMLSWKKR7Pl5r+B6Y9XXgjrlfqAltAzzt7heNc55ju8tk/Hp9mIeqjfjsovJr3IHTRohSoWYFdXMoV1OwbdbA9iOfM0d3QdRFFFgK92sqqvvT0iSI3QYNGCgDdl8jLd7aN/Q+FiJ011M2tOzKvFmWUVOF6oUJxkK15olah+vMiRYsyKwZp49iav9/BrNAaxM4RjZXJ7oHQzDRFsAZaZOXWNfGxBeLzcQrAGvVWDcrzUlOvjZ0Te7Z+mONBKxs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(478600001)(6512007)(26005)(6506007)(66476007)(83380400001)(53546011)(186003)(41300700001)(6486002)(5660300002)(316002)(54906003)(2616005)(110136005)(2906002)(4326008)(66556008)(66946007)(8936002)(8676002)(36756003)(86362001)(31696002)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFtbDcrNmF3a0xudU5uYkFtMXdCZEx6Y2NDMytiRklxdDdVY2cvdTJsVUE4?=
 =?utf-8?B?Z2xSaXJiNkNOVHVncks2VHkybDJlL1pPVWtLSWx0cGE2U0p0dUF3Yk5hWExl?=
 =?utf-8?B?cmUwR0VITTRDdy8yaVgzY3pNNVRIUDRXemNJVHN0N1RwQjdWS3Q5Qkc3dGxW?=
 =?utf-8?B?bTRtVnc2WlFGaTJjZ1NXQjN1ODhpZUtJdWo3TStyb01oeittV2lnU1M4ZUhk?=
 =?utf-8?B?YURmM3lLWUxWeXBjaDVvU2FJUENmZXpmcE5iWUZjUldNZng2SkVoUGZTeFlW?=
 =?utf-8?B?Q2dCQlp4YzRvQmZJTGQzeHlJNFZmY3ZuSWZvQ1BYRUxnQ1BRMHVVU0dmQjFZ?=
 =?utf-8?B?MjFHRmlvWjRjbGZiY1hvV1Ntc1MxazRjRXJhRzI4MnZBMTNxTDVNblgwbXBp?=
 =?utf-8?B?cWEySFV2eTQ4anl3Sm5la0l6cVFHRWRzc1FGdXR4azcrRGVFY2RuTmluZFlj?=
 =?utf-8?B?eU5ISVlpNWRCdkdzVzQxR0pYUHNQU1JCM0Yyd0RZYzNRVFB6Y1pTcHRBODE2?=
 =?utf-8?B?dEFGU3h1MmhwZkpYWk9UTFdCY3R3d0doMEpScHlSWnA5QS9NZXNuaElQOUxF?=
 =?utf-8?B?RTRtSzZmeUJMZjIzZ2tsMFdqTDZaVm9UVDlzUUFTSkprZEJ1Uy9tUzJrdlRW?=
 =?utf-8?B?VmxMb2ZvMTloQmIyR1ByQUs4YWpqaVFmaTRzVWFlTTFYU09PODVFTG90ZHNy?=
 =?utf-8?B?SVZJSWl5RERzVjRaWnJlRjlvcUhEWkFLZzlzZUZza2FSTUJ1SnFhS2QrRE9T?=
 =?utf-8?B?a1h4czZtWlFPbWRuN3VuZzVWbnBrWWlrYWlGbEd1N1MrMXpyU0ltOEpkK3FB?=
 =?utf-8?B?YzFlYzgvWDk1TVl4OVZCRVVneCtIcVQycUd4ODRMalhCN25rV0VPcWoxeUc5?=
 =?utf-8?B?cHkvR3Vxd09udWJ0NW9URnhyODV2OGFOMmpjL2N1TmQ3NTF1R2N6OXdONWdi?=
 =?utf-8?B?bFozbGJCa1ZadjBhNUdiVjRHbXBiMXc1MnR1dWxtdkZFVzFRZ3U4RXQvc1lD?=
 =?utf-8?B?VTB6ekNrem5zS05ZK05KZjZWeHhWeklYbU5DQmtvdllOT0YrQUNuUVg0aFZE?=
 =?utf-8?B?STB1bnUwa252MjlyTDl4Y1I5Q2c4MW92OXRLc3A5Y0dPQkNhUEI0UjN5WjBF?=
 =?utf-8?B?ci9RTzdYQklrMHR2MzJpN3dKVlFMdE9PRXI0VmF1QXJuUjZsbDRpcFB2VmhE?=
 =?utf-8?B?TTFDcGhmSWxhYlg2UldWYTlLcTZCSExJY3Y0MjVBNm9kV1E0UU5hUlIrYmhD?=
 =?utf-8?B?NGlocEFnSkViODR1ei9jc21oQ1NHUUxIYUVHNUJ2UE51djJ3MjUxVHFUanZm?=
 =?utf-8?B?eWcxS2VxNEhSTHdEQ0Y2WkVVeTZUUHVQTGlZQWJlUjFwWCtUYXZ6U2p0Rncy?=
 =?utf-8?B?OGVwMjREQ1krc0xRWG9XTDdPR25vWDhyTTloemxIQWNsOUJyRmo5Y0oyOUFR?=
 =?utf-8?B?a2pDTnRNVXBXbjF6alpoOXE5U3hIbmtKZVVzMHFpMW5hRm41VU1WNkY4d21U?=
 =?utf-8?B?ZFVqeWJEM2ozNDRvVGNuRkwrZzN5Q2lNWFZ1eGd2b1Vsb0hTSVoyMDVMeitJ?=
 =?utf-8?B?M2FSMVJ4N2NlT2FxSTE5eHNuVGxmcWw4WGpMZFVGQlViMXdOeTk5Y1lxODFE?=
 =?utf-8?B?YlZIUzVjMktsb1dtZVF1T1ZzZTJJTWpnSWhYdmZwdExhN2k4clI0cTZXbnUw?=
 =?utf-8?B?a0FZRVFwMHlWODU2SDh1OWtHWGFnRGpTVzVqcmJoSnYyMGhvT09BVzVqMTQv?=
 =?utf-8?B?bjFNTDB1MXZzVTNIQUMrQ3R4dkNHLzRINlRyKzRvYTBvak41SHdJTHBOVjhv?=
 =?utf-8?B?ZldiVDV5ZS9EeE5vdEdzbWY0N2VxN3EyQjdjSEtRdmhjaUVOUjhKMFE3MHov?=
 =?utf-8?B?KzU3OTlzRHRDVEwrQkdrWkhQUHRjaWVwNVVRcUE2ZWVuYUhuY1JHOW1GUnFo?=
 =?utf-8?B?WDZWdDRoSEpQRUs4RjhMWWJXOXZOdEJCOXhzT2pMM0I4Y1ZxdjhMQWNxVG9T?=
 =?utf-8?B?Q3VJaGt0cXRYbERIRzRrR2JoWlZVVWlzVUo3azNuL0tiMlVXbk5UcWRkcVlk?=
 =?utf-8?B?ekFTZ2pyZlBDOU11OUYrNHNoSHI5YXFsS0pGdDdyUW44bUYwRGR1bjc3U3pY?=
 =?utf-8?Q?KoIEf3yWTGF9XT+ATnQgKS2LG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2948ce1-05b5-400c-1bd9-08da8a7cbb57
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 11:42:35.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKjya83vcRhZZI2OeqQYI0N10ycBYz2S8yPHC1gufq1vtnfvB5ai4927GUqF7R4nr/IFE5vpb6QpZEFYP5Ubbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2022 06:39, Rafael J. Wysocki wrote:
> On Mon, Aug 29, 2022 at 6:29 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On some platforms it is found that Linux more aggressively enters s2idle
>> than Windows enters Modern Standby and this uncovers some synchronization
>> issues for the platform.  To aid in debugging this class of problems in
>> the future, add support for an extra optional callback intended for
>> drivers to emit extra debugging.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> and I'm assuming that this is for Hans.

Thanks, and yeah I think it makes more sense for this to go through 
platform-x86.

> 
>> ---
>> v2->v3:
>>   * Rename to *check
>> v1->v2:
>>   * Add a prototype for `acpi_s2idle_enter`
>>
>>   drivers/acpi/sleep.h      |  1 +
>>   drivers/acpi/x86/s2idle.c | 14 ++++++++++++++
>>   include/linux/acpi.h      |  1 +
>>   include/linux/suspend.h   |  1 +
>>   kernel/power/suspend.c    |  3 +++
>>   5 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
>> index 7fe41ee489d6..d960a238be4e 100644
>> --- a/drivers/acpi/sleep.h
>> +++ b/drivers/acpi/sleep.h
>> @@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
>>   extern int acpi_s2idle_begin(void);
>>   extern int acpi_s2idle_prepare(void);
>>   extern int acpi_s2idle_prepare_late(void);
>> +extern void acpi_s2idle_check(void);
>>   extern bool acpi_s2idle_wake(void);
>>   extern void acpi_s2idle_restore_early(void);
>>   extern void acpi_s2idle_restore(void);
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index f9ac12b778e6..474aa46f82f6 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -486,6 +486,19 @@ int acpi_s2idle_prepare_late(void)
>>          return 0;
>>   }
>>
>> +void acpi_s2idle_check(void)
>> +{
>> +       struct acpi_s2idle_dev_ops *handler;
>> +
>> +       if (!lps0_device_handle || sleep_no_lps0)
>> +               return;
>> +
>> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
>> +               if (handler->check)
>> +                       handler->check();
>> +       }
>> +}
>> +
>>   void acpi_s2idle_restore_early(void)
>>   {
>>          struct acpi_s2idle_dev_ops *handler;
>> @@ -527,6 +540,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>>          .begin = acpi_s2idle_begin,
>>          .prepare = acpi_s2idle_prepare,
>>          .prepare_late = acpi_s2idle_prepare_late,
>> +       .check = acpi_s2idle_check,
>>          .wake = acpi_s2idle_wake,
>>          .restore_early = acpi_s2idle_restore_early,
>>          .restore = acpi_s2idle_restore,
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 6f64b2f3dc54..acaa2ddc067d 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1075,6 +1075,7 @@ acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>>   struct acpi_s2idle_dev_ops {
>>          struct list_head list_node;
>>          void (*prepare)(void);
>> +       void (*check)(void);
>>          void (*restore)(void);
>>   };
>>   int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>> index 70f2921e2e70..03ed42ed2c7f 100644
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -191,6 +191,7 @@ struct platform_s2idle_ops {
>>          int (*begin)(void);
>>          int (*prepare)(void);
>>          int (*prepare_late)(void);
>> +       void (*check)(void);
>>          bool (*wake)(void);
>>          void (*restore_early)(void);
>>          void (*restore)(void);
>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>> index 827075944d28..c6272d466e58 100644
>> --- a/kernel/power/suspend.c
>> +++ b/kernel/power/suspend.c
>> @@ -136,6 +136,9 @@ static void s2idle_loop(void)
>>                          break;
>>                  }
>>
>> +               if (s2idle_ops && s2idle_ops->check)
>> +                       s2idle_ops->check();
>> +
>>                  s2idle_enter();
>>          }
>>
>> --
>> 2.34.1
>>

