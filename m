Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A33563CAA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 01:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiGAXHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 19:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiGAXHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 19:07:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F136F378
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656716851; x=1688252851;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=yAFkjqp65vGq9TyOlwqax/ouugB0SXICT8VQS1JhWmM=;
  b=RQvBJHxWg7WZ7lZ3XQQtvUnPPexhy5XiLffcOehPkEONdcxCV79wKFME
   zprR/Cw9SzLyFY67UDTCPk/lSBwYxcWnPWG2nMoVLOJNfKJ0NHilNoGPm
   Te2pkLTksKhsScqYqMdHrShLJTP9YgHGBFE30fD+rBwz5lPJkpB2WDrgz
   r56gBnd82fIfcMnwhnpyclcUYesxuSE1HEUVrNTumgIagKFNmOUfcVDLc
   ykT2ugXxWMX+tMpi8ThPl+ZksH0VOVfivOeeXT+8D4PCTC6uQi5g+llfp
   Nvc5EabA6OxeTXngY6WR5Pzm8OzSujeQjHLRYZxVWBuo8FPWe7r91sFlf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="283492785"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="283492785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 16:07:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="648525901"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2022 16:07:30 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 16:07:30 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 16:07:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 16:07:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 16:07:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAgN/Xr4QWKIRamAQ9osY21W9jGqvBrLxK72G0ScWZo3JwCfIgSCHF4N8o5Yue1ORDW3OuTvOIBVj2HSinjw3lZiH+2q1oPkNnsWkD63B6rgxjx0CC/zxP3b7QqC9mnk+paQ61pe20XQ728YC+0dWu3OVduf4e86zwWrcHPgYXMbRo9kNgFYO0IYfmMxWCg7t/+HmN3npXOud+Shm2LN/b7CLGRu7F8dlLPYEl0S7azeOCKjttk/aFhzm8fo/YLfBrx8HTHXxjdelDCECEX6nMrBWliexCWI30nVptM754e888kG0mtwgcQRhGXbupurtQy+eLAkUZy1jPZiKkrvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAFkjqp65vGq9TyOlwqax/ouugB0SXICT8VQS1JhWmM=;
 b=FW+FC94bLNdOQzX9g7ZMk2Wmhah23d/dwVZu9Bh9J9MRZ2RuqhVx5qdKVw95cqKu7qO0640SfJ0Z/KWtubrWm+7GoEOKFxwumGidxD0MkvS902FQOqXG8g2aLD8I5gY1aLavVb9fmw5qcqCXaXDeAWBPGtpctI+8rZolvTQDn1EXZtpTsI59esIfdZBHnqS+wiacH7F4g31JD8d3EiiXqmfBB9dyfecz2XgV9CdBEFX+3/oZm/t1bC0aayrxfkVW+26FysBHGz50sQ2o/lwCbZhIv/ewYnjCu8s8pjnlD3hWZwamxPVUGsKg0ExK59DHJr2QbRJJ9tcYZcBjunIUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by SN6PR11MB3088.namprd11.prod.outlook.com (2603:10b6:805:ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 23:07:27 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::61f9:fcc7:c6cb:7e17]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::61f9:fcc7:c6cb:7e17%5]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 23:07:26 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] nvdimm fixes v5.19-rc5
