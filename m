Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE64CB6DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiCCGTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiCCGTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:19:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBE149B95;
        Wed,  2 Mar 2022 22:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646288296; x=1677824296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ezndGXnGVL5Bo1+k2I9CnukxO/tVey7aoiQolX+6KlU=;
  b=RAQNfkyZShmOEZquk/xRJqIoj48QViLY9TQSKRQT11I+dq8DAAzlI2qR
   Y4tDHNm+To0mtJ6pUs62F3AEoOWcaZfHKITwl3R3mSwryqsutOI2petm6
   WX5czof/uJ0CCjpYoxE9Q8bchZMnVxRMgtNjueKx2FWQT01Vwh5M7Gfrv
   3IoRmIrhKCXa6ccmpDHD6RwDib23E2y6wfhG7D+IHRND4jeWYhaX9iHRK
   Aj+6CE26/LHoBodbXAA3TBGj+fOjc90kcH8pBOql/9Nwh93G1HsIcJJLp
   /465FK0SFjDggheXBsR323iqOeKYxg4JGi4HVacTAp3QVnkygahwJddz/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="237100390"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="237100390"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 22:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="508472919"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2022 22:18:15 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 22:18:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 22:18:15 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 2 Mar 2022 22:18:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDicBdOSkxUQKHlf8yel3rIG8+tx2Do75LNNcGFT1clXQutitvrCgzv2huVIHN2Re2Am+bR75YSiehbfSp2bPoWShuaIQgukkpqLSIQ6G5HbWHn14b7TmKMVDGFb/D0ro0b4QmazthIB/7mwu1ioD5dgY2JsjLxySZz9ytGUVycs1irVZqwlLTr+ABfDrpIHcXlg2YQoXMtx76EnfCAldVNUDbjMl43t90I9qB454YTcrQu6lp0S4G8kSEr1VWqBwdnxBFtQAW2CMKbECRcUMNr9KFHGbhNsWPyn1L0mWO11EkexiITDlg0hz4sahtBthdBvZ4f8SZBrjyUmWry6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezndGXnGVL5Bo1+k2I9CnukxO/tVey7aoiQolX+6KlU=;
 b=mkUOcVT22JgC410BD4ip5dobdjSiBozHWA/dC4QuxykU2T3EhmTipLYoX3ePT1fNtjD1+X/vNTo3yehqXDP80p1WMOniZd9nrczON5/UeKuTgxhHOhVy+2wAkaADVdii8zwimvgQfZwTuMh5YcQ6fSZxT1lx2pCtGkhUAdzGLKgIrunCNg4sgCUo3ObJrZg9XwZUyOiCfZdnZKw/LWrtxF7aX6LAP547kIrp8LMQjMp800UrgYTa1HOdxywfi6wQNu+7v4XxB1L8Pt9tog/Rw6kwJRIut3O6Pg+XPjFE2n8ci1MI0oDQ6/sl2Re/9PRW5HylwR5MDIOQ4vy5eX8I5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) by
 BL3PR11MB5730.namprd11.prod.outlook.com (2603:10b6:208:351::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 06:18:13 +0000
Received: from DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::d4c9:5841:3761:6945]) by DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::d4c9:5841:3761:6945%4]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 06:18:13 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHYJ9KVLj3sL+vmrk6q1BhORuJTLayrEYYAgADLt6CAABJ2AIAAXvPggAAGSICAAOWKwA==
Date:   Thu, 3 Mar 2022 06:18:12 +0000
Message-ID: <DM4PR11MB554994532B3D128F85553C38F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <23f86de0-3869-ee22-812d-ba610bac48b3@linaro.org>
 <BN9PR11MB55458A882EB4A681C4A63B26F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <3ff11b85-249f-2f47-cbc4-41d2ab6d168f@linaro.org>
