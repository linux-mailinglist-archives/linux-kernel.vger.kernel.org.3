Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B335A0EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbiHYLUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbiHYLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:19:56 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568ECDA2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:19:51 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PBD2f6015709;
        Thu, 25 Aug 2022 11:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=tAxHTXF0eLnhx3p8mRWG1gwU+R6HBrOPCQQvkzZpsjs=;
 b=Yo14QRrujfFuhPy61WcXIRK2y4JxpXNjNJvkO6FELPbjmRIPb7rua6WKKACz+pqBRvAE
 wCPSmHPNI5u+TifwhEE+4O5nJ1ckMaKgFjQUCJE1PiHECA07HFEBiB8gNrS+L2ef6sXy
 SLAUi0+q5e/WdqqCxshGRqTbh137iyDs5ELk4COO5U5qRfsCK5rn91UCNIGuKHEI9u4K
 ipy5QXLf/JiEwr02mM5SnfM7c6jJSxusAy8wgnpcvRpBNijwftnuMAkXszLlwR4aNctN
 oeR8WjUn9QInbOCJUNsO5X/UjyGmzRf5gB4oUbcAYGYTmaC/NZnSXxAw4Gyu9oHETif8 8w== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j53s31ms9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euHY9AYosNSjMVG0AONDOFEjqywhvrD88D5CC2N8Nth6iJvQjBVreASg5mjDEB20TCh131pxeJfpzgLWWoYjDkuu82H4yESNG3DpbKxvDo1xErBYJROd5pIlbuS4LXu0G4ILTkMEtw6Jzu6SJvSzpv71alxlTEwHvIVVT03ys+AmYwoVaNqWuslkDMcdESOiElcCdcaj9a1znNarGozzQ1iXgGYkt+G/WS8odkTuVm7D3Ipna9y3HMP+GzPhCb4/7MbXLYZdX+/PPHLcO6LayjeT7I9qqJN2hPdWsZw4NmvetiieeT4sJst1c8cMo6M5T6n4J8pdMWx/l5/tA+agZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAxHTXF0eLnhx3p8mRWG1gwU+R6HBrOPCQQvkzZpsjs=;
 b=KXKgyzqhjhlo/XCLzQ2uPw11iFH1B2X0P2rgEKCMDZY8wbGQwyruXaPjmhcZQpfUZYnNc6ivEE0vOmDEum73vz/2Ji+rGsWqkc5DZT1Q/xqTte/SEFO1kKcaKKMu9JKTGqV1YjlHszbTdi9/YQJ4VS12RfOYpbmKREGTMmT47W7XPKW6x4rJlu+IkHFtQvh1NKVGk93G75FmAIndNbsHJ+HubeNNBzp7lbJmevk/Y5eyUuOqaIoaKdrBz7rPuJf1193BzOtM9BFDGZbMpfnWGrLT591HzNOvkNLfEYEaEick8YNLDf7OE6e2tN9LzS3+ZreRav8p0YJnGt5NXVDHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 by DM4PR11MB5294.namprd11.prod.outlook.com (2603:10b6:5:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 11:19:40 +0000
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::5425:cc55:3507:80c6]) by SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::5425:cc55:3507:80c6%9]) with mapi id 15.20.5546.022; Thu, 25 Aug 2022
 11:19:40 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [v2][PATCH] regulator: pfuze100: Fix the global-out-of-bounds access in pfuze100_regulator_probe()
