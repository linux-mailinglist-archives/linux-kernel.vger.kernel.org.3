Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5D4C91EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiCARkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCARkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:40:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81042C106;
        Tue,  1 Mar 2022 09:39:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221GZQSs030556;
        Tue, 1 Mar 2022 17:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=uRM6N5Y9SQ484OXU9OKivhMtqwkyXf2B8EcdMjIoTB4=;
 b=dL+7Z6FXKOyVfh9lrCqfZwsOFCiPLEA/fNzYkHywm8ofxSDSBXj1vl6L6lLWZcz5U6qr
 Nnp1rUo5kllkTw1jsybP3xhiHrwtxEQpQJ7ZoJoaZYkHnj9BHY9Opqw52wp4OvsWOabR
 CmDElBNQs0U6/+4lQ5xtBJ2Ig7tESYrn5W8kgfdmzXrxWqndjz4c3A/3z1wMV5GiLac6
 XFvIE/t3JMTvnErK+tNd0uB9+YlJXq1V2MG2uwzAccEzeX5/eMgn4AB4s3LVZ+jg8gko
 1H/O9WpsQ4cygy8CirmVppJglLK8gU2iTWLrkY0O9V8Jvvp1zT1KbvJbi6anY8JS4Dng fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k43hvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221Hb72r059897;
        Tue, 1 Mar 2022 17:39:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 3efc14xcvg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIIxvAvqPArgw3WAWIE7XvrLmCW6pjaSmOBPtfFzfcyG14l5/xggJDuikmTemhBiNRBcIQG+FdGgZxteO6YsJo8/LDT9LsudRTgvgnEXqLJO1L0hN5oSMBQ8U0iJx1bzsvG/PSCTJBkqhAvdXYHaYiaflG3HmQeuw0vx6XXYjcEVgNytl29gKxxdUqtIi7ACk9VWrhZ64JYvTU9usNAGNuUIF2e3F/2T1T3NCc3nC+2f+2+v75d2UunAviG0VTpaajxEtvCZy6y6PhLgD27NR+2YTuyb8IXUBmhjfH/TUBt34v72qjZ41tXPPsa+tbvAhwzcrlAJCMXWbQ92p1DRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRM6N5Y9SQ484OXU9OKivhMtqwkyXf2B8EcdMjIoTB4=;
 b=X1uuM97VE8cFUdxnByj5n0Ry/xbD27JbNEuPtwmuUSgp1hu5h3yi8D7xVE39kQcNSx03HTTSOpPsubyvEpZYEHk3GtFMc9Whj+jnjeS7F8p+HElYJUrz3cvGnS7v1Z27nKDWvv3Pd7HDz3k03YwjwKptOOGVXnFIwd6IZklPL4VmR3cF2AanYxgQeARBshW0N6hIMj6CUSVFs4yGR/BQyKTo8D+0uZkI6yB4GjQuTS2JwYyqxriEVPqckY/CYrSGKSYQRqHGw/j6LOr8Zjuo2dTrFIN99FiIZfXItDPvberaBc6MItUph7xdFKJ7/4Yy7514bwRgPQd379tFQjHQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRM6N5Y9SQ484OXU9OKivhMtqwkyXf2B8EcdMjIoTB4=;
 b=WmlC4KakZxhOnoRoqCdneZQIS8VJRypE/AOwAm51peO46MnYIpZ59oZ4uGsgT9qhigPrmgQ8JLjuRoXiGgz568pieSvTF8PBOWADVWmSlsJlnqWueEGTLMVdleWGdKbwOgGXyrZt0LEgvwRyAe6AsZRtqU0/QNNcOpdojqm+Bgw=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM6PR10MB2795.namprd10.prod.outlook.com (2603:10b6:5:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 17:39:05 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 17:39:05 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, jarkko@kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        stefanb@linux.ibm.com, nayna@linux.ibm.com,
        mic@linux.microsoft.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 2/4] X.509: Parse Basic Constraints for CA
