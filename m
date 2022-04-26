Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B85101A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352180AbiDZPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351981AbiDZPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB3F15CF6A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDStaB018591;
        Tue, 26 Apr 2022 15:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fprKfUzv/x+RzxgVrgGaDBIelAroq5AiMQpUi5ZMI90=;
 b=trK8jeIBnjau1Am5RPuJs4XDYLpdM7hsR5J7SGdT9Hk4sER/rafWGcw44X2JxEcCysx3
 8VJdM6Z23AdhkG3bxyNXxqmRblSRWo1AwKi8Bm3LfQeM8eri694lmb6MUYi/Fw3LuAJK
 auAEKVMgNuaeYQq98l/4iw2do5CRBT1HSInG9RlhqcJkDfSQrCzQaP2G3Ibos60F2WpE
 s2i1l3EOlxEVHStc1t5GTXNd15c6GeNnHNuaeHIOZKu+WeRBh89j/iQRXTtc6KTvqutK
 W0adn8NQ4ie+8LM+9aSp9hBS5rhZtwu1zchc7W2DU5KNd+klPAJXMYwAkjaNeBzmRYa1 hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxemj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64vi012575;
        Tue, 26 Apr 2022 15:08:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gsfk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVRXfVZ05rc8nXcIrRnJDSQzy+V3oHrxrHWAVloj3yyjc97fVRwk9Yq4tuWAClWBmLz3rBp+U65tnlheNxzzxJ4O1zQvkxcmuDmPCjRiIvGd5qYAUrCQ9HnRM7YQhuwih8XG4FyMqkcwMMmCEh4gK7iCsbZrkFjTo6tAiUNzCV+X672uLouxNo+hDgg8/pmuS+FzdFVo8UbI1eOVfxOpOyFKCijMAJS+CL9mgBao4l5Xbb2fi7M1wRzTXVZg/r8ftSH4/omCXREPVtOpE8I2dDLjs6MUMb2k3x6bKLaiFK5gYlYiBbtV+/ovPlpVdr8udeeGTJ3Ak9/7d5XQM08RZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fprKfUzv/x+RzxgVrgGaDBIelAroq5AiMQpUi5ZMI90=;
 b=RkvnvxESf7iQ8xDEQXPsMOV4m/y+esxKx/Kb1WMETzlQ3xK10Tz6SzZ5eDxR9hxk/DRZ7bWFcK7aX9ZGQDbuUzJM0crkrJDA1swZXHPcEKWtfjbvFbThD7vE2bhyusbQ2EZhxLGsfmcp9BP8AF/sASzykQiB95FWkuh51WzeBcdGAwF3AynF19H8FtZDKnMux/UPnxJv/r5OXlnKRf0gpSUKdmjDBCzJ++4HhY3FpQ2PgQgfhfl59Wx6Gu7Fm6BP91Ix+sG7Lb+jcCmGugihv2+w/teADftdZxewF7sNYCqQy/EiRUc63qH7BWY6REapT0Bbab/g30fbDn8Eyam+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fprKfUzv/x+RzxgVrgGaDBIelAroq5AiMQpUi5ZMI90=;
 b=bXGta2/R25Ad7fnWjeFnFp+IkBivdMNN/scdUy+IVvMH9VCQBQjyAZsq4ijUqBX0vcgZg4lxdFkPuxcYiTqQ1hnMCoYUN3rp7+DscCPYLajNMkxmjr9AdzsYrYzwqaJeTU6EKWa6yFVBUy9dYR2f1H6YDk1+wDzlb8x1632hCog=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:08:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:08:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 64/70] mm/swapfile: use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v8 64/70] mm/swapfile: use vma iterator instead of vma
 linked list
