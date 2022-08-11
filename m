Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1198658F5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiHKB6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHKB55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:57:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0BE83BF6;
        Wed, 10 Aug 2022 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660183077; x=1691719077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Clxptd3ItizFUYNKSyyrYOrnE09uq9qFfxbxERVJtSU=;
  b=Hn6JZ+vBDHF7KZKa6AlWIeTDVMIUpUF3dxr5l7blBaSVVbTh0fL66ZqF
   STyOTApTg/4hmVx72ceQjN3WNDNqZ2e2BBovnMmoRWgGy9pypzt2oD0hX
   scerKMnuv8U0VhLtY56OltlQUHkAXEaQXHeGuPcA5m3RPSpqvBXKIuR1B
   4XDQimQctcxW3+fDXDQoZtyn15ce6dPKje+5iJCgg6I8MWr3q+xLRuJE7
   9tA/Q3/5/JM2rX7bYDegA9gkaYZWEq98ZOZpQeacMn33E5QikaH0Pwf5V
   SZ8jz5d0caLq4W1UX+zySc5bucKI/hZHebeWofg72W6WL8shjYqd6zgpY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292027077"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="292027077"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 18:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="581472064"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2022 18:57:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 18:57:55 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 18:57:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 10 Aug 2022 18:57:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 10 Aug 2022 18:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjr73D2bugX0xjGfNC+HxCsUVHyVRSMkMjeE+rgG0Tgl2xoEHTypEuJuPdUbEXHrQw5Y8faBwisT1a5LpRrlPMrp/WE8C9drrLjgMs7urderGSnbwMwqTxeuD3FJbFTucOF8rklzqUGLzUN3q3REmXeZTLecNefS8wxae224Fe46XvSq52n8MgEhgEKTkCOU+V1/WtLY9SxR3V2Hxk8q1q8qwVYEuVnnbv6UeJM7LMpVImysMuv2yUufZVgrYhRZPmkkpsy1oODaBYhmGJFJC1HGvZA21eCN1tDEr+rKc7F34Dftq+ly4ha+Ia5en6HOWjdlkI2vSxzjCY8Hg915dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaILDy1zqDfN77R6JQPDzK2S+BHJW0+JRL7ECL7wOnQ=;
 b=Y6C2FddtHpt6GP5YZkCz4y8zlQUQXqxqMqmPPE6G8rRbjHO0H3biYNqF4x7QT/Hwoj1n8aatXNGfkolk8LnqqTSh1DR8wk1gfaHd7c9qRgndpGpzUmJJhYdfm0WeNty0wEWR9zd3kf1orbJxyK4jnzmAy1pQuua+AFgRkJHtjTaxZmKG1GLTGMWgjiERjezsRFtZVuaPu0pcIFqtQqTh0A1YWUozEL7UNI74e5Ae+IFHcmyXMfImxWQdEK1i/u8uJJfiH7ola08MHMwPZHKrFGIgAJTTZ/UC81EHk8DUA/f2HdztsJMQnupufnwEGvcvHEhXkw8kiii0xDClfssLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MWHPR1101MB2335.namprd11.prod.outlook.com (2603:10b6:300:73::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 01:57:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee%4]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 01:57:47 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "dave@sr71.net" <dave@sr71.net>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>
Subject: RE: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Thread-Topic: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Thread-Index: AQHYnGzh1nwOjOji802J3mkwYJ5zAa2V2ruAgAZYAICAC9k2AIAA95CAgAAOJ+A=
Date:   Thu, 11 Aug 2022 01:57:46 +0000
Message-ID: <BL1PR11MB59782DF6E7F3CD950FCA4319F7649@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
 <op.1p2k13ibwjvjmi@hhuan26-mobl1.mshome.net>
 <35d7254cafde24b722b167c6a3566592d903acd2.camel@intel.com>
 <f16af3f7887d26cde9073d443c1b796c945bc042.camel@intel.com>
 <YvRVZQKklqnbf9oQ@kernel.org>
