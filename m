Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9413759018C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiHKPyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiHKPxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:53:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6295046DBE;
        Thu, 11 Aug 2022 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660232723; x=1691768723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T09UjqL5opG4ReqiMCIBmeO3OHznXb1kRyXgKAvelCA=;
  b=bT0auFh7Lz2iaSCwSohDaaaOiPhsib6FNonagTxCklNtm3Q9P9km1Xve
   4g8IFR+6MOA5GmRY4IXBepPhVpfBDCFPYXcbjddv1A3nsf/Fn7wRI8ROI
   yfrBNe9QWr4EfkNMBy0a96HCwz2q0rlwpN1nkA9fj3FKQZflO3IYQpXvR
   jxmXPBzo8bjPDqG/rHZFHPTrfq3bp7vj8+qyk+MjmF2xDifGjRwoVokj2
   xKv9Eax7fXf34lQrr4ultw9vasavwGzKdPgGUKWlJ0ll7j7nnBq9sTxn2
   I1eYtIEymZT4PCP06tw+gIrwI0vTbzw0AABEr4+4AVZZxV2N88DL9ug0+
   g==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="108636189"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Aug 2022 08:45:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 11 Aug 2022 08:45:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 08:45:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7qDNUKZ0YlrF4GZvaBIh60vkelLYaLO2b/lFCMTGYqP8mUjGA3mTv6jEcJle4qKdCwFdflm+7WjmXOYwxjyVocn+Bv4GMDpNNUAvYHn3z4nylcG53ritO0glwGSrqdEGYNCTQNp82Nz6Pl+kgD43ygiGYeuTqKV1QrCtqEiZow2DTPAJUu5Tx75BVx43SxX9vBb2ZS8bvXv8u9HfxXITjjuNPNhqqKAnEtALAkUG03TXjrxNt7O9Ol3t17enwhAvlo2MH06sYVXP6ID0ZspkYIHarxg0oanx/CjpVx0yOriHoA7Dc8l1cE4/naOR1+VSRNVLf8Pi8MKXggh87CnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T09UjqL5opG4ReqiMCIBmeO3OHznXb1kRyXgKAvelCA=;
 b=Iv7O0bTicCg5obargJvrqJxNb6uSlR3kX3okMqoUBnkVa2AaC3Lp4Z+FtL131R7NmDGRZirSmNW/nMwKGjwl6tyB+vTCqPDhmtbFia1h8WvicdXi+bIVhS+tIz1pNpPHURN3ApmcT3gFnyrkdWm74MJgHgB3umLMr8LiZx15sEWmKkpJUmpUivpDnQCH7ztkRZxuIoKXhSza1Od7pVSxtMryeSJaMcOF8YcJB/ShRpBYrc3lwWwZAAnfkNuxleviiKZMItnLD01oY5h7rJIw/77kz8o28HTnsO88uZ74r0X+tIqEr7s2BNF1s9woupYLdjm7CbviDsPAiPOCTeoVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T09UjqL5opG4ReqiMCIBmeO3OHznXb1kRyXgKAvelCA=;
 b=rui74rKykxf1vzBIFkehd83BqbF43E9lH03ZBpnDsV4CuFtw4eY/aIijUa71YPrULv3xJby0mom3ErmjDGZXMp7MuhBr7h4E3DbxR8dlirQejyE7ilBezh7/9y1L2H0C6DCnv5yymDFwveggTQRHWWwzIqD0go6j4Dzt3Bz3vW8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB3010.namprd11.prod.outlook.com (2603:10b6:208:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 15:45:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 15:45:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <xianting.tian@linux.alibaba.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <heiko@sntech.de>, <guoren@kernel.org>,
        <mick@ics.forth.gr>, <alexandre.ghiti@canonical.com>,
        <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
        <corbet@lwn.net>
CC:     <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <crash-utility@redhat.com>, <heinrich.schuchardt@canonical.com>,
        <k-hagio-ab@nec.com>, <hschauhan@nulltrace.org>,
        <yixun.lan@gmail.com>
Subject: Re: [PATCH V6 0/6] RISC-V fixups to work with crash tool
Thread-Topic: [PATCH V6 0/6] RISC-V fixups to work with crash tool
Thread-Index: AQHYrVXcv96MB9H2nE2Pb9bFKutIJ62p2AeA
Date:   Thu, 11 Aug 2022 15:45:16 +0000
Message-ID: <1e070eac-edb7-ba89-f189-bed0fd0b1702@microchip.com>
References: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a62143b1-9626-4c1e-b32b-08da7bb07ca9
x-ms-traffictypediagnostic: BL0PR11MB3010:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?SThzaGc1ZDFzL3NqdlNpamhXZEdjUFZLS0N3R3dPMWZzKzNxVUs4U1lMM1Qz?=
 =?utf-8?B?NVpVMzNwcHBKSWVPeTMwSFRlQnVrOUoydEJ6czFPcFRVdVdQQ1ZtRkVscVBV?=
 =?utf-8?B?WGtkbEtOdVllRzlldFQzbVVnN2dibkZ0MDVCLzFrWllaeUVVVStCb092QU5V?=
 =?utf-8?B?YWgzMEdIY3kyYmJsL2UwNWJMMGc0WXlEZ0V6dUJLSHlDSG9wQTdvaS9vbysx?=
 =?utf-8?B?MXYwc3BhUkd5L3UwZ0ZKaDE2cXNURUhKejZzaE9pbUc0ckxHSzVJVGV4Ymdu?=
 =?utf-8?B?MUo4Y1hYSW4yU1VOYm5pRHUxdm1zTDhxZ0xkelY4Znl1R2dYWG53a3lFSTVI?=
 =?utf-8?B?UTFKQlJMZkYvYnU2bWs0S0ZvT1l2K1crek54Qjl2WFVNd0F3ejgyMVEwU28y?=
 =?utf-8?B?d2gzLzF5UWQ4aTVhclExellWTTlWeHBBSmEraFlVNVN3cVBJUVE4dDJuR0ls?=
 =?utf-8?B?TXR5cGR2MkpuWjkyVTlhaGZaOXM0Y1VUQkRZMkVzZjBHRWpZbkFVbTZGYm82?=
 =?utf-8?B?M0VTNk1IQUsrVWhBU1VjNWJkaHZKbU5PUmF1cWJ5b3Z0b3pvaGN5eTFjRmpV?=
 =?utf-8?B?NTgxVzBlajFuNmRTT1JjNFEwZWdkTlpkbWxtQ1FINzJXZGwxU2RER2dMQVN0?=
 =?utf-8?B?Sy84MjZFb0sxcWZib09WekRkekNweDZtRnFKbG0zUHJJcnlzdlR2cEZ2eGFG?=
 =?utf-8?B?Z3k0ckNUQWRzZHBHd1lGMzhpZ3RKK1BvVlNhWDlhakwyZEEwU3NUdk9LWTFC?=
 =?utf-8?B?WjhCb3EyVG94eHJTUjNkOTAyeWRkWGZOSXlUNjM2Z2RDY05RYU1ESFhPRm4x?=
 =?utf-8?B?cUFiVHJKMWxWMTRiRVl5UzNPaDBvQWFrMW43ZEloQ2pCZDRmdWwzMFR6dWtZ?=
 =?utf-8?B?QW43YUpWUnAwQzlMYmdQRU54TnNOSzY3UnExS3oxNGJhT2J0cmVaMlM3WXc5?=
 =?utf-8?B?OWczVWlCRHViMmRKSEplTVZ5Q1c2OTc3MC9VU2ZIZWtaeFVkcVJLby9ZWXFE?=
 =?utf-8?B?RFJ3V2JWR2xMdDdORWJvUzVWd2ZnM2g1NHVsU3N6blQ3NEZ0SVJuajRCeDhF?=
 =?utf-8?B?eWNWTnlOT0syb0w4VnNJWGJYYkJGbHUvY1NQcEljMkdwSVVySWd4cWhISVdh?=
 =?utf-8?B?TXUrMUxLWTBGUGplTG1nYk5Td3REMnZpRXFMc2pZUTQ2eFdQTnJlK01pVG8y?=
 =?utf-8?B?MCtTUUpxYkhBOTFEUVZTd2grVUZ6d3c1b2V1cFljWE9sTFBKTUdLMElsV1RF?=
 =?utf-8?B?NUpqRmROYTc3NVhUSm5ZKzVJNGNxTU95c0dzRG92MjBZOXdaUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(136003)(346002)(186003)(71200400001)(2616005)(41300700001)(86362001)(26005)(53546011)(36756003)(6506007)(6512007)(83380400001)(110136005)(31696002)(54906003)(4326008)(316002)(91956017)(76116006)(64756008)(66946007)(66446008)(66476007)(2906002)(66556008)(5660300002)(966005)(6486002)(478600001)(8936002)(38070700005)(921005)(8676002)(7416002)(38100700002)(122000001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVR5K1N3NW9KMHM2SWR1ODZNU0FoTGJrRUh2SW9DeWpYZnRpbFRXTzg4MTF0?=
 =?utf-8?B?WGpBZkxRK2s5Skl3MSs2QVpxVmFDOTBiQzdCWWNaajBGMm9YalBQNkE4QXE1?=
 =?utf-8?B?ZElrSjNNZ2libzlCOHFEMnVRZENhTEhXcTUxODg1dU0yYitkUm1VYi9pWGt6?=
 =?utf-8?B?dEt4Zk9jMVFtNUZ2Y1NVSFhRTzFmZXpsMHpiTWdaanNnUWQ1QzM5bitNSXlY?=
 =?utf-8?B?ZCtSZ0RPWDFQMjh5WGJIRGVNSXRkMHpvY21icURib0svM1dvaHIzL2ZTUVlk?=
 =?utf-8?B?SUdrYnJqMEFmOEtiTUljOUFHNHBQbkV3MFZhaTIvOWZzWkUvV0JaZHFUbm5w?=
 =?utf-8?B?WHIwSlcvajBNa2Q4d3pmdzMwSU1ETitIQU5NNGwwaDFQNTdHcHlFMzR4Q0Nz?=
 =?utf-8?B?UVdsUkJqRVQ0cjRwbkhUdE5ZM1FtMDFZT1lIcmV5ZkU0cTZqMkpGbFFqUlZm?=
 =?utf-8?B?VS9DZEllOW1NRWx0MzhzTnB4MUdkaWh0Nk10WWFiSHBlYVI5T0ViZnRvbWlD?=
 =?utf-8?B?cTFkWENITHNrWlJPM0F4VnZRNXFqWUlKVGdJemZxNloyOGZuemQ3OE8zeUlZ?=
 =?utf-8?B?VTIwTUtaMngzbStRNVhmT1JuVkdqcXBNUWc1QXNUVUFOYmlQTnE5dSttTGVF?=
 =?utf-8?B?TXNQY3k3K2lWTEdjVmhWcVFrc2x1YjRuR2FsUDI4dVM3NkV0SHkvMHNrdGc2?=
 =?utf-8?B?ZzVVZmsrSU53elhwYlNJR0tVbXJRR3psSU1kODhMbkFJNlhYNExQSW8rZXNa?=
 =?utf-8?B?dFV2SGlzS01EbmV1clJSRVVORmpHUkVTTEh5VTBzNjJLKzIzSVpObGYxUUNj?=
 =?utf-8?B?cjVRVkNKTWFDMnZkbTV3UUpnU3E1RE1sdzM2bDA5SkZzZGlnbVZvVUxqNXVt?=
 =?utf-8?B?ZnFqRnNJWnlvZm42Yml6MzU4OXIraDNNRFJJVlRYZTVWUlh0dHpVWFNOMStI?=
 =?utf-8?B?K3RMeGpQL21iMUtqeWZ1eG40cUZDdEtGa2xIY2R1clhaaWxXUzlPdjNSY1VL?=
 =?utf-8?B?TStZUDBpVjJGbTNGWDY0ZmIzNnZ3emh0T0xEWFJwYUFLOStrODZackEzbHdk?=
 =?utf-8?B?VzgwLzFhZmVYbWRMekJYWUZPZkUwaFl1NnVkU211TkpWejBGTE5jbTQwa2lw?=
 =?utf-8?B?QjNic3BnRUNIVFVoTjZuTCtiK3RPZGFpRmJSdENPa0xzT2JzaXlnRklwVkZR?=
 =?utf-8?B?RHVNSEVwbmF1WmJMNzVaNFhhWGR0UFZtT0xNcHpiUFpBbzRHdGNMenRNQWR2?=
 =?utf-8?B?LzVXaFBxK2NXMS8rRjduRkNIdlpDdFdBeHk2WTFxT2FtM0o1NWJNelhhQTNq?=
 =?utf-8?B?L0JWb1lUU0tnTXhLQWgrSE5JK3B0Y1ZTRlFxbmtvcEJUckc0V1RYZitFOURy?=
 =?utf-8?B?N0Rxa0VPa2wycjVOTjN6S0J2cWNRQWQxWlptWFdZWVZmTGk3ZEJnSFF5TzBr?=
 =?utf-8?B?amp0VkdONHJaUFoxK3JUOFZGTDRNa3lrUzZWa1I5Y1lTVGpwTXBkZXhIYlN2?=
 =?utf-8?B?M1dEc2x2TnFEaUpuNVFvRDl5MUdvS0NNY0E0c005UHpHd043cjM0ejRUeG9K?=
 =?utf-8?B?L2RIei82bjdnTmcwanY2Zi9yUGVjbm01ZWR3ZXBpeWE1V1ZTVTliVGxCZ0J4?=
 =?utf-8?B?TW5ncDVndWZLdUk3eGppTUNWWGE2K0JWd3M0dmxnRDJpTDlGdWUrcTdNWHZS?=
 =?utf-8?B?K29IZjVCeWphV0h6b3g1UnVGbzlpLzlQK0ZsSVBXb25vT3c0aTh0bmFkMm5K?=
 =?utf-8?B?U3V3M2RKcGl4L1J4aFNXL0hTb0htbVdWNmgzRTBBblQ5ZDRCRWhUVWlvbk9i?=
 =?utf-8?B?ekhwZTNBQmFhNWhCZHdONFlYWktBV3R5VzR6R0t0WFNRWUFkUVpRZllWSjVO?=
 =?utf-8?B?cHUrcnZxMDBVbDZ4R3FyTXViWUQrZlhrdnd2WDVlTkFhUWg1R05qbDhSQTk3?=
 =?utf-8?B?ektnenZGSUZqUFBqdG9mYm1WWTgzVVRDYmhpTHo2NzNseE1LV3E0YzRmZ3h6?=
 =?utf-8?B?ckpna1JUN3JXQW1EMmVieDBmc3lNdzV0QTBGSmREQlQxWlB3NXc0dEVNSDln?=
 =?utf-8?B?dERaM2ZLTTlwMW52cEhLU2dtSWd1YVM5MmNXaEg3dElyWTFHWkxGMmxCWEky?=
 =?utf-8?Q?cHRuy37qSE1FhmUD4NY/AiJ69?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <636BE292DF4F034B9B1862C794B80785@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62143b1-9626-4c1e-b32b-08da7bb07ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 15:45:16.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h11MSsrc4YcuzCHaS2ByBNbvNqI6aOrMK9X8xrqqxa6k8Suff4DhGrHXMeIAlaczvbCXTs/CiXs/55lIvUITT04Psq5nN4FLYRijslzuLDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3010
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFhpYW50aW5nLA0KSSBzdGlsbCB0aGluayB0aGUgY29tbWl0IHN1YmplY3RzIGNvdWxkIGJl
IG1vcmUgc3BlY2lmaWMsIGJ1dA0Kbm90IGdvaW5nIHRvIHN1Z2dlc3Qgd2FzdGluZyB5b3VyIHRp
bWUgcmVzcGlubmluZyBmb3IgdGhhdC4NCkNvc21ldGljYWxseToNClJldmlld2VkLWJ5OiBDb25v
ciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQpAUGFsbWVyIFdvdWxkIHlv
dSBjb25zaWRlciBhdCBsZWFzdCBwYXRjaGVzIDEtMyBvZiB0aGUgc2VyaWVzDQpmb3IgNi4wPw0K
VGhhbmtzLA0KQ29ub3IuDQoNCk9uIDExLzA4LzIwMjIgMDg6NDEsIFhpYW50aW5nIFRpYW4gd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSSBldmVyIHNl
bnQgdGhlIHBhdGNoIDEgaW4gdGhlIGxpbms6DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1yaXNjdi9wYXRjaC8yMDIyMDcwODA3MzE1MC4zNTI4MzAtMy14aWFu
dGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tLw0KPiBBbmQgcGF0Y2ggMiwzIGluIHRoZSBsaW5r
Og0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmlzY3YvcGF0
Y2gvMjAyMjA3MTQxMTMzMDAuMzY3ODU0LTIteGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNv
bS8NCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJpc2N2L3Bh
dGNoLzIwMjIwNzE0MTEzMzAwLjM2Nzg1NC0zLXhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5j
b20vDQo+IA0KPiBUaGlzIHBhdGNoIHNldCBqdXN0IHB1dCB0aGVzZSBwYXRjaGVzIHRvZ2V0aGVy
LCBhbmQgd2l0aCB0aHJlZSBuZXcgcGF0Y2ggNCwgNSwgNi4NCj4gdGhlc2Ugc2l4IHBhdGNoZXMg
YXJlIHRoZSBmaXh1cHMgZm9yIG1hY2hpbmVfa2V4ZWMsIGtlcm5lbCBtb2RlIFBDIGZvciB2bWNv
cmUNCj4gYW5kIGltcHJvdmVtZW50cyBmb3Igdm1jb3JlaW5mbywgbWVtb3J5IGxheW91dCBkdW1w
IGFuZCBmaXh1cCBzY2hlZHVsZSBvdXQgaXNzdWUNCj4gaW4gbWFjaGluZV9jcmFzaF9zaHV0ZG93
bigpLg0KPiANCj4gVGhlIG1haW4gY2hhbmdlcyBpbiB0aGUgc2l4IHBhdGNocyBhcyBiZWxvdywN
Cj4gUGF0Y2ggMTogRml4dXAgdXNlIG9mIHNtcF9wcm9jZXNzb3JfaWQoKSBpbiBwcmVlbXB0aWJs
ZSBjb250ZXh0LCB0byBjbGVhbnVwDQo+ICAgICAgICAgIHRoZSBjb25zb2xlIHByaW50cy4NCj4g
UGF0Y2ggMjogRml4dXAgdG8gZ2V0IGNvcnJlY3Qga2VybmVsIG1vZGUgUEMgZm9yIGtlcm5lbCBt
b2RlIHJlZ3MgZm9yIHZtY29yZS4NCj4gUGF0Y2ggMzogRml4dXAgc2NoZWR1bGUgb3V0IGlzc3Vl
IGluIG1hY2hpbmVfY3Jhc2hfc2h1dGRvd24oKQ0KPiBQYXRjaCA0OiBBZGQgbW9kdWxlcyB0byB2
aXJ0dWFsIGtlcm5lbCBtZW1vcnkgbGF5b3V0IGR1bXAuDQo+IFBhdGNoIDU6IEFkZCBWTSBsYXlv
dXQsIHZhIGJpdHMsIHJhbSBiYXNlIHRvIHZtY29yZWluZm8sIHdoaWNoIGNhbiBzaW1wbGlmeQ0K
PiAgICAgICAgICB0aGUgZGV2ZWxvcG1lbnQgb2YgY3Jhc2ggdG9vbCBhcyBBUk02NCBhbHJlYWR5
IGRpZA0KPiAgICAgICAgICAoYXJjaC9hcm02NC9rZXJuZWwvY3Jhc2hfY29yZS5jKS4NCj4gUGF0
Y2ggNjogVXBkYXRlcyB2bWNvcmVpbmZvLnJzdCBmb3Igdm1jb3JlaW5mbyBleHBvcnQgZm9yIFJJ
U0NWNjQuDQo+IA0KPiBXaXRoIHRoZXNlIHNpeCBwYXRjaGVzKHBhdGNoIDIgaXMgbXVzdCksIGNy
YXNoIHRvb2wgY2FuIHdvcmsgd2VsbCB0byBhbmFseXplDQo+IGEgdm1jb3JlLiBUaGUgcGF0Y2hl
cyBmb3IgY3Jhc2ggdG9vbCBmb3IgUklTQ1Y2NCBpcyBpbiB0aGUgbGluazoNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMjA4MDEwNDMwNDAuMjAwMzI2NC0xLXhpYW50
aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20vDQo+IA0KPiAtLS0tLS0NCj4gQ2hhbmdlcyB2MSAt
PiB2MjoNCj4gICAxLCByZW1vdmUgdGhlIHBhdGNoICJBZGQgYSBmYXN0IGNhbGwgcGF0aCBvZiBj
cmFzaF9rZXhlYygpIiBmcm9tIHRoaXMgc2VyaWVzDQo+ICAgICAgb2YgcGF0Y2hlcywgYXMgaXQg
YWxyZWFkeSBhcHBsaWVkIHRvIHJpc2N2IGdpdC4NCj4gICAgICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9yaXNjdi9saW51eC5naXQvY29tbWl0Lz9oPWZv
ci1uZXh0JmlkPTNmMTkwMTExMGE4OWIwZTJlMTNhZGIyYWM4ZDFhNzEwMjg3OWVhOTgNCj4gICAy
LCBhZGQgJ1Jldmlld2VkLWJ5JyBiYXNlZCBvbiB0aGUgY29tbWVudHMgb2YgdjEuDQo+IENoYW5n
ZXMgdjIgLT4gdjM6DQo+ICAgdXNlICJyaXNjdiIgaW5zdGVhZCBvZiAicmlzY3Y2NCIgaW4gcGF0
Y2ggNSBzdWJqZWN0IGxpbmUuDQo+IENoYW5nZXMgdjMgLT4gdjQ6DQo+ICAgdXNlICJyaXNjdiIg
aW5zdGVhZCBvZiAicmlzY3Y2NCIgaW4gdGhlIHN1bW1hcnkgb2YgcGF0Y2ggNSBzdWJqZWN0IGxp
bmUuDQo+IENoYW5nZXMgdjQgLT4gdjU6DQo+ICAgYWRkIGEgbmV3IHBhdGNoICJSSVNDLVY6IEZp
eHVwIHNjaGVkdWxlIG91dCBpc3N1ZSBpbiBtYWNoaW5lX2NyYXNoX3NodXRkb3duKCkiDQo+IENo
YW5nZXMgdjUgLT4gdjY6DQo+ICAgMSwgbW92ZSAiZml4dXAiIHBhdGNoZXMgdG8gdGhlIHN0YXJ0
IG9mIHRoZSBwYXRjaCBzZXQuDQo+ICAgMiwgY2hhbmdlIHBhdGNoIDEsIDIsIDYncyBzdWJqZWN0
IHRvIG1ha2UgaXQgdGVsbCBtb3JlIHdoYXQgaXQncyBhYm91dC4NCj4gICAzLCBhZGQgRml4ZXMg
Zm9yIHBhdGNoIDMuDQo+ICAgNCwgYWRqdWVzdCB0aGUgY2hhbmdlcyBmb3JtYXQgZm9yIHBhdGNo
IDYuDQo+IA0KPiANCj4gWGlhbnRpbmcgVGlhbiAoNik6DQo+ICAgUklTQy1WOiBrZXhlYzogRml4
dXAgdXNlIG9mIHNtcF9wcm9jZXNzb3JfaWQoKSBpbiBwcmVlbXB0aWJsZSBjb250ZXh0DQo+ICAg
UklTQy1WOiBGaXh1cCBnZXQgaW5jb3JyZWN0IHVzZXIgbW9kZSBQQyBmb3Iga2VybmVsIG1vZGUg
cmVncw0KPiAgIFJJU0MtVjogRml4dXAgc2NoZWR1bGUgb3V0IGlzc3VlIGluIG1hY2hpbmVfY3Jh
c2hfc2h1dGRvd24oKQ0KPiAgIFJJU0MtVjogQWRkIG1vZHVsZXMgdG8gdmlydHVhbCBrZXJuZWwg
bWVtb3J5IGxheW91dCBkdW1wDQo+ICAgUklTQy1WOiBBZGQgYXJjaF9jcmFzaF9zYXZlX3ZtY29y
ZWluZm8gc3VwcG9ydA0KPiAgIERvY3VtZW50YXRpb246IGtkdW1wOiBkZXNjcmliZSBWTUNPUkVJ
TkZPIGV4cG9ydCBmb3IgUklTQ1Y2NA0KPiANCj4gIC4uLi9hZG1pbi1ndWlkZS9rZHVtcC92bWNv
cmVpbmZvLnJzdCAgICAgICAgICB8IDMxICsrKysrKysrKysrKysrKysrKysNCj4gIGFyY2gvcmlz
Y3Yva2VybmVsL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4gIGFyY2gvcmlz
Y3Yva2VybmVsL2NyYXNoX2NvcmUuYyAgICAgICAgICAgICAgICB8IDI5ICsrKysrKysrKysrKysr
KysrDQo+ICBhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9zYXZlX3JlZ3MuUyAgICAgICAgICAgfCAg
MiArLQ0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvbWFjaGluZV9rZXhlYy5jICAgICAgICAgICAgIHwg
MjggKysrKysrKysrKysrKystLS0NCj4gIGFyY2gvcmlzY3YvbW0vaW5pdC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICA0ICsrKw0KPiAgNiBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yva2Vy
bmVsL2NyYXNoX2NvcmUuYw0KPiANCj4gLS0NCj4gMi4xNy4xDQo+IA0KDQo=
