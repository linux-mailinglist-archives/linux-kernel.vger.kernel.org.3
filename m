Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193465A706D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiH3WOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiH3WOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:14:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D169F64
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:14:21 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27ULs4hv024172
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:54:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=iE7cyKyBU+H+ieHOcgts98bSvI1K/S2/FgVTjZTtzvk=;
 b=RdZOEX1NwW/7hYHYh2Qu5H5s4cXF24tCuQ/2QVj7grx+Ds2ir35qQTpZ5xQPtXdMn3tk
 7KPyvlacJVNJO2qskmuBgvrsDE9Ws5LhKgzASO6p7WhX2Rc8BGpOLgV/id3ok03hgE6f
 p19ZJJpq9iFLHMqYvperdxIJFnYNvrvEj+g= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j9nkrtj9w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAvAJ3p/N4h+TH549p+IljrQLEdMhjGtWywHJfwulR85ZjcSzn4ZfskI/yyd6wafHM8wH9UHtaA5i5B0/si2O0d15wA5fec1EVkhnHZrSjr+WvthKQLUOIeI6UoGtofXKPoNNN2O0csjpuzSqAZtYn7n9MQcOPkwjXirJc8AszBZDfaR+NDW0UKu/MdFpE3TzVfTxj3MonWIFx87zzhqGLJo/57Ae5PJ441VvSdQT0PMZJphoN1hLTvChQVFCepnWh1mdnxuiYX7AGqgOXf8p+CHSfq1ECHjOjAMQPQur4NVZwYgRs8/pK37fsuMUOJrGauJSgtvikb4SKaOjDDfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE7cyKyBU+H+ieHOcgts98bSvI1K/S2/FgVTjZTtzvk=;
 b=PGT62yaAU2qFCBwWEm99tOKslnQTb5vOoBFtyRd4gWyePSs07F2YFN9qcdwsauhTqSUgm1AYVJ48hGNthrC6Y8OOhVjxlTpX3VPle/7h1r0+4CTMVgU947f/ScpMRQ7YCLKf7/t+3fJEN1+f/svu6Fiqy/Gnjte8pP4sDfdVtcNiA9NTU0ITyoQ0+TGp755wA1Mu6GEcwoizbQkgehoHXgY4LfbDciZ3fZMqHRzPoD6PFU3eGRwM3dPCWlCp02yUlr6vLBKBcPvAZu3HIxcwa5CCVIUKghl7hdRnTSzAiKGUvzc+waRWU8z2dyxGia9fX137ZkK56w0HqINJviCyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5078.namprd15.prod.outlook.com (2603:10b6:806:1dd::16)
 by SA0PR15MB3838.namprd15.prod.outlook.com (2603:10b6:806:88::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 21:54:55 +0000
Received: from SA1PR15MB5078.namprd15.prod.outlook.com
 ([fe80::c82a:6d82:5e66:cdf9]) by SA1PR15MB5078.namprd15.prod.outlook.com
 ([fe80::c82a:6d82:5e66:cdf9%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 21:54:55 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Rik van Riel <riel@surriel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
Thread-Topic: [RFC 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
Thread-Index: AQHYuMfP12/URiDwn0CzT9+YyQULcK3A+PIAgAC4WwCAA/n0AIAANnWAgAGGNACAAJzMAA==
Date:   Tue, 30 Aug 2022 21:54:55 +0000
Message-ID: <A92C4953-F9BC-4687-BB03-2202D94D6F5D@fb.com>
References: <cover.1661461643.git.alexlzhu@fb.com>
 <490fcdd204ae129a2e43614a569a1cf4bdde9196.1661461643.git.alexlzhu@fb.com>
 <ead1bc0e-c9df-d590-3423-9cfa449167e7@redhat.com>
 <6448b9a8dba8ef39e42e56a3c0ce0633fff7c6a6.camel@surriel.com>
 <42c164c6-8c69-7b4b-d965-ac62d1607061@redhat.com>
 <37db29410990991555362154a371b58f47d3cb0c.camel@surriel.com>
 <00f2dee2-ebc1-e732-f230-bc5b17da9f80@redhat.com>
In-Reply-To: <00f2dee2-ebc1-e732-f230-bc5b17da9f80@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2508fff-311b-4b9e-0990-08da8ad24669
x-ms-traffictypediagnostic: SA0PR15MB3838:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+kcNqqgQRvXD5pPsbQGvtuZ4TvRBUorlARlUf10FhZFZ4p72YpgaRrev7IcPpoyJc8Si2EL+Y3/6fSEYO20xN6ERZ6HR6k2FJFm7rDMjD1M9t5553Qkjl5KFiAz4EzpTjHXD/EBSl1TV2h3j+qn3xZL53DTJKEu1wNz1KPHqk00E0k02Ht3ccNVx55nVHWfPBUtB5MES/mSwLfBgmoGdh0WLDoxpsxKBTeeXEu80qF7MOeEWCAb6cTu/8SGO4UNZWxQQaXCPmiyZhWYTXG2gDLqSglbUOzWOmtKR3CDhR26zjUTh1YMqBo3nYF9ZjJbgTubnOTo/ZhjHRw3mx17RFAYJ/De7GJonc4ighsd+i2XduAozbCZXjyd0VR6nYmYLZc/dede9IjEdZ9XFDxGAMDyjgu8z11aELPKJ/4kJ7s0GF6aZ6wPwGGxHDKpey2sedT+KUq7keuqPBOyfTUhi/bgcamXApM+2Q62gza2YlH+F6s8guswPwlVHiOwR+hD7Q0nTJgQJCvMyps5GzJAkWaHptzVRjA+s9VrA4kxHqELGZqhW9AsenrzIzHPQjC7jtQ/qCWGWOvN4Le+aT7mD2NGqlobReU+R2chUSSIswcARzsuqzA+fhXaBBCGF6mG3SrIycZWow01hj+ys4oBNZxCNzhRKhS974k7rloLjpI+9iFmNdrCloytgHLYtXFLSmCbJZUnD7QUTO5DnNOyjrM41Qt1jxDDz6dBiUHQFkfGP6+Ap5qrHzcZXv0R1V6EpHkWz9XFHwCCNj7q+C+r039VO/JhdpXEck46nVJQnZ1hNi4bQft3vYb6pKyJY0nT2cByZjDd+UuVlELYkQdk4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5078.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(6512007)(2906002)(4744005)(38100700002)(2616005)(122000001)(6506007)(33656002)(186003)(83380400001)(6916009)(66946007)(66446008)(4326008)(66476007)(66556008)(64756008)(76116006)(91956017)(8676002)(316002)(6486002)(71200400001)(38070700005)(86362001)(5660300002)(36756003)(8936002)(41300700001)(478600001)(54906003)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NYLas8HEoejSSPfgFaLtIMyl9CDu/qH8Bi5WFg77+e1PzaihVSjCjA29X9ww?=
 =?us-ascii?Q?O4H3nS9ed0ogIzqiGJLH+TQqTxLNEorkLxwpu8JELr+PCnC6khbk6YkcU0WP?=
 =?us-ascii?Q?wqRJ7Q3A3uxX/TQEIZ4ERhnWEFm2G2Z4UxAAJvVwg+PFemeq7ns2urZ22n72?=
 =?us-ascii?Q?NxaHUblhpXwf4Do/uQQcGvivH4tV08PzTGL7RiT5XIansNDGVmH3HygnZBYz?=
 =?us-ascii?Q?MX5lsDI4YIBBBshLEtX/ad+Uq3VevjdXEVtNwpmsvG3vnnkdqtC56b1wvYq6?=
 =?us-ascii?Q?52SQ5hCS2MdYYHm/Vxr3YReeOaxLuIdyuApU3xwOtpRe+RsCT5nU/H1vUqaz?=
 =?us-ascii?Q?TIWzpxemmkAkmK5sb3l7Nub7S6QrWLibXgH0zZ055oeJELZ7hQ8ex7XQ76A2?=
 =?us-ascii?Q?HQBGg5yXAo8+O6ZY/4S3sHHYiu6JxefhTsxUhafzJL6WSMEoNlyn7jR1pv7M?=
 =?us-ascii?Q?yzrqvRd7vYd19w54NNc8831EJrDPsX/HRD39Oy807MoQkVy9QMkxRLEUhylN?=
 =?us-ascii?Q?JyEYaDGHWOZRfsFqWv63ao6DZu2T4sXlpgjKlxbTHH7wmxwAZpsEJt4tNPFx?=
 =?us-ascii?Q?IuaZdxrH6yYgltEwB5+nvNq/DWGRhThw2PLypEdSdZGdOtk/rJZ5Ebh7Z6Wn?=
 =?us-ascii?Q?Ef+QGOl7EqkWGqk9G3pKK7BAKQcLmeZ0sKwofcfeWY5E9lz3R5q4R+D5BIVV?=
 =?us-ascii?Q?3mEIVg3Kr/AW07KWyg+1rNRMuRs9Qa1pDkmgpP6BSRi6YaVDIxgtGNwuTW+d?=
 =?us-ascii?Q?G4KQLO1J6irotN+FHZS7yfcuYsFe6i7IFL1D+Vq4uiDOLpcDHrwLgio+e4nu?=
 =?us-ascii?Q?U73WpJYuTpb50lxHVHoRN6ZFOoDu889LT1HyIvJ//+f2Sh9U06xudVXmpiy9?=
 =?us-ascii?Q?D5uwbv7jX0mHTJ/qDJgh4Wg2EnrFhKnRRBP1zHxPwVP6dC7sU4ZAnYSlWWS3?=
 =?us-ascii?Q?SMwuFZiVLo3sz3z/lhqyiRVoVR2+AOx5RhWjHRdRxAo0TszJSqmybOdq7mHW?=
 =?us-ascii?Q?mWfwlA8MIUV2G1hwCB4gRGdMdzUngS8d1hodQ0LmLLnzfvm9fVtSCxkWKe7K?=
 =?us-ascii?Q?ekN+41f3bq9q6Fgl9U/cLGCy0PNknzNMRJSe60BSzoOtsTikyMwgO2u1Tp0D?=
 =?us-ascii?Q?FkPPX4M58JB1YB1lgQLfG/79WXmyUNXA1B7HYdKKLwRYofkGM5h+0iwT4l3y?=
 =?us-ascii?Q?0xPXNnpnA0M+Wvc6O9hPrsEQtexiFuo0QafKe8DkEpo2OLy5wE5tjk+HvuVU?=
 =?us-ascii?Q?0fkUbrQ53WVxFDvb+cpxP+AEVKh8+hNgaVWGhwToOHA0LgTGycMZiWrdH9y3?=
 =?us-ascii?Q?e0wyMmVVLe51fTF9yVfLxTCzgKdShmVP8lMtMeTi2qDEjM/ZkO4TUT6Gid20?=
 =?us-ascii?Q?iFMBrMxgjsIBOQUvejMbSiLYlyYyBNWw03JYRgnXm7sfhjz662ArqT37TgNb?=
 =?us-ascii?Q?jQq6LzjXrC2FBmVRQjvK+24rmu95odVfYzQx7TTS3dOzhzGdjSnP+Mc33vzL?=
 =?us-ascii?Q?tzZA77jlOYeB7poRMWkX+3JmBaxy4FS2qfZoi//MULhV8oxIuydtAXkiz+Xc?=
 =?us-ascii?Q?55xCov2jRDYHPXHccjBeA0FZ1oTh6mwE9Va93Jp5/V8MsPEsR1wojC4W/9IJ?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1B5FFAE1B2DE84E929CD8C0ECE2A029@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5078.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2508fff-311b-4b9e-0990-08da8ad24669
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 21:54:55.5088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6iJ4+omEbQh0rT7TnOPz+c3XgKYsY3x2Axei9q0LJS8QYtvNYTUMrM3rD9bOqPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3838
X-Proofpoint-GUID: KH3vA1hmxMtZptgo_FfJeacvXuw3LaWg
X-Proofpoint-ORIG-GUID: KH3vA1hmxMtZptgo_FfJeacvXuw3LaWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If you unmap something (resulting in pte_none()) where previously
> something used to be mapped in a page table, you might suddenly inform
> the user space fault handler about a page fault that it doesn't expect,
> because it previously placed a page and did not zap that page itself
> (MADV_DONTNEED).
> 
> So at least with userfaultfd I think we have to be careful. Not sure if
> there are other corner cases (again, KSM behavior is interesting)
> 
> -- 
> Thanks,
> 
> David / dhildenb

We can implement it such that if userfaultfd is enabled on a VMA then instead of unmapping the zero page, 
we will map to a read only zero page.

The original patch from Yu Zhao frees zero pages only on reclaim, I am not sure
it needs to be this restricted though. In use cases where immediately freeing
zero pages does not work we can dedupe similar to how KSM does it. 
