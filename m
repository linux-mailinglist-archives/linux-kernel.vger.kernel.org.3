Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C335098E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385673AbiDUHVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385667AbiDUHVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:21:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04941165BE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650525504; x=1682061504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5VjWDhOEWWTy16cnEQOydQtNxfPjeg6JQr0GkAfQ+Js=;
  b=aeZSZg5Nv/DHpWe+tfWPc1ATFN4o0Zso2HkGyvfGQqMW8biejNIUZFIK
   mCPaU/POd3I/KlNwYbLxL6PBPqFu/olF8Ktt3bVw4PnW2OnDKkY4CX6y6
   E/M8dIVUbzSYYSi9KKk1PJXLqkVtyamGvgKqJloxZCoLpGs5IYB9GSpzu
   SogZmZDFNFwIiO3uxcz5/qEVPZX1AGMQJklKAQUiNByfacWePKeTkiFJf
   lsgyTA7shN3wV0fvDvugw6lkSZEMAqK2KswRt3OaKF3m3iy2o/5gT9qNd
   ti5Hp+s06gCPlNyrW5OSiZAV4gzTvofdOXsg2xRDae+JdkY5w3HIllMfi
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643698800"; 
   d="scan'208";a="170386539"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2022 00:18:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Apr 2022 00:18:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 21 Apr 2022 00:18:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGhYN6fGDziddUdWWE2fcEqzN5bniYCiXl5c+/10HIFIRClMkwVqlVMdkqkIoarf9nqpoKdcAUNI/oyy3x7PxoMHi49DBfZpaMWy2M0lrdr1OKXLWx+aNDFVMkaa66+1OUA5Gk7O6kgagFiAVqLrGkQITuMKhQ4hhMBxykL+ne6Qh2NVW2qWRFYBGl17leCX7/6U/SYOzCwjX6XzIZxNynGe/Opd4BGGumWh1s2vpDvDLa98dg3Z5Xj7ytz722fvsIr5o+btfdZtn7Sa+744Sf4m+iNWEcqnwq3pbsyaWeaSJcN81xiNK4TTqkc1EHhPNFQONd8cUk0Dn6cqsFEhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VjWDhOEWWTy16cnEQOydQtNxfPjeg6JQr0GkAfQ+Js=;
 b=BJkxkudzdbL92rNQOoMnB93wWlQaAwBybvs+WciLaSU2mi2sQCljcf+mQnHA4Drbpv+p9KlNSRaO39SCphLoyuHrI31QeUepK+oOqYLRWRu+acFekzFHZXU7vbemHd/f4+8OVt6UAkw6jEJmztssBTKfOjieow7jWWYnCtCeDTv0JpdXbG+xJ6hYkj6ZRzYHEo23ur8Br76cp5aqQM+pQO7/QdgAVPPJHJUcXbOcsFCBdiz28dgWE2DMCz/y59jRtxz2vRFoKxMwFSBeSotVfbfbp39LiSAlv8JR2W1t0sJCw+de5R4QnE7Va6NNxJ3rCPstg1WB3UaBSodNqX4QQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VjWDhOEWWTy16cnEQOydQtNxfPjeg6JQr0GkAfQ+Js=;
 b=C4hWeojSS0Vm3cG31AXkN4BEQBG8deC1upz9Xp9QjR1/9WaVA/H3B4Mq5LYkUAP5HE0ZzGcVdaceniSLSx0zaYM+yMci6xo7aEus2wefCyxyu1wqpgl/Z15VYoNjTF15N7WagX6IbwL0y1sqWgWX23NeBrhKwr5OpSPxSz1UTQk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 21 Apr
 2022 07:18:21 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00%7]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 07:18:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v4 03/11] mtd: spi-nor: core: Use auto-detection only once
Thread-Topic: [PATCH v4 03/11] mtd: spi-nor: core: Use auto-detection only
 once
Thread-Index: AQHYVU/7/NTsfvb/Zk+xiSXQh0nwdg==
Date:   Thu, 21 Apr 2022 07:18:21 +0000
Message-ID: <7f570c32-d0be-97ba-0a1b-9aca93cfbbf1@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
 <20220420103427.47867-4-tudor.ambarus@microchip.com>
