Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5702B532175
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiEXDIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiEXDIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:08:40 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2112.outbound.protection.outlook.com [40.107.95.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2902279800
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/UlJf+R3AP6qWBXKELd3l65hO6GuBuTicLNRTuUeLENXKFXhlb2fqrLg72Ihgf76wVohA+2Y9s6RI6p/HzEx4Te9N3IAsEAlhtFiUGDGB9TxE4K3VDuwmGnXhsRXsmMIVjKXOPXj3Ye39yVazYSFFRUhXRsmyGF7rC0zowkmo4vWJfWP8YXRuROLyStx21d4D/l5Uhfkxk0echJjiyjNcoQiWpJRI9uiHjslfq4xFab1QVSDyKFJb5dChtLwR1RdBxN3e5WNZidh/WA7bTIESykbLgLbXnA6q+wgRFEvL0vesIpZWqaApb8I52L74fmYHgaHbdhO1CzaeSwTSMD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSBBU8wtFL5CoRnOO+r66WKfxM3/Gso/TM0pC0uVE/w=;
 b=gqwxxKZzIBKV9wI/isFT13qUBAOCuQNAPaBGe/ZeTJlT54POo68UUomQL1eNDZz09wPykLXfRVu6WzM5dkaioIg8TRRDgIp1vvVWNll18rzZEa5k7YwMaFbmb1tPG/aemG1ZokXwy+tVUL+kevQwab75pgoOhrcCH5cwvBPDOegYB63JnaiMpyxtK7PhYfwg6CSNUCxxMJkPiBBcEHLTEOLSPLZf9b9VcSA4K2aGrqSrKZVK9PatCqiDDrnKM9Y/ujhiDuTRRdJzZzE2sqxuu0S3efJtzG+jy3s9sbai3WRGMpsZGDzWrNT5bDaLfyyjLv5Evii7hTxFLckAZiHd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSBBU8wtFL5CoRnOO+r66WKfxM3/Gso/TM0pC0uVE/w=;
 b=VHlmX95KE8V5I7uxcYZ75OZBQKAXmReVhMVZgnOzBFOuAOKdYDhF8NEbIwnpBpEowX3M3PFjHAGY9kgojshGZFcHwR8pXxWXmE+4Tl5j9oUSY5VzQ5fIhAk/fJW02dgvVBNYEWT4C/tyLcbbGjsxF9owjaKyS+IHn080kxe7hi8=
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 (2603:10b6:301:33::18) by BYAPR22MB2375.namprd22.prod.outlook.com
 (2603:10b6:a02:c1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 03:08:35 +0000
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa]) by MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa%3]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 03:08:35 +0000
From:   "Liu, Congyu" <liu3101@purdue.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcov: update pos before writing pc in trace function
Thread-Topic: [PATCH v2] kcov: update pos before writing pc in trace function
Thread-Index: AQHYbmb5ybW7rPmroUCLD053biTbk60sJDKAgAEv7pc=
Date:   Tue, 24 May 2022 03:08:35 +0000
Message-ID: <MWHPR2201MB1072A5D51631B60BF02E2F3DD0D79@MWHPR2201MB1072.namprd22.prod.outlook.com>
References: <20220523053531.1572793-1-liu3101@purdue.edu>
 <CACT4Y+Y9bx0Yrn=kntwcRwdrZh+O7xMKvPWgg=aMjyXb9P4dLw@mail.gmail.com>
