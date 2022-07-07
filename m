Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9775699D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiGGF3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGGF32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:29:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD63831341;
        Wed,  6 Jul 2022 22:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657171764; x=1688707764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y58LxgERGMeGLDWhAhoZ7eVd8Z8f+VlKuGSkqoltVSs=;
  b=Wtc1E8c/WKYHTQMi0Oka868XFkRjt7vL3LbqZx7lCD7QulES79hKjpAI
   JVmIMEXHFOWdZ3gwgmu1eatY1g1Fv7yNkrLNZE87rvWkGWi/70q1palDz
   /ErSdnEW9Ujyea2vgC+Vy/Vu8dlm4EPF1oBgVfko9e1ixEz7zr30q/UQT
   YcMZKN9UNYVAvJ9ZnbVlFlJGhtzxHs7vSzk57sUT2iQWFCrsv4WZA7KpH
   DE2oaj6dEu6JI4ofFPHSLWuowSHEGPVuSdavwOKZKhlWCCSDhVl+Sdjqs
   +cTiqH8vaP4yKXSUEQssYFfkV2jqREHOqhYqOzOpz/h2UDdT5q5YhnvxM
   w==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="181103397"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 22:29:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 22:29:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 6 Jul 2022 22:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a86tdqQqUR6x825y0IWtsNh+cU6FPiND7IQmGKC9cFS7B0TkU8qlYkP6NfPMc0dl+fBcmYUAyXIjbVnSHQKa0dFIhtgQl9ai3yE+qOtgDfLyklQvPAYKMLCbQzo99MTP/tuRL0E1M0M/7yAF/uduEZ9gNGhu8k4VLQozX0yI21NmzmfqMxJd5u37RUytKgNFz8FWNX5dh5jGiAzDbOFRJWGEqfzlsUTjXDu155VPY3JIPB+otMBUqfYzYm116trSNQDdLTEqOo0M6Qy+EZbEIN+UeDLHnKlHoRZqXgSAy770fMJfeBHUcAMp4ICN6acRi360gqsb4fjEO8zIWV45CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y58LxgERGMeGLDWhAhoZ7eVd8Z8f+VlKuGSkqoltVSs=;
 b=YcaRWOreoSBs4+DJ4KrId8lI/ZTlxea6tBJfZS3dtAoROr5bEqxDc/XwEMOKj0fjFghVBIMajSymAMmzotogJ1MoWBwEdz53pfMa4zpnjT9EmKoLUsBRbXqLDp4MfmFX0assXjc3apD8PxKR1L5maMeranUgcD9aPXtb7rCeGveeWBMBd7LjDPw9RsoLwpHakkIhyQjxVjK8pesgy0LaTzrq+7E4AtbAqiT76RMLQF6bZ+8QXdqg0brBwQkjLecOUjVbVLic3PB60/+fTQ/xYBhhK2BCiK6BcyO/azFgVWGFU3sU8CYrdWA7sEb4WhguFCQXYCT1fkXYjEQ89wzxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y58LxgERGMeGLDWhAhoZ7eVd8Z8f+VlKuGSkqoltVSs=;
 b=dWXNeHuHRDpVtmpjL0tgltA9BxQuWuvq6/YlY5VTNgN7cDgTMjWX3l7J79nxv8G2qfKiojwgcCd9AImGkvil6QvlD8lkcLS9UonHa8Mu9og9ALYXKdLLYZyrJ26edpXs4uDGLU1ETj1n77FgCvJa3iBYAbSHTe3MP4lx1erpjus=
