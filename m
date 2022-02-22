Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9704BF492
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiBVJWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiBVJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:21:59 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F104201A2;
        Tue, 22 Feb 2022 01:21:34 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21M7Jv5w031323;
        Tue, 22 Feb 2022 04:21:32 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3eckeq2845-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 04:21:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7jibA8qAM5OB5m+F5drxA58NNycMAKBRUmk8aWZJjF3Cl8xRoAJkLFtDo3jMqB/2MlaRi0Vgg4S1YMzh12DgANQY1Oq/rRNfI3Gy3zMRdiIDYeim+uvJIWAF3dFHTk9umX8JCt3FVr9Rzm5C/DA2CH9AAu1c/UTIVcB+dkkMtJHwu/I6SeozQuQ7lG/+oIoqXb8Lj1Fe3vK8wCmUWblYys/Yve6KAJ3Sb+VV0JGdSfrfdcXH2ZCss5mrXhcEYuPANfC1FUjCb+d7ImHJ1FYHHu6iLcysjCrgkE7qsC6AFad2qVetq5ox7mRuPtF/o1fpzRAqqQD6I/6LWObynkdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NExbnc44xbY4mlBccE7sKi0GMF6ABfrZ8+4chmKrQ0I=;
 b=T4fKshmFpG5kZX4tslJSh1q5tx/56pK/XNa03wEFYopWNKDgQvYLLLJz2LXdMQQcQrm8P72c3Cam5eq1/sOYNAYxnLZrQCmgmsYN9Ni4GMlU+foXm/LCfazhHHaWltAFYm776b7p794eGZydewJa/rGRqnBVWeW8YGP7N0+7cUYl6AcAdnRBu65jWwfnSQjgxoiv9HoQF73tNu+7zHprVZwlOxGd6qvnKkDIvCB3YVNsPbEhsObnlaK5CoPSFXMh4r4nTCXmVoRu+xRyQ38VL0anblDmRM/zJ01QPHC+fWc+yCvGo90jJ2BMHmIzMq9a5nU1PlrDbCHAkkxKqnJ0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NExbnc44xbY4mlBccE7sKi0GMF6ABfrZ8+4chmKrQ0I=;
 b=sN03pnYfNHZRVDUm5fAUbPnmLZFordEBiwAVdheUxUeE7fKE4TtTYNnavAUkFmT/oS3R2ZAw4qsVYE4BfePM1OKr8OCyuGHlQWBoJGfR3oRqZWOOVvCu4A07lDiZsSXlWuUoICaFEjKeUrw5nlLjaU20+Qfg3WSh452amCIHjac=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BL1PR03MB6120.namprd03.prod.outlook.com (2603:10b6:208:311::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 09:21:29 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c%6]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:21:28 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] dt-bindings:iio:amplifiers: add ada4250 doc
Thread-Topic: [PATCH v4 2/3] dt-bindings:iio:amplifiers: add ada4250 doc
Thread-Index: AQHYJwVZYcpoFmKB60er2w2RI3PMwqyeNBcAgAEWfuA=
Date:   Tue, 22 Feb 2022 09:21:28 +0000
Message-ID: <CY4PR03MB3399F6E389A3014678849ADC9B3B9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220221092740.25511-1-antoniu.miclaus@analog.com>
 <20220221092740.25511-2-antoniu.miclaus@analog.com>
 <61e964b4-a406-7721-f3d4-26754c7f865c@kernel.org>
In-Reply-To: <61e964b4-a406-7721-f3d4-26754c7f865c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFqWlRJek1XRXlaUzA1TTJNd0xURXhaV010WVdNME15MWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWTJVeU16RmhNekF0T1ROak1DMHhN?=
 =?utf-8?B?V1ZqTFdGak5ETXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhPRE14SWlCMFBTSXhNekk0T1RrNU5USTROVE16TVRZMk9USWlJR2c5SW1J?=
 =?utf-8?B?NVVrbHpLMUE0TDB3clZuSkdPVEExV1ZOU1psTTRUM05XTkQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWxVNVNIbFJlbE5tV1VGVmJYcEtkVmgxYjJGa1ps?=
 =?utf-8?B?TmlUVzAxWlRab2NERTRSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQldGRXZhbXBSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 418c1e3b-3c1c-4a9d-2eb5-08d9f5e4b4e8
