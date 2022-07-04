Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B159E564D63
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 07:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiGDFnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 01:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiGDFm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 01:42:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6571958B;
        Sun,  3 Jul 2022 22:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656913298; x=1688449298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mfk7frHj+PWtLPMpP1hGn6ReQvNuqhk+E2nNlpBIi/o=;
  b=2a94jzJTtKIg+T33hfpP5EtwjnQW7oNGBAz4K6y3qpW3jUyvYMg7gnRf
   Frg0GOE+AMHaTmKkmJ2REY/maf+1KjVBCJrGokTsYI9xoOEQJE9i0MPyN
   GqdumJa5ckoaAJnxUOme8HIYUM3QlW4Od73T/qeOySTl7LD6wJD/qKmiO
   q5m5fkLAzcVSBlQuHl/c48d8NA3/YhPviTqqwff7kHAkmXTzhGGMIOh7u
   kr48Wk8L8lexoHN3HpL0FBx6QAOFI1o+lNPYi/Ob5e5RUln/D+ghYbCby
   tjzn/c59fiCzGAPKQ59Pr7+J0pAgAYgkkBf+kdnl9+7berdsdLAZu6dzk
   w==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="102864222"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2022 22:41:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 3 Jul 2022 22:41:37 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 3 Jul 2022 22:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfTVlLYeKq1HZz12PB0O8sHu91RgE3skyyPqR9KZQU+d0rBuwqeLv+KArSQRVVg9CkiOOK/phyClF2Pw3HERWyePYZ2hC7jUQu0nWs7HxMAPMtmh6iGUEWpkWOr8bohdSXNS8iWZ+wu7Wr5ElTGWmjU1/25lfI2wElwKRbrb9NKgMHfr1S9Ec576cji653eo60IW7oBlGUktgOZmfNNMRul50PCubXiRGkE8VbmKPzkNQOV9fZt7NtQFpNg9wV+fPNgkC4VNAIABTBAFiZnxZWIfr/mAKp0d1wRrl37+CKYRo35CvXnwhB9VwdgolGM66pbOUIKprY1IpOBaz1Culg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mfk7frHj+PWtLPMpP1hGn6ReQvNuqhk+E2nNlpBIi/o=;
 b=UUOVuwyKyWWTqt2HXVEgcMCnutlLb1lOJXteR/fTEgH6TZ8FWbHwbDmGYMXwHIxtyu8tsU0w/uVyxvzRafZ2KEKLmQqiCshcdI9qv/yIG60e03QK/tyTzFVZGMco2gFHE80L/KTidfDxiVfvPa6OZ2gDNuGTq5v0lUafmIhMf5fK3JIRdQZeHCS3Ek2Vc/iVU4tItTclHLE3xqdeOPy6nb3YXQHcTz0KmI0foZhpm14MQMy+HSzrqBEqkFXw74xfDJgw39vDMg3JZIgrFGW+57yPQJaiFJZfASD0kT38VnpecWgRVOogRtVJdMa2DX+Q6Oj4yWrA9jJBki5sdUp2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mfk7frHj+PWtLPMpP1hGn6ReQvNuqhk+E2nNlpBIi/o=;
 b=VfvIP6WSqdjQdaSxYIxx6kWJwAjvYV23A+6gxuOJ6gf8H4A64Hx8TVxZooAIG0DQ7R+lL1sHZ91zsptoZFLS0W8eA8pByq31QffhNeqJvd49L839FAicYGAWgiNhEa2el3fV6gnOj33EptT+1MF2YdLzzxOpDyjAkGkxDfJCFhU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM8PR11MB5606.namprd11.prod.outlook.com (2603:10b6:8:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 05:41:33 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 05:41:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <herve.codina@bootlin.com>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Horatiu.Vultur@microchip.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Topic: [PATCH v4 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Index: AQHYjTlBIEn+M1GMrUWYK6sRmh+9Zg==
Date:   Mon, 4 Jul 2022 05:41:33 +0000
Message-ID: <32790e6f-e708-ceee-e17f-1b09c909c991@microchip.com>
References: <20220701070928.459135-1-herve.codina@bootlin.com>
 <20220701070928.459135-4-herve.codina@bootlin.com>
 <72a1e572-45d7-de18-8f1f-9035d75b562b@microchip.com>
 <20220701160327.102880e5@bootlin.com>
In-Reply-To: <20220701160327.102880e5@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 721d9f07-5032-4877-42b0-08da5d7fda57
x-ms-traffictypediagnostic: DM8PR11MB5606:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQ18DPmPEJ60sq/8yskLJPPgP162RU836rC10sH8LyCQjPfpw6ts/hkIfcXGyu9O+Y75ZgyCA8dy0N4Z9qhT6hlQQvcqOy9RwwlnTsa3KIgmhtrqe6NquRcI4XiDkHTh69kgDFpttZmLOirCjkKoH7T46icjB0Gxvh0kgJ0vQq2FcrQmJX7s0NXqwj8UHiIerB7mpLWYd3HHU84LydnQSjtPVISM9fO4etS2X/nGZATzwruv5H5UNlKCJUWfqOl1Iw2Oh+TGjhGtUH6KwwJkIp/xjBsY0oEOmiY2r6zLcEJECqELny57ftVwsSvl+S5JvA2FsA9HDprFiqEnha8C1W1/p4ZZblF8OowDZGgBFNyAEg2OyQn4WzmJaobPnneBSnNz2A6tZeI9H5qc+hE4IczRgIulgcKqiKl+uYfc+JGcwIRLJR7UuJgBhWxqGZskibOghKb/bMFureS2Gw6khXBsZ/ano4r8uFBOEeiGx3PGPA3nhHxqQlrLkWRgsFdzIVTnsTNyYtKxFMdObYOyiYbFM7yzhz4dfXB7L3U8ojE3zEhiXF23NfdbbncLpd9pu0+7yXhE2cH3F+ulRZICdcTNyui6dpomiJ3ZyKB+/T03eiZfjUNAkcnIIswjP2g7ZLFoI+jB6MQoNhsY2x9yWIsePQH704ZqyJXXAgGHDf5wI47JqX89T91nSNgyjhRpuz+SBWZwjdnXUBdIUya2qOV5dJ7K5CtGH1w+DfUlsH+2frHCIn9BB1JXW08DiyQv3UUz+rHH3xQglh38Xaksx/IzKgD2JB9WWAInGYKRDE7YNxue+ihdsrxHHsB9KC9ty3VfJ3LMA6v0Xk1gwW3hAdohPPE7TIGJXPxipcRQMoPn7mkLgB+c3zFNQFvYYoiMfLzTLVtERW64iXt5sD5ayj+pET3pH65eqEMDmd+ntfY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(39860400002)(366004)(53546011)(2906002)(8676002)(6506007)(71200400001)(6486002)(478600001)(316002)(54906003)(6916009)(36756003)(31696002)(7416002)(5660300002)(86362001)(66446008)(31686004)(8936002)(6512007)(26005)(186003)(122000001)(83380400001)(38070700005)(2616005)(41300700001)(4326008)(91956017)(76116006)(66946007)(66476007)(966005)(38100700002)(64756008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U25aMFVvL0JHNXQxUEVuNmVmNjB4ZzZleHYwUlhwQkRZTlgwa2VCVlNvd1lk?=
 =?utf-8?B?WjNaSmZjWU4xaFh0NmM0VVRaM2lrcHBYTC8yenE3WDRINmpzTlV0M0hSUDNi?=
 =?utf-8?B?bG1DMzROZUNwSFY1WXlJVWM3OVNOT0JBdUxOWVdPd1M0Q1MvSDh0YmVJMnox?=
 =?utf-8?B?OTZnT0R5TllRZklwNXEwVVZveWZWNENKWWJpVjVzNnJNTWIvdkcvMTRQMG54?=
 =?utf-8?B?UEZXZ0JKNkcwcEtXbnpsbnFjcXFoM09tZDNJOUF6VkRyc25YK0lnekFBQ0Yr?=
 =?utf-8?B?Wnp2SzU2U2E0aDB0enRPMnZLYkRIdmVDTmhISktxZnIvQWhqSlhHaWFKQ3lI?=
 =?utf-8?B?SG9BMGY1dU04bm1nWUNKWW51OTgvV2toT09UTmFqVVpRMDlod203Y0NkTmw5?=
 =?utf-8?B?OGhQMTNVT0tLZGRjdjlEd1g0Snl6UW16ODNmVzhZa05TWmRldEw4UjlsdVM1?=
 =?utf-8?B?WXpQMFdYelJ6YUJQMVVOUU0xbXdMZVh5RHdyWlpXai82YWQ5ZUVkRGx4cTRt?=
 =?utf-8?B?bnNPbE5zK2dXUzRIZDMxOUlKR0lMMlZYOU9rMDhIOUhOZVR3RzZ6eCttK3ZU?=
 =?utf-8?B?eGRnY0Z3YmNvcFNYOGJBbjVzcWlITXQ2STdDK1dReUZrUW91VjI5OE5aMG5x?=
 =?utf-8?B?NWhFekZJYk9SNTc0T1lHM2RDdzU0d1ZVbjBtdXhKQVZXUTcxT3ZFNFZtUGlI?=
 =?utf-8?B?Y3cyaGtuSnFoaXVsQllMbWFwMW1mVnNZSHBWTzRsK1pBS2ZxUUNNNTU0bUJV?=
 =?utf-8?B?NExXWjhEZGcyWjlNbE42OXVHaHhVRGhwYXM0OGI5Qi9JdG1xNjI3YUNTckUr?=
 =?utf-8?B?REpGaDVnUmp0RlNjbit5RmpKeHdhbHB3aFRtNzFJV25YMGIzc1BBVEE0WHRU?=
 =?utf-8?B?UTd6QU51bTJjdUpnTk5CbHUycUJmaUEyK1hZVzI4V0wyVmxrYTYyWnR0QUY4?=
 =?utf-8?B?QWdnQmg1MHg2U3E1Z0ZVQVlRa29tclI0eE8vUlk4ZVR4Tm5kYlhURFZyOUZZ?=
 =?utf-8?B?RFF2WkwrYW9vMVBNM3VpM0x6ZTJ2aWVCNm9wWGtwMTdIQ3NMZ3NnZFkxY3Zs?=
 =?utf-8?B?VlhkL0JFR0FqKzR4d1lnNCtnb3RlMFBZYyttS2JFZjF4ZFZ4eStwZkV2c2Yz?=
 =?utf-8?B?U0d5Mjh1eTlKcXh4VEJZMUpMei81SEhobm9WcUFDeGZrY1RWdzFoOWhCb3JV?=
 =?utf-8?B?eWl5Z0owa2syWFFCc29sWmlIelhPZFZJRmFOa0RLdksra0xiMFFhYmRaaGQ4?=
 =?utf-8?B?S0t4cTBqQUwrK09iZ2dudmNEKytKZGNGWEtySUV2QTBBQ3ovb2NySVZ3SG1E?=
 =?utf-8?B?SUpzVzRNYXcvNzVOWXJ6SVlRMmg1cFZJNVMyNzgxUkliSElNb2dvY25uZDcy?=
 =?utf-8?B?YkpRc0V2b3hhY0QvS0h3ajFqc09DVERLL1M0QVNjT2FCdWMwc2pmWkU2SHhP?=
 =?utf-8?B?SmF6a3BkVHFFYUVmRHRkZWR3VS8vSmE5b1lUN2Fkc3RiclJneDJtMWs0RjJU?=
 =?utf-8?B?b3IzU2YyRlByeUR3U1FWejhyZFU4eWFUWE9GcWJvcytUZzBYcUtzam4zTW1i?=
 =?utf-8?B?b3drQmVHUCtEUWFpN1pzcVZRZWFmK3JxMHJXemJESTQ4a2JycnBBTzNJVXcw?=
 =?utf-8?B?aGJ5N2xMazUzRXhEUWFkUmRVVDBOMjVObFo1bXB4VjgrNWdCa1JNR3RMOG4y?=
 =?utf-8?B?ZlJDa0xJNnVOc1VidXgxUFVQSmszZHNsVzZSd0pCblBiWFlEaXo5VFI5WWll?=
 =?utf-8?B?SlZNTmZYY3JuWDZ3MEYwQ2ptR2gxZFJlejdST2hZclJVdFlLRys1VWtIRU1B?=
 =?utf-8?B?OEhLNE1ndTBWWmh4VWVGalFTekJ3NkdIYXBNNDdacHA3eHNDbGM0Nis1SmVh?=
 =?utf-8?B?R2VBVS8rMzR4ZlFFT3B4VXhEYXNxaVN6MGZqbWxzKzVqb0NXcXljazIraXNW?=
 =?utf-8?B?MDBHZXV4R2VsVkxZUy9ndDBnMUZLcjdra0taZnMzQ0tVQm9zUVhHK1JBSGk1?=
 =?utf-8?B?a1VJMklHQTZrU0N5VlR2V0l2NEVYcjVXRlBZNG5rUXYvRWo0UWVneG1TYW9O?=
 =?utf-8?B?ckdvcTVRbFpzSUJiaHJ2SmhUN1BLQ0ViVVFuMGNsRHNoYVZHNkZNbW9jL3N6?=
 =?utf-8?B?bzJlbFYvTUdPb0tEUUJUcnRYL2diNGtTanBpMmV4anRNSjlIcWVLQU9veVp5?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93096D4ADDFAA740B0D731392CF656D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721d9f07-5032-4877-42b0-08da5d7fda57
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 05:41:33.1259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAQqqrrlOWCmebx26nYZp7NfEL6aGHZa+ElXB6VnbVN3YzT3l1tQRpB4f+1+BjxwGwERTh2qWDkImZ87PWYuEzSq0MNYC2Gto8sDCIoaNy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5606
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDcuMjAyMiAxNzowMywgSGVydmUgQ29kaW5hIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIENsYXVkaXUsDQo+IA0KPiBPbiBGcmksIDEg
SnVsIDIwMjIgMTA6NTY6NDYgKzAwMDANCj4gPENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20+
IHdyb3RlOg0KPiANCj4+IE9uIDAxLjA3LjIwMjIgMTA6MDksIEhlcnZlIENvZGluYSB3cm90ZToN
Cj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEFkZCBVRFBI
UyAodGhlIFVTQiBIaWdoIFNwZWVkIERldmljZSBQb3J0IGNvbnRyb2xsZXIpIHN1cHBvcnQuDQo+
Pj4NCj4+PiBUaGUgYm90aCBsYW45NjZ4IFNPQ3MgKExBTjk2NjIgYW5kIExBTjk2NjgpIGhhdmUg
dGhlIHNhbWUgVURQSFMNCj4+PiBJUC4gVGhpcyBJUCBpcyBhbHNvIHRoZSBzYW1lIGFzIHRoZSBv
bmUgcHJlc2VudCBpbiB0aGUgU0FNQTVEMw0KPj4+IFNPQy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IEhlcnZlIENvZGluYSA8aGVydmUuY29kaW5hQGJvb3RsaW4uY29tPg0KPj4+IC0tLQ0KPj4+
ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kgfCAxMSArKysrKysrKysrKw0KPj4+ICAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngu
ZHRzaQ0KPj4+IGluZGV4IDNjYjAyZmZmZTcxNi4uYzk4ZTcwNzVjMmI0IDEwMDY0NA0KPj4+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPj4+ICsrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2xhbjk2NnguZHRzaQ0KPj4+IEBAIC00NTgsNiArNDU4LDE3IEBAIGNwdV9jdHJsOiBz
eXNjb25AZTAwYzAwMDAgew0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweGUw
MGMwMDAwIDB4MzUwPjsNCj4+PiAgICAgICAgICAgICAgICAgfTsNCj4+Pg0KPj4+ICsgICAgICAg
ICAgICAgICB1ZGM6IHVzYkBlMDgwODAwMCB7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuOTY2Mi11ZGMiLA0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiYXRtZWwsc2FtYTVkMy11ZGMiOw0KPj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHJlZyA9IDwweDAwMjAwMDAwIDB4ODAwMDA+LA0KPj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDwweGUwODA4MDAwIDB4NDAwPjsNCj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNzYgSVJRX1RZUEVfTEVWRUxfSElH
SD47DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGtzIEdDS19HQVRF
X1VEUEhTPiwgPCZuaWNfY2xrPjsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1u
YW1lcyA9ICJwY2xrIiwgImhjbGsiOw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+Pj4gKyAgICAgICAgICAgICAgIH07DQo+Pj4gKw0KPj4NCj4+IEkg
aGF2ZSB0aGVzZSBjb21waWxhdGlvbiB3YXJuaW5nczoNCj4+DQo+PiAgIERUQyAgICAgYXJjaC9h
cm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0Yg0KPj4gYXJjaC9hcm0vYm9vdC9kdHMvbGFu
OTY2eC5kdHNpOjQ2MS4yMS00NzAuNTogV2FybmluZyAoc2ltcGxlX2J1c19yZWcpOg0KPj4gL3Nv
Yy91c2JAZTA4MDgwMDA6IHNpbXBsZS1idXMgdW5pdCBhZGRyZXNzIGZvcm1hdCBlcnJvciwgZXhw
ZWN0ZWQgIjIwMDAwMCINCj4+ICAgRFRDICAgICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtv
bnRyb24ta3N3aXRjaC1kMTAtbW10LTZnLTJncy5kdGINCj4+IGFyY2gvYXJtL2Jvb3QvZHRzL2xh
bjk2NnguZHRzaTo0NjEuMjEtNDcwLjU6IFdhcm5pbmcgKHNpbXBsZV9idXNfcmVnKToNCj4+IC9z
b2MvdXNiQGUwODA4MDAwOiBzaW1wbGUtYnVzIHVuaXQgYWRkcmVzcyBmb3JtYXQgZXJyb3IsIGV4
cGVjdGVkICIyMDAwMDAiDQo+PiAgIERUQyAgICAgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1r
b250cm9uLWtzd2l0Y2gtZDEwLW1tdC04Zy5kdGINCj4+IGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2
NnguZHRzaTo0NjEuMjEtNDcwLjU6IFdhcm5pbmcgKHNpbXBsZV9idXNfcmVnKToNCj4+IC9zb2Mv
dXNiQGUwODA4MDAwOiBzaW1wbGUtYnVzIHVuaXQgYWRkcmVzcyBmb3JtYXQgZXJyb3IsIGV4cGVj
dGVkICIyMDAwMDAiDQo+IA0KPiBJIGFtIGEgYml0IGNvbmZ1c2VkIGJ1dCB0aGVzZSB3YXJuaW5n
cyBkbyBub3QgYXBwZWFyIG9uIG15IHNpZGUgKHBhdGNoZXMNCj4gYmFzZWQgb24gdjUuMTktcmMx
KS4NCj4gV2hhdCBpcyB0aGUgZXhhY3QgY29tbWFuZCB0aGF0IGxlYWRzIHRvIHRoZXNlIHdhcm5p
bmcgPw0KDQpPaCwgYW5kIHRoZSBzZXQgb2YgY29tbWFuZHMgSSdtIHVzaW5nOg0KbWFrZSBzYW1h
N19kZWZjb25maWcNCm1ha2UgbWVudWNvbmZpZyArIGVuYWJsZSBDT05GSUdfU09DX0xBTjk2Ng0K
bWFrZSBXPTEgZHRicw0KDQo+IA0KPiBUaGFua3MsDQo+IEhlcnbDqQ0KPiANCj4gLS0NCj4gSGVy
dsOpIENvZGluYSwgQm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVy
aW5nDQo+IGh0dHBzOi8vYm9vdGxpbi5jb20NCg0K
