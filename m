Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9B64C0D99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbiBWHuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiBWHuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:50:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786366D1B5;
        Tue, 22 Feb 2022 23:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645602575; x=1677138575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DPlWjEHtPMywb187ypo9aV+TYStHD4XiqgIjfiICyeA=;
  b=XxrQQIiHqVIMU0igJ+5WNgsLBPbgVu29H07DSYl9UQhUJ9h/vWVyFeMI
   zNEdTRar8iYXklZjEoew7xVJG+Jv7zEqEOxhohjhsplgVn0J9blsyx5PR
   0xA14cM1A7yO2gzgQMsDr4RRMsZYcB+35HQS5RO7Vbn8Vt7Ft8DAZZacX
   Y5utwzd8i27zWDDa2NFq1VdcvRlKYBYFK7+282umIODOWTtIFCDfB4gEV
   FjaZ0tmoKFAi/rwuuZfksZ1vx16zL6JEpuLWU5fJbUJhbZ1KMqYhS2lw5
   y0gF+kwGamfS9w5O8fRP6xafFTXE+qJCFRDQfS5MYJrVJhoN7VXJgqVuP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231879966"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="231879966"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 23:49:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="491099055"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2022 23:49:33 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 23:49:32 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 22 Feb 2022 23:49:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 22 Feb 2022 23:49:32 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 22 Feb 2022 23:49:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfOCaH/wwGbzRd4fOaMBeFEeTstVBZHDKXajuTkSQbiURmkXPRR0WGFWhbU4TJuguxy5PpAy3dkoASfh7mEAkdI6NKLusD8OBYH73H1g4LDTA6B9LCxwxDYt0tktQn9sbOth/eRP4tWBKFpoMbSv3EobB4sE45nYRpShuJObKxG8M3reiEstfk4T0rgPXESNYs/vQhvmFB0rdfnsJQyGQGlJgZo1cvvH63v/sCYzLDVBUAD+KDQe3kIZnRNqoOz1j5Kc+I5V1ehuP68o/j972rzt8Fm64J3KtfUQc5yJYKDaoAwxbm7RW8A+MXQUPQA8nEYCVNVia1AFm3tiEPjOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaJCMK4zBGlT7U/PG81Q/5ohH9vmTCRAabJ/hB1OKgo=;
 b=Na+fYEkN5KnO2jCtAdfv9gi+97wnK0V9YcwsOAaD5cV1rUwvYIJXL/qoZCpeokKY39GGS2pchz1Opi1RfLPoqfXjTPuAzZJJkW/g61fyyqPactx2wGPq5BTowGHlV5NfyqMoHPYhMem3xYc0fqEGvps2/M87IEKVMLKPJFevygawWQnYg2OP49SJG9iErmpO9whBQlpJSabPXzhNgYhfyLVsKYHJi5VlBCcSjBQhcx0VHIqvAYfMnuyDIrSM95Lq//7mdb86B65iDXcYk4IKOIyGD28wHOpTBxzDKfDlASMZFnhcV342ju6Vypgj8kV59DbGo4DZiJ2NWzmokZQwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by MN2PR11MB3982.namprd11.prod.outlook.com (2603:10b6:208:13b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 07:49:30 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::f047:13:ac5e:a04a]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::f047:13:ac5e:a04a%7]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 07:49:30 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHYJ9KPmrr71unh3EaZNB9EpLdxlqygNAOAgABgK7A=
Date:   Wed, 23 Feb 2022 07:49:30 +0000
Message-ID: <BN9PR11MB55451837FE620E72AD94A605F13C9@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-2-shruthi.sanil@intel.com>
 <YhVuJaf3AJ1c6TpT@robh.at.kernel.org>
