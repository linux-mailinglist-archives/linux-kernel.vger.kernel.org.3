Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61196542BFB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiFHJwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiFHJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:51:49 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7323DDF2E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:21:41 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id v19so1069138uae.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gj53TGrcFKvg3WdH/kBUkM4Hf1Vz6A2pmV6JoIO4uQg=;
        b=gcSeh2/XbP0fRf1MOxr9hzlled1viRBXIvwTte1bSf4dJpwUIsWSJKo1BbWJwW1fhN
         A2rKZjSrPRqnzvSFPpJmRO3SZdVqG738atkz4iEc+oWYs5sjTbEErC1Yl+d0yoZS+YWr
         +nJ22b4Vc/isMgBWLMEp7nD7FYrSVQUXm42Ti4oBeM33zB6+E4wLlQhauFt4V9n9pj7L
         KxVy9xKyug/HL1HDcrEaNVonYwHt+qg1VpJDHO8+qt7exQBp7hNXkL8ZMcqsaFTjir1g
         85YXmxDIDspO/ov0x4lSP/XICksXKVyGdTSyxrMmpe12QeNQ2NKKc6Dy+Csb4OZIyhIC
         UtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj53TGrcFKvg3WdH/kBUkM4Hf1Vz6A2pmV6JoIO4uQg=;
        b=al+hWyxtnX0Y5nGgL+NvfOaBr/2jaMPDzqkKWCVU0BzHFqYVfw//7LE00n2wYtx11Z
         U9095jyXLjBhgfjDBGNf/1PCEi3ZQFhYTU2LVRX6tY1SNgJr95/eNWYS2hBuwcaBnOsx
         bViqcw9bCZdGZZHlmXddbUn2ibYdY7FlFFdiKv/gd5kjlr0KBeBUBpDWn62A2M66tYBZ
         o62STqKn2RmM1S8toLgPdnrS4URRfIOJLP+mNy1v4H5+ALNHgr+z/zqSkEk9Tu04vigj
         QLFyqSD3rXfDK9FifLX9WZPRIF/bScVuy1yMXw73GbMVaPMUddRN6B01nv2S25YnJTHT
         LTFQ==
X-Gm-Message-State: AOAM5315Ixv2lfSVe782RxVfgsknmYXgb5Svyhvfp2mEZ9ET+rI9excx
        RIvUrC+Gy2DUFqAKzaE2bKs=
X-Google-Smtp-Source: ABdhPJyGs8DWQ8wnxJdTEW/zlBdhQNuphjeSfXyBIMlzudn7ozMmCizNULarv7m5YEryAN0jhXtMWw==
X-Received: by 2002:a9f:3189:0:b0:35c:c458:ee11 with SMTP id v9-20020a9f3189000000b0035cc458ee11mr36371517uad.31.1654680082621;
        Wed, 08 Jun 2022 02:21:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v21-20020a056122121500b0035d31e4bb01sm2543501vkc.6.2022.06.08.02.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:21:21 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Miaoqian Lin <linmq006@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Helge Deller <deller@gmx.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Powell <gpowell@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: bcm: brcmstb: pm: pm-arm: Fix refcount leak in brcmstb_pm_probe
Date:   Wed,  8 Jun 2022 02:21:18 -0700
Message-Id: <20220608092118.1463835-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526075325.27356-1-linmq006@gmail.com>
References: <20220526075325.27356-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 11:53:22 +0400, Miaoqian Lin <linmq006@gmail.com> wrote:
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> In brcmstb_init_sram, it pass dn to of_address_to_resource(),
> of_address_to_resource() will call of_find_device_by_node() to take
> reference, so we should release the reference returned by
> of_find_matching_node().
> 
> Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/fixes, thanks!
--
Florian
