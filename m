Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD554551778
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiFTLcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiFTLcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:32:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0432D165B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UERSAt8F3MTa+tAXqaZl3y+aj5obK6Hwk66/toPEKxd0swgvvDTwH/wIEPxwqCj7pVS3ncACmmZ2Xuf+uZ24103ASjHrriJxe/TX9R4zBkHjHvnYBBoZDkNAOayVuHOtT5b9YSmv0QJ5HLKXw2SodI1V9cDVrWmyBMW9d26ebiEr6YX2Ol8IXsCRzTlAJj0BkdJrEafrWs2+pdlAu8uKvIDP7ZI7M95kzd0SjPA5c7q7R1+o7q6oqJjCKYI2duVqnnn9Bl6OXYt5muVcp+z82+f3btiJTRZyNaUYiywkZkLCRJJebcoswSTea8il4CZyR0qwo6rmLNrZ4q1bWxGyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYzYUmCxb7wF05EzBZQ5RJ04iyUgWzBZj/1F5rbxhek=;
 b=EhwNrigPhs66m3/1jvToBEtkTMWPdH11lMSy6nx3jgf3J2pIDWv+FsKPYBMpMHl8iU27NMDLzLohWc7T/+8uWaCBAXfPRiqj+TaCE2B7a6a089B9o0Qvlho/f4GU2zV1OKxWXwFZD5TJ8Rf9J+1rKfRqe6GudMRNSzA7BC41zHMTcMtokh0QJiZUVReHaSvEVrVrwghN9gdiPJAhhxuP4UFdzGeu8Ori6SDwQETHhziciJl30ExREWoqUkLgeIAGtgIn3nVvgdNwHtVEeOCeGqo6Ns28l3oCk3vXvRpSey6WvumRJwLnjdX1EF0UVDQ2/1UZ3Yqu7aQLFBVxpXyCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYzYUmCxb7wF05EzBZQ5RJ04iyUgWzBZj/1F5rbxhek=;
 b=3tB3pB98gwCsDrL5xejPj7mtwL2Kqpr+SgDK3L/fnuQAoWGh/eeMCRpBHliHf0WefcV2FjFT0qiw/NG8j4h2eWEDch4aVO7zI9zVPDxc5Zy/i4o2e550K/KF6CnfE8NSx6M3jcsrFm2DcgTVdPzlKR/z16CchNQnP+nIv8kJLIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1922.namprd12.prod.outlook.com (2603:10b6:404:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 11:32:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 11:32:13 +0000
Message-ID: <f1a52ddc-5aad-cc76-282e-93206ae43477@amd.com>
Date:   Mon, 20 Jun 2022 13:32:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Performance drop using deinterlace_vaapi on 5.19-rcX
Content-Language: en-US
To:     Thomas Voegtle <tv@lio96.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        amd-gfx@lists.freedesktop.org
References: <0249066a-2e95-c21d-d16a-fba08c633c0b@lio96.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <0249066a-2e95-c21d-d16a-fba08c633c0b@lio96.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0748.eurprd06.prod.outlook.com
 (2603:10a6:20b:487::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10b3391c-ad19-4ca4-def7-08da52b084e4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1922:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1922F571496DE2F8742DEDC483B09@BN6PR12MB1922.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRfi0bT3WwMNEYczfR0I8fQH79EHaII/cR0JHzYifyfZJq6p68/7K+K7L4HW17jY5Be4spD65Q6U5gsXwHLkQvrkuHoFCX9A7UTRLCNQ92HG7W7UwF4LvMR2lQO0oVgdJPUB/lVXkSx1Ftd64VVGUSv8u1qpsj2vkgKD8ADpPC4QVDIxTRhVZTarC7NjBCprotOcokWvOmdSyqUl4b3G2E9LH4QADnCq0pAtO/h1j2IGy/bjIBT02dqeTxm+S/8ZJznM8Ebut9q5/QBxhiv+YUVlQaMXteSg8LkpgRe/xmh08iA5X7nWkw/riJwvYXEMZnwHYEnf+pu+dueuXp9mmf9lMsGfuaIA/vDLiIigDxnlqrD2iiZ3hFUviGi3dPRVCyqy3MMVIuSlkHC7xmesb1Rxw8p3k9jRB/22E8Sqq3i+7beVWfZ+9uJlIndeozZHy7eMB4Iwdo+TKOCK+jQcHigg19OtqhUky4gGZBgAN39MVWhmA/zaaPSAEjPrSla/EgrNFVicRsMbVQFJklMKHhAFJACgBuSAuUdmoL0J0Lp91bbdS3q4wqdJt2MVmMt7JJflSPpmLxtprd9SroIGTlDVGpopRV0OiGW35Fbm0vQJH4yRSkwzwyYS9wm+WQp1HFADF329GHumuYMDLdV5wyS1KSsn6TUtfJVxrf9g9mT24HtsjUI6sqcdWnyqdHmyn+002GLZYkElVHjBCKmW7w1+XGzKbFQc8rZAGYaHIuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(66476007)(86362001)(66946007)(2616005)(83380400001)(66556008)(38100700002)(31696002)(2906002)(5660300002)(6512007)(498600001)(6506007)(8676002)(36756003)(8936002)(31686004)(6486002)(316002)(110136005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGp1YXVtMjRaV1FnTTEwcVprZTVJUU15L3hkdFo4RFpldTNaRTdyMnZmaERj?=
 =?utf-8?B?cS9GbnQxVi9abTlzekhRRVZiZTI4ZC9lVm5LdCtxTVQvalVOSWUwQ1ZtcDds?=
 =?utf-8?B?d3h6WlgwQzRPTGphSVRLTmhHRjZKd1JKOEY0MjRDOUt0bVp5RkdoN2JuV1NZ?=
 =?utf-8?B?WGlWVnNZSFNyZGZtTVB5bXlPV2NEalJQM0F0bFBacXh2S3o1TWhjcmovd1RT?=
 =?utf-8?B?dnpJVnhGbmFZbXpENjBpaXFQeGx2TXh5UDFrMWlxMjZLUHl4Si9vUGI5OGln?=
 =?utf-8?B?NXp1cThTekN6NVljOWZvaHF6bi90NVMwTWZ3Y0pRWnBLNTBBZEtaNTZiV1h3?=
 =?utf-8?B?THpmdElvaldSOFlSYmIySTFzT1diSmtsaHVLRklYR3hRbWw3bVBSTFlIa2hR?=
 =?utf-8?B?U0d3TkZBVWIxeE15bThjWGltUXdTclYrUmdpbVdseEJHc3Nqb3dMcEJXbDNJ?=
 =?utf-8?B?MTFHMkpmWlFkSmNZcEc2MmVWWTd3RjJwaXdVOHNLTndrdTZmV3JqOXFzNnRt?=
 =?utf-8?B?dnRvTVRSVTBiWTNZSEdQYTZsMk45ejZsd0FicVh2Tm9FRU8vRnB4c2cxd2Qr?=
 =?utf-8?B?QmRDQk1QUEk3N1B0MXpSQjdKektQMWFJTU9TWk1od003czlsN0Jhd0d6S1dV?=
 =?utf-8?B?clFSTHk4NUJxazBaM3lWUGdZeVp6aW83TmZ6MXBYMkpiUVJLRkphZllyUGZx?=
 =?utf-8?B?OVJkdlAzbmRVNTBZS1UwbEE2enBCTytwUE01SnBKVi8xMU93T0dIRnhKb3dI?=
 =?utf-8?B?dHZJcmljaG92eWNpdlhhTWE0NzNpWi83TkgrY2xkVEd3Zm85Ym82ckFBVllQ?=
 =?utf-8?B?NmRJZFNaNHFHZmxjcEp6dkMzNFZ3Njg5Y2lBTVc2aXlhUFdTa0p1elY2cTBn?=
 =?utf-8?B?V2Z0cmx1VVJ2VmRZTUtKK2FaS2xVZlRsdmhOZXBEdzZkK0xiMlV2RUVkaUJC?=
 =?utf-8?B?S2J3b21KcFZrRGo3SCtUSTVSMHhLTDlFUWpocjRJeUtiMk55UkNyMDJKSU5F?=
 =?utf-8?B?VG9SYksrS2hlU2pJMTN0T2VTcERJb0dIM09jblJ4dzJHYk5jNjZ5L3hJWFVo?=
 =?utf-8?B?SGsyOHlWaVNVVElQM0pLbXE2Mk92aHZYckt4ZG8yOVpZUjRDYUdVTFEwRGp0?=
 =?utf-8?B?WTVXa1Vhc25Va1RYR2FXaWdGa3Zsb3ZrRlNVeG90bXBhY2hoTmUvN0FQdHZ0?=
 =?utf-8?B?N0VlejQzeENYS2hVUXBVc25ZeHp2YkF6bVNMZ09TRlhrL0N0SUNIYTgrVnNr?=
 =?utf-8?B?alBtanlOQjQrSnFyRTBZUWNRQi80K0ZQZkg1SWxEZ2FENE50RXYzWFFZM3Bt?=
 =?utf-8?B?WXY1K1NaMHFhZlIxMmtaV3lsdXdZbmtyRXJ5eitVclEydEU1MnFZWG1zZVJH?=
 =?utf-8?B?SHJxV2drY3Zld01CT3dqb0hONldmSXF1R1BtUGlKbzF6V0grUjE5dmsxUDYr?=
 =?utf-8?B?OGptby9vYkU1YVZhMGdlNER5YXFaNEtNZVlDOUk1ZEhZWWp5QVBwalBROWhB?=
 =?utf-8?B?NWc5Rlk5cjRlMW1ZaWVkVk5xZ0lLcjRsd0lRS2g0cWJPeE5ic3V4YzlPTS9R?=
 =?utf-8?B?OTdHVVRHd2RLTzBoTTZ2SkRjUm9BMVhYc2k2c3V0ekVML2NjR0UxZUZNeFhh?=
 =?utf-8?B?WTVIRURFdmFBc2tRZWpObnM2T0FzYk9QMytrZzd5c1RrTU10YjlkelQ0aC9v?=
 =?utf-8?B?OXhrdmhhMHdTcDFZQ3RTaHpBOW5ZRU85b2xNM1hYYlhmM2FNa25idkRGT3ZT?=
 =?utf-8?B?djQvRE4xb2liZERUdTlUU2MyaElJNHU3cTBqY0wrU3oyUmFmRmVkVE8xRlJ6?=
 =?utf-8?B?ajJWT2hkSUN2cGNTM0sxTVloVXhSQUM1TThMdGQwMnFuQjN1TDFRelpwV2NP?=
 =?utf-8?B?RXZKWk5EQzg4bDQ5b3B6dnZXbnFpUUZoVUdmdFpTdlNIQ21ZbnJZQWFkcWxO?=
 =?utf-8?B?Z1hXakxjWlphV0srUkoyWWxrTnZWVitSL3A3bkQ1bGVTYlUxSnBTMnZsNUlO?=
 =?utf-8?B?L2hQK0ZRSVJLMXViNkJkMC9tNEFZaTRid1NJWnY4ZlFRbkdIVDd5SjdKR09u?=
 =?utf-8?B?TlZMSkhxeTJjNHFZOHhJa3J3M3g1M20vMUErWi9kVHo3TDZtdHgxZ2xGUzFL?=
 =?utf-8?B?NVYxNldjUHA2bk8rWnZiei9Ic3M5MmMyK24wbEl5TkZvb3ZRRHBUelFtOU12?=
 =?utf-8?B?d1d0T1hBOW8zVlRwQWlwTDhzN0FOaEplc2VtR0lHVnRLVzNORFZjbyt1SU1h?=
 =?utf-8?B?NFJ0c0JiampNb25Wd003NkhyQ2Rja2hkTVREZC9LY0pmdU9YOHdmazZwWkVy?=
 =?utf-8?B?VzAzMFE2eEw2WUhUMWlSaEx2SUc5clRTYm1meWY5Y0lFRWp6UDdhU2o4QWo1?=
 =?utf-8?Q?3aTfu/6g4F1Zxdf9WbHhON6qbQVuKQ3v3zTmIrXidL/16?=
X-MS-Exchange-AntiSpam-MessageData-1: Galge6P68ibRbg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b3391c-ad19-4ca4-def7-08da52b084e4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 11:32:13.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fzEKzPuSOUrJ//zI/qzHpJz3lqs1HEghzmtrjvwt2MI0i6MVC68ogscvvzYxXB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

[moving vger to bcc]

mhm, sounds like something isn't running in parallel any more.

We usually don't test the multimedia engines for this but we do test 
gfx+compute, so I'm really wondering what goes wrong here.

Could you run some tests for me? Additional to that I'm going to raise 
that issue with our multimedia guys later today.

Thanks for the info,
Christian.

Am 18.06.22 um 18:13 schrieb Thomas Voegtle:
>
> Hello,
>
> I noticed a performance drop encoding a mpeg file to a h264 video using
> the vaapi option deinterlace_vaapi on a Haswell i5-4570 with Linux
> 5.19-rc1.
>
> A 10 minute long video takes normally 41s to convert, now with 5.19-rc1
> it takes about 2m 36s.
>
> My ffmpeg line is:
> ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128
> -hwaccel_output_format vaapi -i test.vdr -vf 'deinterlace_vaapi' -c:v
> h264_vaapi
>
> Removing the option deinterlace_vaapi shows no difference in 
> performance between 5.18 and 5.19-rcX.
>
>
> I bisected this down to:
>
> commit 047a1b877ed48098bed71fcfb1d4891e1b54441d
> Author: Christian König <christian.koenig@amd.com>
> Date:   Tue Nov 23 09:33:07 2021 +0100
>
>     dma-buf & drm/amdgpu: remove dma_resv workaround
>
>
> and wasn't able to revert this one on top of 5.19-rcX.
>
> I tried the predecessor commit:
>
> commit 73511edf8b196e6f1ccda0fdf294ff57aa2dc9db (HEAD)
> Author: Christian König <christian.koenig@amd.com>
> Date:   Tue Nov 9 11:08:18 2021 +0100
>
>     dma-buf: specify usage while adding fences to dma_resv obj v7
>
> which is fine.
>
> Using ffmpeg 5.0.1 with libva 2.10.0 and intel vaapi driver 2.4.1
>
>
>  Best regards,
>
>     Thomas

