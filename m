Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A2356898F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiGFNcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiGFNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:32:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C524BCE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfzmLdp3PSzeeAikHwJevnLMxXU4YGy5N0wDPcGjlhsq2o1dz2PJdWTW88QafONAT0xJINsxwSHvY+SMT+rOcKFfUTdbZww4ose+FNjCILWOlV00VADDVIG3LtPqMjQUwRRsPffV6e2fGgW2lNX/hIU0zJvyIqOfA8JyBnu3oBKXzTfoYrmq8j+OOsi4F3qwiQbdhGZjfNDUMW6YrjZV8IuuZeTzygsusQTXALqPbDZLtV60N8aky/JWb4fFT0H+mCYnsujWRyHzxYYnR0XHVqs+/+wLuMrHpI3F6L2rdhARoQ7L4rTKiNuPEy50kOH4tgKXwpO6UmW3wKF+PauR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtjyJNQ4j7KZk/BHVvcQjS973HokW5tqwL4e6KuyCb8=;
 b=Ysx4Us75MHcgAQspSzcdoBbJGgXv44twDnBykgNzyO2Wn8qqZEm2tC/q+poNDxOUXZmO/7tQqjR68s4oUHYYIvll1aota7dfCq/PZSFY/JVwlsR96FhkKpyG5ofbkviTzcS3QAzw+jgaktMJWp7Ti5gNHu9akplTmczAH5XjRvfuEyW4V6i8q7UOoKXn4NNwPo01/sjvZZNIWtMEF39YPORJzCrpSR79E253LHqxnUqmSPm1q/5bXte5MMXHEpmBQPyCeVU9gInfxd8KPKuNDMw8jaJxuMfUgbiV+wItjWqzJ+j25c+V55QBqyDJuoIjmWBmW+ljJiChzlaB5JvdVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtjyJNQ4j7KZk/BHVvcQjS973HokW5tqwL4e6KuyCb8=;
 b=fAmWeapwU3gLgQsFzljbOC142tMOIzYF4WiZznvsmeNVnaQ6aDhGqgA7ha61xMikgtHKqMf5XcfbirH5ZH+AImk1SoeVy7tLSWYiK5wQq5bXCXIUrW2b0gHa7zNrJI/+Rsrz1wftfCfCd4d80NSPucoeGoyI7ZDvwsxKeOjey0Q=
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17)
 by TY2PR01MB3625.jpnprd01.prod.outlook.com (2603:1096:404:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 13:32:17 +0000
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05]) by OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05%7]) with mapi id 15.20.5417.015; Wed, 6 Jul 2022
 13:32:17 +0000
From:   DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: RE: [PATCH v4 2/2] dt-bindings: mfd: da9062 can be a system power
 controller
Thread-Topic: [PATCH v4 2/2] dt-bindings: mfd: da9062 can be a system power
 controller
Thread-Index: AQHYkTRe2fb3gj/OdE2gjGCdZBj6BK1xVy0w
Date:   Wed, 6 Jul 2022 13:32:17 +0000
Message-ID: <OSAPR01MB5060170CA142D55EB575952CB0809@OSAPR01MB5060.jpnprd01.prod.outlook.com>
References: <c6e19670802355222a228061f37aadace2764933.1657104160.git.helmut.grohne@intenta.de>
 <fde0a8136c773a11def5127d4acad627ec5a9b27.1657104160.git.helmut.grohne@intenta.de>
