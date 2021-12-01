Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420AC465005
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350274AbhLAOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11436 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350131AbhLAOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:35 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E5uxP002539;
        Wed, 1 Dec 2021 14:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CARcQIoSE7KxRoOTp7BsZKY79szLNdajhZnrW3Yhf5E=;
 b=zSP07lKguKTESuiQA/JS0rOcsbBxL2nPN7jQDx0VuRaityfK0GkpyylCvdi7IP7mWQJP
 YqrInfte6CHq0arIzK09A+ncYYaARJ0byFLzhI6dwHU8ECbhOQwwlVkxN2geS46kyG7E
 1NIjPG9ywmmo0Ii4hxLVfJYTlwutzBePQlDQ+46IthncIwrR7hSC9cxnHrXsL+tUCI6E
 5eB0an/+yasZnBT8ptBiSbi55O/zy5sHOHUhkNLeCUTQWFc66YpK8s7TKgOEeZeCpAuP
 t53e3P2l/CaMCaphrYmr+R9kZAtBahwy5D9c7Y0KcL/iL2NEcLWmG/+wMSkCoSqQUv61 XA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx222m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPZ108922;
        Wed, 1 Dec 2021 14:30:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx1iSCp/RIou0heZ6lYQhsajqF3piPJeVfNi/HZHh9FKRKQCuqy+GwUo6PzYxaaU+xtqz3JicO6Y0lQq61jgdqPceOxYl0PWOwTHdhUXu7ZZ4lWzDDlX4qDLQN1Eyr1ItliJeRpjA1rwdKeQ4UqfGSjP5I1gtgyh/kRctw6NVuYwcTx0wUimUBaXMDHx5kYhLXMAp1KDcI90Re28MPqdb3RKafkneG2/pVrbXU7zmQOFpeuronJchwHzFeI5KAUV5B4j4xX4WjBpe3WHjMTAgtwyuRxyf+tyBY+5KLN9HxlABNh9qWU9c3MWE4C0Z9ftPCEM8uAQMoYP9WLykK73XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CARcQIoSE7KxRoOTp7BsZKY79szLNdajhZnrW3Yhf5E=;
 b=XsbNhYbf+qsGMABhDC/7DrQ7Swj0KR6UcvwsLppj/NCJm+VU0+vCHT5QvJUDdPdoQzoJFSIxdqSmwY1BQCq0oF8PE0xH0516wYWGWgFEDyQYzpVaKhESVqcxAbn1lqej5ujFTb7LQ3IyvathTpSUG/+VOqO3wE4c88jSl6jlHzpu7Zg6aL46ZNcPbp/Vkpoovgi8dc5PM+SuGF2V3etlo7cj5ARh2yf0qHmnkemTi3XTJjxip/jG8p7iPc5vGmO+tFp/kmshhgFpouXcgqbDCnwTcmBVWkJJZFzJkSeRh3JLFzwhrjgC15fwKA6TJVVzofbV/rqshofwF69em51uHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CARcQIoSE7KxRoOTp7BsZKY79szLNdajhZnrW3Yhf5E=;
 b=oxHgek7GNijso8ofy4rR0cAeIrHSNLUW2AuOQQdYFzfwJlEi5qL4ndnnB1sKtpTpUDjG/YOZ33ROP0Z5v6kiQDAV7Z4knHHGF7nEiFbg2XudP6FLDjTTt9Ji3FC/Bq8Jqse9RhMpwYsxiw6nDrjoKhIGBL12w5+nr1MH2f1BYfk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:39 +0000
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
Subject: [PATCH v4 48/66] fork: Use VMA iterator
Thread-Topic: [PATCH v4 48/66] fork: Use VMA iterator
Thread-Index: AQHX5r/zSvRE7ckScUaY46O62ena6w==
Date:   Wed, 1 Dec 2021 14:30:12 +0000
Message-ID: <20211201142918.921493-49-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8d56a02-93ac-4adc-05b9-08d9b4d725db
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB45082DC43574DBEA44473F74FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nG/Ud8MpL76WPUALXHaBIY6oCSvBl1u9UqVzvOl4IOmdVeicPNKpt9pBRaXtLzxKXDMM0AI7XvcUCl9E8gABwDIadcp5GM98GRxsGg2DS8ZlBk99VpTUls3CWdH1QVcymPs0mDA3XAE6R8kcAI6ve+8sjSNyV5f2Vtlx3LxmLrM+D9fSOpv9W1vsiO5wh8N1+2phVbSxxVJiJeJq8f9rMSEFeHWlNV8CSBp03336jNkdmb7odIRqaFf0V/fPWLXN3dD9eEAtlUUSdK+Uf3Pjz2zwvt5iDoIC7JDqFLylc1P8Ph0sHN2T8B22hLvb0LivK9sICRIo1DYYGKewPHioko7b970JpXVmiQIydRusJh1RR4Xpngf/ermAdsSWqetuTEHgke8sHVFy8zqHWirwIomtldIhw/UsAnJVsxHv57YgY6GIXATzmwcACZ/34S/Y4Us4vnW6AMpMS5ZWc33+Vv9sBawBLstHYxYTUXGg16V64hrK4mBWjPb9qFbub/QpLs3IA3YzYOIbLOVq1GKKQyljKFS+dVi8DoS/pAq5CCYUVWr1oJ+ZJSNUlNROftKJLf+jZYcr17WMjuhlB9EL0DsRvqZXwPcz3mt5y8DdsBf3GMiGtBqna25qJ+mGLVumqdrnFiCTUvDaYAzY0j82OzOdyVD2hDB5LBmjEv4zO9Pvnf55Q4WMh0f2+v8oTzyKnJCqLuovi8J6yzRL7AIf/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(4744005)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U6TdFqCnbetys8UaOeN9Bjh+S17EoM6TOHbbjI0CTTLrP1EaxIXLEFH0qz?=
 =?iso-8859-1?Q?axHbglnxPdn1xSi0PfXXii+UVsNwSZg18qV+VWkSJAYgG8oHEenuflXg5k?=
 =?iso-8859-1?Q?qDx1R1cvpJZ/NSLTPkpMKwXRHu3ECuxn7Ubd8U52PO/PlA4wSoCiLrusYG?=
 =?iso-8859-1?Q?cbzDTf1OlodkjCbAnDNaIF1WHZYZ5unJYq9sgGMomilOht10ghKqKfhoxI?=
 =?iso-8859-1?Q?ydklZ1prGRGbq4HJL3/R/1T3hChCbF4agOj2zIJQIOrOm8nTkuj+6EAjUW?=
 =?iso-8859-1?Q?8WkUPmo5RgeMF3wVlkSCKhQV5GrXD/QAQHnDooh/yhipP2JCyjEM63wcUS?=
 =?iso-8859-1?Q?7LdWZu0hivEAYy87VfHTRAAV70It8dP8urHS7HP+xS0355MGxr/t3G6Vmc?=
 =?iso-8859-1?Q?alaB31SyfGku5pUFxd0zGQY5eIzPZcq3970LtYURzEGouj3SZN1VIv9twO?=
 =?iso-8859-1?Q?aSpkhLo4uLcrp4vH4tlWitwFsUcJGc7V1bBckupZBOK1zGj9Wb7KytQK0M?=
 =?iso-8859-1?Q?Cl6BWHoqb2GP7Ky7MvFchUmIlttOmsrp0+jfQYjPpXVoPSdo0ISL6Y4ydQ?=
 =?iso-8859-1?Q?2Szsa9TSOHVl9NnpM9C53YjqZHWRWTyv9yr24wRL0+KkSLZEs9C2z4vsBo?=
 =?iso-8859-1?Q?iPkg6jtjS7CuXs7npMuUOXzd8OyU9gylMWBs+powFgAUHmcLaH0m8ocZeO?=
 =?iso-8859-1?Q?AjLZIxj5BG0roGBuBzUFYND1QlteTl+fWWjAYi0zj5kWiockupjRZWimST?=
 =?iso-8859-1?Q?ZNiaO8kqAziFhnFtk35gZJIkwise7cK7JJ1+rgcHrxBjbQV7iNRcY+CObl?=
 =?iso-8859-1?Q?v1tEw65LQRKMfEryt7d6ljYnF/m3m6w9sz95NT/Xxj1+JhnekbTmqhfG6a?=
 =?iso-8859-1?Q?S7QdlpcK4AzVatbxrH1naT1wPr+AG2Ux7TpZXDz0w/4e6Zc1PqpXvo9qJN?=
 =?iso-8859-1?Q?vq+7SvjJydLKfzI+60hY8/dibvHgOm1uMCXp4Tj4b1KipYPE8U3ToO10KU?=
 =?iso-8859-1?Q?mh3aXIFZ+9CfNdSh5l1Hp/HTih6mJUom85ZV1eqbV9pyaj5OPtOMyeZauP?=
 =?iso-8859-1?Q?ctQsDYbTRlaWT83bbUeGSNKpKD8MWikPTpjvG2Mq4JKlSVhu35b6pTDoN1?=
 =?iso-8859-1?Q?DzYwMqvArnk2wf90OSn2TWfD5nB/Z9asSsVkF3CNj9e1MaHmSgk4pIQwCE?=
 =?iso-8859-1?Q?5WcP3o7qoZuyeApvK1gyvMPFQj7c+VA9bmL6ehYlzhCYTf4EauVu+dLcMT?=
 =?iso-8859-1?Q?VnOiXfBGn+TU46Hf/UeB1g4pHGfFN3XdQPK1bHm+og3DOCruJdbeBNqBTn?=
 =?iso-8859-1?Q?Cdt0z3fNGTiwKs9tBA4iyUJyusJJVew5K2EGTzqpx8S03wgMb9BJQUauoe?=
 =?iso-8859-1?Q?1bdKQkDZXX6XQco9Ei7RqgD/KrGK/VpJZTpmL21U3w6FJ9Ll9bD3KvZdei?=
 =?iso-8859-1?Q?/FCd4YrsWejohSPAL/HKi/px3ci+YhPm5Q8lJTYv0gFV3ei2Y2mtx+kkwz?=
 =?iso-8859-1?Q?y1Txv7Vitsrgp4LxABXEPBeXv0837Tei7+SoiJ3lDsK2zchXWhEn578DtI?=
 =?iso-8859-1?Q?bQDuX3mb0hw1eI6Xs2+TqpGQXDRjEb3scWYvZaIRk6seYfOm9/w1fYlSP4?=
 =?iso-8859-1?Q?NqaqiXXQGEhpmmGFTsq4tdkLc80ff212oirFKRjVgFVdmCf0nlurhSD6e8?=
 =?iso-8859-1?Q?AhDmL/EExxJZotGU2pI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d56a02-93ac-4adc-05b9-08d9b4d725db
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:12.2450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RmmhRqKFMcnHEgwNomB4wo1unyCnRFs42XYF5am3nA76Vs6m/NbO0yoccOo5pMxgy977/VkOFw9ZPX8Qbd3WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: pQ2rdBTwvMYx7spNSpPqE-3oDrBX2Ene
X-Proofpoint-GUID: pQ2rdBTwvMYx7spNSpPqE-3oDrBX2Ene
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 3493117c8d35..6de302e93519 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1228,13 +1228,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.30.2
