Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22994CEC31
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 17:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiCFQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 11:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiCFQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 11:03:46 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021014.outbound.protection.outlook.com [52.101.57.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5C3BA4B;
        Sun,  6 Mar 2022 08:02:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co6hInzZiqWMjwdpUiUMiHriKvocHYwQ2zUySEw8AYyLcSia+K07S/ihmsW2OrVrLjmRimYfD9S6JXNnFqGIGxTcpZWybJaexu9MiYTbUvBI0JZXrLIv1TyUlUWd3JRXIxzfx6ew0Ocny0A+MIrg9rdkkSXerTvs3D1Yb6zydtmbkBYicF6XLpS9p9mgJU/cov7rLQ5UYZYy47QxJjpWEyG+9bPyxBWY8mKYfM3yqBZ5uZqVCONAYlmryky+gVrwyBcF4EF7HeYNIDrnYPkgOWiF607fyOvnFpc+hnV/xv7qGvO9STf3UtdomPo6/BlBR1uUONSzImr1X+rIdxInFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnke4lPoaScJHo9L7m5jISnp14xkfG4MCBlJBl2uOpc=;
 b=e20ExeGMduQ9O5Brz+hZm0mMVMd+1sXCAMSXz0jRAXhOpwWFbSJHCWkxi+qe/GhJbFyFrHTCVt4MgLt/fIKfD9MS6ybuWs1x8fY96unQeWTTUR6U5qpaon392tYH9Zinsik2SMLn8pdrbH6zoGXZYON8oTPCAFcCDPiAmx6Elr8Ri99j8kouXVa/MJTPN5AgHWwf7vEb0eBMb+LWaayrFFgV4lbw1b+fGCozxyBKIQ5Jl+FGH0fF3UfE3LFMy5J27xCbVB+/w0WPIJRayHAdK4xz6mFPyB7550WWjgrit8/PW3cxYD/VRpA3+C3d56bCKlOi7aAK3Fdxv5684O+alQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnke4lPoaScJHo9L7m5jISnp14xkfG4MCBlJBl2uOpc=;
 b=CTE21n6xsXrvueOULNLbR/Bym8xU0Aa8G4X5szXz1AmdxA9hS5Fq1vAeAWzX71Z/U7LAm6ZFu7H5z5zLcDFS9xLf0uduA9GNCqWYxGGxneMkalBHiRkpXgXC8FLvvrNcd2DSjkHIOcJQ4xlFg95xgkWWX+NcpHDbKKtp41OxI6E=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by SJ0PR21MB2024.namprd21.prod.outlook.com (2603:10b6:a03:395::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.3; Sun, 6 Mar
 2022 16:02:44 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::a0b3:c840:b085:5d7b]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::a0b3:c840:b085:5d7b%8]) with mapi id 15.20.5061.008; Sun, 6 Mar 2022
 16:02:43 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     jason <jason@zx2c4.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "souradch.linux@gmail.com" <souradch.linux@gmail.com>
CC:     jason <jason@zx2c4.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Catangiu <adrian@parity.io>,
        =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Laszlo Ersek <lersek@redhat.com>
Subject: RE: [PATCH v5 3/3] virt: vmgenid: introduce driver for reinitializing
 RNG on VM fork
Thread-Topic: [PATCH v5 3/3] virt: vmgenid: introduce driver for
 reinitializing RNG on VM fork
Thread-Index: AQHYK11gIYiE2nIxS0mrVE8/JU+KrKyyjVcQ
Date:   Sun, 6 Mar 2022 16:02:43 +0000
Message-ID: <MN0PR21MB3098869F7EF526BF6E18A00DD7079@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <20220226220639.1173594-1-Jason@zx2c4.com>
 <20220226220639.1173594-4-Jason@zx2c4.com>
