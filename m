Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E009F464FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350001AbhLAOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38044 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349946AbhLAOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:50 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EP50X018237;
        Wed, 1 Dec 2021 14:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=Y7lv1PSHv7fvI1FHP3Wd0WNNFTpoXMA7h7MZu4QMDDiBY+O/Pjz5KF2f8KX4W50/UZeF
 Lt7uzcu1n+SgL/mmw66ToLpEQiunfrD7odzTd1iXqlLZCr5Dt/F/dhWKAy6rb6lrfCWf
 YrFjtYWCETpLiRD+2UidgUTLvbZNMdOP9DTB6AOHFcfoQpi2VX3V4djRv4rqVM+OEXyl
 PK46u06lbbgtrriwfq9obqQIOeIHr7gXIsH5dUDfuoLarwQjHW0teBe/SfSqQqqIftMJ
 OsU7iZYGFS8IEK9QeOB31qQC9nraoMoWlelNS6TpLyg9P8kTrHOvj3pVDIdJ2mTa0eYY EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyg0wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EALNd032204;
        Wed, 1 Dec 2021 14:29:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3cke4rv3t3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em2Uy3d46Bjpsfse05ftBk10TKZoAse2gOOoiYomRw7jeRCXmkuJpHr2yOxi0RXLAbX4zv0Jml3L9O/yzJ2KawEk1NO3heJu4Mv4e9yAwCNYIXmMtXytxIFfJNRygrB6qHrerPLabtBrSFvFkiy0gBSsgwnrF53aMctc8t9Wsi9jwWLK3+KsjCuWI3f1IEaeobBZ/CJINZEuRzqRL8j76ZqyAPakKwHtpyj5AK75QjMfnuLuX6Qm2HCOiYIvUtOCJpX+FCEodrewFFL1zGLE4X1gDYXziBWlrj8R3XPAnTQNbhgvxBogooQ3Sht/jxT0vwNAi3VILbpGHyDiCbv+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=Z64xs40JBUET+e5Kds4JL6CzC8xT2IGp4h+TzGoz0etw/6EQ4El9epKq5Zm7UKCXyb0PlrV2TrSjwDouy5zswrCw6ZgQKrs9H4xqNZeUjeZntODQDyOMiPcmpTQ9yRc0ZeVzNrSZza7DU5LTLTr+XNQH2QzeR8Nhy7ZCDQsQeeNiKyPlG8mIyN7ki8GgxNTOGMSV/426Ral7OT2qVDVVU7SWPLElbikfkdjCMgupD29bAzpf/mg42Idf3NgSlBLBmWD+RYpiHfzcELT7PvdBZ5U0lI17wrz530Oi579rEEpoXJ4wu8ZMe/AiBIHT0VAP0J6AfUXyOm0COnhr1ZToYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=eLrJw/GJUzIWOBCXiqPlgLs7wMeEdGFAePy4mtIx9zLx3hb41nNXdbaqsPtK8PyZlQM7Cm80X1/mkW3MKyFFQcRFYDfS/U1lg0v9Wm3OkFe63c02mEJP588DYcKQMg1vyXFbFzniYdQJr+emy6lJnLHz+Ts3HrBxNkmi8r1O1/A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 02/66] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v4 02/66] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Index: AQHX5r/idawVc/vQ0E+5av3PP0u3Tw==
