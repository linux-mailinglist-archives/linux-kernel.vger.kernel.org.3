Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4087F469A9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhLFPJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:09:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49086 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235481AbhLFPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:07:03 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6EarRY030762;
        Mon, 6 Dec 2021 15:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=Tdmboc7lp8kwAsOBorN8HrbsUjGJZdUevnmhwNV2pp0=;
 b=I/4h6h1KkxDhqD7ZwmOrGsrvxfu8Tej/iDBrQgU8x3bS3Z5MM3gkOYAS8Bh4tSUUaIkK
 PuedlBMRInofm8Ju+3KMRbAcwgcpoSeA25CHL4eUpLYjuq+jl5yFeheZsn8+LkguG32z
 vdkVmMwBvmNDQGj87SqMo8Pzc8zajL+ZSkcSkMr7sUjVE3oTVOSt9w584K+fOSXZBQAc
 sTkq/jUq1WWxnSJNztlwHYl4cvspVERTfbt7AIJ5TUnvcFwyPXS/A1z0mSbWmJ0yjJSy
 48su2uBmAC30tNIu8OWxWnLGpYlVjB0bEo2CrReRym5bWQXLZA08HSgNP4K4RCEPjNu/ 2w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcagda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Ev63Z091928;
        Mon, 6 Dec 2021 15:02:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3cqwew49s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWacnjAOXVy1p9aOcUwWDpze/KqU4CeMpgJ/uns/HnRi9Zz47fhXJ74R+kmMxZyTbwE/C9F5AYCBad/mPNeVdl7VRyO+FrwH3TgjKHGHntveSvBqw49NOMRTKhQ4id2YKmHb1PCtSawe+ut5aP8HqXDpHJwvjJLuFkc0MWvsw2Kx19UXTQVLk7lATXibWpINB+N0uWPdxpy756bswKtcWgvLzAVJTkZAQmhXWJHRsbip1TDAnf6dq2O3FahGrW8Us2MplxLa2GFPI6nXw8WKuCQt+kZORAGG0AWAV+gUHumPDq7fGimtssx0zXrCLAFaG9irMNwx2uCpCRyWKiMAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tdmboc7lp8kwAsOBorN8HrbsUjGJZdUevnmhwNV2pp0=;
 b=YpHBlhJ6QfLLcO180BU3QSfo5gPRUg9npo1xTfvO4TD3V0lW15uPL6FVceVOlEKLW7u1/fmGU5Fk5HWDe0nZq1WDoo25InTdOm1QPxysOT9bQ7d1IPgbn4Q20YFUBG5Fr2SSI2YpZ5S8/RF5tdNQkH+iQCNA7OCo5qi0hPsoWU9kmsk6A16lcBrHMwRkZUlZwxDRr22Eh90yl4t4/E4Mcdjmgvy7ASFcHPLxCPD1hMjr5Edu4S6LZRaGB4qgXnWoE+FmEq/yDiD3nQ9KUo3AVzso49FYnBGLrSY/3j0UhznMrP/WG3EkWEM22gjwFCVSPnAnGFcsuJxCT8fbmYpFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tdmboc7lp8kwAsOBorN8HrbsUjGJZdUevnmhwNV2pp0=;
 b=VyLwS99w5IO1HsDV5COOK9WdoXr/vej4O7bo71d8igjyoQ80fzd0MlHlf4BRDZ911frySz+/X/nDAcv+WeBYiJ6t2+ICWzpX6GghGBsOwMoGazmkPF8XSrDWEI5CO1EZqzFvWQ6vtCJufOQNTStoSdA2W0NK8KSWBjYVJHEE1/8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 15:02:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 15:02:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        shinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: [RFC PATCH 0/6] Check length of unmapped area on MAP_FIXED
