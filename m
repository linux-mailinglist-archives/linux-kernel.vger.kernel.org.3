Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D054C04C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbiFODt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbiFODtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:49:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C214FC5E;
        Tue, 14 Jun 2022 20:49:23 -0700 (PDT)
X-UUID: 65ce9d5a836b4f2fb14e0ed8f7eff767-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:014ebaab-2468-4035-b33a-f9cdcd06e9dd,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:a61f42f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 65ce9d5a836b4f2fb14e0ed8f7eff767-20220615
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 897238081; Wed, 15 Jun 2022 11:49:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 15 Jun 2022 11:49:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 11:49:14 +0800
Message-ID: <f51578a139b028f2fa85e738d52f50356027bb26.camel@mediatek.com>
Subject: Re: [PATCH v3 04/10] scsi: ufs-mediatek: Fix the timing of
 configuring device regulators
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Bart Van Assche <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>
CC:     <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <mason.zhang@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>
Date:   Wed, 15 Jun 2022 11:49:14 +0800
In-Reply-To: <bc6fc2fa-df9a-60cb-3929-9dd5808eced2@acm.org>
References: <20220614141655.14409-1-stanley.chu@mediatek.com>
         <20220614141655.14409-5-stanley.chu@mediatek.com>
         <bc6fc2fa-df9a-60cb-3929-9dd5808eced2@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 09:33 -0700, Bart Van Assche wrote:
> On 6/14/22 07:16, Stanley Chu wrote:
> > +int ufs_mtk_system_suspend(struct device *dev)
> > +{
> > +	int ret = 0;
> > +	struct ufs_hba *hba = dev_get_drvdata(dev);
> > +
> > +	ret = ufshcd_system_suspend(dev);
> > +
> > +	if (!ret)
> > +		ufs_mtk_vreg_set_lpm(hba, true);
> > +
> > +	return ret;
> > +}
> 
> 
> Please use the traditional kernel coding style and return early in
> case 
> of an error. For the above code, that means to rewrite it as follows:
> 
> 	struct ufs_hba *hba = dev_get_drvdata(dev);
> 	int ret;
> 
> 	ret = ufshcd_system_suspend(dev);
> 	if (ret)
> 		return ret;
> 
> 	ufs_mtk_vreg_set_lpm(hba, true);
> 
> 	return 0;

OK! Fixed in v4.

> 
> > +int ufs_mtk_system_resume(struct device *dev)
> > +{
> > +	int ret = 0;
> > +	struct ufs_hba *hba = dev_get_drvdata(dev);
> > +
> > +	ufs_mtk_vreg_set_lpm(hba, false);
> > +
> > +	ret = ufshcd_system_resume(dev);
> > +
> > +	return ret;
> > +}
> 
> Please remove the variable 'ret' from the above function.

OK! Fixed in v4.
> 
> > +int ufs_mtk_runtime_suspend(struct device *dev)
> > +{
> > +	struct ufs_hba *hba = dev_get_drvdata(dev);
> > +	int ret = 0;
> > +
> > +	ret = ufshcd_runtime_suspend(dev);
> > +
> > +	if (!ret)
> > +		ufs_mtk_vreg_set_lpm(hba, true);
> > +
> > +	return ret;
> > +}
> 
> Please use the "early return" style.

OK! Fixed in v4.
> 
> > +int ufs_mtk_runtime_resume(struct device *dev)
> > +{
> > +	struct ufs_hba *hba = dev_get_drvdata(dev);
> > +	int ret = 0;
> > +
> > +	ufs_mtk_vreg_set_lpm(hba, false);
> > +
> > +	ret = ufshcd_runtime_resume(dev);
> > +
> > +	return ret;
> > +}
> 
> Please remove the variable 'ret' from the above function.

OK! Fixed in v4.
> 
> Thanks,
> 
> Bart.

