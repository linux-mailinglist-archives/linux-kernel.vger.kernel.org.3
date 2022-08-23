Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472C859ED57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiHWUdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiHWUdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:33:00 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C3B4BD;
        Tue, 23 Aug 2022 13:10:24 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NK27Lu017671;
        Tue, 23 Aug 2022 20:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=fHiDIS9G21DtmtHXK9NhE7npNHi4We1YBCss1EzHC3A=;
 b=KcZZsy4U13Z+6txQ9VEGWaV6l9MKcUTmxA3/699c1Ww2GnXsnJhGxr5/chtQYaaLk1yP
 IZ+DIxHKBNaKNhsjpzMk6InCPpgrCnphzxG6G57RPMJntj2jN0FSxLnBjrKXsXGJI05g
 k3W1DF9VOg+flrWdu2GPyZ+dWg2CCgGaulcAlkcTPWVXYRrtf+5qwwangVIWWWSFDRFQ
 6aVMpWbqDB+XYqrkuXj602Mf2VgSgqAHiQ1F79FuzGD3ekD9Nq4mU0CeDs5mv8AiPzUW
 EVCmKBeQkV3j2DefhDWX1g9nHEN3u1xzc4zBLARsoAYyKos7QHm6gSCTGr5BKM9BBHwf gQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j54akgrnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 20:10:05 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D853A80171B;
        Tue, 23 Aug 2022 20:10:03 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 23 Aug 2022 08:10:03 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 23 Aug 2022 08:10:03 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 23 Aug 2022 08:10:03 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 23 Aug 2022 20:10:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+Q3E5JjSw+o7bptDRGtdHvYXRaT3/pexHckFa907/FPvwEJplsOdG3qJA8Vylj93efLQxoTy6D4VSkXMr9CZEHc2Bx7c24Vzdh0Rn8wnfkfG78Y2GwvXEQcMob5YztldvNRWrGGyr/aXAEUaJFphwvGbkmR/UPxNEjWpZT0nua2EBB2xET1cf9XR8l2gYV+2r8Q7Imn6bBCzmQOVMI4SdEfsupiONM7x6xH3p8YC6ExLC+N6zq9K1S/JNwKlw7vwLMoocBp4FVi25T3WAPoBUg10G7UlJJP0mTU+0995b45NiCwuzp9BMMEXv/Rv08xZetqlMY2xJWi1Bbxt+Daxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHiDIS9G21DtmtHXK9NhE7npNHi4We1YBCss1EzHC3A=;
 b=T5vy+klBzkbKM265kk8uozgWag3EYyOuXlnNLKuZndkg3Eme9DNKcuzzQdeqjcYZgELXE7qjrfKZXz+COWyta8QLsWGC9JB5Z1GxMDHfQZFEjKAMLt3epXgknpl7m0LsE6cpouBaXhm+oZqe8a1PPS7LT2QF/qK6wdgqjb4ki4mKM7qIfrsEoik47vbrA7A78x6Tx2/Cd/jv8sTWmLODUoQ3stavi7nkLuDYql5i3dQpqfr8SHyrptMUbb6XdG4rrYYKv2+qQYnu4XD0nFzMiB2yAvZWQs7HNER67x5yCTqrFED4vMlcKLGEAkYKEDAONT8Z9k/6ee5jsvHX2OVdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1966.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 20:10:01 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Tue, 23 Aug 2022
 20:10:01 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        =?utf-8?B?U3RlcGhhbiBNw7xsbGVy?= <smueller@chronox.de>,
        Tim Chen <tim.c.chen@linux.intel.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: kdf108_init() takes over 250 ms
