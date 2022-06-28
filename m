Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE11C55E500
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiF1NiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346736AbiF1NhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:37:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28AB31372;
        Tue, 28 Jun 2022 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656423437; x=1687959437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Sdk85jPEbentvOxPmfD/Er5LSNx4fSvC9fXjKd0J4xc=;
  b=t5KdSoHbCtKdwZOgw4xQ65unmbtCoNkuynOsji5M6vxvOVFFx7Nwuu0u
   aVsOYCwvzSynIMEaSnarLw8GKcWAwQ7ewBriowWjcceoDFblZZxTBVm08
   HFpfUWw4Aj+aQlPsciPvVX0X7rIngDSWqs1/M0xcQ7IkFN36KOSaTPO2H
   kOkcV21+v8Qd0NCgR3uw3S5BklYVUw7mEC8wi/vnThoNpbpUyc0AMPG4x
   awihSxRfCh4sGtf0mBXRkoBwxAT3lanSC5CIb9pUAJa8fuoqONP+EZBo0
   FNxN2QjRwKpx3YDBzN7Dl6SdRGjgpqkOfBwkLlKj9BKSv9n2+dWoXIDu5
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="169927739"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 06:37:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 06:37:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 28 Jun 2022 06:37:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgsbD/KtTcek75G8/gGn+GA+nRAva/SlZlZGNYpyj6NUCUtRwI8dv3Ta1zSzTAERRmquSk5odTIQAuDgv3HZm9J1H515PINI44uCaqYBWShMQ+d4cnSaNB+3pQ2FPikXydwBTOV6Q8hH4cEsS3Pb5vFX3kG19WkM61NVY//lXObdq0it5Ux5flfDs2uy8bg93OT4rRU2Pxw9ToUoTvbAlT5DcIlDFQQGBxlUcg1wYRdynwtvZKEf9YHCLYwoIOvBLBjqMqaVLAsThmKWtRP8+uTCY3C+tHlhrNRCEtz8vt3vpRyToKQ6KjcofhlM8KY7Y5xRAi7cDqR8F/fWSWiFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sdk85jPEbentvOxPmfD/Er5LSNx4fSvC9fXjKd0J4xc=;
 b=T3iRwTBO4WloBfoIr4vwTzOzvv8/9FT1qAinFE2/55zg/2ilJ3n3PUbIifb+ChiLhqqJwOG9xex02Y0z/j7ayUbADSxjGTrGrcpcw2ofKPGzJp0eWWcmfYSC7Zk2yQt/7NqcuwMOIZ58EF1fV7WO2qrY3gUcLph3YpeYyTWAJCudcTq5kfpnI15GpAOe2Fafu+ruMN5zEIB2mOw2mcckC1SOVy2T4gRYGi882LiJZA+S2GZbXLuXF0/5Fgsi3Ta+nSjZkRP1sS7/re+yd/6B/0v4QLwRx42fQ81GkcV6R+FBwlAv/xxObOYOvtlR3IzS5Gk3gy4EjLjkxcojKwYgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sdk85jPEbentvOxPmfD/Er5LSNx4fSvC9fXjKd0J4xc=;
 b=WsJdnNbe/NJHux6pUESPzROzOocac7I1slSvvkwqS33cnr2c26UsIHXeTq6jx3bkGe0sb0lzpWXhPDlhm+k+VjBktLhk95CIHJWmiUTRMP4hkR8l3Go4vKa76Kg7iZD8u6j0H3tcpEDQlh/uuhZDODxbjx+xGcKgJiCk5AFzyZo=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by DM4PR11MB5391.namprd11.prod.outlook.com (2603:10b6:5:396::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 13:37:13 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0%10]) with mapi id 15.20.5373.018; Tue, 28 Jun
 2022 13:37:13 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 1/2] ARM: dts: at91: sam9x60ek: fix eeprom compatible and
 size
Thread-Topic: [PATCH 1/2] ARM: dts: at91: sam9x60ek: fix eeprom compatible and
 size
