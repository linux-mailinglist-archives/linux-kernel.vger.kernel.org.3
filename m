Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6565A542C11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiFHJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbiFHJxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:53:30 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31B942242F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:23:25 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id e11so4606918vsh.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e/0sdiSvd67y49lSu3lFcJt3wgjE4XshmW4Hj5qQkTQ=;
        b=P+sopvTzXzbdlKLLGlNvbPg6dP8yoK1KO1VQhr8+F4oGXMSnZ0CtfGvG7u7sus2aK5
         goaFJsZcjzpEABjSkK7uDVHykt9GYyfzSNGiCEuPtCi1vcYu8GKbGHTosvui0MhzK9dr
         r+OmnAS7uByYYeeseem6479sJplICTUctbXaBykvWbbQc7ssLuP0cvOMj84uvYucxVh1
         bUypmxCRL2xArWetvsK4e/yLUkg2nwdb0HkbkS6V1we6e4Z7dfJUO10GGbtWUfW/Xu4U
         3dLUxB3wQzwIioCJovsQkCRU0ixnPZPucAlUAWDD0pr7f0OHU+M7z0yzUhugJOMq8gVa
         CsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/0sdiSvd67y49lSu3lFcJt3wgjE4XshmW4Hj5qQkTQ=;
        b=cq/TrAG14Cbr6x0sTg9Bp3tv1AUCnE2GJlGnYKnjhoYGn+/9sUAy0lKPgM2Q1jlWHa
         dz8PSRtiVZPN7mCXPTs4xEZ4g44hivhGXysEsclbBbPkoUe9CL0Co/E/473ynhoCYA9X
         OPiPFpqGDOOMUiaNmGkCbUzMYFwOx3Lkhlt9tD7ri7Hm7CXmFg/5BQB/FI1ZOnSN5eRG
         v72SVsQL1gwPwKlgxPS7Cm5204UNrS4q6j8NPT1mzbu39o3xXj2aDmIyvTI1aw8RsoAZ
         siu3wfoHuoIaoLB7cho4KME1DwZE5HZKRMI4O0uvQ3hksAYhwjMaPDZgQYURLkmsp1K5
         12ow==
X-Gm-Message-State: AOAM533t+99YAVUtRLihpLJh0C9ZODckoFScoHXHEPSpCaWvUXodOGPy
        3cOIkVCxqiA6hKAym/1sZIH9hDgi+LgETg==
X-Google-Smtp-Source: ABdhPJzL7fPWhSa+eEh0ZKUBixmTBOfi600kfvLqXaCWWJ7+4bwDhB9LXx2IaqGxfIAH0gCTcnWR4g==
X-Received: by 2002:a67:7083:0:b0:34b:8d5a:93f5 with SMTP id l125-20020a677083000000b0034b8d5a93f5mr13375698vsc.27.1654680203900;
        Wed, 08 Jun 2022 02:23:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g26-20020a056102245a00b00349dedb879esm2222195vss.1.2022.06.08.02.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:23:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Miaoqian Lin <linmq006@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Christian Daudt <csd@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: bcm: Fix refcount leak in bcm_kona_smc_init
Date:   Wed,  8 Jun 2022 02:23:20 -0700
Message-Id: <20220608092320.1464566-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526081325.30954-1-linmq006@gmail.com>
References: <20220526081325.30954-1-linmq006@gmail.com>
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

On Thu, 26 May 2022 12:13:25 +0400, Miaoqian Lin <linmq006@gmail.com> wrote:
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: b8eb35fd594a ("ARM: bcm281xx: Add L2 cache enable code")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
--
Florian
