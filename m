Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922B44D45D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbiCJLif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCJLic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:38:32 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300131.outbound.protection.outlook.com [40.107.130.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11813BDE;
        Thu, 10 Mar 2022 03:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRI1TbuQosoq2FOAoTL+z8d4lwY7dzgp1gzBEFfT1whXekvWBQjvUZYXZr54SGCYmQ9r/AucJPUDPsmXJC0oX05FJhl65TyRADBGa9DLir2rOSyM4Q7qQIWJkDjMBThRjS9VY9VKissGoPqrzgnHUanOGIBVwfccUOWZ5ktb2ct8Xblg1VtrnDbWcH7PXhrqnu5HGwaObdrczuFvjlHV06SnYjCiZJ5GIU5RV7CWsTG3TnrDyawbqAPme1INmttE0Pk8W+NWde/gPzi/qwkWeQJB/w2EsVXbjPk+qmzz3l1lnmVTlXXxQc64X5BbJ/AESshaziwSYOi9ELk/NIs6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYAfweHNl6JrvFPxuQwsHcuM8x70VDmWIoLRySNKoXQ=;
 b=Gqf5JxKLGUmiizy0CBRrqfsGedJSRrZLvFySgU6XAYiBnynwbDa8YLfCUpfpfI5Ru+DPFNyy/0L1pPDLU69kVJlNszOktUVfd91wVJ57WA3RY73eDdjrh+P2Has4RY6IN8U/3FasZnvwPRdVor9cT8A18HTvVaVC4l7DW9QiyHCs/K3ufFVWk1jYe6jQUYSkC4o63swCCS86iIDTbhp7kqOA8B9jHdQUF1y+drrlWiQ3pDQC1X7gqU62gULA2UzR2Zhc/mJ7xLRw3G0NjfsLRe70+emvzg7ZVhlI2m/z5dA6NcoX8Vidhi+W8OphLH5NM++OWVCpdGs3c7P31RuHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYAfweHNl6JrvFPxuQwsHcuM8x70VDmWIoLRySNKoXQ=;
 b=TWurFkb7ibGpj2SzfRfMYvSO43vk6owATa338r+YYbd6jAr8b7EsaT1eiFUcWBoBhDKa0HHCzQejVbXLM3ueZDhPYGO6uizy4QuaR32OVpiYkDBcsNhHcHi4X4b3eQ3bvFgiPDGcLhFS7sn0h58lY4LWn6g+D4KxolxiiCOB4aU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK2PR06MB3537.apcprd06.prod.outlook.com (2603:1096:202:36::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Thu, 10 Mar 2022 11:37:28 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 11:37:28 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] cifs: add a break after finding a new iface
Date:   Thu, 10 Mar 2022 19:37:09 +0800
Message-Id: <20220310113709.739102-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fbcea4c-1a98-4eae-b391-08da028a5aac
X-MS-TrafficTypeDiagnostic: HK2PR06MB3537:EE_
X-Microsoft-Antispam-PRVS: <HK2PR06MB3537C2557A86F5C35EC38E6EAB0B9@HK2PR06MB3537.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+WX6PaqXCKzdtQdG2ABBDnqT2mPI3zaTVzQcSLgnbqaaRk5UvNa33hkPe1HJCC8/XjGk/1J6VtDOhBrSsLoMgPH/z0jke8gUT8fGEUS8Yn1ZUSsv2DvZcCyxwacapsouD9E22q6qsUjIFLzVpokQJMycP5TiiAK7hncQy/XJy5soxU63gHR3MtKFOT8SvyZizMu9N6ZSpkEKS1GOQof+0E1Up3/M4Mdk9SgLerHxZGMkYQ2VTcbj2BNh4/TDF8Q7dKllcheeK2n6J6Drd8mL10dPfl2g2o0ob/ttCNFOVV7zAGd2B9n4+ILM5Gx45RyKXaIJI4nFcUW8REQysFfDv0WazBhVhq+t/NCUwkBduAku31Dj2wMfV7vljnyiMP5WW6IkAhMlh8YQ/SRKG518RzNY1xoOZ4jjVJUmQfWW6QPknmZLQGCVhrFbZJ/jeiOcbUXOaVpo6CCoeFfLUpKf0xQG8vmdq0p/ol+zBSRKsARR1YYSzMuFr/C1PF9mtPS9zisQwka3Oy2/Jua/3Lymakrt/lgvNFbC0clqPeTsdKuzR3vfSg2KrkHWNwg5xKv5o+dLcpwy1r49TYqR9EIjYp1YvB9cMOM2uD34c0crP2dupm6ltwTgg1sFUzlSE94nqi2JvT11beQYqmqfpY/f+vICboyOa0WWZwuCp9iLHNq/JgXwkZyiw3VqchR/ZlcAEComLD5Z9CUz4+YLsTs/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(8676002)(4326008)(38100700002)(6506007)(38350700002)(316002)(107886003)(2906002)(508600001)(2616005)(1076003)(6512007)(6666004)(6486002)(186003)(83380400001)(52116002)(36756003)(86362001)(4744005)(26005)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HyHGtmowqsAuMKXoA4zjPi0v95l0hKKySv8QEKedf0tZO01zwzsVW1UR1Ld?=
 =?us-ascii?Q?UOqJxXVT60WGYsYnmT2TFWbIg95ASggOiHrzUy1l3vxCGEugUXj5P/8R3cKS?=
 =?us-ascii?Q?+gxgiDSB1wcBIIQz/YW3sRKa6OUr209V+rNw4hGAJ+ZHFK7NmOriifxswZOe?=
 =?us-ascii?Q?ldm5pDZ0dtCkHN/zsbg8Gylr6lOPnng7GkUv5qJeAA88CT8cuYimgS7lKKuX?=
 =?us-ascii?Q?LxxxobiiLXCqvQWEKWW+nMLx1B7JwQFUmXmmV2KpeDbFb7Y3vIDXv8DaIvdY?=
 =?us-ascii?Q?8oIy3VYNyyrR7oqxhHOUH+q5j9RfPRy6/t90CexvlzDJHwUSZufxIlf1Xpvw?=
 =?us-ascii?Q?9Yt4HeEr25fDTLQmIDQHxkVGoz4qz0orO6ySL5c0S4mZpehzqWxPQ4RmM+EY?=
 =?us-ascii?Q?XeVWik5sP4s8K6teRtrtok2RbcV5ExeABusZDZEalAfHDxMg4tJL3pUn2RiL?=
 =?us-ascii?Q?Y9csLNPwMCdj3O/kpqlxM6h7ZLVv0VckwBu6CC4k1I3sL9hhiANmU+qwOc/r?=
 =?us-ascii?Q?CkAwSO0CZ6fCuZqi27alwu/5gLWI+gLkrzJxQD4fuyniUFvwdrlSJrO5uGwE?=
 =?us-ascii?Q?mTjhj1NvwtyNvYSNXPzMDbX/S+7HIPPuQtlMtNDjeWSDNELQ87nc06pyHeHS?=
 =?us-ascii?Q?f9d2U1ml04nUWWVcw81+eYDUFMNXufz9Uu0fjYw87YtsJQGNvxGmnX+scrST?=
 =?us-ascii?Q?h0riTgUP8m/G/Y8EzKrVj8Z7Sh2axiL+qMHt55Ebg2oX0ilpq6hBbEekiKCi?=
 =?us-ascii?Q?3+ilw68wv9karr/+KyIp5lmT94dtXavkIIKQ2UL2lsJccIIOmPCeaxkU0pxy?=
 =?us-ascii?Q?NVclyG/pj/9NelidkokaOjYwBYDc6HF4u0bjspi08IwUACs+JJBVbQclKpF3?=
 =?us-ascii?Q?MQSdKu+3Sdq/k4bAMXqnOEy2cP4i7ZnpOTGUnbe/EQgKvb59Pa0pOaRKO4hh?=
 =?us-ascii?Q?hPhrj7gIJ178hDiNIh6OuQuDxODkVr75+yBo5Uy/k3Y5tBoRFJdL3SJQ/Y1n?=
 =?us-ascii?Q?h6zSfP7ZzhgvVcixHK9gB814aUE6OIT5U7WRufocYGpSbrqB+ZSxqXEfLP/D?=
 =?us-ascii?Q?4Dur1shX33RoGR971piMJpRUP2ZLMH/BxS+WVxJSzV94aV4pfx9XC/KTAxoE?=
 =?us-ascii?Q?zS/uFAMyZew+GYnCr+TjdeZSUtrmjxFfVvNtmUlLtyYBO4ffWKpIIy60EROv?=
 =?us-ascii?Q?jWPgPPyGn3C/PiFEaPGCN4H8O8QdORlBuHOD4zR4ydUhaxJe8YO2AAFUqhk8?=
 =?us-ascii?Q?inNQ12fMvOJhtNjOg8ruOWD+hGDbdVZovijuTxBofGFxgxp1XjoEc5oE9J2x?=
 =?us-ascii?Q?RkD305LB/5cLCnQD0MSGLRYhgSMUkKhmqEt3cy5J04VPWVAjhdjnqcRsM+yA?=
 =?us-ascii?Q?ogp92a9FNsVjSaheGKzQ/2v7sLmbgBAuK7CaN5v/Z0WzawPwYNQxXtoSip7u?=
 =?us-ascii?Q?Na6kQmjtqm694P/YLgPEpCoTmx1wj96aVH6a6TsVIFQrx991RnrESMAuo0XP?=
 =?us-ascii?Q?YA2Sm3Y4ifgQUI88N3+4CJt21UHEWKGeG7oIikCL5YXpoWVXlp3bays5PAQ9?=
 =?us-ascii?Q?1255R/bFJazkQUxa3hEeM8q8O+hAK7SYQfFwTksyJNV1DldsPnfEgsV6UEQN?=
 =?us-ascii?Q?ynURM2HhemHrnfGzTzct7ts=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbcea4c-1a98-4eae-b391-08da028a5aac
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:37:27.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfDL1Z0d56X/SSfeL3M/VYG3WAiB/BXElCDUpTH09LtR9TCW+RwOwrTPNwoXxBrni8v565aba9xw+jA6Jggrcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3537
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should be a break after finding a new iface, otherwise the iface
would always be the head of the list after iterating.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 fs/cifs/sess.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index fef087129c21..7802525a52ec 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -253,6 +253,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 			continue;
 		}
 		kref_get(&iface->refcount);
+		break;
 	}
 
 	if (!iface) {
-- 
2.35.1

