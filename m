Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7DE4CC98B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiCCW7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiCCW7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:59:15 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A416F40E56;
        Thu,  3 Mar 2022 14:58:24 -0800 (PST)
X-UUID: a3c0849d45d34e17a737fd33f7840dc5-20220304
X-UUID: a3c0849d45d34e17a737fd33f7840dc5-20220304
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 309536899; Fri, 04 Mar 2022 06:58:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 4 Mar 2022 06:58:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Mar 2022 06:58:18 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <alice.chao@mediatek.com>
CC:     <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <jejb@linux.ibm.com>,
        <jiajie.hao@mediatek.com>, <jonathan.hsu@mediatek.com>,
        <lin.gui@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <matthias.bgg@gmail.com>,
        <peter.wang@mediatek.com>, <powen.kao@mediatek.com>,
        <qilin.tan@mediatek.com>, <stanley.chu@mediatek.com>,
        <wsd_upstream@mediatek.com>, <yanxu.wei@mediatek.com>
Subject: Re: [PATCH 1/1] scsi: Fix racing between dev init and dev reset
Date:   Fri, 4 Mar 2022 06:58:18 +0800
Message-ID: <20220303225818.12752-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220303075527.25258-2-alice.chao@mediatek.com>
References: <20220303075527.25258-2-alice.chao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SORTED_RECIPS,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alice,

> Device reset thread uses kobject_uevent_env() to get kobj.parent
> after scsi_evt_emit(), and it races with device init thread which
> calls device_add() to create kobj.parent before kobject_uevent_env().
> 
> Device reset call trace:
> fill_kobj_path
> kobject_get_path
> kobject_uevent_env
> scsi_evt_emit			<- add wait_event()
> scsi_evt_thread
> 
> Device init call trace:
> fill_kobj_path
> kobject_get_path
> kobject_uevent_env
> device_add				<- create kobj.parent
> scsi_target_add
> scsi_sysfs_add_sdev
> scsi_add_lun
> scsi_probe_and_add_lun
> 
> These two jobs are scheduled asynchronously, we can't guaranteed that
> kobj.parent will be created in device init thread before device reset
> thread calls kobj_get_path().
> 
> To resolve the racing issue between device init thread and device
> reset thread, we use wait_event() in scsi_evt_emit() to wait for
> device_add() to complete the creation of kobj.parent.
> 
> Signed-off-by: Alice Chao <alice.chao@mediatek.com>
> Change-Id: I2848cf054186739d3a125a0635dbed5539557e64

please remove Change-Id here

thanks,
Miles
