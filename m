Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78FF4FF75B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiDMNFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiDMNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:05:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB65E745;
        Wed, 13 Apr 2022 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649854993; x=1681390993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZoRqmwNM99hVscCvjxgcUjqxj6TaMCzuogAYJ1/QOtI=;
  b=ZzU9NGbl/8ZBcbXlbI7ji9Eeh0IQ6hl5xMChhqA1aTEwvuGVDbEysUdU
   6A8czt+lae6b4/WKjNnyRyzoN2q+LhLYUTxCZZVdkujglZk5CPAz+mkNA
   Z2A/kA50oRFQEJVZqyuv2dOB5hWAsrSyyKiclqiMJzB7pQdQ1y8i34gIg
   YvhPMYfaeya9iWdxHFVOh+12Nroj/trZVT8EH61nTafq+EBYV8YqGd8ah
   VrAUsSDPLGVGMwgL+hW00S+jITHMWhv/0TnLkeJGIEsDPWY1QstfBm56s
   e+06CHmRzo2dRRgsbcZ1zE1DngzuuURauzzOQC6da3V6svMt8MqoTnTEu
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,256,1643698800"; 
   d="scan'208";a="92256613"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2022 06:03:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Apr 2022 06:03:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 13 Apr 2022 06:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6ICE2W5bX8h8T3kj8ugx0NP5TUF+jsxC0Pf6vRf5ihPmElBWaUqs+4XpIYt9ifE5yHGZ/noDiX8vn38EdtGY8WesMIVMr2bAd7FwdHlvhLsn4DGciPHo9+ihdzOoFWe2WRO/a5cjqBhucnqPTuz0ojegBm4mJBu9dDORse1JhdDKP6oLGN3Xzm6zP6Hn8QmIlhkOT4mo3CKYwAfQFDgd95qzwBgzpPVYdP3zLyCkIjGaD3p8bpLoxw9knUlkA7As2y9L1MN3jZZKiWfmLW2pXodZgKZ1ke3R7fhRrTjJ5pJvMkgmrwgaHC7+uDIAyadYnpTJS3C26LmBc25F6C7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoRqmwNM99hVscCvjxgcUjqxj6TaMCzuogAYJ1/QOtI=;
 b=BaVHtwcQYPuCHCHZKPccXwxFKvQWWmE8Vw3ybj/xAOJEWCHArhWOC2C5NV7t5rd5N4dL/dpMo3OswuKNw0+igYbMqWJxsVyfkczM5h1w46FSvNxFoX+rAm5cSe0LSgRT+Fv93wG+7KIuTIWeoiMJcc4zat4hMr0Mp6WkCkApcx5WPVoR31owieDr7STtS17fUXIi4723+ecv1F0bm57x7PrUkdoHPTrwwp+x37+19bvunAshnotPV1pkmmi7COaOyNteOXJ93ukafpcmQH8iQtEmFx3rc2/5P6qJZBs3eik4Y+f+T7hxW48IpgmhmiDNdDiVNTyttKh8xgzXeu779Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoRqmwNM99hVscCvjxgcUjqxj6TaMCzuogAYJ1/QOtI=;
 b=vWAecmG62+EOZnBVokTQCEfG/wVi55qydgR4cmALkns56VUH2dKSNHuQANVgsGUbjdqz4rrzfianenIGeVlExPOIKNmb1OxzwC0rkBQ3+qYmiSvAUf4xfsogrEXV7Mb3hzM8e3dqOwOp6QvbGmUEIG+UkNpfYVBrsAvDteF0F08=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN6PR11MB1748.namprd11.prod.outlook.com (2603:10b6:404:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 13:03:10 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a%5]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 13:03:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <alexandre.belloni@bootlin.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>
