Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6D4D3AC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiCIUEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiCIUEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:04:36 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF9219E;
        Wed,  9 Mar 2022 12:03:32 -0800 (PST)
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9E82740134;
        Wed,  9 Mar 2022 20:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646856212; bh=qJ12JAvqnuUDUO3M+vgevsA9NBz3rKpErpDBrcCNab8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TfKfRnfkHJ16fswZ7M6uEDkZEFbhuLdcYjZxECyAZKDYPMbVIF7durJ+//KY5QO40
         n+djq9hCoCctrRfMV6PQ+qxwznK5L33372CuQp2A6tKEvUJm2Jf3xkrj7d0vJsL1dq
         Y7k06FNRcYAs0OZrFtkug4WnSd4K64hTxFkVD7vXDCrdERgN5F63pC+TXcFblVcy/S
         jT2HDgL0YSMDrWxxCmoqJOTaj3/2T7zSyyIDe/+pKTOHm/Iis4XDH7QqxuWo0rCRlt
         YKyUBb9RqsIKfnRGwKCVyt/MyH1t/KdlCqvIf2WX+NoIgYyyG7+h5j3bP8W3SZ4S6Z
         dtgQLiXaUPbiQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BEB96A0071;
        Wed,  9 Mar 2022 20:03:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 579E94005A;
        Wed,  9 Mar 2022 20:03:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="VI7hB8Pm";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOX/pr0GSTAkjdfk9/1Ykf2aor/QtCUtOibl+0tfhCmI8oy0pUY6Qht67MUf3GFQMKveL1gz96fd+sQF6jRTvwOhmg19/ylV4HqHizv+W78k4u6fWv0COJskrlkgR2X8PSmlS58Yp2aCyPNlRKl7ez/rZjaqIqk/BphQNk3ETt60grm8ha57Pxh+g6lEc6EiAc2Vzbip3Ly4cITwV+3wPhmUiInEDZJUQHMilg4M7SvO7BLc/LW5Prst2EzA4jkV546K+4weGRfeKnJxrT9EaZw820ldTerEg68uBM4PW7Af7SOrNbp65qxdVmhsWjLOd7ByTfImLF9eZZqw2vevwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ12JAvqnuUDUO3M+vgevsA9NBz3rKpErpDBrcCNab8=;
 b=MNUwFct6JtA7kibQVwuAnF/DLGiKgKDL5aUBWNe4+woaF8i7bAffDVJtTsTVWij3rhOzL0h6i73q6AraVs0EKz8mq7eJcl1MG7zlIGNd3beyWgqOm4jKmXVj2frrKsV26KOnSJUBNgxfsSKc/DqMG/oqwqmYrxlnZIrA309tQ7sEHE73+iPUTUb4wucqeNPn81/crgew9MuNU/Ki4S+nlupCCXLnxTw7MAWiDWKMLVoh453B7OAptTc6QpLTVNSZD0KQrwveDgG9n/s9Mugzp1HvIA7xgYNWPp3Oz5DuL20zS83TLo40JCI7oa12EA9h+32YXZvYC37lzmt+mKbyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJ12JAvqnuUDUO3M+vgevsA9NBz3rKpErpDBrcCNab8=;
 b=VI7hB8Pm8jn8pUfJ2MZ8AhsiYKb5D1KVydiFw7UUZGKFrnemYW1wHJ4o/kBbY1FTO8yUEZHE6w5ZxUZlxNZNhvp59qvmBGe4R+VT5z9NevDoWFuK0RYQN2Xb8MIpDf0F0JVe95nfZEfW0la3gvW6AScx0MQMekdbHbHF3FFZgfU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 20:03:26 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 20:03:25 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Wait for ep0 xfers to complete during
 dequeue
Thread-Topic: [PATCH] usb: dwc3: gadget: Wait for ep0 xfers to complete during
 dequeue
