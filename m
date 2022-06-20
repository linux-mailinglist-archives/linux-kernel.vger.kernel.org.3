Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D03551798
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbiFTLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFTLnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:43:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7866272;
        Mon, 20 Jun 2022 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655725392; x=1687261392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dyMiZbi5zEbEc8NSdYqDX+mjRBMEm0yQRaTaIP0LyWU=;
  b=iFfad7ClLe4yBEJGXfEyrseaLBDuA5lm6fFP3smJ+SultVLxwzKX/eTH
   FF/pvtRSPuRQF/B4nt17uFEw39geOUL7+DNFdiiNgdCHgQkP/vMzu/BMa
   5hp3L0c56rHC3LSk1FesDfdqB5LbmD08y5qngMvCRPsudNsblC7LHtwYe
   gw/2h8h03kXtsqrAKhc8Koj+nMHYpdlgIKDxXCcODE9yWcpvtqxa1W85V
   z9bvBN0FA8BXkNIDSw5GGQGwaxpldmuTDhStROl5QFlRcBzFVJCWCFXYn
   2nwCsaxdimxUcr83klGZ8ETO4LAE6dViTKcLn1u0FbA2qxh0JOE2MVAdw
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="164142586"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 04:43:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 04:43:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 20 Jun 2022 04:43:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTQd8VHBDMaNTZYMwomp2CDkiPn+7prna8fj9AfAfiYj/LSkCvljJuiAs+YG250rrd740FTx86Hmso/gqTgCjD7JyxzRBskwhSh76JcB2kx+uCGFDaTZxKsZcFsFXRC40vFxWRz8auagau48zAat1jfnWgrdfZ6XRQh0N9JlMjFQ+TfQz/+FY/zOTXZTamFF5p9U4whrFYu2IPnyK+eYAKkPFquhhC5EiM7DTfLrWb9cIABPdPsArkxaJVrAqTSJrfyO5px8p33Vg42Wxypkj/vw91vIXSaZ/czqwIPQ1ixg4/4fgQo1pptSZ492iXMtNmBdNKy2LX1I0kmzNKZzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyMiZbi5zEbEc8NSdYqDX+mjRBMEm0yQRaTaIP0LyWU=;
 b=Brt9DA+1IPkskSe6DFR+WtQtg2Ne8VZVqqFImkjGjezJC+2x6TMNtuR5RRlCHWSmmYZGcp7hfjeeNwLw3NEAzp8lwyudP38JjEYEcQfS65R6Ouo1pewnDRqE/8i+Dtsg/j0vUsNndxFuy0RS2xsWeIJvl4twbWDUQkrx/QsjN1Oa6eP46E0PTRyrebvxUBvNUqEGA8lAcqpXnEe0u+tQCywsqJ9EpMHQGwnNgMtfYlT4qYMW2uoq6aapJkvVTpdSYObMy9NwoJYDsQJkiJm7CAQ9qXkmiBOE8YR9v2wy3RKxzb7PkUTaiH9sKee8bMt4hNIn58MfJDGjV4/eQZ9+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyMiZbi5zEbEc8NSdYqDX+mjRBMEm0yQRaTaIP0LyWU=;
 b=eHlCgw7lR+UK0Jy1VcJflk3AoWrU+ZOLAQLiLUQq1SdSiTroJjqBcLyasiEuSYtUwCdokGCn605pGwZFtij7ZxPAX30kHvP2/6IuxUJuzanQISe2upRhI5QjwVcPkMUfv6jXte9JMc4e9WfZ1negJMXVuBUQGz1boyABfmZtRQg=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by BL0PR11MB3089.namprd11.prod.outlook.com (2603:10b6:208:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Mon, 20 Jun
 2022 11:43:06 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a%9]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 11:43:06 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <Conor.Dooley@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYgktCiqqptpU+dEuWUcG+O1Oj/61UN50AgAABCQCAA/cHkA==
Date:   Mon, 20 Jun 2022 11:43:06 +0000
Message-ID: <CO1PR11MB4865EE8D69EA0F52931A4EAB92B09@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
 <20220617130729.12072-2-kavyasree.kotagiri@microchip.com>
 <1a7fc699-6381-f2db-178f-169bc1ebf064@linaro.org>
 <5f679b6c-9561-1b41-d2bb-ec3d0155d2a3@microchip.com>
