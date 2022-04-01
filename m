Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5544EEB09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244864AbiDAKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245116AbiDAKNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:13:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C91945EF;
        Fri,  1 Apr 2022 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648807875; x=1680343875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3jrUqHzpUZ6P6RDmRVFOzQHdXQmwz8aUSRdfTS+i0xw=;
  b=PxxV0HEEnTd0N3tTpPBMmI2YD5N8W0XV1C25H8/1urFdtlKiL4amIzy9
   Zb3Pa1a4Ie6mrECAOXuLMGFTfAuttb+DNxqjsPrAPkGowvYsi3A8ahd/E
   S6DY//beKj/WlZlh6uc40Dg9bYXOW4h9gvZ86GQA9MEKfZ3EmG9F3Oe30
   8TRSYihQ4hYFIK4mI8SNuth6Jcx3sDiuMOpl0BnBpyI0aEF+UinKqRmzC
   g6SZlApG4K+hUAoZqWqWzn+Peaqv5ZsE571WX514PiVC+VAoxN0W4+TLU
   pWruBxvC6fTLhoA3/OiukIeAlzGLDlac8qjiNFT8Av3zXe74+EDY5+ym1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="258927457"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="258927457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 03:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="567359956"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2022 03:10:46 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 03:10:45 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 03:10:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Apr 2022 03:10:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Apr 2022 03:10:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhclSsMO1tfxvuAeJPchnMQ+wDy1qAdf7vycd2zfML98nm4ExGTcjubXOu7PWgO7td6E+sLcPT5iFOPd5FF0KxIpQW7M3pJD7OLzI4LIVB0NC6pnEeDVgkd36tf0YzAcYSS6YqjZh7NB+4WpDvW5572bDW9ia+SVLzAjBdmLiB9WftfomchZyLNN6PwazWx+u/+iND72W1mVitNqjnc/eIqO2DTYO9qDTXjRdS4UIkD6DrOe5MlxH9L+zZvdmSWBaSpFzcgjDlF3gtsctNZAE1daUOuiU3XLSz+WbNfBQw6HwAI7CsLHXrSs+Ea2AFHplBXb+efnIBmr+4YHcVVAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jrUqHzpUZ6P6RDmRVFOzQHdXQmwz8aUSRdfTS+i0xw=;
 b=im+ViYDxKhM5mcm+NEkbIPLzYAZibzlsuB8hvBHkiK1UzF+++EExryssq4VKFjC4w4eSBkAhX971Ncup6NZD5DOAbAS58psyFYrP463VPrtAJRHZwX5KxAXJgTMxDodfby+4GNHc0fkLC3EZIzddEUAYR293xay5fi0NpBsdT+HHM7TggMMFjfrZAY9uxndGbC1KPI6uyznlSyJZRgdtW5uZ3oNFCQlifDvz636bbD34HKpGiDEPs01RO9+WT0tf5Ko4sIRP3B8/qyZQXzJeEGFrc1Ut9nrkL8OupKUJpF4kGmxsN9SE+YsWw2avMfgkCgI74xmOFs4xSHEwUEzURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BYAPR11MB3047.namprd11.prod.outlook.com (2603:10b6:a03:8b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 1 Apr
 2022 10:10:38 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3%7]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 10:10:38 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] kasan: Fix sleeping function called from invalid context
 in PREEMPT_RT
Thread-Topic: [PATCH] kasan: Fix sleeping function called from invalid context
 in PREEMPT_RT
Thread-Index: AQHYRahAPBhx8+IVqEWk1xTI1Gzupqzayh8AgAAKNUA=
Date:   Fri, 1 Apr 2022 10:10:38 +0000
Message-ID: <PH0PR11MB58800917A1BF8D1A76BEF84EDAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220401091006.2100058-1-qiang1.zhang@intel.com>
 <YkbFhgN1jZPTMfnS@linutronix.de>
