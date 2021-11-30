Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D054F463044
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhK3JyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:54:15 -0500
Received: from mail-dm3nam07on2085.outbound.protection.outlook.com ([40.107.95.85]:50401
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240590AbhK3JyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:54:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blB0QHf9C89UbrZLT6ZobndO1XGdIwV767c2n16DNr3Ljsl+dJ5peglZ0gU8z78XDWZnpjC5mF1JPYcOr3wLghh8xzZUnJiJY6H+CdiwJNG06jlmD0PrSLbxzIu5ARa351IKKtxbUHiKci963Q8ph1o5rieLvb37c8J/vdMOhBVgoGcVTR+VBrxQCBwIQF6jtBwiEa+c+gLo7qyY/RrcQmi7sapKbB7dyA6Aou0nz58KJYZKjbpGTNgrN82fsOtemHQrp5KDvWpqk89gq5CBRvfkdh5Y/G70FHMjWdevfYPcM3dUh6YCN/1sLy8c/fARWpg9xUR7uErl2+EqpMacRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn8YDJhdITYcwW23rSGLac62n2ZeqHru/R6j5kFSBBU=;
 b=OpdA4zt/37xEXPzTRxorQg7rRHRu8Gv6QUZMV3scAitZpiJtbNbBBldEYvSr8ajwDSgQxqSDsVE8oUwuUsjtq/jd5F89GIpSHOlenpZwBZtkPtCFxqzPsHAMF2o5pk8+95JTx4ZEC7aeiwNHQYiK+pU+UM2DvoaskZihxHdTtsRShr4oGOAMSCHc0uHxdWOzOJNcmumfOMQbxw4dR/Ei5g4R4tEDZ/AOF85KgElzWQULMi/sgiFyPjc/iaQlpNhRV5sp2bpKu0vQRN262+g1a4RWRaR+mnxf7UU2HO9fjbIJjQZXTigOUnaBzOyX1xEg9U9mhUSsguGw4aeoCCSSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn8YDJhdITYcwW23rSGLac62n2ZeqHru/R6j5kFSBBU=;
 b=Zb9hgKuof/hBt+AWgDkT5aDzlY8Beg6acS6Qvc0tMgElPkwwPoI4ea6yLeXwmqUrEuzw/YMs6mmXnSeyTuVxehWFwu5DOC+0Eb/C2DX1h02RuK45Y8+n+3D/riHcH/5+7VtcwdCmAjnibC952baiffxBx+dTcALx7X65wBS4jMI=
Received: from SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18)
 by SN1PR02MB3790.namprd02.prod.outlook.com (2603:10b6:802:31::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:50:48 +0000
Received: from SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::8861:2ba3:deb4:b3c9]) by SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::8861:2ba3:deb4:b3c9%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:50:48 +0000
From:   Abhyuday Godhasara <agodhasa@xilinx.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 0/6] Add Xilinx Event Management Driver
Thread-Topic: [PATCH v7 0/6] Add Xilinx Event Management Driver
Thread-Index: AQHXyiGGO/oh8pNNck6JdLI41lUmAqwFtGmwgAJCkYCAFBPokA==
Date:   Tue, 30 Nov 2021 09:50:48 +0000
Message-ID: <SA1PR02MB859271E705E56BAF2B9C84DEA1679@SA1PR02MB8592.namprd02.prod.outlook.com>
References: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
 <20211026042525.26612-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592C7C312EA93D3B9467872A1999@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YZUcAch7lVZ32/+t@kroah.com>
