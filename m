Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4199B4656CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352774AbhLAUCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:02:04 -0500
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:48224
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232365AbhLAUBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:01:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/Dx25FSn4GQqlbni32t7AhqOC+V7zJpuKQxBJse7MHcWtdGizo7jblb3AwLRK4fqP17HqJ471+dbYhEMukvJFqB/UQXBTg67DsjYcUo8xbM6BgPuauEZxQTd4uU3BuWuFOQZ4gaYjIbUSOkxOVHkT7E3fzBTld16OA8QJoErhuBKeyWBNAptS7CfZIlOB24nqkqexNLOgU1oXSYZTGs0hj8A+DQYUZydWnTxYzt3R4cYTvPtc6X81eVZsEJGo8V+WZ/+QejZJ93f4LcRSJygCk6n75Jl6Cb+N56kbMbJnk0EocnY+EXx29G3KYIo+s14U8k7zT8P1DK/a95DlQgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPSIGk1LhiwVcVQmFAxaXoDaXvhBLgk5hlfUvmKDHnQ=;
 b=M2CYJnj03vUVWIOV3EMWKlVEatRpCqbO8bVIbdvrJmE1NUNO4Lq2SxCi2CbwGSuiFmhDwpdcV4v3j6r2/XbKQBOWGxlktF4ph18DyWHytqRXQ6ELxsBweDk62ss3aRYC46hcyo61pLafFvZPZ+W7qh2bEMqMyMMxigasydi9s1wB2bc4zKG6rRTemeltgU8mWyz+c1UJa786FJgPxqOm2Iy6TdjJhQCdwcvOdoc/E7K90r2TKejKcdbhqfEtOk2K5AOjHv/RS+eiTr94YB18P0CSVFdL6HgxPMP6dXy5zhBXK4tGMOHAOmzumC7Q3cqieh1UAe+jncY5obkvFl07CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPSIGk1LhiwVcVQmFAxaXoDaXvhBLgk5hlfUvmKDHnQ=;
 b=AyZ+IS9xsxaGPgdegTi9Bh9crKeDod9YC7RDjqZ8DoEsHM7X0aooBO2Z6gkdlICW4AZecRAW9reZjfSJE1Smk32QhtjCp2jHLPVaxpQ71dZt8PuHZSmuzofc2frthSdxfMHZUN9fC1y+D77IBXi5fNCMjjsuTrg4mPSRyymUK7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 19:57:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.020; Wed, 1 Dec 2021
 19:57:46 +0000
