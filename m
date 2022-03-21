Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315154E275E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347813AbiCUNUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345828AbiCUNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:20:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BC02FFF7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647868733; x=1679404733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qSYNmMRMjSUARuEj4yh1w8tkeOusuOaeckSbL1nz6dM=;
  b=nwe9sbsh3KHfwJaVKUCS4s+C5+PHXJT/BfUsNr/2Yu5FY3d4dvNGIbWW
   UNWj9CuQo9cek18r5YQOThgTA4JL51GpLVO3vGjsg9gUprWoA07pfYKb6
   LyTVxn8MthpyxSc15oAdW6Z8tXSvvHw4bwUel7vGkbgKVGJ8O9SxLyzmi
   DiqXXcu/FYGb97Fq5XWxlEXH+WbkZGQruRhJ3E8tMYRGPPw8xM7VuOfTB
   JJfGXNYJ2oRXUYnArunCwxCTGTTXJVdgQ8B/sIfh6z/d6RKffUDI972iH
   gVSHveAmbUnVKHnTwdUNSMFiFtSyt9Si+aeMXn9wn1FfFQKydBBmk/Rsf
   A==;
X-IronPort-AV: E=Sophos;i="5.90,198,1643698800"; 
   d="scan'208";a="149856822"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Mar 2022 06:18:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Mar 2022 06:18:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 21 Mar 2022 06:18:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLzt3mkrTZFtZ7OK0Roa3wQF8EfB/2rLdx7I9VU2dihXGCFtYi3sttTP3rDI/eT8zh1WaEcnLRdBLQrGYWChsf3Oz8mk4EE/06WAXTftG7pP3T3OkmTwgLhsn7mAuaQe918prsBRc6aB60zh281fJvceeaZ1uFjVCYsYShAE4Qe5RB98SrZ4DaqNY5RZ//W7c/IOUYwhKqsYck3ZTuGoHOHeWyFRp3B1Pqepz9lOEvzXWYWdggXwqs7Sh7Q5pgqtMQUQ9+B5MpZ7f3VpDUsxPmEKwOPlUqDZtj3VCIOwjNqwcJjuIHkwV6XPVA68wSvaMCOYKKoCrWihFkjk3CTBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSYNmMRMjSUARuEj4yh1w8tkeOusuOaeckSbL1nz6dM=;
 b=XVz1IEGqgwPkyGAeDogFADw0JPO0TqIsxFifts1hw1+H3klNrAB7AVZ5JoHceBtaqbVdByWGk9xWsGXokJb7JzHwC7xKVUSS5sG5WYk2J7u2pl1/5AqJVlQpqqtbpGf+0nvZKKfJirRcrvqE7CCN+VpV6/BPvFZDXlxck9ckdgaXen9xerhWguWGXU6TcBz1PXAHnDhwYgBVzwN0Z0853IxoIOS9Qw1CWGxax77foMBFWo60yzFawJ6/UTnAK6Q1LQuQVsqgUNMpU40QtO6PjbPDDtdKoOx9ug5Yo56ExOZPkJV9FcdYjVPU3J3803Jp0+uSHh18UXJVdQoaD2PPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSYNmMRMjSUARuEj4yh1w8tkeOusuOaeckSbL1nz6dM=;
 b=bAoS5K1T4YI2VNkbprIfoecEjK+hGj26WK8E4ivGHwUnO313Eg57+quLN8QAj5wzgPMqJVcV2uCdsh7IeevtfKmEee9DZrKkA56yhXpC3e89e/Njkr4dtEPVOLNncuAFVap6f/Gsz1i9Xrf40+/FjkF5JXKX1wRIHAfcsXkb37Q=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 13:18:49 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::b828:b4ef:5cb:e551]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::b828:b4ef:5cb:e551%4]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 13:18:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 4/8] mtd: spi-nor: core: Introduce method for RDID op