In-Reply-To: <20220420103427.47867-4-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 939743f7-0801-4c75-2de5-08da23671dbf
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_
x-microsoft-antispam-prvs: <BYAPR11MB35585948FB994021B6CDA627F0F49@BYAPR11MB3558.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTr4JRV6kskGNQcov51nIF6ClEgiyTVyC9eZQnqJ73l9NXpRmUbVbjDNn/vDl79fwE6SvZYbkRpnHxEMJ1++C1wI3N396V2mUyDzOTNmcHG7SJIiMMBKvb1ofBTQ4xl3n7VKvM8AR52948uw79oVE7IINaC5wbmwLF6W+8n9IyroUqe/ODpPy6/v97PjojFHroCHLQ0S9HTTA+TMfyDTmOBjBmhmYd6bHIwny9gSYR7srWqaARGrwzJVBncqtC6nDvSkXd/sdDc/vzaW01Ishdzlg9rmDhJmA4yKYvNf6nh5fdKQwGyLTdlxPqI3PfaO6WnRw3gT5vtOqU6uc3nkQWq2CmdHCLocmgfD5LOXiwhEVHY+zSiWtHVEok6JkGMSiXb0kZqbSOvIK8XaR4apDnk94VwGTVV1wgTi5HYhTFzORyRbLfUHWES7Bwg+PPy4SUTXUA/zKHAyzBIP2NF+RhXByZIPdVKknpnWsY099BKzzRgfHGqUWHQrZVZwa67yUfyRtz6GD1XWWJsMcdxLn7x62YlmHyCY82hhAbtSxXOlmdGLSH1Z7cprpKK55xeF4zEyCF5GtCsd4ouIKaBK60OlvMNTM6CSe9ac1LLKGhl6tc8LOfE6BFHPZDMWzvC4byod4GQgK13InJWpT9AgW6PtOvc51ch1jvcJkdk86YaxOl165+z7WXrC/km7AmPB/b/B/TprVhkTk0geiu5sp7ZedUKn0HLO2D5SgAeHtsB5G4U/2oSq5jEC6fy4MokAew1pbyJ3jOJ8a5kZBnkm8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(71200400001)(6486002)(110136005)(86362001)(31696002)(54906003)(8936002)(316002)(2616005)(508600001)(83380400001)(26005)(8676002)(31686004)(66946007)(186003)(76116006)(122000001)(66446008)(6506007)(64756008)(66476007)(66556008)(91956017)(4326008)(53546011)(38070700005)(6512007)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmhpVlMwSWJURjZsV2lEVEhJb0c3STJGajd0ZThzMFR4VXp0Y0U2L1FXa3lY?=
 =?utf-8?B?RDV1T0dBL2ZqSkVvMHRkald3WmhGYUdPUlVBSTV5bDYwL3Fia01yS3dlWTJS?=
 =?utf-8?B?TFNYdTRLNnc4MGNTYXorTnRPY3dTTWFzOWtiazdBbnliQ29FNWFScmMweXhG?=
 =?utf-8?B?cjYyaXpoakNwcnRyU2xKandDT3h4SEY5YWlRemp2SlJZWDdjTmZBbldLblZL?=
 =?utf-8?B?S2gycXdoQWY1K2RBOFVvQzNWeFpMcHdwaU5TUDlCSzJjQW5LdUtPQnpTdTh0?=
 =?utf-8?B?aXh6b0dFN0RDbXZEQ3AwTE51UWZzcTVXZEZXcVNnV3J1R2pRcmNJczRncWt5?=
 =?utf-8?B?UTkvTml0UStxbUNNdUJkclVCdVFRWHhtMm9GalRkaXF2alZUc3dUZkw5WTR6?=
 =?utf-8?B?M2pRMThWVEVXcUd1RDhpdmoxVERZUStDL2tBR2VoOEFycmZ0bWdwc0J0WTZz?=
 =?utf-8?B?TWV6dWN5UVEwSE9FQ3ZuTDgrMHhkczc5bGNpZ28wemFmektHSkpOLzZXNVhq?=
 =?utf-8?B?dkNUWEhGWGwxNDhTUnpWOTZyZU5LOEp6UVIzTTU4T2xJQjBjZXZtM2xlQnNw?=
 =?utf-8?B?R2YzMU1pUVVTQW9IKy9jeHVNL2MyT1BFTHBrYnE1ZHBCVDNrY3V6YWRmelJB?=
 =?utf-8?B?eG1hR2RrMVhoY0F1dXlMa01zQjcyQnJocFJmSDI4anpZaWNiem41ZHFIdjV2?=
 =?utf-8?B?eU9COUx0c2tySTJkbld5S0FiTVg5V3ZzVzJuN0RRdHE1WTBjYnZEMmFvQjFr?=
 =?utf-8?B?TE1pVUU3R1RvRENxMUxCODIrMWVBRjh4cC9lV0RwN0lPcmdUY0huZzFvY2Jo?=
 =?utf-8?B?UmxXb0hEak9WMEVxMngrR3lRTmlJMVc2TVh2YTh1aUQ0TGIrZSs3bmlISkIx?=
 =?utf-8?B?RmZsbHJHL0owSmwweGJrMHNXRFEzS2E5L3dNMFVadUwxdHhvVTViMnNVRzlL?=
 =?utf-8?B?VGhRK1hxT1VPb1p6MkhEYS9veDIwTTEwMjBDSk5HbjE4SmpuellaWGRiaE9K?=
 =?utf-8?B?bFdEc09jN1F2Z2FpRDNYVnBoNlpTZVRiVUd1M2FPcnR6YTArYytsVEExU0N5?=
 =?utf-8?B?UE45c3l5MFZXdkJXWkNBS20rY0J2K2I2cTdiaGJLajMzdHhpRjB6cWpDcmtW?=
 =?utf-8?B?eWk3cENZZ2V1dHcwbERmZWxBalY0dnpzdnRGRzVwVEYvVkNjQnQzMXVRNjdK?=
 =?utf-8?B?Wm5EYi9GcVZCd1M0NU9LOEhQRkpJa1BKblNMOWRUZ01BOGZxMzA3Wk4rWENC?=
 =?utf-8?B?cC84dWxPVFJScnJPRFdQUTh1bmpVaFFBT2IyNHlMYzRVcDlMQ1FTU2pFNldO?=
 =?utf-8?B?TzZ1T1E2bUIyYm8vRHR1eDBDNzEyQ1NJNW1RY2YrV3ZaTG9US29EY1IwT0VW?=
 =?utf-8?B?Wmx5VFBzYitRWHhscFcreWw2ZEhaRDU3VGt1WTRkbHNqRzd6amR1TEZTWTY4?=
 =?utf-8?B?ZlR3U0JYT2xEbUdjajlsRlZpc2RadzZ5ZDNvWWpWbFR6bmw2ZkIyT0xtY09o?=
 =?utf-8?B?WkFTNmdBcFJDSDM1aGQ3K0p0WU80ZUVSbGQ3SFFvWFZsZHZRd2d2RS80Nk9I?=
 =?utf-8?B?cUd2Sjl6c3dHWkd2ZUNsYTlLUkpsZDNLSEZJeURoMThndHRROFZWazRiTWJH?=
 =?utf-8?B?bU9IcFVqMTNhN2lvTzBDcGVkOHAxSndSRWwzelp1MTNmbmFCQ1MyR1lKWVl0?=
 =?utf-8?B?Q3l5cTZQRkRmc1R5UXhoYURTbHFBQ1Y4QWpjeitkVHFCNXRqc2djc0xFT0lh?=
 =?utf-8?B?VjJCcW1zbUptMXNWeDZ0WnBaNEttdk1yUlhPeUV1U2lMVkF3bm9OSFRGWkk0?=
 =?utf-8?B?YkJDYXd4blJBWStjUFhXbktEK1ZCOC9KRy8vVGlZY1VlUkF3ZldoTk5HaC9u?=
 =?utf-8?B?WFZFTU84L2ZGLzBWZGswcmdyL2s1bHgwTkpRZ3BSdTJiVG5OTlQ3cS83R2lQ?=
 =?utf-8?B?R3N0QStsVVU0ZFFZbE8rL05hcWZvQkhkbXYzOUJLcExMSGxIMEZsNFhIZlN2?=
 =?utf-8?B?RjBrWUdDbDhWY0U1QlpBUlJSQW1hdmJKd0Nid0N1TUt4TVFTTXRoOWN0QXow?=
 =?utf-8?B?SEJqZGJhM3pSb3JGS1ZRVWhCUThhYmJ4b3V3bDFJZEhSSzJCK201d24zRU5F?=
 =?utf-8?B?UnJkVHZ6WkZ5b3NFZmIvOEVnUXdnb3V5eW84WThCRi9NVk1vbEtyQ2d5dnNh?=
 =?utf-8?B?L3JDVHhPVVA4Y3lZQmd5b1orS3prU1FyV3J0RVE1YnoxaW9RQWNMSmRKZzJG?=
 =?utf-8?B?eUhvYTc2U3JCZitHMFVvWk1JYjdlNWJEOXVzMkZIZzVrQkFPWSt6NDV3bkFX?=
 =?utf-8?B?SkxOQVFhc2N0bEwrTklxOGd5cmZMYjMvSEdLeE5QbnNPc2RFUFNCMWtBZmlG?=
 =?utf-8?Q?t1TWGjFgBM2Kisj4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8245021287A4B94090B1C0DC8B2A3C55@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939743f7-0801-4c75-2de5-08da23671dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 07:18:21.3549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GEjQYACRt6MdyYdpIcLcA9GuNIhDFy1xNo86PuaohHJi3yC8e5g2+PGneJs24wb7wH2hM3Efq0pWZYa31EeoGFk3vHZuNSmcNL9jGx43Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3558
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFByYXR5dXNoLA0KDQpJIGZvcmdvdCB0byByZW1vdmUgZmV3IGNoZWNrcywgd291bGQgeW91
IHBsZWFzZSByZW1vdmUgdGhlbSB3aGVuIGFwcGx5aW5nPw0KU2VlIGJlbG93Lg0KDQpPbiA0LzIw
LzIyIDEzOjM0LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPiBJbiBjYXNlIHNwaV9ub3JfbWF0Y2hf
bmFtZSgpIHJldHVybmVkIE5VTEwsIHRoZSBhdXRvIGRldGVjdGlvbiB3YXMNCj4gaXNzdWVkIHR3
aWNlLiBUaGVyZSdzIG5vIHJlYXNvbiB0byB0cnkgdG8gZGV0ZWN0IHRoZSBzYW1lIGNoaXAgdHdp
Y2UsDQo+IGRvIHRoZSBhdXRvIGRldGVjdGlvbiBvbmx5IG9uY2UuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IFJldmll
d2VkLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiAtLS0NCj4gIGRyaXZl
cnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgMTMgKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+
IGluZGV4IGI5Y2M4YmJmMWY2Mi4uYjU1ZDkyMmQ0NmRkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0K
PiBAQCAtMjg5NiwxMyArMjg5NiwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8g
KnNwaV9ub3JfZ2V0X2ZsYXNoX2luZm8oc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gIHsNCj4gIAlj
b25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyAqaW5mbyA9IE5VTEw7DQo+ICANCj4gLQlpZiAobmFtZSkN
Cj4gKwlpZiAobmFtZSkgew0KPiAgCQlpbmZvID0gc3BpX25vcl9tYXRjaF9uYW1lKG5vciwgbmFt
ZSk7DQo+ICsJCWlmIChJU19FUlIoaW5mbykpDQo+ICsJCQlyZXR1cm4gaW5mbzsNCg0KQXMgTWlj
aGFlbCBzdWdnZXN0ZWQgc3BpX25vcl9tYXRjaF9uYW1lKCkgcmV0dXJucyBOVUxMIG9yIHZhbGlk
IGVudHJ5LCBzbyB0aGlzDQpjaGVjayBpcyBub3QgbmVjZXNzYXJ5LCBsZXQncyByZW1vdmUgdGhl
bS4NCg0KPiArCX0NCj4gIAkvKiBUcnkgdG8gYXV0by1kZXRlY3QgaWYgY2hpcCBuYW1lIHdhc24n
dCBzcGVjaWZpZWQgb3Igbm90IGZvdW5kICovDQo+ICAJaWYgKCFpbmZvKQ0KPiAtCQlpbmZvID0g
c3BpX25vcl9yZWFkX2lkKG5vcik7DQo+IC0JaWYgKElTX0VSUl9PUl9OVUxMKGluZm8pKQ0KPiAt
CQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCj4gKwkJcmV0dXJuIHNwaV9ub3JfcmVhZF9pZChu
b3IpOw0KPiAgDQo+ICAJLyoNCj4gIAkgKiBJZiBjYWxsZXIgaGFzIHNwZWNpZmllZCBuYW1lIG9m
IGZsYXNoIG1vZGVsIHRoYXQgY2FuIG5vcm1hbGx5IGJlDQo+IEBAIC0yOTk0LDcgKzI5OTUsOSBA
QCBpbnQgc3BpX25vcl9zY2FuKHN0cnVjdCBzcGlfbm9yICpub3IsIGNvbnN0IGNoYXIgKm5hbWUs
DQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAgDQo+ICAJaW5mbyA9IHNwaV9ub3JfZ2V0X2ZsYXNo
X2luZm8obm9yLCBuYW1lKTsNCj4gLQlpZiAoSVNfRVJSKGluZm8pKQ0KPiArCWlmICghaW5mbykN
Cj4gKwkJcmV0dXJuIC1FTk9FTlQ7DQoNCmFsc28gYWNjb3JkaW5nIHRvIE1pY2hhZWwsIHRoaXMg
Y2hhbmdlIGlzIG5vdCBuZWVkZWQgYXMgc3BpX25vcl9nZXRfZmxhc2hfaW5mbygpIGNhbid0DQpy
ZXR1cm4gTlVMTC4gSGVyZSB3ZSBjYW4ga2VlcCB0aGUgY29kZSBhcyBpdCB3YXMuIExldCBtZSBr
bm93IGlmIHlvdSB3YW50IG1lIHRvIHJlc3Bpbi4NCg0KPiArCWVsc2UgaWYgKElTX0VSUihpbmZv
KSkNCj4gIAkJcmV0dXJuIFBUUl9FUlIoaW5mbyk7DQo+ICANCj4gIAlub3ItPmluZm8gPSBpbmZv
Ow0KDQo=
