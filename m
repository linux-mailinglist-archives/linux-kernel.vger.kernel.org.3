Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE7A4C2C20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiBXMu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiBXMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:50:15 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C1F1E3745
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645706975; x=1677242975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hFrzqtmq0TTXDCsXI1fBtGLsq/MQUQ3c1RH8HRklIys=;
  b=BfrE/bDsSU3SL0sO8VgYw27Rdje8ZHVS4plvJeY2LBoErByvT3xpRqf5
   cSZk8UDvMqUjdibKPMH0Dn7oxoFbAYlvqbnfPY2K+4kuhw2uu7l9DgiBZ
   PjtITKL30HMzVxqrTfoXPi6lpqsb0PnqBP60/HROOtcpLgBI0SPlIQhUP
   CMKafWdlmMOL+lzJXX7y2q5YOSyaUD6zWIEZ50STZf2WFK6uXpCA4PmBw
   ONJvUvvXuleMvOxgLcD4hUayMKJGxiofXj9p6tRYDsLspg+/IF5LAOFDg
   UiGI5md5+XeGWbRyzzW4dkD9y/wREq5KvnRNspk9CdNUQPb9kF2wLotgf
   A==;
X-IronPort-AV: E=Sophos;i="5.90,133,1643644800"; 
   d="scan'208";a="192779566"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2022 20:49:35 +0800
IronPort-SDR: DeNynNMTp2z/4NfLx5hPTX6Pa/JnueRPkPbPFr923NWbfb6R9lUyArgURPbCc7q7lXymA4z8vx
 52FSVhLSujGKI4j8VBEwBXC5mvElCvd2ktuXVkH1NkToRdKmcPU+F+OxUqhB6N7uRPYEAgsH6/
 bPmd2JMhtu0e5ykWCklvGciGP/vYCIO/Tw6rw5a65YfF+8d2CX8CHhM372cKqAyg4FWUFkso4d
 duENW6kKnZttbP1EgvgDZvYkqzK87zB3yVWlsXrbFwa+Upu+IqytusNfEXaBWgyxUAu9LgO0TW
 4k7eilpvwn1Yfq/HJ3SjOFFJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 04:22:11 -0800
IronPort-SDR: Aescq/AdMNwdwwdsKMmmw7lrdvjZKy2mb8B7YsBngv6IW2HZun5ELpnG+hlcmW9fcTuGo1GI9k
 duJf8lk2tvAtiSVS9oGLJsrvE+shibgDUgvuRNGvV/zSRnXwg4sSAR0IYp0nPkRWOE/pBSpAHt
 mQ28UYzo2q4GGeJSc3bBTk+KKFev2VI0gHsgVZe6d/S6crsGix5jIZn26Fq0RZ88pXmhWtHQo5
 loZAzWAZHAu6JcgSR81tH4wG1incWTqr1Vfyk/lZWhh8zjwjxZHzMgigZoLcFC4bZAga41tMe/
 8ck=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 04:49:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K4CR30SFHz1SVnx
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:49:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645706974; x=1648298975; bh=hFrzqtmq0TTXDCsXI1fBtGLsq/MQUQ3c1RH
        8HRklIys=; b=FZAh2zCcsHg6Q2OcsCOtCQgOhHeQ7OxwZUkSjggOmbpb3jRVbiR
        v4XD2W6q7tbNKPE8z81W/uR+c9kZVcKCM9HHWhtyXOjniLcOQgV+zjsZ0VOpOKKB
        Xz6loa8UncBskn70W+ESOpWxiPGEC/3UI9d5dlPunR6r5fACa/5U/7us06zX8bnO
        tp8jNvk1y+EG+SMBVtfPRf7mbJ6YZhywnONR2RiXlAj/UPFCP3/RQZGaUk4JA1K5
        u1ZoDeonojNJasXjOC/a2RRlcwnKi7K3NiJR9zHy5Q21BUEXV2U83uwnWN6IjXMB
        bbyr+c3unzYNtfHA0Ih1BDxqP/yROVuBYiw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y1v2A6mE9VeR for <linux-kernel@vger.kernel.org>;
        Thu, 24 Feb 2022 04:49:34 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K4CR10wjDz1Rvlx;
        Thu, 24 Feb 2022 04:49:32 -0800 (PST)
Message-ID: <4b107020-2494-2470-ba1b-c2000eae1355@opensource.wdc.com>
Date:   Thu, 24 Feb 2022 21:49:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] scsi: libsas: Use bool for queue_work() return code
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenxiang66@hisilicon.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1645700699-82369-1-git-send-email-john.garry@huawei.com>
 <1645700699-82369-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1645700699-82369-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 20:04, John Garry wrote:
