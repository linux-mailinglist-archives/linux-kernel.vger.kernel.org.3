Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8C5ABD91
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiICG7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiICG7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:59:44 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90087.outbound.protection.outlook.com [40.107.9.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B196578;
        Fri,  2 Sep 2022 23:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J30PT/PUgXg87cT4/702oIgrpshsFOL0naiJUcv2KnpOwj8xe4YwVyFPqjmrmchmqxzmjaqj8ahVC8IA0vfCVcn+lgytPXUpUI/4bCTckBRsSVZtyewhmsundJqFWsIcpnV0MFgF8tOg6Yznobr/GD+1cXLoStC9E954U6Z6eSm/0aVC3QpUiuCbBgp1u08bXdwZOGy1xpZA5lr9aSAobtJv57NQa/fKNigSdvxKFopWRKx9pLXZTduSKzM6xSM0qNRuQpQA4kA46pgO4KfBm+Eq6n/H44+6/8lp+27948DYZNhm7K87wLcZINzz/Ir0sXtr4ciCxFRRbSwL+P50Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cAY6QnvGuTXwGvXr3KjsksPs7d8icMne9IHCzDGgZ4=;
 b=dq7oPESoNnONYp7fy9FGfeiHKWSBO6Jo/SKJcPMGV4WiPCIywpxhu+GoK3qxlEridSVbNXxt6WWPd8f8NXZ0JWTMKUPa+dhzb6YCduo3MGUOzXjSdVCpz5Rfj+pAJq9hxTG7/WNKDg2XdRpZmQIP0gje8KyMwkt0Q4oT/fE+QB54vFYJv6bhw/eyHw2DMrwhZY1JPJ+16+M31AaFhdp+uTD5m5c9rOHCZcBThrrybRchO93HzLvtpqe4RvvI8vAFUBJm580Ic71fu0qq8aLuUre1FjJ3mWWYxfNGyQxBU3dpi+dNbTwdvmoMAnfZweRen99OY+KFLlbCgaLEdiTgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cAY6QnvGuTXwGvXr3KjsksPs7d8icMne9IHCzDGgZ4=;
 b=L+Lk8sEyTRvlPbw1BP7Xv3M0cJhKgMe2QESmYEok6uZidTa/u/1uztzacWo4GBIv/XNEeGphRnvvkXixcSuNzNXeNX7YJkjaykIn9d1tCPgtAZX2ZD5iQMvVkFR8XUuVFKZNV0pyLCNfWUpW38Meh4rTiiqIVjJ3LWCsFwl5COr0YmlgV5RZw4F38fnhM77Tvx/g8PAd6w6RzPQr0x7oqDCqB4u+69FaFbC5z37tkq+qk18GB+ZyEpAaWy0rH1wvRwpcTJKaNbgqj5SPZyz+4X7M+pXpRp7hjCWGjxgS7l+HR87zxIX1IXvTIq4eVRs09HWqOTx8/L3J139yM8KauQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2964.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Sat, 3 Sep
 2022 06:59:36 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.017; Sat, 3 Sep 2022
 06:59:36 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "inuxppc-dev@lists.ozlabs.org" <inuxppc-dev@lists.ozlabs.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Thread-Topic: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Thread-Index: AQHYvADXSfya6wb65kG+D7mgtkHwTK3HGEyAgACRYoCAAE3+AIAAsbkAgAPYXwCAAACZAIAAyxSA
Date:   Sat, 3 Sep 2022 06:59:36 +0000
Message-ID: <dca632c6-80f4-b80e-a81f-e2f91a3b2e48@csgroup.eu>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <608934d4-466d-975e-6458-34a91ccb4669@redhat.com> <Yw5AOZ/Kc5f3UP+s@monkey>
 <Yw6Bpsow+gUMlHCU@monkey> <739dc825-ece3-a59f-adc5-65861676e0ae@redhat.com>
 <YxJQfGSsbXd3W4m/@monkey> <323fdb0f-c5a5-e0e5-1ff4-ab971bc295cc@redhat.com>
In-Reply-To: <323fdb0f-c5a5-e0e5-1ff4-ab971bc295cc@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32949607-d666-43ed-f19d-08da8d79dccb
x-ms-traffictypediagnostic: MR1P264MB2964:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lcWoUfIrUVUVFI/Ve2+r4K9kN2K25WNBrCIb0Kq2vOKPq4WVMbxMsLdMF6XI2QvZoycmJ3xXntWSmFfFidMUk14QuHHZyCv05Ei+nr6F3mTrcdQisxDLZrHOePt3cdto0dNoDHtgO+z4AyMsm5mlEUS6EdrIT2jfD6ENt9cL74aN1Q0LEGQTHAQZE57bfLEkkVNRSujGIpAJv1tXL7RGgJxNhNt+Gr/q1oLGqtMJHO5zSNXLdpPyR+3yjYecrCmjVKeAkMSlYKbRnjRLRi1A1/pbGss58lkkDWmA6tlHs2cpoNKhsc+7jd3lxthpfL+6vMEmv6c3C6iXBrNrKocQbcUc0BTD7sJh5W4mtbIUU4rbI2cYDQtvMmmFiXalRXxnKBenssu/qAZvll/yJs387JbpN0IvoIl3p4YksBqqd7gihjlVJCKa73l3saPA3uDVBuFApUqX1jTqaA+Wr9wQk+B5KIN9Z98QRerxGpKfew3noV9GzwhYl4oS2DOd/2veZCjyflmhh4dcKh82KomFble7JvNIlqOfakecEPCKFF3JfKHMJTcyfkxihbsGI2617Oi4Sz87R64G8gpIvvmnaVCKJzJvaVrm0n7xl+Eq68snpCyBcegBxXNytB/7S0i0GOODFXC9OLTKOPwMoxbzwNTAm0H/FbEscmtI3ZMiocYebKz9nrobRzSdkiUS2JvOuiBR4TdZ/TPd6Mi61oC3a8zEiVZ+TDaD+adahQG1m5HNgsyLXIGkSyuaDIKL5WbIZ6gGmiBNHHo0wDmh7GRzXbfZFOUy4YXMRq4P96IEuwd8oWDkABpRjVwPwJ+ctVAO7vJ83d1ztE0pU2mGS3RzXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(91956017)(83380400001)(76116006)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(8676002)(316002)(110136005)(54906003)(31696002)(36756003)(86362001)(31686004)(26005)(6512007)(2616005)(186003)(66574015)(2906002)(44832011)(38070700005)(7416002)(8936002)(5660300002)(478600001)(38100700002)(71200400001)(41300700001)(6486002)(6506007)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emFielkycmVrTmZLZlNCV0NKNkNjdW9YbWtJNjdDQUgzNEU1OXdJeW55RGV1?=
 =?utf-8?B?dnBqY1FveUZ6LzVuOEdRUFpMRVA4bG9raTJiNlJIdGlDeGRReHJkVEpkanVS?=
 =?utf-8?B?R1IydVNFOVF4MDh6N1hMVWlYVzRtUmJvdUdpNU5oTnBYcHQxVnlaRjdMUks4?=
 =?utf-8?B?SVB5K3BoY1ZhQjVPSVNWdUtrNkhhTmNEaVo3V1dLUHRiTCsyMFl4Y3dtazdE?=
 =?utf-8?B?dGRaTjRaMTloYUtPdzFUa2M5QjUvb05jbVN0dGdBaUI4VC96WWg3VjdVQjBL?=
 =?utf-8?B?YVNCbXNacU8yWG5rSXJRYUxtVVVFSzdOaVNCZzBOcXdtdTN2Y2R6akxKYks2?=
 =?utf-8?B?UjRkVXdzWmJEaFI1clpSeFdheTlBQndQY2JTVk5nUEoxMTcvL0VYYi9hTEo2?=
 =?utf-8?B?ZFZibWNaalU2bmhyKzFWekEwQmlodmYwVVNySVVaMXZnWWh3aWdkOE55VVYr?=
 =?utf-8?B?UzQxRXliSVhjOENiTElaREJ3Rm12ZVErMzRTWjdXeXdTRkUvZG5GOXFiK1Bm?=
 =?utf-8?B?TGl5UHhFeHBVbSttb1hTWVc4b0hpUlFnTC8xM1JCSzdSTFdVV3paYm9DSjNh?=
 =?utf-8?B?NnFldmtBdERlZ0U2OVMvazI5RzRUYXFDcnpOcDNQd0lVU1BGZUlCUkhIeEVF?=
 =?utf-8?B?NXhrMGhRQnlsSTR2WjUvN1BXeVJ0WUlGeGV2VnZIMWRlQnRMcG1jRE9iWVBP?=
 =?utf-8?B?Z0gzNEJBcTV6SGRYNHFsK0JMQVdhM0JXbEVhTTVSQ3JCOFJzL0E5eGhINGl5?=
 =?utf-8?B?cDFTOGZVbFRHRW9OZlNjZ2sxRHpUaTl0R2tzbkl0SHgxRStwOCtPK2dmSkQ0?=
 =?utf-8?B?Wmhyem91NlNlUEppTkFGOTQ4akdGdytZeWc1dU5jWUVxVkZPN09wTU85Qjlk?=
 =?utf-8?B?SFlFQTc0Nk1aeDFKbm1idURVR2FaSnlqS1o0T3lOaWt2MlN4dG9NNVJITTJX?=
 =?utf-8?B?MU9EWUVNSnIrYkg3SVVVNjkzdWN1WDZ1MUxUc0g3VVVid2tHOE04QllVTUVi?=
 =?utf-8?B?WEdVSkhVQnI0Y2ZhTnUxUTBEa0FaZ1RCY2FMWUtQNStLa2l1S25OTnBPdFRk?=
 =?utf-8?B?K3F3eURnRDd6dStKUnhaVGo5N0Y5MFNDbGs3ZkU2V0M3TjRjMHlFR2NRRU53?=
 =?utf-8?B?MFRSeDlHblNibGVSdFVoMWlQK1BKSVhscXVUeVdlU3lrMEtjbXNQTTNrVEQw?=
 =?utf-8?B?L1pidmJFRzE0RjUxQUhqL2w2THVDVHhWZzB1ckh1Nm56cmx4bi9BRVpVRFNz?=
 =?utf-8?B?SER1VTZ1NmdDdFlBQnJ0RnJuRUJaaFZFTU1MYi9QejFDaVF4MEw3VGVEOEQ1?=
 =?utf-8?B?NmdxMWVLQWlMZDZ1UWJnNUtvUHhiMW82M1RacERweTN2SDE3TGpZK2wwb1A1?=
 =?utf-8?B?UmRGNzYxUUVXdGdycjI3dURkeVVpcGtPUHk5Wk53ekJXK3EvUGFHRlFia1V6?=
 =?utf-8?B?R2dkVHVpZE0xM2RmQk0rUm0yVXlxbm5PRjUycXo3dy9SVTYvSTNEUVFjVFpC?=
 =?utf-8?B?SThNQVk1bE9vTXF0S0dybXhPTERybUJiRXFYYmdOeC9vUFRMM3VNZUF6S01W?=
 =?utf-8?B?RVQwWGtKOHJvT3JmRzRwTytERU9rSGljODlpTlltb1dlUlZySzhjMVVBSTFp?=
 =?utf-8?B?dkx6TWhmc3Nua0doVFJqa05UU1pTcFg2RVFWV1hUMzNvbitLNE1INkVqUVAr?=
 =?utf-8?B?Q3V0aU9nZVpQMitzdFo3Rlo1b0RzNjlJcmxUYmgxeFZVRDl5MTQrUlFhd0Nk?=
 =?utf-8?B?dGIvOVFkaENKUlpma3Q4SzhJcUF0THFORU1YOTRMVVNXckFNT1VGZVREcGJK?=
 =?utf-8?B?czFxc2swUFJ5WS9vNURXMEtuZlZFRlNpb0tLRkVOSThWazc5bnV6N1hWTTZ3?=
 =?utf-8?B?SlB3cjZqa1ZmTnErcml5SnhHdGRLR2pQM0k0dW9SOW40Umw2VTRGMlZVbXIy?=
 =?utf-8?B?aTRxNHAyd3V6UUJXZGVqSnBjWDdPU2JaRGM0WHBwZitEY1FYazlOWkhYTGJI?=
 =?utf-8?B?R0lWRUVmWGR2aEFCL0hLdXNaWHN4TW1IeHRzampIb1VIUGMwa01rUFRmNFlF?=
 =?utf-8?B?dWRlL3hEdjVFU0Nlb29pdFp1NlJTVStXNFhJeDJscmswV1lDbGdUNzN4Z0Fv?=
 =?utf-8?B?YU8vZjV2c1BhbFBqWTcwT3R2MjVrN3VEbjNkQ3pKYjQvN2V2S0Q0U3M5YVlV?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <232F4182B3E4FD4999575233BCAECC5C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 32949607-d666-43ed-f19d-08da8d79dccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2022 06:59:36.1102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dmek5jVIQrmSO9xhZELSQr3CT3AzEiFsxt988WIr2zfTjL36VVXETU+dQhcx9J0awLFvUht28wy4VdnEveELAvRbelYNbL14yVEgkObNLHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAyLzA5LzIwMjIgw6AgMjA6NTIsIERhdmlkIEhpbGRlbmJyYW5kIGEgw6ljcml0wqA6
DQo+Pj4+IEFkZGluZyBDaHJpc3RvcGhlIG9uIENjOg0KPj4+Pg0KPj4+PiBDaHJpc3RvcGhlIGRv
IHlvdSBrbm93IGlmIGlzX2h1Z2VwZCBpcyB0cnVlIGZvciBhbGwgaHVnZXRsYiBlbnRyaWVzLCBu
b3QNCj4+Pj4ganVzdCBodWdlcGQ/DQoNCmlzX2h1Z2VwZCgpIGlzIHRydWUgaWYgYW5kIG9ubHkg
aWYgdGhlIGRpcmVjdG9yeSBlbnRyeSBwb2ludHMgdG8gYSBodWdlIA0KcGFnZSBkaXJlY3Rvcnkg
YW5kIG5vdCB0byB0aGUgbm9ybWFsIGxvd2VyIGxldmVsIGRpcmVjdG9yeS4NCg0KQXMgZmFyIGFz
IEkgdW5kZXJzdGFuZCBpZiB0aGUgZGlyZWN0b3J5IGVudHJ5IGlzIG5vdCBwb2ludGluZyB0byBh
bnkgDQpsb3dlciBkaXJlY3RvcnkgYnV0IGlzIGEgaHVnZSBwYWdlIGVudHJ5LCBwWGRfbGVhZigp
IGlzIHRydWUuDQoNCg0KPj4+Pg0KPj4+PiBPbiBzeXN0ZW1zIHdpdGhvdXQgaHVnZXBkIGVudHJp
ZXMsIEkgZ3Vlc3MgcHRkdW1wIHNraXBzIGFsbCBodWdldGxiIGVudHJpZXMuDQo+Pj4+IFNpZ2gh
DQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIHB0ZHVtcF9wWGRfZW50cnkoKSBoYW5kbGVzIHRoZSBw
WGRfbGVhZigpIGNhc2UuDQoNCj4+Pg0KPj4+IElJVUMsIHRoZSBpZGVhIG9mIHB0ZHVtcF93YWxr
X3BnZCgpIGlzIHRvIGR1bXAgcGFnZSB0YWJsZXMgZXZlbiBvdXRzaWRlDQo+Pj4gVk1BcyAoZm9y
IGRlYnVnZ2luZyBwdXJwb3Nlcz8pLg0KPj4+DQo+Pj4gSSBjYW5ub3QgY29udmluY2UgbXlzZWxm
IHRoYXQgdGhhdCdzIGEgZ29vZCBpZGVhIHdoZW4gb25seSBob2xkaW5nIHRoZQ0KPj4+IG1tYXAg
bG9jayBpbiByZWFkIG1vZGUsIGJlY2F1c2Ugd2UgY2FuIGp1c3Qgc2VlIHBhZ2UgdGFibGVzIGdl
dHRpbmcNCj4+PiBmcmVlZCBjb25jdXJyZW50bHkgZS5nLiwgZHVyaW5nIGNvbmN1cnJlbnQgbXVu
bWFwKCkgLi4uIHdoaWxlIGhvbGRpbmcNCj4+PiB0aGUgbW1hcCBsb2NrIGluIHJlYWQgd2UgbWF5
IG9ubHkgd2FsayBpbnNpZGUgVk1BIGJvdW5kYXJpZXMuDQo+Pj4NCj4+PiBUaGF0IHRoZW4gcmFp
c2VzIHRoZSBxdWVzdGlvbnMgaWYgd2UncmUgb25seSBjYWxsaW5nIHRoaXMgb24gc3BlY2lhbCBN
TXMNCj4+PiAoZS5nLiwgaW5pdF9tbSkgd2hlcmVieSB3ZSBjYW5ub3QgcmVhbGx5IHNlZSBjb25j
dXJyZW50IG11bm1hcCgpIGFuZA0KPj4+IHdoZXJlIHdlIHNob3VsZG4ndCBoYXZlIGh1Z2V0bGIg
bWFwcGluZ3Mgb3IgaHVnZXBkIGVudHJpZXMuDQoNCkF0IGxlYXN0IG9uIHBvd2VycGMsIFBURFVN
UCBoYW5kbGVzIG9ubHkgaW5pdF9tbS4NCg0KSHVnZXBhZ2UgYXJlIHVzZWQgYXQgbGVhc3Qgb24g
cG93ZXJwYyA4eHggZm9yIGxpbmVhciBtZW1vcnkgbWFwcGluZywgc2VlDQoNCmNvbW1pdCAzNDUz
NmQ3ODA2ODMgKCJwb3dlcnBjLzh4eDogQWRkIGEgZnVuY3Rpb24gdG8gZWFybHkgbWFwIGtlcm5l
bCANCnZpYSBodWdlIHBhZ2VzIikNCmNvbW1pdCBjZjIwOTk1MWZhN2YgKCJwb3dlcnBjLzh4eDog
TWFwIGxpbmVhciBtZW1vcnkgd2l0aCBodWdlIHBhZ2VzIikNCg0KaHVnZXBkcyBtYXkgYWxzbyBi
ZSB1c2VkIGluIHRoZSBmdXR1cmUgdG8gdXNlIGh1Z2UgcGFnZXMgZm9yIHZtYXAgYW5kIA0Kdm1h
bGxvYywgc2VlIGNvbW1pdCBhNmE4ZjdjNGFhN2UgKCJwb3dlcnBjLzh4eDogYWRkIHN1cHBvcnQg
Zm9yIGh1Z2UgDQpwYWdlcyBvbiBWTUFQIGFuZCBWTUFMTE9DIikNCg0KQXMgZmFyIGFzIEkga25v
dywgcHBjNjQgYWxzbyB1c2UgaHVnZSBwYWdlcyBmb3IgVk1BUCBhbmQgVk1BTExPQywgc2VlDQoN
CmNvbW1pdCBkOTA5ZjkxMDljMzAgKCJwb3dlcnBjLzY0cy9yYWRpeDogRW5hYmxlIEhBVkVfQVJD
SF9IVUdFX1ZNQVAiKQ0KY29tbWl0IDhhYmRkZDk2OGEzMCAoInBvd2VycGMvNjRzL3JhZGl4OiBF
bmFibGUgaHVnZSB2bWFsbG9jIG1hcHBpbmdzIikNCg0KQ2hyaXN0b3BoZQ==
