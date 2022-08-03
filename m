Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76190588500
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiHCABx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHCABu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:01:50 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7EE140E6;
        Tue,  2 Aug 2022 17:01:48 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272K9KLk013109;
        Tue, 2 Aug 2022 17:01:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=rJKMRf4y+/RUoFQONMRrK6rv5TC//j6UBKFS4rQ990c=;
 b=qrXLyos2m4vx0AujHsGILSMJPD3QKIKoB0UzNklH76VRIMU9Pm7T6Py3ookPxZsJ8BDs
 H2tHbJmZS91F/vI/Tz5W8FVX1zVGCy2R8HSsR66w1WCUXbYEV+EdioZBqE3yUGCDM4Cd
 2r7b8ZQ1Jl/wUxcMmmxBlT6B1jr5EDOtylrzmdYbf03NdJk/yhR+vb84ira4d1Bstn57
 qmOHH4zqNEzsGbQvHBr61oi6gFFaptxARh++zN6/elNvCVpr9o4oRjteg2NnYO7yqKIj
 y69vp913VH+z/YNyElGP+gN6dtGSkWWwhvGSKHkBYQyeGEK3fiHU35FdU/LfT70j+NXt sg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3hn39fgwgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 17:01:19 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A7CD0C00F7;
        Wed,  3 Aug 2022 00:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1659484878; bh=rJKMRf4y+/RUoFQONMRrK6rv5TC//j6UBKFS4rQ990c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IX6yxbTxJBdSyUg6s9SXGSrd7U+dpuLzZhxCRi23ExlXwVHnkUHhKjtGBOpvj/pq1
         77n/7x675M6CLLafAulqGg5V0sRRF0XOgZF2F+XQUOOI0KhJbJAYUT+F4iqBtSD6SX
         2yG0BezKNpxMleI5RacKAHNUBjn3HXNYmESAKzOZ1+yn5ZuLYR17yXzRbnQzNt+wS0
         tdH1Rp16Jmp3SPoxnqeB+Ek8gEEsddjJQ+YCB+mlaEJKspUmvNAsTH+Pn2exdGtSG3
         aMklRgTfOX0cPoOirdDr3RA123848O2tDTueh40woQubVpDCNzUsXQvRdUSCC5Cniy
         3+L5hVGjWsCBA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0B669A005C;
        Wed,  3 Aug 2022 00:01:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6A07F400BF;
        Wed,  3 Aug 2022 00:01:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="olcKB/8v";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MonSLgQ82z2R2bld50qMxnvdnqzrUyiIYzhdbDDL4wrEaaMH/Lj43t1zGJwpaPRs6SC4xZkRsMQDx4w1D5A8KylHOVLBV42QW1NkTK10VJT5eaYBs1XijnAU86cQJ0p6ITwL7Jj72paEJEtL+vEaAWsqZw4ySCdQiADukRm3RfTpDevV6w2o1jcnXsArLxC2oqqio8uMT3YEWJL7KSLaQrE7gAAXmHGEET9V07Jtmg/occBPi5VB0U2Tjpcuv7hOeTfbs4RcGG0JL8oVHehUOKryJPrbwGn6l7WHSio6nTJ6uS0GQeg73djD2NHdlE1uF4sRHE3xumqxCCK0boOyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJKMRf4y+/RUoFQONMRrK6rv5TC//j6UBKFS4rQ990c=;
 b=Ajan7C0TYkDA9x4vR4m57tSOG4tDj/fCKeSomzceQIjoX/u0K7nvq+9WKAnC3OtJuTiSjgadn/7tKj54hDhXxyC1DsmyZ64nkU36tppOsKdaRgB7LW7VlwnU5WtAmEHlBWirA2iy2dLqAJm8AOMpDY1VGDzXOFKjOgABn5L2cb2lzXOSBdRWxkbjxWOnpl218E/VSmRUaGgmdCE5SawRH7m63L5AhlepZ+WE2rYyYaEgpMi4GTUXm1j00Usrw/VqW1jpwhoPYR3Wqdd56HhJ3BAV5Au02u9pI0Ne/jX43gRqDWRK5K2zSfortaO4DBVftXMHlBzCYxEM3A/1elGBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJKMRf4y+/RUoFQONMRrK6rv5TC//j6UBKFS4rQ990c=;
 b=olcKB/8vIlWFRoeTH/MAG3emFBZjEohhv3dwGO69OD3aJ8UF/4Nu+zVyvCFe5zwKNYippCX1yRSV5MlEQLiiN7iblxnUgMBfoaIA+HBf6itScISexNiCrYN5KoB2BSjh3BTPNic9me67yocHSJ1B9N8ucRQ6zfy9kw/gpn1u62g=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 3 Aug
 2022 00:01:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5482.014; Wed, 3 Aug 2022
 00:01:14 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH 1/5] usb: dwc3: Add remote wakeup handling
