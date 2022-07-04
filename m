Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571EA564D02
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 07:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiGDFjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 01:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGDFja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 01:39:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D825F47;
        Sun,  3 Jul 2022 22:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656913168; x=1688449168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l2FZjeqA0tGc2rd7LlmGMbRjuRBAD4u82pv589FBESM=;
  b=FmpB52kV4Yx8m52PGxiZofNPLKGptq949tpiK1m4lT+kLn9CKdGFKlK6
   XjIv4jZ+DxU2NFAfergz++VjXyEm1yx3e3Y0mdVE4wZjt1q2wEGWCMP5I
   cqI9kvOrpr7+fcOE9eTRVP8rVwBP457Krvfc6weCEvj/mKOHw6+xsmuUJ
   7AGC3jbNseZBMzDhh7CHBUG9wvf5AqnBNeVyHhP9owCfoe9uCXvyH1PLR
   LzUL1tN3BHoRGXTf2ZZTz+DqKKFTLpPHJtCzVdjC69kE8Itx9CdXRIfxp
   nHuGivvTpJSeJiR7CTJh4DCi+PFT0Lp8A2t0dhTf48jh92tmSzmH1XpYv
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="180598770"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2022 22:39:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 3 Jul 2022 22:39:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 3 Jul 2022 22:39:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNFLFP/4+ZIm0Byhu0A6aNG1eGBOQlE25Ne4YYr6i2gJTv0GZ8QmnXf/4tOQIKPYE7fPz3OtxdhJUsc5bMfr+KGSk3o1tRXs+vC2ni8fw4yul/gHguvEoeY9erYrg01E7kWCuOW9rs1T1/W/tYGR8Es3UwrBlBxfic/CgRXDw4A0UPsuofiogLsyjgqC6xwDXnxNKKopLvaZG08RZ38zECpYrYt3jgyHuy7pHC7LqQgrNH6QuCeR9y/0FqbySBWl1JxyUmrh/4bHXbLR4VMweoERnKBVUU7wqg9bJFmKAFFTEtb0fQfVuHRec+S7t1aq/vX0WgyAHDpvLs+qNxmB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2FZjeqA0tGc2rd7LlmGMbRjuRBAD4u82pv589FBESM=;
 b=W2KEspe52c4KDamHk+yBqCAppSNyUhEdXtDzcwAiD829Sy5s1mHGl3qtPs6GyhKWGeNMfMPlv7Pr4SG9GizzssoapEipP6gPcUoUyfXJUwxND1j48p3qqg/XSfk38T7hdMrFBlkkb7jgak2y36dXv4iOf5WV1zKmegQ6Ua5MWj+nkUXC7fYDii0x38GQRnLLQgGLoo6MWi2qkkpSJKArVQuG/UlCQabiIS0kAcFqc+DF9W+9dh2TWsoVKq8Z/r3WHFwOncWdpin5MmVrbh2X2O0GwIP7tfAjgeObYEna/2ap/+XwOcbLCs1VOBAAEs38urQTqg1wMSpBRBnLNz518A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2FZjeqA0tGc2rd7LlmGMbRjuRBAD4u82pv589FBESM=;
 b=DH1NFMOQbIQTBg79Aj18GeTZytcbVXcyuYZNdwI8YNRaKhs+yovWfGuJL+jLDGf0488COMcFlJDoXDeB74duXARPEABPArbDrE4RTDILxv8owPOWxn+iAv1oAynzCLS4fwcHkczo6PyEL2kLOoAWnY7T5MxHX0RetjwbEeF+FKg=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM8PR11MB5606.namprd11.prod.outlook.com (2603:10b6:8:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 05:39:22 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 05:39:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <herve.codina@bootlin.com>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Horatiu.Vultur@microchip.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Topic: [PATCH v4 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Index: AQHYjTlBIEn+M1GMrUWYK6sRmh+9Zg==
Date:   Mon, 4 Jul 2022 05:39:21 +0000
Message-ID: <e88c6b69-1e06-429a-5784-a8c66d13e260@microchip.com>
References: <20220701070928.459135-1-herve.codina@bootlin.com>
 <20220701070928.459135-4-herve.codina@bootlin.com>
 <72a1e572-45d7-de18-8f1f-9035d75b562b@microchip.com>
 <20220701160327.102880e5@bootlin.com>
In-Reply-To: <20220701160327.102880e5@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd04e5d4-df1b-49a9-503e-08da5d7f8c2c
x-ms-traffictypediagnostic: DM8PR11MB5606:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5qufCMFivcbnwQT7DHs0comcrE5l5bOKV1MzV4kCIAvKrb/r1/qt1X7NHOjgf1+cOCjczao/IPJT91yicb4lrW/eDZDjK8tHJJNoKmkv4k4/v5QqXwNHLw1mQXmKVGrZNTlMMTMJL1O869IbDLh3Bx0ON6XDxEAtqlxS556KjWD5DT/DQ8LHJIbxQ4J9IwdgxMdIMCAaHZ2ndU5bUvsRS5MbBHmvyVZjBOo9OQ3eYtuAjjKPq0wOwVq9nge0DakiK7NqaAnDfcEDDUEE4kFmTYtfEOg1xVjggRzhpbD/ITAk0SaCI6Ftwgx82yOaJNPFrXYmdGRF7BWjePMB99qSxsmHAWFcP86qtqFSbQLAv1n8OnCD6dpdT/s1sUQAWZ/bEY2umtKJmq6deP8fW3ZZEUd+UIxkZG7zxDHG9sc77+X+ETQer7Nanqhjb5eneMBelzxUTDIgPXU3k+1iVk+jOmGsuhjSi1SZCLjHEMRlo+LlbEcvPknqxWTp1tixo8JLZ+sF11SE9btXDYJ1D0ER3xKZPEeTXW8vDToqufvw9BC+rOnn5ehdkOoGjFz1TmsgYUHzvS3iFGfoyWuGOYnmlxgxwN0UzMs/rq2Zzvcv3JwpjpchogGgSGLZYJZESpA6xiVTWGyJQNdxplNA4tK9NrKyLbFmqGPHSlNugF36CxwyEZFrc+Ga0ft/0rjLOtf1FX8WPk2H/R+Dc+tf8sBNXMvA4b+aZ7VV6VklWIs0UymnYCb8PMicXLdNOAwUR3pLiSu8DpGrWQ9o41yPV5XSzQh/V44+g79LADYjrcujJuXb1bcbyBct7AaaXCDarga2t53XURm6/3brCIEyxQAXdX2GrD8XnYnnVN/eZGGK5+220T3ccB3EnsPRFJYAY73g2zqMye4ALe+GiJoIiXrTIoQ5og8J4zbhBA6Y72lFUKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(39860400002)(366004)(53546011)(2906002)(8676002)(6506007)(71200400001)(6486002)(478600001)(316002)(54906003)(6916009)(36756003)(31696002)(7416002)(5660300002)(86362001)(66446008)(31686004)(8936002)(6512007)(26005)(186003)(122000001)(83380400001)(38070700005)(2616005)(41300700001)(4326008)(91956017)(76116006)(66946007)(66476007)(966005)(38100700002)(64756008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUZIQktIcUJCejJSazROZDB4WnMyWCtnWEJFZEtTWDd2cUZtWXQwVnpGTXlX?=
 =?utf-8?B?WmtJVWptZmtPa1VGZVliRUsvUlV2Qi9xN1BnUlhYc0VCTHViaWxsK0RXTzlh?=
 =?utf-8?B?eTBWRVlLWDhraVZGRG95SERkYzZTNGRNcDh6dEtRQlhpUGlMK2c4cXZvaUFR?=
 =?utf-8?B?NWl1OHY0ZENIckppeTB4YkhnOC8vbittNW1EUWQ0WCsyQ2RpOUNOOHUzdVBm?=
 =?utf-8?B?ZU5lbEF5WU1jNS8yczdwZzB6S213eXJEUTU2RFBueFRYMUNEd0YrazZLQllL?=
 =?utf-8?B?eW85bFQ2QUh3czE2RmFRNXRPR2hTbFhrOXFMWk45V2t3czZZNDBDQ05MSmR1?=
 =?utf-8?B?YnU3d0hpdkJmSXY3dG1mVC9USFczM0xmQ1RPVzJHeklySFJYeVFsaEltc1g1?=
 =?utf-8?B?S01OWnJSdjBRczIyVy9iY1JETVAzWVJyWi9ObUlneXI0MkRob1FnVXZQREhS?=
 =?utf-8?B?QUNJa2kyUWZCaGFXRms4SHMwbDFudnVSbVQvbkt4SDdDTEUxY1p0NVJsRHhI?=
 =?utf-8?B?blFZRkVUUnFUczlqNVM0akIxZWRyWUgzRE04RUVISk1RaGUxalNuRVhoMk44?=
 =?utf-8?B?TlFoZGwxQlFDdGpYckpUbUNxd0tRVkhVTEJROWRRWGJMZEtPb2w0NmNiaHEx?=
 =?utf-8?B?dUIzcG5aeUgvQ1pWNVBHT28rQ3lRUDJLNGlJVHdoVFl4SjRNV3oxbEM1c1Zp?=
 =?utf-8?B?ZVNJUitTc1Y4QS9xTGpKUWFnOXIzVUc2V3QwNW9RY1dpQnpHSEd2ZGsvZlcz?=
 =?utf-8?B?dU5RNG5xeEg4eUpyN2xQSHFIcmpYaXVYTnFNYWJNNmg4Q2xZNVZVcWpKc3Rl?=
 =?utf-8?B?NUN1MVUxc2dWRU83cjk2MW15UHgyNmdwRUN1eEhPeTlVUTREcUpjZHlpZUJS?=
 =?utf-8?B?RlBZSWphU2pXMW85UXNaM1hmY1h4aUQ3RklHVmxiU1RDSmpoUEgzVWUvTVlv?=
 =?utf-8?B?NFVnR0NrK3lYcy95aHZYWmdTMjU4em5ad2tQQVR5cTh3MG9YQXh1Vll4QXVl?=
 =?utf-8?B?VG1CV2JOdENYU3FmSnVmTm1yWngxWnBveE13YmtzQStLdlJCWDExd29vLzdP?=
 =?utf-8?B?WnVkR0RyWkl2QVJ3UUlVS2lBbFVYckpuYnZ2VjMzaXRnZTNaTUdtK0hkY1pK?=
 =?utf-8?B?dTF1Tkd0NldCMFBEcUZLaHRlVlgvYXlTMldYaEFCZFpEZDFuV2tUWEdaUGo0?=
 =?utf-8?B?bmpEb2JWRmFUQzZTZXhUeDJWdEs1amZXYmJ5RzJOOVJkRmM0cnE4OTRxNXVx?=
 =?utf-8?B?dCsxWjR1ZVJzSys3eUdWVVlINFBySENMQ09GUHg1MTZwSUpRSTJUZEN1VWJs?=
 =?utf-8?B?NWdkdkwwRUNXOHJjVDE5TE1EOUkvN05rM1NsSmNGQ0JRdVYyQWI4ZFgvYzRM?=
 =?utf-8?B?RHlSTkMxcUc3NjdoOFNQYkVvb0tGVm1BcmdDVWhNYmxtNVFsK0NYUm1wZ2x3?=
 =?utf-8?B?T3lGbEQ3akNrK3k0OTFDYm83em5GWXFPazBhZ0V6clk4OEEveXhSVUp3aDh2?=
 =?utf-8?B?MFJzVnB5TVZmNU9zRUF3Yk1CalZ6UUQ1a1ZNaWFvWWR4aU9jT0VTRTFXTXJ2?=
 =?utf-8?B?dTM2d0pZNm9MTEhVSjdYV3paVGpPWjkrZW1qejhUSTFld1BlVlBZeWFQRk1z?=
 =?utf-8?B?VEp5RWVzcnh2Rmk3WnBYdUQvazVvSTZ0SXVBMmx6bmhiNS90TDJZT1FSeU16?=
 =?utf-8?B?aG05ZnZjSDJtMDVmcDhrd0xJNFVnVE9zT1NYUXcrcXZjbE1uUWNqcVJlWTFt?=
 =?utf-8?B?ZFRjMGVGOTVFOUhGQmJOUDJrSm96QXVSM1VVMTBkQ1NDOTJibDBWS2tQdzUx?=
 =?utf-8?B?YkJzUUFVM2N5elZrUmZBRk9BWTZnL1IyaHJnckFJRUhnM3R0Ui9BNXRlVjhT?=
 =?utf-8?B?eFdhalNBaWNOTVdiUUJ6SldDd1YrbEhwanU1VFROTm9pSWJycXhrNHJ3UHVz?=
 =?utf-8?B?MFI2U2RpMVdmZk9GRzBoVmMyTStaR1ZoNUJ1MzhkTFFyUHBqbzgydFdCdHNp?=
 =?utf-8?B?Y3BVL2h4UTlHVG9vVVFsU0lxRWIxbkVkU0FiNGZ3dFNKRmV3d3FSSUJlKzRS?=
 =?utf-8?B?UGNkNE5yOFNiWnNvMVhqVEtTaFRxU3doRVFSTUVvOUQ1Z3pFRzdNWHo2M3cw?=
 =?utf-8?B?bUNRN1M0aDlpaWI5aXcrZlgyM29vV3lST1d2QVJNWEtmRDdtSEpuVG5pQ1ly?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BC81B735112B546BC06411588BD9A5A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd04e5d4-df1b-49a9-503e-08da5d7f8c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 05:39:21.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dND4czt+OjJSOsmQRs9MG+OsRFYw4UrQbIJVnamDy9SSfandMaQor2ME0lZsqyV96sqBk/cZ/1055jvoAttz9n6thJ0C9KTRUovoftx1HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5606
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhlcnZlLA0KDQpPbiAwMS4wNy4yMDIyIDE3OjAzLCBIZXJ2ZSBDb2RpbmEgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQ2xhdWRpdSw+DQo+
IE9uIEZyaSwgMSBKdWwgMjAyMiAxMDo1Njo0NiArMDAwMA0KPiA8Q2xhdWRpdS5CZXpuZWFAbWlj
cm9jaGlwLmNvbT4gd3JvdGU6DQo+IA0KPj4gT24gMDEuMDcuMjAyMiAxMDowOSwgSGVydmUgQ29k
aW5hIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+
Pj4gQWRkIFVEUEhTICh0aGUgVVNCIEhpZ2ggU3BlZWQgRGV2aWNlIFBvcnQgY29udHJvbGxlcikg
c3VwcG9ydC4NCj4+Pg0KPj4+IFRoZSBib3RoIGxhbjk2NnggU09DcyAoTEFOOTY2MiBhbmQgTEFO
OTY2OCkgaGF2ZSB0aGUgc2FtZSBVRFBIUw0KPj4+IElQLiBUaGlzIElQIGlzIGFsc28gdGhlIHNh
bWUgYXMgdGhlIG9uZSBwcmVzZW50IGluIHRoZSBTQU1BNUQzDQo+Pj4gU09DLg0KPj4+DQo+Pj4g
U2lnbmVkLW9mZi1ieTogSGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb20+DQo+
Pj4gLS0tDQo+Pj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSB8IDExICsrKysrKysr
KysrDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC5kdHNpDQo+Pj4gaW5kZXggM2NiMDJmZmZlNzE2Li5jOThlNzA3NWMyYjQgMTAw
NjQ0DQo+Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+Pj4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+Pj4gQEAgLTQ1OCw2ICs0NTgsMTcgQEAg
Y3B1X2N0cmw6IHN5c2NvbkBlMDBjMDAwMCB7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
cmVnID0gPDB4ZTAwYzAwMDAgMHgzNTA+Ow0KPj4+ICAgICAgICAgICAgICAgICB9Ow0KPj4+DQo+
Pj4gKyAgICAgICAgICAgICAgIHVkYzogdXNiQGUwODA4MDAwIHsNCj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxsYW45NjYyLXVkYyIsDQo+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhdG1lbCxzYW1hNWQzLXVkYyI7DQo+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MDAyMDAwMDAgMHg4MDAwMD4sDQo+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4ZTA4MDgwMDAgMHg0MDA+Ow0KPj4+
ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA3NiBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNs
a3MgR0NLX0dBVEVfVURQSFM+LCA8Jm5pY19jbGs+Ow0KPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGNsb2NrLW5hbWVzID0gInBjbGsiLCAiaGNsayI7DQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4+PiArICAgICAgICAgICAgICAgfTsNCj4+PiAr
DQo+Pg0KPj4gSSBoYXZlIHRoZXNlIGNvbXBpbGF0aW9uIHdhcm5pbmdzOg0KPj4NCj4+ICAgRFRD
ICAgICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRiDQo+PiBhcmNoL2FybS9i
b290L2R0cy9sYW45NjZ4LmR0c2k6NDYxLjIxLTQ3MC41OiBXYXJuaW5nIChzaW1wbGVfYnVzX3Jl
Zyk6DQo+PiAvc29jL3VzYkBlMDgwODAwMDogc2ltcGxlLWJ1cyB1bml0IGFkZHJlc3MgZm9ybWF0
IGVycm9yLCBleHBlY3RlZCAiMjAwMDAwIg0KPj4gICBEVEMgICAgIGFyY2gvYXJtL2Jvb3QvZHRz
L2xhbjk2Nngta29udHJvbi1rc3dpdGNoLWQxMC1tbXQtNmctMmdzLmR0Yg0KPj4gYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC5kdHNpOjQ2MS4yMS00NzAuNTogV2FybmluZyAoc2ltcGxlX2J1c19y
ZWcpOg0KPj4gL3NvYy91c2JAZTA4MDgwMDA6IHNpbXBsZS1idXMgdW5pdCBhZGRyZXNzIGZvcm1h
dCBlcnJvciwgZXhwZWN0ZWQgIjIwMDAwMCINCj4+ICAgRFRDICAgICBhcmNoL2FybS9ib290L2R0
cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10LThnLmR0Yg0KPj4gYXJjaC9hcm0vYm9v
dC9kdHMvbGFuOTY2eC5kdHNpOjQ2MS4yMS00NzAuNTogV2FybmluZyAoc2ltcGxlX2J1c19yZWcp
Og0KPj4gL3NvYy91c2JAZTA4MDgwMDA6IHNpbXBsZS1idXMgdW5pdCBhZGRyZXNzIGZvcm1hdCBl
cnJvciwgZXhwZWN0ZWQgIjIwMDAwMCINCj4gDQo+IEkgYW0gYSBiaXQgY29uZnVzZWQgYnV0IHRo
ZXNlIHdhcm5pbmdzIGRvIG5vdCBhcHBlYXIgb24gbXkgc2lkZSAocGF0Y2hlcw0KPiBiYXNlZCBv
biB2NS4xOS1yYzEpLg0KPiBXaGF0IGlzIHRoZSBleGFjdCBjb21tYW5kIHRoYXQgbGVhZHMgdG8g
dGhlc2Ugd2FybmluZyA/DQoNCkhhdmUgeW91IHRyaWVkIHdpdGggQ09ORklHX1NPQ19MQU45NjYg
ZW5hYmxlZD8NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4gVGhhbmtzLA0K
PiBIZXJ2w6kNCj4gDQo+IC0tDQo+IEhlcnbDqSBDb2RpbmEsIEJvb3RsaW4NCj4gRW1iZWRkZWQg
TGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL2Jvb3RsaW4uY29tDQoNCg==
