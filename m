Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11026597DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbiHRFAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiHRFAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:00:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E793521;
        Wed, 17 Aug 2022 22:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsKEBInlGHNG7ohDWI4czlV2QqEzE9XhfezqNB6HwqwtIPm0iyzk5BddCzwUULyyO/VO6zs5Z2Vl7kuSROLBh7kFwUugAwSdVExVKG3dJ6iIrWKxn51jVNvwLbd+rThYFiA1MD8KlH1zXP9WHUMorn0pQJZDAiNPjki+UiwZkDbATQ5OWfooLtnpuayNrmIwmTqgCqj7ZQ9ULgu1IIYT7fJ3HxBIkwUthyekAeF14LF5I2scoAsXc4IzZzdikc4iPVoUsGUKtJJCNjH9K0jwDcp6z6Qs+zBJSzWPapTzLra4unko09zxWFzkjZwBQri0uFahuGT8Hz1/FCFaqycwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72dILuJLLBb5Nb9TQ4vzaAR7GgkQlnCl8CxbZ107zts=;
 b=iSdypduyXEqrdX3OoiPeQ2YuRpcIfXIBFcBvikeiEX4+c/yreuteuk91JQ1pLM21Qd4quETjTNYjamnj0QGaAXvYfj8SXWNolRNnr0AutGiSWejKtZ/FDU0hn3QJHkEuRhC9RHVosRP2t6WQOVvDO5/P162+pP0PEQjZ0xR6g8JpvtwYJVrAi5sDlUmLRvINjLdWcF+iJMRNM4NFnDkJRkjIFP8O96CeMge1UwBMZvUURvOqJYBHddyu66ojHhn673T8K+S3B6/cvW/UiqP8ravDjbdMnrMZrubkBB5Gtbdknk2qEcoH62H4AddRPqtUjV2O1QinrG7UNZCccmPN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72dILuJLLBb5Nb9TQ4vzaAR7GgkQlnCl8CxbZ107zts=;
 b=M/CmMoN3/8hMWVe6rXny/kD2UF0/3enBmHYUJPl0dU+Y9RBLkUTcA4rX1r9V1Ogx9ZVPXYoimHSnoMdI787VgUB2GHqVDdYqSgneIwtbu/BrP1o/MZpK94w8u/DvmwbV3c332rgCIg6yLDVIGSh1GrYsQwwhiI1UZkK0HfADxvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 04:59:58 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::8481:5712:c1a7:f84]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::8481:5712:c1a7:f84%7]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 04:59:58 +0000