In-Reply-To: <YkbFhgN1jZPTMfnS@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32646faa-937f-43f3-0e61-08da13c7dee2
x-ms-traffictypediagnostic: BYAPR11MB3047:EE_
x-microsoft-antispam-prvs: <BYAPR11MB30473BAA821113939619CEF9DAE09@BYAPR11MB3047.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bEnti1Xivxyhh5bUJYsXpmoh5NJ8FbsbCKD/b2lJpyyeVE6i4d4IodzP9BvWrUt0ebOb8puv+vLQdX4TgiUL2vcSMQ0SJdeAurMt9fEGK/5JP9iTU/HGhFp4s1Xjdy20gu+dD4+GZBTxGTVzQf3fPcF3IvAGoXImsDDn6KMlGE7JMZnatc7lbwpqDHBdYZghhUdoYvSTOFnpzFYTWq5+md51U90ovrYBKLpnVOmR3+HMmsq+hE6Ccwn2aGKOteyUiFFQQUKnknTvPh62AzjUuGx8GOn2wUmGTi9KWU/5zU005LXFXJKlChOPauDKCX9Lb7A0co/Q0LZn6bvr567wAxbojg0cYf5NV2b+Kp72h2oPQV/z/W7qdb/EG/phcBnRGaWUc6ERxwZiADTNeSvAef9ohGE2TKV5AWR5r/xGmfqIyuZ5UcQ6bCvWNRzr5rfqaDtl8qv9h1HObdkZsjOjLNvf4shMuinnkAz1x3XvE8zfF3grgTqSODVfbcfyvLC04w4ozo9Z6GezCvn18Xa09R1jqDDJDhdM2FZ003tpyb6PacmDKOqAFDqQV6SkIUO6lU4rXROk+sXFZlsM4vr6jG+1jbux6H9NW0vZWa65XT5JDPDQH0ZVOg3HI/xOdkDMZkEq5E/Kk8nf6C4L/bIF/opGMJnfiHb6VmYxjLMdF+16r0NiFMSGoVMg6sE/AtVFp/MN4xa6ZPrinAUS6K1RMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(55016003)(7696005)(54906003)(53546011)(52536014)(6916009)(9686003)(2906002)(8936002)(38100700002)(122000001)(82960400001)(5660300002)(38070700005)(8676002)(86362001)(66946007)(33656002)(66476007)(71200400001)(64756008)(66446008)(76116006)(4326008)(66556008)(508600001)(26005)(186003)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk53SWp1RTdMcWxHdjZ4SThYeWw4WDVEY2d6bHRPZjduNlJhcVpGVFM5SW9L?=
 =?utf-8?B?dkNnc00vSUM3RTdKYTlkRFZtTjBDNk5DWExUUWhwVnE4RXQ2MlZFVWwxclVK?=
 =?utf-8?B?Q2FBSHNZYVE3RjR3ZkdJd1IzV3JHSWZLSVh0Y2VCcXFWQlhaMGczSVhsMnB4?=
 =?utf-8?B?TStPbEhpdXlDTE5MdmxrdjduS2plNEhSWElKLytUVUtBZitHQWVSeTFGd1NB?=
 =?utf-8?B?ZktRY1p2bWVxSElKRHhKUjVLbjBHKy8zY1A4Z0lqYWFxYytsdWVWMkVhRFhs?=
 =?utf-8?B?UDJ1ait1MlpsUmN1TGh5cWZNbXQyVjNzNzc1MTlBSFFzRWNoaGRjQTJxZzF3?=
 =?utf-8?B?NVg1ZGkwRDBPd1FHNENmdjlhVjFURkRnNDd3eW0wKzJFajJzTnhIVWptU2gy?=
 =?utf-8?B?WUw4Rk5TOFd4MHpSdlVjSzdFVmFZd0c4STZ1UGYwcGRiQWJkN3dhRDRjWm9t?=
 =?utf-8?B?YllCTzZBM0ZXWVM3NWhlTG94RmNpdUZ0Y051aldWa25oYXFCTnQ4VlUrbHJC?=
 =?utf-8?B?ODdOM2EyNlFUTFJRL0NnaGxFazUxWHF1OFIxY2FzdXMrZlZNU20xMlJrRTNY?=
 =?utf-8?B?ZTNUZndwN3dSUytYbzYrK1RDcTFjcmRLK08rdnN2dUtpUHRPZUtOMkFhMzhz?=
 =?utf-8?B?R09TWldBekpMNXJmenpvZklRYmJlUDZKY0xYRFpXMXdTVEdmdWZENitGMEpn?=
 =?utf-8?B?NGJiUUJqdE56RUZwTDJ4QXB3U0F5ekVDV3YxYTdzUXU3RytJcndXbDYwTStz?=
 =?utf-8?B?U1ZQYUZqQXZMSUR4MGhPYXlLQk5Pbk5CV0tJdStxem5aWk5jVkxKZm16MjBC?=
 =?utf-8?B?MDcyZ2NEYXZCckU5alMwVSswTTVwVXptMDZ2MkROaGdYQUdFa2dRd0UyYlcr?=
 =?utf-8?B?aUJTVDVlRXQ4SmpnV0VPaVo2MHJ3QzNtNG5VandUelBlMnh2Sit5T1JIQmZr?=
 =?utf-8?B?dWorcE5GRFdXYVdkTkZmcTAxNG44UHRhU0hyOCtuTWRWdWowR3FuTS9DQ2hK?=
 =?utf-8?B?MnlmcFRnbEo2WldmZ3lsR3kwMitZSnFGTVFpOE5KL1NDZ2dNRzVEZkxsK3hm?=
 =?utf-8?B?QVdFRGJJV00wamROd2pYREQzQXJoTGJlNStCOVFSQmpDb0lrWmVTK3hReGVO?=
 =?utf-8?B?eDQvcFNjcXV4UEpOQTUzMURKKzBMUmk1THhZRWZYOS9NeDVLNW9qUW9nWndM?=
 =?utf-8?B?VDdIMUlvV1JYaUtyUUhyV1BQRHlQaFMyWFZRTDI5VVhwOTlsbEhvVVRQRGlS?=
 =?utf-8?B?L2pUcjdWOTVCS1QxeDZ6RjdkNzYrVjgyakZmU1Z6Z09DZkVZWDQxN0F1YVVi?=
 =?utf-8?B?NEE5U3NBRnh0Q1pqRFpJV1pyck1iWHA4Y2VjeFM4alFWdmxySUhPZGFEWG1V?=
 =?utf-8?B?SUlYL2ZSaStmd3JCTU56WXVpN2pPS0Jwdmd3REEwcFBXbmVSaGpTRU5YZEpO?=
 =?utf-8?B?MVFWWWdrdGNLalVaRjllUkdYaHJKMXhsK2dlZE4zUEtocWlyK054UVpOYVk4?=
 =?utf-8?B?R3pWRHNIdkpWbjF5MmV0SDhMMVZDQytnTlhILzJtM3pQNFFCckNna3o4b2VP?=
 =?utf-8?B?dlRJaTFzSEdZVFRLS1NzaW4zTTlUS0c1QldNS3BadG9WM2lya2JTTGNUMEpT?=
 =?utf-8?B?NVExaUdCTXJuRks3cldBdlJpQy9QZytqYTdkTTRvd2F6Z2hsdGRoWkhuTTAw?=
 =?utf-8?B?N2xtOXlDeDJjTUtQS2owdWxTODNZS1FRMlFZcUJ5bnkyRXN2QkpteWJMeXpo?=
 =?utf-8?B?WngydXo3enJtYkdMTWIvVjlPMnZ6Y1drSWlVRmNWaExWK3lOeFIrRHpUc0xP?=
 =?utf-8?B?enpJNUg5SDlNL3RKRlk1NEI5aVpDSnoyUnFkNURaek00U284VDhnSG5LOGo2?=
 =?utf-8?B?Zmc1SzMyeHRQOXp2eGRDcmc1WHpka3BmMkRoK0hIdEFxT2dIeUtPYjJzNXV6?=
 =?utf-8?B?SE9VZTRpMUJIdmJZSW9FUlYremg2djFrMGlTclpnWStEL0VaajdTTjRRZDdI?=
 =?utf-8?B?VWtheFNYeHhySEtGTEJlWHB5ekdxOFdtMUR3ZFdQU3prT05GMzliT2JMR2R4?=
 =?utf-8?B?QU5EeXU4SEN1dTRGdUMraHh3NS9yeG05a3BkdTBmbDZSa2ozalZnb05nWit3?=
 =?utf-8?B?aTZuZ3hMYkxHcVBydU1KTEJHQlRDcFRKZyt6NGg0eFVzM0VuMVNwbmpqY1d4?=
 =?utf-8?B?aUtEamlUcUZpZlNvbmUrVG1wWVVielFxbENkYVNtUVU5ZnBrU0dERHV4dktY?=
 =?utf-8?B?N2NsR3VYWWpsZm5yOFV4ejVWVnVvMzlGS0l5d1hyLzJDWFNJOFN2bU9MaTlq?=
 =?utf-8?B?SUFla3R1Sk1BL0NYWWlJUWtTWjdmRUYyNzRjVTFtU2NCOEJoMEEzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32646faa-937f-43f3-0e61-08da13c7dee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 10:10:38.4185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S24SZGqBVXZzYPLz9xuvCsAC9AjVeFsfZ4TlgjBA1rNaI/PfohG8DVxwMZTsB0GH5i1+3dYr53P8od2Mr+/R4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3047
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

