Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1845A6871
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiH3Qao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3Qal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:30:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9DA5AC42
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661877038; x=1693413038;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=VBdpbuCdWepIqUsrQ1OPtUWIWh4m34UX3OyQUhwf+JI=;
  b=S8NkWuSP7Bj7A5OLRSHn2fEfNRymA+3S6LoJN227+ztV6+4UEZhwPT6S
   6FhYyJzsZ5sQY9SCHJVfPey0dapKJacAsNJqiuiJuK0r+g6j7IsBjrLQl
   f7CRhf9Np8edfDHtVuNJNUXVQw6q1tfXVuRf0U7mvBCGKje+VtrX5+9KU
   LLEmK4IjsQRQw/p1O47RCBkpgru84YdiHQpyQTIZ0hMF1pFt8rzQZgkla
   tgGWFullSN7SNHSmb2hxngEaVUXFgWkZNsN3sXKS1Ii9CguLxloYhnopY
   Kuc5eMWP6JHzBthSJbw4NfJ14GhLDQMfRC7A46rH85P5RKyg0axfYjykN
   A==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="111424379"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 09:30:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 09:30:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 09:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEUk+AcanYaSj7o/2LLyYD5p965QkBr+UOqRnTmn4J6KlbPw2nx+i7zHDjb89DXCcPKp2ETqP5XKF2So6FkQUrQnvXrx7qEWmBz1kg3C1Zi3sAA4Y7Vp+SG2asy6yc/v50OnOPkdcCYZ9npTm5esp7b00J0tsRmVjW2LKk0je5mtD4IxRJiFMIol/7FcppSwEjBOEUae/A8BQdbCiJJs3BPd2S2ewlgNlIeOVCO7Du0Sd9UjA+dlXjucCzgyWIIjXF6Cpi8V9F+s4V6yZyZoWdQn6Ayqa7fRTmOwqeRByokP7IrFeA5LyTGqwwKBw3LyWRqkp08A+0pcXb6Mbx3A2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBdpbuCdWepIqUsrQ1OPtUWIWh4m34UX3OyQUhwf+JI=;
 b=ID4AGlDml6EqaNVkXJ///9FQcGh1bfD6VfrSfiQBtHu7glHpcvvYYvwSoH+qCoL8fGZxckTAWRrOJPNEli7oLYxVk5DJsHmw9OEfSlPjQZe8/7RkR4JrkkGokiw6O56ZKz2onziQLHYL0/LUDVpZ8nBEV+8YCke8axfI/YBkEZ1pdx64HR5EAbrDkEU4aoGO8NYWfuRaKI4NBTnSLn9+4arY52vySvBl6pO6Fsqn/1jN3vBCTAMMpqqK7HPW8n7mpvlaH5Xcud98oPd8xQU7lBJr+gvnsl0/g/R49Es2b2woOdOAFXwb2pPQdJ+dKXsa8wrkLLCOoflFfIHPM3PLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBdpbuCdWepIqUsrQ1OPtUWIWh4m34UX3OyQUhwf+JI=;
 b=qFlxexGZWdmDDLXINFjkVDtzScynnb7RRsanrOvR99EyiaiQUViEOPeAzya8GkdNiG6eP9qLrdOJI1Fzl2TzuHxmhffmcLV5f5jafHwO1VVDuXB/0+R4TG/X8scXG3c8FWVUJfZbI7lEVxd2KAwWYB+VIQJez96XP4SuhbntqZU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1449.namprd11.prod.outlook.com (2603:10b6:4:8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Tue, 30 Aug 2022 16:30:32 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 16:30:32 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ben.dooks@sifive.com>, <zong.li@sifive.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] soc: sifive: ccache: reduce printing on init
