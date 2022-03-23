Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE8D4E4BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiCWDn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiCWDnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:43:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4296C970;
        Tue, 22 Mar 2022 20:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOGEJ2efITHp6g/6cG4ImYgOIRzce75+Q/Qd9NfRGRzh1ilPDMYFd/YN6RdrQsYw0hJcHI1tV83FZX6ZJmaXRJhujeSZWTrheROBMlDhVM8Rx1T3QnEUavvixg1vl5gcw4NovgjwwOyZCyMnVjidqpvv4AI/QQPnvD9Uvb7p+W8po9WL08XW6pgkZDUm8rBCLQXg4GToLUXsDw9JYzszw6BFsnvQAIZGZyvSbRj7bIEbQSTr9lZPxIfa5ri/7ZYGsH50dihMWbvdWUZFaiy6APOfA3/DHNdiLsyNbG38Vu+IFm2ZVkQoo/uyj9i0QzvzJJnf3bt3lBQGDZzCXwQFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQCsPgOtAKUKy5ZM213P5+aKzX1dWckhC4Y3d3SSAw0=;
 b=aD6dQVGEQ60ngCWqbWgnz5oQwGlsLPD+Kg/iXhaylmhOPXl9SSjJUGywRcRVsTNOdk1s9cTikZeqzNc/Zy7GwvwV9RBL0OOf9pc+gSCsRfQ2acsVkDAozko38GjCEKvMOBW6HwT/7nU++ESuBMOd6nsROO7FPlHrJBpsiGpgj7IwuFmg+C6grsYediEYU51uPvC4FguIk7Q+mTlDWsfBoC2kGwT8fNZbrMl7i324Zu3NN3miUNsvr1FHyiSflOK8peGNvu+4E5c3xarPuQJm9A4B2p52qoDetvndG0oO/IHBBSuvKKzdArCS9kixRGqMp1opAjjwvpOjKKX/LglR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQCsPgOtAKUKy5ZM213P5+aKzX1dWckhC4Y3d3SSAw0=;
 b=LWkJL5srTx83aQpvHS7f2e8p++J14rOy14ReAA4q5ZEzhWvdlxj/zPicLhqm0ao9QGRgEge7+1dNiIPDl8H06TVrP2ta6lhnF3UYNIVEj+DoQ3OOtXH9/r4CV3kX/BDBNpDvdx3MXKxU8zpgWtohPrOI5LfkeuSDYTn4DTx365U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6868.eurprd04.prod.outlook.com (2603:10a6:208:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 03:42:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff%3]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 03:42:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: [PATCH V4 0/2] remoteproc: support self recovery