T24gMjAyMi0wNC0wMSAxNzoxMDowNiBbKzA4MDBdLCBacWlhbmcgd3JvdGU6DQo+IEJVRzogc2xl
ZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0IGF0IA0KPiBrZXJuZWwv
bG9ja2luZy9zcGlubG9ja19ydC5jOjQ2DQo+IGluX2F0b21pYygpOiAxLCBpcnFzX2Rpc2FibGVk
KCk6IDEsIG5vbl9ibG9jazogMCwgcGlkOiAxLCBuYW1lOiANCj4gc3dhcHBlci8wDQo+IHByZWVt
cHRfY291bnQ6IDEsIGV4cGVjdGVkOiAwDQo+IC4uLi4uLi4uLi4uDQo+IENQVTogMCBQSUQ6IDEg
Q29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDUuMTcuMS1ydDE2LXlvY3RvLXByZWVtcHQtcnQg
DQo+ICMyMiBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5
KSwgQklPUyANCj4gcmVsLTEuMTUuMC0wLWcyZGQ0YjliM2Y4NDAtcHJlYnVpbHQucWVtdS5vcmcg
MDQvMDEvMjAxNCBDYWxsIFRyYWNlOg0KPiA8VEFTSz4NCj4gZHVtcF9zdGFja19sdmwrMHg2MC8w
eDhjDQo+IGR1bXBfc3RhY2srMHgxMC8weDEyDQo+ICBfX21pZ2h0X3Jlc2NoZWQuY29sZCsweDEz
Yi8weDE3Mw0KPiBydF9zcGluX2xvY2srMHg1Yi8weGYwDQo+ICBfX19jYWNoZV9mcmVlKzB4YTUv
MHgxODANCj4gcWxpc3RfZnJlZV9hbGwrMHg3YS8weDE2MA0KPiBwZXJfY3B1X3JlbW92ZV9jYWNo
ZSsweDVmLzB4NzANCj4gc21wX2NhbGxfZnVuY3Rpb25fbWFueV9jb25kKzB4NGM0LzB4NGYwDQo+
IG9uX2VhY2hfY3B1X2NvbmRfbWFzaysweDQ5LzB4YzANCj4ga2FzYW5fcXVhcmFudGluZV9yZW1v
dmVfY2FjaGUrMHg1NC8weGYwDQo+IGthc2FuX2NhY2hlX3NocmluaysweDkvMHgxMA0KPiBrbWVt
X2NhY2hlX3NocmluaysweDEzLzB4MjANCj4gYWNwaV9vc19wdXJnZV9jYWNoZSsweGUvMHgyMA0K
PiBhY3BpX3B1cmdlX2NhY2hlZF9vYmplY3RzKzB4MjEvMHg2ZA0KPiBhY3BpX2luaXRpYWxpemVf
b2JqZWN0cysweDE1LzB4M2INCj4gYWNwaV9pbml0KzB4MTMwLzB4NWJhDQo+IGRvX29uZV9pbml0
Y2FsbCsweGU1LzB4NWIwDQo+IGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MzRmLzB4M2FkDQo+IGtl
cm5lbF9pbml0KzB4MWUvMHgxNDANCj4gcmV0X2Zyb21fZm9yaysweDIyLzB4MzANCj4gDQo+IFdo
ZW4gdGhlIGttZW1fY2FjaGVfc2hyaW5rKCkgYmUgY2FsbGVkLCB0aGUgSVBJIHdhcyB0cmlnZ2Vy
ZWQsIHRoZQ0KPiBfX19jYWNoZV9mcmVlKCkgaXMgY2FsbGVkIGluIElQSSBpbnRlcnJ1cHQgY29u
dGV4dCwgdGhlIGxvY2FsIGxvY2sgb3IgDQo+IHNwaW4gbG9jayB3aWxsIGJlIGFjcXVpcmVkLiBv
biBQUkVFTVBUX1JUIGtlcm5lbCwgdGhlc2UgbG9jayBpcyANCj4gcmVwbGFjZWQgd2l0aCBzbGVl
cGJhbGUgcnQgc3BpbiBsb2NrLCBzbyB0aGUgYWJvdmUgcHJvYmxlbSBpcyB0cmlnZ2VyZWQuDQo+
IGZpeCBpdCBieSBtaWdyYXRpbmcgdGhlIHJlbGVhc2UgYWN0aW9uIGZyb20gdGhlIElQSSBpbnRl
cnJ1cHQgY29udGV4dCANCj4gdG8gdGhlIHRhc2sgY29udGV4dCBvbiBSVCBrZXJuZWwuDQoNCj5J
IGhhdmVuJ3Qgc2VlbiB0aGF0IHdoaWxlIHBsYXlpbmcgd2l0aCBrYXNhbi4gSXMgdGhpcyBuZXc/
DQo+Q291bGQgd2UgZml4IGluIGEgd2F5IHRoYXQgd2UgZG9uJ3QgaW52b2x2ZSBmcmVlaW5nIG1l
bW9yeSBmcm9tIGluLUlSUT8NCj5UaGlzIGNvdWxkIHRyaWdnZXIgYSBsb2NrZGVwIHNwbGF0IGlm
IHRoZSBsb2NhbC1sb2NrIGluIFNMVUIgaXMgYWNxdWlyZWQgZnJvbSBpbi1JUlEgY29udGV4dCBv
biAhUFJFRU1QVF9SVC4NCg0KSGksIEkgIHdpbGwgbW92ZSBxbGlzdF9mcmVlX2FsbCgpIGZyb20g
SVBJIGNvbnRleHQgdG8gdGFzayBjb250ZXh0LA0KVGhpcyBvcGVyYXRpb24gYW5kIHRoZSBuZXh0
IHJlbGVhc2UgIG1lbWJlcnMNCmluIHRoZSBxdWFyYW50aW5lIHBvb2wgb3BlcmF0ZSBzaW1pbGFy
bHkNCg0KSSBkb24ndCBrbm93IHRoZSBwaGVub21lbm9uIHlvdSBkZXNjcmliZWQuIENhbiB5b3Ug
ZXhwbGFpbiBpdCBpbiBkZXRhaWw/DQoNClRoYW5rcw0KWnFpYW5nDQoNCg0KPiBTaWduZWQtb2Zm
LWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQoNClNlYmFzdGlhbg0K
