Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A585A2171
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244979AbiHZHI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbiHZHIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:08:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE5AD2B0A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661497703; x=1693033703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gVF77M1KsiwxnwegrTLkdT4Vb6nhRP8srYCIqOHtZiU=;
  b=gxktdNCAFdAXPZNdRXiZHh4WdV+R+OWxUfT/FLB2yjlIrFLyALx/QXlM
   fQaByP+c0LPOJooFxOf3FyWZ1IEdeU+QxgnoAMp3N7yFT3u/pcRzVH/jt
   P4yquv64gMIA14WdEVGAsbx49RRZFP6En/UPpS4gUTzs2vzjy2lmL2NIN
   7Xv7qObcoGCT+6J9xvGClebI0OYkDLZjCt/cvoIyBejDVhacW88M861zl
   t8TNWhEJvCfpBz6q5MgsxHBjkelFTfs/Ev7QzDncoX0DC+ZmUHjr2A5JB
   e11ISNGcmLoCIFltc3grzh03iI6VE1PjHg5rYHydqhkNZu39a71tnx26u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="293183544"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="293183544"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 00:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="678769800"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2022 00:08:00 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 00:08:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 00:07:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 26 Aug 2022 00:07:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 26 Aug 2022 00:07:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxVcsWPr4IhhVRi1hJX8/xavoijnjJarkTeAv/UAziDa5u8z50i2Mfu9t+w9FUas9q8kgFe+2nt31O9jIT2U/NflvuOSc+11DrM1LSOmWvt+kOXGQ508CN5w040IMINoXqKtulLiBms7Dyt8Tbl5+eF4v0PAusAswNzQcJe9MAhOhvKVyi64ksuCvoBLMjuz0S4o8OE7+59L3n0VuC3ipCuMey67NnJfX4CW/VSCCltuqlKVYX5wIcFSsv38oAOXPqtKKouHUU047QHMVAEXUUttcOF6mOiypDQE/utKaIh1Rxn/VE/H7ZIJnpWTtbCiATEQdVuW83gAR6/i/lxgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZqNS++p5j6INNHuPFwcmzSXttx/AuTRL61X57En3rw=;
 b=N6MWAD0MRfoj9iaWcjVYLlA569l2la07H3W/SbHNqKEYIKM2dqiXSebIpQHx8Lc7efN4OzeGatafKwH/uzftwqTVCseCFDQdkbptY43FMCCHcIpINYp6FpF8nIpnvNHrvUriXYqN2KTBLtD66sTIfMDEYy9CCrc89dKiK2bpqUH+R18Fbi++GdIXe74luqjefzOFp0TeNT0Ub+S6/kpfg8X8tUgBHdlhjTqMPuILD39AEN1TuH5Irn22vgMLSw4P/kzt6ktFfDhWey7HaWEAYG1Gk0SYfK2+nkcwmSJ+WdSJSmtTdu+f1RQpW/OgXUomAJppKOcmFQ5PITA3ob1zIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11)
 by MN2PR11MB4032.namprd11.prod.outlook.com (2603:10b6:208:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 07:07:57 +0000
Received: from PH0PR11MB5045.namprd11.prod.outlook.com
 ([fe80::4473:d15a:3836:fed1]) by PH0PR11MB5045.namprd11.prod.outlook.com
 ([fe80::4473:d15a:3836:fed1%6]) with mapi id 15.20.5566.014; Fri, 26 Aug 2022
 07:07:57 +0000
From:   "Xue, Zhan" <zhan.xue@intel.com>
To:     "tj@kernel.org" <tj@kernel.org>
CC:     "florian@mickler.org" <florian@mickler.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: Regarding WQ_MEM_RECLAIM
Thread-Topic: Regarding WQ_MEM_RECLAIM
Thread-Index: Adi20TVWwQYki1ZlTMmpLUbjHR8rhQATLfuAAA7oLRAACaYz8ABLL88AABrYsDA=
Date:   Fri, 26 Aug 2022 07:07:57 +0000
Message-ID: <PH0PR11MB504503DC6E37BBE9475804BA94759@PH0PR11MB5045.namprd11.prod.outlook.com>
References: <PH0PR11MB50451B7F2F155AD8A893E9E894709@PH0PR11MB5045.namprd11.prod.outlook.com>
 <YwUb8UmXvKNHgSrP@slm.duckdns.org>
 <PH0PR11MB5045D2FF3C98EAE995F7897194739@PH0PR11MB5045.namprd11.prod.outlook.com>
 <PH0PR11MB50456E21C95359B57223F23994739@PH0PR11MB5045.namprd11.prod.outlook.com>
 <Ywe5TlXr2cR3inuG@slm.duckdns.org>
In-Reply-To: <Ywe5TlXr2cR3inuG@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd431af9-6e67-4b37-e73f-08da8731b42c
x-ms-traffictypediagnostic: MN2PR11MB4032:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lr520njeMphzDQvnDE/9vGghheT4ffr3LvAsZbmv2xq9kg3NjOL9QIF417wyePRJZ6hg5h19mJlEOEXixD/R/FriDEKKA0/chz1zxbcRx3I+rbUedEF1vvNWH5Gn2YJVA5vRY2xIyMgIi+8KGTeULwN+JstVy0QJWEyGjTkUarDoS7wCXfr8QOjg86u7py/VAJt4x4Otp9N6/4QZzdVFo7gmBdcfanhkHrMEC6Ixhm+PFlb0NyigTqG8mGchJ1p14rYZBhtwRIyrn5G5B9sbmhEvYNhRwNynhYu413G8VYm5wY3tMJ3l09EmW0tZ4StBZ54bPinYb2kCOE+JsrNiKqS7kFtYhIO8I4jfLfb4u9jV0Rw+Q9jtDMlhhNrAM4HQjeDMr0u+2zobNqcICLctTBIoHR3Imc7rIYrC4H5f30tQBboxXBDzQeXzGfTOMpOmrMZDzt/nxW8OK0feD1J1wYEs9+Kv0eGRAZgySFuxPYO8iVtFWBOqxvsEMCdnNNh80s67GoRKWRYwxTfxiXKWXkot7DFlp4vmrn4RVwE1XGMwjHXSTWcSxRV9bBHcxPdc+npUkkfDA1kS+sVoKV9amUF7/oLgZ/AifCxVgl3zGmQ479Qh9IgFgDNq1hDmhOzG+PCfaZcW4QLpracPyEkU/50gRx3x9m9WKkNyv8LsJkOADAgagl6YR//NRHTRBXqe+Qd/tsETBGVH6uRh/+GLbtpH/LTwDO1Kjf4rJYacs91NFjd66p8DfCNW7SNUJyWj8t6R3FDvpDHEw8BLZ2jhig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(136003)(366004)(396003)(83380400001)(5660300002)(7116003)(2906002)(8936002)(4744005)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(8676002)(4326008)(6506007)(7696005)(33656002)(9686003)(55016003)(478600001)(186003)(53546011)(26005)(41300700001)(71200400001)(82960400001)(38070700005)(86362001)(52536014)(6916009)(54906003)(122000001)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TX86C6zexseOQbeEl2pSH7/awSD3t510nhMn9yua6mxv5JQVXlBON73cKHTN?=
 =?us-ascii?Q?K2PLcHqPSI4av6KPV0h+2bvJG2X+u7Wfk9m4Ld+LYHr8o8O089VXo9GQKkLp?=
 =?us-ascii?Q?GxGIXOe/iN8+vW8TMs2c93PhUhNF0YKDd2Hspy1/WKFd9F//FrZToXCuQXza?=
 =?us-ascii?Q?PL4XnTpMJ7l9PwstW8ZY1lvukwCLILKQsHod79NtrkUFVlgqzTb3nAbO69SN?=
 =?us-ascii?Q?/iz7V9A8QDMNtac9YJ9MUrO1cb5k6p7BsD2eTzg/VwvY1RWgROQTJwP0V9K4?=
 =?us-ascii?Q?yo/xrEdRGHMe+IiC+oIocOQM/m0hwdEZcOkmgPgW00XpU631xvjP4ErqoyKx?=
 =?us-ascii?Q?PJmmRCTHe7e+FwT5tu8JkoXNk9XM+Z/kHW5+my109eV47SsxmXdK7IDETEe9?=
 =?us-ascii?Q?fjff0mu4HUcQNDsWsCBlPtoksNeLvthlLtH4bxi+tkHtSCy5mW+GDWqiTTZs?=
 =?us-ascii?Q?Tft7upcAySgX3rhehKUzkEQ7/GuAMHQ4c0kHOSGxa7RN6qMRQrKgDsjt1L6X?=
 =?us-ascii?Q?PxSbtnM8jpTH0yiT9CO3XpLb8WgsJmLA5m0UGGrqWRRgbOQ/ae25PepZJKSC?=
 =?us-ascii?Q?9fn/yW+tu5Bkwmh1o/IBcybmxLJ0C3dLq8gOGoZbldApF68QiMKuitW0wwKJ?=
 =?us-ascii?Q?Z1PjhWNwVck7h6xVUlh3W8AU8fn73ujoOpLwC6ZAM75d3VO7D4JbucXQGppi?=
 =?us-ascii?Q?eSgIDHlgxwdvqy3ozaZ5zdzEgLKiZ7vhcmhOHGGb3rlcchtK3irocHSzT4Vi?=
 =?us-ascii?Q?H0KAMvtMLKkEcVewHZgxr2NnZQf7C0p6FIAWKmIKeyevnZyhLYfOy1L1EKzt?=
 =?us-ascii?Q?rAViWYkUsy1ntJIZZieZXcNcjdzvEWAP4EDEykrwKWt+Kvu+NSW+9mQtq+Rx?=
 =?us-ascii?Q?OeC3J8t/QGPTIehLdROcFtlPVuAkQYsKkj+SChc2ZWyFbJTBZ9xUg7QjM1zY?=
 =?us-ascii?Q?QZvcjtvcbURNzpoy4XGXoANysjhNDMDp7gCZbuaPEe61XF399xdN1R5PkeAe?=
 =?us-ascii?Q?qi5Lsr+FFJ4oCj6SY4pfRvcQ0BCEn8yQxu+BMFGrmh4WbAlwzBpl7bmrYzSX?=
 =?us-ascii?Q?mEvROh/AQnPYpj6k5eUb6HaTD15xauelopeyqHM33bQaPmDYEf4YtdurO4l0?=
 =?us-ascii?Q?Xs+MuPCALVhRm2SJOZ+sI1LYYilu5XMqUosZPLjCvQ81fAQntCrVW2bu1C6y?=
 =?us-ascii?Q?Os7IBqF98lkPCw4S2P4fW58Wc46R7M+efBqy1k2W5LZkOGIiTYFRCHc1ILYE?=
 =?us-ascii?Q?mnZcevy9iC9nV2cR6ZYRrp4Y2zZb02w0n22b5nBTBdsPT0SJz4kJJRH+RZNq?=
 =?us-ascii?Q?iU+ApFR46Pj9KOBSMhPxurnh2bsle6lYVIfA3L2lKPrdgTSBIXL/lCQzrJ1L?=
 =?us-ascii?Q?/ENzGzcSSgPcjkFRKcUukvM/GZXIYwhm/uxNKKFJ1bXN4mHb7IzLIcjEwpBC?=
 =?us-ascii?Q?H5aS3Y22mKR4wYMvJcUEANviGkaRFnDm+wXVTPnc6tSSn7XCw+nWzVQbGijb?=
 =?us-ascii?Q?1UTrPgK7T9FCRwGeqOmcV8s5DAgNBaPiP2oJs7TggmcKhtG3bjH7SX1CKZBT?=
 =?us-ascii?Q?lMsC/LkyEk+7/bQZpT7JTyw9CnBPHza0lPxkMOxz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd431af9-6e67-4b37-e73f-08da8731b42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 07:07:57.1866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nysm6nr39006w1GzdhJbjBIuaaqTOVzdFqSFA3vy1yWzZOBFohy5oR7aHhiH+8lCB0Wl5cKInjp2JzF/h4ABqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4032
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

Hi Tejun,
      The brief point seems the answer to one concern about " workqueue: WQ=
_MEM_RECLAIM (current wq) is flushing !WQ_MEM_RECLAIM events:(target wq)". =
  If current wq is for memory reclaim , the target wq should be marked with=
 WQ_MEM_RECLAIM as well in case that the flushing target wq  (its work item=
s) in the context of current wq is  inevitable.


BR
Xuezhan
-----Original Message-----
From: Tejun Heo <htejun@gmail.com> On Behalf Of tj@kernel.org
Sent: Friday, August 26, 2022 2:03 AM
To: Xue, Zhan <zhan.xue@intel.com>
Cc: florian@mickler.org; LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regarding WQ_MEM_RECLAIM

On Wed, Aug 24, 2022 at 06:10:56AM +0000, Xue, Zhan wrote:
> Convert to plain text..

The email's formatting is too painful to reply directly.

Here are two brief points:

* Just don't share the same workqueue between work items which need forward
  progress guarantee and ones which don't.

* If something can block memory reclaim, it is in the memory reclaim path b=
y
  definition.

Thanks.

--=20
tejun
