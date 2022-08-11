Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A4058F50B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiHKABA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHKAA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:00:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999047665
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:00:56 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGueRx027421
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:00:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xbYGRBraTerr9MwZZ0vAa5dQjjwdmyAUc2fXGamxLqA=;
 b=ZlCniEYgUDz0b7KsfIQx4TIKt8AnNBRmjGSq9poepgKJmBo2AUfUzBGdRhgcBcMz76N+
 7/ydI0O+CCTWr/caDr5EERvhhaYue/N1FOU/idJ3D6rBNagUO0CttJRxuOQofKI07H+d
 DvyHgBUXTyM+f2Og8jMWEBb8fpMSqUK++LM= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb6d8sc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF4J7gUHATO7knxTDJEWStBEdkCT5BWJoHsuXvyDt6f598e7TfWT0ot24Yakqoq8hUIHowq8hjFfrNlN0v5IOPx+qAl/mZ4em7yWZNhORAnHGfht4vIaVwgXKJz9AfTju5GdfmOIPGg0tkpvF5Vm7Ihd1AfI0+PEqa+cbGyTgu3kn6QXcXtsBfAqnU+5uhqBQu55vZz32uUOGQ3a4GTnzzXsu2oGb4KXczaQlVvypUOPiADtWRNw1bpfkFW97GroTAcHuamXGyxYBAAD93MkR1zJfdlaAfhRJNQ1xjx8LP9rvk6uQWVllOCSNsVl5xPTDyDsNDBn73XFZx2yQmIg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbYGRBraTerr9MwZZ0vAa5dQjjwdmyAUc2fXGamxLqA=;
 b=Xg+F6EzeO17U33kPco6t1hq0XPTjpECEjhj/SPzrv7TgWBEo1M6jMalO7Wa527C1dQN4L66+PxKrdmwKDM+Wxpmnc34ULy8gexQvN+np7fwU2liyGap8h+zQKFWqw38ZDin28WLx+0jaNdmu2CUqfqt+b95W7Nt7mRmJNPl+spOiC9CrqqHz3YoR6Qog+1dxdjNRir5Gk3X3r/XrqxN0zlyCZ6Cx9M2eHUOYtvls6w7Z53WQLnhSz7XCI8DcS9N7HSIzrb6mAW3Bb8brJCCUviHAM4Ufmi6JumS9XW/cXjoKr45hJHLPX6QYsiXTJzqdvTjkSC5Ffj+Y45LbHd165A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by PH0PR15MB4229.namprd15.prod.outlook.com (2603:10b6:510:1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 00:00:53 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5525.011; Thu, 11 Aug
 2022 00:00:52 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Yang Shi <shy828301@gmail.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Index: AQHYqPrSmG3WqzybNUurgyMbb9mveq2gpnsAgAAD8ACAAAWRgIAAB5EAgASWfICAAAsqAIABevqAgAABMACAAGoqAIABJd4AgAAB+gCAAAsNgIAAPuUAgAAEtACAACLbgA==
Date:   Thu, 11 Aug 2022 00:00:52 +0000
Message-ID: <DD679B3A-BDF7-4EBD-AAC2-A663057AC8E3@fb.com>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
 <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com>
 <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com>
 <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com>
 <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com>
 <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
 <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com>
 <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com>
 <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
 <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com>
 <CAOUHufas1o1Ez9EDSjjxsO-w6Ph6Km8R8yOX+1_c=4LvG6DEWw@mail.gmail.com>
In-Reply-To: <CAOUHufas1o1Ez9EDSjjxsO-w6Ph6Km8R8yOX+1_c=4LvG6DEWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e559ce4-99c3-4639-0ba6-08da7b2c8e9a
x-ms-traffictypediagnostic: PH0PR15MB4229:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: shz1Pt7gv6RofO77zKu9ekgOUJTyHr5VCqkaaLH3ivWSRaOsCa6apUadBa0awXFP2tBEK0dlR5DWvmqPrQCYwAqWNpyYV/TUaAOW8cmuiOYqsoOnfTGfpsVNfDu0Oa9/rLC3HG8nqEIEa2NOXG8+vB9g+q4tACEcKkeiIXY1OyO8/lP51M53oFsewnlsjuNr2si667rfdKQ2nXbTnb+FV24RE2+4+cI4tr01s2sLJiFbqHSebvZ5jqJBjAukIjEjk1ACxM/8XTpoSMkslGbH4E+7E+zJhpQtyPdMWceJmSSk/sfz2TK8HTG+JMdc51h5a+4mhnJEl9AV7NCSNyfj9f+UsdLsACwiKjy3GpzTi5urG+4xPR2N0JSe8tdNZb+cx7EMc/7yuSQMyFnGiadUwUBg+1HWdT4feObRDvScbPoWhwwCtoO7Fn/Zq3icBURQ2S/bCrJESquJQpQVsrJFjiW/hwHwuoeOygO36jdAxyxXSMrKtU7QvbtRQlYlZeXl7zvHdu0jTP+FrskVV6Y2mzFzXrKm60twa4xbyFzl0m9TB0aH9vM0Eunp+97bpBSIfEE0186uAgcAeiMgQiSfw/MxLnNBbB+moR0orNtz3ZTjzsHEK4Bhs4qwDj1jxZJ5/EtdD2b7vncoyaRVXsquE7IzHoROTJmuuw38HSxB5oLfXHsxOEdYDLn1lS9JyGEvLuVisVkvgOj2f1Bh986S+UfeQ3xB63ldMRvps0Y26iQ0c/4dsAuLZilFXChMcnQYBjYpF1OTP52jbhNbIbm1yjDbWZANUOz1917/7YU3Rf4Wf3ibx5N2x9DBOCAW1538hE5HfKHBfe/gP2HAqmLpKSSsdTOULsyh4nkW8GwfRFXEThxCArP7GGa20tCC501DvDYb06iWYYpAgVsQ3BRLaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(66946007)(8676002)(66476007)(76116006)(4326008)(64756008)(66446008)(91956017)(66556008)(38070700005)(5660300002)(83380400001)(2616005)(71200400001)(41300700001)(186003)(6486002)(478600001)(8936002)(33656002)(6512007)(2906002)(86362001)(54906003)(36756003)(966005)(6916009)(122000001)(38100700002)(6506007)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nnp5L2ZWQUlicDFyeWQ0NHBLZG5vNWpmMUZtakd5YnNFaytTNFdHcjIxVHY1?=
 =?utf-8?B?dVZkOWhaM29WUmZvZXBlYXJCYmdSMXgzSnR3VFUrbE00bmpqY1VYMmp2UGox?=
 =?utf-8?B?dkJmaldiSDYzSmgwMjlPQmw1ckthaUdJSzJRZEFuQXpzNFlKd3owZndSSGt6?=
 =?utf-8?B?Q2w5Qm00U3Z0emx3TUlHRk12NkJwcWRpMC9lOWlraEtzTk9oU2pSeEJJaS90?=
 =?utf-8?B?Vm12dUUrVjhIZk9QemxVNytyb2RhNVBhbW0za2ZWRFhYQ1NZYk5lZE9jSzJL?=
 =?utf-8?B?K0w1R0ZSNTJIcnJyTEExZHg1UWNIdXRYYzNIWnRmM2dtNGNudFRnUmo1bndW?=
 =?utf-8?B?WXJ0RnFLTFBNRU1oaXF3OEtSMVJ0ZEk4S2Fna1R6SkwzL2E4MXU5cGIvaXJR?=
 =?utf-8?B?YU5LS092MWtMYUI4RU9iQ1dpaVRSL1VNUDUxV2NKWUs0YlJIODNVeGQ2UmdE?=
 =?utf-8?B?Vk5uQXpFV0Nsckhyd2hZV3F0UnNFWkMzTll4a3BaUHd4SDhzZld6QWZTZC9o?=
 =?utf-8?B?bE85bVFWMkJDTUdMbllaaWJseFdQMTNqOUY1eU45OU5aWDRhTHpZdzRZNlNY?=
 =?utf-8?B?dU5mTVZid29sZUt2bXJqRmRRWEtxY3lFaGNKTTYySmhyQ3YzaElnazNpelhV?=
 =?utf-8?B?TW5hcFdYTUtRV3V4K0ZINHRaZytabUdSU1lzOU1PYWpSZDg5WDBsQStOdlVK?=
 =?utf-8?B?K0tuczZLVnJpTC90WUMwa3FvUzdzQUdzZ1ZSMkJaV25OQ1JEUllRYXBoR2di?=
 =?utf-8?B?MnkxczFSTkVaUWllelIxSHJZWjVBK3hoUHNpVnRMY3l4TC9jWFpPZ0MxdmpY?=
 =?utf-8?B?TEdldDFTUE9neVJBcHRBN1Zuei90ZTZLS3lNM1FhOWd4cmJOTEQwR09HeVZa?=
 =?utf-8?B?QjRMV3dkK1RYMHM5WFdrM3R0aytGOVRBVGdBaXByQTV4RWNnTTZ5Zk4vejNQ?=
 =?utf-8?B?Q1lUU1B1ZmJPaEVNR0JKNVo1dU9yWmUvUjd5a2tyd3VKeFp0c21COFArWjA3?=
 =?utf-8?B?ZmJWZGJsT2VtTE5aU3dQK05kM2dwaGdtRSt1cys3d0srTmdKS3FaN0xzWlZL?=
 =?utf-8?B?QmozWGVReUdveW5zS0puM2pFaGNyUjhUUVZtTG9pK0x3Nmx4dFZCUDBtRTJD?=
 =?utf-8?B?OEc2alNieVFPdHZnNzlISzZmYUc3cXI0YWNodnVCNEdWNUUzaXIzR2h4RHQr?=
 =?utf-8?B?ZU15RnJVSWVrakI2MnY2M1lhd3RXdGw3eXQwTUFYM2M0dmNCWTJhNWx4UzBk?=
 =?utf-8?B?MG1nZlM5dSs1YXZWKzRGdmlsVWVycUhzRlN3ZW96dTVOWkVSeVBvK0ZIWFgw?=
 =?utf-8?B?QmcxREJ4ckF4b0Jab0FQNG1HVzBGWWUzR24xNENwWktEU3VEQk9nMXd0RG1Z?=
 =?utf-8?B?aWFhOGErblQ5cUYvMU5iNVlCdmJrQU9GcVNDSVZxY0RIQVBrWGh2OHg3TW9z?=
 =?utf-8?B?VDA4NjZKNzVZWTlDTXYySWVPelRzdVVWdEp5VEh2Ylhxd1Y1RzJZT0RydlA4?=
 =?utf-8?B?d2pMZWNaRFNMRWUreUNwSXVHY1JLN0F2MmZsRElxM1U1a2VNSzYrY1lVZVQw?=
 =?utf-8?B?VXprUXUyeHlwSTE5N2FXWWJmQklnaTF6aWpDVGVpaEtYWVhkTWVkNG5YaXNm?=
 =?utf-8?B?ZFZiWDQvWWY1T0VmRUJZRUFmWWY4cU9SV1hCV2granM4RDlGM2kzZVhEZkxN?=
 =?utf-8?B?NTJ5d09BUE5YRno1dkdzbzNCcXhFRnZqR3VnWXRVWmZjQ0FMamlKa2tKdFNB?=
 =?utf-8?B?WjlmclRXamM0WHNQcXNoSUxuN3kvSDgyUVdabkh2eDdqMGZqT0ZwYlNQcjdL?=
 =?utf-8?B?aEU2QVE2ZVo2am04UWR6NXpQblplclI5YmFlZkZRTWo1YVh3ME1UVEl0ckVI?=
 =?utf-8?B?M3N4cGpGelpYZFp5NXRmaHFuWEJSd01EZ1Z0ZHFhdnliVnQrL0pFWXlCWCti?=
 =?utf-8?B?bHorUUx1VzhldithanlUVytYL3R3MjdwRjhIOUxSY1V0UlAwNi9RbGNxVTBp?=
 =?utf-8?B?WXdDMm5GekZIMGt1dHBBK0VaVWlSdEpDYnBqdUNQbEtuTy9xZmFxd0l2b2px?=
 =?utf-8?B?dzY5YkNQczFmTURhUWFWN0NBSm1TU1dIN1ZZQzF5M1Y2UUREY2twRXIxYkRX?=
 =?utf-8?B?Y3RMLysvelptbkxKRjVWVDh0RzNqZ1NTWlM1ZDNNRmFlbVRoRXZiaThETzE0?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF7401B49B37F447BB9FA9EA638D99A3@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e559ce4-99c3-4639-0ba6-08da7b2c8e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 00:00:52.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ni9EL9eY73EmikJytyAKlAJzo+WPwKnEN/xn8NAOpwrXb7dNvB4y7Z1ehh6TEG5l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4229
X-Proofpoint-GUID: 0riUHrZ0inU40xk6Zi8IjKrPCK0KHoz0
X-Proofpoint-ORIG-GUID: 0riUHrZ0inU40xk6Zi8IjKrPCK0KHoz0
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_16,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFdoaWNoIHNlcmllcyBhcmUgeW91IHRhbGtpbmcgYWJvdXQ/IEkgbGlzdGVkIHR3byBzZXJp
ZXMgYW5kIHRoZXkgYXJlDQo+IHZlcnkgZGlmZmVyZW50IG9uIHRoZSBjb2RlIGxldmVsLg0KPiAN
Cg0KSSB3YXMgcmVmZXJyaW5nIHRvIHRoZSBzZWNvbmQgcGF0Y2g6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8xNjM1NDIyMjE1LTk5Mzk0LTEtZ2l0LXNlbmQtZW1haWwtbmluZ3poYW5nQGxp
bnV4LmFsaWJhYmEuY29tLy4gDQoNClRoaXMgcGF0Y2hzZXQgYWRkcyB0aGUgVEhQIHNocmlua2lu
ZyBhcyBwYXJ0IG9mIHNocmlua19scnV2ZWMgaW4gbW0vdm1zY2FuLmMuIFdlIGNyZWF0ZSBhIG5l
dyBzaHJpbmtlciB0aGF0IHNocmlua3MgVEhQcyBiYXNlZCBvZmYgdGhlIHJlc3VsdHMNCm9mIHRo
ZSBzY2FubmluZyBpbXBsZW1lbnRlZCBpbiB0aGlzIHRocF91dGlsaXphdGlvbiBwYXRjaC4gV2Ug
YWxzbyBkbyBub3QgaGF2ZSBhbnkgb2YgdGhlIGFkZGl0aW9uYWwga25vYnMgZm9yIGNvbnRyb2xs
aW5nIFRIUCByZWNsYWltIHRoYXQgdGhlIHBhdGNoc2V0IGFib3ZlIGhhcy4gVGhhdCBzZWVtcyB1
bm5lY2Vzc2FyeSBpbiB0aGUgaW5pdGlhbCBwYXRjaCBhcyBzaHJpbmtpbmcgVEhQcyB0aGF0IGFy
ZSBhbG1vc3QgZW50aXJlbHkgemVybyBwYWdlcyBzaG91bGQgb25seSBpbXByb3ZlIHBlcmZvcm1h
bmNlLiANCg0KSSBiZWxpZXZlIHRoZSByZXN1bHRpbmcgaW1wbGVtZW50YXRpb24gd2UgaGF2ZSBp
cyBzaW1wbGVyIGFuZCBlYXNpZXIgdG8gdW5kZXJzdGFuZCB0aGFuIHRoZSBhYm92ZSBwYXRjaHNl
dC4gQnkgaWRlbnRpZnlpbmcgYW5kIGZyZWVpbmcgdW5kZXJ1dGlsaXplZCBUSFBzIHdlIGhvcGUg
dG8gZXZlbnR1YWxseSBkZXByZWNhdGUgbWFkdmlzZSBlbnRpcmVseSBhbmQgaGF2ZSBUSFAgYWx3
YXlzIGVuYWJsZWQuIA0KDQo+IFRoZSAybmQgcGF0Y2ggZnJvbSB0aGUgZmlyc3Qgc2VyaWVzIGRv
ZXMgZXhhY3RseSB0aGlzLg0KPiANCj4+IGJ1dCBpdOKAmXMgd29ydGggZGlzY3Vzc2luZyB3aGV0
aGVyIHRvIGZyZWUgemVybyBwYWdlcyBpbW1lZGlhdGVseSBvciB0byBhZGQgdG8gbHJ1dmVjIHRv
IGZyZWUgZXZlbnR1YWxseS4NCj4gDQo+IEFuZCB0aGF0IHBhdGNoIGNhbiBiZSBvbWl0dGVkIGlm
IHRoZSB0aGlyZCBsaW5rIChhIHNpbmdsZSBwYXRjaCwgbm90IGENCj4gc2VyaWVzKSBpcyB1c2Vk
LCB3aGljaCBtYWtlcyB0aGUgd29ya2Zsb3cgImFkZCB0byBscnV2ZWMgdG8gZnJlZQ0KPiBldmVu
dHVhbGx5Ii4NCj4gDQo+PiBJIGJlbGlldmUgdGhlIHNwbGl0X2h1Z2VfcGFnZSgpIGNoYW5nZXMg
Y291bGQgYmUgdmFsdWFibGUgYnkgYXMgYSBwYXRjaCBieSBpdHNlbGYgdGhvdWdoLiBXaWxsIHNl
bmQgdGhhdCBvdXQgc2hvcnRseS4NCg0KUmVmZXJyaW5nIHRvIHRoaXMgcGF0Y2g6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvMjAyMTA3MzEwNjM5MzguMTM5MTYwMi0xLXl1emhhb0Bnb29nbGUu
Y29tLy4gDQoNCldlIGRvIGluZGVlZCBkbyBzb21ldGhpbmcgc2ltaWxhciB0byBwYXRjaGVzIDEg
YW5kIDMuIFdlIG1heSBiZSBhYmxlIHRvIG1ha2UgdXNlIG9mIHRoaXMgaW5zdGVhZCwgSeKAmWxs
IHRha2UgYSBjbG9zZXIgbG9vay4gDQoNCg0K