In-Reply-To: <20220226220639.1173594-4-Jason@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d5631f25-7439-4542-ada7-b8177f6b2162;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-06T15:51:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a33e37a2-3b73-4e98-3bc8-08d9ff8abfd2
x-ms-traffictypediagnostic: SJ0PR21MB2024:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SJ0PR21MB2024D6B1F26CD1C5393F3D44D7079@SJ0PR21MB2024.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Iy5miJ1pBytUqglGU6SENDsWG39+qyG9zgLGbo9OOqOeiaY9DPCCV75FSe1jBjbOyrvA+aR36LZxrbofoeGdrOru1VGPJh5l9N2CuEbCsDbvXgYTHVKPjr/HLzaKZ99ajqfDcZnIbyQpYmwjyMrGTsRdWXRdpHctcCMwCMyhO3ImHW2RQBndWFXBhQPqUPcESMe4z7lTIQQkWlmzjGS+cBEtOBEKmf1E8VWwEZV7Xs0EopmJHhUpyL9PFsfitwSByYrbNYw3KEIPOYpHj8+f3PuOXO8kzm9Vn2PCHVQdbEqZTfXXOVY+9zDZ5t2kZycKhccwGHYvOniP9u5iow3p2UwiZCPqEUl/6/92sVdNZzA16Cx2CW4oCmAYP8Mf/bO07SVVOqTM/N75yWiBGZkZFhGjtiRjxA2JyXung0RxmXxGL0XINb8P+Y2PFbO/1CTgIGJY2d2yBeC5Jxasgil8CmrjEZQKuzV7F75kdW+r9oyHqQqKFmOT0fTH8a1OdvQ5xxcIX/E3BbFQTPZnaR+Z7HT8nw+hZyXx+Zc/T7dXYWpQVOBo8H4eOEdfsL/0M+l/W4SF8FB1W6sX8Jn1DXjMGppZyUrT+qYDNW7goyshiBU9LTwh06yw/Co4c8mRMaqpoBzoHRH/Y/eYYJQwcyLMwilRUwWS8vGph/6L591f527Yd3vFq1srIqIA+5XjOeEGjTpR9+6wmr67udL64/jAPrDOT/5ciabAJ/whLPJHWZtAEiZMCAH0iTwT1mTXnVJfIVx/RbKMEFbBPjpWU9finpE+tLMznSeiLtD2zQSrCrCxbI9U6w1bnwd4Ovzpl3Ky7v8y6gydqjl4bcxjew0YBJj0zBKih8uvO/I6SrUhTi9FD3G5xsEuRb0jjoAnedC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(38100700002)(2906002)(7696005)(33656002)(8936002)(52536014)(66476007)(64756008)(26005)(5660300002)(4326008)(54906003)(186003)(6506007)(508600001)(66556008)(9686003)(316002)(38070700005)(76116006)(82950400001)(71200400001)(82960400001)(8676002)(122000001)(86362001)(10290500003)(8990500004)(110136005)(7416002)(66946007)(83380400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vZZzUPRbn1vM/KiDwOYyXqIPUlCMEB/qCv3kM2ZODfxVwgnSn0SLfj18a3?=
 =?iso-8859-1?Q?4J/OcF7/nmV3IBtu+k4+aWamkzhra4fRYVYVZtokS9i7vxCJpn/RAU3LHM?=
 =?iso-8859-1?Q?2U3WF66U24T4cyRAwHdA4E9r8ujhkQ32dS7RqCnfYZTLWWhNXge9m7iGb2?=
 =?iso-8859-1?Q?bviilaHNIh8UodvJ7WpePneMferFbAnAJ3lSXj1bMaxZiQGFKPwVnTHIYq?=
 =?iso-8859-1?Q?OeEIYU6ZUsm/Q7AEXBUyPKTkG8BBkqjoygNXmU25zptpn67fQn6NgMPk2i?=
 =?iso-8859-1?Q?T8d5Hnh7ReqmijM0IpDl9w22qhQWinNk0IQG/YfdLxUtmJRgTf7Dqb6WKZ?=
 =?iso-8859-1?Q?MNdYglZGTSlXHrQRDO194cFkg3IOkXIn7CFkQm8bq7+j3WA2WzWovDMHVU?=
 =?iso-8859-1?Q?/kfpwD/l1F/QT9riRAOj4CrD1g9dW3Ah3Wcm/+fxv7FEg8/0vDsevkbnrf?=
 =?iso-8859-1?Q?IMPxzJKpXYoPg2muepRnFmvNsIlFWYiNWA0yNtjmyB+kg/o66CZLz7P2pp?=
 =?iso-8859-1?Q?dV6h70qkzyvdOVlxH1W19yXMQNVIdtEI8z0pMWJ0DyMySCBKaK2TUmo/CR?=
 =?iso-8859-1?Q?k98ES33yuhj1FrK18QOEeY4W2JIqUHuK4b/ABnrP3OBI8h07VNjAsMTOJf?=
 =?iso-8859-1?Q?/xstkTwuTWFtSZjvK21PHm+sZ+m9pv99NOlausQ8fXqRM2NJjEAGNCdOGp?=
 =?iso-8859-1?Q?YIQyLBnbe+4OA27r/vp8+UC/9FYTd1SMnvx0dQYVPf62XYq+HE9hufTvtg?=
 =?iso-8859-1?Q?FnmgUsQnDdHOpKcdGKPcsJ4SImkU9+P6V8aHJH1G0pb1HRpeaYNR7PnlSl?=
 =?iso-8859-1?Q?OdSP4m6L9mF/lpofAZOBW45HvaO9vmdwQN8iShnD+mtIJGOjjKPe8Rrybp?=
 =?iso-8859-1?Q?gwQxIvAod8TbATZmAMXbIdoPru/it6Udtz7MmqMzulnD9NhkE8d/LX97/u?=
 =?iso-8859-1?Q?mPKMR2xbAocN6DuJYkMyW24Nv5vNMrzRHDOi3YrsL8hX8Ef4/X/ub82QzS?=
 =?iso-8859-1?Q?rPZaQjP7dg04NoxuBgBjf7hyK0axHh7asoyMN5jpT8d8X1mQNBbTqEbYpY?=
 =?iso-8859-1?Q?5RfvHBuMyuqxMgdGDB/9dXkejt9NqZQDaNHvdqVFVEolryoGNghAlibG+S?=
 =?iso-8859-1?Q?LkSKcqSi8ayuqMFbpOKERe8e3F2UQD5xuoVPTjr+fxOzeigCMI+1UEQnSA?=
 =?iso-8859-1?Q?ykXqTUdbKmC6j/jKVdOgCuw6hmiSrW0CuJobtBuynVimcq9kARAV7n3iyz?=
 =?iso-8859-1?Q?XhugAQTd3W8YvpOGPdteEAuKoVpHNkisOx0lbY0n5A5TRe1tsByYL+O8lg?=
 =?iso-8859-1?Q?nfzKT74GWUnVJfnG9XnjpkJ40l2qkx9+EoQODYoqi5k1klyEk87UdnujAa?=
 =?iso-8859-1?Q?ux7LZVcSIenkpVsKcD5mGwMAsNkLjIhydOVgZfOvOIjgHTridbe8XCTH7O?=
 =?iso-8859-1?Q?s7y1ENAzQU8raQVfiZIP96mmNZg1VJrW9afL5GQtAmEDEtapP7yggLcwBg?=
 =?iso-8859-1?Q?Z26En8xGK1kuD1XJgV9U5THYOB4e/h8Py3SGecOujn5A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33e37a2-3b73-4e98-3bc8-08d9ff8abfd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2022 16:02:43.7282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mw5dMhmfNo2yKfVf/m1xpL/he5pB06YXvNS3jahwJWXpm+xNZx1Xl67Q9AiRs1jcu4+eP+c52UKMopw4IBMELv6ScGZvt7b2FeoCu7Hor0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2024
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Souradeep Chakrabarti <souradch.linux@gmail.com>

Jason A. Donenfeld <Jason@zx2c4.com> Sent: Saturday, February 26, 2022 2:07=
 PM
>=20
> VM Generation ID is a feature from Microsoft, described at
> <https://go.microsoft.com/fwlink/?LinkId=3D260709>, and supported by
> Hyper-V and QEMU. Its usage is described in Microsoft's RNG whitepaper,
> <https://aka.ms/win10rng>, as:
>=20
>     If the OS is running in a VM, there is a problem that most
>     hypervisors can snapshot the state of the machine and later rewind
>     the VM state to the saved state. This results in the machine running
>     a second time with the exact same RNG state, which leads to serious
>     security problems.  To reduce the window of vulnerability, Windows
>     10 on a Hyper-V VM will detect when the VM state is reset, retrieve
>     a unique (not random) value from the hypervisor, and reseed the root
>     RNG with that unique value.  This does not eliminate the
>     vulnerability, but it greatly reduces the time during which the RNG
>     system will produce the same outputs as it did during a previous
>     instantiation of the same VM state.
>=20
> Linux has the same issue, and given that vmgenid is supported already by
> multiple hypervisors, we can implement more or less the same solution.
> So this commit wires up the vmgenid ACPI notification to the RNG's newly
> added add_vmfork_randomness() function.
>=20
> It can be used from qemu via the `-device vmgenid,guid=3Dauto` parameter.
> After setting that, use `savevm` in the monitor to save the VM state,
> then quit QEMU, start it again, and use `loadvm`. That will trigger this
> driver's notify function, which hands the new UUID to the RNG. This is
> described in <https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/specs/=
vmgenid.txt>.
> And there are hooks for this in libvirt as well, described in
> <https://libvirt.org/formatdomain.html#general-metadata>.
>=20
> Note, however, that the treatment of this as a UUID is considered to be
> an accidental QEMU nuance, per
> <https://github.com/libguestfs/virt-v2v/blob/master/docs/vm-generation-id=
-across-hypervisors.txt>,
> so this driver simply treats these bytes as an opaque 128-bit binary
> blob, as per the spec. This doesn't really make a difference anyway,
> considering that's how it ends up when handed to the RNG in the end.
>=20
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Adrian Catangiu <adrian@parity.io>
> Cc: Daniel P. Berrang=E9 <berrange@redhat.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

The patch has been successfully verified in Hyper-V. I have used checkpoint
to create snapshot and restarted the VM multiple times from the same snapsh=
ot
by applying it each time. To confirm the unique VM generation id, printk ha=
s
been used to print the value each time.

Tested-by: Souradeep Chakrabarti <souradch.linux@gmail.com>

> ---
> Changes v4->v5:
> - [Greg] Use module_acpi_driver instead of writing my own code.
> - [Alex] Match on _CID instead of _HID.
> - Prefer Y over M but still allow M, to handle initramfs reseeds.
> - [Wei] Use IS_ERR instead of NULL check with devm_memremap.
>=20
>  MAINTAINERS            |   1 +
>  drivers/virt/Kconfig   |  11 +++++
>  drivers/virt/Makefile  |   1 +
>  drivers/virt/vmgenid.c | 100 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 113 insertions(+)
>  create mode 100644 drivers/virt/vmgenid.c
>=20