Date:   Wed, 23 Mar 2022 11:44:03 +0800
Message-Id: <20220323034405.976643-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0111.apcprd06.prod.outlook.com
 (2603:1096:1:1d::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a46af7fc-9ee6-46a8-48cf-08da0c7f20de
X-MS-TrafficTypeDiagnostic: AM0PR04MB6868:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6868F0C1673BEEA580F754CBC9189@AM0PR04MB6868.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hIv0D64w5y+knjfAo0dzyorPrGzB5F6qcdBCeW4f2rTEdl0jqL+LFrsoA68oCqIxZPw/TvWs7arl3z1BSIYV45c/9fCmPbJZBlgrMX/9tpwsVOKkxmgtcO+y03K3cViSpvZxk7yV0TpXb47TdZqOLOPJhwmmqI4nDh5p6fO68l7wvpNqNs71U6B1rC5bQoxo0lzH0r8AQoO+D16NGvpUp8ZWBPoYR3iG1xp+6MsmKEOJwKk7M8/TB+ipCsJ+UxYWojw8qrIzHTkmBJ+RqXiUOtgk+ezc3UczdC2XFUjqp1REqzNAoLchzz6CKClZtoZY0S8ix5WfndW6V6mp4a65bBxnzTZoVGq/ycaszOMW7LjGyH3r3lGW+lsVT33DgUiN9fwvYTv7RtUujYr2WctbpUGI36n9kJXJjx0i3jnrgvkZ6o3uT8aUYbyijKD4dSnQrnbS1RRnHNqR95fhybj5YJ+HQKafhlB95nSvh7J5blbsYULZ/Fvu+B3owRbhStvyG0pQdFD3eHsmibCXjsMpIB20ExPEzwD3sxNDEEVRx9An2BpraVCqmRc/0+qU8xR3PC2N72WqJEkpzBkED+ODT275JA4XX+wn8TUMMqOiQGSTbNVHzVig/OIOAil4BX0UEBy47S4EgWPP5h0XsNUqiKieGmRNKi8tFuMu/3jCmsVoISP5LlEUcgvZGc9ycX7dWplMFt9gmVInDK+ERfUIKnQvy/xIGI2uQfrZ2QVq/tdT7CFQwJd/O+E5EQeT9zolS4nIchxgMK7PMMdueMyLKxL/k/ieOvn69oaKRitTQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52116002)(38350700002)(38100700002)(26005)(186003)(6512007)(8936002)(2616005)(5660300002)(2906002)(66476007)(66556008)(66946007)(966005)(508600001)(6486002)(6506007)(6666004)(316002)(1076003)(86362001)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yd8wJiXfOjHxpSVi8OJhjMhZoWj5Uw5cqX0iQ5Mvgrq0H5oAkb3odwHC8Px0?=
 =?us-ascii?Q?x8GcRIAfKhs48SjmmQ3a1l+v1ye6vBmK3aAau7Xp/Yv8XC0nYsGfMgFRMK/t?=
 =?us-ascii?Q?6vhxgGaEaK6t561+i1/ZZxTwH5rUjZcQgD+iv/bv972dqjlE508TDoC02GYh?=
 =?us-ascii?Q?i8KfceiXyoFkqS/Nh0A8f3lJpHRfbJMmX7SkI4Ivmv+BCJ/efwvyB+5lYOxz?=
 =?us-ascii?Q?KQaf9bSYQF+3yMiYoNTEzo0+yxuFvbI7+2J/qfbgxz/ufAfFZtXe7jQaCQT+?=
 =?us-ascii?Q?vs5lgHac9o6ZAQTU8idykp1wVbWdjVtHjYksiT1zxu4zYY7+qUQybHNois4f?=
 =?us-ascii?Q?W/FmN9Qt/weeqThcNslobRYAZV19s+ghKVWk18J7BTcakisoFwV8lR68CQLV?=
 =?us-ascii?Q?jOsMOYuaF9iqqNn/MOurlz2bDU5F32iWCL+Xi2sLtDdAnncT9XEPAFDD2Iut?=
 =?us-ascii?Q?R5wTZM+pudk5EiE8fmEDbMTGF/VbLIl92xSnEce7ee1Xi9CvyLxCBur64KFe?=
 =?us-ascii?Q?5HjiacW2yBhc3VZSUFcfLw7CFvXB6T1GH1SHYxKtbHKEJoZF0xR88lWLrBuQ?=
 =?us-ascii?Q?WQZx1D6VCEchs4QiInmXkhvU3KpMwvC8qZ56tyjr7B59EO0Jq/X2QWQrRTJP?=
 =?us-ascii?Q?MmUl6MW5P8WyPN9AUsenE7PwLNDEq4TfjPTdcjKTYIqX2c7aPjDxpjwCTcdL?=
 =?us-ascii?Q?hHVV1vU6DzK86ORxX5Jizoy2idMbTPhsMNC/r48pFwxKYaeLWeahu1GmZB3s?=
 =?us-ascii?Q?vE1tqtYwmmq44elZKlTFYud47ifrblc3/KwXRl6BHS4c00ZgdnfhgZIh7hK7?=
 =?us-ascii?Q?jutj1IAst45kwKmJYpXq89IKDeKnUaqp027VnDfcPK4HTAB/6D3bQwqCB9hd?=
 =?us-ascii?Q?Rgml5J/Ou+6rY5JOBWRdTPwgWg7HyqMqmNJt97vKmXYVS+GUX6xPFhmYM0T+?=
 =?us-ascii?Q?bJ+KWg0hFk+3GrqXWIuu+EQ2xKi90uRTG3TKbst4mAGD8pdW0m24JGc47asl?=
 =?us-ascii?Q?7cpPQweqkK3kgdCBy7VzigZV+SBrkQSLVuqqYsIjro635i3T7xf1JHHn/czz?=
 =?us-ascii?Q?kasUJ2tC0AusWLdhlMbJgjRdy1Nzo/XN26WmWSUcSbnKXiWDYhdiIuNyY1XJ?=
 =?us-ascii?Q?91BEf6v+zU13V/v02HXKtpqY4mgNTpAbb25ZZUSQ8yYwcvJksywf/ZpQj9sw?=
 =?us-ascii?Q?sWikLV7bOEkP9wm7+ClzolRzJ5Z5hTyWvzrAZtdZTegf9kHTJL6VfQ+mbU5E?=
 =?us-ascii?Q?bPBG4EuIGauGcQDLi28ikOEH92mkFMIBkCEKYHdhmVEYs/gqHELKdIwZY+T4?=
 =?us-ascii?Q?72j+CFlsw+l0KTnLawgl3bPvepLXuzHatvvvRGFBMvNJxsHqhD/O+YDrgBDu?=
 =?us-ascii?Q?vRO8SJo3owsfalJCr+BhUAKoT7fFDb/UpoeEbJVBb3FnbLQ5YE1hFpZGry1L?=
 =?us-ascii?Q?iVFeXsNg9wosQgQnKnx3S4L5BNgU6KTz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46af7fc-9ee6-46a8-48cf-08da0c7f20de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 03:42:18.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IIQyJQSFrheZKk0VEtbe7W7+jNuAQGfaNkzvnPfZCCKFRWy232iwzAHPR3BzcaWLlPhc/ZrKhL3rHMxefL0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6868
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
  Based on Bjorn's comments on V2-2
  Move the rproc_has_feature/rproc_set_feature to remoteproc_internal.h and
 Keep rproc_features still in remoteproc.h, because we use
 RPROC_MAX_FEATURES to declare bitmap.
  Update commit log for patch 2/2, and add comments
 
