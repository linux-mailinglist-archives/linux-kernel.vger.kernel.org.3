Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB14C5514
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 11:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiBZKI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 05:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBZKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:08:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D9186BB2;
        Sat, 26 Feb 2022 02:07:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8941B8119A;
        Sat, 26 Feb 2022 10:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB3BC340F0;
        Sat, 26 Feb 2022 10:07:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a6suHdAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645870065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79g6OfpDSx9ETcg9AV9TpSFsHTZWvmjpNpU+/s320+A=;
        b=a6suHdAT+1KNB8Rys8JCbnaf51MLLCvftPto3ZSV1gTjC3p1mCoRSj3ogn6PqaY+bsh5a4
        H0U9VR1GqVtdPouFqjefKhlAeRZ7sfxErugwWQ2cvp1C03zqWrkU/aoO7xxrVd3RvudR5x
        RrXwCaUbZm5NDhekndVmAhjokXGcLiA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 28391d5f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 26 Feb 2022 10:07:45 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2d07ae0b1c4so58148777b3.11;
        Sat, 26 Feb 2022 02:07:45 -0800 (PST)
X-Gm-Message-State: AOAM532cMzSOqq4tejT6WB6uFZl6SL3eNyZBOsxVeQbf86dV/KtDauo3
        8quT5osS6rY3Hs3EqkoolPeS6Piji0z8pblIlbQ=
X-Google-Smtp-Source: ABdhPJz4bhaOJP/yNCVlL4FXLwHREnxaHEs8VOyLgzZU3ywBYrUgpi88+2UkTVWX6JSSt4bsAU4ukcyEQD41J42CfaY=
X-Received: by 2002:a81:5a83:0:b0:2ca:287c:6b5d with SMTP id
 o125-20020a815a83000000b002ca287c6b5dmr11390955ywb.2.1645870064299; Sat, 26
 Feb 2022 02:07:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:71a8:b0:167:24f9:2d40 with HTTP; Sat, 26 Feb 2022
 02:07:43 -0800 (PST)
In-Reply-To: <20220226094331.3268683-1-weiyongjun1@huawei.com>
References: <20220226094331.3268683-1-weiyongjun1@huawei.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 26 Feb 2022 11:07:43 +0100
X-Gmail-Original-Message-ID: <CAHmME9ojcDsA5k2nmzVKjM-BP6XNcPUWPM8O7i3WrVKBJS-fzw@mail.gmail.com>
Message-ID: <CAHmME9ojcDsA5k2nmzVKjM-BP6XNcPUWPM8O7i3WrVKBJS-fzw@mail.gmail.com>
Subject: Re: [PATCH -next] virt: vmgenid: fix return value check in vmgenid_acpi_add()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
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

Hi Wei,

Thanks! I'll probably fold this into a v+1 of that patch, as we're
also waiting on some ACPI changes elsewhere. I'll CC you when I do
that.

Regards,
Jason
