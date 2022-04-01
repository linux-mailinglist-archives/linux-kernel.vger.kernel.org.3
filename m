Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD04EE5EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbiDACNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243955AbiDACNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:13:49 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1EE258FE0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:12:01 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ke15so1004735qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfF4jMoourRXWty+VeiIwmu3poFQSsT7at+4kHLppy4=;
        b=UOYSEjNCt4hvd1B3augR+23XTiJ93+NZvhnXrjnOQu1PLlGGuM5kE5DTveWmUYsJ4F
         w4zNDyY/pfzHfNS28LbSqNiFA8sxRW/3PJySNvuMKwvhTEoEJprO3kjyr4UA2W+Zm+Q1
         Bw0hjwHG0lUQOfRS/7gUFksaeiuU7nSMAHrD2pMn2e90Xdma+bIMvXZoQVBgzJz9KSE3
         0QlZo7pjve6cb7nG1842znWNewGcnKis4gv2L8Z2XF2HERAMdxbJrRrDSVDKknyKYC6+
         47OCiaWkmmCsdg0U1gFsCX+KBqemmaPe3o8VatmtPVljCKff9gm6WiRSiXsNW3iC1NcH
         dqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfF4jMoourRXWty+VeiIwmu3poFQSsT7at+4kHLppy4=;
        b=4yABjOlR+m6v/S48B6kzh4G2f/O5kZsqmJ8K/5pIvhnfBUhauwK00TjnpF7JqRuQ52
         qF7Gafypttc51/bDf77kGGUW3tV07sFiEWHxzajKD8ewF31zXDyfBIUefqRzMWwHsDGb
         +lDm76OaJMhfEl9f6G6ZHnXn6TZyUKKaN4N6ObyQlo5slyDCG5F3HI8pat42PH1JCtXd
         gcxGRy4ba0aU5fxViHBtcPASsF+pEmtiQbPdEo01jlo9eAfY6PpjWht/jTUNPoycuqJW
         30jvyTlMZyRd/m6NPPVwKeUxXM6ctKcxXAhsqg4T/UYTOU+ZFSkBxctTwJuyi1ktR377
         053A==
X-Gm-Message-State: AOAM5331rBm8Jt+En7uBPET7HJx4sJoMPg0/hc/0RbB5yitlgtpps+ax
        hsG2i1Ny2U6pZM0ksvMYNMJxWJDRuLG/XWCUT4A=
X-Google-Smtp-Source: ABdhPJxzRZI+WONbFlobAstHM9ajemhoLTb/bdpcboZ7nAT4a/jycTUcFDcLDacKgW+Geq1QQGLspmi7s/8rNimfeGo=
X-Received: by 2002:a05:6214:1c85:b0:443:8347:d7a5 with SMTP id
 ib5-20020a0562141c8500b004438347d7a5mr11363444qvb.11.1648779120601; Thu, 31
 Mar 2022 19:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220331215003.882143-1-jakobkoschel@gmail.com> <20220331215003.882143-2-jakobkoschel@gmail.com>
In-Reply-To: <20220331215003.882143-2-jakobkoschel@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 1 Apr 2022 10:12:42 +0800
Message-ID: <CADBw62qyyisDy2NkE29GYZkCi_O5Vgp+t1jeZtOkPsLV8UGFGQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: sprd: remove check of list iterator against
 head past the loop body
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 5:52 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> When list_for_each_entry() completes the iteration over the whole list
> without breaking the loop, the iterator value will be a bogus pointer
> computed based on the head element.
>
> While it is safe to use the pointer to determine if it was computed
> based on the head element, either with list_entry_is_head() or
> &pos->member == head, using the iterator variable after the loop should
> be avoided.
>
> In preparation to limiting the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element [1].
>
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>  sound/soc/sprd/sprd-mcdt.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
> index f6a55fa60c1b..6e27789a0df5 100644
> --- a/sound/soc/sprd/sprd-mcdt.c
> +++ b/sound/soc/sprd/sprd-mcdt.c
> @@ -866,20 +866,19 @@ EXPORT_SYMBOL_GPL(sprd_mcdt_chan_dma_disable);
>  struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
>                                               enum sprd_mcdt_channel_type type)
>  {
> -       struct sprd_mcdt_chan *temp;
> +       struct sprd_mcdt_chan *temp = NULL;
> +       struct sprd_mcdt_chan *iter;
>
>         mutex_lock(&sprd_mcdt_list_mutex);
>
> -       list_for_each_entry(temp, &sprd_mcdt_chan_list, list) {
> -               if (temp->type == type && temp->id == channel) {
> -                       list_del_init(&temp->list);
> +       list_for_each_entry(iter, &sprd_mcdt_chan_list, list) {
> +               if (iter->type == type && iter->id == channel) {
> +                       list_del_init(&iter->list);
> +                       temp = iter;
>                         break;
>                 }
>         }
>
> -       if (list_entry_is_head(temp, &sprd_mcdt_chan_list, list))
> -               temp = NULL;
> -
>         mutex_unlock(&sprd_mcdt_list_mutex);
>
>         return temp;
> --
> 2.25.1
>


-- 
Baolin Wang