Message-ID: <3bb043a4-987d-5896-29e1-21bb471da0e3@amd.com>
Date:   Thu, 18 Aug 2022 10:29:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] AMD_SFH: Add a DMI quirk entry for Chromebooks
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20220816102120.6131-1-akihiko.odaki@gmail.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20220816102120.6131-1-akihiko.odaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31d6452c-e51c-43f9-2690-08da80d67fa7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzCMhwfgjdpPdjkh+m3pE3QrCFCBZEoINIZAsMyLNEbON2MsywBpSlYylA7/k2DH/LQCGrqZ6UuAD6OaLnygURZAUaLoAnFGKsWFXxOLGd9D0fu9I9ZofL4oWcIUjs5aY/7p12ShB3jviHv/M7V6ig2HwWI6mFkV0lT2k1wPkWWRI7JgpViIWgsvG6o2D/tz4AKlBHOuZv0lE9q/Ob+ae5MAun2NJMUvJvdday+T7FrfzosC/bggc2TevR4D70epdUpLRnGwP3kdLkHISDZoxaUTKT6GiuXM2csVzEgbPbBptLgdV9pjF3zRjW3AOmzPdpTHP4keJvcOlGjp3gvdx9X1SZ3TQavMZa84HdVUyzBs03RiHVjlE3pJIY1UPMupc/0pl35KVJRvz/cCWmRcsujUuD5rYq6Ugo/Bn57cnERwGnfzZqmjxrMCWzbgOegH4LQs92S5c6CsWr8oxJjSiARrfDorcDpfuWhH+/uvoNe2oqS6niluKFkpFzsl8rMLbqzg7gKbZiDMO+qrvye7l8H9kwSDPFgCPcR1Hmt5vf5g0WQJYOJGWQvzSaWxl1WCcKLbCYpc6d8VFOIu6bibLogsJN/AFCKjEG4R/rTOOCU3eZ5+pPuFw9Ue7p9/GYn13Ahmg9G4kkfIPTgohbQj89h4F2GrkNAU7ZSOLZOmWTWlzlvr5SG4UnBxAe51UMu8z+t//795n6hSOuIgY/f7zfN2/d5LtYrRHH0RWxKcOfyKj9gM3JTWplgx6/dXmNzJOgRk3xedhsGHCnqH+SavKFjtDyLaJBnB8PA7oVlrgOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(6506007)(66946007)(8676002)(36756003)(83380400001)(6916009)(53546011)(54906003)(478600001)(26005)(6512007)(316002)(31686004)(186003)(6666004)(41300700001)(2616005)(6486002)(2906002)(31696002)(38100700002)(4326008)(66476007)(66556008)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2VzOUozSjdBaFBobHc1UW9NVno1WVdlVTdteWgzaGVZUElaOEtJTmhVOWli?=
 =?utf-8?B?d2kzejlja2Q5M0RnUEhWZWIyOFRWdkJxL2R1eHJYaHRQS0lUeFFoc0MyUDlF?=
 =?utf-8?B?c2srQmMwYTFSa0l3TDFXVGFpY3VvRGtiNEV0TUZ2TUtzTWgwQ0lQTFRibTJ4?=
 =?utf-8?B?K3FoK1VJR0lyU3NjZkZkVGxsQlB5Uk1lOFJIYmQ1NytkclJkVHJXMTE3eWcw?=
 =?utf-8?B?R3lxbkNFRDQ5THlTTTJ5WWE2N3JVSXhlUmc2QUNQUnJkOUUvQVBOTy96c3N2?=
 =?utf-8?B?b3VsdnJKTUg4K1o1NGd0RTVyRFF1WVpJMUg2elVtQ3BFeEtTaGk0M1BhcjFw?=
 =?utf-8?B?L1FRYlhIdlliS2Y5MzhNTTcyNHI3bjNhQ3ZaaUVDdzRac084Nmg4U0JrRktO?=
 =?utf-8?B?aTNocmgrSFVkajBFdHVjWlM0MjBNRUpGeGRPUTV0VU80T1RiMFVBSU5MbWpl?=
 =?utf-8?B?RGI5Nk9IV1F1M2p1K2tZQVFka2ZQSDRmLzFDaGl6SU15Q05tdFNIR3NxbUpw?=
 =?utf-8?B?RDF4TFIrZERhUUJCMllxNWtXUWNodWp3YUlRWVRFVGpwd0dMamxGVzA3b201?=
 =?utf-8?B?OGRzUlJrRjVTZU41TzlDaVllRkl4Nmk5NmFCaE83bitvUzNJR2p2V25VbXQr?=
 =?utf-8?B?Ui9GdGRVRFBBNzF1ODRzVjVpZHZFV3lmYzVRMVVKeHdVSUNaZnJ4L0UvSGVD?=
 =?utf-8?B?b3REd0cvWXM2enhka2RzdklOcUlnWWg4dE5Mb2Z0SGNORzBock91eVR0S3RT?=
 =?utf-8?B?SVNIRDhPdFh6SUtaUnJXdW5uMDRLMU53ZUdjRlQ2M0gxMFpEcVF6RzhLNmNC?=
 =?utf-8?B?Z1BRTEpudmsrRVIvUmtRZ2ZxWUVySngrSWxEWHNMSUpiUlYvWGUrZXpySmoy?=
 =?utf-8?B?UUJDYlV2dHdickRJTS9kUHpGSlplbExBSnMwNjk5d3Y0a3JpcDlMT25FN242?=
 =?utf-8?B?MGlqcUp0NlZzZ2NZVmM1QlhvbzNwUDgveHhhM2Q2LzJyb2p1bGFpcHFqZHFE?=
 =?utf-8?B?SnRvNWJqcFA2VzlhOHRwSktFazhkWFJtTEZ0SGNGaGMwSys1azU0cE1QQXVW?=
 =?utf-8?B?OWdneHgxbTdEbVIrODJSRC92MHpDaDl0SGIxUU02VGxLOTJZTStKUGZFTEtH?=
 =?utf-8?B?VTdoRHRNaHBaYldNR2NQWS9iK0pjRjc4RGFBbnpWRTBTZWhaRUtIRWVlZlMx?=
 =?utf-8?B?ejFaVUJFVy9xdWNYS0daQkErOTRMcFJ1YjU3OFc2dXNQSXdQTHlQRUFaaFBL?=
 =?utf-8?B?a1BaN2o3T3hEa2VtaTY5L0tubmZtOTRiWC93M1MxTW00bUtjdjU1Z2dZZEN0?=
 =?utf-8?B?UWxsM1Z1cWxLaGNBRzVBVlpZMUhHZGlBUjZSQ0p6TU5HVmRlMlB0NXJRczJL?=
 =?utf-8?B?dUoxalB3bGdBbDRoanR3WmNkdHkwNzRKRWpVQUR4MStBVEhiWVM1MTJnOWRx?=
 =?utf-8?B?QW5PbFZtYVVhcy80b3VBQ3ozdmtKUmIrVUJDMnBMYUo3ZWRXSHkraHhGaThD?=
 =?utf-8?B?R29BUzkvU2l2b2NMS3hnZEZnQjU5aUErbGVxOWd2VjlpdTI3a0UyOWdKU3du?=
 =?utf-8?B?RVRIMkRmczF3WGVBRFdBQUlsRWtSdE5XcTh6SVdmK0xoc0NFMjBqUkFDSGlX?=
 =?utf-8?B?QkIzeDF5c3lYZ0VRZzh2ZDlFejFqMHBvS3Z2WjJCUklBYzBDOXVKY0x6a1BQ?=
 =?utf-8?B?TjgzQjVzTXpDMVZOMFVGVFdKaEpUbzkyTTk5NEhFWFZUUWR4MFJ4eUpzV1k3?=
 =?utf-8?B?TCtmSnpwZkJKME1NNmtocVd1dW1GUmJyZ2xqSU9GWjdRMjNRcGhtbkFyRTYy?=
 =?utf-8?B?RS9ZTGNkZjJGSkxUaCs0Rlg5L05kVkZ0MjVzdzZWZjJ0b3dObldCTnYyaVB6?=
 =?utf-8?B?N2JOcTJjNWRVZHU2ZUZqTVVRUnA2cjU1dllMbnBVSitmTUpEZm9YVzJmOGVk?=
 =?utf-8?B?c2ZQNG5UTzM3T1hqSllEQXZ0b29qQXpBd3Bxb1ZNQ3JWaDAwZ291ZnBaTHcy?=
 =?utf-8?B?Qno5aHhXcHdYR0NoZlkxQVpsdkY5SFYyYlJWUWVDTHBMVG9UVXgxQUlIb1Nx?=
 =?utf-8?B?T1ZiM05PU2Y4QzRUcVJGOHRKY0dSZ2hZbzRtUmRJSjR5MmVUemV5c29uNWIr?=
 =?utf-8?Q?4s1j8HAB0/O8G5AClveQz29LE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d6452c-e51c-43f9-2690-08da80d67fa7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 04:59:57.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuKLtB4Jp1unt5uY7lbfWHApYS+t1ANmLOiQ/mQz4YVQIvwBIEnCLe3dtUjXP7GnIl/TvMNeitK9RQYhlT3a/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/2022 3:51 PM, Akihiko Odaki wrote:
> Google Chromebooks use Chrome OS Embedded Controller Sensor Hub instead
> of Sensor Hub Fusion and leaves MP2 uninitialized, which disables all
> functionalities, even including the registers necessary for feature
> detections.
>
> The behavior was observed with Lenovo ThinkPad C13 Yoga.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index 4b90c86ee5f8..47774b9ab3de 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -288,11 +288,29 @@ int amd_sfh_irq_init(struct amd_mp2_dev *privdata)
>  	return 0;
>  }
>  
> +static const struct dmi_system_id dmi_nodevs[] = {
> +	{
> +		/*
> +		 * Google Chromebooks use Chrome OS Embedded Controller Sensor
> +		 * Hub instead of Sensor Hub Fusion and leaves MP2
> +		 * uninitialized, which disables all functionalities, even
> +		 * including the registers necessary for feature detections.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
> +		},
> +	},
> +	{ }
> +};
> +
>  static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct amd_mp2_dev *privdata;
>  	int rc;
>  
> +	if (dmi_first_match(dmi_nodevs))
> +		return -ENODEV;
> +
>  	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
>  	if (!privdata)
>  		return -ENOMEM;

Could you please prefix amd_sfh patches with 'HID: amd_sfh:'
With that addressed,

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj 

