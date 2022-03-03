Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB524CC2B7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiCCQ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiCCQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:28:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065B682D2B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:28:13 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223EuRTV009253;
        Thu, 3 Mar 2022 16:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dAHduroJWRmJvbEGqqRIGWm4ONUR+9W7wjI+BQNzhUg=;
 b=k5bcoo3/LV4HajoJW/BAWtYLohufuo1Y/tlaETKBvRGZggWef4qYUk0mOV8BxMyPjmDL
 uEIT2pzZgObjbYXyWi+Iwvd02zJfSMQ5isAob1SW3YilcsWJgzLGuU4OmYDCct5DiUmn
 XB3ccgWGQGZGYOXrnbDBcIfY0BTbEW/nBh7DA5dkcxj+p/JgkZS8LEeuIyuiAu9WLA0F
 zNPiNkMgKmjuKRAFaEztoO9MmM150Gr1ManpsYDcfZIJF8ae6XkG0Ux+xKP7rh8gEnh2
 y+7nUTEijJ6JpOIVrwI7wnyaYIiDmG7Ofnnq8Rz7fvxjvS4NT/oFVg2aJ1nbXS00QEM7 TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9fwxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223GHOxZ084121;
        Thu, 3 Mar 2022 16:27:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3efa8jf0y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtiMkHOQUd5ql7N4R6Q/QrInbjI3sghsdeWGvZ0uxHsbCbFW7R82dGiW6fD+xxkUFPTUPhOjJzItVSRRoAhnj5x8lzbNryLR0BxrIOKR2LUPZPRtxvoJz2Tt8/Goy7UWnNMxkBK28I+MRRltDXctN1UYTMQYiL2UlBssXXk4ARBvvcvoL6KykbAKj0fZFI51OtALkKGwT/WrqT+N+3jO1NfgGC5y1Il3zl9AqoEiuX+/uUUr0BZYrxQgSupxmyt8JXIShEYWbosr3Z7ZITmt1lG01UQWnjMxfAd5G35wmOQgRnHXkdjjuB09joEYcUA1Ftsk/tlPSpukNvambn9e0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAHduroJWRmJvbEGqqRIGWm4ONUR+9W7wjI+BQNzhUg=;
 b=XRmKF/OuEe8SS7W/EjlTUjYajN8Qy3W8uEyALQiKu4umqyjmtyrNcmTufFX8tsO+78lUDqmV0Nng9xn0HX9HWNgWcfRirBoUTCb+dVQ7WdLVCu5bVvz5v8xQyC0qV/88pJmTo+Xx1NiWKXVvW0DXW85k0U0h3WdgQSr7vZlow/Mww4oTmGlkAwfxp0TxN3+mqExf6p5Cv3fE8hpNr82SWO49MzR0V9n/OwWNzQ23kYDtvKkUmLIpaqmA3olZeE9NdKsAd6DE0QD2JoVM93RddF3a1NiR/MDPLL+WAKUexyoB1zDXcO8rcHZ3R+i5WS5T9FXXfQhhhLOU8rQf2gpqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAHduroJWRmJvbEGqqRIGWm4ONUR+9W7wjI+BQNzhUg=;
 b=mwygbd2Abd95g85YVhbKz9mvetuC+Gth8nFe7aXrHH7G1MJ6PtwGu/tsNjTgH67Swc0m2DXOURJdVpnonh3gY2DtB6w42PECBDg3kqYtQEHRMI97peK673E81NYfPOtg+Brxpx7JpaJA13TpoUurkgQFbBadd6R99PfCkZioMLI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:27:48 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:27:48 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v5 3/8] crash: prototype change for crash_prepare_elf64_headers
