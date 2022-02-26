Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80FD4C5499
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 09:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiBZIRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 03:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBZIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 03:17:48 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA56299CA5;
        Sat, 26 Feb 2022 00:17:15 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21Q7q7Sf013375;
        Sat, 26 Feb 2022 00:17:00 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3eexvmbwa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Feb 2022 00:17:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQuPdhe15FtZkJwle9ihgkb5np9L3/O6qKKgpXZNu5mREbIRXkFxU6oGl6dAXH1Ahvan3bHB13bK3ARh7ktUQcoa17OX31loZ3wFx4kxHr68OI6917CiSjZi3XQZd5OPhIkc0+sXflbA3dK5ULCZWMzkgmm9LWZlkuKpb6zSSVIQSWTRPHkKtoobYtm2OaK3cW2SCcTEXy4APgGnianxePA10etxel4DrTc/7yyTZgngnNSRRiHTfxESNN68wH8FFJyhc0ID4kHgRFQNAA3HEIx5u8JOw5UjFFHujht8aEmXS+LzBNbF5SAaC9V7rVPZeSuGORkSz0mTzx3Ky17Sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fQZpvF4gxHq3nFndW7QPUtap3N2s2CsVLAkomvA8Bw=;
 b=NdrDPIL04P0kRJt/jHliVWTcXecHng5FtZSpWG3zwR8kXqWaOOZIBuCDVBQR5EyuK5G4GEd0w1IFL89RUaxpFTs1X+XUEifh82/FTGhJeQlcL5i2F7yUcBUpqO6B4sPy38D8POIGQgIIJH/Yh4sXpSh3BrQCX5Or5vEZziKsW3gErF3+WKarL8FxTIVa3FA/DjnvsTEQ8s3+Cq/Hl/ifO0j4jdnUuJn/RDnOpRs9DPpJOK0bEt2flXtZ7KKno1YY+n6babbxQr+Rx/TdK8UpK7vK9p3lowGr0Ma138o6ULEdevqKez72Ikq1MHB+H9K4dcZepbSgyaispVvgHVhjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fQZpvF4gxHq3nFndW7QPUtap3N2s2CsVLAkomvA8Bw=;
 b=Ni9dUvJV+hHKGYlJ6Ehj4bgxZHn/ybN1U5/zfTPlhcT1/rKhGOjefkUmqLx7p29znFhRMBeNITaJioY+nI4RqSeBxhDmlekNf7XcuEGRvwZWJdWG+SpIB0F6k12XQaNYFPi8cWvJj854t7TVtHsvNEePodnreC2GDNg6i9WPBE4=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by SJ0PR18MB5137.namprd18.prod.outlook.com (2603:10b6:a03:438::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sat, 26 Feb
 2022 08:16:56 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::b4b8:1371:6d16:1521]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::b4b8:1371:6d16:1521%8]) with mapi id 15.20.5017.026; Sat, 26 Feb 2022
 08:16:56 +0000
From:   Sunil Kovvuri Goutham <sgoutham@marvell.com>
To:     Wan Jiabing <wanjiabing@vivo.com>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jiabing.wan@qq.com" <jiabing.wan@qq.com>
Subject: RE: [EXT] [PATCH] hwrng: cavium: fix NULL but dereferenced coccicheck
 error
Thread-Topic: [EXT] [PATCH] hwrng: cavium: fix NULL but dereferenced
 coccicheck error
