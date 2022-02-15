Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CABC4B6F50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiBOOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiBOOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4267210335C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:07 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCO3ES024982;
        Tue, 15 Feb 2022 14:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MtORTXwHjrXlvxWTH7ITyErm6mFH676S9feFSXzZfzM=;
 b=Okt1sNNF5jwScduC1rQCT1V16wuIp+y6luO89+Pz1JOyDXFLOQH0Q3+ueEwtX7+RHzJm
 4ouXdDPXwWW0MhmKYxL23ulvrT7j+5c+ZGOyWNgYhTO1fDW2H/6qrVe8j6nGcYjn5FZc
 PtE383U4Y1B1yVA13qx8ZyQ92ij28gfOIcMfv44D0h23N+VPBIPt0Xf6OHw/atd1l3aG
 8UyZLJGuCLWtZ1j//1z6fpQnjpx4qTTLX6env8M+T4DR6kPafLCDRjTAVV2+m9Y2O4jT
 t8RRNgVuzvY3xcv3VfNn3xKSy2RZR1xMiT8rRZM6tT8MTxnccrIfYmvftUbKslenjuXS hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psaqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVcc085745;
        Tue, 15 Feb 2022 14:43:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 3e66bnpj23-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wuy5IIDnzmuernc21FkqqbZ2wwvZpTX58Za4vtECPZBoMLn0bpMXeXy3z4MokckRGtusHhy2hf0U4x9ddFaoXtiDMvQEZN9F9QKrgnSbysOy31OYcbwCVkNYswIeL3qQZWlrXqVKMb1OsT+ln37R0ZBpb6U3QXHEcuHf5WHmKwxJ9IwAGf13ROytX+SGCRc4ye6mWV1tgfJniNkWkiAnHD1h0EckKG3xB3btTHFMFAoXqMGGJPtZ3ZNhZMInQlTpg2VHeANkeJlxq0181YaBoqqwUWd7JOXA0+MJU1Idf82JSvtlWdOGDzkInIME+inOCWeGsygzAlyfwD8BJqmMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtORTXwHjrXlvxWTH7ITyErm6mFH676S9feFSXzZfzM=;
 b=GI0V58xbnDhlvfy4G3P7ZaibFwkHDm6JU3OnOr5cNF/uQTQciPt5jUgu2VRvPySItGJiOjYVkbZUJK7H33ZT6RMYtZT4uHKULU21YVnbUz5IyAVcrsmT7kSIYTGIYQD0J8nC2/eZEbiMI6dOmBZvB8/R89m1bLEVJiSFpRan1DPcZA55OkRhnKUPj5V7TFs3iHuquOkPYEkjemxeOa4Lwzq1CsqLweT2oZJVDWOq9Us09F2fhtiB1Yxv/WWUmu9ZxUKohy1RApKrhyqR9avCb+5I8J2T7IPKnz2VeZgcE5JSaJNVl5mZJqEdVVbz80WIy0J/UoMct3Ieirls7ubHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtORTXwHjrXlvxWTH7ITyErm6mFH676S9feFSXzZfzM=;
 b=q3rzK4TFjj75th/7sIPuGh0RJM/3EhwAnjlAWJvww4ms5o7Hqrw1cqzMm7Xiy0GpZkDsR67pwg5lMXuEH3tJ7BH5b0dYDIgpC7K4r9GpjaO9xrCpF9ygMK1rUD15CkDJPinyTuLZhSquDFPHqIKXEaBjo1t8rzI1T/jr3d9Urk4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:42:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:42:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 07/71] radix tree test suite: Add lockdep_is_held to header
Thread-Topic: [PATCH v6 07/71] radix tree test suite: Add lockdep_is_held to
 header
