Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E36535A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbiE0HQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347541AbiE0HP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:15:29 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED0B40A1D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653635728; x=1685171728;
  h=message-id:date:mime-version:from:subject:to:references:
   in-reply-to:content-transfer-encoding;
  bh=Uq6Y6JcpS+LMkF9yM/5ASHepbZuL0onP3nIIGb/A/X8=;
  b=ddEqiJ6CasivCy/7y4ZgV3Ip0lrRqUfJM7yFAYl68t+G/4OSsAkZ+66c
   j2qjIRd1zugXDNlUjhlCU19OywoUcU0K2RQewM8qMdK495Fn440gvqxtz
   CLj+UYlnoDVBKrlZHG5TndgZ8NkM+dvsEvYZW9va1aNsrNGCe+rAbmGnh
   cSapc8lHUa2TGx4vhmyLqTrAoboQB/6XDzUrMrYKoHew5PeAjiCD0MG+M
   ILRhcoOzJ2pBTrdks3FzVMj0AG89lu5nje+U6sPd+ipWB7TEaUh5/GGWX
   El12HWv60v1VGLAHdDWRKEoXm5v6Wpa2qfTXxUJRhB9HR+wiev3vuF+p4
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,254,1647273600"; 
   d="scan'208";a="202415915"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2022 15:15:27 +0800
IronPort-SDR: /46JUq41C58pS/XPGVD405yu2dODTenMFwI/1rewtK3eFUEyer/GyBjcbD49cztMQ1NBrsd3dg
 pAIOYx5MQeF7oDNHw2tsUv1YWUet8D2KbttdqTyK+p9wo4HRect6QQVOkxbrbq9IbZ8qQvbyFg
 rS9yyP1PBagPkFmZYju1Q9dmw4KqKR2e191cYXOyoYLS9U3w0zPD//eylGWCT+1thymXQ0RX1Z
 ZuwEzME1nWYrlWRNMvVT9jn+gtUW/kPSMLTGd3VmYCN0Ifava6AobupI4onjVHwfOdkX0yuwwk
 Q2G8VyN/tlWvAy5mSZifgOkj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 23:39:19 -0700
IronPort-SDR: EVyasxcVkmOunkc8QD21bhBZfarPCW+Wa0CWemiCh6GQS795DdVCKt/4Gi1Heo7cxIucEFTcTx
 jBDhx06wwBYOtHNWDNJlHCKhqYtO7zM0kl3UpmU9/cwRWlBEYPdr/PalJUQ47FwfnH2rl8b0De
 arapTHUIJNoUCUIxyif0FlnBI4YsKgpn8xY0xghooervGfAAUko+7aIS3xN89AzO1Q10TI1+6C
 uqzXLG5/+t1bJAB5+4bRn2S7WSQ3Zu/xv1d7gwbsKBap1cemOXng4ea3qu/ca8iQrmB7MapDH/
 f78=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2022 00:15:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L8bg24z0Sz1Rwrw
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:15:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:content-language:references:to:subject
        :from:user-agent:mime-version:date:message-id; s=dkim; t=
        1653635726; x=1656227727; bh=Uq6Y6JcpS+LMkF9yM/5ASHepbZuL0onP3nI
        IGb/A/X8=; b=XtY3DQZwgwlIB7gLXrn6o2ydAFXNcTo4iCqd+S55/vxOOgtFaUL
        w04lrZbN6tulVtPQHbn/QEBJz5IZDUxPinI0/4OfxlyUyM2fykMC2Djrz2f6ttnC
        yYEZJsXuZv1MBKe49DsmbqvqS8G01UsiFf2e3tHf0mMRJZeW6kXSz24IYprxPR9y
        LxBwYSHKfdVlSaxJ+sMxKM+yDuGNbsrVG9v5YoCI2hGvAhk6hYwmprrDpTT9SD0T
        xG3QHrfThArB2i7vi0ro2583i6D+uhVxUAlPGD64UOUOKvyu7jpzGRqhWOJ7Y4cR
        GDd84aSFuxzBVkfeAP9YYsXSkbnnMVnDlLg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8FiD3znbysVj for <linux-kernel@vger.kernel.org>;
        Fri, 27 May 2022 00:15:26 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L8bg13fXrz1Rvlc;
        Fri, 27 May 2022 00:15:25 -0700 (PDT)
Message-ID: <3f35b011-4aab-4c9e-4a0d-220d7babba5d@opensource.wdc.com>
Date:   Fri, 27 May 2022 16:15:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: Null Pointer Dereference in sd_zbc_release_disk
To:     Dongliang Mu <mudongliangabcd@gmail.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAD-N9QXY57RvFwGQvh8U7WBc3JCX-0kpqB6+fZ=oJJtHmFdUwg@mail.gmail.com>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAD-N9QXY57RvFwGQvh8U7WBc3JCX-0kpqB6+fZ=oJJtHmFdUwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/27 14:51, Dongliang Mu wrote:
> Hi maintainers,
> 
> I found a NPD(Null Pointer Dereference) in sd_zbc_release_disk function.
> 
> There are two definitions of sd_zbc_release_disk:
> 
> #ifdef CONFIG_BLK_DEV_ZONED
> void sd_zbc_release_disk(struct scsi_disk *sdkp);
> #else /* CONFIG_BLK_DEV_ZONED */
> static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}
> #endif
> 
> When CONFIG_BLK_DEV_ZONED=y, the function implementation is as follows:
> 
> void sd_zbc_release_disk(struct scsi_disk *sdkp)
> {
>     if (sd_is_zoned(sdkp))
>         sd_zbc_clear_zone_info(sdkp);
> }
> 
> static inline int sd_is_zoned(struct scsi_disk *sdkp)
> {
>     return sdkp->zoned == 1 || sdkp->device->type == TYPE_ZBC;
> }
> 
> In drivers/scsi/sd.c, sd_probe() allocates sdkp with kzalloc(). If
> errors occurred before the assignment "sdkp->device", after the
> allocation, it will triggers a NPD in sd_is_zoned.
> 
> I am not familiar with kernel configuration. Does anyone have a
> suggestion to fix this NPD?
> 
> I really appreciate any help you can provide.

Can you try this patch:

 From 875899a114bce34f9549857ce87ea309b366b1cb Mon Sep 17 00:00:00 2001
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Date: Fri, 27 May 2022 16:07:20 +0900
Subject: [PATCH] scsi: sd_zbc: Fix potential NULL pointer dereference

If sd_probe() sees an error before sdkp->device is initialized,
sd_zbc_release_disk() is called, which causes a NULL pointer dereference
when sd_is_zoned() is called. Avoid this by turning
sd_zbc_release_disk() into a nop if sdkp->device is NULL.

Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
  drivers/scsi/sd_zbc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 5b9fad70aa88..236a766c8de4 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -804,7 +804,7 @@ static void sd_zbc_clear_zone_info(struct scsi_disk 
*sdkp)

  void sd_zbc_release_disk(struct scsi_disk *sdkp)
  {
-	if (sd_is_zoned(sdkp))
+	if (sdkp->device && sd_is_zoned(sdkp))
  		sd_zbc_clear_zone_info(sdkp);
  }

-- 
2.36.1


-- 
Damien Le Moal
Western Digital Research
