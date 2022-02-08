Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DD54AE14A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385236AbiBHSor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385015AbiBHSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:44:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8DAC0613CB;
        Tue,  8 Feb 2022 10:44:41 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218GjxHu026745;
        Tue, 8 Feb 2022 18:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=nSIELne8b69yJidBmyRYmkARSMNrUgCTXjrhp0ZAVlI=;
 b=mNkbwqab09eAAeNQz2wrKclSLG1qFtDC0OW6Qshl5GGgcV7/13wBGDfMj2+LU8wrwgbX
 Bf/RqqKIUoJr/O4RM2XaOM93lEijtlUOI16IDgGde4HgKQvVjxK+x7B8OZDJXoFnPEfp
 WYdph8NbCcN4JeZKdgcL77kj7AwbnjMag6GdfUaFlRDUjpv8KCBp/ok76fiKAVhWIxVr
 vK1l8G46mw3Uz1EQ0A9yfRHvwhl5+ko8aDw/PC3vlgQVxw46fpw8MdH35lJX5PRoTWri
 9C3Y61qjX9VOdsXTw83KaT2qco65lPDQrb/LIhl8wgltPzb06T+g/qwwwyiBJOkqcPoa Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28j8qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218IZXLK159273;
        Tue, 8 Feb 2022 18:44:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3020.oracle.com with ESMTP id 3e1h26thr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkO8lZ9IjUSyTLgaUPyCsMJf2mFRXvOD99pmVajwki0HclD6bBepDbkiTHju3xikD2XSJ5IzZ/AoLfpMvHv41jhen86E1eFTNqtw4oLWBtDpUif7BVXUJmXiWx61TY1wv9hswnDqIo/Gv7Tk3ItL1OAkIFW9MJvRI1AeyVFIB9+Pj5+hfRUBDJESjM5wi0CTOpXCe/MqCKj/4gGQq0zxZ9bSQkaSEnxnBvbo9eFHKRRV2S688JrfOXy/Kef3+T1RQotEQM7r80x1adaXpbeXEDZ9Ev1LbUJKuoz0J8GoFgnR+ZI3O7e2z1IoYuNc/0XigLCwwTFNgekowFFKkJ7jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSIELne8b69yJidBmyRYmkARSMNrUgCTXjrhp0ZAVlI=;
 b=QnnC8PIfgFzQdyLdeM4ooRAOv2uWGoHZu+YzaROv2j8s/52lG+z9Dj8nLuqJfccIrv77Oj7oSOkj/S8hvkLP6+hW7a4/ex1He89RQaGxQp1IJYGkjF9KDRcoM3csiIztgOCoxRRixlSUgmNZsxEOJFCuXjaHMDCjZOkGLhklnuQtw1iurIZ/1nzb5+cMHSy0dZTNbEJSHQoegBYZp2KYGZOJ9czj6OdFP2AQEo1sGkcYTemroCdBqb9MJjn0SPPzGxb6kYyN6SSFDzZ1F77w/wEO3BwBMqy5vdgq5L/2G2602JtFEjfj9DiU34zXcbjdCevpSuraiVz60Azw9q4TGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSIELne8b69yJidBmyRYmkARSMNrUgCTXjrhp0ZAVlI=;
 b=rCDenqcFMVz/Ol2mQ5hG+BeLLq+anFE6w6xQSyEg4W2WaCjSzpYKBLSg17xEUS+jNg7JcozO9OrChPxKawOvyspfkgVDIo8I4lbYtu6M1kgeoCnuYzBScI9Yv1nGrq1+QuXTROJYMktcsFcwb3zQFCRm6OyN7WfO5FA4pMN/+Bg=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Tue, 8 Feb
 2022 18:44:08 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 18:44:08 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     jolsa@kernel.org, rostedt@goodmis.org, bas@baslab.org,
        tglozar@gmail.com, Ast-x64@protonmail.com, viktor.malik@gmail.com,
        dxu@dxuuu.xyz, acme@kernel.org, adrian.hunter@intel.com,
        ak@linux.intel.com, irogers@google.com,
        linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v8 2/6] kbuild: add modules_thick.builtin