x-ms-traffictypediagnostic: BL1PR03MB6120:EE_
x-microsoft-antispam-prvs: <BL1PR03MB6120A8156A73EDBACD76F1D09B3B9@BL1PR03MB6120.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+9Q+7W4obi0kZ//+Cqst4JZPkPSyd+aJJura8Vkj9qku6uOgP/9CteFV7ZT362+Rp9a9vR9TWk9uu3JoR7E8z9QgIjTr5tw4xDe6mKJqzn24y+KvUk+cRJKzAEMLsKlxB6iacDwqkXS0GZcx57md3YSPzU9bLosPg0x78TipdvgIgXOjNNN4P40ufcZ4MGtqGLTfulAqOIJiDiRt2GjeBGCSiSS0ap5pDnwJIlp1XyHBrtNqk8/NS0y0JuGq1B8Jry5+qjPBPV5Vwe0MRZNFnSCZiW+9dpR9B2BHbUnSRl+rLuEmIRCmBmb9DjPM45aoJDc4YnBjCby9gYdRADt3PwnFJGSdK4iuKq3L9muz2M+NUlzQen71Sq+Ie5J/p+djsOr6lsggKyjb1ds057k21MmLz6EDEtHW4yLnCLZA/CtNHK4Mfw5EZZ/VAu7xLlg9I3cgFtXxxfREZ1JygjNLn8my9QJSVlzr/Wf4TWzBG7ZD6ZlxGtqpxZWZ023xgLgjAGd99bTxSFy98HMTDxM7vkKzrgUg78k7FWJzSUBfs4ujx893r6++JUBsNnCjqK8i+jLMaBl1ughDFgYW/icApDsBSNSnLQJ82FDRY4n9erEN4qLy/ElXP0BbDPIRbyNEEibIVuasP7voT8EDzx76CdIasK0Z1AQDi9Gv/dxkCZk3BMmqG6R4pr3ob6uE4BxV4dXX538sn3zI7PnYvSvyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(122000001)(508600001)(52536014)(5660300002)(86362001)(8936002)(316002)(76116006)(110136005)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(33656002)(83380400001)(55016003)(186003)(7696005)(6506007)(9686003)(53546011)(2906002)(71200400001)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTd4SW8wZzBDQU4rSjcyR3czd3NRbWs4Szh3YnNvUndpa3lxYWxiTUhJVTdj?=
 =?utf-8?B?cGNjclNHZERSMHFJdWIzYlFSQnltZDUrWldXQkMxbU1oSzk1b20wUmtKZjNv?=
 =?utf-8?B?SXc0TExTWEY0RVVkVVJWWC9PN3ordlZxTzVtYnRmVjRKK1o0dUdLMjBuc2tt?=
 =?utf-8?B?Q3ZQUHZDNUZ1TFRwSlMxK2dkaXE3SlVFWDNoY0lkTEJlQldvbWpEMlE1NnFM?=
 =?utf-8?B?SGZISzdTUEFrTEZrL3I1MU80akJmQlpYV2VqK05NcGZEVStsN3RkeWErRTZi?=
 =?utf-8?B?M21jVkhtc0Y1STZMdE54SlNSWTdiMzg5L1Z0anI3SjAxTjlGL1FraTcyYVpY?=
 =?utf-8?B?TU1lVHZibmFGdS9MejU4anZ5Nkd3ZTdPU2ZQVGxSY0lxZFdaaDR0WnBNSVFj?=
 =?utf-8?B?ZllyWEtqZ3ArUmpGWXF4cGRnQmRmanEvOWlSMjdyTDJvYkJyc2w5UWsxeVlk?=
 =?utf-8?B?amZhekphQW5mVEQySXpBMUJqeXpLMTJTcVJJMHJXdXFTc3duK1prM2paYWtY?=
 =?utf-8?B?c25PWWs5NkVNQjR6aUg5blRHWmFGd1dCOUlmWHdhK3grSCtqMDhVcjFpK1p3?=
 =?utf-8?B?VksvUGhtd1hBaTdnSDNpMlYwR244eUFzNTU5bmpnWFM2aEp6cTVxckVIcFJm?=
 =?utf-8?B?TDRBalVNdFBkQ0ozd1RNcWUrZEVzeVp0MG4xM2Jpb2s3Y1gvMzZZU2lYMFR5?=
 =?utf-8?B?Z2tiUFBrNCtMZ2dmZ0E3dGVIZWwvbTBzQ1Z4Ly9GOTdrTlpjcERIWDJDQW91?=
 =?utf-8?B?bzFIaGZVc0hNNEovd1p0ZUgxaU9IMXAvUWo1Z0x5cW9FdE9hYng0a0J5Zzlv?=
 =?utf-8?B?RWZNSm5MZ001L0g2ZnNQUnVTczVYb2o1cld0NER6YllERFlmMmxFVnVJYW5p?=
 =?utf-8?B?VzFES05HOEtzamR4TVIrSmhiODI3UXdFM2FhOHQvQjZjZkVVdDh5TTk4bEY3?=
 =?utf-8?B?YTZrQTF4aFVjOUpGQVptajVpSG5jSDhHTWZHazNBaXE3Sk5Wb2JrbDJtZTdF?=
 =?utf-8?B?Um9PUjFveEFhVzZ3YVNMWEhNUEJPRVNuRUlhaG9ZWmtjLzNkZXAyQXdML3Zh?=
 =?utf-8?B?eENGUEVHY01vK3NwMk9jS056SStlOU4wQ0Q1blRvQkh6K1BHUXdibE5PNUtq?=
 =?utf-8?B?eGVCSkVpT2pReUgrZGFUdUVkbFJITnRtVDJLbE5CbVJNZVRMVFBtcHhNOG8r?=
 =?utf-8?B?TmFnQ0tGcGl2L3RqYnJNMTRhK296V2tieXFINGNUSmxHdk9XRVBMeGkzNUFy?=
 =?utf-8?B?amlxdHV0SVZpaVMwTDJqbFZDOGhSMkJZTkQvRW15M0ZPSVVuWmVTdms2SHpt?=
 =?utf-8?B?bTZ2cjVkQXdqU0p3VXBycEh5QXIwSlVIdjRlYTNrWmJZV0Y5Z00xY1NyNmg4?=
 =?utf-8?B?dzRRblQvVnZlM3FlRk5sZGhaOUVoME5hbVpsRFhxTGQvbnl4MnVmTVhWQzZE?=
 =?utf-8?B?OUlreGx6R0ZqaUdrRXp0L0pmQ3VlS0FueWMvYjlibXhrNUFxZzRDMlpJZlc4?=
 =?utf-8?B?OUtnOWoxZXJJQjhBekQ3TkpwZUo3MnFFYmFLbW9tc3pNbklPSDZmZkxhL0NJ?=
 =?utf-8?B?Q2ErRS9pbExBckNTdzZUM1FqK2hJeVJlOUUrTld3Z08xdE1jWHREM0RIQlN3?=
 =?utf-8?B?L3labU1PZHo4aVJBQUpVRk9vLzNzK1ZmVnBHYTVEUXR3dW4vZ0JvWjltOUpp?=
 =?utf-8?B?RTJZbWh0b2pCZVh0VW1zVm5hSkdid09yV3psNTYxNm4xWjdaYzc0a3FkbFZm?=
 =?utf-8?B?UmExQURVNDRQbG1VT1NHTjc5U3pJQWVUeldKYS9XTDI4NktyTnpRUS9EbGhU?=
 =?utf-8?B?bDVOYXRUZ3MxUFNTVEx1bTVTN2tKNEtWQlE2ZFBUc01YbHlWUUEwMU9kZm90?=
 =?utf-8?B?QzNYOUsvQ1BVUmovTHlpK3o1c0RYdUxZV3RKa200MHRaOE9JdTk3c2VIQlp2?=
 =?utf-8?B?TWtRTjAxMU1mbjNndUhBenlhRkR5d2EwQkNldVVCV21HSG0wUktaTHl2QjNa?=
 =?utf-8?B?dWg3cER2MGtiR1h4NXREc3JFRlV2T3BpUmFjbHQ1ZTRQNGpRYXl0NXF5RUh2?=
 =?utf-8?B?WGVpaGpQeVJTZFJybmpDelJxcEFncFVoZVFaSzU5SjUyQ2ZmenQ1TGVCQUdw?=
 =?utf-8?B?eVRwd3F5UTJwQ3FyQ2h5ODdCNlRDcldDQjZBRTZCdmpncEo2RXBJa2M4MmE2?=
 =?utf-8?B?TWtGeGRvRlZBUGNrbzNETU1URmdtNzA5cTU5UXo4RlZvUWVNR2RDYU1wT0g1?=
 =?utf-8?B?UWtsdGRRdFpCWHVmazNRZXYyWE1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418c1e3b-3c1c-4a9d-2eb5-08d9f5e4b4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 09:21:28.5005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SI05/rV+7aW2sFFfOb5Pl/4UII3k4UP5hWBxDhvXU2LnbplD1WgLYq3LjIOz0sxaooPxadsp5XppEEb0pWSv8iryOcEEH3bVexX+kf/nRoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6120
