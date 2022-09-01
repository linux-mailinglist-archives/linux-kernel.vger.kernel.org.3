Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC7E5AA03A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiIATjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiIATjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:39:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF769A9B4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:39:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h22so14309064qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=caA/FC3GwEIv5k9saHBJim4xjLc8yHfbXgArB9Vpu9o=;
        b=KOA+pEkUTKh6NEiZvW0bhOuMsKMrHRq0GZiZppZfrIzhJJlf/cNhMT5nKA3TMNP8r3
         Wo6rhkS0WvSoCvTy65pQrh2rO+8OEqebCcaPd40uEpi3IO0luDF8LcQ9/0tQ2BqMelYi
         7KKGmUWZbiv3yUcuuoNFr+RhkGCla80rI/V6FLXc2KuqKCeGFT7WsqixGlO6IdDJJCeE
         hPRCBX5Tc3zbkoRnFBueyUKt3BDNeSo7y5IZFPkqhhUWlTe0EZKfzobTpmLOrXExn8Mk
         zK0oQRfAldkCNbAo9cRUG2hIAUFxJRbNQ4uCNeDc6iwrGB7z55hO5EJKxzJF4X8ZJCWO
         kTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=caA/FC3GwEIv5k9saHBJim4xjLc8yHfbXgArB9Vpu9o=;
        b=eaghx7NbJaN+V0w0oD6nNTAsK5SU2R5M43SgDlxvTui3LZnKV0TGmBNhPtWjtrpOP+
         BMwD/WDuxSRcfqdaGozHWfH0l4waGG7zee6a/9/5c+IW9oXb4tqsSy1aXqJhnm4D5m22
         6cg8uopMbtPpYkNf9szNw/wd8997plAcT0Wy7E/n52lNiMpUgLZCHBCS70p74Hk0Nd9o
         gTEySiisn0W+zsVJ/Aosw+YzLj467yomaoduFFDP+203zOBiI25Dmbc5jBu/O8SElu9X
         thVgjaAGmf0mq94TY/JRAg/KypnO6q4ft/15m8v/c+SWQlMQgeW1WR/qJtcpsXm6yKoG
         c1fA==
X-Gm-Message-State: ACgBeo0uc2K3SbGF7i8nu4/QAx65caiyK1QegEKxpXQ0TjWxrWRU9OLv
        53zdbpNHEBWPomFM6ta2tLDrpY6MhbnSpB0Ikso=
X-Google-Smtp-Source: AA6agR7ycdrj03TpdN1pNIKGGZ9QWs6zk+zelMKiqHJgiCa6yv0iI9OO+AGRoQEK0SvmHRtqi1edNJROMh8PLIAu4EE=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr25052426qta.429.1662061156594; Thu, 01
 Sep 2022 12:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220901175022.334824-1-cezary.rojewski@intel.com> <20220901175022.334824-3-cezary.rojewski@intel.com>
In-Reply-To: <20220901175022.334824-3-cezary.rojewski@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 22:38:40 +0300
Message-ID: <CAHp75VdVqRyA=J0-HsHtgiAZhd8XxqxmMddTyV2u29TxvV9=Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: SOF: Remove strsplit_u32() and tokenize_input()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 8:40 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> Make use of global user input tokenization helper instead of the
> internal one as both serve same purpose. With that, both strsplit_u32()

the same

> and tokenize_input() become unused so remove them.

...

>  #include <linux/debugfs.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/string_helpers.h>

I believe either blank line needs to be here (to split the sound / SOF
group of headers) or this should be put after 'so*'-ones

>  #include <sound/soc.h>
>  #include <sound/sof/header.h>
>  #include "sof-client.h"

...

>         struct sof_probes_priv *priv = cdev->data;
>         struct device *dev = &cdev->auxdev.dev;
>         struct sof_probe_point_desc *desc;
> -       size_t num_tkns, bytes;
> -       u32 *tkns;
> +       size_t bytes;
> +       u32 num_tkns, *tkns;

I would expect a longer line first.

>         int ret, err;

...

With the above addressed
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
