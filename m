Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1192357C5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiGUIIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGUII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:08:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413A7D1DE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658390905; x=1689926905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e4Q9C+V2cPMnMEOz9Ug+asGRao9QGNdATh0QD5oWwtw=;
  b=YdJ8nN/ifnE98DkuvPFppE62tC4s8n67MiGRCbtwJkzx6pR2aBjhvr06
   /GwJc0vOlHGJ2S1SgEEZsTofRNOZYgt9rxOAJA1YEaYnE7adkuN+k4r9+
   46EvqEKNvwEGluNbwuJtPMRsQ9EM/Kxf/zNVsN9FKroY1iOTuqbe+t3Ev
   BizFXwskOqlUVH7odb4F33JmHs+Tcb0FvGbZ/zQxu8D8Hq9U3bM1pX9EA
   VWbz0S0zPp4KoSMtMxOY7793plHdV9ccNfh2j41lvihW0TLb4bRYboX8q
   2TzfeXY9g6dAETj5R4a3BdU+/jEUmnB+iDZiYaubaSPkoeu6RsT6U/4xH
   w==;
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="105477707"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jul 2022 01:08:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Jul 2022 01:08:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 21 Jul 2022 01:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HP8dfYCWvOByniem3Ae8eGF4VJKFbpYv2SRTzrKy0bi8133g0h9S0+Bqlb+hSHuC8cqi3y6EWAS+rrdGL9As/OhQipXJCIlIF0BnpOaN7GErpcTVaox9E3BuaikKJAz4sDhZCtr+NTmnv+FBcIL4PnsCB6sc9KauweNvr8zHJCwjLgz3bhL4BOMZ/E5rxyXZ20duuwFixBYQY46fBOXaYEEIxjWYXrXmIpWCEzEhiZFtg9S3z6z3FwzNEZex2kSj4ML9F2ATngkkPZbrMI6lY65Cx20HNXRyKDJnnwOrwi71KiyZcOKGeIKShU/Yk6wydwwVAJygsRMKDAs8mHvQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4Q9C+V2cPMnMEOz9Ug+asGRao9QGNdATh0QD5oWwtw=;
 b=HlweWy6e1/RKNUjj22o6ySXXiW9674mkYguWsitjWn9TrK7Rly8Usw0lZr9Jn/dw/JWiCWUObPGO+j11MeBL5kjam4oYUGIx3m2wDoeZqi1ZcaZgOfSMLGH0ZY0B26A/MCARSRXWVA7ygUjZPnf2kLqmdgNt/xHmeAJnL6fTFexYMXOsxJ7eSddgrd+9jlNvy2SxiL80ZNFMCm2iKL6shfS6wCSTS0AcNPf/Uxw5XiearCUiPFGbS7aT2Hlqnkf9RLXrfvbm4MkuwX2XKeb9sCU+XE/mKP5P8Y4SN9maEe6Ez0CG57/v96+oWF0E/mpHSdoK6k9bLqQq0tzYBXbqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4Q9C+V2cPMnMEOz9Ug+asGRao9QGNdATh0QD5oWwtw=;
 b=AMvAXbwCiPdNb/BFrlAfA2sWF9NAw+u3ZUPt5SwEOv91GKkft+9PfpeI7+k4lQIvsxxS6toMW81PwXzmlbn7nB+hunb7QgEnw3V2UHPw+zSSATUdTjTGKoB7P60nJFHk1mcJpSusdj2WXArOz34S5ljGFzBlqfFm3ED5uIw2Dg0=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CY4PR11MB1525.namprd11.prod.outlook.com (2603:10b6:910:9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.15; Thu, 21 Jul 2022 08:08:20 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 08:08:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <tom@tom-fitzhenry.me.uk>, <p.yadav@ti.com>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2] mtd: spi-nor: siliconkaiser: add support for sk25lp128
Thread-Topic: [PATCH v2] mtd: spi-nor: siliconkaiser: add support for
 sk25lp128
