Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3ED4C23ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiBXGJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiBXGJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:09:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F893268379;
        Wed, 23 Feb 2022 22:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645682940; x=1677218940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F6LXD/xoDiyqPqc13J5eczBFYpJ9GFCTB5CPe3rlOgA=;
  b=F3pqGWMNnc7qTcgjIygbaw5f7JExtfiUUryO25wvTmr+GgiJhJ0+cVVi
   Xq4kHItBdmCQMCjtxawpOv6CH/xcjLIZ6/626yLQabKQPHfkxwM4IpeUh
   vVY5y3Cg31qaywUqqrWQ/wfnvuQRx3L8uyqT9aaIV4q4NxvLmsyzlTbXA
   ieZNLdSZC6PZWH5Duk4F8rCaETT6anuHeM0+50+k1iPQJHWWVjfauP3NT
   xkragzQEHd2xlZv0IYk5G3Cy+KkSEqwdVuGNman7lH3Vz1FXmIdvCUL5n
   fHOsdMPFR7/iIJO354kye/sYFsrwyKjsbSze00R0vNhSpUYEcaMOgPZEs
   g==;
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="147108908"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2022 23:08:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 23 Feb 2022 23:08:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 23 Feb 2022 23:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPfR46Uh+ILupIJck7ERHHmAucmb73qg8+c0rgikMGuCJ711D7pAdzYLLL7wtsZ1VNhOmY2PC4gfPTtpChtznzBLQmbG9CRpnN7OnNN363LPaont2hPTHccuiVw+bRAJehAb4IhjV7AMLrW2Qqgsd9mEVIWtsOiAZ20/bYR6CK0eQ1eDwyjmnLk+529IRY6av2ee3RndA1penPM+krEAzGpk7CY63Pr0aQC1ZBDSFWDwqHoZJt7RH0WOWkfq7HfDpJLURIQnP0XD5Na5LdCOkU1LxpP7q/2YTltY46LH9bBsZ9aOfYIdoZHsHgqJuI8+59auY5jGLm4SWpQ9woUbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6LXD/xoDiyqPqc13J5eczBFYpJ9GFCTB5CPe3rlOgA=;
 b=ThFvo7DobBH7vKhT698zE2YiRhUliRue8sPatJmplk/C4qKLtmnaPYbj71uI8xTAlfgQhrTRaaSGVnvpm3P6jmUlICyGgdRZllwpcaTtvnRsX+iiduzm8HLjsSY32Ko8taCw9gH3Cz/Ns61U5BPrf9APtsLYh5k1DCRrpcIKMJ7J9S9RXxtfngzF3ZvcLzYOZKXnhRvXJKRZgHBCZLrN+w/eZioC7uwiDS/kdOY0CYAKAAnuPgpEtdq1U4FeCsT8mjQOgwjUinHD2GKauDX7DvWcKsD3MrB+Zp5vxWb/o1BhDJjNghE/IioxswQQ0Ii5Qt8kzc7jF1p/52b2/0fxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6LXD/xoDiyqPqc13J5eczBFYpJ9GFCTB5CPe3rlOgA=;
 b=IIR5N3bp69nqxh626xZ1LCFpvwVnepGjwxNy6vRI6otBnb6vEq/yUvyCZRiarsvBpRmO/RSGQb5cWXiMtxaCWq6vBIIH+HRPrIsJ+lCnfDoJT42+b7iKSdBtSoKitZIkDZE7qd4zn1kxDBY8larkSg4TpGa0CG5JUuHxZGbzuaQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CY4PR11MB1318.namprd11.prod.outlook.com (2603:10b6:903:27::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 06:08:44 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 06:08:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Topic: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Index: AQHYJ/PF9hATniilJUe3fAFeGB3/Dw==
Date:   Thu, 24 Feb 2022 06:08:44 +0000
Message-ID: <6eb179ec-0b12-de30-829e-83ec6b964f21@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <44f655d027b49b87065915f6ba2744d2@walle.cc>
 <81d7c569-d6c2-9167-e007-eda72f34842b@microchip.com>
 <23fbbf2dde387e3832b4ca23d46816c0@walle.cc>
 <7cd74ef3-5a7d-4e65-3436-ee3399ca56a3@microchip.com>
 <e39d06684b8f3a63103f40f0e99e030e@walle.cc>
 <3cd510ad-a6ab-d4a0-92e3-9156a0c7ddbf@microchip.com>
 <20220223183849.xcwciv2ybnkdnauk@ti.com>
In-Reply-To: <20220223183849.xcwciv2ybnkdnauk@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c2bd705-dce0-4fab-4870-08d9f75c1cf0
x-ms-traffictypediagnostic: CY4PR11MB1318:EE_
x-microsoft-antispam-prvs: <CY4PR11MB131869844601870D566658CBF03D9@CY4PR11MB1318.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xp9FMS0urixYjwJ7lRwNnPGm3LntZgZWmEuohDUDi8YtAvAr7/POPuKlWfRwOme80UpOMutwkQ+mVnvrwwcGQxGNMleLudlyM/X8BxekxulMyWAv4y1rmOZv8EV9XmzNkzwWcazmkDDgotlHFALaCWblW6VN3kSTzzV2HJLSqKnvoKNFSUXhVd0FKan9Cwfc14Hhv41HvTiqb08RCZIDdWfby4XE0CxmfYf9SMenSjms04k63woeh0EAfhewRsZD8ueMNvesdN0RVhmGvJ449apvHoQG9C15ddwC2xIMo+OroDMqJ27jNndJ/amxdYio0du5dz8OkgJBu7zFUEfBA+zsAyfoUTatuYJH91qJV0SuUIoUnmia/alGfrEvUlzUPbZk5noGJcN1SlzxjkPCKRYI5Fess01Nz1rjMzSYgyTF5uNmNjek747Nm+1ohTzTPTBPQdLzFgyuJ2H07cnpAQJBg3OZPl9VV554FzcXC+xDei5OAlU+82UwpkwNhNntjuKr50gh7s60eWcqk3LFBXPSycFYHnqqddHL1GsqGfu2bomqlYO0ezDb4b0DHgo7QhJhLx9ATwF/cO05sZhSarwBTbg6M3X0y9IY4VZqyw/EVdNmNBShz8Wgx8x+MgALc3SaS+lNRZlCEMZttF9JFPkuy0bM4HU1DuwGL4q9t9/bFe5pdkSLMD6TKX7oBfUCAAm0KGHloeC9H7K2jYbbkubqOWsM3FZPl46He0UHLHOefQHiG4kxYOB7W6Sna9R5DxmPLzZ3tZFBVbOvEXbr0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38100700002)(86362001)(38070700005)(122000001)(31696002)(6916009)(53546011)(54906003)(6512007)(66476007)(6486002)(36756003)(508600001)(316002)(76116006)(66946007)(4326008)(71200400001)(8676002)(5660300002)(7416002)(66446008)(8936002)(186003)(26005)(91956017)(83380400001)(66556008)(2616005)(64756008)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWZhdFNpVVlWTHAydTRVaGhzTFVSd2pqaHJxSER0RUFMdE9EQzlCMTFqWFZs?=
 =?utf-8?B?V3A4UFhxanplQWVINEJPSEgvK2R4NXJWdEZlUWJsTmhIbHAwS205RDNqMUZT?=
 =?utf-8?B?cld0bVgvQjZTcUdoVndQZHp6Y1FzZjZqYThVbjlHeGc4V29uVTZtcEJnS2Q3?=
 =?utf-8?B?STM4cmdIQS9OREVVRTNIMkNEZTVBY0tIOGxhcUtaN1RyM05UYTU0a1hBbkcv?=
 =?utf-8?B?V1phaFc2ZmllTjdZN1VHTnkyRW9hdzFQMUJZajJxdjJDeDhxYTF6a0NNalU5?=
 =?utf-8?B?VmZVbjFqaExIZm80dFJOL1hYK2laRDBMSW90cERGaGN2YnhONExuMmh1WkUw?=
 =?utf-8?B?STRtQ2JPU0hOc1l2UkRnbXQ3YzRoT3lUYlZUd0g5a2kxZ3Ayb3ZlSm40amwr?=
 =?utf-8?B?cTVCejI0WGRFK2M5MTFNdnlwZUI0VmdyVS9xYk9xTWZubVN0YlFhQ2NFYVE5?=
 =?utf-8?B?RVI4ODNRSVFoV1B3dFpsUGdxUmpEdDVFSVFPaVI5dkxHQVZmbmxlQnRWWTlr?=
 =?utf-8?B?YnpHNjRHcjNJd0M3cFZ4SW1MSXVUTWFYbU5yV0RVRUhDN3gxdm1wV1NQZHlJ?=
 =?utf-8?B?dXpETFBBVy9HdG84bFFYdGFSckE5SzVuOHBjSHd3VjVvOW9kcEFzUlFybHB2?=
 =?utf-8?B?ZTFXZDlQWlJHcG1ZMUlwbk5NTGtBbnhBcm5tWXNCTFRJQUd6L3lPNWlUMGZj?=
 =?utf-8?B?TXdMc2tNYTlMUHBPYXhGQUs5ZnltYlJieDFVbC8yZWdKaEphUmVKS3RjbHNw?=
 =?utf-8?B?ZFFZdmo1RXhodTEzbHdYK0Z5bXBjUUxpYVdGTWgrZGxZSW92aUoyOEEvK2tN?=
 =?utf-8?B?SEo2KzEwbmxWaE90Nmw1S0xDN25iRVUxSXZZdklMVmV2NFdXZkp2RWRVZVk1?=
 =?utf-8?B?RjczaTVidURnelpsOVhldjFIcHFLTE1zODRLWG9IZjNHaTNOWUppKzE1Mitk?=
 =?utf-8?B?bzU1K2p2c1c0aU1UQUJwSE1oS0ZqSzB6MXRrYWszMENNOURXY1RtV3A5cVhq?=
 =?utf-8?B?UW8zQTRVOEhXSExISVpoZXVpbVQ3Smk4Y2dwQWl1UXc3TjhmUWl2QlQwamF5?=
 =?utf-8?B?VzRFWjF5RnRSazBDRGtNOUhLNktxVEprY3VjYlRobUREVU1TSVhFQ0NUcXpq?=
 =?utf-8?B?Yldsek1ybk1abzB6ajdxcHlSZTFhVlQ5TzhNaEtBdjRpS2NmaWxQKzM1akxL?=
 =?utf-8?B?VHRvTFgrNHdnVGtBTjNSRzQ3U0hjbUlNNmpITXF0VUpyN1ZJRW8zUlZ2SlYx?=
 =?utf-8?B?d1I4L1BCWkNRaUlrM2ZIZ3BjdDZBTkVGcXEvejNOMVkrTXd5UVdUbllTUjJs?=
 =?utf-8?B?MXBIb0d5K2l2ckx5T2lPRktzTDl1WmMyK0ZYZWZMbHFqd09ld1ZBd080aCty?=
 =?utf-8?B?eGtrUVZTck9UVFdJZ1cxK0VzaDlaZHhqTm5NQjZwLzkxZmNSMDlSNjdNYlJL?=
 =?utf-8?B?SG4rWWlsZmwzYVBSb0VEaUgyeDByaURVM1NoSGxzRSt1R1laTFdpaEloUGU2?=
 =?utf-8?B?eTFhK2lZZ1NnbWZJQ211eTR5Y3lRenBGTWJVblhMeEFWbnB2SzVqU2taUmRv?=
 =?utf-8?B?YUxTYTdHNmk1eXlqa3ZueUZiT0puaDhOMzd1YkNPYk9vZW5jY3c5Um82TWZs?=
 =?utf-8?B?V1NiblZhRGQwc2Z2WGtGbWVIbEg4bkczT2VFOGlvK1YrY1Uxa0RFbE13ZmZR?=
 =?utf-8?B?NUkzbXpUVCswQXlnMVpLNnJGTjFhT3RxWTNYMG15VkxDcXR4T3J1L1VFV09N?=
 =?utf-8?B?S3l0Y0tjNDFDb3JnNzhaa2VYeXRQakV3cHZ2RDQxR085T2Y5TEZDU2ZyZk9J?=
 =?utf-8?B?Y2JFWlAxVVFTNVhNdVg3S1UrUFZCYVhRbjR1cjVNb3lzTGZBL2wweTF4ckJK?=
 =?utf-8?B?TTRwWGtoZndPN1dMUzlwVkRtT3BLOWRlQmVYbTB0bXp1SnRnaWthczRlRWY1?=
 =?utf-8?B?UDdqVS9sUzM5REtzNTZsZDdURFQ4VkNjMG00bHJpaklreGRObUdVeHh6UjFv?=
 =?utf-8?B?bFd2cTlmcHBQVXgvRGk5Wkl3WU5SSDBuOThURUlGRkhWbmJhQW56ZUZPdFpr?=
 =?utf-8?B?VTZUQU9FeGJ4dWFzVkpDblp2VmN3bFo5K3BLeGgzblY3NEN1V2dPay9YZW95?=
 =?utf-8?B?eFJ0TE0venQ0SkJJOVVsdStSNGtINUlGTzRjMFE5a1RwZ2JPd0poK1dRZ0NX?=
 =?utf-8?B?ZHRJTEYzVTJFRGh2bjk0UndyTHA4RFQ1cmdYeUZuSUVXMk1paFM5Rm13VjJK?=
 =?utf-8?B?d3ZUTVd4MW5qcVlwQ2FhM0RrWnhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9B329A78A02E04FA9A47BD0B0A43432@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2bd705-dce0-4fab-4870-08d9f75c1cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 06:08:44.2934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79j9pgc5ng8eIto6dfixQiFsN96THq6+MM9R6PNId08AbbCFm8JWkfsb826q2gEiqwUws64I8e7fqcFpMIzDhz1+ac1TY3RBxvQV1Auttks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1318
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMy8yMiAyMDozOCwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgVHVkb3IsDQo+IA0KPiBPbiAyMi8wMi8yMiAw
Mjo0M1BNLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAyLzIyLzIy
IDE2OjI3LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPj4+DQo+Pj4gQW0gMjAyMi0wMi0yMiAxNToyMywgc2NocmllYiBUdWRvci5B
bWJhcnVzQG1pY3JvY2hpcC5jb206DQo+Pj4+IE9uIDIvMjIvMjIgMTY6MTMsIE1pY2hhZWwgV2Fs
bGUgd3JvdGU6DQo+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4+PiB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pj4+Pg0KPj4+Pj4gQW0gMjAyMi0wMi0yMiAxNDo1NCwgc2NocmllYiBUdWRvci5BbWJhcnVz
QG1pY3JvY2hpcC5jb206DQo+Pj4+Pj4gT24gMi8yMS8yMiAwOTo0NCwgTWljaGFlbCBXYWxsZSB3
cm90ZToNCj4+Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4+Pj4ga25vdw0KPj4+Pj4+PiB0aGUgY29udGVu
dCBpcyBzYWZlDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEFtIDIwMjItMDItMTggMTU6NTgsIHNjaHJpZWIg
VHVkb3IgQW1iYXJ1czoNCj4+Pj4+Pj4+IEZvcnR1bmF0ZWx5IHRoZXJlIGFyZSBjb250cm9sbGVy
cw0KPj4+Pj4+Pj4gdGhhdCBjYW4gc3dhcCBiYWNrIHRoZSBieXRlcyBhdCBydW50aW1lLCBmaXhp
bmcgdGhlIGVuZGlhbm5lc3Nlcy4NCj4+Pj4+Pj4+IFByb3ZpZGUNCj4+Pj4+Pj4+IGEgd2F5IGZv
ciB0aGUgdXBwZXIgbGF5ZXJzIHRvIHNwZWNpZnkgdGhlIGJ5dGUgb3JkZXIgaW4gRFRSIG1vZGUu
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEFyZSB0aGVyZSBhbnkgcGF0Y2hlcyBmb3IgdGhlIGF0bWVsLXF1
YWRzcGkgeWV0PyBXaGF0IGhhcHBlbnMgaWYNCj4+Pj4+Pg0KPj4+Pj4+IG5vdCBwdWJsaWMsIGJ1
dCB3aWxsIHB1Ymxpc2ggdGhlbSB0aGVzZSBkYXlzLg0KPj4+Pj4+DQo+Pj4+Pj4+IHRoZSBjb250
cm9sbGVyIGRvZXNuJ3Qgc3VwcG9ydCBpdD8gV2lsbCB0aGVyZSBiZSBhIHNvZnR3YXJlDQo+Pj4+
Pj4+IGZhbGxiYWNrPw0KPj4+Pj4+DQo+Pj4+Pj4gbm8gbmVlZCBmb3IgYSBmYWxsYmFjaywgdGhl
IGNvbnRyb2xsZXIgY2FuIGlnbm9yZQ0KPj4+Pj4+IG9wLT5kYXRhLmR0cl9ic3dhcDE2DQo+Pj4+
Pj4gaWYNCj4+Pj4+PiBpdCBjYW4ndCBzd2FwIGJ5dGVzLg0KPj4+Pj4NCj4+Pj4+IEkgZG9uJ3Qg
dW5kZXJzdGFuZC4gSWYgdGhlIGNvbnRyb2xsZXIgZG9lc24ndCBzd2FwIHRoZSAxNmJpdCB2YWx1
ZXMsDQo+Pj4+PiB5b3Ugd2lsbCByZWFkIHRoZSB3cm9uZyBjb250ZW50LCBubz8NCj4+Pj4+DQo+
Pj4+DQo+Pj4+IEluIGxpbnV4IG5vLCBiZWNhdXNlIG1hY3Jvbml4IHN3YXBzIGJ5dGVzIG9uIGEg
MiBieXRlIGJvdW5kYXJ5IGJvdGggb24NCj4+Pj4gcmVhZHMgYW5kIG9uIHBhZ2UgcHJvZ3JhbS4g
VGhlIHByb2JsZW0gaXMgd2hlbiB5b3UgbWl4IDhELThELThEIG1vZGUNCj4+Pj4gYW5kDQo+Pj4+
IDEtMS0xIG1vZGUgYWxvbmcgdGhlIGJvb3Qgc3RhZ2VzLiBMZXQncyBhc3N1bWUgeW91IHdyaXRl
IGFsbCBib290DQo+Pj4+IGJpbmFyaWVzDQo+Pj4+IGluIDEtMS0xIG1vZGUuIFdoZW4gcmVhY2hp
bmcgdS1ib290IGlmIHlvdSBlbmFibGUgOEQtOEQtOEQgbW9kZSwgd2hlbg0KPj4+PiB1LWJvb3QN
Cj4+Pj4gd2lsbCB0cnkgdG8gZ2V0IHRoZSBrZXJuZWwgaXQgd2lsbCBmYWlsLCBhcyB0aGUgZmxh
c2ggc3dhcHMgdGhlIGJ5dGVzDQo+Pj4+IGNvbXBhcmVkDQo+Pj4+IHRvIHdoYXQgd2FzIHdyaXR0
ZW4gd2l0aCAxLTEtMSBtb2RlLiBZb3Ugd3JpdGUgRDAgRDEgRDIgRDMgaW4gMS0xLTENCj4+Pj4g
bW9kZSBhbmQNCj4+Pj4gd2hlbiByZWFjaGluZyB1LWJvb3QgeW91IHdpbGwgcmVhZCBEMSBEMCBE
MyBEMiBhbmQgaXQgd2lsbCBtZXNzIHRoZQ0KPj4+PiBrZXJuZWwgaW1hZ2UuDQo+Pj4NCj4+PiBC
dXQgeW91IGhhdmUgdG8gY29uc2lkZXIgYWxzbyAzcmQgcGFydGllcywgbGlrZSBhbiBleHRlcm5h
bCBwcm9ncmFtbWVyDQo+Pj4gb3INCj4+DQo+PiBXaHk/IElmIHlvdSB1c2UgdGhlIHNhbWUgbW9k
ZSB3aGVuIHJlYWRpbmcgYW5kIHdyaXRpbmcsIGV2ZXJ5dGhpbmcgaXMgZmluZS4NCj4+IEknbSBu
b3Qgc3VyZSB3aGF0J3MgeW91ciBzdWdnZXN0aW9uIGhlcmUuDQo+IA0KPiBTbyBvdXIgc3RhbmNl
IGhlcmUgaXMgdGhhdCB3ZSBkb24ndCBjYXJlIGFib3V0IGV4dGVybmFsIHByb2dyYW1zPz4gDQo+
IElmIHRoYXQgaXMgdGhlIGNhc2UgdGhlbiB3aHkgYm90aGVyIHdpdGggYWxsIHRoaXMgYW55d2F5
PyBTaW5jZSB0aGUgc3dhcA0KPiBoYXBwZW5zIGF0IGJvdGggcGFnZSBwcm9ncmFtIGFuZCByZWFk
LCB3aGF0IHlvdSB3cml0ZSBpcyB3aGF0IHlvdSByZWFkDQo+IGJhY2suIFdobyBjYXJlcyB0aGUg
b3JkZXIgc3RvcmVkIGluIHRoZSBhY3R1YWwgZmxhc2ggbWVtb3J5IGFzIGxvbmcgYXMNCj4gdGhl
IGRhdGEgcmVhZCBpcyBjb3JyZWN0Pw0KPiANCj4gSWYgd2UgZG8gY2FyZSBhYm91dCBleHRlcm5h
bCBwcm9ncmFtcywgdGhlbiB3aGF0IHdvdWxkIGhhcHBlbiBpZiB0aGUNCj4gZXh0ZXJuYWwgcHJv
Z3JhbSB3cml0ZXMgZGF0YSBpbiA4RC04RC04RCBtb2RlIF93aXRob3V0XyBzd2FwcGluZyB0aGUN
Cj4gYnl0ZXM/IFRoaXMgd291bGQgYWxzbyBjYXVzZSBkYXRhIGNvcnJ1cHRpb24uIFlvdSBjYW4n
dCBjb250cm9sIHdoYXQNCj4gdGhleSBtb2RlIHRoZXkgdXNlLCBhbmQgeW91IGNhbid0IGRldGVj
dCBpdCBsYXRlciBlaXRoZXIuDQo+IA0KPiBJIHRoaW5rIHRoZXJlIGlzIG5vIHdpbm5pbmcgaGVy
ZS4gWW91IGp1c3QgaGF2ZSB0byBzYXkgdGhhdCBleHRlcm5hbA0KPiBwcm9ncmFtcyBzaG91bGQg
d3JpdGUgaW4gOEQtOEQtOEQgbW9kZSBvciBpdCB3b24ndCBib290Lg0KPiANCg0KSG93IGFib3V0
IHN3YXBwaW5nIHRoZSBieXRlcyBqdXN0IGF0IHVzZXIgcmVxdWVzdD8gTWF5YmUgd2l0aCBhIEtj
b25maWcNCm9wdGlvbi4NCg0KPj4NCj4+PiBhbm90aGVyIE9TLiBTbywgdGhlcmUgaGFzIHRvIGJl
ICpvbmUgY29ycmVjdCogd2F5IG9mIHdyaXRpbmcvcmVhZGluZw0KPj4+IHRoZXNlDQo+Pj4gYnl0
ZXMuDQo+Pj4NCj4+DQo+Pg0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gUHJhdHl1c2ggWWFkYXYN
Cj4gVGV4YXMgSW5zdHJ1bWVudHMgSW5jLg0KDQo=
