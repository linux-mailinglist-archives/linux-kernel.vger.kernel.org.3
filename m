Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA1464FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350301AbhLAOjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:39:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47548 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350079AbhLAOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:24 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EK9Ee012065;
        Wed, 1 Dec 2021 14:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FErdZ5eQNc2GI+mTs6Ys5tr98g9+Kr41kKQMmAlOF2o=;
 b=aK/InK80ByQKXtolTl9xO+xfYGtcz2VlkURXy6HjtZmO5RTsCnbr5hext9/Ed2vUaYlT
 6QylotTs6tV1MCzk/r8J0rTjw5Sf+BLAbz358oAK490OxNJ3/ygsgwpdo9SVO4vXcSAF
 WCi6mBlpVAn/zlKyyVg3dFsD3nftwzIqu15jUhdsshnJno6f5XLuJDpBlNOcWheIlWYa
 mfdyOQMOIDv1MgLdG85Z1aKM8uF1EnYB0nwnitrmDGvy/thAZ7tJQi/BgP9M4Sz+JY5E
 vYlwC8iZN1R2TbCXYcSjb7xNZjufwwsHzaMVKyvWPROhMVmbhciEcsgZ8CcUEWyEsbxN Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1h0xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBoqA037533;
        Wed, 1 Dec 2021 14:30:47 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 3ck9t1v74d-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFIswmg8Ot1r174Ix3EAov7qBf0ztkes9VKjLjgggJwCo8QMSas9PLUKQZgUsI1vIo+L+zGcesnZ6W5xxjoOV0AeHP8Ua4q5d2TjBd8co22hm7jg4uRFT1pIGBPl0AS4Jn2aZ59IPx0EAAYFqfEhYEi8vxR5Z5lIlQxiFH3dBlxgFgQMI7eMnlzK0gd3KAV4mjqzC2lAw3fFNXdYrNS3o1VLuoZnKl3RoQz0yPCwEziCGCdboImJ7FcRXZDYT5mNtAjMVK3PmvCUjxLz/VwztmCzFuZhcaieCgRQkHCe29FSWLIvkWXyA9ID//jsMbwxoZjL07piGLjleyKlYPUSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FErdZ5eQNc2GI+mTs6Ys5tr98g9+Kr41kKQMmAlOF2o=;
 b=UnSMdZt9wcfF/Oe/ySpH5BcvB5FPh4SNLlbPO5VglT+w/1U7+i1xKbrLNcVqvApt4bxUzzfB2jo5x5RdDN+Np68lmm4Gwovn/MgVuKoUpSs6x2M6B9ff0DKTrFzdPLpVYY6bYGVZLeyutYUw6tNhujjIfmYKJprLBTMNU4zG4N4IJiD0HGAeZBGnS4/b0Mhu1V3Wu6kbc3fF9DqIvSkTQp2NPLPAz7eaLIIx0zgRHtunZet9+DIRugBBGohKP1lgnMXpoKPzsKrXc8QKCgmwuaXz+7Nz+8e8jvgJ8aLBbrRh/9K5H4kY0i0CT3raLnzB1fQOYAH1Eh2fSiboLuglzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FErdZ5eQNc2GI+mTs6Ys5tr98g9+Kr41kKQMmAlOF2o=;
 b=IYlLuzH69MnuJ7Xu77z/dho8DPaLHNduZ9nv/TpBfePTV9646/pJ+AZ4o5dnJORJl9aBE225XW3WxvOOiQgxRPc23UHKQN/Gwxiz7/4q1Kdvr1tyGzAM3R/wqdtbhKnswVpyeYmiLH0eu1E1lM+45OQDlKst3PJJDnbLtHm6nGE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:30:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:42 +0000
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
Subject: [PATCH v4 59/66] mm/msync: Use vma_find() instead of vma linked list
Thread-Topic: [PATCH v4 59/66] mm/msync: Use vma_find() instead of vma linked
 list
