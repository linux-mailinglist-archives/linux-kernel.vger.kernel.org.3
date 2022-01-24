Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FFE4981B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiAXOFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:05:42 -0500
Received: from mail-dm6nam08on2076.outbound.protection.outlook.com ([40.107.102.76]:38241
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238491AbiAXOFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:05:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JByyQKVcbeUvWGPyCargaijV12Q4IzAQByeH3e+c6XtwB/76NTiwBQ6zu427xdqimzT/XrubN7XEhIAXlM9P/xJSMldRzc2U6Yu+jyeiOunX0LowwqLh/rw4oLSHAj4do8JSoOvzImh21TQxcQD/t2xCaNoRfae8SEExbcv/2W6MIZ85nFaUgXSwlYwcJ/oazLdZ06C8Lg9gn6UgS928IajPAcGQv7VhSTAAWVIcdHS9nEviL9l0d87rlCmCrm39Oz6o4YjKeoonS3Mof5Nuno4GozYBrfCpRuxYpJ3gd6YPp5VO32gGDGNfYkSZl/l8t9jgydPpOYEq/5PNkOVoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBRbt1WLtOzLrZg86Rg1sNK7TJPcP2DmGscXXBigB/I=;
 b=iY7b3+wInQVAIGJzqL0LnYVLCZf2HjhGuZST3mhrUTNnnzEdQfgMFrpnk9WRAkZ7f1LzGkDEdEPzbsB/lJNz7EHU7cz4vFOrJwWoc4Z7jgwXr4ITUpjiyspmZDw3XEOauctOFDczaHmVXWxJg6hB7F5duR0a40F5/8pibECUTxSSF3ZxOeqeUhd6dkcGhO9/MfevDcb5HXMGtQcEOiZt3GTYeiJZ+rWFQqHa8m7uRGAl1oDqwJ+VvHJDekVZ5yqPyzZ1S5qrJcNWEKmbSq6Mh7C3Qd9R3VtmeTbejGQebv6lfddYha+mvNbOMHdI6JQzxVGM+CnT4dqoIq0X/iwzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBRbt1WLtOzLrZg86Rg1sNK7TJPcP2DmGscXXBigB/I=;
 b=lkZRAzK8Cs+QDJKtgzs/fN0c1OAqtX/HAWng9oCWSQ5sfMHw/t/qCIoARX9HZ6EjtqNBNxMXxMs2ExHVIO/s/UuT4Otf/Qz0RTh9d4gd4tHGhCdkrDz7AZKynFxCFqisk0x49ccyR0BOwWS+EHiHtcukw2QQgJyHAb0odtvAEN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Mon, 24 Jan 2022 14:05:34 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::340f:bd1d:17e7:ace6]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::340f:bd1d:17e7:ace6%3]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 14:05:34 +0000
