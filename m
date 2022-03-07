Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B04CF271
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiCGHNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiCGHNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:13:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D0560A90
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646637143; x=1678173143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3P+wI4fc8qal7pO1VcRlGIIcSBtxgYJ6lMrmqKRoQMY=;
  b=fCdlzWCcC6Gt0SvhhRLNz8jenV41ndJtZdjhvmiVvOVBIvTaZsz+daIk
   oBh9RVc/nsmPgcVK381tnXFJJTglgkpK56U5Iqog9yWc7jLYWlUaFDLLp
   32XfrIBomFEyk/EztzkYq+jg/NflFgUutI0j3ieiduf8D/hoFk2Chmety
   0pXU7I3LNVwwydpzyUMFWDYabg0SyeISRVETS0079F8UR4hJsyXqVCcsH
   WFj6/ALVqw86/KvpqeCz+e7wY0nujTE4pJVlLuX/+mSXIX/XKA70m0Hdf
   UoSAFtmdGqACrN0Uv0r5x3o28bHAys/pwTxN+5yRnHCuN+KXVDVdO8f7c
   A==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643698800"; 
   d="scan'208";a="148291603"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 00:12:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 00:12:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 00:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/U+YktXu7sNhDHAnrcGXfw9h351lbA+WpDjzBPoj2SpWF9I4NwB7tXBRj0FRttptE1LuCKbFEXOgZvPhhOM22Nvyy5BEyy1mmPXNfo1652gUAN55EagvzkK2UZyLuihFiYdCJ/1PzhUApHm4i5wMw9K3hO9gzwfa2psxa7fNZ5Sn4dfR5vBIWdjT3+eTGVS3niB1CfqGai5bv4LWJHyki6bwityJQ5LLi8GkSlfiPI/CRHNzoSqFhwZOxS6l2XiNWY2Lb9AOmZlex4nHHpJvayOZ1nx0s+X3/hBKwib13TAC+MUfK2YLwBRRHf96aXkxVdbcsaRMzsmhbYgjHRy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P+wI4fc8qal7pO1VcRlGIIcSBtxgYJ6lMrmqKRoQMY=;
 b=CcKcvi9SaNsfW0tRxSg8HUL+J+NQ/T5Jm76Ty1YNm8l418DnBv8wJKuO9JISB5DnkXBpl6rnpimldo4zSC7qJnx3yKpGvRKIT/iZ1Uis3ex6h7jKDBjC1SXAka1JTTU0x7EAmj/UUGWoaZyn5D5laljjbUUjOLHAUGkfeiYg2RnTHmMK41qcBvWOzYir3J64huU1XWz8pHPSwY2xbJYT9gz5Ei6CMNbSGcTHKOWLcKEIbh7dOaYwZeRM4oR2WT/x2Y2sLHw4m+ZvlU6UpNtiBIs+3fcacgbl4XxSHkJ48uHV/5CJpHhGArOQVVoRb/E/yHDqoSpIsc6UTD9xjgyXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P+wI4fc8qal7pO1VcRlGIIcSBtxgYJ6lMrmqKRoQMY=;
 b=V0cyri/pSsG5lD+CgPPseIY3aDfAMknxVtIpe+DCN3+YoL2FnKd+CeedCoSKASILVu7Uw3uK4IdsikVZuWWCgNq19XN+j0c2N01eKpgOzms13C+eK9KE+KEJMvQq2G8CB/M1HU8+RAhxdSW6VyxBeyhIc2I38I0mLrAA2uvWWLg=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CH2PR11MB4311.namprd11.prod.outlook.com (2603:10b6:610:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 07:12:15 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 07:12:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <heiko.thiery@gmail.com>
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Topic: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Index: AQHYMfKsE2aD0LVQO0KmbZoSG1RT0g==
Date:   Mon, 7 Mar 2022 07:12:15 +0000
Message-ID: <7f339d0c-5ca9-261c-a545-d4ebf3bda140@microchip.com>
References: <20220304185137.3376011-1-michael@walle.cc>
In-Reply-To: <20220304185137.3376011-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 683f177c-5a03-44e1-a86e-08da0009ced7
x-ms-traffictypediagnostic: CH2PR11MB4311:EE_
x-microsoft-antispam-prvs: <CH2PR11MB43114D5079F2F22C2E6354C3F0089@CH2PR11MB4311.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6aPKxVZSSoPj1T0IgxD6CsyxD3DckiAQla2aaJNnwzhXFw3VIAPJc/yTJ1JbX+5rZ+TDXn2pBzyOyGJ+lStXk8SgB137fcGJwcjdNjE6norKFXL8uGoNBf/vbsKelJMDSKYOITj3LKAQTWs3mQEXHTQTMz0iPZlg/MB9bA5NzgxhVHlTG9eduqCBg2BRyF/tf6F/6DaSdT0ognAlDT1kwCrDZqMdoOR6tVZmweaYUe0sCY1ZZpa6CTmMAh4vDIzwg3KpcTKfdMA9Dk90PTNgzGV5mcqIMor6wJWminMUXdghjVwOt5FG4EeVDloVORUyvj6yYigzKNPhSTPqAUYinkG0iZxQ+PVlkE7830OWaee+Gy3brZZjGfYsvzF5k3VyW2BWDNCxyua9pHIlRyquoE2GpzHosfoTOHHuqkgQz5BOI6+jaM9y61g+5qZPo/lCcCiXagB1P5Dtuh4V7Ug/IPrui3jCJnCR3lmZKWNJhZF39b/SNq3Q05UPIG+omF/0Rsv1yI6VIpicmIORjuHmXVRFuIQ2Pg5yIlQBs3wGqdZsJSn9653DgoosK6gSQt2Qc3oVyP1io2XBs57Hu4wcO6IhnpakuaHv91VoijvJpjU3jyiYrffXbjNUPgvAP+q3BYYn4Y84kH7uIFq4S3mxRH2FqP8ihyUEMhBfIGNIZHNxtDP4JSDFzqsU7ZAAaXcGHclMwsFpNxCvFgfsLiswoacV6eHQajXAg9ILNZxUJv+vJbG32jIe7KpRfrHJ6oRgmvkGuJgN9a633t5SefN6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(54906003)(38070700005)(110136005)(31686004)(66946007)(2906002)(26005)(316002)(122000001)(6506007)(6512007)(53546011)(71200400001)(38100700002)(8936002)(6486002)(2616005)(83380400001)(86362001)(36756003)(4326008)(8676002)(66556008)(508600001)(64756008)(66446008)(5660300002)(76116006)(66476007)(31696002)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjRKbWxEdFJiakxvZjRta1EvK0JpSXFOckNNb1ZhY09JK2RHaHh5Q0duazBx?=
 =?utf-8?B?bmQ5akFuWThPUlNuRkV1KzliNWg4WVRJYU1jeGlOSWVFYlY1UmE1U3owaExF?=
 =?utf-8?B?czR1YTBHM1E2OUNkY0tuSGlLRll6T2xWdEdyVGZzSWN5dHQyZ25UcUE2cG9w?=
 =?utf-8?B?YjMyVHZaVWNObVFXMEZVbWFmTi8yeTVkU0hhbnFHRGQ0aDk2RnB6aGxqOWd3?=
 =?utf-8?B?R2VrdWRBUlF1ZlpTQ29pYWJLRXhHVXBrT29NY3FlN2djQkNDK1llVG1lVUkz?=
 =?utf-8?B?Z25Bc1VYN1I3VFVMdjROOXAzbDNKU0VBM1A3MVlvcWdYTUxZc01Zcm15THVX?=
 =?utf-8?B?dkN6eW1scTJ4eG1sZG9Hd1NiNVF4NklxeFBNNzFWM2s1aFNrQ1NXTVlIdEFR?=
 =?utf-8?B?YkVmNDRkZUY5Q1NmTElUazRaRytTYnJXK1hFVnBvZnIxK1F0RXczSUFXZmNE?=
 =?utf-8?B?ODc0L2taZ0hoc1h0RklVblZSRldKMXNrN3dlMXlZQzhJMjR0TFBaaUw1c3ZG?=
 =?utf-8?B?NlRkd0pRdjlXSGxtWGZXUm10cmRmeUczZkZIdlVWQlB1TG94NCtsMmNNZUg0?=
 =?utf-8?B?Z3NGbFA1WmE0T0FicWFrQlRjbTVlV1drWEtuSDlVek1QRkdXbDRaeGhyZmsz?=
 =?utf-8?B?b2pUczhUbWNLR1hqOUg4S3I0TVRlWjZldG9jdnV5N3psUWpUOThqaVkvYzZJ?=
 =?utf-8?B?eUpVcWtiTmJUdCtHejZoeGw2TDYvZDJQdVJxMS9OMEtESFdUNDhQcGh6VG42?=
 =?utf-8?B?S2RrS1VGVm1rb1pSQk5SUnpmSnV4VFNWejRJWVlNZG1EcHBqa3cvd3FrR3Rt?=
 =?utf-8?B?NE5QTFg5WERITGUzUnVaVTE1TkFheThRNFpnZGkyRitrODM3UFB0SVFtN2dn?=
 =?utf-8?B?ZlVBNEVydzNhRGlteHo3U2dGTndQMENVTGlDc0V6NmQ0L3dKazVYT0JvMWFE?=
 =?utf-8?B?K3JsbFlmZTBtRGtNTnJlQkx0RTNySFJKZy9YTHlzS21oNjlPem9GS2F0NFA1?=
 =?utf-8?B?djM1MTJ1NmhWQVlPejZOUElWM3NkYy82UVR0OEhZSGtheDlKaVlnbnlFYmw3?=
 =?utf-8?B?cDljOWhiVVhHTTFIczEycXltREJxb2V6MkZWT1Z2UUMwU3V4R21qT2xtd3l6?=
 =?utf-8?B?cHlpYisrMUZvczRNMkxOY1QyRzF5T1NIcTcxM2FleHFVSGlydllNaEIxdzFu?=
 =?utf-8?B?S2pIc1o2MFdyNXJVdjg2MFlub2QzUjcrZ0hvVkpEd2VkVFNxSkdwSHpZYlph?=
 =?utf-8?B?OEM1U0tOVFFpdkJGRkRmYi9kK3BXeGV2dnF0d3BMNldSQldrckg3MzNjdkJ2?=
 =?utf-8?B?Zm5nWC90Zy9sdkl1QkQyYmlMK1BpbFgxSC8weXBKZVEwRSswVDVONnQ4elRz?=
 =?utf-8?B?ZTBMcm1CalRvd2lwbUFabFhVZG5DKzVSamNPYVpyVTVraXNaRU02K0RPemg5?=
 =?utf-8?B?cnBRL3FrR3pWU28zdjBHbzBQS0V0THVUU3lMcnM2UGE2V25YVmdNYjJydk1j?=
 =?utf-8?B?a2JoTk9FWmVWSUtZRlB4RmZLeGpHNkhUbkI3QmZxYTJvalpoeGN1Q2ROUnVQ?=
 =?utf-8?B?VXhVU2RISnVjekJXLzlSRXVWT0NDWVI0bGpvbkhkLy9mVnFyblRHditMdlQ3?=
 =?utf-8?B?VGhNUEZvN1d2RjFvNTBtSXN2dEZmMEh2M3JZaWpPZEN6SXVacEtiNHoycEtR?=
 =?utf-8?B?YlJyNE1GUEp3R0FQdm9aUEpBNzhhSjlTQ0I5NlFBV01Ya1ZEWnZDSXBtTytY?=
 =?utf-8?B?WkhDb1RFYnF3eVRJMmdibGhUU3FaMnp1YVdCMDZpaEEwOHJNcUIxS3hqRkV6?=
 =?utf-8?B?bUlRN1BNblFUK0RHL0FMQzFqbUx0ZGQzSUJueGtqY3FsOVlobUJmKzI0aVVl?=
 =?utf-8?B?SDlYOVJLV3BWdXNQelh0MmJUbmF1MHhwRFVtTHUwRkZzd3dyeFQrK3EwRlU5?=
 =?utf-8?B?TEdocUcvYW04YkpjS1BObk41M1JOY1V3dGRUakJ2Z0lXVWt2dkloSy9vRkxV?=
 =?utf-8?B?M25RendRY094YkhCQ0dwQjk5aGt3MGJ5Zm42dEdrYlVOVjQ3NWZaRExwN1ZR?=
 =?utf-8?B?amRQTmhGakpPSHBSdHlhNlJ6Y1h0T1BjakFoRlFiZFpHT0RQWmFNK3NNOENH?=
 =?utf-8?B?TlJVUUF3YmxmTDltNC9lVFVNaUN3U1NkY3FzdGtyT2FJVDQ5VndReVBETXF4?=
 =?utf-8?B?WWgrMGszK0pKbTN2c0daNlpvMkZuZThXUytBNXVtQklSY0w1Rm1KRlVEamFZ?=
 =?utf-8?B?STBZekIyTThwelRkYlJnSFdUYnBnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CF5A2BEE4543E48BA2A1B89AD196551@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683f177c-5a03-44e1-a86e-08da0009ced7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 07:12:15.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghnm+t7VVVY0oUUip7St4FAatPRxVQ2vhlrOvfVMA6dPDkWJVkloESK3/HMc1AeuMMufYFrRaVLR/eeeOibl0P7DOoU8wlIJgKcBweb2d5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4311
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy80LzIyIDIwOjUxLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFdoaWxlIHRoZSBmaXJzdCB2ZXJzaW9uIG9mIEpFU0Qy
MTYgc3BlY2lmeSB0aGUgb3Bjb2RlIGZvciA0IGJpdCBJL08NCj4gYWNjZXNzZXMsIGl0IGxhY2tz
IGluZm9ybWF0aW9uIG9uIGhvdyB0byBhY3R1YWxseSBlbmFibGUgdGhpcyBtb2RlLg0KPiANCj4g
Rm9yIG5vdywgdGhlIG9uZSBzZXQgaW4gc3BpX25vcl9pbml0X2RlZmF1bHRfcGFyYW1zKCkgd2ls
bCBiZSB1c2VkLg0KPiBCdXQgdGhpcyBvbmUgaXMgbGlrZWx5IHdyb25nIGZvciBzb21lIGZsYXNo
ZXMsIGluIHBhcnRpY3VsYXIgdGhlDQo+IE1hY3Jvbml4IE1YMjVMMTI4MzVGLiBUaHVzIHdlIG5l
ZWQgdG8gY2xlYXIgdGhlIGVuYWJsZSBtZXRob2Qgd2hlbg0KPiBwYXJzaW5nIHRoZSBTRkRQLiBG
bGFzaGVzIHdpdGggc3VjaCBhbiBTRkRQIHJldmlzaW9uIHdpbGwgaGF2ZSB0byB1c2UgYQ0KPiBm
bGFzaCAoYW5kIFNGRFAgcmV2aXNpb24pIHNwZWNpZmljIGZpeHVwLg0KPiANCj4gVGhpcyBtaWdo
dCBicmVhayBxdWFkIEkvTyBmb3Igc29tZSBmbGFzaGVzIHdoaWNoIHJlbGllZCBvbiB0aGUNCj4g
c3BpX25vcl9zcjJfYml0MV9xdWFkX2VuYWJsZSgpIHRoYXQgd2FzIGZvcm1lcmx5IHNldC4gSWYg
eW91ciBiaXNlY3QNCj4gdHVybnMgdXAgdGhpcyBjb21taXQsIHlvdSdsbCBwcm9iYWJseSBoYXZl
IHRvIHNldCB0aGUgcHJvcGVyDQo+IHF1YWRfZW5hYmxlIG1ldGhvZCBpbiBhIHBvc3RfYmZwdCgp
IGZpeHVwIGZvciB5b3VyIGZsYXNoLg0KPiANCg0KUmlnaHQsIEkgbWVhbnQgYWRkaW5nIGEgcGFy
YWdyYXBoIHN1Y2ggYXMgdGhlIG9uZSBmcm9tIGFib3ZlLg0KDQo+IFNpZ25lZC1vZmYtYnk6IE1p
Y2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IFRlc3RlZC1ieTogSGVpa28gVGhpZXJ5
IDxoZWlrby50aGllcnlAZ21haWwuY29tPg0KPiAtLS0NCj4gY2hhbmdlcyBzaW5jZSBSRkM6DQo+
ICAtIHJld29yZGVkIGNvbW1pdCBtZXNzYWdlDQo+ICAtIGFkZGVkIGNvbW1lbnQgYWJvdXQgcG9z
dF9iZnB0IGhvb2sNCj4gDQo+IFR1ZG9yLCBJJ20gbm90IHN1cmUgd2hhdCB5b3UgbWVhbnQgd2l0
aA0KPiAgIE1heWJlIHlvdSBjYW4gdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgZXhwbGFp
biB3aHkgd291bGQgc29tZQ0KPiAgIGZsYXNoZXMgZmFpbCB0byBlbmFibGUgcXVhZCBtb2RlLCBz
aW1pbGFyIHRvIHdoYXQgSSBkaWQuDQo+IA0KPiBJdCBkb2Vzbid0IHdvcmsgYmVjYXVzZSB0aGUg
d3JvbmcgbWV0aG9kIGlzIGNob3Nlbj8gOykNCj4gDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3Nm
ZHAuYyB8IDExICsrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
c2ZkcC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4gaW5kZXggYTUyMTE1NDNkMzBk
Li42YmJhOWI2MDE4NDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5j
DQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+IEBAIC01NDksNiArNTQ5LDE2
IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9wYXJzZV9iZnB0KHN0cnVjdCBzcGlfbm9yICpub3IsDQo+
ICAgICAgICAgbWFwLT51bmlmb3JtX2VyYXNlX3R5cGUgPSBtYXAtPnVuaWZvcm1fcmVnaW9uLm9m
ZnNldCAmDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTk9SX0VSQVNFX1RZ
UEVfTUFTSzsNCj4gDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBUaGUgZmlyc3QgSkVTRDIx
NiByZXZpc2lvbiBkb2Vzbid0IHNwZWNpZnkgYSBtZXRob2QgdG8gZW5hYmxlDQo+ICsgICAgICAg
ICogcXVhZCBtb2RlLiBzcGlfbm9yX2luaXRfZGVmYXVsdF9wYXJhbXMoKSB3aWxsIHNldCBhIGxl
Z2FjeQ0KPiArICAgICAgICAqIGRlZmF1bHQgbWV0aG9kIHRvIGVuYWJsZSBxdWFkIG1vZGUuIFdl
IGhhdmUgdG8gZGlzYWJsZSBpdA0KPiArICAgICAgICAqIGFnYWluLg0KPiArICAgICAgICAqIEZs
YXNoZXMgd2l0aCB0aGlzIEpFU0QyMTYgcmV2aXNpb24gbmVlZCB0byBzZXQgdGhlIHF1YWRfZW5h
YmxlDQo+ICsgICAgICAgICogbWV0aG9kIGluIHRoZWlyIHBvc3RfYmZwdCgpIGZpeHVwIGlmIHRo
ZXkgd2FudCB0byB1c2UgcXVhZCBJL08uDQo+ICsgICAgICAgICovDQoNCkdyZWF0LiBMb29rcyBn
b29kIHRvIG1lLiBJJ2xsIGNoYW5nZSB0aGUgc3ViamVjdCB0byAibXRkOiBzcGktbm9yOiBzZmRw
OiINCndoZW4gYXBwbHlpbmcuDQoNCkNoZWVycywNCnRhDQo+ICsgICAgICAgcGFyYW1zLT5xdWFk
X2VuYWJsZSA9IE5VTEw7DQo+ICsNCj4gICAgICAgICAvKiBTdG9wIGhlcmUgaWYgbm90IEpFU0Qy
MTYgcmV2IEEgb3IgbGF0ZXIuICovDQo+ICAgICAgICAgaWYgKGJmcHRfaGVhZGVyLT5sZW5ndGgg
PT0gQkZQVF9EV09SRF9NQVhfSkVTRDIxNikNCj4gICAgICAgICAgICAgICAgIHJldHVybiBzcGlf
bm9yX3Bvc3RfYmZwdF9maXh1cHMobm9yLCBiZnB0X2hlYWRlciwgJmJmcHQpOw0KPiBAQCAtNTYy
LDcgKzU3Miw2IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9wYXJzZV9iZnB0KHN0cnVjdCBzcGlfbm9y
ICpub3IsDQo+ICAgICAgICAgLyogUXVhZCBFbmFibGUgUmVxdWlyZW1lbnRzLiAqLw0KPiAgICAg
ICAgIHN3aXRjaCAoYmZwdC5kd29yZHNbQkZQVF9EV09SRCgxNSldICYgQkZQVF9EV09SRDE1X1FF
Ul9NQVNLKSB7DQo+ICAgICAgICAgY2FzZSBCRlBUX0RXT1JEMTVfUUVSX05PTkU6DQo+IC0gICAg
ICAgICAgICAgICBwYXJhbXMtPnF1YWRfZW5hYmxlID0gTlVMTDsNCj4gICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiANCj4gICAgICAgICBjYXNlIEJGUFRfRFdPUkQxNV9RRVJfU1IyX0JJVDFfQlVH
R1k6DQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