Date:   Tue,  8 Feb 2022 18:43:05 +0000
Message-Id: <20220208184309.148192-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.35.0.260.gb82b153193.dirty
In-Reply-To: <20220208184309.148192-1-nick.alcock@oracle.com>
References: <20220208184309.148192-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::21) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94458f20-412f-4f6c-1425-08d9eb32fd64
X-MS-TrafficTypeDiagnostic: SA1PR10MB5781:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5781E31E7788A10978CC4B118B2D9@SA1PR10MB5781.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97XPM24X/9AelFQ+3fhuROOeliS56NT5jOluSorMbnMH3nWxTJ//V4M3UeYM/Kbr+cdG7jT+Kj5BjjMgYuJYrtJl14Fvss3jN1kAupWKZk5/vTSFyZ5fXQqc1oakHSYlM66jW+JzKp2ujHbsgagw+9bjvfdHWbQOYUh3fDhwGKeQnlxh2Xb0TpQpWsdcrWDTJdqrnWpp8mNI09E0DM3i+dW/RTP989kcj7g7PtvdLhgD4QPYuFg9DXnXAU5I793Jf7fwIIeLasfP+2ZAQraEMCjDV/7ElBrkTQDWlj6L4nK5tR3esRCCEiKB1aLrFewdh50w/b9abeChaljGQ9mAqI9e3zzInmjgUlEJq5zjF0NWqduSDL4w30pBbC6r48J9lQm2qnrF4fgleM3xNdh3S6RN7QvzTtkWbc9OrL5P7xFvAEuVCt3XmuCC3BPUZbjo+RzyQhlx5XmKpVj3HmABmsW49hPZSNLQYkAa+xBeFDpEDvpPfsURAgMzUIFo2ladmFZM5SOfyhaavoLk3DfZaOxJtrTwgxMxnUkPP2/p8pTMX8qKuiesyV7Q46mI/iXkXqwFoJslcDMkcAodE7ZFWLoaZQCfcWAlTuhLaofBxT4zr9gfMfkk0kq5J0iwvd5wadoFNfvDQ3dx58F2lXPXyUkYk0pN+1N4DJrylvSMmin0yscrGvKkElPCezDzJIdfeGwro4lhZVzCqjsF+YFj/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(86362001)(6486002)(36756003)(52116002)(5660300002)(6512007)(30864003)(1076003)(508600001)(6506007)(7416002)(186003)(6666004)(8676002)(44832011)(66556008)(316002)(2906002)(8936002)(66476007)(4326008)(2616005)(38100700002)(66946007)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FWVe8jzSQZCCLspfxeOtddu52PSAextifZPUvUdyTib17ATF15STfhWO2UN3?=
 =?us-ascii?Q?8IIz45nzZgVyoDsNZbQ8KWCqx2r7PeTXxrILKpwu4NKBZltt+DcDfQIdszxv?=
 =?us-ascii?Q?xbJuLzRcjjRqSr6FovxiyFx/zUY7gB/3fEcpSfsNmTB9GyshC5U+ont0ye1u?=
 =?us-ascii?Q?vnU9s1nZHZqIqx2B5socGN1ZvuchoiPOol4FragNAjpDxMrJDOibAfcCVVWB?=
 =?us-ascii?Q?92oDyMBQuBmJcbv4j4ogCxUx9ilsqMzHixUfVuQ6f6ZzbFwcnSY5pzSgYJu7?=
 =?us-ascii?Q?bTz7tgeSkg9fpyhUsRHIrXSCjl81sdh38d9mr9kNLYI4egF55O0NoCoMNOSi?=
 =?us-ascii?Q?y2PIPYXyavAXUHKQx8bBISNcPlJ0LvSiExjS386QLk9+pUNCZq4lrzO1MgdI?=
 =?us-ascii?Q?2B7E8aSb6MegyGriw4VR0Wjw3LYXuLJ9Yj9inL0du3PYld4EnsBoilX83t0W?=
 =?us-ascii?Q?jWNdeI69j4pkVyKJgPqq3D5oeMKYmV/O0ZbQi9XofpFkBB0HqNpmt8kEx9Ri?=
 =?us-ascii?Q?CV7gfXS7tfaWA2SXyhDxNxM7Qsvf2uvBJ0oGjKIXZvWGHRmrx2glp2BalzNW?=
 =?us-ascii?Q?r/nBBvGse5PKShKrssMJS9Ne4d8xEl5SD/TUnpzY2noRuJ2+RH3/QyelOh4j?=
 =?us-ascii?Q?5OLc1FXo6/k8oyG1HDx+oAxFMPDwc9V4HRrN3M5vRAQFE1xnUYcKytfdtvQB?=
 =?us-ascii?Q?+Ywu6TnShR7uPTKqCWnh2/cOKvbQeY6SAgCa6zE4DzdNfPCAwXMl6KoQ8Kkm?=
 =?us-ascii?Q?TM3skdY7LGQ/SRDkwrTqcjjpgnmGQfEu3sySRzSA/chDUTr4mqTQ8OzlUU3x?=
 =?us-ascii?Q?u9jf7GNyBwfTk38vFiQ7mGmUz6GvzvJHmuLrNYvK5rygRb7k5Hun/De5V35L?=
 =?us-ascii?Q?dk13KNsUNIn/Zw3pHlw5aHzej3alpyYd0yn54FbU9KOmbpTif2OBRiT4A52D?=
 =?us-ascii?Q?SmCqiLJ8wAK1VbpsHgYcMjcrSySNnMfyAcHdsvX4wKDeIpb1PZb/DMEZFl4T?=
 =?us-ascii?Q?zqit6c2WimtVZO4fgc/KrgfToXRvKbtb3y19dQL7Ia1YPP8ykgIlyH9GTWnK?=
 =?us-ascii?Q?mn9NHtVDo0DsFjzpeyQtXKQi+J0rQpBpFCkp+589e03YuHeTfL0dKlFZMZ9+?=
 =?us-ascii?Q?qeX2cX4UyJfihIc6H5xenwaDtsi+l6V1rmSDCYk+t38WBSs9kc/UNqAr6dKR?=
 =?us-ascii?Q?spMMTuXKfL4r3P0Pf2yiHcjcn6Ui2I05zkjhO/MwRHXhogiOl5h5Ogk4m0NA?=
 =?us-ascii?Q?fGUsjbSV9b/ezN2i7NtB82W8dMv21cO1WcCkZZtrAcJFm5xRXUW8o8/sR8lY?=
 =?us-ascii?Q?YsYwis9IPMkNUw1MBPA1pEWATfj8QBaRZCgDBNQsK7DwLGkkimH+L88/qEIh?=
 =?us-ascii?Q?v18BO7+ZbeOQ1vgc5O+0Ui331NMnNbFmM+D2ycu+vpGsECg1JHaN6HDs/ZTf?=
 =?us-ascii?Q?Y48QfPcKv3OHkE+VBjbTo/DgYhxLRUlVJ2E7krCONlHhFT3q3JlfCgEThGD+?=
 =?us-ascii?Q?bB4PelN6LalketcmcBLFVKWoA3OnaUAeJg8cOq/YWsChRzeBSqwvn8cCbWH2?=
 =?us-ascii?Q?SgXrMmuVqwdvAJKhFAGmWE5fjrUN1lejHaxs0WKHPe2VwEErL1wGOvaGZZ1h?=
 =?us-ascii?Q?khMCEX3M/9rRFQIH8MkHPZJ8AIksIW20Sgws+hyz+vfd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94458f20-412f-4f6c-1425-08d9eb32fd64
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 18:44:08.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bND8KScB2XZG41PgEQYBE07G6FdEXn87fT/4U2zo2NnkIIoEgZT501EWAZSvwbyerRkdKib1fYCuU1ZsppHrlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080109
X-Proofpoint-ORIG-GUID: 7Qy0e2YLBvTxzveCkOkPoQBdc2DhB0eN
X-Proofpoint-GUID: 7Qy0e2YLBvTxzveCkOkPoQBdc2DhB0eN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to modules.builtin, and constructed in a similar way to
the way that used to be built before commit
8b41fc4454e36fbfdbb23f940d023d4dece2de29, via tristate.conf inclusion
and recursive concatenation up the tree. Unlike modules.builtin,
modules_thick.builtin givs the names of the object files that make up
modules that are comprised of more than one object file, using a syntax
similar to that of makefiles, e.g.:

