Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3D4FF036
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiDMGz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDMGzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:55:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AEF29C84;
        Tue, 12 Apr 2022 23:53:29 -0700 (PDT)
X-UUID: 2f01c031cc91458a80812bce1864c06c-20220413
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:d3e08e59-1505-4517-b68e-d159e6d51df9,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:52,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:52
X-CID-INFO: VERSION:1.1.4,REQID:d3e08e59-1505-4517-b68e-d159e6d51df9,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:52,FILE:0,RULE:Release_UHam,ACTI
        ON:release,TS:52
X-CID-META: VersionHash:faefae9,CLOUDID:e33bfea8-d103-4e36-82b9-b0e86991b3df,C
        OID:2f989790bfaf,Recheck:0,SF:13|15|28|16|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 2f01c031cc91458a80812bce1864c06c-20220413
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <alice.chao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2132525755; Wed, 13 Apr 2022 14:53:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 13 Apr 2022 14:53:23 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Apr 2022 14:53:23 +0800
Message-ID: <7ad2e7fc39ce0d2b145f651d530d157c67c04f29.camel@mediatek.com>
Subject: Re: [PATCH v2 1/1] scsi: Fix racing between dev init and dev reset
From:   Alice Chao <alice.chao@mediatek.com>
To:     Miles Chen <miles.chen@mediatek.com>
CC:     CC Chou =?UTF-8?Q?=28=E5=91=A8=E5=BF=97=E6=9D=B0=29?= 
        <cc.chou@mediatek.com>,
        Chaotian Jing =?UTF-8?Q?=28=E4=BA=95=E6=9C=9D=E5=A4=A9=29?= 
        <Chaotian.Jing@mediatek.com>,
        Chun-Hung Wu =?UTF-8?Q?=28=E5=B7=AB=E9=A7=BF=E5=AE=8F=29?= 
        <Chun-hung.Wu@mediatek.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Jiajie Hao =?UTF-8?Q?=28=E9=83=9D=E5=8A=A0=E8=8A=82=29?= 
        <jiajie.hao@mediatek.com>,
        "jonathan.hsu@mediatek.com" <jonathan.hsu@mediatek.com>,
        Lin Gui =?UTF-8?Q?=28=E6=A1=82=E6=9E=97=29?= 
        <Lin.Gui@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        Peter Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=8F=8B=29?= 
        <peter.wang@mediatek.com>,
        Powen Kao =?UTF-8?Q?=28=E9=AB=98=E4=BC=AF=E6=96=87=29?= 
        <Powen.Kao@mediatek.com>,
        Qilin Tan =?UTF-8?Q?=28=E8=B0=AD=E9=BA=92=E9=BA=9F=29?= 
        <Qilin.Tan@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "Yanxu Wei =?UTF-8?Q?=28=E9=9F=A6=E6=99=8F=E6=97=AD=29?=" 
        <Yanxu.Wei@mediatek.com>
Date:   Wed, 13 Apr 2022 14:53:23 +0800
In-Reply-To: <20220308232333.28978-1-miles.chen@mediatek.com>
References: <20220308020725.16116-2-alice.chao@mediatek.com>
         <20220308232333.28978-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

On Wed, 2022-03-09 at 07:23 +0800, Miles Chen wrote:
> Hi Alice,
> 
> Thanks for your patch. I have some questions.
> 
> > Device reset thread uses kobject_uevent_env() to get kobj.parent
> > after scsi_evt_emit(), and it races with device init thread which
> > calls device_add() to create kobj.parent before
> > kobject_uevent_env().
> > 
> > Device reset call trace:
> > fill_kobj_path
> > kobject_get_path
> > kobject_uevent_env
> > scsi_evt_emit			<- add wait_event()
> > scsi_evt_thread
> > 
> > Device init call trace:
> > fill_kobj_path
> > kobject_get_path
> > kobject_uevent_env
> > device_add				<- create kobj.parent
> > scsi_target_add
> > scsi_sysfs_add_sdev
> > scsi_add_lun
> > scsi_probe_and_add_lun
> 
> These are backtraces, and the things above looks like your solution,
> not
> the problem.
> It's better to describe the problem first and solution later:
> 
> Device init call:                              Device reset call:   
> scsi_probe_and_add_lun()                       scsi_evt_thread()
>   scsi_add_lun()
>     scsi_sysfs_add_sdev()                        scsi_evt_emit()
>       scsi_target_add()                            kobject_uevent_env
> () 
>         device_add()                                 kobject_get_path
> () // something wrong?
> 	                                               fill_kobj_path()
> 	  get_device_parent() // I see a get, not create parent kobj,
> could you show me that point?
> 	  kobject_uevent()
>             kobject_uevent_env()
>               kobject_get_path()
>                 fill_kobj_path()
> 

