Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449C04C91F1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbiCARkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiCARkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:40:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E82CC83;
        Tue,  1 Mar 2022 09:39:43 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221GZcGH030728;
        Tue, 1 Mar 2022 17:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=x9+vCh16QwgR2f3jYYr/YM2OczhtAWKgrplmiF9iehY=;
 b=Gx0+CuzTOI4pmiLoetB0cdYfoQOrWYk8VOCbbccsxuqOrUELqHeY81akdxKXsrLgSeYW
 Hmx3SIUB1/GZ/4TUTEjRqGhoibOWbrwxNNYQf8x9lOITF4sHJSrfvHK6eOYh7L+cvgH2
 KUNll/SXkHamp5BU/BCCBV3QyxjC88CSDM1HiD4Ld7RBYfO3HrWHpy54GoHWX2dBiaqV
 tiHlFC8vDm0TykNQIqfCDldutlIAld92LM/5gjLQNc7lMpEPpsmwU3rXAi7eoA8QQ2Iv
 vr7zg8yH5K8eTyiEwpyTotN60Wxno6DN86gxOU3O4DPwcd81g+xuei2hHtkclDDFBBuQ gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14bukrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221HZcpm006884;
        Tue, 1 Mar 2022 17:39:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3efdnn7cg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQf5dUJxvWligoEs5IIvhmv+8qHU3meGZSapDbei5gUCRfN+/Q5S2E51oTlPEha4v5MhmYuFI6v3aG+/aHmMBGXVC68Ce8/7Et/WFbhMt6rNrBAfE8HUl4Jsoeqm3P4avSX2itwKLsWvB7vyREq9SysAl1/KmG4F22oAqpIsHURP29bfTLzUKgou9vYFCH1oeruJbFQ8kCnwatlY9rhqH0JmSiiyUrA9QBy82qDFhf0IZykBFbyfkQXM1DWFYM9BEWZLS6Yvu2B0XjV1AoUKzHs0O6XEDn1y7vFQXiKll216S0+GOlljQi3hQCzhq4LmUQ2X84B9BdwunlNX2jKu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9+vCh16QwgR2f3jYYr/YM2OczhtAWKgrplmiF9iehY=;
 b=apXNcCFQRxUqBXly/RJqNUbdF6GmRPbqDhh9qJ+eZ9kXxqMFXBxwgB6xRnCwKzLB924KaIRNUwesNqTtHXhncDTZizKECv8IUIiSP2duCB7+2hzupMKSyLwoIbS5d5gygzHbktbhm1sMW+9f9Ealg1K8wYpDvNJbjPqXWTDwyOg3amUIKp4AAgVfZnZAZHUdue+QIfyJ3A66Clq3wWeLUsK/5dfiNXE0Ltgt28QDzlGhbEdQiVzoAy4OgPSRRZ4pAnZwWvPOQ120YL4FVJR71W65YSRdbsX7LJSv4f3UaeZ9RfPgR6dL0hBgrtcH+vHVjvk15BMqRRAMJSvBE72puQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9+vCh16QwgR2f3jYYr/YM2OczhtAWKgrplmiF9iehY=;
 b=ADRaGES70lbiCzck5iUbbWYROtuwTksBgJE7BIsP9ilqbgPPoXH2z/64mzoN960rdH4DImipAJO5cmWGyjEjlDLaTJ3HlnjwfVTq0Ru/nr5XaH7vrJm84n0VsBKq8N6ym5L02LQENzeqY6c+IDQJNcvCuTsJVhMTVdBfXL8rQ5w=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM6PR10MB2795.namprd10.prod.outlook.com (2603:10b6:5:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 17:39:07 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 17:39:07 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, jarkko@kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        stefanb@linux.ibm.com, nayna@linux.ibm.com,
        mic@linux.microsoft.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 3/4] KEYS: CA link restriction