Thread-Topic: [PATCH] soc: sifive: ccache: reduce printing on init
Thread-Index: AQHYvEo2J0R+VrnBYkWwZtQG6jcIpK3HoxEA
Date:   Tue, 30 Aug 2022 16:30:32 +0000
Message-ID: <fdec1b72-27f3-96e6-5e19-d54ded4aea68@microchip.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830082620.1680602-1-ben.dooks@sifive.com>
In-Reply-To: <20220830082620.1680602-1-ben.dooks@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60b6447e-cf98-4738-c259-08da8aa4f578
x-ms-traffictypediagnostic: DM5PR11MB1449:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ScpYLAiokBjBiCPO9QUz/mTe5nXUqrLlvZDpLrrWGqOprLjPpYfDgeb27SJHoD2bQI/mmsLK6Tg649ogYv/TGzw1v03Pi3arBwerzIpLe7bw8cZPd9f4cZ/4l+2R15XWZnjZTK9zldkLNNEEkHYPW7EOhs1QUNDO+BEo60xjE8ZTzg7ChOsvJ95O5eAdgh25JWVmzjDQSex3X5zPimfDhobl2mFmQLvrLAzIeutyHMe3A9wwmSQNttCDjvunMzDhhggZCrJHOggzDf8CX0PCEESezddvN5jipx13x2ZemlHK5xm2cPp4hFoLltZTg06aua1p2K5rxXAe9Ea/2C3aiqn8PP6CDnJboAYKRG/LM1KjL+qVGT49Jz4+sMNufDEWgHFE5Bi4fbyDT6RkXHsgbvk1Xh+Q73pA/idlMdZEA1RnMmr69BQAbhqEKzJjMQxC+6bxP0DgRk3BgQvCCZ1FIxZAVkL64RbHTRYjsEKWvztYqovxDGwMV0/QttGKhkrUyQOEaxaG0bdtZYFTc0DsHA5AZe+oUWKVMrayjNK62sAkODd3PtFX5iAZ/jYr9kk3tUnjUnHgpb0muxDxEPlG1HlnnEU4ojAVKCZMXAF4ZMJYIT80Ev+CuSuKrL4mWTjyLvJ+GRUwTBdKv5HKbdVcnEJ72hiL4ebGtFdRonUwyAk4gaa1RgMx4d2rkGTRTcOlAnG66Q6N/YSpArICdKhgPfQNmM1SqqyRtHv0mSvyh/C09rCSM0EN5fsFWS1L1nj8kj9gS97a84xxX0iu5ghxs7rODVD22ZysQ7f8G3+1jFvSTFpIcTjif1AiW+iatyGvpcHO1/VxHMnnjZFED7//9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(346002)(39860400002)(66446008)(91956017)(66476007)(110136005)(8676002)(64756008)(316002)(8936002)(66946007)(38100700002)(5660300002)(2906002)(66556008)(76116006)(36756003)(122000001)(26005)(38070700005)(86362001)(53546011)(6506007)(6512007)(6486002)(478600001)(71200400001)(41300700001)(186003)(31696002)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHZqUG1GdElHRGRIWEVKdHREdXQ1WFVMVzRmTyt2TUJxTklSeEx3ZUF5QUZ5?=
 =?utf-8?B?RjdXTHFEMWRRa2hYMFVpK1dZenkrWDNUWW0ya2hDWlEyNTBNcFFyZWVjd3Vl?=
 =?utf-8?B?QUdCOWY5UVk3MThYK291MlJUeElKNS8xTlVOekp1ZklRV1gvenBhUy9XZTAy?=
 =?utf-8?B?WVZGMzd0ZXhTOXhTbm9sOEV3ZDc4Y3JDaG1OdEdQcWo5czM2aUloUENIL0Jr?=
 =?utf-8?B?V0haZ2xxUE1sQzJSblo1WEdEODFFcjBFdlZXT3h2bDhSMTUwNHpONi95eUJW?=
 =?utf-8?B?UzhRRTFTbmhJUnZ6OGFtR2xmVEVOWnNmYllBK2lXMzZsNTd4N2RRcFdncFJW?=
 =?utf-8?B?VzFoOHAvMm9SaWVHUTRNRVpwVTIzNlNxWWczVmpHVHk4c0d2NGNUekIydVNh?=
 =?utf-8?B?R1hRREZEUG9HSVFqQWVGZk5LMXdFYzVGZmowOE5NZitUQmg2c1Z4RUNGbmEz?=
 =?utf-8?B?UGNNYlVRbzNiUjY0WTA0eUpSbllDdGh6SDBqWWJQZk4ra1RPTk5ManhzTE1h?=
 =?utf-8?B?RG45eHROc1ZodTFZblZJQ3NQQnJ0UkxYZjVkWjFDdGhBcXJwV0VXeERpZTBF?=
 =?utf-8?B?WDYza0hNeGlRdzJaczhmTXNPNzIvdlRjNVJDQ0U4djNaUW5CSVM3RzRyUGEr?=
 =?utf-8?B?UC8xTG5GcW5MYkpHdnNYMGhxeHhBN3ZXdVFGNEU1dDlwbldRRDV6V1RaY2RK?=
 =?utf-8?B?a1NUdGJxUkM3ZHBhYzdJM1Z6dHRVUjdNZ3lDSHJXSDdEaW01MnhCdWN4NHRK?=
 =?utf-8?B?L3A4SktYZTgwbS80NFpmR2lSN1NUQmxBeXlaMysrYkhmQ0hBVzByL2Q3dFJN?=
 =?utf-8?B?V2g2TUFYd0tFdUlUUk9CbTYzNHFQLytxblFyQkJoU1hpanY3QS85d1dadGFC?=
 =?utf-8?B?N3ZWb1EvYkp4L3p0bThCdzRrZDNxYm4zSmtJOTBBZWlZU1VFaHVuTTljUlJV?=
 =?utf-8?B?aHpVUTQyOG1XWkNMUG1JajNYSWcrK3dRNlFidEtuaHhLWnJ0SHhXcHNmenJJ?=
 =?utf-8?B?RDFUL2hrL1ZoYVpJdkxxWEUzaWVaQmlhNk15NzJjOUN1NEkwbHVsdWdpSGRS?=
 =?utf-8?B?NURGb0EzQmNBZ3A3U1RvTFd2UWk5dUQxMkhsbVlsWktoMWFtanQrM0dONXhF?=
 =?utf-8?B?eVVUYVBvdGJuWmhTSVV5cHViN2cvZ3YwMzdoSy83NmE0Y1ZMVTlheFQ2Sjg5?=
 =?utf-8?B?cXVaTDI2M3V2bUR0N3A5dXQybWJleVBEK3FMTHFsQUFsMG5paHV0OXgyd1Z2?=
 =?utf-8?B?U1oyWUZJRjNMZ0xQclpJWjZEeVVBTXFNM3VtcnRhRXMvWm1Od1dxOEpzVDd5?=
 =?utf-8?B?Q3lsdS9yRUZRWDF2UjhLRGdmbUV3SE1CbUlLVlpLb1htbmIwamNRQmkxL2pG?=
 =?utf-8?B?RStnS0FtejNEWGl2Q2RyNG9FUTZPQStGUXpkWHdVRitHSGhYMDlieXMrZnZi?=
 =?utf-8?B?RGNreTMySExIZzFTYUJuTUxBV3gzS2J4eWRJS2RuTjFVM3dyeEtMQzdwZ3Mv?=
 =?utf-8?B?d0JtR2dkcktTWCszOXBDRzhESE9iRk1jeHRGU3JFU0lubjM0NzkxUWg4NzQr?=
 =?utf-8?B?NkxObnNIUjF1Y1dqcVArT1NkdDVHY3o4bU1oN3l0SytXMW9uQnlXMko4RVRW?=
 =?utf-8?B?L0FVNllPd3dIYTJwYU5IMXpjb2huOTJnczZ5UFlEMTBnb1hxM1hab3BFaVBX?=
 =?utf-8?B?WFJhdE43MXRML0lOdGg2TGRHQ3JQdXI5Nk1yaFM1eHBhSjkvVVpSL2o4RGN3?=
 =?utf-8?B?Ni9oNVNKWjUxdy92YndKMTNmOEQxRm9UNmlKcGFVYi9EeEZXdURYbXFkcG54?=
 =?utf-8?B?aU1lMC95RW0vOVh1YStWTi9LZEtlaEFwOWUxK25ZaFpLSkJ4aG56MStMc2ti?=
 =?utf-8?B?cVFuZ2RRbVFsV3BsaEpvRWVYenJTUlJlbjNMcEQyVmNIVnduRGtUMXZDWUtn?=
 =?utf-8?B?ZnBNTXdHOEtla2QzOEY5T0FOeHQwdGVMYUg5anNkRUJJZGZJMGs2a0cwc1F3?=
 =?utf-8?B?eVo0NG1zNUYxS3pROFE0ZnduSk85L0VvTTkvL0lwTEZaNUpwc1pSVzErZVZK?=
 =?utf-8?B?Ri9oUWxFZmpkcklwdkNRVTZITm9FS0VJdjkyd29ZM1JHNk1qR3dkVXZ3R2JG?=
 =?utf-8?B?SGw0ajRpbGdXSzRsZkpnT1cvYzNyU09Samxqd0xFbko4d1I3a1pPVlJuanVm?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <450B844F639237408B40E1576EB50364@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b6447e-cf98-4738-c259-08da8aa4f578
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 16:30:32.3791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uaVwNgsmoPwy8BuVT41ytNLL9cMJ7NRDcYEf3Uct5Bvj8L4b0OxiILnp3P1uYh8CLHPuLo6CfiMEZUzjFaP2ZhsZcGED88qtmizSIwlZkJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1449
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAwOToyNiwgQmVuIERvb2tzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBkcml2ZXIgcHJpbnRzIG91dCA2IGxpbmVzIG9u
IHN0YXJ0dXAsIHdoaWNoIGNhbiBlYXNpbHkgYmUgcmVkY3VlZA0KPiB0byB0d28gbGluZXMgd2l0
aG91dCBsb3NpbmcgYW55IGluZm9ybWF0aW9uLg0KPiANCj4gTm90ZSwgdG8gbWFrZSB0aGUgdHlw
ZXMgd29yayBiZXR0ZXIsIHVpbnQ2NF90IGhhcyBiZWVuIHJlcGxhY2VkIHdpdGgNCj4gVUxMIHRv
IG1ha2UgdGhlIHVuc2lnbmVkIGxvbmcgbG9uZyBtYXRjaCB0aGUgZm9ybWF0IGluIHRoZSBwcmlu
dA0KPiBzdGF0ZW1lbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZW4gRG9va3MgPGJlbi5kb29r
c0BzaWZpdmUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hl
LmMgfCAyNSArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zb2Mvc2lmaXZlL3NpZml2ZV9jY2FjaGUuYyBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVf
Y2NhY2hlLmMNCj4gaW5kZXggNDZjZTMzZGI3ZDMwLi42NWExMGE2ZWUyMTEgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hlLmMNCj4gKysrIGIvZHJpdmVycy9z
b2Mvc2lmaXZlL3NpZml2ZV9jY2FjaGUuYw0KPiBAQCAtNzYsMjAgKzc2LDE3IEBAIHN0YXRpYyB2
b2lkIHNldHVwX3NpZml2ZV9kZWJ1Zyh2b2lkKQ0KPiANCj4gIHN0YXRpYyB2b2lkIGNjYWNoZV9j
b25maWdfcmVhZCh2b2lkKQ0KPiAgew0KPiAtICAgICAgIHUzMiByZWd2YWwsIHZhbDsNCj4gLQ0K
PiAtICAgICAgIHJlZ3ZhbCA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9DT05G
SUcpOw0KPiAtICAgICAgIHZhbCA9IHJlZ3ZhbCAmIDB4RkY7DQo+IC0gICAgICAgcHJfaW5mbygi
Q0NBQ0hFOiBOby4gb2YgQmFua3MgaW4gdGhlIGNhY2hlOiAlZFxuIiwgdmFsKTsNCj4gLSAgICAg
ICB2YWwgPSAocmVndmFsICYgMHhGRjAwKSA+PiA4Ow0KPiAtICAgICAgIHByX2luZm8oIkNDQUNI
RTogTm8uIG9mIHdheXMgcGVyIGJhbms6ICVkXG4iLCB2YWwpOw0KPiAtICAgICAgIHZhbCA9IChy
ZWd2YWwgJiAweEZGMDAwMCkgPj4gMTY7DQo+IC0gICAgICAgcHJfaW5mbygiQ0NBQ0hFOiBTZXRz
IHBlciBiYW5rOiAlbGx1XG4iLCAodWludDY0X3QpMSA8PCB2YWwpOw0KPiAtICAgICAgIHZhbCA9
IChyZWd2YWwgJiAweEZGMDAwMDAwKSA+PiAyNDsNCj4gLSAgICAgICBwcl9pbmZvKCJDQ0FDSEU6
IEJ5dGVzIHBlciBjYWNoZSBibG9jazogJWxsdVxuIiwgKHVpbnQ2NF90KTEgPDwgdmFsKTsNCj4g
LQ0KPiAtICAgICAgIHJlZ3ZhbCA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9X
QVlFTkFCTEUpOw0KPiAtICAgICAgIHByX2luZm8oIkNDQUNIRTogSW5kZXggb2YgdGhlIGxhcmdl
c3Qgd2F5IGVuYWJsZWQ6ICVkXG4iLCByZWd2YWwpOw0KPiArICAgICAgIHUzMiBjZmc7DQo+ICsN
Cj4gKyAgICAgICBjZmcgPSByZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfQ09ORklH
KTsNCj4gKw0KPiArICAgICAgIHByX2luZm8oIkNDQUNIRTogJXUgYmFua3MsICV1IHdheXMsIHNl
dHMvYmFuaz0lbGx1LCBieXRlcy9ibG9jaz0lbGx1XG4iLA0KPiArICAgICAgICAgICAgICAgKGNm
ZyAmIDB4ZmYpLCAoY2ZnID4+IDgpICYgMHhmZiwNCj4gKyAgICAgICAgICAgICAgIDFVTEwgPDwg
KChjZmcgPj4gMTYpICYgMHhmZiksDQoNClRoaXMgaXMganVzdCBCSVRfVUxMKChjZmcgPj4gMTYp
ICYgMHhmZiksIG5vPw0KV291bGQgYmUgbmljZSB0b28gaWYgdGhlc2Ugd2VyZSBkZWZpbmVkLCBz
byB5b3UnZCBoYXZlIHNvbWV0aGluZw0KbGlrZSBCSVRfVUxMKChjZmcgPj4gU0VUU19QRVJfQkFO
S19TSElGVCkgJiAweGZmKQ0KDQpJIGRvIGxpa2UgdGhlIGNsZWFudXAgb2YgdGhlIHVpbnQ2NF90
ICYgY3V0dGluZyBkb3duIG9uIHRoZSBwcmludHMNCnRob3VnaCA6KSBBZ2FpbiwgaXQnZCBiZSBu
aWNlIGlmIHlvdSBhbmQgWm9uZyBjb3VsZCBjb2xsYWJvcmF0ZSBvbg0KYSBjb21iaW5lZCB2Mi4N
Cg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gKyAgICAgICAgICAgICAgIDFVTEwgPDwgKChjZmcgPj4g
MjQpICYgMHhmZikpOw0KPiArDQo+ICsgICAgICAgY2ZnID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBT
SUZJVkVfQ0NBQ0hFX1dBWUVOQUJMRSk7DQo+ICsgICAgICAgcHJfaW5mbygiQ0NBQ0hFOiBJbmRl
eCBvZiB0aGUgbGFyZ2VzdCB3YXkgZW5hYmxlZDogJWRcbiIsIGNmZyk7DQo+ICB9DQo+IA0KPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc2lmaXZlX2NjYWNoZV9pZHNbXSA9IHsN
Cj4gLS0NCj4gMi4zNS4xDQo+IA0KDQo=
