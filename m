Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625F851F463
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiEIGG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiEIGCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:02:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4001816D4AA;
        Sun,  8 May 2022 22:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652075902; x=1683611902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WoOW5MQpmfBZnYboFFzeXf3X/aeWueR4Ru367m1K1tg=;
  b=0wpnfz6cPvRQEXC4HG0LdALff1qfskdUlSZP7tvBbH8UebmJv6CjZ/fA
   PYJVe4wjZVxKZsHnZBt03i2EygJTWB+P1aO0gd9lnCNab2/LxuIXrPqyx
   QdAF/AbZ49FW1iLavPOVWrIatzlZRkUOVYXx4vKeurzIkfj3/HWhVpTbV
   fNUUD738HCsiVOr0A2bdxn9djivxoCcxZOLui/KuH8r4fS2JjZTzX0SzO
   VP54F50o5ZaZ/OnvXQ/LAuQfxz/8BmlgdqhlEW0u7shwP2ts1/SieYnBy
   nMugJef8UiMZieSgGZpmpNJgSpcWNkxO8TReyabeoH3j27UK20I03UZ6F
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="162793247"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2022 22:57:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 8 May 2022 22:57:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 8 May 2022 22:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge17jYKcThHt4mZYvPy9qx7y0HdGWXYu/op+zjBXOeiC7g7KMSMcSjwzGuztEk2/NjGidaOjdZPucR1nWYPUxHBmibKRWOs/pld3zQSxNBEZka+bmnezefUS8UDKR/7PApv0AzsMkyX+OnnHY1483UfgadFdwEKkKZZXX1ZyTjtvVtWx4CFABOCGqp3Cno7l1LU1/F1o0UZhKvyWmFOUWC7Hk70G2WMvRVZC2i+N6vko1iJgl428HvovFJH61RCv8qZR4QjLVhbmF1xS34ui2KU1mdibuVjZkucJrsPjFbhF50HzB/+VboLobQfA06q1MqI4unyht7adOIt2qhulFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoOW5MQpmfBZnYboFFzeXf3X/aeWueR4Ru367m1K1tg=;
 b=a2FP6m+jLdBCt+IzFkJoPP27Dr86om6j9DBtoLfMUPPZ1VlfzW2wquRpICAuFR/3zo56dXX7r3ag82v70oCTGVVr8Ha7ExsYCG4A5g7eK6VlSmEb7W613kemJIHQ9ssRH7bKU2/Q93zCSHPQPQMeQTKdxXHHPuQ7bqR8xFmdPesRFvA5nbndrGd9m/jlPQY6/d2FfNXGjwcGSTM97Uw8p60Uf/zah/0DcIMrCbM0tRkxXAOBUcyqEQGEKuOkid3Yapf2XNmeWW6F//jXlRh/e0bE0AX4a9rTzuTNjKPv+RPwTRE0ss3PPOrWLaFTyez7ER/vkLok3FP5+usB/09AuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoOW5MQpmfBZnYboFFzeXf3X/aeWueR4Ru367m1K1tg=;
 b=dabjed3N1yh7jt+RZ3WfsXyzZkVThwCU8hufYtxLg9h3LCt77okvcnVwQGVrL4zaBL+OW/tigluFlARFNTgf5BYFn5768mX+6ZvqTVADvmsweB+81MQZRDb0bdyA4srRCnrpeL7LjdAFT2DEPDx8vEAIvgW+zqXcqzBkDji3uPY=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by MWHPR11MB1744.namprd11.prod.outlook.com (2603:10b6:300:10e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 05:57:39 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 05:57:39 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Eugen.Hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: remove interrupt-parent from gic
 node
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5: remove interrupt-parent from
 gic node
Thread-Index: AQHYY2mwafi0ZFjT0EGsEcUBfnYt4A==
Date:   Mon, 9 May 2022 05:57:39 +0000
Message-ID: <f5cc90c5-c822-7db5-8480-593c6cc90659@microchip.com>
References: <20220503133127.64320-1-eugen.hristev@microchip.com>
In-Reply-To: <20220503133127.64320-1-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ac6f08a-3894-4e2d-056e-08da3180d358
x-ms-traffictypediagnostic: MWHPR11MB1744:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1744BE5EB1B2DEE4D2E01B6487C69@MWHPR11MB1744.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oKBnpQbJ+60/VhGXZum3JQX+jMi26iI8wvfgn/zSEhoL+qSqe2RSOXiJJmP3jWGxSd2KlOkS5aaf3ibnSumqfwbqpTYs0sP/KIk9AmRwJSQiwjNEwEl93ndPWTgZYpY0ooIzwq9XleBMRTZmPOO28kqkkVhkh+p9PsIeQ85cj+Adny6UkIAj79nvaeWEyC31hu98ThwC8fFsV8oAMAZimkIQ5IWAAUkURFCWEehPA/C9YLr4w4+EzHRhK7ahsPEBFWPNTwi9n2X2pwcn373ZguLKp85nR/oop07Z3UbP1d5cxD/zHp+C9doBAi8klRj5lAI3u3eLaHMpsg3cR2qy/9ZvX90MmKQaa9K0Ea054EX+h2OZe8woDaF5KMM8aqfrvLkHy48s9RW3ZRY15RYPZfmY/4nzxsbY+x8SYpqjNekD1ghqVK3/Ax0B62WHHNSRtiXhDjPJi5XhtJOvbMm8zlSon1xH+9lKfRv0qq7TVjfuidgG5muTIvXk/FOdWJvJEWcF8TSBin+Ul6JWZR0SntjJrpX+rl8OlXejTfmEomjc3fNJwAfHIyjpuv0rEKBF8zK0HSx7kn7cPl3Ma+panm2Q4Zp+ua9MW9RbRAV9uZ8ZTibh0htdlu1G+uMa4zno3XiYZ18LdZzGTN+1BRKDx+Zty7V4u1p46OySNQJ9Lw9fpdCeUFBmR7Fki1jKFRUCGmO/MNX4SdWO9YO96dMlN1NMSPunA+oct0wDX+ReWJm8oa45XPmYL0nlvu7yMGvcjyBIwg+82LgcU9diq7GaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(36756003)(91956017)(31686004)(8936002)(5660300002)(64756008)(8676002)(66446008)(66946007)(66556008)(66476007)(76116006)(4326008)(110136005)(86362001)(38070700005)(38100700002)(31696002)(6486002)(186003)(54906003)(2616005)(83380400001)(53546011)(6506007)(26005)(316002)(122000001)(71200400001)(6512007)(508600001)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW4xSU1DYm9Vd0dPZjJhR3V1SEJYSWdtRkJ5R0tpcERDa2w3TjlEZ0YxSDlL?=
 =?utf-8?B?L00xZG9KRDBkQm1LdG1FOUtLZjVMSUFIeC9Wem80RVBObEtYSmhHSkRyYWVz?=
 =?utf-8?B?QVkyVHBiRS9oSVIvd3drWlNoUXJxZTlPbGUyUndMZUQzdkNjY0U5NlZ2bk9K?=
 =?utf-8?B?cW1IWDllbFB5NHdsOW9sU2F2NEtrekdpNnlDanVoclArWUVwZnhOU3N6MklX?=
 =?utf-8?B?Szc4Vm1IUWFTZEQ0T1VHMzM1Q1BTMmJINHM4RmpaZ25mdURSWVQvZHBPOWdK?=
 =?utf-8?B?TUFpcFNKOWIxbHl1K3ByWTNNM3VRRllrM1dIUzhTNFNqbXY5Nk9pNXRZY2Vh?=
 =?utf-8?B?aHBTL3dPVVoxQ2tDSHJiNTZTSVFKaGlTOGRBR3E1bEtuWFg1aC9VZVhOMkJL?=
 =?utf-8?B?ZUpvb2d5UDFENS92QmI1dnE0VzJyTUN5SEtuaG9QYVZDKzJaWjlYd0ZyS3Np?=
 =?utf-8?B?Zjg0aXhXbUVPTWl3TEI2Rk9Ednl2OG9tdEJQWHBLbUlMaEtCODU1VFByWDgy?=
 =?utf-8?B?TDNvTnpodUFDaHoxekJGVkxHekRaNnZ3aTZYd08xUnBzVi93UHJSSjlMVk5y?=
 =?utf-8?B?ZGRDdjcvaUVLclFtK3pWZ3UwQW83bFAyMzRuRzdqWkRNa2tpVTdreVhZalYw?=
 =?utf-8?B?N3ZZc2ZsaGJFRmJqd3FtU044SWRqUEYweHdxRkg4TXZuY3dPelFMNDZlNjlC?=
 =?utf-8?B?aVVVMTFmVzAyLzZQU1hCSDEwTGQzWitZYW9RNjNNcDV6MmpmV0VsR2hra1My?=
 =?utf-8?B?cjUya2RPbURCRjVqYXp4TDRENUZKS1U0S0ZFUzl5dFdROWN0Y2VLWWRmMzVK?=
 =?utf-8?B?M2RnV01ZTTdvWmFDREp0QzZQNDNFakVJU2FseVpzdEdQWFg2WHpPUjgwQW5T?=
 =?utf-8?B?S28rUkJQMDhlNUl0U1Y1Y1p5SEllWFNsQXZmOFNnQU1ES2crQ0J0aEZPQzJ5?=
 =?utf-8?B?cUZtbGo5OEhIRjlLeWxGVzd0SjZhRWF6YjFhb3ZscnN3NmVJZ2NoLzBmRmJW?=
 =?utf-8?B?c0xCM05YNkZucnlMdXkzK25reWRTTElkd1l5dXRIdm1IUDB1aTc4Uzh0dUdv?=
 =?utf-8?B?WVJNSkM5S1hZZG5ZeSs1RWhCNU8wTjFZa3oySTNCc3hYdHQwSE1nTVc3KzBn?=
 =?utf-8?B?QUxaQitGTitFTmpqdFJ3bVBBd1YzcVk4ZW5rTHpXMnFoRmpjQWt3NjZNQ3pY?=
 =?utf-8?B?T2ozVSttcTgzd3FHb0h2SGpiNHRmdnAyN3I5bkd0V1FyWXlHSG5kaldnNmFk?=
 =?utf-8?B?b21CczlwT05YUEozLzdpS3hBcUVJL3lkWUpCUGo3a1dEbnNrNUhxUnZZQWZO?=
 =?utf-8?B?S2tHWUtmRzRsNDZyVFkyYW1NRXZ2RHgrWFZudE9yZTg1K2JZR21GcEdZaEFj?=
 =?utf-8?B?aVhLS1Fab0w1MDVsb0JxNUxVWnArVFh5SzAweUNxcGptbGlJNGNJQWxxMnRl?=
 =?utf-8?B?TjhIS2JDQ2dnblcwTFNON1NORlZyeXV2a0lndjJaeGkzbXFVNTZIaGR4cGUz?=
 =?utf-8?B?ZG1yaXJJOGI3UEwxZ25CT2JuOEl3bFk4N3ZRWFUyMEhHcUNCRVNWYXphUXAy?=
 =?utf-8?B?cEhKTVFOUVBwM0lzOWoyMUMwZkp0V2JRd0hNdXJjVjFydnBLRFcwRS9jM0NJ?=
 =?utf-8?B?MmJleGd0TkJyREQram5aMHB6YXBiOGRPVFFYRHRQcTB5TFBHRkZyWjRCTW5X?=
 =?utf-8?B?K29xN0M5M1BsYUtFcGhYajk3dDFEbWJyS3pNUk81VnFIQk1abUNGTWJRR3NI?=
 =?utf-8?B?Y0poZ3JqZEVsdmZFb2FtK2VIUVB4REVVYytDV0Jvbk04UlRWUDd5aVdWeWkr?=
 =?utf-8?B?ZlVsb2lCRzdQcmNlQzVtT3VReWUrN1JONFRySVpsNkJ3WitXQjFidjVialdM?=
 =?utf-8?B?Q0F1eis3TStLWU9CbFJ5cHBHOHBSTU9uVHdNd3pGdDRha2N3R0xZYU9ZWC8r?=
 =?utf-8?B?K1hPaXYwVmNiT3FDd0N6TmMwY1VNWDAraWNwdVQvK1pHTUN2WTVwWmFBNnk4?=
 =?utf-8?B?Y01ON2xUSjljSHYxVy8vUUs5dGYxdENuN2hOYmxCZ2hlVThsYUF0Z3B3MmNQ?=
 =?utf-8?B?SEM1dGk1K3ZuSWtqaC8xUy9QeFU0dmR4ZE0yaHRCRDJtWVRZOFd4a2xmNGc3?=
 =?utf-8?B?VkU0dXJVUGtxQ0ZERHYvaFVwYURUNUdmRE5tZzA0Z0Z6YTlQL0VNMVRiUVY2?=
 =?utf-8?B?ajBiakdidHlYN2xVZ3RWWkpRZXdpaEFuN3lQcEFRWG5RSUQzL0RDZ0tMOUtC?=
 =?utf-8?B?aEdweXBpYVBVcUh6bXNpZW42c1NNOWpzdDJBYVFCai94UUFUODlwcFVMaFly?=
 =?utf-8?B?TWM5cUN4N1I2cnhOOE1wKzkyaEJKK0pIMVJiU1ZxVFBOa0VyMVQ2ZURNTXEz?=
 =?utf-8?Q?b3AeBXLy8HyhdBR8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64043AF49BC5754599317370F23C381D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac6f08a-3894-4e2d-056e-08da3180d358
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 05:57:39.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRyXMeIYAfpprcL1NYMDiJyBKUlNlrnmn/Z8rXMXKHLig2zWSZzjOCS24X3irf/8k+Q9OnDvmRrVRICdvpgqazCA4npSfu4Y8ipOofAjy4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1744
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDUuMjAyMiAxNjozMSwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gaW50ZXJydXB0LXBh
cmVudCBpcyBub3QgdG8gYmUgdXNlZCBhcyBhIGJvb2xlYW4gcHJvcGVydHkuDQo+IEl0IGlzIGFs
cmVhZHkgcHJlc2VudCBpbiB0aGUgRFQgaW4gdGhlIHByb3BlciB3YXkgaXQncyBzdXBwb3NlZCB0
byBiZSB1c2VkOg0KPiBpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KPiANCj4gVGhpcyBpcyBh
bHNvIHJlcG9ydGVkIGJ5IGR0YnNfY2hlY2s6DQo+IGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2Ft
YTdnNWVrLmR0YjogaW50ZXJydXB0LWNvbnRyb2xsZXJAZThjMTEwMDA6IGludGVycnVwdC1wYXJl
bnQ6IFRydWUgaXMgbm90IG9mIHR5cGUgJ2FycmF5Jw0KPiAJRnJvbSBzY2hlbWE6IC8ubG9jYWwv
bGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2R0c2NoZW1hL3NjaGVtYXMvaW50ZXJydXB0cy55
YW1sDQo+IA0KPiBGaXhlczogNzU0MDYyOWUyZmM3ICgiQVJNOiBkdHM6IGF0OTE6IGFkZCBzYW1h
N2c1IFNvQyBEVCBhbmQgc2FtYTdnNS1layIpDQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0
ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNpIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE3ZzUuZHRz
aSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE3ZzUuZHRzaQ0KPiBpbmRleCBjZGFhOWM4MjVmNjku
LmY0ZjE3NDMxNGU0ZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5k
dHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE3ZzUuZHRzaQ0KPiBAQCAtOTQ5LDcg
Kzk0OSw2IEBAIGdpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJAZThjMTEwMDAgew0KPiAgCQkJI2lu
dGVycnVwdC1jZWxscyA9IDwzPjsNCj4gIAkJCSNhZGRyZXNzLWNlbGxzID0gPDA+Ow0KPiAgCQkJ
aW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+IC0JCQlpbnRlcnJ1cHQtcGFyZW50Ow0KPiAgCQkJcmVn
ID0gPDB4ZThjMTEwMDAgMHgxMDAwPiwNCj4gIAkJCQk8MHhlOGMxMjAwMCAweDIwMDA+Ow0KPiAg
CQl9Ow0KDQo=