Date:   Tue,  1 Mar 2022 12:36:50 -0500
Message-Id: <20220301173651.3435350-4-eric.snowberg@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ae1e43d-e350-4e11-05ee-08d9fbaa62bc
X-MS-TrafficTypeDiagnostic: DM6PR10MB2795:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2795E6344B7A867FB75D396987029@DM6PR10MB2795.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7lo/B+0+vaN2JtyV2cenAGccZUX/j+oYHpAOyT65WATYXEfVJDdhVexC7yzsI4Bsz0nJcGo32dwtLxuG89ya+prhWmfD2FLDNHmdOWLefEX31wyirSWtcwX5yy05fRI/GmY8uLaiPRXU5qgQok3BAsFQskky3MNBVE2GtObON7fa+DxcfO1TaW5askUC3i1eNnwPgnzEdMgsXTl6y1CEimsdXJg6vIP+HYbwGhBlJCe9vqPyQd7lf4Gbe8YJQrJT6DXBFloceGD4EZghohDDGqVKbzUQvqkJVrhFXCHXFhw0C0Lr/XDpS1arVApUyi9YUUdP+78dJCCPi6pb4VMO/qFfCfC+148JKaj+sVYyZrUptlQbpKs7ToKxLOaSXPpshHwySIylioqfG0sn248WQSAcellw+oG6sP7J9xOXQN88r33ahuAjzmBJi0hNoFwP4HsUz43ypW2fsPpkhRVkzPxrsujm6hIrNgIjtkyezQHz8GyIoXUJasUE90PZwSZkOtnUAComwka98yyebtUNE1d5x4Dxyj+04OTWRZG8s/hxhsdZ4YfFJ1vObG9uC7zmLNLGxKDKqEHBpeTUyEdIAFUaDPgbKu+NGxz66IX3FZOsJlJ5Hlnfg7LA8O4DAAxTfrvhWCd0FA65qH8R7Hn7NT3zQxdlf0xV7yOa1cTzENJHz/+mYsnuVlx8BRXP80rGQf9USldWIAWxL5HfrP8/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6512007)(6666004)(6506007)(52116002)(508600001)(2616005)(36756003)(86362001)(316002)(26005)(66946007)(4326008)(66476007)(66556008)(8676002)(186003)(44832011)(8936002)(6486002)(5660300002)(38350700002)(38100700002)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CDlKv1X4bzhCO0b6+SwHas8IiN8qcV7gRhusb9gbZoF5Ja12jBmjqkoiVMjy?=
 =?us-ascii?Q?PqI7cPtvvJY4R5X1VIQV+w6SFkD5MFp+q4a4xC3pTaUEsN1Tc1ZC0/Pc9DjV?=
 =?us-ascii?Q?qaT86OJVo+jVF49SkPnjA8YM0uBm9FQLtus5dsHm8pIxq/MVUYzdHtwSRCwO?=
 =?us-ascii?Q?GPVzrQzfZUxBsjfHffwxJV3+BpsegdUgW4eYSL2ImdwX/VA7Aa8jH0qHEfwm?=
 =?us-ascii?Q?P5CbWgm0mrZxtsa+6M2sVtY51FZN91ifzZFo5dVLboESrB5DTeCfelr1wgKR?=
 =?us-ascii?Q?WuUfWEA533SYrljAZwutshVLc+tVcVBeDIf2xBpt54IWxS3Z89pepk2corVv?=
 =?us-ascii?Q?DNs9rSDmzDEodo0+HMhXrUvxA5YQ9xsdmOtl/ZA2RuvBHAdOLApAEwGdj6Za?=
 =?us-ascii?Q?pthcp7jNs9f76pTNcXGojNHl3iVTIc4uNBO+d1C5Q3zMGrWesApMk5qkmMi+?=
 =?us-ascii?Q?jAX7Qex+q0a5MhKTqAFg1X6TmaymJFaVaTjbAz5kuuBDe7rvOH+O13ZjtAf5?=
 =?us-ascii?Q?EbTO9I8WMT4XCqdR+XywDQXFP7RV+i03YOVmL1bm7fRwaN4eNojJpwsaN6QV?=
 =?us-ascii?Q?ku9638L5p0mg1QLAW3V4t0JMVEdNMPPLzQfvgXyEAzbEEfcJ8I9aN/fhhaiJ?=
 =?us-ascii?Q?PBjX09M9WfJ7k1mmNowNNLiICXFy9SiaavprI/EOxachPFOHEJyikd9shCoF?=
 =?us-ascii?Q?ra/WxYZ3RJjaRG7ysqyExgOm5bTIVS+72BF8r5uATcHJ/1YnvKFvx+Fs9iK5?=
 =?us-ascii?Q?T+nIyILwAJ1XLu+WPRVeHNyVczPpJiQugifS59DZ8T6KiP2CPfcvV90AKiS6?=
 =?us-ascii?Q?xa2iH950yRGWRQTXV1hQoLSx3e/y1sUfP2LJK7f3FZFABmtlobmlWCAUqXzH?=
 =?us-ascii?Q?oHGoOw7V3662DTXq+bDCdS4Njv9PpImWtrwAgByeBhyoW2zhqGMyL6636vCL?=
 =?us-ascii?Q?xyAzWW9SMJLUMAOu4dURBkmYhxafV4BGtoUp105/eFZAcMST4LQigVYzc6Ux?=
 =?us-ascii?Q?l584B1C7p9JMZjtqnw4U0lfkY7G8tN/JIhbO7eb7KuczbrTbO3WQz+4/s/sQ?=
 =?us-ascii?Q?Kns+CsVzkH8jKk32JvEOfMmBoo+GsniCNFk7Asbg3pMhXCDiu3TVBNKMwHTO?=
 =?us-ascii?Q?UA9K2iGJ4lv3ULCTpzAH/L8+CQ81OjtJpqlA9XgtWfTpvYljW4oFlyCGAoRS?=
 =?us-ascii?Q?RplZSgOgSyq6q2xj25V98eg+ao1d8Y10rpAVS7oURC3/b2WLpB5MrVdxgs0N?=
 =?us-ascii?Q?jVorWlR4xTEzXL0uWQkvruyyYFn1V3CbFb9lG2FYM1uQRfVLOpy7oKBvRz2w?=
 =?us-ascii?Q?dMQ5oZaeXvvuuy5VgQ7rYgovqDNQNqP+kSpn/2nmlCMLJn7PfMCfMTf3181E?=
 =?us-ascii?Q?QtKsW1HafNQs2C0xELer+kq9+6U6m6PKm/B6fNAX5m+HMWPgxY9G0DT7ALS0?=
 =?us-ascii?Q?3v8uY2eqi2TDcPqeqj9XASC6a1zUzc50ngcBksJ4Ee0lUG9TSSEuxFQlHd6R?=
 =?us-ascii?Q?eWt7dXYwKw806QyXxBULwqK3Vm46cGjx9PeYgzNW2H1Dvb6nhxd2sC+dil3x?=
 =?us-ascii?Q?lSKLdjbyIfY/Uz476mjOJJtZRL600V8XwG8qBJ3ggrGc8xUHlDwKEwCXKFnY?=
 =?us-ascii?Q?PmuYps/msiOHhzaWK5TTelDBp7+jQ2KQcNA7Ob6KDZ6Crh64jPIS4f2osQiz?=
 =?us-ascii?Q?mCIsNg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae1e43d-e350-4e11-05ee-08d9fbaa62bc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 17:39:07.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4vRXeW/c761uY/0VfnDLQS8qi+rY5C+8bp53cmOSDqpWIK1oeWJJ8Kk300cjctvHEx3rknYXeLxwmit3gZhye+R+k54xeLnRuHZP+pdtlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010091
