Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B83464FFE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbhLAOkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:40:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3478 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349994AbhLAOfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:32 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EP4ml018222;
        Wed, 1 Dec 2021 14:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o6T9RLReSyAul2/TF7gPSLi2ow585BDqa6WngvG/QW8=;
 b=PFQTeKVZQOrKZoiwZnpTv5T/lelzT86pur/n9514vIurU4S9F0YTfL1nFEaP+MPLH7qd
 piDHT232nM5/gE16jc949mM0+Fz+knN+pTvC9nG5f+KWBNbcdaXboWiIiM5/X/Oo1VW5
 /6XbFnqPjAJbfEZsAW0MKNoFb5w8TXQWmHIG0AzAY7azGImfvDlBAVWvoDpQhU/S/uct
 agsKmE9CZzCp29g+IENScr6HlnWHeZe6IfWZp4dzDDpimeK1IDujEFeMjgTxcxklslTR
 monF+jL0niivFSeVvBDrFxROGmWlWOG8lnIZwEf4CAvmUf16EWbk/ZbU/x9cnBCWxtmB WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyg15d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBl7b109791;
        Wed, 1 Dec 2021 14:30:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3cnhveqcc9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUEavyKNahYfLD3wPaR32TKmIXlwkWLBGMBgp4P6Cj3A9KyHr+XftAUW2jnLwzRgVF/hgeuOf+ZyOTwh+eI9icpJS+0ChtOBQwApBR6Ber+WRw1IbRIZ1NAS7FbdSyplZPI4PSACEko5Zo9QchyzYc2EKc9fLToNFCFp/YcpkJnp9F80Vpzd6gb0PThiqdY2/gLPNqp2SiXVnlqjb2BJtWLC13+Le/pQE5RwpZPi2kN1tqBoMSWMRpd36qG7mp0+1BNonhVUSFb+TUS4P9I/gHptdzROCtbVzA4qg4sxUcc8PNGzihEjZNJU4XUCDgGFJgzzExI6+offowuNDEhRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6T9RLReSyAul2/TF7gPSLi2ow585BDqa6WngvG/QW8=;
 b=YvPgEJFvFbWYNs1Hl2POEDIgMASApsoNB5ApFDotGfi8m1NK5sSTWbo4UgegQ4R1L25YcdVK75E4vDJGl6Sspt5JhcELRsv/6rJazYD4uMGzmh97AklhtfAlYyFeWNKtTdG78fMGbDNh2ERS7N/1HUTSlj8vi94CRwKq6zg/b13Jn46r4q/rJCPy05YeUXXM471Q15SnfWYJg8FWxbgkzypRXDPK6cLExGHoT1al5CVDtyJGz2HIpeOjdgJAAZ8ZWbXSUdMkrB+l93D4iZuufD0yky2vcVHJgsUq6S66nGF9XbQFgDXyFxHJiSzJfM6+/JYC4BdLNhd9r0YkkGKIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6T9RLReSyAul2/TF7gPSLi2ow585BDqa6WngvG/QW8=;
 b=y+nJ7hGib7YpYYRc3jzpGjXvg+cEgVKrL+2U5Wr5HXp6PElnAlCP8BG5wo8TPIvRyyfIPX/Xp2lhBKtqPYYpAz+3c0vCx0Cci2+ZiAq4Cc5b8TVbtVllOinQgq5ZLahLC0qpmKAhJaDQmOp9pCOVZ0gpZH+wiLEuEsmKAvYeWI4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:38 +0000
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
Subject: [PATCH v4 42/66] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v4 42/66] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Index: AQHX5r/xefKkkGSxLEyfIjGHfmNy0g==
Date:   Wed, 1 Dec 2021 14:30:09 +0000
Message-ID: <20211201142918.921493-43-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b4f391e-d94c-473c-2be7-08d9b4d7252d
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508046A858E9280B666C90EFD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8wVk6Sw4SaykK4DtaYcE+fB49y0rXnZ3N0CiN+1TE6dvjKKZic5NOolU6Edi+QjWi+w72GlCngSV7xX6l3hT7nTVd4hoWZ8Nw9CdX8u6CjmK3BFkP7JVF6m/QR+Dm4jM/7F6x5vWIG0ocs8udyqCRgH1StcBLItenOvVP8FLzbFsBaf7w7oeX5rc5kf0TKIjvENLboCTFnsWsOdx4S+6OphVwOFRBLXhD+RzhplBKzQ2J5b4odt+KtW+/5zhKsHUaadqybBLzD2mz+F7L1KLBsN5JEuu1VNHojmurV2K3FP20VmeqVJgScAENHbD42IYlYnt6cxmAR9elPQFXkZhiWRbJ5HaDRwSh9qukeV7QsK2fu/HMsJcdfT4rufr8x8VyjuNth1B9rzW6wP8+KcF0YXiMovjn94W57ll3KfMOjS3AYsBFSPK5sjrOYQY8uN2XLkLoUkpbJjeJT1iUBM/+Gf0L7VodVQuO2p0+jRwNxi9wp8uXckm1x08Bpp/s6mUp/i0V6A9PPvGGzSGfyl1ryu5DXIM2yJhU9LT4WY+mCJOA7QYWieqAl6vw462iY5ScHtjuMkHN1m/1PbQfXZsZ9iq6heJsCH24KgfkncHXk/g64ccFxT8pyZlW87nCVjWk3dpQgU+VIcXHtIPhzmVBtAzQTtMTdU0m2daWevA2yY7bQpILstttoGcUGZjfXBEXzShy3QNDrR3+rVNZPkcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6WJvKmi31WR0/LShIHTE7n36DxDoXWXVfZ4I+Qe8CE4HAUVl1aZspqMc2F?=
 =?iso-8859-1?Q?KUH+bmdvBvOI9EWtoPSDNGUbGSBik9c5iLUGGN5j5L3EbAqg0xXWx99kae?=
 =?iso-8859-1?Q?KcZl/4KOS2JgGJt4BPRV+7XjfQvfUo2ZbmhNFeEqFVbUVBNm756VXGeisj?=
 =?iso-8859-1?Q?s4mSvsv2H9QtSzc/mrLxalaMFDpd0cN9agBYFLL1CbRUaU2AM2HOwZeB5U?=
 =?iso-8859-1?Q?y7wJmrWvvD6eWvkfCs7dPgv3DOzrIINYZl+liukIJrDoUe+IHDEuy1SAOs?=
 =?iso-8859-1?Q?R18xCiW5Fy0U5/cSElqnbhPovl6QG3e98Ytl3cWicdHmXxtBN3W/Cyq93x?=
 =?iso-8859-1?Q?5X7lDX0BHyyFDoB87a8f8aUptn7g3x56pqKIN0SM6QQdEN6/xeZ3V85SPe?=
 =?iso-8859-1?Q?KKAoHVbxN0fwafRci9BkZyzt7cL3TlCfuTzaL5gWu0vGNW6Xkj2q3Ms1Al?=
 =?iso-8859-1?Q?YqsaWd2cJ/8RBTu2Gtc4+W6gybTgDtA8RhYslnNc4XOkb8DRvZeAbgXKN2?=
 =?iso-8859-1?Q?qDh3p9+c7UhfetkG+cLQGPyZ71exKSL6Kcen5tTU/RzQPJpPxTXLnlQk92?=
 =?iso-8859-1?Q?SjX23rzwHauzOR/+ifvA1Z3RLRBeAxSfIoM4ukNYXkTvyLnTj5Ix1bT9xJ?=
 =?iso-8859-1?Q?zJTIXTIt3qBIZ+zVAq+v3aUkVjA+EaKO1BqzgBRhbHdu0RTiFneWJbPNoM?=
 =?iso-8859-1?Q?tzkTJ32JqUed/9NJt9izA9Pq+Qch7S+roFcYpAkIK7afcfIz1CBLLL1NMO?=
 =?iso-8859-1?Q?SkSMB0Dh+voHpJn46ZyceZdnPBhSRCoBZ+jIHoUSTas197V/s1rQdPTDCI?=
 =?iso-8859-1?Q?iIwQN97eJkZ1fdBy/Sg4SBgUj9Jq2e70jObKK5OwA5MMucP6hM/ht+x1Sz?=
 =?iso-8859-1?Q?8ZVhpOx2sNab/zEUjFjSRFvy3C9xdwbC425/6DpTgVh6QJSRxgEYPaPb7/?=
 =?iso-8859-1?Q?jXK39/+ZZWyTzzESfhr+pNOpofpM4kpLJTR1tU0R5XLdp5RV6FMprbAtkM?=
 =?iso-8859-1?Q?DP9B+pfV8EQF8mrRrsPe9+ORRHifAdB6lkzsO86c404pkGbY5HnIjw78zM?=
 =?iso-8859-1?Q?sggf8QsBoTg2nB1iVDxDPtPZaQ3e/7zVujZ1yz0Efl3ZVv2N34Z/a20cZu?=
 =?iso-8859-1?Q?z3OJSap0XRiP21NMWa+jfyCcEK+v4oqxP3zTVBHcAsB+StPQWXYVptvyDh?=
 =?iso-8859-1?Q?b9SpjgioxvnKmLwCCX6TTCppLZarCtL6TYb5ppVfvPvn4VD2Nn890HlXzH?=
 =?iso-8859-1?Q?yvG1rR1XC+ssWEwQR4juV6t4/APSRLWFn46nDcb/5uncu3YkeMXrlDg2Ko?=
 =?iso-8859-1?Q?kpHl8vdYZyC2myLmG5zlQR5BM4sCjF4pioWFnYHLlojaXbEmvX4BiiYUUH?=
 =?iso-8859-1?Q?BHqgwlZfHl8xF6CsuJuKNvl0erW1l9JeYoqD81DDcyWMHTqcuDVPAremGa?=
 =?iso-8859-1?Q?ogKFDMabq7ZuR3AP2fRCKqHeCmd5dzrarwJSr7VjUyvQ4cV/cvltqdmDNh?=
 =?iso-8859-1?Q?nA/LNuycvvTE6Bu8Gk7B6u+XFu4CbATUjqd4hle0PEvFZD2+aTbeRWGHS7?=
 =?iso-8859-1?Q?AYFRARscoPd0UjsjQ4wzz1B9vXBrI0cJ1XYVbIAf/gjREEfbBn/LC42Vhv?=
 =?iso-8859-1?Q?38JeYHDH/+vc3Ovn5HLp7frAXET3aYxWnf9mBaU2/cDQsGc1Xb+xnw18CW?=
 =?iso-8859-1?Q?C6LQO+Ypzn86yK6Ieb8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4f391e-d94c-473c-2be7-08d9b4d7252d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:09.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXO4K4czRth6l0xJb6XNttTcWIDuI35Yx+rjGKYwKlPQ4eesb8zkkaXMKYm+xmLsnSkGRoiprFx8cQbYmXCB2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-GUID: 4-388LoRnQmcB9WC-ZlHqM-lAWIZ_AeP