Date:   Tue,  1 Mar 2022 12:36:49 -0500
Message-Id: <20220301173651.3435350-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220301173651.3435350-1-eric.snowberg@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0194.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ff3a0f-89d5-480d-671a-08d9fbaa619b
X-MS-TrafficTypeDiagnostic: DM6PR10MB2795:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB279584447E89587F25A045A187029@DM6PR10MB2795.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuU77XRRyKgAiAsRnB5Amd912L29OcYFAc3ZhUKGUitJbifYP44r2Xy65YvE1Lsf/0w7DoE+BrcR6Wgd27YuoynVeYIetImqmaKp41WABXo4bj70LywVikoebNoVQPnGkc/UwJVKPJY8zi2n3+COn+z5tPpVQ5TR0quCW7DQd0l5v8nTbQUrlagMwrI4fHHtmsH1P+CVEzmb+MbVOQQtXc7VnhwKHt1FDjt7fkK6Inj7qasaswnnO1h/0GwWNfB9JhfrO8pnbWjXR7obqvrEZEvISj/pyk3Qn0XA+WqmeOl87V0UO7GMj2fm2YXFpZPDOjlgv4FF/Rqf077ssOL4frvZsFvBJBguQ8DOG/DQiUfUsPN/lWXpLeif85cceK/2aeGJbexJYEZtAONy7on4BgyoU/iXPdAFXQe841VX+Sxq+o12oGNqdnhITjcVzP/pwhIYXsyjIKyLgcEUi+n96LiulIEvTp6l/giOpeOiwpHR/28EEyUSrze10/7SQaqolvnkpbNTSBZmTvsoB6febifgQGDE4vIRVZpdCmGre8V4qV4NR/3TGYfcAzypH7gVJGwuFibpeJfhsy7piUp8bFdi31kMlW2UhrxOgHgHPkwm3U+6xuAGvzaa2v+N/vl6HEw2B29WZy9KGFyEkNzyv11fN7GgC54a+7HXYrDaOAakGU0SWMYrLMM+H6KEaSMWMGY+pwydZuCkT1+ZpShw0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6512007)(6666004)(6506007)(52116002)(508600001)(2616005)(36756003)(86362001)(316002)(26005)(66946007)(4326008)(66476007)(66556008)(8676002)(186003)(44832011)(8936002)(6486002)(5660300002)(38350700002)(38100700002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAQYdfF2VyNLcs2vP6rwHiTlCds7b22UQ1ntDWPVapw3pfJgZNhsMYIqLAkZ?=
 =?us-ascii?Q?/Jz4mNC5wcFeQAYpjtvMvYSKNgD9J4PStBb1NMvvS7tDSS05b55YZX0s2byk?=
 =?us-ascii?Q?IaO+M7Qndi1dFCWbfohrvsGMOJcLDquZ/d0y5VNJoX3BVG1DO221pD1KRgNk?=
 =?us-ascii?Q?mUeQcdr6oNXhvTRqWTFNGBYMbhrpVcUpAvbf66vdV64CgPszCKhpW8UaYwSZ?=
 =?us-ascii?Q?rr0eO+QiVNehN+0aztBm/z0z8OOA2Zn68tCX7MLO5xst0uU7Wv5XFQ0+L9j6?=
 =?us-ascii?Q?oWSi+BSYABWUifOT7Wdpvw3+ftMbubtc4pTFE/4SCLcn5PhlxangUwjarj/P?=
 =?us-ascii?Q?w5d+C135+pNDNfTELVpPeDxqPt+5fkk58QEG5xI0S89un0nPBAWW+5ZrdU+S?=
 =?us-ascii?Q?/eU+rO44+jos41ROt1uH+m9WFwGZLqI/M7ayANTFjTVAqZk2FeqHb6TgsjWz?=
 =?us-ascii?Q?sXkn47FCIXvGvEF1GpVBOn4nAUAm1JVLsObeUIW8KEuhm95fx5th+5dnrY5l?=
 =?us-ascii?Q?Ct5FavHVZCtYFArx3E8avuYECi3Sp/e/qLuFzDaBmSYHSjYqM3XmrcKlPj5+?=
 =?us-ascii?Q?J89VNBzhShPW++n0mXIGr0CV6hI+wv9IvI4aH7JcsMl6o3i5ouzGg7IxeVqb?=
 =?us-ascii?Q?Ln75P69HgW9jXeMb0FXo8Z8aRxVD4ORwrCDttXe5j+myiW2x2L6xZcIZJk0b?=
 =?us-ascii?Q?OgYXbwq5YZtFCJAqltwl4WWCYQCXVrVwrbvvmBZmtED6fyfiaiOSm9KY0Y3K?=
 =?us-ascii?Q?yNnZA1PoPYRbnr6m6Mg7HrLOhRdNk1u8cSapYeAR8Y/6xABGGNmbr2c3jR9q?=
 =?us-ascii?Q?HZBjPGGmSvTkABZDpLFRGlTsg6GjyCZxNT4WhDcsow5vjQyFUbqYoESfv6Y8?=
 =?us-ascii?Q?+cprN8kLCKfO7wC0YP9J/Lg/kFDgC30YhFPnkED2ad0zTGHl+sGRwLU4+73y?=
 =?us-ascii?Q?9QnaMg4TKiMC83Yao/JqskYSJK1a2tJYwoqjNnVcvCpUaS9uL18DH4hyVcqR?=
 =?us-ascii?Q?Hfs4dbQquOdKeuqFdBDlXpARbqVbk1MALXCsUJMDKJCOqxXqJNSRTtlYJmqw?=
 =?us-ascii?Q?DIOKAV1oEsc7uNqwf2VSlqUjm+PXDSUr50vUQmE68edsXILraCvK670LbJ6a?=
 =?us-ascii?Q?6FYumZZuWpUtT/mpmdEdYg1t4u6ky5ONoSPqoOvenzOAsPQ/ltdc/7ny1sXL?=
 =?us-ascii?Q?LfhwOxm2PdKd6YpdK1THMzRqkPhS2GhxEqD1DuFMoO7GspGKMMl2s/pgPTlc?=
 =?us-ascii?Q?bvJ+NNZwZvDd1xSwwpTXwycEyYtaE5YPKh/rLpnon07C5MnOGxHDI5ih2CJV?=
 =?us-ascii?Q?nq6aJvLFi3u3JeLzims4Y4ynZsx5QMF5KMVi7T/GGQVThaiO8UnXac7coutG?=
 =?us-ascii?Q?ZpRegInAqgCWm9W7S7fIN4DzAScbnSROjMbZ37puhTOPD1Wvr9A5Swvu60Cl?=
 =?us-ascii?Q?svnPbGtitG2yxh6sViIzlNd2DN7v5/Q5fF4NuWO6ghQHmXDkqimuC00T3R0k?=
 =?us-ascii?Q?sZmuBk02iaduqTSAQnpmKssA2ehbItQW57ahWpQLRETsFzny2pDgEXpkGCaO?=
 =?us-ascii?Q?BpjXkO/hqjCLoLGKHAr9nFe7RgJ1yTP1/9okCRiJe4+IT9GjQzxdJVIZ99y0?=
 =?us-ascii?Q?CQlTDxFmmUoAYkfI/4gWX7gWCxiOcYQ8syKRfQ3FUuxTCzmJIaHOQoQ9fXWg?=
 =?us-ascii?Q?DpLSRA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ff3a0f-89d5-480d-671a-08d9fbaa619b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 17:39:05.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9khN0uTuUuQPBAOOtZXlptzTU95JZ7/JbPswEvl2nDz0RrrTBhjWQojMjRmMV0ShRIBynbnA4iS9brVZJuirnAQIZUOqGG4WBG3AePb6EG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010091
X-Proofpoint-ORIG-GUID: DTfe0SagZZ-ueuPmSFFUF4DkdH71esQg
X-Proofpoint-GUID: DTfe0SagZZ-ueuPmSFFUF4DkdH71esQg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the X.509 Basic Constraints.  The basic constraints extension
identifies whether the subject of the certificate is a CA.

BasicConstraints ::= SEQUENCE {
        cA                      BOOLEAN DEFAULT FALSE,
        pathLenConstraint       INTEGER (0..MAX) OPTIONAL }

If the CA is true, store it in a new public_key field call key_is_ca.
This will be used in a follow on patch that requires knowing if the
public key is a CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 include/crypto/public_key.h               | 1 +
 2 files changed, 10 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 2899ed80bb18..38c907f4ce27 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -583,6 +583,15 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_basicConstraints) {
+		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
+			return -EBADMSG;
+		if (v[1] != vlen - 2)
+			return -EBADMSG;
+		if (v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
+			ctx->cert->pub->key_is_ca = true;
+	}
+
 	return 0;
 }
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 6d61695e1cde..0521241764b7 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -26,6 +26,7 @@ struct public_key {
 	void *params;
 	u32 paramlen;
 	bool key_is_private;
+	bool key_is_ca;
 	const char *id_type;
 	const char *pkey_algo;
 };
-- 
2.27.0