Subject: Re: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
Thread-Topic: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
Thread-Index: AQHYTzbSZ3I+NNYirk6v/0Mnlw4qWw==
Date:   Wed, 13 Apr 2022 13:03:09 +0000
Message-ID: <bd818c4b-3519-ba80-2061-e4d2b9da5eda@microchip.com>
References: <20211214133404.121739-1-tudor.ambarus@microchip.com>
 <20220413125032.151907-1-michael@walle.cc>
In-Reply-To: <20220413125032.151907-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c6c68a1-9107-4f92-a590-08da1d4df5dd
x-ms-traffictypediagnostic: BN6PR11MB1748:EE_
x-microsoft-antispam-prvs: <BN6PR11MB174865097B03EA4E69AD0CB7F0EC9@BN6PR11MB1748.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TCxBqX7z/wKSgE3stsbz3a++7stlASOHvcY7ZbDJ83HrpSD37NlPL+qW9R8ovMfcrnShfKS/4/uJrXLdd+nnax2ubBzuYcNbwjK4Ea3hK0Ca+HXp8RMmuPANtrTCuAGxhN83cINo6mmUVBZEUDc+kNuUC1Kyyx2SY13o2qVwKTuDO1oyI1f35ALSqoImR19ynNAm4on/P0aaE9EVi8pPJY29Sjoocxil9EmaFQso1Ok23HOQRMbY7lov/rReli7IpL33skQ+Ej6QM0s3VeLiabOKZZMs/W6TXWBAXl6D4aQpllM7OqN+jpwxnzus7RbHDoME+ZQngS8yAR5rGI+odxrQX1UwIki7nBctTPAH946fXZVTlgAAyh+83r3/pu+cyctLi1B9SKQdDfPe9DUySPzTiSrcvrHL4xSs+FamSkaY2a4a4n7N+Zc8KAbnPFolqr4VNtXYt5JvoWI++HVCa1CzOglMOvw/Hz+BX60fAhRIE6EpnCxwctfbwotBEHDI1b+XZefK9Ebf7ZT/BNY3KmHSa+KL4hN1ISi3MxTc/V3L06HR1KQH7KA8Wm3bI2h6fABLRcljc2x/rth3yUieGUD/Ur1vEUKXwTKwobGy7a6k6/tNxkx/WZrBIJ2vSJfA7WMDbfjlA122f48rbZ/Xboa1d70SdG2pZWDThFDY+MDXfffVYmAsHf6bd71caPjwI+SC21811dE6Z2wmupHJd8DD6WSq/RGvCi1dfaFVOsyjJtlNR54a3whvmqoWGWOj3vAPW6SEltnXP7HLo08Qbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(122000001)(508600001)(66946007)(76116006)(66556008)(91956017)(66446008)(86362001)(83380400001)(36756003)(8936002)(38070700005)(8676002)(6486002)(4326008)(64756008)(26005)(186003)(31686004)(53546011)(6506007)(2616005)(71200400001)(107886003)(38100700002)(316002)(6512007)(31696002)(2906002)(54906003)(6916009)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW1IQURXZ2JSNWFNbnZ2T09pODIrS2lQZWlJT2ovZzNKblkvYWJkRlNqL2Jj?=
 =?utf-8?B?NmFvQVRUY2xsb05lcXI0Q0lxK1l1QnRtbldUYjJGSnFDV0R2dTh5SmdjZE4v?=
 =?utf-8?B?SU5iNTBXV05EY3k2SkNDMlFYTEJiakt2M3laTk9mL1NRS3pRNkI4WG9IcExw?=
 =?utf-8?B?cnlXdzlqbnFpZi9sdGJQS2RqdlJQcWZhYU9UNklBYTlUck1kQTVJejdONWg0?=
 =?utf-8?B?M2labEhhVGtIMTFuanhOc3hBcjFrV0hXcFdqY25qVkE3SDlTM3NrTXRuaWVI?=
 =?utf-8?B?SytOMllqQWNFSjVKNzR1Z0hLR0k0ZWxtN05uUGh4YjFJRUFzK2NXSzZxZWJG?=
 =?utf-8?B?TmhROG9qSzg0WHk3QVA4SXdER3RjQnZPSkszN3pPV0JwYVM2YVUwVVdhcTBu?=
 =?utf-8?B?OU16Y1lqMnJ6TjZlYTU5MytXQVBPYzd3bmJTREQxNlFkL1JXQTI5SWcwSThm?=
 =?utf-8?B?ZktSYWVVM3ZBa0VOVU92SjRpaW1Gb1VadWNNUjRjT3RwellvZEVJbGNJeE16?=
 =?utf-8?B?TGExV3lUMEhGMHlNWlRCVFJlZ1U4NUlYSEh1c2FJNmZvZ2RtNE92NE91K3pl?=
 =?utf-8?B?ZEtrVjRTa01XY0VaZkZhcUtMTnVlb3FEQWxxcDYrMFlBN0hPTnZ5Q2JvVTRP?=
 =?utf-8?B?SnBIc0tuNldENzdjZm9IYmxpZ0ljZlVndW50eEthZ1VlbEpEaUhtTnlrV3JF?=
 =?utf-8?B?NncwMzl1Z3FkYjh3ZFRYS25BTUJjNTZmTS9vT1NJd2pTMG94Tk9RcUhadVZo?=
 =?utf-8?B?WEZzQ1lzTEwrcFJ3d2pFMzhSdHZPZ1k0cDMvOS9BWGRWWDI2RGhtcTFlSVlR?=
 =?utf-8?B?WStoNGRaWFVNbGJnKzdyVUJqSzhIcnA3QksrZ3VRdkhhTklFN01XZkZTMTB1?=
 =?utf-8?B?bDlCYW81QUN0cjMyd0NVa2Rud3RleHJsNDdaSVRlUWFYTW1JTTlIT1hteFVF?=
 =?utf-8?B?OUVqdkpxWm1YeU9rYWNkbGFpbjNmWER3dE9ISFdrdmI5Z2FEak1HbjZsdFFB?=
 =?utf-8?B?L3AvS21IaFhXZU1UVjR6MVFoSjJmWWx6VllDVVgvY0hEVU9DYjRJcG96Y2Fx?=
 =?utf-8?B?ckZ0SnNpNGxvYVV3SXJxeDVrRndnaVVuV3plZ1BmNTBOZFJIR0tYSkpaUDIw?=
 =?utf-8?B?ajN2Ni84MmtTVEQzYnkxVUo3TkM3RlZjaE5EUS9nSld5Q2tZenhSb3VSTW9Q?=
 =?utf-8?B?UEpkWktrY0t3ek5hU2ZrdVlWc1EzSEFmVFVaL1RNNzNYYUx1VEVQcjdtcTM0?=
 =?utf-8?B?S0t2VG5tMDN0cVMwTFp3SGhRYVBqeGIvNWRLcVExVytpNGQ2ekozZ25KOGxk?=
 =?utf-8?B?UVpLVDBMQUc2amQxOTluR1lNdEtKcDRzaS9zL0lONVFpbUl2R2Y0ZkJrWjZZ?=
 =?utf-8?B?YnlNb0Y3T1pEWmVub2hvT1dyeWlNN1pGNXE1SnpKMUxKYXVsUkRldE9VVWdV?=
 =?utf-8?B?dmxPRzBVMm1lSDVNang2MkltUG1wNktMYURvSnUxMmpIYzdhVUxySWVSaURI?=
 =?utf-8?B?RzYwcXc3a01aZVVkbmxhY3orWjdMdDAvVGpMZFNxTWFud0NSMWxDZjZQSUQ5?=
 =?utf-8?B?RUxEZW5aYjNzQWxqMTFHem5JUklKY0hyeS9aampib3BzL2FUOTc5bjRYdVVN?=
 =?utf-8?B?cm51Z1VCQ0NnTEw1a1FIUy85NFFLWVQvRUkwSVB4RDZlelAxSGxyQThVTk4w?=
 =?utf-8?B?VlRPRDZyZmFSQ3ZCOWVLTU4rd1IxbzBiYy9ZUFVCVnpwNm9hb1ArZjlPTSs4?=
 =?utf-8?B?ZmhPdmR1MU9GemxvR21XNWlhMHd5OVBaRGFyWXVPM1VGOU1tZzFJQXJtQ20v?=
 =?utf-8?B?Nm52VmcvbzdiQUE4ZzhsUDhQSFJDS3E5UmtadlBVNS9RQWtQY29neEt2YzNt?=
 =?utf-8?B?T04rb3AvV3hUVVpKUGQzNG1vNXpnbU96NkRQYk1ia1lVcHh3N3NKdGlMN0ZR?=
 =?utf-8?B?aXE0VmZxeFUrK1VNbFlxYnh0YVZBRXg5SWM1VnlYd3BFYVdMa0haV1VsUzNC?=
 =?utf-8?B?VEhWMHl1bmdNNmk0Q2o3SEtBSHhMa2ZSK2h4TXM2YkVMUUVwZUVHczBJdTFu?=
 =?utf-8?B?TGhTckFkRUo0WldvWG1TY1ZNSnkwcUJaSDRnc0l1eWwxSkZ3R2FqTE9nR2FP?=
 =?utf-8?B?aEVRTkRMWFdReFVxTHdOMUhWTWlhcWpqaDk0OWdiS1VJWlNONnozc3BMQ25v?=
 =?utf-8?B?QndjTDYyS1hwQ0U2MXMxTVZsVHNxQU05c3cwUjE5M2F1cTZ2UkFHZzVZYWhJ?=
 =?utf-8?B?VHlaa3NzN3owWXpRKzJFUkROSnh0eXQyam1ZMkFiRGc4b2lPTXhNNmdhMTc1?=
 =?utf-8?B?L1RjeHo3eVVJZWdtY1lGOW5MSHlyZ09FZENsWHVMT1F4YWhTSUJYamdpY1Mw?=
 =?utf-8?Q?u8A8dqdMT2FZoFMA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C029B67820D4D44294B56068E15A02C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6c68a1-9107-4f92-a590-08da1d4df5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 13:03:09.9747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Dyu2TEcYAc9y7LJ+AzGc7nMNI+WFWV2SoWtgFmF/NkCbomU2gI63aKpJR0Cq8Yxs4LJ4iJweZUhvrC7m5z9mCrRfJ8Y1N9SKkYFv6yeve8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1748
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xMy8yMiAxNTo1MCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBUdWRvciwNCg0KSGkhDQoNCj4gDQo+PiBUaGUg
c2FtYTdnNSBRU1BJIGNvbnRyb2xsZXIgdXNlcyBkZWRpY2F0ZWQgY2xvY2tzIGZvciB0aGUNCj4+
IFFTUEkgQ29udHJvbGxlciBJbnRlcmZhY2UgYW5kIHRoZSBRU1BJIENvbnRyb2xsZXIgQ29yZSwg
YW5kDQo+PiByZXF1aXJlcyBzeW5jaHJvbml6YXRpb24gYmVmb3JlIGFjY2Vzc2luZyByZWdpc3Rl
cnMgb3IgYml0DQo+PiBmaWVsZHMuDQo+Pg0KPj4gUVNQSV9TUi5TWU5DQlNZIG11c3QgYmUgemVy
byBiZWZvcmUgYWNjZXNzaW5nIGFueSBvZiB0aGUgYml0czoNCj4+IFFTUElfQ1IuUVNQSUVOLCBR
U1BJX0NSLlFTUElESVMsIFFTUElfQ1IuU1JGUlNILCBRU1BJX0NSLlNXUlNULA0KPj4gUVNQSV9D
Ui5VUERDRkcsIFFTUElfQ1IuU1RURlIsIFFTUElfQ1IuUlRPVVQsIFFTUElfQ1IuTEFTVFhGRVIu
DQo+Pg0KPj4gQWxzbywgdGhlIFFTUEkgY29udHJvbGxlciBjb3JlIGNvbmZpZ3VyYXRpb24gY2Fu
IGJlIHVwZGF0ZWQgYnkNCj4+IHdyaXRpbmcgdGhlIFFTUElfQ1IuVVBEQ0ZHIGJpdCB0byDigJgx
4oCZLiBUaGlzIGlzIG5lZWRlZCBieSB0aGUNCj4+IGZvbGxvd2luZyByZWdpc3RlcnM6IFFTUElf
TVIsIFFTUElfU0NSLCBRU1BJX0lBUiwgUVNQSV9XSUNSLA0KPj4gUVNQSV9JRlIsIFFTUElfUklD
UiwgUVNQSV9TTVIsIFFTUElfU0tSLFFTUElfUkVGUkVTSCwgUVNQSV9XUkFDTlQNCj4+IFFTUElf
UENBTENGRy4NCj4+DQo+PiBUaGUgT2N0YWwgU1BJIHN1cHBvcnRzIGZyZXF1ZW5jaWVzIHVwIHRv
IDIwMCBNSFogRERSLiBUaGUgbmVlZA0KPj4gZm9yIG91dHB1dCBpbXBlZGFuY2UgY2FsaWJyYXRp
b24gYXJpc2VzLiBUbyBhdm9pZCB0aGUgZGVncmFkYXRpb24NCj4+IG9mIHRoZSBzaWduYWwgcXVh
bGl0eSwgYSBQQUQgY2FsaWJyYXRpb24gY2VsbCBpcyB1c2VkIHRvIGFkanVzdA0KPj4gdGhlIG91
dHB1dCBpbXBlZGFuY2UgdG8gdGhlIGRyaXZlbiBJL09zLg0KPj4NCj4+IFRoZSB0cmFuc21pc3Np
b24gZmxvdyByZXF1aXJlcyBkaWZmZXJlbnQgc2VxdWVuY2VzIGZvciBzZXR0aW5nDQo+PiB0aGUg
Y29uZmlndXJhdGlvbiBhbmQgZm9yIHRoZSBhY3R1YWwgdHJhbnNmZXIsIHRoYW4gd2hhdCBpcyBp
bg0KPj4gdGhlIHNhbWE1ZDIgYW5kIHNhbTl4NjAgdmVyc2lvbnMgb2YgdGhlIElQLiBEaWZmZXJl
bnQgaW50ZXJydXB0cw0KPj4gYXJlIGhhbmRsZWQuIGFxLT5vcHMtPnNldF9jZmcoKSBhbmQgYXEt
Pm9wcy0+dHJhbnNmZXIoKSBhcmUNCj4+IGludHJvZHVjZWQgdG8gaGVscCBkaWZmZXJlbnRpYXRp
bmcgdGhlIGZsb3dzLg0KPj4NCj4+IFRlc3RlZCBzaW5nbGUgYW5kIG9jdGFsIFNQSSBtb2RlIHdp
dGggbXg2NmxtMWc0NWcuDQo+IA0KPiBJJ3ZlIHN1Y2Nlc3NmdWxseSB0ZXN0ZWQgdGhpcyBvbiBh
IExBTjk2Njggd2l0aCBhIFNTVDI1VkYwMTZCDQo+IGFuZCAxMDQgTUh6IChxdWFkIG1vZGUpLiBC
dXQgdGhlcmUgYXJlIHNvbWUgY2F0Y2hlczoNCj4gDQo+ICgxKSBTUEkgbW9kZSBpcyBub3Qgc2V0
LCBpLmUuIFNDUi5DUEhBLCBTQ1IuQ1BPTA0KDQpub3RlZCwgd2lsbCBkby4NCg0KPiANCj4gKDIp
IFRoZXJlIGlzIG5vIChvciBhIHJlYWxseSBzaG9ydCBkZWxheSkgYmV0d2VlbiBhc3NlcnRpbmcN
Cj4gICAgIHRoZSBjaGlwIHNlbGVjdCBhbmQgdGhlIGZpcnN0IGNsb2NrIGVkZ2UuIEkuZS4gU0NS
LkRMWUJTDQo+ICAgICBpcyB6ZXJvLiBJIHdhc24ndCBhYmxlIHRvIGdvIGZhc3RlciB0aGFuIH4y
ME1IeiB3aXRoIHRoYXQuDQo+ICAgICBBbHNvIHRoZSBzbGlnaHRlc3QgY2FwYWNpdGFuY2UsIGxp
a2UgYSBwcm9iZSB0aXAsIG1hZGUgdGhpbmdzDQo+ICAgICB3b3JzZS4gSSd2ZSBiZWVuIHN1Y2Nl
c3NmdWwgd2l0aCBhIHZhbHVlIG9mIDIgYXQgMTA0TUh6LA0KPiAgICAgYWx0aG91Z2ggYXR0YWNo
aW5nIGFuIG9zY2lsbG9zY29wZSBwcm9iZSAoPDQgcEYgaW5wdXQNCj4gICAgIGNhcGFjaXRhbmNl
LCBubyBjaGVhcG8gcHJvYmUpIG1hZGUgdGhpbmdzIHVucmVsaWFibGUgYWdhaW4uDQo+ICAgICBJ
biB0aGUgZW5kIGEgdmFsdWUgb2YgNCB3b3JrZWQgcGVyZmVjdGx5LiBJIHRoaW5rIGl0IGlzDQo+
ICAgICBvdmVya2lsbCB0byBtYWtlIHRoaXMgY29uZmlndXJhYmxlLCB0aGUgYWRkZWQgZGVsYXkg
c2hvdWxkDQo+ICAgICBiZSBuZWdsaWdpYmxlLg0KDQpzb3VuZHMgZmluZS4NCg0KPiANCj4gKDMp
IEFzIGFscmVhZHkgZGlzY3Vzc2VkIG9uIElSQywgdGhlIGRyaXZlciB3aWxsIGlvbWFwIHRoZQ0K
PiAgICAgd2hvbGUgbWVtb3J5IHdpbmRvdyB3aGljaCBpcyAyNTZNQiBmb3Igb25lIGNvbnRyb2xs
ZXINCj4gICAgIGluIG15IGNhc2UuIE9uIGFybTMyIHRoZSB2bWFsbG9jIGFyZWEgaXMgb25seSAy
NDBNQiBieQ0KPiAgICAgZGVmYXVsdC4gVGhlIGxhbjk2NjggaGFzIHRocmVlIG9mIHRoZXNlIGNv
bnRyb2xsZXJzDQo+ICAgICAgICAgKHdoZXJlYXMgb25lIG9ubHkgaGFzIGFuIDhNQiB3aW5kb3cp
LiBUaGVyZWZvcmUsIHdlIHdvdWxkDQo+ICAgICBwb3RlbnRpYWxseSB3YXN0ZSA1MjBNQiBqdXN0
IGZvciB0aGUgU1BJIHdpbmRvd3MuDQo+IA0KPiAgICAgSSBoYWQgYSBsb29rIGF0IHRoZSBkcml2
ZXIsIGFsdGhvdWdoIElBUiBpcyBzZXQsIGl0IGlzDQo+ICAgICBub3QgdXNlZCBmb3IgdGhlIGFj
Y2Vzc2VzIHRocm91Z2ggdGhlIG1lbW9yeSB3aW5kb3cuIGRvaCA7KQ0KPiAgICAgSXQgc2VlbXMg
d2UgbmVlZCB0byBtYXAgdGhlIG1lbW9yeSBqdXN0IGZvciB0aGUgbWVtY3B5X2lvLg0KPiAgICAg
VGhlIERNQSBlbmdpbmUgc2hvdWxkIGJlIGhhcHB5IHdpdGggdGhlIHBoeXNpY2FsIGFkZHJlc3Nl
cw0KPiAgICAgYW5kIHNob3VsZG4ndCBuZWVkIHRoZSBpb21hcC4gV2hhdCBkbyB5b3UgdGhpbmsg
YWJvdXQganVzdA0KPiAgICAgbWFwcGluZyBsaWtlIDE2TUIgYW5kIGFmdGVyIHRoYXQgYWx3YXlz
IGZhbGwgYmFjayB0byBETUENCj4gICAgIHJlZ2FyZGxlc3Mgb2YgdGhlIHRyYW5zZmVyIHNpemUu
DQoNCkkgbm93IHVzZSB0aGlzIG1lbW9yeSB3aW5kb3cgdG8gYWNjZXNzIGZsYXNoJ3MgcmVnaXN0
ZXJzIGFzIHdlbGwuDQpJIGNhbiB0cnkgeW91ciBpZGVhLCB3aWxsIGNvbWUgYmFjayB0byB5b3Uu
DQo+IA0KPiAgICAgSW4gZmFjdCBJIGRvbid0IGtub3cgd2h5IHRoYXQgbWVtb3J5IHdpbmRvdyBp
cyBuZWVkZWQgYXQgYWxsLg0KPiAgICAgU2hvdWxkbid0IHRoZSBETUEgZW5naW5lIGJlIGFibGUg
dG8ganVzdCByZWFkIGZyb20gUkRSIGFuZA0KPiAgICAgd3JpdGUgdG8gVERSPyBBbmQgUElPIG1v
ZGUgY291bGQgZG8gdGhlIHNhbWUuDQoNCkl0J3MgZmFzdGVyIHRoYXQgd3JpdGluZyB0byBSRFIv
VERSLiBJbiBmYWN0IEkgc2hvdWxkIGltcGxlbWVudCB0aGUNCmRpcm1hcCBob29rcy4gV2lsbCBk
by4NCg0KPiANCj4gKDQpIE9kZCB0cmFuc2ZlciBsZW5ndGhzIGRvZXNuJ3Qgd29yay4gVGhhdCBp
cyBJIGdldCBkaWZmZXJlbnQNCj4gICAgIHJlc3VsdHMgZm9yIHRoZSBmb2xsbHdpbmc6DQo+ICAg
ICAoYSkgZGQgaWY9L2Rldi9tdGQwIGJzPTMgfCBoZXhkdW1wIC1DIHwgaGVhZA0KPiAgICAgKGEp
IGRkIGlmPS9kZXYvbXRkMCBicz00IHwgaGV4ZHVtcCAtQyB8IGhlYWQNCj4gDQo+ICAgICBBY3R1
YWxseSwgSSd2ZSBub3RpdmVkIHRoYXQgdXNpbmcgdGhlIChidXN5Ym94KSBoZXhkdW1wDQo+ICAg
ICBkaXJlY3RseSBvbiAvZGV2L210ZDAgcmV0dXJuZWQgc29tZSByZWFsbHkgb2RkIGJ5dGVzLiBN
aWdodA0KPiAgICAgb3IgbWlnaHQgbm90IGJlIHJlbGF0ZWQgdG8gdGhhdCBhYm92ZS4NCg0KSSBz
dXNwZWN0IGl0J3MgYSBwcm9ibGVtIGF0IG1taW9jcHkuIFdpbGwgb2RkIHRyYW5zZmVyIGxlbmd0
aHMgd29yayBpZg0KeW91IGFsd2F5cyBmb3JjZSBETUE/IEkgZXhwZWN0IHNvLiBBbnl3YXksIHdp
bGwgdHJ5IGF0IG15IHNpZGUuDQpUaGFua3MgZm9yIHRoZSB2YWx1YWJsZSBmZWVkYmFjayENCg0K
Q2hlZXJzLA0KdGENCj4gDQo+IC1taWNoYWVsDQoNCg==