Device init call:	   Device reset call:
scsi_probe_and_add_lun()   scsi_evt_thread()
  scsi_add_lun()	    scsi_evt_emit()
   scsi_sysfs_add_sdev()     kobject_uevent_env() //get kobj.parent
    scsi_target_add()	      kobject_get_path() //get wrong
kobj.parent     device_add() // add kobj.parent  fill_kobj_path()
      kobject_uevent_env()
       kobject_get_path()
        fill_kobj_path()
Above backtrace describes the problem, device reset thread will get
wrong kobj.parent when device init thread didn’t add kobj.parent yet.

> > 
> > These two jobs are scheduled asynchronously, we can't guaranteed
> > that
> > kobj.parent will be created in device init thread before device
> > reset
> > thread calls kobj_get_path().
> 
> What happens if device reset thread calls kobj_get_path() before
> kobj.parent's
> creation? a crash or something?
> 

It will cause slab-out-of-bounds in kobject_get_path and kernel panic
than crash.

> > 
> > To resolve the racing issue between device init thread and device
> > reset thread, we use wait_event() in scsi_evt_emit() to wait for
> > device_add() to complete the creation of kobj.parent.
> > 
> > Signed-off-by: Alice Chao <alice.chao@mediatek.com>
> 
> When we send patch N+1, we have to put the change log between patch
> v1 to vN
> under a "---", so others can understand the changes between patch N
> and N+1.
> e.g.,
> 
> ---
> 
> Change since v1
> - remove Change-Id
> 
> > ---
> >  drivers/scsi/scsi_lib.c  | 1 +
> >  drivers/scsi/scsi_scan.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index 0a70aa763a96..abf9a71ed77c 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -2461,6 +2461,7 @@ static void scsi_evt_emit(struct scsi_device
> > *sdev, struct scsi_event *evt)
> >  		break;
> >  	case SDEV_EVT_POWER_ON_RESET_OCCURRED:
> >  		envp[idx++] = "SDEV_UA=POWER_ON_RESET_OCCURRED";
> > +		wait_event(sdev->host->host_wait, sdev-
> > >sdev_gendev.kobj.parent != NULL);
> >  		break;
> >  	default:
> >  		/* do nothing */
> > diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> > index f4e6c68ac99e..431f229ac435 100644
> > --- a/drivers/scsi/scsi_scan.c
> > +++ b/drivers/scsi/scsi_scan.c
> > @@ -1904,6 +1904,7 @@ static void do_scsi_scan_host(struct
> > Scsi_Host *shost)
> >  	} else {
> >  		scsi_scan_host_selected(shost, SCAN_WILD_CARD,
> > SCAN_WILD_CARD,
> >  				SCAN_WILD_CARD, 0);
> > +		wake_up(&shost->host_wait);
> 
> do_scsi_scan_host() is not in the call trace above, could you show
> the relationship
> of do_scsi_scan_host in the call flow?
> 

ufshcd_async_scan()
scsi_scan_host()
do_scsi_scan_host()  << here
scsi_scan_host_selected()
 __scsi_scan_target()
scsi_probe_and_add_lun()
scsi_sysfs_add_sdev()
device_add()
kobject_uevent_env()
kobject_get_path()
fill_kobj_path()

After we add wake_up here, we can ensure that device reset thread will
get kobject after device init thread finishes adding parent.

> thanks,
> Miles
> 
> >  	}
> >  }

