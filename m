Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D954AD142
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbiBHFvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiBHFvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:51:53 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB3C0401F2;
        Mon,  7 Feb 2022 21:51:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i17so17025585pfq.13;
        Mon, 07 Feb 2022 21:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qPomn2aTiO/Wqql0j5UpXavLHxVxjTovhC2XCkgw4r8=;
        b=JF+6fUvAFE9hNgvPF9O092aY/u6NFl4UKjZIie/kuUdmWWpmAuTihMJ/vuFk7CV//9
         WfqwUgGUFBDA2INXy3l94V0BeoMahLk4ohguaYeVg4jk+LbrBwEHUKxEi79JBIZjeXZT
         vkpYq+dx4Zf0IiHoGhb4GxXoGmQ3b8NgCaUTS6W8s9yDtLo1IqcaQE8RpcIagNidBA8L
         b6bYkfw1KK/sKEAQcIV7tdF9V8loeFqfVSjD/rxRZuONBIM8GIZUsM2O0Mvwy4fZ2VPA
         elMCHSMr/pKihL/mFM64l7lAw0JDCNQ1gy9pw9+Ohbw8v6QgnuGLd5+P/B5jJpBBRF8S
         xWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qPomn2aTiO/Wqql0j5UpXavLHxVxjTovhC2XCkgw4r8=;
        b=Ox+EFn2BcTgwkkGV+iCdk7G/XaqDIFbCVUO7KROOQ2GIw2Ilv5OI4MmjhB6j//kojE
         ED/T38ynZPbo3nQNfoLRKIQtl2hLsLH7wf3gXx19TnCVwLP2Uce3nH9uKwVXzYS6tyNa
         VsbWn6YH6ZvFNNU7d/f1ZnbmCagDpyDMbNYFLUFncqlitp06sOLACt4XThQmlGtnUz19
         cM2/O+mX11MSBeCjsuXFSE4/D9LteFY/AA48qIfNOCTRfBS7z5y3Tqn2QvyxJHCjcOHs
         6d5xal96LnkXTwXLDBFdgEFKElbOcrjOTjIXBM+db0zumRpsEZinm2PXrH0/s9vrmhgE
         1C3A==
X-Gm-Message-State: AOAM53005p9Mj335ssgpfml42v/bfeo8ZFsSsjLdHUhP6QQi/26WotaU
        ygp6JiVRmPRg+Gv4UMmQxhg=
X-Google-Smtp-Source: ABdhPJxTi6c7zODiZt4BTMaMo4DcM8IRpV84XC6QGJ4NBxpob/G/3wllUDpw6QP+C11lZD20O8t6Xw==
X-Received: by 2002:a63:171a:: with SMTP id x26mr2265185pgl.447.1644299512234;
        Mon, 07 Feb 2022 21:51:52 -0800 (PST)
Received: from google.com ([2620:15c:202:201:7164:d581:d7ee:53bb])
        by smtp.gmail.com with ESMTPSA id h15sm231154pgn.4.2022.02.07.21.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:51:51 -0800 (PST)
Date:   Mon, 7 Feb 2022 21:51:48 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: input: mtk-pmic-keys: add MT6358
 binding definition
Message-ID: <YgIE9NjPGEPlwgtz@google.com>
References: <20220121140323.4080640-1-mkorpershoek@baylibre.com>
 <20220121140323.4080640-3-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121140323.4080640-3-mkorpershoek@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:03:21PM +0100, Mattijs Korpershoek wrote:
> Add the binding documentation of the mtk-pmic-keys for the MT6358 PMICs.
> 
> MT6358 is a little different since it used separate IRQs for the
> release key (_r) event
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