Thread-Index: AQHYKhJxrR9dzEQ5a0aiW/kWobxjsaylfcAA
Date:   Sat, 26 Feb 2022 08:16:56 +0000
Message-ID: <BY3PR18MB4737A9EEA5F59B9089A4306DC63F9@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20220225063901.893274-1-wanjiabing@vivo.com>
In-Reply-To: <20220225063901.893274-1-wanjiabing@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 435786a0-30a5-4c11-1371-08d9f9005ac6
x-ms-traffictypediagnostic: SJ0PR18MB5137:EE_
x-microsoft-antispam-prvs: <SJ0PR18MB51379305808D6DB186E49728C63F9@SJ0PR18MB5137.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhDWHkHy+s1T+T+YWFUzCSR2JWX8pO7zAEoaeOcxiRbw/oPlLLBpZtBMj4ojVRcZrGNI6bzw0dVSBQIZZXAx8IQGFt5KxjmKlsBsbqd9sp8yHOtNl1CpWbyDjaHVizSAW7K+VKMIL3QmMt1AUARfIgSZ27Wxo0PLaXhoLLJAPY7kNKco+MkGz0zmyC831cJTkH5p3hMiUAj3L/GfNBnvOllfK1/8KUKeVYvPNGjj+IO+5LxJAN19hHuqQt7NzpW53wK3nl4VLy3e7aKQZgfCIoiFZlE5gsEMpuLhFp+5w+/uIGkNjmkOTWG/BfDLVHX0oY2IVA1GV0l8OwxZNDBS4wxS9eLA2dttx42xjJ26rjRZILkMXSCK4gFheLRERCYsqpvwMzaWiKkwZMZzWQ8kSjXs1ihVgFeo9lwqhXpWvRJ9N8FUFlnA91n9moMRN+24SZEgj5hDKqqzrjtYnhtehA0jSlk5kHF1ltM+m7ZjnTJkO3+B3ttFwxZL4HU61y2ABBIbcGPuuBUdH5r9vjxFr2PFq0C+0dRgBckJvBjs46zBA4or81bnnh8U+YHGM6H81EpYXM9KT9vwvssByqWjWwV2XswnDRzGSyNP1CcrjCa+JHksqmZO57x45L1y4UtQ7rWgUMOEBSOOg0d6WIfDJ6fmwORcOWLDFkBLRRbOE5s1Vi4Fyz6db52YW4aMUZ1fQyvo+nJH9KHMSiBpUhoyEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(2906002)(86362001)(66946007)(38070700005)(83380400001)(186003)(52536014)(9686003)(71200400001)(122000001)(53546011)(5660300002)(8936002)(66476007)(76116006)(66446008)(26005)(33656002)(110136005)(55016003)(38100700002)(508600001)(64756008)(4326008)(8676002)(66556008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uSrCJXhIb5SAUd5GToBEB05C0hW0c1WgtBn+b6KQPvJuv+GWWprmsPBP4tYl?=
 =?us-ascii?Q?1HvXFEmoRD5/cDQj8yScTpsuiZqmvQBfZxwKu75fP9v5OLDQ5KwEuxCC8adg?=
 =?us-ascii?Q?se59N6Oa9h61sCgzrk+fiCmE40TAlrYFPTbaRJ4Ozwvr7aIpm9I5PQB3Y6uN?=
 =?us-ascii?Q?pgp4ObhmYkFqeumcu6ooFnfL5vJ8ztMMlROm50v3EN+HQpibYfdjhLa92ov4?=
 =?us-ascii?Q?qARHHc/UhFSCjTNJ948tA9wzAuUrV7YTBY0qwKwt0DHRPBwMfmXVBcuFBrma?=
 =?us-ascii?Q?pumVQmUVJSVwT9WXfZI92afdxk1r48MCoDlS583QtOiKEzeX3igUChqbTwmW?=
 =?us-ascii?Q?npRBHsUvy7sFVRbqF4L5i06cDJq0zPX3+jfEskXi+lthIP8CMPkqWAtns2gY?=
 =?us-ascii?Q?TtAY4akdDup+69FgJ5orgc7dKoMo0BTgMMJgGFXWJc7h+lhA3SMs8o/QD26N?=
 =?us-ascii?Q?gDDgbCcOtNoIqCA+2OymUjcEeqnUd/e67W7cd6FNEkLnVCDa2B2mdIo6OPkc?=
 =?us-ascii?Q?qqiDmepUGyKQw/ZFWrPnf8zkpfSx1hBgSvS0NPmOz3pwayjjzgAwg7AIelQz?=
 =?us-ascii?Q?IMbhAIE1YqYnXd3oHA5S2lP/TxtknXuOMkxSTsQZblwBoeCKgIkInsRj6v+f?=
 =?us-ascii?Q?o52znhZiDW0aqDqmtdXG5i2Y81MACq6hM9bUq+ZABUCC6KHbAzhE9zPyvI1b?=
 =?us-ascii?Q?lxj9Ul+RB+j72yoH0UuZemDeMS6bb8sXKvBpby/vEt1b0HmpY7FXhLEwlzY2?=
 =?us-ascii?Q?yuGvTPmMENvVMbBN6Llh9v8ujJb4QiKEHGLLwfzSB9GfcymlZ9pFEooftQz+?=
 =?us-ascii?Q?zblv/ZWb+fIBdfYpy3pouX+4BJb8Mivpo8kA3dbYuC/E9ThZDNz1jwxcm62H?=
 =?us-ascii?Q?DTD9wCYeLW2zs+OUMgoqgyoi0DEt4csb1AVeQnRXwMn26zZDiNLhBTub9rUV?=
 =?us-ascii?Q?iM9DGESB5dS6xnwZAkXtJaakMjGkLszOWBGZucro3UUl/BKmvfYCu3vIocKq?=
 =?us-ascii?Q?2SwxiTsshHpNny6BpJEg70a1uJ4869Jgrju02utKEKEp6zCNPiI2W9VQKp7H?=
 =?us-ascii?Q?ABf/grQfft3P0H123RL37r6qiuxlhsNn2yDfrXBiVT0BmQH3gpOFz0Lpyk9N?=
 =?us-ascii?Q?0XsJxpZid0qJ+Qwp0hVo4n8EeJNWG/W7oOioQPEih0zukwrTAQCaQWPCOIrv?=
 =?us-ascii?Q?VJ33QhEaXejAaZCvjcQNTg57yjq+ivXkLoeyOC38kd8jvA/iQ9DhBSCJCzlG?=
 =?us-ascii?Q?kw0L7kaZqQNNELrdIQQPqtPNR2aCWmFY6wAzJfQplUtESsp6DiLKbba4NSTp?=
 =?us-ascii?Q?nyzxiihRSSH+1wS2TB5DJ/t2BXNkW7+KKXVbmKKfKuoTuxhb2VcuFuX0nLRg?=
 =?us-ascii?Q?6uXZLSalsHSdFMoDLY3+C2aZSRAJ1fwxYfHJm2BDfDMGyUKNlHj2jfvkaMxL?=
 =?us-ascii?Q?ofLf02ACbG+f0n71qNptWnlyOy0phQglqSPf1vrzkNWfA6D8LFe0nXiN7N9r?=
 =?us-ascii?Q?1DgUziq8xiwnmlSLEQXGfF4ZYBKaqKy4SbaaXxyEsJvjJGYLwzl84lA5civs?=
 =?us-ascii?Q?fALG08MJNdq9IbDGdDhZbpl4A1/sOZgbERFyio2mTKi11cgg3+Bk+/tGVTi3?=
 =?us-ascii?Q?/SQ/7OzDCJT17xWHl4pFM+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435786a0-30a5-4c11-1371-08d9f9005ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2022 08:16:56.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /en/Gz9Q/Ctn/1fO5O6efgAr8z52olsvRcxLR18438utsWRUTIU6gOyPUPalGMr6KKKUteSGWuTb2qbnBHnWJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5137
X-Proofpoint-ORIG-GUID: FJvmj8dRLQ_w3mfYM-f5KqVqlAvKlBtK
X-Proofpoint-GUID: FJvmj8dRLQ_w3mfYM-f5KqVqlAvKlBtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_11,2022-02-25_01,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wan Jiabing <wanjiabing@vivo.com>
> Sent: Friday, February 25, 2022 12:09 PM
> To: Matt Mackall <mpm@selenic.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>; Wan Jiabing <wanjiabing@vivo.com>; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: jiabing.wan@qq.com
> Subject: [EXT] [PATCH] hwrng: cavium: fix NULL but dereferenced coccichec=
k
> error
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Fix following coccicheck warning:
> ./drivers/char/hw_random/cavium-rng-vf.c:182:17-20: ERROR:
> pdev is NULL but dereferenced.
>=20
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/char/hw_random/cavium-rng-vf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/hw_random/cavium-rng-vf.c
> b/drivers/char/hw_random/cavium-rng-vf.c
> index 6f66919652bf..7c55f4cf4a8b 100644
> --- a/drivers/char/hw_random/cavium-rng-vf.c
> +++ b/drivers/char/hw_random/cavium-rng-vf.c
> @@ -179,7 +179,7 @@ static int cavium_map_pf_regs(struct cavium_rng
> *rng)
>  	pdev =3D pci_get_device(PCI_VENDOR_ID_CAVIUM,
>  			      PCI_DEVID_CAVIUM_RNG_PF, NULL);
>  	if (!pdev) {
> -		dev_err(&pdev->dev, "Cannot find RNG PF device\n");
> +		pr_err("Cannot find RNG PF device\n");
>  		return -EIO;
>  	}
>=20
> --

Thanks for the fix.
Reviewed-by: Sunil Goutham <sgoutham@marvell.com>