X-Proofpoint-GUID: yLZKYDvTu9KgyTg2Gw8bLZGwHa_8B9KM
X-Proofpoint-ORIG-GUID: yLZKYDvTu9KgyTg2Gw8bLZGwHa_8B9KM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new link restriction.  Restrict the addition of keys in a keyring
based on the key to be added being a CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/restrict.c | 43 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       | 15 +++++++++++
 2 files changed, 58 insertions(+)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 6b1ac5f5896a..49bb2ea7f609 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,49 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+/**
+ * restrict_link_by_ca - Restrict additions to a ring of CA keys
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trust_keyring: Unused.
+ *
+ * Check if the new certificate is a CA. If it is a CA, then mark the new
+ * certificate as being ok to link.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if the
+ * certificate is not a CA. -ENOPKG if the signature uses unsupported
+ * crypto, or some other error if there is a matching certificate but
+ * the signature check cannot be performed.
+ */
+int restrict_link_by_ca(struct key *dest_keyring,
+			const struct key_type *type,
+			const union key_payload *payload,
+			struct key *trust_keyring)
+{
+	const struct public_key_signature *sig;
+	const struct public_key *pkey;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
+
+	if (!sig->auth_ids[0] && !sig->auth_ids[1])
+		return -ENOKEY;
+
+	pkey = payload->data[asym_crypto];
+	if (!pkey)
+		return -ENOPKG;
+
+	if (!pkey->key_is_ca)
+		return -ENOKEY;
+
+	return public_key_verify_signature(pkey, sig);
+}
+
 static bool match_either_id(const struct asymmetric_key_id **pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 0521241764b7..5eadb182a400 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -72,6 +72,21 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_KEY_TYPE)
+extern int restrict_link_by_ca(struct key *dest_keyring,
+			       const struct key_type *type,
+			       const union key_payload *payload,
+			       struct key *trust_keyring);
+#else
+static inline int restrict_link_by_ca(struct key *dest_keyring,
+				      const struct key_type *type,
+				      const union key_payload *payload,
+				      struct key *trust_keyring)
+{
+	return 0;
+}
+#endif
+
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
 				struct kernel_pkey_query *);
 
-- 
2.27.0

