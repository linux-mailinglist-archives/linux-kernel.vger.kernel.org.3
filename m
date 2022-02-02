Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43A44A6C40
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiBBHUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:20:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10116 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233658AbiBBHUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:20:39 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2126XdZ5004746;
        Wed, 2 Feb 2022 07:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=SpgDj4ge/A/0uEBxDJCGoSPy/ZPRUyhaj2QYzsN/mEk=;
 b=NRHSfULot30rtANkG6dpbeBCil/LV8haK6fBAdP+p72OUGa7CpOR9+XajBtmbnijjZ7N
 lJRptzsPswlc5JvR/bHIADoWk2V3nc1g92ulkPRtbXUywHXaNmApewGZ7N0zHL/DmI/k
 v35HZbTDnA/fWSgxh1CbkojSDaWm6M8ocVoUyeyg8kE2F0SNPMS6NWv3QvfDt1s1oD3j
 Xd2qO5g1d6hcw1JAQ9vI4hMv94E9NbAbiVnyHWU3eFk3gkUvombV/+YJ9ZtSjwlzNkXU
 OH+BWUBkeRMlPh78E2qVQDd+kWZoRR6kKRt9bfQTkcEMn1RuEBoPM72RRuBt8tubMsek jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac568w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 07:20:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2127FQqb176741;
        Wed, 2 Feb 2022 07:20:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 3dvtq1yffn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 07:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GutCLZNjo5gS/K7y0gtH9hYjNvPr5Mp7/twfHqw0CTV/x/RD/UghtTSuQKkBSV0Hhr9VQj/zxSG32Bsarb/s0d3PxbNdJ2R3hgKhva5Bkw1/8HD5PdRtH9CZE6wp0PD1AhLDwMz0Yz4k6cGyzAj2pUtNV4Ppwq8pJi/oOeo1iv0HrC4ugOUwU/pS/62I+QAM/i9EWazBlUdb2VrvrF0vSdcUsmyRubhIXqXzKuTfoe43/kjEpt+lWWiHf35W4ayXy6lDxLNsUI0i0nMCbppQLn18dHcRxEa4GRZvi7ePtE7SaSN9A6CSW7d4uzTXL27BrljM8YLxr133RX9VO2B+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpgDj4ge/A/0uEBxDJCGoSPy/ZPRUyhaj2QYzsN/mEk=;
 b=PhzYwe5xCrk2ozj7f5nfMjW8lZgsIJtzUVW7tGvw0UwViyqgl3dWI9cD4eLyHJyur+4BJI7LIDZHqYVye8ds5r0fQqFlpYAEAviJAqNP3pNgeGauTsH4E2wPzc8/F4pC7IJFv7Dc3gPx1Psm9F1HpX0/9sI8mTcUhMM88BX2vaBC//3v+gllxX2IxMFXBxJK+qmBtNWdQhlm2uSTuell2Octqkbr9APp2qo/NEJKGQTj3gIVKzum7hDET1kyt2w//E0xw5KjcsePLkxTi+mNLlau8H6REwUU+e7GRSE52ogviq7qK6wNuKhoyLd+mDBAedlCOUQYHPYUExo97G6lOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpgDj4ge/A/0uEBxDJCGoSPy/ZPRUyhaj2QYzsN/mEk=;
 b=ckQdBxGRm5EJN4R9b8c5kZOm8I/QQVbHB/QhKg2FpTsDiy9N/+CXzrZisjKuY7BAUpD9WaiIDuYcYrvPQwSCs3CFtrlTE8kjsCWD1KvGqV0Igc75dVknIpJ/XvYlhbzBfGTRnqnYwVvE1CS/bV63bbZ65jZwAzbIFAmfMmCQwX0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 DM6PR10MB3274.namprd10.prod.outlook.com (20.179.160.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.20; Wed, 2 Feb 2022 07:20:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 07:20:27 +0000
Date:   Wed, 2 Feb 2022 10:20:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>,
        Mitchell Tasman <tasman@leaflabs.com>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: greybus: fix an error handling bug in gb_svc_hello()
Message-ID: <20220202072016.GA6748@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40fa44e4-527e-482b-3b0f-08d9e61c7c44
X-MS-TrafficTypeDiagnostic: DM6PR10MB3274:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB327448A4C116BC8EC69A91388E279@DM6PR10MB3274.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fE1Kbp9yU39uYBoWnXBv/GLrEczY5S5bZTz9PdgE6K8IMwNPyN0XEwG2TvPj95Fm+xszL9QURe3eZNkoL12GdzU3z74b7YtxTgqjknT5T1Wjih7N6SyG2VYw4/DMcCfo4evJ1NLZ6yVLxmzST+j08I7hXaUuzX/cc0n0LKGVtSqR50ZphPdF7NGVn97qgZ5QvrBoXkUW5+mOolbH3Vp/spClpLAAxRvR9CZnltwotTOgJllT3AthE2UPeZEzDLsacZ4rY3Rf7eKDMnBNo/KLeTd6xah/0lZvU48XGOB3hoZ13OrChBxtpkz8JELfEx82N7eV9Za3gcIz/0ugTIEpY4UndMYbRcp69lO0eXSUXikRMba3icwaY4yi56lV5hNZt+urmJKoBfjV31dZ2AxqgdzMCgenr9WYQeXSxHmEm2lGHlRpw3cniUmJ4dpqUNgdYIP8dYnAZeQrr+nnVrcBdjQr8pUHnLxN5hA1GT00Xv8tEXPfK3LlTJgLJp6yYGTYTX7+P0+2qN+OHV/Q0zX2uhLIjHZH2Kffi8yWRR3HPj3qVmP+E4uRjnKIacvlUiXNRJhze2J+s4fYf9GtJX8g3e9UobSZvhm3fdeOaZAhQeAQMnk7h/0nmLX4RXAul6KOIkjWtgWQIGiyd+73kG+QO3/9CiySRUQhwhmcH9ap0w52ZYevWeVrUmide+sf6OH/wCTIxvwhJBBaqiAZhvN0Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(4744005)(83380400001)(33716001)(33656002)(186003)(1076003)(26005)(6486002)(66556008)(38350700002)(54906003)(86362001)(4326008)(44832011)(38100700002)(52116002)(6506007)(66946007)(8936002)(6666004)(66476007)(8676002)(9686003)(6512007)(316002)(508600001)(110136005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HnB2WUjJlTomFsQx8OJ1LaO0v970poJ4lhHLsFK6VXx7EDrIM3xz90vJ2Ute?=
 =?us-ascii?Q?gOeRf4DEPsqRTf0yDH86AufxsWg6DyaiaZ5yL1MkEKIDKqoU57cgDZcszoYN?=
 =?us-ascii?Q?4FFrBIz7fwNqyAmJ6GuTadX7J7tz2wlo6mZ5uPicD+AIEV6H74LtxgBSgNwr?=
 =?us-ascii?Q?ocJMQ/ZAz3qox+jK0nnOenmNyU1YAHwuF1h0bS6U/OMINqX8td5xQSrU5DrM?=
 =?us-ascii?Q?2kQNKemEYcLhHDorBW9VCGZJz3rwulYsxErZ23WZwwonbhJHcuqyzUfe/qkg?=
 =?us-ascii?Q?6gljhtqcuLAGlpMfoBNz4ui7ceMPOm7G4162upw9EX9I5CApLBKN+mOb05V+?=
 =?us-ascii?Q?sOa951AWG5slYFUJlz/IXN/majanvwEiwdkBgk+pnV+hMfKoO53QP5syJRW5?=
 =?us-ascii?Q?bdox+c/WhxL9KvWScGf8cLLtdwINjcRB75FKkdAqyA4XQGq6lJzwBlgKI7Rq?=
 =?us-ascii?Q?tdlYcYuHGh7Ha0NV+ep67nYdKjbYGPhlJ9T0+oHBWYzeJ4TSaVH3FbWLn9WP?=
 =?us-ascii?Q?zErOaD4XBqP3FHsKtH0npUdputuKmLsYTznYJr1we6q9IugSJlt7mGCJyPtn?=
 =?us-ascii?Q?vc/deaOGeNsMgz7kQdkwIN+n2u/ZQQ48H2Txg7h2Ah5VYFbXBKFXhHXPmO35?=
 =?us-ascii?Q?U1VqF3YV9pEdyAku7IOBjQS46Jei5csiIqZlqvCYA+y/oeVptwLqz1n717Aq?=
 =?us-ascii?Q?bOQG7Ac3FqWzfYHl1z9saGhy7Q+u6gJxc6DGbV13/EsE6mLkBSHJ79SVgi8d?=
 =?us-ascii?Q?rPNfd/foBn2tJIDaVBLTqMsmrQI6svDM/iS2+178Ge+3fdnYALX+CLDoqsHp?=
 =?us-ascii?Q?6p5Z1BCMf/fOcwREwcGXARwUurOubmmST8ZP9KsKXVqFZG8h6JII6RzguHNM?=
 =?us-ascii?Q?xYlRXE5VEFNykUbU0dXLOzg0zKgnzIXZDwDMqsTgQaMpF6824k0NMhb+ljnY?=
 =?us-ascii?Q?b9Sl8hll4AbXXId88y81Rls1PzlZwzpf7BoQEqyikPfxriGw5O3cdHjj9yKW?=
 =?us-ascii?Q?6ckUpUUvEXuGOp/+8v20hueQpQ0wc8hPzBtIED1D5KfchWMJVb5Wj8L6cdoK?=
 =?us-ascii?Q?2SR8jsQzR7mpTL9RL6ZbM2+52pRiBVkQU9mbcPQOE9ZufzAm3C7we2e6Bk9D?=
 =?us-ascii?Q?04eqwaEMaEOvmUEqSU/vsyY4iW3f565SEDT5WSCg6jtJurOghg8SN4kvU7eV?=
 =?us-ascii?Q?GzmcD+fJnSzMfOpmS/iz6BvFLYPMjdeU5whTtDo0v20PWnCtn57QB+F0hDrp?=
 =?us-ascii?Q?wkXKCZCsGb650B1sq4mg4+PUXkR6WC29OMyFVVErrpThz3P1waHnVEzDt8m9?=
 =?us-ascii?Q?/3mr3zbwVCTt9SMOWzOaZL4py7ULdJorYke9heKroVR8ezZyM10izQtAG5IE?=
 =?us-ascii?Q?N/eNfbtpj3RijST0HBBw1oToojOkc52JyFvucaxxNSN9smDisbWrcbw69hkt?=
 =?us-ascii?Q?A8PJvW50RBj1/RuLWKJEYKgjIHedZ/3+Y8VuFY/W1n7deumZ6XUVUJgHV70q?=
 =?us-ascii?Q?wTqXOK1KlHOxhJJhUqirIDgiT5C9kes7dqMqbJVg3wwjKmWlaae2JtJ9dnWn?=
 =?us-ascii?Q?5XVlVIySLUXneOE16F87LdUkqsnA1k3ZTv9EeTmRljBZASfFhnJcfSainsSo?=
 =?us-ascii?Q?Qh5s6DyhWadIzueByRtyW+Zi3ebfOOer+eTRGYPXj0u3o6TajTScAEIPMOYA?=
 =?us-ascii?Q?XjMsZZo7QQNSJuUfrhpyGfOrRS8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fa44e4-527e-482b-3b0f-08d9e61c7c44
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 07:20:27.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCWPvtEb4eKHRd3p6c/PolRqPVCyjJtydIjeuHZsiaDzRASCfG19i6kL0dTxHLeYOlVCSM1aRGAd+a0EO62thB0WHNPIiDMb/ZoBGHqhZ4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3274
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020036
X-Proofpoint-GUID: YR-OZVFllx36OzNRBSZg7K3AOOozY1VK
X-Proofpoint-ORIG-GUID: YR-OZVFllx36OzNRBSZg7K3AOOozY1VK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup if gb_svc_queue_deferred_request() fails.

Fixes: ee2f2074fdb2 ("greybus: svc: reconfig APBridgeA-Switch link to handle required load")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  Not tested.

 drivers/greybus/svc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index ce7740ef449b..b19651048081 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -866,8 +866,14 @@ static int gb_svc_hello(struct gb_operation *op)
 
 	gb_svc_debugfs_init(svc);
 
-	return gb_svc_queue_deferred_request(op);
+	ret = gb_svc_queue_deferred_request(op);
+	if (ret)
+		goto remove_debugfs;
+
+	return 0;
 
+remove_debugfs:
+	gb_svc_debugfs_exit(svc);
 err_unregister_device:
 	gb_svc_watchdog_destroy(svc);
 	device_del(&svc->dev);
-- 
2.20.1