Thread-Topic: [PATCH 1/5] usb: dwc3: Add remote wakeup handling
Thread-Index: AQHYpqS5lPHnqL0URkaZk6bVPiQU0q2cSwCA
Date:   Wed, 3 Aug 2022 00:01:14 +0000
Message-ID: <910da314-f00f-2fa0-c35d-fd176d63f18b@synopsys.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-2-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1659467920-9095-2-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5780157c-247a-49e3-4974-08da74e347fb
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsCbaBpGuyWXg44DdHkO7kG0JUGafu2nV4tvK7hNxaLtWExVKW2S//VJ7UjPiT6IyCfjr4Kijuny4Od79pq5bAiMuM7b2FBxgaGJxCei2nYMSdgkfUsGCEg0LarKAIa9YX98exNQYvq8cf2t/1HnAaLII4MzIon5+qP5KnB1FQ8gVQ4SNuMdsTrT2K0SfViuxaQY3vSzpEZmAbOu1G1kTIvZwgjvrfW400TxEKOKh1CBgMC0yGSXiu5pZFVAblKeDmbzcLfscu/nxuz9uvZijDF1LxjwAHfW2q3McS1ObLJFFDfxk0Jb7fLNmLQtWs9EylqnmDouoH2QMQC1caZP6fabthOJoQKF/fxbkemdgo5s+0+Xxs95BCBm+drDbGXmYg9dLhdUgDNowncazOrGLOjop7afe6x2zwV6lfUDvl6DKwk4nglvDnxsx8Jn0PCAYwEb3art+QeJHeJCy/gvaCeJsATtMHe+V4mXReAvK8Oi7n/++EZi3vls1nXjaFy4MBxUr3Z9T7cXc8kCaKkQnUhOGuvTfMqujfc8y5XKdm0TaJLRCCKCw8IH99Q3uAHkyJH5xFrmx21MtrIwt8+UjG9s5wX6TrHKmKUi/bplrCejlwvApZjrqG0scoAQB+WHKcUDoL3QY/IaOJ+GKbw++QaBQHefwHuL4IYqOeE1LHNB+BKAdfRGDUKt1cPnTdy5VkescfF9+hOu6IoomPdeL+RI4/liGCrC+WPWcGAkNm2UPqnfl5ro6sDxz10jmRO7Vsw1qIGWrh7jEeOhFnwpATqrjGouEbuvlAYrZLJtvr+nW0GaFwXNlh4rtixNDXo2RSUS43d60FXdSGOjlMtCdDVhRgEW9nHdcGxA3YMi3/7QxOaoiokHZAoSqbLiKu0f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(346002)(366004)(39860400002)(76116006)(186003)(36756003)(38100700002)(2616005)(6506007)(86362001)(31696002)(66556008)(71200400001)(66946007)(64756008)(66476007)(107886003)(66446008)(83380400001)(6512007)(26005)(31686004)(8676002)(4326008)(8936002)(2906002)(54906003)(41300700001)(478600001)(110136005)(5660300002)(38070700005)(6486002)(122000001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWNSeTkxQXRVOEhXY1puMXAwZVU1ZWNrQ3hNQkVHWkhXeWZRY3B0eldPYytC?=
 =?utf-8?B?MjRscXBsNXRCMGR3dS9hMjEwcm01TUJ1dzY4RGxGMWRocWlhUFE3OWtEWjNu?=
 =?utf-8?B?d1pQbFhLeDArL0U1anBMYXNXbWhkOG9aRkdzQUFVZUFCVGpiU2dTeUU1aXJr?=
 =?utf-8?B?RUZrREJFcEQ4Z2dDdVVDNmdKU1Z5eWsxYTJkWXg2dmU5ZjhvSFNOWEswdGRO?=
 =?utf-8?B?cncwWU9OUGk0YVZ5WG5xWnR0M2R1SGoxdTB2R3BreTNkaC9IRElRdUUzWElT?=
 =?utf-8?B?SjRNbTJvd1hLZWJaU3RraEFKdkozVFZ5MTRWTnI1QjVvdk5UaTRkTmo5ejZD?=
 =?utf-8?B?RWJ0NHVDWFFSb2FHY2R0QTdvanZhWnJvcE9UNkZSZG0wbmU5RFhLdUhRQzNK?=
 =?utf-8?B?T2c1cEdvNVpiNWs3QlVnS012SW9Jb2s1V0w5NnFmamRwRXhqaXY5Nzd0a0Z6?=
 =?utf-8?B?SXJRbXcxVFgvbE5Yejd6ZUJGdWFzUUFLc1d4a1NHTi9HeU5YMkYxSXFKTGpL?=
 =?utf-8?B?by9mTFN2VENZUVlFemNYYjVoTFNwTFNWVFhaL2lHOXRkVUxFUzYxMTIvNWFI?=
 =?utf-8?B?UUgxQ2wxajV5SWZLblZmeVYxclo4N0RMbGVWZkFKaG0rMUNhcy9neFdZbTZ3?=
 =?utf-8?B?bTV6L3BRYVVuWE9aTUh1VHhMTS9uUzFvdTJ6aHlhUHVYeEw3ZGo3NlQyQWx0?=
 =?utf-8?B?M3dyRUZFOFk0T0RLWmJCNXpaQWw2VzVCbHhTRVoxS1NVWFFPLytGOWRraG4w?=
 =?utf-8?B?NWk1NlVFK25BdjFHRW04bE94NlJqMWVST0hPcEx3Qm5xVWlsRDVPbk8zcFFn?=
 =?utf-8?B?WUdXY1Vybnhmck1WSCtWQXVyTzIvWVRZSFNSazFqdzJwcTlqVGg4bFZQUzcx?=
 =?utf-8?B?Rnd2cFUzQlVtUXpvZnZ0bHVOWTlONGJaM2k5VlVGM1FSbnIyWkVYMkNtSEZu?=
 =?utf-8?B?NDNSaUtOTVdXOTE3ZEpYZytxaHBYYlBvVEpyTzBQWGxTa1JIVk16VkVBd2NE?=
 =?utf-8?B?dmQ1RVB2NVQzUnZiRFQ5ckt4Vk5xRUNDcTRuODRwS1lwSnpGWTBYdjB2M2h0?=
 =?utf-8?B?VnVHT3FyMHFpaUk0MW5hK0V6cHVud0ZxUVBQQ2w3b3grSHdsbGI2bzhaN09J?=
 =?utf-8?B?ekZSaTRsWTNseXNLbGoxVWMzSzF1MFVEdmJvN3lXSXR6dG16K0R0bSs3ZDhG?=
 =?utf-8?B?Z0hhblhrQW5NRCtraXRERWtiZWg3VjZqTjdRV0VVa0ZibzRVai9YRzk5U2Rq?=
 =?utf-8?B?QlJIZ1ZZN0thb2RJTCt3VVVsSTJheGhDZjlaRzlUc2NYN3J2TXpPcXg1NE8y?=
 =?utf-8?B?R2JQVjBRRUlJN1ZqbnoxOW1zQ3lOUitpSTVDUTV4WUo3NE0rSU9HQlJnbGh3?=
 =?utf-8?B?dFJkdGRKTHV3NUFzT0VFUUhDVVpWdllPc0ZTeiszWkpOQmxXb3RTajZDR21H?=
 =?utf-8?B?OU43K1hub24wZUhJQ285UUxVbVR5ZVhodHVBdUdaSGdkcWQvWWhKR2REekdR?=
 =?utf-8?B?M2x4aXJKM2FDQzliKytZRUc1K2tnUVA3aGs5enZmbHFnSHZhdGdjQUVZamNt?=
 =?utf-8?B?Vyt2emhOMDdONmM1Z2dWRGs5QThxVUpqWWs4Q3hvQWxGK3RTeXV5aFR2NFJZ?=
 =?utf-8?B?UEdnR0pWMjRvM2pueXMvTEN6NEp4TU1yT2tycWtTK1lONkhPN1V5TTZkTEF6?=
 =?utf-8?B?S1dQcWl3MXdKWlBSMVZBZ3dRRS8xU09wOGlqeW5HdGhpcWM2dFBUV2xuVmZM?=
 =?utf-8?B?eDJGM0xhMWduOUluem44Y3NZY2duZC91TzM0aXYxWGNLNVE1eHJ5S3liZzM0?=
 =?utf-8?B?Slk2MlBxdjNvTVhkTnRZSnRVUGw2ME4yK0lPWWF6OVBhdjRKdGI2M3BTR0ha?=
 =?utf-8?B?M0xHNCtHTE1RUnRVQnIzR0FlYkNwSFZwSlZ3eStCb1RiMmhFTGRrZlV1dXgz?=
 =?utf-8?B?bmdFVXJHMEJUV3dDUW1pRHFJUWpBMmE1L21CbkR2bitSR0tVRHBveWI0Q2xv?=
 =?utf-8?B?K0FxTW1adWpTemlzR3B4UFIxVjY3WVFlczNhVGJhUXkzVmcya0FZanM3dkpo?=
 =?utf-8?B?b2VZV0dPenc2YmhkT3VnVElTTVk1Skt5M01nSDEvUEE5K2FLM2pXQ0tkZWhz?=
 =?utf-8?Q?TtDVOQs9fACfVd5gCDYeSE4NF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B5277137894814EA3CC896CA0EC6913@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5780157c-247a-49e3-4974-08da74e347fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 00:01:14.0239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Su2559MXR5oFebsWpQbEJHJ2QIxM9R46HIlV4dIcIvt+73q6xGOArOINpyGsdfFCSzsM5e8t/iDRU8/k9v9KKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
