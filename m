Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D05AA459
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiIBA1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiIBA1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:27:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8145995AE9;
        Thu,  1 Sep 2022 17:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662078441; x=1693614441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TP90jy+/ayFJxFRx7wFQWMN/sm/4ZI8rCc/tz/Qczdk=;
  b=bb9uIWiJL1nyhKOqT4TVcMolrpHoSBtu4KgrT4g+NMr+POkNouGDveCS
   57aKI9+Hj4ZnPJGsrEs394FPgonEfazHxh6BtZDAEG+EjVz4gADezl/D3
   cObZHLP4bGKI3vHmtBWZvsAiB35n1kMzblRY+fXa7hay01XT1UdomcBev
   PRLkytSeqTJlxM03l52AtnHZEZXlyrZOdQ9Sgit39L7DaF8L5j+M6V9Rm
   TCt7wtn/d7prT34lZX7+0Byhfgu16F0CtnrXjwf3z5Lq8flW0wYcM2fEq
   7dE7Rb7HUzogTlSam1xwy4FYDXtae4WwTWqtBEYDT6Jmipa0h9CBLYNwV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="357578119"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="357578119"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 17:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="701948333"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Sep 2022 17:27:19 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:26:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 17:26:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 17:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEdYbneSXv07YI89jn+lQct8wCQd4W9r7CYzUV5RIGrLXllRwpUs30gIfJs5SZEPCZ1hRWFmUlU/yxz6oFXGcWk7RuAsF5CEiBCRyCBuXQ6LxRNKcfgSxkH81MqYVicF7rDSENiB1FjW2KAjtmmb3Il1dEGQH3IZko/VPiQ4E96nwJrsTaz3VmeouX09ovqf+L1/NUXS++b11KN7dKqcQ2fqVYfjK9SnZ6nxh9Zp9nndlad91DhVkVH7EVs8ym00U0NTDLOxKwEc9KUj5tthHdtD2IrAzH3BL/NndrGlxMAOtkf/sVGmsrL5Fk0EosemuyN387xrZyhqxM0V02bY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP90jy+/ayFJxFRx7wFQWMN/sm/4ZI8rCc/tz/Qczdk=;
 b=eJ86U4vzH5GonCtACQwnRw/uIiYBdKdlTFYuYNKhoQxRRF+G1PiAxloB6Y6L+1yRbexzylyBcl2ALW1cfkb+rb9n3mxzf8lpDoWQKENHlun2P7VWXJhjptk/FKenmSbmWvRWtyXngSS3QDKV3vYJESSbYf79IQFtX4w5TeTA+yZnjgCj6/NZ4g4ZzJQ824LFTCs84/d2EyqPQfciGnVotGc9Y1G1KAqjCWnM9fDc2JinbQfiV/Q/2Spr0HbBLjqweOfChLl9/GLDrGH7yTctOcPFEpOHky0nnM+tPbvYeesGuVzziFPjpVzhFm2tX7u5VYxABVN4+g7UbU7V7tYfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO6PR11MB5633.namprd11.prod.outlook.com (2603:10b6:303:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 00:26:46 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%8]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 00:26:45 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Topic: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Index: AQHYvB5Zhte1gFzwtkKh12BdFyDkBa3IDqyAgAAq44CAAA1sgIAABY4AgAAChYCAAAMQgIAAAG0AgAAFhYCAAMlpAIAANTGAgAAB5gCAACO1AIABr4AAgAAEDoCAABVtAIAAB2ZQ
Date:   Fri, 2 Sep 2022 00:26:45 +0000
Message-ID: <BL1PR11MB597806C567B8196D4155AE9EF77A9@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <Yw7LJa7eRG+WZ0wv@kernel.org>
 <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
 <Yw7OEh7QP8tb7BR1@kernel.org>
 <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
 <op.1rrt4aecwjvjmi@hhuan26-mobl1.mshome.net> <Yw+oR3FKlwbeOl6I@kernel.org>
 <ea61a9ee-96dc-4f23-9de3-34e033391abc@intel.com>
 <94993d90b0b3c59fae61427cf0cc78dd10c381bb.camel@intel.com>
 <YxExyuA/+ptl0Y4G@kernel.org>
 <e1229a770fd2b4ec6642b921ec4a7e9ed0d11a3b.camel@intel.com>
 <YxFHKttZMxbbmo5z@kernel.org>
