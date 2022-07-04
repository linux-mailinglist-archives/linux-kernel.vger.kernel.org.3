Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6497D564E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiGDHFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiGDHFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:05:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF731095
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4vdLm1yT/fT4S+21bKexFwNM3pJpngyd/HqzDutcv676wcLd+AwE/bN7I15M2Y63EgLLoMIkF6n3+mMVN/GonzmbonGlEJJNgI78PqPoIT9B3XwUmAtCkR302mDordyDjDnWmE/224tMf1aZwUgF3IdyoOqFbzVI6+ojE9zoILs7hpEaSSZ0F2my4Aq6iE0TfvOz5AVkquk52P4FbTL4Z8olXWwF2Y38ebVGO+hC06ZPI9hmKCVRUrA8J6sjRfxSVwMqMBGMmUrBhouTlRfIwaT1ut8qDgg1SxP5digmkFerzLipgVSAYLaHn6My8IBl/m5C+9k+OtJsalCmD86NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDrEOo+47nfRO4w6flEK/k+h0ocU0jIdL9rXWKCtyEA=;
 b=UQKZyaccXXvvIQQjwVaV7inXCroPutCWYhw8926noAs3l29HRWvj8s9VbenHgI5Y047krFqND8Ntx38dQ7sO/NS20nird1ort4zexbplGvrddYn//H38yKoFZJESIANLeS2ycClFW2jt8UtedDpRLSUuiJXNAMgm5f7iSt4SjUIDL62cQA+Ly63djWl8QQvq4W4ORoppR37H3wSCt5yGi5pxFeHX/WNrqS7q8QPfkb4dLLxTTQ+Ezu+7TvOA1WnDRco18+lfbddO4g6g135MES935bb877zew8559NnTj/DFSK/JrDg4ikya62IeFADFh/YCzeIttGT8JEsezYFuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDrEOo+47nfRO4w6flEK/k+h0ocU0jIdL9rXWKCtyEA=;
 b=VhOHmP2p4Bn5TR3kudFq95naNwpJCQXiMn2XT1MaJGAMjycDMI0wK852HPguzJ47KzfVKT5Vha1uGYI4MU3VQew68EoO77TVeNfVUX6+9XO0TDc1lpq8f5zwabL3D+NBRRoLUj5g7Mo8zhvjsbPq74lNbyFq7TX2kPC/uWQFTcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB3935.apcprd06.prod.outlook.com (2603:1096:400:6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Mon, 4 Jul 2022 07:04:57 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::6cb1:51de:ca51:465d]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::6cb1:51de:ca51:465d%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:04:56 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yee Lee <yee.lee@mediatek.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Xie Jiyuan <xiejiyuan@vivo.com>
