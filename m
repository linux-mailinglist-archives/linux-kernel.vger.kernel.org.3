Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F1552BCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbiERNNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbiERNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:13:38 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9271AB78C;
        Wed, 18 May 2022 06:13:35 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IAe7gf015430;
        Wed, 18 May 2022 13:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=nDFRUfTmxnJViVih8+jcMgb7fEQBBl2ABBsCg7xN3V8=;
 b=jpJwTHd1cII0d5cSIFZFLRBrfoV4fQis0K71AbBWbttjrLvb5bL27PqrXMSDasm7Gnle
 uDmU+wHuR1ux8hIRMFu09Uv4v68HXgYPtklfNfZP6pceCTO7GF0JJvmAYKh4mVyuOAoY
 sS0FewrnrWFtjBHl/YWmmsI5AzyrNTAREWTN5lSlV6myWmtQFAIOU/DDkZlnFihc/hEl
 ZUJ38FtUtpVheBLGBtjKI2JelPjslfreO5N7Ux9yCOOOwz6/d6gy/DxJkmQXbbb29v+n
 rpcUeZ6Xf5f3k4Nk2NGKQOEEHBteymfNCCrI7bT5iW1F8Y26tVqNLMYudIFN0i5thhHN vg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g4fkjdnf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:12:52 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 815B68005C9;
        Wed, 18 May 2022 13:12:50 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 18 May 2022 01:12:43 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 18 May 2022 01:12:43 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 18 May 2022 01:12:43 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 18 May 2022 13:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsiWygSe9KyRIRQlfjSCTrh1qysWSIY6r4WeZ2JSDuHQWUp8dCg95gnMuOHkGINPdlvA5P//uQz0cII0qBS9BRVf9GEnj+nlMfyTBd/DiAPQYHniBlhyCKbPHy0z4qg78fYALs3Tu35EgaPh2kvezDgAMVH2buwoXiXDZcheXNLVMUpet2Hixl7YV0gDvU1x6SoxeL9WuKjYHLkAe/a4QcOO3CJpGME+XTPyt4b167fvCwu4gnwrBJmnycY4cppBYiXKDoHDNwOyk7GxOnFGV85xhCegmXOee93J44nsIy3wOWly1DhYTLoyTTrdmcc1ijhT2zzGHV7V83dgTdrw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDFRUfTmxnJViVih8+jcMgb7fEQBBl2ABBsCg7xN3V8=;
 b=EKHF4wiEjgYD3pQCZ3mzJVdsRA6DsX9EH/6qIu4PWhDNkYXCEqcVGLtc7chi3rkxmP6EaFxy2Sw4voL2sGJav458GZT9fk9ll5ir4LqI1ftTm74ibVZ6Bog5Z7xKS+BTGujGrPcO0TcoI/VM44O3+YAHAcj/vP+VgqxO0waUk9AQUFE3ENBRwA7ZGvcju8vNDyjRYPY22xw2taaswdSA09865UR5iyVLT699FXu6BT1qu0vxKm0Ds4EQWpB3fDmPYfdmZDeq8FTporBuG8qT4nyb/yztbAdM4QuPF9+x5nKeFxcwD8PTGZvZlOrBskkf3ErsHtH5xY2O7CL/uzAglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1954.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:16e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 13:12:41 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3d5c:ba8f:36f4:5170]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3d5c:ba8f:36f4:5170%9]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 13:12:41 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Russell King - ARM Linux" <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: RE: [PATCH v8 0/8] Introduce HPE GXP Architecture
Thread-Topic: [PATCH v8 0/8] Introduce HPE GXP Architecture
Thread-Index: AQHYaUJvp8sRjYC7xEiGFsYpvFYNCq0kjryAgAAKzQA=
Date:   Wed, 18 May 2022 13:12:41 +0000
Message-ID: <DM4PR84MB192761B3970E4934D059C3F188D19@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220516163310.44842-1-nick.hawkins@hpe.com>
 <CAK8P3a0914=TM9f1CNcg_PXfHvt6nHDPyrvLp=0KO4hZM2GT5w@mail.gmail.com>
