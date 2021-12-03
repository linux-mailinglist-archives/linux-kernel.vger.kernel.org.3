Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D2E467D17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382511AbhLCSUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:20:42 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:33889
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1382508AbhLCSUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:20:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EROR+Isb8fhTbyAGATt6nuHZKF1mGEb2EBGpOqAq1jwE+jEosTzSjD0II+flZg1FMz/Pv5OX2RO2LtYI4rvNZhMjWwvtz6NTspUhLeyGJIiags/fA70jFi+puhNdRYq8ikbwybBfPoli0wa2T7i0PjvxG4p9TFmDdospex+jQcQz4UqLOJZ74F8cP4EA35jFWIp7D0Y8aF8ivGJ+91tHXrA4CElAmguH19NqaQTzxxIOgbnlfK9xSScmMov48OC+UidRYHiHoCZDNiTEq1jonhP7dcTCF9Os6DiqS87/8OPOCi8A9lpeAYnTVhtn5F535xGeGyeUPMb72X9N37rpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpIk5FAmXMkMAI5D0Y/qTET6d7B2hhnwV8FJKbSFOmI=;
 b=TAEOUv8hFylRytTpyCZjmWLDmwmeammcuR5hYrP1h3plD8ZL+kn2ISYDijdXDvfBhO4g6FmkQYkZs8SvUJLjrvUsX4B+yFh8nV+aYB/baa28PEbGQAreur26Lxqpcse5PhsLSefglg2xdoGzJonL4KprXH1CeWCG2gNcQnYnEsxSBJ1uomcubQ7CVT0dOdFRN74tbGcw9Iyr9VQB1WcD1NgVFAQjHIkbxzhkosa7349y6APs5kdaDMxTpF6nzCXt0EV7nlo7uq2NlmmWfPPKTNKFA7oRBF1RFChlCuogZmuaZuehEuD1QRJjX14uv4IOdN76TxPCLJU7UtQ9CaW8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpIk5FAmXMkMAI5D0Y/qTET6d7B2hhnwV8FJKbSFOmI=;
 b=BFTBzzhdn8QBj49V2ndw7dnNINR+4LtYg5CcoBVBT59p0DTlpwHX6OTCH5bfEUQmZNvxxhWraoPkWU12KuGiGWtTeeSQdny8qggdXapCqm8DGK8tOU7YJ7OH0C2vFYJ9iBB4lKz21B7gPsilhExmZrb7xH60qvTKQeF0uBPrNAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 18:17:13 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 18:17:13 +0000
