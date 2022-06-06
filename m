Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDA753E822
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiFFN0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiFFN0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:26:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4D74EDFD;
        Mon,  6 Jun 2022 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654521963; x=1686057963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6CdEwPlPlz9rlXIvnbFZPpZQaUBsS39SOREkG6ra3Cs=;
  b=qT1NL0G9qn5p6UiwYzaRTznK0FsaReGgL1aDKqydtrvyzIPveFkSVbxS
   aSO4Cb3+FtfBD/d5H5u5HOqt5fKpxPhEZmxrLgeB/gT8lZ/c6JT9gmXBG
   25tNwT3jvqb2Oy2ZtD5eIb+NvhkWsV/2o8lLyYCTXdPxUQgP/hOQis8YR
   gXe8yxpIa12rbMdswfSaXzF6ii7fTGua2L0UhkrOlT1W5LpZ2++2XDEXr
   XfplgeOLjNYDcy/qdkbcnnbCLiW2HVBtnXVgsCnMWAt1pXPjeFSYAmyR0
   7kjEOC67mEMV6twsWZN2+XoUNlrexXJqigfdt9e8Nll8SdI60aOMwPXAG
   g==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="98736731"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2022 06:26:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Jun 2022 06:25:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 6 Jun 2022 06:25:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbY0sRssFvtwg13f+eVS9m9btyPkMmEL7fHhfJVvtq0sn/IbKJj0j/A7YS7a2Pc8wQM2famowQcovqy/VRHCzTVQX5XWxhBSZYMRCI6RupbPqjxReuPCLqkMCl6Zi2LpPdc7nZo550mu89NiIACtuk6S9ttcFtz8LN/vLMVUCJGwp3cf301rhTXNxxH/3imC/I8sbztPnsvZbOp4EJIxE00xy/T8ak8GAKxsmRYjTBMyuLxJRzYkEnALmCLC0BIRtZpXrhO44Fnfsdm9GFxH8wUcblyeUS15PjxE0iFK8pMSNv4vs2FhaSEO9axaMUL1Ah2OD2HarX3GjS9yY37c2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CdEwPlPlz9rlXIvnbFZPpZQaUBsS39SOREkG6ra3Cs=;
 b=DCdKbptxNYQIx7NtvRGZR4Z3BxliFgdUK5LC+nqQE47KoD8vQYuwOc7EfIhGdaMlg47HjIUbqYkufSmAORi+axcOtV4dggHyGW9gbmzD4lGgeBMx/QtHf6OE26YLcRhzsPnCevEUbfOmH62R2fJGqVVV2IGSX9JVK6UNVOf3F/OezduSvvS1CKREAzYbAJgRfMX0ZmW34tbTvvRo2VMmAdqNGNd5BzvW7yJW6TKdXAWOdOpxuZX1oAL0i0VSMkR2+4331z9Gy+j0Lw7wIIzlAplr91NFXModScBLWMkrw2Y0ag5myEMQFu4vQsW16+I8fYc+Lgq5fPb8yl7Euv+INQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CdEwPlPlz9rlXIvnbFZPpZQaUBsS39SOREkG6ra3Cs=;
 b=HSDjMpSuoDEdnBbe29hn1wURoohBnOGPxO2leMc2OlmDCT4Q6/PSuke4kKBeCNxetki+B5qe3Lm0jVZGavyHCeK02ZGK9S6zdZYECX3KErXALgxShdj5QrLyNxd6ZQ/q7/cqd/ID8y1bWFcWZvxIkv8DvYXl/GdKyZvBvSqDK2s=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 13:25:47 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::ed35:677f:b973:ac96]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::ed35:677f:b973:ac96%8]) with mapi id 15.20.5314.017; Mon, 6 Jun 2022
 13:25:46 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYd0Qh7YtNtR/jxE2kV4m9yLBHUK1CXHeAgAAEzDA=
Date:   Mon, 6 Jun 2022 13:25:46 +0000
Message-ID: <CO1PR11MB4865475C31FACD142BB9752592A29@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-2-kavyasree.kotagiri@microchip.com>
 <ba24037d-8c31-ea35-6fc9-ed8a61118848@linaro.org>
