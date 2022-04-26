Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4118650F931
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbiDZJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347852AbiDZJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:57:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F635259;
        Tue, 26 Apr 2022 02:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KayVaf0OWzstrPFkdZ965vTLPK/chwYQ110HCA1AEeFqmqRSEwTKLFQm1TS0u2j2IcHGNT/VtFKFJBtsNVDz7D9hD0ya6aSyGTyD3+tawmPxIz4iPiJTXYj8YRZ90J4tgLR2WFxRaCL6HOl4GyN8yo8/6b4vJSvpC9o37WKZJFuysqvFlQr6iWgxDB5DiuZcXLPYQMTftX67Uvh+BBhbSPriga6CPICteAycHID1Keq/NPya+47rTaMcpHgAUsHuI1LN8LPNQu9RGj2VIDFtgGw3rer3Ddea78kvi/5PF4wFV2k/S23Mah5HalVe/fVWnd79fp+cvjZfoE0le+IbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebdaI+3h3nCPjbUPlBBJ4vQF9kBs4WEaQGckvC+FhRQ=;
 b=JTF2JHwLZ54VprCJCfx2F8IHZLXNESVrqvTA2bRh6wEyDgBo8z6foVZsRUncDfjB/TD9+K7K/+bIuLdA205QIOHe1ZaNDtUrIqAcY8EZuJfLNfVVd1QZeGYBDzrgLGB8QIfcOFd2DeqJzpS+cgHBnyk3MC79v7GQC0bkmi8pcO8Z49k5LShTFe0NqgweeYuOBR7F8nCauCLAKV0QdsfWQKKCRYPh5iZnbLbl28jVeywY0fW8Pf9H9U3uBMseGqEu9PhXjKtYuRWqssKcDjRbGA1MPza8u0g6OhfRhqFilkWpgYs7v3qoGounCA1FMEd3pwBWJwp+tw6Jlo/ki2kibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebdaI+3h3nCPjbUPlBBJ4vQF9kBs4WEaQGckvC+FhRQ=;
 b=WD5DFgzJvcTE1TV/v3Ja62EEn5jTtBPjaDRhzBXNMVFMRhP0uvnLE3zraU0x+jVajs1JRr5RNXHaWvjwXBD1osDBsTikivaIPEftRtI13uhE82ONRfGQyqDhyVGlhoUzS0n5sYngnc+IoRMExAd+ImsQ5GbL5/qYqDxrzvwrxto=
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17)
 by TYAPR01MB3870.jpnprd01.prod.outlook.com (2603:1096:404:c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 09:15:33 +0000
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::15ba:6d34:ba18:2a8a]) by OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::15ba:6d34:ba18:2a8a%5]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 09:15:32 +0000
From:   DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dt-bindings: mfd: da9062 can be a system power
 controller
Thread-Topic: [PATCH v2 2/2] dt-bindings: mfd: da9062 can be a system power
 controller
Thread-Index: AQHYVhEn2yqQUT/nq0yvgRUz+PF4s60B7/rA
Date:   Tue, 26 Apr 2022 09:15:32 +0000
Message-ID: <OSAPR01MB5060554EDB7EBF7A3D48C38DB0FB9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
References: <ca76e2bb2f5d47ad189fa1a40bb6dd8a5dc225d2.1650606541.git.helmut.grohne@intenta.de>
 <3a0838f71653f57be9a866c96dda5921cb10a653.1650606541.git.helmut.grohne@intenta.de>