In-Reply-To: <YZUcAch7lVZ32/+t@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95931ee2-f48d-4631-f0ef-08d9b3e6e326
x-ms-traffictypediagnostic: SN1PR02MB3790:
x-microsoft-antispam-prvs: <SN1PR02MB3790F918004F4D5A5BDC519FA1679@SN1PR02MB3790.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UI192D3/dAO8OKay0lSQtRakoB+JJlLNkuuQ06vIfyBNG+iQuOn1cEs+4Oiy4sttLD5q6MYHtt4ezi52XHwr1WwUrd50MRLYAGKJBhl+zj7Af95y4WSnSPxLJF4GfPNK7+Tw/Zj8oEyznZ0uehGMuME0ZNWXzqwu3NeX5dF0kAKDXdmeTciytJBUsiRvYvCiQWR95970e1yM9tqrXT0O81QgyyetLyQdDjpyfPj3jVnOnAtXQz7iJ6CX56hojDbLMI/4iwXI6Huslz5QRsGklhexg7zWO9qFZJ4LSuZI5t/ZjX9vtKhUcz9upXvGu+oY4smQG7AGCzZPsYfGer3nzJhJOETqGfKExMEWaN05IRaOIzFdJ0OfHW53KIp71Xzs85WVNFkCiNCGigK6okSCV76i0Hx8kKf6qYbtqMfSfcOlOI3PM+gy76buHjP4HmPKYtLHaZ7vmrRPTw2smOSMOPUdwCJ/lDDJRzfjKbE1wByMOsO4PGVP1Nk4+lsqk9G2zxDuV+Cim9OhtT884nhT4O0nf7wQhk5K68dCnwPCKmncAG11ecOGk0C+jAhQ1x1NdKTp68bHcvggUs9V4qrxRv4VHljUimFf2ShyIHPh2OfNW5bGn3NMQ6u23Hn19udwhf1pU0pd1CyEZWns/HH9irjuFwNXwOLZOmb88c7chSk5Rw0mjqBXtTGe4XbybjJzhMOu5o207xwwjEZ4OjtTNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8592.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(66946007)(52536014)(4326008)(38100700002)(508600001)(33656002)(9686003)(66556008)(26005)(83380400001)(54906003)(186003)(76116006)(122000001)(86362001)(7696005)(66446008)(66476007)(64756008)(71200400001)(53546011)(2906002)(316002)(8936002)(6916009)(5660300002)(38070700005)(6506007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hNJythcb/ifySD0OfyN0nbRGI3caqcDhKLiFwePJacnj/sWOJTIYYXpg5fyu?=
 =?us-ascii?Q?hzDEbqXxRQhMmNI5k0GYbEflznTK2RAB1XdicAKOXGQgTxGZ4Ekr2xzTt794?=
 =?us-ascii?Q?jOMr/cPiQfu5RQ1weM6osX57eFGtidXeuSQw9v9cff6d0KQVMqoPfeS6vhZ2?=
 =?us-ascii?Q?COthyDwD9a7AN3KtVWRjmabk43GlelymN2MvSubcjPjk+TUmjlK5Lo5PTzpn?=
 =?us-ascii?Q?+qUD3EdoMtTL4AB26ba6spQrge+S9g+yhCzXpdxsme5jX6F2rew4pqI+Id3x?=
 =?us-ascii?Q?JuRueWsFQJlJMFK4CbMxjPCQqo/8EyyBo8zLR4b0GzonPVcQRawjWimqDVYt?=
 =?us-ascii?Q?674TSRUwa9ZTHwgyclQoFNgXanvSGLzrOiEvdn9BoEXUDPEB6qf31TxiU4YH?=
 =?us-ascii?Q?AKXg3x0/mQ6IsIfDm/BNIRvS87r/FN3Sas51i07WU16tXEhvcxgMOyrILzJi?=
 =?us-ascii?Q?IfH4Z7eJENM8vItgPUzkmwa4GbnZnYZQ2QgrjLnijLt9QYv6sHFd/XjTLW48?=
 =?us-ascii?Q?TS+hmSiXWBH+EkLmhAj6TCq+eTVPbjo1wfRHfYYJnk5VJrxrmlRiHaUuDReb?=
 =?us-ascii?Q?1NxSRFyl6nU2bc0zgrhO5uia64GU2nkBC+sfyi/qCsm+6cFHgDuNbgXE79mS?=
 =?us-ascii?Q?/n7Eu72i2FW7goTfKPYcrV+vLqb2PC7DKY3SskQ/IZj9OnkqxnoW4yYttdWo?=
 =?us-ascii?Q?RBN9p+AhS1fiRJP6Sz7JPCEv9CfICCDmv5Dz/w+aTaO5vXozA8UAM/JGaR3b?=
 =?us-ascii?Q?CAPXaZHDP2ZQjoIQgZjovfxiw1cP3HjaC/gSguwnBHWneQRxbGp28Y4moqe4?=
 =?us-ascii?Q?yAbWS5sa21yiMBer6LYD8ry4HR6PLx0ZcFc+E3pWCAATndZFX4wDbfLSy9mF?=
 =?us-ascii?Q?hGnfUTp9IzUokNUwSSGLO88vuK3qa7pqwQfd2FZK5sPGFD9kA1ux6iLJc9Sw?=
 =?us-ascii?Q?CW0B1sPlAKTdemnTOODV7UO4pL3LVbtTYBcrU9My2f2mRH8JIVfVpBU6JPqb?=
 =?us-ascii?Q?0MhFAKxoCLafKx9TDE2qO7eWYkFVqGFSHcjuyATXBd87DrO5tbVDnmgjOy2M?=
 =?us-ascii?Q?A3Vr6H3Cj5VOwKgCtbjeiRGjWW7RKUcgVi3eqka7z8t7wDKc7/k+WTUFLgu8?=
 =?us-ascii?Q?0mrPWA0bEATViQSq8aqQaE1h2MaAgNXqhiThcp/ciC47QK5nYHZ5/D/oP2N1?=
 =?us-ascii?Q?FxMFB0fPx0T6R2EaHKc4FViESx47vZlR6NZxqcKTELz4XNkuL+tD3hAUtgZ1?=
 =?us-ascii?Q?Q7Y+LGIwPNKlpxQ455FTenQNlflBIw4WmPNEKorCHD4HKlzvoRvha1BCe0Rj?=
 =?us-ascii?Q?TPy7WlUsGFXGir50uSl1h4kIx3VHQnPcKKYHsvcW3JLmRNlmKutDP6e+bfjH?=
 =?us-ascii?Q?4MaHIbQXg4qrgcToJQqi1tXeoNFkRNLWka5qCXPzCEDr1LPolTtWYuWQRc3k?=
 =?us-ascii?Q?NjSpJOEtbOkAW1Ba7W+Gb2itDjn9stRBWzGa/2wI4dZBY994vpsw238629MP?=
 =?us-ascii?Q?ftJnNgdfM6k12Do+1lZD/vnJcKhGCwLdOG1VpU4vDp1WMz7fQKh5YxLGqNgV?=
 =?us-ascii?Q?FBmjYeh70qXka96olbIF08P8VR4NJWzmGMPLuL9XyOW3FveFC4lO9ij8Ei2P?=
 =?us-ascii?Q?ERsVr00+ZrCUGxX9LU+1LWE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8592.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95931ee2-f48d-4631-f0ef-08d9b3e6e326
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 09:50:48.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1RnhXTlK27fd5OAhpO6GOnjFZZczn4LdwY+RBwvcfi8Jf4QLZFg1SCtKQFRdhKn1NiJrmAGAuqhP6SKCX1Klg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Replying inline,

> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Wednesday, November 17, 2021 8:43 PM
> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v7 0/6] Add Xilinx Event Management Driver
>=20
> On Tue, Nov 16, 2021 at 04:43:51AM +0000, Abhyuday Godhasara wrote:
> > Hi Greg,
> >
> > > -----Original Message-----
> > > From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > Sent: Tuesday, October 26, 2021 9:55 AM
> > > To: gregkh@linuxfoundation.org
> > > Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > > <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Manish Narani
> > > <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna Potthuri
> > > <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; Jiaying
> > > Liang <jliang@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org
> > > Subject: [PATCH v7 0/6] Add Xilinx Event Management Driver
> > >
> > > This Linux driver provides support to subscribe error/event
> > > notification and receive notification from firmware for error/event
> > > and forward event notification to subscribed driver via registered ca=
llback.
> > >
> > > All types of events like power and error will be handled from single
> > > place as part of event management driver.
> > >
> > > Changes in v7:
> > > - Update the cover letter and version history.
> > >
> > > Changes in v6:
> > > - Fix compilation issue that come due to force merge during rebase.
> > >
> > > Changes in v5:
> > > - None.
> > >
> > > Changes in v4:
> > > - Rebase on latest tree.
> > >
> > > Changes in v3:
> > > - Update the commit message.
> > >
> > > Changes in v2:
> > > - Removed updated copyright year from unchanged files.
> > > - make sgi_num as module parameter for event management driver.
> > > - Use same object for error detection and printing.
> > >
> > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > [Abhyuday] Michal suggested to merge this via your tree, Please can you
> merge it.
>=20
> Patch 4 of this series fails to apply to 5.16-rc1, so I have taken the fi=
rst 3.  Can
> you rebase and resend the remaining 2?
[Abhyuday] Submitted the remaining 3 patches as v8.

Thanks,
Abhyuday
>=20
> thanks,
>=20
> greg k-h
