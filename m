Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1949AE4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451568AbiAYImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:42:01 -0500
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:29959
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376410AbiAYIjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:39:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+6MC8tTjUemezI1Ei1z4i4w3RxdtAKME1dl60KzKeX0SCS/YEfmAfx/xbqwfF4rN/QwWBybjr3o73Z90Ch4f7V0va1J/ApnvDkm6gfxaHYuzzt86hdjAvWn6C0O/OjRwV9XOf8Quk/ML62MpOWgf/a9U66IhqGsdA85I5HJLT7f5e9WCjzd8LS93ff2cRM6h8gar488NMNzFGyQcIs6d69Tb+FCDI8BUOfH0PHCt0HdhtqQFRiyV501gw6i+zdR3U8daqQ3ovo9KA0N2mxxh1YAVkyvcCxJHwa2d5W6VmVXmmJDR/7OmH8kCgOTVIrJeGv120ZRYtVrDW5eLjhXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z31SA35lhoH8FWykmGeKncvAwT5CngiqNP9OZj68Ars=;
 b=YYdRtzdOeGHr5pU2/4sVL0/8jGbjLHUSyMOeUhZPcA7koRTqxy5UCpT2rwCD7hziu3J/Ft1WD8bhzpKh9pZcyaq2sFbBbZ3v8LsWeI53uRR6kj+/B9ad9cuqzs0lIrTB7us1kEhasKp4nPBmvjelyikagOt/ERBJMJnVrI+OR/r5cLv1YlZNZD0m2C51R0ZB/ctQ3veZ1JEb+xwxicJvnbStHY3b23ocrAkXmU8zifRk9hBn36QupbLRQv5hEcBcljIdn/c6Cm6n/zMETGyqqkj9JByoJ2Pgrh4DizUxavgjdfhC3Tp6km0jkWMWWGFyku9RNWzkg8FHOq/uNuSxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z31SA35lhoH8FWykmGeKncvAwT5CngiqNP9OZj68Ars=;
 b=D/4990hpSB72dg7F2ELf2EsrNR16kkBYC8QWt5g9i94Uq8P1nnaA3VCUsEQk9/F/ocBDLAl3lISRHYFau7ZR0K1qBDcTibaZVrrbZ2kTOQJezcjr7AVqdKXBcguQvvJ+M4xkDY0xu63NzvIOzuLguTRObMu36q9CT/7S3ziNQRd6mHoWJe93zijyRyCUe3NL+0xd1A9fCEIdn8ZlvgKfGA4pfb3DmDNy7UAwt1Poop98Bd+/7F4J757M8YcMo5Rcy0IHggV+DVYP1BXv6/7gzZmrearEJvyc9yhvJdbq1r7B7sSUHpey+avj4Ee/hMUJ5mRgGjXLC660ZoNMVVydmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Tue, 25 Jan 2022 08:39:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 08:39:32 +0000
