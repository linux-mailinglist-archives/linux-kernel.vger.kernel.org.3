Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB704B70E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbiBOOs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbiBOOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5841162BB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:15 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi0fY014259;
        Tue, 15 Feb 2022 14:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ELdCh4DE5+UyD+4egtHVt19Pwqv52X7PLvvh+RreRls=;
 b=qqOh7myiWViMZjEDwIyx5WjxaCxbUw4wVOC6qgh0z3gZfccYdym8RS6Be17E2jTNqpkv
 xEFmiwWUnA9A3btxKv/mOhpkYBBiy0RgApfdADwePv2R9A/rsZkVQqHJ6aLgqq+UDGBX
 YlVIpw1iejgpemdSYkd0qeemxuTNlCbUOduVkRK4Ni3iJNYa4oQ8ISCTzHeHFep9Gdce
 Yfazyvs80aldJaDzVNQXgzYe0NfpcVMIT4KnKAv6REb/HAqRtRHGZLrOef5yKFuICwhR
 2CU84+Or/TeL+8y36pB6L32qm34+n91XkZvS1bAG9N19xMhCskpwC7tbqGVIe0e33Wg4 Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8570shtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4R145723;
        Tue, 15 Feb 2022 14:44:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6hY+fwXtR30WHVsoFCymHKKlwoXnnCPuqnuZhDHbOqMWHB+by3HhFzkdZ3DItom8tArWXCFwDjnni78yNU2jMQT2Q4fCCoOVdOPJBzo2j+oma/DT0CUJdDBn8I3M2x7hnslwEbDbcMkQKN+/lIZde0lm+T20Hs0kvafkbslO4I75wmoybtLdw4Fm/ot4fg7jq0ePp/cliI9qKKdT1jk9OwjCGD+xh2vwOc/aZHyKfbPf+P2+cet3TeY03Y0v06mT0iYYqM+RrMx1PzWStJW16larmQm02z3ShHkKO3z8orHrLlcOH3K9K1J0RlqVmPe72qu+NaTlNSk342tvqJ/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELdCh4DE5+UyD+4egtHVt19Pwqv52X7PLvvh+RreRls=;
 b=KNRdUYepg1T9zjCR0iih1ADfqnXpV3MHwuLx8WQd+a5MYMTQWsYWkhvAwT5ipokDAAc9YG5ZQAUfTrsLji4ZH2tt+Pptq7RQ91hMR66pLZKST60sJ8pHWhsV1xTAYNX9NSqTxUCV1bFW3u5lS0ed1P7G1qXizrXkNK1QaNRyymAW5q8yspL1P06ugsxsDKYxszqk3Wyo1H6eZOK2PMDH5CWvn0U40ydkCCaXegM14BfE9zaZxu9m005TE8DhLt8mRAlnTy+d+ov8eXdymL9nULwePvNcn/IBIYTL5uTFaqeNvK4heWcd2thqopRyOWRh256JuZFoiHbIiRFOiWVVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELdCh4DE5+UyD+4egtHVt19Pwqv52X7PLvvh+RreRls=;
 b=NPKDHhD2qCWUtNWgZ2nyroLwKqtSSlYA9yC6/fsb3EgEyhaxm3Lb6skxMVVRoS11PmVgHWNoycEzZ43N25lWY+Jz7zI4ZNiDh4CKH7I6e9rzY2kkPMKZiPrZGePOI5WSidvd6Y/4i2T2929FL4oHJAdUWfLSTMG3Vi/FIXD7HDM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 50/71] sched: Use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v6 50/71] sched: Use maple tree iterator to walk VMAs
