Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E555A55C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiH2UuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH2UuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:50:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0926277
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:49:58 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKe3cg030818
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:49:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=mAT0D04OJ24s6D2oAthXnlmQZK6aqlMOtY8wAYUoPy4=;
 b=B7uOR6QPVsXbK4rDYX4+w8IOV6IYYwLQtXLifH6veZtIcABed76oHNMy1FnhzHBDH1zv
 f4z3cStmJYRI5/Hryga/GDzwweAmqHm/+t3FmWLQrYktyhmEzJ4KsfHgIFXGDhEJHKtT
 Z9QZUDljtVSIpR9eyoT1gJj8ofIb9HmmlFU= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j94gy84sb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un9/GU+D4W3s0C8bCuw19ZGPXlQzxke9ZdQutZDv2b4Sf/nulfhAYiPk67sC3jjSObW51gKugKzvZkQKew1Z2CrREkEoZKSr4AxPC65m9IFeqvK9MSILFFDRPqS84hFLak+4O5q+UyshvCf/wTHapHpDNLvw+iXCd7l1sOT/fptLKRg3XYy7lFfSfYzJxNKxWtlsg7NqLGphZl+bgFYmiWvvLnQEbM102/7LoIrGn8nytUdP7/P7NPnWGkfBVrSXx8vZcCDrPug0NkgEMGkc80K5NQak3QiGR9QOzcizUaiBYlQ8ahRfLEKoUNHzCmMquVSybKls5lPpbVZ31olWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAT0D04OJ24s6D2oAthXnlmQZK6aqlMOtY8wAYUoPy4=;
 b=HkymYO+C8+STa8y4A8KBMLL1ePnX/XfqH0mw5MFVVUr4Y7dO+muLpm5fswpq+d1RRiTux3LgLrgqe/QFBbGBjdiFSwmjjX8fmaCV7Uz+uNg0n7FEQfaLCmLBYgnP/dNAOqOvHHP9fEi3NGYRTHQeb6M2PLXSFroMoftm3F2TY8Rmh53S16tLOYGjLhMZPHTmlsipxwilQYdsuZpf4vl9VdDYY3xsh4LdP476e4RPa7u8fFKU5fo+5fbptKxVWkVrhRehJ4GdCr0hLjjF4o0LHLtZWh58PhQ6PzAbIwAHHSpEDLzI5ixt6hJoERuUzt11b8zsIbXdigY8TvyWmfQbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by BN8PR15MB2802.namprd15.prod.outlook.com (2603:10b6:408:d2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 20:49:31 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5566.021; Mon, 29 Aug
 2022 20:49:31 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "riel@surriel.com" <riel@surriel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 3/3] mm: THP low utilization shrinker
Thread-Topic: [RFC 3/3] mm: THP low utilization shrinker
Thread-Index: AQHYuMfZq+C4m2BzLEuV1fXJ2h4fp63B5ZUAgAR6hgA=
Date:   Mon, 29 Aug 2022 20:49:31 +0000
Message-ID: <12F2BA64-E7F8-49C6-B062-96DF48DF0192@fb.com>
References: <cover.1661461643.git.alexlzhu@fb.com>
 <ba2dfb44f4d4ec099dec0ca83790f4fb9ee02e72.1661461643.git.alexlzhu@fb.com>
 <4BA28B97-9E5C-4CF5-B6E1-A6AD27A1B6AC@nvidia.com>
