Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05994F22E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiDEGHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDEGHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:07:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0FE101C5;
        Mon,  4 Apr 2022 23:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6vjTyi0oMLAtMEMQalAAPZZQkVG0lHDZQqBwjPJBc8wpj5pSgk+jSr/PL4FzhnLxe+CqsAV2X0xrig6an+NJkFthG9lQNCuUUqkF3ZHRQMBFN+FlGHvpmtyyu+T6m1D6rWw6GicmaSDAXKzB9zuc11sMXlLnrUoUtkOa3BpP7EYrpeWlJiAesTV2trtIayZW99+8riOO2LeH2Vf+4imnaFJR2ft5dK/lV1FvcVnY5rxa6kvAq6SudJReipBHWMS0U+cK51kcH1NloYWNlO/e0VwSXGQ5cNX/qwQ+ku06GZshVLHkhVlJfIGlth82abkb2K6x62GcXTT6yYIpm1c7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2AOZ1yEGa4mPSngGSjn2Z/nSCtvHOJc057pSumCGII=;
 b=n0N+vy7duF8yAi778xTg6aZXTdak94PvWFtTawswZOLyRnVzBuOpsdzeHCmUBaHSzy0MhxTS1rQuOx4wqZXvQv3EiRXNo1yh3k+3t7pyJlQuWDiFudqR7KL6lY68eCBRLy4vPa2zj40Kzgy5l6d0NFyiG2kXJiWrE+H7+4mAE5ZSXmV6yJ4MgH3DFpHSwpeecFyMSsIAa+cNnX1igybVpI7Xh8fvcD4O5eYBWgR5vPxa3EmTulsXqYpGLDVEKGEIbzG7IZ5zpZc8u/iiWe2WB1a6g6oMahDaxlN9tBICldTQCGneo6DQRSyEqAyr8ILTZYRILU8iXUTcuwkBl4BTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2AOZ1yEGa4mPSngGSjn2Z/nSCtvHOJc057pSumCGII=;
 b=oXg9R1Rz3GifNlQRCj3iy2gZyYS/19AQWg5vvThj/7m5my4w/GKS98oKTOYdaOwe26P9WojUVYLZf2pIHuE1k+QwwmbU82THUPzNFGHeYMdQhCwsv3VBX4cZvjeikIRzLI/1VzLfB3EDhwDVE3xyFCLEhnr9k7jbvmCK3a6HE+ztMXhtBUBloqPiQvP3ojR9CpBwYEJ5XmJlT5rLe4QNP9kcHYyLk1tNj9hVokpeZ5O4pCKgIsRvbqrNlNO1vhJI+8zZyCBQpZbRLT5PqQ38yY2SK8Gt0DIuiCEAuw+RdXv0gwQiQwxDPlvGDuEgiQqsBEth9EdTNtZ835B1xE9N1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by BN8PR12MB3154.namprd12.prod.outlook.com (2603:10b6:408:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 06:05:15 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::8c21:efba:52b7:270c]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::8c21:efba:52b7:270c%7]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 06:05:15 +0000
