Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464E8485AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbiAEVpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:45:18 -0500
Received: from mail-bn8nam08on2069.outbound.protection.outlook.com ([40.107.100.69]:58848
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235053AbiAEVpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:45:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Shoa8OYMu85lJphVO/X25VcDRn04yBfHSz0KbIO1zxxMOEoEWuqm19bRUqSpFa5PINNw0CFeUA7N+u63Nqs/aUhzjhvrmfRHavkDzfmg9NKBT+3BVxbFfRp7TK69P0VPe80p6V+evvA3+4AbXAnp2xqPejH2v+cNOTrFj9fqiHUjGcfk7YiTG8JIdKNbjIV9YmbOJTkc8RmG/mpmDG1XX7UcNPNWLf2HlThl7XbBXDW9nQ20p+Ssou9k1mNFOoIji2iYm2jKdcuO8Ox/PDNeVvBL8U0n73T7P3QzBWE249MUCkGLJNuP3yRgfVPwgaKXXIeMNlL7y1nWgemY7u8Ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g31Gfcu8A2DfdXBgaqhmkPT8kMTVac1Ds9ftRX4Xpc=;
 b=AcVBS6JuEGBHVuXOc6y+0nV10zdZbcdz4yEUBdRXvQcBWRTopwIWRoBoPSe/6LR7DQphg9w8kyyuEia1EOcYNyR4wfqhtElt5f1AGBmLaAHXhBmMxozonR8K/OYVpyN56W5VRyIbRG7dn22cgaeK0dntCJwK2ev3wzXesJa4wvvfPmN6Ik0XhhImx65SOXvsbU7QAb6t//mYe0XDrzQp8oUB36m/yN3Tb9TDCsoCx1Tl+SoJcGxlXuvzReUIvQSpM79F1iCZNCQTMsyd05LsOScvv1+S6QM2De6VFZrbXmSCARTPcr0pifUmIk9l2dFvCIP5IpvUPz+4oxLj6mFi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sladewatkins.com; dmarc=pass action=none
 header.from=sladewatkins.com; dkim=pass header.d=sladewatkins.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g31Gfcu8A2DfdXBgaqhmkPT8kMTVac1Ds9ftRX4Xpc=;
 b=lABr6J7rX3lOUtDmb8Ve3XZWc9RHy+K+fNijpFKuOGUShriiCNVAkoRnkvW00i5yyWEnln7P48Hwe+JND0huv46zBE2HAOsG3GJ+6rMx8i8wWf39wiZFUVp/v5AzwICSgDqzNGMVRwCKWgQn2//F+O4yWH1ZUN0lFtmSXw03F9fFCwL8hpDp5lcA0cu12phC/NA7us13OWaKRpXVVjhyc/QPYl9wPeA0i74RKHM1HtrUrTqO8+OydvWMlHtdg8OYmukSFKpLCtcm2lqOWDuO9/sjrHl7adl3HmnMGhWEpjlZ0ePCnNDLC8xS9ZPbleQQ8pcRb+Fvtnqi9ofkqVC6Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sladewatkins.com;
Received: from DM6PR20MB3097.namprd20.prod.outlook.com (2603:10b6:5:1d0::23)
 by DM5PR2001MB1834.namprd20.prod.outlook.com (2603:10b6:4:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 21:45:09 +0000
Received: from DM6PR20MB3097.namprd20.prod.outlook.com
 ([fe80::1426:7c36:a8f8:5a11]) by DM6PR20MB3097.namprd20.prod.outlook.com
 ([fe80::1426:7c36:a8f8:5a11%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 21:45:09 +0000
Message-ID: <36e53115-e9bb-f96a-ce64-dbb504f1c97d@sladewatkins.com>
Date:   Wed, 5 Jan 2022 16:45:07 -0500
User-Agent: Thunderbird
Subject: Re: INFO: trying to register non-static key in hci_uart_tx_wakeup
Content-Language: en-US
To:     kvartet <xyru1999@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, sunhao.th@gmail.com
References: <CAFkrUsjA1qai+1ysWS_LEUYcMGo+ZRF3v743q6k9e4roF6PWZw@mail.gmail.com>
 <6338e7cd-80cb-11af-e3c0-edd740bb9e49@gmail.com>
 <CAFkrUsgEJcMAdVUP3aUB7-H4YmUjFeii5754nPpOVh+vo3bnLA@mail.gmail.com>
From:   Slade Watkins <slade@sladewatkins.com>
In-Reply-To: <CAFkrUsgEJcMAdVUP3aUB7-H4YmUjFeii5754nPpOVh+vo3bnLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0008.namprd15.prod.outlook.com
 (2603:10b6:207:17::21) To DM6PR20MB3097.namprd20.prod.outlook.com
 (2603:10b6:5:1d0::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad3bb1a1-c519-4138-2250-08d9d094a4f8
X-MS-TrafficTypeDiagnostic: DM5PR2001MB1834:EE_
X-Microsoft-Antispam-PRVS: <DM5PR2001MB1834ACD55D8F1311BD514DFEC84B9@DM5PR2001MB1834.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk1n/6cjTVFoXbiERiCtRqQhUlX8SGXr235bMsucZZ5FBEdISoOFjeExqUQhWThBPiqT6exDpNQTBAE3wxnkYSjxlrSG7NnbvF3VVX+7ZaiGyD69L1dr+kGUJ8rrz0XqPHg6jP4AnJ8OldyKepJ02A9QiQkuvJN1iyJBkD3FSSgT7rokcEZ/sIDf3W3TySOWf/Vea2H/VEpuLSTcihSi7D6p0dnfqXTvvzy5XdqO1yQBRGGOBKC7RtqylB0W1ut46bhjIkgCin+XnYRlPVLVbPJxoswRiBX/ykWXM34SU7qlOD3Ch1orMnpjj/JNXm6xT15EkotBMCdhQ6oWuofmfkNMat5S4eVIWt/0sT1JjQBQxnHKAH+SHfsnP4peBnsDeQrwNLag5UJWKLH2WLCQKVL/atEIO3U3/Z3q+rDGte8v55kVFpmI+JgYFbUZlolO74lpJs+/jZ2XNlIUBjBOEA8bcPzRiIlTvR0W9PkQI7MEFxEQHdGBdjvZhHH7xKMePtDoH7EZ7a3+WUGndqOe56+/DpVen7c4KZ2N4fdvCLe0gXdBXJdk2VSDNSnFUcaD5TSCl3mqvxPT8wggmVXTGmmC0wEbpBpCu97xtEkf7Iq8cho7IepEKo0vpGopuJXjEizRQoxmPzsoy6XYQkEJQmSRke5ORreXRjvAWDIOEZLbSynPHueK7ZMptKKz3qJ5TeurZfsTxH5WB5RP2ZUqU4G0JrXFAMNPdjUgwbIEvdnRZ+N27kdGQElBaYiy03y2v7PwrVov8OXJ1Ym2Pgv1cDZZ2PLfUbvfVqrVx4xzKLtLAWhVoA4A5ifeys7LxR6Lu704jlWas6Jc38IL7H19Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR20MB3097.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(136003)(376002)(346002)(366004)(8936002)(8676002)(36756003)(6916009)(966005)(508600001)(31696002)(5660300002)(4326008)(66574015)(31686004)(2906002)(66476007)(38100700002)(83380400001)(4744005)(66946007)(26005)(186003)(66556008)(53546011)(6506007)(86362001)(6512007)(6486002)(2616005)(316002)(10126625002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9pR1NoaHVEVEV4OTRwUGIyS2NKSE1sNXZWNTFyQldpM2Y2U0dGSi9XOFgz?=
 =?utf-8?B?bDg3VVR4N1V0cTNDRWhBOGM2NTRYbjdwYXk3YVJ0Z3dqWU1LNnoySWJCMnZs?=
 =?utf-8?B?aUttVnlwc21IUTVPVHluTldhNWx0MWR0dy92d0xsdHRNWGorb1RPMVZEVFJ6?=
 =?utf-8?B?T25sZkN1aUhjWkdEeFFaRnoxcHY1aUZaYjgyZUtsS01uWTNkaGpkeDJmek00?=
 =?utf-8?B?RWVDSlJHWVdDMW9yaTNKVnRNSnBCRXkwbG5LbFRrQlJPMEV4Q01BVlU3VDBn?=
 =?utf-8?B?Ni91WHAzZFFjbVZuMFZLVnJoSEFpRk9jc0E5THRjN0swRHVLNGY1SDViNFZI?=
 =?utf-8?B?M1dXL3Z0UFE4ZS92MEt6UkJpMmRsaGo5dTFhSTFzM3AxcVB3cTRDWXBMcjVp?=
 =?utf-8?B?SE82b3MzcURTaHFoUkdkcjFFQzlrK2JJQ09oaFVDUnlscU0wRUVRcTR3Z3cr?=
 =?utf-8?B?RjNkQ0tsZnpGQ0JMaUtpZHJQQzl0MGxXTklMY3dPUVR6VHJaR3FCNjJBZVZy?=
 =?utf-8?B?OXEwaUZXZ3dScHk4MER2c2dVYU1IWnF4NFFFMElLVWNvY0txVTF5ekdEZUgr?=
 =?utf-8?B?OUhUWDFFN2dwRUhFVmJSWG9rUjgwdFFYV3ZUSXZNbzlvcUNHNXduZUlBQWJE?=
 =?utf-8?B?RGx5L3A0QXlGMzRKYVN3dWZpTFNnTk5QRVdoRW9ETTYwYlJPMEhUc3NwMDhM?=
 =?utf-8?B?elBhTHdLZDQwZ2dackVYTmV2MWd6K0p4dWVnYkE0VjlIRGtFcVJRWnlMdllo?=
 =?utf-8?B?MTNaaGM1VTBBOFpWNGVYYXVnalg4OG43NWI5TTEyM01GemUvMkRLNGlpQ3U5?=
 =?utf-8?B?encwVXM2bkoxeU9FdTNmdWZET2tlcEtCbVdUU0MvOGRPVXF0TGFpb2c3bVZE?=
 =?utf-8?B?NmlqMHNnMU56UThkNHV6Qm5hbE0zM0YyUmEzRjNBY1p2THYyWGJabzJHaUlY?=
 =?utf-8?B?UXVvYktwbVdFYTE2ek1XTFgrbG80MkNNZnlCNjRrYWtNS216VktuMUVvS0J0?=
 =?utf-8?B?OWQxS0N6UDViU1RTRElTdGo0SGF6Rzg5U0lrbmJSVFdEMTYrNHhRRW1OTkdt?=
 =?utf-8?B?WFpjMGE3MjBKcFJIcFBrTlBGUWdvQWljR3VXQkVzYjNPNThVSDBoV2t5YWxZ?=
 =?utf-8?B?eUhyOUxybFJWamZTYWJldDloQk4vV21SQjlFZkJxdmlXR01UblI5bE44cVdP?=
 =?utf-8?B?Zk5wSkI1eUs4QlNTTXp1bjRETCtzNEdkMzhET1o2RTFHMnZIUTMxTTVIdlN0?=
 =?utf-8?B?NWpMcDgxcmFnY2NKdE5nM0tKblBOVUNaNXVMbmozeE44VE5zSVRSOSt4cWZ5?=
 =?utf-8?B?alR4YjJQN1ZsOTdieCs0YWdXc29SMUZ4YTI2TDcwM3NuQkprQXN3anVMZ0E0?=
 =?utf-8?B?ZTlsY0JDaTBiTDhDNlJ4djBIc2NqSzZ6SDFxdGxNOEl3OEN0SnBjaHEyTGhm?=
 =?utf-8?B?T3NUdEhzdUJpaUk1VmV1RXU1TFlQK21TTndNS1ZoRTA5T1VtMktoSm5hbjBS?=
 =?utf-8?B?WDlpc3h1a3ltZWVmc1hyZ3hZVkNNSjJ6VklOK1JteDIydE9Yb2FkVWNWNzdN?=
 =?utf-8?B?N21mTU9SSFZUalZvSHB5L1dVYjV2b1YrVFlBM1VhcjA0djdLcy9hbVdFaGxv?=
 =?utf-8?B?Vk9UdVJXM2t0OXZSZE9EM0l4am81VkUyeVRQcmV3SGpvaC83cm5OQzVNMWFh?=
 =?utf-8?B?YWJPTnlDSmNBR2FEeDNqemc1eHNVUmt6V0hkekpuYW5lSG5FNnZoV0l1dlgy?=
 =?utf-8?B?Q2pCY0dTNlljRTdnZml3ZWNBanF2bnYzak5sUUFrV0NhYVRxdVZqWUFIbXov?=
 =?utf-8?B?M2VnL05MdDdSUTJGTGNubVg0czVhVWdSRTBXOWVkQkFjU3NvSGNWdDBXOTRx?=
 =?utf-8?B?aHBlZ2llRGRucThCcEdpUnBsK0pQS0pnQTRadlFjYnRWdnRzdkg3SWpEVXI3?=
 =?utf-8?B?bEwydFN4aFVBTWg3SWVIVVMrRVVPQWRQNG10SDYwNm96UDd1SE9acEh3TXFP?=
 =?utf-8?B?NXhhejNhVHBOM2tKNzBVbjZNbm5nNFFFVmMvTXFNOXN3M3JtcE42b0Q1dWJT?=
 =?utf-8?B?UG5xN2tjaXFiTEdhdk8zSm5QaTFSd1lzTXc5SnV0Nm1HWUFhdEw2UkRzV29R?=
 =?utf-8?B?THFLek1ZNFBWWktncU8zU1hxWTN1SWh0N0NlK1pmMWxhKzhLVjZvS09HMTVZ?=
 =?utf-8?Q?dmHQ9FuZLp1V0Rn8oOY5HAg=3D?=
X-OriginatorOrg: sladewatkins.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3bb1a1-c519-4138-2250-08d9d094a4f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR20MB3097.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 21:45:09.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 369a2136-99b5-49ad-839a-ceafa92bc824
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVSGl7NBV63+0AOG1OUUcKgz1NyFxJM1TsoueBdVogKMe1MJHbbiIo9pq4gXziwVVcCst+wnlegppX46GXCn+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2001MB1834
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/2022 9:34 AM, kvartet wrote:
> We are so sorry for that. You can try the following websites, which
> can be accessed without registration.
> 
> console output: https://paste.ubuntu.com/p/Bfpr8Gxtd4/
> kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/
> 
> Sorry again and look forward to your reply!

any particular reason Pastebin[1] can't be used?

[1] https://pastebin.com/

best,
slade