crypto/crypto.o: crypto/api.o crypto/cipher.o crypto/compress.o crypto/memneq.o
crypto/crypto_algapi.o: crypto/algapi.o crypto/proc.o crypto/scatterwalk.o
crypto/aead.o:
crypto/geniv.o:

(where the latter two are single-file modules).

An upcoming commit will use this mapping to populate /proc/kallmodsyms.

A parser is included that yields a stram of (module, objfile name[])
mappings: it's a bit baroque, but then parsing text files in C is quite
painful, and I'd rather put the complexity in here than in its callers.
The parser is not built in this commit, nor does it have any callers
yet; nor is any rule added that causes modules_thick.builtin to actually
be constructed.  (Again, see a later commit for that.)

I am not wedded to the approach used to construct this file, but I don't
see any other way to do it despite spending a week or so trying to tie
it into Kbuild without using a separate Makefile.modbuiltin: unlike the
names of builtin modules (which are also recorded in the source files
themseves via MODULE_*() macros) the mapping from object file name to
built-in module name is not recorded anywhere but in the makefiles
themselves, so we have to at least reparse them with something to
indicate the builtin-ness of each module (i.e., tristate.conf) if we are
to figure out which modules are built-in and which are not.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---
 .gitignore                  |   1 +
 Documentation/dontdiff      |   1 +
 Makefile                    |  19 +++-
 scripts/Kbuild.include      |   6 ++
 scripts/Makefile.modbuiltin |  56 ++++++++++
 scripts/modules_thick.c     | 200 ++++++++++++++++++++++++++++++++++++
 scripts/modules_thick.h     |  48 +++++++++
 7 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