In-Reply-To: <YhVuJaf3AJ1c6TpT@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6bdccab-a4e2-4a41-f42d-08d9f6a10667
x-ms-traffictypediagnostic: MN2PR11MB3982:EE_
x-microsoft-antispam-prvs: <MN2PR11MB398281CC010C45FF6D57B352F13C9@MN2PR11MB3982.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITnNxTe+6CYI94G7nN14NkHE4kj1fJzvNcEna3ZCpPpgHTjHhlJetpe6UBGRNCbVWWHIj96fCi4Xsm7IR0uG6kNGmf6z3OHzqmgyr29aer2teWuSQBPyP91CUUAvpCnUA7KNVZF5JkUi2jet63K8K3eoWpLyfS2jqJPny01kXya7GFJzGonXwBsc+IH7A//SoSr5guEqiIdndP/5x9cgTTYfmjj+PA8EJL+uiDDkYNRRZ7KgmJVCf+FIHmdZl4PTBdXTierjzPZaEv0gFFPP+JOmKdXLQ/FZGva0RCjJlvDHCW+XqfVtPtDcfCqc3fK0lz23Pr0fu3o0KV64P+sZ7G+uWjbYHhMlZqM3s27zBigGCWHvrbHLch5m2cHCqJSr3dmElwgy3WjhK6JhEmy07M49EXp6SIXAwOFhUb3YQiKkD/5GV6kKBOOwpYgo3MgdhVqFEYdGp+eXkTrC891Pc0RHX90pVsnoky4VuhoMxwcsUjTc40+xcDLjl0h+uHKf5uCKsM353mSjQHejjGgpVJHziHIvlgzNpTnAYMJCE75u0QbBtOpmGYFjnq+GU0kUTOpU5HopVbXFwy/DlK/RtEWjikfioJh92kooZnt2P6sMZ4vzx8fKNNH164sCfhd7zn1kvJYMJH5KxxHlQzJk74fuarQQQNqRGaiH+QftYniXFZ5t78LJAdzS3d/b8lZwyatOd8LKEXfjklqh6yPxbmgkFEfHIdYi03r3Mzh3LuQpeYY4MYTWqCQHxd62EVNCqib1NpKwOvbO71OltzJJqOoLXHZOlBo3n3b0InaZypXfS9EQ/S5G/CBgF9Oq8C+sVTnat02GiL8CoIQF4wl7gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66446008)(966005)(64756008)(66946007)(66556008)(83380400001)(8676002)(508600001)(6916009)(54906003)(316002)(76116006)(55016003)(66476007)(52536014)(33656002)(9686003)(8936002)(5660300002)(71200400001)(38070700005)(82960400001)(122000001)(86362001)(2906002)(186003)(26005)(6506007)(7696005)(38100700002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3DOtn9VbkRwQuqBGLFhAdvKp89aqR2jU90MMOtNoPrYtM3XcXg6fszUt5pHx?=
 =?us-ascii?Q?YSNlAmY2gUg0wIkdSize/uTPLAYfpot8TeE9Ld6m7LsD0fPWfrWKJ6AqPxsm?=
 =?us-ascii?Q?/+7sq3Ame/VuF3D8kTLtfMlAPfgUkAUqSgbDUGc74/0UvdpHU15KIAd0eCUn?=
 =?us-ascii?Q?nPsrGcL9+1xKYv3k/FxprM/3KId0pMZ1P/toW8WwBaryqKDsOWy82hq179HV?=
 =?us-ascii?Q?yH3r1HQClNwqay2D4awU9E0Slp+UEsScEQ0xPyV/J4oG22bs4ujgrFy6jQR0?=
 =?us-ascii?Q?5vyi7AWKIPqGneGFTmR3IhYTKvEC1alOKsFLDMw3d7D4UjxBWP/LC9eUKOrf?=
 =?us-ascii?Q?6aymfgkq01HhQGWLacWp8ZoulokEjW2jA8Ek109Kv4XHcKfKdVFVEsqXRpD7?=
 =?us-ascii?Q?SqykEn6Aua247vY6AeEXgvvKIxF+n7QYb1LkHcOyaZIDu+mKCM6el1V7VEZf?=
 =?us-ascii?Q?PQp8wafJXajxhPaRivDZSeWwR0xEXR+pmeaGNH9KUbP/RW1f1Het4xZE8UNv?=
 =?us-ascii?Q?8BGkiI+LoMdYL+RcGHu/JR6WYVjeinh23FL7xO2JUaCl614N/d5Q1YHqae1X?=
 =?us-ascii?Q?cP6X9i585gJdBbqv2+5abarbJ5NLwHI22O+0nTB/YpYGO8V3d4YIkJ8V1+6Z?=
 =?us-ascii?Q?N4w+Nls86Vr+5exaXLL429Ha1hj7+QIDnr1lbVVrYqxAqjSWhYEHN9dfEkGU?=
 =?us-ascii?Q?9KRIdvrMrH80Cgcbo76hT/TuKFm8jQQm6oXkqybgBKPGzD1uMrNkojDB2/Da?=
 =?us-ascii?Q?rkgNEcvS9T3dU7ynGpd2sA2eOHbj+urQHJLXmqt2WT2qoNAMyc3PGeotOnMG?=
 =?us-ascii?Q?5zQZSySMyQtpJYdVIEA0yS33sQh9BwUNHKstpjRx0tgWKcAoEjOoeYsniiJv?=
 =?us-ascii?Q?emkz42j3SVPvtbiY21OfCYc+VYZbGIKNpJ7yaZIRjw4DKrHmDzRSljDNA14A?=
 =?us-ascii?Q?W2HwyyJkHwD2JUJhJIodkhEn7am8eRxcO1qHDAuFM5BZSOccZXtOsp46KyHR?=
 =?us-ascii?Q?t4pNxDYqGVSmGqCuInCI/aQIVJqbq9SghvhMJkEGCYPGZN6vR8s4gIuUxF2M?=
 =?us-ascii?Q?mTKIs58tbox2OpFP8+wXGLkJpC2BZArXY3miPxGCsyLV9nH0/p/Pz/a84ErK?=
 =?us-ascii?Q?nZlceGNFyahD1vGIZ5CkVpzE/4myUtv9ge5STwbEMU8kfYhATdWPKxvT4Aml?=
 =?us-ascii?Q?FzUfsMj9B+CaS/vTsEe7vaqNCST3XbDXsDYO8Te9uEGe/cis3WmJaY89Dxin?=
 =?us-ascii?Q?emWpLxGRhiZNx9KEedYIYJ8o4+BkG9oyZhe9jyMh5+UCn7BcV3MfFNSOE7pn?=
 =?us-ascii?Q?uEm7wPwFnGq0GEXQ6ZBeXXt/I2Ukdt4mhItKl6ahsxc904j7AW3poqA4KAuH?=
 =?us-ascii?Q?Vfmut41KnoGz/33XuToU0bhem4o3MVEzVBY/DjwuuGlEjPnZkL3XKsd67r3f?=
 =?us-ascii?Q?rLd40sClf21vIHA16Eouqu1IlRMYxi1P6d8HofESXBXyeAeDVau2LP+pRRw1?=
 =?us-ascii?Q?2hiQI6kqhz192MXOBWMQopMMGMVZS4ILsOqRqIk1p7IY0xuOIbmfLLsZsuXk?=
 =?us-ascii?Q?m7iZDM4Ij5jModIWh0euHjYfa6xFw14MO86BE0v8pG1bB9PTfEgmpdPryKii?=
 =?us-ascii?Q?50dL92ZmO819YsJMnIrPAl4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bdccab-a4e2-4a41-f42d-08d9f6a10667
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 07:49:30.6497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmQLMXY95GjonJSnRt8pZog+AHJkMMzRJO6Vxpe5iH13x5eQ/luLJMfUkkhN7f0VlmH535YkeY38fsL5x8mzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3982
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, February 23, 2022 4:44 AM
> To: Sanil, Shruthi <shruthi.sanil@intel.com>
> Cc: daniel.lezcano@linaro.org; tglx@linutronix.de; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Thokala,
> Srikanth <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> On Tue, Feb 22, 2022 at 03:26:53PM +0530, shruthi.sanil@intel.com wrote:
> > From: Shruthi Sanil <shruthi.sanil@intel.com>
> >
> > Add Device Tree bindings for the Timer IP, which can be used as
> > clocksource and clockevent device in the Intel Keem Bay SoC.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> > ---
> >  .../bindings/timer/intel,keembay-timer.yaml   | 128 ++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > new file mode 100644
> > index 000000000000..9e6d46ecc2dc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/intel,keembay-
> timer.yaml
> > @@ -0,0 +1,128 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/intel,keembay-timer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Intel Keem Bay SoC Timers
> > +
> > +maintainers:
> > +  - Shruthi Sanil <shruthi.sanil@intel.com>
> > +
> > +description: |
> > +  The Intel Keem Bay timer driver supports 1 free running counter and =
8
> timers.
>=20
> Bindings describe the h/w, not what drivers support.

