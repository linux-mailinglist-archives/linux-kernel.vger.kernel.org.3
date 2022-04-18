Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4FB505FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiDRW4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiDRW4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE12B2BB11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:53:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t12so13516397pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afvg5NWVwD/qVAkdktGqgMo9aOSaMIcJ+XINPIEZDPs=;
        b=E6XIMT0VFA3wpgpCaSaflm+uvbJL7CGEu+tBAucnRfcBXoD3NmWmgurBI47Nl5Ml+C
         E5qvU1DX9IHya8+jp9x+gUHliBhJCRTqtaKyNAn076FDV3LbeO8cOCpGqpWyCf/WiNIo
         H2RdDcaOvuJeW3zpvJtJwdpPxOqVQmGQP4vH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afvg5NWVwD/qVAkdktGqgMo9aOSaMIcJ+XINPIEZDPs=;
        b=CkIZlA8vrNUikWi6g8N0SlJE9VasrmRzH45gYqFH5Jw9hi3DGw4/AKLp42X1maS8o3
         G9LSruO8fTCVGZjvZ2XOld3InOT5hG5YJ2yKiYjBn4ehNhFh+Fjc0sIc7l+n543BzHsd
         +i9BBuK6o5u2Og/4uuXZrKzLP3isMFHEGXXaqFYoGMfNBevalsInIEsVpacZavKtVkpN
         CLQYIbeqvxrxhHdQVKvtC0ltpf0xCTm7zP0Nb467hVU9I/o0DcZUxfz4MBobqePwkjb8
         SmuR8RHCxP3AR0YQEaETeuhXmh9007CTk2DM+8eFhwYxBVUE8YtjKmFYNEBaVFgznsN9
         erkA==
X-Gm-Message-State: AOAM532PRGUoEgMb00PMoXxSsp18Ubx1qwxbzkT5qSHFPl4qmdaoJr7O
        xaw03VMuN/cEV7O+gOOSmAQIYQ==
X-Google-Smtp-Source: ABdhPJxgNiCCQXH3r6Ye7JvBt5yRcdnLBD7xC7vmaL9G1C+elNu5N4RNV8qu7p5gxM9T3Zk8wDIVmg==
X-Received: by 2002:a17:90b:38cb:b0:1d2:6c52:5be0 with SMTP id nn11-20020a17090b38cb00b001d26c525be0mr12880416pjb.32.1650322400522;
        Mon, 18 Apr 2022 15:53:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b32:a0a5:ec32:c287])
        by smtp.gmail.com with UTF8SMTPSA id x5-20020aa79ac5000000b0050a4f4c4251sm10319715pfp.206.2022.04.18.15.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 15:53:19 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:53:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: core: Replace _regulator_enable_delay()
 with fsleep()
Message-ID: <Yl3r3tiJ6uFTqbd2@google.com>
References: <20220418141158.1.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
 <20220418141158.2.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418141158.2.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 02:12:40PM -0700, Brian Norris wrote:
> fsleep() was designed to handle exactly the same thing as
> _regulator_enable_delay(): flexible sleep lengths, according to the
> guidelines at Documentation/timers/timers-howto.rst. Let's use it,
> instead of duplicating it.
> 
> One notable difference: fsleep() allows a usleep range of twice the
> requested amount instead of a fixed +100us.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
