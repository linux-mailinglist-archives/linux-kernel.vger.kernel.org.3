Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B033B5874D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiHBAb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiHBAb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:31:27 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ACE29822;
        Mon,  1 Aug 2022 17:31:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u1so9495270lfq.4;
        Mon, 01 Aug 2022 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=P896A15ebEpZdNo5vHx5OEHcywwIEWdjK6w2RcDQzYQ=;
        b=ktHCjpZb1Z2kJDU0u5GRsUdvWmKhZDoEFQglUL5YDs0RgWXLUpkCfU5c2oJk8hVU8L
         PvaN8QUdTiHPmL+VZ6duW2eOJ4Kt094QfG3L5QkSzO+/CTx9JuWJhwS4SLXIYlEXq6ZA
         if1yzvHY79LaXpeQFej7d+KILUayCixXFqpmJ9ymbt7BYHTWR9Jwo2CIGmBlbjABXCcH
         nDbgwDCjb3wbPral3S6n5A4oGkccO9dcJ2pya29O58tY6xEZP1OIHbpDahtsvxiOn86O
         g2HJE6kfJh909goeO91eWtgY9LW4lWLzKaeeRtbExno1jtgrPNmqc8ZrzhJ6xECyXdhZ
         nT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=P896A15ebEpZdNo5vHx5OEHcywwIEWdjK6w2RcDQzYQ=;
        b=CsvGa0ASIVZ/wTDY0/KPYVQMGMH9Yjxxit5MR+0cqL2S4WE3S2zIvh0FKnsbzkuBBt
         b1Jhdv6ZvL6Eh2Q2g3ruyJOjV3SzvzzKJlaDyJdHjB0bzK9Nz2P+2bfmsyVk2SuOJjUv
         SAqITXRgDwtGDTi2GmlY2ZpniPZL2VYbQsNTWNncEfbUyL6nNmuBpBGgnzeOH/yJ4UsI
         FJUTQqLtNj76C0v6o3FIPIdWzsBBjCA8r/5AGoFd4M7V7jcrXM73ydsBylt5AsFY8I+Y
         dkC6HVlZwDAkvfHf6LF9zpCT4xyLRPC8WZXtfqs6c5jRwNYmIbvKTcyhMl9qZBD/PR69
         DK6g==
X-Gm-Message-State: ACgBeo3OxaApNky4P+pwZ70hyTlLKcwglFyYZHklcOte4jqWMF34KQBG
        +Gt4TGFhNhQPzFq/NTvrx5MaqpgVtOmOHpdovg==
X-Google-Smtp-Source: AA6agR6+SnMnOlDR3MdTsPi6AjVjKiKhlL4B1ectWpNGNkXuAa3XgrcLeFw8c/lruUStpnyS4bpz/UieGTRQnJwnljU=
X-Received: by 2002:a05:6512:3dac:b0:48b:694:bb35 with SMTP id
 k44-20020a0565123dac00b0048b0694bb35mr1059764lfv.215.1659400284735; Mon, 01
 Aug 2022 17:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220729075519.4665-1-stanley.chu@mediatek.com>
 <7e8c58cf-64c1-8426-bf22-97d3df85ed38@acm.org> <CAGaU9a_G1kH8VezozhZ3-S6-GvMr=EUVc4btU8Dwdo+cCJDxUg@mail.gmail.com>
 <b92ef74c-1068-b86e-c3c2-a95f057e2494@acm.org>
In-Reply-To: <b92ef74c-1068-b86e-c3c2-a95f057e2494@acm.org>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 2 Aug 2022 08:31:12 +0800
Message-ID: <CAGaU9a97KYYJNy2wPWZXX8sjB4NMbX1KB1sVQ95GWHGfn27iEg@mail.gmail.com>
Subject: Re: [PATCH v1] scsi: ufs: Fix ufshcd_scale_clks decision in recovery flow
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        peter.wang@mediatek.com, Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Tue, Aug 2, 2022 at 1:34 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 7/30/22 00:08, Stanley Chu wrote:
> > Hi Bart,
> >
> > On Sat, Jul 30, 2022 at 4:12 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >>
> >> On 7/29/22 00:55, Stanley Chu wrote:
> >>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> >>> index 581d88af07ab..dc57a7988023 100644
> >>> --- a/drivers/ufs/core/ufshcd.c
> >>> +++ b/drivers/ufs/core/ufshcd.c
> >>> @@ -1574,8 +1574,6 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
> >>>        ufshcd_rpm_get_sync(hba);
> >>>        ufshcd_hold(hba, false);
> >>>
> >>> -     hba->clk_scaling.is_enabled = value;
> >>> -
> >>>        if (value) {
> >>>                ufshcd_resume_clkscaling(hba);
> >>>        } else {
> >>> @@ -1586,6 +1584,8 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
> >>>                                        __func__, err);
> >>>        }
> >>>
> >>> +     hba->clk_scaling.is_enabled = value;
> >>> +
> >>>        ufshcd_release(hba);
> >>>        ufshcd_rpm_put_sync(hba);
> >>>    out:
> >>> @@ -7259,7 +7259,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
> >>>        hba->silence_err_logs = false;
> >>>
> >>>        /* scale up clocks to max frequency before full reinitialization */
> >>> -     ufshcd_scale_clks(hba, true);
> >>> +     if (ufshcd_is_clkscaling_supported(hba) && hba->clk_scaling.is_enabled)
> >>> +             ufshcd_scale_clks(hba, true);
> >>>
> >>>        err = ufshcd_hba_enable(hba);
> >>
> >> I see a race condition between the hba->clk_scaling.is_enabled check in
> >> ufshcd_host_reset_and_restore() and the code that sets
> >> ufshcd_clkscale_enable_store(). Shouldn't the code in
> >> ufshcd_host_reset_and_restore() that scales up the clocks be serialized
> >> against ufshcd_clkscale_enable_store()?
> >
> > Both check and set paths are serialized by hba->host_sem currently.
> >
> > Would I miss any other unserialized paths?
>
> Where in ufshcd_host_reset_and_restore() or in its callers is
> hba->host_sem obtained? I don't see it. Am I perhaps overlooking something?

It looks like that some callers do not obtain hba->host_sem. I will
fix this in the next version.

The direct callers of ufshcd_host_reset_and_restore() are,

- ufshcd_link_recovery(), host_sem is obtained by its callers:
ufshcd_err_handler() and ufshcd_wl_resume()
- ufshcd_reset_and_restore(): the same as above
- __ufshcd_wl_suspend(): host_sem is obtained by the caller
ufshcd_wl_suspend() but not obtained by other callers.

Thanks,

Stanley
