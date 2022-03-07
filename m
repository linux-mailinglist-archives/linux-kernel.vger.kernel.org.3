Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113A14D094A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbiCGVXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiCGVXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:23:08 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2101.outbound.protection.outlook.com [40.107.96.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A892C100;
        Mon,  7 Mar 2022 13:22:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mECR5dgc9DAf3FnD6TYrlgVxy1jSF7Tke7b44+wKlz00fGM5KUwU4r4ZltlR/H9Uj4OMV2APtrdRCbl0t6zp0LlpOc93kzD146c5vJKfqzrxk7P4Do1NjX1dTHIZ2n+BO1D734XvQfkTBwL3y5k4pDc87ilqY2baRK/BtBsKP+M+lRHav9T+J3FcCxYTt9gj/d4c3fOcqrG6Q4OiBIgVaSMJ6Um2pQqvz++fN5zNNKyH94NGmltzeh9V7f8wwSZcMJuZThgQJUuXanHsBIQeXLTTEbM/eHynDBicoC2SoC0/YEsOdqsI/p/VJ+XYkWdxeOEmgxchnToYWg21DNS1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md//v7mJkh9UMTCGH21KsVSrLLw30yq3WWaq+8O+NoM=;
 b=lxZF1v8zZnj/i3Chdc5+GgejKcUtypBkCebqgBl9wc35EUid9RxJjU+t3QZuLYYP27WxAz4xBYXc0zLMQbMZ8b2yWsDHngLt0nuDo2+d4wgvghpDkVt13wvioZQwVeHQ8zUTKsR2P7E8iRQWtvjMSRSb/SgFFkHoSsVeCqxZgwBwUyjWLHagSBAb8bmxib6H/8wK8UrdLCH9HeJO+43mJ7IbNym5xUXh5trTaXTyJTW7XDkoGodnQssUsE6cxIPNWTsSY2EsjTlDMqNSu75EiEu9LLVuvbWshrTt8B1H0DM8gD3txzE2kThp4u4jco8oTazRZCW51gbJFUJtfTdOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md//v7mJkh9UMTCGH21KsVSrLLw30yq3WWaq+8O+NoM=;
 b=aXRsI1g4ceaeGUuvSsC7USB3lYUyZTc4+pJyYWrgDLPDcNsRNeV4/oyQWXC6xwb8ZELojvwqmMeEbRONSoc/R84tJqNNUY+pZBjL57ooKl7klXL4fAwnvI5UCmdvwdoh8QEhHLRa0gUvx7UfzLn9qqGI+lFG9XvaPNwQ8Bapqv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB3915.prod.exchangelabs.com (2603:10b6:5:8d::28) by
 CO2PR01MB2055.prod.exchangelabs.com (2603:10b6:102:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.21; Mon, 7 Mar 2022 21:22:08 +0000
Received: from DM6PR01MB3915.prod.exchangelabs.com
 ([fe80::91fc:309:2875:9e9f]) by DM6PR01MB3915.prod.exchangelabs.com
 ([fe80::91fc:309:2875:9e9f%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 21:22:08 +0000
Message-ID: <345c99af-4f65-6776-fb21-f9fe8662566c@os.amperecomputing.com>
Date:   Mon, 7 Mar 2022 13:22:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH][V2] ACPI: sysfs: copy ACPI data using io memory copying
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Henry Willard <henry.willard@oracle.com>
Cc:     James Morse <James.Morse@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Colin King <colin.king@canonical.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <20200317165409.469013-1-colin.king@canonical.com>
 <20200320131951.GA6555@lakrids.cambridge.arm.com>
 <698da6fc-3334-5420-5c97-4406914e4599@arm.com>
 <88DFC1B9-D444-4D44-963F-34D0F5B9EC01@oracle.com>
 <Yh5DOz/u2hf3Eu5Z@lpieralisi>
From:   doug rady OS <dcrady@os.amperecomputing.com>
In-Reply-To: <Yh5DOz/u2hf3Eu5Z@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To DM6PR01MB3915.prod.exchangelabs.com
 (2603:10b6:5:8d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c172b7ea-8cfb-43e7-310b-08da00808931
X-MS-TrafficTypeDiagnostic: CO2PR01MB2055:EE_
X-Microsoft-Antispam-PRVS: <CO2PR01MB2055823263E11CA602B2A070F0089@CO2PR01MB2055.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8KtU3rHki/s+ZzWUSvKcWGt37CVXi6cY1jf9Hw53MMMgC+wl2qvDwVfQ5wDEwf8xgUN/hi4VZe7cpvzTpVu2k7mnlmZcLIOIMtpPxemPGFKVWvvgbIwXFAlErkWg5ZL4hj0+cevxEQLF47zwgmDhgMV6E4VvX0obwB/nRnyZKyqnAR03BeUxXykmWq9hC9kWZXBoh19X/IMF8UpryK+vwy8b5AwoepZhjyg036hwl3xeXUyBAmbAU53oVYD92TdmDmmJowTJ+WOUnFNa4qVkgAlD3fAuYVtAL6O6BWrk9hk2Jl1OvkEt81JV5AFh6FWMZ6h3qmjUeKsh+dLqOTZHdHR5djfas4qykjDu9UuMvfTqEF3FgevPqjdOen900EyT+lAoVmTjf0jJPrMOXerbQC0i8pRJXI6Vf5bnkEZqU5aiRkdoPcqzMP4ktCy+R1UAhL5ydvwGhON2ZxzJL0DEOKmmkH/4JnY9BU1kPggARC1LWmjoMLR45mhNq9bwLWgsVJ+wFSVaF57izy6N1fYP4Ytw7UgaVR7qYVpiak2XC1uAZgYB3wDlIwC0Y9SH4/Jh47R3YRJlHRI0fIx8uB+wFvBRQmUrNv8JgjhIJxPemZ++uwYSEMdHlqJORS87mfxGLkYwOh7F8vIKN7A7hjcRXYX7DLODXsDf0bGiOTjIOUmPAEyP7Prsj5vitO2zqr+m2++jvTIX8wuCAMqvVn3hGPREFusD5nDevfVy8i6jEc2VztJbK96YeVceL2nFMwbTO9NdA9VNvxYWaNMKlH3Si/3FXUKAFt7x733uxvw+cjflgHIUC/My/dLYt7TR7uI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB3915.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(38350700002)(86362001)(31696002)(38100700002)(316002)(110136005)(54906003)(2906002)(6512007)(966005)(7416002)(4326008)(6486002)(66556008)(8936002)(66476007)(8676002)(5660300002)(66946007)(186003)(26005)(31686004)(2616005)(508600001)(52116002)(53546011)(6666004)(6506007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXdJTXdkWkJaQ0tFeEJHTzZZc05SMkR3aU5FdmRMcVZJb3ppYzM2Mi81Rkdv?=
 =?utf-8?B?YnRiVDJpbVVyZVdyb1J1bU0vNHNoc3JySzJWQVpzbFZqL3FwdzZWR3NNMmFh?=
 =?utf-8?B?NElwT0JXM0NTelVvVDN0K1p1czVGNXVsUTduT3QvZmVyNEttYm80UUk3aWxM?=
 =?utf-8?B?VnVHY3FPMTQyd2lLKzUxQzBUOVM1c1JZWkg1L3luc1UzZFJQT29zeU12cFRI?=
 =?utf-8?B?eUlBb1ZQYlJWNldaV2FiZUQ4S3hOMDdXT1ZMc2NjZnZ0MmttZi9GeGx5YlEv?=
 =?utf-8?B?SkJSMXJIWFNDQld5c2tyTnZjamxDTERGTjcrOWRLdjBuM25TZUw2czR1b2k4?=
 =?utf-8?B?RUIzOWlybjFUODZZaWFoS1R6czdnZUM4TE1vcWdiMWR0cU5LOFNTMmtiZExo?=
 =?utf-8?B?Q3dzUkFzbHdqdit1bmJrVVlOdy9saHVRQWFOajQ2SHV6aHVTYjVSaXphTXhl?=
 =?utf-8?B?S0JNSUhQUlcrNmhocjRCRzF1eUMwalZIaWl1Zk5ZM2YvelhvTXhicFlzbTZa?=
 =?utf-8?B?SFMwQ1B4cm5CVFJwUTV4ZjhpNER6K1hRNkxxRTJXSG9DYjZsZ3pJV1E4Q09x?=
 =?utf-8?B?c0pIdUE2S01kSmxTMFZHYktOZ2pQblVnVFBObEs0czErRk9ob21QYWJ1QkZ4?=
 =?utf-8?B?c1B0THpScU5oQ0doSGQ1Z0gzZkJvblpGZjRnRnVQQ3BiU1ZVWGJ5clM4UUtJ?=
 =?utf-8?B?bDU2ekt1V25XejVVL3c0VmNmQTNPQU1GYy9OL3JnakRlUGYwd0ZZZEJMYnhu?=
 =?utf-8?B?blU2Z3RhNWZ4NkdYKzNjMTNhc1Yybnd5SnVobzQ5ZU9XSjVVVy9NY05SeG9N?=
 =?utf-8?B?ZGxKMFkrUnRKMXdKZDZvdDdnNU8vZ08wTkxvTFBYbDV4NXBIVXM0NVdsbFFX?=
 =?utf-8?B?OWUzM2lSZU1idy85M0U3VzZISzR5blNJeUtmSEtFbk1HamZtdFFTYTkwVmgw?=
 =?utf-8?B?emRuOHBMckswWklaWG93NE9GT0ZDdGhMbGRJaVkwSUpmTlZLL2hza2hkRVRo?=
 =?utf-8?B?QXhrZXR4TnVpNEdyRWdQOEY2eHlXTHVCZ00rcmk2V21PdzVTY0lmT3R4bEVl?=
 =?utf-8?B?NnQrTzZnMEZ6alNJbFFmeGtxR2pEWFdUN3gxQ1JMN1BHOGRoaXV6a1ppUzRP?=
 =?utf-8?B?bURYVGVHaGVzY0paWCtEZFhydUR6cVRXRXhNVm85T1NocDR1ZHRGd1p0aXVl?=
 =?utf-8?B?OGRpOU8ralZOMjVMWU4ySWN2ZHdlYlVoOExnekowRjZQMGFXREI0Q2xvYVZU?=
 =?utf-8?B?aEtmYlliaWFNZW5nWVp3WDJJRm9qUzNiKytVancxeVJyR29kaW9rY0NTeU1m?=
 =?utf-8?B?SDF1QW9RQzlhMi9RaVVKdHlaWjBpOGhQMU5TMkxlR1R3VTdHS3o0SEs5dHJX?=
 =?utf-8?B?RCtDT0cwUnpxbFFnQTcrWVVpUXppL3pSbER0VmtDTUR1ZmNuRW5pYjE3dVhO?=
 =?utf-8?B?clVwVG92L3RZcnBVSk44VWIyNXJQL3NWWldsZFUxcUxkczlBYmF3VlFHWEp5?=
 =?utf-8?B?ekwvWHRKZEV3WUdOaXh3MDlBUytEV1dvaUx1dzJNa3pxM1htTUlVaGlkNnpR?=
 =?utf-8?B?TWRXeEFuSkhuRy9TOVR6VlhpMzVhMlV5bzV6dHM5M2g3cWk2OGZNT0lTdzVS?=
 =?utf-8?B?ZDFpejMzOGhmbkdVMHhIZTRhV3ZsYmI4RGdhbFN6c2JmYmh4dDRsRVJzWGdn?=
 =?utf-8?B?RTlmV20vTXkwVEpoY0h1dnIyL3NWb1ZONy95Z1Zwck16NFAvRFhCMWs0VlJs?=
 =?utf-8?B?TzJKdkdxT2MwSXZDZ0FaeUx5Z2UyWWplODZ4cHVlTEIrY0FRMGpjODF1SnJy?=
 =?utf-8?B?STZ0c05VcnJjVmxvZFpXdGdvQk9uL055WUtldVVaaTZEaHZKK3JGY2JDcmo1?=
 =?utf-8?B?OVdZZFdyeFJ0K2JLa2tqUDloaFhvVWg4M2d2UWNYY2tLR1ZmcnNBYXk0aFpr?=
 =?utf-8?B?WUkwV3ptTXpqNVJHUEtidGQ1YXJjWWE4MDAvemxpcEhGQjg4MzYralRCbHQx?=
 =?utf-8?B?T2ZYc21FTktZVWgvdFFFaEJSeTlWMTg4ZGJMSjE5Z2ZZU3JPQ01Oam5FZjVT?=
 =?utf-8?B?cnRmSkZZUlVBYXMxQTZ3cTk2bVhiK3RPSWd3UG9vZ1lHaWUvemExdDd3MTdJ?=
 =?utf-8?B?cXNEc3NNNXloQ0ZtYUg4TitQU0dvNjM1ckZqR1Irb1pDTzh1bEc1dnM2OU5E?=
 =?utf-8?B?aWF4dm91MzZ6azFnS3A2TGROS1JYdmhyaWVkTmJLYkdqenRpc0RNcTQvNnc5?=
 =?utf-8?B?czkrQXhZUXk3ajA4bnd4NmVwUktJczRFeDFYT1ZvNkJPM1htTUNxbUgwY1hQ?=
 =?utf-8?B?WksreHpHMnBEd2srM1JQK0FnTjVjcE11V1lzUTcrd3gzejZhQ0NzQT09?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c172b7ea-8cfb-43e7-310b-08da00808931
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB3915.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:22:08.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXPylqxvIr6Fx3I3IbEe01uw8yRTAS6Mi6b3DscXM7CTRXqKDTXGC47h3hAYB2SjzT40fKaRfM8S9EqdO5eTmJXo0F7p5RSj0CH10VoGxgVZxVpmjmiILf++eNBa+I/d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-01 08:00, Lorenzo Pieralisi wrote:
> On Mon, Feb 28, 2022 at 11:51:23PM +0000, Henry Willard wrote:
>>
>>
>>> On Apr 1, 2020, at 5:44 AM, James Morse <james.morse@arm.com> wrote:
>>>
>>> Hello!
>>>
>>> On 3/20/20 1:19 PM, Mark Rutland wrote:
>>>> [adding James and Lorenzo]
>>>
>>> (but not actually...)
>>>
>>>
>>>> On Tue, Mar 17, 2020 at 04:54:09PM +0000, Colin King wrote:
>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>
>>>>> Reading ACPI data on ARM64 at a non-aligned offset from
>>>>> /sys/firmware/acpi/tables/data/BERT will cause a splat because
>>>>> the data is I/O memory mapped
>>>
>>> On your platform, on someone else's it may be in memory.
>>>
>>> Which platform is this on?
>>> (I've never seen one generate a BERT!)
>>
>> I have seen this on several platforms. The latest is an Altra based machine. It shows up in the Linux Test Project: ltp test "read_all -d /sys -q -r 10”.
>>>
>>>
>>>>> and being read with just a memcpy.
>>>>> Fix this by introducing an I/O variant of memory_read_from_buffer
>>>>> and using I/O memory mapped copies instead.
>>>
>>>> Just to check, is that correct is it correct to map those tables with
>>>> Device attributes in the first place, or should we be mapping the tables
>>>> with Normal Cacheable attributes with memremap()?
>>>>
>>>> If the FW placed those into memory using cacheavble attributes, reading
>>>> them using Device attributes could result in stale values, which could
>>>> be garbage.
>>>
>>> Yes. The BERT code should be using arch_apei_get_mem_attribute() to use the
>>> correct attributes. See ghes_map() for an example. bert_init() will need to use
>>> a version of ioremap() that takes the pgprot_t.
>>>
>>> Always using ioremap_cache() means you get a cacheable mapping, regardless of
>>> how firmware described this region in the UEFI memory map. This doesn't explain
>>> why you got an alignment fault.
>>
>> The BERT error region doesn’t appear in the UEFI memory map on any of the systems I have looked at. This means that acpi_os_map_memory() will always map the area  as PROT_DEVICE_nGnRnE, which results in an alignment fault on an unaligned access. For some reason this does not fail on some implementations.
>>
>> It isn’t clear to me from the ACPI spec whether this can be in anything other than normal memory as bert_init() seems to assume it is.
>>
>> We have used this patch to resolve this problem on the assumption it
>> will eventually make it into the mainline kernel. Is there any chance
>> this will happen?
> 
> Yes this should be fixed. I put together a patch that I needed to post,
> below.
> 
> -- >8 --
> Subject: [PATCH] ACPI: osl: Fix BERT error region memory mapping

I hit this read issue while debugging something else and this addressed 
the problem for me on Ampere Altra and AltraMax systems. Previously I 
could only read the BERT file using dd with BS of 1-4.
With this patch, now I can 'cp' the  BERT file.

Tested-by: Doug Rady <dcrady@os.amperecomputing.com>


> 
> Currently the sysfs interface maps the BERT error region as "memory"
> (through acpi_os_map_memory()) in order to copy the error records into
> memory buffers through memory operations (eg memory_read_from_buffer()).
> 
> The OS system cannot detect whether the BERT error region is part of
> system RAM or it is "device memory" (eg BMC memory) and therefore it
> cannot detect which memory attributes the bus to memory support (and
> corresponding kernel mapping, unless firmware provides the required
> information).
> 
> The acpi_os_map_memory() arch backend implementation determines the
> mapping attributes. On arm64, if the BERT error region is not present in
> the EFI memory map, the error region is mapped as device-nGnRnE; this
> triggers alignment faults since memcpy unaligned accesses are not
> allowed in device-nGnRnE regions.
> 
> The ACPI sysfs code cannot therefore map by default the BERT error
> region with memory semantics but should use a safer default.
> 
> Change the sysfs code to map the BERT error region as MMIO (through
> acpi_os_map_iomem()) and use the memcpy_fromio() interface to read the
> error region into the kernel buffer.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0g+OVbhuUUDrLUCfX_mVqY_e8ubgLTU98=jfjTeb4t+Pw@mail.gmail.com
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>   drivers/acpi/sysfs.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index a4b638bea6f1..cc2fe0618178 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -415,19 +415,30 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
>   			      loff_t offset, size_t count)
>   {
>   	struct acpi_data_attr *data_attr;
> -	void *base;
> -	ssize_t rc;
> +	void __iomem *base;
> +	ssize_t size;
>   
>   	data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
> +	size = data_attr->attr.size;
> +
> +	if (offset < 0)
> +		return -EINVAL;
> +
> +	if (offset >= size)
> +		return 0;
>   
> -	base = acpi_os_map_memory(data_attr->addr, data_attr->attr.size);
> +	if (count > size - offset)
> +		count = size - offset;
> +
> +	base = acpi_os_map_iomem(data_attr->addr, size);
>   	if (!base)
>   		return -ENOMEM;
> -	rc = memory_read_from_buffer(buf, count, &offset, base,
> -				     data_attr->attr.size);
> -	acpi_os_unmap_memory(base, data_attr->attr.size);
>   
> -	return rc;
> +	memcpy_fromio(buf, base + offset, count);
> +
> +	acpi_os_unmap_iomem(base, size);
> +
> +	return count;
>   }
>   
>   static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)

