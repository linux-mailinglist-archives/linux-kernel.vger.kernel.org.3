Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240DD57A21E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiGSOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiGSOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:45:47 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A782DCB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmCxXjWTeGBOA6shZjE33zhrZJQYdttt/psbIK+FFQQQmu3NOLRYRYwBAdo0L9akmDg/SQ0EPprUWIkp8j4wcJ6FMor4v01IGp09zHCCp1uZMvLSF9RgrefPqmX/jLnxxK71IF4VfkB4Y5JdLelZ/vcUw5Ma/DbhtDxVlu32Nn+AmJhHtLR5QY9xqdQJp9fKkt8EiVOgMVKAYU6UL0ZovEgDqLU5olwspNDEK4ypk7PymBnUGQ6BU4eCCf4Zo/NtHOVd/cNUzBvIL5M47kzJFe/q9UuRxKGl1D6+t4vXGDnptvh+Xqwz1ja5gmG1pwaB1zN7OIYlrJPNKX0KGmJSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxNvpR1rrPEBVxjcO2AbGngLIZapWDxAtVFv800H7lM=;
 b=XX+C8Yu6KW1aa7YRxZhccwqIOMYR9Xn2nt8h8fOhkibSLO/eJhewNr9y0RolOmdPjD6wO5dGiNGMIpWbxH3KZfdIFjy5rMzI4OkUb/te0WpAlFFb0uIXkyu0sIdmYV+ZECdhYfRzorZuJRsL6tSNqY3KHHySw/twhziHK2Hhnx2x/fMVNUFMbFo2Ho/2K4FHcwn1gSVFBYChHAewoJ9FBaQOxjMYRtmBHdy9PSsmotHRApP34Ds0UZ8INd1FpYuM4u9OpmT8Fx5gHa7Ebgg8HhW/ESU7YUHTdxN38vPgWyG3w2stkNAZhs7PB37stwguWDELZLD5UHT9ZSi8/a8KIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxNvpR1rrPEBVxjcO2AbGngLIZapWDxAtVFv800H7lM=;
 b=IuOspfLnyJfyX3YY4c/HgcPYM/iwDImRHGNjfPXhf9Aj9JztMQ62TOYfEtRw2oRUpaLFIp/1hyRu9zMZBR/9FVlrUwKVRnDHKBMuaFEzTnrzUVEVfaKfG54udetUv0udsJREs5PCwiIXLQ4VoB29SqkmORtEOhjiYCZBBfd0Q9o=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SN6PR2101MB1343.namprd21.prod.outlook.com (2603:10b6:805:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Tue, 19 Jul
 2022 14:45:40 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743%4]) with mapi id 15.20.5482.001; Tue, 19 Jul 2022
 14:45:40 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: Virt Call depth tracking mitigation
Thread-Topic: Virt Call depth tracking mitigation
Thread-Index: AQHYm1nH6l3OTUepcU+z5MKIwNgU8q2FxEjw
Date:   Tue, 19 Jul 2022 14:45:40 +0000
Message-ID: <PH0PR21MB30250D66D36B5D94C809BE31D78F9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220716230344.239749011@linutronix.de>
 <4ca4a4ab-6ea0-d94a-59cc-1ab99ff869d5@citrix.com>