Date:   Thu,  3 Mar 2022 11:27:20 -0500
Message-Id: <20220303162725.49640-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220303162725.49640-1-eric.devolder@oracle.com>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff990a19-1fce-4bd3-47e9-08d9fd32c15a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4704D428A4A5E1CDB255975C97049@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2lhpsfcUMtmnhNt7Cgv3KkVyeTtdw+3+1dSaGRAHCbP+lAf4S8nmLtrIR5/HMtzdiZvHhfJBDIRWuWZyUdrg6dqq7lXw+xyksW5YBEe5YcI5Ty9MfxvoyBmrBHdY3LqRo+sEp/FD/c3pWj5DX9xKFJj8ogL+PkBTc4dCpPsZDlZa2piDrypCutbp36fjHM1iLOFlIl8iLw80L442r1bIuJDOwB5EO/GkRr25SCGa+jPgfsB/BxDA5EtQ+dAbSismZuhkJscQndcNbaGR5mUvWu4D2eohROCWaty2vrPQ9D/X8eRU3NVBilyvyW4d/OMbMZAR3ckW6MLsnIW6vCXMwpQqrrxy0NPedegMgvozTuYT0EaWetSA6y6RxwqSb4/38lGmR1FqJbCTVM4fAEWPsqLFrHmdfTajxccQlK9ja3FxH5jzRPT4PMOwE1qGs4b5KOq5bJGzdU+M8h8sW1ZUbfHM6gXiP2EDsVYijARJtw0m8RnvKqeeQlaoWxGXbJWZTH9Mmc6d277/wjMePhFYSq9MkNvkjYTQRErI04nqbWNjtbmlpG8I8TziqtVWS3EvO7FE6qf6RLx/H/8adp0/F+KWRaombIzlX7+qAF6ZXWzqrHtk868cFr24ukLzvVeq10WsahWzPfaNHKGIkwk3w+VcWojJIXZQjglf2D2JheX14h5qa8orr8D7+ESjelCfTFvR2lYwmcwpNA4zL+nCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(38100700002)(38350700002)(8936002)(1076003)(26005)(186003)(107886003)(2616005)(6506007)(52116002)(6666004)(6486002)(6512007)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(83380400001)(2906002)(86362001)(36756003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eIrL4ipovvwNptjDbWQSZRFf+M/6hs34k5M2fYfKgu7Wp6wn8WsBEE3iAiaK?=
 =?us-ascii?Q?eeslqpiOsdaJfV+yyywvpD9Bf6y0FIUFtzF9h1sDMRoIJWarXdIyfMDvfoFc?=
 =?us-ascii?Q?bEBKnBp/VjMBIVxK97ntf35RnJy4RPBJ6xlAY7+8Due6B2f2bi+g+mk0QwAY?=
 =?us-ascii?Q?M3w/GqNZQ/Dn0w4H/WtrZVZKydEg18TLRySTMON0UlS2wnCUBkfeEo+RKQzQ?=
 =?us-ascii?Q?5qrHUd5LmVyTfdeWT9nR3dTvcA6GNL+QkSPTdV3CQy0KHRHLoHwQcz/MlJkQ?=
 =?us-ascii?Q?YPnFaj4Ky0sOHzv9T+edX3aLPIj5rMp7n2K3zyhXoAKdZIdkj801gFdkK2/i?=
 =?us-ascii?Q?PyITBhiGa6piYeQ8i83uEhqdbvffhylr7xYaiFtw9LGswQFr6p2x6AI5cEE4?=
 =?us-ascii?Q?MOWmNwSYiLkoSXq20jNbV3FSNMmqybopQMBBUm6Vq+sD8yAiI0gVuudhAe5D?=
 =?us-ascii?Q?O0TJSooLwuIUywPgm+FuyHrDof70W0m8HS13ThLaEQX1R/GebIzGiBCjBTFl?=
 =?us-ascii?Q?FiErWfdH3wjiL4Wmmx33EFm+CEqQoGRK2G3110VyXTt8FNNZjFW7HYXEETzs?=
 =?us-ascii?Q?RstKHmNa2JmVOeItQcFkdyFxY8RjsKVnRzeO3qcBqDJ78iCePMZVydPMmroJ?=
 =?us-ascii?Q?10tvFbKHAQGBGpm9JiPu4PnBnKjoydfnEm5pgME68g9Xdaqr3ARMow435Jo/?=
 =?us-ascii?Q?8GmNPAhpsSD6Oplim1SD6cJYdRQ+Z2WtbDsDl51U5dzdWCVe4JO1OIXiiqHR?=
 =?us-ascii?Q?5BbFw4WpsDIRKmk8xHRKvOEp3tQsnleZUXqYZdR4QkF5JNgdl9soqsLhuBjj?=
 =?us-ascii?Q?7bkAgQqVog6LHqvUW+FidOr9bocvmSM49H8CzsnZCiMfZaOYRq4eiPtwDiK7?=
 =?us-ascii?Q?RXqCynRLjD9QqBJ+jyBoZQBpYTIKZRXziMlEC8clC5WLYXIFqqTJVbFn4COZ?=
 =?us-ascii?Q?mZVvOpaR0j7tx2aQSLqpkuETfWSv6hO6s7Wy0rqDTuVqAd8d1Hs4q6eNWaeL?=
 =?us-ascii?Q?yk1Gl/iYWmJNbndfH7jRcWHRNGydmftAeDCWc2Sjr6tQwvxX7pXX114p+RQY?=
 =?us-ascii?Q?MzDbgzLsf/3al3JUD0GbxOW5Krr2HOcguq16P1TWbD/8+7EKCTcfc0GW5qgp?=
 =?us-ascii?Q?W8Jq2HvXUgACDtWnwvzL9E32VGT0MyMY2qV6Ht3xGENItI0uvrZLZWU9vix5?=
 =?us-ascii?Q?tUMiDQ18FzLVtB5UZe/RL+8aoDMFNbCDloaG58fb3/VKQDgsxRzmZ6DytET8?=
 =?us-ascii?Q?s56NYVpVBbZPnIPiDLjiyOmOwl0fGQsy1VEuXF936xYRVOAD8FyZE4YkK3U1?=
 =?us-ascii?Q?urtkq/+o7WmYrTLj5Gt8qxeQQJLu7+kVqfpnxqd+nTl2jjxGnzQMJ+phyM8/?=
 =?us-ascii?Q?s7tUtSUACjJ8THNbKsGd9MvuhoPT2SrKFn9CLVteT6xveOW1TK9RzWK6//L2?=
 =?us-ascii?Q?ODW5HIDKxx+8uryG+ekzxt5I/fUcsqBS6+6H5hRhz7qDLUoNOTmfMPmrPKUT?=
 =?us-ascii?Q?GTNECNg78Va295OPwKN2stjL9W4MX3M1s863goYiYfgbz3AlZ7ZF/7gmLw9+?=
 =?us-ascii?Q?s2C4X6kqkri8Kn391UVAxVt6D0inA3HkoI994qxXQ9bUYQT5URVX20L683jM?=
 =?us-ascii?Q?UxtZHn98RC1ksFvvume/le8mGzxgjxum26zEoshxcilTdwCG7lVJE1c8wcY7?=
 =?us-ascii?Q?PnPhUA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff990a19-1fce-4bd3-47e9-08d9fd32c15a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:27:48.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgsPH31bMDe6TY8mvt9e9QiKNBosUeuj4mh7vtbosXabmAJr7iUNhNKzEuZVl6RdXYQ+5evkI1+HBjY4rOK51Y7uzlqAwT3SNt5oWjSLx1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030079
X-Proofpoint-GUID: cmvkYO9S-ydGadcsrFjkryA7LKjb2fad
X-Proofpoint-ORIG-GUID: cmvkYO9S-ydGadcsrFjkryA7LKjb2fad
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers().

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/x86/kernel/crash.c                | 3 ++-
 include/linux/kexec.h                  | 5 +++--
 kernel/kexec_file.c                    | 4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 59c648d51848..7dbafb42ecf2 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -67,7 +67,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 
 	if (!ret)
-		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret =  crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 	kfree(cmem);
 	return ret;
@@ -96,7 +96,7 @@ int load_other_segments(struct kimage *image,
 
 	/* load elf core header */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out_err;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index b4981b651d9a..07da6bf1cf24 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -797,7 +797,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9db41cce8d97 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem,
+				IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..d7b59248441b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -221,8 +221,9 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+	struct crash_mem *mem, int kernel_map,
+	void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..801d0d0a5012 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1260,8 +1260,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.27.0

