Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DBA4C5938
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 05:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiB0EAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 23:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiB0EAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 23:00:41 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835821DB3D7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645934405; x=1677470405;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+xrsuOI9TEYJqO66rOjju0qwmMM8tmROUCmeVCpyQHI=;
  b=GPqIabfHQR1Liod4MttaTGFrOIfGgPpJEjIytL30JqeFE1wpTB9OO0r+
   KP9TCjjfhTrXCQ69z46BNbDRuJ7aKSaa/aewNtgSKVeHcSEmwvL05uUQT
   wf91EmzVTEyXvFjG93ITM8fJweRr3QugROUjZX2nYdsG0dhFGeCXKbP2e
   pH3ed0KEPrFb/2xmflxGOKwoL11OOocalEIvQEWVxecH2JDVclvxqTXYe
   Ipx/GjANJrHhnv7/7R8sZpbc3D8HVdcaaluHLbHwldLrTjuJdGzNbu4B1
   8lLpM5rjrz9TK5k9kn0FSVC8Mt9X7fdxEoNIGgRLurJ/vkBS8gQkwMAJ1
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,140,1643644800"; 
   d="scan'208";a="192948254"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2022 12:00:04 +0800
IronPort-SDR: in1DlKSmUsD/vyp/tmbnwtsSalNxqxLVtV1YredG8ANPphcddr59rCCrNs310wGxGtbZNrT6bU
 rOaiy+JfiJuqCSdL9GIn+OswdoAaI0KP7eYmD7h6TqVThDDG+Gl+ICIhj5mubrkpCfvEaj6xn0
 2+0jMS8JqNawRfy3N/ctmHZnGBCTwQnI0i/du99Khb4zXJ9G/qGxVC0VTJD4MGoDxYk7R6cZB/
 Xk2PoalrwigRhzpvdaoHgR5Dv9XPVZsyeYkNsmDJyXLHk8oYe7x+GDe+aHB5njX/vZJUEIBKE7
 TYAWACyLzAlybzjnvYdcjrKA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 19:31:31 -0800
IronPort-SDR: Cdyosb4NwA54HDiUpKQQEZZYbxHfiVPnaQH0o9vlKKW5jIzfmzPEcxCu+8bhi+XOmsPX0tRcQa
 tdrqWb/eHheUAFPfbpMZvs5VCHjkwOtFTcY3dPfbbEyxIGLfmwzYVUOJAyog4U304UAVFKZkxv
 VT2l21YsVG4V/sSWn/UIzOkB66R5eo45d6WN24wa3B+WmrKT5XbHHJG3KfhuOue6K1ojSHbR5+
 Y11A3IqWGnuQrUDF2dBELIxQoW4LjSV+nbRUhhCfDLKeIgr0Wfvx+oc9HPtzHZso2HYSPpXDdQ
 2jk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 20:00:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K5qXh1KdBz1SVny
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:00:04 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645934403; x=1648526404; bh=+xrsuOI9TEYJqO66rOjju0qwmMM8tmROUCm
        eVCpyQHI=; b=jk1YeFgsPfCpag0c2T6Oy7mM3oQ5g7iy2tDGelWSdpN3qQwMMXK
        qZYW0NLhfY5+sxsbPtEHClAA8g1TaQ210PqaMA1o1kBA46Ja/NU6w3OY6A/WTiyh
        Dh8Ba3PWulUDlK+6OfYAagahcf6chfwEPL5Cp8JhgWS4AJZOvMMiEhvtqQbbUnI3
        CV+1wuIq+u6Nri/M1k51CHxnV9iqhhGfW0+iZ5me7sxcoGuzNJPhQyDb3vlx0gVI
        Mp5OKG5S7JqJkV5+8w7QqNmLA+3WWkKVlGrQvbKfwMf1NA3kaPxcmPL+Q1SE5Z9L
        WN1V4CEg4BtJdDmK6SJstmZhzHz8dd/Fv6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n3FqqXmrxuPs for <linux-kernel@vger.kernel.org>;
        Sat, 26 Feb 2022 20:00:03 -0800 (PST)
Received: from [10.225.33.67] (unknown [10.225.33.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K5qXd1TT3z1Rvlx;
        Sat, 26 Feb 2022 20:00:00 -0800 (PST)
Message-ID: <d81c76bd-36aa-4885-1f36-1aec17ab5098@opensource.wdc.com>
Date:   Sun, 27 Feb 2022 12:59:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] scsi: libsas: Use bool for queue_work() return
 code
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenxiang66@hisilicon.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1645786656-221630-1-git-send-email-john.garry@huawei.com>
 <1645786656-221630-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1645786656-221630-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/25 19:57, John Garry wrote:
> Function queue_work() returns a bool, so use a bool to hold this value
> for the return code from callers, which should make the code a tiny bit
> more clear.
> 
> Also take this opportunity to condense the code of the those callers, such
> as sas_queue_work(), as suggested by Damien.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/libsas/sas_event.c    | 30 +++++++++++-------------------
>  drivers/scsi/libsas/sas_internal.h |  2 +-
>  2 files changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_event.c b/drivers/scsi/libsas/sas_event.c
> index 8ff58fd97837..f3a17191a4fe 100644
> --- a/drivers/scsi/libsas/sas_event.c
> +++ b/drivers/scsi/libsas/sas_event.c
> @@ -10,29 +10,26 @@
>  #include <scsi/scsi_host.h>
>  #include "sas_internal.h"
>  
> -int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
> +bool sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
>  {
> -	/* it's added to the defer_q when draining so return succeed */
> -	int rc = 1;
> -
>  	if (!test_bit(SAS_HA_REGISTERED, &ha->state))
> -		return 0;
> +		return false;
>  
>  	if (test_bit(SAS_HA_DRAINING, &ha->state)) {
>  		/* add it to the defer list, if not already pending */
>  		if (list_empty(&sw->drain_node))
>  			list_add_tail(&sw->drain_node, &ha->defer_q);
> -	} else
> -		rc = queue_work(ha->event_q, &sw->work);
> +		return true;
> +	}
>  
> -	return rc;
> +	return queue_work(ha->event_q, &sw->work);
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
> @@ -44,13 +41,12 @@ static int sas_queue_event(int event, struct sas_work *work,
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
> +		if (!sas_queue_work(ha, sw)) {
>  			pm_runtime_put(ha->dev);
>  			sas_free_event(to_asd_sas_event(&sw->work));
>  		}
> @@ -170,7 +166,6 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>  {
>  	struct sas_ha_struct *ha = phy->ha;
>  	struct asd_sas_event *ev;
> -	int ret;
>  
>  	BUG_ON(event >= PORT_NUM_EVENTS);
>  
> @@ -186,8 +181,7 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>  	if (sas_defer_event(phy, ev))
>  		return;
>  
> -	ret = sas_queue_event(event, &ev->work, ha);
> -	if (ret != 1) {
> +	if (!sas_queue_event(event, &ev->work, ha)) {
>  		pm_runtime_put(ha->dev);
>  		sas_free_event(ev);
>  	}
> @@ -199,7 +193,6 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>  {
>  	struct sas_ha_struct *ha = phy->ha;
>  	struct asd_sas_event *ev;
> -	int ret;
>  
>  	BUG_ON(event >= PHY_NUM_EVENTS);
>  
> @@ -215,8 +208,7 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>  	if (sas_defer_event(phy, ev))
>  		return;
>  
> -	ret = sas_queue_event(event, &ev->work, ha);
> -	if (ret != 1) {
> +	if (!sas_queue_event(event, &ev->work, ha)) {
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
