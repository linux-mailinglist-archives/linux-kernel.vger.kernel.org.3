Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3963A50FF99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351190AbiDZN4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351184AbiDZN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:56:13 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABDE1541F3;
        Tue, 26 Apr 2022 06:53:05 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDQbFs002755;
        Tue, 26 Apr 2022 13:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=vv2zxzg9or9pM0cT0Nn/4xyr5w+j/pCq/qCMmGuuKxw=;
 b=hhS9wquT8yppZW4wwbBnVWIlAfsQi5Bm580YBRm+uaarM0GTp9toY9KfRFm/tsH9SUZm
 erQnlf5CcFSVfdJ6xmgVf2Gh6fWL2/wup4o0b9qNe6US9BO4WCm4OxOMg/FXz0yVQFks
 zxfdQ9180sofw5q5efeHWIikHjOrgiortsrKbV9jK+eCF0c1VIHqeC3lFK+gJJJcDLX/
 tr3RVHNikEX5DpUFnerLqVtMUx4SqMz9ZSKkILIwQ6JmnoXF6r8PYRwnTqTEaDYSbeWB
 e1JhU0qz1w9amgu4GSYAK4foWelABGbXc9gF1dLUEsHO2dIi4m9jmY9KgEPRqIUW8aZg CQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fphmjr802-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 13:52:27 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8A5F5800359;
        Tue, 26 Apr 2022 13:52:25 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 26 Apr 2022 01:52:19 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 26 Apr 2022 01:52:18 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 26 Apr 2022 01:52:18 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 26 Apr 2022 13:52:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1r4IXdfk2AUfWQdKpF8XWvPl+C7qtvITd1LO4cKu8AferCYnA/P+V9sHztAxL6gsmAegoL+gbNMEpgTwsbZV6zbaa9hwcVaxC1hSsCApnXnWHsF5FbF9Xj3OYrOlD4IFHPsfBpw5u0KgvK8GunC3a/SQ0m8hoMc4nQVrVXqZHE12l4h4jBU3FHYFZyKux8dSYYAYNH0Zc63iCn7bkO+YGf5YEXphJ/zEQzfkrRmbIEl99/MFiCcAyxcRDt253ppDpv4R4cMjA96TktvII5UX9RearNUiwcrsbM7QExP+AimxrSvYXpGAvzvV+Uox3heNisFQ3uTNJ6i9gnnxbZMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv2zxzg9or9pM0cT0Nn/4xyr5w+j/pCq/qCMmGuuKxw=;
 b=FiYPQIgc8+mDiWRVG4cTh+MH4qAqt4fVZtbqDzcnK9ouv4AHzaTa7+RUtyvBXN0tjP2xpZ6Az9AwhvUysMSdKCBIz0BOshu0jFSDFyidMqavInLtES8FZyGIsJyIBLnRD7dJ+753ulFRMiQuHcEcKL5qollIrnykZCKB8TpIiZaDB5lWU9RXu0miWFQd3OPGzHriYw2eUC7etTiWS+2kiJj9b9sBU+eQX/8cOPY4mHzYG0mOgcQXVPSHUOhGtr5nKeveaNQ7+2w0exEZdWtofucANsGS6/YNCMWrpioNm5uTffQjTyFlvUza+Iz6iIkNeCVxUdJzFTSjWt2r/DSSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by PH0PR84MB1360.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 13:52:17 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 13:52:17 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