In-Reply-To: <5f679b6c-9561-1b41-d2bb-ec3d0155d2a3@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e80b5d8-7526-463e-0942-08da52b20ab0
x-ms-traffictypediagnostic: BL0PR11MB3089:EE_
x-microsoft-antispam-prvs: <BL0PR11MB308912C5B533FBD12AA7FFFF92B09@BL0PR11MB3089.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hr+4vILoW1D/lqlPgRLYwybWohdedmhXisTRaUlFNaFV5hgpNv8zsjEmDXhEUMV0HFfceXfNqT1SgRw87iwwNH4kEtMSgw1/D9LGlbuQXf0ciRn+Dk2lycie4RAovW/rCoJYaec/MPnNQzABkax4p62HFRU8saemF+tGze/N4JEF1xtLSLRnnG0HTInDVvF35YOrW10Bb3N9Do31wbJE+6LGYZG8iexsodJbeVJWwmRJuDrXir4MJQarZHfaQjlq1QovPViTiUFNb/yexAH62f9dwfbt9EjzZ593YBFLLqqxMZd9bYDGjCDxZ/MPCBHwZ+A0OkU634jNSVYDE1w3sFtYEH9jJSGelcSc6g/ONdpwn0bCuTIBymS1VaWEZGLY3KcqzN92XADRcsI7/6Su1y+lorXz4WYxzCE+l+zWZA1QO+CJU15ACUgzlfhw6K5agiAn8oHFQRbUVRJhzoEMGJNwPu88DHfv1UlnZXNvD4SKY2o/K81bKS/gYK7gs7aZYKQJ3+fMM3guRm6dYncgjBGUidHXRTSr9FPCuI8NOSMWVlxxTIzOQmaU7UB2VjreNvf23TQNynsEeqizCCorWlc3BpfoDzKwW69lOvXswQduzQcb2WXgmbArwfzMr9NuWzPUEm+aT76PnbH5PklRJF01ClD7UfdMp+i7yKBxHNBtyt2VkRSDb2odhEcXVpQodVoLbRnuUemoqHs2N22/5dxn04SU+Ia0c+Sm1nGuKECiIUwb34l8ya5SIFLW5qRL5KQJLduJeuLOgaHRz0OkHnsOO/39fXBaHHnP9J8c9FjHUKanecv+zRgp6O2amunWaojRe6OtCOYNhX8wgNygwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(366004)(346002)(136003)(8676002)(66946007)(66556008)(76116006)(4326008)(66446008)(66476007)(38070700005)(83380400001)(55016003)(71200400001)(2906002)(186003)(54906003)(110136005)(316002)(64756008)(8936002)(966005)(478600001)(52536014)(5660300002)(38100700002)(9686003)(41300700001)(122000001)(33656002)(26005)(86362001)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NERJb3pwN2Zib2lXVG9hMFB5cDVKdnhPcEZtL0Fsb2U4ekFFdERWZmc0L3Ez?=
 =?utf-8?B?TDIxUUFscGtSUzJIZkZOZEVnbGRpTXdqc0NialRRNVdhaGN2VEU1anpLNkNy?=
 =?utf-8?B?dW52NGNRcUhieCtxRCtJWXV4aDNsL2FTY2NsYXFZMFZIMVhHOW1OUXN2VkVq?=
 =?utf-8?B?MURyNEFWZ09YeHQ5di93K2NBemdCMk14NTBjbUloaGlpeC9nUkNNM1luby96?=
 =?utf-8?B?NVBBNC9jNUdDWEFVRFRyUkw2UkwvY3RXbGhYa0QrOFJMMzFGTnhxdStVZ1lS?=
 =?utf-8?B?anc3aDBBelU3Ti9vUUROdUZZUkxSL1J1Mi94ajVlZUNQVDlwVFkrUjBuazA1?=
 =?utf-8?B?ZTF3d2FHYUdNdkFlT2lxNklFTGp5TnVIME83NFBsWVk0c3Jmd2VTVEljRldn?=
 =?utf-8?B?dmNLWmZWUjYyYzNLU1JxWENlN2RKalExNElvbVZrbWQ3ODRZaUN1ZDFMVzBO?=
 =?utf-8?B?bkZyek9Zb3V3TE1ITTJWTVNUdzBiMWJ5SFdaTm94K1Vhcmc1aFNWdC9palU1?=
 =?utf-8?B?M29sbm1lZEFMMTF5Q0hBRVkwYXV6MkNaSzVxYzdmYThmN1BlNCtObHVhV1I1?=
 =?utf-8?B?bVVMcVVja2FOc0Q3Wm50T1pydnowUi80MWtiUEpiT0VUcmFUZ3lNYi92eUtv?=
 =?utf-8?B?YzN2ek9HN1V4STVNWlBHK1hacmlsUW00VDZWM0FSS29RLzhDVHpsb0tiSVRa?=
 =?utf-8?B?L3NxNzh5Q0YzcjUvQkVmNmZoczZvaU92bCt6OHVxM1p4K2hJUnpOaGQzMmI0?=
 =?utf-8?B?bW5kUWUySHdYRVhqeHZPTFhEdDhBZHMxMVNjTzQzZ1VTM0hPVENmNHVWZGEz?=
 =?utf-8?B?VmZNQ2VvRUg2U3NQOWhqSkpINi9TZDVqMHRydmFWeUNCQ3FjeXcxNjg1SVlo?=
 =?utf-8?B?dURrTUgwNmJQajZaT0NvRVBMZURQQnBSVW9jNzd5Sm1XOTVrVWt0VEJwTTR0?=
 =?utf-8?B?bXBzVWxSKzBMTnVGWGFxaC9JME5qYWNSd1RPR1lSazdCVzdmbmc1akpnT3R1?=
 =?utf-8?B?ekpXa1hvK2V1d1NCLzZXbnhDTHVsMTkraFdHMkVIaEJHOUxTOEFBcHVqL0do?=
 =?utf-8?B?aDU4K1FkMStHYlhVaGhWNm9HclZObkxYdFlXSXRWTDN6VzQvNFlWbFE0b05r?=
 =?utf-8?B?SEN5MGwzT1RvRHpJTHpQUnA1bFhEbEpId2FxZUtKSFlQYWQ0M3NycmdITlFC?=
 =?utf-8?B?UmlocmQ0bkpscFk4MnV5Y3FBcnpHSFlTSjgvR0F1UW04aVZ0OCtnY1l2aWN1?=
 =?utf-8?B?eEhJa0VibGQ2eDU0WEZNQThQeGRSOHU1amVGM2MyK1BRTlY0a3ZYZXo3THZG?=
 =?utf-8?B?MU95MGtiTDFQNEpWL3pDbjVKSWJmSVJxVkFYckN2M2pCNGJPUjNaY05lRXV1?=
 =?utf-8?B?T0d1TnlGV29RUXFoNEpzMDI1Zzc4b2JHTjM5Qm50WE1JcGoxV3c0MDhnejlB?=
 =?utf-8?B?cjh1Q2dmRnZOMk5jSWlicVR6bzExQXBOY1NLRG41aWlwMjZKemp1L2x1VGFD?=
 =?utf-8?B?alNQalhiRHk4WFgzeTBRdnR1eEgxamR0OHk0Y0lDOVphb0ZxcEJzTXZLbDVR?=
 =?utf-8?B?SEd5YVFFc0U2dlBndmM3WkpJZk83ak1PallLNXlvMzBndnM5UzZrQ3RVSG5E?=
 =?utf-8?B?bnh0NHZxRTJSUjRPcEE1ZzJ4MmRUWCtWQ0ZTNldqckJnTVh6bjZRUXhXcDVE?=
 =?utf-8?B?TW05RTFuYStibWtMaUNXVXpZTXpWOERRdFZMbWd1cmpDckZVbHZBVUlTengy?=
 =?utf-8?B?YkE1TmZOUEtOY0VHeEMzZndaVzVhalBnMU1TRmxLQ3FVRVV0WUM4Wkl2S0JQ?=
 =?utf-8?B?SXc0VGdFckw5dit5NFduREdjZ3NNVllibHlIT1N3M01yKytjMlVaOTlpOUVZ?=
 =?utf-8?B?UDk1VGNvQUVjQmJaU2xhMjBWcDUrbnJ2ZXdEcjlsSXRueit6Qkh4SnNiWm9q?=
 =?utf-8?B?MFdiMjRScjNkUkp5SHVucG1VMEg4MlJJczZwRkc0a285SXNZT0NQbnpZcllK?=
 =?utf-8?B?MnhjcWo5dmt2VDZDTi9nSlErQ1BGeXA3ZEdma2FoNjVzUlo4VVVlV0tMeGNR?=
 =?utf-8?B?MnI3ZytRckdEaDJBY1UvbHJ3TndmcWVpeFE4d3dlM3ZiNzBwSm5ZclJYeFFZ?=
 =?utf-8?B?cnlXRmhENzN2NDd4TnRHTmJxdmtSTGRGOW1qTE9zemIxU2RLNlMzWHRwSVFU?=
 =?utf-8?B?NHhyK09SNEhKWTZFWEFXS3lkTFlPOGxpK2RKcDd0N2Rad2huQVU3YnU4Nnlo?=
 =?utf-8?B?NHpoNit4cTJDbnZYUHdyOUoxM210VVN5U0ZyU3VtSlQwWDZFWStBWW0xK2tH?=
 =?utf-8?B?T1B1TVI5R2lmTFpMLzR0dEZkNmM0ZFhoNStCVnRWVi9haG9Ub1Vsckp6Ulp1?=
 =?utf-8?Q?Uj75JyeF3KbXbEb8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e80b5d8-7526-463e-0942-08da52b20ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 11:43:06.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdF88Xv3gHkIEpWxuQLqOBpFm1Q9kxPzStzPZjeZTnNiy0KEqkU1UTyXPqzCMywMdeVqon+HNBRgXtK8md4TYl4qNlYSJaYY/lOL89yfv3mrbhdAcX9fy9+LA8i9oXZS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3089
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiBDb252ZXJ0IHRoZSBBdG1lbCBmbGV4Y29tIGRldmljZSB0cmVlIGJpbmRpbmdzIHRvIGpz
b24gc2NoZW1hLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBLYXZ5YXNyZWUgS290YWdpcmkg
PGthdnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+PiAtLS0NCj4gPj4gdjMgLT4g
djQ6DQo+ID4+ICAtIENvcnJlY3RlZCBmb3JtYXQgb2YgZW51bSB1c2VkIGZvciBjb21wYXRpYmxl
IHN0cmluZy4NCj4gPj4NCj4gPj4gdjIgLT4gdjM6DQo+ID4+ICAtIHVzZWQgZW51bSBmb3IgY29t
cGF0aWJsZSBzdHJpbmcuDQo+ID4+ICAtIGNoYW5nZWQgaXJxIGZsYWcgdG8gSVJRX1RZUEVfTEVW
RUxfSElHSCBpbiBleGFtcGxlLg0KPiA+PiAgLSBmaXhlZCBkdHNjaGVtYSBlcnJvcnMuDQo+ID4+
DQo+ID4+IHYxIC0+IHYyOg0KPiA+PiAgLSBGaXggdGl0bGUuDQo+ID4+DQo+ID4+ICAuLi4vYmlu
ZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbCAgICAgICAgICAgfCAxMDQgKysrKysrKysrKysr
KysrKysrDQo+ID4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtZmxleGNvbS50
eHQgfCAgNjMgLS0tLS0tLS0tLS0NCj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlv
bnMoKyksIDYzIGRlbGV0aW9ucygtKQ0KPiA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1sDQo+ID4+
ICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21m
ZC9hdG1lbC0NCj4gZmxleGNvbS50eHQNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1sDQo+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4g
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mZGIxNjQ1
ZDEyM2YNCj4gPj4gLS0tIC9kZXYvbnVsbA0KPiA+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbA0KPiA+PiBAQCAtMCwwICsxLDEw
NCBAQA0KPiA+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBC
U0QtMi1DbGF1c2UpDQo+ID4+ICslWUFNTCAxLjINCj4gPj4gKy0tLQ0KPiA+PiArJGlkOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tZmQvYXRtZWwsZmxleGNvbS55YW1sIw0KPiA+PiAr
JHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+
ID4+ICsNCj4gPj4gK3RpdGxlOiBBdG1lbCBGbGV4Y29tIChGbGV4aWJsZSBTZXJpYWwgQ29tbXVu
aWNhdGlvbiBVbml0KQ0KPiA+PiArDQo+ID4+ICttYWludGFpbmVyczoNCj4gPj4gKyAgLSBLYXZ5
YXNyZWUgS290YWdpcmkgPGthdnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+PiAr
DQo+ID4+ICtkZXNjcmlwdGlvbjoNCj4gPj4gKyAgVGhlIEF0bWVsIEZsZXhjb20gaXMganVzdCBh
IHdyYXBwZXIgd2hpY2ggZW1iZWRzIGEgU1BJIGNvbnRyb2xsZXIsDQo+ID4+ICsgIGFuIEkyQyBj
b250cm9sbGVyIGFuZCBhbiBVU0FSVC4gT25seSBvbmUgZnVuY3Rpb24gY2FuIGJlIHVzZWQgYXQg
YQ0KPiA+PiArICB0aW1lIGFuZCBpcyBjaG9zZW4gYXQgYm9vdCB0aW1lIGFjY29yZGluZyB0byB0
aGUgZGV2aWNlIHRyZWUuDQo+ID4+ICsNCj4gPj4gK3Byb3BlcnRpZXM6DQo+ID4+ICsgIGNvbXBh
dGlibGU6DQo+ID4+ICsgICAgZW51bToNCj4gPj4gKyAgICAgIC0gYXRtZWwsc2FtYTVkMi1mbGV4
Y29tDQo+ID4+ICsNCj4gPj4gKyAgcmVnOg0KPiA+PiArICAgIG1heEl0ZW1zOiAxDQo+ID4+ICsN
Cj4gPj4gKyAgY2xvY2tzOg0KPiA+PiArICAgIG1heEl0ZW1zOiAxDQo+ID4+ICsNCj4gPj4gKyAg
IiNhZGRyZXNzLWNlbGxzIjoNCj4gPj4gKyAgICBjb25zdDogMQ0KPiA+PiArDQo+ID4+ICsgICIj
c2l6ZS1jZWxscyI6DQo+ID4+ICsgICAgY29uc3Q6IDENCj4gPj4gKw0KPiA+PiArICByYW5nZXM6
DQo+ID4+ICsgICAgZGVzY3JpcHRpb246DQo+ID4+ICsgICAgICBPbmUgcmFuZ2UgZm9yIHRoZSBm
dWxsIEkvTyByZWdpc3RlciByZWdpb24uIChpbmNsdWRpbmcgVVNBUlQsDQo+ID4+ICsgICAgICBU
V0kgYW5kIFNQSSByZWdpc3RlcnMpLg0KPiA+PiArICAgIGl0ZW1zOg0KPiA+PiArICAgICAgbWF4
SXRlbXM6IDMNCj4gPj4gKw0KPiA+PiArICBhdG1lbCxmbGV4Y29tLW1vZGU6DQo+ID4+ICsgICAg
ZGVzY3JpcHRpb246IHwNCj4gPj4gKyAgICAgIFNwZWNpZmllcyB0aGUgZmxleGNvbSBtb2RlIGFz
IGZvbGxvd3M6DQo+ID4+ICsgICAgICAxOiBVU0FSVA0KPiA+PiArICAgICAgMjogU1BJDQo+ID4+
ICsgICAgICAzOiBJMkMuDQo+ID4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVm
aW5pdGlvbnMvdWludDMyDQo+ID4+ICsgICAgZW51bTogWzEsIDIsIDNdDQo+ID4+ICsNCj4gPj4g
K3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+PiArICAiXnNlcmlhbEBbMC05YS1mXSskIjoNCj4gPj4g
KyAgICBkZXNjcmlwdGlvbjogU2VlIGF0bWVsLXVzYXJ0LnR4dCBmb3IgZGV0YWlscyBvZiBVU0FS
VCBiaW5kaW5ncy4NCj4gPj4gKyAgICB0eXBlOiBvYmplY3QNCj4gPj4gKw0KPiA+PiArICAiXnNw
aUBbMC05YS1mXSskIjoNCj4gPj4gKyAgICBkZXNjcmlwdGlvbjogU2VlIC4uL3NwaS9zcGlfYXRt
ZWwudHh0IGZvciBkZXRhaWxzIG9mIFNQSSBiaW5kaW5ncy4NCj4gPj4gKyAgICB0eXBlOiBvYmpl
Y3QNCj4gPj4gKw0KPiA+PiArICAgIHByb3BlcnRpZXM6DQo+ID4+ICsgICAgICBjb21wYXRpYmxl
Og0KPiA+PiArICAgICAgICBjb25zdDogYXRtZWwsYXQ5MXJtOTIwMC1zcGkNCj4gPj4gKw0KPiA+
PiArICAiXmkyY0BbMC05YS1mXSskIjoNCj4gPj4gKyAgICBkZXNjcmlwdGlvbjogU2VlIC4uL2ky
Yy9pMmMtYXQ5MS50eHQgZm9yIGRldGFpbHMgb2YgSTJDIGJpbmRpbmdzLg0KPiA+PiArICAgIHR5
cGU6IG9iamVjdA0KPiA+PiArDQo+ID4+ICtyZXF1aXJlZDoNCj4gPj4gKyAgLSBjb21wYXRpYmxl
DQo+ID4+ICsgIC0gcmVnDQo+ID4+ICsgIC0gY2xvY2tzDQo+ID4+ICsgIC0gIiNhZGRyZXNzLWNl
bGxzIg0KPiA+PiArICAtICIjc2l6ZS1jZWxscyINCj4gPj4gKyAgLSByYW5nZXMNCj4gPj4gKyAg
LSBhdG1lbCxmbGV4Y29tLW1vZGUNCj4gPj4gKw0KPiA+PiArYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+ID4+ICsNCj4gPj4gK2V4YW1wbGVzOg0KPiA+PiArICAtIHwNCj4gPj4gKyAgICAj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+
PiArDQo+ID4+ICsgICAgZmx4MDogZmxleGNvbUBmODAzNDAwMCB7DQo+ID4+ICsgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLWZsZXhjb20iOw0KPiA+DQo+ID4gVGhlIGJpbmRp
bmdzIGxvb2sgZ29vZCwgYnV0IHlvdSBoYXZlIGhlcmUgd2VpcmQgaW5kZW50YXRpb24uIEkgZG9u
J3QNCj4gPiByZW1lbWJlciBpZiBJIHBvaW50ZWQgb3V0IHRoaXMgYWxyZWFkeSwgc28gaW4gYW55
IGNhc2Ugc29ycnkgZm9yDQo+ID4gYnJpbmdpbmcgaXQgdXAgc28gbGF0ZS4gVGhlIGluZGVudGF0
aW9uIHNob3VsZCBiZSBmb3VyIHNwYWNlcyB3aGljaA0KPiA+IG5pY2VseSBhbGlnbnMgd2l0aCAi
IC0gfCIuDQo+ID4NCj4gPg0KPiA+DQo+ID4+ICsgICAgICAgICAgcmVnID0gPDB4ZjgwMzQwMDAg
MHgyMDA+Ow0KPiA+PiArICAgICAgICAgIGNsb2NrcyA9IDwmZmx4MF9jbGs+Ow0KPiA+PiArICAg
ICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+PiArICAgICAgICAgICNzaXplLWNlbGxz
ID0gPDE+Ow0KPiA+PiArICAgICAgICAgIHJhbmdlcyA9IDwweDAgMHhmODAzNDAwMCAweDgwMD47
DQo+ID4+ICsgICAgICAgICAgYXRtZWwsZmxleGNvbS1tb2RlID0gPDI+Ow0KPiA+PiArDQo+ID4+
ICsgICAgICAgICAgc3BpMDogc3BpQDQwMCB7DQo+ID4+ICsgICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJhdG1lbCxhdDkxcm05MjAwLXNwaSI7DQo+ID4NCj4gPiA0IHNwYWNlcw0KPiA+DQo+
ID4gUm9iJ3MgYm90IGFsc28gY29tcGxhaW5lZCBhYm91dCBjb21wYXRpYmxlLiBBcmUgeW91IHN1
cmUgeW91IHVzZSBoZXJlDQo+ID4gY29ycmVjdCBjb21wYXRpYmxlPw0KPiANCj4gSXQncyBpbiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaV9hdG1lbC50eHQNCj4gU28g
dGhhdCdsbCBleHBsYWluIHRoZSBlcnJvci4uDQo+IA0KPiBUaGFua3MsDQo+IENvbm9yLg0KPiAN
ClllcywgeW91IGFyZSByaWdodC4NCkl0IGlzIGJlY2F1c2Ugb2YgdGhlIHNwaSBkdC1iaW5kaW5n
cyBhcmUgc3RpbGwgaW4gdHh0IGZvcm1hdC4NCg0KPiBDb25vcg0K
