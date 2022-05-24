Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000FE533389
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbiEXW2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiEXW2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:28:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F90366BD;
        Tue, 24 May 2022 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653431326; x=1684967326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s192NW6heIgMwQZxXoaC91v5K/c1liTaMW2bjRc17H0=;
  b=AL4MIvGJNyVvbFFD+e44l57VXU0iOH9PB+77PX5QMhTPKc944Yp03jXf
   rNfw7LXSAcxv/9gsLYC1s0JeDHvyesRSDjRJCi6nLzPpyx7BqwZZJDKrk
   2910xekJ4z9H9Z3szsPTBLvcGx5kzYwy+c8S/LrNcI0QjCupya1Iw0AcH
   Kxw6ssSfgd+rz2Ow1tYTIR4m4z8WnUAhra9qu2dITmspBC5t0rIA+YZv8
   5d705pQ4KPx+CgqaGrdc/l3dMqFAnDY13+IpNPcEigrr26cbR2/8WLZqu
   m8zHtP8KZ31W/jVJuO6o/XqgY60Rl5rf4YQ5KsIToshbbaQjbkGjtkHft
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273391653"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273391653"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 15:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="820479819"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2022 15:28:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 15:28:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 15:28:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 15:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZywuUnCXgwvufJr0JzkLBbvfFDeEa3OSxhUlMScJyV0kgwKLwGmbVRNNq9UYq9caV9bye8MYn+rvJFMVuoIWjGePzQSyKzIEgYVb8Bv9P/ZmiHhefL9ptAMqRo+2gISUY2Do7nkk3PIhMXt45YUjkenUWXu/++8Sq7SFkxo4dY6NC+7Ie0NPlDC//vH04ae/OQ0tatjdM7xsHB2AOh1etmqS7YICQDH4vvXNSDXJ0P6A4+fJxqp7frByj3Y17GtbzVZtG8yFmFgwvil74Jq3NEf+P0MS4doNNTdgQGYMsvUhpVxpNQP18oroSfSZBKhJ4IvDOszb648Il/XiPfjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7RQxYFXJtaq/V0r56zz0iOuqAiTsHIxmDLn7g+xi9c=;
 b=MzwksyzR+2UnCkEFJiA5atFCF5r4GnFOxMNwpkekq32JE5H0sLk0PJICDhPQhLdpUEAR5UlIQj800RjGjWWpGxmL0jdh+ynoypF6qyokiVCFrEXJGNVz0D1dE/j2VaBS1WHDIsag3u8TM1ySpyNbxYuoi9V41AmAk3p9Fw+gqHZuU4NwsSNHpNx/UV8TSfRk0YMMlwQcb+4Ti9N3F38KXUhN06hHEn23gqbr7Kdaj49BO6N76bgu5leGs/O8t/zg0ZRJXVoQyZtlqS2TLj0+7I0kjkJGy4RVYK2XgTZCEHy9Tic82OlEERey7eD+m2L13UQ1kc4chaT8TIMeLy29FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MWHPR11MB1664.namprd11.prod.outlook.com (2603:10b6:301:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 22:28:42 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%8]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 22:28:42 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] Add no-idle tasks check which in dyntick-idle
 state
Thread-Topic: [PATCH v3 0/2] Add no-idle tasks check which in dyntick-idle
 state
Thread-Index: AQHYbwYeiYPsayhRuEClw46+7/spza0uSXCAgABTTEA=
Date:   Tue, 24 May 2022 22:28:41 +0000
Message-ID: <PH0PR11MB58808F5F0E02ABC4E12EFCDCDAD79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220524003454.1887414-1-qiang1.zhang@intel.com>
 <20220524172855.GP1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220524172855.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbd86418-833c-47e2-93c7-08da3dd4c1cc