Thread-Topic: [RFC PATCH 0/6] Check length of unmapped area on MAP_FIXED
Thread-Index: AQHX6rJXrr696fCVBk22/4Q8wj+utw==
Date:   Mon, 6 Dec 2021 15:02:51 +0000
Message-ID: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 698fe5cf-7348-4328-a57b-08d9b8c979b8
x-ms-traffictypediagnostic: SA2PR10MB4556:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4556A743E3E4F8878B0EDA1BFD6D9@SA2PR10MB4556.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyB9X6XPQyjVVAj1enMl/N0a/SFyjmPMGVwV3M41QLy0KHC1zSzorxto/7bL7Kai/pYgMMNCJdB42WaZuRkFVLeCPZS0ZNmMBFa9QwUJpfOEta/zcq4jmK5TCf7BzvbVjvkRFre0jErUutHenkPIdPKr3NAB8xL932AhaBZHKhYBWsQFcAXsEqTzAB/AAFmw1A/Zt6dlhJbs3KJy1zK2X2XhAKiFEkEnVAtuGTOOVxapoAIHVQkcAkO6YI3o0oSWqDqKiaDcc1RkXZtGeaislKSkHoKfCUZGJqlqSufG1Rcwpw+j5wX5XtiBBvEbYzMOktNK7zhSurLRzSTe6/08OkP70CBKiYFrUyWCTo1WYc4tpOwPSSsNOt9NMfExLvGpYDo019gQkbxU4bPrqhRouSu7sE6KQIeqK8Cb4eamJOEXOnpw4R2YyJDQbpEjTAkO6T0QMqKzzaJrn9rXwyIp6iwOvzrQ75lVQw2DTTrTEpTpAfEFQOuSLBiY1WMgPlPxRi7ZmhO/+D0Jp1hdE3Dpx+cDpjOkEEWzY8G/4oHaZwR4Yu0tIhOx4PEeUACPj/Nx75u0prLTLcsiBsB/EA1+/PvYpkCEv6lzPSR27avauTH36aCCqCE/9mnhSlRhfOu/oJUPXcnbO6mGCJTR8Mei1cOXXB8m3i1iLxzTpCrVK78kqeUah+CgDXoGqY/4GdPtkw2BHo5OZLwvwoDGlDauyuD5YuHQ292Fqmr0dg2QQcQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6486002)(110136005)(71200400001)(6512007)(36756003)(186003)(122000001)(8936002)(1076003)(2906002)(6506007)(508600001)(7416002)(38100700002)(26005)(38070700005)(8676002)(66556008)(66946007)(2616005)(66446008)(316002)(921005)(86362001)(44832011)(64756008)(66476007)(83380400001)(91956017)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jYheTyqEAoNObyFJis/S04TUjv9SujCHg8gvGhhbxryD/v4TID5YuUfQPy?=
 =?iso-8859-1?Q?RAAXct9xv8texmfv98VnbUBhFsp9hW3ktxEsQye1pdVnL1ep2mlXycpVhV?=
 =?iso-8859-1?Q?w9yoNFOQKN7mFsb0J9RNEbCxzigKJCBxOQCDHOIyXL5dN5PHcswlZQCm1S?=
 =?iso-8859-1?Q?U8CuRR7kjWWJMaLAPF72ESm9TghOzPiV8RyXzWup6qb/8ydqtGFqCzIaO2?=
 =?iso-8859-1?Q?OkvjSLjYKhPxPLUN2eWylA0/Lx/Ia65LesTtmE4RLSB5Ewyy5yD50oCSZ3?=
 =?iso-8859-1?Q?LWfXRwcY7Wzw1TsX9vxZ+6osbfRwoPCmi8LpALHhfAyRa6ywpXmZEsZtrC?=
 =?iso-8859-1?Q?00228g7qGy1HJWVT/7tBewamLJLY2F7kLspG9L9Ych8IdyKWr7WKqL7gbK?=
 =?iso-8859-1?Q?WJSR9jN7KXabMlw7Gi9/Go0v2o4bGwLXAYq2HxOuyJDxolaJTIF+3vNV/N?=
 =?iso-8859-1?Q?ftnAhGfv6qC7jFTwxaU3mQukK9QqUWhGBXhRrH5h/ZtWqOmcFk/oaVbOvo?=
 =?iso-8859-1?Q?an90aLGX3FpUvEYKLFIus4d3rnQ4TyoMPjuYzG55hAQdtMsNT792CosJEo?=
 =?iso-8859-1?Q?t15oHaoooe8MmFeoIfKrgyN1rfrhs4/bHhHzLGX3b8A2nSx7yzAxkxdjzr?=
 =?iso-8859-1?Q?8VovZPX8f4SXw8ZlaGZStZfL6lYPaklA7qeUNhFy39EtTq/KVSYncWBkKI?=
 =?iso-8859-1?Q?qB+9/S7X3CfeDJ+/7TELw6r87r0sUBvKMwGIYdxDl2wXdhNYGwzusOFaxr?=
 =?iso-8859-1?Q?Ee7FJw2oRXkzFzfLl3yOQQbupfJLHYTEQuwjMObYwkJ0E6A6ZoUsy6hjXW?=
 =?iso-8859-1?Q?5nOnfecw88xNOt2HN9H5l14yWhq3QkZExaDZ9bdGjDM6xc3fBUZUGvVcDq?=
 =?iso-8859-1?Q?/MvVKru7Lql0RFHo/ocPF9K5N4qq6NBGjjIT0dPxD3CL1CGvghdN3kFPgG?=
 =?iso-8859-1?Q?KOlwVSUKeGXMpW08r36H1gxXTO6+vHDFyVCB7ncWLtJgvl7Z0OK0NZZZ+t?=
 =?iso-8859-1?Q?94DTEzRV/kkB+mlWwS5uzty+KhPKm0tGLVB5GH5ShwMWCNL7maCWlsZWnL?=
 =?iso-8859-1?Q?Xmkn0JvTStnLRz0Kx+k1QYNLpfsi4ex7DB/bgSvfsHe+JTMTAEx04OsVqi?=
 =?iso-8859-1?Q?8pDd0dNt5gEDjqBGdRiF/v9Tp+sQ0W29XDGmRtdAv8nyPNoFchhrVCfc7g?=
 =?iso-8859-1?Q?lu8kRdlv+Q4f7C11cYMJOZvRaIpW+X4RiMHao4Dxmm6Iq+VU0TYSkbQmoR?=
 =?iso-8859-1?Q?zXVmdNPn35LyHh1TgrPsn54zWWoJwp7ksTOKOFtC2+5rPWSiiCFl3M0ydl?=
 =?iso-8859-1?Q?GxBMk27/WkR5EBE+fbL/yXsYTQ0D7knkPri+yDxn7hFDUe6+1Onwevge2A?=
 =?iso-8859-1?Q?UdOPfgYQAsPzoTDtFHubGRs+zDJrjzdk/uN1RMLNhCKwuM5EZOryOGDELI?=
 =?iso-8859-1?Q?u2IdDKG7odT+g9wSSId57K7qoFQM2pKzfVvnfYa0jC7tknqTUz/3iDrIVy?=
 =?iso-8859-1?Q?QwC6tE/s5YRfTPwnhFPobnySnDkhIYin4tCUFjuTXHdnC3r1gXbFyZ2X1s?=
 =?iso-8859-1?Q?F1lttfCzhsyIfRSCtnJZJIhXxWWM4L3KkseemGWyWb1ji5I3kTTBgUTeZi?=
 =?iso-8859-1?Q?GFtMLMmv1ttD2xlvpATOCLU6YvGW72tYblQ9uz0vGlC9CRcBux5hNzkwqr?=
 =?iso-8859-1?Q?3uwchDHWiUVLCuYNNqc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698fe5cf-7348-4328-a57b-08d9b8c979b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:02:51.8936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +j84qvicV0DDSyQVgrc6vLYLGOMaC/IQi+b+imWq4VCApAOVXrPawtPFFjglNroaMPWtlG6MuLYhPq1+oowDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060094