Message-ID: <a6964809-ad10-aca8-0776-011c9e6b318d@nvidia.com>
Date:   Tue, 5 Apr 2022 11:35:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ALSA: hda/tegra: Fix hda Jack detection
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, perex@perex.cz, thierry.reding@gmail.com,
        jonathanh@nvidia.com, spujar@nvidia.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220405032607.8489-1-mkumard@nvidia.com>
 <s5hfsms843u.wl-tiwai@suse.de>
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <s5hfsms843u.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::33) To DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 464f431c-320c-4528-f03a-08da16ca408c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3154:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3154ACC6B5BD0D3E463DE9F9C1E49@BN8PR12MB3154.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjX1mgpPfKx8rhKADMmYx08N2DJsOQrPnCVE/7Kb5LzqPECm4ZIDE7M8pIw9m5ElURsPAJ3Lpi6kgilRTrs3qgN3g5Wl7vcri2cmQnOf+rKM/Y3WgBCAmHwFazifi1t4oM1ehTTk8D2SUvSbu1Q1GXyc3ebPRQEtvXBLY3gugJNpCiuh3oASPWr0/PSgAq41U9YF6ZqKxW4zBoPDOJjGxMVVDYUlFEUr3REK9tAHmys0sZBr2kKFAwPMEpPtEYl9Jf9pFDqS6VHPlcoXwhnR773j7aNM+547n6xfPJ7xDmgKnJHhd5BIbG8rSmITigQ8/lWhZKHwaPuLAUnsg5eACLB0xhH/Rp2vZvJW3LcyAqdSObFi+etkO4nmUkCWjEzCJnT73bxEwrcaQlAvPzuj1rDhpItbL193gMkpssLw4fdT06rxIzoHWkdX9+lMjpbLR/9DhnV6jiVNXsuaF9lRJM1Y6Dxv0vWbdpUGUC++tIzDKoBxlwQfRE8HfBhLLkwgFCJm1kfToYfZ57eRlLb1j5ZrZHAspsWB1kH6evFwdBTt5V5IdihaEWOQR6HhLGcpJrcR7D1tGjBadYrQAEJ10R5MCKQ4RzVNpD5VwEfp1KVDjrZ+ZMo0w6vqsL7Omcf4gobikD32pa/FfLrkIjBySMGAixfDwI08LXZJfPFts12+HYmJrNJ5e2lxM8BjvLgM2cjRuuz24kOARVe0nsECDx6L8DQRPUERCiAGEUaw73o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(316002)(6916009)(8676002)(31696002)(2616005)(6666004)(6512007)(6506007)(53546011)(4326008)(86362001)(8936002)(508600001)(38100700002)(83380400001)(6486002)(2906002)(36756003)(31686004)(5660300002)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWpFR3NpbGg0RHhDUlhjRC85YnhyREVOVzJQUXd1M1BXc3k4ejlaOFMvNzcr?=
 =?utf-8?B?UGQweXVDdjltVkdpaDlwd1R3c0pIOWdLSTJmbEJ3V0N4akxvQkVlYjJQRjBZ?=
 =?utf-8?B?M2Q5K2ZJZDQ3Y0p3dFY4dHM1cW1JVzdNTWNsY1BVV3ZwVTU1NExHTWFMSHM3?=
 =?utf-8?B?czhkbmJRNEt3VjhZSkx0UTg3NWprYm1WNDNVZVM2Ujc0a0xPWVZYQ0JJOEtt?=
 =?utf-8?B?ZVNnUXhsNU1BcnhxTXd1dFZaUzlaelJWQnVoSktsa1psdGw1Wm9GaVpqVjgy?=
 =?utf-8?B?bmg1UjNNTlJLaGhWK1hyOGgrVm9xUWxyT1hVaXRGdGN5bHFxaGZvektySUZM?=
 =?utf-8?B?bi9qZzJRb1hLdG5HOERjRnRyY1RiSEVoaFBvVDlKaGdEZHNKbzNWNFdTNGF2?=
 =?utf-8?B?OUdWZ2htaU9Vb1QxMDZ0UE5MbXJUR3F3R25wdGcwMEhpRUc4RkZ1eGdaLzFv?=
 =?utf-8?B?cDhiU0xDQm52TDhzdWZiTG1PTkRFbEx3eXN1ckZBSEhJVjQ3NmRJN2Jsdzdl?=
 =?utf-8?B?dmd5UlNYOVh3SnFmV0RLNjlBbWx4a2l1RUtRMmNTMHBlejN1Ukg4UnVUK0Ez?=
 =?utf-8?B?dGhBeUNpd00zdERHN1BkRG5KeDQxM3FkUUo5UnVncFYxekl2blVXUzk2WnRG?=
 =?utf-8?B?SEJaVGwwc1lqWXZuR2ZHVW5HRUhzMWdCcUVvQWZvWjhnYWNZaWUrcmkwRGZK?=
 =?utf-8?B?YmdtSE00TWxac3dwNisxSHVyYUxKc0I1Y3dXSDJwWU0yRVBaUHhLb0VjYS9l?=
 =?utf-8?B?YndzKzBKOUNLd294S2VyN0tWdG1wV0tHS050UjdsbnBSK0lDbGR6Sm1xN29R?=
 =?utf-8?B?ajRXdXB3b3hXNVcyWmVlSlM0Sm1NV29vcFVtQmlxQ3VWd0VwVi9rZ3lESGVH?=
 =?utf-8?B?SXdSc0tBOXlkcG5oUndQcUVMZytmcExoc3ZWL1d0d0pXNHVzTVB1eXZxaUdI?=
 =?utf-8?B?Z1FGUEs5ajRpYVdqMUIxbXhkQ2N0THFMb3NrczdDSDBhb3pCUFNuczZZcFhs?=
 =?utf-8?B?NlJtUTFBcUdJeXE3SFRKbU9qd2xERCtBV0FWOHgzTEJUNkdhS2Z3MGEyaHFx?=
 =?utf-8?B?RGliQ08yYXkrMHk1VXNkcFYzSm8wWklEZ2JCSDVxQnVwaXJiSGZEZ29nL2xw?=
 =?utf-8?B?M2M0VGQzajFrN2hUQ09FZEVjNy9KVlI2ZzZHMWpSaGZxamdaNWp6QWJDQWt0?=
 =?utf-8?B?bUZEMG5zYXlpTHFkekJ1QlpCRTNpQUt4YmtEVUF6bjdrUEY4dXY0SzlvSXpU?=
 =?utf-8?B?RFBmYlpBWk80TGFDenpvUHZpUHg1bkxVMXF3SmRBcDdjNWNCaEJDc3JtdlpZ?=
 =?utf-8?B?anhTbHh3STBKcGZZdG1hWHpBZEZKVG4zK21lWHU1c1hyUTVTd2hjdzZCVXc0?=
 =?utf-8?B?QjBTUUdwNTRlZXB0KzE4U3duT1l4eCs1SFhUZGtoYUUxTGUydEZ2UCsrSGRY?=
 =?utf-8?B?V21CSmZNU0I4eGlhak40MjU2QWhCeDlBRzNUdkd5WUVOQ1RoeklpVUUwaFl5?=
 =?utf-8?B?NERJcE5xcER3TXlFY0VFNGJ0Q09pbFB3RlFDQ29zRDBueitFei9UTkdmU0Z6?=
 =?utf-8?B?SHp1S0xxVkw1K3ArQjkrRE5lMFZFMWd4bkF1UVlWdzEzTTJCRHRZeFhVRUs3?=
 =?utf-8?B?eFIvR1BoU1RFQUZRRnprbVZDSnVWWW0yK3kzRmdVVGEyL1dPeitaY3FRZ0Zi?=
 =?utf-8?B?S3Jnak1KYTdKUmpYZlhldzlYQ25XRFAzcnNkUmpyUDIrRGFPdE9FNlBNVXZX?=
 =?utf-8?B?TmU3eG05ekFQMEptdnNnLzY4V3g0R2FhaEFzeUJrMW04U1ZjNksvYkIxeFJx?=
 =?utf-8?B?R0NjUUJ6R2FyYUZGMWdWRmxJU3p2UjlLZ1cvY0NyMEVRb2tyNkpnZTlMV0JX?=
 =?utf-8?B?NXRPb29Hd3R1MExmdnJ4Qkh4TUZpL2lwUGtIaVJzbmZSVXpaajc5WjZEaGZu?=
 =?utf-8?B?UHNGNkRzR3VEdkpHSE5xN3RkZ2dUNHlRc0RvOGU1SGJzN0lNVzdqbXN5MC95?=
 =?utf-8?B?V2lRM2t5Y3hNNjFqdXZPdnVKL3J1UlcwMW1qY3VMRTRFY2xEZjdydHM3dWFZ?=
 =?utf-8?B?VWVYc05aNUwvZzcvSmx6amJKaHphNzFiQzdSempjUk91M0YrdHpzSXpSQ1ph?=
 =?utf-8?B?dVVnRVdUT0lCZnovOUJjTmtyczB0bEQyS0MrK0tKU0FDdnB1UjZEanhSRHBT?=
 =?utf-8?B?RzJ5YXdacnVWcWorM2xMQWxESGlCUDNKT1BPTFk3Y25VbU1IamJucERFWW9U?=
 =?utf-8?B?K0JnS3JycHRnQnkrZXNwN0VwT0FkZlRIQXhweGYwaVBCTGxaYWhqMTAwK1F5?=
 =?utf-8?B?dDFjby9nMDRrSkpyeGxVTHZvNDJTc0JRWUpLSUd4bkZGK0NJa0xmQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464f431c-320c-4528-f03a-08da16ca408c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 06:05:15.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFmHkfRtQAxYtDNBCiWqmnsFSK4aYJNu/60Kvz+l7vDYq9y5CxPkXEks5NOsO6YM16ojzSEEFtpoSZijVLv+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3154
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/2022 11:27 AM, Takashi Iwai wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, 05 Apr 2022 05:26:07 +0200,
> Mohan Kumar wrote:
>> Tegra HDA Jack detection logic doesn't work when the HDACODEC
>> in runtime suspended state as unsol event won't be triggered
>> during D3 state. As pulseaudio server in userspace rely on the
>> jack mixer control status to show the audio devices in gui and
>> any display sink device hotplug event during D3 state will never
>> updates the jack status which will result in no audio device option
>> available in userspace settings.
>>
>> The possible option available to resolve this issue for multiple
>> tegra platforms is to use Jack polling method for every 5 seconds.
>> Also to make Jack detection work seamlessly the Jack worker thread
>> needs to run continuously after HDA sound card registered
>> irrespective of whether HDMI sink device connected or not, but the
>> Jack state update call happens only when Codec is not powered on.
>>
>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> Hmm, any reason not to use the standard jackpoll stuff that is already
> implemented in HD-audio controller side?  That is, doesn't the
> following oneliner work instead?
The reason is, the Jack poll thread implemented in hda_codec.c runs only 
when HDACODEC is in runtime resume state. But the problem trying resolve 
here is something opposite, bcaz when hdacodec is in runtime resume 
state unsol event would work but not during suspend state. So either 
need to make some changes on hda_codec.c specific to tegra or make it on 
tegra specific driver. So I went with second option.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
> --- a/sound/pci/hda/hda_tegra.c
> +++ b/sound/pci/hda/hda_tegra.c
> @@ -421,6 +421,7 @@ static int hda_tegra_create(struct snd_card *card,
>          chip->driver_type = driver_caps & 0xff;
>          chip->dev_index = 0;
>          INIT_LIST_HEAD(&chip->pcm_list);
> +       chip->jackpoll_interval = msecs_to_jiffies(5000);
>
>          chip->codec_probe_mask = -1;
>
