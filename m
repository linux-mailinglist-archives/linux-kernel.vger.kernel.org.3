Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689F15A09B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiHYHQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiHYHQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:16:13 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69408760C4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:16:12 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P6pIbf018149;
        Thu, 25 Aug 2022 07:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=16R22EvHkjDZ2eXWG20yKVHU62c58BUZPAPUbJ66KDU=;
 b=cOgdD6bxMSKkw/zgLoxrTsvH/EuR89Jl/i/0tQY9mBClmCDfzMnp0pPTa853N8mP5t0B
 aITPR6a1sMqnve6t5o/QwyldA3K9DZpKt/ENS85iNb+zrTLiu9md3D/vIitqaSDANinF
 ao9Nesd4DG52gIn2RrwlBOthS9IV8Aac03aAQ1PV3ePPgT46gtWXenJvQmvI8m1FXaY/
 XjRyJac3qA3urJA/ywvOrzL/giUjNsXXP61+r1QAXT/hk81kQskXm3LastG+04MRFcWb
 yPPpGT8jPGlMOH/vkRd0s9bbuS2o5vLZaP0uKXqDl6TJHPF4b/2hb4xmP5HRHF+ZH0TV oQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j53s31fvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 07:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyq6y8xF7WrAsllhMPNMIwI0w9cR2pP2RKQqC7ecvpp8bGGliF+eIixleD8gxI8+km85GruY8HPXezQnx0B5j/2pJCKivGqn1xt841CYJ4lRMmioKN/pyrCL4eejasWjzl1OIe8wnxMgay5FtbJZqL7I1cz9r4dR2Ghqr9fNEvb9xa6uKZtRTIt+UPXm4T/1/1r7A6o98++ZJptmWhP2fc30wEYUtHQbfiZkzi59LjlzpAG3Q+5rPA3cnvMCqeXpBA8MCSlSIzFXrHeYEZotijmpXl8RTIrTqfFdDDOVQCbs8cR7Nf5kd2Mym5Utcy/7zpC2l9GvCwJE+pqJHwAqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16R22EvHkjDZ2eXWG20yKVHU62c58BUZPAPUbJ66KDU=;
 b=YLRdlaArn8aHXphlFIp0GyPMj80LjRyG3s0KQ3+NHqxPEjmCeF4SsU3cwceFwF8YuaEk1hTNwAvuFReyvdg9ZxC1s/brUMuQFlJ0Q9zt/cESEFG+L9063+6oQPiq+bjXXBtO0Cbd6o+2JIeTYlF2jNikukv+ahj3YC2emoDrN4hMCV6gnhsU1ezU7/Oxu6YKOPitf5jsQPdGrGip5muiZr1ioDJwcjF5gtzX2GYYr4U4zVerC9F+yKflZLnfemMf/PVucxLVS18Eq3jZRljsyNffvyQOxMlM3mcji3LmlRB8qBq0uu6qeS8cHSsAfRzef9f09fSk7HD1oikA71nuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 07:15:57 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::b411:e315:e210:73d2]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::b411:e315:e210:73d2%9]) with mapi id 15.20.5546.022; Thu, 25 Aug 2022
 07:15:57 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: pfuze100: Fix the global-out-of-bounds access in pfuze100_regulator_probe()