Thread-Index: AQHX5r/1MwPqtm2DH0OUDFon7zNFtg==
Date:   Wed, 1 Dec 2021 14:30:16 +0000
Message-ID: <20211201142918.921493-60-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c26a90e-24fe-4856-f09c-08d9b4d72786
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB24649BD1C8B7D77653953E8BFD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwXj2H/TZy5h5PrxMGTQBQ6aaJ2NJlhqElpjwOnbNhf6ecMCELLW3Y2a9uajVkrOjL/g9o8VeyXtjWM26EqpF5T+0tpmz+SpRhYgGP5tGbRTMS4BXDvY3+Mbn7m5mHnq3vOKAq+lPdUw5pvZNuUs5IC12M6wYGPoYv5oIshqDuFPGayP0Qg5lU+CaABiABHURW6htIrND1zHEj5F112pndYZqCs2EHcHLute5WGWhwl83qYUfQsG2y9irg5g61vxQgQhHIKLXFqZswUFqwTecoEDPAlKbaXnthCdwPR5A76OxdIB/HuOscupvPr9gcjG2Mwa+0lxql6Z75FdX3GabJxy6j8HZn+mdcDOoAnYSoutYVbSE4VbG93YGa1vmuGjoJBPrfksqnrMBiab8H1Kxa2xDb3e+Vpt5NqiW4kQcbQvjmvsAT8IYLELbSGQbiqQ3hHG3KohvE7juDxi5CE9ap7Bd0wjpn5NsL1ToUOGrTG7NWy3wnvlNIRvTtf0RnO3CpLqlmBEY1qDaoannXTOPWJ2jz6ZIl37q5NPunROtc+aygRgQFEGCzZT4/ylya0jDGm2LRUKh95oOT5xkQCSJ8JnxaxGoTLMpEy705yh0V5gHNlm8Dbq2HFOvrd6L7OWpGTMKU7psA+gUmzNrtVdsKwqd3+2PAchZ8kRTgIGQW0tp2tBaKgCi9cU0BGdo2FooqKyAJaucZ7HcZkZGb8g0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(4744005)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iLLrll0jZNsgh2bUEWjr4zNqqUD/QON4fwNmhbaySKkyWhf6CeedBM8XlX?=
 =?iso-8859-1?Q?P5ocFP1wxsAYuobf5TwMIz6DlNcq7wKHnC4tKPsWSX8YJmM1eyQqD0Y763?=
 =?iso-8859-1?Q?5B8IZXmWDzC9MYO2IJAwdtm+P9aqhSc3+uN0p/KsMFrqVVeQADdQpW75Oi?=
 =?iso-8859-1?Q?3ZH5FaoHoopb2sXcs0lR+XSnJgKL+Gq5DS9Tdy6l4NegcmHmJ15y4Wu/t5?=
 =?iso-8859-1?Q?cyhJ3eIbeGKOthm6Q9cSLrkzoF9g7qsbNaUx9sM2/0oV8YQ50TTwRKBjVo?=
 =?iso-8859-1?Q?GilAqx+11cjKyKvHtnWX0L+uHky9i/WBr63UUmSCdvj4Pfu4Jjfcdfyktb?=
 =?iso-8859-1?Q?JC5k2M8v7WRSa6ZzHY6WS3yk03vWHXSvp3b3189bL0HCOu3fn3jGIhpxZa?=
 =?iso-8859-1?Q?+CHjGRASICDyphXtO0KmfIz6mbdskrbQy/tzDXIzvR/NMSKUljwZoCoXgj?=
 =?iso-8859-1?Q?ZMbedefJUI5jqEbCSrWRI/+zMgT5ItADMQDjD6rwD11b5XWwN3fRvO93B1?=
 =?iso-8859-1?Q?pigshTHmKLISF//Rx4kMOHvbzJtKE5n9fh5TIdIi3q9vtL1mrW0///Nc+1?=
 =?iso-8859-1?Q?UlYI9AXEuGJMAZzKXTNbO7mI22TlwxlVjACtYSM78iIbidDnp+Cz+XqSIn?=
 =?iso-8859-1?Q?HcsywyX23iorPImMypzkqXqJGURZQyzx2Z5NLlaWMVXUhjFSp/zzFxf6o5?=
 =?iso-8859-1?Q?fGANFa3RevTgoLqu9+5+C/vyoCikKXpE8pyuEgq235YDEuONhRUl/4+ONL?=
 =?iso-8859-1?Q?5j1hVoXh3XzvEikTtdn51XIMMaJ8mNzzjxRAUS4AM5TyDr5Rf+3JYZ2xzh?=
 =?iso-8859-1?Q?tL3kiS2mgXIHilUfCOZPT8SN2ieELU/SY8hCMxL9t/Gj3ApMaBBCUnKJqR?=
 =?iso-8859-1?Q?+HJ0/NXbg12a1SnY5KVUCsmjBex9yh3mHsH+PHjgPclPFDfR0ktliHAWV+?=
 =?iso-8859-1?Q?Cwv+yRxmfYJ2iXwgLFks+sonx+V1C7pOkl/+oB2G6qmh/wmgJ5C5mX34IU?=
 =?iso-8859-1?Q?9yjpzHaxC5F05NPcrE3dMTlv8u3ESSeogkHv+HwwmSWk1/U+VJYvIUrHe/?=
 =?iso-8859-1?Q?mst2VC0ZP/UXc6zhoWXmY+oLW+KI/hkhcJzQ/0Upei43yFZDqIlj9QjB6C?=
 =?iso-8859-1?Q?P85nm73HT/kzsOFw/nqpMEgbM8u/nag+bhyH9cuQMK7UxKk92/cfidNPdB?=
 =?iso-8859-1?Q?ii06lzHMBGer0OcKwQdm3JEjmRdRId9atR1z80yobUQdWDbeh0v70rrDMV?=
 =?iso-8859-1?Q?KXPZLTHc/GFWUKo6jCysuGwziW7pXL79P4eb/eeK8TKtyqsAd4r6tRQnDD?=
 =?iso-8859-1?Q?DRxh0ibG9nAuZXsSNxlkA+hsBp/ylv4PXt5DAdpJZXCdBcDzcJpSBzU4ya?=
 =?iso-8859-1?Q?EqixCpUCtEWW1zxjXxRvTCltb3ZF69W/+Vjjkp9oq44edfGtUK23qaTfeL?=
 =?iso-8859-1?Q?pcnMd+X5mVFIiqTW4RJ+ZpXrqi4FTYBGwJNKDaJDogypgAesRFY12F2ZuP?=
 =?iso-8859-1?Q?QRcsRAA11tofOOHL65kD2mMmQQFHPDi1fE7trc0Ov9AaLKhqWL1VHyqC2i?=
 =?iso-8859-1?Q?2B4E9l35lEJGd2hk8GtwfNxJSotmbm+IKHp8ba2fb4glmDFpPzIwfAIM9W?=
 =?iso-8859-1?Q?brVeg1fa0gL8ASP+B9X3vYZKmFrZGDVRWI60vqN81+QWgxTp9Ge4PeEHRL?=
 =?iso-8859-1?Q?aCdlIu23Nv45K0VCkOU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c26a90e-24fe-4856-f09c-08d9b4d72786
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:16.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMi0A5/qxPErkx+B9xq+u/FJm4azSCMPxmglTkzsKdnL0XN08QWuxc+XHZ0m39r8a6c2v1rVMf2SPkQgi06huw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: Gk2O4tLpCf9reMUeVVdDdJyp5MBYyfzU
X-Proofpoint-GUID: Gk2O4tLpCf9reMUeVVdDdJyp5MBYyfzU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.30.2