Sorry for adding the word driver here.
Actually the Keem Bay timer IP has 1 free running counter and 8 timers.
I'll correct the description explaining clearly that the above are the H/W =
details.

>=20
> > +  Each timer is capable of generating inividual interrupt.
> > +  Both the features are enabled through the timer general config regis=
ter.
> > +
> > +  The parent node represents the common general configuration details
> > + and  the child nodes represents the counter and timers.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
>=20
> Don't need oneOf with only 1 entry.

OK, I'll correct it in my next patch.

>=20
> > +          - enum:
> > +              - intel,keembay-gpt-creg
> > +          - const: simple-mfd
> > +
> > +  reg:
> > +    description: General configuration register address and length.
> > +    maxItems: 1
> > +
> > +  ranges: true
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ranges
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +patternProperties:
> > +  "^counter@[0-9a-f]+$":
> > +    description: Properties for Intel Keem Bay counter.
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        oneOf:
>=20
> Don't need oneOf.

OK, I'll correct it in my next patch.

>=20
> > +          - items:
> > +              - enum:
> > +                  - intel,keembay-counter
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - clocks
> > +
> > +  "^timer@[0-9a-f]+$":
> > +    description: Properties for Intel Keem Bay timer
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        oneOf:
> > +          - items:
> > +              - enum:
> > +                  - intel,keembay-timer
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - interrupts
> > +      - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #define KEEM_BAY_A53_TIM
> > +
> > +    soc {
> > +        #address-cells =3D <0x2>;
> > +        #size-cells =3D <0x2>;
> > +
> > +        gpt@20331000 {
> > +            compatible =3D "intel,keembay-gpt-creg", "simple-mfd";
>=20
> It looks like you are splitting things based on Linux implementation deta=
ils.
> Does this h/w block have different combinations of timers and counters? I=
f
> not, then you don't need the child nodes at all. There's plenty of h/w bl=
ocks
> that get used as both a clocksource and clockevent.
>=20

Yes, the Timer H/W block has 1 free running counter and 8 timers.
These timers and counter are enabled using a common configuration register.
Hence we have a parent node which has the details of this common configurat=
ion register
And the child nodes with their register and interrupt details.

> Maybe I already raised this, but assume I don't remember and this patch
> needs to address any questions I already asked.

All the review comments given by you in the series of this patch are addres=
sed.

In the example below, I have just added the details of one timer.
But in actual we have a total of 8 timers.
I can update all the 8 if that's required to be updated.

>=20
> > +            reg =3D <0x0 0x20331000 0x0 0xc>;
> > +            ranges =3D <0x0 0x0 0x20330000 0xF0>;
> > +            #address-cells =3D <0x1>;
> > +            #size-cells =3D <0x1>;
> > +
> > +            counter@e8 {
> > +                compatible =3D "intel,keembay-counter";
> > +                reg =3D <0xe8 0x8>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@30 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x30 0xc>;
> > +                interrupts =3D <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > --
> > 2.17.1
> >
> >