Thread-Topic: [GIT PULL] nvdimm fixes v5.19-rc5
Thread-Index: AQHYjZ9UlHqcwwuC2U6IO4LPOjcYYg==
Date:   Fri, 1 Jul 2022 23:07:26 +0000
Message-ID: <02c021ee6306877ea63d6db0a314564ac7843882.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2 (3.44.2-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7eba9b8a-eb16-4b16-693c-08da5bb67737
x-ms-traffictypediagnostic: SN6PR11MB3088:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NIYX/JXkGWVZ/VdCsTJ5AruX8rhE3NO/7H3EHmdKGpL/7RZi4wilb5i28MFqDVyHn5nBKDDZDeDiH9XNhca5MnlD2c8GAcUhN7Ixev0T7C+va1GR6YdLXdwCjEiTKZsbOI1PEK1JD5fkC/12U+b/DUCES9tIvOzvcd+QkaKNGrUErvpZlCrD+VJGsO8Xux+ZLmjjledRm/G0wpBr+unmImpD67cVzW5gG2M7WQE8n/nfLsP0WbSI5LwarGR4qlrANmQBxW7cYf+Z1S3LIU/MKf129pncdZDXMbuTbz3oHhkT4/+aJE7MtU/d9vJ3q0LigcMCwLP+514dbUmH2YUpgSXomcMoN5Yx0qcB9TE4tgsIwhVtuWJytO07vPWN+zYS7OnD7T1B2sVsk77kJ8aBG4bNhKHJZ7LfpQyjRlAHfgGHV1U8AQUnJLGEQ1gqVxFlKuGbLwXJUoVpBWHY/IhN3cAs28WikJ+tg7bDZNM3dmI7Z50vwayJAc1uIQZnztBcQxfHhtSHZ7aZKWg/q5fcsPg2UEJugW/7MUGIJF9/O+CnzeC9wawVsb6GZXXPAlbd8emDSRd9qxifJJ8xAsHhPlNR6q5xFw5VRUBm5b2u09nOmSU0RFYSUIoAi7B3l8bTVnZv5n3urKfkabKy4lsubdYe0uL3pjaoZZyf0iT5gqdJ3Ydtlo/ZijmZiZZXSak+Bqpy5Pg4KIt2HCUzpbPibtrPjc3r68XRd1po+GTj8rc23b8ntKyVsaduR0MehclkKABy2gdYN5qcSdGbXJFxOncgpZwNP4weyzXyljb6q4qlJLbPcp7qb5l/LNMtOYd8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(366004)(136003)(346002)(4326008)(2906002)(64756008)(76116006)(8676002)(71200400001)(86362001)(91956017)(66446008)(66476007)(66946007)(66556008)(8936002)(5660300002)(316002)(54906003)(36756003)(122000001)(26005)(478600001)(82960400001)(41300700001)(186003)(6512007)(6916009)(2616005)(6486002)(6506007)(83380400001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkRFQXpUb011T0pIdzM1WHk4M0ZMWkhNZWpOMjU3aU5nWVVGSEw2bzNyOXZI?=
 =?utf-8?B?RzBBOThLWXVYbTRuK1phRnBDa0t3cDRUZkg0aTNDMmp3QS9WVG5tblFVbVZQ?=
 =?utf-8?B?bVFYSmVFZTNIOVp5aGhiK0Z1NUZSSkhRdE5qWUE5R0FTQnAvdE9JT1VFZnlZ?=
 =?utf-8?B?K1VDZ2t4aDVqVWJMQXlBVWV0SCtjckNFa2dYL21VWFlvcFZFeUdTS3lpc0dt?=
 =?utf-8?B?V1JYU1pYc3l1c3RoaVZFNlNuaU13YTZsNVpUNGhMNzhsZ2VYem5YZ1UxUTRC?=
 =?utf-8?B?VEdvTk9vYmFRaVppckorS1NjbFdCYjZyNmpFN25MSmgrNVc2aFIrVk1RNGFk?=
 =?utf-8?B?eFVsNklub0FkYVpqOWFkMTRtRDFoMUN0Y0pTS0N6aEM1NTA0UzVnMW8vLzlp?=
 =?utf-8?B?SEdKdnZ5TFVZa1RZR3M2N2FiU0lLVUZuS2NhK1dsUktVRDVVcTlTYWdPNWhn?=
 =?utf-8?B?UXdtQldKRzh3aldWQlVOcGdjcEc1N3pVU25HWU9FS0NEQ2RZYzNxU0hvM1A4?=
 =?utf-8?B?YlY5RUJwYlJOR2tHY05IcFgzdTlaUnhKYTJDbmtUT1hGQWh2OEswYjEyWWcw?=
 =?utf-8?B?dkVhQnVXNit1MEZNMjJYeWw1QktQUm1NN3lhMjhIYm9ueFFIekFWNFZQZTFL?=
 =?utf-8?B?bmZwd1dJN1hRdFlEQm5DUFM3M3k5YitscFJPMDhLc2dXY2llYk5zSFRNZWxI?=
 =?utf-8?B?UlI1N0dFYlFmVlo4aEg2d29qbDdsNFBSUWc4cWtPL0VJN0NUUFY2VWV5ZjI0?=
 =?utf-8?B?Sy8xbXRnMkpkTlFqS01rYmw4Q1Q1R0dWU2kzaEZVeUhSN1JKZThlY1dWTlIy?=
 =?utf-8?B?bGZyMFRZODlyc0QyYjJaK095dVNSQ2poVmVBVi81RmtVOHh5Z09QbDdGSHZU?=
 =?utf-8?B?aVhNQU94UTdLVXRZeUNrSVBQYUJCdzBJZFNQSVV1dEMwb01GOW1yeEJEMDNL?=
 =?utf-8?B?M2xqUTFnSVkrN1hDWG0wK09IVDdFeXFDY1JxWU04M2FxbEhpb3lzV2REcVNz?=
 =?utf-8?B?Skw1S3cxK3ZWMllrSFptWjBFL0tyZ0N6SUtNT1hGWTRveXBQK0tMR21iamwr?=
 =?utf-8?B?OUxSanV1dnVyZzRRZFZBL0czVFBMeUtKbWhwZm9HbGJSeEtTV0ZNSitpUFpP?=
 =?utf-8?B?anlwdExPdFV6Y0dCdmVWMTMzdHN6R1lXQ3l6cnJ5QzdBbnVsVlFib0tydWFh?=
 =?utf-8?B?cTdyNlBJMk5RNGhYdW5Ib2tBa2dsdE9lS2RxUnRqZy9VQmU4NmwxbTlwTnM5?=
 =?utf-8?B?S2FZZ1lHMmxweVlNeTBveFhVU0hPRkpETHJDK2M1ekhCOXhZR280UmRkRXJY?=
 =?utf-8?B?VDZYU1NZa2VqeFVOcWRINEdLdDB4SlM2TVZEQWtYMGRqMDNNaDB5ejlNTTFn?=
 =?utf-8?B?L0d5ZllOY3FXMTBDYXh0aGNaalZEbHdUK3JyV25Xa2ZtRFk3WjIzdFpXU2hp?=
 =?utf-8?B?WlQrUDNGNGRYb29YNzVuUHpFRXRrN0tQd2ZxUTBGajg5Z2w3UGxtT0IxcnRJ?=
 =?utf-8?B?a2JIR2tRWGxIT3ljWjFSMUhqb0xhTW5pa21HUCtEYVVndmRpWnJuMUtTUTBJ?=
 =?utf-8?B?V1prTStIRlpNRzJvdnUrazR0R0ZJSlBodU5ldnJMMVhNR2dvcGlMZk10cnNm?=
 =?utf-8?B?Nm82b2pRZjNkQzZKQ25jWG9kWmY4WTVpb21nYm1CQnpYdFF3UzJPZW1GWjFT?=
 =?utf-8?B?a0prUktteG15bG5hOHFoK2tteEdmNnFYb1AxRnVUb3pDWEVsVFI4WlNYam1t?=
 =?utf-8?B?N3hHSFQ5RW81VXRvWkxQTXZ3MjZMYlNVdzR2N1BJVkpaR1YvRFppWDl4YkEz?=
 =?utf-8?B?Yi9qRVVtblZUNVg0UHBacmw0Y2Q1YXQ1MlVtY1ZYOWFDQzdlLzk5WUxUcnk3?=
 =?utf-8?B?aXpzRFgxRVdsYTJIcHVvWlpjbGwwbkk2WWs3THQwT2tyMFEyQkN5RTZRZHhU?=
 =?utf-8?B?cXJSZG1HU2Exdkk3bHkzalBvK3NEcGZ0Rm9zQmJlc3BwQ0IzUDlpZEdnVjI3?=
 =?utf-8?B?UXB2TEp6bittMENWNnVySXZSSmFmN2N3M2h3dWN0amwxbmVIRWk1ZnlkNXMy?=
 =?utf-8?B?Z0xjK202emFvRFJxbmRoYlEzemVDYVNFc0tkQ1RZT1pQNmRkeUZOZ29SOXJv?=
 =?utf-8?B?WEM4ZURVSTdlY04zSU15S1pnU3J1VUdIOGdxaDhrYk5HRXprOEdYMkttMVlk?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DF3103888C0B14D89A1780BB69122F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eba9b8a-eb16-4b16-693c-08da5bb67737
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 23:07:26.8485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PAWD8CaW+AIXEIkigl/Idoy8n0y9lgxl8Pp3Cf7FjFh/FY+aL/wHJ2N/i1eSNS6bSp0qlILIBBoB30Nx53twxQB0YUlNoTLvVqDc9bjIYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsIHBsZWFzZSBwdWxsIGZyb206DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L252ZGltbS9udmRpbW0NCnRhZ3MvbGlibnZkaW1tLWZpeGVz
LTUuMTktcmM1DQoNCi4uLnRvIHJlY2VpdmUgYSBmaXggZm9yIHY1LjE5LXJjNS4gSXQgaGFzIGJl
ZW4gaW4gLW5leHQgZm9yDQphIHdlZWsgd2l0aCBubyByZXBvcnRlZCBpc3N1ZXMuDQoNCi0tLQ0K
DQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGExMTFkYWYwYzUzYWU5MWU3MWZk
MmJmZTc0OTc4NjJkMTQxMzJlM2U6DQoNCiAgTGludXggNS4xOS1yYzMgKDIwMjItMDYtMTkgMTU6
MDY6NDcgLTA1MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0K
DQogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9udmRpbW0v
bnZkaW1tLmdpdCB0YWdzL2xpYm52ZGltbS1maXhlcy01LjE5LXJjNQ0KDQpmb3IgeW91IHRvIGZl
dGNoIGNoYW5nZXMgdXAgdG8gZWY5MTAyMDA0YTg3Y2IzZjhiMjZlMDAwYTA5NWEyNjFmYzA0Njdk
MzoNCg0KICBudmRpbW06IEZpeCBiYWRibG9ja3MgY2xlYXIgb2ZmLWJ5LW9uZSBlcnJvciAoMjAy
Mi0wNi0yNCAxMTo1NzoxOSAtMDcwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KbGlibnZkaW1tIGZpeGVzIGZvciB2
NS4xOS1yYzUNCg0KLSBGaXggYSBidWcgaW4gdGhlIGxpYm52ZGltbSAnQlRUJyAoQmxvY2sgVHJh
bnNsYXRpb24gVGFibGUpIGRyaXZlcg0KICB3aGVyZSBhY2NvdW50aW5nIGZvciBwb2lzb24gYmxv
Y2tzIHRvIGJlIGNsZWFyZWQgd2FzIG9mZiBieSBvbmUsDQogIGNhdXNpbmcgYSBmYWlsdXJlIHRv
IGNsZWFyIHRoZSB0aGUgbGFzdCBiYWRibG9jayBpbiBhbiBudmRpbW0gcmVnaW9uLg0KDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQpDaHJpcyBZZSAoMSk6DQogICAgICBudmRpbW06IEZpeCBiYWRibG9ja3MgY2xlYXIgb2Zm
LWJ5LW9uZSBlcnJvcg0KDQogZHJpdmVycy9udmRpbW0vYnVzLmMgfCA0ICsrLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9udmRpbW0vYnVzLmMgYi9kcml2ZXJzL252ZGltbS9idXMuYw0KaW5kZXggYTRmYzE3
ZGI3MDdjLi5iMzhkMDM1NWIwYWMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252ZGltbS9idXMuYw0K
KysrIGIvZHJpdmVycy9udmRpbW0vYnVzLmMNCkBAIC0xNzYsOCArMTc2LDggQEAgc3RhdGljIGlu
dCBudmRpbW1fY2xlYXJfYmFkYmxvY2tzX3JlZ2lvbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQg
KmRhdGEpDQogCW5kcl9lbmQgPSBuZF9yZWdpb24tPm5kcl9zdGFydCArIG5kX3JlZ2lvbi0+bmRy
X3NpemUgLSAxOw0KIA0KIAkvKiBtYWtlIHN1cmUgd2UgYXJlIGluIHRoZSByZWdpb24gKi8NCi0J
aWYgKGN0eC0+cGh5cyA8IG5kX3JlZ2lvbi0+bmRyX3N0YXJ0DQotCQkJfHwgKGN0eC0+cGh5cyAr
IGN0eC0+Y2xlYXJlZCkgPiBuZHJfZW5kKQ0KKwlpZiAoY3R4LT5waHlzIDwgbmRfcmVnaW9uLT5u
ZHJfc3RhcnQgfHwNCisJICAgIChjdHgtPnBoeXMgKyBjdHgtPmNsZWFyZWQgLSAxKSA+IG5kcl9l
bmQpDQogCQlyZXR1cm4gMDsNCiANCiAJc2VjdG9yID0gKGN0eC0+cGh5cyAtIG5kX3JlZ2lvbi0+
bmRyX3N0YXJ0KSAvIDUxMjsNCg==
