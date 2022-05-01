Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD3C51646C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345419AbiEAMlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 08:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiEAMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 08:41:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C51369487
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 05:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7959B80D5F
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B76C385AA
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:37:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CPpjIrua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651408669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gyw8g/I/yf7uRFwPuaR0Fpjt/xWN9KsIsKQjFiHvPw4=;
        b=CPpjIruap9BntjM9f1SJEwXu6YNMHhz/u/YDhiSpnUU1KK8BRT/L9UoE5JpcSLw7ygoRBT
        3xNWh30yLLBOkVyIrQ4pYmIwAHBez9DXsn7Enz3qn1mce1rHbrT74s4/wINH8Zxie5Zbza
        1u9fnIEDomTT+GyNLiuIrEy5BVPaq5k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1e5ad942 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 1 May 2022 12:37:49 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id w17so21982791ybh.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 05:37:48 -0700 (PDT)
X-Gm-Message-State: AOAM5306u7MOc3pAndtgX+s/ljV6v5035XcfM2Ge652Y2pRiBELQeytH
        qpMjb5FmglqvMnNU4g9co4flRGO0TBjKeMDAd/w=
X-Google-Smtp-Source: ABdhPJxEPGDw/oHqym6By2FkW3IuuqrSHC9Q2GYNjar3/iXlksNjYDRNXXphaKKe5t1erxFjbODHbbfajkM6t1Ho7t0=
X-Received: by 2002:a5b:8c5:0:b0:648:d88b:3dd5 with SMTP id
 w5-20020a5b08c5000000b00648d88b3dd5mr6785570ybq.267.1651408668132; Sun, 01
 May 2022 05:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220430195620.2772485-1-Jason@zx2c4.com>
In-Reply-To: <20220430195620.2772485-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 1 May 2022 14:37:37 +0200
X-Gmail-Original-Message-ID: <CAHmME9oGpNN2C4OM6nMB=BHiRaX1pSTHHfioWOzi+5bdXgOKmA@mail.gmail.com>
Message-ID: <CAHmME9oGpNN2C4OM6nMB=BHiRaX1pSTHHfioWOzi+5bdXgOKmA@mail.gmail.com>
Subject: Re: [PATCH] random: do not check for system_wq initialization in wait event
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still required actually. Dropping this.
