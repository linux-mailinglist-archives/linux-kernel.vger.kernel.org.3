Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC89581487
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiGZNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGZNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:52:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B48248DC;
        Tue, 26 Jul 2022 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658843550; x=1690379550;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=QsqBgASbAacR/Sg2rebp7BnwXGKFEf26YDhWlkrrgcA=;
  b=bRZ2RHvAlcKMCjHT8+G1lT2491p8pIYvycjMJAG3gPVqb4s6eGkR1bD7
   0f6daa+NrEcAOOpwq4IY7D7fP9+NXt8XFPbSbU0MmY4PBTTFiL3HINabb
   eftCRzm1Ej83PRfQQA/5ZiPHQKPiRcDlDUM+D7gCrTmUOgW8v12dmKR3B
   ntcBYzYU6auKmXCWj2J2+vTF5SCMncCbNSwEtbJgX4TYLTUTmKGN7QSgt
   hKHSr/W5eQ9Q+2b0kSuwvEfwR7x6Heelj4zMUTvG7CTbMi2bayeg5AqdD
   D6A+bjdBBdM2C8tbnVgHuxuipmoKrndhpBdilwSRHkdjM0JXtHJYlUylf
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="173678427"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 06:52:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Jul 2022 06:52:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 26 Jul 2022 06:52:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht5EO9TddjQ5lA1kY6SIYGmO9ZnqCKXME94lNbeRvpcfyyLCD911zWbGqZ3ljl8kcl5L8HsPcAp8SF7EeForZHzlAAuE+3qbX8+LzTghsQFaZO2u8matGFoSw0hUg+JT4CUEJDnNapx7WoBjV9y9ZU4EQEeRgqBWsVN6EhB08VUFPx7LjTHsnwUIeKNiVJLRG1jOihzPU1mmsLoi3wPnMpIaL98W7sasUsulr7tTl3A0D1xG2yQK4LJt8VMqxZitVOZSp3iBvcnvgbeYffD/eMe7wR5XkM9KuvAxNyJLOySEQ9OHXModHFngkxdtWUKc3Lbwkem0sMDBS1sYgAoUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsqBgASbAacR/Sg2rebp7BnwXGKFEf26YDhWlkrrgcA=;
 b=D1rVY6Wnylh9iQNrN/heB0JiIPP5rebKCjxHRlUalTuJvDBTYrpYilaia1RzDeVT4KTSRFyr/bPvselQsnCHOZ0FNaPtCIqxmAcfuxQ5zrop/eVrG4kQxxN85fRFmI9G77Xai20sdPWPSOwIWrDVOCEGycVmftfoJtrAV5ZjROhrJg9H7ABtfU6stcGL+KjR8Tm4ehI/Ag6U4PKwOKRYne0733rTTu3esm7Ockf2xUyUv4Rgkd5OE0gyHi11o+WfCT6xfCaHeXq4FnMnZag6BXFCGY49nUi2khX5I+xdwG7TqDmLz/OgC5yhdRFc+AJnK0ltig4qM9iKe5cqs5p+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsqBgASbAacR/Sg2rebp7BnwXGKFEf26YDhWlkrrgcA=;
 b=g+kVJKdKPbYfn2HZehjXpKB6cMactI3OFurs4+8aN7TSwgLFBoNWp14SPMQkmMiMjuQSfnzfbp11v8dBnNNpglheUZ5+EHkG9qAuGccbqBQmLLTVxgk0p11vY3voPbRcKqHw87wTpAk0kBvCWOcsyHldfOsjPCtf7/jybZyRrGE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB3459.namprd11.prod.outlook.com (2603:10b6:208:69::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22; Tue, 26 Jul
 2022 13:52:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 13:52:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <arm@kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <nsaenz@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: soc: microchip: drop quotes when not
 needed
Thread-Topic: [PATCH 3/4] dt-bindings: soc: microchip: drop quotes when not
 needed
Thread-Index: AQHYoOc9cOhWkxytn0ibH+WcKKasBa2QrA0A
Date:   Tue, 26 Jul 2022 13:52:22 +0000
Message-ID: <610165ac-1c7d-1c82-3f6b-654878891c22@microchip.com>
References: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
 <20220726115841.101249-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726115841.101249-3-krzysztof.kozlowski@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e044c5ae-0da6-4935-af44-08da6f0e10a4
x-ms-traffictypediagnostic: BL0PR11MB3459:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?Q2YvdjkzNGV4YVZGc1R0RytTSWVDVDMxU3BQUDJJeVBKMCtEWi8waHZjeVBw?=
 =?utf-8?B?cDcrbHpBSmN1cXVqZmFET0NkT2R0WWpoWmxmMzVNcjNnb2phUVZZOXQ4VHBK?=
 =?utf-8?B?a2FrODVoYjJqQW13Mmk2cDNtQ1hMQWpFVDJsNHAvMzJ3ZzdmRGhnTXV2enpX?=
 =?utf-8?B?WGFvWkQ0SjVvRDl0d3V4ejVSR1ZiUzV5VlBJczRKWFFFTFFQZ3NNTjdISW90?=
 =?utf-8?B?MkVCR2d2N3ozUmhYMmc4blVQQzZqOXlkcXhJdnFWcmNIeEZYSFFJZDRGbUZT?=
 =?utf-8?B?Y1BFRmgybUlYZmdpcWljRkhIVGo4OE1qV2tScFgyYndWa0VWMzEreUsrOEht?=
 =?utf-8?B?QjM1ekx3Ukt0dDQreFdwL3N0ZlhKaGRpc1V5bTR5aTAxOWJPd3JFRnN6b1NX?=
 =?utf-8?B?dGNmZml5NS9qTUlKRGM1WmMvSmxLNGJrckJHKzVIK2pXOE1INFdmQ0VnNFll?=
 =?utf-8?B?UUtlTFRmQzJIRlYvU2xROGNkRHFWem8vZmtqNUpoNnkrY095R09uRzZwVkho?=
 =?utf-8?B?MGlBbDhLL3FBSzRWcGpCVnhKKzhJVEI0ZXBnMmhldyt0ZkdWUGx6MFdWUkhY?=
 =?utf-8?B?T3VmS1lZdXlUMG1VNjV6TnlFREVJb2Q3U2lmR0dBS0lTTmp5MTNWYU1nTDhh?=
 =?utf-8?B?aHErS0ZBd0FqUWgyU3ZSSEhZNkRjaUs0KzNmVjZSdXRoTG1jOHAzUWc1alho?=
 =?utf-8?B?Z2xBcm1talpMenpWVFdUQTVDYnJCRDRHZ3A4RFBndVhxT3RDdGxHNkFlVFZy?=
 =?utf-8?B?bUJjLzdDUGpIbDl0VlVsaVBNSlAxSDlsK3V3OWFuSW45R1hCUXRLOFVBWVZB?=
 =?utf-8?B?eFRFNHJKZ1BZUlQxYmp3M1BmNnM0U2lpbmhsanpjNDNSc1I4Ykdhb2lZY2w5?=
 =?utf-8?B?R2pzTCtuRFFuRmdCWDdXUVlaSi9Gd3NpSU9pOEJHdkJ3WGZLeGpRenVEUXFR?=
 =?utf-8?B?ZlFBQjdyYTk3WVFOSm1SRHkvSHVZYWFsYmdwZ0ZJOCtObjZGTnUwcTJUNkVM?=
 =?utf-8?B?YVhwN0tGei9IcjNOOEFjRkFQWUtQRGNSbVVDbThEa2VVR0xRWlFNOWV1M1JZ?=
 =?utf-8?B?bVIzVFBYN2RyM1ppYTlZQzB2L1ZXNGxQbm5nME03SVRYWHp5N0ptQUFaL0p6?=
 =?utf-8?B?QTBDTGFac0NOOXBrR1ByKytIVWZ6QXE4TG1pT09SUmdBeVZUUmdhcG51YUY1?=
 =?utf-8?B?N1Q4SFk3NjVGVXhMVURtRmI2dkRMUXY5U09keUtjSUI0ZDVFaVBpakh0UDVV?=
 =?utf-8?B?MzVYd3E4MWdSSjhOLzh1NkxhRk9IdHdBL01mbnJXWXN0SDNNUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(376002)(136003)(396003)(76116006)(91956017)(66946007)(8676002)(66556008)(66476007)(66446008)(64756008)(110136005)(316002)(36756003)(31696002)(86362001)(5660300002)(7416002)(8936002)(2906002)(31686004)(38070700005)(186003)(83380400001)(122000001)(38100700002)(921005)(478600001)(6512007)(26005)(53546011)(6506007)(41300700001)(71200400001)(966005)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ellzc1ZVTEdydEEwQUdyN2IxS092eG1VZjJEb0Jkcnd5V3hRek1PSUtZbWZz?=
 =?utf-8?B?L0FyS0ZIUDh4N3o5clpBQkNsdGh2S3FXRHVUSXRSS2NoNkUzdzRZQUxqV3N3?=
 =?utf-8?B?R0tmMG44RU50Q1RwTXR4NW52WkkwakNMQk55VVlGSWVuaW1BRWpBcXVlZlNs?=
 =?utf-8?B?Z2VnZFI2VU5PWXgzeDk2ZERSeEdWTGh5K3FkZ2U4Z0hwcHFSTXRzRTkxVCsy?=
 =?utf-8?B?aG9BdkZSbDJCMmZUckM5NUFCNk9KL0Y1TkNTOGJvK3cvRm1ELzRFYjh5SHdB?=
 =?utf-8?B?bUJHSXZZMU1KVDdaVnV0Q3I0MXlBZUhNTU5kRFRFYzBSenpLM0hHWnpKNTRM?=
 =?utf-8?B?ZVljMXBsRXY5VHZFdDl5Qm80VjZWVjhKaUdUZzhUMHRKNlVIcEZ0WVZNNHd5?=
 =?utf-8?B?Zk5YS1dXbTVTUm50Y1VLQnBjaEd2K2tXU3htaEVqWHpDN241TGRhRk5PaTJk?=
 =?utf-8?B?L1o2a3l2Ly84QTNRZGcxeVVMZFdPdUlUa055YklZSkd1czFVVTF6bFhERlhj?=
 =?utf-8?B?eTJUWDBSb3BraVJDQWpCN2YrUXJSY0dVeC9UZ0hSRmx2WTJwSnhSbVNGZ3Bs?=
 =?utf-8?B?Wk1Gd2JFNmVPZzNjSHFVZlFYZ0xLd2dsTnFGV3BlbWlwQ003azJIQi9yVU9R?=
 =?utf-8?B?QmhMSk5KMUZYY0VydWlFREszMmtFdUxyT01hN3pOd08wcm55b2FOYm5CTXdo?=
 =?utf-8?B?Vi85VlZ6QUlPTS9pWlRjUlp4MmN4bUtDRm1lWHZjNmxudU1ZK1lQNXJvQkp5?=
 =?utf-8?B?dmloUFBGNUtzaHlvd0FMNmZkNTlkNml5bUN1Wm5ZaFJBQXlNZWNpRXhzZ25W?=
 =?utf-8?B?WkFrYSt5TStxQnFMVXRWYzJPdSsweElFWGN1bjVMRzZVcVdma3g1OXYranNk?=
 =?utf-8?B?bVBjYjd2SlhyN1dIRFlVZFNQN1czYUtGOGNSUmpjNUsraE00UjdsZHR3RmJn?=
 =?utf-8?B?SHdIellzOEhrUkhocXo1VTVHWHJDdmlRL0VLSzBmS0dUamloWUVZWUQ0cGkw?=
 =?utf-8?B?S3pVMFcwaDNSMEI2NzhYK3pXcXhsalZla0cwZWRpVTFreEdZRGJvbmpSdC8r?=
 =?utf-8?B?NUEzcWZxT21Fa3RGM2picFNrRjlzL2pVRi9EYVVIR2xIV05zaCtGS2oyZkFw?=
 =?utf-8?B?cSt1MDR5TDNKWi90Ulk1S3YzMlNpczBEOW92bXM2RlFaSG5xY25VMncyN3VF?=
 =?utf-8?B?MFM0SmlVTnpHY1QwTHZJcFJIV0laRzJYdGhZRERHVjFVak5nOTFMLzdpYkY4?=
 =?utf-8?B?anZ5cGUyRFV1bmliREFOQ0JnK0pDSlR4cWNBTHRZci94QmZoRWVpNTRLY0dw?=
 =?utf-8?B?WWRMNFd6QWRpMS9VdXZNekNIdzNlTk5UZlJQeSt1VnV5UWozMytDVXFpOVYx?=
 =?utf-8?B?OWRKV3NrVUdrT0tYNDF6eUcxZWlTRUZOVktoeWdkWlZDcTlSK1hZNHkxZ2lz?=
 =?utf-8?B?TmVXTmtDVTg2SEdXS3ZVTGRUMlJTMlJYd2drRCtuQ0ZDUXZhWEEyem5Va0tZ?=
 =?utf-8?B?U1BQQjNLL1VINEZERjk3RjhlSFBSQ3g2QnRsZUhSdmNOei91TGdTaFd1YWFx?=
 =?utf-8?B?cURzS2kySUZId2txdnppVnE1SDkxRFd6V0thQ2JuTjFQWkxXTEloM2hFai93?=
 =?utf-8?B?SlFoV2VjRmpFbmNpNTdPaEg1SitMNzVvU2Y4TDgxemhtT3RUdEMzdWJJMStr?=
 =?utf-8?B?SjVVRWowOVdXdUFleFJibzl0cVI2VnFoRU5kS3JibUdrZVdGZElQMEZIcDFG?=
 =?utf-8?B?UUp2b251Rlk3NklpaFFvb2hzRGdoOE9BMy9RQWhXOVFwR3NpWHgwS3k5WkU0?=
 =?utf-8?B?K0pYMjBwRjZnVHhWb0ZEa1hpbmVONE9OWHJQWWZEalRiQUFhRmI1dm5wYnJ2?=
 =?utf-8?B?MWplY3kxUmN3Tk1Lbm1ZTExLbXpRTG1jZHdpVmwxWjJYL0dFaE1RUXVTZ1Fk?=
 =?utf-8?B?NmZjK3FsVUtBWFViL29DcWJoajA4WGxkeXdkZnl0T1RRTG01V2R3OXBZUmZ5?=
 =?utf-8?B?STUxWktjaFdFeSs0cThSOFhuR2VNTVdIYzRIME5LcGNLT2x0eTFzZlVvMW1I?=
 =?utf-8?B?V0xlZGtVSUJCM1pZa1lQTUthYjB1NDlYbGVyM21oYlBVRndJZDRnS0tub0tw?=
 =?utf-8?B?Y0RiSTMxRklEY2hIcnBXWGcrNndrYmIvajBrVHhkNS9heTUxTnllYlByaFJu?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4964C642204E084484CFB07167FEEEEA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e044c5ae-0da6-4935-af44-08da6f0e10a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 13:52:22.5487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9GyuRBd5Xm5xX/RRCKUcKgHYDVuWd5jiI1NSGCR1LIFsDUQt7qFJaf4srTy8LR4M3vNy21liCZ1Vgr+lcmj73NnA59Vkptv4wT+E9BxaAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3459
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hvbGUgc2VyaWVzIExHVE0uDQoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRv
b2xleUBtaWNyb2NoaXAuY29tPg0KDQpUaGFua3MgS3J6eXN6dG9mLA0KQ29ub3IuDQoNCk9uIDI2
LzA3LzIwMjIgMTI6NTgsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSWQgYW5kIHNjaGVtYSBmaWVsZHMgZG8gbm90
IG5lZWQgcXVvdGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIC4uLi9iaW5kaW5ncy9z
b2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwgICAgICAgICAgfCA0ICsrLS0N
Cj4gIC4uLi9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL21pY3JvY2hpcCxtcGZzLXN5cy1jb250cm9s
bGVyLnlhbWwgfCA0ICsrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21pY3JvY2hpcC9hdG1lbCxhdDkxcm05
MjAwLXRjYi55YW1sDQo+IGluZGV4IDU5N2Q2N2ZiYTkyZi4uMmY4Y2Y2MTkxODEyIDEwMDY0NA0K
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21pY3JvY2hpcC9h
dG1lbCxhdDkxcm05MjAwLXRjYi55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwNCj4gQEAg
LTEsOCArMSw4IEBADQo+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBC
U0QtMi1DbGF1c2UpDQo+ICAlWUFNTCAxLjINCj4gIC0tLQ0KPiAtJGlkOiAiaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvc29jL21pY3JvY2hpcC9hdG1lbCxhdDkxcm05MjAwLXRjYi55YW1s
IyINCj4gLSRzY2hlbWE6ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUu
eWFtbCMiDQo+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NvYy9taWNyb2No
aXAvYXRtZWwsYXQ5MXJtOTIwMC10Y2IueWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiANCj4gIHRpdGxlOiBBdG1lbCBUaW1l
ciBDb3VudGVyIEJsb2NrDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL21p
Y3JvY2hpcCxtcGZzLXN5cy1jb250cm9sbGVyLnlhbWwNCj4gaW5kZXggYjBkYWU1MWUxZDQyLi4w
NGZmZWUzYTdjNTkgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb2MvbWljcm9jaGlwL21pY3JvY2hpcCxtcGZzLXN5cy1jb250cm9sbGVyLnlhbWwNCj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvbWlj
cm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIueWFtbA0KPiBAQCAtMSw4ICsxLDggQEANCj4gICMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0K
PiAgJVlBTUwgMS4yDQo+ICAtLS0NCj4gLSRpZDogImh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL3NvYy9taWNyb2NoaXAvbWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIueWFtbCMiDQo+
IC0kc2NoZW1hOiAiaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwj
Ig0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb2MvbWljcm9jaGlwL21p
Y3JvY2hpcCxtcGZzLXN5cy1jb250cm9sbGVyLnlhbWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gDQo+ICB0aXRsZTogTWljcm9j
aGlwIFBvbGFyRmlyZSBTb0MgKE1QRlMpIE1TUyAobWljcm9wcm9jZXNzb3Igc3Vic3lzdGVtKSBz
eXN0ZW0gY29udHJvbGxlcg0KPiANCj4gLS0NCj4gMi4zNC4xDQo+IA0KDQo=
