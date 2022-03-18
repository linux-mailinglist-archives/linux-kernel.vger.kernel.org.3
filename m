Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A594DD4B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiCRGaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiCRGaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:30:13 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A120D1100
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647584935; x=1679120935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tsJrXXdvBosvrfpv+D4vJQ5zlxqW6SE/eE4xiQxSdyY=;
  b=TLfQLOWAe9D8IK3/9DIShujhCOXUCljuSzcmikoKMOa0OzG9uVGJ6/yA
   hEai7M8pPFiyIXDCN5fdN6BPEVXrwJ8w9TDju9CpeFsOxfmuUu+IkqbOT
   N2j2O4AkS99sBvi8zpB+T1aMvrwK/+buzkI+cBZP1yIbwrhvBULeOi3O4
   ezf/wPupVOHKV66Uubx3j/JLQhxCw7o9TTEB8VjsW2ZKxJqsr8PkPAbFh
   C59d815+shnVC7nbsod7Z89hqIF43jfTwHHbSV80w+02xAwsqvJTO5hiP
   6msWXhbzfceZQ+VFqgGj906/KKPQucoKlfuZhWcYa/aAiga7RLZ6UfxXI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="317783683"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="317783683"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="599372868"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2022 23:28:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:28:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:28:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 23:28:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 23:28:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNtwxJgESorwswTHRNIm8tR6vwURYo25Bfl8ILbkErfhX8dd4a71fNefZ7aXm6rQKPNLsLGH+Ot+H6syJc5nMlhfzLzOH/KjnYMkFIFEiGSxDvd2hqKYo+89Gyk0iu4RHImX+G+WpgsQ4NVYlomiWufahGsO4S7bpJUWF5WKsRbgyMZ/g89GeaV0BZqQiJWH3JMtfwVe+6JwEJpWwFWrspqzSXtY/IXPleln3is0dp250XGOYk0DvVgj/9Dqgh6SKUzNiHRkOFLvVRNr+f1P0BiHa/ZFst1O6FbksYdWB8JE59IB01VV8lc7d86eBjxNd7/c0rdO8gtL/T8AIUkl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsJrXXdvBosvrfpv+D4vJQ5zlxqW6SE/eE4xiQxSdyY=;
 b=Z18nBNKcZpVOF3Bun6PdksvmQ5mOlAQbDDYSRdp2VAtOt1bzuyJpqoYwXleBc/n1W0FKRMNJQTCdOGpMMwZeTu3FWxytF9/hYTzIa/Bri3V2kthG+SKTT5HH+MpZo37Ebrt2/tVcitsbYO7heKwTv1mhi+tH5scdcI5lkT1p9EjTZ1BVV/Q9n34Mgqiej+kWDJQiQoPY+gKU5Nt9FI3Pr+rBQMziy4+6EK7gZ0e52ldpU/xtSZdJWAd93Rv8W287ObgWqsUUwJ91Fc428V5yinYXRzG7zAqlk09xky72pWIrcKO5gkJIJNlJKTCBFdHlcgI+MmHRgJu6KF+l0DDBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 06:28:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 06:28:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 9/9] dmaengine: idxd: separate user and kernel pasid
 enabling
Thread-Topic: [PATCH v2 9/9] dmaengine: idxd: separate user and kernel pasid
 enabling