diff --git a/.gitignore b/.gitignore
index 7afd412dadd2..b49cd96f587a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,7 @@
 *.zst
 Module.symvers
 modules.order
+modules_thick.builtin
 
 #
 # Top-level generic files
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 910b30a2a7d9..6a78988547d0 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -183,6 +183,7 @@ modules.builtin
 modules.builtin.modinfo
 modules.nsdeps
 modules.order
+modules_thick.builtin
 modversions.h*
 nconf
 nconf-cfg
diff --git a/Makefile b/Makefile
index 199b6f388484..5e823fe8390f 100644
--- a/Makefile
+++ b/Makefile
@@ -1470,6 +1470,23 @@ __modinst_pre:
 
 endif # CONFIG_MODULES
 
+# modules_thick.builtin maps from kernel modules (or rather the object file
+# names they would have had had they not been built in) to their constituent
+# object files: we can use this to determine which modules any given object
+# file is part of.  (We cannot eliminate the slight redundancy here without
+# double-expansion.)
+
+modthickbuiltin-files := $(addsuffix /modules_thick.builtin, $(build-dirs))
+
+modules_thick.builtin: $(modthickbuiltin-files)
+	$(Q)$(AWK) '!x[$$0]++' $(addsuffix /$@, $(build-dirs)) > $@
+
+# tristate.conf is not included from this Makefile. Add it as a prerequisite
+# here to make it self-healing in case somebody accidentally removes it.
+$(modthickbuiltin-files): include/config/tristate.conf
+	$(Q)$(MAKE) $(modbuiltin)=$(patsubst %/modules_thick.builtin,%,$@) builtin-file=modules_thick.builtin
+
+
 ###
 # Cleaning is done on three levels.
 # make clean     Delete most generated files
@@ -1849,7 +1866,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*.o.*' \
+		-o -name '.tmp_*.o.*' -o -name modules_thick.builtin \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 3514c2149e9d..167bbbd5fdf5 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -74,6 +74,12 @@ endef
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(srctree)/scripts/Makefile.build obj
 
