Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173754D25BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiCIBEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiCIBEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:04:30 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA67275F6;
        Tue,  8 Mar 2022 16:41:55 -0800 (PST)
X-UUID: 5643b9c7fc6f4726a569dd98f1f01242-20220309
X-UUID: 5643b9c7fc6f4726a569dd98f1f01242-20220309
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 373336592; Wed, 09 Mar 2022 07:23:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 9 Mar 2022 07:23:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Mar 2022 07:23:33 +0800
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
Subject: Re: [PATCH v2 1/1] scsi: Fix racing between dev init and dev reset
Date:   Wed, 9 Mar 2022 07:23:33 +0800
Message-ID: <20220308232333.28978-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220308020725.16116-2-alice.chao@mediatek.com>
References: <20220308020725.16116-2-alice.chao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alice,

Thanks for your patch. I have some questions.

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

These are backtraces, and the things above looks like your solution, not
the problem.
It's better to describe the problem first and solution later:

Device init call:                              Device reset call:   
scsi_probe_and_add_lun()                       scsi_evt_thread()
  scsi_add_lun()
    scsi_sysfs_add_sdev()                        scsi_evt_emit()
      scsi_target_add()                            kobject_uevent_env() 
        device_add()                                 kobject_get_path() // something wrong?
	                                               fill_kobj_path()
	  get_device_parent() // I see a get, not create parent kobj, could you show me that point?
	  kobject_uevent()
            kobject_uevent_env()
              kobject_get_path()
                fill_kobj_path()

> 
> These two jobs are scheduled asynchronously, we can't guaranteed that
> kobj.parent will be created in device init thread before device reset
> thread calls kobj_get_path().

What happens if device reset thread calls kobj_get_path() before kobj.parent's
creation? a crash or something?

> 
> To resolve the racing issue between device init thread and device
> reset thread, we use wait_event() in scsi_evt_emit() to wait for
> device_add() to complete the creation of kobj.parent.
> 
> Signed-off-by: Alice Chao <alice.chao@mediatek.com>

When we send patch N+1, we have to put the change log between patch v1 to vN
under a "---", so others can understand the changes between patch N and N+1.
e.g.,

---

Change since v1
- remove Change-Id

> ---
>  drivers/scsi/scsi_lib.c  | 1 +
>  drivers/scsi/scsi_scan.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 0a70aa763a96..abf9a71ed77c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2461,6 +2461,7 @@ static void scsi_evt_emit(struct scsi_device *sdev, struct scsi_event *evt)
>  		break;
>  	case SDEV_EVT_POWER_ON_RESET_OCCURRED:
>  		envp[idx++] = "SDEV_UA=POWER_ON_RESET_OCCURRED";
> +		wait_event(sdev->host->host_wait, sdev->sdev_gendev.kobj.parent != NULL);
>  		break;
>  	default:
>  		/* do nothing */
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index f4e6c68ac99e..431f229ac435 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1904,6 +1904,7 @@ static void do_scsi_scan_host(struct Scsi_Host *shost)
>  	} else {
>  		scsi_scan_host_selected(shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
>  				SCAN_WILD_CARD, 0);
> +		wake_up(&shost->host_wait);

do_scsi_scan_host() is not in the call trace above, could you show the relationship
of do_scsi_scan_host in the call flow?

thanks,
Miles

>  	}
>  }