x-ms-traffictypediagnostic: MWHPR11MB1664:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1664B8ED6060E0912E6F36D2DAD79@MWHPR11MB1664.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FdjqBuDhSYm9ToEFsr0PzGHnc9mgIcr9OMSRtcW5UVVhGg8T5xLA0WjJJpshRONIqMSRPT10ruLxsX3+GYUfy+s4czA4TuoFh965Vmb3qnmYjciLFOlxfyjx0LIt6eDwIduA3Od1v0p3DJil94CQZTW7B0A0aJSBTz7WapT9+0XNzyjBO8hFh2Kz4cwl2MlBbALCY8AeYAsU9zsNqaJXNhvLEKsxe5iR0K/VgROpn6I9uDEV7A4uf2s5K+NP4Tn3ARSmI3cQNVSKksWBl3X/tN68AxmolmweMUjst0PHXZWqljL1IYfFyq0CC5E2iduFZuZ/lNVOTKiup6lBUAj54HUmoxZfr/sUoAW8UIV/f7xfNDUPW+3AIO/z3jKPRoDhQ99Roa/oUJUFk20xXd5g9Bq63W3xhirUtQJ0eaAhZY8ko0yrfi01UFb1IXRe0mI1KIlIR1MN+0ec3dXN1VoFog3bMizX2cQCatGA8sfII2x6jJsyTsmdQ1ESmn5ByX0/pMGAJSmj+MQSWhds5sTl5wvhhkxnbp4TtcFvaJHwm3OVoZSz3UMXrtHn7y0vhihPfrilaOnLsHNjsBtIh1xPpvVkKkgEmuthReUIS5+aMtg1c84gn9TvCze/xY+U9XrFUyEj1qWBvusYTscVk0Upk1YBbLnGWy6P7IW2JqN+hYT/3MvtLkarYQChFJYkIG8H6lex3HdnSP7pk4nP65Ntv6UKfwFEj/eanpPI9sBWXkFVwS1vIDGgqOXepf0OWmCviR2qIund6XEhQX54T4m7orEeC28B2HECPeVNOqZl0INZxML8L1SK/2sYJ66PuGsT2NfGRnmml6jnyiilex8hMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(5660300002)(64756008)(7696005)(8936002)(4326008)(76116006)(82960400001)(86362001)(66556008)(66446008)(66946007)(66476007)(52536014)(38100700002)(38070700005)(122000001)(186003)(26005)(8676002)(71200400001)(6506007)(54906003)(316002)(6916009)(83380400001)(2906002)(33656002)(55016003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ixsSQeBF/bGr5ziA3KmdX3qA/x5L/5+qzsAThr0B0a9uM79E9BbAXoWiuF8F?=
 =?us-ascii?Q?OZv/TgyqTiH0RlUe3DrKOgup8/IiR1Yq7LfZOObfJoewD/Zbt+hnc0Q4nKeX?=
 =?us-ascii?Q?z3CsU771R+3EXAOO7p/p1R3oYgoV4M1fNpzeHY97Z9lWzui2LLpbUhM4EvPi?=
 =?us-ascii?Q?KNtgc5Q+cka7gIaNeP2M+xMWBlxUZU9z5z6v1cID24AKb1wAFmrrH6Iun18t?=
 =?us-ascii?Q?boHdpuJ0bKsC4EHUWuHW+ImeeT88zYHyYsXQLdonSfOPtEPa7rnTCyRIDG5B?=
 =?us-ascii?Q?OFI+nvvpmRyLwdTWCrDOT2A1G5okdm1wiPmrBiJBPGSvdaNw5K9WSmKzIyLy?=
 =?us-ascii?Q?+LcskxUOdvm4SlWT8S0oaWF1AIkiPQZqO+90PWLP62deBDDtG4TDG1Jg9BXz?=
 =?us-ascii?Q?dP57F8zWwfhZ3QRVQxvs1ruLlawtw1NEu0gKf34F2gFJAqyHlRUqlcUjXlb/?=
 =?us-ascii?Q?U7y7/i4y1O+mLoewRX1ON6ga+wVJvRrPCUHPZjMc3a82I29X5rV/87zcNPUG?=
 =?us-ascii?Q?c/q7YEhDXZUUq9zjC92BF1yicxXE5Yy+qtMEAGBiXbLdjhNuKzqwuJKiVEPj?=
 =?us-ascii?Q?K5qP1r/YLbs1XfubQ1If5Ycr/4ZkMslyjbfmRr/yeeIzUeilS6lljspjUFH1?=
 =?us-ascii?Q?5OXz6Lmkn+T0RnAFpvyHnsp7g80+vJiP7ZSz/035gI/JwhB01OzVghpQoeqh?=
 =?us-ascii?Q?X0cJFuighK0FM8yYikidUv8g9OTr6q0VaeRkknWuhgAjC/nNyQPKglJ7pf7A?=
 =?us-ascii?Q?CamCVpofgLCvMH67t3sC3UlB846ynjEjsgje1fHR1LrPC6odqMkiKkYPGw4L?=
 =?us-ascii?Q?Hyut9yd+lV3OggPGoliz6fCmJpiCA/DmLlP6uUP2ZZRddt7wT9NXkkbEJVdD?=
 =?us-ascii?Q?9vKY7/BsQVv3teksIPQoAezlIGbg56yv+Ih6V6O0STC/uMjJbKCQsU6b+0Io?=
 =?us-ascii?Q?fuKUgH7S5HLKLq8dWmVtfvgdNm25mMEwfgaLUMW3N07g3TSWnCWK/pkCIqiB?=
 =?us-ascii?Q?qA5Duly9RXT9505Z9Nwa3Y3269AZAIIiD20uwG3sBfNIgipLnDDELu55FMos?=
 =?us-ascii?Q?YkeDUYKGRgNqZXkhZ0ZVcIXc07kw0eoCG/glFuW5sTQz0QBEpJ99VkcugEWH?=
 =?us-ascii?Q?pFPOs8gyv+b5qNoIrI//S51fgvvAlF5jdqIaKesuf4RplblWouCfE8aIZGD6?=
 =?us-ascii?Q?YNuMhliEJXjDjKkhuxHmRSWqgdFBcAyg58sTFaXBuN5V5yOCu+16l1cMzTer?=
 =?us-ascii?Q?OGbxZjWcsKq+AJO7GCmMViJbsfzIIkDZkfTkpBH00nr0dacpvRBFMsPj0lCX?=
 =?us-ascii?Q?IFaLsfv1L3Ej4cyRsV8CjcZ91tkPg7sOp5jy7rFQ+YN3O5IIuKy7VnYUAYzS?=
 =?us-ascii?Q?z4Jdjw2aeL9a4y7zQ2IoxavQIUyB1vYFHlQA9ZssmQV5djzPB0sjh0uy+SNK?=
 =?us-ascii?Q?YOydfwCSgvRZBe8HoP0CKWg5xvX5Qz3a80wDRtEga8ggau2uxnay1bqvjOYJ?=
 =?us-ascii?Q?xSbl1HnEJT11UcvfBDFL+QZaJbJFXsHK0/17LHnJhR3yQf9evvqSxORz1Bwa?=
 =?us-ascii?Q?NJ42MzhehMGX3o1gK8hdVlBLJw15X6ZiL4pVCi/UNHtKUsclAJavmaG650g1?=
 =?us-ascii?Q?J4Bua153p0vLDhjaIgWen2PEU//PPOQHYhqAl62ZviLKeBk4+PQ6Plb90WZy?=
 =?us-ascii?Q?dwWhxgdZKJSugP0ZmDK8W1279eIKhLvhmkswy9pNJseyikgHI9+G2uIfZKaX?=
 =?us-ascii?Q?N31bvFPAgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd86418-833c-47e2-93c7-08da3dd4c1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 22:28:41.9648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSnbY/r97ec/rR6oRPUI0ZBWyhOuxBlM9CPDgbyCzpGS6bnCb7YXagfGsKz7Oon20mFXU28bLfOnZ4ftkeQmqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1664
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, May 24, 2022 at 08:34:52AM +0800, Zqiang wrote:
> These commit stop scanning no-idle tasks which in dyntick-idle state=20
> and remove idle-tasks check from warnings.

>This patch might well be correct, but there are supposed to be upcoming ch=
anges in the idle loop that would make it possible for RCU Tasks to take id=
le tasks into account:
>
>https://lore.kernel.org/all/20220515203653.4039075-1-jolsa@kernel.org/
>
>There are currently issues in amd_e400_idle() and mwait_idle() preventing =
this, and there might well also be similar issues in non-x86 idle loops:
>
>https://lore.kernel.org/all/20220519135439.GX1790663@paulmck-ThinkPad-P17-=
Gen-1/
>
>So I must hold off on this patch series for the time being.  Nevertheless,=
 thank you very much for your effort and interest in RCU.

Thanks for explain, I will keep an eye.

>
>							Thanx, Paul

> v1->v2:
> fix build error when CONFIG_TASKS_RCU=3Dn
> v2->v3:
> remove idle-tasks check from task_is_on_dyntick_idle()
>=20
> Zqiang (2):
>   rcu-tasks: Stop RCU Tasks scanning no-idle tasks which record on
>     dyntick-idle entry
>   rcu-tasks: Remove is_idle_task() from warnings in=20
> check_holdout_task()
>=20
>  kernel/rcu/tasks.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> --
> 2.25.1
>=20