X-Proofpoint-GUID: u3TPYO7m8hF-MsSoKREkfyOwk0o1pE0C
X-Proofpoint-ORIG-GUID: u3TPYO7m8hF-MsSoKREkfyOwk0o1pE0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 impostorscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yLzIwMjIsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEFuIHVzYiBkZXZpY2UgY2Fu
IGluaXRhdGUgYSByZW1vdGUgd2FrZXVwIGFuZCBicmluZyB0aGUgbGluayBvdXQgb2YNCj4gc3Vz
cGVuZCBhcyBkaWN0YXRlZCBieSB0aGUgREVWSUNFX1JFTU9URV9XQUtFVVAgZmVhdHVyZSBzZWxl
Y3Rvci4NCj4gQWRkIHN1cHBvcnQgdG8gaGFuZGxlIHRoaXMgcGFja2V0IGFuZCBzZXQgdGhlIHJl
bW90ZSB3YWtldXAgY2FwYWJpbGl0eQ0KPiBhY2NvcmRpbmdseS4NCj4NCj4gU29tZSBob3N0cyBt
YXkgdGFrZSBsb25nZXIgdGltZSB0byBpbml0aWF0ZSB0aGUgcmVzdW1lDQo+IHNpZ25hbGluZyBh
ZnRlciBkZXZpY2UgdHJpZ2dlcnMgYSByZW1vdGUgd2FrZXVwLiBTbyBpbXByb3ZlIHRoZQ0KPiBn
YWRnZXRfd2FrZXVwIG9wIHRvIGludGVycnVwdCBiYXNlZCByYXRoZXIgdGhhbiBwb2xsaW5nIGJh
c2VkIGJ5DQo+IGVuYWJsaW5nIGxpbmsgc3RhdHVzIGNoYW5nZSBldmVudHMuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4g
LS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggICB8ICA0ICsrKw0KPiAgIGRyaXZlcnMv
dXNiL2R3YzMvZXAwLmMgICAgfCAgNCArKysNCj4gICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IHwgNjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+IGluZGV4IDRmZTQyODcuLjMzMDZiMWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0x
MTEzLDYgKzExMTMsOCBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4gICAgKgkJ
ICAgICBhZGRyZXNzLg0KPiAgICAqIEBudW1fZXBfcmVzaXplZDogY2FycmllcyB0aGUgY3VycmVu
dCBudW1iZXIgZW5kcG9pbnRzIHdoaWNoIGhhdmUgaGFkIGl0cyB0eA0KPiAgICAqCQkgICAgZmlm
byByZXNpemVkLg0KPiArICogQGlzX3JlbW90ZV93YWtldXBfZW5hYmxlZDogcmVtb3RlIHdha2V1
cCBzdGF0dXMgZnJvbSBob3N0IHBlcnNwZWN0aXZlDQo+ICsgKiBAaXNfZ2FkZ2V0X3dha2V1cDog
cmVtb3RlIHdha2V1cCByZXF1ZXN0ZWQgdmlhIGdhZGdldCBvcC4NCj4gICAgKi8NCj4gICBzdHJ1
Y3QgZHdjMyB7DQo+ICAgCXN0cnVjdCB3b3JrX3N0cnVjdAlkcmRfd29yazsNCj4gQEAgLTEzMjYs
NiArMTMyOCw4IEBAIHN0cnVjdCBkd2MzIHsNCj4gICAJaW50CQkJbWF4X2NmZ19lcHM7DQo+ICAg
CWludAkJCWxhc3RfZmlmb19kZXB0aDsNCj4gICAJaW50CQkJbnVtX2VwX3Jlc2l6ZWQ7DQo+ICsJ
Ym9vbAkJCWlzX3JlbW90ZV93YWtldXBfZW5hYmxlZDsNCj4gKwlib29sCQkJaXNfZ2FkZ2V0X3dh
a2V1cDsNCj4gICB9Ow0KPiAgIA0KPiAgICNkZWZpbmUgSU5DUlhfQlVSU1RfTU9ERSAwDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jIGIvZHJpdmVycy91c2IvZHdjMy9lcDAu
Yw0KPiBpbmRleCAxOTdhZjYzLi40Y2MzZDNhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9k
d2MzL2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAgLTM1Myw2ICsz
NTMsOSBAQCBzdGF0aWMgaW50IGR3YzNfZXAwX2hhbmRsZV9zdGF0dXMoc3RydWN0IGR3YzMgKmR3
YywNCj4gICAJCQkJdXNiX3N0YXR1cyB8PSAxIDw8IFVTQl9ERVZfU1RBVF9VMV9FTkFCTEVEOw0K
PiAgIAkJCWlmIChyZWcgJiBEV0MzX0RDVExfSU5JVFUyRU5BKQ0KPiAgIAkJCQl1c2Jfc3RhdHVz
IHw9IDEgPDwgVVNCX0RFVl9TVEFUX1UyX0VOQUJMRUQ7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQl1
c2Jfc3RhdHVzIHw9IGR3Yy0+aXNfcmVtb3RlX3dha2V1cF9lbmFibGVkIDw8DQo+ICsJCQkJCQlV
U0JfREVWSUNFX1JFTU9URV9XQUtFVVA7DQoNCllvdSBuZWVkIHRvIGNyZWF0ZSBhIG5ldyBtYWNy
byBmb3IgZnVuY3Rpb24gcmVtb3RlIGVuYWJsZWQuIE5hbWUgaXQgDQpzb21ldGhpbmcgbGlrZSBV
U0JfREVWX1NUQVRfRlVOQ19SV19FTkFCTEVEIHRvIG1hdGNoIHdpdGggb3RoZXJzIGluIGNoOS5o
DQoNCj4gICAJCX0NCj4gICANCj4gICAJCWJyZWFrOw0KPiBAQCAtNDczLDYgKzQ3Niw3IEBAIHN0
YXRpYyBpbnQgZHdjM19lcDBfaGFuZGxlX2RldmljZShzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAgIA0K
PiAgIAlzd2l0Y2ggKHdWYWx1ZSkgew0KPiAgIAljYXNlIFVTQl9ERVZJQ0VfUkVNT1RFX1dBS0VV
UDoNCj4gKwkJZHdjLT5pc19yZW1vdGVfd2FrZXVwX2VuYWJsZWQgPSBzZXQ7DQo+ICAgCQlicmVh
azsNCj4gICAJLyoNCj4gICAJICogOS40LjEgc2F5cyBvbmx5IGZvciBTUywgaW4gQWRkcmVzc1N0
YXRlIG9ubHkgZm9yDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA0MzY2YzQ1Li5kNjY5N2RhIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTIyMzIsNiArMjIzMiwyMiBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHVzYl9lcF9vcHMgZHdjM19nYWRnZXRfZXBfb3BzID0gew0KPiAgIA0KPiAgIC8qIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tICovDQo+ICAgDQo+ICtzdGF0aWMgdm9pZCBsaW5rc3RzX2NoYW5nZV9ldmVu
dHNfc2V0KHN0cnVjdCBkd2MzICpkd2MsIGJvb2wgc2V0KQ0KDQpJdCBzaG91bGQgYmUgbmFtZWQg
c29tZXRoaW5nIHRoYXQncyBjb25zaXN0ZW50IHdpdGggdGhlIG90aGVyIGZ1bmN0aW9ucy4gDQpT
b21ldGhpbmcgbGlrZSBkd2MzX2dhZGdldF9lbmFibGVfbGlua3N0YXRlX2NoYW5nZV9ldmVudCgp
DQoNCj4gK3sNCj4gKwl1MzIgcmVnOw0KPiArDQo+ICsJcmVnID0gZHdjM19yZWFkbChkd2MtPnJl
Z3MsIERXQzNfREVWVEVOKTsNCj4gKwlpZiAoc2V0KQ0KPiArCQlyZWcgfD0gRFdDM19ERVZURU5f
VUxTVENOR0VOOw0KPiArCWVsc2UNCj4gKwkJcmVnICY9IH5EV0MzX0RFVlRFTl9VTFNUQ05HRU47
DQo+ICsNCj4gKwlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfREVWVEVOLCByZWcpOw0KPiAr
DQo+ICsJLyogUmVxdWlyZWQgdG8gY29tcGxldGUgdGhpcyBvcGVyYXRpb24gYmVmb3JlIHJldHVy
bmluZyAqLw0KPiArCW1iKCk7DQoNCldoeSBkbyB3ZSBuZWVkIG1lbW9yeSBiYXJyaWVyIGhlcmU/
IEl0J3MganVzdCByZWdpc3RlciB3cml0ZSwgYW5kIHdlIA0KYWxyZWFkeSBoYXZlIGlvIGJhcnJp
ZXIgZm9yIHRoYXQuDQoNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfZ2V0
X2ZyYW1lKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnKQ0KPiAgIHsNCj4gICAJc3RydWN0IGR3YzMJCSpk
d2MgPSBnYWRnZXRfdG9fZHdjKGcpOw0KPiBAQCAtMjI3MCw5ICsyMjg2LDEzIEBAIHN0YXRpYyBp
bnQgX19kd2MzX2dhZGdldF93YWtldXAoc3RydWN0IGR3YzMgKmR3YykNCj4gICAJCXJldHVybiAt
RUlOVkFMOw0KPiAgIAl9DQo+ICAgDQo+ICsJbGlua3N0c19jaGFuZ2VfZXZlbnRzX3NldChkd2Ms
IHRydWUpOw0KPiArDQo+ICAgCXJldCA9IGR3YzNfZ2FkZ2V0X3NldF9saW5rX3N0YXRlKGR3Yywg
RFdDM19MSU5LX1NUQVRFX1JFQ09WKTsNCj4gICAJaWYgKHJldCA8IDApIHsNCj4gICAJCWRldl9l
cnIoZHdjLT5kZXYsICJmYWlsZWQgdG8gcHV0IGxpbmsgaW4gUmVjb3ZlcnlcbiIpOw0KPiArCQls
aW5rc3RzX2NoYW5nZV9ldmVudHNfc2V0KGR3YywgZmFsc2UpOw0KPiArCQlkd2MtPmlzX2dhZGdl
dF93YWtldXAgPSBmYWxzZTsNCj4gICAJCXJldHVybiByZXQ7DQo+ICAgCX0NCj4gICANCj4gQEAg
LTIyODQsOSArMjMwNCwxNSBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVj
dCBkd2MzICpkd2MpDQo+ICAgCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfRENUTCwgcmVn
KTsNCj4gICAJfQ0KPiAgIA0KPiArCS8qIElmIHJlbW90ZSB3YWtldXAgaXMgdHJpZ2dlcmVkIGZy
b20gZnVuY3Rpb24gZHJpdmVyLCBiYWlsIG91dC4NCg0KRm9sbG93IHRoaXMgdHlwZSBvZiBkb2MN
Cg0KLyoNCiDCoCogeHh4eA0KIMKgKiB5eXl5DQogwqAqLw0KDQo+ICsJICogU2luY2UgbGluayBz
dGF0dXMgY2hhbmdlIGV2ZW50cyBhcmUgZW5hYmxlZCB3ZSB3b3VsZCByZWNlaXZlDQo+ICsJICog
YW4gVTAgZXZlbnQgd2hlbiB3YWtldXAgaXMgc3VjY2Vzc2Z1bC4NCj4gKwkgKi8NCj4gKwlpZiAo
ZHdjLT5pc19nYWRnZXRfd2FrZXVwKQ0KPiArCQlyZXR1cm4gLUVBR0FJTjsNCj4gKw0KPiAgIAkv
KiBwb2xsIHVudGlsIExpbmsgU3RhdGUgY2hhbmdlcyB0byBPTiAqLw0KPiAgIAlyZXRyaWVzID0g
MjAwMDA7DQo+IC0NCj4gICAJd2hpbGUgKHJldHJpZXMtLSkgew0KPiAgIAkJcmVnID0gZHdjM19y
ZWFkbChkd2MtPnJlZ3MsIERXQzNfRFNUUyk7DQo+ICAgDQo+IEBAIC0yMjk1LDYgKzIzMjEsOCBA
QCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAg
CQkJYnJlYWs7DQo+ICAgCX0NCj4gICANCj4gKwlsaW5rc3RzX2NoYW5nZV9ldmVudHNfc2V0KGR3
YywgZmFsc2UpOw0KPiArDQo+ICAgCWlmIChEV0MzX0RTVFNfVVNCTE5LU1QocmVnKSAhPSBEV0Mz
X0xJTktfU1RBVEVfVTApIHsNCj4gICAJCWRldl9lcnIoZHdjLT5kZXYsICJmYWlsZWQgdG8gc2Vu
ZCByZW1vdGUgd2FrZXVwXG4iKTsNCj4gICAJCXJldHVybiAtRUlOVkFMOw0KPiBAQCAtMjMxMCw3
ICsyMzM4LDIwIEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVjdCB1c2JfZ2Fk
Z2V0ICpnKQ0KPiAgIAlpbnQJCQlyZXQ7DQo+ICAgDQo+ICAgCXNwaW5fbG9ja19pcnFzYXZlKCZk
d2MtPmxvY2ssIGZsYWdzKTsNCj4gKwlpZiAoZy0+c3BlZWQgPCBVU0JfU1BFRURfU1VQRVIgJiYg
IWR3Yy0+aXNfcmVtb3RlX3dha2V1cF9lbmFibGVkKSB7DQo+ICsJCWRldl9lcnIoZHdjLT5kZXYs
ICIlczpyZW1vdGUgd2FrZXVwIG5vdCBzdXBwb3J0ZWRcbiIsIF9fZnVuY19fKTsNCj4gKwkJcmV0
ID0gIC1FUEVSTTsNCj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiArCWlmIChkd2MtPmlzX2dhZGdl
dF93YWtldXApIHsNCj4gKwkJZGV2X2Vycihkd2MtPmRldiwgIiVzOiByZW1vdGUgd2FrZXVwIGlu
IHByb2dyZXNzXG4iLCBfX2Z1bmNfXyk7DQo+ICsJCXJldCA9IC1FSU5WQUw7DQo+ICsJCWdvdG8g
b3V0Ow0KPiArCX0NCj4gKwlkd2MtPmlzX2dhZGdldF93YWtldXAgPSB0cnVlOw0KPiAgIAlyZXQg
PSBfX2R3YzNfZ2FkZ2V0X3dha2V1cChkd2MpOw0KPiArDQo+ICtvdXQ6DQo+ICAgCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgIA0KPiAgIAlyZXR1cm4gcmV0
Ow0KPiBAQCAtMjc2Niw2ICsyODA3LDkgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9zdGFydChz
dHJ1Y3QgdXNiX2dhZGdldCAqZywNCj4gICANCj4gICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+
bG9jaywgZmxhZ3MpOw0KPiAgIAlkd2MtPmdhZGdldF9kcml2ZXIJPSBkcml2ZXI7DQo+ICsJbGlu
a3N0c19jaGFuZ2VfZXZlbnRzX3NldChkd2MsIGZhbHNlKTsNCj4gKwlkd2MtPmlzX3JlbW90ZV93
YWtldXBfZW5hYmxlZCA9IGZhbHNlOw0KPiArCWR3Yy0+aXNfZ2FkZ2V0X3dha2V1cCA9IGZhbHNl
Ow0KPiAgIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gICAN
Cj4gICAJcmV0dXJuIDA7DQo+IEBAIC0yNzg1LDYgKzI4MjksOSBAQCBzdGF0aWMgaW50IGR3YzNf
Z2FkZ2V0X3N0b3Aoc3RydWN0IHVzYl9nYWRnZXQgKmcpDQo+ICAgDQo+ICAgCXNwaW5fbG9ja19p
cnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gICAJZHdjLT5nYWRnZXRfZHJpdmVyCT0gTlVM
TDsNCj4gKwlsaW5rc3RzX2NoYW5nZV9ldmVudHNfc2V0KGR3YywgZmFsc2UpOw0KPiArCWR3Yy0+
aXNfcmVtb3RlX3dha2V1cF9lbmFibGVkID0gZmFsc2U7DQo+ICsJZHdjLT5pc19nYWRnZXRfd2Fr
ZXVwID0gZmFsc2U7DQo+ICAgCWR3Yy0+bWF4X2NmZ19lcHMgPSAwOw0KPiAgIAlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gICANCj4gQEAgLTM3NjgsNiArMzgx
NSw4IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2Rpc2Nvbm5lY3RfaW50ZXJydXB0KHN0cnVj
dCBkd2MzICpkd2MpDQo+ICAgCXVzYl9nYWRnZXRfc2V0X3N0YXRlKGR3Yy0+Z2FkZ2V0LCBVU0Jf
U1RBVEVfTk9UQVRUQUNIRUQpOw0KPiAgIA0KPiAgIAlkd2MtPmNvbm5lY3RlZCA9IGZhbHNlOw0K
PiArCWxpbmtzdHNfY2hhbmdlX2V2ZW50c19zZXQoZHdjLCBmYWxzZSk7DQo+ICsJZHdjLT5pc19n
YWRnZXRfd2FrZXVwID0gZmFsc2U7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIGR3YzNf
Z2FkZ2V0X3Jlc2V0X2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiBAQCAtMzg1NSw2ICsz
OTA0LDEwIEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X3Jlc2V0X2ludGVycnVwdChzdHJ1Y3Qg
ZHdjMyAqZHdjKQ0KPiAgIAlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19EQ0ZHKTsN
Cj4gICAJcmVnICY9IH4oRFdDM19EQ0ZHX0RFVkFERFJfTUFTSyk7DQo+ICAgCWR3YzNfd3JpdGVs
KGR3Yy0+cmVncywgRFdDM19EQ0ZHLCByZWcpOw0KPiArDQo+ICsJZHdjLT5pc19yZW1vdGVfd2Fr
ZXVwX2VuYWJsZWQgPSBmYWxzZTsNCj4gKwlsaW5rc3RzX2NoYW5nZV9ldmVudHNfc2V0KGR3Yywg
ZmFsc2UpOw0KPiArCWR3Yy0+aXNfZ2FkZ2V0X3dha2V1cCA9IGZhbHNlOw0KPiAgIH0NCj4gICAN
Cj4gICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9jb25uZG9uZV9pbnRlcnJ1cHQoc3RydWN0IGR3
YzMgKmR3YykNCj4gQEAgLTM5OTgsOCArNDA1MSw5IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0
X2Nvbm5kb25lX2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgIAkgKi8NCj4gICB9DQo+
ICAgDQo+IC1zdGF0aWMgdm9pZCBkd2MzX2dhZGdldF93YWtldXBfaW50ZXJydXB0KHN0cnVjdCBk
d2MzICpkd2MpDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF93YWtldXBfaW50ZXJydXB0KHN0
cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVkIGludCBldnRpbmZvKQ0KPiAgIHsNCj4gKwllbnVtIGR3
YzNfbGlua19zdGF0ZSBuZXh0ID0gZXZ0aW5mbyAmIERXQzNfTElOS19TVEFURV9NQVNLOw0KPiAg
IAkvKg0KPiAgIAkgKiBUT0RPIHRha2UgY29yZSBvdXQgb2YgbG93IHBvd2VyIG1vZGUgd2hlbiB0
aGF0J3MNCj4gICAJICogaW1wbGVtZW50ZWQuDQo+IEBAIC00MDEwLDYgKzQwNjQsOCBAQCBzdGF0
aWMgdm9pZCBkd2MzX2dhZGdldF93YWtldXBfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+
ICAgCQlkd2MtPmdhZGdldF9kcml2ZXItPnJlc3VtZShkd2MtPmdhZGdldCk7DQo+ICAgCQlzcGlu
X2xvY2soJmR3Yy0+bG9jayk7DQo+ICAgCX0NCj4gKw0KPiArCWR3Yy0+bGlua19zdGF0ZSA9IG5l
eHQ7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2xpbmtzdHNfY2hh
bmdlX2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjLA0KPiBAQCAtNDA5MSw2ICs0MTQ3LDEzIEBA
IHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2xpbmtzdHNfY2hhbmdlX2ludGVycnVwdChzdHJ1Y3Qg
ZHdjMyAqZHdjLA0KPiAgIAl9DQo+ICAgDQo+ICAgCXN3aXRjaCAobmV4dCkgew0KPiArCWNhc2Ug
RFdDM19MSU5LX1NUQVRFX1UwOg0KPiArCQlpZiAoZHdjLT5pc19nYWRnZXRfd2FrZXVwKSB7DQo+
ICsJCQlsaW5rc3RzX2NoYW5nZV9ldmVudHNfc2V0KGR3YywgZmFsc2UpOw0KPiArCQkJZHdjM19y
ZXN1bWVfZ2FkZ2V0KGR3Yyk7DQo+ICsJCQlkd2MtPmlzX2dhZGdldF93YWtldXAgPSBmYWxzZTsN
Cj4gKwkJfQ0KPiArCQlicmVhazsNCj4gICAJY2FzZSBEV0MzX0xJTktfU1RBVEVfVTE6DQo+ICAg
CQlpZiAoZHdjLT5zcGVlZCA9PSBVU0JfU1BFRURfU1VQRVIpDQo+ICAgCQkJZHdjM19zdXNwZW5k
X2dhZGdldChkd2MpOw0KPiBAQCAtNDE1OSw3ICs0MjIyLDcgQEAgc3RhdGljIHZvaWQgZHdjM19n
YWRnZXRfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MsDQo+ICAgCQlkd2MzX2dhZGdldF9jb25u
ZG9uZV9pbnRlcnJ1cHQoZHdjKTsNCj4gICAJCWJyZWFrOw0KPiAgIAljYXNlIERXQzNfREVWSUNF
X0VWRU5UX1dBS0VVUDoNCj4gLQkJZHdjM19nYWRnZXRfd2FrZXVwX2ludGVycnVwdChkd2MpOw0K
PiArCQlkd2MzX2dhZGdldF93YWtldXBfaW50ZXJydXB0KGR3YywgZXZlbnQtPmV2ZW50X2luZm8p
Ow0KPiAgIAkJYnJlYWs7DQo+ICAgCWNhc2UgRFdDM19ERVZJQ0VfRVZFTlRfSElCRVJfUkVROg0K
PiAgIAkJaWYgKGRldl9XQVJOX09OQ0UoZHdjLT5kZXYsICFkd2MtPmhhc19oaWJlcm5hdGlvbiwN
Cg0K
