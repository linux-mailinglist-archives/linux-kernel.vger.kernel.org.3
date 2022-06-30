Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54834560F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiF3CjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiF3Ciq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:38:46 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD8D403D4;
        Wed, 29 Jun 2022 19:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656556702; x=1688092702;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dF0GoSKOgWBvIwsNV3121n3vXOSj5NzFsxONJyY8Jcw=;
  b=t6KbFRKgR+qoE/1GzO9926Qtpp1zsUNGZjCRBSzOJA6Vbp6igrmByAOJ
   3Wjanll5dA8dWGJOUVtQYrdFaG8RO2FjVd6je8JAoFjhYqc2Ck0yaddfa
   nlkY4VE7APRQZ2SgpDGUkD13VufUE5D1b6hpSVKEwOzWF2D6Gtw1CeaFu
   iOtswViNJUteJtgdMRKqDbgKyFoIZ7rOkFn8wN+3KqHfh+INCy0jVnxbH
   Apn9BhGWl+cSw9R6f8AR1GAyIsNn1GCiCoSz7f/sGAVuhSq3BMWUFa8qZ
   RwflWuZCbLSagW1nxFiQZGxPTI+v8O18RioF4ukBDMEJJojjwN5mPuhFK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="59301015"
X-IronPort-AV: E=Sophos;i="5.92,232,1650898800"; 
   d="scan'208";a="59301015"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 11:38:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaArduSNbB5U0RQbcc8Pn3j280wpzlSnAkMxgv38eHfgFMqlpL+Ckvlpx/ExzlUXse6LBmB2vRNKL66ZQZXrSNGVutlgyDwrTyPepVJpM+huKP91rMWeyzsywzPX2bYrwoPGjjUmLg5HZH1a5liPA4zMWj4QdvgqZ/9PFhXazht+esdI3PUuejVCFWB279oRyuo+2HPPCVHZM7te70nUt2JTZlTlKOoC401mw2poHLhPVCSfQvoVkXY7JiwQrso/PNDLU3HmleZBr2P35RN98iLncTsFZ/Rso0jykcr2DfrtCYlIyZdjziYFYSUGXZh78PgN1toc5hB+hRn7THt9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF0GoSKOgWBvIwsNV3121n3vXOSj5NzFsxONJyY8Jcw=;
 b=YDTNK1v8RQ2JRijKlTNCiPWm9lWloP76pskXDTDdaKBqK++hBIrtES2Aj4biwhJZwvQBCfGHm+CQJbRQm910xz5Nbv0BQ9t1hnJv18P8w2Syh7TMsrY2tV66OPNqVONduQYf1J9FXNZnBRkpGRV7luGgnK18UPwIvWxhdUoOPO2YmI7BqP1N05v8W0iXS1kbk7OcBhh9664U8XfsM6rhSUl2VsOzkBZ0E6bdRSS8qTRtjhpCaU8dxxzne478tSJ8SZzvOZpeHfBBB9SWxHeBYR44VgZeC5/uZtkZigIa6vB8XIu2FyNa8OwnyvzHoDxb8g5DTMMg945BkIowvwJHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF0GoSKOgWBvIwsNV3121n3vXOSj5NzFsxONJyY8Jcw=;
 b=EJv3Cbtv3iflX2g66xo1KNZCF7R7VNTScoYT3IOByxzDb04ADxsKf1ca2jwEdmtQGislMac0czOUSslAHaWQ23HDsqJnXUZ1bGWgtefrC7xmJlYk1cMaEVFKXhXAIz7EJHbUL+cUaCR+NFpk3MHF/b+u5u0dHfzmvFjBnMTZAeY=
