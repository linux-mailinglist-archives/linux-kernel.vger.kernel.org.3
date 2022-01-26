Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4AB49D62E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiAZXfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:06 -0500
Received: from mail-os0jpn01on2074.outbound.protection.outlook.com ([40.107.113.74]:53984
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229725AbiAZXfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB3cVSw1Blx9UIoL6C1akdkbx5mT0rOV9ZRDP21eQhAhuYPnoUXBEd3ZGlVX/xBClTkT+JQDNUat6hFja2rczVV1k1/MIpA2hinye8gpGou/7aTYU40A1c41UodSAj2qc8u54G3X7r3Lr7ovseH1RSNkVUVPkS8iUALxKfpMC4H1IX/cJG2akrf6TMHMEoTnqK5sZwbXnouwiRJfAK1ktg/T4jKu39X6XIxgWHl6iQkvAIdhEg2hKmXfODsjlSUwbsvFTVxwfRu5B5bBmGNsLxaqWAhmFdzye/e3S12z5XFiS+4Iy3XdlNDx4er9oawiWurNoLh3yYk7300e4Ql6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM0OJSGBh6bIdaf88V3w2zbMBnmTiCb/Le1Bxoh337w=;
 b=JtX68lE/RO2YZacRfXb6XhYo3by2C+EV/SUVX8cX6Lzf2AI89NYpkdh8EvdYC3UDM+f3kuEh+wJoagarFboViioSwJYk2lb/GxgMnuX660e0jrF0p1WqWXtvMRKd55o4RewEW+9TnvLEG6b/JxxwT/RtqNvBD36tHu6DN+XVslerUz/jOpzgi267zevX9M0Run2bSdCKfsUsF5vPA0P870TRCO81pWUKYMvTQ3e/XC12SYDSOkj+BffKK7/mosAQbi3g9IVTnOFSKFVzs44IzI6hqXiaahQo/Tq6xidREzDQalTpUjPsRcjtkKuQpdoDtLyU+tyfmJRVclbq9/E7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM0OJSGBh6bIdaf88V3w2zbMBnmTiCb/Le1Bxoh337w=;
 b=mQkzble5pcoinH0i6J9wFgEXFL1lINUhDAHjOXBe5akd1TkyNU1cYbrSloKm5zOFgPkHoAf8TY7l/+oP+vH2lH5ola0ch/vZRzth/0jFjDaP4reNQWXWgcc6OwN0fmrDQdUUqJF4SkNejc92nbcC/8WdyUhTdDpYNcXW1n3kDKk=
Received: from TYCPR01MB8190.jpnprd01.prod.outlook.com (2603:1096:400:103::9)
 by TY2PR01MB3691.jpnprd01.prod.outlook.com (2603:1096:404:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Wed, 26 Jan
 2022 23:35:02 +0000
Received: from TYCPR01MB8190.jpnprd01.prod.outlook.com
 ([fe80::81f9:7ce5:226b:6237]) by TYCPR01MB8190.jpnprd01.prod.outlook.com
 ([fe80::81f9:7ce5:226b:6237%7]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 23:35:02 +0000
From:   =?iso-2022-jp?B?VEFUU1VLQVdBIEtPU1VLRSgbJEJOKUBuISE5PjJwGyhCKQ==?= 
        <tatsu-ab1@nec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] n_tty: wake up poll(POLLRDNORM) on receiving data
Thread-Topic: [PATCH v2] n_tty: wake up poll(POLLRDNORM) on receiving data
Thread-Index: AQHYEw1Xw7tuGFtGzkGN0Ezm5vc7sg==
Date:   Wed, 26 Jan 2022 23:35:02 +0000
Message-ID: <TYCPR01MB81901C0F932203D30E452B3EA5209@TYCPR01MB8190.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f1f9c19-162c-4b72-fc9a-08d9e12479cc
x-ms-traffictypediagnostic: TY2PR01MB3691:EE_
x-microsoft-antispam-prvs: <TY2PR01MB369180D1F2C91234EA7D5513A5209@TY2PR01MB3691.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GcuZNJ6Rq5+BRS9XnO7BLzxn6wpR212siojdKsF5ZweCOqP+M+JHyQTPmBXppr3vm14R4YobI6K4vW07/MBQud51tTvTRuSyTd9mPMiQ+TzDBiXYiV6oPfkZZoxnPXKxqvET4SJji7pyYEGZjAOFAbxFRWC3RX6drJggJp8UylbELCeldqEw0497ysOv99+DhRRCaNa7nwgut+HORWL4+WzdVsKWrb95RI5e5D5r3NE67yoM/YtZkyxcZl0DyKkuEvc8EGel1N68Y1WB/UKgzm5i15WgNt1bdrwTt131Uxbk/+ds5Xoe02GkjkUNunqVszJgj7GGxeh5Xf7vkkKzs7UtpMuRqJDSykDDdrUHz0bd2U0qhBO93AbP2HAEoJz5bubUa798yBzrU0oK/n6gJd/A4XZ88SQAlp2H/bMbipw3Z0Hb2C/7xUH8+yLc1qxgK1mbKAB/dZh87NiaevhVRMH4jC5/k3qZkOPsef++u15CfsQSwR9EvVf4L1J2A5M8shJ4wGC5ArBe64gALYCf3N8seJwQOCMRZARAJOqpEEuvV/7vj6Cfab5iT+Bm3YWsUbsVVgSlLuaQMKfoDRQ0S232ottJfZIiEhDK2yVubtCT6HN96sVIlPDSLX9DJU6VObphT5+q5BVYQ5eyTXoXfUMdAvvNWC8u8yaHvT1UqKh913TAQBvwGyqCTWaH0l6lRsvfAMjAD2GGohn6Z442Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8190.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(64756008)(71200400001)(38070700005)(66556008)(66476007)(66446008)(66946007)(5660300002)(7696005)(82960400001)(122000001)(316002)(2906002)(55016003)(38100700002)(110136005)(85182001)(76116006)(83380400001)(8676002)(9686003)(186003)(6506007)(86362001)(8936002)(55236004)(4326008)(33656002)(26005)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OURZRytqeHh3UGNtRzlxN3ptMUg4ckw4QnZKTE9XRmtBRndSVmJKWHdm?=
 =?iso-2022-jp?B?OVFqM3RQMktFVzRSdExsTWRNa3puWDNsbjlDRnQyaDRvdk5kNm5zYkFK?=
 =?iso-2022-jp?B?NzZ1T3VHR00xcXAxQlZIMC8zSDhMUEtCa3hHVTMvb1dMSnhwYjQzWGEv?=
 =?iso-2022-jp?B?akg1RC96c3J5ekxDYjJJMWRDWnU3clBkSjZ4STNBQkNQdWFDNnM2emxh?=
 =?iso-2022-jp?B?enM4ZUN6WGJmUW1NYkRMSjhDTUs1U01NdUptamF3SDZtWUFIRmpqRmg0?=
 =?iso-2022-jp?B?anRIYmM1MlV6MGpxOTFMc1U5OFBNRE0rWWViNUc1WHUzR0tzZ3lKU2M5?=
 =?iso-2022-jp?B?dTAybnhCNTRrTEprbGNjRG15MXo2QlZNTzZray92Mmx6UUREK2xyVmlI?=
 =?iso-2022-jp?B?Qi96WE5GYTNIV3JkWnBIUnJLMUxCWXpCd01UeTlHVGNINXhTOVIzaDNN?=
 =?iso-2022-jp?B?cSsrOHZkQ3M1KzNCRm13R21ER2JsM3gzNkdlb0V6aVRITU9vVkhwVXE3?=
 =?iso-2022-jp?B?cWY3Qzl5dGNjdDVBOVhmQyttL3NOWGFxdEtXWEFMbEJtWHZxTVNCcXFX?=
 =?iso-2022-jp?B?eUgweWJVWmtpSlNLOGVmOXBsOEpWQlJmWDBRUy9JREhydzZaYm0xMy9z?=
 =?iso-2022-jp?B?ZHlBbmpmNVE0MVNYaEx6ellwK2ZSV0FzcWhjWm51Uk9EL2sxdkMydjBM?=
 =?iso-2022-jp?B?ZThNaUQzNHcvMlhTNHgrYWNGSUMzTlZHVElxZ0VnMkpqaytOOGsrMWtT?=
 =?iso-2022-jp?B?TjlXMngyNDh1STQwY05hSTJtR3lhTExIWnkvOVFWYUphNjEwUUNHZlpW?=
 =?iso-2022-jp?B?NFIwTHRPVGFVazIxRDJ6TkMvQWhKRVBaOVV1cXlISmgzWU83TjFaMUlm?=
 =?iso-2022-jp?B?NVBoaEdqM2JEaWl6Z21LWkx4bGxWMlYwT09nRGVHZG9zQTBxM2s0Z0pC?=
 =?iso-2022-jp?B?NVFXN1hZSTdFb3VxalhEeFlQYmE4a3MwaTVTc0tMV2lwaGYwTDN3K1RF?=
 =?iso-2022-jp?B?ZC9VOGpscVIwdFllTUNlR0VKS2RtMVFQeVVwemZsdmZXMWFkM1RGRnla?=
 =?iso-2022-jp?B?YjNNMnR5ZXpvVGVWczRRc1BVU29vYWtLNWdmVm1uc0ZFMXQ3dnR3dDIv?=
 =?iso-2022-jp?B?c0N3cC82V3RQZ0F4OEIwNWpFUTNKMk9iVlVGM1FlemhjbDJkWkJIVGtk?=
 =?iso-2022-jp?B?cnRDcUFXUVE4TmFCSEUzamJlbE9jcEhmVFZ6NENBZFA5VEUrNU5pMzI3?=
 =?iso-2022-jp?B?eXAxN0IvMEtJaXR0MW12b0U0VWdwbElnWXNhRHZtZUZyRnVia2NkQjFt?=
 =?iso-2022-jp?B?UkRtT1VEU2tjRUh1ekN4QnFnQnpqQTYvTEYzN3d0RzdhdWVoWHQwUkxZ?=
 =?iso-2022-jp?B?U2sxNlgxcU5sblhiZ2VuVDgxT3FhMkVLcFUxdEJUdks0WnJVNTRMbCth?=
 =?iso-2022-jp?B?YkJyS0lJWWF2VkpXeU9ZeEluU2ViN3JtYTZITk1YcU02d3FPMUluZFZW?=
 =?iso-2022-jp?B?TEE0MDFEMjdPRUdoK29WSlJBUXhQcVFuVklwUkpPcDB6MVVXRlNRdkpl?=
 =?iso-2022-jp?B?TWN1bkJBWUs0VVpLcXRvOXVjb2IyTENhVFM3dlZyazdLR0U0NERBTmVT?=
 =?iso-2022-jp?B?N0ZsZTZDUU5YT2NVenFnRi9FNFBVMGl5TkxESEZxUHBIKzc2V1R1aXo4?=
 =?iso-2022-jp?B?MDN6aUFkT1E3S1N4VUpEK1pLMUFtTDVWUGtYeUNLVm5NYnlQQkZINHl2?=
 =?iso-2022-jp?B?NW5PV0RKdjlWWE5meEU1QjNWZlFNYkxkbHpKNm8zNTFxY2h0S0JWYkVn?=
 =?iso-2022-jp?B?QkJhUVFnVXArcW9HakFveG05aXRxdXYyS3VvODV0MHQ1WDBkbStqUFdj?=
 =?iso-2022-jp?B?WmxLUGZBeGc2azBHeUxoS2tyQlJURmYvb2pGYUV1OUNDTS9FTm4wNnJK?=
 =?iso-2022-jp?B?MmdwWDlzbW55aVhaWGRpUWNTeVlTNEhFdTJvNFVTWkZXRlVwRldSOFdx?=
 =?iso-2022-jp?B?RDJaY2FMOE5xV3hqWGhKekR2cW95bzFvMy9pT2JyS1poWVZ6MkdRWDNo?=
 =?iso-2022-jp?B?Q3RmU1k1MENHTzNtcHBiUFFNRlBDeGZkRXBTRFVraHNBUTJjcEx5RjBa?=
 =?iso-2022-jp?B?Z2RTWnVsTDBaRnNPc3VlNmFmdzFtL0JZZGMwNHg2NUlIYVpEaXk2bFlS?=
 =?iso-2022-jp?B?K0pCZmtYaDVsdkFrQzhtZVJIYmthVm9hUTFXeGRpYjZ1MWlHUDZmb0F0?=
 =?iso-2022-jp?B?WGhkckU1QW9OdlN1M2dYV2dVaGZlQllKREEzaEZvTWMzam5RYXprY0w2?=
 =?iso-2022-jp?B?UVQ0U3VITGcyOWZabldCeUNISU9MM1J1RW9VMXVYZ0dKaE92eEcvWHNU?=
 =?iso-2022-jp?B?THFYYVBLaEF2YzA3RWpWdjRWcm85djk2Yno=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <07AC1A20DE1AD94DBF294104D9497A41@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8190.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1f9c19-162c-4b72-fc9a-08d9e12479cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 23:35:02.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTDzlxwzvtfYju+oR6n5AGM4S6G2AlaNxxkxmD1v/S9s1GvW3VFdYqkaoseKOOsFtc3zyG5g5Po8xKm2jVhpjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The poll man page says POLLRDNORM is equivalent to POLLIN when used as
an event.
$ man poll
<snip>
              POLLRDNORM
                     Equivalent to POLLIN.

However, in n_tty driver, POLLRDNORM does not return until timeout even
if there is terminal input, whereas POLLIN returns.

The following test program works until kernel-3.17, but the test stops
in poll() after commit 57087d515441 ("tty: Fix spurious poll() wakeups").

[Steps to run test program]
  $ cc -o test-pollrdnorm test-pollrdnorm.c
  $ ./test-pollrdnorm
  foo          <-- Type in something from the terminal followed by [RET].
                   The string should be echoed back.

  ------------------------< test-pollrdnorm.c >------------------------
  #include <stdio.h>
  #include <errno.h>
  #include <poll.h>
  #include <unistd.h>

  void main(void)
  {
	int		n;
	unsigned char	buf[8];
	struct pollfd	fds[1] =3D {{ 0, POLLRDNORM, 0 }};

	n =3D poll(fds, 1, -1);
	if (n < 0)
		perror("poll");
	n =3D read(0, buf, 8);
	if (n < 0)
		perror("read");
	if (n > 0)
		write(1, buf, n);
  }
  ------------------------------------------------------------------------

The attached patch fixes this problem.  Many calls to
wake_up_interruptible_poll() in the kernel source code already specify
"POLLIN | POLLRDNORM".

Signed-off-by: Kosuke Tatsukawa <tatsu-ab1@nec.com>
Fixes: 57087d515441 ("tty: Fix spurious poll() wakeups")
Cc: stable@vger.kernel.org
---
 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5be6d02..b2b98fe 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1369,7 +1369,7 @@ static void n_tty_receive_char_special(struct tty_str=
uct *tty, unsigned char c)
 			put_tty_queue(c, ldata);
 			smp_store_release(&ldata->canon_head, ldata->read_head);
 			kill_fasync(&tty->fasync, SIGIO, POLL_IN);
-			wake_up_interruptible_poll(&tty->read_wait, EPOLLIN);
+			wake_up_interruptible_poll(&tty->read_wait, EPOLLIN | EPOLLRDNORM);
 			return;
 		}
 	}
@@ -1589,7 +1589,7 @@ static void __receive_buf(struct tty_struct *tty, con=
st unsigned char *cp,
=20
 	if (read_cnt(ldata)) {
 		kill_fasync(&tty->fasync, SIGIO, POLL_IN);
-		wake_up_interruptible_poll(&tty->read_wait, EPOLLIN);
+		wake_up_interruptible_poll(&tty->read_wait, EPOLLIN | EPOLLRDNORM);
 	}
 }
 =
