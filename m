Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD54DD061
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiCQVrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCQVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:47:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04579190E90
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:46:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e13so5565579plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4nG1tjL8NLMsT4cMgggdZFwaJZ01TiYbAaXgC6uFDB0=;
        b=LshajC2/xAr2200yH3KNZOFjlWNSOShPGCyj+JvOZlsPXiXdfNYvHCsJmCx9wYXKWU
         1xbGadWUjt6wR82iYphWGcVUpnqF1AHTmD7X/qcs8F1nJAxiFkVv5qZWhRJ/VAeOkzse
         KCZydwVP5PxIHu+aZMT4mWdVcqMwmDGY4efBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nG1tjL8NLMsT4cMgggdZFwaJZ01TiYbAaXgC6uFDB0=;
        b=U+2S+Lo6Lf5+RfldsXfmr/sFJ0kyGvNoOKr3+ZBKpE7uhwgpGZVWKm+6Qi9d+RR6qz
         AgESbGegMZvgM+jRC85DzA+SNj6v7/koI98rFB+ULSS0aa89vJqV7cLBoGXwBhNkwWSe
         78Ypsw0fcrsOfwXDXJJYximUDiyNQI6m9Tkf3chaEGfDsB1h7jsmws3KLLvKjI27ydq7
         5dS3jbj/fMg9ecoD95zX+LdjmyAyjVPV7Ym+5e7b1V3NpIVdYscY4qgvCQFoqKU/s/cY
         9yHeCmETLu/4yS7uw236GnOGwL+uERd8BbvU3GMiMwgdDrk5patSwQqzkvREQGb4Ms/h
         lvBw==
X-Gm-Message-State: AOAM531pBBpD+kh4huU1j0Y0ae8+iWs4ttRtayRmubA/iwJpb/6iFH0I
        OLDkipigrgLFrQ+PVBf6GW/VaTaU5VQRiA==
X-Google-Smtp-Source: ABdhPJz4qlnmPCz+FBLPosA30YBgzzO1nOPfvrAYzZv2zyeVEcZnwOe+NpoMwJLbpb6lrP1paknYYQ==
X-Received: by 2002:a17:902:c40e:b0:151:a83a:540c with SMTP id k14-20020a170902c40e00b00151a83a540cmr6960279plk.10.1647553589534;
        Thu, 17 Mar 2022 14:46:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ae74:932d:af6a:6079])
        by smtp.gmail.com with UTF8SMTPSA id h22-20020a056a001a5600b004f7c17b291asm7718766pfv.87.2022.03.17.14.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 14:46:29 -0700 (PDT)
Date:   Thu, 17 Mar 2022 14:46:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v2 3/3] platform/chrome: cros_ec_spi: Boot fingerprint
 processor during probe
Message-ID: <YjOsM1aRzpAiPErC@google.com>
References: <20220317005814.2496302-1-swboyd@chromium.org>
 <20220317005814.2496302-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220317005814.2496302-4-swboyd@chromium.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 05:58:14PM -0700, Stephen Boyd wrote:
> Add gpio control to this driver so that the fingerprint device can be
> booted if the BIOS isn't doing it already. This eases bringup of new
> hardware as we don't have to wait for the BIOS to be ready, supports
> kexec where the GPIOs may not be configured by the previous boot stage,
> and is all around good hygiene because we control GPIOs for this device
> from the device driver.
> 
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
