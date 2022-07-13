Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB734573C42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiGMRzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGMRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:55:04 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6436620F75
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:55:03 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DGVwII016560;
        Wed, 13 Jul 2022 17:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=Vd5X4pebhPgRNBgsev16djsCScVsMJIg0cV3nu+BEjw=;
 b=f2iDE7TmVZWwkwLnqggklBefPYe4ALRK359q9PfvtXOYT+dkSdNYciEqGEHLo6zU7u6m
 oKTHlcaq2GNYPpYLaWrhu/bPsz1KPgn5eCAIBeTCQ+E4VYeJK6ue4GsjNYPt/zhUlW1r
 8g4a3ATgf6MMzLgP9Z8q3OZV8zTEgwX4niMtnHwPjdBVD1kEZaSTOkkwVsjjOKlcyMHj
 ZLXBwdjrtqJu7Z4BnKJ+1TVJ1NNlFlpyZ4dWX7cOeFxyqV6+Ho+N9EdswUmiKAJZHVPH
 LarAZPUby4Ju8mn9ZOjxOK8LxYhjcocUGBZm3XLFQtqyTRJGkSekHKZM/9lyLZGyhkuu 5A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3h9yvksy5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 17:54:59 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id E89F1D2CD;
        Wed, 13 Jul 2022 17:54:58 +0000 (UTC)
Received: from blofly.os1.tw (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D2FBD802F38;
        Wed, 13 Jul 2022 17:54:56 +0000 (UTC)
From:   matt.hsiao@hpe.com
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, jerry.hoemann@hpe.com,
        scott.norton@hpe.com, camille.lu@hpe.com, geoffrey.ndu@hpe.com,
        gustavo.knuppe@hpe.com, Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH v2 0/1] misc: hpilo: switch .{read,write} ops to .{read,write}_iter
Date:   Thu, 14 Jul 2022 01:54:51 +0800
Message-Id: <20220713175452.4221-1-matt.hsiao@hpe.com>
X-Mailer: git-send-email 2.16.6
X-Proofpoint-GUID: W4M7nKSUv0FdQ88qbFpx9NL8rFGSlwc5
X-Proofpoint-ORIG-GUID: W4M7nKSUv0FdQ88qbFpx9NL8rFGSlwc5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_07,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=858
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130073
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Hsiao <matt.hsiao@hpe.com>

This patch changes .{read,write} ops to their iter variants for
dependent drivers to use hpilo through kernel_{read,write}.

Changes since v1:
- Fix the patch format so it could be applied cleanly.

Matt Hsiao (1):
  misc: hpilo: switch .{read,write} ops to .{read,write}_iter

 drivers/misc/hpilo.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

-- 
2.16.6