Thread-Topic: kdf108_init() takes over 250 ms
Thread-Index: AQHYtw5Jpbvx+xh0nkuELZMrH3udsK284slQ
Date:   Tue, 23 Aug 2022 20:10:01 +0000
Message-ID: <MW5PR84MB1842811C4EECC0F4B35B5FB3AB709@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <6d6b6bcf-cab8-695b-568a-c1372ac531ee@molgen.mpg.de>
In-Reply-To: <6d6b6bcf-cab8-695b-568a-c1372ac531ee@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea69dd9a-f306-4e79-39c2-08da854375bb
x-ms-traffictypediagnostic: SJ0PR84MB1966:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25x66wp0v85wFppSy611CfT69ToFGXa5Xma0tSY+5j+fjC90MWVCNc1p1mDguK/NyxnVlXWJ+KwLUJrsKLubl+KhAMDZPQGw2ccv2SMRCVqZd+1l1O9oJEes4gj750FGE4wbYClMJeTx4HTdAXtu4uTs0aXHjstvWzP9IGKu3b6QhN70BjIGjIm/eYymSwQXXaISEouY72g6lGQpJelsTy+M2yisiJFFN4JH5fRCrs1PEkOgSpMnM+/aLlHFvbD3oes6Ta605rJCwzgiPDE0t4r/SPbllYF95tbOdm7gUAsrv3k/771dfDG7WAYKOE+pdl0J3NEG47VduOi8wFwX/VKVlR77hgVOXrxfmLlp5HPd0k0lyHfXgu/GSEsm0TFrE0jggen2U/RTTjYe8UOJy7viK0ODXs4+Qnwceu2Jmibe4BTLxxfXY+kNOn1B9vbNBlMFIsT336KPixU0DCYFn6yx6bE8/o4lslj2msIQQSmVDCidG2MH4NsJL5bQbwHRLhRMiTl+oPtwsE/vsmzeLzr0lyY59CYgyyytK2cAfqCQ8ZASqEfUJb+Su7naGq1TFLTxUzAMfcxyCGUbqSH8j9gc1ZL0lBhpC1SPULIj7Y4gQpg0RVG2LTFkrucWXSgORakXpzh+JCImjoCsOWIAXYB7C6XhsOlmhAIjnlSFxFU+yH7jbjb4q7ueCAMaAEr/8Lbz3nVG6Ty4o3TYapOKk0Wk56ee+gdeBUYqIGeRH056YkZuabsSNzqwl0pECscegoQF7JSTdqeqC1XUxeBDHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(396003)(39860400002)(366004)(82960400001)(53546011)(7696005)(9686003)(6506007)(38070700005)(33656002)(26005)(41300700001)(86362001)(71200400001)(186003)(66574015)(83380400001)(478600001)(5660300002)(54906003)(64756008)(55016003)(4326008)(66556008)(76116006)(110136005)(66476007)(52536014)(66446008)(38100700002)(8676002)(66946007)(2906002)(8936002)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU9vVGlJTGJKUGU0MlYzNHQ0SDI0RVA5enRjRHR1M0dqSk10OWh1a0cvaGRO?=
 =?utf-8?B?eWtrWkZ6VUtKbnBoTUxHOUdBVDB0NFM4M1A0UnFkanB2SDRBVEpZNkU3QkZm?=
 =?utf-8?B?R2psZnFMM3Fvek8zQXJsYXRvRkNMWElZWUd0elJ5QW1VSEo2L0xYdXVXeG5X?=
 =?utf-8?B?bS92UElwS2pOcTNiREIzRFRWMGxQZUJXeVQyUFJIZGlQWVByT0tnTzFCVzJm?=
 =?utf-8?B?aTZ5TnRYdlNldWJwZGZXdXc4dkp2K2RPSjlrTkw4Y0c4NlU3dldOZFhPUWVM?=
 =?utf-8?B?eTBtTzF1R3FkNHk0RWVVMnVEUnFYQ3diZVd3MTFReS8xREJwQUZzQS9kZWhH?=
 =?utf-8?B?Q0hRdE14MFJjeTdoYmxCVFBvc1hTZVF2Ylh5WDhac2E1RUJDRkRNUDhSajIw?=
 =?utf-8?B?cm8rU3AxdnRrNVU3MjloNGxSRk8yd3ZFeWl3eEEyR3FhSWhIZ2d2MW5jTWt2?=
 =?utf-8?B?QldHYlJnV3locm9pQWY0NmZiUHc2Q3hrRGlpVXlLRWJ6cnFYd1lULzRWK3VU?=
 =?utf-8?B?aHYva2N3YmdnSDFNVVFEZExZYk5FZnVHNmxTNmhSWHFIZmZRdTRuOEtRVmhi?=
 =?utf-8?B?S1pYd2dLRTNKZWdEcVQ0amlMZFdkN2JuSzN1YXd3M0wxRFhhOHNxWTZFT3Js?=
 =?utf-8?B?UVptNiszK0lEZnNMQm9OK09XUmsyc216aVptMS92MyswT1FFWmdPV25TQUZG?=
 =?utf-8?B?eVhvRW0wZ3FOcEN5ejhwNmNGR3dpTUVoeXdqb1hmZGFzbEVSSmNrZmtYMmdX?=
 =?utf-8?B?OXZqTi9Vb2hZK05yZ21NL1JmL0t0cmlXUHFaaGdHVlRtNFM4cVp3clByWEcr?=
 =?utf-8?B?Yk9DWUFtYUhrL1hQSHFGOG9EVldIU1RDcFVlclkwS0xXQnNBOWc3a25IQ2Zs?=
 =?utf-8?B?OFlYNFlOUUZ0aHRyZXlObXBzT3lkRVNQVzlzWnZpMUhPclRTYW1XWUdyeE5s?=
 =?utf-8?B?UkRia0Fsa0o3YktBeEdaZUFjVld1OU91RGp0WkRHeUZ1MUlYM3A1aHlWclhT?=
 =?utf-8?B?ZDNyTHZyNFJ4NjlwUGNhRW9STEpxa2xLNk9yS21WYTdzNjJvQkswYVBjUEQr?=
 =?utf-8?B?dDVHdzZGeDZnRWdsTmNlRzhJd0dDVmRhN3M0VTdSeDMxcDVhVW5OTHV5bXJy?=
 =?utf-8?B?RmI2R3cwYTZIUHJqRzhPNUUwMExzZUtoK2pDREowaDJXTkdMNTgyaFl4WHZs?=
 =?utf-8?B?bTg1K3dSa1VpdHN3MFlzQ25WU08rdVBNM29BanZiOFY4a3N0RG1wUHRiMW5o?=
 =?utf-8?B?Uk9FM3RvaUxvRFZhMHI5dU5maDJrbDdYUW9maVN4Q3JzdXhPUGZTMkJ3U1o2?=
 =?utf-8?B?Y0ZFb2h3VVJsdVVWREpZYTh0ZWVIaWNoMTJXVDVWeGxkVVBPK2ZiLzc0UkJk?=
 =?utf-8?B?b21OTUZzcTl2MDl3WUxSWldqeThISHNna0wxTWNmdC93amh5ZGNIeGJvT1pK?=
 =?utf-8?B?M1VHN2JzUHBaRjRidGs2TjRWZmo5VWdqbURQcVJPK2ZOaCtua2ZlWVRPQjNo?=
 =?utf-8?B?cnEzRkQrMFZBT2hGeEUxSm1tTERSZHh5bjV0TjByTy9KcXBHYTNrOE5IcHcv?=
 =?utf-8?B?V3M2MkpKdmdzbi9LOEVEcElpc1d3OGpCdWNsRWhWZzRURytkTkFqMkEvTWM1?=
 =?utf-8?B?N0lvU2lBN1YyKzM1K1FJZUZJN1FtelhXTVp6T1ZhOW9uREpkMGhNQVNINGhy?=
 =?utf-8?B?NTQ4c01JWWZOWlhseGJFaEwrV1ZqZnNZNk4xcDFER3lLMllBMDRpNDErR2Ex?=
 =?utf-8?B?dXBQM1dmOTdBNi8yUU02OXRtRUZ1bHNNQVpmSDRabTZEVDdLc2JWMStTME5j?=
 =?utf-8?B?dmtKdG5tSlJ0SUZMc1h6WXVSc2tQM2JXOXRTeTBrUmZXLzZDaU1EdHRMblBV?=
 =?utf-8?B?T3lsa0U4NEZxcW9IVnBaNWEwcUFnbzZRZ243UzljUE43Wk1qa2NhNVk0QURa?=
 =?utf-8?B?TEMwVnVXNnVTVVBHdldMT2drRDZpZzNUenFSTHlnS3RmQTNuTTJYaXB4WjFi?=
 =?utf-8?B?UFJ5WmU5cXNEbERsdXZmWEM5ZFVOSW9IZnhNYTdLWEY4bWd5NGhHYXg5ZlVk?=
 =?utf-8?B?WmpuY2YrM3RlNTVxYUZHRlg1Skd1Z3lvV2dQZXhJZmxnR3R3T3Bzd01ZMm9a?=
 =?utf-8?Q?Tg90=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ea69dd9a-f306-4e79-39c2-08da854375bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 20:10:01.0228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOM1gz+aDM++zl5WZqiqo7f+d+lKbmQ81ZIU28PLcnmrmRWhOrHJ80IpzLba+xrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1966
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 1EcmRxg5Tq7uRct-oxRt0IjQVqkQx-wC
X-Proofpoint-ORIG-GUID: 1EcmRxg5Tq7uRct-oxRt0IjQVqkQx-wC
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVu
emVsQG1vbGdlbi5tcGcuZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyMywgMjAyMiA5OjUy
IEFNDQo+IFRvOiBTdGVwaGFuIE3DvGxsZXIgPHNtdWVsbGVyQGNocm9ub3guZGU+DQo+IENjOiBI
ZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+OyBEYXZpZCBTLiBNaWxsZXIN
Cj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnOyBM
S01MIDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDoga2RmMTA4
X2luaXQoKSB0YWtlcyBvdmVyIDI1MCBtcw0KPiANCj4gRGVhciBTdGVwaGFuLA0KPiANCj4gT24g
dGhlIERlbGwgWFBTIDEzIDkzNzAgd2l0aCBEZWJpYW4gc2lkL3Vuc3RhYmxlLCBJIG5vdGljZWQg
d2l0aCBMaW51eA0KPiA1LjE4LjE2LCB0aGF0ICBgY3J5cHRvX2tkZjEwOF9pbml0KClgIHRha2Vz
IDI2MyBtcyB0byBydW4gZXZlbiB3aXRoDQo+IGRpc2FibGVkIHNlbGYtdGVzdHM6DQo+IA0KLi4u
DQo+IFsgICAgMC4wMDAwMDBdIENvbW1hbmQgbGluZTogQk9PVF9JTUFHRT0vdm1saW51ei01LjE4
LjAtNC1hbWQ2NA0KPiByb290PVVVSUQ9NTZmMzk4ZTAtMWUyNS00ZmRhLWFhOWYtNjExZGVjZTRi
MzMzIHJvIHF1aWV0DQo+IG1vZHVsZV9ibGFja2xpc3Q9cHNtb3VzZSBpbml0Y2FsbF9kZWJ1ZyBs
b2dfYnVmX2xlbj00TSBjcnlwdG9tZ3Iubm90ZXN0cw0KLi4uDQo+IFsgICAgMC4yNzIxMjddIGNh
bGxpbmcgIGNyeXB0b19rZGYxMDhfaW5pdCsweDAvMHgxNDkgQCAxDQo+IFsgICAgMC41MzA3ODdd
IEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogMzkzMzJLDQo+IFsgICAgMC41MzQ2NjddIGFsZzogc2Vs
Zi10ZXN0cyBkaXNhYmxlZA0KPiBbICAgIDAuNTM0NzAxXSBhbGc6IHNlbGYtdGVzdHMgZm9yIENU
Ui1LREYgKGhtYWMoc2hhMjU2KSkgcGFzc2VkDQo+IFsgICAgMC41MzQ3MDNdIGluaXRjYWxsIGNy
eXB0b19rZGYxMDhfaW5pdCsweDAvMHgxNDkgcmV0dXJuZWQgMCBhZnRlcg0KPiAyNjI1NzMgdXNl
Y3MNCi4uLg0KPiANCj4gV2l0aCBzZWxmLXRlc3RzIGVuYWJsZWQgaXTigJlzIG9ubHkgbGVzcyB0
aGFuIGEgbWlsbGlzZWNvbmQgbG9uZ2VyLg0KPiANCj4gYGBgDQo+IFsgICAgMC4yODIzODldIGNh
bGxpbmcgIGNyeXB0b19rZGYxMDhfaW5pdCsweDAvMHgxNDkgQCAxDQo+IFsgICAgMC41NDEwOTZd
IEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogMzkzMzJLDQo+IFsgICAgMC41NDU2NzRdIGFsZzogc2Vs
Zi10ZXN0cyBmb3IgQ1RSLUtERiAoaG1hYyhzaGEyNTYpKSBwYXNzZWQNCj4gWyAgICAwLjU0NTY3
Nl0gaW5pdGNhbGwgY3J5cHRvX2tkZjEwOF9pbml0KzB4MC8weDE0OSByZXR1cm5lZCAwIGFmdGVy
DQo+IDI2MzI4NCB1c2Vjcw0KPiBgYGANCg0KY3J5cHRvX2tkZjEwOF9pbml0KCkgY2FsbCBpdHMg
c2VsZi10ZXN0IGZ1bmN0aW9uIGRpcmVjdGx5IHJhdGhlcg0KdGhhdCBhbGdfdGVzdCgpLCB3aGlj
aCBpbXBsZW1lbnRzIHRoYXQgbm90ZXN0cyBmbGFnLiBNYXliZSBpdA0Kc2hvdWxkIGdvIHRocm91
Z2ggYWxnX3Rlc3QoKS4NCg0KT3V0c2lkZSBvZiB0aGF0LCBjaGVjayB0aGF0IFRpbSdzIHg4Ni1v
cHRpbWl6ZWQgU0hBLTI1NiBtb2R1bGUNCmlzIGxvYWRlZCwgc28gaXQgaXMgdXNlZCByYXRoZXIg
dGhhbiB0aGUgZ2VuZXJpYyBpbXBsZW1lbnRhdGlvbi4NCk9uZSBteSBzeXN0ZW0sIHRoYXQgaW1w
cm92ZXMgdGhlIGtkZjEwOCBpbml0aWFsaXphdGlvbiB0aW1lIA0KZnJvbSAxLjQgcyB0byAwLjM4
IHM6DQoNCldpdGggc2hhMjU2X2dlbmVyaWM6DQogIGluaXRjYWxsIHNoYTI1Nl9nZW5lcmljX21v
ZF9pbml0KzB4MC8weDE2IHJldHVybmVkIDAgYWZ0ZXIgMCB1c2Vjcw0KICAuLi4NCiAgaW5pdGNh
bGwgY3J5cHRvX2tkZjEwOF9pbml0KzB4MC8weDE4ZCByZXR1cm5lZCAwIGFmdGVyIDE0MjU2NDAg
dXNlY3MNCg0KV2l0aCBzaGEyNTZfc3NzZTMgKHVzaW5nIGl0cyBBVlgyIGltcGxlbWVudGF0aW9u
KToNCiAgaW5pdGNhbGwgc2hhMjU2X3Nzc2UzX21vZF9pbml0KzB4MC8weDFiZiByZXR1cm5lZCAw
IGFmdGVyIDEyMTQ4IHVzZWNzDQogIC4uLg0KICBpbml0Y2FsbCBjcnlwdG9fa2RmMTA4X2luaXQr
MHgwLzB4MTUzIHJldHVybmVkIDAgYWZ0ZXIgMzgyNzk5IHVzZWNzDQoNClRoYXQncyBjb250cm9s
bGVkIGJ5IENPTkZJR19DUllQVE9fU0hBMjU2X1NTU0UzLg0KDQoNCg==
