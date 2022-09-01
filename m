Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A55AA01B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiIATfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiIATfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:35:31 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54C371B2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:35:30 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id f9so10582574qvw.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UTBH3ZdVXDU80DZLVRDqtIzjJqfExVq6UuHtVbe7ytw=;
        b=cc6qIcfeYMZ/SYFhyoOYaOlejSar4fvt7eaC6hWph8Vm89PxHJePz6jHQuUA3uKOxW
         xoTb/FIeZEjEW9w4NCFuhaYpPrfpJV/zJIvQufFLDvYJBV7rG0whxvGEaiET0X4TnOKI
         CSxHkTzgBb8BNcBUXa8evSulFwvVWMOZxIt6Xq7Iy/0ifZixSTfYHgKw8O7+5E4bZSaz
         IwcCzXTwudYYjaV7t+vQkIg8sXbOoMQYCDo7bFvAUQ9/3bNuTFPDqiIOzv11BkZhxiIH
         0CtLSbVdwVcJ+EDSJAr48KcnueG6sU7NHnMJu9KdeaNijV2p21nG5lVZ1LSvqy8PbkTP
         ARyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UTBH3ZdVXDU80DZLVRDqtIzjJqfExVq6UuHtVbe7ytw=;
        b=cmZuzl2HIeLZLe7uLj/CedRvMeROvgPI142qeVHu7qt6fnQ6Ld43KbaBid16e2setG
         d8xcWfnYQGvF0IkQ5K72twy2KGOi9YtqkBMbGowTzPDbFY2yByTm0BA6PTVpbnVtIYRO
         y6gytNL2HhUvJaeIUbiGMjFt97Wh4Q98ynApRTbTvRiMxxqnwMzV+E2FF900KKWW9NqC
         wQ510PbDbF3P/IjCh/1UDYPdUhd1BwXVkbedJ11OP6yTEY5ieUbmZXhFYXMA/VsoF44O
         SwJ/6ZVMhAuZZQmFE+NW9E2w8lOB1VYA6O4CWtMq1yRUeKGhF5THQei41paJQoycfQ9w
         qFiw==
X-Gm-Message-State: ACgBeo0L76pHbS84KCkFblQxx1j5gmOK0ppjvZrM/PWd03rNNNEJIsIu
        X71JeOG8a2OJ/26j4uCKxqzRxT1U15tq1cAQnzE=
X-Google-Smtp-Source: AA6agR7zE5vM3379YmH+8og+0FzDs/kfGFEcxRhQLFhYOuDVffSnUvhdWpR+hcl+9VqRuiFaxcnc+E962KezfuFf5sw=
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id
 r15-20020a0562140c8f00b0049921ebba3bmr7362076qvr.97.1662060929333; Thu, 01
 Sep 2022 12:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220901175022.334824-1-cezary.rojewski@intel.com> <20220901175022.334824-2-cezary.rojewski@intel.com>
In-Reply-To: <20220901175022.334824-2-cezary.rojewski@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 22:34:53 +0300
Message-ID: <CAHp75VfO7_ASHGdpkcb1dwvhyHPT31eYuAkCm2q7B+2WmtZC4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lib/string_helpers: Introduce tokenize_user_input()
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
> Add new helper function to allow for splitting specified user string
> into a sequence of integers. Internally it makes use of get_options() so
> the returned sequence contains the integers extracted plus an additional
> element that begins the sequence and specifies the integers count.

Thanks! In general it looks good to me, but a few minor comments below.

...

> +int tokenize_user_input(const char __user *from, size_t count, int **tkns);

Not sure how I can deduct from the name what function is actually
doing. Suggested new name: int_array_parse_user().

int int_array_parse_user(const char __user *from, size_t count, int **array);

(Note that we have _user suffix for many APIs in the kernel that does
interact with user space memory)

...

> + * @tkns:      Returned pointer to sequence of integers

array

...

If you are okay with this, you may add my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
