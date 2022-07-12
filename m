Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE492571069
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiGLClI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiGLClG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:41:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0D98CCA2;
        Mon, 11 Jul 2022 19:41:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d10so6316561pfd.9;
        Mon, 11 Jul 2022 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lDqoYU06M5qfjJNyMJVfxr7RWOkJpJykf6wQoyOq3/4=;
        b=nktI3+yVZ2upxobo1pYI+Imzvb40JntPSd+uVznnE+JDiZ3iqfgylh7IdheE417ReI
         0ZJpKflv+wrre/BLrPhm4QrxaUd3LOGwvwHzkbu7H+1fNoleMTZTDhPkSukdQ3PUQ/KD
         juCfkcILprPT0MwHhmuOHfyicKcZori7Q384uxVes08GJTq3ofAq4GkB/P+dcKQNyhSn
         VtxQLkhJYWpiqxb45R3paqRoCG9hNEAdbQMIwIArDB+kC1uF0c3fP/q7PpXuVbVFKpg1
         7fCoKDWpMVbjfUYwWIFNl9vyB7Rg2HqMO7tyZ/SEbkPs+j1g1k6+m5t1IpJ67AhI55rf
         WlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lDqoYU06M5qfjJNyMJVfxr7RWOkJpJykf6wQoyOq3/4=;
        b=c5Vx1VispoR8dbOpceTvpwb/T8YSt1Ui/j0TaPbeOkbJhVxT0MCPBu3v0Ot19Mas6/
         Zs3bzTXrQ8D5Wa1z5QNkmSmZzFOqTZS+LS8Lm+L1AqpDgjWhHlD9pe8jjm2z4SoYkTm8
         zR93oybayry4La7QkgimSwilG03LFcVoAjRVZOam+mc7vA2NnHpINIOUp3j0tYja86kX
         tjlEjFHC97dH5HmBHBK4A4mTt/JEW/7D/nBpWiMRN5TpCzhZwnpLJ4u5ZedTex3hx5bl
         o5i/Giydw+4uw1a424J64SmcLcnX1U/UoF4pUaSzlA3B2FwsgWQiL3vFeRl92xtxMnU5
         OUog==
X-Gm-Message-State: AJIora9yidsT2CujiQ1cy1uNu0BccDkFyWeBlcUF0Crrwsa0kjH1/iTA
        5Nz2adMKuYP8HlxZwmFynsU=
X-Google-Smtp-Source: AGRyM1sgSZac13/1lfi1ve8MaLQooeCokQeReYKhIfbjxRfYG+jCF6NsV3uqc9I/KRMG3daStn5p3w==
X-Received: by 2002:a63:5cd:0:b0:412:b163:b7e1 with SMTP id 196-20020a6305cd000000b00412b163b7e1mr18843432pgf.451.1657593664115;
        Mon, 11 Jul 2022 19:41:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b0052ab9f1fe45sm5448189pfi.120.2022.07.11.19.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:41:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Jul 2022 19:40:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        khilman@baylibre.com, abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 01/33] thermal/of: Rework the thermal device tree
 initialization
Message-ID: <20220712024058.GA2308616@roeck-us.net>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-2-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710212423.681301-2-daniel.lezcano@linexp.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 11:23:51PM +0200, Daniel Lezcano wrote:
[ ... ]
>  
> +static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
> +{
> +}
> +
> +static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
> +{
> +}
> +

Unless I am missing something, there are no dummies for the registration
functions. Is that on purpose ?

Thanks,
Guenter

>  static inline
>  void devm_thermal_zone_of_sensor_unregister(struct device *dev,
>  					    struct thermal_zone_device *tz)