Message-ID: <a3a86e84-b5d3-3a21-cb3f-c3f809cfdf83@amd.com>
Date:   Mon, 24 Jan 2022 09:05:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: linux-next: Fixes tag needs some work in the amdgpu tree
Content-Language: en-CA
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220123164116.5fd89414@canb.auug.org.au>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220123164116.5fd89414@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8555ef0-b297-4893-db70-08d9df4296e3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4475:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB447592B3CA5BC8F3F37FD56E995E9@MW3PR12MB4475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mURngNqURQUOLGpbmz6FEjXpGmQNa2Mq1UWCyHZM0jYJOxWk+TMdfYB/GTKMBKp419I2iezKSdhu/HtMecv041ga4H+J1Ux8esY9SBGBSi2mFYsv2OTBCCHJ3GIf8mgHsntbR/TOxPSOpcSgVInx3HgKijNjeb3FSnhwcwV5pMLhcyfesljFYKAImz/r/o/XEZIhtV1UMoThlHC5pY+9OKxk3HgP/iQy0Va9/CdV+tqtVOTd/X7N427+ELUKeW9lIZYALUzfsWOCZg3TJyjND55iaPBSARZKQIvWjf8gWFcnXqenRlmgqg0wkegc1Z6n5ovkaJX4I501HbrR4KRAZ/FSlZ9DLz0061lNgZOC/t9AUbG2weOzORyXIxyEb3062OzFyJRO469UPJDRfkWWUY3KEgdk9WLhvhrKr4TULu7AmE2kUiPM6o6VpHAbxsGB07V3u1mmTSvKTL5UbnxkeQ+9gOPbSXjgh+bN5IIF030JTM8NWIZCwyN8+GhPfK9Zc/G3gKPwutgzqVmxDwF6/t5RSV7gkf9zjzD2q4E+W6puaj/tvm26uI6cCNzd7N5u1vi6WOl6mAKByNHLkevaSFZTabjMcwdIA8NUJhP19TatN5uH2bYwPcVksvBoE4R/rP4R5NAPRhLy8tFOg4k1tglCQaEkSrBaZGJECXqBRoAtu354lvod+CVIvvktlVwG7B/j2XuUBZRqs9p/FTyamH/Qvh9EojhwJQ/5q1LOkns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(186003)(4326008)(8676002)(110136005)(6486002)(66946007)(66556008)(66476007)(316002)(6512007)(86362001)(2906002)(44832011)(508600001)(54906003)(36756003)(53546011)(6506007)(6666004)(4744005)(5660300002)(26005)(38100700002)(31686004)(8936002)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURTamtMWUFUQlljNERkb3gwZkhiRittNnlUQkxKdzdES1E5WkNMUGJBck5i?=
 =?utf-8?B?bmhYS2FzSGQrUzFBMlQ1eWlzeHQ5blJVOVZVcFhNbWF3S3ljK0lWRmZMZXlH?=
 =?utf-8?B?NkJ1clBJeStiMmh0TVlLT2FSN2c5b0ViTDdKQkpja3RyeXlmUmZDYUNhTENx?=
 =?utf-8?B?MjljUXRYYmZvUGgrbXE4RkQ3MGtPNnFLVXVpN1cvNEIwTVo3Y1dpVkhKdGJD?=
 =?utf-8?B?VGtTT0t2b2hJTFpMMHVJRnpHQWZNRU1kY2p2S0FWeWhOd3F5UFJnL3I5d2NC?=
 =?utf-8?B?V3VDaW1zOVJnNXNrKy80Q3dCWDRiZ3BhYW5PU0tObTZNZTZ5YW94eEo0S2d5?=
 =?utf-8?B?cnU3bncwL0ltM2swam1wMXovMkxnMUxWaDloMlVlZG9hVWFQOFdLWU0vam04?=
 =?utf-8?B?VEZMVStDZjVwRHhzTEloU0NCZWJ5VktBS2hMZWpyeWtFN2hXY3FETkpIVEtB?=
 =?utf-8?B?eG84aTMyblhQbzVqa3ErR09iRUxsYVNmN2prQ2E2U0w2eGs0ZjJPaGpVKzlX?=
 =?utf-8?B?WmtuRmg4SXdoYUEvalpXK0R4MkdNeFZsNGVXSU1zWVNwMjNwSUc5aU41RDBp?=
 =?utf-8?B?d1hFMkhpdWJIWmJmNWxEcDNWSmlFODFUZ2FROU9qeCtBNmRDL2g3S05Edjhj?=
 =?utf-8?B?d3FOZ3NwTTczT0RQREh0a0w4SWFiSmhlQUI1bGRTYjlUeGR6b1htY2pYSmtq?=
 =?utf-8?B?anpzK2VxU1dINXFIWkI5cGswRGJucENROTRoL1lpMExGbk9acWlXVDZvMEVl?=
 =?utf-8?B?dTdIRmc1ajMwRHVCbldXdnRDODFOMTBUYVdjeXBKYXp6K3NRR1M5RTQreThz?=
 =?utf-8?B?eENsQmtTeUZySHdzM1p1ZVBqUTFSaytsRHloY0dlVUk4SitjSnErclpIT29u?=
 =?utf-8?B?SVVqMlBNSXVLbnJuTVl6djFtL1ZTeTAvcFV4ZnBySGkwV3Avd3EzcTUxRzBw?=
 =?utf-8?B?Zithem5BQ2ZvQ1lZZWExNmd1cXlObTZyUnNYWlJIbzkrc29od2RGTzlLVlNy?=
 =?utf-8?B?YnRyTmg5RFlhekVlLzIwS1pjQ0JmL0RIV3NhSW9PejFTbW9VRDlkNkNPMDJa?=
 =?utf-8?B?MXlOK2IvWmtVakdlcm84NTUxOUhtTkc4dUZJdG45bmZ2NTVVYzhuV2RpeEI5?=
 =?utf-8?B?aEo1bnV6RFFET1R2K1hoRnZMaTY1ZmthQnByQUlvMFJBQjIzU0VyWUNpTHRT?=
 =?utf-8?B?SWNKWEYrTlNkTHRnSnZtWmFDRnR2cENSWTJjSjlFUUdvYW5VSHRLZGRoeVk2?=
 =?utf-8?B?ajVBazVpZUp3V3MwN012ZlAvazM0NmpIcWVSRk5xKzVpMlVCdTN6ZTBzRWNv?=
 =?utf-8?B?Q0RkYlVldjNVVElkOFVaazc3cHdtUTQ1Qzg2cHJoWGpHS0ZpNVc4MlU1T0M2?=
 =?utf-8?B?UE5ESGpkR3hCWUlkMGxncWRldjloWkkrV1prNC9hSnBTenZmNlpjS1FHMnpm?=
 =?utf-8?B?Z0hVMlFLMDlHSGtURXhuM1RzbVArZUhaWEw4Y1NyVk5lL1R4ZHlldXRJMmFj?=
 =?utf-8?B?eXRvMWZpYml3ZXRKVVdxM2wzeHRPSlBhU3psVElCRTY4bkRxaUVqa1ZOME52?=
 =?utf-8?B?RSt3MmllK3UrS2VQMHhLL0Y0VERubWpIQVM1VGhvZm1MVlcwYjZFQnlLTWlS?=
 =?utf-8?B?Vi8yUmQ4S0daWDhnTkFlaGZtSEVwOWJGdHlobHNmYmdjb0RBWlkwdmtKR1pa?=
 =?utf-8?B?MklaVE9rYjFqdHA0eHVZTm5RdjBMSjJuUmllL0tOdmdBWmdtWnNFTG5hTGZ2?=
 =?utf-8?B?MzdrK25Ib2pmSDI3Tm8zQjQ1a0dIbU9xejZLUDZIUTRBejR2cTVYekxUTHMv?=
 =?utf-8?B?Q3VHUVNtMitXVkhURE95QmhSbU9RL1BjYnNlUXhibDVrQUNMblROc2JvZVlT?=
 =?utf-8?B?VGRTYWszMTd1L0VEZWdpc3NjWlEzS2ZobSsvb1VGS0NLK1QvWi9OTGFxQ0ZX?=
 =?utf-8?B?R0JjaFRNckhFQTloamVSbitBT3FST05teVozQ0pna1JnNTNhUjNRNDFPeVhF?=
 =?utf-8?B?ZmtkZ3FjMkR6VXBOVSs2QVhIRnVjQVR6OVdtbnl3REI2cDZGYTVTaDNreExo?=
 =?utf-8?B?RWs5NWVXaStCWXA5SWlZbm9WbkJpWHUyYVlOVERpMXdOSGpCMG9SVDdQN3RY?=
 =?utf-8?Q?2SCU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8555ef0-b297-4893-db70-08d9df4296e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 14:05:34.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkU0XY4GbOcnKO1Obt4dWkgG3L9dbukO+AoNwBG2GSKU6lEWiwsBTbZwew2c+cre
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

In our local tree the SHA1 for the commit which is being fixed is still 824c2051039dfc.

Perhaps there was a cherry-pick or some kind of rewrite or something.

Regards,
Luben

On 2022-01-23 00:41, Stephen Rothwell wrote:
> Hi all,
>
> In commit
>
>   47b6584b9f43 ("drm/amdgpu: Fix kernel compilation; style")
>
> Fixes tag
>
>   Fixes: 824c2051039dfc ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: eadabcc2bc6c ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")
>

Regards,
-- 
Luben

