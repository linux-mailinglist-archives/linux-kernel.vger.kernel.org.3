Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C424EF859
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiDAQvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349454AbiDAQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:51:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE63173B06
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTHekBGw/6vb9ug0o7jdo3DFUJYyxU7uDy80Xppj9NIhicqyanah4R9iQiobOiCxft4DMTK3LIrA5rNV17PtaDrVWQQDZN3ZGEtFkEFGnP6e/GZlEBBMr5VH6CyskxJeGiwKMWmyBdCp7n1AdIR9rAJMfflYN66iOj3I1hyV/AIQoQhHNxgIaT6078u6uKwUvn3CUGGoWvIs7v7Yrqwub4CkmJtnWiPh53SccgbREA8JNyoXpo1tDQug4FVlDaLKECE2s3gCwXgaUEuHeMWqTYpmrhuISAqyTVCosCMJpuPijWtfocH5zcEfWiqoEaQoR5h/5chkDYXj3we9FByOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icwjlne3dtrImUUDAXKu4AtJswelvNl8d8yrbeMcGik=;
 b=apsoX20NWXOTbHUomVVu88HR+Aep5x5CFi4N2TTSrwmkWzcBgfPGwhx7DXTlMGpUjNrrwp10DxNn/rGuDDDLcX+tGhhFN8kXpJ4udFzq8pgcXV8rwkWjIMm/1CFpV3BR//covC6SuTh+kLDRQ/si9BIZyYYQgc2BXB4jSrLLmOTQZ2vrOl77VHH/pWWg7/s4EgCyhf5FDD1jiaAlZaZKE/V1hGhMiw9JNQ3wrWOokSyILPH//xoORHuESWWY0ZcqTfTBcWV1HaX7pn/j6fhFbjEbl5J1ib4xsB+2rks+qaHACI6kyHMoeJOuasy5vb4gmhw/e5T0m96EOZgIIQgJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icwjlne3dtrImUUDAXKu4AtJswelvNl8d8yrbeMcGik=;
 b=PbCDypLaTjXo+VsxLzL2kKZUgqXACX0ri3e1ihhe6jdtS5ipRLM1BBSnIcofYZ2bJLK2CY8dxJLWwPtghmg+5y282w77iQLV3BGGF65aQMjo3dlmTRe9T5F3Tgaxx8gTQPCGhkXG+CFg6a9IWTblxt+NcJSdZJd6sqR5wrioJvhimjD9Yn8iXICgqRTu4kE9/vEHM5TFppmZ9whpf1repxzPKunmJWxgj9x8ojkiVm88CW1hwdTK/PxF838a60b69s4O2aG0m2C3RWDR2x3IIjILeBinC+xODxXJNhv4kNSEfGpMpuTApLk4doOkdek1Hps0lgbk/1WlVMoH3NJKHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by CY4PR12MB1608.namprd12.prod.outlook.com (2603:10b6:910:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 16:37:14 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 16:37:14 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy page validation.
Date:   Fri, 01 Apr 2022 12:37:11 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <31FDAB92-ACE2-4502-9970-77C21D6EBB5D@nvidia.com>
In-Reply-To: <CAHk-=wjToETfvzxkz_Y=QPt0JQRHF3VZ51xjhbPNAneHFvZofw@mail.gmail.com>
References: <20220401135820.1453829-1-zi.yan@sent.com>
 <20220401135820.1453829-2-zi.yan@sent.com>
 <CAHk-=wjToETfvzxkz_Y=QPt0JQRHF3VZ51xjhbPNAneHFvZofw@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6A8A4A09-AF3B-422A-9C1A-381F2D7A37C1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0129.namprd02.prod.outlook.com
 (2603:10b6:208:35::34) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6d5d1d9-b4f7-4748-da53-08da13fde059
X-MS-TrafficTypeDiagnostic: CY4PR12MB1608:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB160826482D9F51E92268D9F5C2E09@CY4PR12MB1608.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71sawBSFgJqEJ7bA5C/i+15esPNJzlgpTXd12iOxhO8D4IGOgS8AgLBQqUuIwfVlEfyCTg1XAjaA4qCJpmxOMrJhlps+QBe0yIMEVVbZJCFRdBcdSNuVl6GaqjvOaS1ZpOVmzKIOTngU2ri+Irz7CT5ToVzZC4BdqK80jlmdS8xGxr2JsfwZzmIWJPO6f/wzyO4uC+iHq/TsVLdfPTd6MHNwViiih3AFjDXRZLcEYr4WKg46WWrD30o+MU+RZ/YK1c41dXIvH1mUxp3WhllQOkU4Pr/dMijOrcelWpaa9G2pN5nTWedxWL9y1RTiZvLHb8Gb2bYR4OaEhh+NzW4+YswkUNqijNpa2oHMZE/o6wdhmfVmffois4XVhqP5XNzF0oOX8DN6L5x98RLWDOnTKI6x/Hmw/emhMj/cDOOyg2vku5IM06OhFmXphKBdkRKz/HfBjcFYeH+haJdkA5k1Gp3CZcT1l0Q9VU1mEdaWGu4utAOR2XUQSa3S2pBtK6GOafaGmh6cmPk2dyqWlFezgiH71WFcb6CVnqv3g63ROJIE2vFe5jzmU0ltWbwVWrM451WCZ9GbPwSD/weRL8ocWHWYH3b2bR4E5CCLD0xvGbDrBGB1uWwaMzjQWZArTfBuiekBq06I2HDl3P2WP5kQ9aZeXXLYIf4wPWNi5aFqHMGpGm2v40rzvHfBySHw+6USxeZAVJ1Wrp4cYhfJrpTN5DCCiTmVp8P/RjL89qAyJ3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(2616005)(26005)(21480400003)(7416002)(186003)(6666004)(8936002)(6512007)(6506007)(53546011)(36756003)(83380400001)(4326008)(86362001)(66946007)(508600001)(316002)(235185007)(8676002)(66556008)(66476007)(54906003)(6486002)(33656002)(5660300002)(6916009)(38100700002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SStQchRtfsJ1m4DPTpj6unNv8brYJY6rmbprqZ+Hhp98ceF/g+eWKSGyGO9f?=
 =?us-ascii?Q?stF67+B01eek8isVaH+cqu3aVGIwBubFNIpptsrARk85PevtkxxlF0FhJDq0?=
 =?us-ascii?Q?rUTuEt7j+6HviwTLxSAfoNv2d1lkiJclA1kkM4D19Ppy+sLRFRY4Nvaxu5r/?=
 =?us-ascii?Q?VIPdj0YtaSMopdhzAiSIPmPsenh4RfxcSLp6pAeiNtZRF8TOcXp3VoCWEgiK?=
 =?us-ascii?Q?BMDYYtOX3ldrHAaNepVuBRNUwvvboNppJQwFtegNmFl9IHsLoOVvDu3eH8EO?=
 =?us-ascii?Q?9C+iMJixikgueSP1wDBpxFlzvFB7GzTcZHIcycYRjhBc0jhA6vjGTQN+GG+b?=
 =?us-ascii?Q?C35ld15L2ktAYYL70lkJdVp6pYkNHR8g4hdLirq9D6QATHbTi6AD5h2QWvII?=
 =?us-ascii?Q?hrUhxgZssx9qAvawsFUX1ozh1bMXFAaVOYbOwYDYpoixP5m2sfA/UmocCaT4?=
 =?us-ascii?Q?StnpwzyeefODYJZqVAlWsZfgB82qNfunO+o8UeyZC5znv0XpKe17n4HIXPq/?=
 =?us-ascii?Q?pdiQR40HVJWmItdsyT26TIrn2T22sDUA7Fal06mxaAxhizC+Syyg8xv+m5W0?=
 =?us-ascii?Q?ixv5lB5boXERCTLjAB2pfETFDExl8KZ9eYc3ceq7TtnbaTnatPM5LonYgSQp?=
 =?us-ascii?Q?5EVNuIlcMzriSwmDsTzMFnn58pW5DHRcD/aCTsUCvko6aw3KxwkidtbmMuTi?=
 =?us-ascii?Q?0JV4C9CsWnE1NBcEDIfGVo1NQgIaKQQFSBW6cuht4j9bBu640tmgeMlt2Xdl?=
 =?us-ascii?Q?sHiwAk0nN2s46dGQczuP0b6HQt0u/mAo4Up3bKSK/rGi1hsFU8BAYSpTdj8v?=
 =?us-ascii?Q?ZXvxiVJviZ7EhgCPTIv1jCzyAIvx6lqllYdAvY5MYAXxl2NaHouRzwCbgS8H?=
 =?us-ascii?Q?eGP+yjPsqtfJvt9+n5FuoCdcVPWbW4WDzMXrRrpSMmCXcEJ4IrXatggYwguW?=
 =?us-ascii?Q?9zpyCB88n34ku8KTThZNs/P1/+IGDugbFnBU6Lr24Ri2EcGAfKbssRVKFD3+?=
 =?us-ascii?Q?HVO/Cuyij+ycZJVIrBp8cZBbJRlgYfmRdirPu2D+eesILFVPcXS+dXQJJ45t?=
 =?us-ascii?Q?jIYP3dIG4SArtfW7NFKz93OjJsWjXp6EHlRpqSqnNVArkOcHafGBUA9phV7Q?=
 =?us-ascii?Q?S9Gv/TdaPsOwDB16AhZqP0W0EOJnhdBrP+u4d9fTGUPpT1BaYcXM0Wdsi3Xt?=
 =?us-ascii?Q?IFqrRhPXZ/BiIAYFdT4JkJe+hnhoEMpSlLb9hC/MRkxqFLZx2gY8nPALXBTe?=
 =?us-ascii?Q?nzbrH1mpa/NJcakL/cFkoXEQ8VKwsi4kvDzD2U2+IQRa2xy+6ZrkUnis4l38?=
 =?us-ascii?Q?Jr3QFVv0RRslLNM3AjtehVwHoePFAnYtJq7E1dMzQ9U1THdIqvgmasN1+MKP?=
 =?us-ascii?Q?abHLww3SeWn/Ck2jKeSf10lmHa0v9IM0iImaUeDOLtuy9mm+7onj0tknitgc?=
 =?us-ascii?Q?3mnIylIysfXEnvBXe+aQ8UfrNQRjcHwO4AgK8urYPE6dO2Cbbr8Me9EO91Cx?=
 =?us-ascii?Q?r/c1Isp8+EBaXrIrM1l0UhjfUHEj0DM4VBiHEXvDrtqmp27oEYcROvaL13xu?=
 =?us-ascii?Q?TWx6hBVXrSZfls9rIaok5w0Hxx0ty/TUH9XJPczeLC8Y8sIKfh7sb/NDBEL4?=
 =?us-ascii?Q?YaFSS3QuOZWoOx0gQJ47HTFK3VSSlw2lPgftWug/Al/3Hc9dAea39AvE1eHo?=
 =?us-ascii?Q?bM7MbLdt+6w9eE31cHmKEOrf6grImjbWKWa/b3asN2M7q1H9iWQHwBrLz4Kz?=
 =?us-ascii?Q?/hM5PRibQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d5d1d9-b4f7-4748-da53-08da13fde059
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 16:37:13.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Osw6htrnDUT9IMh2/wOvJ8dEJdsbpv+vAixWBPXV3S6pUE/zVB9k9tckUbMkr69U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1608
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6A8A4A09-AF3B-422A-9C1A-381F2D7A37C1_=
Content-Type: text/plain

On 1 Apr 2022, at 12:31, Linus Torvalds wrote:

> On Fri, Apr 1, 2022 at 6:58 AM Zi Yan <zi.yan@sent.com> wrote:
>>
>> +extern bool find_buddy_page_pfn(struct page *page, unsigned int order,
>> +                               struct page **buddy, unsigned long *buddy_pfn);
>
> Wouldn't it make more sense to just return the 'struct page *buddy'
> here, instead of the 'bool'?
>
> So a NULL buddy means the obvious "no buddy found".
>
> I dislike those "pass return value by reference" in general, and the
> above has _two_ of them.
>
> We can get rid of at least one very obviously.

Sure. We can get rid of both and calculate buddy_pfn from buddy after
a successful call.


--
Best Regards,
Yan, Zi

--=_MailMate_6A8A4A09-AF3B-422A-9C1A-381F2D7A37C1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJHKjcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUZBYP/RCOxdyFoLT0by6iA30va5FJ+AiBGLJ7TOWA
gz1QAVuiIM2rDbqrL3DrLlsSBe8n+CDnAtDOMNrttKK4WvVHdpS8HnOYWvlmBnh0
MTK13IyoXzuBR/NPiuiyUm4dUFT0gJPJnzWL3/I83fpwAw1JnDlUlQSlr4NyO+vu
LzJEG1SaPXiPhug94f2FIvZsBalv5VnD5MTJchJQSOrQs+/k+yRBWmL2MqWz5PT9
0wR/2vJwvhEwK2TyhdTc9ifmFZrWPTdMyOKYP8nRSA6SgeQgGsdKBG8DUZIK6cC3
/xPXqPnR4vnY6mC8TcTiYsJOLa2VlnL1Ut9ciUA6EM7gNGaNtZ7mBb7egQyxSaS/
wxOYRyG7dlb5MyqQN6DChbdNE3t+giJ/hEcbwxYSpsCmkUw6wwccduicZvY1vRX8
oravYVCpGFaaDSh0iiH3DdLkClPyf46FUZiaQmUAvpXq4TAWx8PO4JahqIDNJJqr
bZcmcuvH5AVmAoUC/FTr+hjlU588dhdcd08FjmekronX8s7po5OeQdR9YccT/VHn
W2x7pqdjOV4QVB6KF038qWO7a33yAIyLl0O3/eloX0WVLkTQJWHGf8fDVP4CpL1k
5Dh74xkrpUl+cge0PQHWhRfi+or3fVCB7+tNEGuKPg3i8IMjoQmg6DX8+dhf6FR1
qFbDWaf1
=qNuX
-----END PGP SIGNATURE-----

--=_MailMate_6A8A4A09-AF3B-422A-9C1A-381F2D7A37C1_=--
