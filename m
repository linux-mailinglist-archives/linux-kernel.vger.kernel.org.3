Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633BB496945
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiAVBvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:51:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:28060 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbiAVBvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642816307; x=1674352307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+aQO3/3sQlUxGz9CedVJM4HDv26gbg/FHXzBjGv7IJo=;
  b=BAyFfev70YYUqArO7EQE6XULNn61t7bHk99cRn7p1q+a2uxwGLaFmJzT
   xnmCk8y7EoIz08UffSNRMcxYq8Dl4DZLQ3j4fb5ebSl5y+7mW6sa2qcnD
   8w6MPMLlfb2K4CeKIwIFpsmFxOFao5ROmn0hzeW9hPOp/8h5ZLT5FhWUO
   4XJBojyW4o5wJVClw6IistZaiY2fl4Yjp/BMhcD+x6cZuEIQtrAXq4M2O
   GKjYrewQd+du3JFnD5qkJnqEutzIWQxC9kOYD/SN+X2FxbzcnkBl+/FH1
   Lun+VI82RZswaWtetY6f3xhk/uzumoAPLWfXGEHQi9CZv4xadkMW6v4h3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="226454937"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="226454937"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 17:51:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="494032886"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2022 17:51:44 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 21 Jan 2022 17:51:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 21 Jan 2022 17:51:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 21 Jan 2022 17:51:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBSjAeDthbBjf7/O7fqH/5C13YSRAEe7aUV2VvUjfYK6VIifqNgU/M+pJfSKzSePqCp05ike8XMe5iL6FR1KfgGniMnWkTnRW3qLhfWzdhFt7poMvBmlzIySRu+vQWCIZsC3JTdkuYCadHJ1UakIPhp97FM9hCxkrwW+q4ErC3YgTMNK9kmtfti5Vz7wMkKHznHMiZlvr6njrvRaSuCeGHZFm6XLDVtXLyqLaDr9UOLPivJWeIwKufz7xGyXEy+iNdVRkBLLoAHQXTghdBZpSAnHnvSzn8riTgdVTgB3LNM6lM//1kvNYMj1rUBhQRiQkR62VyESJgKRjwBYKuDMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j03+hDuLWAqKIPAJemvkDeqbvL9doDvNmDrg515nX+U=;
 b=HNR7HTptx1qKbyciB0G+2CeHjIovKd1novQjGNd38mx8OVu14peEdgHHS5n2cSS1nKuh/i+tCv0BQAwY81QOkQo27ZHoBD19sJ5WytO2S2DQhMSwwdJ5/vB0YcCByE6rpnBSFClAYwOK7HOpYi18s7uKNjPn2N2SUXhSKGOTpIUapjLO4QtlC70jCjxsgQc+nkP5KBRD6Z1cKEgHkCevv+ZZzzoHz7NLh+hiOM+D4GDNwlDAor5XK1UrtvYNv/s0RMjxG1pHkReO5eIuHNEXtk/7F9txoFf2tY1Zy5rhysSRTyZIM1BqFeDabg+EWLDfcpw79Q2lpMjzsQJTRsnyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW3PR11MB4604.namprd11.prod.outlook.com (2603:10b6:303:2f::16)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sat, 22 Jan
 2022 01:51:41 +0000
Received: from MW3PR11MB4604.namprd11.prod.outlook.com
 ([fe80::a180:db26:d811:4e06]) by MW3PR11MB4604.namprd11.prod.outlook.com
 ([fe80::a180:db26:d811:4e06%5]) with mapi id 15.20.4909.012; Sat, 22 Jan 2022
 01:51:41 +0000
