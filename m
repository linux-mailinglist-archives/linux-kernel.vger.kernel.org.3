Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E542D4D7048
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiCLSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCLSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:06:48 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06467093D;
        Sat, 12 Mar 2022 10:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647108341; x=1647713141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V06D3fsAdX2WKmWkWr30VaQexd54eHNp9s017GAROM4=;
  b=LYoqB1FXUMEYD1Zb4DjYjmhhZNcwbYzJm5HiRTtLqnrOrHCxiOgjkAZ6
   6boDKke1wty0pzamZXuH/NukKRHMV0B1zUbVl9vgvHu29+Ov3ayhD3HE6
   SCDvDDlMmWMX0Fxa6XvInp+crpUOgRDqs9EKtfjDYXqh9USKYjwhF2Fq3
   U=;
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 18:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jjm+TL683ajptZVZo1h/l9PhKJPPhmCro2xz4yQIRPtVF1YdJRLoSDdN4znquLlxwHGuWBpLPplmEqXcmcywFnjJTGKkmEyYECvpPkdcwn2LggKFdn2Dxk4gK9jAmNqhcnCSwuSUYZS7BP8yF4aliiFxvJ9WZ1I016PQ1LzeTWzZ7YdIY/d6cM9n9r3mJSgLbLmozlrXawnff0ILHmVYE85JsntXR7tbAc4aF9qx1us5lGoJdaQa2VfbaByUU84WSz1M/lexiOnJWD2h+lFD00Fe8c3zrm2fVFmvMDJhGETRcubXLs6MAtaqUr/ewiS5NHlceE8XlFOS7mdxiGldvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V06D3fsAdX2WKmWkWr30VaQexd54eHNp9s017GAROM4=;
 b=IPvwHiCZBOnAvU9ptEeQvvIcqwMJV+Or2FWOL6Mv4tQiN4nuET9JzqULI/mWEZgRl6oHba2Qv/u1VATL0kq1UtO+iGeZkV5IvgtghowebOfjpsXdGoqTXGhpTMA2hSCHXGSxxaLm2OAcxmF91q+swn/WHgh9DdTpRn4/d9krQ+7G1JVzYEwsVAxZt1eZtRgszTQvom8AsGp4gvXGMqB++PUbbIXfZq2ounXRd+9d55qE7sw7XqFCaNrz2D+Z4tW8IkTEs2E3GjHAgrMx1pKOZj5xMKXMYSgOOff8bnQICIEtlcRBIpapXiQhOgJVRGwbwn6zTCnLhNwx+MEQmaUWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by DM6PR02MB5257.namprd02.prod.outlook.com (2603:10b6:5:48::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Sat, 12 Mar
 2022 18:05:18 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%7]) with mapi id 15.20.5061.026; Sat, 12 Mar 2022
 18:05:18 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "Asutosh Das (asd)" <asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Veerabhadrarao Badiganti (QUIC)" <quic_vbadigan@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        quic_nguyenb <quic_nguyenb@quicinc.com>
Subject: RE: [PATCH V4 3/7] mmc: debugfs: Add debug fs entry for mmc driver
Thread-Topic: [PATCH V4 3/7] mmc: debugfs: Add debug fs entry for mmc driver
Thread-Index: AQHYLjYMGTMBJkJI00OI74Pqo/S1i6y1RzAAgAbT1ZA=
Date:   Sat, 12 Mar 2022 18:05:17 +0000
Message-ID: <SJ0PR02MB844982C750EBCB47410C343DCD0D9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1646226227-32429-4-git-send-email-quic_c_sbhanu@quicinc.com>
 <29a1a50c-bb65-25a4-b09e-7a869490231e@intel.com>