+###
+# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.modbuiltin obj=
+# Usage:
+# $(Q)$(MAKE) $(modbuiltin)=dir
+modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 # Usage:
diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
new file mode 100644
index 000000000000..a27b692ea795
--- /dev/null
+++ b/scripts/Makefile.modbuiltin
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Generating modules_thick.builtin
+# ==========================================================================
+
+src := $(obj)
+
+PHONY := __modbuiltin
+__modbuiltin:
+
+include include/config/auto.conf
+# tristate.conf sets tristate variables to uppercase 'Y' or 'M'
+# That way, we get the list of built-in modules in obj-Y
+include include/config/tristate.conf
+
+include scripts/Kbuild.include
+
+ifdef building_out_of_srctree
+# Create output directory if not already present
+_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+endif
+
+# The filename Kbuild has precedence over Makefile
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
+include $(kbuild-file)
+
+include scripts/Makefile.lib
+
+modthickbuiltin-subdirs := $(patsubst %,%/modules_thick.builtin, $(subdir-ym))
+modthickbuiltin-target  := $(obj)/modules_thick.builtin
+
+__modbuiltin: $(obj)/$(builtin-file) $(subdir-ym)
+	@:
+
+$(modthickbuiltin-target): $(subdir-ym) FORCE
+	$(Q) rm -f $@
+	$(Q) $(foreach mod-o, $(filter %.o,$(obj-Y)),\
+		printf "%s:" $(addprefix $(obj)/,$(mod-o)) >> $@; \
+		printf " %s" $(sort $(strip $(addprefix $(obj)/,$($(mod-o:.o=-objs)) \
+			$($(mod-o:.o=-y)) $($(mod-o:.o=-Y))))) >> $@; \
+		printf "\n" >> $@; ) \
+	cat /dev/null $(modthickbuiltin-subdirs) >> $@;
+
+PHONY += FORCE
+
+FORCE:
+
+# Descending
+# ---------------------------------------------------------------------------
+
+PHONY += $(subdir-ym)
+$(subdir-ym):
+	$(Q)$(MAKE) $(modbuiltin)=$@ builtin-file=$(builtin-file)
+
+.PHONY: $(PHONY)
diff --git a/scripts/modules_thick.c b/scripts/modules_thick.c
new file mode 100644
index 000000000000..9a15e99c1330
--- /dev/null
+++ b/scripts/modules_thick.c
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "modules_thick.h"
+
+/*
+ * Read a modules_thick.builtin file and translate it into a stream of
+ * name / module-name pairs.
+ */
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file)
+{
+	struct modules_thick_iter *i;
+
+	i = calloc(1, sizeof(struct modules_thick_iter));
+	if (i == NULL)
+		return NULL;
+
+	i->f = fopen(modules_thick_file, "r");
+
+	if (i->f == NULL) {
+		fprintf(stderr, "Cannot open builtin module file %s: %s\n",
+			modules_thick_file, strerror(errno));
+		return NULL;
+	}
+
+	return i;
+}
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name)
+{
+	size_t npaths = 1;
+	char **module_paths;
+	char *last_slash;
+	char *last_dot;
+	char *trailing_linefeed;
+	char *object_name = i->line;
+	char *dash;
+	int composite = 0;
+
+	/*
+	 * Read in all module entries, computing the suffixless, pathless name
+	 * of the module and building the next arrayful of object file names for
+	 * return.
+	 *
+	 * Modules can consist of multiple files: in this case, the portion
+	 * before the colon is the path to the module (as before): the portion
+	 * after the colon is a space-separated list of files that should be
+	 * considered part of this module.  In this case, the portion before the
+	 * name is an "object file" that does not actually exist: it is merged
+	 * into built-in.a without ever being written out.
+	 *
+	 * All module names have - translated to _, to match what is done to the
+	 * names of the same things when built as modules.
+	 */
+
+	/*
+	 * Reinvocation of exhausted iterator. Return NULL, once.
+	 */
+retry:
+	if (getline(&i->line, &i->line_size, i->f) < 0) {
+		if (ferror(i->f)) {
+			fprintf(stderr, "Error reading from modules_thick file:"
+				" %s\n", strerror(errno));
+			exit(1);
+		}
+		rewind(i->f);
+		return NULL;
+	}
+
+	if (i->line[0] == '\0')
+		goto retry;
+
+	/*
+	 * Slice the line in two at the colon, if any.  If there is anything
+	 * past the ': ', this is a composite module.  (We allow for no colon
+	 * for robustness, even though one should always be present.)
+	 */
+	if (strchr(i->line, ':') != NULL) {
+		char *name_start;
+
+		object_name = strchr(i->line, ':');
+		*object_name = '\0';
+		object_name++;
+		name_start = object_name + strspn(object_name, " \n");
+		if (*name_start != '\0') {
+			composite = 1;
+			object_name = name_start;
+		}
+	}
+
+	/*
+	 * Figure out the module name.
+	 */
+	last_slash = strrchr(i->line, '/');
+	last_slash = (!last_slash) ? i->line :
+		last_slash + 1;
+	free(*module_name);
+	*module_name = strdup(last_slash);
+	dash = *module_name;
+
+	while (dash != NULL) {
+		dash = strchr(dash, '-');
+		if (dash != NULL)
+			*dash = '_';
+	}
+
+	last_dot = strrchr(*module_name, '.');
+	if (last_dot != NULL)
+		*last_dot = '\0';
+
+	trailing_linefeed = strchr(object_name, '\n');
+	if (trailing_linefeed != NULL)
+		*trailing_linefeed = '\0';
+
+	/*
+	 * Multifile separator? Object file names explicitly stated:
+	 * slice them up and shuffle them in.
+	 *
+	 * The array size may be an overestimate if any object file
+	 * names start or end with spaces (very unlikely) but cannot be
+	 * an underestimate.  (Check for it anyway.)
+	 */
+	if (composite) {
+		char *one_object;
+
+		for (npaths = 0, one_object = object_name;
+		     one_object != NULL;
+		     npaths++, one_object = strchr(one_object + 1, ' '));
+	}
+
+	module_paths = malloc((npaths + 1) * sizeof(char *));
+	if (!module_paths) {
+		fprintf(stderr, "%s: out of memory on module %s\n", __func__,
+			*module_name);
+		exit(1);
+	}
+
+	if (composite) {
+		char *one_object;
+		size_t i = 0;
+
+		while ((one_object = strsep(&object_name, " ")) != NULL) {
+			if (i >= npaths) {
+				fprintf(stderr, "%s: num_objs overflow on module "
+					"%s: this is a bug.\n", __func__,
+					*module_name);
+				exit(1);
+			}
+
+			module_paths[i++] = one_object;
+		}
+	} else
+		module_paths[0] = i->line;	/* untransformed module name */
+
+	module_paths[npaths] = NULL;
+
+	return module_paths;
+}
+
+/*
+ * Free an iterator. Can be called while iteration is underway, so even
+ * state that is freed at the end of iteration must be freed here too.
+ */
+void
+modules_thick_iter_free(struct modules_thick_iter *i)
+{
+	if (i == NULL)
+		return;
+	fclose(i->f);
+	free(i->line);
+	free(i);
+}
diff --git a/scripts/modules_thick.h b/scripts/modules_thick.h
new file mode 100644
index 000000000000..f5edcaf9550c
--- /dev/null
+++ b/scripts/modules_thick.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _LINUX_MODULES_THICK_H
+#define _LINUX_MODULES_THICK_H
+
+#include <stdio.h>
+#include <stddef.h>
+
+/*
+ * modules_thick.builtin iteration state.
+ */
+struct modules_thick_iter {
+	FILE *f;
+	char *line;
+	size_t line_size;
+};
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file);
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name);
+
+void
+modules_thick_iter_free(struct modules_thick_iter *i);
+
+#endif
-- 
2.35.0.260.gb82b153193.dirty

