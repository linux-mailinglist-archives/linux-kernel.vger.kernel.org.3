Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B281476ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhLPHE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:04:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:63401 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231981AbhLPHE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639638267; x=1671174267;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y5zkdtd1k/L43hZDL5jc/VaiMmH+2/lIfrKkDroev8c=;
  b=PQZn+AUl4v/2BeX3LyTTBjbByMwVBoOGj7um0+0yuXD8awytzuyaYYrP
   zaYdfyYFjPVoOcYA5+8S9GaH9jZxwhAcDP6gv3nu0uHnAVA3B75sWyjXd
   YYM6YDvRGwYvDy1W7dhMtJ/A/zIq3FUPhAVjYutR6H5IEksxSEoE6Tmg7
   sErA/zBE1lIYxhR/tfjnVeUKIf964OjAVA4WZNv6joUPdka8m3PcoKnhK
   Shc4wYBkGhAU/kx3q4/F3YlrUh7+KL98rEau1MmT6FnMlc+LKaqGp5AWF
   JFdHaqGctFtDjbHln9BYMc9AnCQDuv5ayeBA5plowsBx7Sm38+nhL9P6O
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219434511"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="219434511"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 23:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="605406833"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Dec 2021 23:04:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 23:04:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 15 Dec 2021 23:04:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 15 Dec 2021 23:04:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHiQWJ8jcR+DmSgcugwWcV0uE0obKGkRpp3r7rUo5w0WnxDcrPQcD9utnzz4HRFN/N9Jm8H/th23o5NvJcdu7i/LZhawt7pJHa94e0h6kyZi6yjO+C37nHWHszIWLCgwyfqHwsBAzp2tI9QJLZOILYkWa/FltIiMHOd5z6EwJUkhwGQGfH01vLVlT5PbBKpLvYB4mK3c9MyTHrGYYG2LIE9RxratLLYfcZ5diHPXzu9Qe6VsCw7/Invxo9tUJZYg/mSCb6vK3/bZtgCUpbkxelkXr5gE+8gauO4nb46su6ykhf9cJBrPqYDI6ArWiobelQXCLQ+C38x9dRw5SRXx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXOHikBM0CYpDdgvvlWB3Yattt1wO8Y7fZ4hEPkWSx0=;
 b=SegBclSsFfUUq1JNp41D5vkFQYGUjU0FsovFHsICC057ScA04VoH0F8oVCY3fqjD70rR7cpyzXdOxMWJtQHyjdYcL/3+s+GjdmkMXPqn0KQxUb1VTF2d++X1PRjqdkPCc3dMaYvnb99g+p2c28gH5k8vjQgQUm+/L0BHHcFvUBr8SLELhBi09nYOlPpKDr6ndXtKiyyO5xTbZ8hBdc6a+yVfbA36mv89m5hOTRZoum25KpB0fc3zSWJrG2P0fWCAkqB6SN225lo1nc+F5CN0bCWhuhIIEObzAkVZv4/O0aOi+hR6c77E+73diol4CrGZNHPIZ5ZvCC4+TOObiJQaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by BYAPR11MB3333.namprd11.prod.outlook.com (2603:10b6:a03:19::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 07:04:23 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::2c45:151c:a37f:410a]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::2c45:151c:a37f:410a%9]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 07:04:23 +0000