In-Reply-To: <fde0a8136c773a11def5127d4acad627ec5a9b27.1657104160.git.helmut.grohne@intenta.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 437be95a-1c23-41bb-f253-08da5f53f1f1
x-ms-traffictypediagnostic: TY2PR01MB3625:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5yhNTnKrXftTNjpoydmSssFCPueNwnb1V8vRolDSrGeXE9ZXEo9lVlRgYopzwe9PwK8NIrt0Ka+CQuZ+7tpQYYxpLtPNIl1k+haiPMrjs69cN/QcEUjqBG+MymzSTwJRkx7rGt5PZJq6Mf4WKME+h76dUqvmvfKfKbdfuuHnBWVNGPb6zE1R+n+JbbuUuSnz68PmK+qDqzBqyF7zHmQtfGRt4vjNJX4JblJDHTNGgZXXp6ouvnw2lGyfuM5F7zniDbiKE62/sDn3+RSKQH4++DIskL2l5+ohmgBI36qc1OZdmkcB6DWRtL6bWUV390t5qc8QAUJGhrNkLh+FQQOJhQhKO0hEqEbUo4YcgETRrQ7qNGI4bSwQpa+fGErx4rfoT8BlKxHKzwpAhwjaM53iucHKm5hdLcXSy7f6BLnK/LN6k25yAKK5Ks/5jgrqfIVnZeyprGy1MTqMDEvgdSnDkMk0Em3vQ2f/IC0VOlNK0Imea8d19JPNwoIvu1SWSWsQqwPG2fQd8EWWkO7ElqzP1B4yof4k+h9W4ZZ2/2PhMufIanekcaYN5Y4QJ6bYRkgqtOanx6eZvSATAdJ+g8xDQTt1DKTXVc9nEu5CUOtZPeeZSa0J1G8lAwMQVQXuiXtCOnS6n+LItPwJJtGQPSv1Qd3rV0Y9w01wVB+zcSZebANlcdl31say66ni5zoJOO7pMuczAVPMQ4dbHMVCHqg4VUe4VRYSh2dBvLoR/HrbY4fJnQaH4vz0624i5tXh/gk+Td5qW/QuMX8zuw5Os7xmIoTfF+ZLnlWz19k4yS/xslAFn7d63H6uLpg5ZuxsmO07
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB5060.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(2906002)(478600001)(26005)(9686003)(38100700002)(33656002)(186003)(122000001)(66556008)(558084003)(8936002)(54906003)(8676002)(5660300002)(110136005)(71200400001)(86362001)(316002)(55016003)(53546011)(7696005)(6506007)(41300700001)(38070700005)(52536014)(66446008)(66476007)(64756008)(66946007)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2o5cUgvUVZJd01zKy9LTjAwRXN4b3l4VjJHamsxWkdkbGh4bm4xTFRzaGRu?=
 =?utf-8?B?UEZDWW1IMlNDTHN4MXR3L1ZmWjRnTXZpU1kwNkRhYkdLajNjaW5GeUYwelkw?=
 =?utf-8?B?WExtRjNEbWdRNERrZ3pnNUl3VWE0T0N0RGVMT2J2dndrWWs2Um96MzNkbFFq?=
 =?utf-8?B?anBVY211aUVGUkRYL1h2Uzd5R0RIdmpjYlJ1T21NNVFNd1JOTkh1QW42N1Z3?=
 =?utf-8?B?WW5TM1EwVGY3a016Z280QzFLckhxMlF1c25rZGpsVkFXM1RCeDQxQ0Rla01T?=
 =?utf-8?B?cThLNlY0aTBRT3Ftdy9SbFRSVDFUYUJ3SjZXU2tja0RBQlVtczhrQ0FaOGtq?=
 =?utf-8?B?RUoycWJJbituS1pYMGJBZktDS2RGeTh6LzhldDFmS1FCRUNlWDNsVms0b3d3?=
 =?utf-8?B?SHM5anE5YnRYalBJYjdMQm9VZnVhbXN3bFZkSFl4Z0JRRUpocld3Wnplcmo1?=
 =?utf-8?B?NVhpNUxjK2NSell3WlBsU2RvSFhTT1g1VmczZjB1TlAybFlGVUdZMUZ0VDl2?=
 =?utf-8?B?Uk81NWxiRWhRY0oyYU1mcGNObjMwLzZLb2o3RGhlWUtLeXAwMWpIOHB6N1VN?=
 =?utf-8?B?SEZPUlMydmZRNlpjTUJSUThIeGtvaUd6VVZUV3JFYTNOUEcyZDBST0tFTzVq?=
 =?utf-8?B?WlNYTFZhUFd1Q25VTElRdUFtOUozeWI4ZWNkZGhKN2sxeDF6cWVFaTdJNlFy?=
 =?utf-8?B?OXp6MTQ4ejVIblhhTUFORXY2NHFLbENycHdCZXhaT095QlI5MEZFOXN4NmRZ?=
 =?utf-8?B?TWs2cVQ0K1pVR0dLZnNkZkp4ekIrNC80Nk9yQklJamJjaDUyc3pCdjdkTFVW?=
 =?utf-8?B?VWd5b0NaVTVSL2dUYklwK3l6L2FFMm9vTjI5bzlOb0pLNWQ5Q1ZwNFVlbDhD?=
 =?utf-8?B?K1JKT3NoaHE0bUxWQmRtdHhNdWpVWVlBVDl1eWoyRitqV2xpaTQxbUdST2pF?=
 =?utf-8?B?VlV1Rm5qaFdxdjc2aG8wbVEyczc0dGN3S0liMGp3MTNRcHNRd2preFJsbHk2?=
 =?utf-8?B?Q1hrQ21GSWdOZ3FWWFkxYkdKdy96QS96T09Wb2pMdytYZS84ZzVIVEt6cEJo?=
 =?utf-8?B?U1FhWHFWc1lRYXFUdXkxRHJnclZiSjRPOXlNUkhnZVphbFZCTjlqNmI3c0c0?=
 =?utf-8?B?eU9lS3BneUtKTHdTZnBybTRqbDdYR0ZCYUNJOHg5eXg5N21nWDZiYXhjMm1T?=
 =?utf-8?B?YzZrenp4bTVmcUlJSTdjUHB0dU1Ua252M21HaWtRdFhtU09OL0kwcUFkZ3Rx?=
 =?utf-8?B?TXlyRDNpNDBZaXA0bTZQZHkvN0NUcVZRMldUUlV2OGlKME11KzYzNWpMRTVN?=
 =?utf-8?B?L2srTUNxMUJNWFd5cFBaMWg3anJLTi9JYU5jMEZNZ3JpR0RJWmo3Y2wzRUw0?=
 =?utf-8?B?WFN3alZMeWRRSWlKYnFicWFiTDhqZkxzdFk5eURUTXFpWnVNZmRMRmE4UTVY?=
 =?utf-8?B?SGFvRVJYUExTMWM5eWEwUENvSHhQcFdJSjYvRWRlZEhCajNWUlgxd3ZyZFRN?=
 =?utf-8?B?ZjlaOWJFU2R6ZC81VGJSdFFEeDNGMWdpVVU2MWQ1M05nUjFnbEUzNGlycWxj?=
 =?utf-8?B?SUtPd2hKVFFUbXdqNnM3Q0Znam50MUY0NjNkTTB4QjJrbmpUa09qS1U2dXpB?=
 =?utf-8?B?UmtZemxsV3B4NnpNOTA5RDhOOStzL01uRzY3bkpGVGlKbm14RnpsZ1hNSHMv?=
 =?utf-8?B?eWk5QXhhTEViaUFIRDBhYjQyUDhVbThmcnJhbnEyN3hCYXBJZnZmc0VqMitD?=
 =?utf-8?B?Mk0ranI4akRlMWlMRkJBT1IxNXc5MjQyK1JGQ0JvM0tDbGgwOEplYkRmSThl?=
 =?utf-8?B?enQ1RnJwQm5haElGSHJoajRuejRSeEdXV0ZyR1FZZ05oaTV1aGJYOWIwaVow?=
 =?utf-8?B?UUVsQ3grSWpZbjcveU4rR29zcEpFTHZueWJEcWk2bkJnZXNFY0R0QW5seGJ5?=
 =?utf-8?B?em9xT3EwOVA2aGRhMXFGQW1rSHJ6ekMrL0dSWWtHNlB1RzYrREFDMm5wcUVn?=
 =?utf-8?B?c0YzYkNkYnlHWVlLY3UxV3FRQ0JZaFBpam02Zzd5UnExOG1BNGFqNEpueXN3?=
 =?utf-8?B?ZlBBZGVBUXYydkt2QVNkSkhYaVlON0tkRlBVK0RDRmRLN0dJOXcwRWJGM0Zr?=
 =?utf-8?B?NVRTeWc2RUpxbXB1ek43QXNlL3ovTklBOVBKZ2l4aS9JR0ZCdFJPZUZwZVI1?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB5060.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437be95a-1c23-41bb-f253-08da5f53f1f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 13:32:17.2123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OWt+Xej8UeNWwrHTmlpaEx/CYk3WyAXEOaPlzIqvji1JqdGi61R3sTrh7/3LYTnx0awphY7b2Fyn99vY14/EFhCJOLQc2Wqk7gndJNTxOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3625
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYgSnVseSAyMDIyIDEzOjMwLCBIZWxtdXQgR3JvaG5lIHdyb3RlOg0KDQo+IFRoZSBEQTkw
NjIgY2FuIGJlIHVzZWQgdG8gcG93ZXIgb2ZmIGEgc3lzdGVtIGlmIGl0IGlzIGFwcHJvcHJpYXRl
bHkNCj4gd2lyZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIZWxtdXQgR3JvaG5lIDxoZWxtdXQu
Z3JvaG5lQGludGVudGEuZGU+DQo+IEFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPg0KDQpSZXZpZXdlZC1ieTogQWRhbSBUaG9tc29uIDxETEctQWRhbS5UaG9tc29uLk9wZW5z
b3VyY2VAZG0ucmVuZXNhcy5jb20+DQo=