Thread-Topic: [PATCH v5 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
Thread-Index: AQHYVbTOsVjE6kZL10OpjL+eSsDcLa0BNZcAgAD++BCAAATIgIAAAJqA
Date:   Tue, 26 Apr 2022 13:52:17 +0000
Message-ID: <PH0PR84MB1718D9B549FB0CC6FDDAA19788FB9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-7-nick.hawkins@hpe.com>
 <YmcbCgjD85lIRMSf@robh.at.kernel.org>
 <PH0PR84MB171845F606BC40AD653BEC8888FB9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b9d68100-c6f3-4f58-fe42-63f4cdf1dc50@linaro.org>
In-Reply-To: <b9d68100-c6f3-4f58-fe42-63f4cdf1dc50@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d728312e-82a8-4803-7214-08da278bf9e9
x-ms-traffictypediagnostic: PH0PR84MB1360:EE_
x-microsoft-antispam-prvs: <PH0PR84MB1360BB550BE742EB29F7387088FB9@PH0PR84MB1360.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gvQn/KMN4RNRi5IDoYm895a36auRwPMEVIjbkcUDElqkNCO/AfjVxYEJSNCXBw/5gXPFiI1l8L0VhyMtDxA+aQoaXHc5W6RWax6NniXloMO2syAHrGBWwfB7wY09M47SVyBb4YAr8zGIFInDATRW8LrWLmJ2KlyXlXGpH40+9zs1hT60Da54LgYB3kQtpuAjH3YmkG46IBGRYdW+0zgXm9Af4NOm+oPfBxoyZdGamydsOKppV1d9JxkM9M8e/o6cGLjzGGC0AfEkgsKC9hOH3bXgnEgDeIDl9G+MU5Lwq6pUkaPkBHWx1RRnNWHgz6qkCmHpLJ0szfyMXAtGfhPkkeL4ZLo0GFMzOxtew9FD9HYPS4xaaxonVDU2U2dS/KQrhq4f+tP1aWYGWHU3FLBuP6HLsrgYN/IVPmV95wwYMXhH2fomMzfhNoAPcWpBMwZJ5dZoUjBdSgPkgT17Q9elFp9gaF6dL8N/f8MlJlNpoPQXPVxcFDcH1sIZcXa2zapzzB3zixlVn9MlSCGGDWgLAwIEBtjZW35uXwmZmPl8sBkV1Q/DRXKqVx4z76BP0I8hXB3NGWYiUvJL/nSGuzlVS5MIs5aceR8wHziyAKz/tZ26fqLqnVEK7SvdTHJ4cz5lZhardqEpMv269xCPs7eVqbxAFm7a6OdYGZXbeJmJ4w9vQd/71VSkkJC3OgXm6n1IJeOqUo/KG7NDQXJCTAs3Qd7ODTgyYUCBlW0pRCMOlqk/O1OArid58lHzX+T8SxdO537XuHs6JEBWzQA2Y6JQHrsv213JhfyNXIjesL+Y8P/ZPYR57P2BtCj1c209X3dxCLUleIk5PWvwjqIvPhewQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(122000001)(7416002)(316002)(52536014)(7696005)(83380400001)(508600001)(9686003)(38100700002)(38070700005)(26005)(966005)(55236004)(5660300002)(86362001)(8936002)(53546011)(2906002)(55016003)(66446008)(66476007)(66556008)(64756008)(4326008)(8676002)(54906003)(186003)(6506007)(76116006)(33656002)(110136005)(82960400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFZvTEhFdHQ1YnpyaTJKbU1pSHVrQVZGY2J6aVNpdGpPYjkyYnVoTUhBWkIv?=
 =?utf-8?B?NU16TklIVzhnYVhCVHpCNUdxcTQxZmwyUGlnRFl2Qms3dG5Qa29NbnJBTWpU?=
 =?utf-8?B?MUdhK2llWHBTVlFUU2I5SmVHamxaVmxVRHk0MUw1SVBrS2JnVFNHejJxQlRB?=
 =?utf-8?B?M0dab2trMkl0MktiQXdsUGZ6UVZzWEg4LzIySGF1MWlHalZWWUtHUVlWVFlO?=
 =?utf-8?B?cmdDY3NUcnVqcWEvSjRtMkdFQzVLbW42TGp4SzdIUFBycU01WEY3K29wbUkw?=
 =?utf-8?B?a29oS201cGNUU3RPSWVST2JDZHZFczdITmhwMnpWQjlkZ2JqTGJ0V0dDS3JF?=
 =?utf-8?B?V3dtL1dhMU9nQ3BFZ2dWejEzeUR6dy9ON3poOFVoV1luTC9QT1VDWjdlMTh2?=
 =?utf-8?B?T2ZYbCtZcThZbmJwT3g2TGtUNFc4dTdkc1I2N0hRaHVOMFcyR2h2TWJIREpa?=
 =?utf-8?B?a2xKVTZPTTR1eEdjTUZxbmpjUm5iRW9IWGJPRmEvYzN3NDJvTHVpdS9JQml2?=
 =?utf-8?B?Sjl2anloT3dTY0VwRXNGVGEzKzZhNmVCSkFYeHVkbTB0V0ZOMjdjaWRlZzY5?=
 =?utf-8?B?MUwyV1ZIc2pTTEFTTnNNUzREaHhlclBhZThxWDQvZWZLbVJZTVpvOExaSW5S?=
 =?utf-8?B?T2E0OW43RjFVYUtZa1daT2FxdnFaN2RDRUJEdThFVUVER2twOWNjWXNaejRC?=
 =?utf-8?B?Ny9JTCtxQzRNT1pDWDVSMFZzVmtlVE02a21WM0FjV1FEWDNMaGJMY3ZkKzZD?=
 =?utf-8?B?S3lIS2RmSzl0aFJzWlVRS0wyVWtKQk80MjNzOExTcGhXLzRIc1I0MVZVZGVQ?=
 =?utf-8?B?QzgxUmJPM1k1WEFzMGI1OUphb1pUVkRIN01qcUd2Zlpja0Y0V2tYdDMwd1BK?=
 =?utf-8?B?UEEzYnV1ZS9KaC9BQXVkVGpodkVqdytuMGM1ekcvYXgvWkxXbzZFWDhyNS9i?=
 =?utf-8?B?NnE0ZGhyK1YzaUtIOGZKaXpnY0U5MmhIMGwvajhwNlFuUTVESXRwZ1VVZzh0?=
 =?utf-8?B?cWs1S0EybldDOVZxSVJWNnVudmZLa0VuS0VzaC9DbC8xTk1iK1JYNUowb1Y1?=
 =?utf-8?B?NWthdTRUSFFoWFBqa2xRTVJHZkRacjNONEhCeXlzMFd4Tkp3M09NMW1EKzdP?=
 =?utf-8?B?M2dPU0JzeitKR1hheHo5TkYxUkhtWXVrR1BGMWJKd2x3dVdaOXRLUm12cGhS?=
 =?utf-8?B?UTdKdkFsSTlxbjg5QVNSbUE5VHU3aXZvWDh5QTRxeUtYS2pyQVh2T3lLL1NI?=
 =?utf-8?B?aVY3bUFGNU15UjZ6OGZoK0piQzN3QzladEtkeDhPaDhaTWYrZVprMU5DQmVs?=
 =?utf-8?B?TXlUU3FZb2w4UitYVk1xaU5OYmV4NFpJSnJEM0tZZDhQTU9KTnBJTWs2cGQw?=
 =?utf-8?B?S0V5K1JjNmdFcnYvT2JYS3U2UnE2czdlR0VJOFFVK1B4WXRzS2N5Ullxcjdn?=
 =?utf-8?B?Z2d5NWEyZlgrWkE1VzhrUlI5ZzRrQWhGMEdlQ2o2NWVuTVpiNklkMGdhY3R1?=
 =?utf-8?B?Tnk4UWt6RGxubEZVaGNYc3NCUGRSenU3TDd5TjNrWE1IR1lFMjZTWmNFUHZP?=
 =?utf-8?B?MDRYSE0zKzBaUElUWm5IRWs5bDdQd1kzeWE1VlY4TFFJaUQxWTh5bTYza0pT?=
 =?utf-8?B?d2JaSHA2NEk2MmVsSG1UQ3ltWllaeEFUYncxNTBtUVJ0WlNGbEI3aHlxT3dr?=
 =?utf-8?B?YWVkbDYzMkgvYnZ1QzNBMlV6MkdsSjFoNkJJbU95QmtTMHZqVGQ3OU5jTDZS?=
 =?utf-8?B?ZldXRkxOT2F2WlJBNnErTnI1elpHT0s0K3cxZVdwQjNIRGNyekNsUmlKdjVG?=
 =?utf-8?B?TXduQVl1a2NqRW5qd3V1eHlrYmpmYXExV0N2cEVISWxhVE0zVGZCZEV1ZXNj?=
 =?utf-8?B?YjdxSTdPQ2NObjFFRk5mZWpFemhjZ0hKb2VaSWhCdUJLUTdjKzVSYnRaQXBa?=
 =?utf-8?B?WGpwWVZYWUZGalc5TWtVcGtWQkcxQmNRdk56a0ZSamtOb0t2UXdXdmoxWW1k?=
 =?utf-8?B?MDFYS1VDNUFib0ZuaStGTG52T1hmVzRDTlNYdzQ2K2swbVJQc01QSVNDckhz?=
 =?utf-8?B?SUMyZ2Zod1E3eFNRalRvK2tJSG84Y3Q2eWZKRGdqZjNxNWF0WnRJTWFockdi?=
 =?utf-8?B?Mkd0alVkNnpPSDIyVWtwaGtxdWFnb0Q0Yy85Wkd2bHRWcXR3Ym5EUE9lekZH?=
 =?utf-8?B?eThGNVNjWlBBNDAxWXlrT3F4RHR1bUxvUU8zZHJSaGsxc1R4QVNWZFNtUldi?=
 =?utf-8?B?NlpaMlJ0cDZLVUx3bkJ3Vmdoa3FpTVc0UHlweUNhWnl1dUFHSHdxOTRIZDJw?=
 =?utf-8?B?aVdnakpCcmJQL2ZGUVlRSlZPNlNyWmlqL3orU3U2dWlYS1RDVmtWdz09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d728312e-82a8-4803-7214-08da278bf9e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 13:52:17.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvFMKYwdGBoQktAjK2hX35SdZEzOCzdNjLwgnMCSp3qg3XGeOeqBT85bKVA9ua+jkaHEOzmaHdS5NTU6lBkxDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1360
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: EdAiDaP_5RstoAaA8aDyU1vJmuD0yXTM
X-Proofpoint-GUID: EdAiDaP_5RstoAaA8aDyU1vJmuD0yXTM
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_04,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260088
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IFttYWlsdG86a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnXSANClNlbnQ6IFR1ZXNkYXks
IEFwcmlsIDI2LCAyMDIyIDg6MzUgQU0NClRvOiBIYXdraW5zLCBOaWNrIDxuaWNrLmhhd2tpbnNA
aHBlLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQpDYzogVmVyZHVuLCBKZWFu
LU1hcmllIDx2ZXJkdW5AaHBlLmNvbT47IGpvZWxAam1zLmlkLmF1OyBhcm5kQGFybmRiLmRlOyBv
cGVuYm1jQGxpc3RzLm96bGFicy5vcmc7IFdpbSBWYW4gU2Vicm9lY2sgPHdpbUBsaW51eC13YXRj
aGRvZy5vcmc+OyBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+OyBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBsaW51eC13YXRj
aGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHY1IDA2LzExXSBkdC1i
aW5kaW5nczogd2F0Y2hkb2c6IEFkZCBIUEUgR1hQIFdhdGNoZG9nIHRpbWVyIGJpbmRpbmcNCg0K
T24gMjYvMDQvMjAyMiAxNToyMSwgSGF3a2lucywgTmljayB3cm90ZToNCj4+PiBIb3cgaXMgdGhp
cyBoL3cgY29udHJvbGxlZD8gSSdtIGd1ZXNzaW5nIGl0J3MgcGFydCBvZiB0aGUgdGltZXI/IElm
IHNvLCB5b3UgZG9uJ3QgbmVlZCB0aGlzIG5vZGUuIEEgc2luZ2xlIG5vZGUgY2FuIGltcGxlbWVu
dCBtdWx0aXBsZSBmdW5jdGlvbnMuDQo+PiANCj4+IEl0IGlzIGFzc29jaWF0ZWQgd2l0aCB0aGUg
dGltZXIgYmVjYXVzZSBvZiB0aGUgc2hhcmVkIHJlZ2lzdGVyIHNldC4gQmFzZWQgb24gZmVlZGJh
Y2sgZnJvbSBLcnp5c3p0b2YgSSBuZWVkIHRvIGNyZWF0ZSBhIGNoaWxkIG5vZGUgZm9yIGd4cC10
aW1lci4gSSB0aGVyZWZvcmUgd2lsbCByZW1vdmUgdGhpcyBmaWxlIGFuZCBtb3ZlIGd4cC13ZHQg
dG8gdGhlIGhwZSxneHAtdGltZXIueWFtbCBhcyBhIGNoaWxkIG5vZGUuDQoNCj5JIGhhdmUgaW1w
cmVzc2lvbiBteSBmZWVkYmFjayB3YXMgYWJvdXQgbWFwcGluZyBlbnRpcmUgYWRkcmVzcyBzcGFj
ZSwgbm90IGZldyByZWdpc3RlcnMgb2Ygd2F0Y2hkb2c6DQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsL2M2MzA5ZWQ4LTZlNzQtNjdkMy0zMDRhLWY1Mzk5ZDE2Y2MzN0BjYW5vbmljYWwuY29t
Lw0KDQo+SG93ZXZlciBsYXRlciBkdXJpbmcgdGFsa3MgaXQgdHVybmVkIG91dCB0aGF0IHRoZSBh
ZGRyZXNzIHNwYWNlIGlzIGhlYXZpbHkgc2hhcmVkLg0KDQo+TmljaywNCj5CVFcsIGRvIHlvdSBz
ZWUgbXkgY29tbWVudHMgaW4gdGhlIGVtYWlsIEkgbGlua2VkIGFib3ZlPyBUaGlzIHY1IG1ha2Vz
IHRoZSBzYW1lIG1pc3Rha2UuIFdlIHRhbGtlZCBhYm91dCB0aGlzIGFscmVhZHksIHNvIHBsZWFz
ZSBtYWtlIG5vdGUgb2YgY29tbWVudHMgeW91IHJlY2VpdmUgYW5kIGltcGxlbWVudCB0aGVtLg0K
DQpLcnp5c3p0b2YsDQoNCkFwb2xvZ2llcywgSSBkaWQgbWlzcyB0aGUgY29tbWVudCBhYm91dCB0
aGUgZG91YmxlIHNwYWNpbmcgYXJvdW5kIHRoZSBsYWJlbCBhbmQgdGhlIGxhYmVsIG5vdCBiZWlu
ZyBuZWNlc3NhcnkuIEkgd2lsbCBub3QgbWFrZSB0aGlzIG1pc3Rha2UgYWdhaW4uIEkgYmVjYW1l
IGZvY3VzZWQgYWJvdXQgdGhlIGNvbW1lbnQgb2YgbWFwcGluZyBhbiBlbnRpcmUgcmVnaXN0ZXIg
c3BhY2Ugd2hpY2ggaW5kaXJlY3RseSBsZWFkIG1lIG9uIHRvIHRoZSBwYXRoIHdoaWNoIEkgYW0g
bm93IGhhdmluZyB0aGUgZ3hwLXRpbWVyIGhhdmUgdGhlIGd4cC13ZHQgYXMgYSBjaGlsZC4gVG8g
YmUgc3BlY2lmaWMgdGhlIGZlZWRiYWNrIEkgd2FzIHNwZWFraW5nIG9mIGFib3ZlIHdhcyBhYm91
dCB0aGUgZ3hwLXRpbWVyIHdoaWNoIGlzIGhlcmU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC83MDRmZmE1Ni00YmFlLWZjMzMtZmRkZi0zZTNkZDhiZTBkYjlAbGluYXJvLm9yZy8gVGhhdCBp
cyB0aGUgY2hpbGRyZW4gbXVzdCBiZSBkZWZpbmVkIGZvciBhIHNpbXBsZS1tZmQgZGV2aWNlLiBI
ZW5jZSB0aGUgcGxhbiBJIGhhdmUgbm93IGlzIHRvIHJlbW92ZSB0aGUgaHBlLGd4cC13ZHQueWFt
bCBlbnRpcmVseSBhbmQgaW5jbHVkZSBpdCBpbiB0aGUgaHBlLGd4cC10aW1lci55YW1sLiBJIGFz
c3VtZSB0aGF0IGlzIHRoZSBjb3JyZWN0IHRoaW5nIHRvIGRvPw0KDQpUaGFuayB5b3UgZm9yIHlv
dXIgdGltZSBhbmQgZmVlZGJhY2ssDQoNCi1OaWNrDQo=
