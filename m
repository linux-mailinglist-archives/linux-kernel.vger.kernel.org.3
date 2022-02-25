Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00E4C4715
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbiBYOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBYOJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:09:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE6B1CABCD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645798136; x=1677334136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=raChaZbnh0Q8IMAD8/RwT+IKIKVz8EVF4L4Wv0B4KtQ=;
  b=0csGQabeMvJz3jv+XKvIyi+E8hiTKp03Ofm+fmiRC/2Ap1y7p1HHv5J7
   51oIUXMBWAZHRcl6e/4hg6ohjOh4OW5nZkrwTQnIF3x4u/LWmoUgfBs0e
   2efak3ygaEtfZBVwyo3HPg5C0jq/ip60zA9cR5WbNeBtrGcvWAZs7kEcP
   phLHu9QPXp0kefqVWW/rxokLbcS4hx/sfVTdZGA3sRJXhCbRXkBei14Fu
   PCHTbi3Jx17ltSBQlAjwySi/tdSbRWSWTHgtHCGNJkxiIOxE/EG/p9rfa
   VE9RrnKCuxE9lWdXmewwzhQVa5E46IaeN9RZJ/XVGNcITxrsa3phFqd89
   w==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="147288136"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 07:08:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 07:08:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 07:08:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gal7/poxo1tCNswYXEyrfNjCCOeCLb3WIrUopZ4fG7nO07jS4s6tYmQar9z/qBY0maV7UZBver0HuFpefRgbFogV0WCRa2vfSg6dfLt/RLkI7ZXSrgYTrjLQryT8HzKF3e9BGkg3vZvdf3j5ApRPwfbFUqg9dhDlEhu+gEqvVFPb6dnZXQ7y+fJkiBYQga+TZUaUs7AdIvQpdVrexpsv//wEQ0fQLxSpVe9ejiQcpDGVG6RUyVhu+eZcqUHyxoLKHR0r3ykfM8JVO49tw7DcfWnUy25Lq2GFz/Slc5VY9XcTyU2OXhCU4RATKsB2AEpVcAXsfWnAE/GKo6+pgm8+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raChaZbnh0Q8IMAD8/RwT+IKIKVz8EVF4L4Wv0B4KtQ=;
 b=UN+Xn7XYRdh46qhQ7iX447Te7oCt3C7WJ2zD8o2nUwvv2CSOU8OLqg2ibNUhGg81HaMzd4QCxiiN2M4L0IzCaruHhNcuM1RURuTRG7S/QvhEeb4h7VU5lK9n9RxThSpvCiFmq5QBY9ZvNQvmYPcU6z6VU1vipZ9XG7SXFPWHfdCjHWviPiJFsnNJiZ1Xb9R61p1Zn8lXkCea5LWdrSkt59y8AXKJfhIznlxRSP5xjvRnBSr0ZbLF7TOdNaiHV08WyciWaS1yZ8JOR63IimfD2rj8yhUvdDszJ1IOLgUsuqiqyAdu6D3hcxohx3TSKgacB3sz34c4QzIpwiPkY2aKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raChaZbnh0Q8IMAD8/RwT+IKIKVz8EVF4L4Wv0B4KtQ=;
 b=D/+GzGiU/KoWkfAP4/pzzL32AFPrpGuQync3vKS5b1eMPmOp80z3npVvW4iRuzLGchWNmRCCNOj3pbRtsOXbF/ZdtF7bbPmnTSSkegSxdwvW51FyiKo3mjJjuJp0AxCx7IqZAV2ASClkAZMwDT2NQ7DQz+gWbhwUElFs+GQM4qQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 14:08:41 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 14:08:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yaliang.wang@windriver.com>
Subject: Re: [PATCH v5 31/32] mtd: spi-nor: slightly change code style in
 spi_nor_sr_ready()
Thread-Topic: [PATCH v5 31/32] mtd: spi-nor: slightly change code style in
 spi_nor_sr_ready()