> Function queue_work() returns a bool, so use a bool to hold this value
> for the return code, which should make the code a tiny bit more clear.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/libsas/sas_event.c    | 23 +++++++++--------------
>  drivers/scsi/libsas/sas_internal.h |  2 +-
>  2 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_event.c b/drivers/scsi/libsas/sas_event.c
> index 8ff58fd97837..e5eb24100e2d 100644
> --- a/drivers/scsi/libsas/sas_event.c
> +++ b/drivers/scsi/libsas/sas_event.c
> @@ -10,13 +10,13 @@
>  #include <scsi/scsi_host.h>
>  #include "sas_internal.h"
>  
> -int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
> +bool sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
>  {
>  	/* it's added to the defer_q when draining so return succeed */
> -	int rc = 1;
> +	bool rc = true;
>  
>  	if (!test_bit(SAS_HA_REGISTERED, &ha->state))
> -		return 0;
> +		return false;
>  
>  	if (test_bit(SAS_HA_DRAINING, &ha->state)) {
>  		/* add it to the defer list, if not already pending */
> @@ -28,11 +28,11 @@ int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
>  	return rc;

While at it, I would cleanup this function like this:

diff --git a/drivers/scsi/libsas/sas_event.c
b/drivers/scsi/libsas/sas_event.c
index 3613b9b315bc..38e6e91aaf36 100644
--- a/drivers/scsi/libsas/sas_event.c
+++ b/drivers/scsi/libsas/sas_event.c
@@ -12,20 +12,17 @@

 int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
 {
-       /* it's added to the defer_q when draining so return succeed */
-       int rc = 1;
-
        if (!test_bit(SAS_HA_REGISTERED, &ha->state))
-               return 0;
+               return false;

        if (test_bit(SAS_HA_DRAINING, &ha->state)) {
                /* add it to the defer list, if not already pending */
                if (list_empty(&sw->drain_node))
                        list_add_tail(&sw->drain_node, &ha->defer_q);
-       } else
-               rc = queue_work(ha->event_q, &sw->work);
+               return true;
+       }

-       return rc;
+       return queue_work(ha->event_q, &sw->work);
 }

No local variable :)

>  }
>  
> -static int sas_queue_event(int event, struct sas_work *work,
> +static bool sas_queue_event(int event, struct sas_work *work,
>  			    struct sas_ha_struct *ha)
>  {
>  	unsigned long flags;
> -	int rc;
> +	bool rc;
>  
>  	spin_lock_irqsave(&ha->lock, flags);
>  	rc = sas_queue_work(ha, work);
> @@ -44,13 +44,12 @@ static int sas_queue_event(int event, struct sas_work *work,
>  void sas_queue_deferred_work(struct sas_ha_struct *ha)
>  {
>  	struct sas_work *sw, *_sw;
> -	int ret;
>  
>  	spin_lock_irq(&ha->lock);
>  	list_for_each_entry_safe(sw, _sw, &ha->defer_q, drain_node) {
>  		list_del_init(&sw->drain_node);
> -		ret = sas_queue_work(ha, sw);
> -		if (ret != 1) {
> +
> +		if (sas_queue_work(ha, sw) == false) {

if (!sas_queue_work(ha, sw)) ?

>  			pm_runtime_put(ha->dev);
>  			sas_free_event(to_asd_sas_event(&sw->work));
>  		}
> @@ -170,7 +169,6 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>  {
>  	struct sas_ha_struct *ha = phy->ha;
>  	struct asd_sas_event *ev;
> -	int ret;
>  
>  	BUG_ON(event >= PORT_NUM_EVENTS);
>  
> @@ -186,8 +184,7 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>  	if (sas_defer_event(phy, ev))
>  		return;
>  
> -	ret = sas_queue_event(event, &ev->work, ha);
> -	if (ret != 1) {
> +	if (sas_queue_event(event, &ev->work, ha) == false) {

Same.

>  		pm_runtime_put(ha->dev);
>  		sas_free_event(ev);
>  	}
> @@ -199,7 +196,6 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>  {
>  	struct sas_ha_struct *ha = phy->ha;
>  	struct asd_sas_event *ev;
> -	int ret;
>  
>  	BUG_ON(event >= PHY_NUM_EVENTS);
>  
> @@ -215,8 +211,7 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>  	if (sas_defer_event(phy, ev))
>  		return;
>  
> -	ret = sas_queue_event(event, &ev->work, ha);
> -	if (ret != 1) {
> +	if (sas_queue_event(event, &ev->work, ha) == false) {

And again.

>  		pm_runtime_put(ha->dev);
>  		sas_free_event(ev);
>  	}
> diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
> index 24843db2cb65..13d0ffaada93 100644
> --- a/drivers/scsi/libsas/sas_internal.h
> +++ b/drivers/scsi/libsas/sas_internal.h
> @@ -67,7 +67,7 @@ void sas_porte_broadcast_rcvd(struct work_struct *work);
>  void sas_porte_link_reset_err(struct work_struct *work);
>  void sas_porte_timer_event(struct work_struct *work);
>  void sas_porte_hard_reset(struct work_struct *work);
> -int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw);
> +bool sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw);
>  
>  int sas_notify_lldd_dev_found(struct domain_device *);
>  void sas_notify_lldd_dev_gone(struct domain_device *);


-- 
Damien Le Moal
Western Digital Research