Message-ID: <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
Date:   Thu, 16 Dec 2021 15:04:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage
Content-Language: en-US
To:     Borislav Petkov <bp@suse.de>, Carel Si <beibei.si@intel.com>
CC:     Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <lkp@lists.01.org>, <lkp@intel.com>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic> <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <Ybm96seTxl+pWjTX@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5c44a1d-c55a-405a-b07a-08d9c0624a40
X-MS-TrafficTypeDiagnostic: BYAPR11MB3333:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB33337FAD0B4C685FBE79924CEE779@BYAPR11MB3333.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xk4qwfUGgSJ4r86WII2y/p0fuY3/0oPKoMlIMfCU7PBL7+INMh4eMHdfMObtIB50fAXff3EerOMRupOkYZNJEPkZFwbLzD+T2LHT3dh2lQ1wcOdPSM+llQO3GnXv3GpAonnP1EFm6qDapfcbww85y8KrwxNjYB8i3OImJ15mx+Aq58T08oBZeLUxJhxZK0uV4RS3wcGnvQTeYeQLth/dggsqLCmMz9k/XH6Jr4ScZ5yBohI3bt0HZneJQFAf3Q/mxNCP06MH4MfjpFBjLa4M7VLT5ExST+sYnuWtFjH8zGQy7e1UFow1Nv6QgW0zY+m7PoZbFqijDpNmNcMR1DJaTvrbCQf/W9gtAjeb1ckfMzMSK+h61uhLnZJWDkFIpUJhQiDP+14P6n65dJ5GVbmlhtPSbuRjUFzLvAvR5EjsZ2e81TDcDGUFih2PL+1msJjkd5BHp8onCB+NcuX4G6DN/jb5i+mW8CwuZVL9z84PzbBWt1oSXpAagczLDoNWcNKWWBHaZ7eLfqaP/QBMHszhWjin4NbEyLtGgASG8o2BzhuIGjG3LerCKxeDlpLkH4Vxswqnwq55dlJApfSoFShMXYvpo85rK8vFw2brqE2X3byinnquJFxZ74qrdxEYG1UUeuiJGSJnqauIiJo5r8kDE74EAJfEdu6Ggna7mpZD2kktJtCN1dwt5N5aGr3dU9cApB8y1kc7XL3FpVEITZhroRZ1g5R/3r0fnbjtvn2t2lbt5FwLZgk7tryxgWulk8zxdDvyPOZeZtFbGMQ/4xPfAywTSu9aFMCtFw3Lgy0Fy/bNLlKcBIOcTFdbNuT5p55KRqsi2wplzBiQRTYfQ/MzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66946007)(6486002)(54906003)(5660300002)(110136005)(508600001)(316002)(66556008)(966005)(2906002)(31696002)(2616005)(66476007)(186003)(26005)(8676002)(83380400001)(31686004)(107886003)(82960400001)(53546011)(4326008)(6636002)(86362001)(6512007)(6666004)(8936002)(6506007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckdITVV0VGZHSHpHTGRUdnlwZm01Q2ZoaUEybXVSNGdVeXdFWGtrQXN0V2g0?=
 =?utf-8?B?ZFBrNnA2cTRaOTFmUjI2YnhEdVZUQ1JVeklDaWZEL2ZtODhmU1ZhUXBCVjRK?=
 =?utf-8?B?VUxyQzJTM2ZVTHpaZVh2YTMraTBHNlVrNmpJK0tEUGdxK0k0WDVDL0dEM3li?=
 =?utf-8?B?WFRCclpjNlovWDNyN2hyVlViUDcwUGpnd1lldGJBeDNhbE9hUWpDVFBmbWxZ?=
 =?utf-8?B?d2RqZllUSEFwSkVvRmU5ZzYrQkxzYk1ieC9nUmRyYTgyL2tNK0xwc2prdUV0?=
 =?utf-8?B?cnlBNWtZN2pacHRNeGVWT0c3MUF2T2pUd0FxRG0va1BDSmNXU2RIZ0tBOEp1?=
 =?utf-8?B?VDg0UktPbzBLa25mMnVOeUkzZ09GMEt2Z1RNb25pckxlc3VXTzI3ZHA5eUU0?=
 =?utf-8?B?djI1TEF3QnBlR3JQOUp5L1A1QWxQVFAyK1MxMFVtcUMwSFNOTWVWMmhNR2ha?=
 =?utf-8?B?bmxmSHZqVzVaNGRYL2xJZ2xlS2JMMmE5ampPRUhEWHZIQjFYckRCWFJ2MkJC?=
 =?utf-8?B?a0NHTXc2enBUMFBXVGNCZVNtQkJTOHVEVzVyb3BBL0N0VmhzSTE0dzVpdjV0?=
 =?utf-8?B?RG5NczE5OXljcDlsa2lINHJTT2N3N0NxYWxEVFRGS1kwNWRpMUFLN25ZMHor?=
 =?utf-8?B?c241YmwzR0xGdTBhQmdPaEljekpRUHFkc2dweVZFQzZXbWpOM3hqMWF1TU5k?=
 =?utf-8?B?cUMzTlI1Slo2UWVVRWthOHhsNzk3eXBIT0NxeWlKQ01XZFpmSERBNmdHcVlI?=
 =?utf-8?B?NndpOGNRWlJTSURwWWJsVGUrOVFISk92cW04VDZ3MFpWUW9lTjZtVXlUWTR6?=
 =?utf-8?B?WHpRVWlheDhoZ0xoN2RTNnVkemNCRnZ6cld6Tlh3dEUwRmRvVHFIcHNHekhN?=
 =?utf-8?B?N054TUxrOEplU2ZsbnBXY05kRHVaK3JvbzJTLy9PSWxCcko0aEFEVTg0cE82?=
 =?utf-8?B?MkxLRFA5dUlva2VZOWNvd0dyWmtHNUVqb0V5SnBKQzRzbkZIWngzUTdHOUNS?=
 =?utf-8?B?UjYxTHFOdDJkOUE5R3dwNGZZWks3NnhVLzk3akQ3anBXSUpHbWcrMDlCKzBW?=
 =?utf-8?B?TkIzbUdXNHJRU0VlUWw2UFRUSjhoVTY4WDFZVzVoOVlDSTRhaTNRcXVoODVJ?=
 =?utf-8?B?QU1QOWl1Vi80bDcvUnFyQmgvT01RaC9LdG1SSVB1WTlQajlocTJTbzNjd0pN?=
 =?utf-8?B?cUNPbSswN016NmF2WWtmOWplUUNuMjRpUEdvaHczVW5qTUFETGwyYnVPTndF?=
 =?utf-8?B?d1dCb25Jb1dWNUVlYW5adjRMUUpBUEkwTHMySFZXQkhpeWxJK0YxTjYzOTNa?=
 =?utf-8?B?cXRNS3ZaY3hBL3FzWjJobVZNNkM2K090VTMxcHV6eU5DdUtCMXJ0Y29YMlhk?=
 =?utf-8?B?OHcyRzVab2xVbmQ3VjIyeWJYRWlMVTRySEhCMC9PbXRjbEJaVlQyS1h6RGZ0?=
 =?utf-8?B?ZEdlRVRFb0d2VFpOWFUxNDFGUjRJUDVEck15cnNDeFFybGZWRjl4ejg0QXJB?=
 =?utf-8?B?cUNtcXRYQXFOakFBanJjL2dWT1l4TlMxdkc0R2JVK0RsOUdQNWlKYWtGRTgr?=
 =?utf-8?B?L1hMdUkvQ0pIdEVOVU8xMTMrMlZMUU1mTEZ0UDRlakRJZTVLYTFrNUFRS2Y2?=
 =?utf-8?B?RXpuQ0tMblF4cmMyeUZySlJ1U2ZSdkFwVkEyVUFWOUt4MHE4Mzd2WGhrVHJr?=
 =?utf-8?B?YVg0d2hiUllOazZaak13WEd1V1V0RFhMdi9samM0ZU0zT2svMWhUTU1sL3R1?=
 =?utf-8?B?ZWh3NFd4dWQ2UnUxOEs5UkZ1Zlo0aWpjRTBOSzdmMjVWT1ZhTzV5UlhmaS9l?=
 =?utf-8?B?OGlDbHZzeTJBeFE0YUtLMUp6Mi9rek14djY1MDdGTmwxTWVjZkE2UXNnMnpU?=
 =?utf-8?B?SnR5aHBvM2dqK2Nabnp3L1NiNUtzd1ZuLzVsTVdjbXh4YWZvMjVQMFJQQndI?=
 =?utf-8?B?OHRHQUVSeHpubUgwRTFlLzZrYUlZVUo3Tk1Zd0Zrc2swdUZpdmUzSTBSY0xS?=
 =?utf-8?B?Ky9pMUhRMXdKWEdVV1FncXVuRkxhWFJrTWpXMlM1ZXhqTTBtQUY3OG40Lzhh?=
 =?utf-8?B?eDduUnJ4Sy9hVUZ1aVBWb05DNFhmSG13eHNRNCtCMTFjZ0F0SzdHSGhWb1Nv?=
 =?utf-8?B?M0RBUmttakVyNGZncFBlN1VuTk5DWVAwNDlEMnRBOTcxUWJiZkJiVFV3akNC?=
 =?utf-8?Q?pNuJHtqjZm7g6maIG5nwfAs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c44a1d-c55a-405a-b07a-08d9c0624a40
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 07:04:23.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzCdk6NhIwFK/RzEJz4x+70WMLvvRrO+mk1C3FL73+FJwQ0oSdwXYF2K6WYQ3J9RHumrWQl643OX1hy6jPllhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3333
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 12/15/2021 6:05 PM, Borislav Petkov wrote:
> On Wed, Dec 15, 2021 at 03:00:13PM +0800, Carel Si wrote:
>> We have verified by hand, still can reproduce this issue.
> 
> Ok, please give details how exactly you reproduce: host, guest, kernel
> versions, configs, machine types, i.e., /proc/cpuinfo, dmesg, etc. I'd
> like to see if I can find a similar machine here.
> 
> Also, would it be possible to upload your vmlinuz somewhere so that I
> can download it for testing?

The testing was with Qemu. And we found that the hang is related with
clang-14.

The original report showed the kernel is built with clang-14:
        # build kernel
	cd linux
	cp config-5.16.0-rc3-00003-gf154f290855b .config
	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install


And the clang-14 generate different code comparing to clang-11. I pasted
the native_write_cr4 assembly code generated with clang-14 and clang-11 to:
https://zerobin.net/?ced930258536c677#U6et+H97oxbpdYclFvAX0F3ha0rCJctLE53mJjDKrgo=

The extra code generated by clang-14 is like:

ffffffff810b8784:       48 89 d8                mov    %rbx,%rax
ffffffff810b8787:       48 c1 e8 03             shr    $0x3,%rax
ffffffff810b878b:       48 b9 00 00 00 00 00    movabs $0xdffffc0000000000,%rcx
ffffffff810b8792:       fc ff df
ffffffff810b8795:       80 3c 08 00             cmpb   $0x0,(%rax,%rcx,1)
                 --> Qemu reboot after this instruction from x86_64_start_kernel
ffffffff810b8799:       74 08                   je     ffffffff810b87a3 <native_write_cr4+0x84>
ffffffff810b879b:       48 89 df                mov    %rbx,%rdi
ffffffff810b879e:       e8 cc 7c 64 00          callq  ffffffff8170046f <__asan_report_load8_noabort>
ffffffff810b87a3:       48 ff 03                incq   (%rbx)
ffffffff810b87a6:       5b                      pop    %rbx


Looks like KASAN related stub generated by clang-14 (KASAN_SHADOW_OFFSET and asan_report).
This function is early function called before kasan_init.

Looks like we need to disable KASAN_SANITIZE for arch/x86/kernel/cpu/common.c. So clang-14 will
be happy with this kind of early TLB flush? Thanks.


Regards
Yin, Fengwei

> 
> Thx.
> 
