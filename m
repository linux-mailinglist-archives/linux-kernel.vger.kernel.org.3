Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86AC4805DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 04:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhL1DYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 22:24:17 -0500
Received: from mail-ma1ind01olkn0151.outbound.protection.outlook.com ([104.47.100.151]:30374
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234705AbhL1DYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 22:24:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAa65ydpFwBy/XXWPoF/GX3Uq5Gz7zgbc/yNGn0iYuCome6kBhvaGI/ws5mbYdLWvQTWf830658ZMxLKWg0dOJjTszh3mdSoA3JDaQSERQTazGjbQLHme5xJg82fwivlDuadl2uj4uTKHe3g71fXkh3428TG/GoLZldlHLv5k52VtyiAldIi58DQRh70gFYAYUYUtBctSnZMzN2q+NvFR889r8JDKlqMAFOD7DaySK6os9OgHKggJqR0r8FQ+YRvqUgMh3BltD+cvWaCY9Rsin44W7udt/xWduS56Ox4cnidNTs56aqSuVe6r7ZoDrMJGbWO0T9GiPfCw1zGe3w5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vguOGEfCm1abJgodbY2boe3EBE0Nh27WtShRl6UF/KY=;
 b=Zv1flu5ydlO+gnA52OGgUiIgkHeIAmNHDySpCUOCPEIjlhAcoNefkhZ5Vpp2+r9DQerKj1W6wXYpcQBxhcxqf4G5nmAJYjGuC4WU3hNONPEvN62ZZCRfK3f+WDdWtwKKVGZ5bVps6NPREgXnfBEkgoeQ3xoGtYmc7+VAr44yhpyI4KjbrdPcHGB9LGyiiJd77LWzKH2Hjd8/QHzmCYGQF6mvnJD3YNKFM4ObuRxSGLH6Y+ndlY8Bp6zd3HIk0eVPa55adWVoauhxg6AY54JXLgMR9AZG8Qg6yYFgQ+1qid1KsrfAAv9ThHv67LB+2gK5dNf7MPjz6hQxWTVUQlGvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vguOGEfCm1abJgodbY2boe3EBE0Nh27WtShRl6UF/KY=;
 b=BrbfxSHjGWk+LZsUqBsXssgD97Wt8P5KPsCOQcars/v1BmYn1IcX7kpWLT6KRYF4MIaE1mkhFS3PB/HLUCfVy5tz14f4q8eIWW3LwNJ20mrvugTTuESOvS1Mek53VK/ZaMtmXQ9Kzf7prXFteRFbMffUwqO0P6I8J8c40JzFwjhrXNmPWdj66floebJlWnGU0rylOiFlATNRZiI4iQpaECaWErL3qoX3CYXGMHTYpw/QB2tpW6L684FwYMrjTib8YfIosSoYhruLVH0ActvqlzEJwCqL2g3dCNXQYBqOZHMzaxe/HO41Ikyr9CmgPh8q6evNLNqKWYqnuGq/8YYUJw==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB5686.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Tue, 28 Dec
 2021 03:24:09 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 03:24:09 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        "admin@kodeit.net" <admin@kodeit.net>
Subject: [BUG] Slow bluetooth speed on Apple MacBook Pro 16,1
Thread-Topic: [BUG] Slow bluetooth speed on Apple MacBook Pro 16,1
Thread-Index: AQHX+5pgFv0y9sw7IUOZHdhR1j78nw==
Date:   Tue, 28 Dec 2021 03:24:09 +0000
Message-ID: <3352A23E-EA42-4366-BBAA-459CEAE6F51B@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [pr3XU+NsIMrzGmkzWQwUDYJEkbGp1SPpR6+SzczFW7+MZqp2Kr34VY/jL//mmIVc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61a43775-94a5-4e5a-84cb-08d9c9b18303
x-ms-traffictypediagnostic: PN3PR01MB5686:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbAWuFc+fU8ebEnkRV3LsZKGZ4RTNLvr0qOPwq99TmZYoCo9iosZdT18f+O+G3dWthfGyq/uLwUwt4+0mmtXdiD+3UuyodYhHnfsedrWcVaZmFfPuiop8ABzdE/jYc53ZilUYNp4+/pxZyyE8eIykuDXFsmtz6k3/dIFgnyt+dYk1/QimDBuc65c4spbC5KLGKap6Y96+AuWuIf+fE66MzhwyNF1XgprQqIrkzLnh6oi9ufawjs0HLjQWY+yYWLt1hGSgFSZBqklBdJVfNS+Yl8eurV7eM/AVg3Q/1naj0UuXiOUj/pXNnfzGnBYi13FBGlQzQImsfm+6u+e6zb6oT2JSvYWBMGFchjhMwTs4fblVpsHDAxxJOieAi2nOvbHcBA5I1uWU6ARPyaOKnaQiRKXgZc3MCQITGkeRjaf4Ps1GTWMPgS2iUXADVbeTn5uvC8XKUqQBb7KzrgWDYbW73bld2vYz3KdxC4Vs8a2luASB+zuOadvLywbkO2P4XuGmM7u8iLMKuqWxVUzquIQfqVQiz6a1+ng0IjwOG3pd/Z6ExS82JG3ZqVnr3+KCrK+400qDIhweM6XOC2sNHnGCw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZGtPFomNyHDqf1qiZjg3RNi1UnPMqyCzSbdDnp/dRD0DjBXq1yw92ZNvPLR7?=
 =?us-ascii?Q?z6fkUQzAVVXRK1LB5c/ZSJKUcEQnZI3yAfjw9Gz3Qp2W2k/q2bvURY9Gj3av?=
 =?us-ascii?Q?qGQYOSqsRYSwJX0KTbryOQwoReo1KkaFL7NDyozMbUNRoPHbdiDNhU+xv8R9?=
 =?us-ascii?Q?CFR7Pmwy85TKMPdrCv/5O8vv5qSJa9HutyCe+xCkInHraYoZ52aaoy8YyvmW?=
 =?us-ascii?Q?tl7/DC2Huk+88uptmdXmomZ4bwWqKE82QJutM3Qw7kvzopQ/b8AVKv/fENhx?=
 =?us-ascii?Q?HBWq9iWNmLtf6P1avf2Mdugkyh2zoWUgDWUfTE7FmerNpY1oZIo7kn+HiCkw?=
 =?us-ascii?Q?sHjea+xv2Pyk+9OmLyhIHrEUaDdyIAaII+lxpgq4a98+sz/jXqb99JIVsErd?=
 =?us-ascii?Q?PNuu+ewKLeQ/mCmtL41eUIx3geEk9VFRFe4vQPGwV0i+0WsaPgKF51Gr0B7R?=
 =?us-ascii?Q?djjui5gbgbj/Fil9uLeZBNi5LUqr7CGR0mfdSv+7u/eNMYabjUdqNqzDlISx?=
 =?us-ascii?Q?hQ0ZJlQTLxUMRF71uJmfE43TyHE5GRfGJqceAA6vjIUxyOJOfxXwwPSpTJJA?=
 =?us-ascii?Q?YedDtRhdlAWxudJR8xWxOyUY7B+TNPv3Mc/tQ0pBhEA08GBeqDMqYUXi4t3k?=
 =?us-ascii?Q?msSUDqdo+YNWZuTmpdHWap7yqV81bCCBir2LA9tzkdB23CQy9O1FgIGPDAOV?=
 =?us-ascii?Q?2ehsDvj4dNYaRvhjpPUepH8X/X280b/uX69PlytVGeroWrhFs+333MNrLUJk?=
 =?us-ascii?Q?KuWLLVCiESNgQ2Xw9Nwyij52+ED273YoCA299XxnLlgejmXRX3mshI9eKf4s?=
 =?us-ascii?Q?dNq6IssDmTcnnzKaOeYJ/fIcHGPZtMUe7Ot0+EKVWoQCNqVU3p17ty7xclmM?=
 =?us-ascii?Q?2GmT7yqdCWMyF66W3cw2MM8iQADGK2Iz+V4iMTDv7qsVMP9MyBqAKlYz+oEW?=
 =?us-ascii?Q?3vtbvJPPVZus/dndQXRfTzqDptPUyFq3HSWlv+wp4FC12XScpCYT1wlwYFH9?=
 =?us-ascii?Q?iiDRkeiEDxjESJY2FEsfALpt2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EECD95F5CC4A244A2E632A6A0B762BB@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a43775-94a5-4e5a-84cb-08d9c9b18303
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2021 03:24:09.3628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5686
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file transfer speed on MacBook Pro 16,1 from an Android device to Mac i=
s too slow even if I transfer a file of a few Kbs. In case of a transfer fr=
om Mac to my Android device, it simply fails.

Some logs that might be helpful :-

-- Logs begin at Fri 2021-11-26 21:34:04 IST, end at Tue 2021-12-28 08:38:1=
6 IST. --
Dec 28 08:28:29 MacBook kernel: Bluetooth: Core ver 2.22
Dec 28 08:28:29 MacBook kernel: NET: Registered PF_BLUETOOTH protocol famil=
y
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI device and connection manage=
r initialized
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI socket layer initialized
Dec 28 08:28:29 MacBook kernel: Bluetooth: L2CAP socket layer initialized
Dec 28 08:28:29 MacBook kernel: Bluetooth: SCO socket layer initialized
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART driver ver 2.3
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol H4 registered
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol BCSP registere=
d
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol LL registered
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol ATH3K register=
ed
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Three-wire (H5=
) registered
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Intel register=
ed
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Broadcom regis=
tered
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol QCA registered
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol AG6XX register=
ed
Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Marvell regist=
ered
Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: failed to write updat=
e baudrate (-16)
Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: Failed to set baudrate
Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: chip id 150
Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: features 0x07
Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM4364B3 Trinidad Olympic=
 GEN (MFG)
Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM (001.016.075) build 00=
99
Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: firmware Patch file n=
ot found, tried:
Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
Dec 28 08:28:40 MacBook kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.=
3
Dec 28 08:28:40 MacBook kernel: Bluetooth: BNEP filters: protocol multicast
Dec 28 08:28:40 MacBook kernel: Bluetooth: BNEP socket layer initialized
Dec 28 08:35:02 MacBook kernel: Bluetooth: RFCOMM TTY layer initialized
Dec 28 08:35:02 MacBook kernel: Bluetooth: RFCOMM socket layer initialized
Dec 28 08:35:02 MacBook kernel: Bluetooth: RFCOMM ver 1.11=
