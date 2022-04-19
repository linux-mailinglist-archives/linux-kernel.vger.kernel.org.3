Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C980507990
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355355AbiDSTBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiDSTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:01:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD26B3EF1F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:58:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d15so16649610pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fyf1PTx0yUxmy8QJj6XRdY4JzR19H+LadWdH1OjqpQ=;
        b=cfhuFASrLgcbhKuiKOEPbDHW+TBXmFYUW7h6Z14sl8+sHax5rf7tppGQp3YtjPADun
         NJdUU1JZCYebpl/uroO2XURjKcaMlRFsYCnZ3g8BppGbKnucsuU67+bXYVOjXMAwouJE
         XezHq2FUdU3RrJgCSxieSyIbOwwOTIRwxyBtf4cnt7fDRtXEw2eGQpaNTQX1y8y9Lfkf
         DgLIh8/3fUcGCkIoz5r4JIQJz4Hkm3v3tp+dRwFrimXx/s98Wguu2HQV7cDve8t7yE5t
         wR+5LNF0fF5r4qJkUQeqeafVblsSgV2q2cIGLJKuOPhJiCBeLPbt7W/O9weuW7Vww7FI
         UZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fyf1PTx0yUxmy8QJj6XRdY4JzR19H+LadWdH1OjqpQ=;
        b=lgFpCzBoe+qrlO4HLL9QSal016J1VuS75AOZrvOue139ULW3kEScd1Go0lax+bykpl
         Y51WS+Sk85B8i87V60DdZx7KHAHOw7FWNWoL1GzK+yxFumpxZfHyr7ba1RdRcc8z7gVE
         lVPRWu9aoheVagrz6NebCiKeRHyVEqbyWbJqCvwIL/iBIkTOe7cgOR5bOmLf8YQ1Agcl
         eTWQqJv0Z1R50MjWxFjhzMAuxuEZkvG3Aq7MjKHS5t4vz+H23c7Lp5XgYYEPmz0GHIZN
         R3+EfKjU9ngaxObp/nQzpELlNa9NRQ57yfnOz7Lg+fXYgQwyvubGAQa0gzgdP0yh9H84
         11Bw==
X-Gm-Message-State: AOAM533B/5+TyLivXfOyq5LzfnSfMwmyW4vSyw3Yd5CigP4R8e5QJehv
        h5kJqbFCXzPziTEh9skJRV4=
X-Google-Smtp-Source: ABdhPJw46gOyITqEvZVwPP6qrX4qd7JMNWZ9feMKsa0GHPYEScXqVFoswx4aqSD53b7bV+jW0e7EbQ==
X-Received: by 2002:a17:90b:1b03:b0:1d2:a338:c568 with SMTP id nu3-20020a17090b1b0300b001d2a338c568mr16154pjb.129.1650394725235;
        Tue, 19 Apr 2022 11:58:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y21-20020a631815000000b0039fcedd7bedsm17873525pgl.41.2022.04.19.11.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:58:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Ivan T . Ivanov" <iivanov@suse.de>, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: add raspberrypi to BCM2835 architecture
Date:   Tue, 19 Apr 2022 11:58:42 -0700
Message-Id: <20220419185843.248477-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409184017.114804-1-stefan.wahren@i2se.com>
References: <20220409184017.114804-1-stefan.wahren@i2se.com>
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

On Sat,  9 Apr 2022 20:40:17 +0200, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Recent changes to the firmware clock driver have not be send
> to the architecture maintainers. So fix this by adding the
> matching pattern.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
