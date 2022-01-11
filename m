Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662BE48AD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiAKMSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:18:43 -0500
Received: from mail-ma1ind01olkn0151.outbound.protection.outlook.com ([104.47.100.151]:28628
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239606AbiAKMSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:18:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFDOvpfXCEBLMA2XfvmKrnWmsCYiRvSjOLFPgIl9s87n+ImNl5G1aHkJ5LqIz9uA2g736sTk9rOk1z+1aOcBx/k+/C7PfVh7tYgYNBWE6OGbeOfvpNnUandhquz+L0grADiUPFkhzqWFqyppoTdlGIvB40Yzq5GWJ88cRCt/pBE6F7sAYhg5WW/OpTljXs4L4t4H0Pm+0CUhuNTgxLEG9vCqm11jyOAQ19etK75PXcW+pMfghi9vt3g1LxP7Z/XvbqQoZZd+rog5gPCucyzPuXThphHHrZ+4DyopBTHoBknp+o+Qqag7sRzejLwFise0rK1qa0EhgKDf61WkyBUcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smyUgqIJQdkevdZmclrxbuCEoL/d5U0S7hMFqk9EXvs=;
 b=bKutwFPzwKft4SjU0hlfkRhvO/vvpDERBaY2bfbqXLQjRHy+3duqHLpmyT7zzwDjYC0WpNXggOoqdhLiWE8TKoRpDtvZwDAytqS/M9z6vs/fdePUQpjM6ewscUrjd9lvpm0NZF+Vf8Usm40NWRoevWfk+GMVi9mUQCWocfMsq87bzA49+Uc/gZIIJ72NxwbI1BP/OhIwb5yD/LE8F1fLzmf7NcKmfrP5mXNQ7tacHkELnxPpJPu+PDSBzv/tPN39pY5FLCfPgVmFnNV1LeRFgydblKcLBfUsFUUv6rzMREPKVTfi15EbASfZcoCJmiHv4R3ZuETKG0GG2Hy9ug+cFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smyUgqIJQdkevdZmclrxbuCEoL/d5U0S7hMFqk9EXvs=;
 b=HGOK9WYSZcP7BUFEzVjDYgS7FoHHZr7JbLHdVQLTx5ygjD3e1LVpPie+25X8Wo69OMvo/8w5MbqMaxAW+jTkycS2VMmbNsN8SsAVy77ptopCZssL1OReFhTZQ4UxSSrffrEAvn4VXFRU7P2bHa4CI7XeBdxxMw3aRT9VbVIBPnwyEYGFJ9lqSMZLsrRarnZFnsLOoY1xZvT3tU/TEB6vJMspD7GAtT6ND7iU/sZI3is4kiqrpCkYrq8Y1XWlE2eALBimUlIvyTbUk/xtUYAJatPJZ7/dh+/gNK/9jNaqe6Kro9+m26lJcvUoCUdZVQUjlbXWX9RvOaX1Si93lH3rkg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNXPR01MB7305.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 12:18:37 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 12:18:37 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        "admin@kodeit.net" <admin@kodeit.net>
Subject: Re: [BUG] Slow bluetooth speed on Apple MacBook Pro 16,1
Thread-Topic: [BUG] Slow bluetooth speed on Apple MacBook Pro 16,1
Thread-Index: AQHX+5pglIbInP7e1kiyabPnZ43W7axd038A
Date:   Tue, 11 Jan 2022 12:18:37 +0000
Message-ID: <E0B80B1E-618E-42D2-9187-48FA5BF46BFA@live.com>
References: <3352A23E-EA42-4366-BBAA-459CEAE6F51B@live.com>
In-Reply-To: <3352A23E-EA42-4366-BBAA-459CEAE6F51B@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [II4zycM89QlKq7fkFLbgtpoA2ML+SENBQUbniYWFqctmSPNFNjMDH773IUaikS+O]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a607bf29-b7ea-48bb-e6c7-08d9d4fc7f0a
x-ms-traffictypediagnostic: PNXPR01MB7305:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wog0mGRyKng/73sbXCKGQnAdQ4lyMyS5Q3gSqgmscsuWsby0OQl6wnsEZKLSWluMzUevlmBZW5GhoJe61wV0+kLMt9/4LSIiv8xlSRRWK+dkyvd6yxS7qxKFWyhcRIvq0vMaJblsDXwXa7gavqie98rsFk3zbuQ+7obeptC0lf8cbdEXxpeRrht4aDRWYL321KW9f3KIfCReHffm17ngQfwR6K23lF6PB/AVk6KyRUQHsUntwvQbj951ZvRb9SG4FYiLYVC1csTYkdJx9COadTDu62tTnPlue+uiZRbQzEEtAIyrA8LYT2j/TtvcEKgAwLoZomtd6XNb67/R02V65ns4OSpGO/WWtbu6gAc+n1labWan9HkLqiZCIycRqj6R/WUkz8FOi1Z5/ALR8kTcyV8B+J362R44MsxLlB/7WM2eSsTHKbnhdFxKPE6SU8e+guspFP38MbGGbVCcjVlJS7NuJctavEkobuF1KPzmEN1u0ei/YAZtUdf40iSLADFkzqc6a6b24OGdz1j5ZBAaUByRhZ0v18dbfac650aj6bC4r7ixVot9vH11Xi1KA6GnAN4IEIozSoQKP7aOgAFOuQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9KHUFah59YOC5ldDchQfFG74yeZ83TpXQbkjVxBbG+1CwMHXdr0+u72UIpFA?=
 =?us-ascii?Q?jDdCBWU753FNPtu6SLV1d+ZKJycXlZ2N5fyUJl/dXzFX9Pdhu5PU/WLXdiiQ?=
 =?us-ascii?Q?pe3fGteaFJXtsgxQlZpAKvpOXtplvxFYpGVQmnBztEIxRKSxGiSgfseSnove?=
 =?us-ascii?Q?aU7EMLE1MorGhNv9tgaI8Hxe+iPEJHqfDHoUDxTYpbhcB/EUcGWANmkH0RBe?=
 =?us-ascii?Q?qwZ7LbSYdQcVXupT2RtKoXnbHAvSUVEV0ngbz7Dm+WjeXLhYB0XLW90jwb7H?=
 =?us-ascii?Q?/xxHFZ8D/lhfFzJxAnlj+aKkMVmWrxI5opHZdy/Nnq838V6wRip2GjgXOVx2?=
 =?us-ascii?Q?KZTYhMg+ko0qNQkZUfoz6v7a+K+7zh1I4EltZu0rMHeJ7+1aqCHcPxxWE4ng?=
 =?us-ascii?Q?be+bzh0ESrx/9n2WxOkRreUpe2cjg9ROBr88KFvnZp9bOi6V3dspEiuuaw9Z?=
 =?us-ascii?Q?nOfLeuHBHBlhCze1UhWp9CftHJN+2tch04NweqxKkH3miusi2nl97jB9QZuW?=
 =?us-ascii?Q?+ZtMiaiOZAUMRqc47QMB6nS/A4dcdAwJjPBsZO1tJx8rq6EM4gIufPz4Pk67?=
 =?us-ascii?Q?t/Yy52MkrjTVXQ+BV1ZjvVdubuufQia5/AVAcs3OutjUERy5ejbadHtUG7bb?=
 =?us-ascii?Q?sojDIXYPt3R4f2Qr08ATwwwGncbOv4WciBbOvx/5/PdgUE/4G5MMOJL3qxYu?=
 =?us-ascii?Q?XH4JiXf8vPIyHduH9X9EJj5dwu0UIEGPt1moGSNfb2jNrE/Ba81yuaUsNS40?=
 =?us-ascii?Q?KEAy9ky6tGft57Ca2LoUIKY5qR7wItZGf79w/d9G0jxbBPaSYcvdg7iQVPZb?=
 =?us-ascii?Q?G4oQSMEYRas5fZhRsi1R60rD1NGaWXolA90GB++Ky/yVsbTrTSqZEz8K0dZt?=
 =?us-ascii?Q?85MWI8atibUd3ptltnotYs7FafiNHpuvxSIljdMbgHhJl6OJ71XEkZHkB6ia?=
 =?us-ascii?Q?kyhcB974jRqiZEo355rNGIp5bCLIGqzj9XXE1fd0uRP4ridRfcnguFTOW9kT?=
 =?us-ascii?Q?Gir+kAlkVUS/SxwFePbiMCu7Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3CCD742684027349BAE71C2FDD79AC11@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a607bf29-b7ea-48bb-e6c7-08d9d4fc7f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 12:18:37.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7305
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some additional errors are being seen in 5.16

-- Logs begin at Fri 2021-11-26 21:34:04 IST, end at Tue 2022-01-11 17:44:4=
0 IST. --
Jan 11 17:42:26 MacBook kernel: Bluetooth: Core ver 2.22
Jan 11 17:42:26 MacBook kernel: NET: Registered PF_BLUETOOTH protocol famil=
y
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI device and connection manage=
r initialized
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI socket layer initialized
Jan 11 17:42:26 MacBook kernel: Bluetooth: L2CAP socket layer initialized
Jan 11 17:42:26 MacBook kernel: Bluetooth: SCO socket layer initialized
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART driver ver 2.3
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol H4 registered
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol BCSP registere=
d
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol LL registered
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol ATH3K register=
ed
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol Three-wire (H5=
) registered
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol Intel register=
ed
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol Broadcom regis=
tered
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol QCA registered
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol AG6XX register=
ed
Jan 11 17:42:26 MacBook kernel: Bluetooth: HCI UART protocol Marvell regist=
ered
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: BCM: failed to write updat=
e baudrate (-16)
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: Failed to set baudrate
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: BCM: chip id 150
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: BCM: features 0x07
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: BCM4364B3 Trinidad Olympic=
 GEN (MFG)
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: BCM (001.016.075) build 00=
99
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: BCM: firmware Patch file n=
ot found, tried:
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:42:26 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:42:36 MacBook kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.=
3
Jan 11 17:42:36 MacBook kernel: Bluetooth: BNEP filters: protocol multicast
Jan 11 17:42:36 MacBook kernel: Bluetooth: BNEP socket layer initialized
Jan 11 17:43:20 MacBook kernel: Bluetooth: RFCOMM TTY layer initialized
Jan 11 17:43:20 MacBook kernel: Bluetooth: RFCOMM socket layer initialized
Jan 11 17:43:20 MacBook kernel: Bluetooth: RFCOMM ver 1.11
Jan 11 17:43:45 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:43:45 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:43:45 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:43:45 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:43:45 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)
Jan 11 17:43:45 MacBook kernel: Bluetooth: hci0: Failed to read codec capab=
ilities (-56)

Also, we haven't got any reply from the maintainers yet. I hope that I shal=
l get a reply this time

Regards
Aditya=