In-Reply-To: <CACT4Y+Y9bx0Yrn=kntwcRwdrZh+O7xMKvPWgg=aMjyXb9P4dLw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: eb43b202-168b-5b93-d60f-f1d8b95159f7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b13280c-acba-473c-b3e6-08da3d32b11c
x-ms-traffictypediagnostic: BYAPR22MB2375:EE_
x-microsoft-antispam-prvs: <BYAPR22MB23750C2D5DFCCE15A73E9258D0D79@BYAPR22MB2375.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkTW56Qdkhup26N6j1nDwkPwfuFoYqKhMx3BJMHK3zYS1jkoE9V2nE/dt8rKDah8eU+cQjzfT1yEHwnI3L6kvpyg+l4oL89ty7E1GZPDvimavXx+pUDcWgSpuzpUketrDvsP+RiWJh8p34NObsMVoJp/zWEz6C454NqYgLM6bqacNsGO7AO0KJWCwDgwWZCOFzBumS24v/gIHAc1e5wcoN3od4grRgQ7IWO/hY8qDeAw3LcHXyX74CuFZ75mrWOffteW7Psq/6KRcSoEEKr+CJCrDujnKOSminoSpyc0aMrM2+8AFZ1d5SC/6CfdmmGWTbtFftwlVQ3NsaJmAxIny3keCI5xhHA4DaYlfgGHt5e8WtdoUC5Fj9iK+g2dAGqnyrO6JbbbIrw/5BCSHrDaJyzlbgbYWEutnAr15PG9yibaYjh06ijLzKne7MLy89CZWDQzOgQwELoKNOM1Om8j4UKXukmLR+ijt6dUu4p+HNmVZWlfb+Kh4UGILPHctX+xLnQYwxzASaQErFOW/GNKB62Y1YVU1Zhh8PSfpzPJsCiDaIXOyFo4hz7fMf2qkYtYO+rebalXi4nbpMD4g0Mwr7vAeioQx3uLXr1my+8HEZcjHKmttnzW85K5CV72q2SQBaSwZgZQljHKUOX+MF3XgJZpxkiRPtKKgSBXPZlYqYfvZKuBE+G4IKC2FHv283Y8YNdWQRI0a9TPIeHwGHxClDDPg01Wlk1jL4OAlK37nXqGYuVx05gn8/dXGfjUV8C5WQ9KPULNXhg85EPENdjIo5ykWZg6LA2KJTtQ4tB6I5U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR2201MB1072.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(52536014)(8936002)(55016003)(83380400001)(186003)(5660300002)(6506007)(7696005)(53546011)(66476007)(64756008)(86362001)(26005)(15650500001)(9686003)(33656002)(66556008)(2906002)(508600001)(6916009)(8676002)(54906003)(38100700002)(316002)(786003)(122000001)(66946007)(66446008)(76116006)(38070700005)(4326008)(75432002)(91956017)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9mu3UxyPg8Bl89tkt5xOofAJK9o/ZgGrsVkZ9XD06EBfDJ40f1JRBpvdFqUd?=
 =?us-ascii?Q?6SP1u0yBLjy8e5qluVtqc6V0+oHqDxJunvtOr7T5fCn9Jzdu0o5b006qb/O+?=
 =?us-ascii?Q?y3wqMLgQCTqTMyrwx5C7DiNgaKJpXdpZxjYiM/gZU73eumDxvq0bWaeQ6pIG?=
 =?us-ascii?Q?aF4YjtkhByQFnp/BNE7uUfmLqD0wfp9i6x1orAiB9DzeC2P1b2We3fk4DPKB?=
 =?us-ascii?Q?leizepZ5i3Unt5RpWUrqp20IJN5tPNE+lSKdZtDZ+oB6AjFGMs9OutXv1+WF?=
 =?us-ascii?Q?bQqIV0KSIyA1ZmoHvGCp3UaPb14FT744Bf87qoFv+fY7VU2DliAT3RDtcTab?=
 =?us-ascii?Q?2okxL8UPOKOVrTgiqdKOhorveiJjYM/fU2rPl4K3l6JM2XVvNPtShgFXq8+z?=
 =?us-ascii?Q?AVYUaJlcOvheKRFF7TC1fmdOfCDYnRoaVKDFSw1JtTt2d6DUeTvmNoR1MxN8?=
 =?us-ascii?Q?QWme2bfbfJWRnEqxb+myoG2YOacEm7wG1F7FfFIpklKcm1O6i7ooUrowsoI0?=
 =?us-ascii?Q?+rv6axkXpwvPgAZ09BhjuKejY5ore360K3Q0i2puiutHBIQZXPmxofdE+lwo?=
 =?us-ascii?Q?szYyU5o+Qkjl2yJXKHo0c+c6gdNVXwFobPWwjNpm67TvtBlpprAc2IqFthm6?=
 =?us-ascii?Q?/H2VdVEjG853DvoWsITcjWi0cVKqfxmO/y8uVWjuVpswAkMM50zeFD/Pz9+c?=
 =?us-ascii?Q?6XYeS4bBMBY6zrV5fRDYPZvfIy2X8oj9ydhH/wnVADbQwQmU/KGDY9+kxl6u?=
 =?us-ascii?Q?Iv/cPBl5U85gEj7Q2V6j6I5X0rZpWRArMZkXAe+yZ7j2gBeirJT4XsFp8N10?=
 =?us-ascii?Q?9fvILoTSiHRoH5Z0wAgkwR9cOHcuicZjPPMlsqeBLGZnDomwlDBTZAB/WyIk?=
 =?us-ascii?Q?2+bmwbii0XbOywP7Q7BTrgREialnTk0BWFciBazL7EZsFH/+73JUiYcx1U8T?=
 =?us-ascii?Q?QlLDyisDI/xDWS6C8rSP4kFGgIO11ec2ui8dawTnlCkM6tkEk4SjeRpU2KdC?=
 =?us-ascii?Q?C4WEs8sFlgYDKdY1CTRj344Og1qpwBfHIHnQeJAMWFPEDxdYt6TWwvOXPb/O?=
 =?us-ascii?Q?X1aml+KfasEQFaTKqubDGG/wIoztimgQsGQXvq4cJfz2CnyQUI7fUFaJfSEF?=
 =?us-ascii?Q?RqcgKVKahxFhAx6GH2TST+zfvA+wVR0V36dJ9bIglXo+w3DdK8tlFQowxlN8?=
 =?us-ascii?Q?/1RlEPAXir/Hnzb+uCqgASSMJMQovSZSXJD4Ug0iQTnIFd05yosJ/Qw5kybc?=
 =?us-ascii?Q?T9t+GFw9XFhRl5+qeNx1kBa3R2/Rn4XlkU7GdjX8rZs+NJifO4nR68tmNUu9?=
 =?us-ascii?Q?eM/f0K0qdAr0giyC9URye0BnzWh5R+n6qlf7QHeYmXtCDV/YWyme6oGCnaWt?=
 =?us-ascii?Q?bwDUSCWlQ1UncHC1xtekjXkb7+0tCcRPAmbsRo5mMYxJ7mnakU1orKQH2jAv?=
 =?us-ascii?Q?oQrm4joVTK8jywYJF86DlzS9KLmcOIZZ1hwI3yYcYtMANdZSyGpPv7PfvXaO?=
 =?us-ascii?Q?MjcjDUdIgypPMocICETOZiqrk7izLk6kA7rn06ocW/c4Scf1wWQhMr5+iV5n?=
 =?us-ascii?Q?qmfCPO2jFCeWPKFEjYe7nWl/2stpGxM4d9kNbd/dPkNQhulM5Da1jDh+SkHb?=
 =?us-ascii?Q?81BHfuGFICBPcttQtitTSZWnIaP7kpmNeYCWnuYFtvaNA9fDGb76U7gNZaQa?=
 =?us-ascii?Q?irJtSK1glzXxY6TL5Gd1Fs09iKs6Qfaewh06d9IaYKzMwMzw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR2201MB1072.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b13280c-acba-473c-b3e6-08da3d32b11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 03:08:35.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8Kc7mH7mWRpr81gwZAj6GmC2+6Wss4poTFPLnHulBD2UmAefJk0v4GIj+1EcoDcYgcT1MRiJC8wbyObkxW7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR22MB2375
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was actually first found in the kernel trace module I wrote for my resea=
rch
project. For each call instruction I instrumented one trace function before=
 it
