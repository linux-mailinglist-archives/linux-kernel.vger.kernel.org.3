Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA804B6F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbiBOOqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbiBOOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DF3117CB7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi0eL006569;
        Tue, 15 Feb 2022 14:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eWYXErr3IcTSra7ghItXZ+6IrQl8bG2Uc7ZsQghCbHw=;
 b=jgqaFFCX3gvXdgPjSzdHa1+2kA6gSzbWEeN8zU4xlih3ewU2uetHkETCO5+eI0mQbtCt
 0e1v+bfeYkVu8zf0kHJYo8MTjXoaOE2TnfL8/tmTuYXxpZlX7VCilan2DNnkvrD+kG0F
 cYILDSmPd1VYMII8k6CovQvGnnuO7VrOco1cSW8ewel+efeslEw3gQ9unObf+LXskxiG
 BgegB09oCtdhIePrCkGd12UXXoC8B180tfHKHIZ6B6yq8ZC6zQmNnyuczCTpajdpVmSz
 JaASwp6uZfbX2I8AZGoeFHnLyBsC124Shgh5c+rNIz3/DZLZgWucxtwUS7MVmxIHbsjZ 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0hge5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8lt016243;
        Tue, 15 Feb 2022 14:44:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3e620x7vn0-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzM7bff0dexqLP71QZWvAfX8OU+bPb2eTxIr9gNnO2qHIUaE9NOxnU7Tt9YmpBZSeiT6mibOM82wxeKSbRJQ6ahub+UfX4TJZHQaQWSJQSOvAu6cFKqaX7DwFaY3X7ZRAiEIX7SbdnNM2TeloXoxF4cVMziMCbCwc+UirJiIfztfZiV4ofEZoap0hv+P3rC7+6auexftIXG+HOMglG1vAHwoW/imFRu+ElkcdmbFUFaU/XG8OwlGUn8VRzX+h5McleRVO72nh+FU73ZOv5Cg8+TVseLZwGnkKiY6Gs7viiS18VBVap6XDI3AiuyT3uhXSnElOCpYECX28NK6TgZUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWYXErr3IcTSra7ghItXZ+6IrQl8bG2Uc7ZsQghCbHw=;
 b=n1BjkWU2rV2yomxJIW+xyX2wgOMZKW2qPHWriWtVaewK7Y+tS8CWo0nlTJITrI10nmjsUo6YBLN1H6JtOTqcVfXD86tUtYgZ1lvvgELLHkyiy4fx46lqzVc5+JOWBSOrFFt9ipU+Q/YjJvtEHsJKaV5diXQoA+/46gZMhmZgfP8bxP832Rf/vowy8a+YjHbW4Zr67Pa8Y1LK0Ul3Jki7+XNTRMfgNENQyhhkdYVeu32B6vXU/EeRjwWkBE7sBh8IDesFPHjcf6PdCF2eAjMaEzeI3RCCXgHNSe6H5ZWzSZTHT+hYm0fkEKCEeFc6YI1i6720Ph0tDK4qX5Rq3e/SAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWYXErr3IcTSra7ghItXZ+6IrQl8bG2Uc7ZsQghCbHw=;
 b=nf3y3cz5sqTYGy8kspvx90sGzYz2Do8vt0bLMwynfqwFnTVuYV6lO5J4kKfJvGXiFh+dZPLsak5i7li14V086hpwFpqlziWlcP8Eh/hmFskZvXS9DXPdHLxnKvTxpZ7PBUPbPOtB7D++tuD7zDufjJtD94G2NYlaN5acPJeNMBg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 60/71] mm/mprotect: Use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v6 60/71] mm/mprotect: Use maple tree navigation instead
 of vma linked list
