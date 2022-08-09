Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19F758D242
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiHIDLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiHIDLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:11:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174915A39;
        Mon,  8 Aug 2022 20:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2CnGgj74AKDlCjgiAu6fJ69ILv+Ds0PmczPGKXF5wApeZCTzpUnODlymLzJPe/EfKNOxXj5RUDTYyPyDmwlFF9etTJBsYnecZAPX0vRkNU7cKdxgCMr4G6aXztrLQIm3Xuu1APYxYrC2JdSf20clfyuievvNZA8fmt2+hQguYdLEpWBAXpl3Dc5FT1ftS/tmVDG1ZPa5BAZZo/Rp8Sy3NG8bgT/w6qMtQNyJeP/b9QXWtc7l9uvTX0CRNhheNXRy/R89AUzUCih8oZmdPPUyLZYOvs8ZykBuFSxTD/9UgtXBeTDSbwuvUWNORwetqou1909gZOCrbL/arcRyySdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IId6ulxBKcuAevZ5U7QeeAD/rYRxPG15bbMhDm5A3Ng=;
 b=M68MvvW8MCSC2Q95kcP4TOJL7MvgXH3nbU0tuamPbG5fS+OpGX8Q4+EpW6GtzJYakKqVPxr3+l33NEreYJz4mlxyPPS3FQwT7GF4I4uC10ptEJbqyVEUqJX8FxixS5qyQX5lorBUxTDyPnBKqcU07A3EMMp1059xc/C5l2ALD5ChJ1GTKq4615cULr1GWl8+lynr7DCzg4DcwJKOdZTm2bnxz3MXkFf7j00jSm5g8kqxgL6nVL/y4xKw3O4jza55+dWVLKYKZ5ssDGVLQzAlUdVN0QuqUuGmWgjhI4CuATjgSY0GpTT4HgczXd4fEiSmSYmU0qrphV85Vn2hSlCpGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IId6ulxBKcuAevZ5U7QeeAD/rYRxPG15bbMhDm5A3Ng=;
 b=e6iPW1sLSlpmhCvUFgYSErP9EXo8rDJraYePOXnHIeA8jlkqT4Zicn45BzvrF/U5QKnsK+eWLFG9bCB10gndn4zJ0bmylrSuimNyL3vB7xm+Zc7A5EY/AaBG87TGWW+9E97l3A81O1T7AuLcoTjTPOPlfs7A+ZFEEqXzWSdQexI=
Received: from PH0PR03MB5848.namprd03.prod.outlook.com (2603:10b6:510:30::19)
 by SA1PR03MB6628.namprd03.prod.outlook.com (2603:10b6:806:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 03:11:32 +0000
Received: from PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca]) by PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 03:11:32 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC:     Derek Cheng <derek.cheng@tw.synaptics.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>
Subject: RE: [PATCH] HID: HID-rmi - ignore to rmi_hid_read_block after system
 resumes.
Thread-Topic: [PATCH] HID: HID-rmi - ignore to rmi_hid_read_block after system
 resumes.
Thread-Index: AQHYqwZUXeo8/uu+vUqrcpU3ezQMya2kuP4AgAABZ5CAAAW/gIABJL1Q
Date:   Tue, 9 Aug 2022 03:11:31 +0000
Message-ID: <PH0PR03MB58481BA39CBC1D1D4E0BB487A3629@PH0PR03MB5848.namprd03.prod.outlook.com>
References: <1659949639-3127-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <7507e07a-5094-f129-b75a-69cc32147543@redhat.com>
 <PH0PR03MB5848811A9EC856635CD1E519A3639@PH0PR03MB5848.namprd03.prod.outlook.com>
 <598d8186-b07e-5ece-210e-83689791b85a@redhat.com>
