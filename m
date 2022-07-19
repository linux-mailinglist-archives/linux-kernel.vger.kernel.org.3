Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A84579240
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiGSE5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSE5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:57:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37ED2314D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658206664; x=1689742664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m5yyTVE5IkUEXFI1ABiNMkM2A2N4ETEddPZ9MECeHp8=;
  b=HzLK6Na8ShozwDFftcyukbzu+jcM+k/CKF7Y+mVJZmUo820NhfcKwqE9
   f7e1Vn3NUlSfrWr6hAbGrUfdd1GNgBnU0cVv2Fzj+R0LO2u6z5BD3Y0HZ
   Cd/HP+Sd+/YA9LFIr9IxGkd5+FLf9Uz5WWOr3qQ1JI+fXpBMRSa6S2u/j
   QKZhRDKEUesOT8wcRFk/7B8LbmZ5lV0qo3cBsFgY6WD64Ms12z6pLgi+N
   MRjBTpJ4q0rI1LdyVQtWm5kD6TGCjU/K7nvNwAcxauSU8hlrwdQWPdzrr
   Q66d3ekIsUhsIH4ZlTCNaLUVLr/mxWjufjxIQbn44RDAMyObA+0AOucSB
   w==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="172875678"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 21:57:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 21:57:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 18 Jul 2022 21:57:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGlAJYaRtoIYEXf58xKKLBoP/Gsvsd/KoJFpoCiSIDQcxHOqjc77vdcvoRY8lQ0pdot+pAGr/K7dR8AwdDQkcatdTcnk0nb/nhUUZxSzleIz682zO3xjYS+Z+PSM7jS8CCWk6ttD5xwVjsmlQGzPFUzjBo+ZMmn6sPX40o8jihYdCBth+aMXv+JfEAk4QtZp69Q9/X05bbfE2GaXjmE+HQthzqe93UQEgVtWzfJ6NPRpB8eAvevcFG0nfG4uNRTmCPVmREiZmNg2wNmh0j5ZArsFYhZdwDed1r4uI7o51LYg3B0Vg8fuLyLr/46Jl3825dom+8oezw1YLTrr1Hmibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5yyTVE5IkUEXFI1ABiNMkM2A2N4ETEddPZ9MECeHp8=;
 b=Ai3n98OkO6FqCHGRl1rn7B4gFsfikh/98lvy6HEUKUACzKU0eiJi/mVed/8hS5G6I0AF+PWBUEo6niiHaFGNy+Nvlu6xTKl0v1883rqCU0v35PserHzAlodGUBtZGYc5UU0zPHZ7d9HXoHbcfD+5VDQ0FqnQHLATI9gssAxUmo7zQTWckQm5z9hfZNit/Xv6Jn/YmkKuXy+e2tQkcExL7Q8Ia7o9xwy25vnj12rEe/s/1a7dKRsE7KUYq2bH04J2p6H2ZYO+NH5vMf60pK9lkI1ZfmcLHeNVBXfV5YsXs0PHnxSttK6NfFsApdMBdRgpVAtF+HUstGnWLoCKBH1TaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5yyTVE5IkUEXFI1ABiNMkM2A2N4ETEddPZ9MECeHp8=;
 b=B8V/m61H+/SjfpsazjxKNAvbZBrMxZ271/oexZu3ra5Sea/sR5yoveccETu2a5G+itfcDzGmGVGufXwzRf2QT7VkJvLZ9Wvt+CQfxoOPbdvJVGjpgUxX0kA9p1ghu2ueTyq5XB/lUG4sd31pkuZHjiaWlElQWeOM/kvD7FoyWRQ=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 04:57:42 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 04:57:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <heiko.thiery@gmail.com>
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Topic: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Index: AQHYmywTE2aD0LVQO0KmbZoSG1RT0g==
Date:   Tue, 19 Jul 2022 04:57:41 +0000
Message-ID: <43041ef1-2b1b-5729-9611-00964d617f63@microchip.com>
References: <20220304185137.3376011-1-michael@walle.cc>
In-Reply-To: <20220304185137.3376011-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56a14fb8-1be7-44a4-c735-08da69433620
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E24nJb1YODdbhZoK9sIw3dHqE5UsZ1At1/bT0QDRUuSfZp1MyHeuEhpC2MaRa6c3x1wYbwRCSTAKsFNLsOo2cDlMol7ps2b+HypNbJCpkrSKXxpKP4yMJpXmJeaLxCjr1vQe0KvbwdNrpZ0GM1PvpJjKV+jg6MjvQ67W5claBVyuYFldt5e2IKJsX8bi53dCKa5rxj3npASTSjEwkNRBku9R96HCXvYxvthYSavxDzrtbhN7fDvEDeZu+Dx6WKq7MY01cTcHiuYFV6qptcqIHgk2Rye1viG+9e2/ywhwQJxUt4qqdbi8f1NLvNBvLJzpZGBbAVQyvI/nJrz+8wbV5jbtxVIjwVQp+594PnXKTLFZhTqobumM943vlyYOFDe3diHma2dE09SWBIq/SqBoPrY55Btr1FdM77Kt1kpHdvK+prkl9SZcBGAluYx2M6nb3bvDa9Jh8/EH4+s22zZRUpTzTRIcHhHVxYXNv2SVv+x8uvrcjMyQAhvzsMTavDilOaecs2HAr4+4MSHaghc65hkjl3JQEOsfZfUwhI9n7yoK34uneo7I2WOMo/sqf+bR06OSJQ64WB8IqBGHqsh5Mp0DlAVA0unThhebKpFX0JiBn/axa41+vu/FYGOTrVxfino48w/3+sqjspXi9aQK9yBUEKU9zlL+utstZ5KYHGbOh1Q9JABJfVIkeA8urnW8cNOpDqtK6JZaCkbX2VOuGvSRWUzyhA+XapkJBw2HEar/2Fn2quvEbKI6djNXWc5BP3ooo5rFKDMjl1A9JlfvLSv1T3fAaRbem9SsuIggaHGQwVSeMOe25b4LSfBeMSTrGMljFR5av8VGtGU6UCpLD1v70Zv6rWpL+ie3SBD8pXqsrUQ5JMhn0+h3UxHRiPcI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(376002)(39860400002)(110136005)(54906003)(53546011)(26005)(6506007)(6512007)(6486002)(71200400001)(41300700001)(478600001)(2906002)(76116006)(66556008)(66946007)(8676002)(66476007)(64756008)(66446008)(8936002)(316002)(5660300002)(4326008)(31686004)(38100700002)(122000001)(36756003)(91956017)(38070700005)(83380400001)(31696002)(86362001)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDI3Tk0zVFBTOERpMEFFcUJvVGtpNitYc2ZTVjRXVXFWZ2UvZy9QQTBvT3dW?=
 =?utf-8?B?eHRMSC9DRjdZUDRUQlRjRkhKNFluK0dEMG1MY1d3dDhMc2wxR3pOSXk3TnF3?=
 =?utf-8?B?aExhSnBNbjNqMFp6NTJ6Vm1tS3FsVUxwNE94WEhqVURSajV3cDhSSXd6dlY1?=
 =?utf-8?B?OFUxdXdTNE5WTURFYWdSeWtaMmRzV1NEQnBDd2FUZzJtOW9EVzhvSlhDZm4x?=
 =?utf-8?B?SjN4dUNaOHJUWGlMMVJ5SFZpVmhMaHNLbmRPV2w1NGxPM0JIeklTL1d3MnJk?=
 =?utf-8?B?REQxZ0ZIQVBYOGpwS09UVFZZOGpZSTArWllFSmJ1WmE0RUdkSnpKV1BpeU14?=
 =?utf-8?B?cHdIcnNERS9BcEtxVE9xOVduWkFPM0tjc1JIZ1NtMnRMUTdWTFJBZmczaFp3?=
 =?utf-8?B?Y2ZWaEJhSVZCcGRtUEUrM2pmNjNJdU03MjY0alNqRnVFbmErRjIzOTd0TzJF?=
 =?utf-8?B?SzhXUTJSQ3R3bDgvTmh2NkZPcmRjdkd2Z2ZPQ09DTExmTkw4TFNTODNHYTc5?=
 =?utf-8?B?dGdzYndpdnBzeWlQVTh3QWloRlQ4U3ZKeHlLbEY1dDdWVTJrRktvR2pYQmtP?=
 =?utf-8?B?THdEaTRVb1gzdXhGcWxGemdhRjllNDdLMGVvZU5lMGRHcjBzakdXQmdkOXkv?=
 =?utf-8?B?OWVVV1VDUEcxR3dnS1NROStwbkZ3ZHpIQjlUcnpNS0dXOUZHV0wxNU1XaG9k?=
 =?utf-8?B?OEFaR3JrWDdSQWhEVE9xNW5hblNVU1crV2FzcXd2SlpQejhOOU5SOFZTbktU?=
 =?utf-8?B?WDVmSjB6TFFjUmxwaytNWVZPdy9YVzVqSC92UjNOK2ZkVi9BZGdXYjVaUUNF?=
 =?utf-8?B?NVRTSWgrU1BJa2p3ME5qM2hkUDhyRGc3Qm0zV3JjYU85eW5MTDNzbkRINVpN?=
 =?utf-8?B?SHNSQnVGN0NvcGpZZUk3Mis4YmRCVHhubm1yck1xQ2U1U3ZTaGE5SjZCM3dy?=
 =?utf-8?B?cWp5YkZqU0dVdHhsVVNHVE9NQmlWbnVFR05SVkl5YWlWS014NmFNVEUyMVM4?=
 =?utf-8?B?dm92QWk0ZjRoUVVGWGNTckRLQm1DQnJSU1FoSzZjKzhCL0JRSjVlSm9TQ0xi?=
 =?utf-8?B?U0YyOUNDSFNyaDFQY05ZVFZVWXI3NkU5SUQ0cHg5eGRTSlY2bjlOd2p6Y0dj?=
 =?utf-8?B?WVlqY3VoYlkxRTZER0RvbVU4bHBTTXpvcnJaSS9lMWZpcWdYdVdJemhDbk5E?=
 =?utf-8?B?Z1Q3VWJaZ0R6Zk9jN3VkZnZkQ0pJR1pjNWwrWUx0cThLZE93bmtNL1IwWkJs?=
 =?utf-8?B?ekRPRzlSbVEvdHhRWmRKWUNnOXBPSjNyWkN3YTlxYnk4WXZFKzBlUGlDVnND?=
 =?utf-8?B?K3lFcWRrZGIyOGhvTHB0dVEyQmpKMm90V0xlblpPZXh0TmpEUWFsRUg3YW5v?=
 =?utf-8?B?Q3BGZklUdDNNQ283UFBDZ1Nza1Y0SXNMcGt5SHhmLzE4NG51VFVUSThCUlVa?=
 =?utf-8?B?cEkwd0lacU1hYzRRckh2aDNnNWljOTJKNms0OWpzYVF5MFJmWEM1TzNveWoy?=
 =?utf-8?B?QmluN3Rza29aUFFFRmpwdEFFU0drbXh2N25teXlHT1Ixdy9nL2RWbVphK3d2?=
 =?utf-8?B?alpFbk84ejZiYkY2c0NjM2M5MXFkOCtnclc0ZndvV0ZOYWdjaWw4bTJRTHRw?=
 =?utf-8?B?ekwyUnBUNEdBTWMwa2FvMEVVM1I3TlEzN3dpQXVkRXZjQXdIdmdVdW9DRnZi?=
 =?utf-8?B?dmh2cUNpRlVxSHhjSmMrRFBLTy9GTnlsVExQTGNCT1RZYVZtRUhOajdheDdn?=
 =?utf-8?B?ZkdlcUhndmNZL0tuc2p1TGtwbkc5eHhUejZYYVBzTWd2ek5BQWdlMDhXR0Mw?=
 =?utf-8?B?YmYraGN2Skw4VXp4cUZobHJYbjJEZE96aVlkekdMcGxSeER4Zmo4V0tvK2c0?=
 =?utf-8?B?bG9oOXl3RVBCdWdHU1VnMGRSYktQYis1MmRmd3hRRkFpeFZHb1F0bUJOOGx4?=
 =?utf-8?B?Q2JpbER4eDJwTkx0WjdpOVpZMlBOQ2hBQ01kY2x3MDJMZmx6bGZ5ZkJlYkV1?=
 =?utf-8?B?dWVqUVpFNDJxOWxheEJPTUhqQUUxVTZsakZiblNhTmZJYXVyME04dGZsUWNT?=
 =?utf-8?B?NU5maWd6UG1jamljcjlqUjRFaEVzNGQxeTkvTzdDR0JlU25sdERjUmxpSGk2?=
 =?utf-8?B?STQxZGpFQmp5ajB2Sy8rQWtXbjRPYlpCRXBvKzZvb1NkdGJFY3pzSWxCT2ZG?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C13C8EB6369074B9E9E7ACDAD4A2D59@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a14fb8-1be7-44a4-c735-08da69433620
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 04:57:41.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r59kgzdFbsKOpRklBZDQ1z3s/px1QzLOAMdHrcGO6061lhq3TfVZOsHnDfYlXr14T2RHWeeiq81o87ocL8VlDtcyUe0qMzhYkiphu8N+IyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6219
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy80LzIyIDIwOjUxLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KDQpIaSENCg0KPiBXaGlsZSB0
aGUgZmlyc3QgdmVyc2lvbiBvZiBKRVNEMjE2IHNwZWNpZnkgdGhlIG9wY29kZSBmb3IgNCBiaXQg
SS9PDQo+IGFjY2Vzc2VzLCBpdCBsYWNrcyBpbmZvcm1hdGlvbiBvbiBob3cgdG8gYWN0dWFsbHkg
ZW5hYmxlIHRoaXMgbW9kZS4NCj4gDQo+IEZvciBub3csIHRoZSBvbmUgc2V0IGluIHNwaV9ub3Jf
aW5pdF9kZWZhdWx0X3BhcmFtcygpIHdpbGwgYmUgdXNlZC4NCj4gQnV0IHRoaXMgb25lIGlzIGxp
a2VseSB3cm9uZyBmb3Igc29tZSBmbGFzaGVzLCBpbiBwYXJ0aWN1bGFyIHRoZQ0KPiBNYWNyb25p
eCBNWDI1TDEyODM1Ri4gVGh1cyB3ZSBuZWVkIHRvIGNsZWFyIHRoZSBlbmFibGUgbWV0aG9kIHdo
ZW4NCj4gcGFyc2luZyB0aGUgU0ZEUC4gRmxhc2hlcyB3aXRoIHN1Y2ggYW4gU0ZEUCByZXZpc2lv
biB3aWxsIGhhdmUgdG8gdXNlIGENCj4gZmxhc2ggKGFuZCBTRkRQIHJldmlzaW9uKSBzcGVjaWZp
YyBmaXh1cC4NCg0KVGhpcyBpcyBlcXVpdmFsZW50IHRvIGNsZWFyaW5nIHRoZSBkZWZhdWx0IFFF
IG1ldGhvZCBmb3IgYWxsIHRob3NlIGZsYXNoZXMNCnRoYXQgc3VwcG9ydCBTRkRQLCB3aXRoIGlt
cGxpY2F0aW9ucyBmb3IgdGhvc2UgdGhhdCBzdXBwb3J0IFNGRFAgUmV2IEEuDQpJZiBJIGNvbnRp
bnVlIHRoZSBsb2dpYywgSSBjb3VsZCByZW1vdmUgdGhlIGRlZmF1bHQgUUUgbWV0aG9kIGZyb20N
CnNwaV9ub3JfaW5pdF9kZWZhdWx0X3BhcmFtcygpLCBidXQgSSBkb24ndCB0aGluayBJIHdvdWxk
IGxpa2UgdGhhdC4NCllvdSBjb3VsZCB1c2UgYSBwb3N0X2JmcHQgaG9vayB3aXRob3V0IGV4cGxp
Y2l0bHkgY2xlYXJpbmcgaXQgaGVyZS4NCg0KV291bGQgeW91IHBsZWFzZSBleHBsYWluIG1vcmUg
d2h5IGlzIGNsZWFyaW5nIHRoZSBkZWZhdWx0IG1ldGhvZCBiZXR0ZXINCnRoYW4gdXNpbmcgYSB3
cm9uZyBkZWZhdWx0IG9uZSwgYW5kIHdoeSB5b3UgY2hvc2UgdG8gZG8gdGhpcyBqdXN0IGZvcg0K
dGhlIFJldiBBIFNGRFAgZmxhc2hlcyBhbmQgeW91IGRpZG4ndCBpbmNsdWRlIHRoZSBuby1TRkRQ
IGZsYXNoZXMgYXMgd2VsbD8NCg0KdGhhbmtzLA0KdGENCg0KPiANCj4gVGhpcyBtaWdodCBicmVh
ayBxdWFkIEkvTyBmb3Igc29tZSBmbGFzaGVzIHdoaWNoIHJlbGllZCBvbiB0aGUNCj4gc3BpX25v
cl9zcjJfYml0MV9xdWFkX2VuYWJsZSgpIHRoYXQgd2FzIGZvcm1lcmx5IHNldC4gSWYgeW91ciBi
aXNlY3QNCj4gdHVybnMgdXAgdGhpcyBjb21taXQsIHlvdSdsbCBwcm9iYWJseSBoYXZlIHRvIHNl
dCB0aGUgcHJvcGVyDQo+IHF1YWRfZW5hYmxlIG1ldGhvZCBpbiBhIHBvc3RfYmZwdCgpIGZpeHVw
IGZvciB5b3VyIGZsYXNoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWlj
aGFlbEB3YWxsZS5jYz4NCj4gVGVzdGVkLWJ5OiBIZWlrbyBUaGllcnkgPGhlaWtvLnRoaWVyeUBn
bWFpbC5jb20+DQo+IC0tLQ0KPiBjaGFuZ2VzIHNpbmNlIFJGQzoNCj4gIC0gcmV3b3JkZWQgY29t
bWl0IG1lc3NhZ2UNCj4gIC0gYWRkZWQgY29tbWVudCBhYm91dCBwb3N0X2JmcHQgaG9vaw0KPiAN
Cj4gVHVkb3IsIEknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFudCB3aXRoDQo+ICAgTWF5YmUgeW91
IGNhbiB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCBleHBsYWluIHdoeSB3b3VsZCBzb21l
DQo+ICAgZmxhc2hlcyBmYWlsIHRvIGVuYWJsZSBxdWFkIG1vZGUsIHNpbWlsYXIgdG8gd2hhdCBJ
IGRpZC4NCj4gDQo+IEl0IGRvZXNuJ3Qgd29yayBiZWNhdXNlIHRoZSB3cm9uZyBtZXRob2QgaXMg
Y2hvc2VuPyA7KQ0KPiANCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jIHwgMTEgKysrKysr
KysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMgYi9kcml2ZXJz
L210ZC9zcGktbm9yL3NmZHAuYw0KPiBpbmRleCBhNTIxMTU0M2QzMGQuLjZiYmE5YjYwMTg0NiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4gKysrIGIvZHJpdmVy
cy9tdGQvc3BpLW5vci9zZmRwLmMNCj4gQEAgLTU0OSw2ICs1NDksMTYgQEAgc3RhdGljIGludCBz
cGlfbm9yX3BhcnNlX2JmcHQoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gIAltYXAtPnVuaWZvcm1f
ZXJhc2VfdHlwZSA9IG1hcC0+dW5pZm9ybV9yZWdpb24ub2Zmc2V0ICYNCj4gIAkJCQkgIFNOT1Jf
RVJBU0VfVFlQRV9NQVNLOw0KPiAgDQo+ICsJLyoNCj4gKwkgKiBUaGUgZmlyc3QgSkVTRDIxNiBy
ZXZpc2lvbiBkb2Vzbid0IHNwZWNpZnkgYSBtZXRob2QgdG8gZW5hYmxlDQo+ICsJICogcXVhZCBt
b2RlLiBzcGlfbm9yX2luaXRfZGVmYXVsdF9wYXJhbXMoKSB3aWxsIHNldCBhIGxlZ2FjeQ0KPiAr
CSAqIGRlZmF1bHQgbWV0aG9kIHRvIGVuYWJsZSBxdWFkIG1vZGUuIFdlIGhhdmUgdG8gZGlzYWJs
ZSBpdA0KPiArCSAqIGFnYWluLg0KPiArCSAqIEZsYXNoZXMgd2l0aCB0aGlzIEpFU0QyMTYgcmV2
aXNpb24gbmVlZCB0byBzZXQgdGhlIHF1YWRfZW5hYmxlDQo+ICsJICogbWV0aG9kIGluIHRoZWly
IHBvc3RfYmZwdCgpIGZpeHVwIGlmIHRoZXkgd2FudCB0byB1c2UgcXVhZCBJL08uDQo+ICsJICov
DQo+ICsJcGFyYW1zLT5xdWFkX2VuYWJsZSA9IE5VTEw7DQo+ICsNCj4gIAkvKiBTdG9wIGhlcmUg
aWYgbm90IEpFU0QyMTYgcmV2IEEgb3IgbGF0ZXIuICovDQo+ICAJaWYgKGJmcHRfaGVhZGVyLT5s
ZW5ndGggPT0gQkZQVF9EV09SRF9NQVhfSkVTRDIxNikNCj4gIAkJcmV0dXJuIHNwaV9ub3JfcG9z
dF9iZnB0X2ZpeHVwcyhub3IsIGJmcHRfaGVhZGVyLCAmYmZwdCk7DQo+IEBAIC01NjIsNyArNTcy
LDYgQEAgc3RhdGljIGludCBzcGlfbm9yX3BhcnNlX2JmcHQoc3RydWN0IHNwaV9ub3IgKm5vciwN
Cj4gIAkvKiBRdWFkIEVuYWJsZSBSZXF1aXJlbWVudHMuICovDQo+ICAJc3dpdGNoIChiZnB0LmR3
b3Jkc1tCRlBUX0RXT1JEKDE1KV0gJiBCRlBUX0RXT1JEMTVfUUVSX01BU0spIHsNCj4gIAljYXNl
IEJGUFRfRFdPUkQxNV9RRVJfTk9ORToNCj4gLQkJcGFyYW1zLT5xdWFkX2VuYWJsZSA9IE5VTEw7
DQo+ICAJCWJyZWFrOw0KPiAgDQo+ICAJY2FzZSBCRlBUX0RXT1JEMTVfUUVSX1NSMl9CSVQxX0JV
R0dZOg0KDQo=