Thread-Index: AQHYWX9CIEjiu5lTkEmr7Khlf0fRsQ==
Date:   Tue, 26 Apr 2022 15:06:51 +0000
Message-ID: <20220426150616.3937571-65-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb32277e-a15d-4d3f-2882-08da2796916e
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB237734B819CDD9BB3FCB5400FDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /kujHfYTiAoJ8Skmc4pRr1hceEifHWtE6nmqesfDwgOkNgDk0X6IU24yN9gWlHv+E7U8wFu4tfrn1Vg+36ci4SLTGnUN26RGduRJSNjCVY7RuqU5u19uJNNZpUc7FPBEuvCPv8FxYewhb2vQZ+bg66dISe47Xy6D5EmJSyFHxWGEZo/ysNNvbA+S7gNd+h0GH0eo38gsJdPUySTsVRhD3W46hzBLxsdydCnnI5qx8TjNA4u5ZQW4x9p6wTctX7PtdEa11L47w+mEJQZGZFptger0tLiys7zIKgZ4GSUylIHgwWc+NP6B5+dAlRY2A1i7VdFtQtxqX4Y7TAh3drgloMb1lsoLlM4PsPco4dN+rfqDrNDjfH8btpKR9Q0lR9oNQesm6SMW6+UPVxb5zZW7k7JX/8snhRAPMdF5u/ENHmFeQBnzsC7TwlKLYtA1yFx2UWJEj6kqiuJopdL2pXDAJxfoCHYFhwciR9VnpnLa1juWZHkZjeX7kdSluWDwCiVH88xLfxbHg9o8exrFbk0cIxm1NIqEHdN46rBh1Zeys9aJjQh7GeEBwh0RnjPfjBbE2Ihpoi0JYy7trvMyxIc0P/5a6O16PFnrL+9dii/NTZtXVq9H+TMUA0fr0V28TAWYWFFCsHubF1nSA83ie5kcFQQUJAOOGyj1DExu1ScgI9+fC1ENElIoiQS0+wInklRMIHaPXzt/wNnfEW/52bYjBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(4744005)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7TdzeB82t9mgfh1aes0FcHj718uP3ZSGkeSyHf0u1Byu6rjniM6MXDxDwb?=
 =?iso-8859-1?Q?6mRYN5OWt4+NocQcIBlgoUsrUqAHcLf65Ejx4vKZ7z1O4VFYwXGxqETuKR?=
 =?iso-8859-1?Q?buzqsJd+RzLKzGo9Di819va1BgzGIOjjYDf1RcFSuirZeTzrRLRuqaUsjt?=
 =?iso-8859-1?Q?f8Oq8SHkj0Bn4KcyngfuTpg5H1cjjz/3boKLVJ5Eecmp9aXKpa5ogPdmTs?=
 =?iso-8859-1?Q?qF/c1LRybg3zaEKIeBrpU1ctk2WTkUAbg/cTJJaUkDWqQ0RbiMtXLM4IKd?=
 =?iso-8859-1?Q?VAYqhUIBWIeJOJZM7xWEY+6mQe3dIguiPeE7yv9yhoLvYkzbXdxGBOYkmi?=
 =?iso-8859-1?Q?RNz0auT5irPGYxM/esYhY00D3+JjjhFtdX+ahmAzx1hIzdemSVTV/4mTKJ?=
 =?iso-8859-1?Q?TfJHVo+B/2qzk/B9Cx8/Nr6FS9soiqYFuzQXL7K3Z/b5Q+8ZJoiS0k5EHS?=
 =?iso-8859-1?Q?X/2/h+GrkErs9X6ravRCsDjFNzn5RzcrQSJPn8Yk/xY+GMZKcHDEdzu5zL?=
 =?iso-8859-1?Q?aunYLWGdzquj+P1E8CYaxS3hNIQ+Y1/pcu4ngrQouAEJZMIcRwKTvQSUyQ?=
 =?iso-8859-1?Q?p26MeAIX03opQ290hsxOxlS4q7KB+3gnnUtSrAUSdbgxztbRjxRff1Y+hz?=
 =?iso-8859-1?Q?3Umw5mmL1auoyFVkglvQ+OryZ1T7PeVvKHJMoPrRC27q25IpuyzDjSi0ts?=
 =?iso-8859-1?Q?FTEcLevIiuHq0ui/YOwqHNuI92PAGNrYg9rP3sgKP0V7VdPhnoREosZLEq?=
 =?iso-8859-1?Q?JUPtmQtlJY4nMz5ylJStNlGIpLSogYIGoLF/4xykolhMeZ0GVwPLaVWVRa?=
 =?iso-8859-1?Q?NPS4BBYv61thDkCEO3SFqQDNfNJgxKdXvo219Uv+mI1NzjH+1+SQnayIVL?=
 =?iso-8859-1?Q?ockpb/qZ5lmmDcOc5kVoP9YGhkQ+ELQhonDFk7NyrrO3kSzog5lQd8bdNV?=
 =?iso-8859-1?Q?AEXoG7tg3LVAwvgdaJBM8bAaMS7VYjUfA6UI2A/zlS5FUmNy+BcG3jHwoj?=
 =?iso-8859-1?Q?Ftbg3bTXnoGgRTrPqbcz+eH1N0j4jexAACi4bTmcH3BxzVIE0n0kFBpbkg?=
 =?iso-8859-1?Q?Va++WJ3oYvUfqm9qpGy7Wz4MwsV0MfinA7UyXWomY9Ld4ARGR2uJWeGXl/?=
 =?iso-8859-1?Q?pco+mAlPv7zV/DVaopyPb6sqPGIEMG0n12Jax0eNsSMdZ+pZEJHsNavz1r?=
 =?iso-8859-1?Q?Hx4rhTcaB0KddG1Zd+MHHun5IDFmSPq/qxahvfQRGdwOMjX/G/W2ADTpVH?=
 =?iso-8859-1?Q?EJWEqu4zZuk1N8dL4li15G7UyuSda7a4ntYHnUtm2QM1pGoLsiDNuFb4JR?=
 =?iso-8859-1?Q?mgMKcdoW7qZxkNmQezAfvyc3kETFTQ0NsB2neDA5Eo5TSo4MJ3tv6a2n13?=
 =?iso-8859-1?Q?N51KEx5CaklUoOhOzu8pesGFKkVWi93R3hhAA/g9H1BGijq1vWsVmVD9MM?=
 =?iso-8859-1?Q?5QKRWsO0CmEOsT5Sr1dxiu4J8+aV3GpqksRCPpINv16pz/HGOHN8CKSf1U?=
 =?iso-8859-1?Q?D+JtX2EEhsq9MX7CQANrwF3K2ylemFBrQCqKzX5jtWBtrmSW28ve2f8L7U?=
 =?iso-8859-1?Q?M0vQQWc5oHi+RWXFsBgdWkoLygQdZiLHuj8aIBK3yPDtMD3DtD7hFaxAq7?=
 =?iso-8859-1?Q?LvyXztwWTzf5CffwsqZT9nwgDHTAraRuuVz3hQc8LHRfwXARcGZU/uWf3U?=
 =?iso-8859-1?Q?SvFxgQw2ODrTLfm2bt8jyIK9zZyD950AgggzDKQMgwzTl2QGYK2XM+tOvE?=
 =?iso-8859-1?Q?qG2m9mEDXg/koqWWwC877SGnGsSXq/KwE2GqlD3SaaacsoBmiI0TI9A9T1?=
 =?iso-8859-1?Q?1PkhOWYFdcJzrci8cDdjwUfE2yjRP9Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb32277e-a15d-4d3f-2882-08da2796916e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:51.8327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3w5lMbkIyC/3c9BY6rmf9i59xLv0M4S37Wfsecnd9xmexRNdcIypdUHVJtKvHEvnJiye8JZmtmPbIoxHXyd0tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-GUID: R-Carm28ScfmTBfVdPYPmzNdVEVpOtBb
X-Proofpoint-ORIG-GUID: R-Carm28ScfmTBfVdPYPmzNdVEVpOtBb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

unuse_mm() no longer needs to reference the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9398e915b36b..3007031c0f5f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1984,14 +1984,16 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
+
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.35.1