Subject: [PATCH] scs: Fix a wrong parameter in __scs_magic
Date:   Mon,  4 Jul 2022 15:04:03 +0800
Message-Id: <20220704070405.2768538-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.37.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 274872a3-53d5-45e4-2891-08da5d8b7fde
X-MS-TrafficTypeDiagnostic: TYZPR06MB3935:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDNq6HaRpe+uVeo1F8ZN+8r1UhwCsrHvw5TUIbgk1DrWGDggqaukqjpfWF2wT8aam0WpL1pM8larEFIWWKS68P86HZaJHxBHuO60XQJ6odB7aCP+CBS9K/GCIMNkCmIVS8mPvjQkBla5ZkA3u3SZycig8Dj0D3v5VshGtiGj3393dDVaTbXRIctgdMn6tYdjoUfIaqyCmFUpadOyQDn/0qj859MVU1wZG7HpjBKnn7glrj4ac8qwlPUKBPj+fibWTf+NEC7JsEi5ttOwnpUq/NR+MNfVRjokwIWFSvKXpNAIvsOD69ykrNqF227O2IsFC6+A4FgcKVOJxwmJS8hI5QiXObs3/sbycCA2svUsj+Z1PO9/1wmHXjtoVmqBP1sIFsvUNfWB97xGUIHjATj9SeXUphZ0xOsf+NnVtpdbSIlXFhz7q5ZFeCPDPtGLU81uPXQ2eGhA/pjGTMPJsOUP9+mwvs1NNprVUnTxSm2oytKIDzEuOfYLfeXMJTDkNaa42/r/MJ6GPUdYPw8hRyq93k5deBTs9H8ST7TSgf7eBNP3oM2Z/xmB/5SY/NSZ2UHb5L1beD1KpyUrs9iUJaJLT5IcWGq53Z81Ju1pccT60wgOzmg5SD5D4MkNSo1tmLTO0JlcbS3H5ljPFwn/Mz0LMtaCRgPk2Arh7EBnEOkWI6NHEgCEog4gAWi0CHQMmn9wCVm5wfg57PmqCRxeMUKIUDrd0dCJlZQmh2uC0VywW/73jRwl/5LT2m+tPykRREsxRmbCZtr3TSQLjNazpcOLOfm9qLX0LwbWzq3q9luwEWFpUdeoqJinPJ2V5xmXLQ0S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(346002)(39850400004)(396003)(186003)(83380400001)(38350700002)(38100700002)(66556008)(4326008)(8676002)(316002)(66946007)(66476007)(4744005)(2906002)(8936002)(5660300002)(6506007)(52116002)(41300700001)(107886003)(26005)(6666004)(2616005)(1076003)(6512007)(110136005)(478600001)(6486002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gGvBXc/7LFos0IhwSjqJdE6SSbxc46p8bbWgB2J9HXdWGtldj8AbT6btz5OG?=
 =?us-ascii?Q?w/rw63uBmOhOFc0SGf+cyc4uKMxzobla8zV9y2G+KDx8KZWfZHQY27TvhM/y?=
 =?us-ascii?Q?FWyl+b2KCGzSKktWaIJmRv8V0sUPP2tummm2G8F4g63+4aqbZWfVq+NPk/qa?=
 =?us-ascii?Q?qbHu7cs8t7VjNttYucr0080b172CNrtmhLhjYJkMNA26jPe+wsSIPA7c+4F3?=
 =?us-ascii?Q?8zQ3XtJdf1GQBL+X+1TYcJEoT9VkyMt4UHVzVHk2Ojd8J4bhKJDJyjGUXMEp?=
 =?us-ascii?Q?4sw614CiDZHMzfyiBYW/lF6jMbDvBJ9hTMjqTgLxwEBSncqO67dsSQPM2Txm?=
 =?us-ascii?Q?x/EjKKR5+S+bvvAaZ1tYMmuga1pRXdRixsy9xiCSpAfklm5J12G2nDohca+Q?=
 =?us-ascii?Q?Z7k4ySZj5DBuz2/fBlWQWhI03f8eIUdMoG1G803nom9rXZIVnLnGmEz0DvsI?=
 =?us-ascii?Q?AGfZlGG3hcqDOfDgFZNo+TJM4ydbLVo8Hp4ew9kNrfEgRdZrgYPiCyBreUYB?=
 =?us-ascii?Q?TvIu3CNp0bcLQ2ODPY0ba/+3eI7XH7D9D0NyUrXvT8TVF2EJTWQGivziNmwF?=
 =?us-ascii?Q?pJQq3b9sx5SWp2wau8nH41CcKQx9COliN9mV7aSbPOOneHpioFSf4OUjNRV4?=
 =?us-ascii?Q?cKAmVzPg+QzItYzZ9t1ZANGTy6NZDEiYzc9vKBzS0Ho+jIFP0VJTdIuzd8kf?=
 =?us-ascii?Q?TzZqm9B4il7hmadHalzsIr5JIb++GO0zWQ8HhtV9S7RpFmX/Ksw/ikIk61Gg?=
 =?us-ascii?Q?+DQnaOEDoc3A0f5/+Jr2MmutN8c8I6Kbbgtke7mMS1L6YE/RbdwA2Ehtxoax?=
 =?us-ascii?Q?xiHKNWhaHmEDyusA97NOlhIN1guYaUfTXhZ51dLIYNd0unQFaHwwrD+e52Nm?=
 =?us-ascii?Q?rtaGV8eoyLBsfWSP0F1v95UDlyrhXRht85+ee5qWUBf58LZDgEBsVPkmHcmW?=
 =?us-ascii?Q?zq6zNefcWuEuu4tN1eDZo0knlvNBYDcPQnf4G5CEQevQa8ebxixqeGwdNp3T?=
 =?us-ascii?Q?FO911ShIKe+QRIOgZaVpAsuEoXH+j90Rl6SY9v7oY1Alb4FMCDoGN9CQHG60?=
 =?us-ascii?Q?xUpZowVoDN919yl+w7JvPT/bpl/AlZa66GJTbIZtWKbAwnVde6Vsp3yVpsap?=
 =?us-ascii?Q?sGP8mKVXXlJeBbKrcRr3Wn8i4NmEf1Np5bgOAtnxRcNSsLPN+Xtk0JNCOLv0?=
 =?us-ascii?Q?MQ8Z7b9shyKG7yX0+35oqStEJeykcZJ40afIGP5jEwax+we1yj6GTaoK4UPa?=
 =?us-ascii?Q?zOGpij6cRuJAaE1GkdPzbHLG+ycYEkGFdytDHykh+U5ikClmgIjVUEhkiCXx?=
 =?us-ascii?Q?lz8lk7awilLmh91RfXUBHC8AUxlHinJlp2mDBN0MM7Uf83N3jzhG4Erw7p4x?=
 =?us-ascii?Q?94Dok57bYFVOjBKpvS0G8TwKYOf4/cvmcue/MlHxv9ofJrWvCfyvp3eGdzbZ?=
 =?us-ascii?Q?Mfj9X+0eAuxHimY+dKrmcL9mMfvday7U3jfd1VqV8Cq9unG0E+jtASHawLDb?=
 =?us-ascii?Q?KEjC4HccPKAAXyUJgWIUKKhHvFYLGQQsMU3zkZUfW7Q7nRJFo8mJagZcRvXS?=
 =?us-ascii?Q?xdqUxklm1GHLeZn2zC2ximrpvjA1r/LBqLftjAlJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274872a3-53d5-45e4-2891-08da5d8b7fde
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 07:04:55.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkpaKWPyvFf85VkWGq8UTZ6Dmz6q81Oj8PetUkhEUsPkDB65Y+T/qXoRpRqw7CvlDuTBl3NQXhfREZFODC+cbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3935
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__scs_magic() needs a 'void *' variable, but a 'struct task_struct *'
is given. 'task_scs(tsk)' is the starting address of the task's shadow
call stack, and '__scs_magic(task_scs(tsk))' is the end address of the
task's shadow call stack.
Here should be '__scs_magic(task_scs(tsk))'.

Fixes: 5bbaf9d1fcb9 ("scs: Add support for stack usage debugging")
Signed-off-by: Xie Jiyuan <xiejiyuan@vivo.com>
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 kernel/scs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scs.c b/kernel/scs.c
index b7e1b096d906..4c1ce6a6172d 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -125,7 +125,7 @@ static void scs_check_usage(struct task_struct *tsk)
 	if (!IS_ENABLED(CONFIG_DEBUG_STACK_USAGE))
 		return;
 
-	for (p = task_scs(tsk); p < __scs_magic(tsk); ++p) {
+	for (p = task_scs(tsk); p < __scs_magic(task_scs(tsk)); ++p) {
 		if (!READ_ONCE_NOCHECK(*p))
 			break;
 		used += sizeof(*p);
-- 
2.37.0

