Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A4956C5E3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGIB6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGIB6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:58:33 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456B6402;
        Fri,  8 Jul 2022 18:58:32 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9B7D345F9E;
        Sat,  9 Jul 2022 01:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657331912; bh=av97cRbZUXFAGjJn2n4ee34J0Qe2/hDH1RFVEegQacI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Cz9LBZ20Ym/tM3QRfmAWihvu6EeaQdWCyS7513zdTRbMe+7Ha7wC37/Bbjys67IQH
         KkgKocMyl0ZIYg/OHLz0GPiVfR5/HLpusVDdz6n4sTYMpd5CUew8ngQiGZOe+M1txW
         2QQ+fhDC0mNV7JNePp8AuE1HBKm+TLPniWBtr4PwkY+7vEevZ4YmQp8qm6ILHwlmcl
         UqkvmM0CcHLD31EvSiUEl7k2+PrqpxeJ1Afl+hPQtZeTrcOj86/F9ng/kNDEJxtrYN
         mkaCghoMuF7TPIndRshywjYBBkmNVYD2D2MdfYkFZcq2iS44CTNoRqTYiEOFHFpLHR
         jLCv+Ie61BNKg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DA8C5A0065;
        Sat,  9 Jul 2022 01:58:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C20F040087;
        Sat,  9 Jul 2022 01:58:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="QtmCYuPH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ginQTNWaBbbvN8MpKcZbPRokfKlHg14ae2PQaXUO7u/H26zLgz50u3RiX7axp1fxDI+/SqesAi6Uh6iW0TqrLU912mgtC21K7EgQof5SLUfkjNUc4H2x6MmsagE5M86CTdWRzg2fMg9tHWNXbTy6lr1XfDIwDTFP8SwLWvJaykQBXikGEpBQKbOfiv1d/jccScyKvZSkakUqCPyz0nxd6Gmzostxz6cGfJxGmjEg3AJ9PEFu1+gEOI9nxjB5+L7dYn0pvGbbpaeAxcmWmx0AAvhwtlctiwpSN6fiZDRQw2NqLexc3YzZVBu3Uax2wHTP3gyXYOvkLxIc9s49dq0tHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av97cRbZUXFAGjJn2n4ee34J0Qe2/hDH1RFVEegQacI=;
 b=dDQHBEJUK95bgml7e57Smcl09fS0ebBaU+pu+BkScNZ3ktJrE/E3U3GDy4rtjpyshiSb5JAShnFjyvk0GycuTc5KTE+M3SinWdIfaSx+X+i1xNGaVzRQZZotbHF+QVoDnb16acgF63l1TKN/GMwL20MQE2uoHPvq3Smej4RDat6BxEgwJwl3zN7JFvVP2R6md2qMZxEGVGsF75Ly2IBKfVRkoaPL/EQdsqdRMMgPTnOSsXkQpyOKgAbM4RhGBiSi48wT0IWJ4S+a/OvdULlhB4rFSgFVSuswEpZaP/b1kFaN9WlXk3k0Eo2X+CHoHa79dmOvujgAppm9CCJIXaokWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av97cRbZUXFAGjJn2n4ee34J0Qe2/hDH1RFVEegQacI=;
 b=QtmCYuPHMubt2Zux7It1A4sWbSfzwmSf3/SljGM04XtIS41bONGPToArH1KqDCBmdfBiQCDeyGc8du2Wu42I+8s92rqXiBCyrmDNH7NrHZZod9vORj9is3QvDRJId+wvo+UoJiY6cK/5F2Ft9j0ngK9ywd7oQDhNbAnatJpUGK8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Sat, 9 Jul
 2022 01:58:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5417.016; Sat, 9 Jul 2022
 01:58:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Topic: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Index: AQHYkvuyG8yeBB+HgESO8az/W4EWca11SMkA
Date:   Sat, 9 Jul 2022 01:58:27 +0000
Message-ID: <06498069-db45-202b-eba6-47bfa6948143@synopsys.com>
References: <20220708185007.21743-1-quic_wcheng@quicinc.com>
 <20220708185007.21743-5-quic_wcheng@quicinc.com>
