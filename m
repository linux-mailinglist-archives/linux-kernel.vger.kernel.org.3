Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF053331A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiEXVoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiEXVog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:44:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24487DE3F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:44:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c22so17377802pgu.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tdwGjLIYtWqSmu4a56WsblDf3vmkiiXdBBRqZtk4IQA=;
        b=CuE1tQFSmFVJONeZAL2ThFeB1vwnSfXzq20k9Ovt4tQxLU7TJ23JFm4sQVvfgfOHpO
         Sa+5HkQjHK3IdvBheLqRfLW1kI03jDepbgOkcxI9o+lvYjSXo2zrKOUfAI3T+u4CxO+b
         i6o/oSBBJ0Jnzvgq8zHo2W6K+MEnlXla0lLQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tdwGjLIYtWqSmu4a56WsblDf3vmkiiXdBBRqZtk4IQA=;
        b=WaesDF9kKZvVNl3Vfj7vJEQWsoWygclS04kMtykpzwgs0NCA9JWuJ6XNM67plpEIUP
         Jo1WaG43zdjm13HNsxcyMpYZRo4CeU8ujgSJFgV3B6Zw7KX1+eN7c3BZ1DQPkOW8U4pY
         xgyIMUVAbS76ZuOF0ZuXLjf4ed/9mjiwywpbVBkOCrL6v6ho2GyiOiV7sAelmazd39+C
         wJxqm3rEyec8EhQbIEYXquG0GEhGdUkkMwcObf3RHxUpPYJQz0evQBMAI8MCKhU0LZrC
         +SKAQyutxt44VfSd7iPQegeer7KkEPcXjhCrEmJK2I7kr779g6PfFLyFUTbqr6w/E8la
         GWlw==
X-Gm-Message-State: AOAM533Dw9HKTXriFGxM9rC2Q/SHRp1tJe8/8sWg7T4YBiXDz6JScsVD
        JxFlQidVP/nT0n9WVI5wnoZKeA==
X-Google-Smtp-Source: ABdhPJyJSoSMADvSLYVlL/2kUNvKx6n1UYhKgAQ/pEqNXyseFU7Q4J/kE1GmzKPcau1xYFh10SCG7g==
X-Received: by 2002:a05:6a00:a8b:b0:4cd:6030:4df3 with SMTP id b11-20020a056a000a8b00b004cd60304df3mr30432733pfl.40.1653428675455;
        Tue, 24 May 2022 14:44:35 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4d83:f549:9abd:427])
        by smtp.gmail.com with UTF8SMTPSA id e4-20020a170902e0c400b00161947ecc82sm387777pla.199.2022.05.24.14.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 14:44:35 -0700 (PDT)
Date:   Tue, 24 May 2022 14:44:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/5] platform/chrome: cros_kbd_led_backlight: support
 EC PWM backend
Message-ID: <Yo1RwaTYUtWWfdDg@google.com>
References: <20220523090822.3035189-1-tzungbi@kernel.org>
 <20220523090822.3035189-6-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220523090822.3035189-6-tzungbi@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 05:08:22PM +0800, Tzung-Bi Shih wrote:
> EC PWM backend uses EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT and
> EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT for setting and getting the brightness
> respectively.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