X-Proofpoint-ORIG-GUID: 4-388LoRnQmcB9WC-ZlHqM-lAWIZ_AeP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove references to mm_struct linked list and highest_vm_end for when
they are removed

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/internal.h |  2 +-
 fs/proc/task_mmu.c | 73 ++++++++++++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 03415f3fb3a8..45b132c609ff 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -290,7 +290,7 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 #ifdef CONFIG_MMU
-	struct vm_area_struct *tail_vma;
+	struct vma_iterator iter;
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 300911d6575f..7cc97cdb88c2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -122,12 +122,26 @@ static void release_task_mempolicy(struct proc_maps_p=
rivate *priv)
 }
 #endif
=20
+static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
+						loff_t *ppos)
+{
+	struct vm_area_struct *vma =3D vma_next(&priv->iter);
+
+	if (vma) {
+		*ppos =3D vma->vm_start;
+	} else {
+		*ppos =3D -2UL;
+		vma =3D get_gate_vma(priv->mm);
+	}
+
+	return vma;
+}
+
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	unsigned long last_addr =3D *ppos;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
=20
 	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr =3D=3D -1UL)
@@ -151,31 +165,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
 		return ERR_PTR(-EINTR);
 	}
=20
+	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
-	priv->tail_vma =3D get_gate_vma(mm);
-
-	vma =3D find_vma(mm, last_addr);
-	if (vma)
-		return vma;
+	if (last_addr =3D=3D -2UL)
+		return get_gate_vma(mm);
=20
-	return priv->tail_vma;
+	return proc_get_vma(priv, ppos);
 }
