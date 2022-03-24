Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED564E69B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353262AbiCXUQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353252AbiCXUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:16:22 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020015.outbound.protection.outlook.com [52.101.56.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A7B2448;
        Thu, 24 Mar 2022 13:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Padc8tntDgANumuWrWoSCGkTph770iIVyVnftd4u06xqZeDOP3D4KV+Yl5zEpcoRFKdhvsko7WN/ROt+kg7x7juWCvXldO7YNstnmrWC0jr25501zCIoTvuKK2iXGa1zqTy2hskCdKZkTHHbV9qZ2eX03PiNwb18Eup+X17L+qhH0zQZTyuQdT144w1zay4VcH1sr2oDAOZ3djGscgVnZhVPsAxn0EYTVsz8NnWJ2Yc+aD5bvPLH+fZw3w3k6zPGCQ8Z9KODoD4knDx1cxdNnEwbNY7LJK8YGvT7XPJLOzginCnlA7I3PSGB+I+VnxvG00+gS68dMWDs+WO1r2p+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egB9+PUoCc78LftnzLiD34Y77fgijMu5bezd3AHfzVA=;
 b=nKh0AoA0klLKEWPpDvw7BB3vouHzEnsEyVEgYR65e0OcS/w0mdhVIxV7eiGK7h8DPOmkiGhc0b4Gaa0TDpv2MP0A303Gg/MJIDwW0AHqJ2Py74lKinbPj/oKxT4ENKuHxL7WLdUJ6Leq172OL35Ql4ytc48a008ZN9WTk1EIAoxDNdN8xgdEUlua/0ACVbn2fkfftsVJr+NlJ9sPMrup2URMmQMSGPcFCdh1bCp78Cp0MGBQVysBziL18MDvIQGcEBmAXglhU36dmIBRsBFE6244vkyPd1lEAIoaWZy8aBF3AktQbtw1MbX3jD7y3wmdhho3XYQhuvhiw8Hx6z5r2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egB9+PUoCc78LftnzLiD34Y77fgijMu5bezd3AHfzVA=;
 b=hufw3Y69R2mCVB4Srwn1NFyznRNXYwBpsEPS8LVifivRNicMloNXtX7BZGlwl286DQqq7gAsup5qKzEG3aYX2edKEO0z0W4d4I61s/LlQ01viu4sZrRtEtKk9S10HeS0qnDiXgCWYv66iFc1QsI5zS531nmpW03EpOM7a2g5nag=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SA0PR21MB1882.namprd21.prod.outlook.com (2603:10b6:806:d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.5; Thu, 24 Mar
 2022 20:14:47 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe%5]) with mapi id 15.20.5123.010; Thu, 24 Mar 2022
 20:14:47 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     jason <jason@zx2c4.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/3 v6] ACPI: allow longer device IDs
Thread-Topic: [PATCH 2/3 v6] ACPI: allow longer device IDs
Thread-Index: AQHYLNK4fL59pmJF2Ea4CQMRQ5s3a6ypbsWAgAAEo4CAAAbTAIAAB7CAgAACs/CAAATqAIAAA+TAgAADDwCAImLl4IAAJSUAgAL2u4CAAAaDgIAABp/Q
Date:   Thu, 24 Mar 2022 20:14:47 +0000
Message-ID: <PH0PR21MB302535C67863043B608710BDD7199@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
 <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
 <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com>
 <MN0PR21MB3098EC13B4E8488E692DB28AD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFe-B=n1zp6M0yBuqJmmfOXTFbkzj29iK+QpPGK=LxRmA@mail.gmail.com>
 <PH0PR21MB30253A8BA8B189686B8E65EAD7179@PH0PR21MB3025.namprd21.prod.outlook.com>
 <CAMj1kXEExWbD9imqNUr1RYRzJmbQX5i3CdG7MPseQh8Q=N1y9g@mail.gmail.com>
 <PH0PR21MB30251D429344378FE8D47E35D7199@PH0PR21MB3025.namprd21.prod.outlook.com>
 <CAHmME9pZW_nu3nACPHO063t8gViMRfV7JFXUjbzDt+f362NEgA@mail.gmail.com>