X-Proofpoint-ORIG-GUID: D6bFesx3z5C135n1O1JqRnE4Lski5HE0
X-Proofpoint-GUID: D6bFesx3z5C135n1O1JqRnE4Lski5HE0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC because the patches are not well tested.  I've not triggered the
issue these patches fix, but have compile tested arm, sh, and sparc64
using the default config.  Please test the patches before accepting them
on your arch.

arc, arm, nds32, sparc32 and sparc64 do not check the size of the
requested MAP_FIXED before returning the address.  It appears this issue
was cloned across various architectures and, in some cases, affects both
bottom up and top down searches.  This set of patches aligns all
platforms and search directions to check the size of a MAP_FIXED
request before returning the fixed address.

Liam R. Howlett (6):
  ARC: mm/mmap.c: Check length of unmapped area before allowing
    MAP_FIXED
  [ARM] mm/mmap.c: Check length of unmapped area before allowing
    MAP_FIXED
  nds32/mm/mmap.c: Check length of unmapped area before allowing
    MAP_FIXED
  sh/mm/mmap.c: Check length of unmapped area before allowing MAP_FIXED
  sys_sparc_32.c: Check length of unmapped area before allowing
    MAP_FIXED
  sys_sparc_64.c: Check length of unmapped area before allowing
    MAP_FIXED

 arch/arc/mm/mmap.c               |  6 +++---
 arch/arm/mm/mmap.c               |  6 +++---
 arch/nds32/mm/mmap.c             |  6 +++---
 arch/sh/mm/mmap.c                | 12 ++++++------
 arch/sparc/kernel/sys_sparc_32.c |  7 ++++---
 arch/sparc/kernel/sys_sparc_64.c | 16 ++++++++--------
 6 files changed, 27 insertions(+), 26 deletions(-)

--=20
2.30.2