Thread-Index: AQHYnNkKComMZVmO40SH149hyPIBfg==
Date:   Thu, 21 Jul 2022 08:08:19 +0000
Message-ID: <dd516981-4d1b-acdc-c468-cbb14d34f68c@microchip.com>
References: <20220603141603.145777-1-tom@tom-fitzhenry.me.uk>
In-Reply-To: <20220603141603.145777-1-tom@tom-fitzhenry.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b519d0e5-44e0-4507-2a56-08da6af02c8e
x-ms-traffictypediagnostic: CY4PR11MB1525:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?b2tPTTh1VVkvRUtmclllTHRETmtlUWh1b3MyUi9sMzhEclF3S1JoMHNBMERC?=
 =?utf-8?B?N3BFeE8wdGw3Q1RwL0hicjBZYldhYWQ3RlI1dGdmb29CUmlheFh4OE9iUjlr?=
 =?utf-8?B?RHdSZUpEanU3RUZKaTh2MTZ4RHBUdExrY3dDLy9hKzFaeVcyWU5DcElrWSt1?=
 =?utf-8?B?OWsxL2lDUDBwUDRMdEx4UGVVeEdlNGJZZFZDbXNNWEJ6ZVNMQjBBREx2OEJv?=
 =?utf-8?B?NkpWTUdSYWFiT3JIV2pOMGQrYkllZjNMZCtDSWRoZ2ZKN0tjYkxxTG4xSTRR?=
 =?utf-8?B?VmJDbmE2Wm90d2RjWGpwK0U5MzNqR0xYZ3J4S3NXc24zWEhNNVpUYUtTc2J5?=
 =?utf-8?B?MVM1Y2J3bTVMOVNEY2gzaU14dFZ3ZVZTMDRpNnN1elZHaWplbzlYNEN3UTZx?=
 =?utf-8?B?WVlUL3pBYXQyalBsNWdKT0dhTEFkZWFDWHJzYXZPS2srUkRuSXpQRmdSNnU4?=
 =?utf-8?B?ZmFSeThQcUtPMmRRQ1cxenNyb3ErdG5QQ3lLZStwTWtwSVJRc0M3MzBpM2xL?=
 =?utf-8?B?Unc1Vk9aTlFUSklJUGtKUFVOakltNmt2S2tORUVydHdVU21QNlloZ0FoL2RF?=
 =?utf-8?B?SkxjQlJQKzZpaUQ3RCtrVnVCTzcxQ0owZmFOTDNoVnRkeGtYUEI0TlFVejJT?=
 =?utf-8?B?OC9PREU0YW9IM25ybVBuQkRFeE5tSVZhU1hFSnhFQmJ1Q09QL2lUbzV4WFZ6?=
 =?utf-8?B?S0hpc2pNU1Q0eDIrWUw0MERrSUVLdHVZeWVRcFJuVDRFVVYxWGhGbzFaeUhn?=
 =?utf-8?B?bTl6aVVVRWZ6Skh4VE9KdGN1ZjBURVhpdVE3STVaNHA1cUI3WHlLdmRtT21r?=
 =?utf-8?B?RlVNTnN2ZDZGbC9tc2pNV1BwZlJXa3RBR3c3TGxFQndMMFAyWm9EdGR5T0li?=
 =?utf-8?B?U2pyVzBiTEZUclJVT3MxT0h1NVkrM241OXhJWGJyTlZjdk9yeGdaVHllMWdR?=
 =?utf-8?B?N0tld3lHeTFqU1Rxc1V0Wk4vRlRLWWszWCtjOXFYdzg4NkJINzVCcXVBTVpv?=
 =?utf-8?B?SGhqZXlsdFZnYXNoNXZGanZVUVpMd1JnSm8yZEF2dk5TL0RsRCtENFZJVGlx?=
 =?utf-8?B?bUNrYnFsQ0oybSsyZzhraG9mNWMzZnRXeTJqS3BSSkRDditpcUxBaFJpTVNE?=
 =?utf-8?B?dTQ1Q1hZT2dKOGJHMURkakFxWmVsRnViWlBiMnFQdU81NXJJNERYZXFuWTU0?=
 =?utf-8?B?L1ZsdWV4dUdIVk9aMWFDQktCcUo4VDJuVDJPSmJBOUNCVXJKb0NGUGMwQUFN?=
 =?utf-8?B?NG5POCsxc3c1ank5c0lNN1oxN0sxYTN3SzJpREZFTERXcVFjQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(39860400002)(376002)(136003)(66446008)(5660300002)(66556008)(966005)(53546011)(4326008)(64756008)(2906002)(86362001)(41300700001)(31696002)(91956017)(76116006)(6512007)(8676002)(26005)(66946007)(122000001)(6486002)(8936002)(478600001)(71200400001)(66476007)(6506007)(38100700002)(54906003)(36756003)(316002)(2616005)(110136005)(186003)(83380400001)(38070700005)(31686004)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWpKQVlKTjdHdXZZMkRtUEZqaWtpTGx6NFN5dkVUTXdsUXk3cDdLU3haMEFn?=
 =?utf-8?B?eWpDV1lEYU1nUU40NmVpNDNIK0Nob002Y0lLcGJoNmVGRm0yWDQ5ZGZtUklT?=
 =?utf-8?B?SHJaWjVIL1IzSVlxTUVQT3VjaStOM1VMbXJYNnV4MkNFdUdQSDdPdXNSV2RI?=
 =?utf-8?B?alg4YkcwYk9xOTlDWXZOMzRMem96Rk9ONHJoM2hoL2x2UjRuSkk2SzVlMzJC?=
 =?utf-8?B?TGt6ekZKVEhYTEpKUXZzREg2RFNlNHJkajkzdlREbUVxK1Exdk5TY1lOQlU3?=
 =?utf-8?B?YUF5Qk9GZGQ4bUNidE96VWV0SUVkRTJwOWJsNk1mY0M5TFkwbkNNUHB6cGMz?=
 =?utf-8?B?cTBjdTFoaVZybFFtVThlcER0UVp2di8xdXlQR0hBd0M3MjhkTDY0LzltSHVl?=
 =?utf-8?B?KytlS0tBVUhtVXZyTXBYbncwemFiUEwvbTY2RVc5QVFSQ3Arbzlpcm0yV1FI?=
 =?utf-8?B?ZG5WUGZyNUNNZVVzbWxmWnJ5aHVwa0p4ajhZeXpIOGthajlsaWRWQ216N2hs?=
 =?utf-8?B?dUZWVWFid2hiR1BqYmFvcjVFNnFtczQ2ZEwzc0lkVWlCTVJ1cGRmbXVOVFRU?=
 =?utf-8?B?UG82eTNNVXc5MTdxc1dsWndaZE0rVWg4bjl5akpmdUU2TzFMcmZ4RlRlenJj?=
 =?utf-8?B?VG5tekk3RVJNZTVOdzNYckM1S2g0WTAwTks3M1BGY3pYc1dGdmlEMnVmck9D?=
 =?utf-8?B?Zk1GSk9MVGhVVEZaWEZnWTVTVml1SUx5MVFyOEg0MzQ4V1ZtRGFKSjFwNG1r?=
 =?utf-8?B?cUVFeUlYUTUxRXQwdkZEWitBdU9FNkR2N2Z5OVo0ZW83ZElQTXBmcXRtY0RS?=
 =?utf-8?B?Nkd1M1dXTGNPbTNOUWNSRzA1UHpXMjJzUmlEeEQ1RVpQWWVTd05wZGdmTnp5?=
 =?utf-8?B?RnVDbDJmbzRnZ1BjVVB0SW5sREZ6SE8zVzFIcWZUZVRlU1pFcHFZQThQSVBN?=
 =?utf-8?B?R1lmWFdVd2c5TDNUaW5UWGUzMGF6Mmp6bWF6bW13ZXpodHJTcC9CaGdjeHp0?=
 =?utf-8?B?eXpZZjhwaXZzczJLOUxNK3ZYU2FLV1RwWFJ0cEdIVU9CU09MbVNUVXBraFhM?=
 =?utf-8?B?UER5Zk5ybHM5b1FWcW52QWluYW03OENENlY5UVVxdlhDRzJFZlNZR2t6bjVI?=
 =?utf-8?B?TkNVZkRESnFnR3RZOS90K0Rqa3JtU1BTU0liWkVuQ1lQdENqbzBuMVFkZ3NK?=
 =?utf-8?B?VS8xVm9aT0NtZXBoUEpQQWkzN0NoWkhmMzNmTll3SkdVUFpaMnVBdnNFcFZi?=
 =?utf-8?B?a3JONW0rcGZTSnRIMTdodFk5R2lzdzNJWjU0a1NBVmM5eTdNRm9iSjMxcVF1?=
 =?utf-8?B?Z0MxRjIwQUtJNWc0azVGbCtMakVDbWYwc0NxVkk1MW1ySEIyVTBUcEZKanNJ?=
 =?utf-8?B?ZlZXWjVMUjd3QXY3czE5ZmJBZDE4Y01hWW1KOUNXR01WRzFENUlnQWwvMmxL?=
 =?utf-8?B?TldzQnRWbTgzSzU5cE1JOE4vWWNOOGJ3U2MwNTJyNjd5UG5OZDBpZ0dtWXpm?=
 =?utf-8?B?NlZUdFdhckZuM2lFa3paRzdlWDBMVjZvVlBpRndwNFM5VmRJTmpKdHlXcGNl?=
 =?utf-8?B?eFMxbWFybmhSYTFvTWt0b3pmMFdJVm1hQ2lyMGJsbUx4VGVIaC9BNVlReHVL?=
 =?utf-8?B?VGpSQVYwNmlIc0dId3NvQTlaMzI0UGduWEc1SW90MmVrZXZSUjEzemZQTXlN?=
 =?utf-8?B?b2VPcDdLWXZOUmY4REhjMUxJNnhKbzlHM0pSb2pqZVJiRjg5UVBEQlgwUzRV?=
 =?utf-8?B?UW5XcURpNmZyWVhUd25YK09BZ2JFNlREbDFwakp3RUlkR1VzdFRpQkdDT3FF?=
 =?utf-8?B?TGVySG1ZdnJwN213K1o5T2lraE12SFd4bXBwMU1nUXdldU5EU1A0b0cxN01C?=
 =?utf-8?B?VjFMbStJdVZxT01Baklhc2VCQXFwb3dkY0tBemd6L2ZhNEV5M3FqbXJvZVBC?=
 =?utf-8?B?akllMEdFYnIrYW5RYW4vbHVSTnNIenA2Ly95UHN2SmFTYndYYWJRZW5icEpN?=
 =?utf-8?B?REF3QktYdXNiZUZMRE1TdTExZm5vVTcwZ1BPTUZEajJlVEtZK1ArbkhOTHVS?=
 =?utf-8?B?a2FibFg0aDBCakZvdWVkUkJaZTZ6d0pXSHA2alJsa25qSXZ6RXBLdUJGdEhH?=
 =?utf-8?B?b3p4aVZxdUVPUDY4dDFLUzlnSy9jOWkxcUl1VlFQcDI0U2g0WStOOVdMYXdE?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E53B523630CC04DA793C216BCADE628@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b519d0e5-44e0-4507-2a56-08da6af02c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 08:08:19.7931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+YtU7hPCoFtvBX0AVcHcePVxq6mP7CUc/MhPwQTWSUJgFXWdaGyJVXE8TN0m47+BFcP1+eYgBat44nHUNNsFFvnOnTH67SoJvgQtHHsIYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1525
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8zLzIyIDE3OjE2LCBUb20gRml0emhlbnJ5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCBzdXBwb3J0IGZvciB0aGUgc2lsaWNvbmthaXNl
ciBzazI1bHAxMjggY2hpcC4NCj4gDQo+IFRoaXMgaXMgdGhlIGZsYXNoIGNoaXAgdXNlZCBpbiB0
aGUgUGluZVBob25lIFByb1swXSwgZm91bmQgYnkgcGh5c2ljYWwNCj4gaW5zcGVjdGlvbiBvZiB0
aGUgYm9hcmQuWzFdDQo+IA0KPiBJIGNhbm5vdCBmaW5kIGEgZGF0YXNoZWV0LCBidXQgdGhpcyBj
aGlwIHN1cHBvcnRzIFNGRFAuDQo+IA0KPiBUaGlzIHBhdGNoIGRlcGVuZHMgb24gU05PUl9JRDMo
KS5bMl0NCj4gDQo+IFRlc3RlZCBkb25lOiBjaGVja2VkIHRoYXQgdGhlIFBpbmVwaG9uZSBQcm8g
Ym9vdHMgd2hlbiBhIFJPTSBpcyB3cml0dGVuIHRvDQo+IC9kZXYvbXRkYmxvY2swLg0KPiANCj4g
JCB4eGQgLXAgL3N5cy9idXMvc3BpL2RldmljZXMvc3BpMC4wL3NwaS1ub3Ivc2ZkcA0KPiA1MzQ2
NDQ1MDA2MDEwMWZmMDAwNjAxMTAzMDAwMDBmZjlkMDUwMTAzODAwMDAwMDJmZmZmZmZmZmZmZmYN
Cj4gZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZTUyMGY5ZmZmZmZmZmYwNzQ0
ZWIwODZiDQo+IDA4M2I4MGJiZmVmZmZmZmZmZmZmMDBmZmZmZmY0NGViMGMyMDBmNTIxMGQ4MDBm
ZjIzNGFjOTAwODJkOA0KPiAxMWM3Y2NjZDY4NDY3YTc1N2E3NWY3YTJkNTVjNGE0MjJjZmZmMDMw
YzA4MGZmZmZmZmZmZmZmZmZmZmYNCj4gZmZmZmZmZmZmZmZmZmZmZjUwMTk1MDE2OWNmOWMwNjQ4
ZmVjZmZmZg0KPiAkIG1kNXN1bSAvc3lzL2J1cy9zcGkvZGV2aWNlcy9zcGkwLjAvc3BpLW5vci9z
ZmRwDQo+IGRlNGQ2YmU1NGU0NzlkNjA4NTliMGNhOGEwZWU5MjE2DQo+IC9zeXMvYnVzL3NwaS9k
ZXZpY2VzL3NwaTAuMC9zcGktbm9yL3NmZHANCj4gJCBjYXQgL3N5cy9idXMvc3BpL2RldmljZXMv
c3BpMC4wL3NwaS1ub3IvamVkZWNfaWQNCj4gMjU3MDE4DQo+ICQgY2F0IC9zeXMvYnVzL3NwaS9k
ZXZpY2VzL3NwaTAuMC9zcGktbm9yL3BhcnRuYW1lDQo+IHNrMjVscDEyOA0KPiAkIGNhdCAvc3lz
L2J1cy9zcGkvZGV2aWNlcy9zcGkwLjAvc3BpLW5vci9tYW51ZmFjdHVyZXINCj4gc2lsaWNvbmth
aXNlcg0KPiANCj4gMC4gaHR0cHM6Ly93aWtpLnBpbmU2NC5vcmcvd2lraS9QaW5lUGhvbmVfUHJv
I1NwZWNpZmljYXRpb25zDQo+IDEuIFRoYW5rcyB0byBodHRwczovL2dpdGh1Yi5jb20vQmlrdG9y
Z2ogZm9yIGZpbmRpbmcgdGhhdC4NCj4gMi4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjIwNTEwMTQwMjMyLjM1MTkxODQtMS1taWNoYWVsQHdhbGxlLmNjLw0KPiANCj4gTGluazogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzI4ZDM5MjVhLTk4M2EtZmNiOC0xOWFmLTZlNmJhZjg5
MmQ1M0B0b20tZml0emhlbnJ5Lm1lLnVrLw0KPiBTaWduZWQtb2ZmLWJ5OiBUb20gRml0emhlbnJ5
IDx0b21AdG9tLWZpdHpoZW5yeS5tZS51az4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9y
L01ha2VmaWxlICAgICAgICB8ICAxICsNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jICAg
ICAgICAgIHwgIDEgKw0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggICAgICAgICAgfCAg
MSArDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NpbGljb25rYWlzZXIuYyB8IDE1ICsrKysrKysr
KysrKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9tdGQvc3BpLW5vci9zaWxpY29ua2Fpc2VyLmMNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL01ha2VmaWxlIGIvZHJpdmVycy9tdGQvc3Bp
LW5vci9NYWtlZmlsZQ0KPiBpbmRleCBlMzQ3YjQzNWEwMzguLjMxNGFjNzc3MzM2OSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL01ha2VmaWxlDQo+IEBAIC0xMiw2ICsxMiw3IEBAIHNwaS1ub3Itb2JqcyAgICAg
ICAgICAgICAgICAgICs9IGludGVsLm8NCj4gIHNwaS1ub3Itb2JqcyAgICAgICAgICAgICAgICAg
ICArPSBpc3NpLm8NCj4gIHNwaS1ub3Itb2JqcyAgICAgICAgICAgICAgICAgICArPSBtYWNyb25p
eC5vDQo+ICBzcGktbm9yLW9ianMgICAgICAgICAgICAgICAgICAgKz0gbWljcm9uLXN0Lm8NCj4g
K3NwaS1ub3Itb2JqcyAgICAgICAgICAgICAgICAgICArPSBzaWxpY29ua2Fpc2VyLm8NCj4gIHNw
aS1ub3Itb2JqcyAgICAgICAgICAgICAgICAgICArPSBzcGFuc2lvbi5vDQo+ICBzcGktbm9yLW9i
anMgICAgICAgICAgICAgICAgICAgKz0gc3N0Lm8NCj4gIHNwaS1ub3Itb2JqcyAgICAgICAgICAg
ICAgICAgICArPSB3aW5ib25kLm8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gaW5kZXggZmRkZTgwZDlmMzg4
Li5lNTQyZDMwMDk5MTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5j
DQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IEBAIC0xNjI0LDYgKzE2MjQs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9ub3JfbWFudWZhY3R1cmVyICptYW51ZmFjdHVy
ZXJzW10gPSB7DQo+ICAgICAgICAgJnNwaV9ub3JfaXNzaSwNCj4gICAgICAgICAmc3BpX25vcl9t
YWNyb25peCwNCj4gICAgICAgICAmc3BpX25vcl9taWNyb24sDQo+ICsgICAgICAgJnNwaV9ub3Jf
c2lsaWNvbmthaXNlciwNCj4gICAgICAgICAmc3BpX25vcl9zdCwNCj4gICAgICAgICAmc3BpX25v
cl9zcGFuc2lvbiwNCj4gICAgICAgICAmc3BpX25vcl9zc3QsDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IGlu
ZGV4IDg3MTgzY2ZmMzI1MS4uODk5NzA5OWY2YzVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210
ZC9zcGktbm9yL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPiBA
QCAtNjI1LDYgKzYyNSw3IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9tYW51ZmFjdHVy
ZXIgc3BpX25vcl9pbnRlbDsNCj4gIGV4dGVybiBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9tYW51ZmFj
dHVyZXIgc3BpX25vcl9pc3NpOw0KPiAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBzcGlfbm9yX21hbnVm
YWN0dXJlciBzcGlfbm9yX21hY3Jvbml4Ow0KPiAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBzcGlfbm9y
X21hbnVmYWN0dXJlciBzcGlfbm9yX21pY3JvbjsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3Qgc3Bp
X25vcl9tYW51ZmFjdHVyZXIgc3BpX25vcl9zaWxpY29ua2Fpc2VyOw0KPiAgZXh0ZXJuIGNvbnN0
IHN0cnVjdCBzcGlfbm9yX21hbnVmYWN0dXJlciBzcGlfbm9yX3N0Ow0KPiAgZXh0ZXJuIGNvbnN0
IHN0cnVjdCBzcGlfbm9yX21hbnVmYWN0dXJlciBzcGlfbm9yX3NwYW5zaW9uOw0KPiAgZXh0ZXJu
IGNvbnN0IHN0cnVjdCBzcGlfbm9yX21hbnVmYWN0dXJlciBzcGlfbm9yX3NzdDsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2lsaWNvbmthaXNlci5jIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9zaWxpY29ua2Fpc2VyLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5jM2NhMTU3MjQ0YjgNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2
ZXJzL210ZC9zcGktbm9yL3NpbGljb25rYWlzZXIuYw0KPiBAQCAtMCwwICsxLDE1IEBADQo+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArDQo+ICsjaW5jbHVkZSA8bGlu
dXgvbXRkL3NwaS1ub3IuaD4NCj4gKw0KPiArI2luY2x1ZGUgImNvcmUuaCINCj4gKw0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHNpbGljb25rYWlzZXJfbm9yX3BhcnRzW10gPSB7
DQo+ICsgICAgICAgeyAic2syNWxwMTI4IiwgU05PUl9JRDMoMHgyNTcwMTgpIH0sDQoNCkRvZXMg
dGhpcyBmbGFzaCBpbXBsZW1lbnQgdGhlIG1hbnVmYWN0dXJlciBJRCBjb250aW51YXRpb24gY29k
ZXM/DQpDYW4geW91IHJlYWQgbW9yZSBieXRlcyBvZiBtYW51ZmFjdHVyZXIgSUQgYW5kIGR1bXAg
dGhlbT8NCg0KVGhpcyBtYW51ZmFjdHVyZXIgSUQgY29sbGlkZXMgd2l0aCBUcmlzdGFyIG1hbnVm
YWN0dXJlciBJRCBmcm9tIGJhbmsgMS4NCkNoZWNrIEpFUDEwNiBzdGFuZGFyZCBwbGVhc2UuDQpJ
ZiB0aGUgZmxhc2ggZG9lcyBub3QgZGVmaW5lIHRoZSBjb250aW51YXRpb24gY29kZXMsIHdlJ2xs
IG5lZWQgdG8NCmFkZCB0aGlzIGZsYXNoIGluIGEgSUQgY29sbGlzaW9ucyBkcml2ZXIuDQoNCnRh
DQoNCj4gK307DQo+ICsNCj4gK2NvbnN0IHN0cnVjdCBzcGlfbm9yX21hbnVmYWN0dXJlciBzcGlf
bm9yX3NpbGljb25rYWlzZXIgPSB7DQo+ICsgICAgICAgLm5hbWUgPSAic2lsaWNvbmthaXNlciIs
DQo+ICsgICAgICAgLnBhcnRzID0gc2lsaWNvbmthaXNlcl9ub3JfcGFydHMsDQo+ICsgICAgICAg
Lm5wYXJ0cyA9IEFSUkFZX1NJWkUoc2lsaWNvbmthaXNlcl9ub3JfcGFydHMpLA0KPiArfTsNCj4g
LS0NCj4gMi4zNi4wDQo+IA0KDQo=
