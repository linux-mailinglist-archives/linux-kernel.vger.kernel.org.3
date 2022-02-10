Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68FF4B113F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbiBJPGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:06:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243462AbiBJPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:05:55 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120070.outbound.protection.outlook.com [40.107.12.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E244F0C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej/x9lYZlfcsGuxVjGQK/fAWELXcf4eMhbkZwbux+K/MHSebZ1zJa1naAIpoWl/hCnA+8bd2f9EVt6C22Rrph1eiUhdhu5HnSHGZCpUpfLE3s7lXEw9VZFnfjFlmoWAq44lu0jApHH/7gE7CyK9z7FNAlzYh0se4ApHaZdzC4pr+KS7lqdxgjzcAaTU18b7QYUCSF96+LcBf0wb2M4874tCJn1JPi2L+uSwwQDC1KL4K9RsDAImlc75fZGMrkhCgwMdijFRJYkn/GL9oQyb1Hurdg2CbtRZH0VUNbaTDee/0FnotxFucUwunA/nJ84xOCfSAEkM/K6ymE3XVgyrbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4o6/BPx8G9Tz+Qja+8EXlZx1EtNhhA19o1AQpXrysM=;
 b=eOWKaD8WchyQHm2CYKtwML57hgujNz2m84az5oNSg2MzwLvev1mvA1z7S4AdPy4J97tgQ3gk8huBfa4vsb/wEgXOJk4le3AIh5sPW6D0bEBQgT2JKQrPoCiyx7eGemsAa5toz8yiG9vFi86gWkmicPh1DB8dFxy9HoRmr5raeuW9/ogJrtVlg69ehoGLP8Iprz+2kEqGAA5yeYsCeRf2rZrUw1tBa/LyRR2JdHgf3gf2Ar6soU0BjT14kC9DWUsA5X9+hTozarCspsKHiBrZwkdnC4M/5UVnay4FhLQT/+UugpT1kraW/pjyWcLEkhCupWBkas+zEQW5MRgijB+7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2322.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 15:05:52 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 15:05:52 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] tracing: uninline trace_trigger_soft_disabled()
Thread-Topic: [PATCH] tracing: uninline trace_trigger_soft_disabled()
Thread-Index: AQHYHlrunD/YgRuIXUqfiNw5JA4bxKyM156AgAALDoA=
Date:   Thu, 10 Feb 2022 15:05:51 +0000
Message-ID: <d60a60ff-cc16-75b0-2415-482cb70a2e5e@csgroup.eu>
References: <38191e96ec6d331662ee7278e26edb79cdf95402.1644482771.git.christophe.leroy@csgroup.eu>
 <20220210092617.2bb40912@gandalf.local.home>
