Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532164B71C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiBOOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiBOOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F80A119F55
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:45:04 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhimo005586;
        Tue, 15 Feb 2022 14:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E7+dHJtvorNCGjr+UxjNurapE/RZ7+D7tnhddM1AuIs=;
 b=hzFtpqZZqht9uz86zLMYVW4E+zESsLEDPXIEmlO0WzROc3SAPUGxUL5kHJeyOZlqC1Ro
 nTtlIQB4z4i0wV7PAqQJvzLL13m469QYOx3xxPFqD+J0QknZX85ruPqT6QOqvWuKsrNs
 Gnbp4BM+XxinoSNxD8aqXJQ0L1zKttMG5xVtf04LqmZoQB3ljFABrMFM35MgIiqtwK1T
 94TAPbTus3qhCUrJ/T7mx0msaR/KaAaZSfshFZ8I39Mmol0W6t6cZw9EXRqy5T1MJUSW
 LHNe4s2gTqWZ9vwg1ldwV2rkglXWP2TeBhawPdVOpdFEGv9T+wDq/ITFuQo36yI2xypD Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh4jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe5V9157068;
        Tue, 15 Feb 2022 14:44:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3e6qkya227-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyCZIH1IVH1WjoMDxUGimrKgGPGLr5URkXRssmUTp12uRGI+g308vdG02TGoSKtfzNSzHrXX2Y7dyR9YxlyaCMImFVsNCk/GslAeRC50i65ZaVItyCRoa0y8tXg+ekR3x2v8Dq+9m9offTac/MZORFZdVv2K5Vq7CoxXD7jv9+4l+4OyvDMHNQTUmqtOevLugA426XsTFuF5yG3PeVGLeCj9qb85VWpDGE7vI20vIoTimZ8k3UDWc4UZhcgd95VFrTOzHRqOM0zsy01smMe2hGJnQOEt6XXBAsMuJuzBT5GKF67dqFcPnfUK/o7gk+7Go2i+DvCYtcn6+rA9vwBXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7+dHJtvorNCGjr+UxjNurapE/RZ7+D7tnhddM1AuIs=;
 b=HW5Uj7SoCSG3svjltmHlZ2Db1G0TdchCh1aTqp9C4UEZ9fP+PElYv+VbxB4p3+SfjNxZFLyKiSVZuUU/woT438rd52KF40VbZeMzrfwQYzUT1T9vrOQWv64yAbfyqVGyraV9PiiSdktsWD/xAm1tau4dikUe/YbhxzwogJdJKj2olo1m2bGBcZWIj609mRrunWUyuuZlCRbwXJ2FGaT9wPN2Bu6gLVJkXy2v1OsjMzwqAsnS2pjglN1J8EDKieZ/waeOW3d/YYWk4fFlgU+GZL0BLsqUwh9J8CYYMGFep8i3fse9HPbl1bTpRV0AnZfXpPh41kGL8IhNEwtSthUQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7+dHJtvorNCGjr+UxjNurapE/RZ7+D7tnhddM1AuIs=;
 b=yL+9ij52XNON7KvxNU87FA/yRUSN9dq9OznyWgaJ9+pV2+YOkZfj9kLi38AuKcAYo3fG62gIoZjuIkyGTDKHAClksUpxFua6vJaFfmbat8AtcWXuAEh5J8keQVfXoo6l2jDigsx4JP1YSyi3rdWkN3dtsf6TAKtNVgCUWpolqCI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 63/71] mm/oom_kill: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v6 63/71] mm/oom_kill: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHYInpjwjVwr7dFD0O3ujD0LyKI4w==
