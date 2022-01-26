Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5730549C0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiAZBWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:22:36 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:41892 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235789AbiAZBWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:22:32 -0500
X-UUID: b68215f317e8436093934fc8cc4202cc-20220126
X-UUID: b68215f317e8436093934fc8cc4202cc-20220126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 428989841; Wed, 26 Jan 2022 09:22:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 26 Jan 2022 09:22:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 09:22:28 +0800
Message-ID: <40986ecb6c81812a1e1ab24d93e46eda75974c4e.camel@mediatek.com>
Subject: Re: [PATCH v2] scsi: ufs: disable auto hibern8 while entering
 suspend
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     SEO HOYOUNG <hy50.seo@samsung.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <bvanassche@acm.org>, <bhoon95.kim@samsung.com>,
        <kwmad.kim@samsung.com>
CC:     kernel test robot <lkp@intel.com>, <peter.wang@mediatek.com>
Date:   Wed, 26 Jan 2022 09:22:28 +0800
In-Reply-To: <20220124180637.160524-1-hy50.seo@samsung.com>
References: <CGME20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b@epcas2p1.samsung.com>
         <20220124180637.160524-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hoyoung,

On Tue, 2022-01-25 at 03:06 +0900, SEO HOYOUNG wrote:
> v1-> v2: fixed no previous prototype warning
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> > > drivers/scsi/ufs/ufshcd.c:4207:6: warning: no previous prototype 
> 
> for 'ufshcd_auto_hibern8_disable' [-Wmissing-prototypes]
> 4207 | void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)
> 
> If using auto hibern8 mode, need to disable auto hibern8 while
> entering suspend.
> When using auto hibern8 mode, it does not seem right to send a uic
> command

The UFSHCI spec does not mention the above rule.
Why would you need to disable AH8 before using UIC command to enter H8?

> for entry into hibern8 in the next
> line(ufshcd_lik_state_transition(..))
> It seem right to send after disable auto hibern8.
> 
> In addition, if the auto hibern8 mode supported, it is enabled in
> resume.
> So it seems that it will be paired only when auto hibern8 is disabled
> while entering suspend.
> 
> Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 460d2b440d2e..a6edbbd8ca2c 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -254,6 +254,7 @@ static void
> ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set);
>  static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool
> enable);
>  static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
>  static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
> +static void ufshcd_auto_hibern8_disable(struct ufs_hba *hba);
>  
>  static inline void ufshcd_enable_irq(struct ufs_hba *hba)
>  {
> @@ -4204,6 +4205,18 @@ void ufshcd_auto_hibern8_update(struct ufs_hba
> *hba, u32 ahit)
>  }
>  EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);
>  
> +static void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)
> +{
> +	unsigned long flags;
> +
> +	if (!ufshcd_is_auto_hibern8_supported(hba))
> +		return;
> +
> +	spin_lock_irqsave(hba->host->host_lock, flags);
> +	ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER);
> +	spin_unlock_irqrestore(hba->host->host_lock, flags);
> +}
> +
>  void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)
>  {
>  	unsigned long flags;
> @@ -8925,6 +8938,7 @@ static int __ufshcd_wl_suspend(struct ufs_hba
> *hba, enum ufs_pm_op pm_op)
>  	 * with the link off, so do not check for bkops.
>  	 */
>  	check_for_bkops = !ufshcd_is_ufs_dev_deepsleep(hba);
> +	ufshcd_auto_hibern8_disable(hba);
>  	ret = ufshcd_link_state_transition(hba, req_link_state,
> check_for_bkops);
>  	if (ret)
>  		goto set_dev_active;