Received: from TYWPR01MB9311.jpnprd01.prod.outlook.com (2603:1096:400:1a1::13)
 by TYAPR01MB2861.jpnprd01.prod.outlook.com (2603:1096:404:88::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 02:38:12 +0000
Received: from TYWPR01MB9311.jpnprd01.prod.outlook.com
 ([fe80::f807:7dd5:3c46:bd7f]) by TYWPR01MB9311.jpnprd01.prod.outlook.com
 ([fe80::f807:7dd5:3c46:bd7f%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 02:38:12 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] scsi: Shorten too long warning messages
Thread-Topic: [PATCH] scsi: Shorten too long warning messages
Thread-Index: AQHYjCpwIxGIEp86UEykMwcVyHAQBQ==
Date:   Thu, 30 Jun 2022 02:38:11 +0000
Message-ID: <20220630024516.1571209-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cd61354-1239-4535-a235-08da5a419372
x-ms-traffictypediagnostic: TYAPR01MB2861:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W97mFIoZ/Yb/2vmTEs0RTULqu1kSxCAvxSRH3SSdhUrCAAaqWZEML2edA+pweIR6OIxRzBhhVPocCat9oOF7bFZxCY3TiBCBpNoKI1MDWwH6hQC1jnL80nRSgyFQy/PwgKK6YWzNKSQKwx/1SHhCQuPf8WkchIeodl0j1YP44bwddJpCon1Bg4niROkF3iqy0Ze7kZ1R95E/2Q9GeyyGwgAa98hxUG3KqeViEo+WzC+zQR9eUPBKq/E2/AbKSMsos9O5c/A0dxSn9h8q6/deAkn8GZaIu6uelAFqlZ1kwUHVIvfEAfPM/IZjvDnDZxFkIhIrC7V+z9bFEnhATRNEzSJqMIxf0o0FnvwB8dm6oIuAYRc6Dbvp9ZvmbuI+u7WlPZkEm4irTzaqV/dkvwezvoaV6/FGZ1rW+R5xjSOBA2b1kh+Q1XHPMqP9U7nHYjEqMUE1fB+8WbX3xXxHPQvKCK/nC2Tg6Ev1EBOsCTNszKyGN+i6P1GV8qwyDkZhqLASi3u/hT5O7K2rFndIoggM9kMZ3PX6ueLhFplF6UEto4njmN9B6LPGig0C+efwxefcPOXtUzUWviSxTh315RLa3DpmYXURMwlNVSM+Az6oHyg6VGrPAsLeOMYrL9WEshAZosxRIBsJVLMC8j5nN5ogl+Y+y4LICdcuZ3XlnfhXqYAPFuN1IX3pGtjefiChH3ZxkcI4r/KboZINpZRJelJq1ji8XCdUZN6z/qKWmTB/ojyw8UP6xm4bmyC1kR4/aDv81DJ2OMZaRWd4sulpHOcXP+8BVCrpo7B8rNXTT4xMsO+IIi2gETjw7PpZ6MwWJi4b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9311.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(64756008)(2906002)(38100700002)(4326008)(6512007)(85182001)(15650500001)(8676002)(66476007)(54906003)(316002)(110136005)(8936002)(66446008)(86362001)(5660300002)(122000001)(66556008)(6506007)(83380400001)(91956017)(82960400001)(26005)(38070700005)(71200400001)(76116006)(6486002)(66946007)(2616005)(36756003)(478600001)(41300700001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bm1SWTIrcXZ5bFRUbWgvUkh2a1VldWcvYkUyREJBL3kvYlJXTTF3QlB6S0JZ?=
 =?gb2312?B?akhHcXUrZEg1Sm5ZdXdTSXdrYk5jN212aUl3UmhBSXJyMDVaeG5veENGbVZC?=
 =?gb2312?B?cDUxSnVPN21yeHRWbkJkVDAxSTFTSURTRDl1cXNGdGJEdE8zL3BaNGk0amNK?=
 =?gb2312?B?Unp4Z2QwTHczc1MvVVhJZnNLcnQrbXhpaTFqT2tOb1Y0RHRZK3BFSXEwcWll?=
 =?gb2312?B?MVMrWm9WM2xHNWNReHRubmxHckpkYXVFVlA5ZTMva1Vxb1FFWk9zcGZsV0hx?=
 =?gb2312?B?enpxZnkxVUxIM2JyNE4vSUcwTXVVQ3dkajZ3Wkc2Yk9oZmNsVFdlc0cwNXJy?=
 =?gb2312?B?OVFKdGdadGx4bzlKZGI1RWRvQWdSMWhpZzd1SkRDOEhab0Z3R0lWS0xDR0Fa?=
 =?gb2312?B?UUdhR3JwcC9MVHNiUmV2VUlqMlpvbEw1UUxybUJpQ0UzZ1NEaHZVdW1paFdU?=
 =?gb2312?B?VHQ1aXdDcWZlenBOUXM4d3U0VnNScDFUYXJQRmpTN2NhRHBZdzRjNTRMQUor?=
 =?gb2312?B?YmE4MzBERzVTKzhkdkVURHkvamRKZTNCSXVaS0EwMy9vL2Q0UHlBeWhFcmIy?=
 =?gb2312?B?a05KTERTRXIzdDl5OWp5bzRYSUEyQm9HMmlXU0JvMzRqUUVTbExSaTRmZGtJ?=
 =?gb2312?B?MlhDY3lhZHVSam1TdkZlUHhNejRCenJVcEtMb0ZpeUFua1B3V05GWlVDd3Br?=
 =?gb2312?B?dUtJQnhYMitTMi9wbW5PQy8rWWY5YzJ6bFkvUmlQUGVJWlR2M1pnNDV0bzM1?=
 =?gb2312?B?QXZLaTVIMGVSbnB2Wk1WZU13TXozc1FCQWlIVUthSXBYNGJySEhUbFgvdnhm?=
 =?gb2312?B?dGhoalpTcXRsZ2gxeGRNeGhKQ3BST0pwUUM3RkVnZHdDdVdXRitYcWx0MERY?=
 =?gb2312?B?K0JUcnpXTVFyNlBxNHlGZmhWZmZZQ01hN1lyUnBTcGdXVHdiQWRBbURDRDE3?=
 =?gb2312?B?VjB2YnZPaldVODNZaFZBdmk5WEtLbjBmTkVWUFptTm84Q0RsTk0yZk0vNVFr?=
 =?gb2312?B?bU13K3Ivc042RFIxMm5BMmxhaVhxdi8xeTFqTE5UUjRkckdBak8zK3dTZ25P?=
 =?gb2312?B?cUs1cHFzenZjQ0xPaDNPalAzZnpTMGF4S3J3VkJ3MWQ2NHloNm9BdkNKbnda?=
 =?gb2312?B?b1FrMFQvTlNqZk5tWERNc2o3dUdMV3dkNnBsQm0rUHd6Z2p5SUdzakNWTUZ1?=
 =?gb2312?B?eEJUbkVkZTdRMi9EWTQzWm9KenBHcUNLVFdQbldTSm5BQ3pYZ3UxOGo4RjVD?=
 =?gb2312?B?MHZNN0JBLzczZnIxcHVud2FoZy9DMGtvKzUzVmxVWDVoWTd3dDNzN0lyOW1X?=
 =?gb2312?B?aUtaU1RUWHJWbHRkcDlJUUxKeURtNExibGNacXExQlk3Wm9GbzdsYW9mQ2Iw?=
 =?gb2312?B?OGhXTDlPcU9OTUI5MDIyZzcxRWpMNEpibmIyUVd6V1p2Rmx6MVF2YVNDTXlB?=
 =?gb2312?B?U294TlZuYTdhanRodTdKT1QxVWlZMU0yZmxQSHc0ZWo2czBYZWpYSldMZVZF?=
 =?gb2312?B?a3Q5VVBWdlJ0Rm0wSlN5c1BIdHkwWllYUFJ4WW04UHZ2S0MrUFBtU0lWU3NY?=
 =?gb2312?B?eitVdWp3ajNQcitUbk5NZUp4bmNBL3dRVmV6MDEzN3laNC85ZVBWbWpac2Z5?=
 =?gb2312?B?OU1ITDJuQ01VcEJuUmxLMmwySEFTL2xZdGFxSFFZNXdTWmJOWVNnZlZoRXFx?=
 =?gb2312?B?emIzTTRxQ01aR2RpZ05rQnZXSTFIUFhqS2U2ZlF0cnNrdzBjZHJEbzFpM1BF?=
 =?gb2312?B?NytJTTdINTZMWVdETHV6YTRMMXJpTFVUa2orOTNqaTYxa2ozcVdrdHBTU09B?=
 =?gb2312?B?RExHekd3ZStNMVVLZ1RrSG9mRU90TnE4UjdtTFBUZXVCTzk4YytjcFlxOXpF?=
 =?gb2312?B?NC9OZjVZM3llams2cWpmZHFVQzl1VWtQK2hZMCtzM2w1UGRyaHozWVZzV0lU?=
 =?gb2312?B?REVIMDA3TkR6cjNkUmFZVDN1UkNDL3hWd25RbCticG1Iald0L0ZTNjc2RzhG?=
 =?gb2312?B?Y0ZOeFpEQzlQa3pLNTllSnFwemgxdEtNdUJIaGhiUWdiRjQwMzUrTVlrOWY0?=
 =?gb2312?B?OTBiSlZnV2h5OUUwT3IxSlp4bGIzTGs4Z0Y3WWhSYUNkcWdZenhrSGp4eEQx?=
 =?gb2312?B?RWNIRmNaRTFvWWw5cEVOb25wQW9Mc3N6Vzc4RlpkSnVtVUd5VmlKQnBQNXlx?=
 =?gb2312?B?ekE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9311.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd61354-1239-4535-a235-08da5a419372
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 02:38:11.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dze64WvD5Z0XH+roRApf+QA9CvZMk1cAuAypzHER69XhdnfikwCFJ0qcvmmlOQh/CJBF2AjriM21maEY4M6DpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2861
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c2Rldl9wcmludGsgd2lsbCBvbmx5IGFjY2VwdCBtZXNzYWdlcyBsZXNzIHRoYW4gMTI4IGJ5dGVz
LiBTbyBzaG9ydGVuDQp0aGUgbWVzc2FnZXMgZXhjZWVkaW5nIDEyOCBieXRlcyBhdm9pZCBnZXR0
aW5nIGEgaW5jb21wbGV0ZSBzZW50ZW5jZSBsaWtlOg0KWyAgNDc1LjE1Njk1NV0gc2QgOTowOjA6
MDogV2FybmluZyEgUmVjZWl2ZWQgYW4gaW5kaWNhdGlvbiB0aGF0IHRoZSBMVU4gYXNzaWdubWVu
dHMgb24gdGhpcyB0YXJnZXQgaGF2ZSBjaGFuZ2VkLiBUaGUgTGludXggU0NTSSBsYXllciBkb2Vz
IG5vdCBhdXRvbWF0aWNhbA0KDQpTdWdnZXN0ZWQtYnk6IEZpbm4gVGhhaW4gPGZ0aGFpbkBsaW51
eC1tNjhrLm9yZz4NClNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1
LmNvbT4NCi0tLQ0KVjI6IHVwZGF0ZSBwYXRjaCBhcyBzdWdnZXN0ZWQgYnkgRmlubiBhbmQgdXBh
ZHRlIHRoZSBzdWJqZWN0IGNvcnJlc3BvbmRpbmdseQ0KLS0tDQogZHJpdmVycy9zY3NpL3Njc2lf
ZXJyb3IuYyB8IDQgKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zY3NpX2Vycm9yLmMgYi9kcml2
ZXJzL3Njc2kvc2NzaV9lcnJvci5jDQppbmRleCA0OWVmODY0ZGY1ODEuLjk0N2Q5OGEwNTY1ZiAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS9zY3NpX2Vycm9yLmMNCisrKyBiL2RyaXZlcnMvc2Nz
aS9zY3NpX2Vycm9yLmMNCkBAIC00NjMsMTQgKzQ2MywxMiBAQCBzdGF0aWMgdm9pZCBzY3NpX3Jl
cG9ydF9zZW5zZShzdHJ1Y3Qgc2NzaV9kZXZpY2UgKnNkZXYsDQogCQkJZXZ0X3R5cGUgPSBTREVW
X0VWVF9MVU5fQ0hBTkdFX1JFUE9SVEVEOw0KIAkJCXNjc2lfcmVwb3J0X2x1bl9jaGFuZ2Uoc2Rl
dik7DQogCQkJc2Rldl9wcmludGsoS0VSTl9XQVJOSU5HLCBzZGV2LA0KLQkJCQkgICAgIldhcm5p
bmchIFJlY2VpdmVkIGFuIGluZGljYXRpb24gdGhhdCB0aGUgIg0KIAkJCQkgICAgIkxVTiBhc3Np
Z25tZW50cyBvbiB0aGlzIHRhcmdldCBoYXZlICINCiAJCQkJICAgICJjaGFuZ2VkLiBUaGUgTGlu
dXggU0NTSSBsYXllciBkb2VzIG5vdCAiDQogCQkJCSAgICAiYXV0b21hdGljYWxseSByZW1hcCBM
VU4gYXNzaWdubWVudHMuXG4iKTsNCiAJCX0gZWxzZSBpZiAoc3NoZHItPmFzYyA9PSAweDNmKQ0K
IAkJCXNkZXZfcHJpbnRrKEtFUk5fV0FSTklORywgc2RldiwNCi0JCQkJICAgICJXYXJuaW5nISBS
ZWNlaXZlZCBhbiBpbmRpY2F0aW9uIHRoYXQgdGhlICINCi0JCQkJICAgICJvcGVyYXRpbmcgcGFy
YW1ldGVycyBvbiB0aGlzIHRhcmdldCBoYXZlICINCisJCQkJICAgICJPcGVyYXRpbmcgcGFyYW1l
dGVycyBvbiB0aGlzIHRhcmdldCBoYXZlICINCiAJCQkJICAgICJjaGFuZ2VkLiBUaGUgTGludXgg
U0NTSSBsYXllciBkb2VzIG5vdCAiDQogCQkJCSAgICAiYXV0b21hdGljYWxseSBhZGp1c3QgdGhl
c2UgcGFyYW1ldGVycy5cbiIpOw0KIA0KLS0gDQoyLjMxLjENCg==