Date:   Thu, 25 Aug 2022 15:15:41 +0800
Message-Id: <20220825071541.1228110-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b67a5f49-5933-4b59-c0e3-08da8669a7a1
X-MS-TrafficTypeDiagnostic: PH0PR11MB5904:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1AeSJbr0SryVyHVjFu+9tqEwQjoIE75a9hIJqPDAk+KZcQZpyhypLYQSkzv2rw6aLCC3S8OBcjWNuycOju2043kOwWnXki/ywKwPWbGC4nDnC9j7X8B0WhCo/Vd+C+4M3rTZunD2KK1meoT36zBDnunRbIIonAINbhguTSEtDnXX2ch0dvrXwG0IGO9aUGY9Dl4YmzYFHqJtPUn6VzHrfjQbgtushsrII6AtWKfSRoLHv5ZiF7cPJGHZEBLgeHBbjKWYU0Xefqw/uTVi1K4+mzsqtEFOzAfmpYVmKm7m1e1hv8d0BeXAIXB570hb2erib1ldOMi/JvkCXV5BKLxjInOosJz/WZ1nQGComs4RPQst/B2q2aUua2GtHn5QRug18mjkjegR787e+FGqBDpTncbYkJhI32tptBn0nFAY9I30/jJdG/hYiiAVM3aLJoYFFqYrlTIOSpzpPfOPsnsi2+bmWQj4Dmv/Dnv22IJqzWdYBGpFNrEe4Sj386ZzuVzRN9xDatClA3GfF0rVuEWxh4lVtK1zBKeUPcp1b1P8Rus3XWYttPSraijwlj7LF+uPffrNT59lXhUMrnoez9VFdZmuPKgaGfGhTuDif8v4hJHe0zNvuL8Oj+BXdcw225AM/DlgDXc+VLxaCZ90vyS8kwzUbbR19O4HVrdfNQogphg4QElne/UWLWgwkD0d621jviWd6nOBK5L9TMKfR555d2uAZqzD//aUVatxqCJM8MO26XBUPd0Qc8ZfxKrFA3zuKF7D15ViG9NWlRAipiH+kp9cbKjqXe3/w6FGlXSxqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(52116002)(6506007)(26005)(186003)(6512007)(44832011)(2906002)(5660300002)(86362001)(8936002)(478600001)(6486002)(41300700001)(1076003)(6666004)(2616005)(83380400001)(36756003)(8676002)(66476007)(4326008)(38350700002)(316002)(66946007)(38100700002)(66556008)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6NVb3difQfhq3SQYKXsz0FVFKBW+VmmWblAZnU/YILY3nYf6OozOHY8LOl+?=
 =?us-ascii?Q?/dNbr6PCv6MLjR/PdONm8ZLO7BUKCm6WtOkG5fANspGekuImU+b3QTsESuhx?=
 =?us-ascii?Q?zIe96uhE8UkGiGWFVbVsbaiVQCvtoj8R0GpiCwrxzyqwJkgVl4QNtwM+8TDQ?=
 =?us-ascii?Q?Eun2C/opxfsJNksx748pd8SZdgYbqzGMg7X1gHJuDwx6WwEPe5CmWCZ8GjjM?=
 =?us-ascii?Q?Gym6T6UVZZWZOhn1kIzT8vLif1a3c28dySlSDtV749HPIYYzpIO/LhtQ9Pqb?=
 =?us-ascii?Q?9MTEExEpSu4bGKtr8ZO1PfITYbSRnUzjZuRbQFdFRNWcpRvlrKOORi3EPWRL?=
 =?us-ascii?Q?uzXWs1C41b1e9FsXzpWXdCGsLk/XH2APUDObo+sOWzLHyxOdn+YO0JKVsgTe?=
 =?us-ascii?Q?3xly0R7UkC2Nj9GeWPWkCmAvGZZPacGH472dvM2YhtGi/OIeMNA3Q4rtZK/L?=
 =?us-ascii?Q?tZ7P+Dttm+ipu/jBGLDd/ZqO0xH3JLPe/1c3jKXkF2mGboV55+px8xKxK9Wd?=
 =?us-ascii?Q?pnz65DZLWycQ7TiZ2WYq10G7N98dhLpUHoDbfqXdSdxRcJ+i7UyuUal20Cej?=
 =?us-ascii?Q?6fZlnmHrUQileCF8fcmyVbVZ5HISpd0dJZi/jUIpqGPf5+tvCBilYs285OBz?=
 =?us-ascii?Q?cPcQiJP4PUUWnkvI/xoT7wqeaZvCK9UuRv10JDhSDYZvqsYir6CR7kr+iS4Z?=
 =?us-ascii?Q?3Ey8zqxQns5p/JpPliOhzJ9barTJ/SJFOu4S+ItbNCZZLau5U/R+ufl7uRUD?=
 =?us-ascii?Q?/AMPYqhOf3oTZbb39gJhqzJHT3Ic5ed84d0bghiCq0bMLFner1hMjAsi9xkP?=
 =?us-ascii?Q?yuWK1bx2NHO5vzYAShhrHGxfmNAt/jdPSSxWO2cGtvYHnfhtxjosux0bW09P?=
 =?us-ascii?Q?IQWLusmNBbmZcNMijjvRAVRA8hbxybW6VqTY25BcylnDyO1DrmXRAzbHR/rM?=
 =?us-ascii?Q?6DXKL3fTk+EWHINty7Cf+1qUaKodwn3pzSUXNEx71TzH+WlgOolX9NYzJA0a?=
 =?us-ascii?Q?sfK8P4jfSBN0tXsgJVaGcE2GwniFWwvnQEmPg7XSh5+8SiFlVCZphY87BI0P?=
 =?us-ascii?Q?d40Uibqbv1T1XRrr+8xHRIsUmXR2vdEBU8JO4LHZKZ5GhFG2WMK8p8iCAIhV?=
 =?us-ascii?Q?HRp6q+hTnHGC/v0lA+DDTwU+3KIZyPFnGK9vWy1w6C80ZB+HCmcWVPKOgf9y?=
 =?us-ascii?Q?zjphxJ3ZKPQulJkEibfNPQT41//MmXpFhefRC+0U4ZFiNOQ1QDLXfJdb9btk?=
 =?us-ascii?Q?zMnsFHChRZXNajfpNmA3uzED6dDRDVBpO0bcx1mJ8aQKJNb9E/4Ro3G1n4M2?=
 =?us-ascii?Q?GZzrzlR9as8mFk+SF9WbwMKh++PnEorEc87xotDoPOhPnlMNDn0EpJTQsfcJ?=
 =?us-ascii?Q?D/KJ3C6tFVzdOBmPDNcQfX0Mt00fFdFz1lbCTnAEEnll6a2BK6i9YihmoV6J?=
 =?us-ascii?Q?hIOwrcq5O5hQtrKpqFxQyOIaf1Omx0ivb9TutpiQ/uRomKl2oH7xiLtFVV/M?=
 =?us-ascii?Q?xdi1DeP2O+ERjclNomCmDW5ayG5WPU00YksVZgBAl6vN+cZ4dPZtr6ZvXgsF?=
 =?us-ascii?Q?RM1r5jG/ulEouvB+kuhZ5NkrPks4N78f1Eby5q1OHFIZPr3cQPgOjD1zEIpj?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67a5f49-5933-4b59-c0e3-08da8669a7a1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 07:15:57.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvLdHszh166wEtns1+hc7c5PMGRc26kPJ5zOAQ24c8dDT92VwR52WjnXGbSaZySJIEJmi1s6I6pNJPMCyMZeE0MZumBmSmTVOgNUnWUhR0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
X-Proofpoint-ORIG-GUID: OGltPaKtnAbQ01-Otx_9rQxSq7Y-86NH
X-Proofpoint-GUID: OGltPaKtnAbQ01-Otx_9rQxSq7Y-86NH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=943 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250025
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
  Exception stack(0xf083bfb0 to 0xf083bff8)
  bfa0:                                     00000000 00000000 00000000
  bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  bfe0: 00000000 00000000 00000000 00000000 00000013 00000000

  The buggy address belongs to the variable:
   pfuze200_regulators+0x0/0xdc0

  The buggy address belongs to the physical page:
  page:(ptrval) refcount:1 mapcount:0 mapping:00000000 index:0x0
  pfn:0x93390
  flags: 0x1000(reserved|zone=0)
  raw: 00001000 ee9a5044 ee9a5044 00000000 00000000 00000000 ffffffff
  raw: 00000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   c3391280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   c3391300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >c3391380: 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
                                           ^
   c3391400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   c3391480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

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