X-Proofpoint-GUID: fbgaZGrkW16opQwdOQFd01AnfzQcmkCY
X-Proofpoint-ORIG-GUID: fbgaZGrkW16opQwdOQFd01AnfzQcmkCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_02,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=998 adultscore=0
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220053
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQotLQ0KQW50b25pdSBNaWNsxIN1xZ8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1v
bmRheSwgRmVicnVhcnkgMjEsIDIwMjIgNjozNiBQTQ0KPiBUbzogTWljbGF1cywgQW50b25pdSA8
QW50b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+OyBqaWMyM0BrZXJuZWwub3JnOw0KPiByb2JoK2R0
QGtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjQgMi8zXSBkdC1iaW5kaW5nczppaW86YW1wbGlmaWVyczogYWRkIGFkYTQyNTAg
ZG9jDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiAyMS8wMi8yMDIyIDEwOjI3LCBBbnRvbml1
IE1pY2xhdXMgd3JvdGU6DQo+ID4gQWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUgQURB
NDI1MCBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbml1IE1pY2xhdXMgPGFu
dG9uaXUubWljbGF1c0BhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+IGNoYW5nZXMgaW4gdjQ6DQo+
ID4gIC0gYWRkIGBzcGktbWF4LWZyZXF1ZW5jeWAgcHJvcGVydHkNCj4gPiAgLSB1c2UgZ2VuZXJp
YyBub2RlIG5hbWluZw0KPiA+ICAuLi4vYmluZGluZ3MvaWlvL2FtcGxpZmllcnMvYWRpLGFkYTQy
NTAueWFtbCAgfCA1MCArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1
MCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FtcGxpZmllcnMvYWRpLGFkYTQyNTAueWFtbA0KPiA+
DQo+IA0KPiBQbGVhc2UgZG8gbm90IHJlc2VuZCB3aXRob3V0IGZpeGluZyBwb2ludGVkIG91dCBp
c3N1ZXMuIEl0IGp1c3QgbG9va3MNCj4geW91IGlnbm9yZSBjb21tZW50cy4NCj4gDQo+IFBsZWFz
ZSBmaXggb3IgcmVzcG9uZCB0byBwcmV2aW91cyBjb21tZW50cy4gUGxlYXNlIGFsc28gZml4IGFs
bCBjb21tb24NCj4gaXNzdWVzIHJlY2VudGx5IHBvaW50ZWQgb3V0IGZvciBhbGwgQW5hbG9nIGRl
dmljZXMgLSBmb2xrcyBmcm9tIEFuYWxvZw0KPiBhcmUgbWFraW5nIHRoZSBzYW1lIG1pc3Rha2Vz
LiBSZXZpZXdpbmcgdGhlIHNhbWUgbWlzdGFrZSBpcyBhIGJpdCBhDQo+IHdhc3RlIG9mIHRpbWUu
IE11Y2ggbW9yZSBhcHByZWNpYXRlZCBpcyB3aGVuIHRlYW0gYXBwbGllcyBvbmUgZmVlZGJhY2sN
Cj4gdG8gYWxsIGl0cyBzdWJtaXNzaW9ucy4gSU9XLCBkbyBub3QgcmVwZWF0IHRoZSBzYW1lIG1p
c3Rha2Ugc2Vjb25kIHRpbWUuDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0KSSBoYWQgYSBsb29rIG92ZXIgdGhlIHByZXZpb3VzIGNvbW1lbnRzIGFuZCBJIHNhdyB0aGF0
IHNvbWUgb2YgdGhlbSB3ZXJlIA0KcmVwbGllZCBieSBKb25hdGhhbiBhbHJlYWR5LCB0aGVyZWZv
cmUgSSBmaXhlZCBvbmx5IHRob3NlIHRoYXQgd2VyZSBzdGlsbCB2YWxpZC4NCkluZGVlZCBJIG1p
c3NlZCB0aGUgIlBsZWFzZSBwdXQgdGhlIGJpbmRpbmdzIHBhdGNoIGFzIGZpcnN0IGluIHRoZSBz
ZXJpZXMiLA0KbXkgYmFkIG9uIHRoYXQuIExldCBtZSBrbm93IGlmIEkgbWlzc2VkIGFueXRoaW5n
IGVsc2UuDQoNClJlZ2FyZHMsDQpBbnRvbml1DQoNCg==
