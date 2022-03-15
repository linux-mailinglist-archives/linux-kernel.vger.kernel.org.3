Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA054D9591
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbiCOHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345625AbiCOHsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:48:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736A94B85E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647330454; x=1678866454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wfO0lh0uVa/0HasVLBLpapWL7FZWXs71FCQvpUyOUmI=;
  b=EZZ4Mt51GS7vxMqiGDAVy7w1NMwFMxY5JalkYHE88TV1Erhj1Ea0+2Q6
   m5Y+6DJsHHmO3tEFzHABa8V7y0DBvIW8jlwl9SBv1IlS8S0hqbsQMR1R7
   6s5EJhpUjyWHpR6VepQA9S3nUwRtChE01b/Rb2nfU6FN1X4/tYzupz8Qo
   F3Z1qtdrDE3Hq9Ox/9v0g7ibrmSZKOBvlfpO9XSw0UH0ZhrflZXm4kIG7
   LtN0rthYqJoHI8cfDv0budTNv51Qqvdy40FtCv+ifpa3Pn3nls/nDtoQb
   J3TJaP3zFoBLJQJVoX7NQYj3WyPi34qSt4oFq7I29H1cebRUV6XyuBMbZ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,182,1643698800"; 
   d="scan'208";a="88947232"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Mar 2022 00:47:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 15 Mar 2022 00:47:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 15 Mar 2022 00:47:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kai+5YEuMQEGOxiEEY3CNTUj37Cj8GcamD/4MCudnJ/G+UwURG6sNwLH34iG+Z/9aNWLuLvsIvp3fHVF+uoDponILwCOSB/2qLwCjfrIlfCabMdfExY0KIi+AAzqDkCuzjXRpnvlTnPYDZlMWNDCbj1fJ6Kdp8LwUwK5owODClkpNHDBoPi2fcIxh89IzpnK67xmjMqlmzvI1pQ5ObiJPcOExNeAMdaJLbhfA3QXg1gOOxIpEACsRixRlOqNOaIFE2yVF1laufk777ipATq7ReMRuOkoyQ/KUHqHkcBfkrQCj3VVqYNbjjsXTQNWpzYkefJAADSw1oNY3OJ0k6zqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfO0lh0uVa/0HasVLBLpapWL7FZWXs71FCQvpUyOUmI=;
 b=hs778CR4psAuGpoDEg2Bb25qBvVRHsLJAwzDUBFWsy/fJHKM7djIX6bVRUVglSVE3a8MaudxS4hFdIlvYIf1nXW4dg8F5O7fjJj3C2BiLCekRprqWkth0+7k8Yc5uQBkbbZ6Cocdsu+mFEX8J36hPG8CrrgY/PJ4wW5Af9b7wottRIHQxmcX/wLAYc/G7fatXw5OMDqwH/I/uJxmauQR75sn7tmC4+dmOVEMT+2qdT/tte/hJQ7puxEvpTM/RvmCRsYTec3JivtNGJwdvGtOc8Un+3/Oixc4QCGVzX/XkTCrXFH43y5t4hrMRX5OgqKaZRgO5+tf7KAEPduHrju4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfO0lh0uVa/0HasVLBLpapWL7FZWXs71FCQvpUyOUmI=;
 b=LBIRwYdFSHSV1WIh97ZTFfpooANYX2cmy4T2LySHvKvYPrl+Mh4wEFT2apOn9d+40uGAUb59jLd4+o+TFRN6yhGxr3jgtvg/uB9cq993iYEyZtx8UScjLLgzlIgYdgVggt35zp3AsQcE0Ol/fiE/ek6N7b5eENonviGZ6+lKTRg=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN6PR11MB1267.namprd11.prod.outlook.com (2603:10b6:404:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 07:47:28 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 07:47:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heiko.thiery@gmail.com>
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Topic: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Index: AQHYMfKsE2aD0LVQO0KmbZoSG1RT0g==
Date:   Tue, 15 Mar 2022 07:47:28 +0000
Message-ID: <683b7df7-cd34-c87b-9918-fd63d09df2f3@microchip.com>
References: <20220304185137.3376011-1-michael@walle.cc>
 <7f339d0c-5ca9-261c-a545-d4ebf3bda140@microchip.com>
 <92cde38c-d398-44f4-26f8-ef4919f5944e@microchip.com>
 <7f947928e7189f98eb950828990b3920@walle.cc>
 <91393780-1521-09b7-8dea-14c65e18b37e@microchip.com>
 <0cf8dbbf4ad005abd3db825fb257dedd@walle.cc>
 <33464af7-b445-6229-a02d-703a5ce6b5ef@microchip.com>
 <77c2c64f362b08cbbdab517bbaa49101@walle.cc>
In-Reply-To: <77c2c64f362b08cbbdab517bbaa49101@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4adbbaa9-cdc0-4583-a062-08da06580dc1
x-ms-traffictypediagnostic: BN6PR11MB1267:EE_
x-microsoft-antispam-prvs: <BN6PR11MB12677D1DD26C91155B02FFEBF0109@BN6PR11MB1267.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJFaZLyf98085HBTkgIBJABlCAXK6os5K+zLl8ad8ekQBvRCkwu/JaXJsH09Qkzjd5iDHBzXMQerlPffpVJrA1lcb/38e3e+qV6knyYdhkwEmi+blZpF06H9Nzszif163MfHGMvO57lD99cUtF6ar9yPTdhBberxKrKDgFD06vYet3lT/B/5MCNgHPWVVmZLXdMjXRqSvwmvB2P1KsTeQsIkubjnGJb9MY2RK+k/PP7CK8PjOJr1zQwo0tp20654IJ6Lla/jQ7ghz0fcPJWhYmhoL38JiH3MhwTdKyuCQ9AaMKCkIRiYabQ8i/q19H/BSmokpXVesJe3VwOtsDNDlTbp6TGfrNhplD8a/1cg12OaGcqUSRC2pi27DN/OVlwZotrmbTYtJU5GhYOXn9mhJpfHnK3gjkmf4OFuApdjHWL00LAKCoq7CXB8RYDS9LA3Yny5DkYHt9DEzCBnnpUua/NyM9W0gTI7WvXBSeUR8QifwFzxDyYF+lVhGyODCF6oY/5W2l1OAQFIgq08u2tRbkw0nURuOm7iCYXdz8cuZRvqj8D7YLRUEoKBbaU1f+Tvro3iqO7WQYKKUi/ee2LmHi+uDAt7GHDggJnqPjJD9DwOYMUFqjPnqmnvaIlWoX7CNy1W/1qDndFxDTvj5mnNZIGudL/J02VBpRzgM2gUiJunCCLLymA5tgdVkxmwuHOreVuVY603kY9L80k6OVsZ1lWTCGKLQ8T7dNE0m7QyZtASvj0vn9dNGI0OxmYIvecjRiYfwpbnyvk38oufXY8/PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(71200400001)(186003)(6506007)(6512007)(2906002)(83380400001)(8936002)(5660300002)(53546011)(54906003)(508600001)(6486002)(76116006)(66946007)(66476007)(6916009)(66446008)(66556008)(4326008)(91956017)(64756008)(8676002)(316002)(122000001)(38100700002)(31686004)(36756003)(31696002)(86362001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnhsT1VhbnNyWXBpZWZtYk91ZWNIVm5qeEkzWnJmWXFhdTl3QjlQM3JYdmFt?=
 =?utf-8?B?U0I0Ymh2d0J3MzA4RUxiYWdlNm4raU1SSS9aUXFMV2NoUFRjUHhVT1BRRnla?=
 =?utf-8?B?Q2dGOTA4aDNwUU5yaWNmUHEzcFJIS1YybzJwNEhwamsrU3VBbnVWOGFzbFZj?=
 =?utf-8?B?UGRwbzNOaEh4MXpkTlFNdVNVVkRZSVZmNDFwUHNQeWRORlBuakhrZG40dXRY?=
 =?utf-8?B?OFZNZG52Y2VqeVZlc2d4Z3lnZWZ0eDF1TzRtYmRyTXhtdndwUm9JN2NveVVZ?=
 =?utf-8?B?NGZzM1hneWk4Q2owN1pRUmFSYlRPeWUxeHA2V0hvMm1kZG9kMGZFWFpzckly?=
 =?utf-8?B?ZEU1MU52NzZYbUN1RTFKaTIvbldkZ2VWUUgzY29RdHlDcVA0UDNwZWhhWmpz?=
 =?utf-8?B?YkZKWk1UU2NRT3grc0pGRk1SZEliYmNBVDcxTzJsQjdmaTlIbE1ZWnNBQkxi?=
 =?utf-8?B?ZU1qd2NzRUZBc0ZoR2F3V0tFb0pXQ0ZxNVUwUkh0UmpUcmZodGRMUmxoUmlx?=
 =?utf-8?B?NHA3NW96bmk1U0FraEdLZnZDOFNxdERUQ3AwK0lMb0hJWlpqWTh2NnluRnk4?=
 =?utf-8?B?dVUrWkt4aHo2RS9YT0FZRmc0MnI3NmhzWEx3c1JpSEJvKzgyVDdGWUZXaS9D?=
 =?utf-8?B?SC82ZUVDWUhhWVNHZVB2VTE0UXVnWmVpRDVYbms5UHpnK0xhbFVhZG1qRWZl?=
 =?utf-8?B?TElzNnVlL0VmeXNiSkloOTFHNGc4SWJob2c3WHh4eXl5NGtFU1NSMHlleXVO?=
 =?utf-8?B?ekxZdDJFNFRoZkRVWWQ2blJTcnJ5bzRmNXBXSWZDWTF0M00rVU9lWEw3U1M0?=
 =?utf-8?B?ZjNWNjN1aEZaeHhGQjl3MGUzMlVlT1ZneHVwaHlZS3BWSTZCb3VzUUprOFE1?=
 =?utf-8?B?dU42UFJ5TXZvZWtpdHoreVkrc1BIcmtKWGIydzFyeHNaWUJtNmtVOElRNVlP?=
 =?utf-8?B?ZXN6T0Mva0FXTEFlQzl4T3FLdHFkcElPR2hRWU1aaE5QU3orb2pJTkc1ZzZV?=
 =?utf-8?B?RHZGTzhnMktEcGZLYTFUNlRLVlRKSXdScWdBa2R1SEYrMWFpUy9hallscENY?=
 =?utf-8?B?cWR5WFhhN29rcjVWZHNtL0FaVWZyL0dESms0eUMzODVmdVBjbEsrQkw2by9G?=
 =?utf-8?B?a1M3RTM1OGNpTjYvQ3pzb1kveEFnaVJzZWVXYWNCTWk5dEFPQWhtNXdCOFVS?=
 =?utf-8?B?WlpoY2xMM2tuZllTcGJkWGM3WWt0V2dRSVJwL2ZIV0E1L1d6SE5MU3l6TzRo?=
 =?utf-8?B?YU5QRURYanVTb2p5Z1cwMklxYkhkQnRVRzBRNVIrRmV5QWRnaEdDdUxCM0Er?=
 =?utf-8?B?ZldvU2NuaU4xdFgydTk2KytKVk9OOXk4WUlnTTNkMXE0QXpuRWhqbjhNK3dM?=
 =?utf-8?B?OXBoRHlkdEhlTi8wMW5BbHc4RitmcVF0N1AveDU1dGcxQk44dU8xVjExdVBm?=
 =?utf-8?B?R0EzbmdMZFBVSkxlb0YvRndaWVlMazAzTXpVN2I4ZDZBY0NILzl1OFJpNkpk?=
 =?utf-8?B?QlRwNHlzTy9FYnNYSmJtTXNxTzZWeWZ3OWZseWxndlAyNW1rNWpNMkl0Ulpu?=
 =?utf-8?B?VGhMRlA4SFdvU1Ivek9LTUJJbHJnMUpqTGhiemFqbDVIV252SUNGOHZhL3ZY?=
 =?utf-8?B?OERTRGZwcWF6NXhxMXlESmtGdnI0a29VUTZoVUZnNzVJRDZxSTNKcWJoTXZT?=
 =?utf-8?B?NUppeGJYaTdYcFRLcTNsajJsdnJ0V1RCVFZ1UEkycGVhVERFRVZoTURWK2Y0?=
 =?utf-8?B?U2tYNHBScklVckFudUZEOEtCSEllSFUrbE9uMHRFREVjdUhsQndJT2t0Y2xx?=
 =?utf-8?B?OHVwNEJ6eDVWUVk4WWxnT2VRTUg2bUdwcHF2cnlmWTZQS1RpUGd2UmhCMlNM?=
 =?utf-8?B?SGxHQzhkdCtYcmdkN25xUis4bjh3U2hEczdDZXFicFF6SXdtamgzUEc5eDl0?=
 =?utf-8?B?bmZKZURpS3NEYlZLbjBUdEZCa3kzVXlWNXV6TWVNV0NoNC9vYU8xODc0VHlD?=
 =?utf-8?B?TVI4aDNONmFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31E1690113AB9D4F8ADD929AEFD0B25A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adbbaa9-cdc0-4583-a062-08da06580dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:47:28.3091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqof0FM6qCTwlnBP8Nef2NOVYy6M4LZ/CTSaxpcHmbYkrdRt/vHThHIsdHfEAJkC4HJ/EBiMovXfLc0OsJmcnsalYXZKKsyOykD5kAc0EHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1267
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8yMiAwOToyNCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAzLTE1IDA2OjU1LCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDMvMTQvMjIgMjI6NDIsIE1pY2hhZWwg
V2FsbGUgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IEFtIDIwMjItMDMtMDkgMDU6NDksIHNjaHJpZWIgVHVkb3IuQW1iYXJ1c0BtaWNy
b2NoaXAuY29tOg0KPj4+PiBPbiAzLzcvMjIgMjA6NTYsIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+
Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQ0KPj4+Pj4ga25vdw0KPj4+Pj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+
Pj4NCj4+Pj4+IEFtIDIwMjItMDMtMDcgMTA6MjMsIHNjaHJpZWIgVHVkb3IuQW1iYXJ1c0BtaWNy
b2NoaXAuY29tOg0KPj4+Pj4+IE9uIDMvNy8yMiAwOToxMiwgVHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tIHdyb3RlOg0KPj4+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPj4+Pj4+PiBrbm93DQo+Pj4+Pj4+IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4+Pj4NCj4+Pj4+Pj4gT24gMy80LzIyIDIwOjUxLCBNaWNo
YWVsIFdhbGxlIHdyb3RlOg0KPj4+Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4+Pj4+IGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFdoaWxlIHRoZSBmaXJzdCB2ZXJzaW9u
IG9mIEpFU0QyMTYgc3BlY2lmeSB0aGUgb3Bjb2RlIGZvciA0IGJpdA0KPj4+Pj4+Pj4gSS9PDQo+
Pj4+Pj4+PiBhY2Nlc3NlcywgaXQgbGFja3MgaW5mb3JtYXRpb24gb24gaG93IHRvIGFjdHVhbGx5
IGVuYWJsZSB0aGlzDQo+Pj4+Pj4+PiBtb2RlLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEZvciBub3cs
IHRoZSBvbmUgc2V0IGluIHNwaV9ub3JfaW5pdF9kZWZhdWx0X3BhcmFtcygpIHdpbGwgYmUNCj4+
Pj4+Pj4+IHVzZWQuDQo+Pj4+Pj4+PiBCdXQgdGhpcyBvbmUgaXMgbGlrZWx5IHdyb25nIGZvciBz
b21lIGZsYXNoZXMsIGluIHBhcnRpY3VsYXIgdGhlDQo+Pj4+Pj4+PiBNYWNyb25peCBNWDI1TDEy
ODM1Ri4gVGh1cyB3ZSBuZWVkIHRvIGNsZWFyIHRoZSBlbmFibGUgbWV0aG9kDQo+Pj4+Pj4+PiB3
aGVuDQo+Pj4+Pj4+PiBwYXJzaW5nIHRoZSBTRkRQLiBGbGFzaGVzIHdpdGggc3VjaCBhbiBTRkRQ
IHJldmlzaW9uIHdpbGwgaGF2ZSB0bw0KPj4+Pj4+Pj4gdXNlDQo+Pj4+Pj4+PiBhDQo+Pj4+Pj4+
PiBmbGFzaCAoYW5kIFNGRFAgcmV2aXNpb24pIHNwZWNpZmljIGZpeHVwLg0KPj4+Pj4+Pj4NCj4+
Pj4+Pj4+IFRoaXMgbWlnaHQgYnJlYWsgcXVhZCBJL08gZm9yIHNvbWUgZmxhc2hlcyB3aGljaCBy
ZWxpZWQgb24gdGhlDQo+Pj4+Pj4+PiBzcGlfbm9yX3NyMl9iaXQxX3F1YWRfZW5hYmxlKCkgdGhh
dCB3YXMgZm9ybWVybHkgc2V0LiBJZiB5b3VyDQo+Pj4+Pj4+PiBiaXNlY3QNCj4+Pj4+Pj4+IHR1
cm5zIHVwIHRoaXMgY29tbWl0LCB5b3UnbGwgcHJvYmFibHkgaGF2ZSB0byBzZXQgdGhlIHByb3Bl
cg0KPj4+Pj4+Pj4gcXVhZF9lbmFibGUgbWV0aG9kIGluIGEgcG9zdF9iZnB0KCkgZml4dXAgZm9y
IHlvdXIgZmxhc2guDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+PiBSaWdodCwgSSBtZWFudCBh
ZGRpbmcgYSBwYXJhZ3JhcGggc3VjaCBhcyB0aGUgb25lIGZyb20gYWJvdmUuDQo+Pj4+Pj4+DQo+
Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0K
Pj4+Pj4+Pj4gVGVzdGVkLWJ5OiBIZWlrbyBUaGllcnkgPGhlaWtvLnRoaWVyeUBnbWFpbC5jb20+
DQo+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+IGNoYW5nZXMgc2luY2UgUkZDOg0KPj4+Pj4+Pj4gwqAt
IHJld29yZGVkIGNvbW1pdCBtZXNzYWdlDQo+Pj4+Pj4+PiDCoC0gYWRkZWQgY29tbWVudCBhYm91
dCBwb3N0X2JmcHQgaG9vaw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFR1ZG9yLCBJJ20gbm90IHN1cmUg
d2hhdCB5b3UgbWVhbnQgd2l0aA0KPj4+Pj4+Pj4gwqAgTWF5YmUgeW91IGNhbiB1cGRhdGUgdGhl
IGNvbW1pdCBtZXNzYWdlIGFuZCBleHBsYWluIHdoeSB3b3VsZA0KPj4+Pj4+Pj4gc29tZQ0KPj4+
Pj4+Pj4gwqAgZmxhc2hlcyBmYWlsIHRvIGVuYWJsZSBxdWFkIG1vZGUsIHNpbWlsYXIgdG8gd2hh
dCBJIGRpZC4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJdCBkb2Vzbid0IHdvcmsgYmVjYXVzZSB0aGUg
d3JvbmcgbWV0aG9kIGlzIGNob3Nlbj8gOykNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiDCoGRyaXZlcnMv
bXRkL3NwaS1ub3Ivc2ZkcC5jIHwgMTEgKysrKysrKysrKy0NCj4+Pj4+Pj4+IMKgMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4+Pj4+DQo+Pj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4+Pj4+Pj4+IGIvZHJp
dmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4+Pj4+Pj4+IGluZGV4IGE1MjExNTQzZDMwZC4uNmJi
YTliNjAxODQ2IDEwMDY0NA0KPj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRw
LmMNCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+Pj4+Pj4+PiBA
QCAtNTQ5LDYgKzU0OSwxNiBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcGFyc2VfYmZwdChzdHJ1Y3Qg
c3BpX25vcg0KPj4+Pj4+Pj4gKm5vciwNCj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIG1hcC0+dW5p
Zm9ybV9lcmFzZV90eXBlID0gbWFwLT51bmlmb3JtX3JlZ2lvbi5vZmZzZXQgJg0KPj4+Pj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFNOT1JfRVJBU0VfVFlQRV9NQVNLOw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqAgLyoNCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAqIFRoZSBmaXJzdCBKRVNEMjE2
IHJldmlzaW9uIGRvZXNuJ3Qgc3BlY2lmeSBhIG1ldGhvZCB0bw0KPj4+Pj4+Pj4gZW5hYmxlDQo+
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgKiBxdWFkIG1vZGUuIHNwaV9ub3JfaW5pdF9kZWZhdWx0
X3BhcmFtcygpIHdpbGwgc2V0IGENCj4+Pj4+Pj4+IGxlZ2FjeQ0KPj4+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgICogZGVmYXVsdCBtZXRob2QgdG8gZW5hYmxlIHF1YWQgbW9kZS4gV2UgaGF2ZSB0byBk
aXNhYmxlDQo+Pj4+Pj4+PiBpdA0KPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgICogYWdhaW4uDQo+
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgKiBGbGFzaGVzIHdpdGggdGhpcyBKRVNEMjE2IHJldmlz
aW9uIG5lZWQgdG8gc2V0IHRoZQ0KPj4+Pj4+Pj4gcXVhZF9lbmFibGUNCj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCAqIG1ldGhvZCBpbiB0aGVpciBwb3N0X2JmcHQoKSBmaXh1cCBpZiB0aGV5IHdh
bnQgdG8gdXNlDQo+Pj4+Pj4+PiBxdWFkDQo+Pj4+Pj4+PiBJL08uDQo+Pj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgKi8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gR3JlYXQuIExvb2tzIGdvb2QgdG8gbWUuIEkn
bGwgY2hhbmdlIHRoZSBzdWJqZWN0IHRvICJtdGQ6IHNwaS1ub3I6DQo+Pj4+Pj4+IHNmZHA6Ig0K
Pj4+Pj4+PiB3aGVuIGFwcGx5aW5nLg0KPj4+Pj4+DQo+Pj4+Pj4gQXMgd2UgdGFsa2VkIG9uIHRo
ZSBtZWV0aW5nLCB3ZSBjYW4gaW5zdGVhZCBtb3ZlIHRoZSBkZWZhdWx0IHF1YWQNCj4+Pj4+PiBt
b2RlDQo+Pj4+Pj4gaW5pdA0KPj4+Pj4+IHRvIHRoZSBkZXByZWNhdGVkIHdheSBvZiBpbml0aWFs
aXppbmcgdGhlIHBhcmFtcywgb3IvYW5kIHRvIHdoZXJlDQo+Pj4+Pj4gU0tJUF9TRkRQDQo+Pj4+
Pj4gaXMgdXNlZC4gVGhpcyB3YXkgeW91J2xsIG5vIGxvbmdlciBuZWVkIHRvIGNsZWFyIGl0IGhl
cmUuDQo+Pj4+Pg0KPj4+Pj4gTWgsIEkganVzdCBoYWQgYSBsb29rIGFuZCBJJ20gbm90IHN1cmUg
aXQgd2lsbCB3b3JrIHRoZXJlLA0KPj4+Pj4gYmVjYXVzZSBpbiB0aGUgZGVwcmVjYXRlZCB3YXks
IHRoZSBTRkRQIGlzIHN0aWxsIHBhcnNlZCBhbmQNCj4+Pj4+IHRodXMgd2UgbWlnaHQgc3RpbGwg
aGF2ZSB0aGUgd3JvbmcgZW5hYmxlIG1ldGhvZCBmb3IgZmxhc2hlcw0KPj4+Pj4gd2hpY2ggZG9u
J3QgaGF2ZSBQQVJTRV9TRkRQIHNldC4NCj4+Pj4NCj4+Pj4gTW92aW5nIHRoZSBkZWZhdWx0IHF1
YWRfZW5hYmxlIG1ldGhvZCB0bw0KPj4+PiBzcGlfbm9yX25vX3NmZHBfaW5pdF9wYXJhbXMoKSwN
Cj4+Pj4gdGh1cyBhbHNvIGZvciBzcGlfbm9yX2luaXRfcGFyYW1zX2RlcHJlY2F0ZWQoKSBiZWNh
dXNlIGl0IGNhbGxzDQo+Pj4+IHNwaV9ub3Jfbm9fc2ZkcF9pbml0X3BhcmFtcygpLCB3aWxsIG5v
dCBjaGFuZ2UgdGhlIGJlaGF2aW9yIGZvciB0aGUNCj4+Pj4gZGVwcmVjYXRlZCB3YXkgb2YgaW5p
dGlhbGl6aW5nIHRoZSBwYXJhbXMsIGlzbid0IGl0Pw0KPj4+DQo+Pj4gV2hhdCBkbyB5b3UgbWVh
bj8gVGhlIGJlaGF2aW9yIGlzIG5vdCBjaGFuZ2VkIGFuZCB0aGUgYnVnIGlzIG5vdA0KPj4+IGZp
eGVkIGZvciB0aGUgZmxhc2hlcyB3aGljaCB1c2UgdGhlIGRlcHJlY2F0ZWQgd2F5LiBJdCB3aWxs
IGdldA0KPj4+IG92ZXJ3cml0dGVuIGJ5IHRoZSBzcGlfbm9yX3BhcnNlX3NmZHAgY2FsbCBpbg0K
Pj4+IHNwaV9ub3Jfc2ZkcF9pbml0X3BhcmFtc19kZXByZWNhdGVkKCkuDQo+Pg0KPj4gcmlnaHQs
IGl0IHdpbGwgbm90IGNoYW5nZSB0aGUgbG9naWMgZm9yIHRoZSBkZXByZWNhdGVkIHdheSBvZg0K
Pj4gaW5pdGlhbGl6aW5nDQo+PiB0aGUgcGFyYW1zLg0KPj4NCj4+Pg0KPj4+PiBBIG1vcmUgcmVh
c29uDQo+Pj4+IHRvIHVzZSBQQVJTRV9TRkRQL1NLSVBfU0ZEUCwgd2UnbGwgZ2V0IHJpZCBvZiB0
aGUgZGVwcmVjYXRlZCBwYXJhbXMNCj4+Pj4gaW5pdCBhdCBzb21lIHBvaW50Lg0KPj4+Pg0KPj4+
PiBObyBuZXcgZml4ZXMgZm9yIHNwaV9ub3JfaW5pdF9wYXJhbXNfZGVwcmVjYXRlZCgpLg0KPj4+
DQo+Pj4gSG0sIHNvIHdlIGRlbGliZXJhdGVseSB3b24ndCBmaXgga25vd24gYnVncyB0aGVyZT8g
SSdtIG5vdCBzdXJlDQo+Pj4gSSdkIGFncmVlIGhlcmUuIEVzcC4gYmVjYXVzZSBpdCBpcyBoYXJk
IHRvIGRlYnVnIGFuZCBtaWdodCBldmVuDQo+Pj4gZGVwZW5kIG9uIG5vbi12b2xhdGlsZSBzdGF0
ZSBvZiB0aGUgZmxhc2guDQo+Pj4NCj4+DQo+PiBldmVuIG1vcmUgYSByZWFzb24gdG8gc3dpdGNo
IHRvIHRoZSByZWNvbW1lbmRlZCB3YXkgb2YgaW5pdGlhbGl6aW5nDQo+PiB0aGUgZmxhc2guIFdl
J2xsIGdldCByaWQgb2YgdGhlIGRlcHJlY2F0ZWQgY29kZSBhbnl3YXksIG5vPw0KPiANCj4gSSBn
ZXQgeW91ciBwb2ludC4gQnV0IEkgZGlzYWdyZWUgd2l0aCB5b3Ugb24gdGhhdCBwb2ludCA6KSBG
ZWF0dXJlcz8NCj4gc3VyZSB3ZSBjYW4gc2F5IHRoaXMgc2hvdWxkbid0IGdvIHRvIGFueSBkZXBy
ZWN0YXRlZCBjb2RlIGZsb3cgYW5kDQo+IG1pZ2h0IHBva2UgdXNlcnMgdG8gcG9zdCBhIHBhdGNo
LiBCdXQgYnVnIGZpeGVzPyBJIGRvbid0IHRoaW5rDQo+IHdlIHNob3VsZCBob2xkIHRoZXNlIGJh
Y2suDQoNCldoeSB0byBmaXggc29tZXRoaW5nIHRoYXQgbmV2ZXIgd29ya2VkIGluIGEgZGVwcmVj
YXRlZCBjb2RlIHBhdGg/IEl0J3MNCmVxdWl2YWxlbnQgdG8gYWRkaW5nIG5ldyBzdXBwb3J0LCBu
bz8NCg0KPiBDb3JyZWN0IG1lIGlmIEknbSB3cm9uZywgYnV0IHdlIGNhbiBnZXQgcmlkIG9mIHRo
ZSBkZXByZWNhdGVkIHdheQ0KPiBvbmx5IGlmIGFsbCB0aGUgZmxhc2hlcyBhcmUgY29udmVydGVk
IHRvIFBBUlNFX1NGRFAgb3IgU0tJUF9TRkRQLA0KPiByaWdodD8gQW5kIEkgZG9uJ3Qgc2VlIHRo
aXMgaGFwcGVuaW5nIGFueXRpbWUgc29vbi4NCg0KUmlnaHQuIEkgdm90ZSB0byBkb24ndCBxdWV1
ZSBhbnkgbmV3IHBhdGNoZXMgZm9yIGRlcHJlY2F0ZWQgY29kZSBwYXRocywNCm5ldyBzdXBwb3J0
IG9yIGZpeGVzLiBCdXQgSSdtIG5vdCBjb21wbGV0ZWx5IGFnYWluc3QgaXQsIEkgZG9uJ3Qgc2Vl
DQp0aGUgcG9pbnQsIHRoYXQncyBhbGwuIExldCdzIHN5bmMgd2l0aCBQcmF0eXVzaCBhbmQgVmln
bmVzaCB0b28uDQoNCkNoZWVycywNCnRhDQo=