Thread-Index: AQHYM06Le2pevUk3FkG15YdkVpv3+ay3etoA
Date:   Wed, 9 Mar 2022 20:03:24 +0000
Message-ID: <319353ca-fe5d-81c8-029b-c4eebbee1959@synopsys.com>
References: <20220309004148.12061-1-quic_wcheng@quicinc.com>
In-Reply-To: <20220309004148.12061-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26a51269-c262-4321-841f-08da0207df21
x-ms-traffictypediagnostic: DM5PR12MB2359:EE_
x-microsoft-antispam-prvs: <DM5PR12MB235928E787E39124DACD5AE1AA0A9@DM5PR12MB2359.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NY1B8rzxL9o189MDFarbQOdB3ka9WzA18grJ3rbotb8KcHbkL+Uxs4VjV01CVKymVWd1H7FWuWwd0Pd/22wSbYlwXlIOo7MCPcJyndPwKTZ8gbrCh/btESlT6S3kARUIZjykdte3SzMxa4bamMdee2KcvkBnclCcH9iWJaLFMQ7JFq4FO8YBgeebZP8BHkE6l1YDJy0a2XuAF635D78b0yw46iwd3ZtCoCe7NPrBlExEZQ3th77F8p4NEC6bgNkDweOAZ0pYhh+igUk2VtLf2PFFCUZiAoXllRPR9nT4oCG8Fqfn/qMfrO4wqenalzAzyl6qNqaR7miiHrmBlcFDB5G8WNjgPsJ8E63aqrhdIuMdAMHn2dpPcZQsryfkvkAN/2epv6AKcG4rX8G12md2mSokJ6SOUD+leSYNTTy43UyMASN4CCzYr9bFWmzFM7OC0LpFjx8Q8z8Esvza7kVchZGEPh8dsStnv3zTZD4kodNI4qvj5fRXiiji8LxrkwblTiJJkE6r8+Z1HfAx6vJEYbrj/HiTs9vWZJFE4FTO+4w0deZF+jybOHE4QZUgpAxgZXQc9PY1lYUBPS/zWaDqxSm4utJdAVEQhVnEFjqXaoo5npinb/rY77n9KxAGYA9dpR5k3lT37/cmVlmwwhHt7x+KxRzLghsfeS2nzz38DxaWEBWj4krBinrLOhodJjhooSGxqrw2m8MT5B6RlzOm6lOCOx6mlTEFq0i0MfmZ5+1AuskB7pq2vhBEHF+trpuMCIZK7I4G7d1TTAzkhad3QjBMTwrEnzPApWKAFJUfTgxxocLp72EurMOIOHDKBhZq5rZ8zvKuYBzPWFY2pX0l44Py3R3MC4gXCIQQfrMtUL0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66946007)(4326008)(2906002)(66556008)(107886003)(66476007)(66446008)(76116006)(38100700002)(186003)(26005)(2616005)(71200400001)(31686004)(6506007)(508600001)(6512007)(36756003)(316002)(8676002)(31696002)(83380400001)(966005)(6486002)(110136005)(54906003)(5660300002)(122000001)(38070700005)(8936002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFZYanczMnVZdm1jQlNiT1F4d3V3cGZZL2NLczJHSityN0xxSXVPSzNjZUp5?=
 =?utf-8?B?UzFKOUVHbm9CL3JEMlpMR0xka2dtbE5wdlF5RzliZW9yU1Q4ZjdYTFJrVEtP?=
 =?utf-8?B?TmVOcHBDTUFXNG83ei9rYU1YRUtpanpDWkRsSGhXVktBSzIwK1dFbUJTQmdt?=
 =?utf-8?B?bnVlTnorT3JVUDlQWFFBRlNmbVFZV1FTUG1iNmxQRUZvTWhvU1lKL0lLYkpC?=
 =?utf-8?B?d0lNYlBNN3p0NXBQRkltbDAwekh5K1ljVVZIc25pZnhQdUtRZktscHQ1YURX?=
 =?utf-8?B?RWZadnQ1VjR3b3dCbTNjemM1UGIrVEJ0OU96djFRcjJrd2hBcVgrNC8vMzlP?=
 =?utf-8?B?SXl1QVUwNitPZjVITG42a29TU0IyUVBER2V3Y2gxYlMxMW9jek53eUNCTGY5?=
 =?utf-8?B?OGRrNmxNZTQyWnZFWVlWcGR2WTNBdUxhVE9PcHd2Ym1qM1pQWFNDeFMwd1Bq?=
 =?utf-8?B?V1lDYmsyZUZjSVRBL2dlQzZxcng0L2VFTk80ZWp5VFRZN25ldy96TXNDVHJ4?=
 =?utf-8?B?ZWx0dnoxVEp5VzdOTDdnakRoQk1QYVhZd3VmQW8yakZlS0dMaFNNVHFGKzJI?=
 =?utf-8?B?eW45d1I2MGZiWW04citXTWpHbWpNL2g2eE5SOHFNNXEzL1Q1WSswaVhpSWN6?=
 =?utf-8?B?Z3JmempFb3hWVTZwR01EUDd0NFRseW8yS1poc0hYNWdQMElCKzFWSGEvZ0Js?=
 =?utf-8?B?VG51MSt4OWpYTWVwenpVZkkvQkZnakwzYWpQTExEUTZnQ0hDVXVtUS9NbVl3?=
 =?utf-8?B?ZDRGVyt1RWVtQ3FPT0hRYm50cGhReGFlSzlhK3J5N0RxMmxJMFgxYTI4TTd6?=
 =?utf-8?B?a2pKU0RZdUNKa1Y1RzNCU2J5ZXl2QktaVC9ZWUplWFZ3NjRzK29pbVI3cUJS?=
 =?utf-8?B?L3hWYmZLUzVyZUduQXh0dG1iKytwLzR4WjY1UTFJa2x5NUlUSGIycUJmRWRL?=
 =?utf-8?B?UURjM3pMYzNLSG5MRFBmMVRFYVJkc2ZFYnFMd1M5U3BzM0wxYUhoWGYrSHBM?=
 =?utf-8?B?Q00yeUFlUWZDYlZZelprOWJrWFB2SldFc2RqUmRTYWwrN1lacURWSkNZL0hj?=
 =?utf-8?B?aDY4OWhsYWRyNS9pYmJjUW81TTkreno1K3BzRXY1bmpiRk5mOWhDbkxWbXcr?=
 =?utf-8?B?MlNaaUNsenNBR29tQW1BMDdybVZDZmZDSjBBejVKQUZ6N2N4VGp5ZlZxUU5s?=
 =?utf-8?B?bkZib1htb3BHWFFNTGRUS2ZGTFFBd3FaVmxNNmhocXFpTXliU2F5K2FvVEM2?=
 =?utf-8?B?dUJ5TEpxTjM1Z2pmSFEvMHBmekNvajV2aWlKS0JpcG9GaWxIVXVmc3RqVTlh?=
 =?utf-8?B?UCtoSm50WmhPMFN1dDY0MGl3QjFhc1VIdDBLeGhQdGM0djBpenJSbFEwUW8y?=
 =?utf-8?B?UkxTdmkvSVdZTnU3UzhjR240d3ViZ3dOSEhwa3FTSGlyVFBObHVoaXpJQ1Yw?=
 =?utf-8?B?OG1PaDkrb0RIMEFVcmliVmVwVkl2Ly9NeDluek4rcWJCOW43WkJGYXMyWWFt?=
 =?utf-8?B?TFRRbmZpUTNDZnA1SnNUQVBrNDFXVlYwMXlHY0dMNTZsRHYxNCtucFM5bFpw?=
 =?utf-8?B?eW05SSthTWNobXZxd2txTC9uaUl0RGhWSk91Q2YzS0hmMTgydGlXTFNXS2du?=
 =?utf-8?B?OGM3bW1pM1NWYkRaYXRFZDdGQTNzSjB0WmkrNENQdlFHKzlJNmI2NlJaT09k?=
 =?utf-8?B?S1pESVoveFIvMklwWld4cVhxaCtXS3Y0TmZxOXFPdndEOVRyc2d2WmJhWkRD?=
 =?utf-8?B?dFBUOGs5dVdKWHhRaFpQMWNhdG9xeUdqSGFMajN6QnV0R1dwYjFoZU1CVjcy?=
 =?utf-8?B?YlU1S1MxdmRMeGw0S21jUFptUXk2d2o0ZGFmL2o3YWdGaE5BY2p4NVUxL2Q5?=
 =?utf-8?B?b3hWbnR6d2phUFU1UldKNkV0UG1XczNCOXBFb1lKeG9SeXZ0YlB6ZUJLSUtj?=
 =?utf-8?B?SGcwOCt1RXV1Z2lIaktBTldiMjM1T0tBMXYvSVVHdzFGUGE5a3VNSE52NXhN?=
 =?utf-8?B?bllsdEhmd2wyaGNPREhXWkJ4TnRZZTZYNWRkekZLQXRIVHlHakowc2k4SVN0?=
 =?utf-8?B?L3FiZkF6UCtlS2N4YWM2aXVISXZUVmpCNk1mdk9ic0hyZElkZHBxdFpmQWxK?=
 =?utf-8?B?OEgzRVNUREgweXdIMjBSL0dEY1Era1FONWNyMTRhbnRQMm5BT0JRVjNVZjNi?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B81AFCA0AC72A64DB4C396607A285908@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a51269-c262-4321-841f-08da0207df21
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 20:03:24.7733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdiLyHB1g8R+i6jANL3+9BWLd/kSHGIKD5dNcnUZnWtYkchJGYFOKVHtqD7UvIPpBMzmLNXWCdeO285CBcrmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCldlc2xleSBDaGVuZyB3cm90ZToNCj4gRnJvbTogVGhpbmggTmd1eWVuIDxUaGluaC5O
Z3V5ZW5Ac3lub3BzeXMuY29tPg0KPiANCj4gSWYgdGhlIHJlcXVlc3QgYmVpbmcgZGVxdWV1ZWQg
aXMgY3VycmVudGx5IGFjdGl2ZSwgdGhlbiB0aGUgY3VycmVudA0KPiBsb2dpYyBpcyB0byBpc3N1
ZSBhIHN0b3AgdHJhbnNmZXIgY29tbWFuZCwgYW5kIGFsbG93IHRoZSBjb21tYW5kDQo+IGNvbXBs
ZXRpb24gdG8gY2xlYW51cCB0aGUgY2FuY2VsbGVkIGxpc3QuICBUaGUgRFdDMyBjb250cm9sbGVy
IHdpbGwNCj4gcnVuIGludG8gYW4gZW5kIHRyYW5zZmVyIGNvbW1hbmQgdGltZW91dCBpZiB0aGVy
ZSBpcyBhbiBvbmdvaW5nIEVQMA0KPiB0cmFuc2FjdGlvbi4gIElmIHRoaXMgaXMgdGhlIGNhc2Us
IHdhaXQgZm9yIHRoZSBFUDAgY29tcGxldGlvbiBldmVudA0KPiBiZWZvcmUgcHJvY2VlZGluZyB0
byByZXRyeSB0aGUgZW5keGZlciBjb21tYW5kIGFnYWluLg0KDQpDYW4geW91IGZpeCB0aGUgY29t
bWl0IG1lc3NhZ2UgYXMgZm9sbG93Og0KDQpJZiBhIFNldHVwIHBhY2tldCBpcyByZWNlaXZlZCBi
dXQgeWV0IHRvIERNQSBvdXQsIHRoZSBjb250cm9sbGVyIHdpbGwNCm5vdCBwcm9jZXNzIHRoZSBF
bmQgVHJhbnNmZXIgY29tbWFuZCBvZiBhbnkgZW5kcG9pbnQuIFBvbGxpbmcgb2YgaXRzDQpERVBD
TUQuQ21kQWN0IG1heSBibG9jayBzZXR0aW5nIHVwIFRSQiBmb3IgU2V0dXAgcGFja2V0LCBjYXVz
aW5nIGENCmNvbW1hbmQgdGltZW91dC4NCg0KVGhpcyBtYXkgb2NjdXIgaWYgdGhlIGRyaXZlciBk
b2VzbuKAmXQgc2VydmljZSB0aGUgY29tcGxldGlvbiBpbnRlcnJ1cHQgb2YNCnRoZSBjb250cm9s
IHN0YXR1cyBzdGFnZSB5ZXQgZHVlIHRvIHN5c3RlbSBsYXRlbmN5LCB0aGVuIGl0IHdvbuKAmXQN
CnByZXBhcmUgVFJCIGFuZCBzdGFydCB0aGUgdHJhbnNmZXIgZm9yIHRoZSBuZXh0IFNldHVwIFN0
YWdlLiBUbyB0aGUgaG9zdA0Kc2lkZSwgdGhlIGNvbnRyb2wgdHJhbnNmZXIgaGFkIGNvbXBsZXRl
ZCwgYW5kIHRoZSBob3N0IGNhbiBzZW5kIGEgbmV3DQpTZXR1cCBwYWNrZXQgYXQgdGhpcyBwb2lu
dC4NCg0KSW4gdGhlIG1lYW53aGlsZSwgaWYgdGhlIGRyaXZlciByZWNlaXZlcyBhbiBhc3luYyBj
YWxsIHRvIGRlcXVldWUgYQ0KcmVxdWVzdCAodHJpZ2dlcmluZyBFbmQgVHJhbnNmZXIpIHRvIGFu
eSBlbmRwb2ludCwgdGhlbiB0aGUgZHJpdmVyIHdpbGwNCnNlcnZpY2UgdGhhdCBFbmQgdHJhbnNm
ZXIgZmlyc3QsIGJsb2NraW5nIHRoZSBjb250cm9sIHN0YXR1cyBzdGFnZQ0KY29tcGxldGlvbiBo
YW5kbGVyLiBTaW5jZSBubyBUUkIgaXMgYXZhaWxhYmxlIGZvciB0aGUgU2V0dXAgc3RhZ2UsIHRo
ZQ0KU2V0dXAgcGFja2V0IGNhbuKAmXQgYmUgRE1B4oCZZWQgb3V0IGFuZCB0aGUgRW5kIFRyYW5z
ZmVyIGdldHMgaHVuZy4NCg0KVGhlIGRyaXZlciBtdXN0IG5vdCBibG9jayBzZXR0aW5nIHVwIG9m
IHRoZSBTZXR1cCBzdGFnZS4gU28gdHJhY2sgYW5kDQpvbmx5IGlzc3VlIHRoZSBFbmQgVHJhbnNm
ZXIgY29tbWFuZCBvbmx5IHdoZW4gdGhlcmXigJlzIFNldHVwIFRSQiBwcmVwYXJlZA0Kc28gdGhh
dCB0aGUgY29udHJvbGxlciBjYW4gRE1BIG91dCB0aGUgU2V0dXAgcGFja2V0LiBEZWxheSB0aGUg
RW5kDQp0cmFuc2ZlciBjb21tYW5kIHVudGlsIHRoZXJlJ3Mgbm8gU2V0dXAgVFJCIGF2YWlsYWJs
ZS4gVGhpcyBpcw0KYXBwbGljYWJsZSB0byBhbGwgRFdDX3VzYjN4IElQcy4NCg0KDQoNCj4gDQo+
IENvLWRldmVsb3BlZC1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVuZ0BxdWljaW5jLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVuZ0BxdWljaW5jLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29t
Pg0KPiAtLS0NCj4gIFBhdGNoIGRpc2N1c3Npb24gYmVsb3c6DQo+ICAgIGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMTY0NDgzNjkz
My0xNDEzNzYtMS1naXQtc2VuZC1lbWFpbC1kaDEwLmp1bmdAc2Ftc3VuZy5jb20vVC8qdF9fO0l3
ISFBNEYyUjlHX3BnIU1hTjI2c3c0RUtRRGRLSXRGdzdzVklTSXo4WmE5UTJvMkZySWQwT1l2aWFP
eVRrUVJyQVZ1SVlGSS1FYl9Ya1I3U0dQJCANCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aCAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMgICAgfCAxNCArKysrKysrKysr
KysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDEzICsrKysrKysrLS0tLS0NCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmggfCAgMSArDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBlYjlj
MWVmY2VkMDUuLmY1NTdmNWYzNmE3ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTczNiw3ICs3MzYs
NyBAQCBzdHJ1Y3QgZHdjM19lcCB7DQo+ICAjZGVmaW5lIERXQzNfRVBfRklSU1RfU1RSRUFNX1BS
SU1FRAlCSVQoMTApDQo+ICAjZGVmaW5lIERXQzNfRVBfUEVORElOR19DTEVBUl9TVEFMTAlCSVQo
MTEpDQo+ICAjZGVmaW5lIERXQzNfRVBfVFhGSUZPX1JFU0laRUQJCUJJVCgxMikNCj4gLQ0KPiAr
I2RlZmluZSBEV0MzX0VQX0RFTEFZX1NUT1AgICAgICAgICAgICAgQklUKDEzKQ0KPiAgCS8qIFRo
aXMgbGFzdCBvbmUgaXMgc3BlY2lmaWMgdG8gRVAwICovDQo+ICAjZGVmaW5lIERXQzNfRVAwX0RJ
Ul9JTgkJCUJJVCgzMSkNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9lcDAu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gaW5kZXggNjU4NzM5NDEwOTkyLi4xMDY0YmU1
NTE4ZjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9lcDAuYw0KPiBAQCAtMjcxLDYgKzI3MSw3IEBAIHZvaWQgZHdjM19lcDBf
b3V0X3N0YXJ0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzNfZXAJCQkq
ZGVwOw0KPiAgCWludAkJCQlyZXQ7DQo+ICsJaW50ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpOw0KPiAgDQo+ICAJY29tcGxldGUoJmR3Yy0+ZXAwX2luX3NldHVwKTsNCj4gIA0KPiBAQCAt
Mjc5LDYgKzI4MCwxOSBAQCB2b2lkIGR3YzNfZXAwX291dF9zdGFydChzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiAgCQkJRFdDM19UUkJDVExfQ09OVFJPTF9TRVRVUCwgZmFsc2UpOw0KPiAgCXJldCA9IGR3
YzNfZXAwX3N0YXJ0X3RyYW5zKGRlcCk7DQo+ICAJV0FSTl9PTihyZXQgPCAwKTsNCj4gKwlmb3Ig
KGkgPSAyOyBpIDwgRFdDM19FTkRQT0lOVFNfTlVNOyBpKyspIHsNCj4gKwkJc3RydWN0IGR3YzNf
ZXAgKmR3YzNfZXA7DQo+ICsNCj4gKwkJZHdjM19lcCA9IGR3Yy0+ZXBzW2ldOw0KPiArCQlpZiAo
IWR3YzNfZXApDQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiArCQlpZiAoIShkd2MzX2VwLT5mbGFn
cyAmIERXQzNfRVBfREVMQVlfU1RPUCkpDQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiArCQlkd2Mz
X2VwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxBWV9TVE9QOw0KPiArCQlkd2MzX3N0b3BfYWN0aXZl
X3RyYW5zZmVyKGR3YzNfZXAsIHRydWUsIHRydWUpOw0KPiArCX0NCj4gIH0NCj4gIA0KPiAgc3Rh
dGljIHN0cnVjdCBkd2MzX2VwICpkd2MzX3dJbmRleF90b19kZXAoc3RydWN0IGR3YzMgKmR3Yywg
X19sZTE2IHdJbmRleF9sZSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGEwYzg4M2YxOWE0MS4uY2Nl
ZjUwOGIxMjk2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTY1NCw5ICs2NTQsNiBAQCBzdGF0
aWMgaW50IGR3YzNfZ2FkZ2V0X3NldF9lcF9jb25maWcoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5z
aWduZWQgaW50IGFjdGlvbikNCj4gIAlyZXR1cm4gZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoZGVw
LCBEV0MzX0RFUENNRF9TRVRFUENPTkZJRywgJnBhcmFtcyk7DQo+ICB9DQo+ICANCj4gLXN0YXRp
YyB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwgYm9v
bCBmb3JjZSwNCj4gLQkJYm9vbCBpbnRlcnJ1cHQpOw0KPiAtDQo+ICAvKioNCj4gICAqIGR3YzNf
Z2FkZ2V0X2NhbGNfdHhfZmlmb19zaXplIC0gY2FsY3VsYXRlcyB0aGUgdHhmaWZvIHNpemUgdmFs
dWUNCj4gICAqIEBkd2M6IHBvaW50ZXIgdG8gdGhlIERXQzMgY29udGV4dA0KPiBAQCAtMTg5OSw2
ICsxODk2LDcgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2VwX3F1ZXVlKHN0cnVjdCBkd2Mz
X2VwICpkZXAsIHN0cnVjdCBkd2MzX3JlcXVlc3QgKnJlcSkNCj4gIAkgKi8NCj4gIAlpZiAoKGRl
cC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HKSB8fA0KPiAgCSAgICAoZGVw
LT5mbGFncyAmIERXQzNfRVBfV0VER0UpIHx8DQo+ICsJICAgIChkZXAtPmZsYWdzICYgRFdDM19F
UF9ERUxBWV9TVE9QKSB8fA0KPiAgCSAgICAoZGVwLT5mbGFncyAmIERXQzNfRVBfU1RBTEwpKSB7
DQo+ICAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9ERUxBWV9TVEFSVDsNCj4gIAkJcmV0dXJuIDA7
DQo+IEBAIC0yMDMzLDYgKzIwMzEsOSBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2VwX2RlcXVl
dWUoc3RydWN0IHVzYl9lcCAqZXAsDQo+ICAJCWlmIChyID09IHJlcSkgew0KPiAgCQkJc3RydWN0
IGR3YzNfcmVxdWVzdCAqdDsNCj4gIA0KDQpBZGQgYSBjb21tZW50IGhlcmU6DQoNCklmIGEgU2V0
dXAgcGFja2V0IGlzIHJlY2VpdmVkIGJ1dCB5ZXQgdG8gRE1BIG91dCwgdGhlIGNvbnRyb2xsZXIg
d2lsbA0Kbm90IHByb2Nlc3MgdGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kIG9mIGFueSBlbmRwb2lu
dC4gUG9sbGluZyBvZiBpdHMNCkRFUENNRC5DbWRBY3QgbWF5IGJsb2NrIHNldHRpbmcgdXAgVFJC
IGZvciBTZXR1cCBwYWNrZXQsIGNhdXNpbmcgYQ0KdGltZW91dC4gRGVsYXkgaXNzdWluZyB0aGUg
RW5kIFRyYW5zZmVyIGNvbW1hbmQgdW50aWwgdGhlIFNldHVwIFRSQiBpcw0KcHJlcGFyZWQuDQoN
Cj4gKwkJCWlmIChkd2MtPmVwMHN0YXRlICE9IEVQMF9TRVRVUF9QSEFTRSAmJiAhZHdjLT5kZWxh
eWVkX3N0YXR1cykNCj4gKwkJCQlkZXAtPmZsYWdzIHw9IERXQzNfRVBfREVMQVlfU1RPUDsNCj4g
Kw0KPiAgCQkJLyogd2FpdCB1bnRpbCBpdCBpcyBwcm9jZXNzZWQgKi8NCj4gIAkJCWR3YzNfc3Rv
cF9hY3RpdmVfdHJhbnNmZXIoZGVwLCB0cnVlLCB0cnVlKTsNCj4gIA0KPiBAQCAtMjExNiw3ICsy
MTE3LDggQEAgaW50IF9fZHdjM19nYWRnZXRfZXBfc2V0X2hhbHQoc3RydWN0IGR3YzNfZXAgKmRl
cCwgaW50IHZhbHVlLCBpbnQgcHJvdG9jb2wpDQo+ICAJCWxpc3RfZm9yX2VhY2hfZW50cnlfc2Fm
ZShyZXEsIHRtcCwgJmRlcC0+c3RhcnRlZF9saXN0LCBsaXN0KQ0KPiAgCQkJZHdjM19nYWRnZXRf
bW92ZV9jYW5jZWxsZWRfcmVxdWVzdChyZXEsIERXQzNfUkVRVUVTVF9TVEFUVVNfU1RBTExFRCk7
DQo+ICANCj4gLQkJaWYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5H
KSB7DQo+ICsJCWlmIChkZXAtPmZsYWdzICYgRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORyB8
fA0KPiArCQkgICAgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApKSB7DQo+ICAJCQlk
ZXAtPmZsYWdzIHw9IERXQzNfRVBfUEVORElOR19DTEVBUl9TVEFMTDsNCj4gIAkJCXJldHVybiAw
Ow0KPiAgCQl9DQo+IEBAIC0zNTk2LDcgKzM1OTgsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX3Jlc2V0
X2dhZGdldChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCX0NCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZv
aWQgZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwLCBib29sIGZv
cmNlLA0KPiArdm9pZCBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpk
ZXAsIGJvb2wgZm9yY2UsDQo+ICAJYm9vbCBpbnRlcnJ1cHQpDQo+ICB7DQo+ICAJc3RydWN0IGR3
YzNfZ2FkZ2V0X2VwX2NtZF9wYXJhbXMgcGFyYW1zOw0KPiBAQCAtMzYwNCw2ICszNjA2LDcgQEAg
c3RhdGljIHZvaWQgZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVw
LCBib29sIGZvcmNlLA0KPiAgCWludCByZXQ7DQo+ICANCj4gIAlpZiAoIShkZXAtPmZsYWdzICYg
RFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKSB8fA0KPiArCQkoZGVwLT5mbGFncyAmIERXQzNfRVBf
REVMQVlfU1RPUCkgfHwNCg0KbWlub3Igbml0OiBjYW4geW91IGZpeCBhbGlnbm1lbnQuDQoNCj4g
IAkgICAgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HKSkNCj4gIAkJ
cmV0dXJuOw0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5oIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaA0KPiBpbmRleCA3N2RmNGI2ZDZjMTMuLmY3NjMzODBl
NjcyZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaA0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5oDQo+IEBAIC0xMTYsNiArMTE2LDcgQEAgaW50IGR3YzNf
Z2FkZ2V0X2VwMF9xdWV1ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpy
ZXF1ZXN0LA0KPiAgCQlnZnBfdCBnZnBfZmxhZ3MpOw0KPiAgaW50IF9fZHdjM19nYWRnZXRfZXBf
c2V0X2hhbHQoc3RydWN0IGR3YzNfZXAgKmRlcCwgaW50IHZhbHVlLCBpbnQgcHJvdG9jb2wpOw0K
PiAgdm9pZCBkd2MzX2VwMF9zZW5kX2RlbGF5ZWRfc3RhdHVzKHN0cnVjdCBkd2MzICpkd2MpOw0K
PiArdm9pZCBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXAsIGJv
b2wgZm9yY2UsIGJvb2wgaW50ZXJydXB0KTsNCj4gIA0KPiAgLyoqDQo+ICAgKiBkd2MzX2dhZGdl
dF9lcF9nZXRfdHJhbnNmZXJfaW5kZXggLSBHZXRzIHRyYW5zZmVyIGluZGV4IGZyb20gSFcNCg0K
VGhhbmtzLA0KVGhpbmgNCg==