Date:   Tue, 15 Feb 2022 14:43:26 +0000
Message-ID: <20220215144241.3812052-63-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be31c16a-5242-4a72-c9b5-08d9f091aeb6
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB18639000A7B2046C841E84DBFD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QnMsjszLGiA5ItYha4GcAa9mtWi3Iny21uiGch4BiZxwB09ir8gG02CmM4YXnwAsIlAsZ+iHsnBMSlDEJFyIpuaonWTaRASLJrpU0LaQ9LbKktZK9a1ZaTVnybQifrDmo2UvsAeDj8XhCrIrc1q3xOqmLDvo2EtG3f1/5n9MBwXVsJg8+BhjNycZgburoTKPBlAEVQKoI1HFPXZ7scnxndGon/wVXeXBh6Bc09c2XcRvCVaisTiTP8VPG5GgYzF+w2vgoea1zPB0ZYF0stBkTHA+eX81F/kTfAW/KqBEigORuN1QxkHfm92cztw698LEc6vN7fDGn2elgTb1TNqEqlDwBkCLNqtOimqhXt07kcVNNxYYM5nIwVGIb23oAzSJDf/7HTcaJr86x7w/E/rwyrOd1ZB0UI5WUfBW0ur3YAcKn5r02jl4WYOswkdmMLcpyOv74xaWUvvEXjT3wrgwfYKmAldiUVmr7vcOLUDg7wGHgqUc0oYbnx7vS7Q68nBJCu69lwiW60tVOifZpp6RoagazqZ+VjWjPpQ7X0bOUe8JrYya6XawKckVhqzLucQnOXqNDu/s2KJvb+lzO541k7RS8pqc3FKuhNvt0t6mbe+uU/D+xLyt+SYlLA31gTzHeNoteIivCnwsEbE9aW7CQP8ro+FGtPkpEgXADJrdxgP68g6/+bFItDnszmqM6y8hmNEyAXiRuEWLCKXeVdugTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1DOUEH4uacw4N7vdMqjYMQaDvNRdh3WDJUf268WEGB4LCP464lnpe49Iqr?=
 =?iso-8859-1?Q?5bZWm0ZTXvGOaQJCByWjCmz9I++SNTVHo1MH/Yq9JypQcuWU+QsCSTkHhM?=
 =?iso-8859-1?Q?2AzYvLYFWKU3JbH73fLSyXEidQUDfVxdLKdGJE7evLW9v4fv7KgAT7o1Yp?=
 =?iso-8859-1?Q?gJYaqZikp1UhNLl4ipweOYWOmK3PZN23jMRKuYRFjdOx0IZ3GJtDlEgrVW?=
 =?iso-8859-1?Q?u9rbSJ61RaIgQXlyvrZI9+frJijXvPglZ3jZRb6mSnA/j5+umEYc0TNO0B?=
 =?iso-8859-1?Q?KZ/2c9JozkUwu1Gp+euA39Nq83Ph20dHphEsV0Y+W3rOJmmYGc4XKwsmN5?=
 =?iso-8859-1?Q?oCZ9f0lOS4zOl5qJz/MnoLdKWuvI+WqVQJ3VHflHdMbizjBCD+TiCBysyS?=
 =?iso-8859-1?Q?wuvbxUpnBZTasHn8sWR56+OJNtlY25LF+WJzxRrXKdfljSEr2B4x3nKVye?=
 =?iso-8859-1?Q?avpAGBvy5ha4ny+r4NzfPgc5x08h2+v4+DS/RJXyEZ69Oq32T6ANkQiWci?=
 =?iso-8859-1?Q?DPzt4+lUhxCUDwsGTB62DN1Xwl9EeGnjPN/2AtA4xrE1ytw7b7S8GeUV/7?=
 =?iso-8859-1?Q?GqU1adoBETbu8z46WDuqVkbjeOop1fOaZCmvFOzGTdCd6c+oYsToMAn2nz?=
 =?iso-8859-1?Q?wWXsS8bx2Aup+CZHLUTa4XBNxD3A1oUNPjN+0e+fp7as/Yqglj7JtVv5Nt?=
 =?iso-8859-1?Q?+LLbqfR00gxFRKYDfGwgvxzPaQ+05x0diKg4OldvjdSevHlkjtEAT6SeHB?=
 =?iso-8859-1?Q?Y2iY8T+nJj62BT4UttU0IWfjqwq//KF0V67XXAFdKpuz6Ngkg+hR4WHCaA?=
 =?iso-8859-1?Q?KdUlNWaeODp0ZdupDeH1KvCl70XKc0QzyVBxWsoMa1jKdEF3p7xy6XzH63?=
 =?iso-8859-1?Q?MHgB3t5dWAUdXqLHBf8NapuhtJ1FmnsgPqvlXRFBsbJFBUVuwUQQ3+NdXa?=
 =?iso-8859-1?Q?/Qc+AVs/q8KW88hOZEqZFfbUrd/dj77PyhKk3pj258LVbjEgDDg9MxmPY0?=
 =?iso-8859-1?Q?Rq/Hn2DaJ7nTwBmwvh7g7hXdVQsu2ucXf+fSeYJWjTb7hga4V+b6cJQysA?=
 =?iso-8859-1?Q?JdRdUSzx0xxjX3BX+ZwgSOtYWsv4W50cEdhu1m9/aAjjOsOrC/czJ3X9L0?=
 =?iso-8859-1?Q?nduwlX4mIBNd16d14ExVhBukZeQqVEAOeRpkSvYFSu3I+3hWOxB5j7h323?=
 =?iso-8859-1?Q?uUTboUK6/SB/ZhqQhjAHxzrb/7yml315S5zG1wackxXAHvbYtfHhQ1qtkl?=
 =?iso-8859-1?Q?btAxsfNhNl5UC7ubF2zwOjTmOtlFnkZBDQyBtgOSmZj/dDUnSQmIjx14UX?=
 =?iso-8859-1?Q?+68u8V61XfygHGf9HJJ12HfesaS1gefFW2shVM0zweWYKA+nbUnC0xQd8A?=
 =?iso-8859-1?Q?5D82WvTdudj0aCWLIHdmE+FpD5wB3WdLnN6vQHv3qqOs7kVgNUXZKC5MSv?=
 =?iso-8859-1?Q?zfIx+fAvsrCYCmQeH9ssBh+ggTAV4lgbBjPzj3VYfTYYEcIZgCYyKLh2Fc?=
 =?iso-8859-1?Q?HLHDhsBWMxtcXx2nxRoOdYdU2XdzJVxE8sUQ+pcQv3a55sbMzl2EGNYCN0?=
 =?iso-8859-1?Q?/cjDf18gx1NnrMU+pu/e6smQKT6K8Qe0yaj/Ao+YQiCgVS7JTwrRD0lEiX?=
 =?iso-8859-1?Q?dzerA4ONHvHam83Lftz6KtgG4XysclnfAAwKhFuewzObc591i2rVknnQIZ?=
 =?iso-8859-1?Q?Q7rnf0aP9nfcuWqlgz4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be31c16a-5242-4a72-c9b5-08d9f091aeb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:26.5726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBYqAs/lS1V9yh3yfZ8KFBmKgav0hHEw5LYpBUyDCS7RUTJTL5Qw8i3Qm7gl+MMDvm0IQoDOPgpTe38SWeQ7+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: TX5B71_0GJyfGzMxCkpuu4zFnvNbZzjN
X-Proofpoint-ORIG-GUID: TX5B71_0GJyfGzMxCkpuu4zFnvNbZzjN
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 832fb330376e..9cbc05fa356c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -516,6 +516,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -525,7 +526,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!can_madv_lru_vma(vma))
 			continue;
=20
--=20
2.34.1
