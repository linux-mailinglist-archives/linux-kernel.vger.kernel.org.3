Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6245A0CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiHYJrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiHYJq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:46:59 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1CAB050;
        Thu, 25 Aug 2022 02:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCRSQCU26NWRWKqfrQJajce7naZjkjqnpvBeNHNhI+YxZyjSgytIdg51hHw7fMuHcjSH1InToMPqORabLzPB+VEEt3uALrgJdZ2T/kuOl8LSlyoFBz3VgT9NAaO+dEhluyPz4Zf/gRD8W8ueLGD8C7/yfu/sPDypa8m/zOZt4JSyY//uOGk6RF0NALgrWuSRMC17Un7GbFShfM32UBIqSeX3LewSxBekAmPOjusLjUAB+yVHOOD1UJzOAEPLhBv+UVhGF2IGhWIOhw5eaNIYSNxdEuLZ0LkaotwjQGZzSCNr8tx6CXMe+dZPe8hZHjgeQcpje0oOm47zltpW3hJNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WctUvkqzRTP6mKH70s0/62XB/XoSgjTKkUdeHnhuBNk=;
 b=OFuCBxsbC1JSw/byUp4ITEt1F1hjmig2sl7780pimIuqjeoo4lGBDIOuFQXln2WA9gCb1FpVw1eqorOYxsH7CGWRXYpKEZOvFL0PB8sJ1K8w4eUgqfhVY7hAOVphd3biEvxYTlWaD1RRMV2lBsGo4cjYx9kOWfjOuLHqIJ81i9Sti9aIiT/vzZ2IgOyoEIuRvqz/OnldiuMAWG0RIfQggJgUFVwjEf95UXbBVf3itGK/Ymv215gab10BVla+5j8G3Sz0HAuyfKF5DvH27PJeZ65lhssimGoM7hoeUy8OL3v+S+OAWFTjaAUY++xoXJSxVIPZybsPcLyZNv7qvhH1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WctUvkqzRTP6mKH70s0/62XB/XoSgjTKkUdeHnhuBNk=;
 b=Tm9zzHWw2LOi7ODHKWE1lVQW+/iOfjoFWH8eAKOSz54oWp8n0Sgpjy+qsj/iidWiJcjPI2ALfQeDEgK7S7untFNG629qDvqhGoC4BP1EqPvRvCpahfDzCtle+8/8DHobBujGIEDmWguGwSxReksXjgqcYuep0U7XF+WrzoQ61mI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB3710.jpnprd01.prod.outlook.com
 (2603:1096:404:c5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 09:46:55 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::307d:7cc:2021:f45f]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::307d:7cc:2021:f45f%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 09:46:55 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: renesas: r8a779g0: Fix HSCIF0 interrupt
 number
Thread-Topic: [PATCH] arm64: dts: renesas: r8a779g0: Fix HSCIF0 interrupt
 number