In-Reply-To: <20220708185007.21743-5-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1811b9da-be12-4a20-e10b-08da614e83c1
x-ms-traffictypediagnostic: BYAPR12MB2760:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YRbmULjdEm32I8t3C+GfHrh8QrdEJPESfrDunYBhufx4ICOL0dfX1A/VVHfIlaAEIRUHClklNCwhArEHFt9+Q2rVQBT/fEEGpa+9DBoty+KEX8JsTiYTJA9dmJSliUNJwMemby7eBvjDIX9sfzusSIthT+ePIhQ5Yn8KyNcqQojlRduy7xokR454AWYERsAXHtTYvyf+0SBK177+IdnSE1YHaLeiDslP+M69CqHQu4CNf5uLDygzsuZWw4msPeTjOcHSQI2IW/tm4S7nimoirlCQT77gdoclyyWBCiwsuDYsZgdxm7pVEWVU/CcDf34k8LSmNnZQJisEIZjkIhNqxCEYbR4feeWwdS1Ul8V+enpey8PMDDyiwuRyfXa9uwreZlLyQTVcy0hZsuiWvl7hsP4ZANTLQSK8YcO1iu5d8PzsD0cG7JJga8kU8kDGqfZn/kIkbGezGNRPgcaIFLw9Z1xizcB9dQxnd3zMmKJxL0DyYqo7qcq8AXGNrqz3EaMnkt+BHMU+mm9zh3u4+wJQC38+hB6yZKfwwfGddFQ6J/nPS3p4e6BXGDDHRUc9riYaHi2dcX8Jqys09qyAukY5ksPW8se5v9iz8ybeuavLY3SUdSDefCLWBRK4z+QtcYGjOLA7eVzDyiqKUp3jpXp3IYkV5aT5MfEjKmLgk+F9n41k/CtcFRVwH1GnGI3BbifbPejeZ/xueGD0L7PObwgkGobZrOUGH7JwZvmBGfN36UyjbHIQsc5nGjY+zpqqcxEghwZyxsCUwxFBKA8yfBKMfF2l5jwOey0TZ+faeJQQACCqNOQ6SMYdPCg25Z9uUzHhwepboRBsUEX4TQB7sFZYX8WCAUqEACqd6z4KedALXuG/dAzsVyovCH3hlQYZE+P9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(39860400002)(136003)(5660300002)(38100700002)(6486002)(76116006)(478600001)(66446008)(71200400001)(41300700001)(36756003)(110136005)(31686004)(186003)(2616005)(6506007)(66556008)(2906002)(31696002)(316002)(8936002)(54906003)(38070700005)(26005)(86362001)(64756008)(122000001)(66946007)(66476007)(4326008)(8676002)(83380400001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGZzRURYbHNlYkFnQUdKRTJ2ckl1QkNhVUxPdENzZ0hKek40cC83bk00MzJY?=
 =?utf-8?B?YS9pcDdZc1JoR2RUMG9GY3RnK09ubnFzWVNSd1lTN0FhQU9oTGhuTFBPS0M3?=
 =?utf-8?B?U0x0YUp3TVV6OGFiVm5lSkVPMDJxQXVHdWFsZGxqK0I4bG96K09HendGOXZD?=
 =?utf-8?B?TXlNK2ZKNmJCRVdzZ3VLVFVBZHFRYk1iUWo2by9GUWZIVTFhYkdOQUVmcTQz?=
 =?utf-8?B?Q0NPNC8zTkw2REFoT1JwVU8xWlR5cTBVdHBsb2gweitxVXJRd0NEM0dDaFlm?=
 =?utf-8?B?ZDdZOEhxR2xvc3p6NWM2WWphd292Q0dhZFdBVmZad2lvdUM3aWlWZWM2NnBY?=
 =?utf-8?B?UktRMDRSL05KR29ncXkrKzZ4Qy8vZkdoTGU2ZVhJVzhmZDZtb1FPV2ZQR2tm?=
 =?utf-8?B?bUJkUlZzZmZvM2E0R2FXRHNNTWF0ZUoxZnIrdHJHdkMzVCtEMWVLdHdHbHcr?=
 =?utf-8?B?Wi9ZL1pIcmNHSEU4QzV3aTJhelNVbU55VDVGV01yRXZpRmhHbWFGTzdJTmUr?=
 =?utf-8?B?dnJwMkJrV1FEY2pSeHVnUXZuZEJxUUtmNzlsT2RXeWd1T2VMTHMrYWtMMjh5?=
 =?utf-8?B?VWdRL3RieGtnOFo3cWk2UG9lVnBSYWUvVDRrOHMzYzBSK1diT1YvejZiQW5Q?=
 =?utf-8?B?M1AwcStjVDF0TitSUmp6cUZFVy8rSlFXWSszMXVNWXBtcXQxSzZtN29mQjFH?=
 =?utf-8?B?RWM3cXYxSndYRjU1eHgxd1dJczljbnRvUlA1VlZVYU9mSmdFM3NhaGZhbEQ5?=
 =?utf-8?B?Z3JXS3Q1M2NWc3VmS0JVenlTRUQwUVIvNFZJWHRZYzZrbER1YVdMZEQwcXZF?=
 =?utf-8?B?SHluaUhSemJPSFJQMGs4YWNDaGkraGFxR3dtalJRM1NYSTUvbmxpTTNMb05O?=
 =?utf-8?B?NExIRytmYVhaNngvMndZdnJOeWdBT0dJRXVOTCtJVTJHZFdYeWRObWYvN3d5?=
 =?utf-8?B?RGJUMlhCeDBtY0VISlI0VEltd2VuN0dsbHRvbHlBNzhxU0ZrSU12eldyaEZl?=
 =?utf-8?B?cGhsdlh0SnRndExhdnppRnBrUm9hV01adWNYQkVPeWtZdXI5Q01mcDdsSGFy?=
 =?utf-8?B?Wk02a0Vnd2Nhbnl3M0JEK1VPVEtIRE1VNUxPYW1iSnFNMzVpTjM0RHVpOG9O?=
 =?utf-8?B?T3pnWFhXcFl6N0tKWEpzTG44R3hJYjUwVk5KdU5QUCs1R0cxTmNEYm0yakIr?=
 =?utf-8?B?RmVvL2RKOExNdytsSmkvY05wbHZmcnVUcksxY0g0aDRVWnFyWVBRNzVRSlg5?=
 =?utf-8?B?RnF2QjhPaDVNQWc5ZkpFSmsxV0d5MS9OR01CM3FhYSs1OG9YLy9NQitsRzBT?=
 =?utf-8?B?cm52ODRKaERKR3lIRktTYnVOQklnYjNiRWgwMDJjYjFneFhOdllJR2YyVHJ5?=
 =?utf-8?B?ZVFYdUtvWVV1ZmZ0Wll0NVpXWlhqeFVZWVUxZXhvSGg1c2U1ZHdvYS83R2JG?=
 =?utf-8?B?V2MzaWduNXpqaW1NeUJJNU1WR1pSZjBmT3JiVWdxN3hna01QNGpuNVMxaWxa?=
 =?utf-8?B?OFd4ck55bWZqVjg5eDZKeEFPaU5yQWZhVnJVKzgwencvRklNMlhRZFg1Tzlm?=
 =?utf-8?B?MkUzVFNGejlsaWVuazhRU0hIcjUyZ1hKZWhjZ2U5Tk5QempMZVVBZzRoVE1Y?=
 =?utf-8?B?Q0FyZmpnWVVhaVpDWVRYVDV4WlpXYjN5V2U1eFJVSDk4OTRiWmpmQ0R4VUNG?=
 =?utf-8?B?MGl0di9uNStkcnJ6a2V4bExUTnlJRVcvYnMxSTVPSmN0RUgzUy9ZOVE2c2ti?=
 =?utf-8?B?MzJVaURQQi83bnhDbVEyY1E1Qm1CMlZPaGdTc21JaDVuWmNLZTBZbFJkSVVF?=
 =?utf-8?B?TEc2R3N3Q3haUzNVSGh2K2VMckpKbEI0RzRsZit5NzByZnZWZENVdk9pQm5U?=
 =?utf-8?B?bXg1SW96RUpLelRtWmNqY0x3VWN5U3FOS0pIb1g5UmxVQVBENElwYUs2bmdx?=
 =?utf-8?B?NE42QmZWckdrQlQ1MWdRUjlYSkorRTdyNDJoaVlydGZzNmo3aTRyTm9wV29E?=
 =?utf-8?B?SzlsYWRqdythVU40UmFvUG51Wk5HNlZBVjk3bmNjTWF5cC9FdnpCcEtGZWpu?=
 =?utf-8?B?WEVqb3dPN0ZNaTlkczVBK01WbmlXTk1kTGp5MU1pWko5ekZQZlZlOVNoL0xs?=
 =?utf-8?Q?Ig0+ITPIeBM+8vHheI8E7QHln?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A8964348C1C4544A73BBAAC55948EC9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1811b9da-be12-4a20-e10b-08da614e83c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 01:58:27.1742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kT+dN5zqafjHZmSRDB/wZY11nmwF9gcaJuCU2HcDEMhXDst3JnP1AOgySWLCquiOmkmlSaF8QIDdAaRZE4RHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy84LzIwMjIsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSWYgc29mdCBkaXNjb25uZWN0IGlz
IGluIHByb2dyZXNzLCBhbGxvdyB0aGUgZW5keGZlciBjb21tYW5kIHRvIGJlIHNlbnQsDQo+IHdp
dGhvdXQgdGhpcywgdGhlcmUgaXMgYW4gaXNzdWUgd2hlcmUgdGhlIHN0b3AgYWN0aXZlIHRyYW5z
ZmVyIGNhbGwNCj4gKGR1cmluZyBwdWxsdXAgZGlzYWJsZSkgd291bGRuJ3QgYWN0dWFsbHkgaXNz
dWUgdGhlIGVuZHhmZXIgY29tbWFuZCwNCj4gd2hpbGUgY2xlYXJpbmcgdGhlIERFUCBmbGFnLg0K
Pg0KPiBJbiBhZGRpdGlvbiwgaWYgdGhlIERXQzNfRVBfREVMQVlfU1RPUCBmbGFnIHdhcyBzZXQg
YmVmb3JlIHNvZnQgZGlzY29ubmVjdA0KPiBzdGFydGVkIChpLmUuIGZyb20gdGhlIGRlcXVldWUg
cGF0aCksIGVuc3VyZSB0aGF0IHdoZW4gdGhlIEVQMCB0cmFuc2FjdGlvbg0KPiBjb21wbGV0ZXMg
ZHVyaW5nIHNvZnQgZGlzY29ubmVjdCwgdG8gaXNzdWUgdGhlIGVuZHhmZXIgd2l0aCB0aGUgZm9y
Y2UNCj4gcGFyYW1ldGVyIHNldCwgYXMgaXQgZG9lcyBub3QgZXhwZWN0IGEgY29tbWFuZCBjb21w
bGV0ZSBldmVudC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVu
Z0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8IDMg
Ky0tDQo+ICAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0NCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+IGlu
ZGV4IDUwNmVmNzE3ZmRjMC4uNTg1MWIwZTlkYjBhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAgLTI5MCw4
ICsyOTAsNyBAQCB2b2lkIGR3YzNfZXAwX291dF9zdGFydChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAg
IAkJaWYgKCEoZHdjM19lcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApKQ0KPiAgIAkJCWNv
bnRpbnVlOw0KPiAgIA0KPiAtCQlkd2MzX2VwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxBWV9TVE9Q
Ow0KPiAtCQlkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGR3YzNfZXAsIHRydWUsIHRydWUpOw0K
PiArCQlkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGR3YzNfZXAsIHRydWUsIGR3Yy0+Y29ubmVj
dGVkKTsNCj4gICAJfQ0KPiAgIH0NCj4gICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGJkNDA2MDhi
MTlkZi4uZmJhMjc5N2FkOWFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTM2OTYsOCArMzY5
NiwxMCBAQCB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRl
cCwgYm9vbCBmb3JjZSwNCj4gICAJaWYgKGRlcC0+bnVtYmVyIDw9IDEgJiYgZHdjLT5lcDBzdGF0
ZSAhPSBFUDBfREFUQV9QSEFTRSkNCj4gICAJCXJldHVybjsNCj4gICANCj4gKwlpZiAoaW50ZXJy
dXB0ICYmIChkZXAtPmZsYWdzICYgRFdDM19FUF9ERUxBWV9TVE9QKSkNCj4gKwkJcmV0dXJuOw0K
PiArDQo+ICAgCWlmICghKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQpIHx8
DQo+IC0JICAgIChkZXAtPmZsYWdzICYgRFdDM19FUF9ERUxBWV9TVE9QKSB8fA0KPiAgIAkgICAg
KGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HKSkNCj4gICAJCXJldHVy
bjsNCj4gICANCj4gQEAgLTM3NDQsNiArMzc0Niw3IEBAIHZvaWQgZHdjM19zdG9wX2FjdGl2ZV90
cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLA0KPiAgIAlfX2R3YzNfc3Rv
cF9hY3RpdmVfdHJhbnNmZXIoZGVwLCBmb3JjZSwgaW50ZXJydXB0KTsNCj4gICAJc3Bpbl9sb2Nr
KCZkd2MtPmxvY2spOw0KPiAgIA0KPiArCWRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfREVMQVlfU1RP
UDsNCg0KQ2FuIHdlIGNsZWFyIHRoaXMgZmxhZyBpbiBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNm
ZXIoKS4gSXQgc2hvdWxkIGFwcGx5IA0KaWYgRW5kIFRyYW5zZmVyIGNvbW1hbmQgd2FzIHNlbnQu
DQoNClRoYW5rcywNClRoaW5oDQoNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgZHdjM19j
bGVhcl9zdGFsbF9hbGxfZXAoc3RydWN0IGR3YzMgKmR3YykNCg0K