Subject: Re: [PATCHv2 0/3] Share common features between AMD SEV / TDX guest
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, jroedel@suse.de
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, hpa@zytor.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, tony.luck@intel.com
References: <20211203132340.41741-1-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b3faf544-00eb-bcdf-33af-286c7af262b2@amd.com>
Date:   Fri, 3 Dec 2021 12:17:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20211203132340.41741-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:806:127::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN7PR04CA0216.namprd04.prod.outlook.com (2603:10b6:806:127::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 18:17:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b10c5465-1f8e-4fb3-9fa0-08d9b689215d
X-MS-TrafficTypeDiagnostic: DM8PR12MB5461:
X-Microsoft-Antispam-PRVS: <DM8PR12MB546158AE6383846F1621607BEC6A9@DM8PR12MB5461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgFhVd0kJZSV/+njDNvqJ3bpBgKpIgPIKn0pOn4JMjhfn9RfNJ9OPTKS982zMpnom+05mGTHF5/45rgY0qbN79ave2U/rxatkm1CM+qykR7dlo1ex491PLp0jXnY4e6jj3SVuoHXBhu51U1WcUW22hoDavYdlTDj+9WMrQl3xAVvyLJfOz3PNrOOseA+iSF2lCavcXJM0+Xe2mYWjEbw/psDYSiSS8pjo8wjK0JoJe4G05DCwJSnLkz07p+fDAFuDsMdzJPkQDl2gC9rgWOCxtYF2hMyPm/1oX6OMfi9RY0BsyPNI4UMgjUBEvt9rH9YGONUdKQCS7Ipp72j/RbQjshx3Q73Peor+3YU5nAO0FUhYKJB7YA/t1wxgjUwieMJ58jtDYG3tR9EFpsQA22J50VSlgxyOli5iD+MrKuVibV0QDhJtXrL34HqoOBfkGWWUbTLVWn4D/Al7jQXQu1sIfvBj95GOGjKpQeLq10CpRV5CU/3W2zo7PhclnbauJOGqdP6VkwNRrqXG7NEvTwfRfm94cmTRd/ZvBgtmdd40HFW6hJZaIMmiyBAElwrFUdON3AJbj+sLE+kTxrUSQKgzr/+D9XzPg23ZXh2jvnP+9xxHRIhKt2OHwkIvrf0EqeSYoVqQzWDF/MD2OO64UJ8Zn3Htyc6T5srZpaKlRBc9K5NEqQkCDu88q0qa0FtTGKX7sAS/Dbqhq67Zh99Ppcs15L1qBdRKCsRwvNY32DBJIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(31686004)(6512007)(5660300002)(38100700002)(8936002)(6506007)(8676002)(508600001)(66946007)(86362001)(4326008)(2906002)(53546011)(26005)(36756003)(6486002)(66556008)(2616005)(66476007)(83380400001)(956004)(316002)(31696002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhYSkUvQ0JxZHR5aGJRZWRVbmZlOFJZNGZ1OEd3QUtqdEREelN6enNKTS9j?=
 =?utf-8?B?UG5WQU82Zk5LekY3Z2hnWlVHcjRxeW1LVE1mNXhvZldnd3A5WVBBdnBNVitn?=
 =?utf-8?B?eGhyNGpkVlBEQ1ZkVHl1U3dHYUZNYVQ2MitDYi93WE56ZG5kem9RMGRhZFJt?=
 =?utf-8?B?OVZsWkV5ZXpYNTlWcEt5WEpTRzFQdmQ3TGZvNWNMRXBXKzRGTWltTHRiL0hI?=
 =?utf-8?B?TDNxeWF3ZkNZOG1qRUZBQjhqMjdVYlFBa3hhakZlWTRoc0YvN3hZbGhrQXlm?=
 =?utf-8?B?bGZmY21Wa3A2QlR5cjNPTjE0dGNxb1pYNW0wYVVjT3RPNkNCeTVUOXltWjhI?=
 =?utf-8?B?Wm1uQjhjSVRveCtDWWFrcmJETGU5SUNRb0RsY0VBU24xZXhNbUdIVDY3Z09o?=
 =?utf-8?B?T05RYUQzbE1wSXQ2T1pvWHBQc1FYdlJCOFJuZTYyTUdla0R0NnpLbE82WXVF?=
 =?utf-8?B?M3MzdUxTWmpkNFdwMFlnN25zckxrMUxUWGR0TFdFcTYvR0ZqWGpBU3U4ZEVv?=
 =?utf-8?B?Wk1jT0Z4bTR4aWJDL01wZDN3ODlHVlk3MlBtMXRYclhOYW1lTWhrRmp5Zk93?=
 =?utf-8?B?MytEblV4RHo4QnVLOUpNMzZhZWZRSHg2aHI5WVFhdStHZm9UUG5LcE9BeGxW?=
 =?utf-8?B?YktzYjRGMWdGY25ZcEg1ekFLL2ZoT1d0ZERYUHhsT1llNXJyNG9yM1ZBNFhl?=
 =?utf-8?B?L0lBcDV0NTZBVUhNZks5N21STENqMTRLem9ibnVySWxNSEtNbWZHZTlWTU1s?=
 =?utf-8?B?eUphNUZlcEdmOW01MmI0d21ZRndjVzRPZ2toYXRWWDJUeTRJNDc3bVFkRjdv?=
 =?utf-8?B?MmNUTTJBZ1lwbm02V1dCdTg5MUxFMDRPRHh6S2xLWDJyYSt5bUpGYi9mcEVw?=
 =?utf-8?B?OUk4K3k5bmZKK3pPUlFSVzc2SUswb1F4T0NGZk1yT0dtVURYNjNtTEtvWll5?=
 =?utf-8?B?K2FHRjZ0dkpvRVZuU24rUlpDMHVqODc1VTgwN3lNcEx4MndhQWttSWh0bTYx?=
 =?utf-8?B?TWFYOVJaQzErY0YydmpQT0tiOUtmazBPUFZTWk9mNytPdEd3Y3ArOEx0a1dN?=
 =?utf-8?B?WHVINjIrWTl4cnhubTJmc3pWTGd6RWRxekNacWFDVVE3bkhkcERDNzJjL0dq?=
 =?utf-8?B?SEhkRWpLdDc2NnNJenhyd0luMWZyUDlNazJZN3YwSTJQbUYxMkRIZjM5OC8r?=
 =?utf-8?B?L21xNGJuT3VkaSsrNzVENnJxMFFqbG5QeTBZdVhSUTc3RjJXcDNQZlVtaFR0?=
 =?utf-8?B?OVFMNVNiTkowMkJMM0xVblVDZ0F1VFpkcXZ4RDJRU2dWRTR1dW5xQno5Ym9p?=
 =?utf-8?B?NnpJWm9acmc5c2pFMnpQZEJLczloWHJZMTk5ZldCODlsNFp5YXhxZFNxSVNp?=
 =?utf-8?B?a21Jdy9QNzlob3pmQmY2bE5ocTh5Ky9HNDVtYVJzeGViV0lnWDhCeHh6dmNx?=
 =?utf-8?B?eVNVSTkzaEsxUlNkQ1Y3RTJIRm0walFDY0dUa0JMYkZGOHhwVElPNDVDSEpR?=
 =?utf-8?B?VWh1ZVVMVTU5Znd4aGdhY25EUXgzM1RvTjlaQnRGTGRscFUxNVNnUXBuUTBw?=
 =?utf-8?B?RjJzVjZJY3lSUDh5S2Y2MkpGMHdlcUhHWENPVXJMajl5VFA5eUhHY0ZyWmZI?=
 =?utf-8?B?WlJLayt5Y1JHczh3REJxdGo0SjFLV2tnaHVRQWJReks1L2R3KzJkNTRQelB1?=
 =?utf-8?B?WGVmK21CbllicWRwdlNPQ0xwcTg2ZVQ2akhqc292ckxMZldCWEczUXlxclVN?=
 =?utf-8?B?TkMyM21QQTRxSzErUWk1NDBLejVvTmo0RGNKZUtmUHJFRjMzZFZtSHFKaUhY?=
 =?utf-8?B?Zkc2OVpkdTdyZ3dxMnltK1JUR0xnak0zZHZJOGJqeEVsVFdSbGt6QW9XVnl4?=
 =?utf-8?B?dXRFaVJzZXpheE0zeGN2Sndzc0l0U0cwQUt1MTM2U1A4ZHNWWGtDR0IycHZl?=
 =?utf-8?B?azVCaVNseEFHM29kSWdxZXhFdWxGTXliVGM0MGRNbWtOcWgyU09WNUQzMStu?=
 =?utf-8?B?dUtVdG5aT1RxSHROdnhudWIxeWpnMmgwcmpQVTgvNG1qMVRFUWRLb0dBcUdW?=
 =?utf-8?B?ajZ4NXd4MURuSUhrRS90bHgydUVPbDN0ci9lZGZHTFYxK1lCZ05zSWVkWGJ5?=
 =?utf-8?B?bmRjbTBVQUxERlhKTTk3QVA5RjByYWxYNkNOVUlJMHFUMWV4RVdPeGRQS00y?=
 =?utf-8?Q?scgeZx6CKc909lKMRHVPoRs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10c5465-1f8e-4fb3-9fa0-08d9b689215d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 18:17:13.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFix3tvbB4+yeKf6lybsgkQzRbGL/J8cF+zK2ymkGemHTtvhIYUms18UYP9mnmz7ih7V0LObsyqy7hWUJJRaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 7:23 AM, Kirill A. Shutemov wrote:
> Hi All,
> 
> Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
> hosts and some physical attacks. TDX has a lot of similarities to AMD SEV.
> Features like encryption/decryption and string I/O unroll support can
> be shared between these two technologies.
> 
> This patch set adds infrastructure changes required to share the code
> between AMD SEV and TDX.

For the series:

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> v2:
>   - Squash first two patches
>   - Rename print_amd_mem_encrypt_feature_info() to print_mem_encrypt_feature_info().
>     It will report TDX feature too.
> 
> Kirill A. Shutemov (1):
>    x86: Move common memory encryption code to mem_encrypt.c
> 
> Kuppuswamy Sathyanarayanan (2):
>    x86/sev: Use CC_ATTR attribute to generalize string I/O unroll
>    x86/sev: Rename mem_encrypt.c to mem_encrypt_amd.c
> 
>   arch/x86/Kconfig              |  10 +-
>   arch/x86/include/asm/io.h     |  20 +-
>   arch/x86/kernel/cc_platform.c |   4 +
>   arch/x86/mm/Makefile          |   7 +-
>   arch/x86/mm/mem_encrypt.c     | 441 +---------------------------------
>   arch/x86/mm/mem_encrypt_amd.c | 438 +++++++++++++++++++++++++++++++++
>   include/linux/cc_platform.h   |  11 +
>   7 files changed, 473 insertions(+), 458 deletions(-)
>   create mode 100644 arch/x86/mm/mem_encrypt_amd.c
> 
