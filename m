Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE155119C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiD0N23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiD0N2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:28:19 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1309838BE3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:25:08 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RCPLrY017559;
        Wed, 27 Apr 2022 13:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=WuLyOIPpkpihnzDBH0OG6NoDN6nuCh6e8kzjSLjAWAQ=;
 b=AeJEZ1cFYd8CHHOZ8gsvQimcXNliZN0o7q1pZmauxPlCwOVfasCcMauyyv2K9mBjO5mb
 hsUxbgXy5Sgaug0rcWadrvuV4Zx3IvXj0RnLzTL7KiLJ2e4ezJ7IfQmnc67ATUKEIFNg
 AC6Nm0JkqTDuX6YcntcV1WlzjjNz8dWUYtiJr+/3ceoBlfaEo0Q7Zbcybaymj8HDb+Uo
 7iB/QnhyPJ60FiVcmtOj0eSQJHjgfCkVGbRfiswS9xQ/WiLzbxGDVQ+VWEC0E//hPOaE
 Ix737JdkSoEGAlrBlUgmZtBQSTl9PIUJYaVrvyyptRaYL6vHsZRC4vh+JPaDexx/glKh jA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fprtcrgym-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 13:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7KwdJ7gMSgWlY1lVZqucl65ldPBYt4DYwnpF7QV3OtKGxlRB80TnfZosljM+BTWf+QCl9t/DqwWX3DBsUbF296JvP1dexY2oOkqLzYMad2IMdFJRaTxmchMKxJRppFr8JRhX2QPm19w0REmsGkH3VXAAgmljjosJmZyg9VYVxUMpkTgBzCbtawGy0OhkCQSPcPqf8IPdJh/sMs5DAaBMDGPlJAFc6UTslok0yoNRVODAzgpvW/lAvuXLZrN2kUrlAai229qitmsoio9dFUA4moJqmczKV8rU1CtzVzj31rqZ72KiwBw/y9B0oF5ZMBH8oNMjXAs4JieQwQpOH3RSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuLyOIPpkpihnzDBH0OG6NoDN6nuCh6e8kzjSLjAWAQ=;
 b=BTYjMgjIIGULlHNUvTc8Uohbl8LgcSsi1HMqPuglsxW5XIwu15Us3sDRCVHTjpEHP4kbejjdt3YTj2NWNaAah7RCEcp2fZW03/Gk1gQtR+HZrbyd4/GqnEagchYTK5l0YjtB41/XwzebPUZwlMeE40iPcE8TIR3yM12/Aege/tFcmI1L7B6AW2Fh6D7zSp3hZ8PpE8pNx4Vees90NTuGrbg4jWEIc45+oJKBJWxqE0I18slTV7cDyCAO/Rh0D4cdAEyZnSouV/NX7ej1ppHIuEKb8P3fy1SyXUqoodr7yIWiDqeA5LGQCeSz12ARa3mX94kNqBFm1uYfY20iOK8HUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BN8PR11MB3650.namprd11.prod.outlook.com (2603:10b6:408:8f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 13:24:57 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 13:24:57 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Phillip Potter <phil@philpotter.co.uk>
Subject: [PATCH 1/3] cdrom: remove the unused driver specific disc change ioctl
Date:   Wed, 27 Apr 2022 09:24:33 -0400
Message-Id: <20220427132436.12795-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220427132436.12795-1-paul.gortmaker@windriver.com>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09bcedba-6abb-4dfc-d3cf-08da28515305
X-MS-TrafficTypeDiagnostic: BN8PR11MB3650:EE_
X-Microsoft-Antispam-PRVS: <BN8PR11MB365077E5025ABEEC8DD8979E83FA9@BN8PR11MB3650.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETv0yq+dJMd+a5GkW7NgK3lcagzCN8tbalXMo74cOst4kYd2HP3KzkdJW29ERM4jeCh2GJIvsyOQMWjfu5Dy1hVN43LMgn4PmqHO/HkIeLK1ic2+OubX3rRp9HpbB+NLQXJcaDTYQEMxYhfR0fO9qHaSWomc1CQd/ATzp/WA/Bg/hMunfU+UuaXiiWY0v94abOxjMB0DKnH0h2uyvilxGtZTh0OIFYztKZEVuixO3iBYQZNJB9utlXBleYhONQe7e+QpuMkuTjX5DeSlQA9F/Mo5MIN+NE+vsqkHj/7OmV6xtCQKF0SSEcGbQQ7FyA7De4JE/IRg/IuK7SSBgxoOPGEwD0FXowhcJoOsQruDqAbvDqSvtKLwz7BbmQKZ17E6mX0FyM0Blx0QafUJZj4H4APDnnXXMBYFlGvmF+lJiov6DSOfshYaYcCHhUVYfnX+z+Wd57jJqLmfje8XnXV8kSRlQXVuBKg02/QdRkIuHHocT8fvOC/qVx/hHOovHhfEAjGfbzCunKCQuTln81ci4YDq5mvxe5hUf+T7uJl/H/oDyuLCQDdE0w5KpWiNmxu1WiESHySSbrvcVI+9Oy3YzQFBplkXdKX8cZCfHhllH/goKlG25rExZlaDoKpedfo2Ol9kt2mgBcU85rV/f1i1qw2DztgKNC6ro57AYhdLZ0XDXGpiNINDdHgvQwnaMDmrl8hNdlfgiWna3cVTsgEQAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(1076003)(186003)(83380400001)(5660300002)(8936002)(4326008)(8676002)(36756003)(44832011)(2906002)(54906003)(6512007)(6486002)(52116002)(6666004)(6506007)(66476007)(66946007)(26005)(2616005)(66556008)(508600001)(6916009)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2BvUqbwLz2HBP4pijFzGAqenyti69xHbRMsLbzXRFUYci5STkazuYKpUku8N?=
 =?us-ascii?Q?jRDxZDst+8idBTWl0Ka5SJBtfO2A1aHI2KJm4fq24uN2L6nlo51Q0w4zBPx9?=
 =?us-ascii?Q?A2MQxSht96Sl8nMSg9Lt1xPmIZPsHv+yfSEFa/s/zEN/l8d26eipI8wiJAnO?=
 =?us-ascii?Q?nCnoMmCsFPUEEJ7sv3go3xYZdXze9zC6RbqFsa94H7275GYz8AZ+XlbC7qey?=
 =?us-ascii?Q?j4Bpbr7tCmh13krVm7SzcJVukq6N3ieCJG1aiR5DoyQXjz62DpcSuhLi39Re?=
 =?us-ascii?Q?jKB6PWB+vmgajADmT4IeF8Hj1MmVkLwLryU09J1pJAkvhOgE3SbV31PbeLdR?=
 =?us-ascii?Q?N2NXr1qiFprUEzV+1tLnjGTtKZ7AgEhh26p7hQj3w4LwuTbvYJLiyNh1maFL?=
 =?us-ascii?Q?9JCaBw+sJSIKaJzR8M20CSXr6parmyBcC4iIfBnc+cRZXlppLEFeIb0TutoF?=
 =?us-ascii?Q?SO/GYxTsW/s5Qo7g+lkNj0l0sUdBFKM/eMiwYMU8oDhk3o8V/T12i1a2ykof?=
 =?us-ascii?Q?QDBktezgydSBIl8cKM3sbrUFeN0BlGn4JKOixx+x/DWhWYqfkYKgptuULgWo?=
 =?us-ascii?Q?ugtx3IMvkjqc8oddsUP+EHbjhZb8IVIm7hV6axbDUXud1ZAkkz7Ikc0ckEc9?=
 =?us-ascii?Q?tYYfJGYC3SJT/4lMKrqxDrmD9oe3QEcsjpoxMe6D1OoxS7a4jTUl93ZEyMVf?=
 =?us-ascii?Q?lgQzbqw3uQkOoLCzu7Ac23it+TN7f2oL4/nKbuv6NFQBytWf1kVOpSGo7y+r?=
 =?us-ascii?Q?plspgZ4u3B3ITgTm3KgMXHaWQWjcRYUG5jLH6+JYIZ/g1rbWdvADvAzWxqSK?=
 =?us-ascii?Q?eXTf/lJBBpaxWtjDcDg+Q2jWbfR3nvQ6PjIkv2i6xqWYtvHFa55R+vCNt7sQ?=
 =?us-ascii?Q?XsKI+D/U4uWhdtsNkIntd1jkcp+hbGHn8uhlc5HQPhqmFUiANeGdJPzIbnKG?=
 =?us-ascii?Q?yTr86q/itvOzFq/+8lKVvHtRe4uD+SUWf6GBFlMAFRe3SjYL+JCfMTdy0nKF?=
 =?us-ascii?Q?Usj8T54jbe8Q+L5hR77s9wr5+0MyL7PasBgjMm1MSB1aAwaJvVfS2/r9tlk2?=
 =?us-ascii?Q?rbVszcBukrNmOiPUkR0+HhyWnkv+GAhPLGyVGmVlTI0/+Ua9drcqxUWmpRKa?=
 =?us-ascii?Q?M7ktkzQ3dxWr91D18p/BNVWe7j+nd+r4gX5d8U+tCjvLjMa7v4RB7bVtsImS?=
 =?us-ascii?Q?a0ag/4xJBS8ezv54ihtNb71KqkrfpJMOYw1Cu6tWixqJwwqoaWxpworyFNRF?=
 =?us-ascii?Q?T9023TTQXhGZ5k7FbzQaWpxGfctke0ELrdyHvbKL6tHRbWMDRDZ73hdGYsdH?=
 =?us-ascii?Q?9+K7du5yCXHPAQJfkEfYgcqECB8bDaUhefxA5qu1xdfF6oP6PW8khveWsgoF?=
 =?us-ascii?Q?q2OY57g+dGLLFldw3tu9xouFLTbNArazp8wVV92S7KEXdfu3UFCTol1pOznJ?=
 =?us-ascii?Q?GorEDlpoWFFvYHZbuWzEr9DwZJ6lfuB4jRmHgu/GuwjSkumTQHZCAI0b+5uw?=
 =?us-ascii?Q?0pp/Dgdc5L9BJ3OCGmWUglWLI7bZNHSL+SPlHm+EhYk6ctlgD7JU8+PRh011?=
 =?us-ascii?Q?I78zK5ln1vNDb5PEgDyWwFMh086Pk7C5+k42Uk/WkytwIOs85GsU0cl9KmFF?=
 =?us-ascii?Q?Dtk+zvRfcWUi8+4ss3iXf/qBOysxZyG24v00yV41L9LYHNOnUHJJv4i0QMF5?=
 =?us-ascii?Q?WjYDQfgbZzS0AZMg7R49cJ0KkVmCDb9o6478AjBq8l6sb+vLSAkXk0w2llCk?=
 =?us-ascii?Q?N79mCl3VhXrlkgVZSGP3M4qNh4ZRPsQ=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bcedba-6abb-4dfc-d3cf-08da28515305
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:24:57.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wi0414Yu7e+zMeHPB915DYT0bAjqoxn4XYSMBQGyCsmt7R58Y6iBibLhjh/Is7sHdi0EbbBT7atVnR6Tnw9M5A3rrH1Poe4la+3BjbbFYnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3650
X-Proofpoint-GUID: tFCS8OKSGG-cMLFEwKn9qODKKfHacSMa
X-Proofpoint-ORIG-GUID: tFCS8OKSGG-cMLFEwKn9qODKKfHacSMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=693 mlxscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was only used by the ide-cd driver, which went away in
commit b7fb14d3ac63 ("ide: remove the legacy ide driver")
so we might as well take advantage of that and get rid of
this hook as well.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/cdrom/cdrom-standard.rst | 10 ----------
 drivers/cdrom/cdrom.c                  |  8 --------
 include/linux/cdrom.h                  |  1 -
 3 files changed, 19 deletions(-)

diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index 52ea7b6b2fe8..7964fe134277 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -218,7 +218,6 @@ current *struct* is::
 		int (*tray_move)(struct cdrom_device_info *, int);
 		int (*lock_door)(struct cdrom_device_info *, int);
 		int (*select_speed)(struct cdrom_device_info *, int);
-		int (*select_disc)(struct cdrom_device_info *, int);
 		int (*get_last_session) (struct cdrom_device_info *,
 					 struct cdrom_multisession *);
 		int (*get_mcn)(struct cdrom_device_info *, struct cdrom_mcn *);
@@ -419,15 +418,6 @@ this `auto-selection` capability, the decision should be made on the
 current disc loaded and the return value should be positive. A negative
 return value indicates an error.
 
-::
-
-	int select_disc(struct cdrom_device_info *cdi, int number)
-
-If the drive can store multiple discs (a juke-box) this function
-will perform disc selection. It should return the number of the
-selected disc on success, a negative value on error. Currently, only
-the ide-cd driver supports this functionality.
-
 ::
 
 	int get_last_session(struct cdrom_device_info *cdi,
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 2dc9da683a13..0a858bfea849 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2443,14 +2443,6 @@ static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
 			return -EINVAL;
 	}
 
-	/*
-	 * ->select_disc is a hook to allow a driver-specific way of
-	 * seleting disc.  However, since there is no equivalent hook for
-	 * cdrom_slot_status this may not actually be useful...
-	 */
-	if (cdi->ops->select_disc)
-		return cdi->ops->select_disc(cdi, arg);
-
 	cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
 	return cdrom_select_disc(cdi, arg);
 }
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 0a89f111e00e..67caa909e3e6 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -77,7 +77,6 @@ struct cdrom_device_ops {
 	int (*tray_move) (struct cdrom_device_info *, int);
 	int (*lock_door) (struct cdrom_device_info *, int);
 	int (*select_speed) (struct cdrom_device_info *, int);
-	int (*select_disc) (struct cdrom_device_info *, int);
 	int (*get_last_session) (struct cdrom_device_info *,
 				 struct cdrom_multisession *);
 	int (*get_mcn) (struct cdrom_device_info *,
-- 
2.33.0

