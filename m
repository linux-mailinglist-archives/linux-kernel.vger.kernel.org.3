Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB004CBBB8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiCCKv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiCCKv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:51:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF23177D0F;
        Thu,  3 Mar 2022 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646304672; x=1677840672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ILCuRVdO4TZQFyRzNnLp1ndGyShq1ismiNx6wRXXB9I=;
  b=U/ZkhT/S0yv8+uKiKsiMPaMq/5tx1tpNdLMjhyDuWMQSoaBh008O9ny7
   hhfKTqMIcZQjTSVpVQvMH25XkgQE2gzSyGt/fQ9ywAPuoM8ijlhIbtgyu
   PioLc/8V95WMkshQtJec8zE0olcIXuFY3/4dVxrNW+lqyYdK1aoNDAMEb
   PrHzFVaMJLPcTmKMtz6EcbcJoOm97vaMRVC1vYSnaSIjKj9PDzy8UYqKM
   cZd3xDStjHGPzkkaDOx1w485Kj4HcUIKi307v2AtLfXbc2gETYtCanRT6
   CSXx9fB0clEiot3aQMqFb07BeTM8c2wzjgVwlMSLtztZc6PUeb/eSyIW1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="252468116"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="252468116"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 02:51:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="642073689"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2022 02:51:11 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 02:51:11 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 02:51:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 3 Mar 2022 02:51:10 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 3 Mar 2022 02:51:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBpravNalNpUZPI0rV+TqRn0ZwwkihslJ+kgY2DfxvecRh+pSRYihr2fWwMco7iwZB2arfvT5YgQMM9NO2KJWjgwH3Ji1chvW2Cz3eMtkokYfxGXINjx1epj68JDgV39v7P4c1dJD1hzdMYPgq+SlIW6a0FF+t0iBgeQdGA1jQtYh4dWRCEQMI80xYbbu6BpSJdcyez0kFHp5n9c3ChnAps3S97W2lqO/vuK7W1wvEEc3quDbGtlFWR9y1Vtvfo7Zkdo9vGprF86fFECieD4KUrBf048pShiHXnk/z0pWsKZSEZGiuqI1Fz8ACnlf2z+hCpa3KsG39RkWW2Hva9blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILCuRVdO4TZQFyRzNnLp1ndGyShq1ismiNx6wRXXB9I=;
 b=UFUxPJht3czTZ28sQia9iGi8lKx8+kPlXuaS9C4Caa0n8G/pHHeFsWUzUPdOFZXVNXtmYqsqX0lkYPJo1SAuqaElHMsrmwibXBU4iskfw+cX3nC+4B8sM3EnrxdseX2ZTRcLJf9Z2+u5CXY0lpSk3b0UKPgRwGPLi2awLm0bIdCp8ZUFeywmNAZ1ntH1qo19oTQhCL6reRM/92TRWshX9eVnoxq+eexmeJPHQ8nWFCLMotGfY74jA6zIjFdmH6edzdn2+K4Fb4fBSOlUx08hf7pHhQw/205b3FNHt7kclsYJkSaDj6Uv5FJ2kTAYC9uvktRcjctXHgqASjAsT2lHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) by
 DM8PR11MB5623.namprd11.prod.outlook.com (2603:10b6:8:25::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Thu, 3 Mar 2022 10:51:08 +0000
Received: from DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::d4c9:5841:3761:6945]) by DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::d4c9:5841:3761:6945%4]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 10:51:08 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHYJ9KVLj3sL+vmrk6q1BhORuJTLayrEYYAgADLt6CAABJ2AIAAXvPggAAGSICAAOWKwIAARa2AgAABJkCAAAdsgIAAAGsQ
Date:   Thu, 3 Mar 2022 10:51:08 +0000
Message-ID: <DM4PR11MB55495E9490D02D3E9A5A0640F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <23f86de0-3869-ee22-812d-ba610bac48b3@linaro.org>
 <BN9PR11MB55458A882EB4A681C4A63B26F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <3ff11b85-249f-2f47-cbc4-41d2ab6d168f@linaro.org>
 <DM4PR11MB554994532B3D128F85553C38F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
 <ce516de7-f1cf-c614-f9ff-439626dfafea@linaro.org>
 <DM4PR11MB5549B22251EDF0D6D5800932F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
 <YiCc7YzF2SQfzLST@smile.fi.intel.com>