V3:
 Resend the wrong labeled patchset
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311

 Write a cover-letter
 To i.MX8QM/QXP, they have a M4 core self-recovery capability without
 Linux loading firmware. The self recovery is done by
 SCU(System Control Unit). Current remoteproc framework only support Linux
 help recovery remote processor(stop, loading firmware, start). This
 patchset is support remote processor self recovery(attach recovery).

 In order to avoid introducing a new variable(bool support_self_recovery),
 patch 1 introduce a new function, rproc_has_feature to make code easy to
 extend, cleaner, such as we could move "bool has_iommu" to
 rproc_has_feature(rproc, RPROC_FEAT_IOMMU).

 Patch 2 is introduce a new function rproc_attach_recovery for
 self recovery, the original logic move to rproc_firmware_recovery meaning
 needs linux to help recovery.

 V2-version 2:
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
 Introduce rproc_has_feature

 V2-version 1:
 https://patchwork.kernel.org/project/linux-remoteproc/patch/20220126085120.3397450-1-peng.fan@oss.nxp.com/
 Nothing change in V2.
 Only move this patch out from
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364



Peng Fan (2):
  remoteproc: introduce rproc features
  remoteproc: support attach recovery after rproc crash

 drivers/remoteproc/remoteproc_core.c     | 67 +++++++++++++++++-------
 drivers/remoteproc/remoteproc_internal.h | 10 ++++
 include/linux/remoteproc.h               |  7 +++
 3 files changed, 65 insertions(+), 19 deletions(-)

-- 
2.25.1

