Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C4956D327
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGKC7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKC7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:59:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5256445
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 19:59:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so7033292pjr.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2WqbsqnJBgBtP7DjnnhraykI1JIFLr/Z5s9tS9xDIA8=;
        b=YV0saGWc86Dr0nLb97pd2N+sjGpt7P84y62z7L/fx7FhOr67Aidp66vasyVaFWstou
         1sf5hspntxeheOTlauMVYz9fUaAO9R8te5hc8OdqcPv3U2+OrYkNFbwjlUVchNpjv5jz
         PYtziagU5jSqpiRvryMD0DoW8T8r7Afv47ZpJsFhwgag8WdRsdac8shwhzTnVXPD/gu2
         q61/IokaBBQV4swk7VAEuIkWydju5kDpcS+nUpd9xdKCsOAGF4rHgoS6rmcRQO+My9aZ
         eAy2A5YNTSA7s8DsBWi6jezZe2CxYOXp3sCWRvF7qG/qGUzvHtzLeOk74HeHcLVWDRKQ
         CM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2WqbsqnJBgBtP7DjnnhraykI1JIFLr/Z5s9tS9xDIA8=;
        b=cMv2l0GQylIjWaX22j4PU5LqhuyBTT1UEMxyvy3IXG6BaTD5zLhlgThaCZadL2JpYF
         B/Sm9nuy0c9DskcwteD7BWsKCAUXCN5J0woX4P92AxSeeJfK0As+TUsU7uxuPY5FeDHu
         xO8T3ffyIbO4BGkCTBre0yWnALE/Ad4Dmjl5m0V8/itnjjAxZT5W0VlBIfGlDSjiji7k
         oNnaaG4nfiXYSYdKCZEDERggrhJ94mtKVTEaA3t5J90UUAM7jj8cXG8z4ImfGSmD+HW/
         MEhPpUs35JWE6uNS8vecOdbeY+iPD8GgKv+wWI8tapZ7uykqYjWP3X8b+UWTpuFvcS9Z
         o+QQ==
X-Gm-Message-State: AJIora/Qs72We535Pj4ED4n0BN6SG8/51DUGy6p3/vrMEQgvc/tqOhQB
        sWN2gHYm8jdWWtSmVzlfkio=
X-Google-Smtp-Source: AGRyM1vFxY03KrBrNYv9cLq5Q8Vjt9qgJF235uzEVGiyWYj2Cxe7tws80vt3Ka3OCRoCfBVcZOglBw==
X-Received: by 2002:a17:902:da82:b0:16a:7ca5:36c0 with SMTP id j2-20020a170902da8200b0016a7ca536c0mr16226830plx.27.1657508389812;
        Sun, 10 Jul 2022 19:59:49 -0700 (PDT)
Received: from localhost.localdomain ([116.232.54.164])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a3f8600b001efd4dbcf13sm5744087pjc.39.2022.07.10.19.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 19:59:49 -0700 (PDT)
From:   Zhu Ning <zhuning0077@gmail.com>
To:     vijendar.mukunda@amd.com
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
        broonie@kernel.org, christophe.jaillet@wanadoo.fr,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, lkp@intel.com,
        tiwai@suse.com, zhuning@everest-semi.com
Subject: Re: [PATCH 3/3] ASoC: amd: fix for variable set but not used warning
Date:   Mon, 11 Jul 2022 10:59:33 +0800
Message-Id: <20220711025933.3445-1-zhuning0077@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d2828d36-275e-60d7-782e-2bff265bae0b@amd.com>
References: <d2828d36-275e-60d7-782e-2bff265bae0b@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is ok. The machine driver should still function well without gpio.

if (IS_ERR(gpio_pa)) {
        gpiod_put(gpio_pa);
        put_device(codec_dev);
        return dev_err_probe(card->dev, PTR_ERR(gpio_pa),
                                            "could not get pa-enable GPIO\n");

}

You donnot need to handle null gpio_pa gpio.

if (!(IS_ERR_OR_NULL(gpio_pa))) 
	gpiod_set_value_cansleep(gpio_pa, true);
