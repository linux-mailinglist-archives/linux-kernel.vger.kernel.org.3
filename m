Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94714D03B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbiCGQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiCGQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:10:29 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D942AC4C;
        Mon,  7 Mar 2022 08:09:34 -0800 (PST)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 227AFscT018215;
        Mon, 7 Mar 2022 11:09:04 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3em2ge1q89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 11:09:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI0jJ9whe27xZ+TIO3VZtTmqpl/z2wQ0G2RwF20Tz7Fy6LRw4QI67X9be2ReKoZUdj+BR8MS2o/h8NCknHsIxB1M8L/GSG0oYCm0FxlnShbmOhaEHBhKidw+Ac4jT1g4wG8azFMjgp21jPrRSe73l/mgaZHRjffG5+wkzvn7DeGRmWkytFRC+4ll/1N4XBQt4DqC6OYTDu/TosoLMvkfAL/U2+MjPw2m81B2zpMrpwRT39TncVhyW8vnVZ8sQI0Gyq7oW5wpp7MAlaL8OaiLQvg9F7xn8TTjJWu5PR/fLiXmFFjehjFzPismFFz0rsbbv8yh0xDh9vEN+TcSrpaPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awA7qbx6RDrVLgtctN6O2wfzDuHLxCjor/fopA/SWnU=;
 b=CAKKFKI2xVtD9AaHOBS1LtISa/alInMbxBb9Z8CLq/KqNIwSahlTncbc84pM8tJneBuJFW1gS3LfQMTWG87xilspKvagBmbei/Yi9mlfK6Fe/F2FSi+4scjM1kwGNCHvchYOgjtYZLd1nqg8xr+Q6ULJ7QxxZgKJClPsmPSZXf7VdzGxfmqT8Cc6xUo+qc5ABxdE0K+7EAhseaSU5etNaFLjWD71e1Nxfb1hjlowYH6qPWuk+8TiGHMylZHMGe+5KYDpUNU25cS7knJKLvLRGe3T1c/9mj87N6utuz/DNVZDdxxlncaZ1joDfN/JjdSzxccNk5YOfFeBM77LhGlyrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awA7qbx6RDrVLgtctN6O2wfzDuHLxCjor/fopA/SWnU=;
 b=LV8vEe+dJxSgx8M+ETKMHAwZEyIIwVQ8WmA0hAGgbTQqIZ3iPynXmtxhOB8AUDtPodxOnQN+AxbK4RB6e25T/Bg5zH6A7a9mRPkFExa2e1Gapv64Jy3TijJ17dFPVH23XHxdwv7jR7Lg79EdIwWj8trKZAmRLtftykFkepTrio8=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM6PR03MB4619.namprd03.prod.outlook.com (2603:10b6:5:18c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 16:09:02 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 16:09:02 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v4 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Topic: [PATCH v4 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Index: AQHYL/IQdHGXQF5840edvo8syPGtK6y0GpPQ
Date:   Mon, 7 Mar 2022 16:09:01 +0000
Message-ID: <PH0PR03MB67860B252E8A63BFF0746C6999089@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220304180257.80298-1-andriy.shevchenko@linux.intel.com>
 <20220304180257.80298-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220304180257.80298-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpUVTJZMlZsWkRRdE9XVXpNQzB4TVdWakxUaGlZemd0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGaVhHRnRaUzEwWlhOMFhHVTFObU5sWldRMkxUbGxNekF0TVRGbFl5MDRZ?=
 =?utf-8?B?bU00TFdaak56YzNOREl4Wm1OaFltSnZaSGt1ZEhoMElpQnplajBpTVRVMk5D?=
 =?utf-8?B?SWdkRDBpTVRNeU9URXhOREk1TXprMk5UVXlOVEF6SWlCb1BTSXJkMk4wTjA4?=
 =?utf-8?B?NFpWSllTekZTUlVKNFdXdGtWME51VVc1cE9YTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVRXpWemhYYmxCVVRGbEJaR2c0VGxWbGIxaHdXR1l5U0hjeFVq?=
 =?utf-8?B?Wm9aV3hrT0VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e343f9cf-14e8-4cfb-cac4-08da0054cbb4
x-ms-traffictypediagnostic: DM6PR03MB4619:EE_
x-microsoft-antispam-prvs: <DM6PR03MB461922B06C97791F2D5A2FA199089@DM6PR03MB4619.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EPuIQOabGaKNhWxDfZubndFqXTxNT7kKnPYJQNODkf7YkLf3c2DmYTzoGze3M2rhmNzXle6nb794VKPi5qy3OzAMGCZkaQK1r+qcIrUfjhtQPbUEA7TUlQ5veUMKOjpNp5l7jYJ/ZOF4M3yQ98jxDKju4fUkngAsWCLFdHsfO28rzxy+HVAfOQ3HojuvN5f7SQSyFmL1h0SyouUAlEG3EN/TQBDUWOTy/2kSIHysqwxv+D/V1zN2hGquPtYpF5PpNFd2fVlbI8Y2C8YtcRza9ipisr/pORttP0lehEbIRw3NFCJBqQRxmZNbnpNfJ/gx5euqI4ENdBbwbMQHgm2jEUpqj+1EQYaFY/su9Ir54CI9cU/Mt2Xfvt7jyWafzSJqNohkJSceabthjCmjefpw25olfd0q59FYolOR+/UuX00MPmDHG12ZRHYn8E44Oxw1q+GMSmGEryNBBq8nD9kzqgceBvtlvwyT9O8LnBYSX2gmVxEJrIwO7gMX9yzelWpCA+bxbD+jfvH8Q/WpCjXcfWDIzv+ea9z5sW7D+vTwlfIK9GvpHmVEkAyC23nQ5qQQNAakfNb4ubH+avvo21hV2bpHcfxptl0IN5uBRuUq8uyqPtVQR7ou12YDohZIbncbu2w4MsHs8yO5T3ZinRYYZEaVsdlgpm4rQoL8S1K/rMFhF2WLZ4nCmSFVuZ/L2pdQXTC3UKEVoTmTgJJO65xsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(4326008)(52536014)(8676002)(66476007)(66556008)(66946007)(64756008)(66446008)(76116006)(33656002)(186003)(2906002)(316002)(8936002)(38100700002)(54906003)(110136005)(122000001)(38070700005)(86362001)(508600001)(55016003)(71200400001)(53546011)(7696005)(9686003)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlF2UGE5UVl2Q2JzN3lqcXNGbXh2b3VyaVczTEJEbWYrZ25iSThOMTRZcW4z?=
 =?utf-8?B?S2E5MzZqWCtKZ2xsRjVuRHJzcUkxZ3RKYWhhUTJmYWRxUEFTcTBwMVR1YzIw?=
 =?utf-8?B?V05HcmxZMnZ6ZThNSGRKeDdxWXlPakpQZzJGZlhQeGN2bUwzVEduMHRveUZ0?=
 =?utf-8?B?WHpxc2NnRXh6ZDlsUi96WlpOLzM3WjMveGNpblh0byttZzllYVZsZVZqUUpD?=
 =?utf-8?B?TDBFWGUxYWozQUdkMFpPcEU0NWh5dk9OSngrWS9Wa1NBSTVNcTZkKzhNWnVi?=
 =?utf-8?B?eHRJbTY3ZmlqYlBjVTVNNkNhYUhkdlplRmRWUk5yV2FvUnFTWkpSayt2WXBT?=
 =?utf-8?B?aUhFdmN4ZTFzNDBiZ2JqZnpJcUtkNjk1UnNsaFlhTDdHd1BDVWFESWpyMXhv?=
 =?utf-8?B?RUZ6SlZXejBVS1cycDZoUXRqdkppTWJEYXhKR0dsT2drb0swU3JEMUtrT1VP?=
 =?utf-8?B?RWtvMFgzTnk3c3g5bHJkWVNBTDV5M24vQmdkbUdublZxbm1mT1ROY2d5SFpB?=
 =?utf-8?B?ZDJITUtOTCtoYnhhOEJidGlUWHoyNFZLeTM3T0VSWUpaNGZ6UGF0dEVHekM0?=
 =?utf-8?B?UFNwdDZ1ZFc2S042U08yRUxwVnA2S3hRTnlUZE51NWU4T3dMN1B0VFA5VGlt?=
 =?utf-8?B?TnkyNERwZWlGWWs1aHJZS3JsMC9DYUxtUTdyV0hidnd6c05mcEIzQWRrQTdP?=
 =?utf-8?B?bjdneWhyaTNWVncrdWlweWxMbEUyT1lwVE5MajhHVGlmZmNnWUpsY0t2SDE1?=
 =?utf-8?B?WjlROXkrbUJwQ2J6Q0xlcVJ2ZHVmSlZxRWYydXVPQ0xtNm5rSEFRM2RrTzVn?=
 =?utf-8?B?WE9YaTJHZXE0QTJlZFJXM3FLV3lYdUQrR2RxQVZuRiswMkU5aFlVZXNlRVow?=
 =?utf-8?B?MzNPa3JJck1nVnQzSVlyTHUycEg5eFlhNDRFUTVnTnJjZU5uUGtLN3NyOEUz?=
 =?utf-8?B?WERRVXIvVXdKMnFrKzAxVy9KdEtxWk1aR2N5aDhVS2lDc1prU3YxRGQ3NFVZ?=
 =?utf-8?B?UFlBSVpBNHBLcFpoNU5TQjZjcWZFYy9WZ3k2NGlTaW9rRmM1U2JCOXF5TWRP?=
 =?utf-8?B?VHFMeUJmU3JzQ0ZxcFUrek5MWDVvQzFxbjUvYjRrOVdFTDhjaGlsVHhKenN2?=
 =?utf-8?B?Nmt4ZHJnL29hTTRsN3Zlb0hjVFI0WmpxaWpGQXVhdGFWVEFIRVhDdk5VVFpi?=
 =?utf-8?B?aS96a3pmV2pzajhidGl6Tm5GQkxlZ0crbmZoY01DeldBSmt2LzRXc3orUHgr?=
 =?utf-8?B?SkY2OTNDRDRTbEZ3N0JsWVp6TGcvbjBoTVZ4OEoxa2lRZG1qRnFuVjQxMFpD?=
 =?utf-8?B?dlhhbzBpeGs2V1Q5RXMzelBMWC9ScjU0ZlFzclpDMHE1YnNXVzFFUE1LaDNv?=
 =?utf-8?B?ZW9mczAxRG55S25pbUdjcGsrQy83ZXMwRjFOYmRzL04rcmE1bDRrVi84WlBN?=
 =?utf-8?B?S0VhMzVkZXJpYzB4TGRxajF6aFJNRUVNMTA2czhYbTZYY1lDdG5tV21CN3hs?=
 =?utf-8?B?UmFLN2dGNDcycVJOb0lxN0dlR2RJcjBSVGNsa095TFI3cmsreGN4SS9BQ0Vw?=
 =?utf-8?B?WXlCdHVrOExiN01mckNoSkw3S08vVThFVFcvWlhJTWJGMHVkY3RZcVIzV1Yx?=
 =?utf-8?B?eFlpSUMvdzZoS1NPRVFNN2pVem5FK0tvaWNCSTVIa2luam1VL3d5NSt3cFpv?=
 =?utf-8?B?Ynd5SDBkQWp0eEJRbjZGb0lCWTNUZjJlbEJBaGpsdldkME9pMkdEallpRkRS?=
 =?utf-8?B?QTZVOUpmY2ppdVZYNm9RZ3VDSHlsMVJwNU9HUXpSMnJ2eDNNL0Y4cG5ENGtv?=
 =?utf-8?B?QVRTMnFCU3hRNWxTS1lMamZtNUMrTkYxZGNlTmdHVHMwZU8yNDFrYlU0UDVq?=
 =?utf-8?B?SktyeWJQQmgzTDJuUVJBNTZrTEdRb1JObEVmOVR6N3VYQnNvOW00Q08zY2xx?=
 =?utf-8?B?UDJCb3AvOGs4UmJGa1p5WEVhUnk2aVdxak51dGJTVFgzeGl3Q2pudU1pV3hC?=
 =?utf-8?B?cGtMWHNDS2ZIVmRzSElUSzB0QkxUS1NXQ25TeWhLYjRpU1hLVy96ZTBvQkhy?=
 =?utf-8?B?dWJBYUxaRGVIdWZuUmxZa2RSOTdYdnpuZm1RbU1KQlNTMjBJcWd4WmlBZ2Fz?=
 =?utf-8?B?Q21BdkRhcTRDSU5QNHN3d3NDVElJU3Y4ZHZhMGRSS0ltWGVscHBsWlRjeUto?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e343f9cf-14e8-4cfb-cac4-08da0054cbb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 16:09:01.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0rQl7z2qO+v3IgIq1FypD3dG80zf5IcQ0lHWuOWbcq01DCxXKQ2QPQOSiKrO/NbnV9VWBqVUhpBd18c5wMtsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4619
X-Proofpoint-GUID: AfNrd9NSTUiwFH19scwbJm99rgBwOA-M
X-Proofpoint-ORIG-GUID: AfNrd9NSTUiwFH19scwbJm99rgBwOA-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_05,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=702 bulkscore=0 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070094
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNv
bT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCA0LCAyMDIyIDc6MDMgUE0NCj4gVG86IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPjsgbGludXgtDQo+IGlp
b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFNh
LCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqaWMyM0Br
ZXJuZWwub3JnPjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2NCAzLzNdIGlpbzogdGVtcGVyYXR1cmU6IGx0YzI5ODM6IE1ha2UgdXNlIG9m
IGRldmljZQ0KPiBwcm9wZXJ0aWVzDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBDb252ZXJ0IHRo
ZSBtb2R1bGUgdG8gYmUgcHJvcGVydHkgcHJvdmlkZXIgYWdub3N0aWMgYW5kIGFsbG93DQo+IGl0
IHRvIGJlIHVzZWQgb24gbm9uLU9GIHBsYXRmb3Jtcy4NCj4gDQo+IFRoZSBjb252ZXJzaW9uIHNs
aWdodGx5IGNoYW5nZXMgdGhlIGxvZ2ljIGJlaGluZCBwcm9wZXJ0eSByZWFkaW5nIGZvcg0KPiB0
aGUgY29uZmlndXJhdGlvbiB2YWx1ZXMuIE9yaWdpbmFsIGNvZGUgYWxsb2NhdGVzIGp1c3QgYXMg
bXVjaCBtZW1vcnkNCj4gYXMgbmVlZGVkLiBUaGVuIGZvciBlYWNoIHNlcGFyYXRlIDMyLSBvciA2
NC1iaXQgdmFsdWUgaXQgcmVhZHMgaXQgZnJvbQ0KPiB0aGUgcHJvcGVydHkgYW5kIGNvbnZlcnRz
IHRvIGEgcmF3IG9uZSB3aGljaCB3aWxsIGJlIGZlZCB0byB0aGUgc2Vuc29yLg0KPiBJbiB0aGUg
bmV3IGNvZGUgd2UgYWxsb2NhdGUgdGhlIGFtb3VudCBvZiBtZW1vcnkgbmVlZGVkIHRvDQo+IHJl
dHJpZXZlIGFsbA0KPiB2YWx1ZXMgYXQgb25jZSBmcm9tIHRoZSBwcm9wZXJ0eSBhbmQgdGhlbiBj
b252ZXJ0IHRoZW0gYXMgcmVxdWlyZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZj
aGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gVGVzdGVkLWJ5
OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiAtLS0NCj4gdjQ6IGFkZGVkIGNoZWNr
cyBmb3IgZXJyb3IgcG9pbnRlciAoTnVubyksIGFkZGVkIFRiIHRhZyAoTnVubykNCj4gdjM6IG5v
IGNoYW5nZXMNCj4gDQoNCkhpIEFuZHksDQoNClNvIHRoZSBwYXRjaCBub3cganVzdCB3b3JrcyBh
ZnRlciBhcHBseWluZy4gQWxzbywgcmVtb3ZlZCB0aGUNCmlmKCkuLi5lbHNlKCkgaW4gbHRjMjk4
M190aGVybW9jb3VwbGVfbmV3KCkgYW5kIHR1cm5lZCBpdCBpbnRvDQoNCmlmICghSVNfRVJSX09S
X05VTEwocmVmKSkgew0KICAgLi4uDQp9DQoNCmFuZCBhcHBsaWVkIHlvdXIgZndub2RlIGZpeCBh
bmQgdGhpbmdzIHdvcmsuLi4uDQoNCi0gTnVubyBTw6ENCg0K
