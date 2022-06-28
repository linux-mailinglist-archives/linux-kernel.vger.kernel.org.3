Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DFA55E728
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347067AbiF1OmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346595AbiF1OmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:42:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11392AE39;
        Tue, 28 Jun 2022 07:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGzBhyH/gHEW3Tq8GNbojyMOqdJvoUf5ub4f0Deb6Y2R1kaXg0a+uUABuy3Ll9XFfvbUG4N2G0ZAUZI4owuIahC1q+3kmKjGgg7/Klg0vwpv7k6/+M+/KshNA2d9PDMEAmEg+0Lrrp08WsCT6CtI/svb2FQ/hPnyiWiONytg132gh1jLNN4cQ2U3x0HU7MRJWPk+w59ha5cGI7m5TA6wYeYC/FmHv97k7N432ByewCFoeez/pMkvSg5NSo5QrZkgGyMWpqeJU741wxNVEe3BTTHGa8JFKKG7lz+eoThkFWCgSr4J5JjcEGBji78DVyE85WPIu6NV0KapzxAFp5CtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfXBbIbinlzv7CqroQDopb69JT6tk1vXFc/KnTSKSxg=;
 b=QHIVR6L1M/vq3czDT614zzNXbH135AtS7/OX0T0M6jEeytQXN2KvLbJfqqOvwXtRTaHlgC61ZjRdeBFGDEVV/flo53BM/HJx7hRGy0IPiKk8NeHXaSpskavjLkZMKVnDdtVpK+wyJPU3bxmQOh//ANgdUs8fskyRDXxS6xTnmXP/Kz2IfQnwpiLJgo4eM0xf2Wx5SAnZ68xRsmWBPkSY3zDDnRZj3OAbopeJEAylnsq39D/7P6GIi/DJzaWSAQHeZnmvPGNT7JlNqNiBKoetOv13WkFWV+rFclfAuyJwgj0vCiQohXtXQ0Wt0opSObiVTtp6VGHWVn3GISlzY5VQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfXBbIbinlzv7CqroQDopb69JT6tk1vXFc/KnTSKSxg=;
 b=HaPavXRPVfRm1gQPqMZsQ7brRNbc+hQv/UbVgdmuyJF7ci+D9xfqoZh+5WlMj4fmLZw/lLSZPbZHBeVavE9qn9+LCN5aUIp/lwe6sU8TeDYX1/5VXxZdK9rUYFhp/qFfvGRjCVPywEfh6lE0Glyw4mW9Yeu5jZW4zKe3gPopYUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY4PR1201MB0101.namprd12.prod.outlook.com (2603:10b6:910:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 14:42:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 14:42:16 +0000
Message-ID: <b17f4e85-8a35-65ab-34de-0978bdc4cfea@amd.com>
Date:   Tue, 28 Jun 2022 09:42:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] HID: amd_sfh: Ignore uninitialized device
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220626081339.7243-1-akihiko.odaki@gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220626081339.7243-1-akihiko.odaki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:208:23e::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6957a4d8-1590-42bd-22bc-08da59146585
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qpj45N9EPa86xZxdws54T31yWUwoZMctlCnkbc2jNDERudHS4BtghNErCa2Z8cwr/2EJF+ZoOztDJzsn914ciKjctf8u/tn1QzrlMxTJSRrIGZ32BJMMkCMlt5FgH/M70VIiIWMP8HV8Kp3f/t0O3RNmPpUcOHNognHLgS1jgePzFHTPfbpoddMRVoYnFAer0oc1UAXy7Qdaa2NSUr6g5NIJeVzbsFvE3uPq3Ch3HWpijb8HHGiAZyVA8EtVYqCPFJh6KgvC1OYHyU1WIjnO4Kb3PwdxOgnmx3wRsDLczxQsxOzMGM/OS4FJ5/kwA5JQOQIQFbDlNMe5hahC1exSR/297OPjKA190InaODWjcvBBg8fKB5FbGySzN7ORe6hfdNl2GQImNU+cksPciK/OECP1JXMzhyy3lWX0tpCVnsdKsX2/dMQgHz3OArOiuRIWW8a5M0tMINDvm1TWK6bWug8MPcStmOQ4B1l0r2Wdd8rm/EVqCDyIgUeA6fupRO5mI7hHSVtn+oRzjlUaYCgEmPilIZStu0AWaU3rmnGxBTWh/EMiUjEesq7iExPJwfgxZD4KScZpQxHikrdX0z6qObaLfxzSzC17z5DWvAiirjL1aFyGiBJtITNwUVw2yOrz39ngl/w4sKtgDkf9Rb6pkZX4081+NPE8Lm1sjeLGEzUwV9VXcgpVGrxcHVTdKauL7WAklJk765Etd3Ha4OftMtDIjzQafIDSDURqcKzEs9rYJTN2KJhGa4DD0cIBzrIxDbX+kehvZvfO9/Iir5/cKuBNqiU6oJpKzqtvqIVDjwPdnJM8WzvMePi75uO2XSpJJSCpM9cOca0U3SnRFRo9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(66946007)(86362001)(8936002)(5660300002)(4326008)(66556008)(66476007)(6916009)(38100700002)(316002)(31696002)(8676002)(54906003)(36756003)(31686004)(41300700001)(6486002)(53546011)(478600001)(83380400001)(6512007)(26005)(2616005)(186003)(2906002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBzS1JkMWs2b1I4M3dRL1MrWkxtYWYxSjF2NUpxMmo5NjM5M2FOTVVTWWpY?=
 =?utf-8?B?N3hPV0FySkMrd0pCMk1pa014ejhESFdheWc2OGRvMDVvVXVRQnc1OUsyVEU3?=
 =?utf-8?B?bzBmQTh3RG9PekwwazQ5RFBiWjVYcUcvQURyV3IrSW9hTG1MRTl3N3lQZ3dK?=
 =?utf-8?B?eHRtTHZWb09FdGtINDhpUmdkT3RZQUpZNExLT2RCQVRtZGU3UGwybzFOc0NU?=
 =?utf-8?B?eVB2bkwwdlYxZWI2K29IMGx4VGlDMDF1V2ZsQTcxNGhqVVFLM2pMRHNhRDRj?=
 =?utf-8?B?VVB4aU16WCtlV0dUU3hzWVVTbVlRV1lIQjlzZnI0ZXRIeWZsbE9mZXJNTFJy?=
 =?utf-8?B?b09BT2JKRi9rOHdLL1BKaGFHeHc0enJQMm1XSUNQYkVqZkNpdSt1NnZIektn?=
 =?utf-8?B?UWdVYnI4L20wOFhjdlRzaWprekNwVW95ZWpVMy9zRENOWmoxT29oMVVJbUpy?=
 =?utf-8?B?MXBMTnUrWEVtQmU4RUdPbkNBSEwzQ2FzYVpIb3kyTTVWOUFnYTZhQUtOM281?=
 =?utf-8?B?WjBFV3RhSGh5TXdwQnRWN3ZNMDJuSTBUVWp1VkpCT29lUGtLY2NOQ0QrSlpW?=
 =?utf-8?B?OG5wUmVCdmV3WnQrK1lWWTVlZkp3VkxnajZVQ2pNRGFDNTI3SEZvVjhuMGVO?=
 =?utf-8?B?UWZoU2lHc3JBbkQvQ2V1TWpkMVhYUTdIYW9KRysyNmVIaEQ0eVRzcGdkYmVy?=
 =?utf-8?B?VUd0d0Y3TXl2eUZoMldTUnNUYVpUUklPMzdzVzhzOWVXcWFsbjlvZ3AveW92?=
 =?utf-8?B?WjdhakM5cnMwSkdFaWRKd2FDSWJoMnJJaG9oRDREcXorSVc3K3ZaMmV1V0tI?=
 =?utf-8?B?UnJ0d0VpUHJTOGtGck9TT0VpalhJR09MY2cwK09yamhRaEFiWUlGam1HekFr?=
 =?utf-8?B?Z3NZRnd6bS9lSFl3Mkx6VmVoZzdQMjFZVHBtdVNKSHJCZzV5VkJmd1RVSzlO?=
 =?utf-8?B?MU9oQ0E4UEtQM3QzbzBMU1ZwNlZmbHcrZFZZcS9ZMWF0ZUtCaExvV0xrdUpo?=
 =?utf-8?B?NUpPa3RNZE9HeVEwbHB5OU9RYisvZzV5MFJQMm4rQmhJU3pkc3lGZ09ldllK?=
 =?utf-8?B?VTVxWEcraXFDa09ZZS8xOUV6SnpmRjJkeDE5K20xQmJiU0M0c25FZWF4aW1H?=
 =?utf-8?B?RDJaNDdSTHVva3FkZk42b3ZFY1hRajYzNmdRazJaWllXTUYybDNBMmw4SWFz?=
 =?utf-8?B?NkNrTktVUnh6Slg0WWVEdGJOeklLUTR0QU1ZQkxHZzZkdW5scEY3cmR4YWM1?=
 =?utf-8?B?ZzhLZWhLcGIrOFV5WUFqQ0ErMUpQMVk0YTFqdWxOSXJiNkducWVBT3RHamp5?=
 =?utf-8?B?Y3pNejVTdStBaGFKUkpGbi90WmpoZ20rVUY1cVpOYVFha3hSWVVKMFFrRUtW?=
 =?utf-8?B?Z3I5RjJ4MksxczFDWFV4R3hrRG1xUnhxRy9YTmd2U2k2MFZRTEFUeDRGTCs1?=
 =?utf-8?B?cVAxV1dMRFUyR0lVM0MwVmVaVWpRSUNoRHdobHJJejZSTDd0dm43c2R4WHZO?=
 =?utf-8?B?b2hUWWtsYUc5ejlIRlZWTC9RYktyR2Z2U1ZRM1BLWkl2K0I1bXNwRUxKa0RN?=
 =?utf-8?B?cFdrUjBHbElXY0k0bTN5TGI2OHdKcElEUEwrd0k1QVdjc2pkK1p3OFlXWUhu?=
 =?utf-8?B?bzhHV0ZRVXljeXU0WkFsTW53WDljWTViSmxxb2lpdkN3UVIrUkpKcTY4eFAx?=
 =?utf-8?B?anN2T1VHemNtRVp0bzE1WGJ5RG1ZR0xUMzd0cXBUSzlYRGRabkpIVEV4WW1F?=
 =?utf-8?B?YVV6WnpDOTRTSlhrQVJOcUNGTXdtK1hEVWoyRS9NcXRiUWxTS1pvSjQzSFQr?=
 =?utf-8?B?eHNiclR0eW14OVBMSVRQS0dpYVkvZVl3RmtOTGVTVnd3YXphOTBQd0NPTmRt?=
 =?utf-8?B?ZTJIL0lUOWRrMnYzQ2d1TkpHMVBNdVA2a1BVN2NMR1BTNkZiMXVXVjRaUmlG?=
 =?utf-8?B?cjhLcy9CY0k0NVEzbm1JbkcwMk51UnphM1dmcWlZb3g3MnhBNjIrOW51YUI4?=
 =?utf-8?B?YW9JNUorMVlqbzkwbGc5MDZvYUtTRGVNQXEzQlU0UmFCK3JIdXIwb1J6dldT?=
 =?utf-8?B?L0wrUnNFbHVHUlVVWkpZbVNxM21hZTVSZkFqc3ZmOWkxNC9LTkpHMTVkZ1M5?=
 =?utf-8?Q?9BBTMig3h+caFPbRLkzP+0AmM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6957a4d8-1590-42bd-22bc-08da59146585
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:42:16.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMxSK4TCn63Ge65SiuNHSIfjV6ZG++c+s2QoqGWZqmXOIlKYOjmiPc2HCDCMX+jn/k3VJ0mca2YGCIV7zlUdvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/2022 03:13, Akihiko Odaki wrote:
> Lenovo ThinkPad C13 Yoga has AMD Sensor Fusion Hub, but it is not used
> because Chrome OS EC Sensor Hub is used instead. The system therefore
> never loads the firmware for MP2 and MP2 does not work. It results in
> AMD_P2C_MSG3 register to have -1 as its value.
> 
> Without this change, the driver interprets the value as it supports all
> sensor types and exposes them, which confuses a userspace program,
> iio-sensor-proxy, and makes it to use the non-functioning sensors
> instead of functioning sensors exposed via Chrome OS EC Sensor Hub.
> 
> Check the version bits included in AMD_P2C_MSG3 register and ignore the
> device if all of the bits are set.
> 

Have you already confirmed this failure happens in 5.19-rc1 or later as 
well?  I would think that b5d7f43e97dabfa04a4be5ff027ce7da119332be 
should have fixed it.

> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index dadc491bbf6b..4137e5da77ad 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -271,6 +271,8 @@ static void mp2_select_ops(struct amd_mp2_dev *privdata)
>   	case V2_STATUS:
>   		privdata->mp2_ops = &amd_sfh_ops_v2;
>   		break;
> +	case 15:
> +		break;
>   	default:
>   		privdata->mp2_ops = &amd_sfh_ops;
>   		break;
> @@ -317,6 +319,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>   		return -ENOMEM;
>   
>   	mp2_select_ops(privdata);
> +	if (!privdata->mp2_ops)
> +		return -ENODEV;
>   
>   	rc = amd_sfh_irq_init(privdata);
>   	if (rc) {