In-Reply-To: <3ff11b85-249f-2f47-cbc4-41d2ab6d168f@linaro.org>
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
x-ms-office365-filtering-correlation-id: a9050d6f-8287-4558-8756-08d9fcdd98d8
x-ms-traffictypediagnostic: BL3PR11MB5730:EE_
x-microsoft-antispam-prvs: <BL3PR11MB5730425A4B69822EEE78BE27F1049@BL3PR11MB5730.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WeIgDvJbKj/K3Ix+TrwxEVqluAXZjVHnc2F+FgsTw0v4anpvw4upQup1eBPd/tLoh/LSWxyRwCmgjaBYSJ1nmqk9Y6xVL6PMPEY3e2jE2aPE7d49f8Xk4KuUyfAzVRIxocEfGLPpd+p2wHw0I1uD4moDc8HCo5tC6glfNz7YkP0i2eTvAGA/QTCK0hfzUW1BZs1VLrPIBQFVflUI/QbAF3Epok0YuJxNXJU3I6PfMZPPplYD8U+zRjjFesr/Y6Nx/U4J/UaJ73YuwVpCBMo849mqM8syKwWYHWmZ4XPk8jDBAtpZcZq05EMHG6aPhGpUDH3P0saMzmu7lrOcGdEm8DXqyuMCW52JKERkhXN7jr8c7UfssB/XOjyYAaIhr8hgoczIs4XEo7dnaAcizESt+R/Bmi4LbNev0gof83+H3hvU/+TlJO8qyw8ggWQZsaZE5STnhXiI5TDJo/DJn8ARBHcxLSrTR3DwHntCdngzeBM+/sKCEKzESeeEopwUhBUFOFsUP6inuo9Yr7Mk6erh2R+DsNPlpGg1CUEPcvCElkjAvhc5FPwFP419L0Ri6INDiWkCtXj9+PUXKEq9AXEibrpb1aqUE5QjuMH5n/3SsLImRldylLrttOzvMwKYDn7GFn0s/W8vjR8T9Q78/x5dDtPnFAvs/i1FcM0tBVAnnEwNO2gIb9N7GsYgzQcATzLG52f6qms6lnYzomM5xhKC6V2Qmk9JlOxqTg6nBtBpvXqS1DNtIYfo/JwUAZfPiIDdVL09UCAHlaDnuXDeGJ75ZDXvUcJQk1RCZbWCEz5zPswSuyX//m7yU2/xJhVCurFlr2V1dAl7Ugk0aiUGeWfF0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5549.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(7696005)(6506007)(33656002)(52536014)(8936002)(5660300002)(53546011)(82960400001)(86362001)(9686003)(8676002)(4326008)(38100700002)(66946007)(122000001)(76116006)(66556008)(64756008)(66446008)(66476007)(316002)(26005)(186003)(55016003)(110136005)(83380400001)(38070700005)(71200400001)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjNiRmttODFXa1lvMVdPdUVJbWdkRWlTdzVRWFVVbHFOcHpEK1lQc0xrZ1dJ?=
 =?utf-8?B?dDBPNU5GR2FETE1EL1M0bnh4ZzNhbTZSV3J6ZzQvOWxiTUNlL2ZrUG1wZHRE?=
 =?utf-8?B?ZHI0RXkyQ0YxVnAwSjc3VlNEZDBZZVJ1OGQvcGFWbGRybi9WSG5kc2JNNncz?=
 =?utf-8?B?L1Jrd20rTmJwNi9BTUo0bS92RmtVNm5TUmpJRDVuNTltVVhnTnRaS1VScTVD?=
 =?utf-8?B?S1hwakgwVzFRN3dKT2w3UzlJRC9iRzBzYndHMzUrTUk0ZGV6dUdkSGhqeDZv?=
 =?utf-8?B?bVJ1QWxHRGlIaUJwYllJdVU4UGE1aDM2NTEvc2hWMmpPbC9IYkZXanhWVGRQ?=
 =?utf-8?B?SUg2UCtIbytjSjk1UUVFemt2SzU0eUpxZksrbGo1WDU0SW1zWm1ZRXIrVFZm?=
 =?utf-8?B?YnlnZ1NsRUovT3RjNkRka0VjZUZZbEFQb0ZTdWNaQ1pzczg0c0pReWVlUWFH?=
 =?utf-8?B?WU56YVE1b0tNU0E3YXVhaXlFRDZLUmt5SUlLSjRBdU5zR3VJcWR0eC95OENK?=
 =?utf-8?B?RWV6UEFFejAxM2F4M3FkZmhhejhvTHdqekVTYW0vSkw4SFowdFF5WFVyLzZt?=
 =?utf-8?B?OUtQM1pFc3NFTVArWmtOSEVzbGdtRDkwM08wUjRvSGVnYldPbC9GUHlaaHNN?=
 =?utf-8?B?WUZpWnkrR0lXSU5wSU1ZbmdnZENJOGxmNHlEUUpONGxSdWpFOERpSDZTdFZz?=
 =?utf-8?B?bGtsdkVPNHdPcTFYM2hneHBUSjhQRkJzS0RMN0lJWUpEZFZ5SUIzekdLZzZE?=
 =?utf-8?B?aTJzV0VGcndYc1hLRlBRVlhTaTZsT05SUkQ2QTFYTmxIUVgzc0dINS9CYkxo?=
 =?utf-8?B?aVphcHhoMWtHdlJIQ3Vuem8vbFkwZG9Namk0dDI3N0lMWjlsRWVmbzZ6c1A3?=
 =?utf-8?B?aEU2OG8rYmNVR0o2WUN2aHAyRys0VXlZTGJXVmFRc29NakR3aHNPRlRzS2xI?=
 =?utf-8?B?OVVjM2hlK25jek54QUVnOE9ENjZsTTg5aGZFRXFaWFRUZENHb2FuQk50WW1X?=
 =?utf-8?B?ZnhndHVZaFJFWjlCbHVPbDBBR3hFQ0k1dWdpTzdScE1Yb25PMFkxNFpnUWQw?=
 =?utf-8?B?dWtSRXZ1eGRYa1JjdU1TZ2o3eW9SNDFkdGtpdmxOZ25uQXJ4cG9HYy9ZR3pn?=
 =?utf-8?B?dzk0c2tGMzdUSDdkSXhrSnB6Mm1ra3Boand1WGtNU210c2NBTXZiYVBWeURL?=
 =?utf-8?B?aEFRZTRCWGlmVi92ZGw2Tk1xNHJub2VXT0hDbSt6WnNTYmxOeHVxQnhTclpo?=
 =?utf-8?B?OVg4dnBEelAwRklOSFNtaERvcThzNWUwVm01L09HdHdsU1FnamVNa2w4Q01V?=
 =?utf-8?B?RllKSkVvRzd1R1lrM1JxZFM2NS9rSCt1bW1UUWl4QjhQdnJDZGJtcnFUeGFa?=
 =?utf-8?B?OVNBU3doU2RwOUE1WVhVTklWU0w5WFNMSXRNaGpjS2pLNEE1eUNlVnRrc1kv?=
 =?utf-8?B?ZkpZOW9qNk5RZkRtNzNlVXNTNjNzKzhnK3lLbFE2amFLcFc5bEg0ejViNVkr?=
 =?utf-8?B?VUpBV3pXR0dpMlFCR2hrTFB1ZEdrMWEzTkN4R2dzK2JmVjRjZU1NRCtVSktl?=
 =?utf-8?B?K3lFaTM2Z1hJZHRzOGNNSGczbmZBbDdlUVByWWhTTGN1TnhoM3I4QlMrZUFy?=
 =?utf-8?B?MjNwTnc2TXN3ZktOcXQ5MW0rVGdubWFWcGpSTm1pblBFYlFMWTFwMFQ5M1Y3?=
 =?utf-8?B?MTRTcXVxa0hjSytFbjdmbjhKQ0p0MGY4Tjhyd3hTRUZBTitkbjNDZGtvQkVa?=
 =?utf-8?B?c3RzeXVCTHAzaTBLMkZvSFZQY1RZMEVkeEJuWURLWFE1Q3VIN3NpeC9laDlI?=
 =?utf-8?B?aDFjZUZJYVU0Z2FCb24vNXIxNlR5d25VTFpROFdVeFN6c3p1dCtJKzVFcHNm?=
 =?utf-8?B?cXlnNnY0TllvZWJoTkc3WE1ZSHpubFk2aXBFNnVXOGpUMTMweEMxdmJMMVp5?=
 =?utf-8?B?bEYxR1dGT2xFQi9KaGdqWUlmSkFrdDROSzlUYzRRVGorNzREL2kyRnIyREpJ?=
 =?utf-8?B?eGtmUmlwSlFXZk1jUlMwZmpXa1NZa1BBWm1sSExtbTdyVjEvRFArUi9jVlhO?=
 =?utf-8?B?dXFhN1VjQzN1M0RPcHpuREdrT2R4eTFPL2ZwQlR2M3VVTklnU0ZBOWJ5RllF?=
 =?utf-8?B?a0duUzBSTTdlc1QvSTM3Sm4xcFNZamhOREpXN2p6eDdLM2haNTBJK2dqamhT?=
 =?utf-8?Q?SxuROZgHT/cHxh7zCMcDAiA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5549.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9050d6f-8287-4558-8756-08d9fcdd98d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 06:18:13.1466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Th9FhbsqrWyPGe+oa32khX8w5JLlFL8XyewPkcGujsaxAi1reB7hJhzmmPLbIuMCQUnNJLwLiiGSCaCJ7FF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5730
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KUmVnYXJkcywNClNocnV0aGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBNYXJjaCAyLCAyMDIyIDk6NTcgUE0NCj4gVG86IFNhbmlsLCBTaHJ1dGhp
IDxzaHJ1dGhpLnNhbmlsQGludGVsLmNvbT47IHRnbHhAbGludXRyb25peC5kZTsNCj4gcm9iaCtk
dEBrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29t
OyBtZ3Jvc3NAbGludXguaW50ZWwuY29tOyBUaG9rYWxhLA0KPiBTcmlrYW50aCA8c3Jpa2FudGgu
dGhva2FsYUBpbnRlbC5jb20+OyBSYWphIFN1YnJhbWFuaWFuLCBMYWtzaG1pIEJhaQ0KPiA8bGFr
c2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+OyBTYW5nYW5uYXZhciwgTWFsbGlr
YXJqdW5hcHBhDQo+IDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY4IDIvMl0gY2xvY2tzb3VyY2U6IEFkZCBJbnRlbCBLZWVtIEJh
eSB0aW1lciBzdXBwb3J0DQo+IA0KPiBPbiAwMi8wMy8yMDIyIDE3OjA3LCBTYW5pbCwgU2hydXRo
aSB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0gRnJvbTogRGFuaWVsIExl
emNhbm8NCj4gPj4gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+IFNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMiwgMjAyMiAzOjU0IFBNDQo+ID4+IFRvOiBTYW5pbCwgU2hydXRoaSA8c2hydXRoaS5z
YW5pbEBpbnRlbC5jb20+OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+ID4+IHJvYmgrZHRAa2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmcgQ2M6IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsNCj4gPj4g
bWdyb3NzQGxpbnV4LmludGVsLmNvbTsgVGhva2FsYSwgU3Jpa2FudGgNCj4gPj4gPHNyaWthbnRo
LnRob2thbGFAaW50ZWwuY29tPjsgUmFqYSBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkNCj4gPj4g
PGxha3NobWkuYmFpLnJhamEuc3VicmFtYW5pYW5AaW50ZWwuY29tPjsgU2FuZ2FubmF2YXIsDQo+
ID4+IE1hbGxpa2FyanVuYXBwYSA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVsLmNv
bT4gU3ViamVjdDoNCj4gPj4gUmU6IFtQQVRDSCB2OCAyLzJdIGNsb2Nrc291cmNlOiBBZGQgSW50
ZWwgS2VlbSBCYXkgdGltZXIgc3VwcG9ydA0KPiA+Pg0KPiA+PiBPbiAwMi8wMy8yMDIyIDExOjEy
LCBTYW5pbCwgU2hydXRoaSB3cm90ZToNCj4gPj4NCj4gPj4gWyAuLi4gXQ0KPiA+Pg0KPiA+Pj4+
PiArCWlmICghKHZhbCAmIFRJTV9DT05GSUdfUFJFU0NBTEVSX0VOQUJMRSkpIHsgKw0KPiA+Pj4+
PiBwcl9lcnIoIiVwT0Y6IFByZXNjYWxlciBpcyBub3QgZW5hYmxlZFxuIiwgbnApOyArCQlyZXQg
PQ0KPiA+Pj4+PiAtRU5PREVWOyArCX0NCj4gPj4+Pg0KPiA+Pj4+IFdoeSBiYWlsIG91dCBpbnN0
ZWFkIG9mIGVuYWJsaW5nIHRoZSBwcmVzY2FsYXIgPw0KPiA+Pj4NCj4gPj4+IEJlY2F1c2UgaXQg
aXMgYSBzZWN1cmUgcmVnaXN0ZXIgYW5kIGl0IHdvdWxkIGJlIHVwZGF0ZWQgYnkgdGhlDQo+ID4+
PiBib290bG9hZGVyLg0KPiA+PiBTaG91bGQgaXQgYmUgY29uc2lkZXJlZCBhcyBhIGZpcm13YXJl
IGJ1ZyA/DQo+ID4NCj4gPiBOby4gVGhpcyBpcyBhIGNvbW1vbiBkcml2ZXIgYWNyb3NzIHByb2R1
Y3RzIGluIHRoZSBzZXJpZXMgYW5kDQo+ID4gZW5hYmxlbWVudCBvZiB0aGlzIGJpdCBkZXBlbmRz
IG9uIHRoZSBwcm9qZWN0IHJlcXVpcmVtZW50cy4gSGVuY2UgdG8NCj4gPiBiZSBzdXJlIGZyb20g
ZHJpdmVyLCB3ZSBhZGRlZCB0aGlzIGNoZWNrIHRvIGF2b2lkIGluaXRpYWxpemF0aW9uIG9mDQo+
ID4gdGhlIGRyaXZlciBpbiB0aGUgY2FzZSB3aGVyZSBpdCBjYW5ub3QgYmUgZnVuY3Rpb25hbC4N
Cj4gDQo+IEknbSBub3Qgc3VyZSB0byBnZXQgdGhlIG1lYW5pbmcgb2YgJ3Byb2plY3QgcmVxdWly
ZW1lbnRzJyBidXQgKGZvciBteQ0KPiB1bmRlcnN0YW5kaW5nKSB3aHkgbm90IGRlc2NyaWJlIHRo
ZSB0aW1lciBpbiB0aGUgRFQgZm9yIHN1Y2ggcHJvamVjdHM/DQo+IA0KDQpPSywgSSB1bmRlcnN0
YW5kIHlvdXIgcG9pbnQgbm93LiBXZSBjYW4gY29udHJvbCB0aGUgZHJpdmVyIGluaXRpYWxpemF0
aW9uIGZyb20gZGV2aWNlIHRyZWUgYmluZGluZyByYXRoZXIgdGhhbiBhZGQgYSBjaGVjayBpbiB0
aGUgZHJpdmVyLg0KQnV0IGlzbid0IGl0IGdvb2QgdG8gaGF2ZSBhIGNoZWNrLCBpZiBlbmFibGlu
ZyBvZiB0aGUgYml0IGlzIG1pc3NlZCBvdXQgaW4gdGhlIEZXPyBUaGlzIGNhbiBoZWxwIGluIGRl
YnVnZ2luZy4NCg0KPiANCj4gPj4gLS0gPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5v
cmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvcg0KPiA+PiBBUk0gU29Dcw0KPiA+Pg0KPiA+
PiBGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4g
RmFjZWJvb2sgfA0KPiA+PiA8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRl
ciB8DQo+ID4+IDxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLSBibG9nLz4gQmxvZw0KPiAN
Cj4gDQo+IC0tDQo+IDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVu
IHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MNCj4gDQo+IEZvbGxvdyBMaW5hcm86ICA8aHR0
cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8DQo+IDxodHRwOi8v
dHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwNCj4gPGh0dHA6Ly93d3cubGluYXJv
Lm9yZy9saW5hcm8tYmxvZy8+IEJsb2cNCg==