Subject: Re: [PATCH v1 0/4] Share common features between AMD SEV / TDX guest
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211201163430.2ncgynzns5t6gvof@black.fi.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <611026ac-0f15-0da4-aa97-e0412f1fcc78@amd.com>
Date:   Wed, 1 Dec 2021 13:57:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211201163430.2ncgynzns5t6gvof@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:208:e8::33) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by MN2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:208:e8::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 19:57:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9c4444b-39ee-4249-886e-08d9b504d858
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5391587B368D7DA6346F05E4EC689@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMLhqyV6F6A1eO2jbXNsTrGkkyLfXAKZJyCc2CqZz4gGI4B/B6MD2wdb8mT1JTeQBcFLz+SaGCeu/p5Qh7wSKdDIBxv2JEFfuQ4B+92+JKL/MseF9aTfpmCCW8bmUHQscaKX+u6F9yXb6eRotNWP0h6fa/TsCPl89zCHsAxHpSO2j3FoPUYiJOUFxJr7O+f6MzMxCm5AILmWqrLm5hVD1L+CRQBbIxD3DdY4kkXfGh0p4r9FOmDYtNC4EfM54zfvmHqVY9k9lzGz/2fYDB7E07HT9DU5/IqXooMUe+TW3U0+skOn4pz8f9HEEqem7jLKtREGersFPrYzqp2SzZRyiLHLfDHXGrD9K3X/XLtyRo5gadlYWteG+SPlSdIxTZIUWj+72TUZ+awfeN1SvbSe17+R2zmhAq921UmpugzsIP0bVuwZSjbFdOup+GuBtEEPCsK5EoL2Zn+ET9dZjI3MYe3kNQhPLZ+2VYJgE4YUCw6QXUppOfMoe5KqHXNaWsQNjhY/tK4S85auNkfe8rOdeFCq4p32/VqNIKIz1EAiiKVCR3J/R5AiL4WgsoOlUoYMmGvRGMZd5/5/JLSpr8n7fLOng59/2GVmOTkkREnsMVLdj6qXnpv3u5TY2y4WIsG1vW5FAi2Ke7sNaoeI2riOBVvD0MTXn5H8qyeCeubzHDjFW/EUXE3Ke/M6nBmNqY6337Rnh8ggN1ymolHOdIaD8qcXaYihMhDQDhCkl701Ep4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(31686004)(2616005)(8676002)(66946007)(66556008)(4744005)(186003)(8936002)(6486002)(66476007)(508600001)(26005)(7416002)(5660300002)(53546011)(38100700002)(54906003)(16576012)(2906002)(316002)(31696002)(86362001)(4326008)(36756003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmhBMzIrTFdqR2huZUVoanpKdGlBRlVuaHR0V1c0UXM2c0h0OFA0RGgrSHJt?=
 =?utf-8?B?L3lJdUxVa1A1cjdUOFA5OFNsNVZDWDlmRWRpUVJBRFg1elc3Kzk1dzJJYURL?=
 =?utf-8?B?d3paRk9SSkY4TkV6T2JzYzBhMjBXQ0JVZHZiWVVFbTQxNW1td1Q2MHFOTTg5?=
 =?utf-8?B?YmI3bjdEYmV0eHVZWXU3ZExXejd6cWUvSmRiTTlWdEhkY3BWbit1Sy9WaUMr?=
 =?utf-8?B?QjFZS0ZFTHhDMy9pcE54VzM4ell6UkFGQWpodHcvQTRYblZibERTVHUzWGxF?=
 =?utf-8?B?SHlwcW9HNmJyM250UlU1UHVydkc3L09EeE95OFZ0OUxnaC92Yklvckxuelhr?=
 =?utf-8?B?U2RuL2k5U1JKT1FobGdRTVozVEdrYStSQUw4V3Y3YTFXVVIxek9Eai83SnpO?=
 =?utf-8?B?THJOZjBEWWhCSHBFMHdQQ3d2OUVpY09td1VCdkRTZ0lCZk9zVTFxZGdHbnhD?=
 =?utf-8?B?MHZiMWUzc2pjdUdINzlhWUYzZXlpWUdBUSsrR1JFVXRzbDIzRy8zaTV6Nkcy?=
 =?utf-8?B?N08wbXVXdERNVHBOVEkzNVVpODZSOWUvYlV2V1JKcm9INXh1K1JkS2dqRUFp?=
 =?utf-8?B?MUIrQnhqaHFzNlc2SEIyWVgrbXZJaWdaT28yTjBQc21Id3Rwd2ZmejRqbDNx?=
 =?utf-8?B?QXp0YzBuSXdxcWZHd3hsUXVUb0ttUjI4SGU0K2NqOGh2aU1QVHAvN0FQZHRt?=
 =?utf-8?B?VloxZlFscjQxVkZoSUtSRjQzczdNR1pLeVFtcngwNFdQV3ZVYzVISlZYUHJP?=
 =?utf-8?B?RzFXNXNVd2dlazlmbTdROU5ja3pGU0pyemxKSDZuOGJOaGlIM2ZnWFZwQjR0?=
 =?utf-8?B?d2tTSmk1NXhBSkEyaktBYkVGTm5NVDlQYk04OTM0Y1A5SW5UZ2IrQ2VpNDVx?=
 =?utf-8?B?ZU1UTUNMNnRRZFBFYVRWcFRoZHNVMVdlV1RRMGYrRVN4UHltZlN2V25aVjVQ?=
 =?utf-8?B?bVJFeStyYTIyNUdhWUtIOGZqQlNBNlhZNmlIUDdjSnNUVllyMlFmVFJWZXZi?=
 =?utf-8?B?dGduelkycUYvZjFUMXE2RTZmN2I0c0U5UGVUR1R0NlhHZVJid1JHaUVRRjJ5?=
 =?utf-8?B?ZzEvSWo1TXp1S3B3WTZLVjdmdTNtUDlNS0tWRlpYM01GUGJ3ZzBJcDlKUUcy?=
 =?utf-8?B?cmFjdWdZb2Y1Y3E4NmxDUXYyaTFOTjVGNEd2VU1GVGxrK1JWZ3FiWlNmeFJM?=
 =?utf-8?B?Z3FJYjdSUTZyTXVlbytoZUJhOGZsS3d6c2JGNnNuME1rdDBlbjYxOTVlUGRQ?=
 =?utf-8?B?M1hUZkdvUkZSTHdtTE9EcXErcDFsYS9rK1VibERPQTN4UG9HS2tqTVM1RU9T?=
 =?utf-8?B?N1ozY1BvZWxkZGt5M0N6TVMvMUt3dEQ1N1lhcVQyWWdxbnlUYjd2Z21Qb3g2?=
 =?utf-8?B?VHlOMDE3Y04zY1pBQlZmT3pXbWhVTGNKREhySXZodVNobEZLc3B0eEJjaHhY?=
 =?utf-8?B?SEpuQWhueGcvV1ovOHZHR21ZcjcyR2FSaFBPS0dlQ3pKZXlRd3llZzNramlP?=
 =?utf-8?B?Z21ZTURNS0FsRk13R01IUSs2VkRBUDVQdGtlcFU2UzRiT1dVaVU1Mk4vSUxp?=
 =?utf-8?B?eEpmMWtnSC9TNTIzVkpFODl3N3Q0TC9vSWl1UVI2bDFGek92Z3VNMFE4ZExo?=
 =?utf-8?B?ZERmWG10dXpHWFM5QURZcFB0S2ZvZ3pPUktHZmxFQnJIUk5YdUM1eTZIb1pN?=
 =?utf-8?B?dzNZcGdyUnA3b3JJQTUvQjR4dENXR05zZVhKNVNLWS9FUFhsSkd4WC9UVHpp?=
 =?utf-8?B?cUJIcVF5aHFGNVFiM0RTdGNKSW9mN3BkTmxYcVlsRnRBWUZpQnpXdHhnaVdJ?=
 =?utf-8?B?VzFTQ1l0bFB1ekJGYU92QVFKM2JVOFRHZHNCM3FWaFB5R3VhbU5iN2FEZW0y?=
 =?utf-8?B?YXVaL3VIQjVJNU8yUzg1WFFIQWJtMkNxR0hMcEZCdUhEVlo5TkNGS1JyM0ZO?=
 =?utf-8?B?Z1RWNXdJcVU3blRuMEUyWTh5UDVLNDZ3WEFyT2VSbkR6ZTBPZGl1VmlyUElm?=
 =?utf-8?B?QnloSEZqRWpMeGdOejVxVVpibUsyZ0ZGNCt3TDNQM3hSL1pjbGZYWlArOG9j?=
 =?utf-8?B?UmNtNjh1WFNkcVY3b0Frcm51RktGNGg1bzlLbjFrbDg3TkFCdXVHa2xQcEt0?=
 =?utf-8?B?bmc1MzdIRXVOc2FCUStwalpmZ1ZlQlFDdjZpQi9nQndNK1NldUYxYi9SVFZ4?=
 =?utf-8?Q?IbvjYv3ciSXgVOYQF+1J8k8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c4444b-39ee-4249-886e-08d9b504d858
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 19:57:46.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1dIybn7lHqNsnGcpApFU1FsRV2JGurFvAhpGtiMRvkhYk99AfCIFyHE+Z4dho77fLb1fRs9XBmFOIDz1Qq2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 10:34 AM, Kirill A. Shutemov wrote:
> On Mon, Nov 15, 2021 at 04:45:24PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> Hi All,
>>
>> Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
>> hosts and some physical attacks. TDX has a lot of similarities to AMD SEV.
>> Features like encryption/decryption and string I/O unroll support can
>> be shared between these two technologies.
>>
>> This patch set adds infrastructure changes required to share the code
>> between AMD SEV and TDX.
> 
> Tom, Joerg, could you folks look at this? Your Ack would be very helpful.

I had a couple of comments on the patches, but they did build and test 
successfully with both SEV and SEV-ES guests.

Thanks,
Tom

> 