Thread-Index: AQHYuGSNbh+QiJ5rCkG0J7Cav6tFrK2/XiYA
Date:   Thu, 25 Aug 2022 09:46:55 +0000
Message-ID: <TYBPR01MB53413F9DABE36AE86143A252D8729@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <751dcef40d4534e856ed49b1d5b3a3e8d365ec42.1661419377.git.geert+renesas@glider.be>
In-Reply-To: <751dcef40d4534e856ed49b1d5b3a3e8d365ec42.1661419377.git.geert+renesas@glider.be>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d599fba5-88f3-4e07-1880-08da867ebf3d
x-ms-traffictypediagnostic: TYAPR01MB3710:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zluoEB7eJcOKzbwLUqCGFhW4Yan8oGmpYvJGcP/B9oFfWRZ+m4ReaOT7fkAgUmd7FDhL6ceQrswsuPwEsIOr2BZ/RIruWwYwan2O1L3wHSv7R4hQbJxVUXMMfMR4d0LoAphxV5j2Yo/yHImRHuT5g1xQwoARKBXF5WLHhWB+m3q6NE+PketGXPtLdyqQ1SaW3yBHnGDgxvMsVOFHWZ/zLcTT3yTMWC/bG6v6kvPoZjYkW7ZNXy84v9Sk8A3m0R2cq+0Y1+9weExtm7rH4DpDA9UQHSY337F0GGHFB3VrhIUbfbclQWFKuORkf2Dy9nium5+3wYNk44DMD70NFhYj9GLt4HHW4nX5HE58rQLPLAfqGOrWSfkKWThD+GwppeNnCsBwcbGjYrhLIYaySRk+RK+jx6xFKdsYy35oxtcVe8Evi0uXOy0kI8P6de6MhuSL8KVMbo1spFPW85qwvZURoKJeJqFeAk9la0E23RVFhsJX/GHLBu+rTDPTYWHBiaKfTPrCgqSs/2fEAIJ8AUoUNAuFstTtcc2f+1hunPsallhrDqNSHLXKfU1YYYuYvbKt+Jb5NE6aCsjVZmidt9ylGMxFLk6A+uVjw8O2hywBAy//uhGy2TXXex3GvUxHRRjh0nCgdP9NcxHfT0cYFMHbdKCsUE2Y299EAPUw4+Rjm/0mk/iVIjZb2ZfXVZFsHsEusj/Wc8l4DytAKGGGlIFtafd5zMkMMc56uttJYX+WF3bfoqYv79R4TJVZUrKVgD6CoN+5uUbVOBMDlp9fk7uYOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(6506007)(7696005)(38070700005)(33656002)(9686003)(86362001)(41300700001)(186003)(83380400001)(478600001)(71200400001)(55016003)(4326008)(54906003)(66946007)(76116006)(66476007)(8676002)(66556008)(66446008)(64756008)(316002)(110136005)(52536014)(38100700002)(5660300002)(4744005)(122000001)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pMW+56A4gBxukYtAMqH2BsqsNDWNEOkixZWHF1w+L4ffXQ66lkvnEUgOqgXF?=
 =?us-ascii?Q?4gvV8SAFRLUnuYm7KxdodZGZzASI88obDNehsc9V/i9B4naUU+3RqwW9bquo?=
 =?us-ascii?Q?S1VLGIvzEULKn0VBB69Qp46Fl50jocrLSIKGut3RxsebqcejfEPrD+jfZaaH?=
 =?us-ascii?Q?d8xrtysbsZtLCzgh6ZNAjSYqXDdAxW4sQ83DcqvkuqpwvutG7OQLOv2tv1x5?=
 =?us-ascii?Q?ehdOeyqm5Xj62Dct6ASb35ilm4reD7/WsZlmykYanOYNaTG96Wz8wxI/uZbI?=
 =?us-ascii?Q?5Oxa+vGNYcfz1aH/kN3Xuqg4vFPiX0suIC15bHCclS3reDaLtjdvt8PrMLC3?=
 =?us-ascii?Q?l2cEXgqwrukCSnE0YWJwf+XISbvuVonOrrFzAcMFzn/CrtYnItgusEoVvdQy?=
 =?us-ascii?Q?LdrGpI1lDPqgqVg55eufHvHXWn1hXYOCzRbKUSLgUniGJIQQZWK91VuO+j9a?=
 =?us-ascii?Q?zppjWng0SqTj/mpuR+tar5b9B2OCbPyc/p+YrOSGqxXVonHfhFdXRBTz3zrh?=
 =?us-ascii?Q?N9+/qUKgjwrZNjNfwvBIb5uFsshdjTyTGMJYo/vq5TdfKqC4HZGqfeGkUEuP?=
 =?us-ascii?Q?GI6UY9Nn5BG4p+0dybFFlxDhI4RtDF/1Z53rU1fgnzZVLj5SmRwGevyD0Xu7?=
 =?us-ascii?Q?xaq0f53EdWqoScGxn6MzONjuXcOoRRx2tTKiq8dthvukDTm3T2L/Kww3/pHP?=
 =?us-ascii?Q?+JE1xVWBo7QfZsUB06keIKNMTWw3CLBG96O9/jfErp/oATHpnqU09Y/BV82y?=
 =?us-ascii?Q?xXbWrARI6rLPkDh6vU6wLOJZw5AefyjLgSGAoM6hETcSJNUCICZFfQp/2mL2?=
 =?us-ascii?Q?gT/FLtovCVlkXIWlST94uwVbdJ54dLAd3bVITuXNvB1gjK845TCz5ukg/nsm?=
 =?us-ascii?Q?ZWEunVy6JaQZxo7xviPhCJeoTQ9M/30Fk/ietfFcmsDhX6GrTfi2jADVhpVn?=
 =?us-ascii?Q?ErN26Zus/rus8eo6T+0RlATNjpKGd1YbkfZLaU2v5galLz0eV1fzc8EaviOw?=
 =?us-ascii?Q?fq1s5esKs56iHLDINm4d0iSvZ00rodU2K64mPTKae31zwSmf1oI6dCPDhCry?=
 =?us-ascii?Q?nGCx3/Oj4nzDrMkhNuyDUHr3Uk3cHa7J2kkTaskgPSl7kaVGWHQBqKHClAfw?=
 =?us-ascii?Q?iG/wplGPzmekrrpHKTtqtQoUBz2jNTOZK33Drs5MeB8mpUvlxQ5wj851xxXr?=
 =?us-ascii?Q?6C9VPT5CmkuZeQSxmqDdwdKI1AZfjZW5aE3fRucErZyrzPoV6WQZkgcUCYKy?=
 =?us-ascii?Q?bkvVOnPf/0v2Wjcut1pNMHQ4TOCbIW2ul6ygNUHDPgqrIPCpvyg1h0VpAidk?=
 =?us-ascii?Q?AmLDWV8fGAQ+rDOz9ibFndUQghVyqjT1QEdmJKXyoRulp++6pzzGiIT4R3uw?=
 =?us-ascii?Q?gFNxvhRjqjqGtb6/U6N1xauV6wBvARRbeG3GE4V0GRBIPQaCgC6Lm2fdzJA8?=
 =?us-ascii?Q?Tp/+Z5fGCozYUV9c98M7x+NhasD0pXSFN7jmsU8cMrcCSPwsm8oalpF2srnm?=
 =?us-ascii?Q?LKlKazx2NQLCB5DOOQvmNDpy9Nt8cjt1fOBwgTlExLF9d4g9ajYCvi3HYVLV?=
 =?us-ascii?Q?mrQY1Z18J91QHOtAapCdfimXjxLbQ9N9G+/de6e+3/OxlsaTewKdzVHb6T7V?=
 =?us-ascii?Q?ZEfQTr6OmL6l8NA9zAMeeygeUW2xk4kFDtPqM5QPFdGWwE7AHn7Ni36z/z9b?=
 =?us-ascii?Q?0qA5eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d599fba5-88f3-4e07-1880-08da867ebf3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 09:46:55.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBJRzuN1tu9WaIbKmQ7pYzrHsYQI2xaMp6qGQIcvp8Md1Tbgih9ctrkXx8Nj/xZHtS39xK09g98oqtqJQp11R5iFagMgP9vKXAKcOll7JyhGoYr/OEFlAVfGGVUxw8fP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Thursday, August 25, 2022 6:25 PM
>=20
> The interrupt number for the HSCIF0 serial port, which serves as the
> serial console on the White Hawk board, is incorrect, causing userspace
> to hang immediately as soon as it tries to print something.
> Kernel output is unaffected, as it is printed using polling.
>=20
> Fixes: 987da486d84a5643 ("arm64: dts: renesas: Add Renesas R8A779G0 SoC s=
upport")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

