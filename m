Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB6456C235
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbiGHUpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbiGHUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:45:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4C9FE0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657313140; x=1688849140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VgO9MaUxmijwbj4ErfoEx1eZxF4iJcn2sE5GRcKqBic=;
  b=mbFUtnqG4oUFav/xGEHDcPxWNIIfNtbdsmY93Lk91N8p36SLiItij67f
   aJPR+uN9gvR63leo9FcZUB+t0V6iCR3KA8O6uVCROwCqmVKMq/01pqvoI
   x+nmWiuwGFuvYyU79k8iwvPWJFfuOVVRu3aj++p27fHwtjcyktMIOUwSS
   kaOI8F0g2ohin9U8g3Uq0FVKmQyRVSs7RscCTgkMm7siQLagFvFA7eZ43
   pa9T7jqf59WuZ88NguuIRlMMT9ne4tCP6x3v2qObdc4ajvT8GNZula0qP
   Cb14aokMJk6rQP9Q+1bufF9EFwOLYQNu2GEk5jqaCiz6RkwBqAC1Lvtlz
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="171385617"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 13:45:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 13:45:37 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 13:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8KNlDc3cV0DLywCiVyl/SyfKCyx3S8+IcSaANy8uFecpMdFhEviZA05348HsrpenXIr9H3RH0L27MdBbswBw1wiR1hp2k3lNr8A1dYU1gMzfbfz1tt38IjHQBLD/m9c0ZcdyBDF+DdN4mmg3kLUclmkUiYllp0CxEz3RSELzUnDetsax/KIHMIzUuM4sxqvMwsC8Wzq+eS7k5RhkmP1mFoIZ5E+S5PAqo4H3mqEFzH9Z2DAxhZz/0ziNWkwK7fI3S8vWw76LhuggpnBZySrA3oRGGk0DN6gTf7DxkSMx/NY24+g7Jh0mslCjBsvfRVjoz8plZW9ugXNIra4NAeYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgO9MaUxmijwbj4ErfoEx1eZxF4iJcn2sE5GRcKqBic=;
 b=TVc3/IN4LELeqzIzUo/M+mwpKfvvK7Bz9gdawgINKQuTpUnefMDB+v1VwCTb4cRUMZIFtJIUDdUU3iafxcvAtoEoM5uk6Bqid19avLX2eaMf6ZfAGLXrmLJyq348Gyx12JtMUyrmTzQi8+pPhTEG/rtIqe7C1/lxY4I6EHX3BdzJtLH0oSWdPYes6taVX7SfamtEjcTJ3PGmKhlZQLLdStZOjLuqvex1W0ruH7hQ13U+f91gLJw9YmOl2ViUY2nXSuAxih0PPGNVgGbrMVG188/E0FfiQqJvIiCfu8a6DYOq+71e0i/45awEUDbHD+lu714urm62Dhlh7O2usryjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgO9MaUxmijwbj4ErfoEx1eZxF4iJcn2sE5GRcKqBic=;
 b=OoBAr6sP3QvKIwgHlbTm7QfOE6RvUCPsSdcz4hEVAakCGB01+Pryz2CL0ZHo2UrEIsDjtIboTJ0qYgfd3FOjyRzUn7E8zVFSYCifvTVgQbi+0z5lAkLZJB3KJZ2cStlCmP68QEwwhp+zBfco6pc4TuCTCrg6+RzISmNwrs8drjE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1519.namprd11.prod.outlook.com (2603:10b6:301:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 20:45:31 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 20:45:31 +0000
From:   <Conor.Dooley@microchip.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC:     <Daire.McNamara@microchip.com>, <Conor.Dooley@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v2 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Topic: [PATCH v2 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Index: AQHYkwoSKn1B1/DCVEW+Ox2TaLu0fa108T4A
Date:   Fri, 8 Jul 2022 20:45:31 +0000
Message-ID: <fb8534d9-baaa-2643-5119-602dfa5de758@microchip.com>
References: <20220708203342.256459-1-mail@conchuod.ie>
 <20220708203342.256459-2-mail@conchuod.ie>
In-Reply-To: <20220708203342.256459-2-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca800dab-611c-4873-9161-08da6122cc6c
x-ms-traffictypediagnostic: MWHPR11MB1519:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TY8PiGtaQ8s6C2Abq7oQ4aPuWpz5FXnxc1pURFpKbcAIWIEBclBKTBABgYPAGdAQ1w1FnF/b99c4d59S1m1+HtXcHAr7gWcabb8UX6BpCO0XWy1e4d8/yCGMuTNBJRDwBWRruYHDioa5/Nwe133ilOkJC4Z7+Gz87A1hZtaWPSpu8+2OBrYn/BOoGURAwuNTVPL/rAA8mTJl8AtxzkOCvbKL8fcOfGKFd9gFsq/oEPU1MNUibvFSGGGzzYmPKQyNwbH5vKVoM6ZizWHAJJlLpDxweUYcnqvbyFFLVxeJy6zDbY+bsjYx75bRkVsjEqufSk2F1iAFitZaNdG49kX99kTIfWBzUs2zTj9ucYVWI5FXFiAzudWQypsaxdx4d4el/UQrTZZTodSFUs+/nc/CwHMZTgeJKKTYv6X4S3YZ/QvCXNxOh6K/sXAfhRCWx0ms9uFLk+OkkHHRtpBaeXA0BUF+41OFY2K7UEUHx/nyA4tY+2kdSa5rg+VVqTB8okoUQ8ylBlDYZNaoWcNBHDOE8ZhmOwz7wIFXG0KXoeAD4rLhMAN360zP5iDGPb51md8azde+wTEMb5QOA0b8m/Zyo1e5pKA3bhCQluGL+vijZ1kxgpMNNxhJwPBzemt5I8EVDMW1Z9Y0+VL2YLAzOUKpskaVRY5VXP0u/U4Q5vjZCbH1TG+PxssU+aN8UbhptIx/+z/Xhz+rtCEilqT2Dxan0AuoBcoHVJWR/xkLDcYzOXcRTwPECfriLvDJGwaMyL7sbnDBRQtleKzSa1/2LBnY5wH7ftknWm9lvmYLSWrD7z2jxq1XL3Z0G0/Xl+F73rJZEL9HU3KoKsD+z+QQznDQUhsgKLj0Lu2ssPBM0O8WNJ8HdXPnUepjxxPC1N5l+sfG8BpoVDtfL1L66sv6nNSD6QvFu7RrGhyI8dtCaTyelJk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(39860400002)(396003)(136003)(8936002)(7416002)(5660300002)(31686004)(110136005)(83380400001)(2906002)(41300700001)(6486002)(966005)(36756003)(71200400001)(64756008)(4326008)(76116006)(54906003)(316002)(8676002)(478600001)(66946007)(66446008)(66476007)(91956017)(66556008)(53546011)(6506007)(2616005)(6512007)(26005)(186003)(38070700005)(122000001)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXVSNnN5T1VaSEkvMUhkVEYvdmdBYm9HL0xSQVBHQWxEaUFsU3F0dWg1cXlm?=
 =?utf-8?B?Tm9oZ2FkL3RFTVFQSnUxTDlrR2dhajFtK21ST0FieHd3UEhoRWVSLzd5dzdW?=
 =?utf-8?B?WFFsRUhSeG1TbFEydnBYejdvcXUyb2RvdjZpL1dCUGpobEVkQzAraVlQZ0hD?=
 =?utf-8?B?NnVzbStKdFZMZXhCUzdoYngraUJsZ05rb0xZWmNMR2FiYjFMaS8rTUQ5T09B?=
 =?utf-8?B?djM4RDdKNllMdHdpY0l3d1hSRFdady9UdEJYbVlTSjBWaktnSkc3Q0tURnc0?=
 =?utf-8?B?S3lFbTZJakN2Y09ibDdqQkt5SkZzMXZ4d01EYURVWThYblVMUjJQZFFmak5r?=
 =?utf-8?B?SEFXY2d2SjdDaG0wbnBBV0xiSDhUeEZyejVhc3hhVEZUQi9icTRaR2ovd3or?=
 =?utf-8?B?QXNSK3BuQzFlaVFyd1FZdDE4QXF5SGFkR3FYekhhUjl4TEdnbnBDbzRsbVJD?=
 =?utf-8?B?NDNRVHVlY0NiSHlHRVdYZXVIK3RjcUZvZWJLVnJNS0EvNURRaXAyczZrMTRl?=
 =?utf-8?B?RWJYWW1DaDlKZ0psTytYL2ZqckFQT0VpZFNSUnY0amRGZ1FTdmtNTmVSd0RU?=
 =?utf-8?B?dkZtaHBZSjBwRE9NQndHUzZiZi9QQUdmRVdST0xRK3JvMng0djJxd05PdVhi?=
 =?utf-8?B?TmxBL3ZLNmxkbjdzZDAzQTZJbHNMRXZncWlUbG9xVmNxa3NyS1JxRkp2eExE?=
 =?utf-8?B?bnZ5Y01FSS9jTlZGUHBNcnhtc1VmRytJSURkNWk2Ynowbk1TRjBHSlhGak5S?=
 =?utf-8?B?aE1VY0FVSGFQeno2TE5XYVlHOXJCek5pWDZQcTFSZDFNeWI5L0h0RlJpT2ZS?=
 =?utf-8?B?bGJmRmgzcVNPRDlZMzY3WEJQZlJhODA0cHVrbU96dFRCYVNVd3dvcGZpTG5F?=
 =?utf-8?B?RzRMOGp3Vkk0T2pVRmpYdnVIWTlXbFNMRGxESGJ1WnZkY0Z1ZkdtRzZNRUp2?=
 =?utf-8?B?azlvcVZkNUVoN3ZtUm1Fa3VQc0thcDNjMkovTDNpWnhKbmdQQ29mamt0cmhz?=
 =?utf-8?B?U1U4TDEwU1FPS2c2elZuNkFJd0U0dFFWbUozTFltNWxTNkdPZzQvSGtUR0ZY?=
 =?utf-8?B?clhteWQ2NmJYV1pGTXpXdkVzRkY1dGdaZGVsK3dVZldlVGhZRzArN1NuSmg1?=
 =?utf-8?B?bStjaG1FQ2xrVUl2MTZqWWZhYS9XVVVkVG05YzluVVY1dTk4SzBITi8xSGdm?=
 =?utf-8?B?QmJUMng5VElEZVpQSW5JVE5nYnhhQW9aVHFFb1BWQnAwVFRqZEVqeXZvaklM?=
 =?utf-8?B?S0U2Wlozc1JBcTM2YTRpSzdNQktyb2ZxV2pkQmwwWSswRElHY3lDb1hCYTdo?=
 =?utf-8?B?UmtCYjZnTEZtaEJXdWMrZkVyTjVtLytUdnRpWWRMTmI0TGd1ZHNQZjF3L01R?=
 =?utf-8?B?M3RTd3lzT1BVYmsxNDgrbGljd04yaG1pdUN0Mi9rb0JQQ0xxSFphOTREWWRw?=
 =?utf-8?B?eEpNbUVYTzZsSjJXQ3lIUXlxa0JrcDY4MXdMbVhPQmdzd3oxQWs5RWlpYXJJ?=
 =?utf-8?B?anJuYzFDUnRiZXkvYTc4WUZqMkU5WHhUOGQ3RThCd1dWdnoxWkxQUERJcVU3?=
 =?utf-8?B?MEVNcUtZL25ZSFA1ZW4xc1JRRXQzSG4wT1E0UWx3YXZzMmtaOUw4aDJ4L01M?=
 =?utf-8?B?V0hHYXhlS01mU2h6M0Jtdytiak5Ic095Wk85Ykkvc2s5dDFsUmlpYi9scFpQ?=
 =?utf-8?B?eHdLbEhIR2Z2RWRNUFdPdEprZVQyNm4rUXM2eVlyYWxSZVovQjdkbUx4cG9t?=
 =?utf-8?B?YWMxTTlub3N5VnIzQlloNlQ0WXdhcVl4YnArOTRlWHMyUHZCRUZHZlVSTzRr?=
 =?utf-8?B?a2dXbmlkZ0cxMjRGYUVMeStTYXZZNFllR2pwM0lUZCtYUlZCVEtCYVF1WXVa?=
 =?utf-8?B?T1JPSHRrSlFWam9IVHB5UU1yRTNSTlFVWVZUa3hDSXZDYjhabzNnWVhjUGQ3?=
 =?utf-8?B?SHZIaWZCZUkrMU9XMVBURGU1QTlUdWRBS0U3UmxwL1RXdzVVcUY1bFV0dnhy?=
 =?utf-8?B?NGJCMmpLZ1J4TFZHMVBIa0VuS296TzJqRHd1Y09IVVltNjNKb0dxTG9ybTBv?=
 =?utf-8?B?aTRLMGg5aVZnTG81d2FJUndxbHVJZ2VNUDVZUklwS0lwWWo1UnBIQnMyRnZt?=
 =?utf-8?B?SHYxS1BIb1p1cDRIbUdRL2syQ29pdXZuSEdLMFhKU1EwYmp0UUpQeldwSnRO?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E0A007B1AF02943BB1FE137E7D9B999@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca800dab-611c-4873-9161-08da6122cc6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 20:45:31.2640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHzoHLkqYccOJtnsbGFvm9vHIWLIVEsohP/zBzF6ZEqGfk5onbbbqMyzWpZ6uGRk/bPJ55z0wH6c/xr5DpnaLlVIxqXWsi/zlFl5opc2udk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1519
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzA3LzIwMjIgMjE6MzMsIENvbm9yIERvb2xleSB3cm90ZToNCj4gRnJvbTogQ29u
b3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gDQo+IGFybTY0J3MgbWV0
aG9kIG9mIGRlZmluaW5nIGEgZGVmYXVsdCBjcHUgdG9wb2xvZ3kgcmVxdWlyZXMgb25seSBtaW5p
bWFsDQo+IGNoYW5nZXMgdG8gYXBwbHkgdG8gUklTQy1WIGFsc28uIFRoZSBjdXJyZW50IGFybTY0
IGltcGxlbWVudGF0aW9uIGV4aXRzDQo+IGVhcmx5IGluIGEgdW5pcHJvY2Vzc29yIGNvbmZpZ3Vy
YXRpb24gYnkgcmVhZGluZyBNUElEUiAmIGNsYWltaW5nIHRoYXQNCj4gdW5pcHJvY2Vzc29yIGNh
biByZWx5IG9uIHRoZSBkZWZhdWx0IHZhbHVlcy4NCj4gDQo+IFRoaXMgaXMgYXBwZWFycyB0byBi
ZSBhIGhhbmdvdmVyIGZyb20gcHJpb3IgdG8gJzMxMDJiYzBlNmFjNyAoImFybTY0Og0KPiB0b3Bv
bG9neTogU3RvcCB1c2luZyBNUElEUiBmb3IgdG9wb2xvZ3kgaW5mb3JtYXRpb24iKScsIGJlY2F1
c2UgdGhlDQo+IGN1cnJlbnQgY29kZSBqdXN0IGFzc2lnbnMgZGVmYXVsdCB2YWx1ZXMgZm9yIG11
bHRpcHJvY2Vzc29yIHN5c3RlbXMuDQo+IA0KPiBXaXRoIHRoZSBNUElEUiByZWZlcmVuY2VzIHJl
bW92ZWQsIHN0b3JlX2NwdV90b3BvbGd5KCkgY2FuIGJlIG1vdmVkIHRvDQo+IHRoZSBjb21tb24g
YXJjaF90b3BvbG9neSBjb2RlLg0KPiANCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4N
Cj4gLS0tDQo+ICBhcmNoL2FybTY0L2tlcm5lbC90b3BvbG9neS5jIHwgNDAgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5j
IHwgMTkgKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9u
cygrKSwgNDAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJu
ZWwvdG9wb2xvZ3kuYyBiL2FyY2gvYXJtNjQva2VybmVsL3RvcG9sb2d5LmMNCj4gaW5kZXggODY5
ZmZjNGQ0NDg0Li43ODg5YTAwZjU0ODcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVs
L3RvcG9sb2d5LmMNCj4gKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvdG9wb2xvZ3kuYw0KPiBAQCAt
MjIsNDYgKzIyLDYgQEANCj4gICNpbmNsdWRlIDxhc20vY3B1dHlwZS5oPg0KPiAgI2luY2x1ZGUg
PGFzbS90b3BvbG9neS5oPg0KPiAgDQo+IC12b2lkIHN0b3JlX2NwdV90b3BvbG9neSh1bnNpZ25l
ZCBpbnQgY3B1aWQpDQo+IC17DQo+IC0Jc3RydWN0IGNwdV90b3BvbG9neSAqY3B1aWRfdG9wbyA9
ICZjcHVfdG9wb2xvZ3lbY3B1aWRdOw0KPiAtCXU2NCBtcGlkcjsNCj4gLQ0KPiAtCWlmIChjcHVp
ZF90b3BvLT5wYWNrYWdlX2lkICE9IC0xKQ0KPiAtCQlnb3RvIHRvcG9sb2d5X3BvcHVsYXRlZDsN
Cj4gLQ0KPiAtCW1waWRyID0gcmVhZF9jcHVpZF9tcGlkcigpOw0KPiAtDQo+IC0JLyogVW5pcHJv
Y2Vzc29yIHN5c3RlbXMgY2FuIHJlbHkgb24gZGVmYXVsdCB0b3BvbG9neSB2YWx1ZXMgKi8NCj4g
LQlpZiAobXBpZHIgJiBNUElEUl9VUF9CSVRNQVNLKQ0KPiAtCQlyZXR1cm47DQo+IC0NCj4gLQkv
Kg0KPiAtCSAqIFRoaXMgd291bGQgYmUgdGhlIHBsYWNlIHRvIGNyZWF0ZSBjcHUgdG9wb2xvZ3kg
YmFzZWQgb24gTVBJRFIuDQo+IC0JICoNCj4gLQkgKiBIb3dldmVyLCBpdCBjYW5ub3QgYmUgdHJ1
c3RlZCB0byBkZXBpY3QgdGhlIGFjdHVhbCB0b3BvbG9neTsgc29tZQ0KPiAtCSAqIHBpZWNlcyBv
ZiB0aGUgYXJjaGl0ZWN0dXJlIGVuZm9yY2UgYW4gYXJ0aWZpY2lhbCBjYXAgb24gQWZmMCB2YWx1
ZXMNCj4gLQkgKiAoZS5nLiBHSUN2MydzIElDQ19TR0kxUl9FTDEgbGltaXRzIGl0IHRvIDE1KSwg
bGVhZGluZyB0byBhbg0KPiAtCSAqIGFydGlmaWNpYWwgY3ljbGluZyBvZiBBZmYxLCBBZmYyIGFu
ZCBBZmYzIHZhbHVlcy4gSU9XLCB0aGVzZSBlbmQgdXANCj4gLQkgKiBoYXZpbmcgYWJzb2x1dGVs
eSBubyByZWxhdGlvbnNoaXAgdG8gdGhlIGFjdHVhbCB1bmRlcmx5aW5nIHN5c3RlbQ0KPiAtCSAq
IHRvcG9sb2d5LCBhbmQgY2Fubm90IGJlIHJlYXNvbmFibHkgdXNlZCBhcyBjb3JlIC8gcGFja2Fn
ZSBJRC4NCj4gLQkgKg0KPiAtCSAqIElmIHRoZSBNVCBiaXQgaXMgc2V0LCBBZmYwICpjb3VsZCog
YmUgdXNlZCB0byBkZWZpbmUgYSB0aHJlYWQgSUQsIGJ1dA0KPiAtCSAqIHdlIHN0aWxsIHdvdWxk
bid0IGJlIGFibGUgdG8gb2J0YWluIGEgc2FuZSBjb3JlIElELiBUaGlzIG1lYW5zIHdlDQo+IC0J
ICogbmVlZCB0byBlbnRpcmVseSBpZ25vcmUgTVBJRFIgZm9yIGFueSB0b3BvbG9neSBkZWR1Y3Rp
b24uDQo+IC0JICovDQo+IC0JY3B1aWRfdG9wby0+dGhyZWFkX2lkICA9IC0xOw0KPiAtCWNwdWlk
X3RvcG8tPmNvcmVfaWQgICAgPSBjcHVpZDsNCj4gLQljcHVpZF90b3BvLT5wYWNrYWdlX2lkID0g
Y3B1X3RvX25vZGUoY3B1aWQpOw0KPiAtDQo+IC0JcHJfZGVidWcoIkNQVSV1OiBjbHVzdGVyICVk
IGNvcmUgJWQgdGhyZWFkICVkIG1waWRyICUjMDE2bGx4XG4iLA0KPiAtCQkgY3B1aWQsIGNwdWlk
X3RvcG8tPnBhY2thZ2VfaWQsIGNwdWlkX3RvcG8tPmNvcmVfaWQsDQo+IC0JCSBjcHVpZF90b3Bv
LT50aHJlYWRfaWQsIG1waWRyKTsNCj4gLQ0KPiAtdG9wb2xvZ3lfcG9wdWxhdGVkOg0KPiAtCXVw
ZGF0ZV9zaWJsaW5nc19tYXNrcyhjcHVpZCk7DQo+IC19DQo+IC0NCj4gICNpZmRlZiBDT05GSUdf
QUNQSQ0KPiAgc3RhdGljIGJvb2wgX19pbml0IGFjcGlfY3B1X2lzX3RocmVhZGVkKGludCBjcHUp
DQo+ICB7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jIGIvZHJp
dmVycy9iYXNlL2FyY2hfdG9wb2xvZ3kuYw0KPiBpbmRleCA0NDFlMTRhYzMzYTQuLjA3ZTg0YzZh
YzVjMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9iYXNlL2FyY2hfdG9wb2xvZ3kuYw0KPiArKysg
Yi9kcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jDQo+IEBAIC03NjUsNiArNzY1LDI1IEBAIHZv
aWQgdXBkYXRlX3NpYmxpbmdzX21hc2tzKHVuc2lnbmVkIGludCBjcHVpZCkNCj4gIAl9DQo+ICB9
DQo+ICANCj4gK3ZvaWQgX193ZWFrIHN0b3JlX2NwdV90b3BvbG9neSh1bnNpZ25lZCBpbnQgY3B1
aWQpDQoNCkFoaCBjcmFwLCBJIGZvcmdvdCB0byByZW1vdmUgdGhlIF9fd2Vhay4NCkkgd29uJ3Qg
aW1tZWRpYXRlbHkgcmVzcGluIHNpbmNlIGl0IGlzIG1pbm9yLiBJJ3ZlIHB1c2hlZCBpdCAod2l0
aG91dA0KdGhlIF9fd2VhaykgdG8gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9jb25vci9oL2FyY2gt
dG9wbyBzbyBpdCdsbCBnZXQNCnRoZSBsa3AgY292ZXJhZ2UuDQoNClRoYW5rcywNCkNvbm9yLg0K
DQo+ICt7DQo+ICsJc3RydWN0IGNwdV90b3BvbG9neSAqY3B1aWRfdG9wbyA9ICZjcHVfdG9wb2xv
Z3lbY3B1aWRdOw0KPiArDQo+ICsJaWYgKGNwdWlkX3RvcG8tPnBhY2thZ2VfaWQgIT0gLTEpDQo+
ICsJCWdvdG8gdG9wb2xvZ3lfcG9wdWxhdGVkOw0KPiArDQo+ICsJY3B1aWRfdG9wby0+dGhyZWFk
X2lkID0gLTE7DQo+ICsJY3B1aWRfdG9wby0+Y29yZV9pZCA9IGNwdWlkOw0KPiArCWNwdWlkX3Rv
cG8tPnBhY2thZ2VfaWQgPSBjcHVfdG9fbm9kZShjcHVpZCk7DQo+ICsNCj4gKwlwcl9kZWJ1Zygi
Q1BVJXU6IHBhY2thZ2UgJWQgY29yZSAlZCB0aHJlYWQgJWRcbiIsDQo+ICsJCSBjcHVpZCwgY3B1
aWRfdG9wby0+cGFja2FnZV9pZCwgY3B1aWRfdG9wby0+Y29yZV9pZCwNCj4gKwkJIGNwdWlkX3Rv
cG8tPnRocmVhZF9pZCk7DQo+ICsNCj4gK3RvcG9sb2d5X3BvcHVsYXRlZDoNCj4gKwl1cGRhdGVf
c2libGluZ3NfbWFza3MoY3B1aWQpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBjbGVhcl9j
cHVfdG9wb2xvZ3koaW50IGNwdSkNCj4gIHsNCj4gIAlzdHJ1Y3QgY3B1X3RvcG9sb2d5ICpjcHVf
dG9wbyA9ICZjcHVfdG9wb2xvZ3lbY3B1XTsNCg==
