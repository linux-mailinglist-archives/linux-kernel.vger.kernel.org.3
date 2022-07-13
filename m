Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5AD5739F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiGMPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGMPVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:21:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A7143303;
        Wed, 13 Jul 2022 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657725692; x=1689261692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sW4cXuKS/T4n0sYs0s6o35VcLp8H9E7zc5gCFoA5Dcg=;
  b=HeMc0dX9VLmP7VfJcdUB0j6Zc+cEyZ2nxA0RvJ+8krpH67jN/TfC2sgn
   +nOtlpjpo+PIyCUlG6IqC2+lZrmfqpN3OBZ3LodAfGxwDRfPxvmJi2mps
   Eic0Y7JCRkCJZsFckuv88Cigyek91/moyeufus0e++ZTWTHTZ+dTw3y1M
   D5q75NV+J/BZO4+s3ks0KBEOEzBEPzMnCH1tLfID9NwB67/zK3rRTnsDZ
   rLUwRK8NX8StwdvHNJaGafJ2hP4NkixAB9gaoE+spbURiyXb/qqpge7IU
   BiUHz9loIXn0jNBRLsZju7Dbv1Ns0cJ0jQLtVeDy0Gd2T5nSPSTaCPns3
   g==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="181978198"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 08:21:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 08:21:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Jul 2022 08:21:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmXA1CMRIu4CM1dMKIl0IUKED2Vr2k3Rrj8BL/ob4+T09ElBXqejoN+BmbfYx/c8hBXGqtMDL6Y3Rk8Y20NydCVrEEZfKJKEwuLrcSmd4W6TtVusRXM+4IGeMPXktd2ATaME5O+vEVAyvB8C+p3R9GBypVsBu8fe+nlgZw0pbUc9le20MA9ouFxXTy6nUJziioCKWh7pVJcMOBEHs72yzLxtbc7nG8YlKtBmTNkj+C7/8vZDSfRlmFLpRrwOppzZScZ72QzDYdXn3yrSo3GaIE5nkO1A7iK/gFTWXe6zfUohhAVv6jg63FwUdQgG4Zrssmum0Fh6TaE7lBu020fK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW4cXuKS/T4n0sYs0s6o35VcLp8H9E7zc5gCFoA5Dcg=;
 b=VnY2wZ2sgc/zRZJb0XVKI6J2QffnWcAQiB6smnFCVx5LNqKZfxpAsoEO2PgjIZlPVVXQLLsTNH9ioepyZ08dCIm9H8lLBA60I6J73Kb6eT6IS7iqzQJgSX33YYHNiJiHBNl1XRYyOnBEjQu851nTeNcIWbyGAIP5TzXEk4uLA5x73VUjtXDfYz9g4ZrY7D4R3+ImsJ5aLNk8BtDWiynWKU/jKLZXg3ifCklUKo3KNKvLkvLQcCK5HnYsDMsaad7Vz5VD5p0B3gM9twolGlv01q+Qrw6vCnySuSLOYz01L8QkIz2IUqxqVtWNdLyU7dTWsL6x/93YKpNSKzgW9EeLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW4cXuKS/T4n0sYs0s6o35VcLp8H9E7zc5gCFoA5Dcg=;
 b=m/yM3EEnfR2aN2wJkCmNMOH/dBGgGZJ9P2QuwFRkbjcRN1KEIytQHW73cU24ba95oTi94E7tWS8jA4JIUMQSuMXDzn+dwVKwbIskP1N53Tbdr5EmlRJokNYbh+eGhhFRS+kxW96H95K7dcENzdTAwS0hROQtS0YP21jZIY8c58U=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by MN2PR11MB3853.namprd11.prod.outlook.com (2603:10b6:208:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 15:21:29 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:21:29 +0000
From:   <Conor.Dooley@microchip.com>
To:     <uwu@icenowy.me>, <Conor.Dooley@microchip.com>, <kernel@esmil.dk>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor core
Thread-Topic: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor
 core
Thread-Index: AQHYlVY+6t1yOzd6XkeyUffI8zZgA618XkoAgAAIQICAAAHzAIAAAggAgAAAx4CAAAJ6gA==
Date:   Wed, 13 Jul 2022 15:21:29 +0000
Message-ID: <b8fd1440-12f3-05af-5d6c-7938adf66344@microchip.com>
References: <20220711184325.1367393-1-mail@conchuod.ie>
 <20220711184325.1367393-3-mail@conchuod.ie>
 <e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me>
 <55e9da06-ccdb-f8e5-b5b9-8125b5fbb58a@microchip.com>
 <822ceff8a6e7f41179abde307ce59c2120684294.camel@icenowy.me>
 <6f6fae32-e3dc-4b9b-21b1-cc2ab0c67de6@microchip.com>
 <1dc0f29b40d34bc6472ba4139ff36f63e9cc9e84.camel@icenowy.me>
In-Reply-To: <1dc0f29b40d34bc6472ba4139ff36f63e9cc9e84.camel@icenowy.me>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec700867-6bc3-45fa-0734-08da64e35c66
x-ms-traffictypediagnostic: MN2PR11MB3853:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C5ipF4vhJ6gB6eUEUFiybYwuslg6P+t6IMjy04/erz7/dYf7dsPN+m60ox7IZA3qEkVaZrjA9phkpMX4WWKEBfSnmA+5to86H2TtaeSRba7RphXkHhW1Qzt4vXNUcEPwpsi7tzwqXH7xP9z0WlKADUkOQgjlBzugigaHJnIs5z+96bSJIkTeWK0DqG2CSzfCv0oGn0rub4p5rmLKUd3HjmWEUkxFF1DFWEk6019q5aiES2bcoTbNOWbLb0NXReQVAAOYaopJLmKmKuJneYvV3rA/BlslHAP+JN0tZ3jhyGIMItLg0h9eJ1FL+Oy3g3l8UetwU/htWzpm4iaFo3atAaxUV3ig+lhBzU5W9EaMOd5ENEmj0uBZuza4IT1L1XJMjLEAO1yLh1k8CIq3mlpQrTfigSGqOtZEi/6qOKtZXJi5/qmon6ASMFLTZRWiH+53O/jKYRKfr9DO15CFJnjVg9RJzBbCMIBqK2e+kM+uuuxlqc+2WQ252ZDhWIAPtK4PpYtU86Ucfozixeybd0oDVrNOJhgmI8ujPC0Vbu9Dgm6xDcKyjHABkLYqbq1OjPZa7D8NXhEvUlH1Gc1JOuBAQU7M4hQnWNm6J7BxMHBCmBPAv8cXXujYqhaNCtW0zciWmt6H0DF0QJxGNnSgOg9196OevctOBE1rkIFiL5ngwP4MN1gxbe04kCfciamCVs/zu/6urkKoTooGNdE6fyYrlprTtPH67IRd1HR15GHc7tcf+hGZzImtHMskxcIpIyJZHzlyuHRW/dnTNDiQMX+eXc+fJehpN8BAAZGxZiOlBFSiG+de9YveDMHoFNXxRuUxhfTOJZpTovryls2OlhQ3JLEI3w5yYN+KS8tLTbhknHwdrFcWzacr6VYKifw9ZY5G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(366004)(39860400002)(376002)(36756003)(31686004)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(7416002)(8936002)(38070700005)(86362001)(316002)(54906003)(110136005)(64756008)(66476007)(66446008)(8676002)(66556008)(4326008)(66946007)(186003)(2616005)(41300700001)(76116006)(26005)(91956017)(6506007)(71200400001)(6486002)(6512007)(53546011)(31696002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEJJOUlaRDR6MDI2MExtc00yZlp2Y3gvMlFPZ3QxT2puOFBiRkdBalRFOWp3?=
 =?utf-8?B?bmNxOE8wV3NhSjVNYUxrTUhDWU5aQ1Z0WnJneVBFcGk1eEl2UWJvSy9saVJm?=
 =?utf-8?B?eHFiQ2x1T3R6V2dvZlRCWmZDUFRWU3ZoUzhrQ1dqcS9FdEEzTE5uNkpYUVJl?=
 =?utf-8?B?a1lsMmF0TERNNW9KbUFNdXROL3ROSzFPa1M3aFBRWnRxb2RQRk94cFducDk3?=
 =?utf-8?B?eVBmWDNNdDQ3NC9hbitaU2ZycGNyQWlSbEdCSVpBTE1pbGFIeDJYRDdTZDVh?=
 =?utf-8?B?YVgzUXVRN05VK2E4c3cxaERtTmFkY2dYUjdFamdYdXNPbnlVc2xpamFoZUI3?=
 =?utf-8?B?eDllOC9Nb3VQZlV3MmhnSFpSblpqM1ZlZDlBeHRZSHl4NU03TXNKb3cxUzJH?=
 =?utf-8?B?aWtFQlcvMGExb0JKWXhkck5IRjNRYzFtdHQxamRUTkJQQnlSSEllMW9IdDZx?=
 =?utf-8?B?RjVjVW5SdEVtQ2djeGVqS1JXL2VtQ3diRzJFYy8rcDB4Ym8rSExneDg2QlFU?=
 =?utf-8?B?YUF6TkV1MDRWc1VCZkVhdmplQlp4VWpML3NWTXRtQktwV09kMUkzckxEeVBJ?=
 =?utf-8?B?dlVnS2d5clhZM2w5TGI5U1VTWDhHaXRxUUVFK1hucW5neDRKNml5TGJvTkJQ?=
 =?utf-8?B?V0Q2MlIzZkdlS2YrSWlpdlE1Vmdxc1lQNzd2WVZEbisvVnBxUlZ4YUJiWGsv?=
 =?utf-8?B?bVZCSDFyN1dNOUFCQS9WMDlraEphdEwxbC94NTE5OWp1bU9ZWDRLWjlrWEZa?=
 =?utf-8?B?Mis5VjBHWDNPWGZHcEcwNzhRQzlVaUFBRTJ5UlQzeXBsVG44MWl1VFFydEo4?=
 =?utf-8?B?bm02bDZTNXZYVnlWUFFIaVNJYjdkVDRSRnA2SGZhQStENkoxZDhuTENicmt4?=
 =?utf-8?B?U1dFWTZ2UHVTSE9uWmN4UDhSN2dyWnBqZGd4WmFMWHdmbWZnYkM1N3pkTzVS?=
 =?utf-8?B?eVBnWng2WjRZM005Ym91UlNrVjBPUFQ5RjJxY0JrL0xBbTREc001eFlYcEgr?=
 =?utf-8?B?NGhkVW5PbHVzc2FnZWlCdkIwc3RTdmY2QmNPUEFzdmQvcGZjV1pBRHFsV2l0?=
 =?utf-8?B?NzNnUjlSdnFiVlgvbnkrYkc5QTJrdHBveCtFc203TStVOEI3V0VCTmNRNUp5?=
 =?utf-8?B?MUhNL2RTSWFiVG1XRWVmVHk1NTIzRG44U1JYU0JFYU0rb2xqZFZnSnFabEI1?=
 =?utf-8?B?WHh0TzAwNDNERklRY1VzallwY0plR3dlZi93MTNsV3IzN0RlU0FaK1U3MUdW?=
 =?utf-8?B?K2tLNzJpUzcxemhVOHlmWmlIOUdBeUxualBiSldHWENZV09mcTZKVDhpcXFj?=
 =?utf-8?B?a01KdmhYb3h6dDVPRU9MelV5N3BuWTQ4YUJQdUJHYm5QR1dNcHk2Ti9kd1BY?=
 =?utf-8?B?dS93dWVsUkY5dTloYVFlUW5SZ0R3N0VQZXF2cjRveVRhQTIzNGZvbkMxUnl2?=
 =?utf-8?B?UTJFYUZxN0M0VndmeVpOcnIxNFRqVldQc0xKM2hibnpYeGtOOHY0YS9OSVAw?=
 =?utf-8?B?bTVvdndJUzc0MHNQcHV5WkZ4VEFZNFlZRmlrSzJyT1c0cTJUZW9xS1g3Tnp1?=
 =?utf-8?B?ZFE2elVjVkVKRC9KdnVoZEdFZzBiSExPUjUwYlhuWVVrWE96V2RyQzhOamNI?=
 =?utf-8?B?YVFKcWxqTUMxckFWRmxGK1NSVFlnMTRHRXRyU0Y3dTV2cVdrSzVvMm5GZ3ha?=
 =?utf-8?B?WE0xM25YWHgzWkQrbXIxcEdvTmdDYStkUFN6STc0TUlIMUw0Mkl1SG4yZlF5?=
 =?utf-8?B?L1JXeEduaE93MnJFNVJSdDV4clFHd2lMVXdRZXNlUjJFY2o5ZWdvS2RCakZX?=
 =?utf-8?B?WDdYZ2hpNk1NN1NOVVRKSFlDVjNlRjdyc0x5TzkvTXdtT0Rqa1Z1SFUvM2Y3?=
 =?utf-8?B?Uy9HR2ExUTZlSEdKNWtqSmVrNklSb3htYVdSTEVsNFNDejBaRnhYdEM5bkU4?=
 =?utf-8?B?a1hnMlFhS2F4WWduK2ZwNUl3d0tsTFpPaGpRUG1CM3NoSHBHMFI0bjI4WUV3?=
 =?utf-8?B?WU5tNFozZlBPZy93cUIrS2tiMlBEZmNZc3lVUW9URDZ5UU9RWFNUdDliUkFO?=
 =?utf-8?B?WlF2ZFlUb3IrTHpIWEUyT3FEb0UzaVRQT2cxQ0xpOFZFTHBxc1Bpa2FTMk5t?=
 =?utf-8?B?Q3pHSXZ5ZGcwYnpaUFhNc1EySVpEVHhKdzJ6aVpJS1cwd1lVVW93c2d3VTNr?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCCF6E94524C4849A1470E8B63B41C72@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec700867-6bc3-45fa-0734-08da64e35c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 15:21:29.6422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pq2XgGHi/u9HwBbcKyn6P8GqCfc3NJtKiFMZXM9jh42p9EczbbjAZIfD8Nr5L/WBywoU5ZD2QJpEZ+kif0ll5mJQBe6WqSfQ0ZB+TzpE/Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3853
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDcvMjAyMiAxNjoxMiwgSWNlbm93eSBaaGVuZyB3cm90ZToNCj4g5ZyoIDIwMjItMDct
MTPmmJ/mnJ/kuInnmoQgMTU6MDkgKzAwMDDvvIxDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbeWG
memBk++8mg0KPj4NCj4+DQo+PiBPbiAxMy8wNy8yMDIyIDE2OjAyLCBJY2Vub3d5IFpoZW5nIHdy
b3RlOg0KPj4+IOWcqCAyMDIyLTA3LTEz5pif5pyf5LiJ55qEIDE0OjU1ICswMDAw77yMQ29ub3Iu
RG9vbGV5QG1pY3JvY2hpcC5jb23lhpnpgZPvvJoNCj4+Pj4gT24gMTMvMDcvMjAyMiAxNToyNiwg
SWNlbm93eSBaaGVuZyB3cm90ZToNCj4+Pj4+DQo+Pj4+PiDlnKggMjAyMi0wNy0xMeaYn+acn+S4
gOeahCAxOTo0MyArMDEwMO+8jENvbm9yIERvb2xleeWGmemBk++8mg0KPj4+Pj4+IEZyb206IENv
bm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pj4+Pj4NCj4+Pj4+PiBU
aGUgSkg3MTAwIGhhcyBhIDMyIGJpdCBtb25pdG9yIGNvcmUgdGhhdCBpcyBtaXNzaW5nIGZyb20g
dGhlDQo+Pj4+Pj4gZGV2aWNlDQo+Pj4+Pj4gdHJlZS4gQWRkIGl0IChhbmQgaXRzIGNwdS1tYXAg
ZW50cnkpIHRvIG1vcmUgYWNjdXJhdGVseQ0KPj4+Pj4+IHJlZmxlY3QNCj4+Pj4+PiB0aGUNCj4+
Pj4+PiBhY3R1YWwgdG9wb2xvZ3kgb2YgdGhlIFNvQy4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pj4+Pj4g
LS0tDQo+Pj4+Pj4gwqBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC5kdHNpIHwg
MjENCj4+Pj4+PiArKysrKysrKysrKysrKysrKysrKysNCj4+Pj4+PiDCoDEgZmlsZSBjaGFuZ2Vk
LCAyMSBpbnNlcnRpb25zKCspDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNj
di9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQ0KPj4+Pj4+IGIvYXJjaC9yaXNjdi9ib290
L2R0cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQ0KPj4+Pj4+IGluZGV4IGM2MTdhNjFlMjZlMi4uOTJm
Y2U1YjY2ZDNkIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZp
dmUvamg3MTAwLmR0c2kNCj4+Pj4+PiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZl
L2poNzEwMC5kdHNpDQo+Pj4+Pj4gQEAgLTY3LDYgKzY3LDIzIEBAIGNwdTFfaW50YzogaW50ZXJy
dXB0LWNvbnRyb2xsZXIgew0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfTsNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fTsNCj4+Pj4+Pg0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEUyNDogY3B1
QDIgew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb21wYXRpYmxlID0gInNpZml2ZSxlMjQiLCAicmlzY3YiOw0KPj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8Mj47DQo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldmljZV90eXBlID0g
ImNwdSI7DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGktY2FjaGUtYmxvY2stc2l6ZSA9IDwzMj47DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGktY2FjaGUtc2V0cyA9IDwyNTY+Ow0KPj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpLWNhY2hlLXNp
emUgPSA8MTYzODQ+Ow0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByaXNjdixpc2EgPSAicnYzMmltYWZjIjsNCj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4+
Pj4+PiArDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNwdTJfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KPj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0
aWJsZSA9ICJyaXNjdixjcHUtDQo+Pj4+Pj4gaW50YyI7DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHQt
Y29udHJvbGxlcjsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4+Pj4+PiArDQo+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdS1tYXAgew0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2x1c3RlcjAgew0KPj4+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvcmUwIHsNCj4+Pj4+PiBAQCAtNzYsNiArOTMsMTAgQEAgY29yZTAgew0KPj4+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvcmUxIHsNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1ID0gPCZVNzRfMT47DQo+
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfTsNCj4+Pj4+PiArDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3JlMiB7DQo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY3B1ID0gPCZFMjQ+Ow0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4+Pj4+DQo+
Pj4+PiBTb3JyeSBidXQgSSB0aGluayB0aGlzIGNoYW5nZSBtYWtlcyB0aGUgdG9wb2xvZ3kgbW9y
ZQ0KPj4+Pj4gaW5hY2N1cmF0ZS4NCj4+Pj4+DQo+Pj4+PiBUaGUgRTI0IGNvcmUgaXMgdmVyeSBp
bmRlcGVuZGVudCwganVzdCBhbm90aGVyIENQVSBjb3JlDQo+Pj4+PiBjb25uZWN0ZWQNCj4+Pj4+
IHRoZQ0KPj4+Pj4gc2FtZSBidXMgLS0gZXZlbiBubyBjb2hlcmVuY3kgKEUyNCB0YWtlcyBBSEIs
IHdoaWNoIGlzIG5vdA0KPj4+Pj4gY29oZXJlbmN5LQ0KPj4+Pj4gc2Vuc2libGUpLiBFdmVuIHRo
ZSBUQVAgb2YgaXQgaXMgaW5kZXBlbmRlbnQgd2l0aCB0aGUgVTc0IFRBUC4NCj4+Pj4+DQo+Pj4+
PiBBbmQgYnkgZGVmYXVsdCBpdCBkb2VzIG5vdCBib290IGFueSBwcm9wZXIgY29kZSAoaWYgYSBk
ZWJ1Z2dlcg0KPj4+Pj4gaXMNCj4+Pj4+IGF0dGFjaGVkLCBpdCB3aWxsIGRpc2NvdmVyIHRoYXQg
dGhlIEUyNCBpcyBpbiBjb25zaXN0ZW50bHkNCj4+Pj4+IGZhdWx0IGF0DQo+Pj4+PiAweDANCj4+
Pj4+IChtdHZlYyBpcyAweDAgYW5kIHdoZW4gZmF1bHQgaXQganVtcHMgdG8gMHgwIGFuZCBmYXVs
dCBhZ2FpbiksDQo+Pj4+PiB1bnRpbA0KPj4+Pj4gaXRzIGNsb2NrIGlzIGp1c3Qgc2h1dGRvd24g
YnkgTGludXggY2xlYW5pbmcgdXAgdW51c2VkIGNsb2Nrcy4pDQo+Pj4+Pg0KPj4+Pj4gUGVyc29u
YWxseSBJIHRoaW5rIGl0IHNob3VsZCBiZSBpbXBsZW1lbnRlZCBhcyBhIHJlbW90ZXByb2MNCj4+
Pj4+IGluc3RlYWQuDQo+Pj4+DQo+Pj4+IE1heWJlIEkgYW0gbWlzc2luZyBzb21ldGhpbmcsIGJ1
dCBJIGRvbid0IHF1aXRlIGdldCB3aGF0IHRoZQ0KPj4+PiBkZXRhaWwNCj4+Pj4gb2YgaG93IHdl
IGFjY2VzcyB0aGlzIGluIGNvZGUgaGFzIHRvIGRvIHdpdGggdGhlIGRldmljZXRyZWU/DQo+Pj4+
IEl0IGlzIGFkZGVkIGhlcmUgaW4gYSBkaXNhYmxlZCBzdGF0ZSwgYW5kIHdpbGwgbm90IGJlIHVz
ZWQgYnkNCj4+Pj4gTGludXguDQo+Pj4+IFRoZSB2YXJpb3VzIFNpRml2ZSBTb0NzICYgU2lGaXZl
IGNvcmVjb21wbGV4IHVzZXJzIHRoYXQgaGF2ZSBhDQo+Pj4+IGhhcnQNCj4+Pj4gbm90IGNhcGFi
bGUgb2YgcnVubmluZyBMaW51eCBhbHNvIGhhdmUgdGhhdCBoYXJ0IGRvY3VtZW50ZWQgaW4NCj4+
Pj4gdGhlDQo+Pj4+IGRldmljZXRyZWUuDQo+Pj4+IFRvIG1lLCB3aGF0IHdlIGFyZSBjaG9vc2lu
ZyB0byBkbyB3aXRoIHRoaXMgaGFydCBkb2VzIG5vdCByZWFsbHkNCj4+Pj4gbWF0dGVyIHZlcnkg
bXVjaCwgc2luY2UgdGhpcyBpcyBhIGRlc2NyaXB0aW9uIG9mIHdoYXQgdGhlDQo+Pj4+IGhhcmR3
YXJlDQo+Pj4+IGFjdHVhbGx5IGxvb2tzIGxpa2UuDQo+Pj4NCj4+PiBUaGUgRTI0IGlzIG5vdCBp
biB0aGUgY29yZSBjb21wbGV4IGF0IGFsbC4gSXQncyBqdXN0IGEgZGVkaWNhdGUgQ1BVDQo+Pj4g
Y29ubmVjdGVkIHRvIGFub3RoZXIgYnVzICh3ZWxsIGFzIEkgc2F3IHRoZSBkb2N1bWVudCBzYXlz
IHRoZSBFMjQNCj4+PiBidXMNCj4+PiBpcyBtYXhpbXVtIDJHLCBJIGRvdWJ0IHdoZXRoZXIgaXQn
cyB0aGUgc2FtZSBidXMgd2l0aCB0aGUgVTc0IG9uZSkuDQo+Pj4NCj4+PiBUaGUgVTc0IE1DIG9u
bHkgYWxsb3dzIFM1IG1hbmFnZW1lbnQgY29yZXMgdG8gYmUgcGFydCBvZiBpdCwgbm90DQo+Pj4g
RTI0Lg0KPj4NCj4+IFNvIGlzIHRoZSBjb3JyZWN0IHRvcG9sb2d5IG1vcmUgbGlrZToNCj4+IGNw
dS1tYXAgew0KPj4gwqDCoMKgwqDCoMKgwqAgY2x1c3RlcjAgew0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvcmUwIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY3B1ID0gPCZVNzRfMD47DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3JlMSB7
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdSA9
IDwmVTc0XzE+Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQo+PiDCoMKg
wqDCoMKgwqDCoCB9Ow0KPj4gwqDCoMKgwqDCoMKgwqAgY2x1c3RlcjEgew0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvcmUwIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1ID0gPCZFMjQ+Ow0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH07DQo+PiDCoMKgwqDCoMKgwqDCoCB9Ow0KPj4gfTsNCj4gDQo+IENv
bnNpZGVyaW5nIEUyNCBzZWVtcyB0byBzZWUgYSB0b3RhbCBkaWZmZXJlbnQgYnVzIGNvbm5lY3Rl
ZCB0byBpdCwgSQ0KPiBkb24ndCB0aGluayBpdCBldmVuIHByb3BlciB0byBhZGQgaXQgdG8gY3B1
cyBub2RlLg0KDQpXZWxsLCBpdCBpcyBhIENQVSBpcyBpdCBub3Q/IEhvdyBvbmUgaXMgc3VwcG9z
ZWQgdG8gZG9jdW1lbnQgdGhhdCBhDQpDUFUgaXMgbm90IGF0dGFjaGVkIHRvIHRoZSBzYW1lIGJ1
c2VzIEkgZG8gbm90IGtub3cgaG93ZXZlci4NCg0KPiANCj4gQW5kIEkgZG9uJ3QgdGhpbmsgaXQg
aGFzIGEgaGFydCBpZCBvZiAyLCBhcyB5b3VyIG5vZGUgZGVzY3JpYmVzLg0KDQpEbyB5b3UgaGF2
ZSBhbnkgaWRlYSB3aGF0IGl0IHdvdWxkIGJlIHRoZW4/DQo=
