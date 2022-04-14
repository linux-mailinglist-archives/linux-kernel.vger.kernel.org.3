Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FC500820
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbiDNIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDNIVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:21:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BAF53E32;
        Thu, 14 Apr 2022 01:18:54 -0700 (PDT)
X-UUID: 459a53c71c984665960a7f6183dc996d-20220414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:e81c5580-aadf-4766-a885-d550ae18b7f9,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:e81c5580-aadf-4766-a885-d550ae18b7f9,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:56345d78-0afa-4dca-bdec-ca54c998425a,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: 459a53c71c984665960a7f6183dc996d-20220414
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 287361542; Thu, 14 Apr 2022 16:18:48 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 Apr 2022 16:18:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Apr
 2022 16:18:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 16:18:46 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <alice.chao@mediatek.com>
CC:     <Chaotian.Jing@mediatek.com>, <Chun-hung.Wu@mediatek.com>,
        <Lin.Gui@mediatek.com>, <Powen.Kao@mediatek.com>,
        <Qilin.Tan@mediatek.com>, <Yanxu.Wei@mediatek.com>,
        <cc.chou@mediatek.com>, <jejb@linux.ibm.com>,
        <jiajie.hao@mediatek.com>, <jonathan.hsu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <wsd_upstream@mediatek.com>
Subject: Re: [PATCH v2 1/1] scsi: Fix racing between dev init and dev reset
Date:   Thu, 14 Apr 2022 16:18:46 +0800
Message-ID: <20220414081846.31356-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <7ad2e7fc39ce0d2b145f651d530d157c67c04f29.camel@mediatek.com>
References: <7ad2e7fc39ce0d2b145f651d530d157c67c04f29.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alice, 

>Hi Miles,
>
>On Wed, 2022-03-09 at 07:23 +0800, Miles Chen wrote:
>> Hi Alice,
>> 
>> Thanks for your patch. I have some questions.
>> 
>> > Device reset thread uses kobject_uevent_env() to get kobj.parent
>> > after scsi_evt_emit(), and it races with device init thread which
>> > calls device_add() to create kobj.parent before
>> > kobject_uevent_env().
>> > 
>> > Device reset call trace:
>> > fill_kobj_path
>> > kobject_get_path
>> > kobject_uevent_env
>> > scsi_evt_emit			<- add wait_event()
>> > scsi_evt_thread
>> > 
>> > Device init call trace:
>> > fill_kobj_path
>> > kobject_get_path
>> > kobject_uevent_env
>> > device_add				<- create kobj.parent
>> > scsi_target_add
>> > scsi_sysfs_add_sdev
>> > scsi_add_lun
>> > scsi_probe_and_add_lun
>> 
>> These are backtraces, and the things above looks like your solution,
>> not
>> the problem.
>> It's better to describe the problem first and solution later:
>> 
>> Device init call:                              Device reset call:   
>> scsi_probe_and_add_lun()                       scsi_evt_thread()
>>   scsi_add_lun()
>>     scsi_sysfs_add_sdev()                        scsi_evt_emit()
>>       scsi_target_add()                            kobject_uevent_env
>> () 
>>         device_add()                                 kobject_get_path
>> () // something wrong?
>> 	                                               fill_kobj_path()
>> 	  get_device_parent() // I see a get, not create parent kobj,
>> could you show me that point?
>> 	  kobject_uevent()
>>             kobject_uevent_env()
>>               kobject_get_path()
>>                 fill_kobj_path()
>> 
>
>Device init call:	   Device reset call:
>scsi_probe_and_add_lun()   scsi_evt_thread()
>  scsi_add_lun()	    scsi_evt_emit()
>   scsi_sysfs_add_sdev()     kobject_uevent_env() //get kobj.parent
>    scsi_target_add()	      kobject_get_path() //get wrong
>kobj.parent     device_add() // add kobj.parent  fill_kobj_path()
>      kobject_uevent_env()
>       kobject_get_path()
>        fill_kobj_path()
>Above backtrace describes the problem, device reset thread will get
>wrong kobj.parent when device init thread didn’t add kobj.parent yet.

Thanks for sharing the error log, I think it is clearer this way:

