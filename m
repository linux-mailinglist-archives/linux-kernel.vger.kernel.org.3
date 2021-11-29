Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9739E461B39
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbhK2PpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349521AbhK2PnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:43:19 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB64C0619D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:48:41 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id j21so17417282ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=6lflMdMDyWCsRReATBZmeMmbT3AVAER9a5vz2Djv9wg=;
        b=6wU8S84vPNW8nzC8Y5XZQ2yI2MIL5smpttdLy5wB7jQhmVWE0UI5bPIqQCCLaNmuxx
         mEPUnTCM3iY3u3n/Y/l5lNDLYH3FOyyGAzQXKCvw+wnMKfIv4RwjBly7ZarjXWHpmiiq
         QOGKeTph9GrAiZVrU2ULefJDXR+E07MJsPcMgFRdKxU4z0GDEn+cxZiRSSd/zY5tmVu/
         HbOshw/hgrCQZuG2DgoMTNSvczHmdbNeUKBQUdPYV2UZ6hFixI43pp60QC/SrAkq0dy6
         IVbtGnkanCuU/3KU9NJWXswgnnXV94Motbg0Q9qZ8ginyIOu513Cd7vIxEiTutj5VQEZ
         nf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=6lflMdMDyWCsRReATBZmeMmbT3AVAER9a5vz2Djv9wg=;
        b=e7Rz7gWzEorO/vIZLI8yvAU55htHhEIniU1jURPUc5nTM6ZD1gnq9MOXaaK5QmLxzF
         kAT2JpcCSk2BDAzLEYvsCWZ2Is4iN4Q4ApieDw9g0cHJFnZErbtEUWep8bFV4jLuZXPV
         D3cBYCbUIWwUCMKqlu9vp/J8Ipo7Pp9Sk/G8EkroPqmfuvzIkyJrmmTNjY/asg9KU+pC
         gqbs3K32HnFEIjrhUvS5393R4l34OgyAph0DsUG1FMWV8AkXpl1cCs9i6P1Lp07z0ia3
         c9hqoujggwkGumXyLXIoh02rpaehR7zerAjTtglIMkq4helvM2lkV7iEWrpSoUNZoF79
         bbtg==
X-Gm-Message-State: AOAM5316uTx6pwvBdFAts5b010HWtjcux0yhJ/t4yYpW3THORsPdTs9l
        F+5i49GIMKoWXEvEy6HOe1krQA==
X-Google-Smtp-Source: ABdhPJz4OIp9UdfzMsdtowKIu000fxQqJGZ+3bsLM+5PL6k3rQO04zhquoxiwopA9z8r/qNMX6CgbQ==
X-Received: by 2002:a05:6e02:1c85:: with SMTP id w5mr24266045ill.288.1638193721004;
        Mon, 29 Nov 2021 05:48:41 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s20sm101164iog.25.2021.11.29.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:48:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     asml.silence@gmail.com, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, Ye Bin <yebin10@huawei.com>
In-Reply-To: <20211129041537.1936270-1-yebin10@huawei.com>
References: <20211129041537.1936270-1-yebin10@huawei.com>
Subject: Re: [PATCH -next] io_uring: Fix undefined-behaviour in io_issue_sqe if pass large timeout value when call io_timeout_remove_prep
Message-Id: <163819371570.64067.8629159720163179788.b4-ty@kernel.dk>
Date:   Mon, 29 Nov 2021 06:48:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 12:15:37 +0800, Ye Bin wrote:
> This patch fix another scene lead to the issue which
> "io_uring: Fix undefined-behaviour in io_issue_sqe" commit descript.
> Add check if timeout is legal which user space pass in when call
> io_timeout_remove_prep to update timeout value.
> 
> 

Applied, thanks!

[1/1] io_uring: Fix undefined-behaviour in io_issue_sqe if pass large timeout value when call io_timeout_remove_prep
      commit: 2087009c74d41ab8579f08157bca55b7d0857ee5

Best regards,
-- 
Jens Axboe


