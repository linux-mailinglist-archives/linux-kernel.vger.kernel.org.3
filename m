Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC905855F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbiG2UML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbiG2UMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:12:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4748C85F85
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrPziedb01eG5CAJ4fM4nB9LvsPEqHOrbhXxrlEpCeIp/sIMa4AsEBcEjSVPJ772hgUhNMQ0AFEwEL9S2admaKuEx6OCrj4q9xGujkTy1ecw5TVi2JoFcOynou7RNkqm78mtSq4jzmsYANj2GvEBLh6nMpqP83X6G1eRhqqgbAtT87B3FBBfLVPT3eUuKPhEgsuK6enwvr+unw1BhePZ6yCzX5XnTbBI1mvF1hPUgcz923Ip8SEuk7Vv70hYuzg/9sinl5zL20VdR82rUX6AFbplOUWmS1VFZIvJu+CY4XEYKORMILEBIN7+QwCPD22lMnEeHD8kiI9adssBgjRQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c65aZY+cTHp9LB0d+j6F1NbEme0FckOKveGAfZJbnjw=;
 b=eHFzCInYBS/E9r8HqkjjyNDjNkSHPAhZqv5UhhFgPbBAGkwufAW0L4JFqxJjFLsEUaxb/HvxNclxe4Q4GJAqmAFWoH2Be+aU6emaZVbJg1C1q0cLjlckZpAHW4mDiaJlS58/LiGpmAuK9VXstULYY4QIyhlUzKIrEetvE9rxn53GDYWM8RHCqRU020AaAXbW5DbpL7q4PQNNQYdRnPdb96nOitQBqYqzp65PeVwM1FBStKYNkkql4xLKkVLiEP+ONdFVuZ8PqFeY7mjzHfsZ91cO5DS0uaBvJmYhhQc36JpRNxvhZS70byE/QiN3wM2qGmh3opVCzbB5vB8/+3+Kqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c65aZY+cTHp9LB0d+j6F1NbEme0FckOKveGAfZJbnjw=;
 b=cp9KeQdApNIS7ByiH6R1mNcP/UqOi8qCSAUXCGt3MtPgpK0J1R2ijrDhIUsl37GM9QE6+rEsUCxfLTNillyjRB/DWWJP0QMNcmY4YDZM1t26MELsiAbsV6vdvEy6f3TIsz2HfGwYc42jD/BkF83+ufYCavlHYFBDmZaM+HHIeaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Fri, 29 Jul
 2022 20:12:05 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 20:12:05 +0000
Message-ID: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
Date:   Fri, 29 Jul 2022 15:12:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659103274.git.thomas.lendacky@amd.com>
 <658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com>
 <d27e42a8-b2af-f922-4cea-b1ddaa2a0af0@intel.com>
 <9da5204f-5c8f-b47b-bcc6-d68ca63db08d@amd.com>
 <377f6c30-bdfc-55a4-bda7-f29c60c53300@intel.com>
 <efde397b-35fc-c47b-b21e-898fa2ec6920@amd.com>
 <70a5c939-16a6-d5e0-2e38-ac7adbed5fc1@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <70a5c939-16a6-d5e0-2e38-ac7adbed5fc1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:5:14c::37) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e13aa24a-bcd3-4057-18ec-08da719e9b44