Thread-Index: AQHYInpjVDTwztuKTkutlmtP2b81LA==
Date:   Tue, 15 Feb 2022 14:43:25 +0000
Message-ID: <20220215144241.3812052-60-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea684f74-28e7-4df8-fab8-08d9f0919bf2
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB18637EC7234AD8ACE7E8EB10FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u8Kb5BKQN3IA+J9riIJSnAtSOmOBlq7w1TRdmdukt1zmtnjxkToFI/AU38HshQ+HP63EObycumNPxczMeapttHDoJwz2rH1wOBBExjscRj3gWMaGOzAUPBevmITD2B0iV83UKQbifNVAUgAToiYfEi8rTVjZEw5wTSNchDceR6VK7mweHl0lypSw10ZEx7KfN1fE5Vwd9kp+/NaPTwfGpwPI+9Rw5kxeI7xwIuT81viULXWaf7jDDVgv9uaGZEWdDADJyPu7Wp2e4KNmOdMYf2vKbmn00Ix+sZZsx323J3gGyRHauS5xEtImNNO8lBTCpRrZP9PdZkhe+/E1Yzt2SLvQubwqhI8xtytEfazqdRgFqxivFrZDJol7UEAWqfjzCAp/YVPsBrb7q6xyIxCGGvKRr6q6j/qOPj6n1Z1yg23/aa8bhsKiVNpbs/Jd1vFjuCDnTGNel+LS0vX48P8rDkHiyWe0ocgwXJ40AyMZGSbBvTKsTSX4B+6ddPWrs0wNDbZvWKrWHjQT6VeJecX+0Dc7jIzCO3hmM/Wsx/MXBSUtTfC9+OxGfL+qYiNSpl+Chm4D6ZP/rm70DoXJHb3gEClxCIjFyhRtzlFsJa0aKh7N7xgK6RoXFboZ3h7sX9NaXb4Aldey383WrG03l9UccLYRei8+f7L94voV9IoWoCP/bXWDTV0oabh2vutYR9KXbwpfDCxuC8rwGX0UBz/m2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?27R9HXhrzNDrVeDOyS419VmTkw5loy31IT9yni46jbVnbOtTx6gXFXHn2Q?=
 =?iso-8859-1?Q?4+DTl5kzitmB3AQJSk3kAjd1VNjiFhLyyUk24LuG2khCUbRGUzQrQZgQ/G?=
 =?iso-8859-1?Q?tXBgZpGuL1nN1O7lcDqAr0NvJJNOQ5nQ8+1GSC2sOXaicqa0+Cx/RAP84r?=
 =?iso-8859-1?Q?4W1lBRcKzDaUCcAGhfF/XZytP68Zg1d3FWGCBreFNc+dIFsVse9VWAEqMi?=
 =?iso-8859-1?Q?8dvv+C3U8t7hQ1smmZWrXhc+cGBhtVE1IDr4L3Jxcc4XGmIIl9SNf29e27?=
 =?iso-8859-1?Q?54lgVPoO05rcMBF+ZrP+EOHnZCa+89H+q22lJwrTz8Py9OSDvZq6VQK2ga?=
 =?iso-8859-1?Q?NPfAcazemxGPkT5MIByK0nB3lRgiA4i0XYSUEd9jqMllNLeq4JwfuIVf+V?=
 =?iso-8859-1?Q?728PJ2hor+kFIjAc5b49c+/Yxh26ipcksN6P4m1RfhgXS4OpWNT+fjZEuF?=
 =?iso-8859-1?Q?m3doB1WFs/nnZ5rQtyngiS7Ie2odxu5Ph2mPyrDUcZjOXw5MNOxznvmHjs?=
 =?iso-8859-1?Q?eCgL0sino2tYO7Q/HLb0dTHKFtAiCcbW3UJ8GadddyKKTSZ1UswDvRvu+L?=
 =?iso-8859-1?Q?t0NGowC1iOoTt5YgybHzEbmVGqVkR+Aq3fVwO+r/KJW/xRO5CxqBsNHNQH?=
 =?iso-8859-1?Q?QslwHKlsnbramYhOKFrc9fMxD6rYLMtScCFg00f6EfDzFbqvVPVAQdP/aU?=
 =?iso-8859-1?Q?8liCQmQ8QfDZwEoV8IEzKzLlGZkl8rwPUUcPkiiL+DiR93Xl1nBjJyCxve?=
 =?iso-8859-1?Q?XxV6tt2afDhoF3juClsSX++q/4ick10DwVvwUvOyWDUgK3dUOFPX43dRzI?=
 =?iso-8859-1?Q?1dIcnh5uwoCJTsJYlO/I5YNWZSNBixnIs6UhDgLD4wqQ1xjeMN793Y+ofI?=
 =?iso-8859-1?Q?aVwTuTPlI88+wxz1Y0LUKYDcJDYbU9bg3QF+GFtOn4m4HkQo5iWfTYDgB2?=
 =?iso-8859-1?Q?rXAj0zuzTyAIUjtOZsfvi4krMYLWKI0wQZlYyPXfYcaN+gls56WLNXukH7?=
 =?iso-8859-1?Q?ckV82yUlV6IBVhZiue1U8EDzjtv5hvjqk28i0ke941i4StiX7Yi1f6tSMO?=
 =?iso-8859-1?Q?+qjb4kyfPYFcLDz/mgy+2gzI54sPNPVddHmRBdqVmwOwgHMF4HMUNuwcqn?=
 =?iso-8859-1?Q?Z9RBfuLjAgH2R0iCUK7IzqDnHqdQBW+4DlcKsOuRIkXJVKwQHCjg74xYoM?=
 =?iso-8859-1?Q?6VChvzTRn7expKFIP3aRlhPu6Lba9SAomWxb6X8s8aO7AQKOCtrd5Ou5Tc?=
 =?iso-8859-1?Q?kko4JTxzUK4o7QRQWjIwW6x/2oajTF5ofdQvQ60TALpvkCcqIkXbsGb469?=
 =?iso-8859-1?Q?nOVKuh6dv+AVgvCayI5xxbjnWv8AQY7Lo5kyEi4PykOkvPGEXaNbBJfARy?=
 =?iso-8859-1?Q?cFBeEp4/cNU4ik3GQ3SLQLt/aHx2/xPzadtGaH4GVCU+d0q5H0RPKvaQ0L?=
 =?iso-8859-1?Q?Wmo6+FBjjxmP7+YQo/QfZ4UNn6v+HM03/TvLLux7DM+E5wwLcDTaleR9Mg?=
 =?iso-8859-1?Q?1sCzP025J4AHBvyRfLkbfDf/WF2zO1rgx18+2GKsZ+YVnzjdfE+3FnUDyC?=
 =?iso-8859-1?Q?O5sgeVVPKwBXOLO0DeJhIf9/J0Tp31By/h6rPN44Dkuc36ps4FRIoUNQpj?=
 =?iso-8859-1?Q?MBGTpPDwaEkjSOl+Xlyyx8uQootm8RFPW6xc7fW2Kb1M7t0Zzd/GBEPF5E?=
 =?iso-8859-1?Q?pBJVu/icTu7NGAKgZvI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea684f74-28e7-4df8-fab8-08d9f0919bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:25.5258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E46mof+7TwNSWhOjof+TKHHBaCFlGWGeMTFdG1TgDgRik2Qwfp/2lNnUb8vKNYOAMov6CePAm54MN68to1aXGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: 8lPkbI4yEypqv7tZKkZW7Hlyv3UJHHgH
X-Proofpoint-GUID: 8lPkbI4yEypqv7tZKkZW7Hlyv3UJHHgH
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
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0138dfcdb1d8..51ef845df4c8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -528,6 +528,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const int grows =3D prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -559,7 +560,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -585,7 +586,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		unsigned long mask_off_old_flags;
@@ -647,7 +648,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			goto out;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(current->mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			goto out;
--=20
2.34.1