In-Reply-To: <3a0838f71653f57be9a866c96dda5921cb10a653.1650606541.git.helmut.grohne@intenta.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e2f14bc-f808-48b8-8177-08da276550f1
x-ms-traffictypediagnostic: TYAPR01MB3870:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3870FF0C03A5296B07C22554C1FB9@TYAPR01MB3870.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6UJL3pOlgDM7yPqzzynWlujcm6UcdN/Iv7/P2H09o2gU/Naf7trRSD5/93G4iFzaedOzGyuJ3f+JaAdPyp39cccThpHXx0P9OVzVT1b0c8QyPozUz/MAG1gJ7Gq6rDBSvTSI1oxFXxxXAWHOkaV+jl7pOYYZ1ztztGraDDpmQk0+2JjZ0cBkRmUcAEBDkSUtXjYWY9DrddT7IDd9dUhX6Gg6qSo2yXJSl3UeO9+1w4dsvph99MLHaqrYZMGuFsvfxiG4FiUxUJmFNyYXm+Zt87SeoDDPHzuMajCr86b9QjYuO2CJSg6ssJmJ5G7nAXYl6iGxLFjHVF0jndOetWLk7YcC8h3mC6wUo6bOC6I2memGsv5Q449X5T0jKV3PLflzQrTd9SyWs90JyDLZxUQxmTz9sFMigqvqZYbdZVcRRHxsC5TLtNyfE8Rsplk4nkJCNI4eI4QoQFC/HHIMTza1k+74GJKWCf/7U9SBq9IqEdbNb/sbfHDo1kXRMzRWaqZQJKvG5cTmPrja+XKj+6GZRWTjJJQi+hvAWhJPaovTfiOmzSKR8PwzkNZtBDcVHUzkuZgmHmd2Rc1CurzgSd8yhMw6qysouwJuXVFzKfuiS6v5jM3gh0XWtz1PqUPOSPjd9OvGhSuDj13Xr9GI7GjD6ku8yqWCqA1VF9L3gzcG/Or25C0Dh3q1SGmy1UNWuD2N9rjYSJhs0Kah7Zh+fuFoEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB5060.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(7696005)(71200400001)(4326008)(66476007)(110136005)(76116006)(2906002)(33656002)(558084003)(38100700002)(122000001)(55016003)(38070700005)(6506007)(86362001)(8676002)(316002)(66556008)(53546011)(64756008)(66946007)(186003)(26005)(508600001)(5660300002)(66446008)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME5HKzJDV0ZxTDU5SUoyQVBrYTdaYm14ZG9FWDllUWhLcUZCMkxLenpYZ2NE?=
 =?utf-8?B?TVUxSE5oNkZJVVlyTEJGaVR0aitXL3ovL0c5eHk3YU9MbVYvWlVaYjJ2NkVD?=
 =?utf-8?B?dTBxeVFlTHBkS2NjSnNJM1RDQ1RPcTZ1c1lJcWJZbkdhaXhiNTJ5Sngya0FN?=
 =?utf-8?B?eFBPbDN2bVpGblBmS0IxcTJwM3BkQXBBakVzL0hWNXNwMC91NG5NNWdRck41?=
 =?utf-8?B?Ti9xRzdaeGYxL2JlZDRWUFB2VnVTRVBIZTR1aUgvOFI1WHc5WDFabEJCMEo3?=
 =?utf-8?B?NlkyK05hZFdpdlB3MXVnLzI3RG5UV3g1SWliaElndDRKOExwdzh2YUVaRVVD?=
 =?utf-8?B?bzlCMGlyVE1FRk1QNTBmZklaTTVkaHRmd1VtRXZEVTg4WDVPd01zQ3pZanVl?=
 =?utf-8?B?c0laMFJHSzROVTYzWXlEQVBYMThPdFpuUytCeW96U0cwc0pJSW9ISVJBdFNC?=
 =?utf-8?B?bDZYckkweGFyb21WcStmQit0bmp4R0pPakZ0TkM1SHFrR1FaalFWRHZRMEF6?=
 =?utf-8?B?azdYaHk1dVk5NWlpWm9VeDI0eE0vcnc4THZxZUwzQktsZ2MzMkRienduU3Bz?=
 =?utf-8?B?RmFtVDM5ME81K2VRSDRXUy9nc3lQc2pLSTlZV1ZabW9NUGVRMHdPUVpNTU13?=
 =?utf-8?B?VnpKRjg3TC9HOG9LbEUzcnpNeXhBSVhIc0wyVy9YSmpITEZncEp1cFBSYUM4?=
 =?utf-8?B?dHBzS2czNHBrR0MrV2ZtcmE4MXhNT1c0ZEE3OHBMK2xRY25MUzhBZG5FOXph?=
 =?utf-8?B?SWtCVXhQZ1N0a0g5cnN1Z3ovREhpM2dzeDAybXZFR1RIWEtua0RSalc5clFk?=
 =?utf-8?B?Um5ESjQrcDRiWC9SNllhL2hseldXeU1sNW5yT0tuOStUR2kyTmVKV1Z2VjlF?=
 =?utf-8?B?cFg5WFd2U2VlNE9GVFdFQWNIYlkrT0NvTG1zOE5jbVJHdklUMUJDcGVFVnRG?=
 =?utf-8?B?V2dLYjM3SGpWWkxNem4wVkZBVTRRZGpGYmMwdEM1VHFXc0l5UXFUb1R1ZFI1?=
 =?utf-8?B?bGJkMHlYOW5sQnhSSGp3QThJbEpyTWNBczRDSlVzODFxQ05WWDJCSjM2MlA1?=
 =?utf-8?B?T2lKTjR0YVIxZzJ6SVBzYUh0R1VaS0dXVU1ocDVBMUFlMVIwYllZTVhKLzNM?=
 =?utf-8?B?Z0RpUHd4algzV2VSL205N2JNSGdIU2F5MEZ2cytwa21PTkhqSWdCeTh2ejc0?=
 =?utf-8?B?MVJDWU9YbmVhRzh1bFdYam1veCtxNTNTZ2k2ekxVM0RDajJvczBxYmMweitP?=
 =?utf-8?B?VXJKZHl6QTRheW9GTHJVNmJ0S3FveXl3NEhwd2RaRldoNzZQU3RKazg3SmFS?=
 =?utf-8?B?Yy85Ly9IUjhXekoySVlJdHZCQXE1Y2FTeVBwbmxpdWRmOHRFaGdlbVdJNVdW?=
 =?utf-8?B?dnR2V2Iwc3JnbFlhWFpsN1RzYi9weEJvRmVjQzl5SnlnY3d2Z1BwL1diejM3?=
 =?utf-8?B?Uk9iTjEyS1p6bGdOWUZ0OVhOT3owSlFZTDhsMmFkYWV2aWRIVGVQZHkzMnRW?=
 =?utf-8?B?ZDFYTTVEbmJmRVlwSXdPLzkrbGp4NWg3bHEyQkpnUHRnMkxjK2FHakt0R3R1?=
 =?utf-8?B?VmJiTnkzdmExM2RENUV0UFpSRDgzYjQxRzUzNHNxNjZUUC9ORDMrdVNnd1RW?=
 =?utf-8?B?NVZ3bmVmQmxwQU5qYks1d3Y3RTlpWncxNXIwdEtZL2ViNVppaS9mbStLU2Yy?=
 =?utf-8?B?V0RKenNoRkdpalVOcTNKcnE3V1NFblNUYW9Xa013RC9iM1ZzQno3VHdFMHd3?=
 =?utf-8?B?eTNDS1NHM095VWFwKzVYQ3pKRUhJYVU0K0loc0ljcWwzUTdCbk1tNEtiSFo5?=
 =?utf-8?B?Ui85dFNVVk9KcnRVcHdkOTlJR2FxUkhUeThGaVFWRlBhMlY4aFhlM3RkUEtC?=
 =?utf-8?B?ZnFXNEFJZ3VhRkhSU2ZBOFhvN2RPc0xFUDAzMGNqQmkwN0t4K1FRVXNQTXJD?=
 =?utf-8?B?R3FWNk9vYzVLNW1hN043VnB0UWpjOFZxY3kxVXY4VFpqWC9Ydk55NFFyeEFt?=
 =?utf-8?B?dmhLR2laVjZFeE1tS0J6NjJDRHgyZGUxRnFYeXI3K1FSL2haOTVKZkR4WlNG?=
 =?utf-8?B?Y3F2RnpvYWVkVzU0SVFiczArOTFkd0REM3haaTk0ckdLcmNRRjB5WWthY0ZH?=
 =?utf-8?B?blRSZ3pmV1pTa1JYWHptMGNlTS9wSUM4cVpveFBkU3RocnhNMFIxeE1xMHZ3?=
 =?utf-8?B?djZhV3FrSnplVkJreFpPcmswbFdKL0drbGozK2dTWXg5NERxYllNZVVqUFFN?=
 =?utf-8?B?OCtHaFZvVE5zOGVCQTJvSnRGSHY0UDdSSmFxVkxlVnJHbTRXSi95c1U4UDBY?=
 =?utf-8?B?SGRJVjZNRzhub0ZyMDUzano0a295Uk0yTXRQdVRVU1Jnb0JHVDZidEtEZEh6?=
 =?utf-8?Q?7tf96HkDqd3LcolQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB5060.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2f14bc-f808-48b8-8177-08da276550f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 09:15:32.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB4zPLAOomwvUfi3pDR7gX8ecGhTcAijk69LKIS9PZZXzGA/qm6zd0FkbG5qb9JpOTNeT4m7CWZSRhMlw7u3YjMNRMgZnO2w56KVqX9TJUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3870
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIgQXByaWwgMjAyMiAwNzoxNywgSGVsbXV0IEdyb2huZSB3cm90ZToNCg0KPiBUaGUgREE5
MDYyIGNhbiBiZSB1c2VkIHRvIHBvd2VyIG9mZiBhIHN5c3RlbSBpZiBpdCBpcyBhcHByb3ByaWF0
ZWx5DQo+IHdpcmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVsbXV0IEdyb2huZSA8aGVsbXV0
Lmdyb2huZUBpbnRlbnRhLmRlPg0KDQpSZXZpZXdlZC1ieTogQWRhbSBUaG9tc29uIDxETEctQWRh
bS5UaG9tc29uLk9wZW5zb3VyY2VAZG0ucmVuZXNhcy5jb20+DQo=