Thread-Index: AQHYKlExHTVlrazkrEq7AA+E3sXd8Q==
Date:   Fri, 25 Feb 2022 14:08:41 +0000
Message-ID: <61aa4b62-1524-719a-2fe4-0c8661aadcf2@microchip.com>
References: <20220223134358.1914798-1-michael@walle.cc>
 <20220223134358.1914798-32-michael@walle.cc>
In-Reply-To: <20220223134358.1914798-32-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0848434d-784a-4b1e-66a8-08d9f868539c
x-ms-traffictypediagnostic: SA0PR11MB4766:EE_
x-microsoft-antispam-prvs: <SA0PR11MB4766BFC547CD120637641031F03E9@SA0PR11MB4766.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M631sOmHJG0CQ4hS7DlBFlicsM0NDyDfp1wEP0uoEhWyDPWJfJeILFTA4Jfxc0fdBohD6MoG5v0OLdAFMnH6UdAXfIAtWi3n094sbMzo0SRe7ehaZlfBVmVjsHrdZ5VeRluRp8GI8Xb59OPrdB7QX3T1Tzx6OdTlkBHnT1aL3AfpJc4Ypzx2/Mws2+2gPGrg9jFLjUQ5/ZQE0FYmugcIIZhd9EXxE339vyKK1svqyvfmeOifYQXemQUl56RE8co7a7wee29w78rizCFJNgqOfV6lbggDg5YWk1/9cX72TBdi+t9Euf+RhZQI/+rmwAl9XEoDjAY3Lb/UP2EgbfmQ+/Umuq5O/Y1UJO9U49JRojPR9okTPuzFX8m46v44M6wVcwUHIGUjDqYdHHeWqjrVa2QacnrpWuFRBAwUiBpR9W9iHgeT3ofIC528mYqpt4Wan44xp7/JEh+fu956qboZUw1agid/y16XmGyXJkqDpDCbDrKj1gBnKlxHZmlEa0eWf9mz2IowoITeIQfP7m2rnCjt53ky+xmlWr9PQj7boV2WcYZG1c0eMjnzeFNIF/k9Urs3rRwGO6ukkMvnTKDNhKyZ+ccN3drIEc2/7dQBL3Z6D8ogzAteX7v99eM6ItGr2lifed0EkHJB03bJvghdfh4ThyACDBPMRUZH4VhMtfduXGEyfzhJOxhtmpYwR9TnV/HKhMRK2lFIB4GpE8KXD6YSP2JPXF+IUhJlgflPiYg/rY7eVFy4c4KceePvAzwFNYUgsRsvw7cOFFfIBZm38g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(2616005)(66446008)(66476007)(66556008)(66946007)(91956017)(76116006)(64756008)(6506007)(2906002)(508600001)(53546011)(86362001)(38070700005)(4744005)(8936002)(71200400001)(5660300002)(31696002)(38100700002)(122000001)(6512007)(6486002)(54906003)(110136005)(26005)(31686004)(186003)(316002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3k2VThKY0ZsaU5nYkIxQ3hkaVVGS0RUWGtoK2kxNlJjcTJkMENhZ2kwK0d0?=
 =?utf-8?B?c0xpY21FaWRSQmNHUlNHL0Qra0xKNkNoZEdRa1dYQUd5NXA5eEhLNXI2eE1X?=
 =?utf-8?B?NW1Yb2tKQlNHeEx1cGJZYkZscGhzYXVVRjVDSG5aSCs3a1FaVHF6SlJFaXF3?=
 =?utf-8?B?Y0c4R05CeDFjMmRMTFo1STJ6eFRpaVhYOURremNQMkFEV25URktxd04wTzdw?=
 =?utf-8?B?Yy9Vakp6S084TUJHOG0vdjFLRVBrcTRlNjhNeVZXTStMcTUrV3l0RERMSUtS?=
 =?utf-8?B?aEpscUthRUt4NEM4UUgzYUFFanUxRkF1T0g0dzJZYmF6VjdMbis4NFY4UEFI?=
 =?utf-8?B?ZG1VUzcyL2NWbkV3VFBMdTI3TjE5U2FBZzB1YmZ3d3EvZEgvdTg3U0xoUXhW?=
 =?utf-8?B?WEtwTHRRaXhhaDhEc3ZTSnBFZVVkWFQzNjJCNWtXTFlKZVFRWGVyN1pEdDlO?=
 =?utf-8?B?UDlPbUlqUXFLUkZ5aEhxODlNeEZpbHZKdGxyRmpITXo5T1RudU5JQ2pNNUtO?=
 =?utf-8?B?eXJXb3pSaTFWSXBMaHRLcmFjajhmUnVTQ0lGWnhXYVhPUFhyVU1raEFFaXpr?=
 =?utf-8?B?WEZJcUt5WmVLWWwyMk5lcndKQ1VScDFVY3YvNlJrWjh2QUVsNjhkYnBYRnBC?=
 =?utf-8?B?NE9NU0dzSm5Mak5yRCs2SkEvTEFsTllBNjB1bHJnKzk3NmR6TFZkb1F6RW1M?=
 =?utf-8?B?M1h5bk5kVGZFTnVoeG1YODQzQ0hFazZoQWV1V1lpNkV6Z3JwcUQyeGRjdFcv?=
 =?utf-8?B?QjdZazdxcnh1YXZVaURJZ2FtU2N5RUFpQlp4dmJZamFGcENjZmdab1BEampl?=
 =?utf-8?B?TTk2Mm03UktUQlNpZ3BmMjdVOXZzR3NwRElZUHJnbzZxT3NRSHhiWi9jUXFJ?=
 =?utf-8?B?VlZDZDM2REF3SVRmOW40NitnZGR6RjZzWHRGUXF4NFNPMURKenRFQjVhYUlK?=
 =?utf-8?B?TG9xSXluOFhmMWxDeFVXZGxBbzJLaXBYdUF5MzVyRFVwY2tqdnB1OC9xNko3?=
 =?utf-8?B?cFZWQXJUU1YvREFzajRaSUs2U3d5VXRxWGhiMW5nd25hVjRiVUhKbW56NTRP?=
 =?utf-8?B?L1YyeHZwWEY4ZmtjQmJEeXhZOEJGRVVNSGU3UE5sSFNVMGlQUW5sSjMwbXJF?=
 =?utf-8?B?bUJxZ3dLSjdVOEFKdXlJNnY3d3EyejFnRDc3ejJtbmVJSVArK3FzTXZqejdZ?=
 =?utf-8?B?YzNUSkx4UHBEemcvcFgwS3BKWFFyQlhiV2w0OUkzQ1ZVbnMyKzlwUkRLZUV0?=
 =?utf-8?B?cXFpN3RCaDlDZzR2bjBSMVVoRkp6SmlyaVM2L2VnQllReUc0dGdES3lOY3oz?=
 =?utf-8?B?clFpa3dpRlVLdlE2VFcxc1hIOXZHU09odXJXVzkxalhiTnUvR2V4OWxXZjZi?=
 =?utf-8?B?TVQ4bXR0Tkl1ckNRaEg4T0xYcU9NdDMwbzhQK2pQU2F5M2pxSlJ0WStacEpH?=
 =?utf-8?B?QVFKTG1GWWhGenI0TWdiL2I1ZVdWTEFDc3huNFlCbFhjamRBcjVHWFF5RjFz?=
 =?utf-8?B?VDc4QkJXRjNxRmR4ZWxDd1BYY1B6K0NVQm5YbjhvYVorUURNdzBvMTZTL1g2?=
 =?utf-8?B?b1pFVkNrODdDaENHb0JJc0pBVUIwaVJHemluMXM3SUVCSXBEQlVPcjg0a3Jw?=
 =?utf-8?B?UmdzTVU1TVozeHU0NTEzUWQyRUJCd0xsbEtCa3MxWDZyQlBhMWlicEFaQk9Z?=
 =?utf-8?B?Y3BKR1M2SEl1NTBvdGFqODEycXdFNkZYT1Z6K1ZUVE0zK1BhQkt1TW9IZHlO?=
 =?utf-8?B?N1Q1M01HVGhvVklvWkxTaGF1Q0VMWEdXUjNoTGNtMzVBTEIweVpxdmFpRW1r?=
 =?utf-8?B?YzM5djJGeG42SzNqTjNIQnhCcElCK1B1Z2FzNXFsSHM2UmFIbGtWOTRqaFdS?=
 =?utf-8?B?eS9VbDZFRXJZVzluOG8wcTFVVlhrb1h6RFVGaE5TWXFDUWlGR2k2dVdxUFRh?=
 =?utf-8?B?REtMOGt2OVR2bDhYUitvVEI2U05wUUdmbjlQQUttd2p6dzZwWlJHcjRrSXlw?=
 =?utf-8?B?dUNvYStUMlVDOUtvUmhrRUdwOHBOWUVPOU9YVVdnaUtUTWs0VHVZMm9TQUw4?=
 =?utf-8?B?ZHdQRFFzU25EZEdGeU15L0dodmlnRmlROEZBZzhWN2hQOW9NK0M2Q09NcDN0?=
 =?utf-8?B?U0F1c1RZOFFqOG5UUElnZW9aMDkrZHYvTm5RVHA2KytKZnpBL3NUYTN2RnYw?=
 =?utf-8?B?MmQ3QWdGYWh3WVZIdS8zZW5INERIYS9TT0E0V0FTbjhCN2cyVzhzK09tY2F4?=
 =?utf-8?B?TVZTVTN1LzZ4Z3hmS3J5eFB3b2pBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F260AF77AE28446A4724B269062733A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0848434d-784a-4b1e-66a8-08d9f868539c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 14:08:41.2057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFs5+6vLlrQ4JMsDApl5SU4O9n4tbe+KqbYxHKyPPJBhbFZmIx1jTNJcspuEWIIpSqhWYIJ+pi9A8+KhD/9UJrzATKfFMCUWPPMukFH8Tus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhlIHN1YmplY3Qgc2hvdWxkIGJlIG10ZDogc3BpLW5vcjogY29yZToNCg0KT24gMi8yMy8yMiAx
NTo0MywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+IA0KPiBOb3cgdGhhdCB0aGVyZSBpcyBhbG1vc3Qgbm8gc3BlY2lhbCBjYXNlIGNv
ZGUgbGVmdCBpbg0KPiBzcGlfbm9yX3NyX3JlYWR5KCksIHRoZSByZXR1cm4gY2hlY2sgbG9va3Mg
b2RkLiBNb3ZlIHRoZSBmdW5jdGlvbiBjYWxsDQo+IGNsb3NlciB0byB0aGUgcmV0dXJuIGNvZGUg
Y2hlY2tpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdh
bGxlLmNjPg0KPiBSZXZpZXdlZC1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgMyArKy0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5j
DQo+IGluZGV4IGY1YTJmMzdkMTQwZS4uOTAxNDAwOGU2MGIzIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUu
Yw0KPiBAQCAtNTYzLDggKzU2Myw5IEBAIGludCBzcGlfbm9yX3dyaXRlX2VhcihzdHJ1Y3Qgc3Bp
X25vciAqbm9yLCB1OCBlYXIpDQo+ICAgKi8NCj4gIGludCBzcGlfbm9yX3NyX3JlYWR5KHN0cnVj
dCBzcGlfbm9yICpub3IpDQo+ICB7DQo+IC0gICAgICAgaW50IHJldCA9IHNwaV9ub3JfcmVhZF9z
cihub3IsIG5vci0+Ym91bmNlYnVmKTsNCj4gKyAgICAgICBpbnQgcmV0Ow0KPiANCj4gKyAgICAg
ICByZXQgPSBzcGlfbm9yX3JlYWRfc3Iobm9yLCBub3ItPmJvdW5jZWJ1Zik7DQo+ICAgICAgICAg
aWYgKHJldCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiAtLQ0KPiAyLjMw
LjINCj4gDQoNCg==
