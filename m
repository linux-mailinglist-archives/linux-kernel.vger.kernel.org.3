Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C264B70AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiBOOrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239255AbiBOOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C0117998
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:24 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi1Wc014275;
        Tue, 15 Feb 2022 14:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XCKZLGm11wRgtFSVSKrkmZhtzGYROXMb8q2rpXH3wmM=;
 b=p0ntKPmVP3P7k1NGuEysDxpP08tQZ5lj3Easge4ontzrkQysHHWpZqC93d+U/oJTQjly
 b73fLPCcKz/C/Zz/+DAdGaHbTgAtKUhH7N6qpmPdUXkUijPTwjH0x1MsHuvl8dwb/Tyw
 eEOKXJptjkdobvWd2lx3kkojdbd1L/2L0mZE4x9fiqRSfh6ITRGbYu4KEdnra4wNGc2R
 j90tZs/fET4bW6pSP/I4Hby1AC1jsUbC3XTfxDSZweveEdd3BaT6nvVii/53XLcW8IKP
 oOalfKFfFv1CgupQF6VLNmA0eSKEIDgM17/IXqRN2VLzdcgSG59Wiy+kRAQUKl5Ps6wl 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8570shtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8lq016243;
        Tue, 15 Feb 2022 14:44:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3e620x7vn0-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEMVVMFzMR0i4lCAmxbfW2ZmrDg2uuRj3lk6VhrzwOqBNkMlPl/7kDx5HwhKV2qTmJBiFubY7kJy5IEW08IQWdcK75kHYtrQJCSoNmh3slAwcsARjMYP59sjag6CYa5N1slBwe71oXRPXfl8NGvoAjKcONesAaT0CkRlumwz4KKKnfmx2o+r+4lFwE/X36/HrWglkFyW7MnVApLEef6b9C2MT96ybhRvXuGj2Vh4TVslvx8AwrwXeezhJ0bXLpdx/hj30GMG8xoLuUPEl0kkglpW5hpD4sRYzlViY7QFcxIvBkvUlNbuouEet/VS/yfcl4un/IISf6tb4vq0r1foJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCKZLGm11wRgtFSVSKrkmZhtzGYROXMb8q2rpXH3wmM=;
 b=lI65mreF0SpG+CCSBloCWErhqGxHGJlKfYu1tGkGVBfNzpfPwXoHvCMGgaDPC9z4vTZqpNNbLoFcshN0+p8kpvmwnD5XAGjcHPM6/+HihAig2Bt93PlV49JbXGhBHpi9J8f9l2SNufc0PNiLzDOWTz87ojWb1SX7pMG//zBf4YWiyrH2sIDT6cR/Eez6XqHmif2iNGsCqO8vNRuyc5BehfuqqavcRPe+YrIzxE5DohUUA6I6MvIg3RkJGjfPOgMSpv0P+80z/caZx2l5oELj/30kDSxY6tuY/Jco1yL4GOQj/Amko0WxpEFd0YrNKWNTatFsFhfcnryulRZwIhPf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCKZLGm11wRgtFSVSKrkmZhtzGYROXMb8q2rpXH3wmM=;
 b=yeoBz/IsK86psLDKYc1dpDGs1ESXyDyUTkaDDrNq1dwTtrHDWP7xLkNfZggqn7rDxxtlCe0wztOL72SwpKE+Wr4aWfs7vXNjG6UmolZdUvELiL9CYweSPtbcImwwTe3aXaiM1MNStr5qqxBtBB6rZlFt3UnaAOrOnFZGkSaI/Wg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 57/71] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Topic: [PATCH v6 57/71] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Index: AQHYInpi/j7Dg/kFZUuugS79rnp7Yw==
