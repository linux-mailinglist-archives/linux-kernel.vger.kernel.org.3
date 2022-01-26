Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70B049D62D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiAZXem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:34:42 -0500
Received: from mail-os0jpn01on2063.outbound.protection.outlook.com ([40.107.113.63]:56964
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229725AbiAZXel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:34:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnVmBzdk66Omyt886SXpa9cfAQoY8RMm8U+wjSzzv3hf4eWIgJQdEnYBm3Xf7Rrdwd1oKrG0vs3+0CE9CKHLXJ/9qyhZDrhH6XGSl/f99pzyKwZuBQwdQ0ODnykE9CDt1cuvxmpA8z09rp4vsgHA4qVFWvkGQdx3lSLPYC5RcQ6zgJwdhXKUYC3F14xllazKamxHT1GdiwNS+lBycxIXPGqX+azS3uKZpqwB5RRcvDeDPFlR3yNpqHaLU15EiB6t/KCJQmTbFuvXD4GiG6bcv8M6sZjqIcjYuZScJ9TcI6GzhPNKRW5WH6Eiwn4O0EdN9AgEv5n9xI1hZbPVEs47QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2NTKlVEiRN0VV5m/LQkVTqc0JdsKsVYZx4JYL7L0Vk=;
 b=CxB9ElDxi7Md4C/rL95RYrADw6Bze8xXUknIIujWY/X/CVY6aSqtdTv0ZTYXE4BwG6E80KW7NVpbpoB0/4tf2/KjO989hstejf6zxnv86aCfI2LOuSMMNaq7dMAYJ7GQ/xhF7zzB/Vu7yEqt0g+c5JEojUEmjJCE4Mhma4lLEKp3/5lrba5Ex0heth27erwqWZFZ57sN7Nvb648GpK+0XvT2xozj3gX24asNYmC/wHKdyXoO7TU0Jn64ikO9UqU8+gutUYga6YpEVrbnLpfm79Qc3S8ErXk6Nbpwq1yl71j56DxfP9WUy7/NaqZ6tS5DOqt/oDUKUYiCm/R2sNoeqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2NTKlVEiRN0VV5m/LQkVTqc0JdsKsVYZx4JYL7L0Vk=;
 b=hKycsVkZBYgepLYikD2PQejsDqXC4wTes04Q8kKOhfuDLl1Hb0SInUeZCkrX8b0tWpzXIUP+FTzYPqqBGwjEkl3CKl2gAfMaCyxBgctfDqn9oa01Sjl7tZC+M05JnjmZRb5Jb4ew5StXSn4wA0N57gmmI3rSZCDLlbIh6PLwLlY=
Received: from TYCPR01MB8190.jpnprd01.prod.outlook.com (2603:1096:400:103::9)
 by TY2PR01MB3691.jpnprd01.prod.outlook.com (2603:1096:404:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Wed, 26 Jan
 2022 23:34:39 +0000
Received: from TYCPR01MB8190.jpnprd01.prod.outlook.com
 ([fe80::81f9:7ce5:226b:6237]) by TYCPR01MB8190.jpnprd01.prod.outlook.com
 ([fe80::81f9:7ce5:226b:6237%7]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 23:34:39 +0000
From:   =?iso-2022-jp?B?VEFUU1VLQVdBIEtPU1VLRSgbJEJOKUBuISE5PjJwGyhCKQ==?= 
        <tatsu-ab1@nec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] n_tty: wake up poll(POLLRDNORM) on receiving data 
Thread-Topic: [PATCH] n_tty: wake up poll(POLLRDNORM) on receiving data 
Thread-Index: AQHYEw1Jxn0XOa6SIUqUi15Ymxz4KQ==
Date:   Wed, 26 Jan 2022 23:34:39 +0000
Message-ID: <TYCPR01MB81901234932D9FD1327DF093A5209@TYCPR01MB8190.jpnprd01.prod.outlook.com>
In-Reply-To: <YfFRVkmtSsXPanS5@kroah.com> 
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19110e99-c981-4720-9468-08d9e1246bb9
x-ms-traffictypediagnostic: TY2PR01MB3691:EE_
x-microsoft-antispam-prvs: <TY2PR01MB36918363F8F5BC28C62F8B1BA5209@TY2PR01MB3691.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Bwbwk+kl+GI/hDFczUesPyPxbP6kNn0r7djzfyYdkkNKhX656kKcp9d00RYydbeSgsvIyc+r8F4MUD/tdEJuq3MRF2MPFE5VVX/BHaTLGp6ZrLt3TZ/QLWmrnPtjUvzzqVneTfio84ccstJ5QKXUlltBD+PHKP5/5coUK8HWqTst2VlfocskkH7kiC4EwU7VaIBhcrWLe1vP2O0lXV1KisRxFFT6RDfLccCll1d1AKFP5Pt/MEkhbcAhx3O52M4BV2VTJ5BB2tKqToLD88dEKgO9lO7aiEBlgQ5UoBljlrMi4jqtwbosNspxB+ZDLvS3G6nDHb/jypBCMyWIozLkzw+igCvnqgODcUG95PMOZQdKAek5+m+5/8cJhjrPCzRdtRyY0HcdkH6IrxYpJzU3Hl0dWQ+Jn+hla78urPgq2JTG+Ae9l3LjZeScYlonImx9acsY4LRiAVQCMO7HRXfeZRYNg6ijBo3IjelH2fUf1OJ/4QYPoO9d3kHhsQfcZHcX0dMFF7vWZ3TN1xbwMs1tBAwhj7IwgXsYYPsvqfQgiW8dC7FNlBVeJ/c0urgGTl3gMVH6hZAybN1OOGiWG4hKRksgErUl/QHuKDTBG9ybctpOpvsowWqTsJ/t/EXC95HcTjUbIGR1sp4imR0zwUVdNWjDwMz6UXMtezZQEmp0JxyJcnV1btRbWpGoErOOiPC/L04ZBPEThr38NNKRUBYRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8190.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(64756008)(71200400001)(38070700005)(66556008)(66476007)(66446008)(66946007)(5660300002)(7696005)(82960400001)(122000001)(316002)(2906002)(55016003)(38100700002)(85182001)(76116006)(54906003)(6916009)(83380400001)(8676002)(9686003)(186003)(6506007)(4743002)(86362001)(8936002)(55236004)(4326008)(33656002)(26005)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YU04aGl0NGxrV3VKcDVZSWZUcVV5cWQ3TnpqblVOdTdvYjRBWEtNWFNP?=
 =?iso-2022-jp?B?YnJ2SDI3NllhZzd2OGF0TU1uVDRpUEZsUm5NaXd2SG0zWGQ5bVRBMmpE?=
 =?iso-2022-jp?B?bjQ5YzRkazcyVFdOV25BMzA4bVpQQjJ4L3R6V2dQZTRXTDYrOHNCMWht?=
 =?iso-2022-jp?B?RWx6cSt2YTZCK2tKMGZCNkpsaCtVWmVHZ0t4NFREOTh0RmRBZFF4VjJC?=
 =?iso-2022-jp?B?TU1FMTN0cXd3eGJHSE1BNjVqakNpb0t4SG8wS0tZbUsxNXlkSWNBOGdT?=
 =?iso-2022-jp?B?dmF2c1FXRUxCbDc1ODY3WENuOFBtN0hjMUJDUWVSeGt3NjdIZzZIcFBC?=
 =?iso-2022-jp?B?dVVobTBoREtXdHZTYWdhWmt0elUrSWhyVllzYTd6Yy92VGlmNDNrQ1A2?=
 =?iso-2022-jp?B?SisyVFRJWlplcFBsSER3UHFDWWVrejBaaXJVS3V2ZWdoOWVxRVBhQXdH?=
 =?iso-2022-jp?B?WTMyRk12Z3JnWjl5MlJURXJmVEsxVGd2cVlCWlVsR01helYyZWM2MVRl?=
 =?iso-2022-jp?B?QjJBS3phK1BwTXlYUURWa2x6d1BDemdEM3lxbVBUSjNBZCswYVlPbHVK?=
 =?iso-2022-jp?B?SitOL0U5NUQwS3dVWGh2b3dpTS9kc2I4dWRHY2JkZmJKVXo1ZHloK1hQ?=
 =?iso-2022-jp?B?TTZIWmdldDFuUEpJSENERVFkKzNUS3JVZDZob2tSbnNvOFliclU0UDdQ?=
 =?iso-2022-jp?B?djFyLzhJTU1lcHYzOVR6T3dYc2U1RGlvOE1YUHVpRzl5bTRkRkdBT3Vi?=
 =?iso-2022-jp?B?N3pnaTd1MDNkdHJiTFU3WTFtZC9ob0xydzE0NThWZnVYQ1NuTTI3RDd4?=
 =?iso-2022-jp?B?Um9uUlQzNWRhMzJXUzRrYmlxVFhvTHJtanpGUnlwdWxRTklUb1lRWDBQ?=
 =?iso-2022-jp?B?dnQ0TTV4Y1EyMVBNbFNmajYvNTJGT1NqTFBhczJlWnZycnA4TldpalNh?=
 =?iso-2022-jp?B?bnQxQ2dlL0xSMDc5UDZrMTlPZ0Jua3hTbDRSQXN3TFduWkZsMjVkSjNi?=
 =?iso-2022-jp?B?Wk9nUm5IR3JLd0N3aTBEdERuRWRJYlVxQVlLNURmVm1NbXJnMFVFVzBF?=
 =?iso-2022-jp?B?Z2xtUW9nR094cmVMNktFcWFNS2VETW4xbjJjeHB3MVZGRW1yclVtSEZa?=
 =?iso-2022-jp?B?NVRWRXBtbU1JSms1ZDBFa0JOYzhwK3VhTWtiU3VUcUtoM1B2ZkRvRGpT?=
 =?iso-2022-jp?B?UkZQeTc4dWdQdjJEc0RIWkNFcSt6M2E0NTRHcjE2Mzl3Zld6N1VWQk03?=
 =?iso-2022-jp?B?cUpoSUcxL212Mm1wN3BpR2VGVTNpUUZwTzBMb1o0VDcySVB5bkZybkoy?=
 =?iso-2022-jp?B?c0N0cGk2bVcycGFYZmJ5bGhUMWFkMFRqZHV0ckpsWUxXMlFRcE5zd3hT?=
 =?iso-2022-jp?B?WkVPWWlncDRCanA0bCtseHpHMnBSaDFQRHArbEtxZFNPdTE0Yys5ckdW?=
 =?iso-2022-jp?B?NDh1UWY5SHd6WWo3eXQwaDBGNVIyVzd5MzZlVUptZWVTa1Q1T1RBVjNY?=
 =?iso-2022-jp?B?bk1nTVZ1SGhFMUErQnN0emllb1hMVHFiKzlzSVBwcDZNVHZrRVhpMDlM?=
 =?iso-2022-jp?B?OEhZOGhsT2o3NWhJM04yL0ZUS0t1OEdqdk5uRDlmL1k3M1FXVzNwRkJp?=
 =?iso-2022-jp?B?WFNFRWY0NVVwUytVOHNOM1Z2T2xFNWdabE1sYTFXTTV2K3JscTFNK213?=
 =?iso-2022-jp?B?b0dTYng1dGNlWnZ1eFBNZWs2TTZXNVZoNDEycDEzVzk4eTdrZjUxY2lj?=
 =?iso-2022-jp?B?dVY2dkMyWU5jRVNKTU8rZ0YzNFpYaGRtdUVFcmNQemlrVmEyd2RKN2p1?=
 =?iso-2022-jp?B?NmdrMysveHVuOWNhRVYxQWxCMTRFTCtITEwwalRlcTAzQkw4VVQ2RXFB?=
 =?iso-2022-jp?B?bDh3S292MzYyT2xVMWQ3MG9WTVp1cExoMUswWjNkaVZvRzRHS2dqZFJV?=
 =?iso-2022-jp?B?ZDFSL2JmSVdRLzEwTWxlNGxOUVRHYTNMSHlrYnc1OXh0ZkMwNXB1L3I2?=
 =?iso-2022-jp?B?VFVUb1Z5aUpNcGJONk53dlh3NW8xVlRVb3Yva3NZS241RTlaZDdtcXph?=
 =?iso-2022-jp?B?N0pzdW9nbjVtRXRSNVhlNkFvTVdVcEpRY0Zkbnh6WjBBSlRKeTQ5VTl0?=
 =?iso-2022-jp?B?VmJ6aHF2c0RUUDZ2K0ErUHYwb0FuSnZuMDZzZXR0K09YL09sMXBncFBN?=
 =?iso-2022-jp?B?QXczZ05kSjMvUkhBUHZUR1J2bjZCTFJDcHV3UGE3VmNrQzRWQy9WV1pQ?=
 =?iso-2022-jp?B?cTZPRXNCdHN1aHVNR2xaSVVBM01TOWtrSTRlcmRCT3htLzYzdnU2bGEz?=
 =?iso-2022-jp?B?M2R1WFdPd2xNNGVEc09rOUJoMzR4SEVxZ1lMUGNreXoyODRua3BlZEZm?=
 =?iso-2022-jp?B?dzM5OE4zbEpUMmFCbDU2SlBrbDJTVFhRSXY=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <47E09DE835629B45A195609D1B0519F2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8190.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19110e99-c981-4720-9468-08d9e1246bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 23:34:39.0747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4+nOdU1Dh6tAOaveWBw8AgIYZ/VOyIuax4XOPzefQm/0sTs5EcyiM35MNW257YxZvCpZWfrnxxb9d9QtD2YIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you for the reply.

> On Mon, Jan 24, 2022 at 08:17:22AM +0000, TATSUKAWA KOSUKE(=1B$BN)@n=1B(B=
 =1B$B9>2p=1B(B) wrote:
> > Event POLLRDNORM should be equivalent to POLLIN when used as event in
> > poll().
>=20
> Where is that documented?

It's in "man poll".  Below is an excerpt from the man page.
              POLLRDNORM
                     Equivalent to POLLIN.

I'll send a v2 patch in a separate message.

Many other calls to wake_up_interruptible_poll() in the kernel source
code already specify "POLLIN | POLLRDNORM", but there are places under
drivers/tty which only passes POLLIN (i.e. pty.c, tty_io.c,
tty_ldisc.c).  I haven't yet made test programs to hit the other
locations and I wasn't sure if they should also be fixed just for
consistency.

Best regards.


> > However, in n_tty driver, POLLRDNORM does not return until
> > timeout even if there is terminal input, whereas POLLIN returns.
> >=20
> > The following test program works until kernel-3.17, but the test stops
> > in poll() after commit 57087d515441 ("tty: Fix spurious poll() wakeups"=
).
> >=20
> > [Steps to run test program]
> >   $ cc -o test-pollrdnorm test-pollrdnorm.c
> >   $ ./test-pollrdnorm
> >   foo          <-- Type in something from the terminal followed by [RET=
].
> >                    The string should be echoed back.
> >=20
> >   ------------------------< test-pollrdnorm.c >------------------------
> >   #include <stdio.h>
> >   #include <errno.h>
> >   #include <poll.h>
> >   #include <unistd.h>
> >=20
> >   void main(void)
> >   {
> > 	int		n;
> > 	unsigned char	buf[8];
> > 	struct pollfd	fds[1] =3D {{ 0, POLLRDNORM, 0 }};
> >=20
> > 	n =3D poll(fds, 1, -1);
> > 	if (n < 0)
> > 		perror("poll");
> > 	n =3D read(0, buf, 8);
> > 	if (n < 0)
> > 		perror("read");
> > 	if (n > 0)
> > 		write(1, buf, n);
> >   }
> >   ---------------------------------------------------------------------=
---
> >=20
> > The attached patch fixes this problem.
> >=20
> > Signed-off-by: Kosuke Tatsukawa <tatsu-ab1@nec.com>
> > Fixes: commit 57087d515441 ("tty: Fix spurious poll() wakeups")
>=20
> No need for "commit" here, please remove as the documentation asks you
> to.
>=20
> Can you resend this with this fixed up, and a pointer to where the
> documentation is for this functionality.
>=20
> thanks,
>=20
> greg k-h
---
Kosuke TATSUKAWA  | 1st Platform Software Division
                  | NEC Solution Innovators
                  | tatsu-ab1@nec.com=
