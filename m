Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF551247C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiD0V17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiD0V1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:27:53 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29EC6EB15;
        Wed, 27 Apr 2022 14:24:41 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-deb9295679so3358895fac.6;
        Wed, 27 Apr 2022 14:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OvoClY7Wo6sAwCkQijL4bMeLDhiKrdnEO3rWf59LH4w=;
        b=yTuTJpWeQtYskSRnsu25sfH85UGTeutHKlabu/MLCC86cXPNBKg00i8GcSqsWtsvN6
         I4slHjyvrmMEqNzavMIYa1K3PJYmeHtKaIhHaPRTQo2J2REdgnNoYamzTlRH7aV7dZuG
         pFxtmVUiOUcqZ5C+OyHDXLrgkGX99yz4mWo7Ta9pSDZMegH+iTXbbqaUP6Dfp0QewWBD
         +d1xb/Gv2tznGb9SPXGtI+0PHU2rWskU2PIJ1bg8zp/ues/0LCA9m+92K9iEhcXlKcx8
         RXvJ8dXuo6Cc8LNPGxLqn42KuRXn7Y4fIsA/r2C0h5E2zkNvFD8Bxo8c4AZFCDz5hSFi
         tvRw==
X-Gm-Message-State: AOAM530tT5unggPK8uims+rR+cAfHc+1gbgOJGbPnpwl3pvlxims6THH
        73O+Uotd5GXDEy19Y3Rhbg==
X-Google-Smtp-Source: ABdhPJx/70ovX3HOazt8zRT+CTgAxkXr29nwoWaE6axRQEDHV4FvWZ3Gtc7RKPYuBMQ2hTUa3jlvlQ==
X-Received: by 2002:a05:6870:c390:b0:e2:602f:d81 with SMTP id g16-20020a056870c39000b000e2602f0d81mr12223269oao.262.1651094681062;
        Wed, 27 Apr 2022 14:24:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j17-20020a056808119100b00322e1b61907sm6337123oil.35.2022.04.27.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:24:40 -0700 (PDT)
Received: (nullmailer pid 688314 invoked by uid 1000);
        Wed, 27 Apr 2022 21:24:39 -0000
Date:   Wed, 27 Apr 2022 16:24:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        nsaenz@kernel.org, olof@lixom.net, rjui@broadcom.com,
        sbranden@broadcom.com, soc@kernel.org, stefan.wahren@i2se.com
Subject: Re: [RFC PATCH v2 2/3] of: Add support for -@ when compiling overlays
Message-ID: <Ymm0l2/oGpt/SeDO@robh.at.kernel.org>
References: <20220427185243.173594-1-detlev.casanova@collabora.com>
 <20220427185243.173594-3-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427185243.173594-3-detlev.casanova@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 02:52:42PM -0400, Detlev Casanova wrote:
> This commit adds an option to compile all device trees with -@ to add the
> symbol table to the Device Tree Blobs.

Why would we want to tie this to the kernel config?

Globally enabling it has already been discussed and rejected.

> It prepares the introduction of device tree overlays that are
> not applied on device trees at compile time (dtbo files.)
> 
> These device tree overlays will be used by either a bootloader or a
> linux userspace tool to extend the base device tree.
> 
> This is used e.g. for drivers that need device tree nodes for optional
> non plug and play devices, like an external DSI touchscreen panel that
> embeds different i2c devices to control it.

You can already set DTC_FLAGS per directory (and target?), so enable it 
for the dtbs that have overlays.

> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/of/Kconfig   | 8 ++++++++
>  scripts/Makefile.lib | 9 +++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
