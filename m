Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140995A78B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiHaIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHaIPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:15:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146973331
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661933738; x=1693469738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qqd+8jis71+UYVRZKvYxGq+9xGr92jvyukBP9OXk8pM=;
  b=ju6Bxp4pame1NicWclvnGdKZam/SsgiG0rfuzLNVLM8V6Ob8ygW2dOFt
   1k7y7vQds/RsqsDlEovuTut6Z50qZs0YVfq27VOa8e/vCuUvjKu4lDJS9
   TwMIwqM1VNL5+uKBMxaPJHG6sO3J79hxEPl6Rw5a2/1VrCmEY8L0hHaJ/
   dSpiGOiPtXDTHTI1/wYy5z5SjmlZEqe97uNcWI8X2tGnkTISlLutdhWVz
   8RWLP+JAcThPLfeGJcmdIuNSLgtIPrFBIzLa3FikYjMc9VFVoWzXXnLBB
   uNCsKlX4Ykk/j5lWNan9bVpD5H5ym5geO/NsAv7ifWMp3U/EKv6NvQw9l
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="171734325"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 01:15:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 01:15:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 01:15:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/qXXPJYsyrvq7AjoKRq53MlCNl34IFDfJFjy+MyfJv6+Tm4DVjLb1FQf3gvPPMb2xriIZK9bZ8WQAtTst5wLe/bNVLj/39u3bSQM0fJsil+unPtfgaYxH4NfOalJrCtBMjxi7yH7i4Z4m1obqjCiF1pczdHHhxHUzkZ3cd2yYSu5dZL5daga/1DmrfCRXUljPuU+t9RuNbEaYDK8J1KLAAuJeLt+D9E+pGgk6d0api1yRht6ZU2V1BJlIOhWlHTpoHl2lIP4TLi+ncwck7ED8Sr8zmiXZ+klgQXkCKBVO909QLmW+WkbmAgMEGEH1c+AnGDMhFtNgUsJQZGiZvT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qqd+8jis71+UYVRZKvYxGq+9xGr92jvyukBP9OXk8pM=;
 b=N9ZmA2UkpPcARWqYfSDIEsGXKS2vlDa5u05wc3+xMw+IzilCZc3lClxRAav7QMe6KcKRDo0oFSsN4P9TmS4fwSq7xq14Vh1q58YfPhc1+A/pd20LV8BRYABJW+c8U1uEIE9JPWAbhshVnd0RbuCO4Mf6D93G6hHtRoPqp/sm7PVLR388nTqiaZ+YxBafjzUGfLGb2eTXrOJLN/UQYFm0MY0OmL+PaIjg3g5iwgBFjYLPJSpc5cTMyQi2wOPbhvDNuATAHd9AUwT2nSkyeDZT79xjH26DphEffNcgvx8tecQGB7Hi8EANd20AfTMm/Ge6ZLiszUZy6XVbrbx2rzFIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qqd+8jis71+UYVRZKvYxGq+9xGr92jvyukBP9OXk8pM=;
 b=OZfCHuk6hyieaCIGfhcCKpmb1hZVasGeCE1r9Q1WT+WApK9w72csBTx4Hwa+qrEzOHp4aKhSJHO8TdXU+2OibopgNBViWLRGe/MNmfecmQaEXpsxR++RMR83/qd67xmOER9XJMpkDVhMYV5XBJabNspJnwK2CoN2N0biV7jJ2DY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB2677.namprd11.prod.outlook.com (2603:10b6:a02:cd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 31 Aug
 2022 08:15:31 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 08:15:31 +0000
From:   <Conor.Dooley@microchip.com>
To:     <chenguokai17@mails.ucas.ac.cn>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liaochang1@huawei.com>
Subject: Re: [PATCH] arch/riscv: kprobes: implement optprobes
Thread-Topic: [PATCH] arch/riscv: kprobes: implement optprobes
Thread-Index: AQHYvO/eaHU6+YdQhkeJ6FHUUeiIQa3Im1yAgAAG0ACAAAeMAA==
Date:   Wed, 31 Aug 2022 08:15:31 +0000
Message-ID: <999df577-48bd-6ffb-a868-cad8ba4615a1@microchip.com>
References: <20220831041014.1295054-1-chenguokai17@mails.ucas.ac.cn>
 <882e9efc-7222-c3af-e37b-f339789e94c0@microchip.com>
 <DC2CEC17-4895-4060-B64A-7A444633F5F1@mails.ucas.ac.cn>
In-Reply-To: <DC2CEC17-4895-4060-B64A-7A444633F5F1@mails.ucas.ac.cn>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbc60cc2-0a6d-4d0d-cb0b-08da8b28f8c1
x-ms-traffictypediagnostic: BYAPR11MB2677:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6zffc9CQvcDj+Qo/DYUXH8ye0tyOQraz5CBgNB8HoLI+VeDjNtXhDSirT1YvPtaEcrFXYKpKdtcXPWCO5xvjDWRjIfE1dGjAEcO9hbDc1PeUgZ1ANTistDVJ3TR3ShI3xehS72m6B4O8mMALNMTlXln3xQUEyM6G5iLCtxa7uUp4ype0BlCiUkyfLAX1WR7uCJgpM0abWjOiY8io6FeGHTlM3IyaTDnaJyZlP3pj5Z3yTakwLsQlpAbuh4wO5O1A/IMGPbF02d49dO/nQc5xPIg83A8GhLV7zHZBrKgIxrwjDGnH0dlXXyC0enWhLzAdrhvEEm9rODl6sktbe/SgPVYwpyfmONmzDxH5GedwAJHwFIy8Zi7EuVwtw8jgWn9IS0Tz1FYyHHUxytA5JryU7O2hHsAdvxavYhbl735TCZBPOIIPmUFnkND+KK/Zs5cEfjSZ8OitiIi1F2k4HmSOu9eD+1KzMg5bSYMjULFvLLQkADVCP3kPVxIcSbezGv0HrCHhfIcun6HF9UytPIczoKCpH9iBtASWpjxAHLrUmod+u85qDBNbuem0wMY3myML8NZZthjQF+kO9GRky5jiSWot0xnMMXlnsRXfVi3WT4vzkyyxBZRvxKNpumyFi1RHmQlUIOCmdMTdxoq/wpsXLaHd1vSWdoL52eNiPHh2CwZ/AAsIy3fLtbN3sLea7b9W2bAae3ejHTi3zx+oaq3JARhN2lwFkX5JI60Ag7DRkgNGct6siBo+Kv2VC6F8idWvMQIzBDPQU9P8VhBVgVOXWcdgTLYQ3yj+oa4HuPg7d9ro6GPc2LfutsY+G2yb2x2+ZGwmhHiKKSaCl+SmvkmcdxSCO0AEPLPcFoY2A6+JpKbMNV9XTL6aiAIAsTKLIzu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(136003)(346002)(396003)(6506007)(53546011)(26005)(71200400001)(6486002)(478600001)(186003)(41300700001)(54906003)(6916009)(2616005)(2906002)(66476007)(8936002)(4744005)(5660300002)(316002)(6512007)(64756008)(4326008)(66446008)(66946007)(66556008)(76116006)(8676002)(7416002)(91956017)(38070700005)(86362001)(31696002)(36756003)(122000001)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckxTZWlUUXV2OGZ5Z0p3cGZVNGtkOFhxcVhhY21aY1QvaDJKdmMyVVMrNUQ4?=
 =?utf-8?B?b3FsMjZiT2JnZktraTc0a0M4UHNCYnZlK3lVcDMzbkZFcTk4b3hUTHZuOHc2?=
 =?utf-8?B?bEc2eE9kQkpXenBDNmZBbzhreG12bDVVS1BxK25YSC92N1B6L2lOVkliVnhK?=
 =?utf-8?B?SCtoaUVMdDhoVVJ6REI3emdjMjByME5BM1pjTC82S1N1TlhDUEpvd1IwY1Za?=
 =?utf-8?B?OHNSQU14Q2JYTWM4MUIzRXFiNFc0VDcxNjdrdUh3b0NNc1BZRFJWY0kwdk14?=
 =?utf-8?B?cTM1c3VDa1I4Q2srb2JUSnQ4cTBReS9nS0Q4Rmxwa29EWVIxaThWUU0vR1h1?=
 =?utf-8?B?amc2VFUvZDM1eHlwV3Z3aXJWeTdHNkljQUYxZGZTZVhRMlFiR2oxOVRkOFNQ?=
 =?utf-8?B?UzhENGlUWVcwZlFrQVFuNWQ3dHBnNVpFRTZMbnBIdi80cVRDd2xVeDZZU0Q2?=
 =?utf-8?B?QlUvTlF6NnNyRTFEMS9RZUtUNGNqcmV6VHk3ME5tVkgvQnBRSnk5aW9OOUhR?=
 =?utf-8?B?UXdBNVBPVFkwOHJ2S1Q2Zjl4Z3czcnRiRE1LaUtXZTRiZGw3UFF5cGo2bTRj?=
 =?utf-8?B?UU5ZMXplYXozQ2NDSTV0RmI2dlJSZ2k1ejJmdG45bW1PZyt5bWJhMzhTY0Va?=
 =?utf-8?B?ZWlpajFPQ005MkdpSEg0R0RjOG1EZk1WSUFRdDVZZE1RN2l4WUNaUVFpZm4y?=
 =?utf-8?B?dksrUitwMWgxcjFqa1lCUFBLaHF1Qm1HQzZSNU9nekpBeG9uY1VNczFqck5K?=
 =?utf-8?B?QmhKT2NCSzZnVlpZYys3aVRIanVuUTVLSGpyZi9FZlY0ZjZlUzF5L3NBR3Ja?=
 =?utf-8?B?Y1gxdFF2RTl0Q3JxcjJ1QldTYWNtZ3diSHV4ZFYwd0ZhY0xEdWRwcWJ1WE5l?=
 =?utf-8?B?RjNkdmhVOWQwM2pXK0JuNHAwOGhGajR5Nm91WXplaVRPLzVucFArUzlUZkdH?=
 =?utf-8?B?RkQ4MjJhZTdCdDZQV1IyaFhqSTROa1dFKzc0Z2d1cjJwVmNPMXUzSWo3VXpm?=
 =?utf-8?B?RnpIOFpKK2JUeGdNSGw1Vzl4VFRmMWYybDIyQVBPQkt6SjZSbUlGVUhaOGFv?=
 =?utf-8?B?ZVYwWE5UVEYrd0FhMnNhVHdLL0hNMjhPRURjRmJTT0owRFIvNEdJbjJrcUh4?=
 =?utf-8?B?V3M4TzBPYTdPSzlUbFQ1U3c3d21XRFArZHNFbFN0MUFoUEZaVHdacVZrSVdi?=
 =?utf-8?B?bFlGZlFmM2dDMVdwbkNPYk8xOUJvY3k3RmxyRFV0ZW8rN3FibEtYN3ZoYzFT?=
 =?utf-8?B?d0IrTU0wNjBDalViK1I0N1U3allnWnFhRjFPTEJkdU4vV3cxbHdwT2hEMXJK?=
 =?utf-8?B?L2lNUEs0bmVzalgxTW9mQVlvbDZHTjNac0tWVmlFeHc5NHFxYlBzVUUvbS9E?=
 =?utf-8?B?MWtaOS9DOHZNZWJ5QnhIdENqSDlqd0lhZUtGWHdGbDRRTTd3djRLaEFKZWc5?=
 =?utf-8?B?dWEyUkhYa2J4NDFaOVVVSVhSdEpzUHllWWtwNitEQjFHVkhkMmV0cWpqV21P?=
 =?utf-8?B?aXE3UDUwb0VZeUZtRkdaRFBsall6K3JGZnlSMWJtTFpOZDVMSHRtWGxEWitt?=
 =?utf-8?B?UWNDeHR6TGdUOWVmMkVvUGFla2d0WnphMWRtdFBrOEs0Tlo2Tk81MHQyYW1L?=
 =?utf-8?B?SXZHVkpLdCs5aERETnVabDM3TWJNeVFTemxEc1U3TTk3bnRQMzFzWVdDVHE1?=
 =?utf-8?B?L1d2WTNVMDNFQ3Q0TFlIb1FSc2F4RDJmYVp5cCtKR0s5UHdvUm1NTEpabXpz?=
 =?utf-8?B?N3N6TXF3RnhqK3kyTjF4bUdHT2grN1pWdGEvNkY4QWRGUXdJeW1LN2JqeU1P?=
 =?utf-8?B?YTFyZ0tHVlBYeWdGM1lTNDFJelIzRWdSaHNPL1p5RFU2WFhPSmhDaXk3eFV6?=
 =?utf-8?B?UXdITmVqZWRkRjVRejRsZC9JbTk1Sjh6VzR5cjZ3RW9NRGNrQXpkcUNlRkZE?=
 =?utf-8?B?OFQrYjlnYzdBR21CUjlLOWJOcU5BZFYrdXpMZ2Nuc0d2Nys3d1Q1YUpVWm40?=
 =?utf-8?B?cEJYMEJaNzE1ekE1NCtYaHRYVEUwSnI0QUp3QnV3WmhVRU80SGVoUk9HSGsy?=
 =?utf-8?B?cjBoajhDNTRwcXJua1N6WExJYUx6aHd4RUR1cGloU0VxTkpGd3FLS0xzQ3A0?=
 =?utf-8?Q?hfNhEMX3Yw05ye0onPkmU1U4m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F4B68F8218B6543A4DCD8AE3BA768CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc60cc2-0a6d-4d0d-cb0b-08da8b28f8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 08:15:31.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7QCP56pmqtmY3lyhMNiScINDGjFrwqkOsI1ty+xiH1kvUHcziRudkmASLqCLHQsB1cCh/8T4EbRR7pxyNDxtQuiXMESC5rIKqrysRCMc1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2677
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEvMDgvMjAyMiAwODo0OCwgWGltIHdyb3RlOg0KDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZQ0KPiBIaSBDb25vciwNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciByZXZpZXch
IEkgd2lsbCBjb3JyZWN0IGFkZHJlc3NlZCBpc3N1ZXMgaW4gdGhlIG5leHQgdmVyc2lvbi4gSSBo
YXZlIHNvbWUgZXhwbGFuYXRpb25zIGZvciBvdGhlcnMuDQoNCkZZSSwgdGhpcyBtYWlsIGFycml2
ZWQgYXMgaHRtbCBzbyB3aWxsIG5vdCBnZXQgcHJvY2Vzc2VkIGJ5IHRoZQ0KbWFpbGluZyBsaXN0
cy4NCg0K