In-Reply-To: <ba24037d-8c31-ea35-6fc9-ed8a61118848@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab8397d0-bd40-486a-1282-08da47c010db
x-ms-traffictypediagnostic: CO1PR11MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR11MB4801172F02344D3111C2789D92A29@CO1PR11MB4801.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G3IR8h8O3ulpCMlbybUnKIojv8YIVsEsQXD3HDkb+OUHK1rg6UlwMhZrsjsi7IZcuSv5fng2nl3O5c0zYXn3XA718V38WYz3K2CnLqbNBsNlZag2zCHqG9qna+yxTomfFEgZumq3fNCUmYKjLGjIM8eCsNwzooUmYWITZYV+gvmAzwOdRRaLLtZ5iwdQDG3vDj+B3HhSS9KA7WVwf//e6A4b2tf+WIl9hGVTwAD5g4E3CueBi8MVoIKetp5+xg6x9VwfEeSFuVrliZ1NQTHkplpvWWtoGzYVIg5p5bhu4TOJS8mKcW0mSKfR+64fXc51HLscqe94sPHnZDJISe/DpsDJWQQqTrmEcXYsD3to8DDdMODbqIgPq/aUVBii8WuYal7RTAHGQOYFp1V/wm3/S4bMs1RPeBZpGNC3YXgpMSmdpTEumCkhvNLtjSp2kL/pB1CWCh3bGfEkgx36DhYPLiIFYc7X7Smo18fRuEO4u6ZqiW583eykOKqajbajy+bKgH+iBXXBQEUfjl0ShlIm5hPVjykvggH23mWeGC+2Avc9lXgF9Q/dxhIHyQ93ER+LrfDKYjO+9ErbV3WKjYTDb1RatQszeQ7sh/mx6b7VRmjLhhl9om4QmxTeWBI0o9b2+qJhajSQf7VA3Uw/+vmDtIUaK9LEaDPbamjBlLn7vcN6KmW7taGmVHIN6FmdOZqrrxu/oKqLvZ8hhB9+wpl9kdXgxsuMHX4GhWdV9AStAv58L7apmZALJ3tfAEMxvbx39sv0ETX4CZuddPBmrig4FKSX+4lgSYPqLrBGPZsb6oeKiw9ZO2euckgMI/E8xQ060y2wUmEY61qbf2W+S/cNKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66476007)(76116006)(54906003)(8936002)(38100700002)(64756008)(110136005)(6636002)(71200400001)(316002)(66946007)(5660300002)(38070700005)(26005)(122000001)(9686003)(55016003)(8676002)(4326008)(66556008)(52536014)(7696005)(6506007)(83380400001)(33656002)(508600001)(966005)(186003)(86362001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFJzNHA0ODJZRTRIa1NHZFpLbGRNSEtVL0RRUVBlRTRCZEgvdkF2NWtNRmJu?=
 =?utf-8?B?UFd3cDBrYVdGZUxCYVF0UXRZbnNTajI1WWc1SkIreUg1SEIxT3FGK1k4WU9o?=
 =?utf-8?B?TGFmZWczUFNYemNXU2hteGRINlhwWnEwM1RIbkl2emlLYVBpaTBZT1A0UEhO?=
 =?utf-8?B?aS93YVFuc2NEbkFCZDVURjE2ZVNLNisrWEZVSThlTzBLTXpqaXZZVFgyZGtX?=
 =?utf-8?B?blNPRWJGdmFSelNkeTlkQjNIZGdzZ000N0dMQXBlQUMvVzVrSUc3NGZTUzBr?=
 =?utf-8?B?c2I0KzNpWFNHd05KSE1SSTFIZWIxOUlRSm1ZSDlraXhwNDN6ZGgwbnpRSG9C?=
 =?utf-8?B?Vk9OYk1MTDBqdnpETGV1STVnMjlQbFJEdmdLR28yOGg5QVBlMUJTZWdrNWpm?=
 =?utf-8?B?RCttNVZ4NTI0aDRLK0VFRnpvRG5TSythVFJnRG5uSkhXKysvMzUvODlWNm5t?=
 =?utf-8?B?MW1UN21lUnFIVmNTN1FMUDkzTFJmejhXNXBoeVVnWnp6TmRoMktwYzJRUSta?=
 =?utf-8?B?emJSL1VpNm1OMlRCS1JQc1R0U2FnL2RUT2ZGck5jaXNsZFU5SWp0WndTVS8x?=
 =?utf-8?B?akxPMlU5ZG1Ha0RVTmNTQUYwK2xab3VEN2NMTVVCTlV5dS9oVzNrN0I5bVFm?=
 =?utf-8?B?QzkxMnkvUEtPUkJKNmxkVlJ1V29WVVpRSkJRbnZSSDdwNjI4Y1JlS0w4cHNw?=
 =?utf-8?B?SjV2cjA2WEJBRzZsc3A4N0VLZWRmWGxSaWtHUjB6YnhNbTIvc3RFWDIzVGxi?=
 =?utf-8?B?Ri94SnN1UTN4THRVRnZNNEl6SCs2eUpMbFdkT04rVmpBUzdORi9Qem1NYk0r?=
 =?utf-8?B?SmhoZ2FMb0duTmRIeDhwUmswLzFrNVZrNzlvWG9wamhOMC8zTXNjWkFzd3Uz?=
 =?utf-8?B?eXFhTjl3SFJYOHVUYmFRZlpQWWVPN2NpaHIwaVJKWThOaWlUZGJuNnVyZE02?=
 =?utf-8?B?RnNvQmpVMTRhblNiaGNrcHhIUHF4YmZqeVd3NFNEcHl3NDc1eEpVbjlTT0Rq?=
 =?utf-8?B?SEMrM0JZQWQvbHI5RGczbTFtRDlsSXVJZG5NNFI1azZWT1BYZWdDZ242eGMw?=
 =?utf-8?B?dDZXSWJod1NlNU1Rdm1LS01raEplSU9aZnVPOFp0L3pjbGNsWlJURCtOcXo2?=
 =?utf-8?B?eUZpWm8wOWxvSmtuUUJmTE9CN0hTbnFjN095Zkt6YjVNelZ2YVJpVXh1Zkdi?=
 =?utf-8?B?eDhuazZhaE5UY0h1aGdYOUFrakl3V1dicjBhWU9XTVQvT3B0bmVKbkF0K0Fy?=
 =?utf-8?B?N0o4ZFhnbEd2OEFJaEtxdXVpVnBKOFFrdEpJQlBtQTNLcjBUU0lZVE5NcHdH?=
 =?utf-8?B?a1lkRFB1NlRJQjlzQnFVdmFjaGlTWGR0SFVDWmYydElwNitYTTlubUtudE5h?=
 =?utf-8?B?bVBnN2FxaEJGTkEzT3Q5THdNTGhhSzN2RzJtQ1RCM1cxUzdSK3VZMmNHS1Y0?=
 =?utf-8?B?NDVNZlpWK2FSWXZ0ZVdrQXIyajZWeTEvZnFxS0J1UDc3aEhkWURTckk3c0lH?=
 =?utf-8?B?MkhWSlRqeUVwNUNVR3o0Wmg3V1JBYkFKU3FMWGpKR2kyK25KQlg1K0UyenpI?=
 =?utf-8?B?Um5NMmh0YlFrbU5QQmZtck5BaWJtT2JXSi9pTVhRcEZGUnFqYVJYbENNUERI?=
 =?utf-8?B?M0hyQi9tYWFpME1WdUwwVlprUG1qWE1oLzhHUkNHVklyc2lDUkJ3MjNtbTVZ?=
 =?utf-8?B?eTJSM2kvc0gwaENZbDJtYUVCUXozU3M0OE1hald0aEtLMWdScFBhT2JWU0Iv?=
 =?utf-8?B?QWV1ZVZKaU5sNEpGY2dlS0hVN0s4YzlTNlFEUFRycjJHNm1ST0picHppRzI5?=
 =?utf-8?B?eW1CZCsvVjQyQ0hrUHk1Qlh0Y1Z5NGJvY3dqekVhOVl2dVNtL3Z1R2QxR210?=
 =?utf-8?B?ZjNoMnM4SGRwOHFJRmUvL2VJakZHMlg1TktHWTVqR2NkZG5XaTFHTXpqelM2?=
 =?utf-8?B?cXVEZkUzSDV3eE16ZmIwMjZYb3h4Zi9Nb2xtVFl1U0owWFhNS0hYZUx3ZG1R?=
 =?utf-8?B?OWlzSnlEQ3l4RytoNkhjOFZjNUpxemw3UStGY1FmT0FsWTVTZDY0aUtEZElr?=
 =?utf-8?B?QU9CbEtzb2lUaGIrNGZELy9GdmVJWldQODFMdGJvVm1scUdrTmRreU8zNEpv?=
 =?utf-8?B?QkFBNmdzaG9XOWNJN1FCVUNrTlFiTC9iSG85T0crTk5rSE1zcnVSK0ZqTVlp?=
 =?utf-8?B?bitWR0w1TnFGb2x5NWRVenBPTkxUZjdhQjFlRlZvajNpaEFVeUFTeFFZMW1B?=
 =?utf-8?B?cndXbXdwcG9SSnc0NUFwOFlWUFhoWWlITmpBc3g4SkdFZm11QjBIR3BoeVND?=
 =?utf-8?B?bTFvT0VEa0tXU2tjTmZGNG5rWnBoRU43aU4xb3dFU0hhOGlWT2ZLNnJOSU1X?=
 =?utf-8?Q?JRNsMJXYAEO9RZaE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8397d0-bd40-486a-1282-08da47c010db
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 13:25:46.7942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/PoDAowmAslZccOKhFiCsUwOU6mKdnLQhys4hDJhoAEgrsgNCatvMc7+T5pZcL5r+4aD6mgmKE425QJtPRqGc90H8y/gp2sFNIVKX4Bah4+rDugbhKA4I3T7I5EWeic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
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
dnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGlu
Z3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbCAgICAgICAgICAgfCA5NyArKysrKysrKysrKysrKysr
KysrDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC1mbGV4Y29tLnR4dCB8
IDYzIC0tLS0tLS0tLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDk3IGluc2VydGlvbnMoKyks
IDYzIGRlbGV0aW9ucygtKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4gPiAgZGVsZXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwt
DQo+IGZsZXhjb20udHh0DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbA0KPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4yMjFiZDg0MGI0OWUNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4gPiBAQCAtMCwwICsxLDk3IEBADQo+ID4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+
ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvbWZkL2F0bWVsLGZsZXhjb20ueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogRGV2
aWNlIHRyZWUgYmluZGluZ3MgZm9yIEF0bWVsIEZsZXhjb20gKEZsZXhpYmxlIFNlcmlhbA0KPiBD
b21tdW5pY2F0aW9uIFVuaXQpDQo+IA0KPiBUaGVyZSB3YXMgYSB2MiBvZiB0aGUgc2FtZSBwYXRj
aCB0byB3aGljaCBhbHJlYWR5IGNvbW1lbnRlZC4gTm93IHlvdQ0KPiBzZW5kIHRoZSBzYW1lIHBh
dGNoLCB3aXRob3V0IGNvbW1lbnRzIGFwcGxpZWQgYXMgdjEuIFRoaXMgZG9lcyBub3QgbWFrZQ0K
PiBhbnkgc2Vuc2UuDQo+IA0KPiBQbGVhc2UgdmVyc2lvbiB5b3VyIHBhdGNoZXMgY29ycmVjdGx5
IGFuZCBkbyBub3QgaWdub3JlIHJlY2VpdmVkIGZlZWRiYWNrLg0KPiANCg0KSGksIA0KDQpGWUks
IGxhbjk2NnggZmxleGNvbSBjaGlwLXNlbGVjdCBkcml2ZXIgc3VwcG9ydCBpcyBtb3ZlZCB0byBh
dG1lbC1mbGV4Y29tLmMgcmF0aGVyIHRoYW4NCmltcGxlbWVudGluZyBhIG5ldyBtdXggZHJpdmVy
LiBTbywgSSBzZW50IG5ldyB2ZXJzaW9uIG5vdyB3aXRoIGRyaXZlciBjaGFuZ2VzIGluIGRyaXZl
cy9tZmQvYXRtZWwtZmxleGNvbS5jDQpJIG9uY2UgYWdhaW4gZ29uZSB0aHJvdWdoIHlvdXIgdjIg
Y29tbWVudHMuIEkgbWlzc2VkIHRoaXMgY29tbWVudCAicy9EZXZpY2UgdHJlZSBiaW5kaW5ncy8v
Ii4NCkV4Y2VwdCB0aGF0IEkgYWRkcmVzc2VkIHJlbWFpbmluZyBhbGwgb3RoZXIgY29tbWVudHMg
Zm9yIGR0LWJpbmRpbmdzIHBhdGNoZXMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0K
