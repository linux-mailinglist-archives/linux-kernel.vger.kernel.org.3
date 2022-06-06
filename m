Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E653ED29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiFFRri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiFFRrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:47:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A26152;
        Mon,  6 Jun 2022 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654537654; x=1686073654;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tWtxKYp2pKtXYKgQgAB/j2A+wUeneBEqOgM6tjwAhA4=;
  b=lLZ/R2GTaLHg2bn7rFnccNSvOjbCL48lmeJ8zvQNAuiB6gVNEEDRk/k5
   6PWlaULX3JcrQSn+flxPJ+cdrUdgA5qk2DgW5davhHW7OMYOrtn5XmTys
   16HYkVrpPcqD9uxjaMTtabxCiF0CjzCxK5Eyl/Q9YKBS3cLsPfUXdzvPw
   AHHwCr0uqjTyL8FEQUHU2kQ8xu3egCv7+7ff9r907z6nAiDUQ0n1LYBKC
   usLQ+ELmLlvY59BrhnvS4b1Ou2ORX7IXwr0ggJMOZV7JlfSpsck6QUZNW
   JMatgRbnC2NkFm5dt0yTUwgZ2TqQVzXQMdi5rHp6kVO9F5GM+Epj5G8iu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="363020214"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="363020214"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 10:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="825942511"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2022 10:47:33 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 6 Jun 2022 10:47:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 6 Jun 2022 10:47:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 6 Jun 2022 10:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJZRl7Wkl6tRr4zbf8Vc6gfV+sfsMIl3dvEDvyNOFgm3Vz+pzYv3YJ7tcJsxUgOrgvloWFunjNOUiNfhrJWYU2vuOFdOe8kDoE38oKY3MVn50OdapP9NqxSSPX8O5sMYdbWB1SUGdLrchL58R2N4+vKtmDMcxQEbYD8AF7SGh7L0A5GhU8rKKoeqfj0OSv8/DvUbSw9JOYqAccqsY2hW3uomgMEJIi0iKlWnfL+L/sRSRBYrGiFW9QAhAdfrleHfG9TrvocO3V7yE2LjfswQhCd6NuQGldCFVpfgNwj785gbBJxoyWzBYSC2VbMIiU5UMet10L/kQ+UlzxDNtyRcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyqWa/co4eu9ejA7tPayKirGDoqflccXVM1DSP5ERk0=;
 b=d6c4Owbi+Z6A0v9jE0FDLllKyOh7g5/mNQa4kNYQqJv5Hv/mJCxBfSjHJdBUINoXYrWVKKuRi4stEEu4c1D/bb21Wj1y6NGxqTz13+rp+ELDzz93qEc4n55ifJmHfz9bX3vtABk553f1xmdPVZxxk479vLTwPTtSNUPfiQx4uRy2I/RwSfNq2h6vpvR7vgTTwYfmginG4mj4Svn/yWs/xEQlLR9Dpeoc5YeCT2+/Qrfc2Jr9wX/HSe78I5jD0H5UBTn7FFCereAUTWggBkEzHDkUt12hcU/MWXRxN9spg1doYgLqro7mngoEcXKVYujAPU5PRZ5c+s+zncYbJHEuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9)
 by BN6PR11MB1857.namprd11.prod.outlook.com (2603:10b6:404:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 6 Jun
 2022 17:47:30 +0000
Received: from IA1PR11MB6218.namprd11.prod.outlook.com
 ([fe80::d451:e933:b262:d77c]) by IA1PR11MB6218.namprd11.prod.outlook.com
 ([fe80::d451:e933:b262:d77c%8]) with mapi id 15.20.5293.013; Mon, 6 Jun 2022
 17:47:30 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHYJ9KPmrr71unh3EaZNB9EpLdxlqygNAOAgADN5wCAE5UmgIAAw7QAgA6SSICAf11jwA==
Date:   Mon, 6 Jun 2022 17:47:29 +0000
Message-ID: <IA1PR11MB62189024516D233482C4362FF1A29@IA1PR11MB6218.namprd11.prod.outlook.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-2-shruthi.sanil@intel.com>
 <YhVuJaf3AJ1c6TpT@robh.at.kernel.org> <YhYa3tlTEcLct2xu@smile.fi.intel.com>
 <CAL_JsqK_k49eKZ+Z+uw29GdY9KFVJL9o5xkzg=1=yF-oEt+JRg@mail.gmail.com>
 <YicsXm9JboW2b+5f@smile.fi.intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c05cb3e7-fed5-4d3e-e231-08da47e4a0de
x-ms-traffictypediagnostic: BN6PR11MB1857:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1857D8376004D60D9684C6D2F1A29@BN6PR11MB1857.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xraQsUDGEDmvFQqGs5iLsXc5FJOMVT0GmIV2NBKFMWxU8A6cy/WY/IXLSOp96KRhvzCh3gvN59H1pMqWNpuxZMVSJu/rEXe8/j9fYnV6F1yiBbCJxlbDg/jrbQ3qiC3Ti4loN+05lPuPeDl5Pk/t5MdFjB6I0aKUYCmYbLES7Aufkir5G/GTJAw1nyEjOQlNbJiyGWj8qpgSPQxh2y/fFoVDh2n+VirGH6DtWB8GG3qi33DiDRH4josavsUtv5MJLtZ3hNFRXjEn6mEBgEVbVB08+j7WTQuZZlbTlBT8/gqIktjB+1hsuh0bbDYSkApWsno55eKrtO7kOgChDLKAXWfm/slFq80ImUue/dfJ3vrDKHmw83ksIqVFWaHnKC0AIp2RCGCbOhAaQXOvgDPsLWvtbqXBUA+PF/vwyRcgeB1w4Waw+FntGq+5bB8UblR8OEy5CfkymmALNPTc2eDqmy8NJ+Atse+kI8eZ55waQhD7+ePm5/YUUyDYBBx9qx3tPmKXO1yP/1GK1xz2pmNeFlFg0pKYxkjO6PnebbA08u1juz67qmGBd22NGu74QiTAh2l+32XJ8CtCqNYlqDoZTDO3WLDJhlwb3Wv2mqLM8CLQy4JwSXqWvcZcVV1GgXcDSob1GT9PfHNAdWMemBCne7LsY2wepnGwFuhGRTf/3OYaUWYi+e53/IvJYG5fJ6pxWDXsk33CXIYO9qNgUfdabg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(84040400005)(66476007)(66446008)(64756008)(55016003)(54906003)(38070700005)(66556008)(66946007)(122000001)(38100700002)(4326008)(82960400001)(26005)(316002)(6506007)(86362001)(5660300002)(52536014)(8676002)(76116006)(7696005)(55236004)(53546011)(110136005)(186003)(9686003)(8936002)(33656002)(83380400001)(71200400001)(2906002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dWFa7A5hAWgDMLr8jK0AagrwIso9OYQdKrTQ5FQ1CNZiMY9X15omnxo1K0Ar?=
 =?us-ascii?Q?XPbS28VhnvkoaIVZUvhhOhfQ1sLaYDt5cFStQdjiUSPu3fen1AGi4byB7I2W?=
 =?us-ascii?Q?QustSR3ArGFb1Ic+kBpqnLJXjME+DbCX/nMDiXIpgDLIjvuL1ot1BReZro8B?=
 =?us-ascii?Q?lp7bhQrxQqVCY/QVpgE22PVZzwg+6lnjGP1pz8uBCNDbJ/TYde7fzXJwWXaS?=
 =?us-ascii?Q?JxzScn84xCzYfY31j9lIaVsCA7cAvQVmtTz9WB396LUry86OuOH0ikzmVmie?=
 =?us-ascii?Q?pUY5gOcASojGCtSbjFejW7mVnPb+3njy8LBlNEQwIHcuSWzIvn5CxJdMBF9Q?=
 =?us-ascii?Q?nbaHRb2z9++fHMO8uN/tQHKmSnUz3qY69Qu6MT9g1Z3cM47/+fxS+8b4aGbG?=
 =?us-ascii?Q?ixhHhR/05fCp1ZU92PXnOijKKEss7gQyEGo3Bur0whMzlAdtPN4uVUDk3/ne?=
 =?us-ascii?Q?opiryBTHaC08o+6W4lfY/d+oE/FsOUd68mprXEIDYiaZkH7I6Fub5JSPy8e9?=
 =?us-ascii?Q?63W3fYTx4S95OPsSj0U67kWQ0zkDtSx4qrNl/ZQJVmZeuWebb6Lpn9XRj5dc?=
 =?us-ascii?Q?/Mlb2jL7svPdxkIF2nxDFVJo6vt3r+fPrw8/cumBz8MNoQ4OYd9h+m3veZzo?=
 =?us-ascii?Q?nQqbzLaiWusjdEDMi6htun0CQq2FLsQsCdOS0l3N/gHgisEha/4+C3fLPMu8?=
 =?us-ascii?Q?MVN4D53tAddQG8Zz385MjwDimm08XNV2hqMebetQtZ6J6HjNrc9ub3h654TV?=
 =?us-ascii?Q?P1m5aT1xLjW8aH+0SRssxc8+GJhv+GrcHIM5UoFgJ9+o/Di+78tFIr21zip3?=
 =?us-ascii?Q?8bSdGEeizFTNRk4eBJ5GdWP1VGpce2cw2p4lDNwP3xQrn+tmFF5E69FBYUW1?=
 =?us-ascii?Q?CBo9x96MJnUs/d9ydCVpyTDgYIhW6avlRoM4RiOsn5m1UoEtXBemORKDCDt/?=
 =?us-ascii?Q?ESJh6G5r1dp8zYl4xYFPOexfsSAoN6LgAx+3lwD1SYELDekd/+NacpNCurHD?=
 =?us-ascii?Q?83zuN4w+WgG6hd2fSpkUv8FFXJcPY37HY8TXktmpsJpemNEgjX2kZAkZ1TvS?=
 =?us-ascii?Q?9Ztw/c7rm/I5f3XnEvgw+HX3ooVb2kUs1hsMeh/yJG+CUHPtG3z50CVu/NcL?=
 =?us-ascii?Q?c2PjLkWn/kvK5fGLUdmo2vxA/LkOWq01UJSu7F+3nX3M5u5fmcrS9G0EAAVL?=
 =?us-ascii?Q?pMyzePbKKnTpB0/FYI4K8BP/6qfAyUvlV92CJGOcLu+6GoQ0dDo8ODMpZPuE?=
 =?us-ascii?Q?c0DzLaodNxZZDCKadwMOWXK0ZEaYov0SRrfXwjg7RZTJN2W7OlXNBpKPiRJy?=
 =?us-ascii?Q?RhnxNclqpsi6pVDmItLixu5E0NcRn4qXHzgRy7nsTSZQAG7ttOQPGMsPQTc9?=
 =?us-ascii?Q?IoaNJnPfROpIucwrwt0nhQJJqckYVRcPq8qHKtmhw1vLyki8NTmIoO1QUqVL?=
 =?us-ascii?Q?wIiLFhCxXcCKrz/lKLu1GESyvBl8OWM7fPgNYp0bo7KEOFTEoPVfJ4Zt4wk7?=
 =?us-ascii?Q?R//DaYE05nAtILefLwKE7H+MbIwYnqNs/CpTXe5e+brp6hwBrpET1MlVgB3c?=
 =?us-ascii?Q?qJOI3zgw4TBHpGI/kq6h1WlDqacTcOYbPd66bikYd2MceWM3bECZ6W6EF+pY?=
 =?us-ascii?Q?cz7Sv/+LKFW8npDmCoJ2n5kHFgONEs0mfuzepJP74pM65W8+FgW7cLFFEL4k?=
 =?us-ascii?Q?HfNPL7bW+zsK+tfiMbNmzGO8Iz+jgbt+ADGwYOM4rmTbjcPlCHl4LXKR3Roe?=
 =?us-ascii?Q?aLX9BkYfbTGtvtTsqoOY3TOSQLHJqgE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6218.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05cb3e7-fed5-4d3e-e231-08da47e4a0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 17:47:30.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gs3mCFJVxkjXP3ks/sBMOFJEU5jRgdtX0RQqdW9e4I2Qzry1DkC4y5kOGK+ffJok1+jhCpnEiDvbh0H6ujPANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1857
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I tried to the technical manual that could be shared publicly, but couldn't=
 find one which had the timer IP details.
In the email below I have tried to answer your question. Could you please l=
et me know if I was able to answer your question?
Can we try to discuss and close it in the best possible way? Need your help=
 in taking this patch forward?

Regards,
Shruthi

> -----Original Message-----
> From: Sanil, Shruthi
> Sent: Friday, March 18, 2022 11:07 AM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Rob Herring
> <robh@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
> <tglx@linutronix.de>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Mark Gross <mgross@linux.intel.com>;
> Thokala, Srikanth <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi
> Bai <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar,
> Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: RE: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Tuesday, March 8, 2022 3:44 PM
> > To: Rob Herring <robh@kernel.org>
> > Cc: Sanil, Shruthi <shruthi.sanil@intel.com>; Daniel Lezcano
> > <daniel.lezcano@linaro.org>; Thomas Gleixner <tglx@linutronix.de>;
> > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org; Mark Gross
> > <mgross@linux.intel.com>; Thokala, Srikanth
> > <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> > <lakshmi.bai.raja.subramanian@intel.com>;
> > Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> > Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel
> > Keem Bay SoC Timer
> >
> > On Mon, Mar 07, 2022 at 04:33:23PM -0600, Rob Herring wrote:
> > > On Wed, Feb 23, 2022 at 5:31 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Tue, Feb 22, 2022 at 05:13:41PM -0600, Rob Herring wrote:
> > > > > On Tue, Feb 22, 2022 at 03:26:53PM +0530,
> > > > > shruthi.sanil@intel.com
> > wrote:
> > > > > > From: Shruthi Sanil <shruthi.sanil@intel.com>
> > > > > >
> > > > > > Add Device Tree bindings for the Timer IP, which can be used
> > > > > > as clocksource and clockevent device in the Intel Keem Bay SoC.
> > > >
> > > > ...
> > > >
> > > > > > +    soc {
> > > > > > +        #address-cells =3D <0x2>;
> > > > > > +        #size-cells =3D <0x2>;
> > > > > > +
> > > > > > +        gpt@20331000 {
> > > > > > +            compatible =3D "intel,keembay-gpt-creg",
> > > > > > + "simple-mfd";
> > > > >
> > > > > It looks like you are splitting things based on Linux
> > > > > implementation details. Does this h/w block have different
> > > > > combinations of timers and counters? If not, then you don't need
> > > > > the child nodes at all. There's plenty of h/w blocks that get
> > > > > used as both
> > a clocksource and clockevent.
> > > > >
> > > > > Maybe I already raised this, but assume I don't remember and
> > > > > this patch needs to address any questions I already asked.
> > > >
> > > > I dunno if I mentioned that hardware seems to have 5 or so devices
> > > > behind the block, so ideally it should be one device node that
> > > > represents the global register spaces and several children nodes.
> > >
> > > Is it 5 devices or 9 devices?
> >
> > 5 devices, one of which is a timer block out of 8 timers.
> > You may count them as 12 altogether.
> >
> > > > However, I am not familiar with the established practices in DT
> > > > world, but above seems to me the right thing to do since it
> > > > describes the hardware as is (without any linuxisms).
> > >
> > > The Linuxism in these cases defining 1 node per driver because
> > > that's what is convenient for automatic probing. That appears to be
> > > exactly the case here. The red flag is nodes with a compatible and
> > > nothing else. The next question is whether the sub-devices are
> > > blocks that will be assembled in varying combinations and
> > > quantities. If not, then not much point subdividing the h/w blocks.
> >
> > AFAIU the hardware architecture the amount of timers is dependent on
> > the IP synthesis configuration. On this platform it's 8, but it may be
> > 1 or 2, for example.
>=20
> Yes, the number of timers can vary between platforms.
> For eg., Intel Keem Bay SoC has 8 timers where as in Intel Thunder Bay So=
C
> has 6 timers.
>=20
> >
> > > There's also many cases of having multiple 'identical' timers and
> > > wanting to encode which timer gets assigned to clocksource vs.
> > > clockevent. But those 'identical' timers aren't if you care about
> > > which timer gets assigned where. I *think* that's not the case here
> > > unless you are trying to pick the timer for the clockevent by not
> > > defining the other timers.
> > >
> > > Without having a complete picture of what's in 'gpt-creg', I can't
> > > give better advice.
> >
> > I guess they need to share TRM, if possible, to show what this block is=
.
> >
>=20
> I would like to explain briefly about the Timer IP in the Keem Bay Soc.
> The Timers block contains 8 general purpose timers, a free running counte=
r.
> Each general purpose timer can generate an individual interrupt to the
> interrupt controller.
> The timer block consists of secure and non-secure timers. Hence there are
> secure and non-secure registers in separate address banks.
> The secure register bank consists of the common control register where th=
e
> timers and counters need to be enabled.
> From the driver we try to check if these bits are enabled to continue wit=
h the
> initialization of the driver.
> Hence we need to pass the base address of both the address banks to the
> driver from the DTB.
> The control register is common for both timer and counter. Hence we went
> for parent child module in DTB. 'gpt-creg' represents this control regist=
er.
>=20
> > --
> > With Best Regards,
> > Andy Shevchenko
> >