In-Reply-To: <4ca4a4ab-6ea0-d94a-59cc-1ab99ff869d5@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c007699c-4d44-450f-a5bf-1a7d2bca1eda;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-19T14:40:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 525d3501-3da4-4362-31b6-08da699559db
x-ms-traffictypediagnostic: SN6PR2101MB1343:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BY7KGAvJHHjpkPVAgpOSqsbKVgfv+jnUestEYz/2dQXm1xJX+TD2tJBponjR4BcK4vKXan04GKGajMEK12v0dIuKwkufPvWTYC6H0xbjzbvYFPhvo66FrJRq4w7SjLTIOcpa23mMaD5HGA7EXR7DELiMjr2492Hrj5q+DpybZzbRLgH1p5dMHU/LZP3KM0uaxIGzDxG6T+/bU926A32es3tqoy4Ut90TNYMaa6C2nufsBkD24qr3TAWYCdRYvSByfqF4MRYbtU474Y+WM1RoNB+15ud6cDM09zYzJtUQzCvKMs4bh3HPHIYjMBVm1PONYBsrmCVLO/LLGXlZK7DdfPg3QhGQY+46BfmmJHXGhu4Tea6NNBaK4mxlffewtdWVH49vAlNOd4wQuZbCwu3oezcCaX4/S6aSCl2RPTgGKuBvPOnOOp+/iURAL2YauaKpS2UxIPIIrc7QFd1bfpoqy752VLA9yLUIKErSxbJhsqgX1g8HEmIQ2AdI8EBAR7MC7aN8qduUkGFUk4SMYkLpdP5Oh7MYo3Kry/fbR18vE8IT3VJyO5kHihndu0IGWYreiRDpOQrEtf9HQy4BFxnkG1wM0jxvYJmArK5pfcCpYooNnyaQVZRaVbW50Lmwq0clmMzg9gs/fRWrmywqgirPDSOU1NMw1IqQ7ukqRd/rnY++p9M7+voEoyGKj7+LKO3JdUsiQVlb7zwwg8C1TuQ9m9msdWPscrHDgGiuhi+2TFmXdrUATg082gnqnPaWStn6nd4Av5lHpoLaykySkt6xf/CJHGjWFc9eX+P4UHHcknrxwidf3Q/of1xvkmDyuroyEHScbDQt6zId0spfpv+BElIkR04fdk8q266muCRx/do=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199009)(186003)(33656002)(38100700002)(6506007)(9686003)(107886003)(26005)(7696005)(8990500004)(53546011)(122000001)(76116006)(83380400001)(82960400001)(38070700005)(316002)(82950400001)(55016003)(64756008)(41300700001)(5660300002)(4326008)(66446008)(2906002)(8676002)(10290500003)(66946007)(8936002)(71200400001)(110136005)(86362001)(52536014)(54906003)(7416002)(66476007)(66556008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YGPphzYJtlUqJFb9K/j8xFvGnE3SHe2UKFeVntjPWPQb4TCx5ffedt9sEWWm?=
 =?us-ascii?Q?fkn8J85LBAjrZwbhXTe9S3oxgyKET9WYg/KqrVKlYzV4vV/0zDIXsK2YfRgq?=
 =?us-ascii?Q?QuPThm5yYp9InMoOP8lrkVo8apCgCKsaNqSPOEHDqvxBDvqsA7FfNPstg+Qd?=
 =?us-ascii?Q?qjZpz0MXOE0+EvcDM8tRNwuB80BT3OuoKyBF/xxwG0Y9r+xEGyD2G7YBXLpD?=
 =?us-ascii?Q?AkQvx8Hl/kv5l5s2eWdzxKH6nxDYQvXZsKTA06TagqLRaML3VS4D0koMsS4C?=
 =?us-ascii?Q?cW5FvDLxlbR9tVk/X15gg1ok/dx94mjY8Rgc3idbfbniwdF3UPSJZCzcDcry?=
 =?us-ascii?Q?pwyjiH3BdeApznMIMIevPH52eGB17CrbL/3lzfVwf4D2PIqyISCJ2un7A1ii?=
 =?us-ascii?Q?QEm8Mf0Y9V8KLmclchfWtl2tvnB+hHaw90+3vMY3H0D4GyXnANCJ4fnfHydz?=
 =?us-ascii?Q?kaFrYwwTfsM11XtgG8Hhv9cezhNbfrUxQ5aedLbWbZcenR0B4QMNKe7ecpES?=
 =?us-ascii?Q?ZdT6wrMf+v58b80sprX0rUg5sgg4bRxP7t+oGrVvmRRuQgmBgtoM6FrQdbDm?=
 =?us-ascii?Q?Djn6tE18b68LBaj5Bz5TgJvIlaaq+fwt2i9kV3yCQXs3ApMyHHNqj23gsrE0?=
 =?us-ascii?Q?Lrm0wc6ooZ2MgL1nifCjIn5DOx3RHFAelHg2A9iB2s3XjQMQNwP8dUTIUYOd?=
 =?us-ascii?Q?+rmnwRL5FOGTiKulhjVRSkKDFTJtDysxCNW8DNxfGtwwsAvPJyLN/z4kcFy+?=
 =?us-ascii?Q?gb5Sws9mmPhZk4fqkrHbO4NklrjLKTouMCuco7pKcsJLGu4pSa/DXxZkTWCf?=
 =?us-ascii?Q?YHdgcU6fkI5LW05gJsY95/w2IVWAI7cWTe2TOKtK6Rh6rqhQe6iHLIjbjIXJ?=
 =?us-ascii?Q?yw2MqXDOniVJii4dJq/99J54K9sewG1l0gRKucJ7a/CoZxHmLeYyzW74Zjsf?=
 =?us-ascii?Q?PIwy55zv5hN1Ni4+CS/FySZxZ4mINHbE9yrGvM464gFRBc3g+N0Bqobd/ZXp?=
 =?us-ascii?Q?u3zSyRBWS9+FjQvNjVUdrqPsgYLBHTHCDm/n0XAhNaZBr1h1h78/+UOdIcLy?=
 =?us-ascii?Q?d/1FXLflTNQpcwRBeURcaispFnJMPL2GT3U6LDK0LD3G2NhOcHkUxDoOrSZC?=
 =?us-ascii?Q?NkO6VS+i3lPgb/YUqUvY7Ep0VHJQIwVKNRMRXk31s2aQ0dAh7hF+1hB4p6o+?=
 =?us-ascii?Q?igNmHCwyqhxH4xdm06XyhWYllCsYNnUpMYn0+sHFJJFe92Yu0CJarElIxpPZ?=
 =?us-ascii?Q?HaArZfxQtWe82h/uOPALjPuEzf3sJgVqoJwqJxKwePI2mut6PR2Eh2V4yx2C?=
 =?us-ascii?Q?nO0Y2IxgrDgCUaiy+rPGQyflJW/0bLIinc1nywUYeuCdzzR0yL7HAWD9dlMm?=
 =?us-ascii?Q?D+hIPG2ZF8I0LdRaTdCE2HAjJBwuEoEB06sL15dMlWIuqVljugNg9puI7OFi?=
 =?us-ascii?Q?Kw0jVJONPqZr2sceB4s+TYd2OyFYyav56EBrlx7CRPh4nh47MNvOGPyZioTG?=
 =?us-ascii?Q?9UdO65eWvemTcT6RGgg2CYXsZBID4je9Lg3Ner8v3z5exLLxO6WPHSHONzDt?=
 =?us-ascii?Q?EG11CWxXX8OAXXRAftsdi8lmjXnd5oAjuqQ0l+aiUbDtrlFkoOof5C9UCbMZ?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525d3501-3da4-4362-31b6-08da699559db
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 14:45:40.4771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brr7f9RUhKP4nEuhyJ8jTvCsMSe00yjI5UjvjDGJnAAGtnsFeZ5WMxJY7SkP0Ms8+8B9IUkqiUlhleJnqJsOKHHc84KBmTtP8W372ZVqRYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1343
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Cooper <Andrew.Cooper3@citrix.com> Sent: Tuesday, July 19, 202=
2 3:25 AM
>=20
> On 17/07/2022 00:17, Thomas Gleixner wrote:
> > As IBRS is a performance horror show, Peter Zijstra and me revisited th=
e
> > call depth tracking approach and implemented it in a way which is hopef=
ully
> > more palatable and avoids the downsides of the original attempt.
> >
> > We both unsurprisingly hate the result with a passion...
>=20
> And I hate to add more problems, but here we go.
>=20
> Under virt, it's not just SMI's which might run behind your back.
> Regular interrupts/etc can probably be hand-waved away in the same way
> that SMIs are.
>=20
> Hypercalls however are a different matter.
>=20
> Xen and HyperV both have hypercall pages, where the hypervisor provides
> some executable code for the guest kernel to use.
>=20
> Under the current scheme, the calls into the hypercall pages get
> accounted, as objtool can see them, but the ret's don't.  This imbalance
> is exasperated because some hypercalls are called in loops.
>=20
> Worse however, it opens a hole where branch history is calculable and
> the ret can reliably underflow.  This occurs when there's a minimal call
> depth in Linux to get to the hypercall, and then a call depth of >16 in
> the hypervisor.
>=20
> The only variable in these cases is how much user control there is of
> the registers, and I for one am not feeling lucky in face of the current
> research.
>=20
> The only solution I see here is for Linux to ret-thunk the hypercall
> page too.  Under Xen, the hypercall page is mutable by the guest and
> there is room to turn every ret into a jmp, but obviously none of this
> is covered by any formal ABI, and this probably needs more careful
> consideration than the short time I've put towards it.
>=20
> That said, after a return from the hypervisor, Linux has no idea what
> state the RSB is in, so the only safe course of action is to re-stuff.
>=20
> CC'ing the HyperV folk for input on their side.

In Hyper-V, the hypercall page is *not* writable by the guest.  Quoting
from Section 3.13 in the Hyper-V TLFS:

    The hypercall page appears as an "overlay" to the GPA space; that is,
    it covers whatever else is mapped to the GPA range. Its contents are
    readable and executable by the guest. Attempts to write to the
    hypercall page will result in a protection (#GP) exception.

And:

    After the interface has been established, the guest can initiate a
    hypercall. To do so, it populates the registers per the hypercall proto=
col
    and issues a CALL to the beginning of the hypercall page. The guest
    should assume the hypercall page performs the equivalent of a near
    return (0xC3) to return to the caller.  As such, the hypercall must be
    invoked with a valid stack.

Michael
