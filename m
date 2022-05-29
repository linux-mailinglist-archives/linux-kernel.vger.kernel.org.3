Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4876536FC4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 07:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiE2FYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 01:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiE2FYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 01:24:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645BAFAC0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 22:24:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d22so7587257plr.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 22:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1bXSF8ugiPCtCGiRfx0ofBs55v7Oyrz6oqRnMJR+0E=;
        b=dBUbfHkT6UNjrK/FkJ90mWtgbYvkVnnL4E9KTkFqiw6R0i+ocf1rG8s9bw8u92IXt6
         ThRrgRqKvmp9jK8PfSI1rEEAd3845afNBTi42cFt+I2wiqR5sM0/2o7ZWfS9mxtuvUdy
         +VxhHS+dDtTISkXwf+zyG/SrtocNCjQbu0ip16HIVfJO3+DlP0wClogsdrvjKlTMGi+R
         dcf16pDLumUIyByvs0rD+2LcNv8wOe8ctosmjtAqBF9xcu6t/AdRCHgkz5AIpwjM2Ayi
         s6gJOUXZqQHTVihIrKttc9zn6G0+ENapgp12PPmQLBFcHZ12fdYD4cwcxz/xM83ijlHv
         8OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=M1bXSF8ugiPCtCGiRfx0ofBs55v7Oyrz6oqRnMJR+0E=;
        b=UDQPxK9gVGKwhk/fu6nWPq5ADlL8llv8Mi7ubW/pIVIGGSrrCN8bO+zrqvJAuH8ppI
         DfcWTIj/VDAsCQvU38UhEJjVitLpz3gmuh9PV2TXDjxx2uCcc3uiNJVLrUzEclwv3jff
         6u6NBKC8oy5hTQofY4lHdYpIo991d1xr4nNWgmW4YxgjoaN06l6weR0492OlEQvEd3ap
         X1PUDK6zgV/vYZ3vu7LJ+MfeFTF+eGz0vLVOucC3l8wjuRaLZboadYnnI1ehdcni40sX
         IHQQGGCYitfwdD/0yGUQf4C+MryuvxjDaJYk+LN4wyaiB6KbDUE+4alieXJ6hz5rOJKO
         +vhA==
X-Gm-Message-State: AOAM532U1UTyyUqUb1+F30Bjqn+biyjOKpO6qZTPEj/sxsBdYloRsoAa
        rTFtoGaplveTA3dSs/upi4Gem0MDrRE=
X-Google-Smtp-Source: ABdhPJzAzSnhXbj5S2Uliqy9s9vZiNg4Zz+WlS6b27rHItGTk+bSRKewJdlGYRUlNuE79xqkhi65pw==
X-Received: by 2002:a17:90a:ba15:b0:1cb:be7d:bbca with SMTP id s21-20020a17090aba1500b001cbbe7dbbcamr16279520pjr.143.1653801883839;
        Sat, 28 May 2022 22:24:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j19-20020aa79293000000b00512ee2f2363sm6424338pfa.99.2022.05.28.22.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 22:24:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 28 May 2022 19:24:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Geraldo Nascimento <geraldogabriel@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: missing NOT while checking if Workqueue is
 offline
Message-ID: <YpMDmZZ7IpEhjywp@slm.duckdns.org>
References: <YpKA5Bdk1Cm6KgKU@geday>
 <YpLLnx8/xpZIPMbi@geday>
 <YpL2rHUXd0vf8IML@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpL2rHUXd0vf8IML@geday>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 01:29:32AM -0300, Geraldo Nascimento wrote:
> I would like very much to hear the opinion of the maintainers!

I have a hard time understanding what you're trying to do. Can you please
slow down and start from describing the problem itself?

Thanks.

-- 
tejun