Thread-Topic: [PATCH v2 4/8] mtd: spi-nor: core: Introduce method for RDID op
Thread-Index: AQHYPSYy5Uot3kf5wUC4x8ym1emt7w==
Date:   Mon, 21 Mar 2022 13:18:48 +0000
Message-ID: <32b3449a-66db-3ed1-da96-47e124800500@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-5-tudor.ambarus@microchip.com>
 <20220321122149.dvqyml4riqkr3gqi@ti.com>
In-Reply-To: <20220321122149.dvqyml4riqkr3gqi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a3208d1-a767-491f-b89e-08da0b3d5602
x-ms-traffictypediagnostic: SA2PR11MB4969:EE_
x-microsoft-antispam-prvs: <SA2PR11MB4969B1CAC8A1BB24CC6334ECF0169@SA2PR11MB4969.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6LQYo7VmysZU4S+Zl91XuXthIbx8GqlPDeHauzwFgjm9ViQ4vgijuOnT/rMimmYPzSWCAlEuPEXQZw4nyuBcJzLkh3xn4XPpZwl/wCKtBM1CYrxGsQA3vzvRCZh50Etur7K+HBpltvzcmwUEB8avkDgn5olAYHHdyqz9YK7Qs9Hjdume2J0bBnAf2hn10JT3LKnLqr9otOJwCMKvy76o7C/g0WXZfFOmxWXEihqdlLMnUnKEEYQ/nUrDE6onw4x8EbeGN9EIYrQ2EkQyyIP6NlCWuSReUD0CnQMY+Vp53atokj/aip8Y//xmsrX3hgbtReyv8Cr3SlACVBqyS61Io56zTggraQzk1o2RKBqpeS4yzKlSfkfkHHxQtH4t4nTmiu7doNa8OwYvSn8Q4pkfFfdflAMIvF8qVuYpCsF7STI6XQ/hWZrDrgemiWYFjnBlm39aOEJH4QzMY5+NYTLEPwHlA6q8GrL7JEJIXAuwG0uzvUvi3qU2MqaMW6TAW4roVHq+Es8/BJQpGJjQF0pXjB81xTZVbEdpCwMejlmPG4ENE1O34FNru3tjN6dRnSCo969NuslZWpwg1vlKL4g8QZprl/I/ypmCE5XmT1UgseumDVZtu/mInmr2E5k2+CA4R4+8gVtO/rtsJ0hrhd6ucE00fY/AcPeiumYsP1KOQrNv3QEAi5kA8k69jRTuuJ28D3G7yAn5fdq7vReLkOxS9xWuE8MfUe0hwCji2GfRO2GoJZkh6daxPpdCgHg9uHlOC38S23qEFBbjkC/un3GN6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(2906002)(2616005)(53546011)(26005)(186003)(38070700005)(6512007)(107886003)(83380400001)(122000001)(38100700002)(316002)(91956017)(8936002)(76116006)(8676002)(5660300002)(4326008)(66556008)(66476007)(71200400001)(64756008)(66446008)(36756003)(86362001)(66946007)(31686004)(508600001)(6486002)(6916009)(31696002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czI1cHJjb3poell1K2hER3J5Wkp3dGF1ZFhzcTJyYXRwc1Z0WHF3Z09MYjdj?=
 =?utf-8?B?Ymlyc2sybHl3N1NEMUM1anJjUDI4S3ZMWThyY09XM29WZmdoeUJRc1M5Z05R?=
 =?utf-8?B?NXJ4b0FVZXV1UUF4Njc3aUk1aHZRRkx1VE54MWRYRTR0LzJtRE5kNHRlcnVU?=
 =?utf-8?B?emxVamtqQUlXUGhJUUV5WjE0UWVUUUVjNWJhTDBKRnBnNTVVbEdZdWNiSWlK?=
 =?utf-8?B?dHIrY3crby9yL0o3aUdtVStqV1FpQ3RJL1ZCbEhBZTlIaVBtRUp2MFdTZTV2?=
 =?utf-8?B?Z3VtNVpmZFU2amZNdEFwalYvWXVzM0lIODlVby8zTVhpdDVHY2NEZUsza0ov?=
 =?utf-8?B?cytzNHVTZlpDVVRUKzFJWDlGSnUrUkdZUGxCd1YxWThDdnZ5SWNLYUxEUmVs?=
 =?utf-8?B?OVNOVERUcXFhOWpZbW9yNDZWeExTa0JWSFovTmFlT1FBT2kvemh2dVdJbnM2?=
 =?utf-8?B?aUsrOHNrTzhzVVZQMy8yblNLKzRZVmdsQkQ2TUhQdmhRTXJrem9KanJZNGhR?=
 =?utf-8?B?SFA1a0xURHpOWWNwRW1TckhUWGlrNU05RGZDQkgrRzc3ajN5bUYwbEZCdUJZ?=
 =?utf-8?B?RDJlZys5eVVMbjZ2OTI1OHZacXF3eW5MVmQyK0dOTHpQRXRMK2w4K0lhZGNW?=
 =?utf-8?B?YkljckdHRndTeVNpRm9aaTgrWG00ZU4xaUVSOXBlbVlMSTZncTVNdVkwWitX?=
 =?utf-8?B?U1ZucXdySDZFNkV4aHRtd1d0VHl2dnUzbVh3Z3BUdWJNbGZpbGl3UUNxdWkz?=
 =?utf-8?B?SVZHRTRmcTR5UFZlOHNya1JxUHYreklRZ1VMZ3VZV3BKdk1hc2VaNVkzUFV1?=
 =?utf-8?B?WGFGUTVGR1Rrc0Z2MENRY3YveVp3SVBnaXl4eWtCbG9mK2tySWNaUC84bEc5?=
 =?utf-8?B?bXlKWTBVK1dIMzBtTzRGOSsrMEVubXJvZlpDT3Y5SEpnUDNPbTZ6WFhjY2VY?=
 =?utf-8?B?YXAycm4wWXBUN1pScitQdXJVUDQ0Nk9hOTZmb0NFT0psSjZpSWFOMThyaWl5?=
 =?utf-8?B?SlBFakhkUHEzT0piYUVqd1YzNndqNitnRmxBS0srNy9kUlJHWkN4RS9RY0k0?=
 =?utf-8?B?ZTVWMXUvZEhGOXhQMTRXdUY5ZzFxbmlvOGFWRnZJU3pqeVFOVWNUWElRak81?=
 =?utf-8?B?VFlhREdwWlJKejd6QjVEQkZmdzBCSzljNjVRd0xMdVd6ZGU4aHlIZmFhWXpq?=
 =?utf-8?B?ZzR1b2RUbnVQWHY4TU1ZY0pTZGMvYnlsdTRXZERodjVPaDdRUDBNOUNkYWFk?=
 =?utf-8?B?VmE3ZE9NRDFDWDFMcm12Q0xuTGgyZ21tS0d6a2hlekZUaVFkL200YXVuTUdJ?=
 =?utf-8?B?bFF2RnpXczVJR0orSFlUclU4cVZCKzFqWFFTQktPYzEwcVpvM1Q4ZVh1Slg0?=
 =?utf-8?B?MUppWTlMMHlyV0JDMjJuWHl5bkhpVWVtWGwyUC9EeDF6TXFFTGtSMG14OFhF?=
 =?utf-8?B?UGIyK0hTRnc5R3hpMTdFQWRiWU9Scko1RFhxZE42c2xKNFdpY1crenJJNlJ4?=
 =?utf-8?B?R0xpdzJER1FEOWtnY3Q2RGJ5Zy8vMUt0OHdPWUdwVGxuTWxZL2tNZVluUVpK?=
 =?utf-8?B?T1Q5ZW9pM1IwOXcxUGVqQzQ4ZmtvbnFFV2FyLzdTaExmdXkwcGZxMkN3dXc5?=
 =?utf-8?B?NzZUWldZNHVaOG1CQWlFOTRtSmkxbE9CdCtHZzRUeVVnS0dlc0RCekNPZ2hH?=
 =?utf-8?B?N3dMVmZ6YlF4QjltSTZGZkFsZEVkTm40UE9WRkJGLzhPVjJQcTRUckpJMUt4?=
 =?utf-8?B?aVYwQUZHNmN3OWhab2IwYTYySVhraUYxVWloMnFVMWU1blVmcDZRRGhPZUZK?=
 =?utf-8?B?ZWR1ZnlKcytJVW9ndW15K1JIUTdkWkJuOTFNM2gwU0NuL1B4SjAwYjNUcWpr?=
 =?utf-8?B?WVNlR2djdkNabmlsN1VEZlhkN2tNOXlQSGYvdnB6cGNBN3p4NExNdDhtZzJa?=
 =?utf-8?B?UFFycXRKendGamVjcjR6UzN5Y0N5bm9yNHE3MnlTK0RHdXNjK0w2OFF2TTBm?=
 =?utf-8?B?eW5qSlg5MDNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E64BC9893EB05945B2EE8A03DCA20E35@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3208d1-a767-491f-b89e-08da0b3d5602
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 13:18:48.9807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8lcIbx6MMyIKACP6TD4glOI1o4Hket0S1I7Dghyf7PbTxAWPgE1pA90VJXdkt5aLA2SY+Sdp32WL5Tg0zoWZNZyoDFYZPhqQLBO+YdbZqHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMS8yMiAxNDoyMSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjgvMDIvMjIgMDE6MTdQTSwgVHVkb3IgQW1i
YXJ1cyB3cm90ZToNCj4+IFJESUQgaXMgdXNlZCBpbiB0aGUgY29yZSB0byBhdXRvIGRldGVjdCB0
aGUgZmxhc2gsIGJ1dCBhbHNvIGJ5IHNvbWUNCj4+IG1hbnVmYWN0dXJlciBkcml2ZXJzIHRoYXQg
Y29udGFpbiBmbGFzaGVzIHRoYXQgc3VwcG9ydCBPY3RhbCBEVFIgbW9kZSwNCj4+IHNvIHRoYXQg
dGhleSBjYW4gcmVhZCB0aGUgZmxhc2ggSUQgYWZ0ZXIgdGhlIHN3aXRjaCB0byBPY3RhbCBEVFIg
d2FzIG1hZGUNCj4+IHRvIHRlc3QgaWYgdGhlIHN3aXRjaCB3YXMgc3VjY2Vzc2Z1bC4gSW50cm9k
dWNlIGEgY29yZSBtZXRob2QgZm9yIFJESUQgb3ANCj4+IHRvIGF2b2lkIGNvZGUgZHVwbGljYXRp
b24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0Bt
aWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCA1
OCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPj4gIGRyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5oIHwgIDkgKysrKysrDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNl
cnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
dGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gaW5kZXgg
YjFkNmZhNjU0MTdkLi4yODFlM2QyNWY3NGMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+IEBA
IC0zNjksNiArMzY5LDQxIEBAIGludCBzcGlfbm9yX3dyaXRlX2Rpc2FibGUoc3RydWN0IHNwaV9u
b3IgKm5vcikNCj4+ICAgICAgIHJldHVybiByZXQ7DQo+PiAgfQ0KPj4NCj4+ICsvKioNCj4+ICsg
KiBzcGlfbm9yX3JlYWRfaWQoKSAtIFJlYWQgdGhlIEpFREVDIElELg0KPj4gKyAqIEBub3I6ICAg
ICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicuDQo+PiArICogQG5hZGRyOiAgIG51bWJlciBv
ZiBhZGRyZXNzIGJ5dGVzIHRvIHNlbmQuIENhbiBiZSB6ZXJvIGlmIHRoZSBvcGVyYXRpb24NCj4+
ICsgKiAgICAgICAgICAgZG9lcyBub3QgbmVlZCB0byBzZW5kIGFuIGFkZHJlc3MuDQo+PiArICog
QG5kdW1teTogIG51bWJlciBvZiBkdW1teSBieXRlcyB0byBzZW5kIGFmdGVyIGFuIG9wY29kZSBv
ciBhZGRyZXNzLiBDYW4NCj4+ICsgKiAgICAgICAgICAgYmUgemVybyBpZiB0aGUgb3BlcmF0aW9u
IGRvZXMgbm90IHJlcXVpcmUgZHVtbXkgYnl0ZXMuDQo+PiArICogQGlkOiAgICAgICAgICAgICAg
cG9pbnRlciB0byBhIERNQS1hYmxlIGJ1ZmZlciB3aGVyZSB0aGUgdmFsdWUgb2YgdGhlIEpFREVD
IElEDQo+PiArICogICAgICAgICAgIHdpbGwgYmUgd3JpdHRlbi4NCj4+ICsgKiBAcmVnX3Byb3Rv
OiAgICAgICB0aGUgU1BJIHByb3RvY29sIGZvciByZWdpc3RlciBvcGVyYXRpb24uDQo+PiArICoN
Cj4+ICsgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgLWVycm5vIG90aGVyd2lzZS4NCj4+ICsgKi8N
Cj4+ICtpbnQgc3BpX25vcl9yZWFkX2lkKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4IG5hZGRyLCB1
OCBuZHVtbXksIHU4ICppZCwNCj4+ICsgICAgICAgICAgICAgICAgIGVudW0gc3BpX25vcl9wcm90
b2NvbCByZWdfcHJvdG8pDQo+IA0KPiBOaXRwaWNrOiBDb3VsZCBqdXN0IGNhbGwgaXQgJ3Byb3Rv
Jy4NCg0Kc3VyZSwgd2lsbCB1cGRhdGUNCg0KPiANCj4+ICt7DQo+PiArICAgICBpbnQgcmV0Ow0K
Pj4gKw0KPj4gKyAgICAgaWYgKG5vci0+c3BpbWVtKSB7DQo+PiArICAgICAgICAgICAgIHN0cnVj
dCBzcGlfbWVtX29wIG9wID0NCj4+ICsgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX1JFQURJ
RF9PUChuYWRkciwgbmR1bW15LCBpZCwgU1BJX05PUl9NQVhfSURfTEVOKTsNCj4+ICsNCj4+ICsg
ICAgICAgICAgICAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Aobm9yLCAmb3AsIHJlZ19wcm90byk7
DQo+PiArICAgICAgICAgICAgIHJldCA9IHNwaV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9w
KTsNCj4+ICsgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgIHJldCA9IG5vci0+Y29udHJv
bGxlcl9vcHMtPnJlYWRfcmVnKG5vciwgU1BJTk9SX09QX1JESUQsIGlkLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX01BWF9JRF9M
RU4pOw0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAg
ICAgZGV2X2RiZyhub3ItPmRldiwgImVycm9yICVkIHJlYWRpbmcgSkVERUMgSURcbiIsIHJldCk7
DQo+IA0KPiBJIHRoaW5rIHRoaXMgbWVzc2FnZSBzaG91bGQgYmUgaW4gc3BpX25vcl9kZXRlY3Qo
KS4gTGV0IG9jdGFsIERUUiBlbmFibGUNCg0KQXMgb2Ygbm93IGV2ZXJ5IFNQSSBOT1Igb3BlcmF0
aW9uIHRoYXQgcmV0dXJuIGFuIGVycm9yIGFsc28gcHJpbnRzIGEgZGJnDQptZXNzYWdlLiBJIGxp
a2UgdGhpcyBiZWNhdXNlIGl0IG9mZmVycyBhIHNtYWxsZXIgZ3JhbnVsYXJpdHkgb24gdGhlIGVy
cm9yDQpjYXVzZS4NCg0KPiBtZXRob2RzIHByaW50IHRoZWlyIG93biwgbW9yZSBzcGVjaWZpYyBl
cnJvciBtZXNzYWdlcy4NCg0KSG93IGFib3V0IGR1cGxpY2F0aW5nIHRoZSBlcnJvciBpbiB0aGUg
b2N0YWwgZHRyIGVuYWJsZSBtZXRob2RzIGlmIHlvdQ0KZmVlbCBpdCBpcyB3b3J0aCBpdD8NCg0K
PiANCj4+ICsNCj4+ICsgICAgIHJldHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPj4gIC8qKg0KPj4g
ICAqIHNwaV9ub3JfcmVhZF9zcigpIC0gUmVhZCB0aGUgU3RhdHVzIFJlZ2lzdGVyLg0KPj4gICAq
IEBub3I6ICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicuDQo+PiBAQCAtMTY0OSwyOCAr
MTY4NCwxNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gKnNwaV9ub3JfbWF0Y2hf
aWQoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4+ICAgICAgIHJldHVybiBOVUxMOw0KPj4gIH0NCj4+
DQo+PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvICpzcGlfbm9yX3JlYWRfaWQoc3Ry
dWN0IHNwaV9ub3IgKm5vcikNCj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gKnNw
aV9ub3JfZGV0ZWN0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiAgew0KPj4gICAgICAgY29uc3Qg
c3RydWN0IGZsYXNoX2luZm8gKmluZm87DQo+PiAgICAgICB1OCAqaWQgPSBub3ItPmJvdW5jZWJ1
ZjsNCj4+ICAgICAgIGludCByZXQ7DQo+Pg0KPj4gLSAgICAgaWYgKG5vci0+c3BpbWVtKSB7DQo+
PiAtICAgICAgICAgICAgIHN0cnVjdCBzcGlfbWVtX29wIG9wID0NCj4+IC0gICAgICAgICAgICAg
ICAgICAgICBTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKFNQSU5PUl9PUF9SRElELCAxKSwNCj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfTk9fQUREUiwNCj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfTk9fRFVNTVksDQo+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX0RBVEFfSU4oU1BJ
X05PUl9NQVhfSURfTEVOLCBpZCwgMSkpOw0KPj4gLQ0KPj4gLSAgICAgICAgICAgICByZXQgPSBz
cGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0sICZvcCk7DQo+PiAtICAgICB9IGVsc2Ugew0KPj4g
LSAgICAgICAgICAgICByZXQgPSBub3ItPmNvbnRyb2xsZXJfb3BzLT5yZWFkX3JlZyhub3IsIFNQ
SU5PUl9PUF9SRElELCBpZCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgU1BJX05PUl9NQVhfSURfTEVOKTsNCj4+IC0gICAgIH0NCj4+IC0gICAg
IGlmIChyZXQpIHsNCj4+IC0gICAgICAgICAgICAgZGV2X2RiZyhub3ItPmRldiwgImVycm9yICVk
IHJlYWRpbmcgSkVERUMgSURcbiIsIHJldCk7DQo+PiArICAgICByZXQgPSBzcGlfbm9yX3JlYWRf
aWQobm9yLCAwLCAwLCBpZCwgbm9yLT5yZWdfcHJvdG8pOw0KPiANCj4gSG1tLCBJIHdvbmRlciBp
ZiBpdCBpcyBiZXR0ZXIgdG8gZXhwbGljaXRseSB1c2UgU05PUl9QUk9UT18xXzFfMSBzbw0KPiBj
bGVhcmx5IHNpZ25pZnkgdGhhdCB0aGlzIGlzIGludGVuZGVkIHRvIHVzZSAxUy0xUy0xUyBvbmx5
LiBXaGF0IGRvIHlvdQ0KPiB0aGluaz8NCg0KSSB3b3VsZCBrZWVwIGl0IGFzIGl0IGlzIGZvciBu
b3csIGJlY2F1c2UgaXQgb2ZmZXJzIGZsZXhpYmlsaXR5Lg0KSWYgd2UgZXZlciBnb25uYSBkZXRl
cm1pbmUgdGhlIHByb3RvY29sIGF0IHJ1bnRpbWUgdGhpcyB3aWxsIGNvbWUgaW4gaGFuZHkNCmJl
Y2F1c2UgaXQgd2lsbCB3b3JrIHdpdGhvdXQgdG91Y2hpbmcgdGhlIGNvZGUuIEpFU0QyMTYgc3Vn
Z2VzdHMgYW4gYWxnb3JpdGhtDQp0aGF0IHRyaWVzIHRvIGRldGVybWluZSB0aGUgbW9kZSBkZXBl
bmRpbmcgb24gdGhlIFNGRFAgc2lnbmF0dXJlLg0KDQpDaGVlcnMsDQp0YQ0K