Thread-Index: AQHYInpTGP3F93dYDECU5CqC0D705w==
Date:   Tue, 15 Feb 2022 14:42:58 +0000
Message-ID: <20220215144241.3812052-7-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 431c2e63-dc32-4f04-5cbf-08d9f091766b
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2197AB23904820E3AEA49894FD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IkltiV01AMo80SID9jfKnSG0ZY4qQsJcT4UcbGZixUt02J5eWFI9x6MdCnA6FirwFxwNiz+gi7t5wPKYadJMCUM661xrkQrHwEQUFSlCkkU52CPi5tboUYzv5Gw1FlKWrH5gdr68+44H5FqW6UUhb60DwyfWTYL5of3HkbOWIN+uw7W7IgkBpVdEKBio4SeYVfdeIY7IJ/UQ0vV3QoBQB9x6KMx/zBHeJAL083JAnSc9yTgzC42k2Hu8VDA8nJgLPebN8eNgCU9CBi7ZFFxAOavEXZZzSIlKza6XtWqzIPIDzyNv8qililAJCLT7JdIMmaCLozFkS7VJOo5IqM3t1idNjE3FJi0UtRITNEwyyReXP+gT/Nr4Nb8oRkUuuoKrhwcJeeQNfNxPVSVPRQ/fGZx3Da5h2FwGIrm/qLVMMK7uxx1zxOZVK3S2BW6cqS4NVcIjfDlW2zLbY6fiLqMQGt0YBGn5bZs5byEP/yLTy4PEtj27nmsGhuic7YAi609NEXzYIpsZL8ITD698WvA7IB0653ll8ceymP2jzyMBtSDodcplgFjPZiqM0D1rLMN7yMkj1AhqFkUuJHci97S0OIFvYPxGFPH78L3KI+fhJm7o+7/apToXJNwB7SBn4AXc+Z1k2LHuWzCtafFPEJM43jJX/5f7KSKpWOrKiJNI/FId5lpXrrtc+dw5XGgVrIPseDtpkquqSDc5Low2bcs7Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(4744005)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7OSTCbWaFWOJjxAsVV4zo116IGurr4VuOVzCvLZwV9kg0tZt0zbFnLzCdw?=
 =?iso-8859-1?Q?5XXMonAAz/AX13sQGl0Zi/EEhGYwaGEyILXTbwxOUaQlLUmF2Rlp+d8o/A?=
 =?iso-8859-1?Q?fiFA3Xm+R+CXUDbGu8MuHBekEzB6W5jIOvx2sthsQqJcbg6jZEG/zOMxlp?=
 =?iso-8859-1?Q?FYk6f3id3PMUW6cnyyTnYGGIdhSGRrMwbf9Suy/IQ/FHEOSsdfg0YkWJDM?=
 =?iso-8859-1?Q?qp79dY1elW3F9nvna5CTMlV+d2Yj2HZrP/vrPwE+85gqUyzC0D7Xegm4TF?=
 =?iso-8859-1?Q?D2RxLNkolqi3TFCEEFANjYb/xDPNtylej9x99D+MiR0S68AamsOfM4itV7?=
 =?iso-8859-1?Q?gFQZERUGfHJjrMUiPnRBh18nwYNR2twQZGX2Ez7cssOqeOmkKdI9UKwVgc?=
 =?iso-8859-1?Q?N2roAorPqdvYbRB2dvd3asmuTW8ZwSTzUdgGYt21AcFdWAGW4Fx7AHP2/V?=
 =?iso-8859-1?Q?AcPexhuQ94Pra9jEtlgFaFyVZiQTzhHOw2WclVr7/HdSYRmLxzwcbtDZ35?=
 =?iso-8859-1?Q?vgZCHwSWPwhxgUqeBLZBVXaCTwPUyg/GWmbcdG4fkF1b4wB3u04+gY5wEn?=
 =?iso-8859-1?Q?zd5PnTdrjXl6nmptGy2TPOSzwA+vazmzTwPfi8ZkxfWeWgoz1u0zr2vJC+?=
 =?iso-8859-1?Q?olXEE8eM2UjhZQEwwzv5guBuYcqgI/7G8+glmiJvH9jEkwFtot+f6USOy7?=
 =?iso-8859-1?Q?FO3FyPtyC+iozajHjZ2gq8Jx5D+WwpRxtKwljUz18ynh8BpmSmcH8Go0lu?=
 =?iso-8859-1?Q?tUphPLUYG9Fj6JtVOjEcUqf4yh+vfPplToIDVUvzuKDiP99xpTqEiGVWb3?=
 =?iso-8859-1?Q?dtEQcKQfTU8P+4wJRXPhzo0w6mbkvKY9jkhI2H+/frbfuIKHOtzdH+JyXo?=
 =?iso-8859-1?Q?rCFKuQOCQL61ehET4rnBsefq+wCh4gAzv5MZ0ZasvnE7ri7YpiL7kP48aG?=
 =?iso-8859-1?Q?GwGBQllLRHj05u7qR1CWPcQpihTbrNvDONjqyDuKXf1HL4uyIBOO6XjSxS?=
 =?iso-8859-1?Q?kbA3ac9Vt6twstgobt//e2bPfs0/8a5K9XFJmnmfzfmf3a2hY0pGxnRCf+?=
 =?iso-8859-1?Q?31/m62zwzrQVL9wy9rQ0LF4NfbG78/BmfqL0IXYpopymSDKLxQ2oNVIl3Z?=
 =?iso-8859-1?Q?/dQ/xiqWRlHZ4VjgJgH1O4eKIHFavNU2p043/hY7AjYpyMaefpB9ej/IG6?=
 =?iso-8859-1?Q?xp0y04TFrGpAJzT3ynDDNiiHIzclGSNzVYYjUfCMD2rFp/z93FELPX4NOT?=
 =?iso-8859-1?Q?XROsHE6JCHYFf2R+tCyR/Z+x69mczXNAGwN2D3xqk5mlKkQg0whv3UOxAJ?=
 =?iso-8859-1?Q?cIMHoxdqIGey1Ued/+M8k5ihqJ7qOFCljHb6qUuA8iX4MLeLh+OcxXwGFP?=
 =?iso-8859-1?Q?2abvftDNZDFtQOHAYPcnCjvVxyAZkZLnkrXYdlvD8q85xt4FVyyjJvSIVt?=
 =?iso-8859-1?Q?3sZo7fGLEEAeXNgdOt2TuxWafbkvfOZVkX6mBZok3d0zwYggB+akwmqFUK?=
 =?iso-8859-1?Q?yx5Zjvg4bdRyEphKN4SGkrVsB1j3uLznoi7sSWHP8kQodU+Hk7KhKrBUYB?=
 =?iso-8859-1?Q?MhCR+zHoQtAhHeHAS6WV12QLFxJdX7D7EqFg8owK1yCqd794LU2SqdPBRH?=
 =?iso-8859-1?Q?kT0Paynqfzm1p6xlmsZA5mSrKHI80h4XO4TcsM5BYqeCRa6iyUrfRJwwgl?=
 =?iso-8859-1?Q?A328ITo6jWH4jAHUdy4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431c2e63-dc32-4f04-5cbf-08d9f091766b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:42:58.9651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUZf5BcdnIuPEx4k2/AxQGKWwepU3G58viXEMkYIrOQaFY+dOL1rt4YDXhYv8o2VKdEf5WZUn6zjLaJYJ5OaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: CFh7Ve3No6wdDl6KuhUZGO0OpvMf-kNC
X-Proofpoint-ORIG-GUID: CFh7Ve3No6wdDl6KuhUZGO0OpvMf-kNC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

maple tree uses lockdep_is_held, so define it as external in the header.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/linux/lockdep.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix=
-tree/linux/lockdep.h
index 016cff473cfc..62473ab57f99 100644
--- a/tools/testing/radix-tree/linux/lockdep.h
+++ b/tools/testing/radix-tree/linux/lockdep.h
@@ -11,4 +11,6 @@ static inline void lockdep_set_class(spinlock_t *lock,
 					struct lock_class_key *key)
 {
 }
+
+extern int lockdep_is_held(const void *);
 #endif /* _LINUX_LOCKDEP_H */
--=20
2.34.1