Date:   Thu, 25 Aug 2022 19:19:22 +0800
Message-Id: <20220825111922.1368055-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b126d76-269b-4046-4e3b-08da868bb40e
X-MS-TrafficTypeDiagnostic: DM4PR11MB5294:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHSx1fRrzrXYmR/s9uoQOlc3PgG75eZ/aLv9NQ0XP6kKpf23wUykKe06YiGUYm5DJojbomXqjW7XcQUQtNuZvpKhSDsq4VdKC+bcfT2mkb3FBehKMaaZjX/VIzxNA3c0BJu8tENBTlG+wXabZAq1VBqTlljoRU86bBF9XXYFNCkTHUUsfdYBwJrDWHhKr2csR9d/YC1BCd384M37Uu8tyI6HIB7kEl3ddqTBzsyD35TrUR8fcDB2RAs2Au3DTO6gv0jp7LJNDvYs6suKX9qLcG1Xym6oZqQG/HK1p6oFH0tQQ/CNkzusEoJ5GNsSwhLY6CXe+8rYyNf5LeU1Usi8n6QwYwivbLhN2UskmF9HyuJq+ZS+1Srlr8wGtVn7Rv/sFG+pyhi1ibeTpweXgqpluekUjlmRTJGrvjW5K28XklHjxzcfRC3+g2R7xLBNhjEUOHa5buWPemqocIPicneI8Ya8F/I17AnHDjIvAjUTDpGvrmt8t90UM6SqoOv7Iw1y/avo1MLv5DprBoQuVIv+I+CWz2fPkYZ2DUQeyisfBi0k6pN8uvASs4imchknAJwIgoB8KFytnSdIv/s/UUnjMYRIXDc/11t9EbChKYYdFh3j+aZi6Z/pBgX+U8TY0byUZBekwwHgfuBqUiLZprZspqP8l1wsLfxK6wFhJglOFG/CI1nBMa1MhQvxTP5AjA7VzxtDru7OgYZ0WYB6aE8eW5sUR1tor8z0VEripu+xN7aqB69Uo2OEugcIZ/wcwwC8v7HUucXEXSWE+Lp1Doh4fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(366004)(136003)(396003)(376002)(8676002)(316002)(83380400001)(36756003)(5660300002)(2616005)(8936002)(186003)(1076003)(478600001)(66556008)(66476007)(26005)(6512007)(41300700001)(66946007)(86362001)(2906002)(6506007)(38350700002)(38100700002)(4326008)(6486002)(52116002)(44832011)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/i/u2CgNK+eJ4YoNAwhzL4mRxpKPcWHdvUmZsSXBhMbQDhdv348GBbqYA01D?=
 =?us-ascii?Q?6TGq/rGjh0dGAdlNZavydGY7KjXHWqKXYrVSjy5F2jvLMlelZ/J0uhL+GJFe?=
 =?us-ascii?Q?9vPVRllAnluIv1k4WL6njighQPuuZI0uI3EejInPF09c8X/ps3VC/kcCLViX?=
 =?us-ascii?Q?P8o4RyNIS0igEWCNNifKpYgS2asimQtRy00W2jkKq0zdBZnDX04xVmYQikqR?=
 =?us-ascii?Q?aMcOwHg8jYrm+RWSojzxNAdcfP9Sc8sKer7JZpc/Y2dSFh/11MT6/sNR0Ofe?=
 =?us-ascii?Q?/OhwwhrgJY3CdPTlGAWtwiO6KyXux3XTMlK3vhqFcPlYiaAPAQ+VXWgp7D4Y?=
 =?us-ascii?Q?0Wk2JB+jPQ/Bkh4wKepK0C1czz8iwUsb8ZrYVUX0mPTuN7Vd8/olsd+rdTdf?=
 =?us-ascii?Q?mUXGKMvnBKDp0HeCcr8RRhrCJCb0BXTwUaTr7EsjMhNUWaid22dvIajWkv0m?=
 =?us-ascii?Q?iTQWywiO075NJBg3diGAMrmShpPzf6kCtxXMelRx2a8RINKHM1oFBHq2OxQm?=
 =?us-ascii?Q?M97yS1rTVFP+hbFU2EuBA44opWsKvwn4QgzmhbXaiO7GsGfqWoxiN09JYLc7?=
 =?us-ascii?Q?F79B8TwdFGxo6avrQnpBZP5/FXb7GAV7DNyP/7lCg2OBGGxDAgM64JxHBC+o?=
 =?us-ascii?Q?W+Hddsmy0REL9SlQYwiuGHCrlEZNx2PwMOFQXDbLe6neQ68I5Bew16HtTQcj?=
 =?us-ascii?Q?P9e8o0JowOtP6DGdUaN+YXyRykGwkWB4rNkRzVaXL7wuxReH3oEmGKntdZGL?=
 =?us-ascii?Q?cRINteHY2QI3o349nkDug9t0GYhk5HJo9xqF6FgbWvVwhO9irvY/eeSxGFEw?=
 =?us-ascii?Q?NLykCxg5DFQBm3GBnW7w76x72tIcUlh5vIqH2SGOh1z3nVetJLP+OfptdBUZ?=
 =?us-ascii?Q?puOJyIeXp6GMctgGgVu/AmV6uuWzymt5ZbRd4droJc5ommnqxzUG1asucY/T?=
 =?us-ascii?Q?FszeR4gBA1xUWfvkSZWLKkImvNuKKFmcg5i/5bjiTKA3PBXTb+UNWmaiTWOT?=
 =?us-ascii?Q?HghnO/+Q28XjYvZUDrZ87w2y4vG3GcWtFz1+Rz+fvE80r2k0VyDd79GVr6Nk?=
 =?us-ascii?Q?z4WmqRHftI+mdaopX+EW6NoldbpYrS2EA99Ybr/jr7/hwVpyqyVDI073/fmy?=
 =?us-ascii?Q?ngFFXbqA/9cvH74O5kmkM+l9dG4Gmz39eaHb1qYyMHS2hDJJ3tksfGPo9xPZ?=
 =?us-ascii?Q?Zlxi8R4nvKBeLAmlSgl7LpPZ6OEioO+4OohWoDnbc5e+TzMPZgtMYVkcZYcE?=
 =?us-ascii?Q?rxujf6DpfS32rQIhBSvGBoRRkWZzj8qik/RLMj0Va4ZtpRXmyHdwBVpQfc9Z?=
 =?us-ascii?Q?rSQpJuZrl0/xEVcQnWU/UXgRftEnLPGYKclY4WFUnyZMQcXkgNy4/hyoJ5g+?=
 =?us-ascii?Q?+/Gz2q5tYlf/FKLk+J4exDleQ3UfrRR71BkX9J3xnnh2uRFyWhzPBtAsBVkO?=
 =?us-ascii?Q?afbl8Er5Lf7IQkDFPUIeACJBq9trnhLAO4G2KLGeXkB8UcbS7J/HWXVpac6w?=
 =?us-ascii?Q?CGa1pSSfy7ZHESuWwQ/x9ssO65tYrm/LP/uB1lfk8qY3+bkzYl/omtIVOg49?=
 =?us-ascii?Q?8ood385w2DZQ/1P2WVyeIuJRfM+ujujY9vna48YkefcwD19ye8nAbFCNwCKw?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b126d76-269b-4046-4e3b-08da868bb40e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 11:19:40.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82hPZeNDG+6YL80m99MXZNvhY1TZccyMtP+BSPQ/Qt6TsPIYSG2v8ZnrMH1jnHEJUCZV6MwAwz2kIY20oh8s4PfnG5QigL6OnVp/UdWg6jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5294