Thread-Index: AQHYOCoc0yAwyaed3UeriUV4DgPjS6zEr0tQ
Date:   Fri, 18 Mar 2022 06:28:50 +0000
Message-ID: <BN9PR11MB527664BEA4D414E02DA08CB28C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-10-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220315050713.2000518-10-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a284abef-61a4-42d3-0f86-08da08a89105
x-ms-traffictypediagnostic: DM6PR11MB4236:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DM6PR11MB423661D3B66E9E833B8E39258C139@DM6PR11MB4236.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acEJJoZee80l774CLyJDyvyg8E1m06UDZkbDUavYYV1uvzW/WJZeEZyNEp2kQsRr8Io0uoNL7lat8RDMIVq4kDqD03G8boxynbHlAYQVgow8FHpiZQF1SWNg+rXGm/boI4L75jTKi3jyl4veJNFIgaxS/a+wL4X1qOjztPZSdsYR42h0IIVFo8gIXqGOvmtD95KvKj5h6l0gSrJerC37lE38CAK1+nAqE8g+DRGGx8WdUIgnoh1S8hCLk7UwZzTizLqdr6WZXe1v8/rFalHwKNstDeBOyRSb+WYV70/vusVpVCGbgyhPB8RCsqgNmvBHYUyqM0puzCrQJxYmi9Za2PvQjYgL3eNmYnH8N8ITqFof/giIs/sYLJjteuGLBgV7VO+NeAqysNbQErek6qmwZqY9RaquRy8Oc8BYqqtPJbMjE57JGZbSWxwwWVyV5mxF5dHFPY3BbO5ewq+hS5adCg10Ao/1tQ/fLi41yEwOsZ2O7XDlNFLbeMm7FdIJSNvSfZuVSkCf2IuzXGizaVWO7E6ZpO4hYJtxdnVUQnQfbM8kgaj1IStEEC483dzp73yFxtjLhEkeZwnPxXDwGIBVu/fuXn8VYF+bp4Mteih6xjTv0CoP2Wi28GzCgp0EWWcPBkYGS7EMeL40JnXk8aoQZtJoq+a6twiusNeF0++VPHKz4TGIH5c6P+ltXxd1+VZSka9CYTXGv1GWmUwMhpxRpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(2906002)(508600001)(4326008)(8676002)(66946007)(64756008)(66446008)(66476007)(66556008)(55016003)(110136005)(33656002)(71200400001)(6506007)(86362001)(7696005)(9686003)(316002)(186003)(26005)(122000001)(82960400001)(38100700002)(38070700005)(54906003)(8936002)(52536014)(5660300002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nTAVGEuZ2xLKW7t9whWATU6ijkg/Z6FfZaG5S62ortf0iZUEAU6KVZFHTyUZ?=
 =?us-ascii?Q?JUu2qaM9ucR1cUc1g1EJDv18TUITP/2OU6mqxSKSFv6TbS7KfCamI027mDrk?=
 =?us-ascii?Q?N+BRwchzeNB4rKwZ3ncyEJPLTi1dyYIv2qYuKJQkHmNpzaxChlPm7FXXpHwS?=
 =?us-ascii?Q?F1JJeIUHGgLZR5ip/12m9qltJ1VDDo2Y0o+LMWRQqaNbFvrh602kRWQVXAZL?=
 =?us-ascii?Q?bP8N7WXSpfNu2LoXYD6zjhuk2lGmVuWV+qHgUBpgDU3JxCqNn+dbx4Zo32Ks?=
 =?us-ascii?Q?cuRB0RNTudiNCl/JZ9aQ47xPomCduPygGOXYYzDYQ+9/QYnWh6saWCGRoOM6?=
 =?us-ascii?Q?c0ZYxOEq1z/Ntlq1Q5IsTH0M+EewCocTT3R263Ys4Nl2W36W45EBM2GR/8sw?=
 =?us-ascii?Q?+gmqr1PySLyV6RBL0DY5E8dlzkxv8LEtmsAh0grCILNKkEcl1Wmofcmu/pRU?=
 =?us-ascii?Q?0e6YeMU0hwBYAZn6TMrKs0W9amIPREhfLMjO6EZrJPiwW2FgeetwOfyVLxN+?=
 =?us-ascii?Q?bIHnWx7mxk5m1UnJlzfNTxQVmndf18rw9kSkumV0XmQa0z+ynHtKeUGFpR9v?=
 =?us-ascii?Q?b+Ea3r04cUsMgovaE0BeJIRsq4z0V2eT9eF//CkPXecvn5eJoeiBauzLZ+DS?=
 =?us-ascii?Q?GyGVvFrU9LZ1srI0nLpBtwLZ/yMca5lcyfk0t2ddr0uMVRKMSd7lVjX771/F?=
 =?us-ascii?Q?0nzdnnH56w49l9jskGCFaxorzjOwRXVqKJ8YCHSq2eVIcNaTo97pgpCjAHIG?=
 =?us-ascii?Q?t79W+Q/D7Nbn7Apz7BEiYQeJW2Y7N7dE6iDSMpbtn1wD1CyDf8u/TCRO80Wh?=
 =?us-ascii?Q?P61nDL6USJAFVRKM2nysCPBC4ntLIEt4+QayJNiLrn5kLQw6Ybo25SdbpXJI?=
 =?us-ascii?Q?9EOsez41dbPfdfpcMmsK6Y+5RfAXkgaJTwLlowQ/nyPRF8V3dTtwR6mKX07E?=
 =?us-ascii?Q?nqKGbFhUVyVJp/cw89xX2gOjqftju3Te/gmtaYfoJ/V8apo8HH/1tuHGDyQ7?=
 =?us-ascii?Q?/Wnk2cPfpTw3OaqRds3983VhB68dixJIdADYYhvyo44FCII0eJ9Hjet3SGB3?=
 =?us-ascii?Q?9nqkLoF/d8wRidq2x19RU9bzDo+DnxbmWfo2OnvcvyZuRU4nAfjAXbTjNaTM?=
 =?us-ascii?Q?PfV/87VxeeK3u/7K5whf/sfdacpOviISTEvfFOpKwvgGSkSe9E0zg9WVJdaD?=
 =?us-ascii?Q?RLaaYqvRQqinF/OwReL0lW87m8skxtduTosXVAHW4Fq4jct27f8Qn7/vm4I6?=
 =?us-ascii?Q?Lxb/0OJpsDhKZkWvMOf2bPz8R9W0zCQJFqA6YIVL+/LQYqviMs4Z2nTvTB36?=
 =?us-ascii?Q?pWlRZVY5RYe/QFJU4D4fAmzlyapLYz5WzEPpN0lAr24Z459KiTsBhcOOCCpM?=
 =?us-ascii?Q?xVHN4VbFWMbimlPJpErOIkDCd7gkcANlr4HJ2VAXKk5iTXsTG6z+/mdiQGiv?=
 =?us-ascii?Q?E3Iamte8gGTj5vYh7j2n0b0stDrI+SFA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a284abef-61a4-42d3-0f86-08da08a89105
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 06:28:50.5027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyLXcb1fKMNz2RIsmkv4V+/eaZYq/oHCMJTWQCf3Ep2Spa1pH1yc8Ckd9fZbAp37xdq0y9l4MfFMRQH2jkRREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4236
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 15, 2022 1:07 PM

The coverletter is [0/8] but here you actually have the 9th patch...

>=20
> From: Dave Jiang <dave.jiang@intel.com>
>=20
> The idxd driver always gated the pasid enabling under a single knob and
> this assumption is incorrect. The pasid used for kernel operation can be
> independently toggled and has no dependency on the user pasid (and vice
> versa). Split the two so they are independent "enabled" flags.

While you said kernel vs. user sva can be independently toggled you still
only have a single option 'sva' to gate both in the end.=20

Thanks
Kevin
