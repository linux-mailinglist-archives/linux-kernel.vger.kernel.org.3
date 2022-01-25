Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9D49B167
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbiAYKLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:11:51 -0500
Received: from mail-sn1anam02on2065.outbound.protection.outlook.com ([40.107.96.65]:6976
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241362AbiAYKGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:06:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwQYf3/CW0oU1exBc6Q6oxyZQ+A2wWi2cyJdqgLRoTdMtbpLqYtW4pI0mJyO+g5GTYERHufgRQ/8smunDCZe1bUWC5AKr3uIvOUMvBkzoCK0ojpThYPQqk09m+3OuxLv/PNbrZP5JNW5leL/IX4hnIqXDfFBAhsmCZ8C4i2fs1KRBz1Dv5ULtmIa6UE4rkI8d0soKhEzS588pHOV0Vo8LFy6o12xtaqAanoQsll8tKHEVrZdHnMBO+vkcLBfHQPRFT9NE3ziqMx3CWBW+rP2s3CDClhxSASVVFH5PpPoUZwZKGcpjbIyknKknxEzCZkF2MCBBBbK8DaL3Rm6sMo2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acms36xYi3pM7Q6WyPtOwibM3CYnLEmVeNIEMNHpQPs=;
 b=Zpz+HL1K/4ZUDsxzP2S4L4RDxfvYQHEKfOufWTwNZAiX1GUHUtNP1WMUWaqV1tB1JuVNemmhwrBV1mbyRyTpPYuXRtRmWPe2DHw5n2SMBHgsf0gzPDz5Abkt8cb3QjQmtnFWHjcV/FVbNssjMzghT+YBCTQ61qVdyLD8K5shifsv6ApTHcuF8xxMmuZdDsTJ0Rb0TXJegReq+EpK38gCL0hBa69bZ6NRuEt1MzDPe5CuuD5LyZty+zmvPrP62AjSoCciJaLE/bzsXfG8qlCG9wS4SYoeYiEaNU3v7lR+9oC8PXyEqelRxA1sTfimiz3pVtewV9ut7W5hXjp4HmxLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acms36xYi3pM7Q6WyPtOwibM3CYnLEmVeNIEMNHpQPs=;
 b=hOmvEQcKKM+dGWnNpsHjoPYD9qxlIGwTGp+WDzASs9uVLUSabNCieJ2UK34Vx350Mj90Vy3U5XmT9h5CxKzwKTKg9wI+1I/Jo+jz2cZk5Z17TvhgS3UsxuIjCA8jWd2zyYmo/NRq23Wd4GtFMVk+flYB2KvzruNNxtiPA4F+CnayQDdZ86lmbqmztH5bHpA90CE3YeUsSOauPXn5oTTfglSf7di9U+EE389FtpSsyje8ePlbCBSmACp95vmILBRrdnZ5t32rM7qazhl9/ETh1VJBbBRTqxOLGhL0ChDO/tqZcBH3Lm3MdvWXTQrgUaawkqXcAaZgMRNL/I2AdcXc8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BYAPR12MB3495.namprd12.prod.outlook.com (2603:10b6:a03:ae::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Tue, 25 Jan 2022 10:06:43 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 10:06:43 +0000
Message-ID: <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com>
Date:   Tue, 25 Jan 2022 10:06:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>, wander@redhat.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0601CA0060.eurprd06.prod.outlook.com
 (2603:10a6:206::25) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a38de3e-31b8-4fb3-3a31-08d9dfea631e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3495:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB349527E01B66324E43C0FE6FD95F9@BYAPR12MB3495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJAgVrlt9iD6aemKyzun3MNsFpzGcwtI7pVVRuIFQ40xROBGtbIsyaSXr7yLUcRmTY1wfPkfaBS1PkfzINZRLHxdxDbcgQ7vn0W/QO1/xJAsng6J/XmfRIzwLIG9DDb0+6ug2jNjIf/NydY+Xvz4t9hG94CNrlyPL8MCTD//8X7e8+IB/OAMbdnh4eT32HN9GnbZj+zaZWhx41k0YEMkkrSRLgKriK+HTTk3MJG3f+jTtBOP3jyechGAOlVgdOn2ugW/qcDypiKoueJOYlYQXz2dsYY73S2i8/BzGtI48KB4feqitc50XXo0bLBb0tQePEZQethKgyWzG+0b5StEE/gI1ydHBbxGLbDkGY1Ed4pw91hjUdM5g7lmR1HXryUcSnP20HT7B5kbosCT5VrBhVNOt0RzYunkzFWiXtv3lpD0YuCa+beFc6EvZFr3kfkOXWlWjjiVfsvRDq25pDiVM8tywN/zAkt7PiJnA/F2UpszNpLk26aq+DczSBoGJmOF6TnVrYt2O1u+moIAaHUSQecKlH9kN3SnRyLJfVaZCD1CnQynuscQ+VlJ176N4lY/koGna8/sRi7wT7JShQ15AuuvOO/xRhfM/Cq1iTwjyZOjjqoVAxVjsRY49AI1efmlbunuPv4gXTv57Sq9rRE5Nvm8CieIsuKMXNKRNK9egRCsmCaBxo7MXE0JEMILSCpvaKRNlkyOtGNUDRHAYS0XNm/rur79VFcoYVS1FpL/g0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(66556008)(31686004)(7416002)(5660300002)(8936002)(53546011)(31696002)(66476007)(6506007)(36756003)(316002)(8676002)(2616005)(4326008)(6512007)(6486002)(508600001)(6666004)(186003)(55236004)(2906002)(38100700002)(26005)(86362001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni9VTEpCN2ZPMzVEczd2bjNkTUZNR1NIMUJ2VzBkdW1EUlBHbHl2RGRLd3lv?=
 =?utf-8?B?NVAyUE9EWVY3ZnVUSjI0NGt0UU1LMWt5UW1hd0grekwzTlpxcmdSS3ZJU203?=
 =?utf-8?B?cVNHeU90NG1GTHRIZkRqRkxJb2pLSkRUU2tXYTRyTVdoV2RZOTAxbWtOWVBJ?=
 =?utf-8?B?ZVpYbDNBNTB6Nkx4SCt0U3M0K280RWZTNUFvOXAzNkhaN1hKTDZvTVRnS3k5?=
 =?utf-8?B?ajlYYXErV3hwWFFLZmowNTB6aDlXaGNuL2h1VWYzMkZIMEw4cEdoekFHdUI3?=
 =?utf-8?B?RHhPbDBwUU8rN2VmYWRmS2JneTB0ckNzY0xwY1Jsb1VrRkFzVjNwcjJlSWNR?=
 =?utf-8?B?bUNidzFTMktzZENsekx2YmF5Z3Qycks4YkI2OFFoaG91aVhkcGhTK1V3TTB2?=
 =?utf-8?B?NFhsQWNaRGppbUk5VU9BeWNTSHJmRTI0Q2JMR2ZmQkFRUnJZdUJtNkNEYjRQ?=
 =?utf-8?B?Y1UxUi9aSFBrT2pxR3o2ZDlDUUlHSS9BR3pMM2o2UStXNmp0UFNLamd2c2po?=
 =?utf-8?B?OTUxWEZCRHRTeGhnRS9CaXk5cm5hcGk2ZDdpMmxoc0R1Ym5PM3FvUnd5RG5F?=
 =?utf-8?B?ODhSa1EyTXZPNFpkbjF2ZTRSR3cxUTZOanVhdmFDeFVQTDZLNEUydVJ3VzJR?=
 =?utf-8?B?ZXZLMVpnZmdaODhWT21wVDQwY3JlUEZHQS9FdmIvcE5EWmJudUtOV0xzWlh2?=
 =?utf-8?B?Z1VXVEdvbTArdjd6NG1yNmZJY0ZYek96UHo4WE9rU2ZwMXdKaTJCcXg4TEN1?=
 =?utf-8?B?YldtT3VBUndZbzR0YjhCTWpVWC9WeUliZkpCQlI3RWxMUHpyU3ZkVzZKc3NF?=
 =?utf-8?B?R0NYSERoaVNvZlZCYWdkbkk3S016dzJLZ2tiSCs2Y1BiM2xOV280b3lrU2xY?=
 =?utf-8?B?ZW5hUTZ1cnlEbnAxcDNkUEd1cFlyZkQyUVNwM1RUSFlkbkdDWkRscWdUeXJW?=
 =?utf-8?B?R0JxdUFoLzRYY0hjaHFkWXM5YkVTMzdtNCtERFh0M0JxL1BTeW9VWHNPVFg2?=
 =?utf-8?B?Y3JxcWpYQlp6bHRWc3RESjk5M0RkTTRtVnZGVEJsVms0TDlOV1prenJuM0FG?=
 =?utf-8?B?VDlCWXF4Y2Ftb0JJVHBRdGZ4QXJRdkZ4UVRab3NiYTk1UlMxajYxM1JkMy9t?=
 =?utf-8?B?dzhxK3RsTiswN1JoM0VITVhjbVAyR1RIcnNySGpRTmpzbllLOHQvNUlwNGQ3?=
 =?utf-8?B?aE1XeXF2T0E1N0hmUnliY3NQdDJrblVySDd0NFErUXI4STh3Z2RrZjJsZkJs?=
 =?utf-8?B?N21zZ0RtQk01cU5GQW9QTHY0d0RXL2NRQ3JyWjlXUC9hSG9EQTBEQk5CS2gw?=
 =?utf-8?B?eFpHcXErUDcyL1BFR1p6WVFUS2FVVDdXajl4bklMdnIyeVdweElUK3JNSVc4?=
 =?utf-8?B?YVZBVk1xZ1g2R25yUVJDMG1ta2J6WUxzMTdScXlDNUlkZ1BJT3dwTDhxT2RG?=
 =?utf-8?B?VzUzU09IY0JoWVEyQWF5VTBSQ1crYWFUdnhBdlJxdEp6RzgyNXNTWmdVNVly?=
 =?utf-8?B?MG1HVmc2eExDbXRDU2NHS0JTd0xzTUFpUzZ4ZytHcXRSbjROQzdjYWdnekhn?=
 =?utf-8?B?MEpYOGVVMmRnOVF3WFZtY3p4VWpzL29qaDRzS3VQYVg3UDBzdHNsdG9aUE5a?=
 =?utf-8?B?QnlNSGFXbDhnZHo1bmVOWjJMRHZSaEpoL0RQZElNUDNiRFBOT1N6OVMvRGxq?=
 =?utf-8?B?c0x3Zm5NdGxIZUdVMzhWRGU3NnR3dStLTnkyaHJ4NE8vTU41bWRpUU4zenl0?=
 =?utf-8?B?NDhtYWloa0trME16dHVjdW9tSDVvZXdlb3RORUk1N0dvWDNjTnVTeVY4dHRn?=
 =?utf-8?B?QjJRUnBvRkFEYU1kclA4R2lTQ0RCVVFtQ280Y1BXcTZYRXNHNWk4U2ZhKzB4?=
 =?utf-8?B?R3plR3l0ZDZ0VWlNNlE3QUpUWjJCaThlWTlxakJIYzg5QUNyV25FM3ZGNlY1?=
 =?utf-8?B?THh5Rlp5ckNLNEJTbHJxbTRzZ1AxK1RzMnpjR1diK2dYM3pDOWFHWGhIbm1t?=
 =?utf-8?B?V280WlBKRXMzU1prSDlJZkw1S2pLNGhNdmVBTkJtaSswempjN2FiNEtEamR3?=
 =?utf-8?B?bkFjYjErZDZFZHlDNS9ETW43LzlmQ2UyZ3BmUUxwWXZ4U3k3M0JRTVdRSmFC?=
 =?utf-8?B?K0dHR2NRQ3lGQ0ZIY0dsZm1FMG1GMGlhZGt6Y1VzNzRYUWtNUDZYWEpZeFpw?=
 =?utf-8?Q?ymuxkrJmoEXQ63lx8BdBSpQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a38de3e-31b8-4fb3-3a31-08d9dfea631e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 10:06:42.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfkQfhkr4E2wJ9lkf+HLz/qm+zcstLanN0jkdUM/dD3nDBMMy7BKHFjOi9+X4v/IF/uARyU/LPaSFXvy59wHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3495
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/01/2022 09:36, Jiri Slaby wrote:

...

>> The test is bogus:
>>          use_fifo = (up->capabilities & UART_CAP_FIFO) &&
>>                  port->fifosize > 1 &&
>>                  (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO)
>>
>> FCR is write only. Reading it, one gets IIR contents.
> 
> In particular, the test is checking whether there is no interrupt 
> pending (UART_FCR_ENABLE_FIFO == UART_IIR_NO_INT). So it oscillates 
> between use_fifo and not, depending on the interrupt state of the chip.
> 
> Could you change it into something like this:
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3396,7 +3396,7 @@ void serial8250_console_write(struct 
> uart_8250_port *up, const char *s,
> 
>          use_fifo = (up->capabilities & UART_CAP_FIFO) &&
>                  port->fifosize > 1 &&
> -               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
> +               (up->fcr & UART_FCR_ENABLE_FIFO) &&
>                  /*
>                   * After we put a data in the fifo, the controller will 
> send
>                   * it regardless of the CTS state. Therefore, only use 
> fifo
> 
> 
> And see whether it fixes the issue. Anyway, of what port type is the 
> serial port (what says dmesg/setserial about that)?


Thanks. Unfortunately, this did not fix it. The port type is PORT_TEGRA ...

  70006000.serial: ttyS0 at MMIO 0x70006000 (irq = 72, base_baud = 25500000) is a Tegra

Jon

-- 
nvpublic
