Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624244D03CB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbiCGQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbiCGQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:16:26 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D1443AD7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:15:32 -0800 (PST)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 227EI4j8009133;
        Mon, 7 Mar 2022 11:15:26 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3em5ca9bbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 11:15:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5vgE11TfO1HJhXTxU2nKTak6D8jXCQDbSEZV/uQsyZ7hT9zUALJud4/jgOtiRkOpcvdx402brd+SOsCJTavfUAjx6YzJ2DuaehEos+Z2eNQICOhTEO4e7J0xUVUz931CV6I8brpa2JLHc2NrvZ6WXxY1dx3tgr3m8ouKb23WcMyz6VRLhAA3a1eNlh9OYVtgBRLfgkf9Ej12mgHm7fE48mGLXqvM0k7T7FvxvSPtcyKODXAlDmwfrm41IT0pWnoz3TtW4FwuAXBU0/VvdUKd80FuCZcwTnQUqO4HKYFhYTTWZcbdRdI/hfdoUifjOIUtuUiSfYm0AWngZVqo6sjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/GkrncEZzSFSVfQtO9YZDRR+GfQiDiEsUBbfYgxb5Q=;
 b=KzuxlU41BSqWE0V0P+vfLDBvXvJ+1WazP9vxnda0rFpDVX6zUzD4eupp9I/gO+6Rpf74KKaTzoBPgnUl4j4D7io1of1kr3qrYQA/ayeeWD1ugH/BWJ9NkVXLmgnNEL0BhwdRzyRh3hWZN1j1C9SEcsgmkn/TTGe11fyMVxAx++jIFz+TMviwYn+GSUUUgPNG7RuU/yB2x6Mk4EdrEIngcjgKQgPnURMDL/Z5UEoL+Mcc2CumC49VnZKi9nTZxm1A3f1rpgl2kfTilycjkWxafFGG1kb/rsQRshIrRqAMA6KfOgxUlKlqZFMut9pN6EILr9iN9WaiuLyHiL8VndIuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/GkrncEZzSFSVfQtO9YZDRR+GfQiDiEsUBbfYgxb5Q=;
 b=fHc3h1veGRf2XMHgIdGkQp/l68psV1pTgOkPLMGABtoPOFENUOIfuUZAR8k3820UYJE4SVf3+zRiH48FkyTC0AyeRQNux8gtOQ9qm+MVb5ooDkgbm/s9dRys3oegh7UxhBkLj7M+Ka7d6W0IM44Tp2HQ0E+fjBOxhtZUoAjgmk4=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by CO3PR03MB6727.namprd03.prod.outlook.com (2603:10b6:303:165::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:15:23 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 16:15:23 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH v2 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Thread-Topic: [PATCH v2 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Thread-Index: AQHYL+3e/ZRFb3p6F0+0kMmiD/CUlqy0G6qg
Date:   Mon, 7 Mar 2022 16:15:23 +0000
Message-ID: <PH0PR03MB67863963179FBA901E649C7599089@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220304173256.39059-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220304173256.39059-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFl6ZzJObVF4WXpBdE9XVXpNUzB4TVdWakxUaGlZemd0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGaVhHRnRaUzEwWlhOMFhHTTROalprTVdNeExUbGxNekV0TVRGbFl5MDRZ?=
 =?utf-8?B?bU00TFdaak56YzNOREl4Wm1OaFltSnZaSGt1ZEhoMElpQnplajBpTWpNd05D?=
 =?utf-8?B?SWdkRDBpTVRNeU9URXhORE16TWpBNU16azNOVFEzSWlCb1BTSXJOMHRSYURC?=
 =?utf-8?B?TU56Qk5ZV1JFV1cxdWJUZElTV28zSzJOWlIxazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVRnlkMUZwVEZCcVRGbEJWV1pVZDJwSFpXeG5aaXRTT1ZCRFRW?=
 =?utf-8?B?bzJWMEl2TkVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 57ad9648-560c-4714-a4e9-08da0055aef4
x-ms-traffictypediagnostic: CO3PR03MB6727:EE_
x-microsoft-antispam-prvs: <CO3PR03MB672721682A65BC024D005FB899089@CO3PR03MB6727.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRmg7nnvqa4Uwk94cRPVJKVkFwwag850o9wf2Q43PtdBAm3zc2BQ/JdhK2jNhMgh3RWOHGwonaDlH/q05qUaBVjeKq4xOuf4HKNXLnSjl2YHOF3JPDNT+G1t8qkWT+WvtpFPXhYFbJGPzxkPYlrZgcoqWprtqqEVynmX/z3khrkeJAkLP22UtFGtjzBF8GQ/aDF8VB1kQYrp5RIirU5Pqmtm4hp4LSwfffvJ89Dq8d8u/Y/3BRwY2QGOrmDVwPvZ4C7bsDF3aAgg1HV+P1mTTBOfT3ToIVL1dLauYPAF9HzkfBO7AY5OBXC2Jyqv3HiUuljKy6ZFsMVK0ZWJIpMuaJ1HtbEanEdO5tMliSAiVs9NJalPdZznlKK6Fc1JxuuHQBSBPIMYGu/g7BCwYgM99pMnCRYH3xgHvyCF+D+sahz7mY9Meg5NnScT7/E59hIHDydhBCYi3yPJKeQJk5wi51qqiaQVlvA6YBeaHjV6c9K0klqPRl773L+YY7NHXCYJk2UuseMLhVilZMnmznud6/IpVHn4+OElmaqSxkWFxTbbsxJd6AUT1IBlw6n14Crj6HQJFvVNvmXLtOdEkecBgzqYne6oBGWTR4MLVOPxe+J8DAy3lghIjToHwTfrUu6b0xfqQd4LDc1WLYsg1HuJnQ9MAknysHttbEorMEYk4sf/i5cKul7W/GT66ibnFzt1ov2FCyZ7/KECENGXaMNktQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(53546011)(55016003)(71200400001)(7696005)(38100700002)(2906002)(83380400001)(38070700005)(33656002)(66556008)(5660300002)(7416002)(66946007)(316002)(26005)(54906003)(9686003)(52536014)(8936002)(76116006)(122000001)(86362001)(186003)(64756008)(8676002)(110136005)(4326008)(66476007)(66446008)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDV3TDZnMWdzVklqQnU0ejdMZWJLTEhocDNacWY4ZURlWjR0ajRmRmh4U2Zp?=
 =?utf-8?B?VC9zK3Q4bTBvUDUrRDByWG9DaXBkZDhWNmYzSmNIc3k2aFplOTZlQS9FRW9l?=
 =?utf-8?B?a3k4SFFQbEtOQXl3SUs3TEdYNTNicVplbkZ5QVVaclU4TzlBcDZTUWVNRU1V?=
 =?utf-8?B?bTN2UlVjaW40cFZRUHhRTFVsbzdINE0rQVdRWkxmRjA0Snp3eWFIU1h1Q3Fu?=
 =?utf-8?B?WjkrY3VUVWJ0S09ZRm8xOU9LZEJYOGZlQXNGM2VYcGcxenovdlM2cGxJUVhp?=
 =?utf-8?B?cjhXUGhqL3BlUEFmdldDQlA1M28vWVBNU2N1b0NJdnlvQmd2cVRsY25SL2Zk?=
 =?utf-8?B?eGdRb2ZsRlR3dmJ4Zml5L0FLbTNVR2IrRG9pcGhKN3YrY0Jsa3VUZlgrbWhV?=
 =?utf-8?B?ME4rSi9ENU9ZeEgxN3hrRHM1SURlMmRmVkVtTndPTUlIRzhUa0FnRWZGOTg1?=
 =?utf-8?B?Ti9odmRlVEZob1hMMXZucXFub2JOTml2dVlRSEkwSXJnV0ErQXEzeDF6RURT?=
 =?utf-8?B?SmZxdEoyQ0Q0eDFEejRNcHpGa0wyZWxCTWh2MFBaczBYdXI0Nk9ObldScHM0?=
 =?utf-8?B?NG9CZllUamV6S3hmbEEvWWlXVzJTVTdDalNPV0tpaEcwdEZKUklXQmxRdjdK?=
 =?utf-8?B?WDFCM1I0RlV0aXlvZTBIdlRrTktyelZGVGNaVVhyTkhJWEFiK3ZNci8xNEJl?=
 =?utf-8?B?RXNlaWd1cjAycEpZRHBOQk44cGZKbmllL3Z0d1pTRzhCZlNKbC9CNzRGaElB?=
 =?utf-8?B?ZlRkTWNwa21JdUdISm5KVHplYjl0Nnh2YWVhZU1MeW80NEw3ODZoM1Z1bCtX?=
 =?utf-8?B?M0d4NVpNVHdidm1idmhpblFDYVM4VGEzTVB0bnl3emFpYUVFclZDUHNvb0x4?=
 =?utf-8?B?b0JjekRseXIybmgxQ2MxZndHd3NqVGpENVl1RHBSVlplQ3BZVVhOUmU1Mitj?=
 =?utf-8?B?MG9HcFJSRHk0a2kwRXBnTjRoQjgvVWZSMXJrSjExbTI3eHJjeFVUQ0h2RHE3?=
 =?utf-8?B?TWE0R2VGNEkwRUFqZVBKMjlMR0JSZ2JJdDNVZjZtK215RGVKN1hSS1N0b2M1?=
 =?utf-8?B?L0IzT0t0c25VUXVxM0lyU0twZEY0UVJSQ0dJTHREVjdSMEZORi9uMWxVS1lH?=
 =?utf-8?B?Y0ppZ29Fa2c2THY4cHgvcXhZWmwyN2NYeTNUV3J0aVNBVi9xK2N5UVpzWmpY?=
 =?utf-8?B?K2ZGOC9FUXlyWUVTUmZEbmo4T1I0Ym9MUXUwaUJnMUZWakV1Mk5FRjFjZzh6?=
 =?utf-8?B?K0ppM29vbmppME8zOERGblEyY0ExVC9mdVhLUzA1bXRzMlNRaERpeko1dmxm?=
 =?utf-8?B?YjdnUlljS1I2UHhFeldoaC9Ba2tSSkpiNXoxd3dhRkVjVC9ZOEtUMnMvZlNT?=
 =?utf-8?B?QXR0RDBnWStxenR3RllpRGNFblJ0NXZtRURlaDR4QnBwcHpqRHN2RlpLdHgz?=
 =?utf-8?B?VTVoSFFUQVdPUFQwbjFUdEc0SlF1TE83OUxibjZ4YStnY0VzTHY1M2h4SXAv?=
 =?utf-8?B?OVRFUGpWeThSbklENUVRRFRyNWR4eFBodzU5Nkgrc3kxU1FiWEIrbktNWXZP?=
 =?utf-8?B?dzdqN1FWQWdEVHdQM0p2eDR3ZEo1bXVENVJDZmh6OWZTQVNyMHlrUUEwY3Q5?=
 =?utf-8?B?cTRFbzFINFY4MEx5ay9xY1B6Nk9yMEdoVE0vZC8zTDZtOTdnaEFyZHVZazdz?=
 =?utf-8?B?Z1ExdFh6TExuRnBQUVFHR1IyRkpHRk54c1VEd1BSRncwY0Z1UnR6VGt0Umdw?=
 =?utf-8?B?eHZvRFg0MkhUVnhBRDN5UWYzTjhZNitMNGNzbGVuRExOTW1qTHNNam5seGZO?=
 =?utf-8?B?cGMxU3NpZGZFNitrR2drVndFNXh3YSsyTFV5dGF6SHRobW9pdFh2Q1N2WTZS?=
 =?utf-8?B?SXowT0hOQVlaaFlQTEdKY2pMMExxNnp2c29rd0dUbVJZaVBZWUE2cXNwRUo3?=
 =?utf-8?B?ODZ5RmNQSTNEdEg0MDd5bktreUJMRXM5UWREaFp1alI0bnJhbERrWTNWNjdJ?=
 =?utf-8?B?OFhzdDhVbHRCVlh2Tzgxb1djcEtHS24zYnZHMEg0NmtiS0tKOUVneUQ4cXg1?=
 =?utf-8?B?N2lDczRJNDZKQmhodEJKQUc2M0F3ZkR2MklDRFQzWXpXRi9SZGd1OW56VUZx?=
 =?utf-8?B?L25mUGhFbll0Z1JobTRUOW1Lb001OVUyVUxVa0RmZjF0TDJUZmpaT0FrcFgz?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ad9648-560c-4714-a4e9-08da0055aef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 16:15:23.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EL/vcUADxfBAInpIBzfECe/svC5RzwIi8si4etp+hv21iTOfPGNEc6lITKecIon3xLi7HrMgKKf3w3JSpqQE3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR03MB6727
X-Proofpoint-ORIG-GUID: WDLmBDiAD0CC5K834SNSMGcUKy8jYZM3
X-Proofpoint-GUID: WDLmBDiAD0CC5K834SNSMGcUKy8jYZM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_05,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 adultscore=0 mlxlogscore=924
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070095
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFy
Y2ggNCwgMjAyMiA2OjMzIFBNDQo+IFRvOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hl
bmtvQGxpbnV4LmludGVsLmNvbT47IFJhZmFlbCBKLg0KPiBXeXNvY2tpIDxyYWZhZWwuai53eXNv
Y2tpQGludGVsLmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBEYW5pZWwgU2NhbGx5IDxkanJzY2FsbHlAZ21haWwu
Y29tPjsgSGVpa2tpIEtyb2dlcnVzDQo+IDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29t
PjsgU2FrYXJpIEFpbHVzDQo+IDxzYWthcmkuYWlsdXNAbGludXguaW50ZWwuY29tPjsgR3JlZyBL
cm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IFJhZmFlbCBKLiBX
eXNvY2tpDQo+IDxyYWZhZWxAa2VybmVsLm9yZz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3Jn
PjsgU2EsIE51bm8NCj4gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYy
IDEvMV0gZGV2aWNlIHByb3BlcnR5OiBBbGxvdyBlcnJvciBwb2ludGVyIHRvIGJlDQo+IHBhc3Nl
ZCB0byBmd25vZGUgQVBJcw0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gU29tZSBvZiB0aGUgZndu
b2RlIEFQSXMgbWlnaHQgcmV0dXJuIGFuIGVycm9yIHBvaW50ZXIgaW5zdGVhZCBvZg0KPiBOVUxM
DQo+IG9yIHZhbGlkIGZ3bm9kZSBoYW5kbGUuIFRoZSByZXN1bHQgb2Ygc3VjaCBBUEkgY2FsbCBt
YXkgYmUgY29uc2lkZXJlZA0KPiBvcHRpb25hbCBhbmQgaGVuY2UgdGhlIHRlc3QgZm9yIGl0IGlz
IHVzdWFsbHkgZG9uZSBpbiBhIGZvcm0gb2YNCj4gDQo+IAlmd25vZGUgPSBmd25vZGVfZmluZF9y
ZWZlcmVuY2UoLi4uKTsNCj4gCWlmIChJU19FUlJfT1JfTlVMTChmd25vZGUpKQ0KPiAJCS4uLmVy
cm9yIGhhbmRsaW5nLi4uDQo+IA0KPiBOZXZlcnRoZWxlc3MgdGhlIHJlc3VsdGluZyBmd25vZGUg
bWF5IGhhdmUgYnVtcGVkIHJlZmVyZW5jZSBjb3VudA0KPiBhbmQNCj4gaGVuY2UgY2FsbGVyIG9m
IHRoZSBhYm92ZSBBUEkgaXMgb2JsaWdlZCB0byBjYWxsIGZ3bm9kZV9oYW5kbGVfcHV0KCkuDQo+
IFNpbmNlIGZ3bm9kZSBtYXkgYmUgbm90IHZhbGlkIGVpdGhlciBhcyBOVUxMIG9yIGVycm9yIHBv
aW50ZXIgdGhlDQo+IGNoZWNrDQo+IGhhcyB0byBiZSBwZXJmb3JtZWQgdGhlcmUuIFRoaXMgYXBw
cm9hY2ggdWdsaWZpZXMgdGhlIGNvZGUgYW5kIGFkZHMNCj4gYSBwb2ludCBvZiBtYWtpbmcgYSBt
aXN0YWtlLCBpLmUuIGZvcmdldHRpbmcgYWJvdXQgZXJyb3IgcG9pbnQgY2FzZS4NCj4gDQo+IFRv
IHByZXZlbnQgdGhpcyBhbGxvdyBlcnJvciBwb2ludGVyIHRvIGJlIHBhc3NlZCB0byB0aGUgZndu
b2RlIEFQSXMuDQo+IA0KPiBGaXhlczogODNiMzRhZmI2Yjc5ICgiZGV2aWNlIHByb3BlcnR5OiBJ
bnRyb2R1Y2UNCj4gZndub2RlX2ZpbmRfcmVmZXJlbmNlKCkiKQ0KPiBSZXBvcnRlZC1ieTogTnVu
byBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hl
bmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiANCj4g
djI6IGFkanVzdGVkIHRoZSBlbnRpcmUgZndub2RlIEFQSSAoU2FrYXJpKQ0KPiANCj4gTnVubywg
Y2FuIHlvdSB0ZXN0IHRoaXMgd2l0aCB0aGUgbHRjMjk4MyBzZXJpZXMsIGluY2x1ZGluZyB0aGUN
Cj4gSVNfRVJSX09SX05VTEwoKQ0KPiBmaXggdG8gaXQ/DQoNCkhpIEFuZHksDQoNCkp1c3QgdGVz
dGVkIHRoaXMgcGF0Y2ggd2l0aCB0aGUgbHRjMjk4MyBzZXJpZXMgYW5kIG5vdyANCmZ3bm9kZV9o
YW5kbGVfcHV0KCkgZG9lcyBub3QgY3Jhc2ggd2hlbiBmd25vZGUgaXMgYW4NCmVycm9yIHBvaW50
ZXIuIEkgdGhpbmsgdGhpcyB1c2VjYXNlIGRvZXMgbm90IGNvdmVyIGFsbA0Kb2YgdGhlIHBhdGNo
IHNvIEknbSBub3Qgc3VyZSBpZiBhIHRlc3RlZCBieSB0YWcgaGVyZSBpcw0KbWVhbmluZ2Z1bC4u
LiBJZiBpdCBpcywgZ28gYWhlYWQ6DQoNClRlc3RlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5h
bG9nLmNvbT4gIA0KDQotIE51bm8gU8OhDQoNCg==
