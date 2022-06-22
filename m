Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AEA554BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357646AbiFVNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355448AbiFVNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:52:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B837A31917;
        Wed, 22 Jun 2022 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655905964; x=1687441964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/dGSUwIfXQDhMWzryhdC635Q77eZu7olT6rsBE7VZPA=;
  b=oUnP33hYHtx1os8j4rCGbq7d9tc/vzAAQTlYaW8zLUmJG91uL++L90ky
   a/RLcWkuj5/cK4vBOm+KfCwzzwdXumEDbvHXsvxUI/2bxRLJ+cjqf66dj
   eSXSn904ohAVQzxjT2s55B0uIjdJ/gn4FzdhRtGMyPb4ODgLsweEVGKaB
   q1tKJr1sABok1MVKO7EFtGdCTZgxYYEIWY2vlmqbHTW1JV/QWOfrBamLV
   hEfExgViN7m2XkBsxQJi2AEtpDEVJ69t63gL9gi566Pr9ksk8sd7PVZVx
   r67PzOROh/XpggUUn1MBGYiB2Cvrlf6KiSVTdFcpzHJKpXlxiLvj57iSK
   g==;
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="161544392"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2022 06:52:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Jun 2022 06:52:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 22 Jun 2022 06:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjPz4sIUvkWtsJD0VTJYFKjahy9asw76sSp8/u2Hgp2hcxoFaJ/nfJfqP3ue21MS7SLALJOnfq75O21MjtclxaUnBhm+aegcBsJOChT+eptABZzyAe5loD8Xsy6ys62k9hDPiuKTzUHq+sdy6lzd5TYu7TTFRMGrKbuMdk4vlcwPOQYvdOblWoQCxKCAbpKVBVgxJ8lMux14RlSV1WSKS9PVvEZzuQKIjT/Rj1dFvE1S3K+uebXy/z/g6VyfcA34XzHEicnaNatInPcEBFMauoIteQ7IBkGOdn546vdsZ2GHqruIBWzoO3Xykyubb89AvfEq/5EBYyXh5eN1KSStFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dGSUwIfXQDhMWzryhdC635Q77eZu7olT6rsBE7VZPA=;
 b=j3V126WFZgfn9Iq6nXUtTjBoneb53sOyYuPru7GeKALGaG4Fk96YWhmcVGwbBAJ5qx2XekCh4qDLEDnCJsTNbGyH1InyHEUs+hnFAntXEFBj55poejArMgeLHUaPKHDJfxiBXZzQ5HeqFYuxIEAtQ/cdLUxYdqBnVPlzePyA1j0q5h+g60jzzonioI3WwjP75Z5B5klRhLxBZeIP8m6I+F261AfNA2ZdJ8VL5a9ro70kAosaBouEscpnHR4psf1kVHWTWy2vBEI9h1TFIrn0C4yrRtCFlfYDuIt5ztceC62chL+ciSDyPFf7QDJgPk3LJdLGakxEzPX8vUdIZ/Pm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dGSUwIfXQDhMWzryhdC635Q77eZu7olT6rsBE7VZPA=;
 b=LMAIjzJnwvlSIFvIBm9jI6LAs6xC8o3VNUqoUrlQLh/uRxje58mUdW91cSqJhhGPjDPj+AfXObUyKao1HxtO4NxRwC8G2E8Kxb4QdKUm5xaAtgcoXPPrgZtBxelQH7qZFZ8X/KHHi/fMTd7uE/uZEI94Blo9dylOTP8V1cR53jU=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by BY5PR11MB4184.namprd11.prod.outlook.com (2603:10b6:a03:192::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 13:52:38 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::c9c8:3bab:6b8f:5376]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::c9c8:3bab:6b8f:5376%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 13:52:38 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>, <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <jacopo@jmondi.org>
Subject: Re: [PATCH v10 0/5] media: atmel: atmel-isc: implement media
 controller
Thread-Topic: [PATCH v10 0/5] media: atmel: atmel-isc: implement media
 controller
Thread-Index: AQHYXtNy0DBb1d5tjEaFV5GKOhbPdK1bn80AgAAIywCAABOpAIAABMaA
Date:   Wed, 22 Jun 2022 13:52:38 +0000
Message-ID: <5f7e6025-295f-55d6-067c-e0d341e58293@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
 <1da61f9c-0605-dc9d-63a3-21c18fcb74c7@xs4all.nl>
 <a19d9e72-7609-1daa-93eb-fdedcaa672c4@microchip.com>
 <0455d962-d13e-9d88-c513-282defe07dd2@xs4all.nl>