and one trace function after it, then expected traces generated from
them would match since I only instrumented calls that return. But it turns
out that it didn't match from time to time in a non-deterministic manner.
Eventually I figured out it was actually caused by the overwritten issue
from interrupt. I then referred to kcov for a solution but it also suffered=
 from
the same issue...so here's this patch :).

________________________________________
From: Dmitry Vyukov <dvyukov@google.com>
Sent: Monday, May 23, 2022 4:38
To: Liu, Congyu
Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.ker=
nel.org
Subject: Re: [PATCH v2] kcov: update pos before writing pc in trace functio=
n

On Mon, 23 May 2022 at 07:35, Congyu Liu <liu3101@purdue.edu> wrote:
>
> In __sanitizer_cov_trace_pc(), previously we write pc before updating pos=
.
> However, some early interrupt code could bypass check_kcov_mode()
> check and invoke __sanitizer_cov_trace_pc(). If such interrupt is raised
> between writing pc and updating pos, the pc could be overitten by the
> recursive __sanitizer_cov_trace_pc().
>
> As suggested by Dmitry, we cold update pos before writing pc to avoid
> such interleaving.
>
> Apply the same change to write_comp_data().
>
> Signed-off-by: Congyu Liu <liu3101@purdue.edu>

This version looks good to me.
I wonder how you encountered this? Do you mind sharing a bit about
what you are doing with kcov?

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks

> ---
> PATCH v2:
> * Update pos before writing pc as suggested by Dmitry.
>
> PATCH v1:
> https://lore.kernel.org/lkml/20220517210532.1506591-1-liu3101@purdue.edu/
> ---
>  kernel/kcov.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index b3732b210593..e19c84b02452 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -204,8 +204,16 @@ void notrace __sanitizer_cov_trace_pc(void)
>         /* The first 64-bit word is the number of subsequent PCs. */
>         pos =3D READ_ONCE(area[0]) + 1;
>         if (likely(pos < t->kcov_size)) {
> -               area[pos] =3D ip;
> +               /* Previously we write pc before updating pos. However, s=
ome
> +                * early interrupt code could bypass check_kcov_mode() ch=
eck
> +                * and invoke __sanitizer_cov_trace_pc(). If such interru=
pt is
> +                * raised between writing pc and updating pos, the pc cou=
ld be
> +                * overitten by the recursive __sanitizer_cov_trace_pc().
> +                * Update pos before writing pc to avoid such interleavin=
g.
> +                */
>                 WRITE_ONCE(area[0], pos);
> +               barrier();
> +               area[pos] =3D ip;
>         }
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> @@ -236,11 +244,13 @@ static void notrace write_comp_data(u64 type, u64 a=
rg1, u64 arg2, u64 ip)
>         start_index =3D 1 + count * KCOV_WORDS_PER_CMP;
>         end_pos =3D (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
>         if (likely(end_pos <=3D max_pos)) {
> +               /* See comment in __sanitizer_cov_trace_pc(). */
> +               WRITE_ONCE(area[0], count + 1);
> +               barrier();
>                 area[start_index] =3D type;
>                 area[start_index + 1] =3D arg1;
>                 area[start_index + 2] =3D arg2;
>                 area[start_index + 3] =3D ip;
> -               WRITE_ONCE(area[0], count + 1);
>         }
>  }
>
> --
> 2.34.1
>