Received: from PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18)
 by DM6PR11MB3529.namprd11.prod.outlook.com (2603:10b6:5:63::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 05:29:06 +0000
Received: from PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::1884:3ecf:a6c7:c2cb]) by PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::1884:3ecf:a6c7:c2cb%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 05:29:06 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Topic: [PATCH v7 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Index: AQHYkSiOZg1vfaNbnEm+LtjpZR1JIa1xdhQAgADqqBA=
Date:   Thu, 7 Jul 2022 05:29:06 +0000
Message-ID: <PH0PR11MB487299A211568CC3614682BC92839@PH0PR11MB4872.namprd11.prod.outlook.com>
References: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
 <20220706110619.71729-2-kavyasree.kotagiri@microchip.com>
 <fca15370-f977-687a-ff62-22ae43046b58@linaro.org>
In-Reply-To: <fca15370-f977-687a-ff62-22ae43046b58@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2354b83-18d5-4963-97bb-08da5fd99c5a
x-ms-traffictypediagnostic: DM6PR11MB3529:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhqsLk9veihlbnMJwNkIRXkUACxfn4oWEk/IubJyIMF1zifnVrFw/dE3OkzyevUyP6yON7oBU25xQn9sHZ6ZDCCk0ISwXDv+8QndNQxMx1zmkGHkevIqYm+KQqvRVo7Tg5TDLAJa7l2IyWpEzH1KG/kFiX4Jss55V3TMhLHMfSTXESGnuzYT+CzljlXm8eLuNq2a+g1ilppVIVZMe1x4i3YiUVBEw9dzYRogj8/Uo1IKgr2sSPMrKBRotpunJB3ir02VdAw2/IecmnkRkj4eVYaeL3Tk/2O/1+qFq9at7sie3xulhq2kKj0kBwKUwNJGaWDa/4QJ+12JJkM6QVCHJk8fANpYFg+RNnC8DIScUZHiPLc04eTaRzc1n+nud2y0OMPD6fABFvHAVjCZDRmaekTPJXpLiNJC0Zuct5XFAqk/1jE9NMaFPjQrgtOSFyAD38mam6SNchURC5Z5F2m9/VStzuMCVWNa8QNql/K/Q3WSsHwDVv9hFMejWA3IwUAITZiLh6o+rPIMZE0ax6F2qRk632bd7xvFfhlfEC5yLv6ohx6VTrWTe8o4VCo9zsnB3U3rEzjRb6kVXE86IjnDkOSuCXzO9+srOOWZJuRgRTkWn6Yc61l5+nZrUiBcPaIX66fXe48eCd0CYyavi/zSa0vJRI0zPuj7oU4SpMvv+hs2lit/5mSUn0Il7ad/sKhuFZRDzHjZ1cyhN2Yhw5J+q8UcPnudc/I4Zt2YxvpKW+aELJvWqMUQ6mwU1xsUQr2buz+HClF2w/X5dq6ZVHEpSI+MkSD225qJfU7N4p72PCi6gLBiIsRNCKs2/ASTP3brvwe5wE6wP0TbX+Gsh8LKcE1aizAxN9wfyUXjhngrzNY+KOrEobHZfUe2Y8lQmji7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(83380400001)(5660300002)(316002)(71200400001)(6636002)(478600001)(54906003)(966005)(55016003)(86362001)(110136005)(2906002)(186003)(52536014)(66556008)(26005)(8936002)(8676002)(76116006)(38100700002)(9686003)(4326008)(6506007)(66946007)(66476007)(38070700005)(66446008)(33656002)(64756008)(41300700001)(122000001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDJlRjVhVjVXTjdWRVJtOXBqVDlwck9HbllLOGFVL3RMdWpNQWNjTUJMWm83?=
 =?utf-8?B?aUdEQWpkNW5aZDRrTHBqZEdoNmJtL2pRMFEwUVJtb0hTeVNNRnFrRHc3RWth?=
 =?utf-8?B?cklheC9tQXBFWlRsZ0FyUG9uYk1IVXQ0UXBsWk1yTkI3NjdkbG5lb1dWYjcx?=
 =?utf-8?B?b1M0OFFnWTg5V3pzdVhMTjFBYkhIU2N5bkE3aHRSQVk4OGFybWRzY3VVY0py?=
 =?utf-8?B?RGhYd2VvUjhhc3EwUVd1MjJ5WlZweUQvajAzWEZIQmNGd1RpVmVMQlZtQk1h?=
 =?utf-8?B?dE8xcXorTm5zVTRHUlZpZGc5YjlMU3JNNEcvZnJqeWc5bmNXT2hBNnBOUXht?=
 =?utf-8?B?T2doVjVLbFJsZGtwUjljK0xGQmQxWjY0MnFqWGtFckpaY1ByVmlDbllCYysr?=
 =?utf-8?B?aUdKQmg4YnQyNmVNQ3pTaXJDMmtZUVZCMkNtVEFhVk14djhiem1LV0lDN1BF?=
 =?utf-8?B?WThUb1ExaE5jWU0vb2luNGZPVUNYZkw5NVZsdGczY1hXZWY3K2FUblVpdVVr?=
 =?utf-8?B?TGt2blBIbEtPUStRMGI1QmprcmM5WHUvY09lTUY5ZGNvQ01peHUvbENCbFAx?=
 =?utf-8?B?TXdhUEZHdHpwOUwyMzM2ZS9OTU9xVWx3Y080SVJMWXJ0RUpKZHBmTG53enA5?=
 =?utf-8?B?Ti8vTm41OEFFd1pDeEdta3c1aFUyRWo5NGd3OHlOTWMvQlA5ZEd3VW1KVDVk?=
 =?utf-8?B?UnlncnlQZE9VV1RJaUpKcGFhVVNBOHVrbGdzSUlrQnAwY0NWZDZwcUszSzdr?=
 =?utf-8?B?ajRBL2NCM0xHelcvbHpsMnRDTjBpYjlIbG0zZ1NlWUdBTm93NUJjeEFqd0Fz?=
 =?utf-8?B?Zm5iMFFlVlRIaEFwVk5LOVdoZ0JFaHZKcmRSQ1lFWTU3aEFVMmIwWjNBZEhW?=
 =?utf-8?B?MnIxSUpHWGdGUEtFSnk5cjJsMnJKUXZYM1lMV00yb0Jkd20vV0pvejlXVlYy?=
 =?utf-8?B?ZkUyZTluVDVtNkozVXNZVUhBbFMzMGltdk0zejR1RjQ2Rmlyb0x0YUJScjhT?=
 =?utf-8?B?L3lYVWlTL3dqaGJIRkZ5T05hYktlelc5T0szMHE3V0NjVFBBMDhwdkxIbCs2?=
 =?utf-8?B?ZzU5a3FJRGFYVUZNbGF0RXBRckRBSTk5alZ0bVMxck85UjkxdEZYVDJsRW5Q?=
 =?utf-8?B?cVdlZTExNC94TnhtWDZHUG85Kys4bTJZVkpOMm1RcFV4anJwcXpHcFI5R1hO?=
 =?utf-8?B?dU9kYmgyMnVYWkpMZFI4ZkkxMjQxYm8xRnByVzltb3dyOFVzNXQ2Q3pySXNG?=
 =?utf-8?B?QTJtdzAwNUpXZEg3RWF3RW51TW03eEE3Vm9iR0hxa0hQcG5abGJQRm1FR2kw?=
 =?utf-8?B?UGZYUzF4ai9VYjNXZ2pGcVFCU3pPejM5WjVZMkpCVkM4dUxJRUp1d2R2VzUz?=
 =?utf-8?B?S1htSU0va1RDSmlIVk9MOTZGV0NCUVFDNFNsUzV1bmJjTWdVSzVFOXdvNnNl?=
 =?utf-8?B?T2pNWktSeWhYNnRvWWVtb24rc2JZaGQwaEZvTFkranpPSG5yQW5od3ZRWXB4?=
 =?utf-8?B?SWZ4Wk01ZVhoWi9QemF2MDAvcVRpZFVUa0doR2VLM3JxSjJrVlhqaDhoNDRC?=
 =?utf-8?B?c3ZPdG92SWtHWnpRMlZ5Z2svc0FmQi9DWDVKb2pUNTk4TEgzUlVRZUw1cy83?=
 =?utf-8?B?SDhlRllTRlJxVXFIQi9MUXYrclpyak9KdHRSZkthRFJqd296NmJWK1ZCcnl2?=
 =?utf-8?B?eTl0d0UvTy9MSThnR1NuRW9DYWRyUGZoUFBmSFBqckEydUVyR1RiZXZpZUFO?=
 =?utf-8?B?YTRCa0ZSR0xIdzErK295RTk3WmNPN25nbTlZMGx3SlJDQ2RHakVMUnkxVkRM?=
 =?utf-8?B?K29YdWxudzJrZWF0OUVYc1BBTWdwbWJiRXRhTlNMa0g3cDhMRS8yclhzSTlB?=
 =?utf-8?B?MWVlUnd2eHFrT3d0SmdEMGZWZlY5TUtGQ0phZXIxN0JtUkVrZmp5N1R4TGRF?=
 =?utf-8?B?UHp1TDZFam1wRDA2cjNTajRpRXl6Y3NodnM2cHNTUlFGQ09QcjE3UHlKT1pB?=
 =?utf-8?B?TnlBRk8weDh3NmFBc3MwQ0lBcEJRVVFiQWJWbEh4cnE3cUdNNDJwaVd5aEVD?=
 =?utf-8?B?eDY4ZmM3YmNEVURrYWJGWjlETlVpZVo0b3JCSmljUnVKQ2FUOXVYbk9SaG5M?=
 =?utf-8?B?cStDRlltWmV2cmF4UmtVRzFuakVaSUI3SEwzRGFCc0FqUnprRU4zY2RBb21t?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2354b83-18d5-4963-97bb-08da5fd99c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 05:29:06.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jaanNI3MNwzaOcu+DvSsADrh8tovQEeGwHwR3dwk52REpKG1HU+76IGIH9lsnpJwk07hug+KSEu6GXOc2j5jBcAerJa1kCRuZc0kkVT7oh70/xXQn+Hoqu/rmTP8LLNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3529
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IENvbnZlcnQgdGhlIEF0bWVsIGZsZXhjb20gZGV2aWNlIHRyZWUgYmluZGluZ3MgdG8ganNv
biBzY2hlbWEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYXZ5YXNyZWUgS290YWdpcmkgPGth
dnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+IHY2IC0+IHY3Og0K
PiA+ICAtIENoYW5nZSBmaWxlbmFtZSB0byBhdG1lbCxzYW1hNWQyLWZsZXhjb20ueWFtbA0KPiA+
ICAtIEFkZCAjYWRkcmVzcy1jZWxscywgI3NpemUtY2VsbHMgdG8gZmxleGNvbSBub2RlIC0gRml4
ZWQgd2FybmluZ3MuDQo+ID4NCj4gPiB2NSAtPiB2NjoNCj4gPiAgLSBSZW1vdmVkIHNwaSBub2Rl
IGZyb20gZXhhbXBsZSBhcyBzdWdnZXN0ZWQgYnkgUm9iIGFuZA0KPiA+ICAgIGFsc28gcGF0dGVy
biBwcm9wZXJ0aWVzKHNwaSBkdC1iaW5kaW5ncyBjb252ZXJzaW9uIHRvIHlhbWwgcGF0Y2ggaXMg
dW5kZXINCj4gcmV2aWV3KS4NCj4gPiAgICBPbmNlIHRoYXQgaXMgYWNjZXB0ZWQsIEkgd2lsbCBh
ZGQgYmFjayBzcGkgZXhhbXBsZSB0aHJvdWdoIG5ldyBwYXRjaC4NCj4gPg0KPiA+IHY0IC0+IHY1
Og0KPiA+ICAtIEZpeGVkIGluZGVudGF0aW9ucy4NCj4gPg0KPiA+IHYzIC0+IHY0Og0KPiA+ICAt
IENvcnJlY3RlZCBmb3JtYXQgb2YgZW51bSB1c2VkIGZvciBjb21wYXRpYmxlIHN0cmluZy4NCj4g
Pg0KPiA+IHYyIC0+IHYzOg0KPiA+ICAtIHVzZWQgZW51bSBmb3IgY29tcGF0aWJsZSBzdHJpbmcu
DQo+ID4gIC0gY2hhbmdlZCBpcnEgZmxhZyB0byBJUlFfVFlQRV9MRVZFTF9ISUdIIGluIGV4YW1w
bGUuDQo+ID4gIC0gZml4ZWQgZHRzY2hlbWEgZXJyb3JzLg0KPiA+DQo+ID4gdjEgLT4gdjI6DQo+
ID4gIC0gRml4IHRpdGxlLg0KPiA+DQo+ID4gIC4uLi9iaW5kaW5ncy9tZmQvYXRtZWwsc2FtYTVk
Mi1mbGV4Y29tLnlhbWwgICB8IDc0DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLWZsZXhjb20udHh0IHwgNjMgLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKyksIDYzIGRlbGV0aW9u
cygtKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9hdG1lbCxzYW1hNWQyLWZsZXhjb20ueWFtbA0KPiA+ICBkZWxldGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC0NCj4g
ZmxleGNvbS50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWZkL2F0bWVsLHNhbWE1ZDItDQo+IGZsZXhjb20ueWFtbCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsc2FtYTVkMi0NCj4gZmxleGNvbS55
YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjg2
NGY0OTBmZmI4Mw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLHNhbWE1ZDItDQo+IGZsZXhjb20ueWFtbA0KPiA+
IEBAIC0wLDAgKzEsNzQgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0y
LjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiAr
JGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tZmQvYXRtZWwsc2FtYTVkMi1mbGV4
Y29tLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IEF0bWVsIEZsZXhjb20gKEZsZXhpYmxl
IFNlcmlhbCBDb21tdW5pY2F0aW9uIFVuaXQpDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4g
PiArICAtIEthdnlhc3JlZSBLb3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5j
b20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjoNCj4gPiArICBUaGUgQXRtZWwgRmxleGNvbSBp
cyBqdXN0IGEgd3JhcHBlciB3aGljaCBlbWJlZHMgYSBTUEkgY29udHJvbGxlciwNCj4gPiArICBh
biBJMkMgY29udHJvbGxlciBhbmQgYW4gVVNBUlQuIE9ubHkgb25lIGZ1bmN0aW9uIGNhbiBiZSB1
c2VkIGF0IGENCj4gPiArICB0aW1lIGFuZCBpcyBjaG9zZW4gYXQgYm9vdCB0aW1lIGFjY29yZGlu
ZyB0byB0aGUgZGV2aWNlIHRyZWUuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNv
bXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIGF0bWVsLHNhbWE1ZDItZmxl
eGNvbQ0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4g
PiArICBjbG9ja3M6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICAiI2FkZHJl
c3MtY2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgIiNzaXplLWNlbGxz
IjoNCj4gPiArICAgIGNvbnN0OiAxDQo+ID4gKw0KPiA+ICsgIHJhbmdlczoNCj4gPiArICAgIGRl
c2NyaXB0aW9uOg0KPiA+ICsgICAgICBPbmUgcmFuZ2UgZm9yIHRoZSBmdWxsIEkvTyByZWdpc3Rl
ciByZWdpb24uIChpbmNsdWRpbmcgVVNBUlQsDQo+ID4gKyAgICAgIFRXSSBhbmQgU1BJIHJlZ2lz
dGVycykuDQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgbWF4SXRlbXM6IDMNCj4gPiArDQo+
ID4gKyAgYXRtZWwsZmxleGNvbS1tb2RlOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiAr
ICAgICAgU3BlY2lmaWVzIHRoZSBmbGV4Y29tIG1vZGUgYXMgZm9sbG93czoNCj4gPiArICAgICAg
MTogVVNBUlQNCj4gPiArICAgICAgMjogU1BJDQo+ID4gKyAgICAgIDM6IEkyQy4NCj4gPiArICAg
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAg
ZW51bTogWzEsIDIsIDNdDQo+ID4gKw0KPiANCj4gQXMgcG9pbnRlZCBvdXQgYnkgUm9iJ3MgYm90
IC0gd2h5IGRvIHlvdSBub3QgYWxsb3cgdGhlIHByb3RvY29sLXNwZWNpZmljDQo+IGNoaWxkcmVu
IGhlcmU/IHNwaSwgc2VyaWFsIGV0Yz8NCj4gDQp1c2FydC9zZXJpYWwsIHNwaSBhbmQgaTJjIGR0
LWJpbmRpbmdzIGFyZSBpbiAudHh0IGZvcm1hdC4gU28sIEkgY2Fubm90IHJlZmVyIHRoZW0gaGVy
ZS4gTGlrZSBJIG1lbnRpb25lZCBpbiB2NSAtPiB2NiBjaGFuZ2VzIGRlc2NyaXB0aW9uLCBzcGkg
ZHQtYmluZGluZ3MgY29udmVyc2lvbiBpcyB1bmRlciBkaXNjdXNzaW9uLiBGb3Igbm93LCBJIGFt
IHJlbW92aW5nIGNoaWxkIG5vZGVzIGZyb20gZXhhbXBsZS4gSSB3aWxsIGFkZCBpdCB0aHJvdWdo
IG5ldyBwYXRjaCBvbmNlIGJlbG93IGJpbmRpbmdzIGFyZSBhY2NlcHRlZDoNCmh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1hcm0ta2VybmVsL3BhdGNoLzIwMjIwNjI5
MTI1ODA0LjEzNzA5OS0xLXNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20vDQoNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