=20
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	struct proc_maps_private *priv =3D m->private;
-	struct vm_area_struct *next, *vma =3D v;
-
-	if (vma =3D=3D priv->tail_vma)
-		next =3D NULL;
-	else if (vma->vm_next)
-		next =3D vma->vm_next;
-	else
-		next =3D priv->tail_vma;
-
-	*ppos =3D next ? next->vm_start : -1UL;
-
-	return next;
+	if (*ppos =3D=3D -2UL) {
+		*ppos =3D -1UL;
+		return NULL;
+	}
+	return proc_get_vma(m->private, ppos);
 }
=20
 static void m_stop(struct seq_file *m, void *v)
@@ -843,16 +847,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm =3D priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end =3D 0;
+	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
=20
-	mm =3D priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret =3D -ESRCH;
 		goto out_put_task;
@@ -865,8 +869,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
*v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
+	vma =3D mas_find(&mas, 0);
+
+	if (unlikely(!vma))
+		goto empty_set;
=20
-	for (vma =3D priv->mm->mmap; vma;) {
+	vma_start =3D vma->vm_start;
+	do {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end =3D vma->vm_end;
=20
@@ -875,6 +884,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -918,7 +928,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -932,11 +942,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma =3D vma->vm_next;
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
=20
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+empty_set:
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
=20
@@ -1229,6 +1238,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1248,7 +1258,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
@@ -1260,8 +1270,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
-				&cp);
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
--=20
2.30.2
