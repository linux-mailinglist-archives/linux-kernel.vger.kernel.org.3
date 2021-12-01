Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33D464FB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349971AbhLAOe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:34:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34872 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243554AbhLAOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E16lm002526;
        Wed, 1 Dec 2021 14:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=G0QQjdFFQr4RXZBZ8KPS9S1LMsI3lj3CHLvLklb8QH7Yi3ZdmJAMFYBAQliYM4MuLATi
 fOKeCfsCxC6v3WpLUz1C6xjY4M5DMs9qQb+YDYK/hUtOGKBXNu0GFIgS5CEBY/ydZFuv
 pXb3wD4xlsfVRaHAW9GJo3x2Cpw48oB5VANXy3yByBgHWvQrdXxN+3rKdBMvGfH1Ho1S
 Bo/QUjDbU74WmsOpHisfiJzlYeJQ74Av5RAf8TqV2yxU6kud09BtviiJvqVRXpe4TuL0
 n8OUOr04OF/l9gDKysIoCSg6/fHG7QtBP1C6dz+fP30mSyaB4qSQ4SC6NU00s+CNw72A tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EALNc032204;
        Wed, 1 Dec 2021 14:29:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3cke4rv3t3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPSHDTnnglhP6KvzlnEk5jF5nuIf3sGWQr9XhsXYlPcO12GAFavVy5E7xuIPN/yrc6VrgVjHjV0sJbRU53fbCBRomZsQZdA4yZbp94vTn8o+uutwMF/3G7BrPe6nDOGRRryzn3zVklgSjhQWoiKiLHxJ1FA/wMZCeYAdosvkf9/CPkWh6eaukC1KkXlIW5Rd9bXRPVVVQGWOF03FslfL8W0JCORUi7++cXxb7c45Ki9TqdBZUrXPvSf1XTQuktuNo64PWGmT2ZjpNU1IltDjKAqCWKan0id90rBlpl2tvQSrLaC40Iz9Y8fqxgbSMh15tpJmHT8UDMpfxBGg8fFouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=A26T/ZmRDfOwsGLmKrUMHCCdt4JfFnu4wbcNd5teUeRfrwVQQVIRYvO2p5UWrqLfWj+xRRu4JSf9ngF83H9bK57SXkUlzKBma+BWxz6Su2q9edgmnBTUPx6gVU/3hM++aAYcHTGn0GAS1SRuMI2xMD0KrG+feSqXnAubKtSzaRkERvqJnLb61A9a5cOtpek5TzsZQc15/dPATui0kL4khKZOWO/Q3Vv3DggwiBHqH99wKopP7o7VnucmWECrtXTPKsjmmVEehWscXOzYZHMMnDYU1Urgvath3vb8A97m0aHn4ljdAHF+xdKcGJ9m7hQ3SbjZyspEc3QkbGZG2aGL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=DOmO9oUHPLoNK1iK4TLj8z8CErui7lfxRFwJuToG9C8P47U7OFw2iCiuQdPsHaPdxyyDTgYoea2MeEvzHPZuCR9eheLwkppQytaZngmy8L18KiLUlgvBikA3I4LdkJfumeDlEbnLg5q9XLRXQ/Vs5KHjwaLP1zs2SDu9o/WHfV0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:44 +0000
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
Subject: [PATCH v4 01/66] radix tree test suite: Add pr_err define
Thread-Topic: [PATCH v4 01/66] radix tree test suite: Add pr_err define
Thread-Index: AQHX5r/ihtzU4vkq50e3pI5OgPHHKw==
Date:   Wed, 1 Dec 2021 14:29:44 +0000
Message-ID: <20211201142918.921493-2-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37311f50-0925-455f-e0fd-08d9b4d7051d
x-ms-traffictypediagnostic: SA2PR10MB4682:
x-microsoft-antispam-prvs: <SA2PR10MB4682D78B9953BD5D48F241B9FD689@SA2PR10MB4682.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w045IojjDsl1FFkh7/zkte/OoPHOzYit6rp48blo7zy9FyHwuAAZ0rJMI7WJO/dQaJCqET668VWXA1BRF+KkdogkbLEd9FY6n1b4QmQoeY21ZSqWhs7J6TxJVM/NbLaOAubYSxp/6QRGgUfb1mZ9gBO8tX1hCkJ9eeSg1f35T1AP7ofsmtgdF3kH1pXjTtZJTeHFNK8wc9AcVXsooZVqK43/bmn4zgR8Z63VFNRlhTxh9O9S8BHHNdXDv+uMTZ6kO0PAjPOdgeUMs+Bo5oO5PmxdHJtpcanYLYU1loRihR70tXjwIzulcLPAb0utduuKDYBOd2R2G2t3fAUsbPUpKXUyYPbIr5V3ZTRphRP0yJ+nqM03xAA47lhVsrvTzlX9nCS1JvcDr31g6GweZFzTxJjZlxKQpuSyGzjtge+4R3I/U7IiaD5NkHDdm6SqmGEAYOGchsz37ihsNTVevMvDH2AlziTijMmw/YCmKy2MxTcmwABr84aZ+XvAa6O4soR5MVqnEH00dEiB6FMNlDxIertAmJn6/pDjl4scCDVD2+Tv3CDcBswG6ILomHVUZttzcRaSro3d2E2R2njLa33+7wRtWaQncWffqNQm2YUSldRRWwJTC/kNzEarkPIRYVBxtSfWcCixXb0ZHNC0c5R+uRwKAvrZKrqAwVbvfU0cVbB0yL6F0prOk6j+C6QhtqVP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(107886003)(7416002)(2616005)(8676002)(6486002)(66476007)(36756003)(122000001)(1076003)(71200400001)(38070700005)(66946007)(6506007)(86362001)(64756008)(110136005)(6512007)(4744005)(4326008)(8936002)(26005)(316002)(38100700002)(2906002)(66446008)(91956017)(508600001)(186003)(66556008)(54906003)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4tGt1khWQovL5nm1ei17ujm7rN58fEiwq5LSrGHYjJR7/w+u6DtGzoAM9S?=
 =?iso-8859-1?Q?GDa38MxJ5yTPBcYGiUdZBsSirdt5dIutfdhu4pMQOckJ0g3H8nzMi+sSHr?=
 =?iso-8859-1?Q?MNDIldLeHcdonfP3R5uVW2slxnMUPsGkd7oKrb15kmwd9P8T8foRvIUuX8?=
 =?iso-8859-1?Q?wY/L9GpTw+JwKhVeS8o4qXKpTmX5+G2zwKE07qhOHtiWPKLp/LqqeOXF7Z?=
 =?iso-8859-1?Q?/ofDvlJAUMIPJL5LSoubrSW0AX0Q7SxDhlBvXHgOW+GmYNNNEIGpSYFAyZ?=
 =?iso-8859-1?Q?ImAd2JBHofGebtd0kD24CFK4BR2JNuaVJq43JDE+3VEFmerOzmcWRpTOmU?=
 =?iso-8859-1?Q?mRkzOsyF9sCHsSfKGdSveyul4qw7gWnUMsBluePc7jHiZRFZL8CJTMHCQB?=
 =?iso-8859-1?Q?QYpc1inQ6ZU+qt7c2AV3FV7Z7qdJw4HEvgEQmxfuDet7dTsAHI6k4N7Exa?=
 =?iso-8859-1?Q?hX19qQDGEyNQ2v0SteXAU5HMLs8NrzP3AUXAKCUBsJQRlCAd8J//HBwAeD?=
 =?iso-8859-1?Q?SV6qdrkEdfHL8e0iIp7AaKWhPi0mwLao5ETHLhLvn6kp/MeXiY+/W6+t6x?=
 =?iso-8859-1?Q?F9mvFsOha+umDiFulQz1GGYJjVJHHHq3ABrpK/CDki19DMKOf3gexdQNNc?=
 =?iso-8859-1?Q?cryxPa7URkQyOPNjLRAn584a+e/TBNh64TK96yY/YNzfIMjgcB15niylJG?=
 =?iso-8859-1?Q?LwBLbn1BfJpxorNpoIHmTTDynmcHR7kb05Jz/w0Z2cuSib3C27/gnkxO5C?=
 =?iso-8859-1?Q?HatKSa5HgsOqFQVe+hv13ClbktpnWzDLaZKDyvXaIxB+73+xdbcj0y0GZH?=
 =?iso-8859-1?Q?aqPjyQy9wYx/CxWAkUVkSbHq/m3kmWgECsoqKGETzpR8Fbiic3e/zJ/2xB?=
 =?iso-8859-1?Q?SkO3hn4WWfO06zGcumG7WQtS0AGSetf2HBHaHJMzBcH9WzE9NXrrEBvDGB?=
 =?iso-8859-1?Q?5sUa+9S8/uk64dfkTDqQcfKeJbodBCDZ83OuDX8klOuIHFk2qs58zdT+3R?=
 =?iso-8859-1?Q?f+J6w0JnAhBpwSej7052uYYpOjuHRBwN5ul6gLwHhG7Q7hiuIpjqUUYaCE?=
 =?iso-8859-1?Q?3GiK72DwSBuG3HOdd8L0N368YqigPWW3rnzkB+mnVpn085h3SxGdCcp5tH?=
 =?iso-8859-1?Q?tyTzkqkD80p+Oo4c2Tz83dWF6QK/1wAirOqBusTR+uULBLVETWYTj4mze1?=
 =?iso-8859-1?Q?2ysjSDSl4j+PKXHGpXlptR9vjGm+UDib1FHCtyaZzgbvt4QEbJfUO7ybx9?=
 =?iso-8859-1?Q?EGX82jnOc65lDtogOh7Kso6PqfjO0fVAtiifj3DSMj9pofiGr2iizkTjdb?=
 =?iso-8859-1?Q?sS6cmElo4csc4N66WBKvp1pZGBR3w1yiSvxcdxa4VJsvyWf9/EwjA8XJl7?=
 =?iso-8859-1?Q?M4bEDmHNlwTEQVAfJBJLOXbzHwwEBAF2NMsbOTiO4ZIp2uHKFUh2i/XUxH?=
 =?iso-8859-1?Q?LsJ4anOgnzJuL3mjNx7fYpNQiUiTKLqQyKBqZEMsx8wfCxsW9PEOR2bPeC?=
 =?iso-8859-1?Q?iXy1IJU0CjBHeNKwCbzp+z54YGeT5/un8lJTTOw5V7ttSj08sz0fCJJAE2?=
 =?iso-8859-1?Q?lPO2qNA96JsaHV9100m2TXq8G50Jmsj7MVOalmO/y/HRGBHyEsdPdKnjyP?=
 =?iso-8859-1?Q?/lhU+oQW33u3bII4E4bY/SQd+KCfdKRgVCba7I+uPjLKNMyM4nqsqI+yiK?=
 =?iso-8859-1?Q?rXdATF5zAE17lzmuS00=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37311f50-0925-455f-e0fd-08d9b4d7051d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:44.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9QB1sTzPNH5g7EmLZNl+Mylc3Rs3yxps078Ip+EciXYmeQniSazBCfEhvr1+8o/rW6/B8+iuYDryKs+4E0Bcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: xBMIusghJcNqLz-RnPY32bI8boWMKM8K
X-Proofpoint-GUID: xBMIusghJcNqLz-RnPY32bI8boWMKM8K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

define pr_err to printk

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.30.2