Message-ID: <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
Date:   Tue, 25 Jan 2022 08:39:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Content-Language: en-US
To:     wander@redhat.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20211029201402.428284-1-wander@redhat.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20211029201402.428284-1-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0060.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::37) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c302a60c-8df7-4245-8c0e-08d9dfde3570
X-MS-TrafficTypeDiagnostic: BYAPR12MB2711:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2711F690C8D0C1F533DBC7EBD95F9@BYAPR12MB2711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msvo8Vbotj+ns9f0VBLULgkcsGjl51zAxmRs+IeMwF2VBjfgFCscrEGdTIKsSoAgJV/ekC6h42I+BiVmB9kiuHgHkYK7BBrv0zznN+NLmTAMV9jAOqaLUWgWNlwukvXtHoy5CtgS2HJSS0A/L71g0Lg+1iGUDaYD3JizapvlIygGlTUuPd94L1mpgwZsP9Tjcwmrq5Wz/sj2njYq/ilyDBTV84wgJvEb4vADvcibGffqwC45jf8hi0ewrsIAHG6TWnYLphD5vvf3rz8gTC5a9dyOrCadHA/h4T1dDCS1ctIzrqyEroY9tgxflcUHh1IBtK2GiIPSiv/yDvUpIl/JxyRdaHOYBNXLNw5NDmKEeQJ5xo/40iziHJqaRnKMg3yE/85WStZF7EGp8MD2MsKWLCeW2Jh9RNDNu/RhAOweIL/x68i+0aoxpHy1v7thsPlxwbxUuopxJPqGGVxWhy0CsYHvg+YrQooMNv9RA9doGoP/3ihwKZvtZJf0YDydWv4CPi/498rCCn3ec8T/E9VlFmKqvGmrd8jZbONRPrfgvSHfxhE4q/MIBgYX67Ykre27qiZqJkKGH4/b+XWU05mEKu1Ranlw2Ek7eBh0EmMTxutrF3lW5peCbk3QQ0HiX1kHT5am/hlGKjedA/lfzLpdSC5vpj/Q0tMdNOCRrZSZBVGDYOdIwRpK2SFwFWiU9XQV3wp7wE4B++U/msQX9FgOe8iM2Ndit0QbZh6V2QF0+G0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(26005)(2906002)(31696002)(316002)(6666004)(54906003)(186003)(8676002)(53546011)(55236004)(5660300002)(6486002)(31686004)(86362001)(508600001)(7416002)(38100700002)(8936002)(4326008)(83380400001)(6916009)(66946007)(66556008)(2616005)(66476007)(6506007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZZb2tZdk80YTlheFk5cjBscFV5ZHZqeHI1eEx1RE9BSGhqQ2FUU1orQ2to?=
 =?utf-8?B?VFhESmNWWXFPeWZ6bzZ0bEJuNzdKTjdBT014eXcweU4zQ0RKd1I0R3VDZkZ5?=
 =?utf-8?B?bjNNV1lRcVUzNzk2ZXg3Q3puQWwvNVJuekVaaXdpQWZ0Zm5NV0VtSHg3clJw?=
 =?utf-8?B?dkZyb1llUWI4Uys2U3hEam8xS3FRU2NlRjIrYUVxODRHZ2Y2a1B1cjY4Sk9Y?=
 =?utf-8?B?SzhmUWYwUTFEc0ppQW1LckJKL05vUEYwKzdCeVQ4UUw2bWRQbWxSQlg0Rjhr?=
 =?utf-8?B?NHIwV1NiYTR0bEtGVEJodThiSHNZQTlnWGkxUkI4TUNIdStXVTdVWWxwTGtI?=
 =?utf-8?B?cDJTWWFURmc4UU12c1UrRWxyWDdtelg0OEFFZHN6V0NaMGdJbFJkSCs3U0wz?=
 =?utf-8?B?Qll5NllOOEwzRTN2SDRmZmN1QmxJd05Pc1VnSUY1bmtILzE4YzRyS3lBc3FT?=
 =?utf-8?B?MGZuTGJTZ2tMamd0WWdCNUJuYW5BM21heWJGMFhLYXduVGo4YWIzQ0EvYWNW?=
 =?utf-8?B?Q0g0d1NFQnUrWi90MVY0QTlBZmlPMG9zVlFrRlB6QmduYUJaVjBEWkJDanVT?=
 =?utf-8?B?UUUxUTFvZUYrSDk4MmZmSjY4QUY5dG1rU3hpN01SRk82UzZDRW55QnBMTzJp?=
 =?utf-8?B?WmozTEprcjdqUzNYTmkvbXk3Ym5RUndJUnZVN2JEeVJjNG9uSko0ZDJHczJp?=
 =?utf-8?B?NGY4eEdEZ3Y3WkYyYTk4dERRdnFMNmlCWlRrNGZpOUd6WUc2NVBRSjVrbjVL?=
 =?utf-8?B?NlEvZ3dScWJzVUpNVU9adFJad0k2OE9HOHdIZ2Z2aFU5UXJxYmJ5Q2trcHFX?=
 =?utf-8?B?QzR3MVNWSHE2TmlNZWxqczBTOG9pWFBjZmFITFRyRjR3dWxEa3IzczlDd2V6?=
 =?utf-8?B?bGl0SG4vcVFWNUt5Y2x2b0hrQkMzbWNNTjhrMFU3MFY0Z3NsOWs3NnlaMkdq?=
 =?utf-8?B?RkZTazJPZFE0M1Z4SXJGeDIyYXIyK1BZZ2Z6cmJHTzJjUWJ5RXptajBYWkFO?=
 =?utf-8?B?SGNYcVJoZ2h0RnZGcHBZTjIwZHl0VTZTV3VPdUlyOXZRYy9aekc1VDNjOWNw?=
 =?utf-8?B?eG9OYk1GNTZTU2t3Um9ZM2M4Vlc5dHVJNTBPYW1iUFpyNWFwUVAycnV3TUk4?=
 =?utf-8?B?akw5SlBVVEp1MDlmQnNjZkJZZ1dRUzl1U3h1TStwNmRNL0h6U1haVHVXOHdC?=
 =?utf-8?B?V1JKSm5rTUFJT1lvVmZqdkUranl1cXVyVlVaemh3dWloS3VkSDgzWkJ5YTFu?=
 =?utf-8?B?NTdXdDF2WklsRVRHbEd4b0huM2hBVHhCMU42eGNMbVBLazhCWjFVd05DNmUz?=
 =?utf-8?B?WWRGSGhQM0crWS9zdUluNjYrVXdCOWNZVFFqQkFIckhuQXQwVTVhR1FsUTNR?=
 =?utf-8?B?M0ljT05yRnNoSTRiQWo2L3A5S0xhbHFrZFJzakFpRDl4OXN6QXZqc1J6RDZW?=
 =?utf-8?B?a0lSY25TaHhqbHBBeElnQjMrTXdCemUvcENLcnN2b3dDTGR0VDg1MmNWSnRr?=
 =?utf-8?B?SDI2blBKbytSNFFVSFVJY0dXOVBwbHpkcGhlUktIcFJ4eS92RUFud1NSYi9l?=
 =?utf-8?B?T2QvVmJoTTNJdEg5QXpzWEwyNmVJNG16WHN4NDJVWC9OcHp3R1g2bDMvcThN?=
 =?utf-8?B?ekNnelQ0WTdFZXVmOWVCRE50ZzNQQ2RveUdlak9pbW91c0RlN0xXcldPNzNp?=
 =?utf-8?B?bHdPRHhIUHZJOWNFR2VYVjBzSDNDbFY5cDR1Y2t5bjJreDZzdXJJSTdQM3Nz?=
 =?utf-8?B?WVpKckJzTTFIaDdMNlFkL2hVbUpYaDcxVlBHWmF1anY1OXNhbXEzRHc0c1Ru?=
 =?utf-8?B?Y2k4VUhBMWJ1ZmNmRkxvZWFHMnBBMDc1Qkk2NmUxQ0l4ZmFKTGp2L2VxRlRW?=
 =?utf-8?B?MHdMOXhzcmhEZEpOL3prVWs2T3B6YWJtbkRCTWR2eFU5VXVHVENiT3FiUXpM?=
 =?utf-8?B?SitxZUVzNnVod3FBbWErZnlkZGNERFNWMFR6NGtITjFBL2I1NkN4U3NjSWla?=
 =?utf-8?B?TDg5UkVwbzNyY2kxVkVVQ2ZrTlh5QmVCank1YWJwczNvb1FvTTUraE55WDdL?=
 =?utf-8?B?dnJOUXlqL01hY29lMUxRbVFVcDVTK0VCQUJ3ZDZYWkF4SG0wbzdiN2VjTDZU?=
 =?utf-8?B?WmVWVXdQdjZSZFBjSitoVmJqRzVYTUJkTm0ySS8rY05LTHRpdVNVMUFKVEJY?=
 =?utf-8?Q?JbjRoHcbAG2M+4fz1itKYa4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c302a60c-8df7-4245-8c0e-08d9dfde3570
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:39:32.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTWyreG87W0XB4lpliykBtWPGhNPJq2fTKc/rrUbtTM32WMuCd34W1CwO+9iUGviC/uszcPwDhneR7vLTt0oZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/10/2021 21:14, wander@redhat.com wrote:
> From: Wander Lairson Costa <wander@redhat.com>
> 
> Note: I am using a small test app + driver located at [0] for the
> problem description. serco is a driver whose write function dispatches
> to the serial controller. sertest is a user-mode app that writes n bytes
> to the serial console using the serco driver.
> 
> While investigating a bug in the RHEL kernel, I noticed that the serial
> console throughput is way below the configured speed of 115200 bps in
> a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
> I got 2.5KB/s.
> 
> $ time ./sertest -n 2500 /tmp/serco
> 
> real    0m0.997s
> user    0m0.000s
> sys     0m0.997s
> 
> With the help of the function tracer, I then noticed the serial
> controller was taking around 410us seconds to dispatch one single byte:
> 
> $ trace-cmd record -p function_graph -g serial8250_console_write \
>     ./sertest -n 1 /tmp/serco
> 
> $ trace-cmd report
> 
>              |  serial8250_console_write() {
>   0.384 us   |    _raw_spin_lock_irqsave();
>   1.836 us   |    io_serial_in();
>   1.667 us   |    io_serial_out();
>              |    uart_console_write() {
>              |      serial8250_console_putchar() {
>              |        wait_for_xmitr() {
>   1.870 us   |          io_serial_in();
>   2.238 us   |        }
>   1.737 us   |        io_serial_out();
>   4.318 us   |      }
>   4.675 us   |    }
>              |    wait_for_xmitr() {
>   1.635 us   |      io_serial_in();
>              |      __const_udelay() {
>   1.125 us   |        delay_tsc();
>   1.429 us   |      }
> ...
> ...
> ...
>   1.683 us   |      io_serial_in();
>              |      __const_udelay() {
>   1.248 us   |        delay_tsc();
>   1.486 us   |      }
>   1.671 us   |      io_serial_in();
>   411.342 us |    }
> 
> In another machine, I measured a throughput of 11.5KB/s, with the serial
> controller taking between 80-90us to send each byte. That matches the
> expected throughput for a configuration of 115200 bps.
> 
> This patch changes the serial8250_console_write to use the 16550 fifo
> if available. In my benchmarks I got around 25% improvement in the slow
> machine, and no performance penalty in the fast machine.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>


On the current mainline and -next branches, I have noticed that the
serial output on many of our Tegra boards is corrupted and so
parsing the serial output is failing.

Before this change the serial console would appear as follows ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd071]
[    0.000000] Linux version 5.16.0-rc6-00091-gadbfddc757ae (jonathanh@jonathanh-vm-01) (aarch64-linux-gnu-gcc (Linaro GCC 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08) 2.27.0.20161019) #15 SMP PREEMPT Tue Jan 25 00:15:25 PST 2022
[    0.000000] Machine model: NVIDIA Jetson TX1 Developer Kit

And now I see ...

[    0.000000] Booting Linux on physicalfd071]
[    0.000000] Linux version 5.16.0-rc6-athanh@j-linux-g017.08) Linaro_B20161019n 25 00:[    0.000000] Machine model: NVIDIA Jet[    0.000000] efi: UEFI not found.
[    0.000000] NUMA: No NUMA configurati[    0.000000] NUMA: Faking a node at [m00000001[    0.000000] NUMA: NODE_DATA [mem 0x17[    0.000000] Zone ranges:

Bisecting is pointing to this commit. Let me know if there are any
tests I can run. Otherwise we may need to disable this at least
for Tegra.

Cheers
Jon

-- 
nvpublic
