Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C850F524515
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349972AbiELFjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiELFjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:39:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986E21687C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:39:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i1so3889770plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+ADADOLsy5U0cbqUSAL8sVCV2JHFFb6d6snlliJvBk=;
        b=CW1zEzHl2MHW93A2lOFLisKLVaijVGVVOUbJG+LpYd/sEPsAq1gJ4cZLkYTgdYyeq9
         luxVY40W6rvMrywxYpQGit5+fe+LYvyCUUjqptcXIlkkwUsyu+YSIV0NWVRcHhwnVVfh
         4OZSrJP7mHtdXyaAovFq2mqhstaDb0N6wzo3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+ADADOLsy5U0cbqUSAL8sVCV2JHFFb6d6snlliJvBk=;
        b=4GeEe9S3dhMOeA+TiyoCB+1UXoSdWXVTVROzyp5OH0UM5Cf0c4Tv47BnpzAt8r4uWg
         UkEEt8jDH9QmFNnsJSeUdtCsALp/fu0IZtAKWnZsCyGKMN+18ii15niz/5iToyM0vIx/
         Z2/30r9t/428PhBqQJ1yG2oXrweIK+ED8N90drQLHK6MhIuW5JWVpMcreUeFC0uPgU54
         rloGeo2nyMl47I4rtSQwFDGdkBn1Gy1/7QZ/OI3EUtSkEol9+f+/Dn67laIizepniSwf
         5gL/spw4HzbSqaHEWzEUx7aVJncpfsHvEeHxc2ZJ9qQu5+CSmTRyQMjPO6RY66BTlK+M
         a7qg==
X-Gm-Message-State: AOAM5324IQMQyXnEsmhgcNh7xZiwtME1MQZBYDnbBKn1i94nuyvCXZFF
        9H1crdJsIXdrhx2MMLLx6Ey5gw==
X-Google-Smtp-Source: ABdhPJzpiXxGpg3/2XDINmqm/PjN3LkXht9fMp4MYaS4FJyG7BSAhZVDPSpPqMiJLhETFW+kFl0k3Q==
X-Received: by 2002:a17:902:a9ca:b0:15e:f017:91b5 with SMTP id b10-20020a170902a9ca00b0015ef01791b5mr27782532plr.27.1652333992397;
        Wed, 11 May 2022 22:39:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ab8a00b0015e8d4eb1casm2880921plr.20.2022.05.11.22.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 22:39:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     songyuanzheng@huawei.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: usercopy: move the virt_addr_valid() below the is_vmalloc_addr()
Date:   Wed, 11 May 2022 22:39:41 -0700
Message-Id: <165233397814.161845.13267754142064821597.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505071037.4121100-1-songyuanzheng@huawei.com>
References: <20220505071037.4121100-1-songyuanzheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 07:10:37 +0000, Yuanzheng Song wrote:
> The is_kmap_addr() and the is_vmalloc_addr() in the check_heap_object()
> will not work, because the virt_addr_valid() will exclude the kmap and
> vmalloc regions. So let's move the virt_addr_valid() below
> the is_vmalloc_addr().

Applied to for-next/hardening, thanks!

[1/1] mm: usercopy: move the virt_addr_valid() below the is_vmalloc_addr()
      https://git.kernel.org/kees/c/0a76d4c331b4

-- 
Kees Cook