X-MS-TrafficTypeDiagnostic: MWHPR12MB1629:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Trhi5mPLSpqqudw9sTe+fs6gmrqwKHNbUuuCB6UAaTFwbCEcs1bOQOZiDKYZjgqdcUEZVuCyZE0mkEiK9xm6UGKmU4ir3Z/Kwitxtqar3cDWUAiezQ03GT1CxPOOsLYCDi9IepfIwa13wAjR+k9o01pSElhDW+x828EVO6JsVeXQ2j7gY/7mu8InHW3wdy+m2VkX09lNn25xmRdSEoRhTJlP4KM90Rdp4fUbmLvkI6Zj3h32vVSOczQz1wpuNFjUyNlB+JBVvuFbMia3Q4I5ECU/0horzV4VZtaRn7FrlnDL+i0DaTTMzx1JhsvGQ7rDF/qsPMfTBEqEr0zkOTonUUSQBZwjNwqE8sMMJswBEvOhb+5kSQ1396BclK6ERTl3qp5FVZgRZsj6qvkyDaafmTMM1VlIDgccozYRYwSxXVKVdkE7SN5/e5p/rHHoVagivf0mP1poKTQmGV6T8uVqq+m08n0ntoWQWQ5HiTH8UtA11dwhUqpSOYN2Ad+iu0kp6DtKc0MIo12WcXtIcNl8SKmDPFTRhVqLDGb+6drjASFV2g5xsQuMNrw1vwojkIMjKJ2GLTG3fN0KpXRFXPXMi/gnXUEjEEmFzOQpFMuLbHzlAYx2XNSptEEl5wba9HFZgp5dHCFkfA21PfomJkNWBLKrV8PiTdPL0GhCtbo1hj7pcH0b4c+FFxWNnNu71T0gIOAb5CEquKwpUPy7m0/bNWQ8vEsTK8LqtO9+skki1eB/3zsHCI01Aj3msyRGvb6rLN07GuY3ahsluA4uAMfZdoiWXZdXgfnvftAhdv6LVvUfkKKZD5Y/xSSdaWdl/ag00OPC+2ESYpuzd+ZPcEP5Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(2616005)(83380400001)(54906003)(186003)(53546011)(6512007)(36756003)(6506007)(31686004)(41300700001)(26005)(7416002)(2906002)(86362001)(5660300002)(66946007)(8676002)(66556008)(66476007)(316002)(31696002)(478600001)(6486002)(8936002)(38100700002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkJCNDJCeHNFY3hnQ09hdkdMVlhhUGN5cmxtcGNKbmt1bDFabWpROWtPN2l4?=
 =?utf-8?B?Q1cvUlBMdTJmdGlDRlNKaDZseU9EM21qeUpXejV1S1A5cGFwZE1zaEZOcUxq?=
 =?utf-8?B?THRGU1llMDJUNTRuRXVCd05GcVZGUFJPY3Zlb1llTkExWnJmRjFjM2hkWE5D?=
 =?utf-8?B?NUYreG9jSnUxM1pQbjhTMVJrM1M1M2pqSkgyWUpySXowT0hOMkZlV2dDbDBs?=
 =?utf-8?B?Y0FhV0NnV0tuSllSSCtGNWhVeFZSbnk0cUwxNG96OUJmLzJSU3RFek53cWpU?=
 =?utf-8?B?ODMzRU02WlFkVTV1eDB6RTNzUERKTDROaTFxbldDcU1zOEZyWDdCenczcjdT?=
 =?utf-8?B?amIzWFlYQWZsMkp6WlpNL2FFYTlLd1JDbE5pMmY0aEtpUXZjMEpnajZxUDRR?=
 =?utf-8?B?di9jbUt6bEJ0U1BJOHBVRUdIVXllUVNLeHVXd1FDNzhPTlp0aDB0Q3N6bWwx?=
 =?utf-8?B?dzZkSmZJaFdycnVBS0I1WTgzWkhJbmhCQVVjTmIzWnBHbExwVmVJVEEza3c4?=
 =?utf-8?B?YU90S3JWa2pmWUJIdGRFOGdLWHBOWnNGclZDdlExUzFhNFpha1VGeXJxMjNC?=
 =?utf-8?B?VmNoZy9xUmduMU1PMmIySW1WSUVCMG95aEhVZ3l0YlZSaVQ4R0d5TFMzT05n?=
 =?utf-8?B?MXNjdC9PZ1c1Vmk0VUVENTIxODJsUlVObEVoa1lOVncveFNBcWIrY250NGZN?=
 =?utf-8?B?WWFSSTVMbjNNMWFjNFYra1Z2Yms4MnhPYlNDNTdwekZlekdwTzVpVWRSSzR6?=
 =?utf-8?B?d2pKcytYQW9RRkU3UEZIOG1SaG56Rk1jcGNyTXhWQlBMT2R2a2hlQUxOd3VU?=
 =?utf-8?B?NVU4SEo5SktBbTRHUnlPbUNzWHhkY2JadjJ6MFcrM0czbXlCU1V5YXU5aHZp?=
 =?utf-8?B?MEZIVmZJRHVzNEJsNzJYL2NwdUg0N2drNEZLYzRqOFNPSUJtekF5NXpOb2F1?=
 =?utf-8?B?RDd3UXA4bzEvbHBCMTZkbDE5MXNiNmF0aHQ2aG9Zb256YlA2UEtSUGF6dmJJ?=
 =?utf-8?B?blNmcE9sVXNvMWhHclN5azFpN2JpbUZDWUpVYjNyc1VWQ1VPYWRMa3J3TGJJ?=
 =?utf-8?B?aU5IakhRU1FGcVhoQktsblRNZlhiL1JGemtLWE5aZDFxQUZjdk9LSjRJT0Yz?=
 =?utf-8?B?eEUvdXBFaGlnY1loREJ1OGdobGhac05uUklIem9Nb29CMXBzaWR4N21GQXlG?=
 =?utf-8?B?OEE0cUF1ejFjMGpmdngyNGtBbnBDODgvNEd2UysvQlMzY1NzYTBQbDRKZWV2?=
 =?utf-8?B?TDFtTjE4MTdxVVRTL3kycVBmaVBEUTNUYnBRUG5LS1Z1Q0ViSjB3WWlmQmZV?=
 =?utf-8?B?YzVuME05WDV3RXRzQVhFR2lyNzdjb0gyVjJESHdzUm9BNGc5MGV6N3JoeEFj?=
 =?utf-8?B?WGNPeGpYM1doSVZ6cmxqMUZaNCs2V1V6YW5PUVE2bC96U2hoTEdLa3pnQ00y?=
 =?utf-8?B?UHlTbkFqcG1tU0JydENDekh1UUZ5SnY3YUFyLzZ0bTRYemY2YkZocG15QjhS?=
 =?utf-8?B?SGljSHF1bFNrcHh2ZnBrQXN5UmNNTU9zcWFTU2wrVU13V0ZyRGFmYVJ0bklj?=
 =?utf-8?B?REdlOEhOWUNpMFNmSHltbmRDWDlvTWs4UzJzQmdLbmlYVDZRT0cwQm5QbVJ2?=
 =?utf-8?B?TnlGMytUNWR4emNMNmlmajh4bGR0VkorbWF4T0Q5Zy80S0dZRlB5aTcyVXRU?=
 =?utf-8?B?ZmpGS2lIMkljT0FDUDlwU0ZKTDM2ekhLU2cxL3JVT29NcnFoOHRHaklPNXdj?=
 =?utf-8?B?Y05PWDBmeE9xcXhIQXNzbE9CL21GUU4vNmpHUlhSVXJLNjk1eHFycFY2ZFpu?=
 =?utf-8?B?Z2wydS9hL2MxZUswY2puaUppckN1UzNyQ1FacGRUdG9GeGJqemc2N1NLc2lS?=
 =?utf-8?B?b2tWOU5rNWlSNWh5am9jM2FEazQvaEVJeDZ4N3FSbU1IOHIrTnZlYmFZTmY3?=
 =?utf-8?B?bEUvaS9LUS9jUEYwVlppYlRYaVpiZDZybkQ0UHloeGJSeFJOeTVyRjlzb3Vn?=
 =?utf-8?B?UER2YUNYRG0yQUdXVHdxODR0bVRRQUlJNUQ1RjA0MTNMOEVLTHFYbnkvNUFS?=
 =?utf-8?B?RjBid3JrL1V5OTRlSlF6eFk4OUxiQkV1T21aaThZR3R1SnEreEZkdm9MWGRM?=
 =?utf-8?Q?JY6rLmDaEiaPXFTeJK+reE9sn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13aa24a-bcd3-4057-18ec-08da719e9b44
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 20:12:05.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mhf56X/lL9YNMBMMbOqbf5CtO29WDNksxK9KJTzKUEhAx2SnbllDaxdUAzccPaTwRcDqBNLdD5kdZoSLDTeCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1629
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 14:28, Dave Hansen wrote:
> On 7/29/22 12:22, Tom Lendacky wrote:
>>> I think this tidbit from the changelog threw me off:
>>>
>>>> Protect the use of the per-CPU structure by disabling interrupts during
>>>> memory acceptance.
>>>
>>> Could you please revise that to accurately capture the impact of this
>>> change?
>>
>> Is s/memory acceptance/page state changes/ enough of what you are
>> looking for or something more?
> 
> That, plus a reminder of when "page state changes" are performed would
> be nice.  How frequent are they?  Are they performance sensitive?
> That'll help us decide if the design here is appropriate or not.

Without submitting a v2, here's what the updated paragraph would look like:

  Page state changes occur whenever DMA memory is allocated or memory needs
  to be shared with the hypervisor (kvmclock, attestation reports, etc.).
  A per-CPU structure is chosen over a single PSC structure protected with
  a lock because these changes can be initiated from interrupt or
  soft-interrupt context (e.g. the NVMe driver). Protect the use of the
  per-CPU structure by disabling interrupts during page state changes.
  Since the set_pages_state() path is the only path into vmgexit_psc(),
  rename vmgexit_psc() to __vmgexit_psc() and remove the calls to disable
  interrupts which are now performed by set_pages_state().

Hopefully there aren't a lot of page state changes occurring once a system 
has booted, so maybe a static struct with a lock would work. I am a bit 
worried about an NMI occurring during a page state change that requires a 
lock. I suppose, in_nmi() can be used to detect that and go the MSR 
protocol route to avoid a deadlock.

I can investigate that if the 2K-extra per-CPU is not desired.

Thanks,
Tom