Date:   Tue, 15 Feb 2022 14:43:24 +0000
Message-ID: <20220215144241.3812052-57-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a795110-3b10-402e-1aff-08d9f0919b2d
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1863823DEA45A531196083A0FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4wECRhT5fDcPXoCw89DAgGXSYJpDFe8HqfLGfag6W5g5HML9DX69XTihZollONcwmKhagNyv0JvxnEdCQzREe6iAuwuBHeukxSZoyDBeu6co4IpQrWozhXxmyIrB1hyZgRqVGGRVVAls9SR3/fRoSTdDoJjRbVwX6tLT3RcZHdjowxhaQk0/scKM/ltz8GRK+tPcMBRo0Ie1fwjn1p9tkt8o/77SsQ0+bs4RjP7PUqGpqnmU6CNX03G0PfyEfxWZC8ch4sGpLwtNHUuqu2J/oB7pwX6ohOsljkJ20+DFpiYMAXXh8SH9tBmQHRXB0AOQKi2b7Dmg0/NbEtwU3eTcXdLG439UXFyOMp/kuUXaxkX4hCXXCky8aMzUWMcCK7vQ+4mZTa6/pR1uAD6o7z3WiuR9xSyeGoaK/809Z9MRadU0hibvqdq3kM6cSfVl2QbZ7LJY79xvDTlNKtRnii3i/fqSu8/z5f6qQTPQBcq5RhJQonAbuQGfW8B9n+ykIWaC2xZesokg1/67svmBuTHwmfvTT0o4RISZxXkk8lewyEl6xOZzxLKinIM9Z6NtOF1DP7W828/y+qwAkFFTP4RnZLIhyuYXtF55nP06qo/6NIYZibggEnWszrwRI4TPUKAYpaS3fRZ0Egj+NQLV4GjelpASAAwkjY1SrEDEFm3imMpYwiiXQ5rM4kD2xnfPl/xPaCDQM8n6sitsZ+K7LlRISQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lVrQV5rOlabWPeVEO2LgNQIgzvO2RjGZOtGwhUH1gtVbK3B2nAk64/6P3s?=
 =?iso-8859-1?Q?QyGAWKuAw/Tnrr5ldakKqy2p+56Lu8XJK7KSZUZ9BzivqwYYE90UMgiym1?=
 =?iso-8859-1?Q?55hM+g/fHbD6OiDHgiFCGI9zfDIdsz9cfdLhV7RSYaTij6eil8jp/Ks2Rt?=
 =?iso-8859-1?Q?0mAg0+PJ1UOzGRoFO+alotkUfTlm8Zw7aFCht/AgwkdiiTaS4Nyns6XLrx?=
 =?iso-8859-1?Q?QFTRR4YSeqbIT7pFxOZDk7Y/0PUwVtVRXvxnCcBXPZmV/YrhIn7Mw4LnFA?=
 =?iso-8859-1?Q?2gY8FX8wonEFIiRFPlu7sK8BHQ8M8kA9q5edxejoUKekPhbA3yoE4p51MX?=
 =?iso-8859-1?Q?ZJbL0iH+AlNxxj5mG0RTAYqOLHevaf7a1kCfq7HGgq9VxCRR5f1FUDfh/F?=
 =?iso-8859-1?Q?uhK8WFooOYTMXSPY9wN2fa/Wwrw8/EGsQzcYKcM0FWcJYZOXcb9UuRTLkY?=
 =?iso-8859-1?Q?d8lyCSYuMKs2Ld9LqmWOK+QQmGr2piSy69jzp7Re6HQdLUtvlUALsGKXS4?=
 =?iso-8859-1?Q?LoSDt3Ka1JGiaGU5TLQUba4M1lKUVZPCAb4SMoQkqyWPYeNwSyaMI1uqHH?=
 =?iso-8859-1?Q?FjIDXdWb0t1gWm1Nefv0GX+ZbD4HgEvodomk0C89jTAR3JzRltvI62Kb1Y?=
 =?iso-8859-1?Q?VHBTTqWDcgqe704nRDWPrW87/hznxfOx16rWqkG7AFSYdQu3enrhx1ZQS/?=
 =?iso-8859-1?Q?+wN6QZZhAPH+Y0W5u2hC8ug98hDr2ebnFCpDTBh/exr/70akOlX2nDo9Wf?=
 =?iso-8859-1?Q?pJvWdsWCrrwnmK0HmZgLqbe6Xq7sHv/4jdB08L1IB9XQtzEPUpoKpFObck?=
 =?iso-8859-1?Q?pXuvAU2RbjVOn5RIgWqQXjvRMPleLqRjBEBF2YoDXXBZr+QiE/EI7FI3Mv?=
 =?iso-8859-1?Q?zGXEmo6Wi1g9QC0e9WEWX+ol5ixBhCWk0tVDbHW9epFto64nlGNzk/7Tb1?=
 =?iso-8859-1?Q?Te+7E8FIJkSvjUSsQ687RtzHavTGh1YISl/WZKpeeM+sq3L0u+/sEPUdoP?=
 =?iso-8859-1?Q?Tphc26NHrQM9Tx8RrHbWKwGWL1Tzr5IXpKBHOzJdKAaOyaAGqtbO9CSiiQ?=
 =?iso-8859-1?Q?yMSW8YRecVUterDFzQ5Jpfa/CDCfORih/HC7jyKjA0ejdn+ieTBMG/JTHh?=
 =?iso-8859-1?Q?55OjiIHW1wI/17ikMUGVhhab73o9NfMSRYnqABPBfgWnCQgcDNkJZ6axTe?=
 =?iso-8859-1?Q?Yp0sG7PXwAumTb5fPE85gE17RvYeDmFEOwJmZsOLMj8EloSCbVi854w7ZN?=
 =?iso-8859-1?Q?MwNylw6c/HmQp1cdkZXceCWRXgwkKlWElyd8FPyFVoMYnlU7QewgVKT0rj?=
 =?iso-8859-1?Q?JAUfS+rkzoYBpmMUCoTZw/ZndY+ZisSRZa7k48a/wb/1wBu7tEjNrxfEwh?=
 =?iso-8859-1?Q?GlV+gcvbzRXya0rsxxOf9Kv8RtKKBRYrayLLfb6jkbzuYWGjxmctS0dsgG?=
 =?iso-8859-1?Q?p/cx1nXIcmWphtcf1An31tLddE0P7QzCO2D85nt3qAEAHCJ+0ufDAXevhQ?=
 =?iso-8859-1?Q?Tjcp0mLy45rsytg0OiYkvvBveFFxI8fddazIgRnQX8JjN7elnpuc89J5+e?=
 =?iso-8859-1?Q?KHfca0WN/7FC5Ih3Uw8SXujLFtOpZGLh9R32MdKJF88JOiq+nMDlsul3sF?=
 =?iso-8859-1?Q?/rtoLnCjS5cKQV3t48AgaOWslAgm5UYu3hnFWyDprfR3p60PMk2gJWccoN?=
 =?iso-8859-1?Q?Xnsoo7PDp4IzTHwthU4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a795110-3b10-402e-1aff-08d9f0919b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:24.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Mv4n7sn6bE8RSIhZkcz2GdvN5ksXZV6+u5P96Oyvf7vs/l+ty9oqQFGzo2LbWgGma150vc+Xl36FamLlX4qsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: 8WkxSC2pwfOX8PmrX0Tc6e7B0sZxnP3_
X-Proofpoint-GUID: 8WkxSC2pwfOX8PmrX0Tc6e7B0sZxnP3_
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

Pass through ULONG_MAX instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 36e9f38c919d..512e373dacce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5827,7 +5827,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6125,9 +6125,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.34.1