In-Reply-To: <CAK8P3a0914=TM9f1CNcg_PXfHvt6nHDPyrvLp=0KO4hZM2GT5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bec2b1fb-24f8-4ffe-f438-08da38d016df
x-ms-traffictypediagnostic: PH0PR84MB1954:EE_
x-microsoft-antispam-prvs: <PH0PR84MB195467B4700541EFAAE171EE88D19@PH0PR84MB1954.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bR1Mt4SEB1OMERVMXj17XiqYqLCWasjWvPTHrEkuLU9M3c8ySugGY1sj8F2CxDI5MaU/1C/Hm+GV2P8SzOejrEVIjegQREZGaCD2gr+cJzOFt8k+S60oy8+T38zBp+lWN0hlc7aNwLGMS0Wpi3LZigV/FsHuxUT+qvJu0mcwqRMSNlYcwL/+7IGDUbfdXM8P00M2ilnwb4cFKCUFxgjXudwafpUnltXoKbQ/r2svBmTeQO8Znw5Uxi7kyqUHYAJL7KDeqv7V6HyKUffRKSvmjM3Tvjuedx7AjS1PbL3W50wzYHgWrbjzBIngGxG/QFa3CzeExhgg+GAL4NNIAFO+v9zSvAQ5Lkj/vVodwUMzGKvHoDG1QNRLFY/bfOoymlP4G6QPegDGm7b7asNS0CaMMgXY1X9VPhaZ/xyk372fPmvXJInS1LuZ5sEPN1+TbnA97ZlSi2rfIln5i4OorhKJbABnnUVuN/9+clCaC1BGR6Xo7OyKv3Gax+rVkYSqEkXjwOcUwLd5/NHE1PoKXO+9fkbsy7hnmGR8y7i7ZzY5cFST+TZUQqJlUYGAcMPMJCnz9EhP0DbE5x0S93mmj2Z6G+XXneztVYWXsgWXLsdS4rY1CTUzNvKwyzD/4asFr/Q/K6MiJqv9cKo5Yl8hHt+XT1XispQnMucN/jNwsmBqLyrDjqK5YK2vXm39WRgM0g3VyzytT+OsK8QCPbcTt43Zpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(186003)(8936002)(52536014)(71200400001)(4744005)(55016003)(5660300002)(508600001)(6916009)(54906003)(316002)(33656002)(8676002)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(7416002)(122000001)(4326008)(9686003)(26005)(38070700005)(38100700002)(2906002)(55236004)(6506007)(7696005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXo1N2JWYXpZMUlVYTVNQWwvQ0ZDbjl0clZJelRUQStmSVlYK0hxVWFmSklJ?=
 =?utf-8?B?YTZMZm1WdGVlQnU5K1ZqNUxGOWRtWkkzY3l0ZExXeTNlVG50RDBwM3kvWFg0?=
 =?utf-8?B?eGZpRlRza2tVblptR1lQL1BNWnlUYXhHemJ6U2QvSEpFc1V4WHJOK0hONy96?=
 =?utf-8?B?RU5QM08zcHFxMU0rSTg3cjJtNkN6MFdLVDFOdzRKRHhCUFRzRFFBTko0ZHRI?=
 =?utf-8?B?dFhJYWxoOEtTYTdRNEN0ZDIxa3RNdW1ySkVQUnN3UE9VNTZ6bGd5akUzUERT?=
 =?utf-8?B?eGp5R2N3NnUwU0VtS0phSk9taTlrWW13YVcvQUxhNlpwb2hvZlZLSm5kczNi?=
 =?utf-8?B?cmhrQlBOdnBIb0pQZFhXbG0yeFpJaTQrNkIySExBN2VualpqVGVsZmFyOTBw?=
 =?utf-8?B?R0FiSWFaS0oxN3hSNEd0aDV1dm1JTkZYaEF1dFMxeEZzQldJdk8zS0ZXTTk0?=
 =?utf-8?B?ZGZ2ZFpGRVFVQ0tQYW5xcm5zTXRYM24vem1XcFBaM0FEQWhWbFp6VWNSc21o?=
 =?utf-8?B?RkZRNHhOT3RPWnhrL0VUdFpIRVpVdzdlZEk0ZDUzK293czNqbUZPSEptUG1h?=
 =?utf-8?B?RWVBSnoyQXlXMlkzdjRnU3hodUFBVUpVeldERTYvcUJYM3dqMGhGaFFmdHhS?=
 =?utf-8?B?MU1yMm5uNEFZbGJZRFNJc2dUTUcvZXYyaHUxcW9RdHZzd0RGd0FSaW9sd3BZ?=
 =?utf-8?B?U3J5Q3lLeFJkY2ZyNXJxdUpmM2xaZEpCWGdKdURVNjJ4ZXJVaTlKTGY4Mmp0?=
 =?utf-8?B?MmpVSnNGWkM4TjBveG80NFQzakhqRlZSdUJBQTd1eDZFcVptRmpXdFlEQ0xX?=
 =?utf-8?B?aFFITjBsbWhHUnd0SDNGQTQrQmtFZ2FJQVZkd0ZheWpkZjhsdEFXeDg5LzYx?=
 =?utf-8?B?a3NQN1VkcWdKUm9ETVRyRW51Slc1R28xNXdRZGJwUG95ZHBhdlYrVW1tdHNj?=
 =?utf-8?B?SUtwcFpMTWZHUXR4UlBSclB2bGVZUWMvdHlMNXBDekxjRzUyVXRYZ2tlTnRP?=
 =?utf-8?B?SStNL3pjTkRtTWd5U1VqZlZWaDFkbTVTUFBldFYrSllqWSt2K2dLb2xZWjdS?=
 =?utf-8?B?cTVuc3daUXJtQWhPTk11bDd5SW51dWE3MHU4TzJnTkh5SDhaZENoQWJPQm5n?=
 =?utf-8?B?VmxuSHpMeXJIaWtYN1NCeStmaUx2cW1tbTRJQkhEV3U4eWVYMFlzSTQ3Y3Uv?=
 =?utf-8?B?UmFLTWlzT2RVM2VBNlQ3M3ordlQrZHlva1Vvbzk3VE9RMnBwOHdZN0ZGR000?=
 =?utf-8?B?bVdybHZvV1FtS2czS0RORGFHeUw2Rnh4RDNQallPbHlHVHgzRkVTaHpSbjNJ?=
 =?utf-8?B?VlRMMFdpekhua3ZBZ2JuZ0trZHFlMnNMVDFQbzM4U3BYK2NzRmpEbVQvL0dl?=
 =?utf-8?B?YzdwSDZZcnFRUCtJRG5SM2Y4d04wdEVCN0UyYjREYnhIa0NCR0xEWG05UkY5?=
 =?utf-8?B?UFRQTWFSYnNrM3daa0x2bTVhanhGZEJsS2VlT1YrNGtvV0lCcG5JNTJJVExy?=
 =?utf-8?B?c0ZWUmFFQkRTZ0lFMjNyd3hscC96bWt4Nk5RbHdyR1pRVDdsMVpKMStqRlF2?=
 =?utf-8?B?VEZnWWZBYkpyOExXQm1YVjlscTlKenlGR1BCaENYVzE0cktmTi9MVFRZNElx?=
 =?utf-8?B?d3dSeCt4TnBTeTlDaVNSbE5henlXcXZPbGxqSFdCSWxXZUhacEJsbVRQV05Z?=
 =?utf-8?B?SVA1S0xsSFdUUnFVSStscnIycXlXMnZwUHdKTlk1N0hNOTFJd0t0U3ZrM0Zz?=
 =?utf-8?B?MkZEMG0vOVY1bVAvVG9mN0g5ZVNLeWFoait3SE1RUGRUcEM4OU56UWhLWndQ?=
 =?utf-8?B?bGN6ZW5zV2hnQTUwSnVQU3J6R05NUDZPZXc2bndNbU5FZjA1ZC84akp2eHZK?=
 =?utf-8?B?OGR6RytmOFNyWHppTEJrREIwMXlIQzYxdUlaOGcvbG5vR1BVZjhZMEgwaGF3?=
 =?utf-8?B?UEJnSHpqdHI4ZUZTQytSK0VEejhtaU5EMm8wcHgzWUkzSkcrQWFqUmUweThX?=
 =?utf-8?B?RVN0UGNENmRSeTJqc2QyL29Nd21XcjBJN1lpeUJlczBTemFtcUc4U3ZRSXRG?=
 =?utf-8?B?ZWlSZHhLT2pSVE1vc2hMdWp3NFFTZThKSUxPcHJOekpadHFlbStSR0pvNkdn?=
 =?utf-8?B?ZEFnWlJUQ2ZXZDlaZ1VsS1ZTdEkyZ0VPQkdCb1Rya3NTRUxUWktxam1KYXRP?=
 =?utf-8?B?aEhrUnFWVWZJaDVZSXFrRm8zNXFTTk5scjZRS1YwT1ZBZld4ZGJLUkQ1d2N6?=
 =?utf-8?B?NWx2VEtZcUNBSlVmeUI5Z0JWaGdrbi9wdC8yQ0tGSVIrcUtDellrN0d2TnBH?=
 =?utf-8?B?cDhOMi80OVZmcjNDZG1aTmV0eCs1b3VoTWxGcXRLeG9EYVptYmZQUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bec2b1fb-24f8-4ffe-f438-08da38d016df
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 13:12:41.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/nti6zurdNoVwiKPv1IeWZ1X6B/Cnk+ieX+EAu5LDJTW2RLUpRNXI2o0ZUwrRQEWpq0tJTBoMqOUdOYsf/+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1954
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: xX61qDE9j6m2vLFCyv0XMrBUyi41hmhY
X-Proofpoint-GUID: xX61qDE9j6m2vLFCyv0XMrBUyi41hmhY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_04,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=571 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180077
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBOaWNrLA0KDQo+IEkgaGF2ZSBwcmVsaW1pbmFyaWx5IGFwcGxpZWQgdGhpcyB2ZXJzaW9u
IGludG8gYSB0aGUgYXJtL2xhdGUgYnJhbmNoLCBidXQgc2luY2UgSSdtIHRyYXZlbGxpbmcgYXQg
dGhlIG1vbWVudCwgSSBjYW5ub3QgYWN0dWFsbHkgcHVzaCB0aGF0IGJyYW5jaCBvdXQgZm9yIGxp
bnV4LW5leHQgYmVmb3JlIHRoZSBjb21pbmcgbWVyZ2Ugd2luZG93Lg0KDQo+IE15IGZlZWxpbmcg
aXMgdGhhdCB0aGlzIHNob3VsZCBqdXN0IHdhaXQgdW50aWwgNS4yMCBub3csIGJ1dCBpZiB5b3Ug
YW5kIG90aGVycyBvdGhlcnMgZmVlbCBzdHJvbmdseSBhYm91dCBpdCwgSSBjb3VsZCBzZW5kIGl0
IGR1cmluZyB0aGUgc2Vjb25kIGhhbGYgb2YgdGhlIG1lcmdlIHdpbmRvdy4NCg0KPiBJdCBzdGls
bCBuZWVkcyB0byBwYXNzIGFsbCB0aGUgQ0kgYnVpbGQgdGVzdHMsIGJ1dCBhdCBsZWFzdCBpdCdz
IHVubGlrZWx5IHRoYXQgdGhlcmUgYXJlIGFueSBydW50aW1lIHJlZ3Jlc3Npb25zIGZvciBvdGhl
ciBwbGF0Zm9ybXMuDQoNCkhpIEFybmQsDQoNCldlIGhhdmUgYSB0YWxrIHBsYW5uZWQgZm9yIHRo
ZSBOb3J0aCBBbWVyaWNhIE9wZW4gU291cmNlIFN1bW1pdCAoSnVuZSAyMC0yNCkgYW5kIGl0IHdv
dWxkIGJlIGdyZWF0IGlmIHRoaXMgcGF0Y2ggc2V0IGNvdWxkIGJlIGluIExpbnV4IGJ5IHRoZW4u
IElmIGl0IGlzIG5vdCBwb3NzaWJsZSB3ZSBjYW4gaGFuZGxlIHRoYXQuIA0KDQpUaGFua3MsDQoN
Ci1OaWNrIEhhd2tpbnMNCg==