In-Reply-To: <CAHmME9pZW_nu3nACPHO063t8gViMRfV7JFXUjbzDt+f362NEgA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4f69e02b-f4ee-454f-a716-01224d62f761;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-24T20:09:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a5c86d2-5ddb-4bf9-b156-08da0dd2f189
x-ms-traffictypediagnostic: SA0PR21MB1882:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SA0PR21MB188200C0260CC866BC10BD10D7199@SA0PR21MB1882.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ylL9VLyyfdbC9mLm99s4y0QFonaRWmIZLUrVeg4VpAK8WQR2QR89pmp3q5TLlY+RZdKOnPAyMXq5L8amH3VBfeLVAZ3z+Zws9XZwa2OwHvSyZ7MW35CKawqNwrL3/KcD9/QQs+2YlClwsRsiKlU03P9nphRF6AkVPws+ywCiGJVQ/heTCmGwKA535W4IYQm5IJO9MRtPnjZleJqTlxR+zvcyXErVecUXHZTdKGcu7n4e5/8A9BrHCklAtCnFDLPD9P/R7CSJN4C3iXG4mwKMqNDHd2lJ+88xtsrTRgIFb8At3TlRRVCEgaBkydbJlffvI21cu3bVLsSoiA5lc6gZ6K7iSKmVLiuztq2uX+C/PSgT7VlY6BhJbuZBhHf2QMPJS1bm0h0htp41PbvqbmAjW25QQF1fSPRu+YU/Xt+LfcbPwUmN2v1MZoX9i/z1fg7ja1VuKMMCJcZ+tmbABLXCDK74jHYjDtN7xT42pYZCasiF8dGgT98XKtHTgnm3ZGRI0wnwBj6aO/VhpWJnjNLYkzprIGVTub5YdiySJCcnadI5F/Rra+h7ClqTB1jUinLei2n59Bsw/PB3187Hf4rj6lk1wkSNP6AFa6DG9MsQkT6KN/tpjrlViayDRPnTqugELa/XzdvPT5Manz3rcT19IWrnLYY5GgGe4KkfnRgKN4Rk0ZDNB16kT+HSGKaxzn2fyjF8JDJ8VhjbYXIR6ZYVZ52Ph2aumL9dFo67rvv7abxSeXa4bmd3J/L1WeTbri/tRFLM58BuGtniLSsLArR3WlJ3YLndFJ81AJ1uvLfs0QSh/tdf3Bg+iv47RPvFJu7ZOoH8d1sqv5vKkz1lGu/Y7p+92JFEHjpYAgiqc5Vvp6Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(66476007)(66946007)(8676002)(66446008)(508600001)(55016003)(4326008)(8990500004)(76116006)(66556008)(64756008)(7416002)(5660300002)(9686003)(52536014)(38100700002)(2906002)(33656002)(10290500003)(6916009)(54906003)(966005)(316002)(71200400001)(8936002)(186003)(7696005)(83380400001)(26005)(6506007)(86362001)(38070700005)(82950400001)(122000001)(82960400001)(148743002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4sHjSwuGRxh6isD/m089H+dO9Pz/L9OERK6M++AOvLGmwiyVZzsR1vZy7UIz?=
 =?us-ascii?Q?CcDUjblYtFSO9wq4OD6O5YdGbg+tvc47/TaxZ41qq9xkWIfBmEOXbZh9arr8?=
 =?us-ascii?Q?/oQ+TYWugu5eZz1EUVG+CDAmcHU6GzT5GIn6Ffosyljf0HD1MTPh8aqO4r9A?=
 =?us-ascii?Q?T2spJNJQp2wHmzZDEoofETtDOXPtkoZRIWDuZN44Zz79/BGLKCshKDKUuK53?=
 =?us-ascii?Q?+nFteJiY7/Lg9owpUl0xe/oZvO4weLusmcYQ3PFbc8hEFOD80b22yxD8xf43?=
 =?us-ascii?Q?l2uzfUYv5qmb1cud4wXpQn4gagqHwFGVEV51fB0D5qgyY29vw0CQZmnwxxre?=
 =?us-ascii?Q?EH8NmtBrQrag31WzDAgLN4UMl732SHds0NsDIzmQn1H/K1RqyVlEw7Ddkgao?=
 =?us-ascii?Q?uznZ3u/0gGKn1exvZx/9YHyhQS/2eSlI253qntuSioGmCQ45XKWlXb3iOeYK?=
 =?us-ascii?Q?L/z+yDcH4nDK3lE/WYnbYaAvi0JpIPdAm7BrUbeWQOgymaz3bAf6/0YPHqyw?=
 =?us-ascii?Q?lG4J1+X1eMnD1D9oanNR15fkVFugV7R6qxji56fLKEOE2k30VhIb62T11TB4?=
 =?us-ascii?Q?Pv/fnP616Qo2eTIylongWUhdQFD7PexQ0ySQ1Bi6nHTMkLD/VePVC6+X85Gn?=
 =?us-ascii?Q?yDUsPYopsyFizwspLK0jRRebujFwCB+s+P35QRqRRJoaMQdwPpXtflxDEB+g?=
 =?us-ascii?Q?7tPk1x7C2hgQUlD4fHwMkgf5lzwjrbp1aluNNaeZ82pS7VdcT8HDcP2U6TtC?=
 =?us-ascii?Q?c2RBmuEk4y1ua9jJnxnDPM2G9IifYCWw/8IElp6a8fzWIOjzOjG1faNl3qky?=
 =?us-ascii?Q?Z7+xhsoZM/PB5AXNrCaLWLGPUwhci0BOAhp8Cqw4rBTEzM1cIdWYuEfuyQhx?=
 =?us-ascii?Q?MiUy5rRhAuHbRUBLWhqyaHhG8l5hxX4qPMbnI0rMG2CvLx8/umdPIAB2waYO?=
 =?us-ascii?Q?Q/Znmzt29EODBltymOAHxxCx0inriYTSbaPihNFg4eLHjKX6e5ZqGNLLUxNw?=
 =?us-ascii?Q?4YqWZ4lwijyqm7mk3oFGEnSDnlZMjyHwtI/Emqn5WrsPM6/BXe7NkPhy8pxv?=
 =?us-ascii?Q?WEKkf/er+WqnMN4Uvp7rEVEOLVzfXadpJ5gxecBkhGhOfFl5EJDitPrY29Sc?=
 =?us-ascii?Q?0VvUG/KmDycay2Z7b8elcZ7nLMPOOrxb8+KV0GqocbX+fx4eJlKDA5NZ+Ekf?=
 =?us-ascii?Q?KLIyBrpWFIxtxhz9OinT+75tXqJJddgxYYZrzMO6ad+d0mcBzSij9HEcdroo?=
 =?us-ascii?Q?iMXZJv4JrC33zVX4dH6pdp9vE4TP8hoWzRqrRvwuM3OBcb7x1WMrOsq8zmnL?=
 =?us-ascii?Q?5Cce6bYRPaIJRSH1lB3wl79j9D/5ocMG7RNfjqM44foNrme+5ewQjCnCFeua?=
 =?us-ascii?Q?XsZRzwnV6IvXcoruCsOufOtAdvkkULJFPoL8f3U5tx0LIZkWwl0jliWjzimJ?=
 =?us-ascii?Q?DQo/xb3fBeIm4ADecp4QDS8BV2KlWdxuLdGMoQw6/MnD6vICEkM6eiT/pGma?=
 =?us-ascii?Q?BPYGKLFlEpi7NgtyNH3NT+Mr5ZJa83GFH39lYlWpd3/S5LUHoSN3rA3LLlDN?=
 =?us-ascii?Q?9SDFdY+C0QybxBIUBvxNDMKOIy8rvwuOV7xMDqQ7g+kPdUF4xws3gTQ+LB1h?=
 =?us-ascii?Q?qPjtvKmyWw3bB7CmA8RF5q/zsq1ISlJL1aEuMWpyu/3hSLJzqxBbN4WcMGrl?=
 =?us-ascii?Q?rQ0wp3ldlBjDPrm5MLGAUTAHk39IWL/MLhZtNtBSsWcYTpPAw8Zmg1Crqib6?=
 =?us-ascii?Q?ZdGeqz4Me3OvO5rrDw5SuLUzVmetUiQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5c86d2-5ddb-4bf9-b156-08da0dd2f189
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 20:14:47.1822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z32wOs/JtyzbjKNNiRggkTT9qvS5G8jl7Uq0X0fTmLqQhDdssdl6Xn9joeL2etZU24hmBshePN3M8ouIlZESUvqRotFiMAYMeZ2mY8Jv1cQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1882
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld <Jason@zx2c4.com> Sent: Thursday, March 24, 2022 1=
2:45 PM
>=20
> On 3/24/22, Michael Kelley (LINUX) <mikelley@microsoft.com> wrote:
> > From: Ard Biesheuvel <ardb@kernel.org> Sent: Tuesday, March 22, 2022 3:=
07
> > PM
> >>
> >> On Tue, 22 Mar 2022 at 20:59, Michael Kelley (LINUX)
> >> <mikelley@microsoft.com> wrote:
> >> >
> >> > The Hyper-V guys pass along their thanks for your suggestion.  They
> >> > have
> >> > created an internal build with the change and verified that it
> >> > preserves
> >> > compatibility with Windows guests.  I've tested with Linux guests an=
d
> >> > Jason's new driver (modified to look for "VMGENCTR"), and it all loo=
ks
> >> > good.
> >> > It will take a little while to wend its way through the Windows/Hype=
r-V
> >> > release system, but they are planning to take the change.
> >> >
> >>
> >> Thanks for reporting back.
> >>
> >> Will the spec be updated accordingly?
> >
> > The Hyper-V team is looking into updating the spec.  The document
> > is 10 years old, so they need to find the original source for the PDF.
> >
>=20
> Lol, here's the docx:
> https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D97=
72691E214/VirtualMachineGenerationID.docx

Indeed!  My mistake.  I just assumed it was a PDF without even looking at i=
t. :-(
Somebody internally here also just commented that it was weird to have a .d=
ocx
file posted for download.

Regardless, that removes one hurdle to making updates!

Michael