Date:   Wed, 1 Dec 2021 14:29:44 +0000
Message-ID: <20211201142918.921493-3-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce31031e-9104-4120-b96c-08d9b4d70563
x-ms-traffictypediagnostic: SA2PR10MB4682:
x-microsoft-antispam-prvs: <SA2PR10MB46827A075A8DFAE856BD0EECFD689@SA2PR10MB4682.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BgY29I9Hn2kERrzIZQzhtDtiKK4Licowmas0enzpYGOd3na69beyG4HmbBejF0p6ZO1b0wdJ0gs31Pxp1g3XHaRdF4WBUyjw4bPc31VnP6UZLNhcAoNgjUVtUtSTNhNtUrPS6BMWxB4qxAD6CMCGSdzDXUiX+uudlNHNpHsHRoUT06iE5es89hljoaepHsdI0xbRqiGULg4cruPxt8qh+ngl6l4BdOtA5IBvP6av66HYzBwJoeZSTnK9fCoAK2Wk27izSvlw+o/USSxOD3EPcza0JU5AfPSUwoOoXl83ECy1cXtlpXPFulvuEJV0fA86L5HHKF+QS+alFgWY2Nr/14MikA65SVXJSOtFqNEFaaLfbUcyNPwFwd7NFxLpCx+L03QU744GhtLVxsrukUQ26y/zpvZHLsTZeFXbI047cTW13aaD40eQMlT3uNF4pp5JwB/EKgUkS4JrraH+u4QxivxOlfnT6iAV7sdkkzZ41159lWfuLy99EfvPK2Zu440Hl+NQVdPug4xFYvA62t2TfzDpUTxSmuu6gXYSpstrbE0ObvGINJOmZyv/RRoqtFDsaHIVURXOrT+C1cReTc2ZQl0EwV0X6dVMmimqVnWinoY6/Y6b6hravQXZKDLFD70nf7X5vtZ89XajKr9O4GdYo2RIk2gziMKI8+sDy+hqG/FrRw4lxe35dcvwG/l6TVvs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(107886003)(7416002)(2616005)(8676002)(6486002)(66476007)(36756003)(122000001)(1076003)(71200400001)(38070700005)(66946007)(6506007)(86362001)(64756008)(110136005)(83380400001)(6512007)(4326008)(8936002)(26005)(316002)(38100700002)(2906002)(66446008)(91956017)(508600001)(186003)(66556008)(54906003)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ptOGaQwTXo7ocwF5TLeNWx/Tq1+Ml4n8wKt3mUD+sd+zkEKX86iREzYd5B?=
 =?iso-8859-1?Q?wPhmc906GEqvCRj8Ldxgzcbdgnsa3vt3VHOM3gQ74jtr7n9eTh9b8mjfwZ?=
 =?iso-8859-1?Q?ivizLBtLattIQtFy5o+XzlRdNzL/aWRZJ3SIBiPbNggND/q7fGKMDu1dPn?=
 =?iso-8859-1?Q?ayckvgGMyfH1FmQV2xj3NCZ4uRzZ9L3eHWwyct56ufxzxt8cq80utTWV+U?=
 =?iso-8859-1?Q?z5/Bmoif3zOxWpi4kyR7eZnkZ05TkP9MAng7iAVZbvSq0MkvB5Syf9YLQw?=
 =?iso-8859-1?Q?8XFYJIKgz+Qs5/ImhcsqNTk/TUSfGhJLvzfuSsy3imOZakZ7dRlsjtd3D4?=
 =?iso-8859-1?Q?THaHhgLTL6pA7KPip0fs3QlEQsjmCevbBbGY3/job4tVwisSd71eBmDjXY?=
 =?iso-8859-1?Q?xseVa9kHHp0SV3cKO+68cYBH4IZt1L1YS9YlwpXfcA8QGq2eOiI6MPqqi5?=
 =?iso-8859-1?Q?qrMBbeaX1Hormetv5pDXvw2srqpXqMCYUmFa/eSQPia46t2qt6WjWOET5O?=
 =?iso-8859-1?Q?AfuRH1/mCbh4SEkzIM+zkniuOkfAHc06hUsAM4eGoNe9IeK09XtUohhOm+?=
 =?iso-8859-1?Q?yEq8VfMPfQWrz7twb0siNwwh438/kAeB4jdgJxK+jdoDcxB7ptEAMMq23D?=
 =?iso-8859-1?Q?+Quptopw6QXLWwVeIIzcYxo2y7ebB8WRvMHRTRQeCZGbAu5IHKg85ocnk4?=
 =?iso-8859-1?Q?k7VwMGOU7a7e68RJ+WfnwDBM+I8fA6F8qMSWuLuuPri5dddvE+X7KLQnXC?=
 =?iso-8859-1?Q?DbsxJYzZPWietYMDVeI1csCXrppKSlZfVEDoaZsO8hIgX3UXCb4PezYInC?=
 =?iso-8859-1?Q?5ix0OsSaWqtePWW5Ef/VsWqiY5XIcxRECV3AMn3/0ozojvAWS8sRmdlLVk?=
 =?iso-8859-1?Q?N6hHKA6x8Bh5tnK84kgTC4vLoVEpJVgnFzGIp82X0v1YAzHzSDf0Zrm4z/?=
 =?iso-8859-1?Q?OTuahXnTwZGNH0lOogtVIzfpEHKqiByoUasugBNc5K8TdfDkWGXLwzu4bl?=
 =?iso-8859-1?Q?lB7Cq/XivE0ewhW/HgabWtgJYhjllEIOvRmBAXt7iF5MH10hBOtvmxbcQ8?=
 =?iso-8859-1?Q?yg9clvqpSwKwp9jTDT8n/fhrA3ni05xnRa3o4ixONs2bRvyUVtEEizt0V+?=
 =?iso-8859-1?Q?zkdgfiH6QJnJ4nnzo4aex8fcDAozQslCXOhPKbqnDeSS4CP+KePl4XmIYk?=
 =?iso-8859-1?Q?MDcNDaAH1TlhMPg16dI/dXoACfnMzomdP8QIFtv1BoFRwI9sTS9sxVV76f?=
 =?iso-8859-1?Q?smwoAMeAw/lC4kQUmMhvoxprJpR5I4MT9+0dPbv5b+eAuPczRPUBtOubha?=
 =?iso-8859-1?Q?ZxHPkWvFcqhBAKjRSorQglqkIgFiGRAMhMWb681wQLG8y18XrXQtho07dq?=
 =?iso-8859-1?Q?4kgfzOUD/qSVceCCD9yF4KLYaCTcMu53VN44Gp95ZllAqcCkUQ9pTxI/dp?=
 =?iso-8859-1?Q?ZfD6Wx3gIzQEY+Cm2M39jOZRafcdj920w+vv5tiBHhicw+S3aPs5+WT1L2?=
 =?iso-8859-1?Q?Zxqwm5EaC5QLnr8jxUeoPmXf+TRqpGE2tJC0MKlw+lUBcb/Hx6tPfqFwVX?=
 =?iso-8859-1?Q?0is/3rIqoAYPHFRp6Nz1/bdPsPiZwzyXVDAb/5motoRszKIRByDVAupV1o?=
 =?iso-8859-1?Q?OKW0Jt8G2qcYc3KcrlwVjKpA93lOrp6VeMmw3SZcuSdYoLhYqGj6tapFW9?=
 =?iso-8859-1?Q?6i4/lm8Vq2LvYFudJXM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce31031e-9104-4120-b96c-08d9b4d70563
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:44.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8es5czE/dJSsKDRfN2Ls2ilC6CPJ0tZO5s54NC/DysmpRL3ruXdATJuID/E/EBI3FxA9c0BgHsaYEsvWGUov5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=967
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-GUID: _RhoPdiiGpGATcP4W_JNwqrP2zMsU0IE
X-Proofpoint-ORIG-GUID: _RhoPdiiGpGATcP4W_JNwqrP2zMsU0IE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 2d9c59df60de..00ee01a14652 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,14 +24,24 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
=20
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
+{
+	cachep->non_kernel =3D val;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (!cachep->non_kernel)
+			return NULL;
+
+		cachep->non_kernel--;
+	}
=20
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
@@ -116,5 +126,6 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.30.2