In-Reply-To: <4BA28B97-9E5C-4CF5-B6E1-A6AD27A1B6AC@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1fb2b11-419c-4d8d-c936-08da89fff8e6
x-ms-traffictypediagnostic: BN8PR15MB2802:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BkJz+UFim+BLlXchTYmbLQNf45Q8w3X3lDA9gaeR9ZehAHMbm7RHlAW4MtGxBnon06oy2m3CEV4l7b42xjcj35X6rGPbGHumia0ToiQYsjYt959ab60Y2h4ysKKp6+7O4iKWSF0MG/YaCNvEupk2nTvLn2P2Eb7IymOsesTvK/aDKO/AVKspd4UZ1NFoER/xpI4URtcsC4mnl3dLrDj5CMNSjIhxMsYI7XlZ09hPUR64bu6tDruyJr868knFv4vEfhg4gwgdVYUopByQov1iBtBhf7rsJ9BFFx/grqab6OBk4co/Gd1XUBf9ioEPf29YPFLkYTPpCnVuTvYcBAsSl9u+V1H+nOmjrH6zFvDpPFOlcEuD8oLRujwPq2UDJ5+0/SmJ/DynOcQwVJUCry6ctbDZFtZZYJclP/FFRuejjJwOmY4+l43VQSpFBngOE2aR2u5Hr45n2dXOhuAtZ1i47/K/0lycgCA0Ycr4ImD+lrjNSNAKJXeVkL54s4mtSrV4l1OGepSGM6N2O+1PCVWtZlpYJQxoroD8ZqNrH9/WRafSe+NDK8epoHwOv9oJPamItN89YdVWm0oMfcmVTFHEXwh5FAfiuWGqk7xONPYFSPVnXlf6Z3SQNOlqtL6wKLIrBozUqR66VnqTbsrRQH6DhouBg/Ri3Ny4OyD3h9NP9nmpum/MGwxXLDHoAR/+JMQ0Pzy7Kr9ZJlzwo0xwLjKEQDzQOli7GQ7DWUtJYMmlbvWW/nQosXjxn94FKHXLR2nIPNdn3DsjLQVS9t8Cflo8GyQBTSWDhAQCULn07SPjusg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(4744005)(38070700005)(186003)(2616005)(83380400001)(6512007)(4326008)(5660300002)(91956017)(66946007)(76116006)(8936002)(66556008)(66446008)(8676002)(64756008)(66476007)(36756003)(2906002)(33656002)(38100700002)(71200400001)(478600001)(316002)(6506007)(6916009)(54906003)(41300700001)(122000001)(6486002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FCTi6AAEjXa1Xs+1ixea/fwiY0njIN2Fz+pZFOzjuWRFVqVUQjpK2XWSj5QA?=
 =?us-ascii?Q?JmuoWuP1VMSZkKeJwmIqX5fOF6TNC1mjhVqMQ/ot6GJoLnINNv9vTfgR24Dn?=
 =?us-ascii?Q?rNJG4WwVuxmj42sq0hmgubJxtf3GxLzEPzaPJtNyxd8X4g0nyEnxUpC4PRKD?=
 =?us-ascii?Q?b90S6/mD9/L2thYV/G9qLbuUS86C8K6hfqI6uELR4jatG2R0FKXxGSyxiHZD?=
 =?us-ascii?Q?6EyAkV6lP6aRY9l9Ke8Uf1iNEcF6vbbeQGRvw8vqUvmwzsQT6YR0ebCqWzHO?=
 =?us-ascii?Q?5b1X/cva1KM+IN2REUqvH6MS9QByOBEG4ReyxZGCA0EF70qkvZ00YC0dM/cd?=
 =?us-ascii?Q?gJOJL1OQY7YVMWzMDx9lmLbkqubHes6+HwGzJvBLdtKJzpwc+oTuYe/+t9tZ?=
 =?us-ascii?Q?5nJQwyFc5zC5HSft+u7+FOjiDUQC5fmDgqMSrAAFjGb5sJwLEReUHbxeyne7?=
 =?us-ascii?Q?Tx4pyBv37Lb7lnH4YGLuoSJ4jH7Rohr25OwValKJxDWza4jeOiYl9CTEgP/g?=
 =?us-ascii?Q?vz4GTTRp/oaxNnfzfbm7r2VYvuJztK0DEewwXATfCMZHdAn1SdRP0PzzD7FW?=
 =?us-ascii?Q?oSTE+L7LayhfStSChM7DgKD73/jNmUJtbF0iizS7TT1aYLfYY9/NiL8rd49z?=
 =?us-ascii?Q?yv5zmGFQ3fQbBzysX7SNhWpSdYx+61IjrRs8T5DBIk3olka5jtuEOo84N/zX?=
 =?us-ascii?Q?OGdSJ8zxM2uoE0CSCwdc6gRHJGX5UB1oGTIXQFrSMiRa7SiNU2/CWrD+Xxrx?=
 =?us-ascii?Q?Ta4pb6Rm63SEhb+tQM0QjQqpkoPdt3kKpKADko7AL1TANUxwofKumi1sJg70?=
 =?us-ascii?Q?doScIHQSzPpCQQA18hJH9eNzpRTo9PGDPDvUlwkOD0sh+/WJC8y6PO95TCgC?=
 =?us-ascii?Q?2QiVquioRsO+fBQPcFyeSL7yrxRLeQv/9kswYs83uZwt0lSKCZDb7or1hnuv?=
 =?us-ascii?Q?v6wR2HNk/6MnY5ibU0xrsOuwdBVkJrOnpegXQIP1Etc0sie6Mg7v3FLcEcvW?=
 =?us-ascii?Q?/rivpw0GAR4zV2DF8QvLoHjHIK2edpEUIvQRmoeEg0phhL02se/ekwlLGXSG?=
 =?us-ascii?Q?6uJtxXEY2i5sfmVC0qG4mCG+jE1sq0OmuUjgZHzq/TLmbe6D0lFod9j2l6Wc?=
 =?us-ascii?Q?aaW9XsDgd77J/RzAljzoCRbV7EBCCoQ3W5bA98J+C+BjqT1kIDTHbxDdLuMK?=
 =?us-ascii?Q?Bj3SRZY6cbenj/YGTY9IbJSaw/nTCwmcvJUVaUpFy5mW0aeQElyWKffOY4+e?=
 =?us-ascii?Q?6Y7FZCT7fL+uDZsXnfa4gjE8+ufm0hbRNakZCVpSTmkIQbYLd45pe2/GUgAu?=
 =?us-ascii?Q?q2zX6yoD31/CQHeYpyBYREqYhzYYR1cdWqW5cYWgppYPK1Au6e+N8CzcKwPE?=
 =?us-ascii?Q?NlMdQalAm4nNm8qqmT5NJHJVr2IbpnizzKdugwcvxzDnWryHyKKCIYucD7kD?=
 =?us-ascii?Q?q9PJGz2S+xvwjn6Bq50k9AMQCJNypZEAKx/G7kWXwGkalUo1W/P8wgTHRIvN?=
 =?us-ascii?Q?EvnfQbzOU2tNDVz2z8riLdwLwQJ2nSAOBiYrso1Z42kg81kwamf8d1eZs/9+?=
 =?us-ascii?Q?xVGQIgtHey4LBFtbompzA3U2yTfv4hScSCbtKOakeaNXOtFDBJim5hQunI6u?=
 =?us-ascii?Q?DngJPJgywvbTiKR0g1x01zY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <447D41771129204081546B91EF7759BC@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fb2b11-419c-4d8d-c936-08da89fff8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 20:49:31.1417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvdNW0aHVvXBWGCjeDUAVDkNp4muaE0k9ckbJicKotV2XRG6SzVdyaM2d9oa21GJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2802
X-Proofpoint-ORIG-GUID: CzBngOWE7y7p1v-W7Pz76BJIkChi3Lfm
X-Proofpoint-GUID: CzBngOWE7y7p1v-W7Pz76BJIkChi3Lfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> How stale could the information in the utilization bucket be?

The staleness would be capped by the duration of the scan, 70s in in the 
example.  

> Is it possible that THP shrinker splits a THP used to have a lot of
> zero-filled subpages but now have all subpages filled with useful
> values?

This is possible, but we free only the zero pages, which cannot have
any useful values. How often it happens that THPs move utilization buckets 
should be workload dependent. 

> In Patch 2, split_huge_page() only unmap zero-filled subpages,
> but for THP shrinker, should it verify the utilization before it
> splits the page?

I think we should add this check to verify that it is still in the lowest bucket before having the
shrinker split the page. The utilization could have changed and this way we do not
need to worry about workloads where THPs move utilization buckets. Thanks! 

