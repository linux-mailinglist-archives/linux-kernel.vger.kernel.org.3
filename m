Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D14FAD24
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiDJKPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDJKPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:15:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686766FBD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:13:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r206-20020a1c44d7000000b0038ccb70e239so2743402wma.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZo/m1bqkSUtO6Lom2S713GFjpljpLQ71ASMRg5Hn7w=;
        b=G58Fiwr1roHUchNnV8uMiaCFlRz2gDTmTryzv+V6xhpmcC2+7j2UYPcxbrxAQ9+rrC
         C/VGld+ZVH6mDkRxPT/wFr2XNJxJN4pjaPhTq70m+y4m/9bur6+N0IV9ClOGx0Tltjkd
         MAM9BzWlGt6Iu5Fy/dIk9cwzKb4emXlRp41t+JtYjnaiL+FwxQ7Zw4lGn9MPUS2ok9bH
         1kgqpfnryNMqmoX4D439+Hlf+b2V686Gx5+avWu3xvMntxGqAUO/5rtBrTax5dOgYJM4
         T1FnmDekMJtgEUXCjydAuYejPCtkWVgUqTCFawTlTWYz+xCScuKzzgQOBaSseJtnwDA/
         1Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZo/m1bqkSUtO6Lom2S713GFjpljpLQ71ASMRg5Hn7w=;
        b=preZ/kobXtWkaghCZPcqOfl3Vs3McLHagkEVJyd810TJ3kly6FnnpS9AkruTM+D6I0
         1msPfa+t4S+a5uEyN2eFnfRkzrmHJk4xIxgGnsw8beIQYqnxnKMa5hqHQWw1dMh+vArN
         Lt2xH3djZd/nWhDs5tksbO98NIsyW9/NJvsbNBVdBdRv1eIS3jMw/5UIkKFRMkssIq9R
         V41dEWlVUc3qYwnI77DlIOR8TuVl8le0p6BcZ+GYA9WfNZdd36AvGwfCV0tvVTn1T38F
         IBlLpQB/qcyH//tkg/IBrJK1jAdxt6IVH5syFlbaXc4YGAOmAa/4hvXH1nS5MRX/Otpm
         9NOw==
X-Gm-Message-State: AOAM532CsMRQGo4Vo+5WWQr5bUmYFS0rCOfYq6uETnuLv5zZ0J66yoQ1
        prECSdcDlsOcC8xtzBtN0M0=
X-Google-Smtp-Source: ABdhPJxGa9m+AiJOIpY+QhfkC4bE2zpKqtFGZEkSzed002NzgVtl8V100+Yzc8eR8U8nqrx6SN/B3w==
X-Received: by 2002:a7b:cb0d:0:b0:38e:aaf3:b08f with SMTP id u13-20020a7bcb0d000000b0038eaaf3b08fmr8769112wmj.12.1649585587969;
        Sun, 10 Apr 2022 03:13:07 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id i4-20020a1c5404000000b0038e7dc5e469sm14467590wmb.25.2022.04.10.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 03:13:07 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, hverkuil-cisco@xs4all.nl,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     shengjiu.wang@nxp.com, cai.huoqing@linux.dev, maxime@cerno.tech,
        harry.wentland@amd.com
Subject: Re: [PATCH v2 1/5] drm: bridge: dw_hdmi: cec: Add cec suspend/resume function
Date:   Sun, 10 Apr 2022 12:13:06 +0200
Message-ID: <3658461.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <4a6a4b70-3e24-3043-4e9d-f62e4798f28b@baylibre.com>
References: <cover.1649412256.git.Sandor.yu@nxp.com> <45739041a743cd435415ca53264678e57a653147.1649412256.git.Sandor.yu@nxp.com> <4a6a4b70-3e24-3043-4e9d-f62e4798f28b@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 08. april 2022 ob 15:41:36 CEST je Neil Armstrong napisal(a):
> On 08/04/2022 12:32, Sandor Yu wrote:
> > CEC interrupt status/mask and logical address registers
> > will be reset when device enter suspend.
> > It will cause cec fail to work after device resume.
> > Add CEC suspend/resume functions, reinitialize logical address registers
> > and restore interrupt status/mask registers after resume.
> > 
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > ---
> > 
> >   drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 37 +++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c index
> > c8f44bcb298a..ab176401b727 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> > @@ -62,6 +62,10 @@ struct dw_hdmi_cec {
> > 
> >   	bool rx_done;
> >   	struct cec_notifier *notify;
> >   	int irq;
> > 
> > +
> > +	u8 regs_polarity;
> > +	u8 regs_mask;
> > +	u8 regs_mute_stat0;
> > 
> >   };
> >   
> >   static void dw_hdmi_write(struct dw_hdmi_cec *cec, u8 val, int offset)
> > 
> > @@ -306,11 +310,44 @@ static int dw_hdmi_cec_remove(struct platform_device
> > *pdev)> 
> >   	return 0;
> >   
> >   }
> > 
> > +static int __maybe_unused dw_hdmi_cec_resume(struct device *dev)
> > +{
> > +	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
> > +
> > +	/* Restore logical address */
> > +	dw_hdmi_write(cec, cec->addresses & 255, HDMI_CEC_ADDR_L);
> > +	dw_hdmi_write(cec, cec->addresses >> 8, HDMI_CEC_ADDR_H);
> > +
> > +	/* Restore interrupt status/mask register */
> > +	dw_hdmi_write(cec, cec->regs_polarity, HDMI_CEC_POLARITY);
> > +	dw_hdmi_write(cec, cec->regs_mask, HDMI_CEC_MASK);
> > +	dw_hdmi_write(cec, cec->regs_mute_stat0, HDMI_IH_MUTE_CEC_STAT0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused dw_hdmi_cec_suspend(struct device *dev)
> > +{
> > +	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
> > +
> > +	/* store interrupt status/mask register */
> > +	 cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
> > +	 cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
> > +	 cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops dw_hdmi_cec_pm = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(dw_hdmi_cec_suspend, dw_hdmi_cec_resume)
> > +};
> > +
> > 
> >   static struct platform_driver dw_hdmi_cec_driver = {
> >   
> >   	.probe	= dw_hdmi_cec_probe,
> >   	.remove	= dw_hdmi_cec_remove,
> >   	.driver = {
> >   	
> >   		.name = "dw-hdmi-cec",
> > 
> > +		.pm = &dw_hdmi_cec_pm,
> > 
> >   	},
> >   
> >   };
> >   module_platform_driver(dw_hdmi_cec_driver);
> 
> As Hans said on v1, why don't you call dw_hdmi_cec_enable(cec->adap, false)
> in suspend and dw_hdmi_cec_enable(cec->adap, true) in resume ?
> 
> With this, CEC engine is not disabled on suspend.

This should not be done, at least not unconditionally. CEC wakeup 
functionality is used by Crust firmware for Allwinner boards. In fact, DW HDMI 
CEC controller was designed with suspend/resume functionality in mind. If 
properly set, it can autonomously scan for preset CEC messages and generate 
interrupt when found.

Actually, I'm not fan of this patch, since it looks like workaround for power 
management firmware not restoring previous state. Or is this HW issue? In any 
case, Allwinner SoCs with DW-HDMI CEC don't need restoring any register, so 
it's certainly not a general issue.

> 
> Do you plan to use the engine from the suspend code ?

As mentioned before, it's already done for Allwinner, so CEC should remain 
enabled.

Best regards,
Jernej

> 
> Neil




