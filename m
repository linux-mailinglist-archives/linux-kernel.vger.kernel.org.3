Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605074A6A36
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244875AbiBBCpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49332 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244251AbiBBCnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:09 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120TLCZ011400;
        Wed, 2 Feb 2022 02:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A0HnWIGT/rG1GbnjraYQx+b1pevqHIpGDry9oirHVS4=;
 b=M2cNhtTzlhoqvCZ2JLQ1VfX3tdWhoec1A9K8EKdn0cN8kDG4iS4nNMThdvmYG0xKFKK9
 /OY3qmfpdVbSXPZyEK6flTpaG2MVWuPgPzIZPJyw6OZ6DFO/GKvJWwqth92t7pO2svk/
 Ihte9t/HgSypNihv9XLBfKsAqI8XFt6gNW+ObeMq1waHmuQhGjNTY5etMKRLMss4L+at
 UcY8yXV+lOdTFluxThNQLLL6yOsqC+xHQsBSo9Tiai06OYsx1HKNIOaXKsnMBWB9vFCN
 8LM27b7vul+9PFtvALEIVmyiJu+W6rQMg8e7DY7aMm1x/TCRAF/D0d/cociZI/Lhw+ER mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvsem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwrk015281;
        Wed, 2 Feb 2022 02:42:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3dvumggud1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlavBpgpxuHKMgGeDSyDmkIuJvwn9qq8ghdG2WvOXsWVZEnihsbu4YnRnXz1rhi4XE5iVeUomPVQiHhOLLVf78p5kfseMZh7xzPf6npcV5eL4jgYGToNv9AluxFw6JKQmU8V2lt8fYa/6Z7vwxZTdvHl5Bf5RV35J/IN6718Vk/SLYInDyH0YwkMf7EXLQqsE3G2v+0rmnhWidnJP4d/aJu9Bf6Eo8Y1WcvB3WmowAtFINsJ6p6BNjY91mvSx0Ziqcm/bb+yyhxSGFrreeOtY/r7xmmdr0qfQpXxG1tMvecm8OITL81ZCUZL6/HePc4Y6XSi6RILrOd2M1R7igxuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0HnWIGT/rG1GbnjraYQx+b1pevqHIpGDry9oirHVS4=;
 b=B+2mgWZJmzIxRxicRqVSjeLFD4T/buyeivzgx9sdSeKn8uWVHI1JYrtT8typdsUD8n6LXsX4oECNWSozxVIvoJePg2IqDHkrWPuSU96CIrGBJVnsdlRy1Z8bKfSHuRoEhjoNmpUis0r0DkprVmw7fVe84GsYBy1BU0bQsGpc70HGKqRw8+cvJSa1HwLVnTmnPu2E+nk942m/441HTImE1k2EoX7x1iKl3qqtBTJWbZ/+zACvghzGgkdCHgvSY2o+3xkf6nIJruXtwEPARiiamYNt10b6ssCgOyoROYXDs06FR0NnrY58EJs2SXGEIWRIsaRbMVyPggAF93Lwq2AIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0HnWIGT/rG1GbnjraYQx+b1pevqHIpGDry9oirHVS4=;
 b=dBGQGDBnP8fWcTiC6gDdmarewj1L0KX2WpACPFYPfi6ndlU1Lc5PVIM6u/F70aUHAghWyWDOi+DSbBy965RTYB8oY/fHjLpmEPgOv7OaWHiT5ccTMDcELkmMkp2ERTq/J2ZiT+jFClG9ndwujVd7Mh6vx3q4uCP4yf05wHN690E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:42:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 55/70] mm/madvise: Use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v5 55/70] mm/madvise: Use vma_find() instead of vma
 linked list
