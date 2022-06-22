Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B609555424C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357046AbiFVFcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiFVFct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:32:49 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0F36313;
        Tue, 21 Jun 2022 22:32:48 -0700 (PDT)
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D44F3466FA;
        Wed, 22 Jun 2022 05:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1655875968; bh=HP76/gSwnAkyFVl/uJx6bpzI2apXRTsx/O7pdev8eNE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dV8tfRvuGY2tLCEtLZZHJLWU12Xng7fwwhzebKmy5eiTtsICSYdozNpliyMkRqCAF
         ZE6/Ku4niRc0NC3iK5j3D+f33FTFLrpY80By5/vsMAzRQXdO+vPuCErKoKBQjVG9N0
         VLF2gg9sk0fNlfYOXr0azmGyU2NWG6i5+I+1B9ey4bhKfsmGGD94YWimnzI/Vo/3tV
         rx6dgK7x+Dt4FJTirhUG82fiFteCWN1jQMVMAVxhYm/hUnsiLTaXYjW9gTKo2vq40r
         4E8ILxMoNCl+mQbXSuC+ewThJLyYvsexHmfGAK+R7QIsaP3IF/DvE7voCXkXxZMEej
         sTfV4dKF6ZXTQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id ADE61A0087;
        Wed, 22 Jun 2022 05:32:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id F200B800BC;
        Wed, 22 Jun 2022 05:32:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HCtLDumY";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6wN8P6oCXGagh3M/qBgYKB0IgmLnaUwn/GYvCDtWBiVm5TCPNzOUd98ks7lh2mzbriioG7CoDPbiObGalnf6IW4v3PGFw51rJC4vHtuzGCyaHvdsHO2mSf/Wl2a+mx6wH7/ayhZUuv+ILprMTk1CvggGZGpulPgLIQEk/aqtbk45nl9J1HKX2JdFOdH73run6e8lnong2pOHW6RjaHsOB9lq3yWVpwbEZLanX79HR56+hLBRy8MtsAtAaTIoIWWO3N5aDjfxO+3cK7Yb0SQ72sAarVePCvmUlPwbqu6kp3cl9PEB0gAVGCx6pxMXvryiRhV8YXr9dur4m5wzFH/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP76/gSwnAkyFVl/uJx6bpzI2apXRTsx/O7pdev8eNE=;
 b=SDlKSj4Sqf9mXD4SfhXUY0HOkcC/MjYvUQG1u7sCq5bV4k5CQ7dYfbV5iMw6STdq2x+DCLyqtGwHsZkt8L5uDjau/r6R/L5mBjyzp/TPP8R6t45iVSH+DQNfMV+9mTjstxAadhfQ2sXgvGwOuXT3ibQbcEYLoy77/hrDpnpq3LipLwBS2PBwhZPuVyD7D0T+NhAvM8Mcq/WRqpojd7CWgXCkOYi02DlyGeifPzyEZFC+1imNOsD0xygTGdq8lzWrWMnGIV761GGoeM5BlUEERF/+K5WjxyxLtR5p8roWRjt9F2xwkbSQANXfQtrEn2SiOxl1mx6QwI+IOb9jcD/zGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP76/gSwnAkyFVl/uJx6bpzI2apXRTsx/O7pdev8eNE=;
 b=HCtLDumYtpfR0eJ/+cAfN9s3ymascKv5GmD7PQj3a+PcEbffM4f/1Zpn6ngTyQqgbGWp8W3a0pAeCZoH3FSAOTlUiKQp6hnlLQLT726CbFxGc32t9vkwXhC7xZrCwW7QVJDR+qX6D+z8vtAWrDiV9IVEov1CpHBQFtwDUK8F9lw=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by CY4PR12MB1126.namprd12.prod.outlook.com (2603:10b6:903:3d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 05:32:35 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::d935:48d3:b77b:b291]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::d935:48d3:b77b:b291%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 05:32:35 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>
Subject: Re: [PATCH v2 4/4] usb: dwc2: host: add TPL support
Thread-Topic: [PATCH v2 4/4] usb: dwc2: host: add TPL support
Thread-Index: AQHYhYMUH+NjAmwQ8Eu8XWG32NLgdK1a5+uA
Date:   Wed, 22 Jun 2022 05:32:34 +0000
Message-ID: <e465c321-1d92-9f93-4e89-d9dde472d2e9@synopsys.com>
References: <20220621152350.145745-1-fabrice.gasnier@foss.st.com>
 <20220621152350.145745-5-fabrice.gasnier@foss.st.com>