From:   "Tsaur, Erwin" <erwin.tsaur@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "chu, jane" <jane.chu@oracle.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "bp@alien8.de >> Borislav Petkov" <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Phantom PMEM poison issue
Thread-Topic: Phantom PMEM poison issue
Thread-Index: AQHYDydWdWgzCdPlXk6vesHxVkUTIKxuMvGAgAANDgCAAAUc8A==
Date:   Sat, 22 Jan 2022 01:51:41 +0000
Message-ID: <MW3PR11MB4604BF71E4796C3C9AE08508E75C9@MW3PR11MB4604.namprd11.prod.outlook.com>
References: <1737f707-7743-4898-37d4-03098d7aaa57@oracle.com>
 <0aab10e0-6f1d-d67b-8aef-7e3d18e26544@oracle.com>
 <YetdZBbt0P/QBHDr@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <YetdZBbt0P/QBHDr@agluck-desk2.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54a35054-3863-4ccd-d677-08d9dd49bc87
x-ms-traffictypediagnostic: CO1PR11MB4963:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <CO1PR11MB4963FC1FCE5371CF6C57096EE75C9@CO1PR11MB4963.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZwL00Tt4+qmeu5f9IRM9uL4gTYRu9PAUk7njH1EXwElPzhCFgIzkNFP2sujtY9UZAG1DJYSwM4E6qOLw2LHENFZPLYQy3vv/+C2C/8ciFcs3lEu68DP3PI+RIJufuG9ONwkOg3xR8U7LLk7iz3xX6GxeihcaDTwkmtq/Y9Hwx2q+6mLMfY0yn8uBfAfr+fd9ozEyQm9qx+tLhyyl/Alt85yUdDe2iYgqe++PJ7UwLtWboLzvSNoMMpvzISCGL1ZeLZib42VjLSMxuOLMqaePsNatuIJNPiCD8dt/DGV3uDVQnFrigIdAJQ9Y11+LTCSnc58UiIvJuHfqn+BLMgxoTxtbQcMD0aSav1yRCACSE8p5G6G+L0/AWjCG1mdQzs8oYtPhoSCMP3sbK0OAgjEs6dWBkUaO5jB+mjD4V3tGf6RPBMTq9XL2ZYy/aXF4StLsiyHrio7QtNx8GbTI/piyAY4WEWd2cK0p5qtXK8QYdMgo9LeB8MHZkjht/EFnJtTsoiNVA6GZitU52mGr/d8Grm4KzvYr9nvZy8LAEMtb0BgEKebAoM8M4veqce+Vs5KNnlkOl03GK3sPB154/W1tJTDFqF8Q8wEgNdYNjawUPSIwrHU7Uov3BV5uOcWbjta3lfZMm9XASITHs7ztATO0DDaUAnZot2yk0+7oilmQYxVzvuMBq1immN7H9x0XitYkrkvUUPkbZnOfMWhMsjXdaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4604.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(55016003)(71200400001)(26005)(38070700005)(8936002)(186003)(83380400001)(54906003)(508600001)(82960400001)(9686003)(110136005)(316002)(66446008)(64756008)(66556008)(66476007)(3480700007)(4326008)(7696005)(2906002)(33656002)(38100700002)(66946007)(122000001)(53546011)(5660300002)(52536014)(86362001)(6506007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zRBusfOFTqA3daeqnB7kT/X5LP+9bzJwuJdSNTFZXXNz2qXVxHqU3zhfjOz8?=
 =?us-ascii?Q?y12+rksYg9GOo7bOokQ4dKiVxbc0KMns37l6jE0GNzMZeeVQbuQbX4USp10Y?=
 =?us-ascii?Q?+eRMERBYv+daAVtmpT8EzPpT5h7ZjqrpcKn+tb7edmIE4b67SU0thJ0fhmCi?=
 =?us-ascii?Q?LtT+TN1UVjXQhh2Oc0ZVh7W5plFwxco2msEUZ+cWE5aR5zALzOtXHh+T+P0I?=
 =?us-ascii?Q?V+Q9Hrb+phJrWTYhAJvBbGdfgLMqR96Tnp+wGPfNA6j9Pcez2IitWZGm5SP8?=
 =?us-ascii?Q?B4bS1tUwVWGffxnfEyNndIQdBO79sS56EKHybBWHY3CE4t0JRB1RD8mDBbw0?=
 =?us-ascii?Q?xMF2rMdCSDit89TpINdqBc9WBVFsLq7cEdQtGKSr8wlAVecwtd4ANE4vzyK6?=
 =?us-ascii?Q?S1/iO0yBM9wCUXhLdaGYJLCtvcnES1K0DzopJRM/UOxAsKTMWjy6TmYn1UA9?=
 =?us-ascii?Q?mHHFmVUwxN8R8uJMXOJCEbBzVcN5Yt2v5/z8KVR3fLbj6wIhYrveDGRwqPa3?=
 =?us-ascii?Q?esBTfRun1LOATaBQKi0jugWCO+vyjoVpi+GP1MbA4yniQgCjquIasLfAOvwv?=
 =?us-ascii?Q?/L+1u8zjGVqvwiWmjduL3/NE7BskYRjKDFYKJtpv5rlfOpNEj1Kdv36hob3R?=
 =?us-ascii?Q?JaoDqqHmfLv7jDPMM959w6Z9CkV6N3sJLwusi0+o8TT267Ee97oVOUuJElU4?=
 =?us-ascii?Q?GelmggtfHF79ym2NK7jJG9bMS9Thw7PgGhQz5XcTbT/dRKEAuRSSURbmpWKx?=
 =?us-ascii?Q?pF5fwoKYlgpyOQ6rJto6NDXBgT0VEdLnIo2U5UI/lDdx3gV3MWn8hwmRGUNO?=
 =?us-ascii?Q?xdeJtW3cHC0gSg7tZQJxgKp2PFiVoMrqzS9bef6DZbw6z/zmi2Iml9k3xqmH?=
 =?us-ascii?Q?VYrwETWbwfjypxOqRWPctuNRTZAq3AXTYZSSQnAnv9T7z9MCo1IjJxzEAVzR?=
 =?us-ascii?Q?2f5sXPrN3vT7NnfD9cciUHd9Qp16PjPUcht0Lda8bX0ANyJQ4CeB3Zzs3ty8?=
 =?us-ascii?Q?UrogzicRpUbE5+t5BvgxKBWSd9c3mhCwVjXxKnavSUhPrbfmdSxTzXIg8ZPg?=
 =?us-ascii?Q?XKaRiKIKguTeBFqFK6++Qolg3+Txztv05p1305OeNQyUn59tKQyLkvTOWv2h?=
 =?us-ascii?Q?19ber6+k9RnWbY8XDqh+KAweky90x3VoH/9U5TY4SPDjcNzj0TvyJRiKYNro?=
 =?us-ascii?Q?t+7tn3nGDKebO6DaSp8zxTc6CdLLGE9RxzNjRIuMSq6vSkeikDTKCcqTrPTR?=
 =?us-ascii?Q?ITp4N2nNVfCDYrlnyTpwI/k0Td+dbU4jHotpkkKLtJXz82lMT4o1JMy5xA9D?=
 =?us-ascii?Q?JMgxrXf9lqZu5KXF1Jqu/Xi/si1HQuF7vy3CUMBFN3jFM4gaMAGJjO4B/mP7?=
 =?us-ascii?Q?FaOj6bcuYL/ymSvfFuRuOOVe2szCZatgO7iEAngbps2eJzmUuSdlEYSu/xM6?=
 =?us-ascii?Q?ke4eBCZ5ZB4rXu18yYXZu+Ny1ukftwbl2mqCekqu/LcK14O3/+FpS7bNWnUg?=
 =?us-ascii?Q?WWZFck6ePOYXo85rYdMg8EuGmjie8feHX8Pyf8XUV5gqGEBtZwpYdTYJRj2p?=
 =?us-ascii?Q?zRpH3dFGQJhnuOVV57DqZ0wZrNUvH9TqVHASMI+1+0cza52hl2hP8uq0xH9D?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4604.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a35054-3863-4ccd-d677-08d9dd49bc87
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 01:51:41.4068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZH2xu0aHyLTlqlwRT7OnUpi9t04Ec6z3xq0pzP/ATvdQ/DK4gKG/MQXoZyyht6NGbNx9n6Xz/YP/YZH5Sa3PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jane,

Is phantom error, an poison that was injected and then cleared, but somehow=
 shows up again?
How is "daxfs takes acation and clears the poison" by doing mailbox or writ=
es? =20
Also how are you doing ARS?

Erwin

-----Original Message-----
From: Luck, Tony <tony.luck@intel.com>=20
Sent: Friday, January 21, 2022 5:27 PM
To: chu, jane <jane.chu@oracle.com>
Cc: Williams, Dan J <dan.j.williams@intel.com>; bp@alien8.de >> Borislav Pe=
tkov <bp@alien8.de>; djwong@kernel.org; willy@infradead.org; nvdimm@lists.l=
inux.dev; linux-kernel@vger.kernel.org
Subject: Re: Phantom PMEM poison issue

On Sat, Jan 22, 2022 at 12:40:18AM +0000, Jane Chu wrote:
> On 1/21/2022 4:31 PM, Jane Chu wrote:
> > On baremetal Intel platform with DCPMEM installed and configured to=20
> > provision daxfs, say a poison was consumed by a load from a user=20
> > thread, and then daxfs takes action and clears the poison, confirmed=20
> > by "ndctl -NM".
> >=20
> > Now, depends on the luck, after sometime(from a few seconds to 5+=20
> > hours) the ghost of the previous poison will surface, and it takes=20
> > unload/reload the libnvdimm drivers in order to drive the phantom=20
> > poison away, confirmed by ARS.
> >=20
> > Turns out, the issue is quite reproducible with the latest stable Linux=
.
> >=20
> > Here is the relevant console message after injected 8 poisons in one=20
> > page via
> >     # ndctl inject-error namespace0.0 -n 2 -B 8210
>=20
> There is a cut-n-paste error, the above line should be
>    "# ndctl inject-error namespace0.0 -n 8 -B 8210"

You say "in one page" here. What is the page size?=20
>=20
> -jane
>=20
> > then, cleared them all, and wait for 5+ hours, notice the time stamp.
> > BTW, the system is idle otherwise.
> >=20
> > [ 2439.742296] mce: Uncorrected hardware memory error in user-access=20
> > at
> > 1850602400
> > [ 2439.742420] Memory failure: 0x1850602: Sending SIGBUS to
> > fsdax_poison_v1:8457 due to hardware memory corruption [=20
> > 2439.761866] Memory failure: 0x1850602: recovery action for dax page:
> > Recovered
> > [ 2439.769949] mce: [Hardware Error]: Machine check events logged
> > -1850603000 uncached-minus<->write-back [ 2439.769984] x86/PAT:=20
> > memtype_reserve failed [mem 0x1850602000-0x1850602fff], track=20
> > uncached-minus, req uncached-minus [ 2439.769985] Could not=20
> > invalidate pfn=3D0x1850602 from 1:1 map [ 2440.856351] x86/PAT:=20
> > fsdax_poison_v1:8457 freeing invalid memtype [mem=20
> > 0x1850602000-0x1850602fff]

This error is reported in PFN=3D1850602 (at offset 0x400 =3D 1K)

> >=20
> > At this point,
> > # ndctl list -NMu -r 0
> > {
> >     "dev":"namespace0.0",
> >     "mode":"fsdax",
> >     "map":"dev",
> >     "size":"15.75 GiB (16.91 GB)",
> >     "uuid":"2ccc540a-3c7b-4b91-b87b-9e897ad0b9bb",
> >     "sector_size":4096,
> >     "align":2097152,
> >     "blockdev":"pmem0"
> > }
> >=20
> > [21351.992296] {2}[Hardware Error]: Hardware error from APEI Generic=20
> > Hardware Error Source: 1 [21352.001528] {2}[Hardware Error]: event=20
> > severity: recoverable [21352.007838] {2}[Hardware Error]:  Error 0,=20
> > type: recoverable
> > [21352.014156] {2}[Hardware Error]:   section_type: memory error
> > [21352.020572] {2}[Hardware Error]:   physical_address: 0x0000001850603=
200

This error is in the following page: PFN=3D1850603 (at offset 0x200 =3D 512=
b)

Is that what you mean by "phantom error" ... from a different address from =
those that were injected?

-Tony