Thread-Index: AQHYInpheXJHm8gPwU6A7JMtz8SqgQ==
Date:   Tue, 15 Feb 2022 14:43:21 +0000
Message-ID: <20220215144241.3812052-50-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bab10ff-cff4-42d9-73e0-08d9f0919957
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5578BBFF1E7E78226D99680DFD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+ZOUA7qg0CX7qzTZ/UU9ArhA4W/ug7KDu8BlSrBA12OzNeAJiTXlPemzP8D4LtOCW/JbmLZHseSxobxdNgnlpJCCqE3miWTUeACAruVAkk00jIt/ieR/R55v96Mjs5le8knqLKRnxX8bZY+buf8X3+O8gsB7JdEDrqAp5WocYFbaQ086cpXAuab9bZBdDwOmvasajM5kRiXvzIDAcJ/I1LIzYMocIcg5n0iMJ/KXdk9GmU8ZlW6nKPkfYXwJ9KM8HrNuaudt2dfIm53UoSbgRzHJjsdpW6YgtYoZYSJeBHFsV7FBROmTwSUfmGKYS10bQDGF1zEwuuNbj1vtNURc5BLgnzhoETh04EQOiVssa2tsooqwGnOVgye81ge9a/j/F7pw6olJ56O2eoJ/7KPiNOGj1QuPU5Bo/NmBXmhE03ht7UOLuO0oJenQiC9qn1vmHkOxsnvIL/vd4CqRB2mOO1KspSwl7Ro9eBkWlTy8sfn2vwDgzMgT7/Mbf9nnM35kuGDQ94Yn0mUtPbKQSzwcb8iXRr81MHGHPOeo18eHGdkUe/iqocgCAxDeRlJZ8F8cV4abn6+ZErpbAo/6ZA7rAr+skfW2DwDJ2evaGfkcmp+nPaPzsSmHURBZMDiHWrM3XJOG9mevJqYPJN4reqs93aj5uWiFlRhFeQsNjojHeq+NJvTD1wjfSLb8iL78B0OIMYhm6CCFNxbCsei+KUulg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9aQIV33ZjeHwIQSyGuNPGEtIFpAIpGinDWLil6uJs6S5i+5A+6F47/+S9W?=
 =?iso-8859-1?Q?a1vUQZpJD4QmfosAcRUkNBRhqfTenEaWBR87USVQkn+TyuAOrHtbckHlxv?=
 =?iso-8859-1?Q?ndGqPmjh10Gm3LV9jhRsfafGyfhBPEJB7BJaDJwKRcUTZbLEq7diKM8UHS?=
 =?iso-8859-1?Q?CkjRW/0nr2iSZSaDp6Sjnkl524bvJEddfBi58mqFtVu8uQz5Id3S6UHC+0?=
 =?iso-8859-1?Q?CHywzo2Shb6x0HfX5UVvUw7hvT0UD/ehdDZVVHDmmYIxdfUbCIfuZpRPxE?=
 =?iso-8859-1?Q?p50FBDzo+S04ffbo3EAjmLN4ncBfuPuZ6NzOORCKBTdMQS8TMQhvWrSHa/?=
 =?iso-8859-1?Q?iJ7MWYcemUkcb2mNpbh/EH1ygm7rGao7bz91CVgUvhyQSFwI/ixCJItgZh?=
 =?iso-8859-1?Q?oZU+3j0uhmoLIFoGDmIzIL6ccYB28m/e7P+eqvTOODdSldLHmhvCxu0pr1?=
 =?iso-8859-1?Q?65u6U5ls7+0a640g47GnG5fvOHcVSDoo95dSHFxyzkI5H7LD3tqd68DU9j?=
 =?iso-8859-1?Q?CeSXtWVTx2PUI30gVAdbSYOZAgBj9hjH5TAT5rOSRLv44+wizO3rNdN6ts?=
 =?iso-8859-1?Q?DCiiqdynfJI6+ivQHiz4WiZ2mWD1NJTYacObfHA1FnJYeQ4bxrg7cXC7Zn?=
 =?iso-8859-1?Q?xWO6WYZuSUcYwOdOrulfSgRilRjwPLf11zWQDd2iM0+pYdQPRbltKzoWY2?=
 =?iso-8859-1?Q?22Wht+Ar8ejynHwU30Qm651cQlqwyAJmhCGnZaA0uBRIeghfHGWmXYNN9Z?=
 =?iso-8859-1?Q?Iod+bAE9GRXS01YwMI+q+uH8OT7ot+F37eZXHmIitpFp9ClFUDKQ2ZnwAz?=
 =?iso-8859-1?Q?AoIsFb0YYoggqYdas/9hOsaM+Fn7JlS7v4v1qlN6iGl9J1irePxOsHyvdS?=
 =?iso-8859-1?Q?egnh4CkrPvzb/w0WcHLx7nmw9MXTkdp4Q3czQzSHWHqSuq9WvDiTXAB7rK?=
 =?iso-8859-1?Q?Eeu5btaHR0iztGy4ZSGb0zVCqLgMNmkrUJ2q/4S/5qi0W0FwrlIVPug7DM?=
 =?iso-8859-1?Q?sVbZF//B/KGCCz/T9B0zOLEm+0Ko+RrneUkq0d16BgG1zGOPXg5hHHPqwu?=
 =?iso-8859-1?Q?iU1mkWNY3PRMRsJDRh+rqjgTDqcRyoelXMTqC8EvZkqniEQR0f92ysSAh/?=
 =?iso-8859-1?Q?3cGBB9OoMwtw0x/fGZxWhWUbkB00cb+SFOgmcTYGvzLbr/VxFpNB3bbO4L?=
 =?iso-8859-1?Q?AlUfZJzXnRYyoy1m29S7rP664ZM8NgYzL5oV13WMPceM4zlpD9RwJ+uoUN?=
 =?iso-8859-1?Q?+GL8z6pfu6kus+HVDpMiUIjTxY4d0YFR32/MAmQcY3NSo1JA/fKTZF7yFb?=
 =?iso-8859-1?Q?RZ2bUFU2M0E6YrvNtOnaqfRfR9ytMgqkQc1ZLXoArOJJAku22+2zDR+OCw?=
 =?iso-8859-1?Q?gch9kiuTCoJY5G03NBa0r1O6BjmUnmohwILMLkSUH9/D8l8IjsGF7IG8CY?=
 =?iso-8859-1?Q?HIKizPyJDaYzrONgX6Tlnh7gvddgKkXRifttJS6GYgc3ewe2H6HsM/p5ak?=
 =?iso-8859-1?Q?tFoz8xik3HcU9kQxt2cPJn4egkWr64AK4C7/Ii8W1voSyQ9V4tkNmLXnGp?=
 =?iso-8859-1?Q?DyjrE0RmLHQ3O3r1kWiBWbA3XYvXy0K0J9k4ZlTqzOZIkZbZem3v0IaK2a?=
 =?iso-8859-1?Q?g9zGTzdYKSkmU7AR5UVq9ildfdKoUUmw2gAHfyr5k8N9lZ71MqFVbbUslD?=
 =?iso-8859-1?Q?l2s8Up3v6hhcMh9XIxQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bab10ff-cff4-42d9-73e0-08d9f0919957
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:21.9480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6Nkm4gOmeEb8CWvoDkSBh1nWt5LNOwwOBjz3jlTNBJM67/sH6D2bFamggc2BjbAUaUbXH418jJ0Eyfy3UYQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: QaCTzwAzUjTNItF3E98HdRWGuvG4sUJV
X-Proofpoint-GUID: QaCTzwAzUjTNItF3E98HdRWGuvG4sUJV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The linked list is slower than walking the VMAs using the maple tree.
We can't use the VMA iterator here because it doesn't support
moving to an earlier position.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..f0ac5dfe2ab7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2671,6 +2671,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2727,13 +2728,16 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	vma =3D find_vma(mm, start);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		vma =3D mm->mmap;
+		mas_set(&mas, start);
+		vma =3D mas_find(&mas, ULONG_MAX);
 	}
-	for (; vma; vma =3D vma->vm_next) {
+
+	for (; vma; vma =3D mas_find(&mas, ULONG_MAX)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
--=20
2.34.1
