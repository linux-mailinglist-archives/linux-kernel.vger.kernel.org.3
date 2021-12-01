Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF23464573
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbhLADd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:33:28 -0500
Received: from mail-eopbgr1300121.outbound.protection.outlook.com ([40.107.130.121]:48733
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245220AbhLADd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:33:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6oBVPmHj5yC/x4BeKZhWMzBjzIoUwT6BHuiJIE+4qWvrNHg3IbjhQnmb9t+T2ZI24J1ZK151Q4+Zb1PuM5Yu24B9Iy9Bv6XPFxUEaTzDEvtlM1inPvMQJ9hp4tHXqMuvc7wUrmWaWr6J/nlhsaIanu3QAjkeUbyUdv194O1IFK3ImGQ64WPqQKyx5oKvh+1UudZZa1YAUrO+lyO6zIHKkVY4Q4QH+Bkn2oL+7qDA36WihtQ0kaOV0wY9MHFXxB9wDizFeBqg/GLEbbFOHOsDRQbvLauPJXaNSaUo4Kp6gLCGd9785RbzEGpam9e0UnQVfSqlZ+8Ri+MLeBum4LLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhn2E5zgNPWe4iBn3QbiHL+sH7qU2oR6LAD0dCxSK0I=;
 b=U+zCo3kW2MGY8eF5ZiEgt9dkNrCiyCmyR3RgHElmjfhzKpNj2lpAXzUNVR+xhISfne7bWcXr5aFoo8adN+CwH/dUDPALXaYHpPuiKEdKRpLJWazeunC80wMKp0yiIEypMrVyil6mWwhS96yDfh30I36UIGIBK8HBsQNW0CxMxpFB93t/9Ry324DufjMomAcWAuMgamU0KKVp+K1Xst7OMscPVjnyZX7sDm+Fk7xsv6MAdwY8V4OlABb6F+Om7A1RvBrAVZr4ptRnLbNp3o83KwK47nkP4ch/5bFkPgyS2AN6cxveN/fhwdR6h9hoIHFNMhxPeSBnbWSAWidrjrFT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhn2E5zgNPWe4iBn3QbiHL+sH7qU2oR6LAD0dCxSK0I=;
 b=HxqemZoAuK2sAcn0bttcgvdXYMZmrvvb8UYtORV0UIfNBA4Q41L94K4S4Owrkfxl3c9XzbzNaF275XiICyvk/ZtnSG0IhD2U/3rmFs5T9O0chks0fflYL4Rdhr4hx5YGzG1J7rvFi+2eF+4VxTmJmBncHQTXTGgdyR2GDmkSVhsoWraWVSz6SFLE8MI6mXqICUbX0azVywfAUvMo42TL7eejmGr/8tnv15NjrZgWQJ48RAapQdx89hhKxaFihkCzmn5Gd+GILYk1ntBL1t9xF8QG+2ba1pGcE1fMZhImz/sgr8/7wGkH2cfdxwlTVXlamIj670+zIDKrKjmCDmoh5w==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2674.apcprd06.prod.outlook.com (2603:1096:203:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 03:30:01 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb%3]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 03:30:00 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHX5Ow7hsOaCLIIMEe2C8jlARJZF6wb1hKAgAGtoYA=
Date:   Wed, 1 Dec 2021 03:30:00 +0000
Message-ID: <CDB0374F-3835-4501-964E-DB771588114D@aspeedtech.com>
References: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
 <20211129064329.27006-3-billy_tsai@aspeedtech.com>
 <e28a5d5de9b940717e6444f019eab63ab1bb0b75.camel@pengutronix.de>
In-Reply-To: <e28a5d5de9b940717e6444f019eab63ab1bb0b75.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 716d7ee7-be5b-48a7-d1cc-08d9b47adb41
x-ms-traffictypediagnostic: HK0PR06MB2674:
x-microsoft-antispam-prvs: <HK0PR06MB2674FC1B7BFEB588050E3BFD8B689@HK0PR06MB2674.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GmQEam52uFzkH1XGT+4nBXj/cA51Bk7Kj0+F097da+V043y+KXVZDvzkyp3UBWVjKlD2SeHi83hQHx2V9wuV7G5SpYYCwI7FtDy9qEIjxYTBR9newuxgpumFGT/W5KpBzuDMYQ+yaW8WfkksB5al+ZzYCYp8JTKLbqP+zZ/mdBhVTnU1F/6oPK8Fomn0/C9qDqehkw4Ddrkkablp0el+LoVH76Y9LKKkwxU6asVBzOXcQ+Y84u6q8E5+WmxCDFRIbOiC1mMhqh5IwSS+wHg6Ppqhx9QBhUwSog5OC0pSq7Gopy3343Mu8K1og+OEWRCd0ByliE0Z4uekX7eJfdRXimCTODNgpN/IP0aOHvVIX/LhorzhHQkYHHN5SW2Dx9J1t5kjYuXLtrxTwxr1PQPK41USciYFS/6f/Lc+q0uNHjy6XJqA3mqLEzPwRoF16Ed19dhYtVzEepyxvVLVZoF3cby6Kxz26rTRQ3PW2Cd6PJSTh0w8sBHo++7NzJTj6Zp4peIPW3uRlMRMe2P8F/YNIUXevLsKRYeLKXBr+NCGdnkyS918EXUastJJlUDfuhc7d2AVfHsr9Ut9WkX5+Livmd+UA/P8mWMLv8KF90JGmi/qrTrPxmjz7dYGAGILLtIjPws4oz6k9mec7HVBhM8XMvi7TDdckhZ3IINdz3dwmh/C3hl8Z8qDdkSfL6G6RybPDYbh5fGiyrbm0UAsgi5VtrG3xax9qnCxFTxoqlMBEb6caL4agIKs0VjZ5Yhavdp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39850400004)(136003)(4326008)(36756003)(316002)(7416002)(66946007)(186003)(71200400001)(33656002)(107886003)(2616005)(8936002)(6512007)(38070700005)(110136005)(921005)(508600001)(6486002)(76116006)(86362001)(2906002)(83380400001)(6506007)(38100700002)(5660300002)(66446008)(66476007)(122000001)(8676002)(4001150100001)(53546011)(26005)(66556008)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enU5R2h2MkFiaGZ6T01sVmhYMFNHb2ZWT2RuZ3RIbnBCQjIwVHk5enJ4ZGNv?=
 =?utf-8?B?TkdZR1NLSWZBbXd1QWNnYWZZVkgyUlhtNWkwdnYvNzAvYzhRLzdwc3ZBVU9w?=
 =?utf-8?B?alhCN3J2YVZMck53UjdiUnBkMS9RSUtJMmk3S01rSEF1Q1FOVHBpWFphVEFp?=
 =?utf-8?B?elNDU1NkYkFab0c0amRROE14U3NoRThvNkg3UTQzZlBHQk5mMFJhNUZlaDFJ?=
 =?utf-8?B?VEp6TzdORlVCSWpDaTUrdnpDMFE4SDQ4UFV3Ymc0ckpib3RvbzVxNnpOS1lN?=
 =?utf-8?B?a0RwUlJ5SU0rUGliRTZFbVowVXFwUWZsTFplaGZPRFhJQ3FNRFFHNXcwNjV3?=
 =?utf-8?B?dlI0UHBic1lMdnEwYkpoZkE2bC8yZWZxUmlHb2I4RkFZbE1FYkRqc2RPeUly?=
 =?utf-8?B?b01QOXMwdWJUT052ejdQZjB2aUFUWFpBUGREVHFJOXQ4RnhUZ1ZkLzAvZ2Zq?=
 =?utf-8?B?dXpIUmE4L3BkbHhJSFlBQXljNHZXSDRHcUJuMm10NURTUkJzYXg3YkpjTjFK?=
 =?utf-8?B?blR4dW5LKzgzS2hrZ2FtZ1EvL3dYQzJyTU8vMUlmZTNNNlppak1ydWUwNkpG?=
 =?utf-8?B?cnAyQjFCVXhtRkJVdjJTM01GTnpLZmxZUEpiNHJHNC82UFc1dXhSb1BxS3JN?=
 =?utf-8?B?RFRzUUZzVmdUTFJtcWJNTDR0Z1JTcE54azlGTWs1L0VSS0xyb2RnWUt5SzZm?=
 =?utf-8?B?YzZBMEluTDQ4VHpkdldscFVpTU40eGlKYkg2T2RLNFQxRS8wL3E5bFQ5emdv?=
 =?utf-8?B?T2MyREdvdmRvdWVkTFVvb1A3b1hIMzQ0dGI1MXlXd1hYVFFYdVlPUFRvYXNp?=
 =?utf-8?B?S3RKNWxobU53S0lPZmRkS1VTWDVRQ1RScmJYMGlneWt1YmRhQ3l6WTc3RmVK?=
 =?utf-8?B?YjZFRzJkMmVNTkovYjZjQXU5eXN0K3kxV0J0Z3hZY1dUcEVueU9yOSt4M3VK?=
 =?utf-8?B?RHpZbEJUYmVOc1M1UFFLU1d2M0FEUUVkTk5QSUE5N0lUeGU0V0g4QzNqNjh0?=
 =?utf-8?B?eG5mQmhDeENOY2FRd2pZcFNDSmxkVkhocmlMYlR5VGhiY2JNQ3paTXorWFFB?=
 =?utf-8?B?NjBBU2s1MW4yMGNUMGFUeU9LeERrMDI0dmgyUjdYR3VPYVhnOEVsaXJWNmNH?=
 =?utf-8?B?UWVHcW1zM2RwK1lYckxIZWtQMWt5TmF5M0ZuK3lsYXc5eHhpUG1Gd01uQW15?=
 =?utf-8?B?TXorZ1dUaU9PN25SalM1U1Y4YXQxRFZsT1IxTUJUaXVFUUlRU29UV2Exdnpr?=
 =?utf-8?B?QVdkVlR4Zk54aFdVNkJEVkMyT2lJNFgzUmVlYmR4V0Q4aVRQTHdHRGdFS25K?=
 =?utf-8?B?T3BsK3NNUTBSdkZlTE9uQTUweVFZaTl6bHVUMDk0Zjg5Z2JXRVhMc3JmbVBs?=
 =?utf-8?B?WEw3NkduSC9NSWRJRzRNM3EzS05kdTdCc0l4cVhmdXUxZjZBK2d0YUFUU1BK?=
 =?utf-8?B?dUw5TWtLRHNPK0VOT2xwUUpPekU5MXlUbjdwS1dqdDZ2Z2RFeVRoYktqQjFh?=
 =?utf-8?B?L3N5QzJNVzJMei9aY0Vlay9yOWNXZEFJSUVUUkVCSGFmS1dGT24yZmMyRXZS?=
 =?utf-8?B?TDkwKzdsM21SNzZER1l5aHEwdlpHL3pWdXJoUXJwNm1GeXFIUktrSndwT3dV?=
 =?utf-8?B?QWVDU1huMnhqVjNwK0RZaldYcXJDRExHWlVUVitla1ZoQ2Yrd2NQck9GSDVX?=
 =?utf-8?B?Q0lBTG5lZS9IV1lkeTd1VmowSlBZZTFtWnhnY2gvM0NlV0FhMTVuRm5VeDE4?=
 =?utf-8?B?cWlKZzI5cU1qRlRHdlBvYXRYblpOWThIb1BpWXdZemwrOVZyTVJsYm84R2ht?=
 =?utf-8?B?eHpjdUhqakpCN2hET0NCbUNqS2pKbjkrTUtwUy9iVldXbUZpaW5rMGpDVkhr?=
 =?utf-8?B?UWw1NHFlZllaUU5DYnFVUjhsd2xOVWp1M2ZYZk8vQ0l5MHRvbUIvRnRCRXdl?=
 =?utf-8?B?NUJVMitCVVpGQmNQN1JkSW9TUldOeW8zRjkwZlRQeUxpUG5zREt2RWRCcERp?=
 =?utf-8?B?b2kvMzZMVW5KNXpHVUtKOUVCTTFmVGM0RWxZWHc1c0pzaEU4V2Qvem93RUNF?=
 =?utf-8?B?eEtzdWRJTkhsNEFqN29YZndpcVdIM0dGNjd4NWpXYVkxZXBvVURpWWZITVNr?=
 =?utf-8?B?b1hFb3F2VzdRNVMwZ3lrZndzVHl5RmlJWjdJTGFUSlEwMGhsSlZKYWwzUDZ1?=
 =?utf-8?B?NkFLT3ZwYUpGQTBKbTUremNEYU1ETkVUVzRPdTVvdDB2Z2xkV1ZsTVNISXZx?=
 =?utf-8?Q?apwWM7G7ETah81Vw8Xqbwy1E9UcB5fScq+2j9rJoxs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F9F6FCBB3AF334D9135C86EA5702445@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716d7ee7-be5b-48a7-d1cc-08d9b47adb41
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 03:30:00.5130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1ZjTOxBDsFrGpPmBYXziXEDb1/7tU8co1fD4SxfiZRFZrFnOsSmxeRie8fvP7zAkTrkSk9CZOG6jCrkSzZRy9b8KkVwsX57vW3iHeeQgIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2674
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcCwNCg0KT24gMjAyMS8xMS8zMCwgNTo1MiBQTSwgIlBoaWxpcHAgWmFiZWwiIDxw
LnphYmVsQHBlbmd1dHJvbml4LmRlPiB3cm90ZToNCg0KICAgIE9uIE1vbiwgMjAyMS0xMS0yOSBh
dCAxNDo0MyArMDgwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAgICBbLi4uXQ0KICAgID4gICA+ICsJ
cmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHByaXYtPmNsayk7DQogICAgPiAgID4gKwlpZiAocmV0
KQ0KICAgID4gICA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiQ291bGRuJ3Qg
ZW5hYmxlIGNsb2NrXG4iKTsNCiAgICA+ICAgPiArDQogICAgPiAgID4gKwlyZXQgPSByZXNldF9j
b250cm9sX2RlYXNzZXJ0KHByaXYtPnJlc2V0KTsNCiAgICA+ICAgPiArCWlmIChyZXQpIHsNCiAg
ICA+ICAgPiArCQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiQ291bGRuJ3QgZGVhc3NlcnQgcmVz
ZXQgY29udHJvbFxuIik7DQogICAgPiAgID4gKwkJZ290byBlcnJfZGlzYWJsZV9jbGs7DQogICAg
PiAgID4gKwl9DQoNCiAgICA+ICAgSXMgdGhlcmUgYW55IHJlYXNvbiB0byBrZWVwIHRoZSBjbG9j
a3MgcnVubmluZyBhbmQgdGhlIGNvbnRyb2xsZXIgb3V0IG9mDQogICAgPiAgIHJlc2V0IHdoaWxl
IHRoZSBQV00gb3V0cHV0cyBhcmUgZGlzYWJsZWQ/DQoNCkNhbiB5b3UgdGVsbCBtZSBhYm91dCB5
b3VyIGNvbmNlcm5zIHdpdGggdGhpcyBwcm9jZXNzPw0KSW4gbXkgb3BpbmlvbiwgdGhleSBhcmUg
dXNlZCB0byBwcm92aWRlIHRoZSBjbG9jayBhbmQgZGUtYXNzZXJ0IHRoZSByZXNldCBvZiB0aGUg
UFdNIGVuZ2luZS4gSWYgd2UgZGlkbid0IHJlbGVhc2UNCnRoZW0gaW4gcHJvYmUgc3RhZ2UgdGhl
IENQVSBjYW4ndCBhbmQgc2hvdWxkbid0IHJlYWQgdGhlIHJlZ2lzdGVyIG9mIHRoZSBQV00gZW5n
aW5lIHdoZW4gY2FsbCB0aGUgZ2V0X3N0YXRlLg0KQXNzdW1lIHRoYXQgd2Ugd2FudCB0byBhZGp1
c3QgdGhlbSBkeW5hbWljYWxseSwgdGhlIGRyaXZlciBuZWVkcyB0byBhZGQgbW9yZSBjb25kaXRp
b25zIHRvIGNoZWNrIGFuZCBrZWVwIHRoZSBzdGF0dXMNCm9mIGVhY2ggUFdNIGNoYW5uZWwsIHdo
aWNoIGlzIG5vdCBhIGdvb2QgZGVhbCBmb3IgdGhlIHNlcnZlciBwbGF0Zm9ybS4NCg0KVGhhbmtz
DQoNCkJlc3QgUmVnYXJkcywNCkJpbGx5IFRzYWkNCg0KDQo=
