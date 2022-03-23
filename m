Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560DA4E582F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiCWSMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbiCWSMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:12:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4408588B16;
        Wed, 23 Mar 2022 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648059068; x=1679595068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+hmqFnwcyyDJ/R9wOvuyKsLgiqKZ2Ehot73ustUyDKY=;
  b=n0PEU2Ym+zx4ipkgr0SyL0s0BbPLNfQqZzR+2yvXz02ToYjgtuZNC1gH
   wt0Ajy5ZkbZp8dS4muDWG9Ee5b4G3k6sYylovcoHY2qJSg7m9mZ4+DTuw
   usX1gDpUWNYNtzGevgLIoW2ktWilYD5wz5nU6NuFrYPEIaDV+4vUtmNmd
   pqLMjD2VCOg4edO4PgUxhoFFHLQt3NWuAUh7r32jWUh2HqYu+po/HUrjV
   yf78nYm3YfYMAxUm4aOdpPgYDC5dXkVwcmhOpa6bcDymFuU8VIb09mjy0
   hrBiBJ82+4PQkBgJYrdDYz0+fwB7UHAE+nV19MSOTU3o3S66DD/GGB4zy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="257018620"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="257018620"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 11:11:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="601405939"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 23 Mar 2022 11:11:07 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 11:11:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 11:11:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Mar 2022 11:11:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 23 Mar 2022 11:11:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPS/hPi6gwskZBZ6Bg9TpyhNnjvur1KWHMTCnEZkp4c6fQpDivG+Nr20h3SCBPSDhWLc3wh9CKPT5+zy1GxK+M12n5gNIICW91mH7OGaxvOb1+zpBnzBGJ9VWxcPn65cExPr7jK4qKiL7NeDQNW8l91T55e0MVqklshd6SbR1b2OqMbToKYiBAKnl77gXWS4E2OhOTrSKq++is25ISm84/IduMIh8K0FCzYcpQufTXxSeQMKUdLm8P118BXu2v/ycKaqf3MriV8+zVjvFth34sBF2dXcD2ZbTkyzq7XZiaco3mE+W4PRIenPJK6tQh7j7H2YAKnmMQEREp+pDFY/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTL3EHGAEfRZdqcB+Dl781LoRCQAbSboC3eoNEM0nHo=;
 b=Ccr05VMm9l8oLxWdiEHvX4XBM7HLEO9luaFhF0Af+63M/sjgiuYi+NYOfFLoXpIuGMqZpJcfl1e48PQsF3tFnL0Y2SU3reXVguBtb7G0zsXgt0Wr7X6FlbmzDRytEDiz5rX1+twG7p0lw+KnCwU+9ICJdmbXKez4WO8vQ+vVt2okCR8mR3aU6bALWzgSBMXaLQ4H3YhgAjcVxrx9jH6LmIs4ShWNevGWlNkBugIDFWWsmhCUBCNOcOJuP1y6VADWbDc2UvwkaapDUx9lwTd/7LMJPJi9gxKRyv1YiuWq8dC9u7r6x4/AVJNzss8EXqzQU7lWzONE3ZAt2BaKWO+7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MW5PR11MB5884.namprd11.prod.outlook.com (2603:10b6:303:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Wed, 23 Mar
 2022 18:11:03 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::fdae:50ef:a0cd:b1c9]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::fdae:50ef:a0cd:b1c9%7]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 18:11:03 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "bleung@google.com" <bleung@google.com>
CC:     "Malani, Prashant" <pmalani@google.com>,
        "jthies@google.com" <jthies@google.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] USB4/TBT device routers should wake up during S0ix when
 something gets connected/disconnected or a DP monitor gets plugged in
Thread-Topic: [PATCH] USB4/TBT device routers should wake up during S0ix when
 something gets connected/disconnected or a DP monitor gets plugged in