Device init call:	           Device reset call:
scsi_probe_and_add_lun()              scsi_evt_thread()
  scsi_add_lun()	                scsi_evt_emit()
   scsi_sysfs_add_sdev()                  kobject_uevent_env() //get kobj.parent
    scsi_target_add()	                    kobject_get_path()
                                              len = get_kobj_path_length () // len=1 because parent is not create yet     
    device_add() // add kobj.parent               
      kobject_uevent_env()                 
       kobject_get_path()                     path = kzalloc()
        fill_kobj_path()	              fill_kobj_path() // --length; length -= cur is a negative value
	                                        memcpy(path + length, kobject_name(parent), cur); // slab OOB!

Now I understood this slab OOB issue, please add the kasan log and the
analysis to the commit message so the maintainers can see it and help.

>
>> > 
>> > These two jobs are scheduled asynchronously, we can't guaranteed
>> > that
>> > kobj.parent will be created in device init thread before device
>> > reset
>> > thread calls kobj_get_path().
>> 
>> What happens if device reset thread calls kobj_get_path() before
>> kobj.parent's
>> creation? a crash or something?
>> 
>
>It will cause slab-out-of-bounds in kobject_get_path and kernel panic
>than crash.

Okay, please add the KASAN slab-out-of-bounds error in the commit message.

Thanks,
Miles
>
>> > 
>> > To resolve the racing issue between device init thread and device
>> > reset thread, we use wait_event() in scsi_evt_emit() to wait for
>> > device_add() to complete the creation of kobj.parent.
>> > 
>> > Signed-off-by: Alice Chao <alice.chao@mediatek.com>
>> 
>> When we send patch N+1, we have to put the change log between patch
>> v1 to vN
>> under a "---", so others can understand the changes between patch N
>> and N+1.
>> e.g.,
>> 
>> ---
>> 
>> Change since v1
>> - remove Change-Id
>> 
>> > ---
>> >  drivers/scsi/scsi_lib.c  | 1 +
>> >  drivers/scsi/scsi_scan.c | 1 +
>> >  2 files changed, 2 insertions(+)
>> > 
>> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> > index 0a70aa763a96..abf9a71ed77c 100644
>> > --- a/drivers/scsi/scsi_lib.c
>> > +++ b/drivers/scsi/scsi_lib.c
>> > @@ -2461,6 +2461,7 @@ static void scsi_evt_emit(struct scsi_device
>> > *sdev, struct scsi_event *evt)
>> >  		break;
>> >  	case SDEV_EVT_POWER_ON_RESET_OCCURRED:
>> >  		envp[idx++] = "SDEV_UA=POWER_ON_RESET_OCCURRED";
>> > +		wait_event(sdev->host->host_wait, sdev-
>> > >sdev_gendev.kobj.parent != NULL);
>> >  		break;
>> >  	default:
>> >  		/* do nothing */
>> > diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
>> > index f4e6c68ac99e..431f229ac435 100644
>> > --- a/drivers/scsi/scsi_scan.c
>> > +++ b/drivers/scsi/scsi_scan.c
>> > @@ -1904,6 +1904,7 @@ static void do_scsi_scan_host(struct
>> > Scsi_Host *shost)
>> >  	} else {
>> >  		scsi_scan_host_selected(shost, SCAN_WILD_CARD,
>> > SCAN_WILD_CARD,
>> >  				SCAN_WILD_CARD, 0);
>> > +		wake_up(&shost->host_wait);
>> 
>> do_scsi_scan_host() is not in the call trace above, could you show
>> the relationship
>> of do_scsi_scan_host in the call flow?
>> 
>
>ufshcd_async_scan()
>scsi_scan_host()
>do_scsi_scan_host()  << here
>scsi_scan_host_selected()
> __scsi_scan_target()
>scsi_probe_and_add_lun()
>scsi_sysfs_add_sdev()
>device_add()
>kobject_uevent_env()
>kobject_get_path()
>fill_kobj_path()
>
>After we add wake_up here, we can ensure that device reset thread will
>get kobject after device init thread finishes adding parent.
>
>> thanks,
>> Miles
>> 
>> >  	}
>> >  }
>
>
