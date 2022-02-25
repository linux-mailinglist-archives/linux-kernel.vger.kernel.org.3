Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC64C4708
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiBYODC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiBYODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:03:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC9B7C75
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645797748; x=1677333748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9Q/1oCkUB/OLGEqeePNbO2y4Wfm+vA00xnbc38lnMI4=;
  b=vhbHYs50t5IGyxvZqftfnU9lfa9NlDsg2/5wYiowWTevsRtF8BoILcRE
   AgPvL+V1k+3FAOO9wRR4p/BNU7Uey8M1eMQ/hrQUmdYBrmkVFMeEgGxzM
   ZgSCbt5jbvKEzEc/e3V3UYVs3jVyhWsQaqNojYXEg14bmNqsI/VB7TGJz
   0NWQwNmLobVTAmYh0P+JEREQ/ITbeQ8j5P9wxNQp/L7QIaafibWJpV3V9
   fWL9Orvs23gwytsiCkFeED8ijdC/kncBsp/GwTha3+12rXS1uMg5BBRJ1
   tp2DPB3jUqI5XcT5NMCtjPVLUanuWeU13eUN+UwNcA/H0DxX278YCtqh7
   A==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="163650385"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 07:02:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 07:02:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 07:02:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPVR14bOVuTJ5B2BD7uThbPPuSkwZ4veDGFNMS3NIncYyiPOi//wfHM/8THbkl2hiJ6SrshtTCmxZjn/HQnY1XYCg2pU5J2JBNtGW3yH8Zo45u6xxNJD99r3VdtURwOZKaPOjm5H+q+LjXP8rqro8Ic5Upj0JbEFqqSk+F0WUCY44Yz9pTixHnB/lDbHY1j8cBa46kMbM5++zXeWZUArWaBG2BqIJzNAjWoZzu5TlrrHCOiJ49mlQ8byJTdhMNg+yyaTxc9Z7ZP2YFzH2Lt7yqCHfWuBPk0TJ5R8TBUpOSm+2HHnp0V8kEOkyfaBibqCXPqRRFrxvA/lAU1hu1hK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q/1oCkUB/OLGEqeePNbO2y4Wfm+vA00xnbc38lnMI4=;
 b=gJm0Ztkpai05TS4UviLcwDF62BeRLSjoCvOGBnpPuIUOx1bch1IhdgJCmE+wXRwm17HhQJGb8m79mEJrTUxCedmrpLvdeyyD5D4ZV46rRK0hvpi0Iz0qmBKRc7lSGdGQUEEOYqR9qlzx70dxWHiPiQjdjMEfl6l07fwWMQE4016DAkhH5SBuHq8lEpBTiJIolTc9nwe6mMx+jHSXmCJXg+UpRvkJb2/4f89A69r6XPSVWzIrDIJZJYBZYFoWeS04ODpJtc41TGhuVja6rT8FSy/4ecFSv5BruD6iWV9ZnyXhokedsudbTDaYRO7jG/+k0RjBVJzAZxklHIAkDJi5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q/1oCkUB/OLGEqeePNbO2y4Wfm+vA00xnbc38lnMI4=;
 b=pERJN/R7GtUPhE+oXBqY115i4dkYuSqYxrALd3JQ84SRt7m64V8kksY0VG1areAbRtSjJWWyCZj+xh3dl3uzaZd9uILeUon9A4gu3Lruf2oeEMOQFtjAOZi1d4vApWasZq7tCN7X5BSyEVyr90cFW1uXtr7Z9zhJxBt1k+l2C2I=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN6PR11MB1298.namprd11.prod.outlook.com (2603:10b6:404:48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 14:02:21 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 14:02:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yaliang.wang@windriver.com>
Subject: Re: [PATCH v5 22/32] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Topic: [PATCH v5 22/32] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Index: AQHYKlBO5uIg8ku+7kKf95f5Ls3ySw==
Date:   Fri, 25 Feb 2022 14:02:21 +0000
Message-ID: <457672c9-3ea9-32de-8458-c1aeff1788ce@microchip.com>
References: <20220223134358.1914798-1-michael@walle.cc>
 <20220223134358.1914798-23-michael@walle.cc>
In-Reply-To: <20220223134358.1914798-23-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b04dcca5-129d-46cb-5b77-08d9f867712a
x-ms-traffictypediagnostic: BN6PR11MB1298:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1298F2EAA4AB0E0A69A32B7EF03E9@BN6PR11MB1298.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJDyg5H7nP8hZcICOQfpTEXTy6X9tebV3zi+YheijNlc2y/aSPIYtNQRiWyI+cGdFcPrRXJVocxQY2CZmbT64cQ1xPwISTVdpLuisBcVZwXusPlbIvTkblLtl1ogVHLLs/jyNYPka9nGU6gDPlHMZh5v6i+YwD8tmeRxMATI431Ti2CFflec6xrdz1gfADXONYSDe6Eq6j11kl6JrqiFG/PfR6g0bG+OhwkFSJovLr9OySA7zWArHGq7/vip2j2sLSnabOSULM+lTeOHR1qRECOMdG0RFhL3HhLeGbSQVS2tEf+5s4mMSf5oWHx/xb1BObJZZDHK/CAbNIbeUsGf3V73uG225gmFEqUKfXHNJ9xm4sjlBWyoHeGLfx1hBjXn4R4W/8YXIR4ZSSTDLLSd1v/WzPMQ3syShSTnZf82SAL/nleDtZxvT1ET2g9v1BTp6uUOjO8pHkvwoO7PCIFw4Mn0FrmqpGqDyezH+XPGlLBKBtkR1/BYp6zDRrGlV1KiqDHnx9tSdh/7QVpUVTICGBoEQ6SB8eYrBzKQnz2YKfv3DfInw7KYLSTOAUuGVp20hPY9C6bIrQIE++9UdfQXfhtvJK8LAN1VNdxq6CUtLEoYz1YUL0xnS98lNJ9rsmQe/fLznDv4G22mANn00khmHJEkuGhKhNqaSCpbusNTWMniqARnIpRj/3z/N2HPKTdgcxewhrF4UxESM+fUahanSQgy7pPrEveroQwzDknIt/DhgxMJPLc+M6h2kmjDH4Alb4oaDrR2YoCMVEKS73gc7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(26005)(110136005)(2616005)(71200400001)(54906003)(66446008)(186003)(2906002)(66476007)(31696002)(86362001)(38070700005)(316002)(76116006)(66556008)(66946007)(64756008)(8676002)(6506007)(122000001)(91956017)(83380400001)(8936002)(38100700002)(4744005)(5660300002)(36756003)(31686004)(508600001)(53546011)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0V1dVJ1VXZtaGg0bEl1aHp5WUo3VFlHY1ZCYllqOGlaaDd1dE1IZitmSnA1?=
 =?utf-8?B?T0hianlHRURQQTV2dS9MSWZKdjNOZVhtMDJqTCtaZ014VWRObisxdjBsTzJm?=
 =?utf-8?B?S21jN0ozdUFpVFdNcnZnVEVZcUxPc01UMUo1anpDVm5XWk5WUU1PRDBpUkJ1?=
 =?utf-8?B?VCtEcjc0akoydnZpM0k2azVtL0ZWV0dHK2diZXFJZ2VGRWxuTG42cllYQXA0?=
 =?utf-8?B?QnRwR3JYVUVaVElBY0VWZGN1Q0RNMk1DZlVWQ1NUMldsTVRROTc1TzBuL1J2?=
 =?utf-8?B?ZUF5UWFSeTZqcDhTbm5ON1JDdTNsRTVIWm9GU2t1Mndlc000NFZIZExNQ0Nq?=
 =?utf-8?B?SytaSVpleUVkbUtVT0xLYjRIM0FYK003TlVrOHhiMFpRdXk2d3RCTzh1cFlU?=
 =?utf-8?B?N3hTekJLMldQa05jUXNMcHpxczA1UlBHdWV1YWRUK0NIc0doaUMwanVESnpj?=
 =?utf-8?B?b1JLdXltMUd3RjQ4K0tSMlBUeldjWGpTMjZTZERWL2d4WVR5aVhxY1RBTzFI?=
 =?utf-8?B?SzV5S3dqU3BBYkdQN2xGS0VwVWE3Z0RxMnpVeW1Db3VvSnc3dzc0bWxGU3Ji?=
 =?utf-8?B?Y0ZVeGdxME1DL0ZheWowSDYybTZwb0FIVkM1YVdlTW9Ja0lrcDkzWjFhTUc4?=
 =?utf-8?B?R29HQUVrSnk1ZEZDZXd0VzNtbDc4aVB6Nk9sMGQwWmdjcDV0U2JSaWZQd3ZK?=
 =?utf-8?B?a1ZKcmd0Ukh3elJSa0VUMFVDYlJ3YVNtS2RsN0RuMURnVFNHa1dNbW54aUlF?=
 =?utf-8?B?MVF0dXBzdDNqelRxbUZEdFVCZDlwU0VGbDE5ejZOOVRPdC9xU0lkT2lxNWNy?=
 =?utf-8?B?cFg3aDQ1TlJKVFNiTEFCQWxPZTN2R1Z0SUt3dXNmbHlScHl3Zkg4bThCTTFT?=
 =?utf-8?B?M0tOWklxbldqWFJtakx6U1lYZDdqSUdtb1JnOUh0TVdic0U0QXNkbUYxVVdE?=
 =?utf-8?B?VDdKc0t6bUJ3QTlvU1BSdEhrcGJoWGpXeks5L3IvcVMrZDAxbng5cVh5S0JT?=
 =?utf-8?B?b2VzbWZNMGp0MDFva3dNSVNSUW5jS0JEemZPOEsvOEg2NGdpbjhSTC82S2R5?=
 =?utf-8?B?b1h4YVltVTNmaitackJ0NWFlVTBrYUpGcWNtTkRXWDRvdkpFck52SXAyTWl3?=
 =?utf-8?B?WGpnYTFrZlEveHN3WHBmSkR2NHBKeldmNWFFTGxMSExNOVZ2OFdWTmlyQUZm?=
 =?utf-8?B?N0Y2eG5jMnJHcnhCLzhvVGhXVUtqQ3cwUzZBUmx1ZTJvdHB0cWVyZmFOb1Fr?=
 =?utf-8?B?REdJR29Md2hxRUo0UTNWaWtmS3poMUNZMnJqU3c1NUZEOEVsL0trdVRRdFlP?=
 =?utf-8?B?eHhFalVNVEt4cE51d3dXQUsvUEtjcGdHb1FGU0s1TlZLanBsWkFScFBHZm5H?=
 =?utf-8?B?SnppQm1jbzNPTnVYaldSNGlmRjlJQ29Hd0gwQnhxZWRXeVhaVThZUmRJODhR?=
 =?utf-8?B?UUtJSHlmeDlkck1EY29ZME1aY29GaFlETVhnbVNwVjlUR1hvR1JlQ1hHcVVj?=
 =?utf-8?B?cmFHbE8wbTkvZCttUjhEeHVSeUVrVlBKeWdRKzJRbzhrazBtM3AxMWRCc0ps?=
 =?utf-8?B?ajJKOVQ1d1ZsbkNvczFUM3ZEMmdJd1RLaHZ0VDlqTDFmQjFMeU5jenBzM3RH?=
 =?utf-8?B?NjFXa2NLV051NFFIU3F3cVYvT0E4cnlQdC9Ibmk3Y2lMQlFtaGVtWlJ0TjRt?=
 =?utf-8?B?SHpuOGx6dmFoa1BYVDJUTzlUK2IrcDRXMm9FY040TVUrbVJqaDA1dlhkZkNM?=
 =?utf-8?B?OEZXTXlLaTRYZDlLNDY0ZS92R0RRM2JFQmZGb2FVejF2dnhQMDlEQVJNcmcr?=
 =?utf-8?B?aDFLeXhjSFZCbHJLZnZ3ZzF3NFRsNjYwZVZrSlk4ZWhta3dvdmQzOVpBUHlm?=
 =?utf-8?B?aDU2VGZzQWliMkhaK05SVC9pZkNqeGlEWmNyVkJMek1VNSs3bDBBWFo3dTQ5?=
 =?utf-8?B?UU5KNFNKNUtYL3RqNnZLZzdBeTgzZ2JjeDM1MGszcStnZ3lNVU4wN0RiOVR0?=
 =?utf-8?B?ZXdRUUpRRVVTNlNUZXp6L0FDRmUzTHorbE9CeGUrSnVDWk5HT01Zb0ZhQU1o?=
 =?utf-8?B?QysyVmFHL1RmMkNhZzBSWnR2WUNmRFJLOGFpS1VHbFVNeU1oWTk0OGk5UE5n?=
 =?utf-8?B?M2VtdFRTOGxIMlg3MngrT1N4YUpxeEgvWVdwNVlvaE1Ma29vQ2tlSkxjMHJR?=
 =?utf-8?B?V0pFTXpvb1dWcVBvWXBXK0c5c0JyUVMyMXBMcHNzNVdCcFYyRWl3NXhsNU5s?=
 =?utf-8?B?N2llc0d6eCs1MVlNVFRYOXN1bFJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6232E6BEEED67F418B9999C21C738A4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04dcca5-129d-46cb-5b77-08d9f867712a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 14:02:21.2932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtwXfPc10MTxTkBtCthNGvD0EWhR9/vgpw1M9PyCGDlDIjYpUFKRWQBlvv4UtnAM/5HNodNBzBNBlWft/3yQMZ0yVx2P9ucXU8NCdLDZvf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1298
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMy8yMiAxNTo0MywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEcm9wIHRoZSBnZW5lcmljIHNwaV9ub3IgcHJlZml4
IGZvciBhbGwgdGhlIHhpbGlueCBmdW5jdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNo
YWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiBSZXZpZXdlZC1ieTogUHJhdHl1c2ggWWFk
YXYgPHAueWFkYXZAdGkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IveGlsaW54
LmMgfCAzMCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL210ZC9zcGktbm9yL3hpbGlueC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci94aWxpbngu
Yw0KPiBpbmRleCAwNWM3ZmU4NDNhN2QuLmZmZDU1NzlkNDVjYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9tdGQvc3BpLW5vci94aWxpbnguYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3hp
bGlueC5jDQo+IEBAIC04LDkgKzgsOSBAQA0KPiANCj4gICNpbmNsdWRlICJjb3JlLmgiDQo+IA0K
PiAtI2RlZmluZSBTUElOT1JfT1BfWFNFICAgICAgICAgIDB4NTAgICAgLyogU2VjdG9yIGVyYXNl
ICovDQo+IC0jZGVmaW5lIFNQSU5PUl9PUF9YUFAgICAgICAgICAgMHg4MiAgICAvKiBQYWdlIHBy
b2dyYW0gKi8NCj4gLSNkZWZpbmUgU1BJTk9SX09QX1hSRFNSICAgICAgICAgICAgICAgIDB4ZDcg
ICAgLyogUmVhZCBzdGF0dXMgcmVnaXN0ZXIgKi8NCj4gKyNkZWZpbmUgWElMSU5YX09QX1NFICAg
ICAgICAgICAweDUwICAgIC8qIFNlY3RvciBlcmFzZSAqLw0KDQpYSUxJTlhfTk9SX09QX1NFPw0K