In-Reply-To: <29a1a50c-bb65-25a4-b09e-7a869490231e@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e98cf9fc-b105-4cdc-ae45-08da0452ddbd
x-ms-traffictypediagnostic: DM6PR02MB5257:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB5257CF37AD1CED5DEF3952DEB10D9@DM6PR02MB5257.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Djadl/AaI+CUjjoJbYjVhy8gz4qR74IWPxw/QcdWZNrPlRhpXbWai5OB9SX5t23zwjTu2gae8sm5Ry6ImrX+qt+3u3f2T7luwuu2dVZo4DVgCwQn1l5LXph4akVZuU47e6FbFY/6bpc6pMfS84b/vjRs+OR3pMZoGk6dKywOLWnSr9mI0PkZtpgy9E9Dfh8OscWIqR8y0cTSZFx8vFy3QhBEMLiQi+QkIdldIX24RZhcZZN3IBfT8TWoez3RyGDsLhwpHnXNggAhRVwwk5TbwrUb2WtML0hVpkMAXyiS7IGgnfT9NcCx65yInwoV51rO4f5RaV7Rvo9uF9ZKLvoeY42jQpjPyxpv5UOsGlfMUN2qrKqZ22YmG3Qw6oZXEFPMFfmugGfQN1J5tcrDAPhcapk5CxIXSpRl5DBN42ykCY1qExgiE6AFcFiCxgi9HXB4UB4sjWUcVcSVRtLvFdEw3b0lqm32PCnSpuwmDwENewgTS9KS6VraCRqrLmDbwVJ0NgmwefgqLe3Kcgbd2gITdbCuAAKHG1MbUBWmvvASUekbjsFFIYJ6gz6f2F42/zHUU4AMnhFuk30Gdl2Sm3zI+hJ2dQcjXMQGwUSmH61XImMFYwqnlz2fIJHWWTfLLQCufhHnW4h5tHgRp8HU/SZgmnTR5EE0nDXxGyWZlTyZGcVESQfR0mq7EHgMgqLro/ASCMW5l0p/ZHkYhQ1+jI8Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(55016003)(38070700005)(186003)(76116006)(110136005)(54906003)(4326008)(86362001)(107886003)(122000001)(5660300002)(6506007)(8676002)(66946007)(53546011)(83380400001)(38100700002)(7696005)(26005)(33656002)(8936002)(508600001)(66556008)(66476007)(66446008)(2906002)(71200400001)(316002)(52536014)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWtVckhUVjFtS1h4VGljNi9kc2xUeENadDZURGNSdFRYYysvQ0g4dFhQL0VM?=
 =?utf-8?B?NzJaRDlBd2V0VVprbnp5d1NQQkM0SktUQnZQVm51dktINDZGSzBaZTZRYjFS?=
 =?utf-8?B?eVVzSWlZMVRmQ2o3dFJWY2Npbm5hL2ZLOHhCZUdYVG5XRW1xalYxTGg5QUdq?=
 =?utf-8?B?RjMwUjdZc3ZuUk41cWljeCtuRU05d1h2YTlyUzBZdlZ6dlV0by9GVkthd0dF?=
 =?utf-8?B?SGtvSm5JVVpIbDFSZW9GUU9XNGlTUFBkeGVUUDVBb3FGbzVQWk9pandEZW51?=
 =?utf-8?B?NzdvOXZoRlFadXJNc2NUUzJsbXFGaDUraVN4eDRsTWpLaG55YU1rbGhMY2JY?=
 =?utf-8?B?b3doUE94RDllNDFDa0xocTNGQllhbHVNK0VQVXdpU1lJZ0xRckpFekNGYi9n?=
 =?utf-8?B?QmlWUUs4dEdNMTZjNlFUdGFrcXNxMWZKczJPdEF2YXdTYWIvcmhpcFJnZDFB?=
 =?utf-8?B?aElQTHNoT1JvaWo5Y0E1bklJK2Z1UjN6TjVMaE4wZUNxYVQ5cFdHbDNIQTlI?=
 =?utf-8?B?TG02SzFkMmphVUlQZ0J4Z0V5RDRtN1pvNit2Wm1nclRwMjFkWkVrSlk2d211?=
 =?utf-8?B?c01WOG94WTBKOXJTNHAvQkthaEJTY2VieDdTaFlsQU0xeUR1djE4cnVUek9Q?=
 =?utf-8?B?RUN3bTVLUE5jZks3RWdPOVBZN0tiazlGT3A5bWo2cTJvVGc2d05DcXhINDA3?=
 =?utf-8?B?MWxJeElzY1h4eGNRR2k3RzVLb0lMVWdDbjB1VjNYZVdFa0JjdUJPbmRERlpK?=
 =?utf-8?B?cEFicldaRzhHZ1ZlazFwTW5rSTc3bU84cEhvc1hUNzhKYUdYUXp5MGtDZ2Rw?=
 =?utf-8?B?Y2J3Q1c1aGkySzhmb2hDQi9KMU5HQVlEbTJ2VjI2OXo2YnljOXo2QkY4dnJy?=
 =?utf-8?B?bmJVbWtVRTNYbG1Td0x3Rld4QmV4dkhabTJtc0ZhUVA3NkFwQTA1THVuUUoz?=
 =?utf-8?B?MzNlVmZCR0d3N1pBNzJkN2xwQ3lKYUFveERqdFNEWm1MYWhiZVd6ZG5qVHMv?=
 =?utf-8?B?Z3BxQTBaSnc2YUdaeXJyK2diMW5scit2QTlsRmNhdzZsVUVoeHRSbEhhVG9m?=
 =?utf-8?B?VE1mRHkydFRwdFRGdnBlTUx6czdGbkYwK2NkU2VWdFAwbUI0bW9maDhRM0Q0?=
 =?utf-8?B?M0pHaForRWJLVHJoUnhsQmJDY1RiUTJ4bU54cTBNYTgrY3NsMTM1Wk9DZmZI?=
 =?utf-8?B?ZGQ2OVNEOElHZlE3Q0xTWmg1alg4b2ZrRk1meHNGU2VxeDNWR3RNTG1NZEEw?=
 =?utf-8?B?a0FpTm1UQmhMYTN5UDZ4SkZDb0N2TTliUFQ4RzdMbThRbk02YW5FNDNqWVN1?=
 =?utf-8?B?TDRSQTVSZysxOFFsbWhEaVk4bU5OQmcwOHRFVUkrQnBtS3ZsWmQwOXhXQTJm?=
 =?utf-8?B?UWRORk5XUUhlMTFUYVdCUGtOQ2tnN1JKY2dMWGtXT2ZqY2lUWWJiU1FROHMx?=
 =?utf-8?B?R2sxYkZnNTR0WU5OcHdaZWUzTlY0U2Z5QzZFMEozYWw0aHZQa0MrQWlSV1JC?=
 =?utf-8?B?cktVeS8vS2lSWnQ3YndUZkZCMTZaemhzYW9tdjVHRHMrTWdySjMxcmdhSDRS?=
 =?utf-8?B?ZCt0aGlaVEVOTUtqS2srV1RsQWgrSU44R0VDUzdYWmJSbncvWmJYWTBId29F?=
 =?utf-8?B?dEtmODhFR25JWDJIK2tXQ0dNZkFKMWh3Y09pRW0rTm9KU216Ylk4cTRMcldP?=
 =?utf-8?B?Z1JPU28rcDVWdkR0WUF6T1FDZlNJWnkyK3hUQndqd2RqNnBVUzEvQ2dCclpD?=
 =?utf-8?B?djAzY0JybDZURkd5QlFkQ1VYemZiSjdEdSt0ZnBxUlhySC9TTXhhdGFPQlNl?=
 =?utf-8?B?Rk9ia25GekZYQjZKY0hpL2xjbC85V0cwai9YZDIyNnhXVnMrWXNob2VWYkM4?=
 =?utf-8?B?L3Z0aDhzVzgramFHaUR1SG84N29wUHR2UXBDYmlmdFZjTkw5NzQ3U09ocThJ?=
 =?utf-8?B?dEUwT0VFd0ZhckRFVVk5Uzhib3FrV2V2Q2x1dWkxclQ0bVJsNjM3Vk03NHdL?=
 =?utf-8?B?R0lJUXlDcFBtejc1am94dDFxNzFETTcyMjZoa2xzbk40cml5cnR2RGhtdG1N?=
 =?utf-8?B?SHhNQjlnOXZvYkE3N1lrTXUzT1YvOWFXNTRJeVd5RFRYUlVBdlNzcjZKZFpw?=
 =?utf-8?B?Y0Uzek1mN1lGY01CMFR6L0x4S3RiSWlnYXRSUmUwRmxESis5eDd4bEZROTZ5?=
 =?utf-8?B?cU4va3NtaEN5M1F4WWsxRzZqcHExQVpHSHMyS25zVnBLMDJNR25URm9NYmpt?=
 =?utf-8?B?UkpvYnk0NVJHdmdvQmlOOGRMV1JRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98cf9fc-b105-4cdc-ae45-08da0452ddbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2022 18:05:17.9278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ixb047FKJ3Sj7+YEeTEQv+J/HOMmDUBLNI4zekrH5srVfdFX5XSeRsfxXiaRbRMGPw3oy5FkweECRvb8GIUvU0K4/ryjx/ImYQqtIPPH2jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5257
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KUGxlYXNlIGZpbmQgdGhlIGlubGluZSBj
b21tZW50cy4NCg0KVGhhbmtzLA0KU2FqaWRhDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBNYXJjaCA4LCAyMDIyIDM6MjAgUE0NCj4gVG86IFNhamlkYSBCaGFudSAoVGVt
cCkgKFFVSUMpIDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPjsgQXN1dG9zaA0KPiBEYXMgKGFz
ZCkgPGFzdXRvc2hkQHF1aWNpbmMuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsNCj4gYWdy
b3NzQGtlcm5lbC5vcmc7IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBsaW51eC0NCj4gbW1j
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBWZWVyYWJoYWRyYXJhbyBCYWRpZ2FudGkg
KFFVSUMpIDxxdWljX3ZiYWRpZ2FuQHF1aWNpbmMuY29tPjsgUmFtDQo+IFByYWthc2ggR3VwdGEg
KFFVSUMpIDxxdWljX3JhbXByYWthQHF1aWNpbmMuY29tPjsgUHJhZGVlcCBQcmFnYWxsYXBhdGkN
Cj4gKFFVSUMpIDxxdWljX3ByYWdhbGxhQHF1aWNpbmMuY29tPjsgU2FydGhhayBHYXJnIChRVUlD
KQ0KPiA8cXVpY19zYXJ0Z2FyZ0BxdWljaW5jLmNvbT47IE5pdGluIFJhd2F0IChRVUlDKQ0KPiA8
cXVpY19uaXRpcmF3YUBxdWljaW5jLmNvbT47IFNheWFsaSBMb2toYW5kZSAoUVVJQykNCj4gPHF1
aWNfc2F5YWxpbEBxdWljaW5jLmNvbT47IHF1aWNfbmd1eWVuYiA8cXVpY19uZ3V5ZW5iQHF1aWNp
bmMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDMvN10gbW1jOiBkZWJ1Z2ZzOiBBZGQg
ZGVidWcgZnMgZW50cnkgZm9yIG1tYw0KPiBkcml2ZXINCj4gDQo+IE9uIDIuMy4yMDIyIDE1LjAz
LCBTaGFpayBTYWppZGEgQmhhbnUgd3JvdGU6DQo+ID4gQWRkIGRlYnVnIGZzIGVudHJ5IHRvIHF1
ZXJ5IGVNTUMgYW5kIFNEIGNhcmQgZXJyb3JzIHN0YXRpc3RpY3MNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IExpYW5nbGlhbmcgTHUgPHF1aWNfbHVsaWFuZ0BxdWljaW5jLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTYXlhbGkgTG9raGFuZGUgPHF1aWNfc2F5YWxpbEBxdWljaW5jLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBCYW8gRC4gTmd1eWVuIDxxdWljX25ndXllbmJAcXVpY2luYy5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhaWsgU2FqaWRhIEJoYW51IDxxdWljX2Nfc2JoYW51QHF1
aWNpbmMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2RlYnVnZnMuYyB8IDYw
DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2NvcmUvZGVidWdmcy5jIGIvZHJpdmVycy9tbWMvY29yZS9kZWJ1Z2ZzLmMN
Cj4gPiBpbmRleCAzZmRiYzgwLi5kYjA5ODhjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1j
L2NvcmUvZGVidWdmcy5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9kZWJ1Z2ZzLmMNCj4g
PiBAQCAtMjIzLDYgKzIyMyw2MyBAQCBzdGF0aWMgaW50IG1tY19jbG9ja19vcHRfc2V0KHZvaWQg
KmRhdGEsIHU2NCB2YWwpDQo+ID4gREVGSU5FX0RFQlVHRlNfQVRUUklCVVRFKG1tY19jbG9ja19m
b3BzLCBtbWNfY2xvY2tfb3B0X2dldCwNCj4gbW1jX2Nsb2NrX29wdF9zZXQsDQo+ID4gIAkiJWxs
dVxuIik7DQo+ID4NCj4gPiArc3RhdGljIGludCBtbWNfZXJyX3N0YXRzX3Nob3coc3RydWN0IHNl
cV9maWxlICpmaWxlLCB2b2lkICpkYXRhKSB7DQo+ID4gKwlzdHJ1Y3QgbW1jX2hvc3QgKmhvc3Qg
PSAoc3RydWN0IG1tY19ob3N0ICopZmlsZS0+cHJpdmF0ZTsNCj4gPiArCWNvbnN0IGNoYXIgKmRl
c2NbTU1DX0VSUl9NQVhdID0gew0KPiA+ICsJCVtNTUNfRVJSX0NNRF9USU1FT1VUXSA9ICJDb21t
YW5kIFRpbWVvdXQNCj4gT2NjdXJyZWQiLA0KPiA+ICsJCVtNTUNfRVJSX0NNRF9DUkNdID0gIkNv
bW1hbmQgQ1JDIEVycm9ycyBPY2N1cnJlZCIsDQo+ID4gKwkJW01NQ19FUlJfREFUX1RJTUVPVVRd
ID0gIkRhdGEgVGltZW91dCBPY2N1cnJlZCIsDQo+ID4gKwkJW01NQ19FUlJfREFUX0NSQ10gPSAi
RGF0YSBDUkMgRXJyb3JzIE9jY3VycmVkIiwNCj4gPiArCQlbTU1DX0VSUl9BVVRPX0NNRF0gPSAi
QXV0by1DbWQgRXJyb3IgT2NjdXJyZWQiLA0KPiA+ICsJCVtNTUNfRVJSX0FETUFdID0gIkFETUEg
RXJyb3IgT2NjdXJyZWQiLA0KPiA+ICsJCVtNTUNfRVJSX1RVTklOR10gPSAiVHVuaW5nIEVycm9y
IE9jY3VycmVkIiwNCj4gPiArCQlbTU1DX0VSUl9DTURRX1JFRF0gPSAiQ01EUSBSRUQgRXJyb3Jz
IiwNCj4gPiArCQlbTU1DX0VSUl9DTURRX0dDRV0gPSAiQ01EUSBHQ0UgRXJyb3JzIiwNCj4gPiAr
CQlbTU1DX0VSUl9DTURRX0lDQ0VdID0gIkNNRFEgSUNDRSBFcnJvcnMiLA0KPiA+ICsJCVtNTUNf
RVJSX1JFUV9USU1FT1VUXSA9ICJSZXF1ZXN0IFRpbWVkb3V0IiwNCj4gPiArCQlbTU1DX0VSUl9D
TURRX1JFUV9USU1FT1VUXSA9ICJDTURRIFJlcXVlc3QNCj4gVGltZWRvdXQiLA0KPiA+ICsJCVtN
TUNfRVJSX0lDRV9DRkddID0gIklDRSBDb25maWcgRXJyb3JzIiwNCj4gPiArCX07DQo+ID4gKwlp
bnQgaTsNCj4gPiArDQo+ID4gKwlpZiAoIWhvc3QpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
IA0KPiBEbyBub3QgbmVlZCB0byBjaGVjayBob3N0IGhlcmUNCj4gDQpPayANCj4gPiArDQo+ID4g
Kwlmb3IgKGkgPSAwOyBpIDwgTU1DX0VSUl9NQVg7IGkrKykgew0KPiA+ICsJCWlmIChkZXNjW2ld
KQ0KPiA+ICsJCQlzZXFfcHJpbnRmKGZpbGUsICIjICVzOlx0ICVkXG4iLA0KPiA+ICsJCQkJCWRl
c2NbaV0sIGhvc3QtPmVycl9zdGF0c1tpXSk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbW1jX2Vycl9zdGF0c19vcGVuKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KPiA+ICt7DQo+ID4gKwlyZXR1
cm4gc2luZ2xlX29wZW4oZmlsZSwgbW1jX2Vycl9zdGF0c19zaG93LCBpbm9kZS0+aV9wcml2YXRl
KTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIHNzaXplX3QgbW1jX2Vycl9zdGF0c193cml0ZShzdHJ1
Y3QgZmlsZSAqZmlscCwgY29uc3QgY2hhciBfX3VzZXINCj4gKnVidWYsDQo+ID4gKwkJCQkgICBz
aXplX3QgY250LCBsb2ZmX3QgKnBwb3MpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtbWNfaG9zdCAq
aG9zdCA9IGZpbHAtPmZfbWFwcGluZy0+aG9zdC0+aV9wcml2YXRlOw0KPiA+ICsNCj4gPiArCWlm
ICghaG9zdCkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IERvIG5vdCBuZWVkIHRvIGNo
ZWNrIGhvc3QgaGVyZQ0KPiANClN1cmUgd2lsbCBza2lwIHRoZSBob3N0IGNoZWNrLg0KPiA+ICsN
Cj4gPiArCXByX2RlYnVnKCIlczogUmVzZXR0aW5nIE1NQyBlcnJvciBzdGF0aXN0aWNzXG4iLCBf
X2Z1bmNfXyk7DQo+ID4gKwltZW1zZXQoaG9zdC0+ZXJyX3N0YXRzLCAwLCBzaXplb2YoaG9zdC0+
ZXJyX3N0YXRzKSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGNudDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgbW1jX2Vycl9zdGF0c19mb3Bz
ID0gew0KPiA+ICsJLm9wZW4JPSBtbWNfZXJyX3N0YXRzX29wZW4sDQo+ID4gKwkucmVhZAk9IHNl
cV9yZWFkLA0KPiA+ICsJLndyaXRlCT0gbW1jX2Vycl9zdGF0c193cml0ZSwNCj4gPiArfTsNCj4g
PiArDQo+ID4gIHZvaWQgbW1jX2FkZF9ob3N0X2RlYnVnZnMoc3RydWN0IG1tY19ob3N0ICpob3N0
KSAgew0KPiA+ICAJc3RydWN0IGRlbnRyeSAqcm9vdDsNCj4gPiBAQCAtMjM2LDYgKzI5Myw5IEBA
IHZvaWQgbW1jX2FkZF9ob3N0X2RlYnVnZnMoc3RydWN0IG1tY19ob3N0DQo+ICpob3N0KQ0KPiA+
ICAJZGVidWdmc19jcmVhdGVfZmlsZV91bnNhZmUoImNsb2NrIiwgU19JUlVTUiB8IFNfSVdVU1Is
IHJvb3QsIGhvc3QsDQo+ID4gIAkJCQkgICAmbW1jX2Nsb2NrX2ZvcHMpOw0KPiA+DQo+ID4gKwlk
ZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJlcnJfc3RhdHMiLCAwNjAwLCByb290LCBob3N0LA0KPiA+ICsJ
CSZtbWNfZXJyX3N0YXRzX2ZvcHMpOw0KPiA+ICsNCj4gPiAgI2lmZGVmIENPTkZJR19GQUlMX01N
Q19SRVFVRVNUDQo+ID4gIAlpZiAoZmFpbF9yZXF1ZXN0KQ0KPiA+ICAJCXNldHVwX2ZhdWx0X2F0
dHIoJmZhaWxfZGVmYXVsdF9hdHRyLCBmYWlsX3JlcXVlc3QpOw0KDQo=
