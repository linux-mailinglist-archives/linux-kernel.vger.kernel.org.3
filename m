Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4EC47B366
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbhLTTFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:05:10 -0500
Received: from mail-eopbgr660074.outbound.protection.outlook.com ([40.107.66.74]:60169
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233780AbhLTTFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:05:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwkWTfgboMLtz6Jtc9jtmXHWU+zycMcNU5Eour8B/wMWzFh/qiCparx7fyNZaqVylZEksm+v0DlC5p6M6G+xuaPrIH+w3xf6yt+QClddxCxliYrK49yphkQDDo0PHi4dRGfnxPnQTUpQRSML0S75GP/15iMd3whDSgrHxzNY9CEAYC/7ynfa/NmEC9o+mbK1XnQbhXryZpNR7IrjK4Z4aBJwg0CkfuPdm0zHutvjT1hIYxXO4MnEBn7LEWw+CvrScwW0OpOdW55uh26YDAVkjKJKdbZOE4vmF8sStzt9kXEfHIox2XNf5F5GzUPeYOObkyYB0uHen2FMEBZNdIbLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOfz/HQyZFY6TbO/ICvzRB0CCQY6+v1vePosF60niyw=;
 b=cQ1TbhRobOX9Rwhhdpu10G5K5JIfNBlbvL5NotD/yd+CrKOABS2E+HTAwhUiI0WFqgSG56dZRuSn2wh+IG+E5lchFmcUuiBR7+BeEtdGQTRf2F9a2BV3S1fDnjvaAUA23vVIUe2Ch6xBOV6oLUudCgH8L/hrmEbNGQoD/b7h/U3AkvLP6Ed3/ddPey1mLFtCdAO9Qxs9IRYWzlU1oKcu2JQWTsdW/vYXVzBwK5YY73oP93KtgBJZ0KJjcdeyK65jAmrEDCSY5XbpK0/BYRJObiuz38k6JFyg2oop3XWgt7NJM+fTvYN20ATZ11rxXuP/1IgKQ4rZVEJlZo5wNXQDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=amotus.ca;
 dkim=pass header.d=amotus.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dimonoff.onmicrosoft.com; s=selector2-dimonoff-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOfz/HQyZFY6TbO/ICvzRB0CCQY6+v1vePosF60niyw=;
 b=e3LXCYRRycdBSMuUuNVjA9JB/CCemeHP4XieaS8oMCGyATmz3bhLB2GHwzYXAXAorv5oRfAgF5MP/sHrHoWNO8/T6YOEojpkSNmsuESZETR1MBMJub7twh4gH9bQZqdPqHigEyxol0+VH2gOIoNB9pDE5efftByorPyC/MNPqCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amotus.ca;
Received: from YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:40::10)
 by YT2PR01MB5021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:44::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Mon, 20 Dec
 2021 19:05:05 +0000
Received: from YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::44c5:8014:5e2:ab1b]) by YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::44c5:8014:5e2:ab1b%2]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 19:05:05 +0000
X-Gm-Message-State: AOAM533k9LK6SGfVi7aBCYZXHBnK3thhISuy3+OntEe44sJUVsImThMg
        U5i0Wqox9qnXBZkCvYh1WtX3M89ajLu/EJ802DU=
X-Google-Smtp-Source: ABdhPJyFOUp1sdP1Amu0RTN1qIvI+2ZUFzg3gellpnvTihbn3kjtyXYOPX+urWVLsKLirvuUVOfBG3w4yvSZzTgkhYk=
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr16800947ede.28.1640027100820;
 Mon, 20 Dec 2021 11:05:00 -0800 (PST)