Thread-Index: AQHYF96AP37qHWSIFkGLQwApARl1sQ==
Date:   Wed, 2 Feb 2022 02:42:21 +0000
Message-ID: <20220202024137.2516438-56-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30e5b0c2-0a2d-44ef-867c-08d9e5f5b7ea
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5865835AE74F62CB049D67B9FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qesPSe4eavgXZQLokalwAeaI+G9quIrnirHQvT5YCJKmVgSOIVNKrg8TkEjoioV1MJ3ZKX2GLXqYDQCPVzxnJRKmjNTw9BxDX8ke2V1CLgQqGdmPLZ1EqrqEHA0Vk5HAThXfqUFsA8HB3gLjtFZ1ELjgiDHh8xQY+2ebzk1Jau5dXtj5tM5PD8Uby6N5/jFTAxWtFlFzoiUHD/ilSiV3qsOaiZ4QEy7iDcrGS7lqLknKqnVRhYHDPey6GB5JsRobMz6MHFUsw50pAdYU3SVtwJMS7ph6tkLmswz1wYL9BYsWB6KHbg9jf4JJTpeyc3MFEhwZJ68reZWwRGUk300OdvkQPFu1SjBzvdfJ6agxqWM4kgRqjkB8LQ3Zpp2spJ3qhnRoxP7BA7DRDBlO4vYIq0f/ozwNURVTh7X/dFs01KT1EhGkSh6Iq9CDRuPiNpgLQLMf+rE2PzJV/GdprbFvwZUo/YTmRCddcIyHYEIS9tcdt0X/75KyOxdNSc++4+u9yvOvT9PokE3bHaQVxP7gL462/eYyI4lhoxrkbU19rTHsHBTa1H2FNFdw/ZsCzQ1ibzpXe9utmO7+rZWO27L/P61QZxbtn9ESuLujyvRKHqgJNhBcP3BAngJcQXT+tM4SaF8rLlFb0PstrQH1kqfvUvA82jNqITdRDjFlkKT3Gf0MHLfaOVHyAwfY1Oo3tw6nhX14k1GNdDEdukf3rcyPyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(4744005)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OKYMdro+5tOEI1TrH9TUNmLf+L3jIjfe4wFbeH5kOLfD0G9lT42cni0PP2?=
 =?iso-8859-1?Q?AhToftFHcOCXrOa+Sh9zS/I4Nu3vE0mFjsXyS84LWqGOB5npanLNwss0JJ?=
 =?iso-8859-1?Q?g4lvzDiyr4Jdt7t3jCjtDoMquaE3SOhkjaC+XApVPgdisWcU6sljlKItOd?=
 =?iso-8859-1?Q?HVL5o02jTgR9a7qP7W9E9hjMvttvc7nHEHiwgrRYL0sDqqZZv8fpc5UcDV?=
 =?iso-8859-1?Q?kkljtJWT4VSlcB6MglhR1Z3qgqUWNejlSju+RnlKtBLDX+EGzy0XMnXOQk?=
 =?iso-8859-1?Q?BLebWx0LLkOzC2tefk0StGuxSB5Kz2ILLJdZSDxwicV33Kmea1Oc5evPtY?=
 =?iso-8859-1?Q?asB0tF0ewXlTz0cHyYz7aMp1H/UhyOoMKpEvqFRqmCIjPNOckBNpRPJZF0?=
 =?iso-8859-1?Q?7xrZNUdemIWVobCSDj+ikYva4UW2RAMXL9Qj69+aTqB6/i+7koDH9EdwU8?=
 =?iso-8859-1?Q?Ay0sQHEWh/0vlR8Jc2XZZAZKukC6qw9rjC4WIY0GMgv7xtYiwT1PHDsWMK?=
 =?iso-8859-1?Q?Zo8G2xoc7r8OiJ/4BDuLUOH6KpJiK2iM8nqY14SYmsPbYdHSPIqYLzdpja?=
 =?iso-8859-1?Q?Pe/Nh/jaQ6c4KhEIy2rLhxedzhAW1ouakWcV8naUKrzoLi5C9o6e6rkaLT?=
 =?iso-8859-1?Q?7IWY/93n3IBsRIMi8MHyaQIjvjau8flbjLZsQb/vnBlhmeVSZztzjVEQkb?=
 =?iso-8859-1?Q?CYCamZvk+MVedSXj1dUuwytVnTqb/960tjsXchybiUbCmKUmOFfc+ENXZe?=
 =?iso-8859-1?Q?sMLT6w0FoJjhXIS+sFyx/zGGB3/+AYKl841piPfrw/pZdBoLRSHeUpHb2q?=
 =?iso-8859-1?Q?j8uHfhA57i1g6AoHjMAmFRMJo26la8/3wXS6vwUUVtItWqUHo3GZLJX0J3?=
 =?iso-8859-1?Q?TZh6D53dEXAcUl4EBYBd98pOsK1HRlsUSaNrKF/1fnDqHueO3IIN8BVj+k?=
 =?iso-8859-1?Q?6koBwelkEjMez4h3klD3mHHB5OktFTRTBSs4ry3sOwV5lG9uNdsyyJm+pp?=
 =?iso-8859-1?Q?xVncaypqbMY4fN4kRlELxkkUw/nXWFI2yMlLoEz2re27ToWKj6Vef3lXwA?=
 =?iso-8859-1?Q?hrQOaWSF7qH47xa6gTXTgqsMutoMSI9Y3ydOXXznJ9Nlg/veC6/FXPNN+V?=
 =?iso-8859-1?Q?AES98q6Xm1EEUA+ItDMor60kx59uAhpg0u7oDKggw6oyvFBSd6Me84nHDN?=
 =?iso-8859-1?Q?dzsPzZuYJqGxH4n5hO7VRqJubCCkdKDCDvIyKvhEkHCRUkgRc/SsLHrjFp?=
 =?iso-8859-1?Q?oX7Xhr+uNpsp39JHSaqVwm3ahnwH4GT4n/e0hy4tHxOuin840XyR66qkic?=
 =?iso-8859-1?Q?rAcRuMFrTA1pfF6gpSeHKHeid6DL0Q7aOuxzHhnxFg80BSl4UNhkzI4Vsa?=
 =?iso-8859-1?Q?MF+Hw6CX/a/gmBpms2VyfNyDrWG586Lhzt0eK9sOUJn3niOqbG+kU7oxJy?=
 =?iso-8859-1?Q?cZnlpq7aaCLhwphCTq+mqkIZuamXhKgIQG6sqcKPkGTRGt/GLfiTKCgNeF?=
 =?iso-8859-1?Q?FCtEsDVO0p8pGSGf57xAcAe0Uwa3oceb1nP4UGWH89Rq5S2m3zy6HW4W2m?=
 =?iso-8859-1?Q?dGa6DWr9Si/cFG2cNyzYrgh0ZfuahulRoRh2vMdvX+T7Ogiqe4qyAZ/Nbl?=
 =?iso-8859-1?Q?O0lPVnod5x4pORsFG6WHybRlr0ojsAWMe/B/Khq//U6ZgFQO1mIhYovMSl?=
 =?iso-8859-1?Q?c4/berif/IGKMUbcWVY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e5b0c2-0a2d-44ef-867c-08d9e5f5b7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:21.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miKeWPxwWPlfV5h1+sEJqI+xY+Rx//90ob5xMg3GJ8AnPehrcrWNMnUz6MmCSECxEI0bAKQ+kZd+b1ORI7yqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: NoUxLFplq-4rI2xRhsS42nq7s7KqPw3l
X-Proofpoint-ORIG-GUID: NoUxLFplq-4rI2xRhsS42nq7s7KqPw3l
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

madvise_walk_vmas() no longer uses linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 5604064df464..2d3210e59826 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1213,7 +1213,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
long start,
 		if (start >=3D end)
 			break;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D find_vma(mm, prev->vm_end);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.34.1