Thread-Index: AQHYivQrMKJc0FEEP0q4tQ39Fj/gyQ==
Date:   Tue, 28 Jun 2022 13:37:13 +0000
Message-ID: <2b092bc6-5abc-d5db-8135-6a03bafa848c@microchip.com>
References: <20220607090455.80433-1-eugen.hristev@microchip.com>
In-Reply-To: <20220607090455.80433-1-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c04ca891-8a67-4ed6-70e4-08da590b4f05
x-ms-traffictypediagnostic: DM4PR11MB5391:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZJlMwttw76O9+LVEfE3xE36jM1Mlgt/XmGR5D/65GLvb6K2Mwz1BPUcF797MoZXpMwTZuP+dIY2HlLfLYYRElMJZyOoPgx2N6QlOEwzrW/jizuT54hJ6SFdg2+5mk88JgJKybG8QhJWpDtyc7JftmoU5uBxKpfXRPSAUSYgT419jj4TRcEcwufhWOgRVhIxKAtWHRV71jChY4PKEJDTiykj4E3ieV2I+nGE5SXf4Ns5pXAie+gl2HWDSKBpSnyqbCe7gMmyRZFFA3Q0LFruu5s/boyZFdHI3aSiQK4c/GYxkCvTrT3JyadcYuKX+FIQ9SUpYwFYObFFUX/rRZ7bOVOAMxqBzqJyo4Pg4/D8b/E33CVt5NHhHZ8qwsPwnpCgiZjoYbBKoMe4tXcfkQD8Fk77FESXCaps3NbMs6pQHd/LAT8V42h1fH90okqPzMxqhdv4Y573o6bZJuaV1XrsSCDGrvWz1OjBvmcn3NIAsU4EJxZGL8q+EqBAv40debARwz6erOpwmHa6wgN8VeLGJqsBPwI1IZkxZzJmWhyz5jsJiVJxsuQpVzH1YQUqkxTyyG3Ez4ZcOp16xM+za9WuFZrnD7UFAFhSk/bAo36p91CVPE7peNl27nMdPXKX3d+zFV1Hh/stF7Rz6lX7vHkoq9X6x1PRJpDxkY4gzX+iRNQm8xhjkiFoK/azqmHRfzN/+RQmoQTec0oA0MSnbQsjKT6zR930gBl7yZIh6VSggXsBeYWFwColUTRXOtTHZFkBdVB8Oc5JNVo57DrgmPx3t43/sJI6KezUrV5tNoZ6Sv+2sY3oeS4pYlNnZdF5lWqeW2p4xSzTSjdOv1V0UR0zRasCxnJ2zjPq+iuFuVrnXxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(376002)(366004)(396003)(6506007)(41300700001)(4744005)(36756003)(122000001)(186003)(38070700005)(478600001)(26005)(86362001)(6512007)(5660300002)(31696002)(316002)(4326008)(8936002)(107886003)(54906003)(64756008)(2616005)(66556008)(83380400001)(71200400001)(2906002)(66476007)(66946007)(38100700002)(8676002)(76116006)(31686004)(110136005)(53546011)(91956017)(6486002)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2ZVYjFpQnQySkE2RmJhZWpoVjNQWVZ3Wnc4U1lZTnhlOXo4ZktQcWlBVE41?=
 =?utf-8?B?MTB4OGZMK0dlbmNCSmg0ZVJjMVNJNExLc1FWcUN2M1BDd1p4bWp5ZnFRNEhT?=
 =?utf-8?B?ekZUOTkxUVpocHZ3WmpWQ0lRQzFmd0MwQ1NEZ2l2a2RNeUc5bXEyUkhMY3FX?=
 =?utf-8?B?V24wQnRZNm5hSFArak80WXFWNFVhZVNGbktTMnZsa3BoU0ViaVZQcmkyWkNi?=
 =?utf-8?B?ZmtJREl2aThud2N1dzJOaTdYZXR2SEhwaUJwTHRIZHhCVVdYdk02cUZhOGJr?=
 =?utf-8?B?b1F5bmFaNGZleDVxaW1MZEl2K2xLbU5tenIxMXFLQUZsWVVoNi9wbkRPdmZQ?=
 =?utf-8?B?d1BLUE15dmYwTDBidEwvelMwNXpidnNURDJQK2RYNGRYcDJjSWtlMmVOdE5L?=
 =?utf-8?B?NmVXNWJWMDhjREVpelJOamZsQUJuZDAyRUJxQi9VSUlYdFV6VlpYWFRmdmp5?=
 =?utf-8?B?c1VRbkNpSVhLWDRuYmE4ZC84WXRrQXhDUHdrQkdjRGhxbFRiQXB5bDFHenhU?=
 =?utf-8?B?bnY0cGlyamJPVGx1YU9kU3VWTCtYWG5uL3hXNGNKY3VXMmQzOHVyd0ZkaXB1?=
 =?utf-8?B?Ti8yazJsVHl4eEpLTWdBeEUvT2VUZFJrVk1SY2orS1d4b1FPaWVSTnhTY21T?=
 =?utf-8?B?aUc3ZnJKZGsyNGZnWEJCa2p3a2RzblJQdTkzZjNRQ2FVUEFubkVmU0dmbUVv?=
 =?utf-8?B?S0lhVzFRMCtGSmI0bW1nYTVCV080eVVQR1JHNzgyc1pMbmhsMUk0Q3IwS3dU?=
 =?utf-8?B?UzcwZ1ZscjQxVVVWZ21QZXVSaVNBanpTRjBXV2VtWHhHZ2lMYkNoVFVhY2JC?=
 =?utf-8?B?R1pTUXVnWVR4R0NwTXJ6Rmt3TkczcytlbXN0MWVPQmpSRXFOMWpsRFIwZXk1?=
 =?utf-8?B?NFZ5TytoVG5mbitlTEVoMlVjODlaZmNaNTNSRzdSMXl6Znl5dWRSM1JMeXox?=
 =?utf-8?B?djRvR09DOXEzeFlpZ2dNdkZDUng5QzJXbUZSeVV2bTM5YnJuMm0vdjNkWGNI?=
 =?utf-8?B?ZTBBM2F1V2lVZ2pNd0lCQW9yWW1FYTFuTmtoU1BKcW1Eb3F6MVRITEtlQTVW?=
 =?utf-8?B?NU9iTFIrOFlhU25NZGlDNmkxMEs5Z0k3ZHZESmVVd2RkV3pWenZzcFRjT3Bn?=
 =?utf-8?B?L045ZUtGdzAvYzEwUGdwQnEyelUzMnIyTmdTVCtHSnRHZ3oyajhnM1AyWHEz?=
 =?utf-8?B?WCtpMkxwOFVNeXplalJvOEloYXM3QmdUekYxbE8vNVMvZjN4eWhvWkd4RVRL?=
 =?utf-8?B?ZVZJQVBBSjl3NStkRE9mb0dia2Yyei9UM1lCN2t1bkZWZjlxSndoaTU1aHl4?=
 =?utf-8?B?eFFQb1REUG1TdHRxRmxVMjNGMkVhU1BFOWltdksyUGRIV0VKQmF5ckhTaHJr?=
 =?utf-8?B?L1o5QW9Zam9uaE43c1FqYmRuZk85QVI2K283Q1pWODlsL1BJcEM4WVBvckdW?=
 =?utf-8?B?MzVqUUNxOHdleGhQN2ZGbHQ2UFV6c1NqZTQrRDFoQTZleUZHRzN5aVJVVVdY?=
 =?utf-8?B?KzJLNDFISmxhRWpGekxGYm9FMklTNEhTNUtmSS8vUExQUUhKT1hGK2s3MEpz?=
 =?utf-8?B?dnRkMWtmU0FISUsyZG5tQ3dSbG1xcGhTT1NUeTA4SitNS3Rxc3AybWJPM1ZO?=
 =?utf-8?B?YUlXTlQrOGQ3a2NFQzBVdXBjbWZnc2NETk82UTdGSVNpcXdPRVJ4L29nTHpT?=
 =?utf-8?B?Z0FZWmpVTU9mbUFBN2NvdE5vd3l3U29HcU5FRGMzUis4a201ZXV5ZC9nWEVM?=
 =?utf-8?B?aCsvckdhbUI5blVBaXhEZTh0RSs3TmlKTlZLV252S09QTmpIV2FFUXNpM0NB?=
 =?utf-8?B?QTJ0c2FzNFZ2cm13bTZBUFVOZ2JRUEwvR0xUQTFWU1pweGRvNy9ncDBmcFd2?=
 =?utf-8?B?N0JZMlRkWjkxTzBZVWJSdGxpdEFwSzM4Vll1OUZtK0hST29ZZFFTeEFPR1RS?=
 =?utf-8?B?aTRnUHhKNDhYVFM5eS9MS3ZSUjNrZDFvRDNnN3pac09kMWttZStFblhmUjJC?=
 =?utf-8?B?cWVQSGQzWmJxdURMaWtqRkVrMmpHdDFMUWNrU0tWcHhZMXlWNEZMTDFUakti?=
 =?utf-8?B?Yk5JOC9NQVoveThDN2w2SG03bzFPOUdmRFJjNkVPdFcrdWFkOW16N2JkZHJH?=
 =?utf-8?B?MGduSVYwazNwbUZ6V3dleCtmaklGeElzQ3NTS1prdXBTNE5xUGh1azFrdi9E?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C88FB9D394CCD47BD8205F7279F3AF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04ca891-8a67-4ed6-70e4-08da590b4f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 13:37:13.1146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwXmhhRgkAmEtl556zcSV/Y+KKey+GF+B46P5MNvtyO1AHvHNg6uWgEi/BKHUN5733ATQcDEp/vxYIhJryAHDSVtkqeiMGX2G6QleJr0xvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5391
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDYuMjAyMiAxMjowNCwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gVGhlIGJvYXJkIGhh
cyBhIG1pY3JvY2hpcCAyNGFhMDI1ZTQ4IGVlcHJvbSwgd2hpY2ggaXMgYSAyIEtiaXRzIG1lbW9y
eSwNCj4gc28gaXQncyBjb21wYXRpYmxlIHdpdGggYXQyNGMwMiBub3QgYXQyNGMzMi4NCj4gQWxz
byB0aGUgc2l6ZSBwcm9wZXJ0eSBpcyB3cm9uZywgaXQncyBub3QgMTI4IGJ5dGVzLCBidXQgMjU2
IGJ5dGVzLg0KPiBUaHVzIHJlbW92aW5nIGFuZCBsZWF2aW5nIGl0IHRvIHRoZSBkZWZhdWx0ICgy
NTYpLg0KPiANCj4gRml4ZXM6IDFlNWY1MzJjMjczNzEgKCJBUk06IGR0czogYXQ5MTogc2FtOXg2
MDogYWRkIGRldmljZSB0cmVlIGZvciBzb2MgYW5kIGJvYXJkIikNCj4gU2lnbmVkLW9mZi1ieTog
RXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KQXBwbGllZCB0byBh
dDkxLWZpeGVzLiBUaGFua3MhDQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNh
bTl4NjBlay5kdHMgfCAzICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEt
c2FtOXg2MGVrLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVrLmR0cw0KPiBp
bmRleCA3NzE5ZWEzZDQ5MzNjLi44MWNjYjA2MzZhMDA5IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
YXQ5MS1zYW05eDYwZWsuZHRzDQo+IEBAIC0yMzMsMTAgKzIzMyw5IEBAIGkyYzA6IGkyY0A2MDAg
ew0KPiAgCQlzdGF0dXMgPSAib2theSI7DQo+ICANCj4gIAkJZWVwcm9tQDUzIHsNCj4gLQkJCWNv
bXBhdGlibGUgPSAiYXRtZWwsMjRjMzIiOw0KPiArCQkJY29tcGF0aWJsZSA9ICJhdG1lbCwyNGMw
MiI7DQo+ICAJCQlyZWcgPSA8MHg1Mz47DQo+ICAJCQlwYWdlc2l6ZSA9IDwxNj47DQo+IC0JCQlz
aXplID0gPDEyOD47DQo+ICAJCQlzdGF0dXMgPSAib2theSI7DQo+ICAJCX07DQo+ICAJfTsNCg0K