In-Reply-To: <20220621152350.145745-5-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0bf1e4a-db64-462c-30f6-08da54109c53
x-ms-traffictypediagnostic: CY4PR12MB1126:EE_
x-microsoft-antispam-prvs: <CY4PR12MB11265EF55CADF04963B9B437A7B29@CY4PR12MB1126.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNEYzZee6yhXT6TFDdYZAxkXENirgZDDIiW98nZ5xuQrQ+EtEVpu3DpnbOFk/kM9shKBayULkBiVRnsY3zYoyhat+Vl2L+PHugN/Bu9wtrbIuM55QZim0TmGeA3poswUfzA9Inp2SC2OQVfztyiXfYkZWqIgYVpQBUQuQGIZmZ+wymjgeURTVwTB7YBsy8dUCYjjYY5XSfEGmruL0FeBprwp3f+gC4ixlceP44vjdN4VCsb3ZXK6jEMxls9gcxTPrfiS0iUSEJaoRYJ/5PzPl0p9nNSdnRyNn/FIspVJyOtOo72Wzsz8ilTiRbZKLaIaQ2bacDNdtulczbMrogv/Q7WLWtsZ5yu6fJyDh7t/8x40WCELAP5e5ZWr2lByuQTPDuaC1sDbY6E1hswWHBwe/m3Mk80hMYhcdILQ2nGVTSQ1XzBDdKCzl7kiO54JxGsX+GoCX427liLr7m0qSOn4/IYow5jdjylTcblfA7gigpf1TgylWZpmLUjuMmXr3E0rJbW13QaBzcYxfmIiVcqEWvd/HN+/tUT/hHvu5WeMogH8nN2gTl79UQyKTdHr0fU3YMj3nvmfxoZTHaHXCTQQyOOhx7OVYBodz+4VUuu1p9sd6m0/wPZmHoICRQ5Lpniy8viQoVn0Aw+iwqasM7FomgRxkHHWSietLGDqL32/VpRKR45uZzLFc5Q8GYyvrXhEy1TTmuaBW4cuESnczydijYPkD3gXLjJ8zP5Ni1SB3TgmXvbApRSCvVV4QBrvXOykMAqfzF/cmZY0N6u3K31nSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(39860400002)(396003)(136003)(38070700005)(186003)(83380400001)(71200400001)(122000001)(2616005)(5660300002)(8936002)(7416002)(4326008)(31686004)(36756003)(2906002)(54906003)(110136005)(66556008)(478600001)(66446008)(66946007)(8676002)(76116006)(66476007)(64756008)(91956017)(6512007)(316002)(41300700001)(26005)(53546011)(6506007)(38100700002)(31696002)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWhsZVM5Qkd4UnJwekd1KzE2UGowdHMzMlhMOGFlOXVPTC9HYmZiV3NrbUsv?=
 =?utf-8?B?ZGZNanNaZTZVaTIzeXJWM2RXQm83aU9jZ2ZQQnlsNWR0THB0dlNJYnlxWnp6?=
 =?utf-8?B?RndiNVl1em1DOS9kYWE5ZjloL3ZWSG5FS05RM3pYQTZVcWd1enJjOWRNakI4?=
 =?utf-8?B?ZWEyV2Q4cnBnUEd1MXp5Q0V1Q2VKS0ZkQ2dPZUc3UU5nWWcvckd6bUF4RmZO?=
 =?utf-8?B?OFN0MUpGQVVZcStmUE01M2d1RGNlOWFsMGFESzVsS20vZmlHd3JranBzVEln?=
 =?utf-8?B?QXdnNnhLNlNJSWlUNlcyNzRrcGVHSStXcVh3UVdhRzU4Q3k5YkpuNXBHNk8r?=
 =?utf-8?B?NlhaRTZBRWlOSDhDRGh2OWRNdk0yWmkvNGFZZzVrQmFiRU10THZhbC9DKzlS?=
 =?utf-8?B?cE0yQzRIOHlxZEFnRzBBVzBqNWhobkhjTWZJNTRoTWw5ZjZHOTkxNkVhOHpk?=
 =?utf-8?B?UFJWSXNqa0owMjhORkFjUjVrZWsyR1FLajVLWWlDQVdyVUVraEx4V0pPS0FQ?=
 =?utf-8?B?VmZXNFlPdTlrU2JnM0lKUkR0eFZjT1VBY21Ub0N5bHJ5MjJKU3BJT1I3cEZK?=
 =?utf-8?B?c0NROVU5T25tekV0Qk9GZWZWOFRBMGx5ZjVOZXA5QXgrZnNzemlZZDZWRWxJ?=
 =?utf-8?B?MU5sYzYvcDFQVE5md0dyM0VqTk5lczdwWTByVkNjTk1HYjJZRHJIVjZKY2hK?=
 =?utf-8?B?QnMySCtZeGhwem91bkxWRENpbytSSGRzY1NqZEg5aXgzaWNiRWhsSXlNM3NE?=
 =?utf-8?B?ejBJejRKVFo2MURiV0RoQ2V0c0piME5kSFdXWnRvZ3VjSmhoQjIrZXBPWEIx?=
 =?utf-8?B?T1FVUVdSUEczeG5UWENOQWo5ejUwK2JjbU50dktMdjQxYlBMSmpMUHVrYTds?=
 =?utf-8?B?bUk5c3FvVXJ6Z0tlSlR3RS90UHl6N2V1a0x6a2p6dWhtL2lUN2l6QzlJYjQw?=
 =?utf-8?B?ZEdDclFrS0pKdDk1K2Q5eEdWV1NkWlFNMHpmZUg1L1hqbjFyRWM3bitOTXJR?=
 =?utf-8?B?bVVkaGRDcDVEOWV3OTNJTVVVRXBYa25aTVRYdVdpSjJ5N3NOcFl4NnlwTnJs?=
 =?utf-8?B?Uk1ENjlTTGpzNEdobDd1UDZhYW1WVk5SK2dvVlgyUURXenBIa0dMR3F1YkpD?=
 =?utf-8?B?QWIyUEhrRU5aeGp2ODg3UitWNE5raWtEbEFaVVdibmJSU1NVMXBTbEFES2hs?=
 =?utf-8?B?bmVVZ1pHSzFKSVA3K0xBd2FvNTVWbDNYdVlLKzk1a0tCbHNZY1VaZUdZdWk3?=
 =?utf-8?B?eEhOQ3A3RUNHYVhzS3JjRlhPWVgyaURrZU5IU2ZVYk5MYkVQWnZPaVFIandB?=
 =?utf-8?B?VktId05wUEdNNWJ2ZFh1SFlBVE4zTkNISlBBbXZoSU5sU3A5akFBL09kL1dl?=
 =?utf-8?B?OUZGSXZ1N2pWaEZ6VzQ4M3ArL21vVThPd0RmR2p5V29aT3JzRERLNDdESytl?=
 =?utf-8?B?NXdKN3FQK05jQzNEOG5ZTGI5dGJTWXNNYlVRYnFBMTQvdjJ4UmJIK3VJeVlQ?=
 =?utf-8?B?RW1oYVM1YkpiOEJ1Y1Y4am8wMVJMNmRyNmN6VlpnV3lDQ3ZidldlQ2R4Z2Vt?=
 =?utf-8?B?WlNLeVJNcUpDTisyS3VkWmFWMEpXaGs0dDZuSzl4SkE5Zm05VFNwMGFxeHJP?=
 =?utf-8?B?ZUpmZGEyVytoejViYjlHWFg2MVNkQUdqYnQ3RFd0elhDeElLU2N4ZDVFR00v?=
 =?utf-8?B?RTV1dTlCbGlkaGp3bjhreG16dWVpYWk0a2hLZUVnWXE2eG5rVjcvaGF3emRS?=
 =?utf-8?B?akt1dVlXby9pU20rZHhnRk52S3BqR0tieXBpVFFGclVpWUZXejN3OVlrbkg0?=
 =?utf-8?B?alo1dHlhNFF6NFVSbXRXbzBjMEk0cEswdUpxOGl0TlZHdEpCaVFPaW5hcndM?=
 =?utf-8?B?NlY3TzJPZHRZTWswQnF3Sm1yb0UzQnV6ZDZFbmpFZTFrVTZ6STdya3RJS1dF?=
 =?utf-8?B?VTdlcHVNTGZUNW9CdUxBWHdoNmxUbFJxak12U1R0WGRhWWpaMlYyMFIvN2tF?=
 =?utf-8?B?Tkx2MDZNZWxPVXB2ZTI5Y1NBc1B5djBtYWNYem1wVEdSTUdIZVZ3RnJpTGtJ?=
 =?utf-8?B?M3Q2b2U5dzV2QUt2d0R2TlhZRG5OMkFwSW04QzNUcXREc2JlSklIRFpqaGFM?=
 =?utf-8?B?S3JrQ0ZWRHRRUXJaa3h3bEU4Wk9oYjd3SEtJNE1TbExkUHpzUzNRT05IQ0cx?=
 =?utf-8?B?MUJFdGFVQzI0ZVlnVk9FTDFTNmRMenBCcFdOQmhoRnRzZXEvNmx6eWsxOXRs?=
 =?utf-8?B?WWc5cFF2QnNKK2FHMWNTMVlzeWI1SDhUS2xWY2M5UEZBcFYvak1nbTZPSzhB?=
 =?utf-8?B?azc1SUFpNUJndmtuQkx0eStZalkwRDNFQ0s0MjQ0N0pxQ05KSXcwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F66081E342140246B1BDCDA1962F5E0E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bf1e4a-db64-462c-30f6-08da54109c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 05:32:34.4629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSeLM9UfxX3J2uefWm72GX1ZPr1F2JtDFNQ53lSH4AuXtJvQF9E0oLTJmbgJ/RkFRtSygmAJt6+vDH2UYBRORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMS8yMDIyIDc6MjMgUE0sIEZhYnJpY2UgR2FzbmllciB3cm90ZToNCj4gRnJvbTogQW1l
bGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVuYXlAZm9zcy5zdC5jb20+DQo+IA0KPiBUaGUgVGFy
Z2V0IFBlcmlwaGVyYWwgTGlzdCAoVFBMKSBpcyB1c2VkIHRvIGlkZW50aWZ5IHRhcmdldGVkIGRl
dmljZXMNCj4gZHVyaW5nIEVtYmVkZGVkIEhvc3QgY29tcGxpYW5jZSB0ZXN0aW5nLiBUaGUgdXNl
ciBjYW4gYWRkICJ0cGwtc3VwcG9ydCINCj4gaW4gdGhlIGRldmljZSB0cmVlIHRvIGVuYWJsZSBp
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFtZWxpZSBEZWxhdW5heSA8YW1lbGllLmRlbGF1bmF5
QGZvc3Muc3QuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaWNlIEdhc25pZXIgPGZhYnJpY2Uu
Z2FzbmllckBmb3NzLnN0LmNvbT4NCg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxobWlu
YXNAc3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIGFkZGVkIGR0
LWJpbmRpbmdzIHByZWN1cnNvciBwYXRjaA0KPiAtIHVwZGF0ZSBjb21taXQgbWVzc2FnZSB0byBj
bGFyaWZ5IFRQTCBhbmQgRUggbWVhbmluZw0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL2hj
ZC5jIHwgMyArKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNk
LmMNCj4gaW5kZXggZjYzYTI3ZDExZmFjOC4uNDU2N2YzYzI0ZDIyNSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+
IEBAIC01Miw2ICs1Miw3IEBADQo+ICAgDQo+ICAgI2luY2x1ZGUgPGxpbnV4L3VzYi9oY2QuaD4N
Cj4gICAjaW5jbHVkZSA8bGludXgvdXNiL2NoMTEuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC91c2Iv
b2YuaD4NCj4gICANCj4gICAjaW5jbHVkZSAiY29yZS5oIg0KPiAgICNpbmNsdWRlICJoY2QuaCIN
Cj4gQEAgLTUzMzksNiArNTM0MCw4IEBAIGludCBkd2MyX2hjZF9pbml0KHN0cnVjdCBkd2MyX2hz
b3RnICpoc290ZykNCj4gICAJLyogRG9uJ3Qgc3VwcG9ydCBTRyBsaXN0IGF0IHRoaXMgcG9pbnQg
Ki8NCj4gICAJaGNkLT5zZWxmLnNnX3RhYmxlc2l6ZSA9IDA7DQo+ICAgDQo+ICsJaGNkLT50cGxf
c3VwcG9ydCA9IG9mX3VzYl9ob3N0X3RwbF9zdXBwb3J0KGhzb3RnLT5kZXYtPm9mX25vZGUpOw0K
PiArDQo+ICAgCWlmICghSVNfRVJSX09SX05VTEwoaHNvdGctPnVwaHkpKQ0KPiAgIAkJb3RnX3Nl
dF9ob3N0KGhzb3RnLT51cGh5LT5vdGcsICZoY2QtPnNlbGYpOw0KPiAgIA0KDQo=
