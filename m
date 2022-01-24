Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6153A497A17
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbiAXIR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:17:28 -0500
Received: from mail-os0jpn01on2041.outbound.protection.outlook.com ([40.107.113.41]:61189
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236133AbiAXIRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:17:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0ZibOAB5WHkfzKOwBbaUKQH7PI4it52IN6L6gxhU/Vm52YTq8XNMgGQKeZ6UBjn+eYp4bxui95fwth1VnPBuT5xq9NPtGGXkFiZdFCbrKFdr4OKV5f24rLLk2STFmJuNm/76G+yIuLwToQHslxzO9LA9LFh6hWAcThnQjuU3xaRYxYgp2qiEUqRjCNb/3+Y7xq/3BOz+vyoYljTlTiEXOdVkg3JTJQfmbMs0Wp5U8+KNjrS2MffJkcFUWeCit369MQA+ITFOCQH3BpKn5c984cTTm+WMnCVyMEF+APFTANyeHhUxD38kWep3m2IPnETYYtD66BazBrshHe8cUm9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8JZZ2hJAUheDD90uJwQSuTHvEkc9C/unT7PgCxoluQ=;
 b=LO0UIFzryuatX58LlbMU2JZ9cxeRThQkJ+I9mRNAbg9dhou1OX/X8kq14b2Q3UOxDal8YpLTkjAgdmmCiuLgvwyb44Zz8+z/elpfGyOgSkj8jpokz+ue6LTo+DVCtSkyYZgoqMUJVuy0dambzZ+a2PsfDgM/zsTOcahzh5o759uAIVPeVY+GMW63i/d8eKDUqN57OhrkUjTSvjGkn//1hdXTfCDypryEhx4F5jsrNpapFoJYOABZrxCP04OhDTNGnqB6Y6bLDcUGMWRX9z36fwA2BmXDX1KrhcEGMapt4aWS5iuGrak1tgQmfL+Ju5ci/Uu8ElljgqM0B6v9bR1fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8JZZ2hJAUheDD90uJwQSuTHvEkc9C/unT7PgCxoluQ=;
 b=igOl3zh2HyqmCSv7DtX4QNW5MJdd+IHLWSLS6P8YgKsVlzAEHGbkz/NompxkJjGXJgY9sh6IMEThJGVVCwR174iIpoSx1gft2/mFRv3ZTj0G8xWOPliVuO8ycJZKyLqQx1OzrP5Mdwwowj9yyLLBW6s51aQi6TtUT0+3e/BWYO4=
Received: from TYCPR01MB8190.jpnprd01.prod.outlook.com (2603:1096:400:103::9)
 by TYAPR01MB4272.jpnprd01.prod.outlook.com (2603:1096:404:c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 08:17:22 +0000
Received: from TYCPR01MB8190.jpnprd01.prod.outlook.com
 ([fe80::81f9:7ce5:226b:6237]) by TYCPR01MB8190.jpnprd01.prod.outlook.com
 ([fe80::81f9:7ce5:226b:6237%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:17:22 +0000
From:   =?iso-2022-jp?B?VEFUU1VLQVdBIEtPU1VLRSgbJEJOKUBuISE5PjJwGyhCKQ==?= 
        <tatsu-ab1@nec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] n_tty: wake up poll(POLLRDNORM) on receiving data
Thread-Topic: [PATCH] n_tty: wake up poll(POLLRDNORM) on receiving data
Thread-Index: AQHYEPrPXkI3P1hOVkerPpnfwSdZ9g==
Date:   Mon, 24 Jan 2022 08:17:22 +0000
Message-ID: <TYCPR01MB81902ACABDEC2602282FB81DA55E9@TYCPR01MB8190.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a8cb97a-4a5e-4ce3-8cf0-08d9df11f247
x-ms-traffictypediagnostic: TYAPR01MB4272:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4272BB976A87DA14B88B5709A55E9@TYAPR01MB4272.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O0bDGsUJD2PnStBqa2WmpOLUzt9liJE8HKTvlAfgMze2q6WOu7hgbFkRq6xYvM8Xv8lVJOtrEhM6Epdnh2y2EpVol5nFdjUDTof/s1AVcY4ZUr5f7wAfnYXFVzvWWMyHSQFaRtDoPXY8/atiSF7po37akSEz5tJyrTVtG/24ZLQPe7coimC9rWMTozZsl45U1M7bT2QY9wmaGC5fo8q69igAcj8cnuNisCiRkutG8oR9pX1cXCbgT8j6S262NjjFmQtydXr8KFnx8DoZbxfylNmzAbHep/JY9CtpIZ7Q8xOXA15Cvr1jmlsV5IlGUgVBYDRfK+JXDiiXjgRjUUS+8fAKHlcdV+9upAwQbmXTH6jJn6E61AMHOHcqK6T5xjKWEjs09rkSxTjBD/vMZ+QS81cgawYDZuJZIwGRSjjJ7ZopHHQsFPbWgmykkkm9vgbnhMRO8KhG+cTs1JmLi1jEiUr34jxvjA6qlxuFeQ0r2QzMQR91BnBztcNBcogX4uM8ASQxgBcFz8gQbCTwghsaUqVGqtI0L5b3TFdG42y3fkNqRoRSw5A5BT/+kN74XfEFW+D1k3yyQMqTIVmg9Jsvypv7lzTJ8bwiWcV2o9tZSPmZDsAwrjCjnE9SifCQOGFPpWufI+FQGtS8nATL7zqjua7niY6avK4XkOVSSiFZCoQF3qKTzTWtKGUuzFaP4Hi18canSDDYu6Ut8twCzq0/DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8190.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(82960400001)(2906002)(66556008)(64756008)(66446008)(71200400001)(316002)(4326008)(52536014)(83380400001)(110136005)(508600001)(76116006)(55236004)(7696005)(66946007)(66476007)(26005)(55016003)(9686003)(8936002)(38100700002)(8676002)(85182001)(86362001)(122000001)(38070700005)(6506007)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OTVOL29lamttd0VGZk5qWlk4MW1YUGRYODY2UExzaHY4azBLY2ZHWGR2?=
 =?iso-2022-jp?B?bGhFazNCNUNEUEJSTWwxQW8vZDBNaFB4K2ZtOHJWamVLYkZSTU92MWdL?=
 =?iso-2022-jp?B?NHR3TWdzM1UwRXIwbHFrbjZLcHpQWktSWXV0SFI2WnQ1M0pYMnRqbExS?=
 =?iso-2022-jp?B?Rmg2M0UzNzFoUXg0a0VsdU1WeVVqSW54Z2NFOSttcmlRcUcvSnNzQmVl?=
 =?iso-2022-jp?B?TGlaUUl4UVkraVVkdDY2azh4c2JucnhPNmpMUWIyaGdzYURqTktmV0Jx?=
 =?iso-2022-jp?B?WVMvSGFxMEF3NXpZekxpTi9VSWJUdXdoc2pWUk11cEkyMjVyREJSRGNm?=
 =?iso-2022-jp?B?bjNsakxNbmdlbzBtV1J3SFdLdFdSMjhHTkJlajJacnlFQWpoakk5NFR2?=
 =?iso-2022-jp?B?QWV5R1FuUVVFaEdxRWVBSWZTUWFaRWN6MEZGa050bUZZSTlMVm40bmF1?=
 =?iso-2022-jp?B?WlJlMkloTUN0dnhUNFJ4WTVWREFZY1NtbUZiZndiRHhva0I1NnFtRnBC?=
 =?iso-2022-jp?B?SW10WHd2Vm1kd3p4eEp5eGJ3TGR4UmlLaGlSczB2L0RTcWx4RHRFVUU0?=
 =?iso-2022-jp?B?T29HZ0hVWHl6RkkrK0d2T1RNUXByeGtvWG9SaVJuL3VhWU5DeDQ1Q0RJ?=
 =?iso-2022-jp?B?NHhCWjZBSUVUZmxucUJVaGhFQ3ZhRmFZOGQ4ZDA4NHZQMzlYSGFwK3V0?=
 =?iso-2022-jp?B?enJ0dis2WUp0L00waU5uVU9RKzd6TjZoL2gvejEzTWEzTXZHN2I0QWgw?=
 =?iso-2022-jp?B?TG1aMVZwUmRKN2xFOUdXcmRYRUJtZ0drUDIvbWdkK0pzWmUxcTJKRUV3?=
 =?iso-2022-jp?B?RFpyMEp5YXJKZ1hPNWljUzhGYmdzbzhXelVGaUFlOU9lQnVaRlROQ1RF?=
 =?iso-2022-jp?B?d3BPZWJqU2k3S3c4VmsxOUgvZlpFeEY3VWZnaEFhbVZBR2F2dlI4Q0hU?=
 =?iso-2022-jp?B?V25DQ2xPdk5sVWwzVUJNMDlmd2FBSWxCaC95b2NJdDhHakZ0ZklqQ2cw?=
 =?iso-2022-jp?B?U2gvT05CejJOM3cwVlZodWJ0YmVEM2N1WHFMUDJBeFdTeHpxeGplNzh2?=
 =?iso-2022-jp?B?ZG5HaWJWcnRLVWt6MmhQMjZFbVpwRjljTUxTS1hYYmlTai95VzcxVStM?=
 =?iso-2022-jp?B?Zjk2MUQrcjc2c3psVWxXbXVuOENmRHY1OFNqekVyT25QNlQ2Y2pqUjdF?=
 =?iso-2022-jp?B?VG1XNFRINHR2MGxvQjZseXRuNEFkenVkMHY4WTRZb1JLejU5dDVoWEd2?=
 =?iso-2022-jp?B?cFdwL2R6REl2WnpzeFdGYlpmaVhUaFY3N1FzWk44YmVCN3JPeE1xZEJx?=
 =?iso-2022-jp?B?QXlzTENFR084ZzlFemMrc2VYR1oySFhZdUdQMEN1aldSTzVMSk1UdjIx?=
 =?iso-2022-jp?B?ODlCMGxsKzBzSldvbmhydWNKdzZ6QlhaS0FXb1lxQ3poOTdyaUZoRkFJ?=
 =?iso-2022-jp?B?T202RkpaZEwvVEJXMkV1akR2djh3RmplU2lldXNUOW9VUEJkOW5qYk1j?=
 =?iso-2022-jp?B?WlJ6VlJ2WlNYVEJuL0xvYTdzVmtzRmdyMGxyZVd2YUxQY0h6NWEzVXBy?=
 =?iso-2022-jp?B?ZCtOTEo2dGdUNnBYN2NQK2hGeHg1QXhnQlB0ZlNhRzc5ZjROcys4dWo3?=
 =?iso-2022-jp?B?VnhRTkRac2QxZG1mZEhIQ3MzYlpSRzdTZ3NGc2xtRDF1WFRtMzFickhr?=
 =?iso-2022-jp?B?ZFg2SUpzMXV3UnRvMm8rQ1B3VXc4YUxDdHAvU3ZtZ3AxVnpneDNLN3dN?=
 =?iso-2022-jp?B?V0FOazkxNFBUNnltV2hySGRYMzZQalRJNEdCdWxXKzNOeHd5VEU1RCtm?=
 =?iso-2022-jp?B?NThjazN2by84RzhVelVtTlExWnY3V1BPVkMzc2l2SkVyTC9BK2hQM3Vt?=
 =?iso-2022-jp?B?SklIaWtzZ0U0K1NYNnBLR3VQRk9vRkRlbmVIVzYzMWE3VzgxVFBBVjdD?=
 =?iso-2022-jp?B?M0Z3aWhVUVBlRGJRK3ZNRGhvN0Jhc2RZeW1MSjl1QU43VFY2K2NqWUNJ?=
 =?iso-2022-jp?B?QWZwdnFlaCtrbXluelplZzVVQmQ4ZSt6VXhYcWZ6TW9wSi91NC8rVy9x?=
 =?iso-2022-jp?B?dVVKaFl1UWM0Y3JHQ0NWWlNwdTExbyt0aERhdi94WFNTNkZWeUQzN2xZ?=
 =?iso-2022-jp?B?ZDBybUdUbUdKWFIyRXV4K3NYYjNQYkRLOXlQYjg0SUROTTlBZ1pGbVkz?=
 =?iso-2022-jp?B?cWh5bHkzdW1DVHhFOXBEWUVsK3FPU0p2R2I5T0VVbTEvUEo3ODZFNXpP?=
 =?iso-2022-jp?B?Y2hYQ3c0Wm1OWitUVndJc3RhK0M3d29oTXRQZWo4a0lpYkd0dnNmNEVt?=
 =?iso-2022-jp?B?d2lIU1ZJZENYUVhpeHd0VGFKVHRmZFovSkVpYmxSdTNzdzVwWVJBc21B?=
 =?iso-2022-jp?B?ZXBFakE9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B787E0ECC6A3674685EBA2BB6448C2D0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8190.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8cb97a-4a5e-4ce3-8cf0-08d9df11f247
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 08:17:22.1451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nILGHgFYZ3Cgn7NFMvMeY/uc028DMZCfMPcFNHJNrIbOLVxlNgj+J+szewVcqkqrDR1eGfSJsu28gxuW0NlKFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4272
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event POLLRDNORM should be equivalent to POLLIN when used as event in
poll().  However, in n_tty driver, POLLRDNORM does not return until
timeout even if there is terminal input, whereas POLLIN returns.

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

The attached patch fixes this problem.

Signed-off-by: Kosuke Tatsukawa <tatsu-ab1@nec.com>
Fixes: commit 57087d515441 ("tty: Fix spurious poll() wakeups")
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