In-Reply-To: <20220210092617.2bb40912@gandalf.local.home>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8200a592-0389-4c91-197d-08d9eca6d44f
x-ms-traffictypediagnostic: MR1P264MB2322:EE_
x-microsoft-antispam-prvs: <MR1P264MB2322CFD69122109DEA2759B4ED2F9@MR1P264MB2322.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: di1GMOl+77CDzCOdNKe8QgtBc4O4qL/+MCAjq3DOsDnQUyhNtXXLPZoYWSphf0/XMDMlOn2lV4hTixchQHcjFoKgDL7gTJP4hgF1al5UNuS694sPrmDf0CbcvdYSEIcWLzb9E3NANiY8iQ3/532E/ytMcxPHTyzVsYQ7NHNI9mfUFW2ej4ak0wRnPU9KQNrnBLCVO6JEqKVN+pMXE9xzOXabyawv0g6k+9NTMMNGtto/ADtPPg/j+hl+6hEK+RfqflVeWRSC7aHSRLgpfsp/eKgQVPJPVdQYsClLJP9+1JV2D9QGdZAEB/xbnvRwlEjJ8f34k4WWE9hwE5xmaLS0r5zMAUVtmixRdlgDbxiUDxqGxfzkEyEyh4KszCBDWJCASXN+e6P+AxzpFlvjEO7bDezVDdpdJbjA9Px+97R08UIVMBy6c39oxIZtPd6GPNccQ4iwNfRBwMCd6Uwkn90haztqXdr3cYzareBBXmD+Di9LN5WpOKeBY0z2JF6DDmtyFlfY14J1V0N+Z+EMRLT+/fPvA1CLxsoqVJfM66qqfTV3n+VuuDW5I2mX5MYhVjXERax9XMHk39k5xJyO3tOMzAkTuNdCEfpbmotQvz2RIZPOzz5/+QoXbMeT86jmXOXC2ghBnxj3PORCpxXNiEhC1oIabU5mJo8HjjxOljErmQk9nJlwHnKQG2e8HFE5phlb83foG/xVcYSZrShRWEDbc0thW8CqcCnqhm97BRKw7ixDLJZdgjXiwkTPPI0+OYPt4ResFJmS+IvAY6cHzXzqFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(316002)(38070700005)(54906003)(71200400001)(38100700002)(86362001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(122000001)(31696002)(91956017)(8676002)(6486002)(6916009)(6506007)(8936002)(5660300002)(36756003)(83380400001)(2616005)(2906002)(6512007)(66574015)(26005)(186003)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW1Ub2FHYWMrL3JjcHM4MThDcmpleVIwbE80bXNrSHBLRTF1d2FlNW5pc0dC?=
 =?utf-8?B?amltTzBXMEJwbWh2RVVyVUN5Wi9seXR1TGVzNU9XbDBtTnZwcFVHekVPWUky?=
 =?utf-8?B?NW5vL3RjY0lrSzh5MjdDbHRXOTMyOThoYTFURHNIR0c2Y3k3Rmg0WFBrK3hq?=
 =?utf-8?B?VTc3cGltd1psaXVyd2RTcW9vTWpqZTJ5RjVYdkxQc0tadWZ1RGNGTjhVZ2Vz?=
 =?utf-8?B?WTgybEhXK3BmaFlPU3lzQmVIRjA4Y3BxT1ZhQ2dwOVVBQXhrQWd0R3NzL1o3?=
 =?utf-8?B?SVVNbEZQSjJuaDRVbHlKYVRRUDB6SllNZlZsY2JPa0VwL2txNDFrVHZGc0Q0?=
 =?utf-8?B?NTYxMHFrTFB0TXZKY0hGcWx2L0V5TmwyczJyUVhkT2x3YmRJUkNwRG11cG5E?=
 =?utf-8?B?anpQeldRbWV0VmJiUlRPelZVbjhBV0VQMlNpZ2J0RGFHRUQ3aEhLTW9QTStK?=
 =?utf-8?B?Y1B1UWRyYXArY1c1VTJINHE0SEoxRDM4dDNzZDArM29zZGxRK2FvdkxZNXht?=
 =?utf-8?B?WFlBWWYyRGx3WXprWFdpcmlXajMvTUttOERZRHptSXlRYWM5KzU2ellZSVN2?=
 =?utf-8?B?RmU0dHl1NEt4dDB4bmNKT3p4V1dXS05HS21LcStoN0ZvcmtLRE9Sbys1UE5y?=
 =?utf-8?B?RmlFSVB2QUZmMnlRcWZVeHBQeWREbHBZWmoybU82UFRhUVFTZlptSlZ6STUw?=
 =?utf-8?B?aHI1OFh5TDFKdFg3c2lYM09XeXhGTC9HcC9EMEtOWjhaTEw2ODVXeUhBWkVs?=
 =?utf-8?B?VjBHR3dYbyt3U2gzbXpHd2wyak5Sc2RodnVxUTIzZDNTTUZEUnpCT3VtTzRB?=
 =?utf-8?B?aDRZNC9KRG52MU5OT2VIM0NpaTVyYS9lK0VwTmgyemNxb1RoQ2NuNWIrdzBq?=
 =?utf-8?B?SkxwMnlINStjWVoxSWhMempFbFc2SnZxYWhyMGdKTVhRZUNyM1h0eFVvQ2di?=
 =?utf-8?B?aHpTVGoybFdLSUdZZUUrL0lZd2hLN3dxY056ai8ydmJRNEc5QWJEbU1iZm9v?=
 =?utf-8?B?TENBUllwWnN1OWhkcFc1dFVzbFBybWo3azRLOFNuMVl4MDl1eElQTkhNTDFE?=
 =?utf-8?B?U2tiYUl4ZlNxeXUySGtFeXpSdVcwbVgvR2J5SGNuQUoxRElUY2NaU3ZJVk9J?=
 =?utf-8?B?b1BlOTg3aGJaYWI3NW9XejNvMXNGWjUwdTN5WWdqck1jU0hCVDMycmpKWlhW?=
 =?utf-8?B?MjR2dTZ2RjRVa0l5ZndFMFZNZzJ5dmRzaEE5WHcrQ01BVktYcTk1d2hKa0l6?=
 =?utf-8?B?TS9BekNjSUNSdktkUUFpQ3ViOHFWcklQM24xclgxQUpzcXJTanpCNm12VnRB?=
 =?utf-8?B?VUpwR2kwY0lVaGo3RzZGQjcwaTFuQnh3VTNSZWVHejhwU0NMSy8rM1ZXNTJH?=
 =?utf-8?B?VjJFRGlneENZUzlTQzFhNlN0L0xrVG1CZjFjUWhpKzJaS0xlSkYrZEFBQTFG?=
 =?utf-8?B?QnNlSTR3WFlaZ09vSFVLL05kSWxDbEY5NEpCb1JSRGhPemNMYzI2bk85YnFo?=
 =?utf-8?B?SWRTOE5ZQ3drUG9HdEI0Vk1HUmVQWDFOUVlYOVVqYmZRUXp3d01ZWGh1UFI1?=
 =?utf-8?B?Nmp5UnFYZWpzeVRvaUg1dDFKdVlCa3NHKzY5dHpDUEU4eTYrd09hV29kT0hl?=
 =?utf-8?B?UlJETW92V1NMVnZ0bU5nQk42OFRCcit0RTFuYTFnYmxnWjF0aVJ0KzVkRHQ3?=
 =?utf-8?B?VkJPV0VZYWI1M2tHakVmcE9IbVdCREtvYXZ3YUE3SmhmTGdCOEtvNFRISDBp?=
 =?utf-8?B?L3Zla0RvME93OWhhUDRZelJFRzZrdG8vZUhBRjRUQ0FzRVFITU1xU3YxUXZt?=
 =?utf-8?B?N0FFZjFRRE5xYVl5b01yck5yaDNHY3BkWTJzVkQwMUJMT3pkWDMxMFlSZGJS?=
 =?utf-8?B?ZWJxZ2Q3QlBxY0NqMk1aanR4bXBST2VoQjkzWXBHWkpTTS93elB2RWMwLzBC?=
 =?utf-8?B?Nkx3NFE2ekZXdjIvTFdVT3ByU0NmTWppKzNKcjlqa2h0aDJnc3I4dFBESm5S?=
 =?utf-8?B?L251OFJSdXVIMUR6RVcvdEpHdkRYMzJyeVNad2tZVllQQWlWS2lBVFFnZUhP?=
 =?utf-8?B?WmJGcVQ4Tzd5MHZYVXBvUFJGUnZSRE8wYTYzcnZiWk9ldW8rTkw0SVBVR292?=
 =?utf-8?B?NXhTcEVTcGZsYm12OW5WSnd4emlubVFJMG9sdG5MV09hV21EeklNa2wvTEoz?=
 =?utf-8?B?ZU1oTWVybXdwaDFwczFKZkZNTjY4bkJQcm1HT1NtS1NFUEJtSUtVa3pjc2o0?=
 =?utf-8?Q?TMWnrfufO7xeNmofadVtKbfvR0pH1kU3VAU0uCKGyQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9700B345CF2CDC43BD77A71AD2F27D2A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8200a592-0389-4c91-197d-08d9eca6d44f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 15:05:51.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Dr7jnLjlmxiJ50mxhBCiqD8OlhDVqZp96VyUpHxEOfzZvXKkvGcPfEdVRVjn6dEuayP7pilM3WhvVMfB1GW6MblFqL7IzDgTAErXrLvpa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2322
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDEwLzAyLzIwMjIgw6AgMTU6MjYsIFN0ZXZlbiBSb3N0ZWR0IGEgw6ljcml0wqA6DQo+
IE9uIFRodSwgMTAgRmViIDIwMjIgMDk6NDc6NTIgKzAxMDANCj4gQ2hyaXN0b3BoZSBMZXJveSA8
Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToNCj4gDQo+PiBPbiBhIHBwYzMyIGJ1
aWxkIHdpdGggQ09ORklHX0NDX09QVElNSVNFX0ZPUl9TSVpFLA0KPj4gdHJhY2VfdHJpZ2dlcl9z
b2Z0X2Rpc2FibGVkKCkgYXBwZWFycyBtb3JlIHRoYW4gNTAgdGltZXMgaW4gdm1saW51eC4NCj4+
DQo+PiBUaGF0IGZ1bmN0aW9uIGlzIHJhdGhlciBiaWcgZm9yIGFuIGlubGluZWQgZnVuY3Rpb24s
IGFuZA0KPj4gaXQgZG9lc24ndCBiZW5lZml0IG11Y2ggZnJvbSBpbmxpbmluZyBhcyBpdHMgb25s
eSBwYXJhbWV0ZXINCj4+IGlzIGEgcG9pbnRlciB0byBhIHN0cnVjdCBpbiBtZW1vcnk6DQo+IA0K
PiBUaGUgbnVtYmVyIG9mIHBhcmFtZXRlcnMgaXMgbm90IHRoZSByZWFzb24gZm9yIGl0IGJlaW5n
IGlubGluZWQuIEl0J3MgaW4gYQ0KPiAqdmVyeSogaG90IHBhdGgsIGFuZCBhIGZ1bmN0aW9uIGNh
bGwgY2F1c2VzIGEgbm90aWNlYWJsZSBwZXJmb3JtYW5jZSBoaXQuDQoNCkZhaXIgZW5vdWdoDQoN
Cj4gDQo+IA0KPj4NCj4+DQo+PiBJdCBkb2Vzbid0IGJlbmVmaXQgbXVjaCBmcm9tIGlubGluaW5n
IGFzIGl0cyBvbmx5IHBhcmFtZXRlciBpcyBhDQo+PiBwb2ludGVyIHRvIGEgc3RydWN0IGluIG1l
bW9yeSBzbyBubyBjb25zdGFudCBmb2xkaW5nIGlzIGludm9sdmVkLg0KPj4NCj4+IFVuaW5saW5l
IGl0IGFuZCBtb3ZlIGl0IGludG8ga2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50c190cmlnZ2VyLmMN
Cj4+DQo+PiBJdCByZWR1Y2VzIHRoZSBzaXplIG9mIHZtbGludXggYnkgYXBwcm94aW1hdGVseSAx
MCBrYnl0ZXMuDQo+IA0KPiBJZiB5b3UgaGF2ZSBhbiBpc3N1ZSB3aXRoIHRoZSBzaXplLCBwZXJo
YXBzIHRoZSBmdW5jdGlvbiBjYW4gYmUgbW9kaWZpZWQgdG8NCj4gY29uZGVuc2UgaXQuIEknbSBo
YXBweSB0byBoYXZlIGEgc2l6ZSByZWR1Y3Rpb24sIGJ1dCBJIHdpbGwgTkFDSyBtYWtpbmcgaXQN
Cj4gaW50byBhIGZ1bmN0aW9uIGNhbGwuDQo+IA0KDQpXZWxsLCBteSBmaXJzdCBpc3N1ZSBpcyB0
aGF0IEkgZ2V0IGl0IGR1cGxpY2F0ZWQgNTAgdGltZXMgYmVjYXVzZSBHQ0MgDQpmaW5kIGl0IHRv
byBiaWcgdG8gZ2V0IGlubGluZWQuIFNvIGl0IGlzIGEgZnVuY3Rpb24gY2FsbCBhbnl3YXkuDQoN
CkZvciBpbnN0YW5jZSwgd2hlbiBidWlsZGluZyBhcmNoL3Bvd2VycGMva2VybmVsL2lycS5vIHdo
aWNoIC1XaW5saW5lLCBJIGdldDoNCg0KLi9pbmNsdWRlL2xpbnV4L3BlcmZfZXZlbnQuaDoxMTY5
OjIwOiBlcnJvcjogaW5saW5pbmcgZmFpbGVkIGluIGNhbGwgdG8gDQoncGVyZl9mZXRjaF9jYWxs
ZXJfcmVncyc6IGNhbGwgaXMgdW5saWtlbHkgYW5kIGNvZGUgc2l6ZSB3b3VsZCBncm93IA0KWy1X
ZXJyb3I9aW5saW5lXQ0KLi9pbmNsdWRlL2xpbnV4L3BlcmZfZXZlbnQuaDoxMTY5OjIwOiBlcnJv
cjogaW5saW5pbmcgZmFpbGVkIGluIGNhbGwgdG8gDQoncGVyZl9mZXRjaF9jYWxsZXJfcmVncyc6
IGNhbGwgaXMgdW5saWtlbHkgYW5kIGNvZGUgc2l6ZSB3b3VsZCBncm93IA0KWy1XZXJyb3I9aW5s
aW5lXQ0KLi9pbmNsdWRlL2xpbnV4L3BlcmZfZXZlbnQuaDoxMTY5OjIwOiBlcnJvcjogaW5saW5p
bmcgZmFpbGVkIGluIGNhbGwgdG8gDQoncGVyZl9mZXRjaF9jYWxsZXJfcmVncyc6IGNhbGwgaXMg
dW5saWtlbHkgYW5kIGNvZGUgc2l6ZSB3b3VsZCBncm93IA0KWy1XZXJyb3I9aW5saW5lXQ0KLi9p
bmNsdWRlL2xpbnV4L3BlcmZfZXZlbnQuaDoxMTY5OjIwOiBlcnJvcjogaW5saW5pbmcgZmFpbGVk
IGluIGNhbGwgdG8gDQoncGVyZl9mZXRjaF9jYWxsZXJfcmVncyc6IGNhbGwgaXMgdW5saWtlbHkg
YW5kIGNvZGUgc2l6ZSB3b3VsZCBncm93IA0KWy1XZXJyb3I9aW5saW5lXQ0KLi9pbmNsdWRlL2xp
bnV4L3RyYWNlX2V2ZW50cy5oOjcxMjoxOiBlcnJvcjogaW5saW5pbmcgZmFpbGVkIGluIGNhbGwg
dG8gDQondHJhY2VfdHJpZ2dlcl9zb2Z0X2Rpc2FibGVkJzogY2FsbCBpcyB1bmxpa2VseSBhbmQg
Y29kZSBzaXplIHdvdWxkIGdyb3cgDQpbLVdlcnJvcj1pbmxpbmVdDQouL2luY2x1ZGUvbGludXgv
dHJhY2VfZXZlbnRzLmg6NzEyOjE6IGVycm9yOiBpbmxpbmluZyBmYWlsZWQgaW4gY2FsbCB0byAN
Cid0cmFjZV90cmlnZ2VyX3NvZnRfZGlzYWJsZWQnOiBjYWxsIGlzIHVubGlrZWx5IGFuZCBjb2Rl
IHNpemUgd291bGQgZ3JvdyANClstV2Vycm9yPWlubGluZV0NCi4vaW5jbHVkZS9saW51eC90cmFj
ZV9ldmVudHMuaDo3MTI6MTogZXJyb3I6IGlubGluaW5nIGZhaWxlZCBpbiBjYWxsIHRvIA0KJ3Ry
YWNlX3RyaWdnZXJfc29mdF9kaXNhYmxlZCc6IGNhbGwgaXMgdW5saWtlbHkgYW5kIGNvZGUgc2l6
ZSB3b3VsZCBncm93IA0KWy1XZXJyb3I9aW5saW5lXQ0KLi9pbmNsdWRlL2xpbnV4L3RyYWNlX2V2
ZW50cy5oOjcxMjoxOiBlcnJvcjogaW5saW5pbmcgZmFpbGVkIGluIGNhbGwgdG8gDQondHJhY2Vf
dHJpZ2dlcl9zb2Z0X2Rpc2FibGVkJzogY2FsbCBpcyB1bmxpa2VseSBhbmQgY29kZSBzaXplIHdv
dWxkIGdyb3cgDQpbLVdlcnJvcj1pbmxpbmVdDQoNCg0KDQpJZiBoYXZpbmcgaXQgYSBmdW5jdGlv
biBjYWxsIGlzIHJlYWxseSBhbiBpc3N1ZSwgdGhlbiBpdCBzaG91bGQgYmUgDQpfX2Fsd2F5c19p
bmxpbmUNCg0KSSB3aWxsIHNlZSB0aGUgaW1wYWN0IG9uIHNpemUgd2hlbiB3ZSBkbyBzby4NCg0K
DQpXaGF0IGlzIGluIHRoZSBob3QgcGF0aCByZWFsbHkgPyBJdCBpcyB0aGUgZW50aXJlIGZ1bmN0
aW9uIG9yIG9ubHkgdGhlIA0KZmlyc3QgdGVzdCA/DQoNCldoYXQgYWJvdXQ6DQoNCnN0YXRpYyBp
bmxpbmUgYm9vbA0KdHJhY2VfdHJpZ2dlcl9zb2Z0X2Rpc2FibGVkKHN0cnVjdCB0cmFjZV9ldmVu
dF9maWxlICpmaWxlKQ0Kew0KCXVuc2lnbmVkIGxvbmcgZWZsYWdzID0gZmlsZS0+ZmxhZ3M7DQoN
CglpZiAoIShlZmxhZ3MgJiBFVkVOVF9GSUxFX0ZMX1RSSUdHRVJfQ09ORCkpDQoJCXJldHVybiBv
dXRsaW5lZF90cmFjZV90cmlnZ2VyX3NvZnRfZGlzYWJsZWQoLi4uKTsNCglyZXR1cm4gZmFsc2U7
DQp9DQoNCg0KT3IgaXMgdGhlcmUgbW9yZSBpbiB0aGUgaG90IHBhdGggPw0KDQpUaGFua3MNCkNo
cmlzdG9waGU=