In-Reply-To: <YvRVZQKklqnbf9oQ@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23b066ef-b246-486a-18ae-08da7b3ce366
x-ms-traffictypediagnostic: MWHPR1101MB2335:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EN5BAnH6s567GCI+JDOhgG1v8AHJ/PrnXjqbAKONmUERbzGeFbKuMoW6QHGwyC+mrNbpntFtxpTrbAEhYBjGeuez5VMhWqf2G8LF1o1snbYtveSaesQIOxrlLrbsjJvtPhZvu6BFuysA3S2ghIvfyTXYJxXjfS7MGRuUWkihkowzUWdT/4CNZvQg0jUypN3S4/n5go81CxoHjScJa4aDU/AW7yehWgXA0zgumsyTdyxoirgPdxpPFQdE+qRJXH9Adaw/TpRG8xaLHXBhevi9AWfr2eFMQaGWiGMBAVAPBfAycUauWMwBCZaObma5AzL4MqBQ1rN7lxxVEDdu8dbIWKMhuGiBfnnD09S62nBDsnaFFglNQTO1r/RMTOX/oGO3mzvM1Nb9LH0ivEOgWTtFaRbu5ny1y/FuZ94uUyfhUlK3wdGbGNJfHbhC/nmCO8DkbNsX+YjaM3sef6Ce6yC5wznB7e+5v0fTT3Qatl1o0CHwRDjppeixIKBochgmPxlGPpvuxr+uo1kTp4INkLJwbi+/I8q/zWPyUDvPTi2/RxeBh+3yP/whgFZ40xcNcSi8FMFCprm3eWqEjdOq4tL95aIWMM3q/mdGvgJ9cEHTycxjj9wcOaXEaicSWVOVLzy7rjPRytA2q+LmRFhBJyVxQe8G7txWRh/71WSHywIpx0+N90VfwJNDc+617JqzH3KWdgSvsHqEP7mH92YXTDD9Ry7i4Rd+JZCvcX6FmBRclVtalGFW+1rSKzAIqva6MIBP130yE5OX4uGtaqYVcXcahh90vDbukCbz+8oOSzCWlbfpNqCb19QdZIH+r7QH1UQPe+qycoKlWabu5hgUXR+BhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(376002)(39860400002)(66946007)(5660300002)(4326008)(8676002)(76116006)(66446008)(66556008)(64756008)(66476007)(8936002)(316002)(6916009)(55016003)(54906003)(52536014)(7416002)(2906002)(38100700002)(122000001)(15650500001)(33656002)(41300700001)(86362001)(38070700005)(478600001)(26005)(6506007)(7696005)(9686003)(966005)(71200400001)(82960400001)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E6J07tdHMn0vEzbUHvA4asoy13WxIYT6DIckje1tn4PA8fndCpOyNLpuhakZ?=
 =?us-ascii?Q?Xfmno5XWUpesf6Sf/LBsoVx/+quzmjQGisU0eKvlF0axXskmYYB2evXugW6R?=
 =?us-ascii?Q?cOq4XnuhXa4Ed8rd0kR71QY8Y7MF0ouqntHm96qsbgkpycaLtJUQaEu334K2?=
 =?us-ascii?Q?pT5CtQpo7INTzGzyhoNWRvdQRUz3mieidcknYDNQcNPDtxQdVrVLoD0fzC08?=
 =?us-ascii?Q?T+tzmzk2RsUEsrnxcL96g6AxT3BnVG2U/SvTbVRienb0bQ0I/+lRIch8HvA6?=
 =?us-ascii?Q?3Tfuk/N+JFd2E4SU3hzd6GpDLq+Bglcv+mZnYKkUTJY/pCvXjHgHuJ3kjdG0?=
 =?us-ascii?Q?7st4Sz5tYCalMFhHz6lgmOxaZaiDA0PPBqEgZFFVGAO91YF/WCjWTU7EmC3o?=
 =?us-ascii?Q?F5Q+5cozwug2QkVogoLMBfmUMmL24Dchk9ElYuI1qzYUqNPL0CTTAaWSyndx?=
 =?us-ascii?Q?nP6EX1IRIOnxgBIZDvnryjDbRszdwa/jvUdPpTI8gTq7ZKCPp/9KYnLZPmvQ?=
 =?us-ascii?Q?EFnmZ1SJKjpk4+XTSy6hOOctrkFFnTO0RD+g0laj6lAaI88WSeGhMuOZ9NRn?=
 =?us-ascii?Q?bIl6XqiGn3EsoOhp6yBBtV5+Pdhql2tUPDA87kpir2/ssdhXZ/E5SnPPh+nN?=
 =?us-ascii?Q?DtUPe1oV6ZCn17jHBWE3OhGoyeYACSozbVDmkvLpwnfV43J4QmDJh1fGC2yN?=
 =?us-ascii?Q?X1UR2EwOVYoeWk6exdp+TMrfd/VDN+4tl4HmFCVesisGKeQduEx1yEmgoBHy?=
 =?us-ascii?Q?760YxiuXJU7MsYeUn1RMBlHWzvMVAIkA/GQy3iktLycnWel17HXWshGPhbIC?=
 =?us-ascii?Q?CcKri9E71Jeg1fMSRKd221Boc0keAyUM9sJzx8msV/YZKNwJh0/MZZK5VAms?=
 =?us-ascii?Q?eFVyap3SBi+4HVImxSq1OZ6QrnzEfphg3JcHOeTruaswpXVB0hbukIPi43eb?=
 =?us-ascii?Q?BZ+QAnCrMQ/cFJ9HVPC14F1gxGMMBwAZJliOpSZhrjWCbWEk3pk35yfyosOa?=
 =?us-ascii?Q?ctsseN2AQ3C6dDX5U6Bwmjt4PXouLpKMxSAb4XHndQWlQK9CQoY9bDgQPbAR?=
 =?us-ascii?Q?FLLVz3+9iNnrOKYM6TlOVf7/v2PI/smpx9QT552PqkXDJS8iu76NlGkY5MW4?=
 =?us-ascii?Q?o2UcasIdcewXjaLORSmDrmxNgnsGdwr6Xz29IvSarvhjOxrBM+p/+nvMuI4Q?=
 =?us-ascii?Q?mqhK+o4olfD7KW88AAwQR2A+1aqoLV4VcGaqvIHQ8CskleMuHlKJSRhTk4Qi?=
 =?us-ascii?Q?oLt/DzyPER3QMcB6e6quQzYyPPcTJcp1XmeTsCs0FNu+iGdEYmxnMFY8DofR?=
 =?us-ascii?Q?UoUv0fVM44C+NKTRB/8TjbcN7s8eCx+WyqSI23kHe9o/yPzn4YIa/QnS68HH?=
 =?us-ascii?Q?5VdBfwgM2hbRHd3wc+10P7l3a5tzCN4MXdzxxvTSv22zVi4DhdVzL5AzjFW0?=
 =?us-ascii?Q?mjLGyj6JzVUuch90Cay5J+zwQ1P42Y3qS/s2gQGxJ2cGPAEDHKxDvjfDeb/T?=
 =?us-ascii?Q?Azdf84XUZZr7J+buUTFgw7pcUocMTR0zeKpu6xhBTmhMGe0adMG0VyLyv5SH?=
 =?us-ascii?Q?fj76oSMq1V7byCbtPmgb82N8VCPJ3t/e6QgpfLix?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b066ef-b246-486a-18ae-08da7b3ce366
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 01:57:46.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClfLLG7juH6SNAF6xfYQuXik++42j/WicOq5wNhL7+xWBAKuSzdIAZpAwI4EcxSMAcGfedL8OCU1kV2cl1SqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 10, 2022 at 10:17:31AM +0000, Huang, Kai wrote:
> > On Tue, 2022-08-02 at 14:21 +1200, Kai Huang wrote:
> > > >
> > > > Tested-by: Haitao Huang <haitao.huang@intel.com>
> > > >
> > > > Thanks
> > > > Haitao
> > >
> > > Hi Haitao,
> > >
> > > Could you also help to test in a VM?
> > >
> > > You will also need below patch in order to use EDECCSSA in the guest:
> > >
> > > https://lore.kernel.org/lkml/20220727115442.464380-1-kai.huang@intel
> > > .com/
> > >
> > > When you create the VM, please use -cpu host.
> > >
> >
> > Hi Haitao,
> >
> > Do you have any update?
> >
> > If it's not easy for you to verify in VM, could you let me know how to
> > set up the testing machine so I can have a try?
>=20
> I can give ack for this, given that it is so obvious:
>=20
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> Would give reviewed-by if there was ucode update available, and I could t=
est
> this.
>=20

I don't know whether there's ucode update available.  Maybe Haitao has more=
 information.

I talked to Haitao and I'll try to verify this in a VM.

Thanks,
-Kai