References: <20211220111901.23206-1-johan@kernel.org> <20211220111901.23206-3-johan@kernel.org>
In-Reply-To: <20211220111901.23206-3-johan@kernel.org>
From:   Marc Ferland <ferlandm@amotus.ca>
Date:   Mon, 20 Dec 2021 14:04:49 -0500
X-Gmail-Original-Message-ID: <CAMRMzCAe1B66vyhXRsiew2=NDM+FbzFU8O9wXsrod64KaYrZ1Q@mail.gmail.com>
Message-ID: <CAMRMzCAe1B66vyhXRsiew2=NDM+FbzFU8O9wXsrod64KaYrZ1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] gnss: usb: add support for Sierra Wireless XM1210
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: AM0PR06CA0132.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::37) To YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:40::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fff7ef09-06a4-4731-a2c4-08d9c3eba1bc
X-MS-TrafficTypeDiagnostic: YT2PR01MB5021:EE_
X-Microsoft-Antispam-PRVS: <YT2PR01MB50216078EFCA70952173F58FA07B9@YT2PR01MB5021.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RevJlmTFdnzCvqUdVkPEIeD9cEFWgBomTVR+iSr/Nta4cACwQ3jkynlCSpuxgTY80f7CTMn02Rag1Eu5cKR6lwWiL9CL9YXXI8tPhkkS2BNAfFVne08Z5laaZf1kEc1OHNzjZjYFxFrM/GKmxKjyfMsRVFw21dFHrER+xIgEZffUZlD/ViAno8qwsyu2KyODzFi75PdsNxhTJluSPg9VNMIM632rvBImOs2b3izU4ToJnw6jw6M8zdORS6Adx+AhJCooBwM/obtPhiKYvRXHwJlT/lUuHKqKhP7Px+SwaLxPHZQ9ErV+ushBQ4vR7qdO1rkYuM2ykrvkztUCA+E0jPkYqlUqG/omstsudWut1tmV8xtinpPqZqAbVtfcsYKhLOFXCnr3/rCGswWZGQMsfgZt2d80oZSfRtMADGbqF/o6cFnoNXI2/g5oEdOPsVhHbgysiUJiBRGy6j+LvOE3OHrosD9ZvbLqDEtQy7r1l+mA6L+dqQAv+fc2iawKqQ8VXN/obQk05M8RLx7BcwnL/KQjbOpX+3C0Y4TYoFwb/26UAy+KP0Olld6bV1Kkt0zpE4WjjCoqJeg/LbFQFveNlsjmWNnk2W29fDppSjTLha8YntOiFLdYnRa4zA9U411+btLCsWa6qgzTmekBuxQKYW+3Ya13qqZHqm6YZp8dj0oZB1wfwe+iVl02+Ja5YZXJ0Une75Ox6uUESTrM44SmB2RO5e2YiSqbRREYar2bQXZYtsl2D2HkIpvOKAtB66ux2bW68dHwV6VQHloPjFvex5Yrh1d+NJ1W78BHBOvnVOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(376002)(39830400003)(396003)(136003)(346002)(66476007)(8936002)(55236004)(8676002)(53546011)(6862004)(52116002)(6506007)(316002)(2906002)(6666004)(83170400001)(66556008)(4326008)(55446002)(38350700002)(66946007)(38100700002)(6486002)(5660300002)(186003)(9686003)(26005)(6512007)(42882007)(966005)(508600001)(450100002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXBQa010VnFvODMvUGMwNm5CazV6cVZUQXFKck94cSs2ays3eGJ3azVRVmNt?=
 =?utf-8?B?RXI4cUdKL2NTaWV4K0t0RDF6T0ZabTk0NkZIY2FEWngvMDRTTUxrKzU4ZW9a?=
 =?utf-8?B?YjN6ZDNTYlphazVSU0lGVmQyaU4zd3ArcEw0VVhvZUxBL1FyUUo3SzIwWGVw?=
 =?utf-8?B?ZW9YTk9JTVlmT1hINWtiYU1Kc0FiRk9JZHJYZEtNU0FOOUJWdkxVZWVFcSth?=
 =?utf-8?B?K3A2Qi9uT1FaQXJvZkdlc3lpOG9YWWZYRDR5S2k5aWZEK1dGdTJ6ZWFvcEhG?=
 =?utf-8?B?VkVPd2EwZ0lRRUpvV1g2Z1plVkc2S2ZNU0o4ODlWZENwVTJvV2tObk5aYnUv?=
 =?utf-8?B?WEg4bStTdU9EOERwbFgySnJ0dTYzM3VTVVk3UXh5aTk1aGp5blZrKzdYelgw?=
 =?utf-8?B?ams2a3R2U2ZScW1rTXZIRXFsSGxIZ1AwdkRWQVFjVDhhZWlCUEI4RVpLR1FO?=
 =?utf-8?B?R3dqeW1XN0RhRHJBWnYzRkVJdGtoOW9xdFVqQzBaQ1VyeWhMSXZKUVVkVEdV?=
 =?utf-8?B?Q0hsUzF4b3VPdVBJV1AvUW1VdGpHWExmVXhTdFlrNWxzR2pmdmp2QkxKYzEx?=
 =?utf-8?B?Nmk3VEhRS1hybnJPN0JZdWQzNVpHcDllelNrNWN0eUVQNHVuQndnNUpPRHM0?=
 =?utf-8?B?ZWRQSG5Yem1aOWxzdTBHU1ovRWtWbjMydkZ2aWozU3JYS3JnZk11L25XTTVZ?=
 =?utf-8?B?NmNqMFp5a2xGcUdvdHhEem5qOWRHL0c2WDlzdnVaNkpHY2hHcGxrM1k3NVh1?=
 =?utf-8?B?Z0EvNnVGNlMybFRyQitJeDBwTVkwVm9XN21sUVNFYlJvelBla295N0ZVTXNn?=
 =?utf-8?B?dWFjZ0xIOEdoTEZWWnc1TjBXSFQ5NmhERzUwMFl1U3VEODlTR1NNRndmVmxV?=
 =?utf-8?B?Y0lmSjFDUlVOVlZ6ZDAveUhJcU4rWTlYcks3OWtIbmNXN2srQUkvMmN4cVZz?=
 =?utf-8?B?eEU3WUdmSFhERHV5MFl0cFVrZHd1blNWYlUxajd2Qy9LN0VtdVNZY1ltbkRm?=
 =?utf-8?B?ZW9UVlA0dEt5MTU0NWVpY1c0Myt5RlJjMEFxNE55YTlSajkrZXJTeUdPN0po?=
 =?utf-8?B?UE1iZHl0MUtxZDZYRkY3RUhCU0NLbmtRWFV2RlZmVHpDaGFtZG0yMmRuZDV3?=
 =?utf-8?B?cVEwVS9oUkhUS2tZSzdNMjZjbXdLT01pWmI1TVhmM3g1cVAzSG15QU1JRGow?=
 =?utf-8?B?d2pOR21rS2NQclZNaXhoTkNBV2JYUnpwTGhCdjBWNUEzZmk5UDZtejEyblA1?=
 =?utf-8?B?eTBBK2ZjVjRORkI3Y1pFWHdvRHZkQVI2Snl4Wll2NzA2NkV1RWgzaTBwWG8x?=
 =?utf-8?B?N21DZDBkMkx0MDFFNnh2ODdsZUIxUnJUUmM5ZzZFZy84aTVmRzN4UWZtR2Np?=
 =?utf-8?B?NjRQOUxMbW5veUg5bmJObnRucmxoY1JXb2pYNFZxSmpxL0lNNFdqNjFRUVlE?=
 =?utf-8?B?b21sSXhHOEF0ektvTnpJaWNXV3ZTMVZ0S1A0MjBFQVA3dkgweW11c2dVYU1X?=
 =?utf-8?B?cFR1Mlh1M2lmY3dYb1Y1YndWT1h6YmpYWnNsUzJaZll0cVNXM1h5SGNaN1lj?=
 =?utf-8?B?blZ5YVVqajlGcU5EOUV6RHJrSkZFTlhmdXgxc1hMUXJaalVhdUxVSkZBSjBw?=
 =?utf-8?B?Ri84TWFraVFHZGE3eWxET0l2MzZRaFZTNFYyQWpRV29sRUg4b2ViS0pFd3Ri?=
 =?utf-8?B?bE9BQWhQdHNsQVBRdkhOdGhXcnJvK1hXTEMxK1lhaHI1dGZWMmt2YXZOUjg3?=
 =?utf-8?B?T0xKQW82QUt1UWFJUzR0a3NvanJTSUkrVkxXQ3A2c3RyN3U2U3ZDbEh4bGwx?=
 =?utf-8?B?dnh2OFVZcVBNUE1ybTRoY1JlUHlKTWxrMFZHWC9XZXh6cDM1OUhoUWo3QTlH?=
 =?utf-8?B?YXZDVEZmY0YwYjRJbCsxWW1FMk9uQTVOSGl6RW1QTXY2OVYybktjWGh6NTRK?=
 =?utf-8?B?aEVWdWxIeXZIRGIwNDNlZ3JnT3IzUXJjdkdkTExxWnZIY001SXg3K3gyUTZv?=
 =?utf-8?B?ZGVySk1LNVhVNExqaVFYcGUzVEpQVlM3eG93WExmMGJuZnAvK3BQMWVuLzNK?=
 =?utf-8?B?WWI0dVJ2OGZ1dG0vWnM5NFZXcU5hWURCWGRUR0UrL2lSWlV1MkVCV1JCSlJo?=
 =?utf-8?B?VHpjOGd1Rk5zQ25lQkFaZmJFZU43TE1WY0craWhodE50NjdsRWV5NDZwVjVx?=
 =?utf-8?Q?zB1TASsiKzB6gA4D9BIFZ+U=3D?=
X-OriginatorOrg: amotus.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: fff7ef09-06a4-4731-a2c4-08d9c3eba1bc
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 19:05:05.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgjU+RPptwNt+hZ5wgnlxQWGzfdq0sqFuPhKqXHfWpl+J2OJbdzKY4QGrn+XWqNDjV+GU672M8xAZzR5xgCERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 6:19 AM Johan Hovold <johan@kernel.org> wrote:
>
> Add support for the USB interface of the Sierra Wireless XM1210
> receiver.
>
> Note that the device only supports NMEA.
>
> Bus 002 Device 003: ID 1199:b000 Sierra Wireless, Inc. Sierra Wireless_GNSS
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x1199 Sierra Wireless, Inc.
>   idProduct          0xb000
>   bcdDevice            0.01
>   iManufacturer           1 Sierra-wireless
>   iProduct                2 Sierra Wireless_GNSS
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x0020
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower               50mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         0
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval             255
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval             255
> can't get debug descriptor: Resource temporarily unavailable
> Device Status:     0x0001
>   Self Powered
>
> Reported-by: Marc Ferland <ferlandm@amotus.ca>
> Link: https://lore.kernel.org/r/20211027200223.72701-1-ferlandm@amotus.ca
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gnss/usb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gnss/usb.c b/drivers/gnss/usb.c
> index 5c0251034def..792235a688ea 100644
> --- a/drivers/gnss/usb.c
> +++ b/drivers/gnss/usb.c
> @@ -17,6 +17,7 @@
>  #define GNSS_USB_WRITE_TIMEOUT 1000
>
>  static const struct usb_device_id gnss_usb_id_table[] = {
> +       { USB_DEVICE(0x1199, 0xb000) },         /* Sierra Wireless XM1210 */
>         { }
>  };
>  MODULE_DEVICE_TABLE(usb, gnss_usb_id_table);
> --
> 2.32.0
>
Thank you Johan! Much appreciated!

With your patches applied on my platform (featuring the XM1210) , I get:

# lsmod | grep gnss
gnss_usb 16384 0 - Live 0xffffffffc011b000
gnss 16384 3 gnss_usb, Live 0xffffffffc0082000

# dmesg | grep gnss
gnss: GNSS driver registered with major 244
usbcore: registered new interface driver gnss-usb

# ls -l /dev/gnss0
crw-rw----    1 root     root      244,   0 Apr  8 08:39 /dev/gnss0

I also tested with gpsd and everything is working as expected, hence:

Tested-by: Marc Ferland <ferlandm@amotus.ca>

Marc
