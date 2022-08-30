Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917A95A5B45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiH3FvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiH3FvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:51:10 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90057.outbound.protection.outlook.com [40.107.9.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA10A926D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kICYfgLYnHov4wUQHeoSaw7PG0DKnUZuPcobjC09DqjaG6f9Zqxo7XnWN8PjN41L41+Oc48yU532rsljfflKQ62nASEt4U3WH1MrZRlZGIpE/0YD7x+DnGTgbaBGiU0+ZqVTPn3SMJKZ6+/v+EAFhrCpofzGLXkFxkmqXNxa7W8s3MGqWD/WPsAkD3FpNHe8UGh/Y/M0/TTOcl1I97dufQUIGaOtua5x+u/WS8qaTIreGHmLX/VKozJzmvXyeIW2gQIdtyBxnlX62CF8Y/sBp7TKBtDpbtIZkJi/S0TkMJSFM/XmbEvXpEckyEkV/nWQy97xosjXMWlIYP9bBH807A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLzbP2PMaXmNMxdEODfIUoCY3mpGmbsdXw6cvtVEKWY=;
 b=cUGWYwEA3US6PtwTT6JQuHIB1/JwXCMsj7V9ZkE4bdJ2opjAKjLBCsMXr+iqegT+V5Nh7kG1AKrLuJhdeZ7kaAnVfS9moCy6+DLhwUm0AiIQdZClEWAKN8MKwE06P0rCAa0eoMw/AGFD85s6wPYwN/5lGYus1YiwCsFwAkgVbie525GKg5xwLcH0nL8Bn6b/5x3vBF3+hkTHBiIySKKLyflJp31UmAFRlzuUUuLMOjvRBoluv44VaTiEidAJBl2euahI2i8lwXEbeK++z/COLdTdBCY5Tr3jEWcUFLoGagNf5XjX2+uCanka+XFtx7OyaDrKAt+pJCO2J+WgB77SIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLzbP2PMaXmNMxdEODfIUoCY3mpGmbsdXw6cvtVEKWY=;
 b=c7Di5NsDlAC7kHNJ8PgerTfBd+hl9Xdwz0xjsgPtSWkuYZuWMVQVulHiU5v2QFVkXQA+x7o9aL5+JbM+Oa9ZAh/V9WlaBW0N6T37rJ4eSLNE1mknCCKgOZIaQx1VCWOw54m9sDpKByoGDP6Zpiet/fhQ3wAMbLkhKGDIkwW+O881yMxBDrYPsvVMkmwldsJxHduVPNqSxoL/7gQ8vDBrgtl9eL89C/WFQxZAHFQVm2uGMSln0D55r0ArQtNNYKN1SjyKoyNS/+MVpXi5ThcOuvZ5n128mhzGzR2HnJYFQy5m/DKWkhj2WPYwTfFFSBlFmpFvAk8aG1v3sBRiQj9hsw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3674.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 05:51:06 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 05:51:06 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Dawei Li <set_pte_at@outlook.com>, "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: simplify size2index conversion of __kmalloc_index
Thread-Topic: [PATCH] mm: simplify size2index conversion of __kmalloc_index
Thread-Index: AQHYuvD3lNL8fNmBVUaxP5/fLtFnp63FNBAAgAAHEICAALQmgIABA9MA
Date:   Tue, 30 Aug 2022 05:51:06 +0000
Message-ID: <f02b862f-8e8c-0ec9-7b83-c9e26831c242@csgroup.eu>
References: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <YwwuSBAreqUk/jFq@casper.infradead.org> <Yww0NV54DXTzPG+R@hyeyoo>
 <1188aeeb-3949-b561-bec0-512ed763d857@suse.cz>
In-Reply-To: <1188aeeb-3949-b561-bec0-512ed763d857@suse.cz>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd956704-adf7-41a0-2b12-08da8a4ba1a2
x-ms-traffictypediagnostic: PR0P264MB3674:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LB7Q6C0+Xm8d83izElLbQVNVYa/wPxGv2LnSDgd5tdSnNol3imgLKao1tS2C+pV0wyS0Yqtk5UgJ9vXABw+FZ1WMO75rZi8HJfNgiqDGxWHaJCl+oCGKrLftJONy1IP+hSiMjWd0eKMjlL1cEppGVXOeT5lStDuS0Gy3PS16wXKSq+nqC5KMRYeb6TemezA6sG627RApJmKgH8PEgf41J2hH8uFyqXsud04c0nSSG0FGPWRfluXLuuw4VS9yWw8LeLzacLgOLpNOypMqdM7CC58mdCuX/I5etgQqcvVGjcCEGc0U7EQTUJlB3a7TGfNNY+QbhJjLZwo/roQMyPbPbHdt9MSVZwDF//E/IucBtymb3AI5O8sq4cuRwtvweRV6SDsfWuPi2mkRZK9knNB0w/3ix0LXCHEBqWYmCdkYH5cClTTgMhGGR8ieA/dTITVAGuEwAmT2wSyEjVB50Ys/LsaQgRcurrd7crMOuIU0eFX+aK7IK2huKM7OySGWsFQOx41BplIyBVZ5tOWOCc0HcmLh0hy8swoXPWqB5Ag3+hlTVoQvbVkBLucDbHdavIjURSPj0UT5Z46dCsOH3uFPu4/Sp0YwrlskaIjKi0yJJ/fELN3DTTPQzfzsbynI21V6jZpnmx8f0LgwF8POZ9xQeH77QEnUg1igSdN2XAF9C7ocDAadFRsU3Xr55K29NNnX1dqfs8EaEP7BoCvs3DqYC/bY6ye4r8ApjcgJFd7q1OsmfwSeKVhJSVCfkJ0jdLbakPKgknfGZXvv8m3Tn0r9WUcuasGVn69SNi7YOIVHTzI3rZzLBlm+a18SmU5DYNALUZy8+PXwQ0E8JsBvkkZaq+YW5qt0/pJmOGOhJqyMPtA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(39850400004)(346002)(136003)(122000001)(31686004)(2616005)(38100700002)(8676002)(66946007)(4326008)(76116006)(66446008)(64756008)(66476007)(66556008)(86362001)(36756003)(31696002)(38070700005)(966005)(478600001)(66574015)(83380400001)(6486002)(26005)(53546011)(6512007)(44832011)(6506007)(41300700001)(54906003)(186003)(110136005)(71200400001)(316002)(2906002)(7416002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVpHZUhyL0xVeENqY0s1bEd2SHV4R2FubnFYaUxjYStjZi9QbElJQmlDaFVm?=
 =?utf-8?B?Y3lWcC9rb0t6M2dNd1VnNzd2cXZUQjhSZVRoT2RFWW93SDJMa09hWC9xRE5a?=
 =?utf-8?B?a3NVRWdDUHRHZzQzd1l0QjQxUWFvdlYyZ1ZtcFhjMnRoZzlGbCtwa2UvNlIv?=
 =?utf-8?B?dGxWbElCUDhUbWw3SUs0b1ozZm5lSlFMK2o2NDFRYVNmRE1DT0h3MFhsaXg2?=
 =?utf-8?B?TDhwVC8xYVFvMWxyL0NWR3BybnhZVjZsZ1JVMUwzNVRlZ3hVaFZRTi90R3g0?=
 =?utf-8?B?VzR5SEtVWTlYV1R6UWh5WE9TcVh4RWhNUmVyYkRRNjJ3aE9WTnVLd0N4cTFr?=
 =?utf-8?B?VnJDYTlId2s2c0FocmkzWnBiODl3OHFvMVpuNmxxRmxNZk1nZGtUSVZaT3Jr?=
 =?utf-8?B?YjY1ZGFHcWFxOUNIbDFzMmlDSmtya2pRbC9aRUd5UlRFWDQyUnV5akw3ZGt1?=
 =?utf-8?B?VWJKS1JRb3Zza1BmQm1yNURaWTdUSWY3QkZIeG94OVdPV3ZNTWRIa1RnUzdC?=
 =?utf-8?B?emRmaUxkQmlwblBPMlVGVTBSc0hqRWtLVExxZk1HKzExdWtuYmlienBFNmV2?=
 =?utf-8?B?cDRIUHFyT0c1WjVOQWUvQlhqbkQ2Q2c5S3NNcjQ2ZWhWSnpwdVVLY2htOTRk?=
 =?utf-8?B?ZTFoUTdVd0Nna00yaGR2dUlNNE5RZVlUNmxSU1NZMGM3RWw4bUMyQkZvKy9N?=
 =?utf-8?B?TUp2MkE4cWh2TThUSDgveForMG9GUzNKNVBCV2RXVmxSUk5kSDU4WDc0VnJI?=
 =?utf-8?B?MXd0aE85dVBVVEdxdklxZHdGaXlZdW9HbTlnRjVJMmVsZGcrbVRLSUtiUlZ1?=
 =?utf-8?B?TVlmZmJQWmE1V2JLUFZOQmc2aUxiWDMzQTJuekZCQW9HMFBxVEd5bTVWZysw?=
 =?utf-8?B?M2FwTUhkSk1vRFJkSFFVN1pxRzJVMGU0VUd0UlJDZm9TZkFxYzRTVFE2czE0?=
 =?utf-8?B?WG1GMHliVVBDWHlUY3I2N09CWlJxeVRSdS9BRFdSdnFoc0p5MHZPQzUzY3JR?=
 =?utf-8?B?UTlLMmRZN0tZVWRBL0VKS3R4OG9IbDA3RWhJcERYSDdqSHdkNTVYWUREbEFo?=
 =?utf-8?B?ZXJqOTBZYzVubXA1Tm1IN2wrTGdGTnJ1d1JqVnI3OEJxV1RTeU40eHFYWCti?=
 =?utf-8?B?L0EwRm0xY3J5aXJlYk13YTBwQVRpOFA4MUpIY1F1NDBaSlRYQWRYUWtTRk9u?=
 =?utf-8?B?em9lTm55bFZBUkhtcHNST0llTytQa3FFQ3NWVUlFMjdQRExSYmczRGlvazlq?=
 =?utf-8?B?UWRUMmlDQW50NCsrZGRKTENFMndtV0h6Y2tkaE5vdzA2SEFPV1ZTeXdSNEd5?=
 =?utf-8?B?WmF3ME92ZmxPK0prdWExTUhQQ0dSWHBnOUU0bVJDUG5FRXNNcmlZbjRBWHlQ?=
 =?utf-8?B?SWd1UlI4Mk1ldlJsd2U5QVhhVXZSenJ1SVB5VDJFNFBlamlTZzM2N2UvZW5t?=
 =?utf-8?B?WFlONHV1VmhvK0c0NDlEQlJpVlBCVmxTbXNzRk9QOVZ5QUMzZWFUQVcwM0VX?=
 =?utf-8?B?UENLak5laERXT0FzeTVQU3p3SnVBOEk2RHFBV0F1MnAyTUFycGlsL3dqdS9k?=
 =?utf-8?B?ZjdYWWpFVkx3QUo3eUhiSkorQ1ZCQU5WUzBGZ0VOcXlTMTdzODlXMkhxQ2dv?=
 =?utf-8?B?bndUYjdKb1laeHNFVTkwbjVDUXdQOHVGY1VkRTloRmFxZVFnaG56cThhSVd3?=
 =?utf-8?B?QmhycWV5aXVoK3Y5RlpOWElNeGRseWJtK2RVRlNDeWZQMHVZUER1RFlwN0hD?=
 =?utf-8?B?UmJocFg5Rkx3eWVEMWNBVHhuRkswRlhpeVFhUXphUk1PNE5ET2VpMEwrek5v?=
 =?utf-8?B?cGl5aGREM0NiZGlLNlQ2K3lSM1YzRUI0WFNLMmVoejFPU1BQMnh0THFkM2x4?=
 =?utf-8?B?NlRIRmlQM3MwSEh2V3NtaThFYUhySXB2MzVLOUZnaWlIZWhrUUxiUUFBVWJ3?=
 =?utf-8?B?MzZvTHVCaE9uckVmaFhpRzMraUVVL3l1Z1FnbmxTNU16M3VNR3pWNDdNSnNZ?=
 =?utf-8?B?U3NJRWljVEl5NzdoU0x1ellSNXBmU0UxZGwzNy9GWWVsTmhYaVVGN3hPZDlp?=
 =?utf-8?B?Z0hrNUw1ZDRDUVp5eFN4b21INnAyczhMRWJRZWluUTlIT1l1ZUUxWG9xUVBo?=
 =?utf-8?B?N1RvNTNEN2RuWlUzWTVXdzFDWisxYlMvbGlYMERZZVhiakt4cExURWNLdnJu?=
 =?utf-8?Q?uH1zjk93xm9gaKznWejDvRo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C59C57B90D4E9A45BE5CCB494E50A525@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fd956704-adf7-41a0-2b12-08da8a4ba1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 05:51:06.5131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSe9Dau2qUhJ659s0+R4z6zXViyCJ67sx6lA1LPTgX/de4l/fsqy/npfdS6sGzgNCn5Xa/d7D0WCwdRCyx3uqQhQo9EwPTnwLfvaAtoo3MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3674
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI5LzA4LzIwMjIgw6AgMTY6MjEsIFZsYXN0aW1pbCBCYWJrYSBhIMOpY3JpdMKgOg0K
PiBPbiA4LzI5LzIyIDA1OjM2LCBIeWVvbmdnb24gWW9vIHdyb3RlOg0KPj4gT24gTW9uLCBBdWcg
MjksIDIwMjIgYXQgMDQ6MTE6MDRBTSArMDEwMCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+Pj4g
T24gU3VuLCBBdWcgMjgsIDIwMjIgYXQgMTE6MTQ6NDhQTSArMDgwMCwgRGF3ZWkgTGkgd3JvdGU6
DQo+Pj4+IEN1cnJlbnQgc2l6ZTJpbmRleCBpcyBpbXBsZW1lbnRlZCBieSBvbmUgdG8gb25lIGhh
cmRjb2RlIG1hcHBpbmcsDQo+Pj4+IHdoaWNoIGNhbiBiZSBpbXByb3ZlZCBieSBvcmRlcl9iYXNl
XzIoKS4NCj4+Pj4gTXVzdCBiZSBjYXJlZnVsIHRvIG5vdCB2aW9sYXRlIGNvbXBpbGUtdGltZSBv
cHRpbWl6YXRpb24gcnVsZS4NCj4+Pg0KPj4+IFRoaXMgcGF0Y2ggaGFzIGJlZW4gTkFDS2VkIGJl
Zm9yZSAod2hlbiBzdWJtaXR0ZWQgYnkgb3RoZXIgcGVvcGxlKS4NCj4+DQo+Pg0KPj4gSG1tIHJp
Z2h0Lg0KPj4gaHR0cHM6Ly9sa21sLml1LmVkdS9oeXBlcm1haWwvbGludXgva2VybmVsLzE2MDYu
Mi8wNTQwMi5odG1sDQo+Pg0KPj4gQ2hyaXN0b3BoIExhbWV0ZXIgd3JvdGU6DQo+Pj4gT24gV2Vk
LCAyMiBKdW4gMjAxNiwgWXVyeSBOb3JvdiB3cm90ZToNCj4+Pj4gVGhlcmUgd2lsbCBiZSBubyBm
bHMoKSBmb3IgY29uc3RhbnQgYXQgcnVudGltZSBiZWNhdXNlIGlsb2cyKCkgY2FsY3VsYXRlcw0K
Pj4+PiBjb25zdGFudCB2YWx1ZXMgYXQgY29tcGlsZS10aW1lIGFzIHdlbGwuIEZyb20gdGhpcyBw
b2ludCBvZiB2aWV3LA0KPj4+PiB0aGlzIHBhdGNoIHJlbW92ZXMgY29kZSBkdXBsaWNhdGlvbiwg
YXMgd2UgYWxyZWFkeSBoYXZlIGNvbXBpbGUtdGltZQ0KPj4+PiBsb2coKSBjYWxjdWxhdGlvbiBp
biBrZXJuZWwsIGFuZCBzaG91bGQgcmUtdXNlIGl0IHdoZW5ldmVyIHBvc3NpYmxlLlwNCj4+DQo+
Pj4gVGhlIHJlYXNvbiBub3QgdG8gdXNlIGlsb2cgdGhlcmUgd2FzIHRoYXQgdGhlIGNvbnN0YW50
IGZvbGRpbmcgZGlkIG5vdA0KPj4+IHdvcmsgY29ycmVjdGx5IHdpdGggb25lIG9yIHRoZSBvdGhl
ciBhcmNoaXRlY3R1cmVzL2NvbXBpbGVycy4gSWYgeW91IHdhbnQNCj4+PiB0byBkbyB0aGlzIHRo
ZW4gcGxlYXNlIHZlcmlmeSB0aGF0IGFsbCBhcmNoZXMgcmVsaWFibHkgZG8gcHJvZHVjZSBhDQo+
Pj4gY29uc3RhbnQgdGhlcmUuDQo+Pg0KPj4gQ2FuIHdlIHJlLWV2YWx1YXRlIHRoaXM/DQo+IA0K
PiBJcyB0aGVyZSBhIHdheSB0byB0dXJuIGluYWJpbGl0eSBvZiBjb21waWxlLXRpbWUgY2FsY3Vs
YXRpb24gdG8gYQ0KPiBjb21waWxlLXRpbWUgZXJyb3I/ICh3aGVuIHNpemVfaXNfY29uc3RhbnQ9
dHJ1ZSBldGMpLiBUaGVuIHdlIGNvdWxkIHRyeSBhbmQNCj4gc2VlIGlmIGFueXRoaW5nIGJyZWFr
cyBpbiAtbmV4dC4NCj4gDQo+IA0KDQpUaGUgZm9sbG93aW5nIHdpbGwgZ2VuZXJhdGUgYSBidWls
ZCBlcnJvciBpZiB0aGUgZnVuY3Rpb24gDQpjb25zdGFudF9jaGVjaygpIGlzIG5vdCBjYWxsZWQg
d2l0aCBhIGJ1aWxkdGltZSBjb25zdGFudCBhcmd1bWVudC4NCg0Kc3RhdGljIHZvaWQgX19hbHdh
eXNfaW5saW5lIGNvbnN0YW50X2NoZWNrKHVuc2lnbmVkIGxvbmcgdmFsKQ0Kew0KCUJVSUxEX0JV
R19PTighX19idWlsdGluX2NvbnN0YW50X3AodmFsKSk7DQp9DQoNCklzIHRoYXQgd2hhdCB5b3Ug
YXJlIGxvb2tpbmcgZm9yID8=
