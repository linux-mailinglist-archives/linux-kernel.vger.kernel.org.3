Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9649B433
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384057AbiAYMnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:43:09 -0500
Received: from mail-bn8nam08on2062.outbound.protection.outlook.com ([40.107.100.62]:28383
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1451799AbiAYMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:40:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKdB/Lh8RcR6VNAaMpwyWciN4GKZBuwcyLfE+lIwVwCt5leCQ+b5pMaVQFQemmHcIued7OOpD+0jwp7bHFvlpTgY6/fjMPGChSXj7oZRheQZztTN8NxxyLRXSrWe4Pp70lCrhpQFX5WUD0tT7u1K7JqWdq0tiOG1AyIyc0KZDJ5FDOW0TqGJMj+ew6CggSLNIw8oca9cg4dS5XWrx8EFzzfIWDUE0n8tqqnpZQPeTwYzn7POshtuxUTreFCWPsTGyiJkb6YSxOyIi2UX6NdhUH0RMcT9Ek9JQmWvBsT1FIe+VPYAbIWax3YzhOYh5XnczpUSZ/5e/u7Zzv/+Ptagjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wO3eeAISLzHXBXLjoELWN+9TwTchQLsq0OSHp3UhY2w=;
 b=HSYRDhGj6zMGdx9EbB5L1I1YJ58OHw1Ur0eYMaQ8EoPxP0ExLdLqyPT3H/dpchN2B7CIMfznZHRgGFK0G7y5lhxyG9HnF3dYZ2iL/kjvTy5bH93wicowXgNJ/WErxEmJxRR0O9DvX4DqEXPW5ViVkF27/w4d21+qQobyzhPWDtHZWbWokfa6khgwOq3Nd0ZaTjdSZbsMewulhazUU0LJprQVys8GrvYXQn4kYytuN31R6M972i5Y4QMiIDCFW2wMpbhAkmzb34foQOH7Ip7Fjf7t/P8Gtddkdu+9jTV3Dwn/AWjw+IX0r7C9D6jvzFYxzNP1gnJEN8jjd/LaoqBX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wO3eeAISLzHXBXLjoELWN+9TwTchQLsq0OSHp3UhY2w=;
 b=YFftvxSVesI6cwY7+bci3oIB+P6n6HAJ6a1NZMt+0JFKpBuatfxHZAnW0W81clQNPoHaDdxVeolT5BreQKL3YhFxhAnBOZX3ihPeM8U+ec0fdjqDqGgkX4rWen4mWT1N/BAnkIAVJ71ZACynvGowixsg96lvJ55dzOnZHZ1W9NcVOjGWVQCZDxPnj/aVzJ48XcJn6SYlG/yoNXBu0R1N8jcMxInNPVNj7VFWsrTH8dZDxm8Zp11RzkMo44kV6MlFgWk+ZcLKCAnqICUHzcUBsriPUoyurCXWmaQQ+piwVbjkAjPvGzEmLYVnwOLwuYsigKD+SZBnmjwBdmytgkP4Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MWHPR1201MB2493.namprd12.prod.outlook.com (2603:10b6:300:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Tue, 25 Jan
 2022 12:40:34 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 12:40:34 +0000
Message-ID: <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com>
Date:   Tue, 25 Jan 2022 12:40:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Content-Language: en-US
To:     Wander Costa <wcosta@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20211029201402.428284-1-wander@redhat.com>
 <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org>
 <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com>
 <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43ae2c43-2ca6-46e3-56bc-08d9dfffe155
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2493:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2493596FB37C0C31EA24D867D95F9@MWHPR1201MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KP2pWzy/H7/rqAObHZ/J/57ZtCdVIWwWgW0E9vRj/aI7EFKkUbtTi+I+f4VCbxGBhOaH82NS3st+kNUYWVEwiwTvz3u9t3n6eA+IGbL3wgivZL991KsCxtKdRZUKD6gfvB7Av+vZBRPfmoToaehr+rjHbPmW2LEd9RDj8QzXiV+HHXAH1jBzxBoioCLjMymv3F97krLaskbIzY1Ay4IqtVLYhfGMaIjOGlpK5/sZqVHD7X7CKIv9sNMBT1Md6ux/SBbRUhwmIHgnYw1pkgusHDQqxXI+MOZ9Ns/xdy7foLiXtnEAmDMwh+W8fDKfKBwMh7u5XbntVkDiDYq+7YpDrF7uen7TtqiQGDhsWXyahXuHSh5veuEPk1Orim95iUVn7PhsXM6HvPzTtWpGt+IcOWOSe9Qmjc+TjDGVwMJNiaXjFfMlJLXHsyoQqhrVcq0/a6/J1H1QMMAuZ2g3FvWCsSrOraI7G/j3OGi4u4hqczvQGMxXaIRmYIqyHMmjkFCD08oojqFaIzOdEl4fCOe85mNhuFcOraUxUPOpgzclpUi5ESfi9FRvxmPRPj3QPu0s5K7M1aTuU1NL7HdBFHUIuc+Mh18ZLXPnoubOP2vSxl2CuPbmvwpE6/QKOZryg4M4R3ZzwB1C+Pd22PQWfLTjYO4rYz+JmMyUthCZsOu+GQjYAbJo2tUL6cwqKgsAEYDQtxIeKew4uYI2f2yehzaOtAE+21lHd1bx1DCJwAOP1JUxYdQI6IEEUiZN1M6KHgPD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(54906003)(36756003)(5660300002)(8676002)(6506007)(6666004)(53546011)(4326008)(6512007)(38100700002)(8936002)(31696002)(86362001)(316002)(2616005)(7416002)(66476007)(508600001)(66946007)(66556008)(6916009)(26005)(186003)(31686004)(55236004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTh5emxDTkNscXdjM3Z3emlUZ3lzbC9BV2dHMk5acGFiS0ZoNmU1TC81eFJL?=
 =?utf-8?B?ZTlGbk9POW9RcVMwTisrZGVHdjhGd0czckI1MG5pS0luTEozQ0VIN1B6bzJ1?=
 =?utf-8?B?WTNJU1g0NTYwUWNmWTg1WW42dXlyUVlPSXArUlZ1ZHZmSWhmd3dxdnBZUFEz?=
 =?utf-8?B?WTU2R1M5azYwQzZIWThaR3hvVTQ1NWtUdjJrOTV3NEZCd0pyUiswVzVuTEh1?=
 =?utf-8?B?T0l1NTdab0ltWERUWG4wb0ZFVjUySXg3ME82UmczOW9DWFFtb01ndVlwNnN6?=
 =?utf-8?B?aDlzR1BlUWQvUmdXbG1iOUlkNjE5UWhseTl5UzZMaERCYWgvcEJ6V1JwQ1JR?=
 =?utf-8?B?N1ZuZ1JyREZFZVl0YkFGSm1vU0pyd0gyT2FIMFVtTytxcHZubWZIb1FGVzdO?=
 =?utf-8?B?YVlqdCt2TkNzMVlNYUR2dFBuVlVUbmtGeGVZRWZySGpZZEVXQ2Z3NDU0V3pm?=
 =?utf-8?B?cU85T2liRTRQUHhGTFY3SnNHOHphTWVJczdrdlRzMUxXNjhrS0hpS1ZVY1VE?=
 =?utf-8?B?NDE4SUJQSXNzcGNGNkxaOTEyWjM3ZnFoenlKMkh6bXhPNzNLOEF2aG5PMlUz?=
 =?utf-8?B?Q1VkdzlINkxLSnl0Uk5TWS8xTGQxMkJjSUR6M1doMGZCMUUybkcyN0s0dklD?=
 =?utf-8?B?UndHRlBVRzd1RFFKaVlaQlJWSUNUcXVTY0paRkpPUVJpWjRBUytSQ2MyaXpr?=
 =?utf-8?B?djJkNDQ2SGd3T24zWHp5RnhmeWl2d2pIZTlxZXM5QjVZY216S2dFbzliMmZ1?=
 =?utf-8?B?NDVWUzRWajgvaVljM3l1NWVDeFNxdkM2TnNTQmRUUHh1RWlJeHVZbHc0MjZW?=
 =?utf-8?B?bXpWWFgzNTJPdWVSekV6QWVhWFJGdnRiT1VBZ2ZaNFYvT2tnNkVaZ3puWkVk?=
 =?utf-8?B?S2RCTGJRVkM4Z2lXWXliWVR5bE1ZdlRlVGZudW1mN2NZYTAxYnJheUF3bmZq?=
 =?utf-8?B?MHhXTFJYSTFWUFdQZWR6UGlvV2k0U3lnalNUeUNQalkyRndHeEZjTmgraVJx?=
 =?utf-8?B?M1dsbjNzSUxseWN5QTFDWjB5TGhJQzFUOHV2dkNsc1ppSVlNWi9Nb3BNdzdq?=
 =?utf-8?B?cGtieWJaS2RTamJkcmh1NU5aWFlacjh6WXpwQTgrdXR5WmI2SGs5T1ZqUWlS?=
 =?utf-8?B?cFQ2My9GQ285ekVJcG1MUEt4WElPd1lnUkVrM0FVcUtiMG5ldll5WDk0NnJN?=
 =?utf-8?B?bDJYaGpwZGhrTmMrcUljT2U5YWswTmc1MytGSXR6NVh5VDZFRzM1SUlKUVgx?=
 =?utf-8?B?YmRZTjZPRVNUdG1CM05zb3ZjdUVxSytwL3ptQldPeXFIRlVxZTRKRTg4RWZp?=
 =?utf-8?B?Vm5mQ3VQTCtxTFJYUThPaVpOYVBoNytlcFRkakU1a1FteUxTM2xaR29tY3Ni?=
 =?utf-8?B?YWxoQmFhTjFtWVc0T0dhODBtUTgwUC9tRlNaZkhxRXR3WGFidFd5dlh4eTlx?=
 =?utf-8?B?d0NlcE1KdnRzaHpEcVVLbWlpSnlZZUlwQmZ5N1VmMDdnU1RwU0FQcFlYck9h?=
 =?utf-8?B?eFhZdDFGVW93amhkOWFDSFVMNlJmRkV6QkZZV1VkQjZFUkY0YUVOMnhpcGhZ?=
 =?utf-8?B?aE1lRkJnRUx0ZWZlTUllSkJ3RFVVamE4cmJHQ0ZHZDZsa2owRzdYajBRVDVE?=
 =?utf-8?B?QmlObEtlVDZNOXJyYmEvZHgzcm8zclFhbXVqUmlNanh6WVN5WDlja0FRRVVY?=
 =?utf-8?B?VHNqdkJBRE4zOVQwT0xBMjNFSWlJV0VSZng5aSs4d0h2K3lMaktDVENBQkFq?=
 =?utf-8?B?MnlmZnR0M0w4ejJPNG50ZC8yaVR4Y290NG5JQUJqMUJsZ3VUZ0hvWkEydHpP?=
 =?utf-8?B?cTJVcG9GYVcrSnlkUWljNVNjOWs3YVEyZThsWHdCcTB2NjEvaWlLU1p4YjVJ?=
 =?utf-8?B?c1RscC9UUHRaTERDamZGK1dsd2g1MXVxQkIzVHJYd25NZXJ3ano1d3pRRkN5?=
 =?utf-8?B?N0pLL21lemlMYWl1R0V6Z3FUbUU3a1NOeEJhRGdCeUlpY1ZPNU95M1dwdFRK?=
 =?utf-8?B?cHFaMWE1cTVQSzJMMmFkNEMxOWxtRjRwaWdjZ0dtY3QydTBmc084MnRDbmJM?=
 =?utf-8?B?QVduQVZCdWVxSUxVeXVVUXVGQXhqZGc2VGVOazJFRkdadUhFbmswQ0FPYTVF?=
 =?utf-8?B?aDh3RjdqVXJqT0NGd254cVNqVTZuZWlrYmVzR1dQN3YvenhFYU1kbFpINElm?=
 =?utf-8?Q?i7w4Nxxxz41BbaQJX1MIB1E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ae2c43-2ca6-46e3-56bc-08d9dfffe155
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 12:40:34.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P80UPq7cXopGsH67XB+xDhh8K09THB2Uk0qndNutJYxEj/I3lJlzBLX5YiGRcq+7RiIDNezxPouMt/cTY6Bkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2493
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/01/2022 10:29, Wander Costa wrote:
> On Tue, Jan 25, 2022 at 7:06 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 25/01/2022 09:36, Jiri Slaby wrote:
>>
>> ...
>>
>>>> The test is bogus:
>>>>           use_fifo = (up->capabilities & UART_CAP_FIFO) &&
>>>>                   port->fifosize > 1 &&
>>>>                   (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO)
>>>>
>>>> FCR is write only. Reading it, one gets IIR contents.
>>>
>>> In particular, the test is checking whether there is no interrupt
>>> pending (UART_FCR_ENABLE_FIFO == UART_IIR_NO_INT). So it oscillates
>>> between use_fifo and not, depending on the interrupt state of the chip.
>>>
>>> Could you change it into something like this:
>>> --- a/drivers/tty/serial/8250/8250_port.c
>>> +++ b/drivers/tty/serial/8250/8250_port.c
>>> @@ -3396,7 +3396,7 @@ void serial8250_console_write(struct
>>> uart_8250_port *up, const char *s,
>>>
>>>           use_fifo = (up->capabilities & UART_CAP_FIFO) &&
>>>                   port->fifosize > 1 &&
>>> -               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
>>> +               (up->fcr & UART_FCR_ENABLE_FIFO) &&
>>>                   /*
>>>                    * After we put a data in the fifo, the controller will
>>> send
>>>                    * it regardless of the CTS state. Therefore, only use
>>> fifo
>>>
>>>
>>> And see whether it fixes the issue. Anyway, of what port type is the
>>> serial port (what says dmesg/setserial about that)?
>>
>>
>> Thanks. Unfortunately, this did not fix it. The port type is PORT_TEGRA ...
>>
>>    70006000.serial: ttyS0 at MMIO 0x70006000 (irq = 72, base_baud = 25500000) is a Tegra
> 
> I see PORT_TEGRA has different values for fifosize and tx_loadsz.
> Maybe we should use tx_loadsz.
> Could you please give a try to this patch:
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index 2abb3de11a48..d3a93e5d55f7 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3343,7 +3343,7 @@ static void serial8250_console_fifo_write(struct
> uart_8250_port *up,
>   {
>          int i;
>          const char *end = s + count;
> -       unsigned int fifosize = up->port.fifosize;
> +       unsigned int fifosize = up->tx_loadsz;
>          bool cr_sent = false;
> 
>          while (s != end) {
> @@ -3409,8 +3409,8 @@ void serial8250_console_write(struct
> uart_8250_port *up, const char *s,
>          }
> 
>          use_fifo = (up->capabilities & UART_CAP_FIFO) &&
> -               port->fifosize > 1 &&
> -               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
> +               up->tx_loadsz > 1 &&
> +               (up->fcr & UART_FCR_ENABLE_FIFO) &&
>                  /*
>                   * After we put a data in the fifo, the controller will send
>                   * it regardless of the CTS state. Therefore, only use fifo
> 


Thanks. Yes that does fix it.

Andy, does this work for X86?

Jon

-- 
nvpublic