X-Proofpoint-ORIG-GUID: hfaOd71D79PQAXVGc0SDDLWWhQpKM_uF
X-Proofpoint-GUID: hfaOd71D79PQAXVGc0SDDLWWhQpKM_uF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=907 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pfuze_chip::regulator_descs is an array of size
PFUZE100_MAX_REGULATOR, the pfuze_chip::pfuze_regulators
is the pointer to the real regulators of a specific device.
The number of real regulator is supposed to be less than
the PFUZE100_MAX_REGULATOR, so we should use the size of
'regulator_num * sizeof(struct pfuze_regulator)' in memcpy().
This fixes the out of bounds access bug reported by KASAN.
  BUG: KASAN: global-out-of-bounds in pfuze100_regulator_probe+0x380/0x8b8
  Read of size 3968 at addr c3390640 by task swapper/0/1

  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-yocto-standard+ #2
  Hardware name: Freescale i.MX6 SoloX (Device Tree)
   unwind_backtrace from show_stack+0x18/0x1c
   show_stack from dump_stack_lvl+0x68/0x90
   dump_stack_lvl from print_report+0x58/0x4c8
   print_report from kasan_report+0x7c/0x98
   kasan_report from kasan_check_range+0x20/0x170
   kasan_check_range from memcpy+0x28/0x68
   memcpy from pfuze100_regulator_probe+0x380/0x8b8
   pfuze100_regulator_probe from i2c_device_probe+0x37c/0x39c
   i2c_device_probe from really_probe+0x1cc/0x398
   really_probe from __driver_probe_device+0x118/0x124
   __driver_probe_device from driver_probe_device+0x5c/0xf0
   driver_probe_device from __driver_attach+0x144/0x160
   __driver_attach from bus_for_each_dev+0xf4/0x12c
   bus_for_each_dev from bus_add_driver+0x124/0x264
   bus_add_driver from driver_register+0x130/0x188
   driver_register from i2c_register_driver+0x80/0xa8
   i2c_register_driver from do_one_initcall+0x180/0x39c
   do_one_initcall from kernel_init_freeable+0x374/0x3cc
   kernel_init_freeable from kernel_init+0x1c/0x150
   kernel_init from ret_from_fork+0x14/0x2c

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/regulator/pfuze100-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 6b617024a67d..d899d6e98fb8 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -766,7 +766,7 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 		((pfuze_chip->chip_id == PFUZE3000) ? "3000" : "3001"))));
 
 	memcpy(pfuze_chip->regulator_descs, pfuze_chip->pfuze_regulators,
-		sizeof(pfuze_chip->regulator_descs));
+		regulator_num * sizeof(struct pfuze_regulator));
 
 	ret = pfuze_parse_regulators_dt(pfuze_chip);
 	if (ret)
-- 
2.25.1