Thread-Index: AQHYPqA9gj/nefPhe0uZrTXrK6euOKzMw0/AgAABjICAAH6bkA==
Date:   Wed, 23 Mar 2022 18:11:03 +0000
Message-ID: <CO1PR11MB483543E01BD68B353CDD2DAA96189@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20220323101818.3503-1-rajat.khandelwal@intel.com>
 <CO1PR11MB48357FE72D34818360D2105E96189@CO1PR11MB4835.namprd11.prod.outlook.com>
 <Yjr21UzWmj4NjItA@lahna>
In-Reply-To: <Yjr21UzWmj4NjItA@lahna>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: bleung@google.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b715ae66-99a7-4b4a-dfbc-08da0cf87e4a
x-ms-traffictypediagnostic: MW5PR11MB5884:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW5PR11MB588466A150D0F784015EC30596189@MW5PR11MB5884.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFUeh7VDWFZ/YpVk3xIiKwMwYnFpjkkaON88uPZBtn9FPUu44nePILVLSOMgbb/RKUscTIAnvQ4qJjZhP0xutmJnnMmNAfhBxnID3Ljd9jkHj5klFBh3zsN4wkktpxQIzLKS6vzL0sDDuPV0Wmmpo4nb0Z30nortZ3Ii2gPJI/DCt7hvaOqXtLBSbKJwH1YvbL3puCzBC8R2iwkQR0RbwcWVQYlhvJh82cJdaFBzki/bKSoGLdUeR9vvwmHp7s5BJrnihLznGZ81jRiVjlua3uvvV3txlTEM2xmca/Zetnf2ZCmTYlEYRlPgOIgNKH8OAK2vYR6xoEAQwslIWXrXSU2B95JHygFw2JIlEbu8Rlz/s4y9Nz7lXIX4TPJd1DTemWEfFEJ3666EKMqz3Ks7oTRGBZLHDD/OL+I6IJaM8aY72k4V5CBxz3bVzufQQFuA2OYtCc2jjESmfA3fCBu6GWDHOjjqkzaQhfPPReFEKMH4yPTzgI7Q4T/3kjCcSuhsNHz7EnSmalbomsn8F+xp/tpDVr4VRAy4y7N49bZyRQwt0O8UP9hlFjJl9psWGpbS87Y/CtaRgtrxENcnanJTz88NZgMZjV5Gaa83nxnR8qVjzV1zRzukukaRu1rVB89aE/JYq10TXbEX+9zggMnv23Q5L93jBGBSiF8C3CV3B3PM+YsfnyLfCx3tju7kKC+MKjdVzvjcIBddUrrnk3ru9sFXYForfMnuuD9we00LxxY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(4326008)(66574015)(8936002)(186003)(66556008)(508600001)(66446008)(66476007)(64756008)(66946007)(86362001)(76116006)(8676002)(83380400001)(52536014)(2906002)(38070700005)(55016003)(5660300002)(33656002)(53546011)(316002)(71200400001)(9686003)(6506007)(7696005)(122000001)(54906003)(110136005)(82960400001)(38100700002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y457hpKOmsSJGtPO/WszKwluvUsCIw4F5uI+65QphQAGB4g8Dpjxex2xb6xZ?=
 =?us-ascii?Q?TLAWEUAS1vgzL0KvlW8WJNwcPpVSVA6g6cSiPJVQTLDrbmKfgmgjcFbMwtwI?=
 =?us-ascii?Q?UCAuAQir6ZqNuJTD5Cl6hqggwunaC1TeaoeFivHXLoakHpMULH1BZF/4C3gd?=
 =?us-ascii?Q?6f6SohPK8szuESrFX0dS07OUW1TrBV0D2KUuLZukLNRIgVFpd/rgsBj9nAfC?=
 =?us-ascii?Q?GscXmhAE5+hXb5K2hs2GWCP2R0rG5WDr5mki0pe/0RIzs48lD5k1KH7dgF8X?=
 =?us-ascii?Q?9wyF9IbkFiO377DggrV6en3pwVreDzPueEotnGX533EbNE/PspFPTzehA/ws?=
 =?us-ascii?Q?yUeug+n6eFhf5fCiU4B/TU0D1d6JwYJzADI6wmdW4Q4gQBcpdhPO5pvt1T7+?=
 =?us-ascii?Q?VDelvbJSniZSQelNpy9eSPI/sFGhPKKTGEOxLOW9kYLZddFd4Z7sA5y1167V?=
 =?us-ascii?Q?mGPX0gKEaVkdeYfGBs+CQPPCS6clucCqk/NufvlRBa+GUTVaSqkPLxLFx8UZ?=
 =?us-ascii?Q?5Erm5JRzTxkMi5gOoaAw5nsA7Fa5xklb1yU/f+dyiy7qrG3/i1CkcWWLYriO?=
 =?us-ascii?Q?KlXEO10anvda8PFEKDb/RTLlID/Ip12J98CmmrJdRpMKtE2dpcOscOByJHAw?=
 =?us-ascii?Q?fxPJEAsbUbHVtggEFLaKtMfSgz0J+YwhSbEeLC7FQ8+KPy/6m64pJ0XJ5NAy?=
 =?us-ascii?Q?Im7yK6iYBuAFEtkoKGD2oIjTef9glqE+AruTcVryl6C1qwxWngeJRChrpKq7?=
 =?us-ascii?Q?d8bKL6+GEmWtEd46//oyUCKqgYS8U6X86YyVn9xz1bh5btS9Q/kbya0No/4y?=
 =?us-ascii?Q?y3cWBCa8M6G3NBw+vCcz2lOTuBpamNjGlBgFfPS2ycNO9GD88w7Vhms4cHr/?=
 =?us-ascii?Q?mHGCjAvlX41NI8Q63iiuCmWfJ4Y6MvS1bYC+2RGRbqGdep9GuuOZX9tAkGvx?=
 =?us-ascii?Q?nOHkqVzchb9fLzdUUIgZQ7M/yQPfTQQfcvA41fP/UtN/b5CDeZqcJ+5rvy0c?=
 =?us-ascii?Q?GWWGZSa+fpyad5JGrnUAyLzufe7XiuECB7zeyIHD9lW+DivpEcP7qYez75c2?=
 =?us-ascii?Q?qsxlRDHdaUVyw+w/3+dWt78F08va3/dYLAuJ3Luw2o3uIx2O2xeDqPG7ZMjh?=
 =?us-ascii?Q?4xQXn5o4sqmraXIIYWuNQhpIc42Z3LY46ao0vLbk3Esz5z/ngj+jV/lyu2V9?=
 =?us-ascii?Q?uXLaUcWsf5yJ83B1fy/0RVMjme9PeBK/rX/jB5BajvdgR45ZqgERIPI58DPU?=
 =?us-ascii?Q?v1bNngKFduOZWyUpFK2oOObZ43gnw4c9CEOEv8WCtkVWzU66AO+CyYFdAWn2?=
 =?us-ascii?Q?g82ljP6VExRpEFV1CDpgrcjjDHvO8qRdPYb8tVnEsJBYmHDQvxnPXnAfSBkU?=
 =?us-ascii?Q?gvdC2PTIqVU7o5Z1pDabujhKrA0DRWLb76f7BdXwkO7dGA+VR0liMJQaf41n?=
 =?us-ascii?Q?rOoifNKTjGe9kzIWVS3/fL0p/IgkjqoGF058GHMOTVqHpKh0wX3BZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b715ae66-99a7-4b4a-dfbc-08da0cf87e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 18:11:03.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bNKoJTeJPe87/IotPL+I1CRa7IMiHoPaVQBmHmHIP3/VxHys706/pKajGRgdyFYGRoyvLF2AYJ9rWJRo8BjkMMH8qHQa4L/RXIhGs2Ztjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5884
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@bleung@google.com
The original bug only targets DP plugins. Should we keep connect/disconnect=
 flows also in loop? As Mika once told me, if the lid of the DUT is closed,=
 and the USB4/TBT device is plugged out/in, the DUT shouldn't wake up as it=
 will cause unnecessary consumption of energy.=20
Please confirm if only DP hotplugs in S0ix for waking are required.

Thanks
Rajat

-----Original Message-----
From: mika.westerberg@linux.intel.com <mika.westerberg@linux.intel.com>=20
Sent: Wednesday, March 23, 2022 4:01 PM
To: Khandelwal, Rajat <rajat.khandelwal@intel.com>
Cc: bleung@google.com; Malani, Prashant <pmalani@google.com>; jthies@google=
.com; Rao, Abhijeet <abhijeet.rao@intel.com>; Regupathy, Rajaram <rajaram.r=
egupathy@intel.com>; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.or=
g
Subject: Re: [PATCH] USB4/TBT device routers should wake up during S0ix whe=
n something gets connected/disconnected or a DP monitor gets plugged in

Hi,

If you want it to be woken up when something is plugged to the USB4 port th=
en I suggest to add this to the "wakeup" capability of the usb4_port itself=
 (see drivers/thunderbolt/usb4_port.c). And make it disabled by default too=
.

On Wed, Mar 23, 2022 at 10:26:37AM +0000, Khandelwal, Rajat wrote:
> +Mika
> @Malani, Prashant @bleung@google.com This is the patch which fixes the pa=
rtner issue. Kindly escalate your thoughts.=20
>=20
> Thanks
> Rajat
>=20
> -----Original Message-----
> From: Khandelwal, Rajat <rajat.khandelwal@intel.com>
> Sent: Wednesday, March 23, 2022 3:48 PM
> To: mika.westerberg@linux.intel.com
> Cc: Khandelwal, Rajat <rajat.khandelwal@intel.com>; bleung@google.com;=20
> jthies@google.com; Malani, Prashant <pmalani@google.com>; Rao,=20
> Abhijeet <abhijeet.rao@intel.com>; Regupathy, Rajaram=20
> <rajaram.regupathy@intel.com>; linux-usb@vger.kernel.org;=20
> linux-kernel@vger.kernel.org
> Subject: [PATCH] USB4/TBT device routers should wake up during S0ix=20
> when something gets connected/disconnected or a DP monitor gets=20
> plugged in
>=20
> Device routers don't wake up during S0ix when something is plugged in/out=
 or if a DP monitor gets connected. This causes the linux device to not wak=
e up during S0ix cycling as the host router didn't wake up because the devi=
ce router didn't. This patch adds a new functionality to linux.
>=20
> Signed-off-by: Rajat-Khandelwal <rajat.khandelwal@intel.com>
> ---
>  drivers/thunderbolt/switch.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/thunderbolt/switch.c=20
> b/drivers/thunderbolt/switch.c index d026e305fe5d..4f8056724aa4 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -3067,13 +3067,11 @@ void tb_switch_suspend(struct tb_switch *sw, bool=
 runtime)
>  			tb_switch_suspend(port->remote->sw, runtime);
>  	}
> =20
> -	if (runtime) {
> +	if (runtime || device_may_wakeup(&sw->dev)) {
>  		/* Trigger wake when something is plugged in/out */
>  		flags |=3D TB_WAKE_ON_CONNECT | TB_WAKE_ON_DISCONNECT;
>  		flags |=3D TB_WAKE_ON_USB4;
>  		flags |=3D TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE | TB_WAKE_ON_DP;
> -	} else if (device_may_wakeup(&sw->dev)) {
> -		flags |=3D TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
>  	}
> =20
>  	tb_switch_set_wake(sw, flags);
> --
> 2.17.1
