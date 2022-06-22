Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC6554A45
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbiFVMma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiFVMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:42:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3FCAE79;
        Wed, 22 Jun 2022 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655901745; x=1687437745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qopzTfHiIK3uJGhHY/Psxt3u3ExJiBB53sEhDV9vLUQ=;
  b=GKFfLLYIohjt9KI07NsiLqSPtX7zXtgfl5zsN2pfIJ5a8noJlr/XbOAR
   L9c3zDW053L28sYQ1Kj4/8vS5THVDTKGLOT80L3zV5rp3XbZRFT+WKqaU
   ty22FxYILefkRTP0qLZDyXRXe9N37sxuAocU3pyzGYq/bDKDES0YBWXdC
   nsptObl2DAQXdImaHGSxsWm06skYIGwX20eSCvZh3NXKbeAyGDiXboZsZ
   aaLjYMCn+MkdMQBy/+xmSWgKGLplUb3H5e+F03DbLBngzuoNnL7sClLu8
   dhNiRCaX1RJv6QX1hmaDmrtFi7VB56KaAlTS6wpR7FwKlArPulHHAM4mC
   g==;
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="161524943"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2022 05:42:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Jun 2022 05:42:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 22 Jun 2022 05:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKiVX1ZH9X7RQvgdz1eRJrlvCoo6iz3TxcdEfb/en/8Ym3EGKTI345TEEueFWlnISmmHCFdWTKQxS8/89N3txxqNlUECDXX5i+hT1IzuktiDTv2ykwsVM1zQpWhX7osoO6zy04xO7dRM0YNGm2ISuAahiDrE2hG1SG+lmIBC0ShzAkKnUxHjaPVO8wPmUcCOi7drVON4B3NCmCWtxKzKYk1+pKSwJJe7Mx9EUjHfdE26neejGjyqXCmEOj5sZU0b6XAxySAJNfutpJILonPSbaf0vVR8fbyToKBdoBWXAxSAGdfeAA5hld+3tAt8TZvMBIjJPUbFqy+3hjGGY1vIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qopzTfHiIK3uJGhHY/Psxt3u3ExJiBB53sEhDV9vLUQ=;
 b=oZBDJ/wGQGbOEKQoEImSIc27wawGxT6mJYY59ZvflpxyWULoswvp8sWLn3VZcky/4cWLA37On+5Wobdh11THfn47M5ZOPbF6m3OfhSQpnrpsgdpPbeEVkpDrntzFyZHt+ct8RCwwNa259/uGutBONbtqwXPds6y8IzIrfN3dw8pDJpXLeJuiGS5ora/oNpPakCKm83sG7ZQjMcejeDo1YsNaDpdeeWU1/YGLadovz5IVCE/nWcv/IBrSFr8l4VOo2iu0OGc4mYEyhxav/Sv7StIwferWlXAliSYPc0hZi7P0ocnqYECSAmPWmrXZowpdD7Ws4DYB87uwDkSLWYF8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qopzTfHiIK3uJGhHY/Psxt3u3ExJiBB53sEhDV9vLUQ=;
 b=mxSnmZVZNbMsVgXH00M+oS+xM64z6B+CMp/M/CLDtaUJYr2PUbeS/ufhL8v4Oo9EgkQmDz1qDf/CL0/Kq9lTz7sjUHb7KxAF+QsCRIgzZ7lGDuzVdTDYZblUw+GGQwdKqM/A3jykiNjaqwT7uppUccmgQ9IGTIJeYihhseJtqYM=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by BN6PR11MB0036.namprd11.prod.outlook.com (2603:10b6:405:68::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 12:42:18 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::c9c8:3bab:6b8f:5376]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::c9c8:3bab:6b8f:5376%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 12:42:18 +0000
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
Thread-Index: AQHYXtNy0DBb1d5tjEaFV5GKOhbPdK1bn80AgAAIywCAAATJAA==
Date:   Wed, 22 Jun 2022 12:42:18 +0000
Message-ID: <bc22469c-d1ab-72e2-8e9e-6bd42d66f3d9@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
 <1da61f9c-0605-dc9d-63a3-21c18fcb74c7@xs4all.nl>
 <a19d9e72-7609-1daa-93eb-fdedcaa672c4@microchip.com>
