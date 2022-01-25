Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465B449AFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457100AbiAYJOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:14:11 -0500
Received: from mail-bn8nam08on2073.outbound.protection.outlook.com ([40.107.100.73]:17121
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1455320AbiAYJEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:04:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIK+4TOHiPZ3282l1UKKAeEtRDw3svPvgVrCZuenpE5l/t1BHzjeYsWwmzOqlkBqGbUvM/DSB5MBvDIon/gszuCQp5j7RXRzBdK/aOTaPS6py6EBJqAHUN6OxQmtALhXIcdwxLB0cM4BCA+grPV1oR3+ZltjATOrOvrbbu+Hme8Wf5wP+Esxh6kMirpZd+M5fA4HC/BqVb0bjhhquQjx90GL16auyYfo4jsvLTwVced7pIrMNTaLVq29yFRXjUmi143plUIp0t8DopzRHOJGfziV6ljfw86V7nlKrz6590VXqKbuJ21cRU9/ubtsDh79OLBAsT8KcmiZnNkIFDXPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRbR1wl8YFQLvlYLd9ZyBWtA6wIS9YPtz32hWEzOzbg=;
 b=FOMdlXcRBF1QvnwRl+SgT6Tmw0Xys6Sq8T9UaAN0k3OTLq8XzoQUtAedAbpJ9YcNubjFUyfKEL0latQa51VRlKx+crWoZ/z08zmEQODwnwbo33ScmpEo+uLoFWAhd5sgHIC2Q8mPLdTTOfBLUD7HjBZyX0KKwxeI42fG0SITVN1kjX65amfM8kM70FZ6borJY39TQr/0Y4BUdeBN135gKzQ1R6f+gf6oCywLGoLtZ1elb2NrumTtigq+qZLe1e9FOM93ZwKAkmZllZTDFYmKyssfnWtJwpfUfPOvV7QCTuyEpc1Hw4zP7heaICAOr/iXEpb/QYMFYJfrKhn6AmwKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRbR1wl8YFQLvlYLd9ZyBWtA6wIS9YPtz32hWEzOzbg=;
 b=D4XkqSVlaMOrYW0AedqnUd7o5l5T366y+StxgyYYJQ26NMYMEDW8ZClBE8Tl8tEK/jtzTtCpX2wMkBdRI3wiw8po61Gcyq2zae3KYm1lmGohHmLUm2Nj3IYrrAQJgiwjbHmd7vlf6rSS2r737YKH6KkAU8Uojm5aTFCY4Jrx8UOQvrb8eyPmamYVINRyBNDZaXVOm01StLsWXU4l5ZXnI0dPgvxgVB9kgvqRZHT921TUKxKB+c12pwZA3LBEmfmyfCsvZC7tbGxYsAaWQnIRP05WKer/dK+WeQ6Go6ZmD2Gk7MqZ0zfuD87DJlm/NhV19m1DggHz9GGu0i+8UKYYNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Tue, 25 Jan 2022 09:04:03 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 09:04:02 +0000
Message-ID: <a58783f8-ddf3-dd18-d3f4-fb80a1cefc8d@nvidia.com>
Date:   Tue, 25 Jan 2022 09:03:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     wander@redhat.com, Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20211029201402.428284-1-wander@redhat.com>
 <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <Ye+5xrJ2kC85E8QT@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <Ye+5xrJ2kC85E8QT@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::31) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dc7a8e4-6564-44e4-68be-08d9dfe1a19d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4059:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB405995CB667AD27263B018FCD95F9@DM6PR12MB4059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KHradRXQFh5Fs3Fk72V83AQ4xvl5VNW01MuWJ5A3JlunPIl99NLfwA2pKGT0dOTFXqdP2WiaLuXFNFF0us5utQvZ8elBkIMnCrW63tKzFfdMY93tmfUIp+13666gUJgYBpkxTPSsEIA1zpSKnbmJavUF8mKPOSAD8ttfcjhQMQ7bE9Zkac1Fvdnz+NIN81CWFT2Pyp4SsHy0rjlW/XpG8AMWRmrEZLjNNqspJiyiwNxtmW7hNOvyCZlUaOsWyxCG5y+BQyAopIe7LtrK3TKpqaFdLCb+R64h292ArAAF0ervQWTjndRzPMUEHi1omAULGfCDtdpfpABzqAsn7YoO1JGx8eQKTtsM9QXgxdRGfF5IAyO9uH6xnWx0DrkvAkkNHk3VBacvSs8CtUM/RsGqgN+e/lvSR9W0nM9UO8Tpn36yvPkIXjakwR2+vr+/58L6hxWGHwdRv9f4R/DvqhRA4s3orXdvYpz4x3lzg9XmUx5kULSJyljBr4zJFt2/hCJQ0fRYvMKGMtKxj1Szq1X99taks2qZiINHj1zTstWURT/JZjLfIDtRaiZ4lGri1uO+aSXXmMs/OiGPYtk16h+LZGZL0NHINM2oCp0YfiUHYODIjxonNknG/4qPyBYNnrKroj594FotpV5hAY7ea4VK7uPbD6jY7UJ4IZda8+qL0TCR2I5LgTkSSciQgqadFAizh03cF5uZl9jPi/OoExOoXIgz4rItfUrIeLJHdMgYd/nfUvQju6diguc3bXmcHAo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(2906002)(8676002)(66946007)(508600001)(186003)(6506007)(6916009)(316002)(54906003)(4326008)(66476007)(8936002)(66556008)(6666004)(31686004)(7416002)(38100700002)(6486002)(6512007)(5660300002)(26005)(83380400001)(86362001)(2616005)(53546011)(31696002)(55236004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNmVVltcXR4VDJObVZ2K09lTjdMMndiVXBqdUdIc2hWMWt1N0Ntencvanlq?=
 =?utf-8?B?K0JDOERSSVRGTUxMdnBIU0ROdktjbUVQM3R5bWtuVjRwcEhSS1ZvU3VnYXo5?=
 =?utf-8?B?a2JjSTAvSmZOUlhDMzFERTRySHlTeEU4eE4waXdCcVkyeStHNjNXWTRFS00y?=
 =?utf-8?B?YU9RVGUvTmc5eTF3VEI5Y2c2MDlnSmxoVEdiS3d3Rzl3Y2x2NHJwT2FROTNC?=
 =?utf-8?B?d1FyR2g4dzAzby90YnRzbzVkc09HRzQ1YUJmWDlVMDVUZG5yZVlKWmtjT2x1?=
 =?utf-8?B?VEY0VEhINjBBb3B6cmdaWFJPOGYxQ0t5M3F5SUtoVTdtNFFoNm9CdG5wTzZh?=
 =?utf-8?B?eHJVQ1l5RHcvU2hQRXVwazljTm9kTmMyOFR0T0ZKcngvcWwyRERodzNLclVr?=
 =?utf-8?B?OWNqOUNXOUhQMlcvekF2SUFGMkl3QjRGdDNsbjVSY0lQRnpXbkZ1UUNmQmRK?=
 =?utf-8?B?NmxrVWp4R2IrYU9ZSTlScEVOZXBUT2FMTEVpWFJDOEY1SjJ3OFNNN0FHWnJq?=
 =?utf-8?B?UTNOQm1HbkZJMTBaWkhmZGFNWDJlV1grSHRZZnFreFkrZzd6emFrTHdzL1kx?=
 =?utf-8?B?Nk85YitlZXFmZUZkbWpJZjNVdkhzYkpSY3psb2t5bXAyb250YWZlVXNEMnBZ?=
 =?utf-8?B?VkxqMlNDTWhjT2JEMStubDFZOUgrQXhVemlKZEZsOWk0M3lnaTdnMXdrMXAw?=
 =?utf-8?B?c29hazZnTm5wMEg3aVE0NGdBTUc3UnZvK1k0U3NGb1FxQ1krSkFlTEJKamtl?=
 =?utf-8?B?SFFOVEpXVnhNNWRPQ2FDQXNQRFRHMXdTdUtnWExsenp1Z3V2bDBoNE9UbFBB?=
 =?utf-8?B?Z0tXaFVsMW1LaTExVlF4aEpTc01DN0QwcVFQclVGNVpsZ0JrYk1iSG5xOGNS?=
 =?utf-8?B?a0FENlFYVjlKTHYzdUgxK1FzN3lJNVQ0elg3VVRKL3NueTVqYVdZV3RqOXVG?=
 =?utf-8?B?UWpiM1poczRZVjhjMUt5RTNVOEpsVEFvNnQ1WFB0ZWNSVWJYak1EbU5EdjZr?=
 =?utf-8?B?RWJsL01tWVI3Z3RJRDlpQ1hxVlVOT2FmN3RNWmtrWGQwSzdMNitlVWpFSlh5?=
 =?utf-8?B?enpmU2JJMkMxdjNvYy8wUThZdC8rVDhaeU1DVDkyNWxNTnk1TGNlRnRrcXV0?=
 =?utf-8?B?dkw5ZnIxMWYzc09CdVV0djRJcnRmcHFBT3pLSUVBOUlKWXEwdW5TcTdBMWpO?=
 =?utf-8?B?RktIQWswbnZ6bFJ1SDIzdktBcEZrTnNLbVNTbytRdTlnTHNpTkFucVlVWnNX?=
 =?utf-8?B?SHpHUlB5a1Rtd2lsTWRlNUZ6TW9tdDZvV042S1J2TXJaYjBmM0gwTWtHTzBW?=
 =?utf-8?B?TitUM0wzMGEzaEhQWFpLVUc1RnlCdTJCZ1VwYk1kWEFQRjJzMUFvVThrLzBE?=
 =?utf-8?B?QnJabk5VT3cycnpvbzJyUlkrRHVUYldtNW5LZ1VNUHpmY1JTdVV2YlhVUGVa?=
 =?utf-8?B?a3dvUER2VEh3Uk0ra2dwajBEbUdiaXdJQStWWFVHS1FBZE9wVEhieDVuQnNX?=
 =?utf-8?B?TW5DeW9XamFnUVptT1VSak4wYTBzS1JSY1FkMHVzN0Fra1EzcWRTUm5rVkM3?=
 =?utf-8?B?eWlZRWRWU2xCTHh4TXZ4ekRiOXlTTTV1MWNMVUlBNGo3cnFyYnNSQnRHbFBC?=
 =?utf-8?B?TGFNRHZ1TTZ5VlowY3Y3M3JXRm84Q3FlOXBEa2hySWM3NFhyelFFbDAxMm5q?=
 =?utf-8?B?bk9EQlloK2l5Q3RrSGhOaHhvQ0lFYVArS0NqZ1dDelNkM2tlYVlDYWNXOHlX?=
 =?utf-8?B?UkhwM2NnUCtQdmFoMmdyS08xQjc3OFJNY1JXaGdFTW02UjJDc2NwV0xxM2E4?=
 =?utf-8?B?TDVteUFxUkNoOVlaL1dBZ3k4a3QxSHlmNGphZjdzNm1nK3lIRlBaenNKZWNN?=
 =?utf-8?B?NklOUDhrZ0FwMUVBbDZFaFlCb1VrdEhTaXFOdmlNSXJVMEcvZDFvZzNsS3R1?=
 =?utf-8?B?V3VJeDBUaUFFYndFUnlBQ0xWUHYzb0tCTUY4WDVqUVBlK2RJV2Q4VGVheGxE?=
 =?utf-8?B?czY5QXkrSGNmamtBb0RBSjBBR2JWeWszUWJJcFp3Ym9TNXpvSlBqTUJ4WlYz?=
 =?utf-8?B?SjdjWDd3a1VTc3BmTVdNVEg4TTFmcEVQek1mWUNOSjlOZVJoUlF4SXJtUjNK?=
 =?utf-8?B?eitsdVV3RWtYQ0FsZXR4b0dRVWNId2ppMDFpTTBwdmRpUzFLQnFnMWdrMzQv?=
 =?utf-8?Q?LDoZVQ70Yo8Tl4UO/SZ8uVc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc7a8e4-6564-44e4-68be-08d9dfe1a19d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 09:04:02.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKiPrwUjXtvSPTZr7G7CK2j6mHr+To1fYR90IiG/AfP+O+F0fXxCc1W4E611LWH7eVJszoP+9KbeH4jwh89ARA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/01/2022 08:50, Greg Kroah-Hartman wrote:
> On Tue, Jan 25, 2022 at 08:39:24AM +0000, Jon Hunter wrote:
>>
>> On 29/10/2021 21:14, wander@redhat.com wrote:
>>> From: Wander Lairson Costa <wander@redhat.com>
>>>
>>> Note: I am using a small test app + driver located at [0] for the
>>> problem description. serco is a driver whose write function dispatches
>>> to the serial controller. sertest is a user-mode app that writes n bytes
>>> to the serial console using the serco driver.
>>>
>>> While investigating a bug in the RHEL kernel, I noticed that the serial
>>> console throughput is way below the configured speed of 115200 bps in
>>> a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
>>> I got 2.5KB/s.
>>>
>>> $ time ./sertest -n 2500 /tmp/serco
>>>
>>> real    0m0.997s
>>> user    0m0.000s
>>> sys     0m0.997s
>>>
>>> With the help of the function tracer, I then noticed the serial
>>> controller was taking around 410us seconds to dispatch one single byte:
>>>
>>> $ trace-cmd record -p function_graph -g serial8250_console_write \
>>>      ./sertest -n 1 /tmp/serco
>>>
>>> $ trace-cmd report
>>>
>>>               |  serial8250_console_write() {
>>>    0.384 us   |    _raw_spin_lock_irqsave();
>>>    1.836 us   |    io_serial_in();
>>>    1.667 us   |    io_serial_out();
>>>               |    uart_console_write() {
>>>               |      serial8250_console_putchar() {
>>>               |        wait_for_xmitr() {
>>>    1.870 us   |          io_serial_in();
>>>    2.238 us   |        }
>>>    1.737 us   |        io_serial_out();
>>>    4.318 us   |      }
>>>    4.675 us   |    }
>>>               |    wait_for_xmitr() {
>>>    1.635 us   |      io_serial_in();
>>>               |      __const_udelay() {
>>>    1.125 us   |        delay_tsc();
>>>    1.429 us   |      }
>>> ...
>>> ...
>>> ...
>>>    1.683 us   |      io_serial_in();
>>>               |      __const_udelay() {
>>>    1.248 us   |        delay_tsc();
>>>    1.486 us   |      }
>>>    1.671 us   |      io_serial_in();
>>>    411.342 us |    }
>>>
>>> In another machine, I measured a throughput of 11.5KB/s, with the serial
>>> controller taking between 80-90us to send each byte. That matches the
>>> expected throughput for a configuration of 115200 bps.
>>>
>>> This patch changes the serial8250_console_write to use the 16550 fifo
>>> if available. In my benchmarks I got around 25% improvement in the slow
>>> machine, and no performance penalty in the fast machine.
>>>
>>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>>
>>
>> On the current mainline and -next branches, I have noticed that the
>> serial output on many of our Tegra boards is corrupted and so
>> parsing the serial output is failing.
>>
>> Before this change the serial console would appear as follows ...
>>
>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd071]
>> [    0.000000] Linux version 5.16.0-rc6-00091-gadbfddc757ae (jonathanh@jonathanh-vm-01) (aarch64-linux-gnu-gcc (Linaro GCC 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08) 2.27.0.20161019) #15 SMP PREEMPT Tue Jan 25 00:15:25 PST 2022
>> [    0.000000] Machine model: NVIDIA Jetson TX1 Developer Kit
>>
>> And now I see ...
>>
>> [    0.000000] Booting Linux on physicalfd071]
>> [    0.000000] Linux version 5.16.0-rc6-athanh@j-linux-g017.08) Linaro_B20161019n 25 00:[    0.000000] Machine model: NVIDIA Jet[    0.000000] efi: UEFI not found.
>> [    0.000000] NUMA: No NUMA configurati[    0.000000] NUMA: Faking a node at [m00000001[    0.000000] NUMA: NODE_DATA [mem 0x17[    0.000000] Zone ranges:
>>
>> Bisecting is pointing to this commit. Let me know if there are any
>> tests I can run. Otherwise we may need to disable this at least
>> for Tegra.
> 
> Ick.  Does this uart have any other quirks assigned to it that are
> somehow not getting assigned here?


Not that I know of, but I can have a look. I did check to see if there 
are any known issues that could be related but I have not found any so far.

Jon

-- 
nvpublic