In-Reply-To: <0455d962-d13e-9d88-c513-282defe07dd2@xs4all.nl>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 518a381d-bd9d-4db9-660a-08da5456781f
x-ms-traffictypediagnostic: BY5PR11MB4184:EE_
x-microsoft-antispam-prvs: <BY5PR11MB418490BAFDE25C84FFAF26A5E8B29@BY5PR11MB4184.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZgHgpeYSVfxTp31fRaoiW9vA0SUt1xxI7S2TSWAJI7ptucEfrtRgg1TlCqthhmX4/oFVHvO+AhrroodL+ML4mJJ/CiXvX9N3g4GrZqGGB/UWxmLDB5Vvrpd3EgaxL6QUfU/nRC2/mhkodHiPXm8kc61N43gVn3lSeqrpBCFpq/xM1Ma7d9B7EdwK7bbAd4mckPhgasEuN4w9tN5gk+HwCB78V63nqFmIsAeGVCrUfq6QliDlaSV8CWYnk41Y43Uh3lap8BIDidh/LH4hsC3jCQNkW6u7J9AaK1+22jo4QZsNmIhqCI0J8bHYrOVBSn7alkpGCxkpB2bm2IBz7YNUM4yZvCESv6Y57nVczQIvWKhqYxcg4VA2uppfKLTtGFE9/TYlzXZPNDzgh1i0cOPxD49WSKG8fGFY+m/8i5BmoARfGI1WYjU3VJEJez3XugK0NqTAmZNPa5sSuHT7vzndhlmEi0NZBItUW8rwjZfGX4NV4/BrLicDCT+fn9PfLb8mlpH4wjryvXdjFXCX/94TKsYWBwDtu3NVciUT4E/BQZ61iiTwRjOmw+xyXoumoMBu/3Bdp4cwPyqRk2BQ3I/Ew3Jmf0RjvTLLjJSXQsCunF3kD5kCH33Fckvam0bSKgtomf3PqEqW896mbiZAKdcd9+gIwn3MuQdOpwc3WuE52XE60iVeK/2iRoBzXdIq5hMTGKTBimcUkxyuAu4LEQ3i2spB6cDeepCo4/1759+U5THh3pv8lYU/m4v1TIfHTde3CRuRS2+SZRcxP0Iq56RTatwbJt9kVoG8Myw13+D4pxOa3H+KLmUqZr0smkM0GS592l0StYgUp9h24m9GcESVrrnrZnKGlE5VNnj0ys0pQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(376002)(366004)(5660300002)(966005)(6486002)(8936002)(478600001)(6506007)(6512007)(26005)(86362001)(31696002)(2906002)(122000001)(53546011)(38100700002)(2616005)(41300700001)(186003)(38070700005)(83380400001)(4326008)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(316002)(36756003)(31686004)(110136005)(54906003)(91956017)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEpzRUFQd2lnZVN3SGwvNUNJS0FxejROZUtIanJINzNIMXZWQ241b3lNdGV2?=
 =?utf-8?B?SVlwT1BRcWt6VVdqVThyYWlyNEg0blNnemtkU1lxYlByQjA1eUxhTGI5MTY5?=
 =?utf-8?B?dm9mMWNkVkptcy9uUjl0OFU1VHh4NmRobUNGb3lkbUZwQzliNWVDT3RsS0Jj?=
 =?utf-8?B?b2pDQ2lpYVZJSVhGUUdsTWlSM3podWlZTGFMTDdhWkVNckRsQ0p6V0VwcG9Y?=
 =?utf-8?B?ZVVoanJ0c28xVXZnYWp1YjJHT1duTExhdVJ4YWsyTUp4SEVmRDYzeGFpaUhU?=
 =?utf-8?B?cjVHa0JSWnBKaFUxSVlCcnIxcFpCQnNwVHBXdFhtWFA3UmRkUk9HM2ZlNXlC?=
 =?utf-8?B?T2dXSjdFSWxJRjNwQThyMnVWcytqRGhnUU1jdjd3c1lpNnlxMTlTUGZWRFNB?=
 =?utf-8?B?c0dWQ0pBOEFFU3BBbm9BaHRud0VDWjJrNUI0UXZaQnNNdk12cGhVU0tkWXFI?=
 =?utf-8?B?UC9ONTVyRk45S3lWQjYyb29wZEprN0NHTTE4aXQvcVlIZVNETFFUSnFvSjdz?=
 =?utf-8?B?QXN0S3VXRThJVmFBdEhLdS83Q1Bhc2RXZXk5RUd2U0JHT01EdW1mQWJKRkVu?=
 =?utf-8?B?aWEwZ2hleVFOOGdpd010NnhURTJWVndwTFoxMzM2RzV3dDUxbThDKzJmdmxl?=
 =?utf-8?B?YWxRNDVtaGtRRDYzbFE0NzBTRnZqQ3EzajhYUmVRUTBrM3dteHZZcWRYaGo0?=
 =?utf-8?B?OVFyN2FOUFEzVHc5LzdyYS9tZFVzME1ZMjFTY3Nwd29sZm5SUGVRUlNTWXVv?=
 =?utf-8?B?cFVFTFBKcVIxYUZ4aDZmVktNN2FDcnFzbDQzL2UzQVBWb1h2ekthckx2eSsz?=
 =?utf-8?B?TitSNGlJVmJXWGFLVjNTNE5PY0NZcXByTG56U25yNmJKVVprd0pyZlh4K3FP?=
 =?utf-8?B?ZktlMHFuZDBPMi9oOTlNdUNxL0diVHUvbk9RQ0E0aVhJRllQSWQxZ1RlQUVJ?=
 =?utf-8?B?VXNCd01odURxOW5OVUVlajczNCtVcGN3empBa012aThzVHBVb2JyUXYzdHoy?=
 =?utf-8?B?UTB3RjM3c3NhaEorNXVZeTNNaU9STERSSHlLdXU4dGtwUmdqWXVhemhuTlRG?=
 =?utf-8?B?V2NtSkErdzZzNWN1d3ZnT0FJQWFYVEJ4ZStWTlZlODV2cUNJL1VNR2Y5ZjRM?=
 =?utf-8?B?RC9FWE00cEpiVzRFSFhQU0RpNW5kQnIzTHdGc0VlQjQvU0c3anNBVWtIVm12?=
 =?utf-8?B?WjZkMFg2dGFvYUFpamRtZ2xuSDV4WXBXZnpTVmdkOEdMcWtVZ0sxNlVMWER1?=
 =?utf-8?B?d2lnekt1Z1Q3UG03ZWhoN201cm44MExUdXdjYzJ0RGdmNDVpTU1QVmxTVmZu?=
 =?utf-8?B?T0dCRU5EMXh6bno4MndHNGxsczZQV1VmcCtHbjdUc0J1c09sMWRSK1lzYXFi?=
 =?utf-8?B?NVFsZENyaklNNTlZTnJSam5BNy9vN0NJaE1XODVUelJmdFVWd3UxZE1hVWJJ?=
 =?utf-8?B?UkhhVHkzSDZCSVhrRFJDMFdaUks1bVVEWkdiWi9vRjd2dnpPL2pac0FFSjhZ?=
 =?utf-8?B?UW5rY0tINHNWdTRYK0RuQmVzaEhzQnZmRmxUSU9pc1B1ZkNlazM1aWNpRnlo?=
 =?utf-8?B?L0xsdDNtdFNpSkdndTdjenp4bWNkdndWRnA4L09XWHhrcldFMUhGMHJXRzgv?=
 =?utf-8?B?NnZYNGc1WEJ3a1dDVlhna0wxVFlYZHo1ZzZBaXBKMFk4RnpscjZRdVNtSG1Q?=
 =?utf-8?B?NTVsRndIUlF3NlZmRURxUWd0Vk9PT0xpR3FOcWVBd2Fwc0doN3M0UncxM2gx?=
 =?utf-8?B?QklwTFF1ZlRXLzIzRXBZcTlNTnlJUnFtY3lwRkJIcmpzYURNb1ZZeWhpaGZu?=
 =?utf-8?B?OVh5VFJaR09KYThkTnYweHpabjFLZW9JVVg4UWNtaE5tYzdHUUNpUzhRa2F5?=
 =?utf-8?B?VTlzLzllamtCNUtWRkpkc0p0anN3MFc0UUZQOHo5OU1aVk9GYUh4RThCeWt6?=
 =?utf-8?B?VFJCZFFGMUJvL0lteVVvMlQrZ1VKclZlRVA4cXB4My9qV0xiYkl1VHZucFAr?=
 =?utf-8?B?NWpwZVZFNXlvQTNzMFVmUTJJZC9CQUdNWWhGaExyWm80U3RYWmo3Z1lwckZJ?=
 =?utf-8?B?TExGSEx1RTI2YVBkTDY1K1F1a3JvbnJHcWtyZTAvMjFwdGpka3FQUkZudTll?=
 =?utf-8?B?Q0xWZU5WTVgrK2NoaStFc0RaUHJ1eXBpbkhGUENZaUgwN0liZjhMQk1Ud3RV?=
 =?utf-8?B?elJNSlF1ME1YejMzVXNQUndQOVRabU5xblBmaVpYZndJSWZZaHRUUkY4TGtt?=
 =?utf-8?B?V3QycVV3Y3hoNXNGeDg5MmExMnpjaEE5SzNSOWF5b1UwQWFMbG00R0pWWG82?=
 =?utf-8?B?a1J2QVdQdUVZR3lzQ3gyRlBOWjREV2hsYW5JdGRLdkxoZFIrekhFazVpdTlC?=
 =?utf-8?Q?URe7gYPh3rYbD1VM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78510C5CE63DFF4897B8C10E2E99DC2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518a381d-bd9d-4db9-660a-08da5456781f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 13:52:38.4965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yW8yZEQu5vti+VIszxBoAu4J5ExleLtMMZh8jj5kqM6K+XqMMQ8J+qH6nqO9zDY8ApHvK05fo6oWn1iD/4RsHnEZHE6JSkWXoWdQv0NS66M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4184
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMi8yMiA0OjM1IFBNLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+IEhpIEV1Z2VuLA0KPiAN
Cj4gT24gMjIvMDYvMjAyMiAxNDoyNSwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4gT24gNi8yMi8yMiAyOjUzIFBNLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+Pj4gSGkgRXVn
ZW4sDQo+Pj4NCj4+PiBPbiAwMy8wNS8yMDIyIDExOjUxLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0K
Pj4+PiBUaGlzIHNlcmllcyBpcyBhIHNwbGl0IGZyb20gdGhlIHNlcmllcyA6DQo+Pj4+IFtQQVRD
SCB2OSAwMC8xM10gbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IGltcGxlbWVudCBtZWRpYSBjb250
cm9sbGVyDQo+Pj4+IGFuZCBpdCBpbmNsdWRlcyB0aGUgbWVkaWEgY29udHJvbGxlciBwYXJ0Lg0K
Pj4+PiBwcmV2aW91cyBmaXhlcyB3ZXJlIHNlbnQgb24gYSBkaWZmZXJlbnQgcGF0Y2ggc2VyaWVz
Lg0KPj4+Pg0KPj4+PiBBcyBkaXNjdXNzZWQgb24gdGhlIE1MLCBtb3ZpbmcgZm9yd2FyZCB3aXRo
IGhhdmluZyB0aGUgbWVkaWEgbGluayB2YWxpZGF0ZSBhdA0KPj4+PiBzdGFydC9zdG9wIHN0cmVh
bWluZyBjYWxsLg0KPj4+PiBJIHdpbGwgdGVzdCB0aGUgcGF0Y2ggOg0KPj4+PiBbUkZDIFBBVENI
djJdIHZiMjogYWRkIHN1cHBvcnQgZm9yICh1bilwcmVwYXJlX3N0cmVhbWluZyBxdWV1ZSBvcHMN
Cj4+Pj4gYWZ0ZXJ3YXJkcywgYnV0IHRoYXQgcGF0Y2ggcmVxdWlyZXMgbW92aW5nIG15IGxvZ2lj
IHRvIHRoZSBuZXcgdmIyIGNhbGxiYWNrcy4NCj4+Pg0KPj4+IEknbSBsb29raW5nIGF0IG1lcmdp
bmcgdGhpcyBzZXJpZXMsIGJ1dCBJIHdvdWxkIGxpa2UgdG8gaGF2ZSB0aGUgb3V0cHV0IG9mDQo+
Pj4gJ3Y0bDItY29tcGxpYW5jZSAtbSAvZGV2L21lZGlhWCcgdG8gdmVyaWZ5IHRoYXQgdGhlIE1D
IGxpbmtzIGV0Yy4gaXMgYWxsDQo+Pj4gY29ycmVjdC4NCj4+DQo+PiBIZWxsbyBIYW5zLA0KPj4N
Cj4+IFBsZWFzZSBoYXZlIGEgbG9vayBhdCBhdHRhY2hlZCBmaWxlIC4gVW5sZXNzIHlvdSB3YW50
IG1lIHRvIGFkZCB0aGUNCj4+IHdob2xlIG91dHB1dCB0byB0aGUgZS1tYWlsID8NCj4gDQo+IE5v
LCB0aGlzIGlzIGZpbmUsIHRoYW5rIHlvdSENCj4gDQo+Pg0KPj4gSSBhbHNvIGFkZGVkIG91dHB1
dCBvZiBtZWRpYS1jdGwgLXAgZm9yIHlvdXIgY29udmVuaWVuY2UuDQo+PiB0aGUgc3ViZGV2MiBp
cyBhIGRldmljZSBhbmQgZHJpdmVyIHRoYXQgaXMgbm90IHVwc3RyZWFtIGFuZCBoYXMgc29tZQ0K
Pj4gY29tcGxpYW5jZSBpc3N1ZXMsIHRoZXkgYXJlIHJlcG9ydGVkIGJ5IHRoZSB2NGwyLWNvbXBs
aWFuY2UgdG9vbCwgYnV0DQo+PiB0aGV5IHNob3VsZCBub3QgYWZmZWN0IHRoaXMgc2VyaWVzLCBp
dCdzIGEgc3lub3BzeXMgZHJpdmVyIHRoYXQgd2FzDQo+PiByZWplY3RlZCBvbiBtYWlubGluZSBh
IGZldyB5ZWFycyBhZ28sIEkgdG9vayBpdCBmb3IgaW50ZXJuYWwgdXNhZ2UsIGJ1dA0KPj4gaXQn
cyBub3QgY2xlYW5lZCB1cCBub3Igd29ya2VkIGEgbG90IHVwb24uDQo+IA0KPiBPSywgZ29vZCB0
byBrbm93Lg0KPiANCj4gIEZyb20gdGhlIGNvbXBsaWFuY2Ugb3V0cHV0Og0KPiANCj4gICAgICAg
ICAgdjRsMi1jb21wbGlhbmNlIDEuMjIuMSwgMzIgYml0cywgMzItYml0IHRpbWVfdA0KPiANCj4g
VGhpcyBpcyBhbiBvbGQgdjRsMi1jb21wbGlhbmNlIHZlcnNpb24uIENvbXBpbGUgaXQgZGlyZWN0
bHkgZnJvbSB0aGUNCj4gdjRsLXV0aWxzIGdpdCByZXBvIGFuZCBjaGVjayB0aGUgb3V0cHV0IGFn
YWluLg0KDQpPa2F5LCBJIHdpbGwgc3RhcnQgYSBidWlsZC4gSSBoYXZlIHRvIGdldCBteSBmdWxs
IGVudmlyb25tZW50IHJlYWR5LCANCmZpcmUgdXAgYSBCdWlsZHJvb3QuIEl0IHdpbGwgYmUgcmVh
ZHkgdG9tb3Jyb3cuDQoNCj4gDQo+ICAgICAgICAgIENvbXBsaWFuY2UgdGVzdCBmb3IgYXRtZWxf
aXNjX2NvbW1vIGRldmljZSAvZGV2L21lZGlhMDoNCj4gDQo+IEFzIHlvdSBjYW4gc2VlLCB0aGUg
ZHJpdmVyIG5hbWUgaXMgY3V0IG9mZi4gSXNuJ3QgJ2F0bWVsLWlzYycNCj4gYSBiZXR0ZXIgbmFt
ZT8NCg0KTWF5YmUsIGJ1dCB0aGlzIG5hbWUgaXMgdGhlIG5hbWUgb2YgdGhlIGVudGl0eSwgYW5k
IGlzIHRha2VuIGZyb20gdGhlIA0KbmFtZSBvZiB0aGUga2VybmVsIG1vZHVsZS4gU2luY2UgdGhl
IHNwbGl0IG9mIHRoZSBpc2MgZHJpdmVyIGludG8gDQphdG1lbF9pc2NfY29tbW9uIGFuZCBhdG1l
bC1zYW1hNWQyLWlzYyAsIGF0bWVsLXNhbWE3ZzUtaXNjICwgdGhpcyBuYW1lIA0KaGFzIGJlZW4g
c2V0IGZvciB0aGUgbW9kdWxlIGhlcmU6DQoNCmh0dHBzOi8vZ2l0LmxpbnV4dHYub3JnL2h2ZXJr
dWlsL21lZGlhX3RyZWUuZ2l0L3RyZWUvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9NYWtl
ZmlsZT9oPWZvci12NS4yMGUjbjcNCg0KQW5kIHRoZSBJU0MgZHJpdmVyIHRha2VzIHRoZSBtb2R1
bGUgbmFtZSBhbmQgdXNlcyBpdCBmb3IgdmlkZW8gbmFtZSBoZXJlOg0KDQpodHRwczovL2dpdC5s
aW51eHR2Lm9yZy9odmVya3VpbC9tZWRpYV90cmVlLmdpdC90cmVlL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vYXRtZWwvYXRtZWwtaXNjLWJhc2UuYz9oPWZvci12NS4yMGUjbjE5OTkNCg0KDQoNCj4g
DQo+Pg0KPj4+DQo+Pj4gQW5kIG9uZSBtb3JlIHF1ZXN0aW9uIHdoaWNoIG1heSBoYXZlIGJlZW4g
YW5zd2VyZWQgYWxyZWFkeSBpbiB0aGUgcGFzdDoNCj4+Pg0KPj4+IENoYW5naW5nIHRvIHRoZSBN
QyB3aWxsIGJyZWFrIGV4aXN0aW5nIGFwcGxpY2F0aW9ucywgZG9lc24ndCBpdD8gT3IgZGlkIEkN
Cj4+PiBtaXNzIHNvbWV0aGluZz8NCj4+Pg0KPj4NCj4+IFRoZSBleGlzdGluZyBhcHBsaWNhdGlv
bnMgd2lsbCBoYXZlIHRvIGNvbmZpZ3VyZSB0aGUgcGlwZWxpbmUgbm93LiBJdA0KPj4gd2lsbCBu
byBsb25nZXIgd29yayBieSBjb25maWd1cmluZyBqdXN0IHRoZSB0b3AgdmlkZW8gbm9kZSAvZGV2
L3ZpZGVvMCAuDQo+PiBUaGV5IHdvdWxkIGhhdmUgdG8gdXNlIG1lZGlhLWN0bCBmb3IgaXQsIHNv
bWV0aGluZyBzaW1pbGFyIHdpdGggdGhpcyBzZXQNCj4+IG9mIGNvbW1hbmRzOg0KPj4NCj4+IG1l
ZGlhLWN0bCAtZCAvZGV2L21lZGlhMCAtLXNldC12NGwyICciaW14MjE5DQo+PiAxLTAwMTAiOjBb
Zm10OlNSR0dCMTBfMVgxMC8xOTIweDEwODBdJw0KPj4gbWVkaWEtY3RsIC1kIC9kZXYvbWVkaWEw
IC0tc2V0LXY0bDINCj4+ICciZHctY3NpLjAiOjBbZm10OlNSR0dCMTBfMVgxMC8xOTIweDEwODBd
Jw0KPj4gbWVkaWEtY3RsIC1kIC9kZXYvbWVkaWEwIC0tc2V0LXY0bDIgJyJjc2kyZGMiOjBbZm10
OlNSR0dCMTBfMVgxMC8xOTIweDEwODBdJw0KPj4gbWVkaWEtY3RsIC1kIC9kZXYvbWVkaWEwIC0t
c2V0LXY0bDINCj4+ICciYXRtZWxfaXNjX3NjYWxlciI6MFtmbXQ6U1JHR0IxMF8xWDEwLzE5MjB4
MTA4MF0nDQo+IA0KPiBJJ2QgbGlrZSB0byBzZWUgdGhpcyBkb2N1bWVudGVkIGluIGEgbmV3DQo+
IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbWVkaWEvYXRtZWwtaXNjLnJzdCBmaWxlLiBUaGF0
IGNhbiBiZSBhIG5ldyBwYXRjaC4NCg0KQWxscmlnaHQsIEkgY2FuIGRvIHRoYXQuDQoNCj4gDQo+
IFJlZ2FyZHMsDQo+IA0KPiAgICAgICAgICBIYW5zDQo+IA0KPj4NCj4+IFRoYW5rIHlvdSBmb3Ig
dGFraW5nIGNhcmUgb2YgdGhpcyAhDQo+Pg0KPj4gRXVnZW4NCj4+DQo+Pj4gUmVnYXJkcywNCj4+
Pg0KPj4+ICAgICAgICAgICBIYW5zDQo+Pj4NCj4+Pj4NCj4+Pj4gRnVsbCBzZXJpZXMgaGlzdG9y
eToNCj4+Pj4NCj4+Pj4gQ2hhbmdlcyBpbiB2MTA6DQo+Pj4+IC0+IHNwbGl0IHRoZSBzZXJpZXMg
aW50byB0aGlzIGZpcnN0IGZpeGVzIHBhcnQuDQo+Pj4+IC0+IG1vdmVkIElPX01DIGFkZGl0aW9u
IGZyb20gZmlyc3QgcGF0Y2ggdG8gdGhlIHNlY29uZCBwYXRjaCBvbiB0aGUgZHJpdmVyIGNoYW5n
ZXMNCj4+Pj4gLT4gZWRpdGVkIGNvbW1pdCBtZXNzYWdlcw0KPj4+PiAtPiBEVCBub2RlcyBub3cg
ZGlzYWJsZWQgYnkgZGVmYXVsdC4NCj4+Pj4NCj4+Pj4gQ2hhbmdlcyBpbiB2OToNCj4+Pj4gLT4g
a2VybmVsIHJvYm90IHJlcG9ydGVkIGlzY19saW5rX3ZhbGlkYXRlIGlzIG5vdCBzdGF0aWMsIGNo
YW5nZWQgdG8gc3RhdGljLg0KPj4+Pg0KPj4+PiBDaGFuZ2VzIGluIHY4Og0KPj4+PiAtPiBzY2Fs
ZXI6IG1vZGlmaWVkIGNyb3AgYm91bmRzIHRvIGhhdmUgdGhlIGV4YWN0IHNvdXJjZSBzaXplDQo+
Pj4+DQo+Pj4+IENoYW5nZXMgaW4gdjc6DQo+Pj4+IC0+IHNjYWxlcjogbW9kaWZpZWQgY3JvcCBi
b3VuZHMgdG8gaGF2ZSBtYXhpbXVtIGlzYyBzaXplDQo+Pj4+IC0+IGZvcm1hdCBwcm9wYWdhdGlv
bjogZGlkIHNtYWxsIGNoYW5nZXMgYXMgcGVyIEphY29wbyByZXZpZXcNCj4+Pj4NCj4+Pj4NCj4+
Pj4gQ2hhbmdlcyBpbiB2NjoNCj4+Pj4gLT4gd29ya2VkIGEgYml0IG9uIHNjYWxlciwgYWRkZWQg
dHJ5IGNyb3AgYW5kIG90aGVyIGNoYW5nZXMgYXMgcGVyIEphY29wbyByZXZpZXcNCj4+Pj4gLT4g
d29ya2VkIG9uIGlzYy1iYXNlIGVudW1fZm10ICwgcmV3b3JrZWQgYXMgcGVyIEphY29wbyByZXZp
ZXcNCj4+Pj4NCj4+Pj4gQ2hhbmdlcyBpbiB2NToNCj4+Pj4gLT4gcmVtb3ZlZCBwYXRjaCB0aGF0
IHJlbW92ZWQgdGhlICdzdG9wJyB2YXJpYWJsZSBhcyBpdCB3YXMgc3RpbGwgcmVxdWlyZWQNCj4+
Pj4gLT4gYWRkZWQgdHdvIG5ldyB0cml2aWFsIHBhdGNoZXMNCj4+Pj4gLT4gcmV3b3JrZWQgc29t
ZSBwYXJ0cyBvZiB0aGUgc2NhbGVyIGFuZCBmb3JtYXQgcHJvcGFnYXRpb24gYWZ0ZXIgZGlzY3Vz
c2lvbnMgd2l0aCBKYWNvcG8NCj4+Pj4NCj4+Pj4NCj4+Pj4gQ2hhbmdlcyBpbiB2NDoNCj4+Pj4g
LT4gYXMgcmV2aWV3ZWQgYnkgSGFucywgYWRkZWQgbmV3IHBhdGNoIHRvIHJlbW92ZSB0aGUgJ3N0
b3AnIHZhcmlhYmxlIGFuZCByZXdvcmtlZA0KPj4+PiBvbmUgcGF0Y2ggdGhhdCB3YXMgdXNpbmcg
aXQNCj4+Pj4gLT4gYXMgcmV2aWV3ZWQgYnkgSmFjb3BvLCByZXdvcmtlZCBzb21lIHBhcnRzIG9m
IHRoZSBtZWRpYSBjb250cm9sbGVyIGltcGxlbWVudGF0aW9uDQo+Pj4+DQo+Pj4+DQo+Pj4+IENo
YW5nZXMgaW4gdjM6DQo+Pj4+IC0gY2hhbmdlIGluIGJpbmRpbmdzLCBzbWFsbCBmaXhlcyBpbiBj
c2kyZGMgZHJpdmVyIGFuZCBjb252ZXJzaW9uIHRvIG1jDQo+Pj4+IGZvciB0aGUgaXNjLWJhc2Uu
DQo+Pj4+IC0gcmVtb3ZlZCBzb21lIE1BSU5UQUlORVJTIHBhdGNoZXMgYW5kIHVzZWQgcGF0dGVy
bnMgaW4gTUFJTlRBSU5FUlMNCj4+Pj4NCj4+Pj4gQ2hhbmdlcyBpbiB2MjoNCj4+Pj4gLSBpbnRl
Z3JhdGVkIG1hbnkgY2hhbmdlcyBzdWdnZXN0ZWQgYnkgSmFjb3BvIGluIHRoZSByZXZpZXcgb2Yg
dGhlIHYxIHNlcmllcy4NCj4+Pj4gLSBhZGQgYSBmZXcgbmV3IHBhdGNoZXMNCj4+Pj4NCj4+Pj4g
RXVnZW4gSHJpc3RldiAoNSk6DQo+Pj4+ICAgICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogcHJl
cGFyZSBmb3IgbWVkaWEgY29udHJvbGxlciBzdXBwb3J0DQo+Pj4+ICAgICBtZWRpYTogYXRtZWw6
IGF0bWVsLWlzYzogaW1wbGVtZW50IG1lZGlhIGNvbnRyb2xsZXINCj4+Pj4gICAgIEFSTTogZHRz
OiBhdDkxOiBzYW1hN2c1OiBhZGQgbm9kZXMgZm9yIHZpZGVvIGNhcHR1cmUNCj4+Pj4gICAgIEFS
TTogY29uZmlnczogYXQ5MTogc2FtYTc6IGFkZCB4aXNjIGFuZCBjc2kyZGMNCj4+Pj4gICAgIEFS
TTogbXVsdGlfdjdfZGVmY29uZmlnOiBhZGQgYXRtZWwgdmlkZW8gcGlwZWxpbmUgbW9kdWxlcw0K
Pj4+Pg0KPj4+PiAgICBhcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kgICAgICAgICAgICAg
ICAgfCAgNTEgKysNCj4+Pj4gICAgYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcg
ICAgICAgICAgIHwgICAzICsNCj4+Pj4gICAgYXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25m
aWcgICAgICAgICAgICAgIHwgICAyICsNCj4+Pj4gICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9h
dG1lbC9NYWtlZmlsZSAgICAgICAgIHwgICAyICstDQo+Pj4+ICAgIGRyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vYXRtZWwvYXRtZWwtaXNjLWJhc2UuYyB8IDQ4NSArKysrKysrKystLS0tLS0tLS0NCj4+
Pj4gICAgLi4uL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1zY2FsZXIuYyAgIHwgMjY3
ICsrKysrKysrKysNCj4+Pj4gICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1p
c2MuaCAgICAgIHwgIDUwICstDQo+Pj4+ICAgIC4uLi9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1l
bC1zYW1hNWQyLWlzYy5jICB8ICAzNCArLQ0KPj4+PiAgICAuLi4vbWVkaWEvcGxhdGZvcm0vYXRt
ZWwvYXRtZWwtc2FtYTdnNS1pc2MuYyAgfCAgMzIgKy0NCj4+Pj4gICAgOSBmaWxlcyBjaGFuZ2Vk
LCA2ODUgaW5zZXJ0aW9ucygrKSwgMjQxIGRlbGV0aW9ucygtKQ0KPj4+PiAgICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2Mtc2NhbGVyLmMN
Cj4+Pj4NCj4+Pg0KPj4NCj4gDQoNCg==