In-Reply-To: <a19d9e72-7609-1daa-93eb-fdedcaa672c4@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d80abf9d-282d-4e82-73d9-08da544ca4ee
x-ms-traffictypediagnostic: BN6PR11MB0036:EE_
x-microsoft-antispam-prvs: <BN6PR11MB003696B9989C71A967259C2CE8B29@BN6PR11MB0036.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6B+TR7Iw27vg78HQFGTEXhcL55pgNbqLdfk7LrG3y2CnQq/+uaRjWchuB8BMixTKzXm9zOHwt9dhgIPOO6/h9JEyAiV0wNPCaJ2dUs89yetlvDOHY0u+rfxLRo9P5UtsLwIcIiNPhn0ici1BU1BX+NKEQmg+7khjKYc/DfJATTDNjZ7pLENPmrZneEv4s7SZaxVA/GDe7yp8HJFOmUGyO73Kw5hCr83cX9Hxzlaer7XwOJV2DGspyd3l/wkyoB48RpBvgdZ7ifuU+OXcSkaTHIMkdpGhsPSY2Svhs2JKc1nYlRpu+DOEQKEm+d0amuBqxEKJIG8bDDtPgr6Aln51SWERvW705F8XqP7OVBSr7sp23rmrn7kdJR9v0GwdU9uhi4iXPrVV9WdygTO3Ffhz6y0ShwYbteX99tzuYT28nXlvfqj//FXoqrHSF1fi+ArOBmpmcXrGsmrNIPJkOMKDCGw7ChtixMYTM55Wv+cXEBc3EGGnQVSTxYLBW6fHjq0MiexFmDJogKPQUaizxxqDvKL1bNtM6P2Pvkr4jYawDDH8c3u3Ym2Ic8V8+Da5dNIe/l+bZuaDPHnKSs1uFxpzMIVRpwLMcQj2ojMFD6VNc6fgLmrmV20FaR1tU0jrDBF+HJoaU7sAzCjm5F472MeUbYp5CL52Uq7mJ/hJy3DBelgAl/LkBExQeSykOx3yZ4gUkwmbhwYg4ReAwrggYlupTfS5vWqTTxFwMOkpkwaH0vsUdaBjKrmwRAX89gzrC3K7xksyBB2ufs20WX2ouA+3TLsxNRUB5juuJoq02l983Rcvsen6G9HrbrWOjSqqEqPDJj8gVyh75Cg7l21YHnAnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(346002)(39860400002)(136003)(38100700002)(2616005)(31696002)(186003)(41300700001)(76116006)(86362001)(91956017)(31686004)(66476007)(66556008)(54906003)(66946007)(36756003)(66446008)(38070700005)(64756008)(71200400001)(4326008)(316002)(110136005)(8676002)(5660300002)(6486002)(478600001)(8936002)(6512007)(53546011)(83380400001)(6506007)(2906002)(122000001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmlPSkRlQklDUE9RbFdoOTJ2VEhqZUUxUUlMU0IwUnJRQkt0c3BmT2xGTmFk?=
 =?utf-8?B?d3V5L1NEczlCdE9Za0NUSWNIRGlFTlpDTjUwaCs3VXV0ai9TMWdjYkFJbXpT?=
 =?utf-8?B?QlkxSlFaaVE2QVlPd2pCTytkUW9ZS0Q4dXNkdjFYMGlLcFRyb09YRGtBd0Y1?=
 =?utf-8?B?dmNwUkRGaFkrMSsyaDlocmFUVWJCQTVnSXVaVHBXZGZLQTJ4bFVYWm1MaE5L?=
 =?utf-8?B?YlNNVXgrczZRNGIvK25NK2tSc2RLcDJ1TzhLK0RITkNPUUJVT3VjTkM4eDF6?=
 =?utf-8?B?dXlhRkVIRFo0VEhzb1R6cVMveGlHK1hXdjlKRVRSZjVkeFNRY01ER1pBVVU1?=
 =?utf-8?B?RkpZeXlXRVM5b1Q2N2xYRTdQWDF3WEhYSmpkR0FQWktpdXFyb1R1YTNPWHRH?=
 =?utf-8?B?VWdpR3RydU8yYXZTV3lmK0pFTVA5OVBsd2ROaFBHYjhBVlZBSzErYUpZTW9Q?=
 =?utf-8?B?V0RIOEtaZmltRGkrUmdCcDdaQXhmVFBNRnBVRVlEMUcxbHFBN3RETExqcTNU?=
 =?utf-8?B?SE9kYi9vVmZwQ3JreVZaZUx2YUxDUGVaRTViOFpzRnZPMUV5VWJvWG9xSWFs?=
 =?utf-8?B?aGZ6Qm1mVW5LeUh2Z25CY1BEY0pDNmxhMXg3eVBodkc5VTd1TXRHaXJGb0lv?=
 =?utf-8?B?U1JlRWdJdzdTY2Q4S1hta2NmNXhYeEJDSGxRbHU3VUliLzVvSzUybkUxanZM?=
 =?utf-8?B?TWtjWmo4NzlrclJpbWdGNFo4R0ZMOGtlb0lKZkhPZWZ1Z09xVUVHUEtSVS9L?=
 =?utf-8?B?TWFnK2wyWW5xQ0paQnpXZVh3NDRYRFlPSW9ET3lxWWVkQUVDOW4wTTh2WXQr?=
 =?utf-8?B?RkJnZGdUUkVBOTU0b3pPcmczajQ2dHY1RklpdXlxU2t1eit1dTJiQXNMSnRF?=
 =?utf-8?B?aDVlU3ZwVjNYMUZhamUrQ0d5RUs2K2xSbkJTL0VoNXpxejdEZHVoN2lKVzdm?=
 =?utf-8?B?eFJSb3dyTTlFYWZydC9qRS9pWW5LY0QyY053ZWF5TFFoMHcrWDV4R3I3K1VL?=
 =?utf-8?B?aGJlenphN3l4YW8ySVFYcDdSWUFZMHpuRDFsaFFwT1I2OVliVHJhd1c5VFR6?=
 =?utf-8?B?Z3Vpdzh2RUNneHpoYWhaOVIzN2w5ZWpWdXEwQUJ2OTFnc0V1Mi8zQzZEZnNR?=
 =?utf-8?B?eUxwSDBLK0x1ZzVBTjliV2graVo1UnZaVElRUy83TTZISHEwM0syVFIxTWNl?=
 =?utf-8?B?NHRsN0xERW1ueFEvSDN3UGlJUk93Wm5URjZvenhDWjZRWHhMU1R2SE4ySGt0?=
 =?utf-8?B?YVNpMVFFdk44RDdVNlMwVHladGdpNjZocW5hdHJqRERkUzJkdEN4Q1dUVCsx?=
 =?utf-8?B?b1JNZTZGdlpEWE9Sbmc0U25hbzFTUmlkblcvQVFUR3RScXNoYWFocGFCclph?=
 =?utf-8?B?YjRCMVFKL2hTZXVOY3VPdnRqeGVaakl6UFRvWncybXAvb25zMXJqek0yUHhr?=
 =?utf-8?B?RUlLenVhU2l0Ky9oMWZ3TWUvWVRFeXNoMDdTWVRQaGVmSzR2UVJwbVhWNGkr?=
 =?utf-8?B?Skl6ekQvSmFUcC9DYVVVZEJtK3NWUGJxZ0paT1ZxV2tEL3locy92WGxBQmp5?=
 =?utf-8?B?S2hzTmZYbTVWVzd2L0VjbWErdW83aVpEcVJGK0ZQVGo1UXM2OFhiZGV5Sk0x?=
 =?utf-8?B?czYrWWpzSWNOeGxiQ0t0YVRmNk8vUHhoMUhya2cyZjBkSnNLdFYydXA1MkpR?=
 =?utf-8?B?eGRkbVpYajZIS2NmU0wyQWdrTmlKVGEyczk1NmduYXhLeFlkTWgwY1NwNUlj?=
 =?utf-8?B?enJiZi9VQmRDbDNESExocjhIOXgwd0RGck1Bc0ZjMFVJeitCbmdxd1hFTXJS?=
 =?utf-8?B?YitGc3RIODZKWEFwTEE4UWsyeUM4bXc4ZXQwNXpQU0ZKa0lvV0xkNDQyRnNy?=
 =?utf-8?B?cHBnMGRRQkg0MXUxTEp5U2JDMGRWODMwZjhhZ0MremtacmQzakxkSTdTTmkz?=
 =?utf-8?B?dFUxd1JDdmo3UmZvRFRtUkxMVGhlaTRid3BHcDRqRldiUFNPdDlqOURtVkRh?=
 =?utf-8?B?Y0c1QWQ3TWxITG8rczZXUWRValV3UEZ0eXZWbnJISlA1aEYwS3lMOWZqQjlN?=
 =?utf-8?B?b0swVlJwRytOSk41NERHV1JFNEVwN0F3UEJVMVBLZGJpWjhXWm9Wa2FrWVda?=
 =?utf-8?B?UlBaSzZkc21PckwzbWVxTWpZUERjeXh2Vndyb29DQUlXaEhhY3RzY01oWnE3?=
 =?utf-8?B?K2RGVU1KMUlHTENPcXhWWVRlc1FFOVBIZVdPQXMwNk9FTDhDVmtpWXZ4WVF1?=
 =?utf-8?B?WERsVTJIakxwd2k4TVp4c0VFTTNkMmE0TVQwMHluMFVkMVQzQ0wvcmlRREVl?=
 =?utf-8?B?dGZBcUdVcm5uZmhaZk1mNG1TQzJ4dC9ibjJpTHBMWmgvMWNlVkJMOFFrUXFj?=
 =?utf-8?Q?RWvwQLvJWTwaCgc0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FFAA3074E99B94BB525FF891BDFA8DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80abf9d-282d-4e82-73d9-08da544ca4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 12:42:18.7372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fINpg9+qTzLUmcCOEcN/yCAoW6c9yJVGAmPc3e2SReh1MsQnmpEA5snQovZKOs3/G/gNxbfABXCLr8eAdN1aieWUwsGhamS8JVGQHsiGF64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0036
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMi8yMiAzOjI1IFBNLCBFdWdlbiBIcmlzdGV2IC0gTTE4MjgyIHdyb3RlOg0KPiBPbiA2
LzIyLzIyIDI6NTMgUE0sIEhhbnMgVmVya3VpbCB3cm90ZToNCj4+IEhpIEV1Z2VuLA0KPj4NCj4+
IE9uIDAzLzA1LzIwMjIgMTE6NTEsIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+Pj4gVGhpcyBzZXJp
ZXMgaXMgYSBzcGxpdCBmcm9tIHRoZSBzZXJpZXMgOg0KPj4+IFtQQVRDSCB2OSAwMC8xM10gbWVk
aWE6IGF0bWVsOiBhdG1lbC1pc2M6IGltcGxlbWVudCBtZWRpYSBjb250cm9sbGVyDQo+Pj4gYW5k
IGl0IGluY2x1ZGVzIHRoZSBtZWRpYSBjb250cm9sbGVyIHBhcnQuDQo+Pj4gcHJldmlvdXMgZml4
ZXMgd2VyZSBzZW50IG9uIGEgZGlmZmVyZW50IHBhdGNoIHNlcmllcy4NCj4+Pg0KPj4+IEFzIGRp
c2N1c3NlZCBvbiB0aGUgTUwsIG1vdmluZyBmb3J3YXJkIHdpdGggaGF2aW5nIHRoZSBtZWRpYSBs
aW5rIHZhbGlkYXRlIGF0DQo+Pj4gc3RhcnQvc3RvcCBzdHJlYW1pbmcgY2FsbC4NCj4+PiBJIHdp
bGwgdGVzdCB0aGUgcGF0Y2ggOg0KPj4+IFtSRkMgUEFUQ0h2Ml0gdmIyOiBhZGQgc3VwcG9ydCBm
b3IgKHVuKXByZXBhcmVfc3RyZWFtaW5nIHF1ZXVlIG9wcw0KPj4+IGFmdGVyd2FyZHMsIGJ1dCB0
aGF0IHBhdGNoIHJlcXVpcmVzIG1vdmluZyBteSBsb2dpYyB0byB0aGUgbmV3IHZiMiBjYWxsYmFj
a3MuDQo+Pg0KPj4gSSdtIGxvb2tpbmcgYXQgbWVyZ2luZyB0aGlzIHNlcmllcywgYnV0IEkgd291
bGQgbGlrZSB0byBoYXZlIHRoZSBvdXRwdXQgb2YNCj4+ICd2NGwyLWNvbXBsaWFuY2UgLW0gL2Rl
di9tZWRpYVgnIHRvIHZlcmlmeSB0aGF0IHRoZSBNQyBsaW5rcyBldGMuIGlzIGFsbA0KPj4gY29y
cmVjdC4NCj4gDQo+IEhlbGxvIEhhbnMsDQo+IA0KPiBQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgYXR0
YWNoZWQgZmlsZSAuIFVubGVzcyB5b3Ugd2FudCBtZSB0byBhZGQgdGhlDQo+IHdob2xlIG91dHB1
dCB0byB0aGUgZS1tYWlsID8NCj4gDQo+IEkgYWxzbyBhZGRlZCBvdXRwdXQgb2YgbWVkaWEtY3Rs
IC1wIGZvciB5b3VyIGNvbnZlbmllbmNlLg0KPiB0aGUgc3ViZGV2MiBpcyBhIGRldmljZSBhbmQg
ZHJpdmVyIHRoYXQgaXMgbm90IHVwc3RyZWFtIGFuZCBoYXMgc29tZQ0KPiBjb21wbGlhbmNlIGlz
c3VlcywgdGhleSBhcmUgcmVwb3J0ZWQgYnkgdGhlIHY0bDItY29tcGxpYW5jZSB0b29sLCBidXQN
Cj4gdGhleSBzaG91bGQgbm90IGFmZmVjdCB0aGlzIHNlcmllcywgaXQncyBhIHN5bm9wc3lzIGRy
aXZlciB0aGF0IHdhcw0KPiByZWplY3RlZCBvbiBtYWlubGluZSBhIGZldyB5ZWFycyBhZ28sIEkg
dG9vayBpdCBmb3IgaW50ZXJuYWwgdXNhZ2UsIGJ1dA0KPiBpdCdzIG5vdCBjbGVhbmVkIHVwIG5v
ciB3b3JrZWQgYSBsb3QgdXBvbi4NCj4gDQo+Pg0KPj4gQW5kIG9uZSBtb3JlIHF1ZXN0aW9uIHdo
aWNoIG1heSBoYXZlIGJlZW4gYW5zd2VyZWQgYWxyZWFkeSBpbiB0aGUgcGFzdDoNCj4+DQo+PiBD
aGFuZ2luZyB0byB0aGUgTUMgd2lsbCBicmVhayBleGlzdGluZyBhcHBsaWNhdGlvbnMsIGRvZXNu
J3QgaXQ/IE9yIGRpZCBJDQo+PiBtaXNzIHNvbWV0aGluZz8NCj4+DQo+IA0KPiBUaGUgZXhpc3Rp
bmcgYXBwbGljYXRpb25zIHdpbGwgaGF2ZSB0byBjb25maWd1cmUgdGhlIHBpcGVsaW5lIG5vdy4g
SXQNCj4gd2lsbCBubyBsb25nZXIgd29yayBieSBjb25maWd1cmluZyBqdXN0IHRoZSB0b3Agdmlk
ZW8gbm9kZSAvZGV2L3ZpZGVvMCAuDQo+IFRoZXkgd291bGQgaGF2ZSB0byB1c2UgbWVkaWEtY3Rs
IGZvciBpdCwgc29tZXRoaW5nIHNpbWlsYXIgd2l0aCB0aGlzIHNldA0KPiBvZiBjb21tYW5kczoN
Cg0KVG8gYWRkIG9uIHRvcCBvZiB0aGF0LCBhY3R1YWxseSwgdGhlIHJlYWxpdHkgaXMgdGhhdCB3
aXRob3V0IHRoZSBNQyANCnN1cHBvcnQgaW4gYXRtZWwtaXNjICwgc29tZSBvZiBvdXIgcGxhdGZv
cm1zIGRvIG5vdCB3b3JrIGF0IGFsbCwgYmVjYXVzZSANCnRoZSBjc2kyZGMgZHJpdmVyIHdoaWNo
IGlzIGluIHRoZSBtaWRkbGUgb2YgdGhlIHBpcGVsaW5lLCBpcyBhIE1DIA0KZHJpdmVyLiBTbyBp
dCB3aWxsIG5vdCB3b3JrIHdpdGhvdXQgY29uZmlndXJpbmcgaXQgd2l0aCBNQyBhbnl3YXkuIEl0
IA0KdXNlZCB0byB3b3JrIGluIGEgdmVyeSBwcmVsaW1pbmFyeSB2ZXJzaW9uIG9mIHRoZSBjc2ky
ZGMgZHJpdmVyIHdoaWNoIEkgDQpzZW50IGEgZmV3IHllYXJzIGFnbywgYnV0IHRoYXQgd2F5IG9m
IGhhbmRsaW5nIHRoaW5ncyB3YXMgcmVqZWN0ZWQuIA0KSGVuY2UgSSBjaGFuZ2VkIHRoZSBjc2ky
ZGMgdG8gYmVpbmcgZnVsbC1NQyBkcml2ZXIgKHJlcXVlc3RlZCBmb3IgbmV3IA0KZHJpdmVycykg
YW5kIG5vdyBJIGFtIGNvbXBsZXRpbmcgdGhlIGNvbnZlcnNpb24gZm9yIHRoZSB3aG9sZSBwaXBl
bGluZS4NCldlIGFyZSB1c2luZyB0aGlzIE1DLWNlbnRyaWMgYXBwcm9hY2ggaW4gcHJvZHVjdGlv
biBmb3Igb3VyIHByb2R1Y3RzIHRvIA0KYmUgYXMgY2xvc2UgYXMgcG9zc2libGUgdG8gbWFpbmxp
bmUsIGFuZCBiYWNrcG9ydGVkIGl0IHRvIG91ciA1LjE1IA0KaW50ZXJuYWwgcmVsZWFzZXMsIHdo
aWNoIHBlb3BsZSBhcmUgdXNpbmcgcmlnaHQgbm93Lg0KDQo+IA0KPiBtZWRpYS1jdGwgLWQgL2Rl
di9tZWRpYTAgLS1zZXQtdjRsMiAnImlteDIxOQ0KPiAxLTAwMTAiOjBbZm10OlNSR0dCMTBfMVgx
MC8xOTIweDEwODBdJw0KPiBtZWRpYS1jdGwgLWQgL2Rldi9tZWRpYTAgLS1zZXQtdjRsMg0KPiAn
ImR3LWNzaS4wIjowW2ZtdDpTUkdHQjEwXzFYMTAvMTkyMHgxMDgwXScNCj4gbWVkaWEtY3RsIC1k
IC9kZXYvbWVkaWEwIC0tc2V0LXY0bDIgJyJjc2kyZGMiOjBbZm10OlNSR0dCMTBfMVgxMC8xOTIw
eDEwODBdJw0KPiBtZWRpYS1jdGwgLWQgL2Rldi9tZWRpYTAgLS1zZXQtdjRsMg0KPiAnImF0bWVs
X2lzY19zY2FsZXIiOjBbZm10OlNSR0dCMTBfMVgxMC8xOTIweDEwODBdJw0KPiANCj4gVGhhbmsg
eW91IGZvciB0YWtpbmcgY2FyZSBvZiB0aGlzICENCj4gDQo+IEV1Z2VuDQo+IA0KPj4gUmVnYXJk
cywNCj4+DQo+PiAgICAgICAgICAgSGFucw0KPj4NCj4+Pg0KPj4+IEZ1bGwgc2VyaWVzIGhpc3Rv
cnk6DQo+Pj4NCj4+PiBDaGFuZ2VzIGluIHYxMDoNCj4+PiAtPiBzcGxpdCB0aGUgc2VyaWVzIGlu
dG8gdGhpcyBmaXJzdCBmaXhlcyBwYXJ0Lg0KPj4+IC0+IG1vdmVkIElPX01DIGFkZGl0aW9uIGZy
b20gZmlyc3QgcGF0Y2ggdG8gdGhlIHNlY29uZCBwYXRjaCBvbiB0aGUgZHJpdmVyIGNoYW5nZXMN
Cj4+PiAtPiBlZGl0ZWQgY29tbWl0IG1lc3NhZ2VzDQo+Pj4gLT4gRFQgbm9kZXMgbm93IGRpc2Fi
bGVkIGJ5IGRlZmF1bHQuDQo+Pj4NCj4+PiBDaGFuZ2VzIGluIHY5Og0KPj4+IC0+IGtlcm5lbCBy
b2JvdCByZXBvcnRlZCBpc2NfbGlua192YWxpZGF0ZSBpcyBub3Qgc3RhdGljLCBjaGFuZ2VkIHRv
IHN0YXRpYy4NCj4+Pg0KPj4+IENoYW5nZXMgaW4gdjg6DQo+Pj4gLT4gc2NhbGVyOiBtb2RpZmll
ZCBjcm9wIGJvdW5kcyB0byBoYXZlIHRoZSBleGFjdCBzb3VyY2Ugc2l6ZQ0KPj4+DQo+Pj4gQ2hh
bmdlcyBpbiB2NzoNCj4+PiAtPiBzY2FsZXI6IG1vZGlmaWVkIGNyb3AgYm91bmRzIHRvIGhhdmUg
bWF4aW11bSBpc2Mgc2l6ZQ0KPj4+IC0+IGZvcm1hdCBwcm9wYWdhdGlvbjogZGlkIHNtYWxsIGNo
YW5nZXMgYXMgcGVyIEphY29wbyByZXZpZXcNCj4+Pg0KPj4+DQo+Pj4gQ2hhbmdlcyBpbiB2NjoN
Cj4+PiAtPiB3b3JrZWQgYSBiaXQgb24gc2NhbGVyLCBhZGRlZCB0cnkgY3JvcCBhbmQgb3RoZXIg
Y2hhbmdlcyBhcyBwZXIgSmFjb3BvIHJldmlldw0KPj4+IC0+IHdvcmtlZCBvbiBpc2MtYmFzZSBl
bnVtX2ZtdCAsIHJld29ya2VkIGFzIHBlciBKYWNvcG8gcmV2aWV3DQo+Pj4NCj4+PiBDaGFuZ2Vz
IGluIHY1Og0KPj4+IC0+IHJlbW92ZWQgcGF0Y2ggdGhhdCByZW1vdmVkIHRoZSAnc3RvcCcgdmFy
aWFibGUgYXMgaXQgd2FzIHN0aWxsIHJlcXVpcmVkDQo+Pj4gLT4gYWRkZWQgdHdvIG5ldyB0cml2
aWFsIHBhdGNoZXMNCj4+PiAtPiByZXdvcmtlZCBzb21lIHBhcnRzIG9mIHRoZSBzY2FsZXIgYW5k
IGZvcm1hdCBwcm9wYWdhdGlvbiBhZnRlciBkaXNjdXNzaW9ucyB3aXRoIEphY29wbw0KPj4+DQo+
Pj4NCj4+PiBDaGFuZ2VzIGluIHY0Og0KPj4+IC0+IGFzIHJldmlld2VkIGJ5IEhhbnMsIGFkZGVk
IG5ldyBwYXRjaCB0byByZW1vdmUgdGhlICdzdG9wJyB2YXJpYWJsZSBhbmQgcmV3b3JrZWQNCj4+
PiBvbmUgcGF0Y2ggdGhhdCB3YXMgdXNpbmcgaXQNCj4+PiAtPiBhcyByZXZpZXdlZCBieSBKYWNv
cG8sIHJld29ya2VkIHNvbWUgcGFydHMgb2YgdGhlIG1lZGlhIGNvbnRyb2xsZXIgaW1wbGVtZW50
YXRpb24NCj4+Pg0KPj4+DQo+Pj4gQ2hhbmdlcyBpbiB2MzoNCj4+PiAtIGNoYW5nZSBpbiBiaW5k
aW5ncywgc21hbGwgZml4ZXMgaW4gY3NpMmRjIGRyaXZlciBhbmQgY29udmVyc2lvbiB0byBtYw0K
Pj4+IGZvciB0aGUgaXNjLWJhc2UuDQo+Pj4gLSByZW1vdmVkIHNvbWUgTUFJTlRBSU5FUlMgcGF0
Y2hlcyBhbmQgdXNlZCBwYXR0ZXJucyBpbiBNQUlOVEFJTkVSUw0KPj4+DQo+Pj4gQ2hhbmdlcyBp
biB2MjoNCj4+PiAtIGludGVncmF0ZWQgbWFueSBjaGFuZ2VzIHN1Z2dlc3RlZCBieSBKYWNvcG8g
aW4gdGhlIHJldmlldyBvZiB0aGUgdjEgc2VyaWVzLg0KPj4+IC0gYWRkIGEgZmV3IG5ldyBwYXRj
aGVzDQo+Pj4NCj4+PiBFdWdlbiBIcmlzdGV2ICg1KToNCj4+PiAgICAgbWVkaWE6IGF0bWVsOiBh
dG1lbC1pc2M6IHByZXBhcmUgZm9yIG1lZGlhIGNvbnRyb2xsZXIgc3VwcG9ydA0KPj4+ICAgICBt
ZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogaW1wbGVtZW50IG1lZGlhIGNvbnRyb2xsZXINCj4+PiAg
ICAgQVJNOiBkdHM6IGF0OTE6IHNhbWE3ZzU6IGFkZCBub2RlcyBmb3IgdmlkZW8gY2FwdHVyZQ0K
Pj4+ICAgICBBUk06IGNvbmZpZ3M6IGF0OTE6IHNhbWE3OiBhZGQgeGlzYyBhbmQgY3NpMmRjDQo+
Pj4gICAgIEFSTTogbXVsdGlfdjdfZGVmY29uZmlnOiBhZGQgYXRtZWwgdmlkZW8gcGlwZWxpbmUg
bW9kdWxlcw0KPj4+DQo+Pj4gICAgYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNpICAgICAg
ICAgICAgICAgIHwgIDUxICsrDQo+Pj4gICAgYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZj
b25maWcgICAgICAgICAgIHwgICAzICsNCj4+PiAgICBhcmNoL2FybS9jb25maWdzL3NhbWE3X2Rl
ZmNvbmZpZyAgICAgICAgICAgICAgfCAgIDIgKw0KPj4+ICAgIGRyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vYXRtZWwvTWFrZWZpbGUgICAgICAgICB8ICAgMiArLQ0KPj4+ICAgIGRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLWJhc2UuYyB8IDQ4NSArKysrKysrKystLS0tLS0tLS0N
Cj4+PiAgICAuLi4vbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLXNjYWxlci5jICAgfCAy
NjcgKysrKysrKysrKw0KPj4+ICAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwt
aXNjLmggICAgICB8ICA1MCArLQ0KPj4+ICAgIC4uLi9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1l
bC1zYW1hNWQyLWlzYy5jICB8ICAzNCArLQ0KPj4+ICAgIC4uLi9tZWRpYS9wbGF0Zm9ybS9hdG1l
bC9hdG1lbC1zYW1hN2c1LWlzYy5jICB8ICAzMiArLQ0KPj4+ICAgIDkgZmlsZXMgY2hhbmdlZCwg
Njg1IGluc2VydGlvbnMoKyksIDI0MSBkZWxldGlvbnMoLSkNCj4+PiAgICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2Mtc2NhbGVyLmMNCj4+
Pg0KPj4NCj4gDQoNCg==