In-Reply-To: <YxFHKttZMxbbmo5z@kernel.org>
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
x-ms-office365-filtering-correlation-id: b2ad19fe-3f01-4e34-5207-08da8c79d16b
x-ms-traffictypediagnostic: CO6PR11MB5633:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g7IvTdIoqqNtEUalLoR9zVFzHL1Ftg9RC2kRYocu1L6DbtXiS1pEEzcoIytPPBwtUCPAHPi52fkvpCOx4V+dfGwo9xN6wElfZ4BZxMYvNo4VyCUba/TUCFFM1PtEirWSa4MyDhN6s2VAvSsN1a++r+SmldtEIv8UfqOzqoihWrnAwZ537cRFisijDKvCwpY8PY7DdjJVe5UgmaCK8gItY68kXajnK7O8TxvH7VkweHg3AR3KPiwzsiqpz2w7WnIbiKGE5fOAROiDbQXbGiLAydjB1U+O6Zvic5cnNozYGwCLuWwBP6b2PFOqbisM1D68SWhmqSMmEKclpZ3+GkkGg+GxyfXMz+8KuVsEy/eXemOFo3rmWjtJ/t76nAy36nkYwqW+oTHHrcSW/99Hl8vSvkh1ce4ivDDxTjmZ7DN6uQrUd3jPQZ/ARvtvak9qPIbPhFTaFPxlHx6GrRVX4natGgVitu3Uhr315EcvuqlaWJEQmIkCvT5Ch4jXWPTBvvIYvUikXYqKBfcyvzkSGZMAmXh63nmXcZIQf+e08vSQlaLVMBj3cueGnONG6LJJh1n1wujWeh3r0R0Paa9OayEAJ7yqUiITC5G3JtlST4YN23Kkud+TlY4d1biz1yWoeI1VEqLlr1BuT7aDTGLRTxgcsRDvuXfzxApSEGBMkKeduJuihvgkFKxp4b/R1MbnYU750MNof1L0ZoZpkILCHbFP2lizHUog9Dyl6QJ5K9GTy1mx4vl8ZFOrEmMpqP9hs/7v65EWHRIW/q128t/Z3LiJcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(366004)(39860400002)(136003)(316002)(82960400001)(6916009)(54906003)(5660300002)(52536014)(7416002)(38070700005)(66446008)(64756008)(66946007)(76116006)(66476007)(8676002)(66556008)(4326008)(33656002)(55016003)(71200400001)(86362001)(478600001)(38100700002)(122000001)(7696005)(6506007)(558084003)(41300700001)(2906002)(8936002)(186003)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M58mI7S6SLTiNhC/it7bPJMgmXlD7avnW+qQU7PJcH7oHXVxyl9EZWOpKyK4?=
 =?us-ascii?Q?AQI3XiaPXE3tHJGPrZzZcNLAiFQ8/hlHGiA/LKxvdFIODMmPPuLWCUdTtL6u?=
 =?us-ascii?Q?t8ArlE8jYfFe7Zsy8uuM8N6y3I+Mdc66xZkFe6MEhDsOG7DcHPx/AoXvj3yz?=
 =?us-ascii?Q?/2GeCSZzsso2MdDHL68wmYS/lpya1t6CS3k15pAGkLGIxW4fbpXTMVwkLacK?=
 =?us-ascii?Q?yvRxhoJONRUO0gnG9KbQ4UiqAjhtWD8WQsolHRmrjMJaNgfsk4dKKDupemfN?=
 =?us-ascii?Q?O3fsE+fja+M/74F7xGnb5COLCeYXRNaj3Ecb1wk0Ju2v2XoNTChWUrmwGhHd?=
 =?us-ascii?Q?i/9W88Wha5F9JucDczAVKAoJRPjaxGv8b84JCqSLk1RgWl0eJGuBkRXk6lEO?=
 =?us-ascii?Q?C36v3oSwtiU26+2QZSl20fSnv9Ih7gSXaeWyjKoCYfq6Gs+vsHFDBHUvMX4m?=
 =?us-ascii?Q?eH3rf+vDVexaEY+UuJTkw13GSGcC2c7mW44lFuiv/dBas2s9AUzx/n+aWqHl?=
 =?us-ascii?Q?b3vHCP5Zd7njM16pbxWDFHcNQwc8DnRpj6qhfufFWNC3Gx86Z3npMyawiLf1?=
 =?us-ascii?Q?/T6nJxit9HQC6tETCMpiWNgNrOt+R6mcgD66RHez656zb44mMLrn8IG2UNxH?=
 =?us-ascii?Q?U+i/3m+lH2ZxriTcXR9szzk0NbWjAxYiRNQRMhDaWPEKYBKu5eix3EoLv4LE?=
 =?us-ascii?Q?nH4z8wIVGLXMJY2QJT2ZQZyLVEyXTg7DDVtO8+b4HdnRfkmbmnPWsvNXfIZy?=
 =?us-ascii?Q?/xaJ/rXWigpEJEsRFmfckR7XwyzRU3Mo6ZSeoCZbKf/9vZNhBWQ91OYcbXyn?=
 =?us-ascii?Q?AD4ttdylcgpZfUZkBmzh4nhmT/GMwGSevCgoi0aFSD15JYaTXtizRLkxpvaP?=
 =?us-ascii?Q?MbFwQBbOyJ52QOJhq0jEb8puBrYpE5EmwNkRW6OR7p+BIegMmdqGxg8mm+z8?=
 =?us-ascii?Q?MYvchvZ3dnWHInrbESATMKAhvOxFx3bVeS3Q9tGMWC4063MI6a5z5/XFA7eU?=
 =?us-ascii?Q?2fcZU7GKmVqGiL6f4Auf2TtjB1qKDewZDA4jDcJRYCuuTCy1dpPHQAMDkSIq?=
 =?us-ascii?Q?zJvQMfRdIG6tUMkGerSiSdcVO8eabpB8qSXGuQwFXLwDCdRo+WucRAeh2Sm8?=
 =?us-ascii?Q?/oatXqVgm/tkE8IlyJ/nADGWpojcpYSpR7ZMT2MM6dSrmIiWwSiXZZnNNh3+?=
 =?us-ascii?Q?weDPxLI3nVmRpkZNTgerJjr4GZz+pPd5IYpBHw+Ukk9mL2+UAKknmAEsV+oh?=
 =?us-ascii?Q?4siSuIVPT0Zg8uFr/+n26j0inxxb+xNhrVARwCGfUCMrCVj2WhqoukIHPVYg?=
 =?us-ascii?Q?zJsAnfxQoW/mQcOjmoiTQNniZfUuK6xrLXxcFsny7khDqEargOkIAfSJn2TE?=
 =?us-ascii?Q?w/c8P5upd7xZ0JWZDSlWBS4ygYDJ+M6+u+iUYKix1TXNPCg1sMmUaNWYJdZx?=
 =?us-ascii?Q?ww6gOl2YaTYojT/2IPRpAaia7qQG3rZwb0s6EpVqtJiTI8FyBSOqtw/UfCMg?=
 =?us-ascii?Q?z1B0qtk8OTrmOJq/s/i8BROHQdCt6I1uKLXwT6ongexvkRxzYuPRZa6wM3F+?=
 =?us-ascii?Q?cXpPueR7YBal4m26hbdMJqYPSCpLEytj7teMgt4B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ad19fe-3f01-4e34-5207-08da8c79d16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 00:26:45.8593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ndvid4KRbBcTeWx7UujTdB5frikDKC7mfI1wBEoMU0Hk1TZMRYsLqxirnqIUcoPxQ9F+g3fPqKQxTuG/ceXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5633
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Yeah I am planning to work out one to see how it goes.
>=20
> Looking forward to try it out :-)

Just let you know I'll work on it perhaps late next week or the week after,=
 since I have other higher priority tasks to do. :)

Thanks,
-Kai