In-Reply-To: <598d8186-b07e-5ece-210e-83689791b85a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXlhbmdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mNTI4MGNkYi0xNzkwLTExZWQtODJkNS1mODU5NzE0OTljZGNcYW1lLXRlc3RcZjUyODBjZGQtMTc5MC0xMWVkLTgyZDUtZjg1OTcxNDk5Y2RjYm9keS50eHQiIHN6PSI0NTM5IiB0PSIxMzMwNDQ4ODI4ODQ1MTQ0ODYiIGg9Ijl4eDJsSVBhK3pqM0tGa2N6dU5uNFBSMWFEST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc47a6e7-8bc4-417e-9ed4-08da79b4dc14
x-ms-traffictypediagnostic: SA1PR03MB6628:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3YVzpk7NWSsB9oL17rSeFx3CmLvwfk+O/OCu6F1DFDL1HaFSUm5ncfmWip/5YMzOEGbUV9rVu7WqwTohSKbM8I4ZVuKyi3ICQMGXk88tcng86Yc3pARsh5geA9uNODyodi+HD6UEDUnNpruKO+/V2Tk+PupTOgRG54MhraDfenYYkr1VLupEooHisZKj5My+LxgZM/WAfdjI6bctF7KZhUBWQbyA5oc9xF83zgKKcoZwbi4X+UGGtA2EcB+GxZQTz7pZ6M7vn3KForwfuHHCQs1E0dqNabW/Sv5bKjuUBlj2urYz+rNecf3SWZM1f76T+WELdLgOyXbdditdJ7S3FMmxtTyHrAyuol+vlnMSsNAIuJSHBCdEwoNAlpYs1hwTplmrEonqrL8fvESdL9bwt/L3+wGVg2BY/rPoFlfFo/h95VNC1ofUyrSQAehCHyUrMlQYwbNj7Fb4JT+Hjt5QUqwGKyEREqbHVK4gY+Zq46Q/Yp3Y9wsjjOsG0hYyEHcZHy5CeIL8osEJS758xCYSWGwKw3WjdIMF4nWSXeqU6MJwIqO1YNCjJvTJBz3mO2p/JT90rY+Ycaj/g/zphDEYCj+53LAmDbnztKrrDqS700XILtuQ4FixaJevwLas+8D/+DCTMH6JVcrgeDWNYrGaht6sEs2FhcIzpwkpiToSa62diWFYoMnlxKDwBgvHd1H99TD2d4SmMJAY/fqfTA3lpwk25kpewQONLdznhxA9jed/bC1TrDHxeAQVJkGa2ep3PWLkTuU8qhBFjK3K55y2SsKUOOdy7Bmu3MfiCsuIz/ptZZH81okgXEfv4Y0M2/lc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5848.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(39850400004)(396003)(346002)(71200400001)(54906003)(316002)(76116006)(110136005)(66556008)(66946007)(64756008)(66476007)(4326008)(8676002)(66446008)(8936002)(478600001)(5660300002)(52536014)(83380400001)(86362001)(2906002)(33656002)(38100700002)(6506007)(41300700001)(38070700005)(53546011)(7696005)(122000001)(9686003)(107886003)(186003)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1NJYllNWXVQQXJjWTJKTjlDd3JNV1JpcWlFalFvN2xLTHVVcXJGTnkwUUpl?=
 =?utf-8?B?b2NMZ1pIbjE4THI1WkJYeUI2Rk0rQUhZbzRPWWFRZG55RlVkYi8xc09sWlJW?=
 =?utf-8?B?dmxLN2loa2pQeWRrUDJzQ0pXUTR0alNoZmcrU3lnbUczbSsxZGJpK0w5RE9F?=
 =?utf-8?B?NXNvY2xqeEhwOXpBUU1qMzBVYk55Wk51V05rNFY0MWZMajFuR0tvZDRtRjZl?=
 =?utf-8?B?amFQeDFCQ0ZiSWFaVmU2RFl4citCbGVndStPa1gwSm1RMC85SEtaaEErMGwy?=
 =?utf-8?B?cXJsNk5GYnhUeC9RWG16YWZ2UGFGM3N4ZzRVUDVLUEhrcDFVYWhqVVZSaUlq?=
 =?utf-8?B?RXZyOHJFekRyYzUrSlcrenB5bEd0VVlkOEdwOWxUQy9xZjVCTEtKRjdOZmJC?=
 =?utf-8?B?SktURXkrak9YYmtmTklhU0I4VVBUUkxZR2UrQlM1TWVxYXhaS0lrRGExdEV6?=
 =?utf-8?B?Z29KcEh3UU5ZdnlRNmdHZHY0UWx3RDhRN2Q0NHB3UXdhQ21GYmZHZnB3QUE2?=
 =?utf-8?B?UzM5VVVSdjlTcEYyUE5XMCs1V3JUZGhpRE1waSsvUXRyKy90eEMxVnRrRktZ?=
 =?utf-8?B?UnFZMHpFNU03QWFsMWFiT0pNNHBrZFJYZytsaFlvTXRYUmgxQ0hNaXhubDNJ?=
 =?utf-8?B?VC84MUlrTzFnVkJJalUyekpuUnVkSUZHckZGSUVjdlJYdWp0MWtPVno4OGY5?=
 =?utf-8?B?dkROdTZKcGFMdXRMUVFGSFZYRHlQeWdUZWdMclRJUm9jUzBRYmJqYnYydnJz?=
 =?utf-8?B?cDNxSkVXclMxcThGSWpURDc4SXF3RW1vZWZtQ3dXUkIzazRrRHJMdUw0M0JK?=
 =?utf-8?B?N1N6VGZyY0FqOS9pTTdhMGlwWTd2TjhFU2ppS3JIVm11T3NCd0gyY2MvUk1H?=
 =?utf-8?B?WlVYb0FsQnlOS0tDTXRTYmhZcTNrNlRVanUrNmxDNzQxY1VJU25uT2hnRjZJ?=
 =?utf-8?B?VndqWVdFN1lDcW1DcHQ3dWl5UTZjOHMyM2E5dXNjNS9YeTNWZDRUODJUSy94?=
 =?utf-8?B?Yzc4dlBySUliMW5vQTF6dVJ0N1NxbVRvTFVhWmhCVlE3Q0pGa2lLTmR2T01h?=
 =?utf-8?B?L1E4eTF2OVFWbkpLVjN1MWhCTk13ZGlVNDNLb3JNQkVvMVBqbDZ1eVBmbVV2?=
 =?utf-8?B?dSthMmo1RVV6NFFVU3U3SlFEVUxtamhLWHNjcU9vNVVoeHdLZXF4djlacGo1?=
 =?utf-8?B?NU5xaUdnS1cvLzR3UmFTY2pTRW14WEtCcTlNU1N4WUsyZjhRMVZ2eWRyNGl4?=
 =?utf-8?B?OHZEWjFIem1tdFFsb1lhMUwyRHZhZ3QxZXdnMnVrdTc1djNSN0JuQ1B4cWRX?=
 =?utf-8?B?Z2xBZFgyYmhHYksxY3V3Z0pxT3pudEt6RzFTd2E5a1dGbW5HQUhFd0FkRk84?=
 =?utf-8?B?YnAzRlcwcVNNNTY4aTdDd2NwVnlUd3krMG5XekhvZ29XZ3k2emFiU1ZxWkNY?=
 =?utf-8?B?Q2FnVExxRGNmVVdJVkNuYTlDOUIzYzlhS04yT01WRDd1a0h1aFozS25nd1Zx?=
 =?utf-8?B?c0VBa2U4WmhKM2t0ODZaQ1Vxbkd1S21SM1YzeEYxcjJ1ZEdXY1AwcTJFb2hh?=
 =?utf-8?B?b21HNEo4YTMvZ2JvZ3lpU3V1NkZQYXpFREpCblJ4ZWxaaG9oM29JUGYydnpj?=
 =?utf-8?B?VVpmOElISEJaUmVIWitrelVZazVTa1FWNHBOSEplVHpOdnpUVGJOSG56WWlw?=
 =?utf-8?B?cFIvRzVIZmdueEwyTWhWek9pbjdYblFUVmNCdzlEc2w0VmNoMXhHRjFodVRW?=
 =?utf-8?B?U213a3JkWDBaRGNmM1V0SmhnZWtIZmU5dmIvcmJsaktja3RMSmh4dUhFRmRW?=
 =?utf-8?B?VjNDK09PSW9JaUVvTE5vVmxJTzA3RE9RVmM5aEN0WCtYYW8xL1c3RjRQbWl4?=
 =?utf-8?B?WXo4MUZUNk1wMmpORWVLM1VoUFg5VUU4Zy9tQXErZUhyWkdxMEYycEx4SUVw?=
 =?utf-8?B?TnBQNzVEODZBVGQvNXBlekhBWWYvSnF3NWVEeUFLdnl4TElnWVhrL2hNZWZm?=
 =?utf-8?B?czJxaFlCTW9zQ0llL1JpbUhuYmdvc2ZnRS8zb29POW16UXpSTy92KzZDaUk0?=
 =?utf-8?B?L0NTVEJOY0orNEFWQzhmS3hnQXVIVllhYjJERXdCbWNJdWgxd2J3cU9VYXJt?=
 =?utf-8?Q?RKFNT0QPO5+H3t/tewP9PYinm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5848.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc47a6e7-8bc4-417e-9ed4-08da79b4dc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 03:11:31.9290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivnWx318q9YXJ3+W2AMIGykOaluzf6vIt2YMnHvGrSWoPpON+EupKdVq4/gNrMsT+ZhwFTl3BT5Y+h8YLa2dOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6628
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCglUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCkkgaGF2ZSB1c2VkIHRoZSBy
bWlfdHJhbnNwb3J0X2RldiBzdHJ1Y3QgIChpbnNpZGUgdGhlIHhwb3J0KSBpbnN0ZWFkIG9mIG1h
a2luZyBpdCBhIGdsb2JhbCB2YXJpYWJsZS4NCg0KVGhhbmtzDQpNYXJnZSBZYW5nDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRo
YXQuY29tPiANClNlbnQ6IE1vbmRheSwgQXVndXN0IDgsIDIwMjIgNTo0MiBQTQ0KVG86IE1hcmdl
IFlhbmcgPE1hcmdlLllhbmdAdHcuc3luYXB0aWNzLmNvbT47IG1hcmdleWFuZyA8bWFyZ2UueWFu
Z0BzeW5hcHRpY3MuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+OyBkbWl0cnkudG9yb2tob3ZAZ21h
aWwuY29tOyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGJlbmphbWluLnRpc3NvaXJlc0ByZWRoYXQuY29tDQpDYzogZGVyZWsuY2hlbmdA
dHcuc3luYXB0Y3MuY29tOyBWaW5jZW50IEh1YW5nIDxWaW5jZW50Lmh1YW5nQHR3LnN5bmFwdGlj
cy5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBISUQ6IEhJRC1ybWkgLSBpZ25vcmUgdG8gcm1p
X2hpZF9yZWFkX2Jsb2NrIGFmdGVyIHN5c3RlbSByZXN1bWVzLg0KDQpDQVVUSU9OOiBFbWFpbCBv
cmlnaW5hdGVkIGV4dGVybmFsbHksIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCg0KDQpIaSwNCg0KT24gOC84LzIyIDExOjM2LCBNYXJnZSBZYW5nIHdyb3RlOg0K
PiBIaSBIYW5zLA0KPiAgICAgICBGb3IgU3luYXB0aWNzIEZXIGRlc2lnbiwgdGhlIGludGVycnVw
dCBHUElPIHdpbGwgYmUgcHVsbGVkIGRvd24gYWZ0ZXIgUk1JIGRyaXZlciByZWFkcyB0aGlzIGNv
bW1hbmQoUmVwb3J0IElEOjB4MEEpLg0KPiAiRGFyayByZXN1bWUiIHRlc3QgY2FzZSBvbiBDaHJv
bWVib29rIGRldmljZSB3aWxsIGRldGVjdCBhbm90aGVyIGludGVycnVwdCAobm90IGZpbmdlciBk
YXRhKSBkdXJpbmcgdGhlIHByb2Nlc3Mgb2YgcmVzdW1lIGZ1bmN0aW9uLg0KPiAiRGFyayByZXN1
bWUiIHRlc3QgY2FzZSB3aWxsIGZhaWwuDQo+IEhlbmNlLCB0aGlzIGlzc3VlIHNob3VsZCBoYXBw
ZW4gb24gUk1JIG1vZGUgb2YgYWxsIFN5bmFwdGljcyBkZXZpY2VzDQoNCk9rIEkgc2VlLg0KDQpJ
biB0aGF0IGNhc2UgdGhpcyBjaGFuZ2UgaXMgb2ssIGJ1dCBwbGVhc2Ugc3RvcmUgdGhlIGlnbm9y
ZW9uY2UgZmxhZyBpbnNpZGUgdGhlIHJtaV90cmFuc3BvcnRfZGV2IHN0cnVjdCAgKGluc2lkZSB0
aGUgeHBvcnQpIGluc3RlYWQgb2YgbWFraW5nIGl0IGEgZ2xvYmFsIHZhcmlhYmxlLg0KDQpSZWdh
cmRzLA0KDQpIYW5zDQoNCg0KDQo+DQo+IFRoYW5rcw0KPiBNYXJnZSBZYW5nDQo+DQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDgsIDIwMjIgNToxNiBQTQ0KPiBUbzog
bWFyZ2V5YW5nIDxtYXJnZS55YW5nQHN5bmFwdGljcy5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT47
IA0KPiBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tOyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5v
cmc7IA0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBiZW5qYW1pbi50aXNzb2lyZXNA
cmVkaGF0LmNvbQ0KPiBDYzogTWFyZ2UgWWFuZyA8TWFyZ2UuWWFuZ0B0dy5zeW5hcHRpY3MuY29t
PjsgDQo+IGRlcmVrLmNoZW5nQHR3LnN5bmFwdGNzLmNvbTsgVmluY2VudCBIdWFuZyANCj4gPFZp
bmNlbnQuaHVhbmdAdHcuc3luYXB0aWNzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gSElE
OiBISUQtcm1pIC0gaWdub3JlIHRvIHJtaV9oaWRfcmVhZF9ibG9jayBhZnRlciBzeXN0ZW0gcmVz
dW1lcy4NCj4NCj4gQ0FVVElPTjogRW1haWwgb3JpZ2luYXRlZCBleHRlcm5hbGx5LCBkbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUg
c2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEhpLA0KPg0KPiBP
biA4LzgvMjIgMTE6MDcsIG1hcmdleWFuZyB3cm90ZToNCj4+IEZyb206IE1hcmdlIFlhbmcgPG1h
cmdlLnlhbmdAc3luYXB0aWNzLmNvcnAtcGFydG5lci5nb29nbGUuY29tPg0KPj4NCj4+IFRoZSBp
bnRlcnJ1cHQgR1BJTyB3aWxsIGJlIHB1bGxlZCBkb3duIG9uY2UgYWZ0ZXIgUk1JIGRyaXZlciBy
ZWFkcyANCj4+IHRoaXMgY29tbWFuZChSZXBvcnQgSUQ6MHgwQSkuDQo+PiBJdCB3aWxsIGNhdXNl
ICJEYXJrIHJlc3VtZSB0ZXN0IGZhaWwiIGZvciBjaHJvbWVib29rIGRldmljZS4NCj4+IEhlbmNl
LCBUUCBkcml2ZXIgd2lsbCBpZ25vcmUgcm1pX2hpZF9yZWFkX2Jsb2NrIGZ1bmN0aW9uIG9uY2Ug
YWZ0ZXIgDQo+PiBzeXN0ZW0gcmVzdW1lcy4NCj4NCj4gVGhpcyBzb3VuZHMgbGlrZSBpdCBpcyBh
biBpc3N1ZSBpbiBvbmUgc3BlY2lmaWMgdG91Y2hwYWQgbW9kZWwsIHlldCB5b3UgYXJlIGNoYW5n
aW5nIHRoZSBjb2RlIHRvIGlnbm9yZSB0aGUgZmlyc3QgcmVhZGJsb2NrIGNhbGwgb24gcmVzdW1l
IG9uICphbGwqIG1vZGVscyA/DQo+DQo+IFJlZ2FyZHMsDQo+DQo+IEhhbnMNCj4NCj4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBNYXJnZQ0KPj4gWWFuZzxtYXJnZS55YW5nQHN5bmFwdGljcy5jb3Jw
LXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvaGlkL2hpZC1ybWkuYyB8
IDE2ICsrKysrKysrKysrKystLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLXJt
aS5jIGIvZHJpdmVycy9oaWQvaGlkLXJtaS5jIGluZGV4IA0KPj4gMzExZWVlNTk5Y2U5Li4yMzZh
MzhiZmNmOWEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2hpZC9oaWQtcm1pLmMNCj4+ICsrKyBi
L2RyaXZlcnMvaGlkL2hpZC1ybWkuYw0KPj4gQEAgLTEwMSw3ICsxMDEsNyBAQCBzdHJ1Y3Qgcm1p
X2RhdGEgeyAgfTsNCj4+DQo+PiAgI2RlZmluZSBSTUlfUEFHRShhZGRyKSAoKChhZGRyKSA+PiA4
KSAmIDB4ZmYpDQo+PiAtDQo+PiAraW50IGlnbm9yZW9uY2U7DQo+PiAgc3RhdGljIGludCBybWlf
d3JpdGVfcmVwb3J0KHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2LCB1OCAqcmVwb3J0LCBpbnQgDQo+
PiBsZW4pOw0KPj4NCj4+ICAvKioNCj4+IEBAIC0yMDMsNyArMjAzLDEzIEBAIHN0YXRpYyBpbnQg
cm1pX2hpZF9yZWFkX2Jsb2NrKHN0cnVjdCBybWlfdHJhbnNwb3J0X2RldiAqeHBvcnQsIHUxNiBh
ZGRyLA0KPj4gICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICBnb3RvIGV4aXQ7DQo+PiAgICAgICB9DQo+PiAtDQo+PiArICAgICBpZiAoaWdub3Jlb25j
ZSA9PSAxKSB7DQo+PiArICAgICAgICAgICAgIGRldl9lcnIoJmhkZXYtPmRldiwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAiaWdub3Jlb25jZSAoJWQpXG4iLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgIGlnbm9yZW9uY2UpOw0KPj4gKyAgICAgICAgICAgICBpZ25vcmVvbmNlID0gMDsNCj4+
ICsgICAgICAgICAgICAgZ290byBleGl0Ow0KPj4gKyAgICAgfQ0KPj4gICAgICAgZm9yIChyZXRy
aWVzID0gNTsgcmV0cmllcyA+IDA7IHJldHJpZXMtLSkgew0KPj4gICAgICAgICAgICAgICBkYXRh
LT53cml0ZVJlcG9ydFswXSA9IFJNSV9SRUFEX0FERFJfUkVQT1JUX0lEOw0KPj4gICAgICAgICAg
ICAgICBkYXRhLT53cml0ZVJlcG9ydFsxXSA9IDA7IC8qIG9sZCAxIGJ5dGUgcmVhZCBjb3VudCAq
LyANCj4+IEBADQo+PiAtNDY4LDggKzQ3NCwxMiBAQCBzdGF0aWMgaW50IHJtaV9wb3N0X3Jlc3Vt
ZShzdHJ1Y3QgaGlkX2RldmljZSAqaGRldikNCj4+ICAgICAgIHJldCA9IGhpZF9od19vcGVuKGhk
ZXYpOw0KPj4gICAgICAgaWYgKHJldCkNCj4+ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+
IC0NCj4+ICsgICAgIC8vIEF2b2lkIHRvIHJlYWQgcm1pX2hpZF9yZWFkX2Jsb2NrIG9uY2UgYWZ0
ZXIgc3lzdGVtIHJlc3VtZXMuDQo+PiArICAgICAvLyBUaGUgaW50ZXJydXB0IHdpbGwgYmUgcHVs
bGVkIGRvd24NCj4+ICsgICAgIC8vIGFmdGVyIFJNSSBSZWFkIGNvbW1hbmQoUmVwb3J0IElEOjB4
MEEpLg0KPj4gKyAgICAgaWdub3Jlb25jZSA9IDE7DQo+PiAgICAgICByZXQgPSBybWlfcmVzZXRf
YXR0bl9tb2RlKGhkZXYpOw0KPj4gKyAgICAgaWdub3Jlb25jZSA9IDA7DQo+PiAgICAgICBpZiAo
cmV0KQ0KPj4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+DQo+DQoNCg==