In-Reply-To: <YiCc7YzF2SQfzLST@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd7a95d6-b83d-4dda-e2bf-08d9fd03b961
x-ms-traffictypediagnostic: DM8PR11MB5623:EE_
x-microsoft-antispam-prvs: <DM8PR11MB5623E9C8C760680378B4C35CF1049@DM8PR11MB5623.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p6YVz1v3MKE8w6vet/8DXYeEJUnJ8WeSEiU89G3HxbeNfkP4lywm21Ti3bybZwBAWVZBubCbV9Of+XUgZw1kWEIbEls0crJ/UoEFtrD3W0FH5zV0mH+pQgvt5dnseE9Ku6zwEdxDxOAwRbu/4hEmR4HfgKO/0c4NHgGEafTElaPTQ88esZDGH4WeLjoAjY14gwPD2UzEwiPFn85EiO5weQaKlFvElL9qlX5hy4asQnYjJuJNjB0F2ANxMG71iAQ3W+Vgio5S9SY9/uBqgLItZ3d+Z2Us3Fg0KoqrJFG3ftYeOkVvfnJ6RqUS2i96ZTGGRixOlbxSsCFDaJ1NX1vOAO01Z2tPglDZDuXK5EIq5K77/XcrqVb1y+NYiLcI88GBPkWKTF2NolUGQKhg0ZULUANxdYH89I7IT3xAW1dZesxxWy5MoQisc/4rabqyOT5BIuoGipvP74okZ4cUoiMSBqXNElkO4BjSRkmWAlf/Zif0tRzmQkMqUPW9ek9m+1M8wbsBSq1VvJjxfjwdYl4f63avxbWLYOjlz80m1BYLRWYjAgJgpdlO7qeibJ1AKaBVxr8dF0GzNjH5tgNsutOzNN9tAVJzNIjwqRw4QUyDd7oUwpNehms136e/yptM0ImwbJGcCdFcbaYG+eLZh3U3nt9XQS+HlTTaqz72+msM48+A/FNyp8Y//ZNV2WMqAlVOjSUa5Xks0pVaAZwhCjP7jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5549.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(2906002)(33656002)(4326008)(26005)(66476007)(8676002)(66556008)(64756008)(66446008)(5660300002)(66946007)(76116006)(38100700002)(38070700005)(55016003)(508600001)(82960400001)(52536014)(86362001)(8936002)(71200400001)(54906003)(83380400001)(316002)(53546011)(6916009)(186003)(9686003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NKdYc3/4RE6uea3ckpCP3dK1xhnXOiTxhwX3ASFlxmotgjBaqzgAIkj3VTPI?=
 =?us-ascii?Q?N+WrF0Q+iYhYFEx8e7Df9M8+6pSlSLtocpKWmx1/AZGclJlyLBWDX1DPO3jz?=
 =?us-ascii?Q?sNDzIliYIh4QRNjAQo0hFpkC442wN0sq92zBBMElp+AzAAJ+IzhS6uv7dtfs?=
 =?us-ascii?Q?+WtdOKD5A8pjmPIn6xcM4vcjUbFMcPiRgr5tgxqGVNJBzgzeOgVmHZSjtAJ/?=
 =?us-ascii?Q?CBQvDkDDWZNWfVZre3gANAZ8GvUt5fF95FQlwi0Iz5NshnDT9dGZ0bcMa9R6?=
 =?us-ascii?Q?F2KPeOo8PPX4ulqIJYDYaJT/lgvlAIOe4d33fbCaz59QNUQFRwPnkiHWkAyg?=
 =?us-ascii?Q?YceSNl+aSKz0PofsvvT8nYl1/nSsEnAAjH1lOW/ODa1z8qnpipK7OCvGkrrp?=
 =?us-ascii?Q?wkIJGdFIahDiF7dFATG+AuHGQqNGHG6hQiUG6TKNl3kX0gOui1Rl69h+ONnB?=
 =?us-ascii?Q?NI3aFBELVjnnAO3cg01uHdfDC4MOfBVyfd8ZpHR2bTINru0yKlC0UYLRxhDn?=
 =?us-ascii?Q?SYY/VSTXq6weNgM37gGvLEzo6JEpdS6MNc2cYeHVtyYnHU8AhqSJyPhMNPvp?=
 =?us-ascii?Q?DIB40hcMBXBgJesTGjni7JL1Tq7Ts9KkGe/OneJ4aWJNLZMt0qDlAIDF9zWA?=
 =?us-ascii?Q?AfE3Vu0VIqXI/TMdAg5bumWt/PuyEAeFAUjnZRfsiuMI9rdtqjn60t0WE4Qx?=
 =?us-ascii?Q?+UgbtX8NKLRkAB5RN1KOQ71lNWoQ9e/EtNu3sJlObXCbo8bqKPRa7X5QSNwR?=
 =?us-ascii?Q?Vxzg7sLrPIyKKuZRo4Q6C/YVP0IXr5wK4lEweNvuF7PWa7Z4Czm/pik8vtrk?=
 =?us-ascii?Q?8ApoNqQ6iguqNQPsxjJdYJn99fpM49tYVcGyw6RRyAgceqvUgvyRO+jBPMQr?=
 =?us-ascii?Q?j0Xafum+tw8CWLdyE2U1svArTARQMfEIK2bqMlyoAjQzMnLKQrPvKiygXY56?=
 =?us-ascii?Q?SrvCvFUMpkLRvKT63KIw6zTM4ee6G7tyZI3XpvybgRQrgORzYGL2ujskLrc5?=
 =?us-ascii?Q?3RRyj/GuEup7b/szzAQdzaU4rNrMKV4q5sne+MPk6PbJ7qTJYbI64KNn+12A?=
 =?us-ascii?Q?4tnY+FQRe0IjbfVeUTc+NxJ0GF1Oaa1DRzG8lhI4vZL3Zri4UjAxkgNrHSaj?=
 =?us-ascii?Q?xhHaIqdDmyQCXJrmVuO7hxpSMJplyYt4YSEvrxQOXrwKVnbhrmAImYvM9xQj?=
 =?us-ascii?Q?UEppvaGa6xrLJ3LmttQkh0SVMldq+TDcNsHaxgtVllD7nK0VzzecSjQTJuAF?=
 =?us-ascii?Q?wXAb2EAhYBp3NwGd1eQ9xzRThXkdqH1SR7vCQotI9ulllrsRfcbBXTYbW03/?=
 =?us-ascii?Q?UguvfLH9+hX9sh99EVbeY99p5VcLi20lFsSdBooZsGKUVvblmfTZ0DGiFcUm?=
 =?us-ascii?Q?VVmLyGdMU9qp5vJGglx74G+vALcjgXl2prBfi/IRm02e8pwwhZszv/KKq812?=
 =?us-ascii?Q?yRokrhmXdEWBTXlbzRd3nuiEAPjdz9kXgf/k+YtxT1etKpKVsYeOrMoVyDBn?=
 =?us-ascii?Q?L8r+WG1PNvq0SGRMUFlVGesGKygMVeQM672dRDNo80DFJL8uy2usyLYZoC4m?=
 =?us-ascii?Q?FvtMjcOQpv6VzigJSuFU1OhxR0LsoCIyz5DO3MJt9FtV/o4FtU/63fQiygXJ?=
 =?us-ascii?Q?2FNRGDc6piKGEfSp4ysb3JY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5549.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7a95d6-b83d-4dda-e2bf-08d9fd03b961
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 10:51:08.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkwtU9SmNzD/DkgTkjkONkTkaAIbIv2ugWlZPYRaRZcKcC+aScaJU2/8hUd0eA3CK9Bmxd9E474QiqDwHyvyiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5623
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: andriy.shevchenko@linux.intel.com
> <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, March 3, 2022 4:18 PM
> To: Sanil, Shruthi <shruthi.sanil@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>; tglx@linutronix.de;
> robh+dt@kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; mgross@linux.intel.com; Thokala, Srikanth
> <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
>=20
> On Thu, Mar 03, 2022 at 10:23:43AM +0000, Sanil, Shruthi wrote:
> > > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Sent: Thursday, March 3, 2022 3:48 PM On 03/03/2022 07:18, Sanil,
> > > Shruthi wrote:
>=20
> ...
>=20
> > > So if the description is in the DT but the prescaler bit is not
> > > enabled then the firmware is buggy, IIUC. Yeah, this check would
> > > help, may be add more
> > Yes, right. It would mean the FW is buggy.
>=20
> Make use of FW_BUG prefix instead of "Firmware" in the message.

Sure. I'll update accordingly.

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

