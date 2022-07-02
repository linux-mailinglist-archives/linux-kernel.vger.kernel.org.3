Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC8564269
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiGBTMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGBTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:12:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5722FE0D4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 12:12:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y8so967732eda.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sfab9HgfAOoADvsUwSkk4m+M1h+ar5bTh7JdIRbhQUM=;
        b=IZu3Jt7AOIy4gdTFW6XqEe6Vy5q4dQ+7cSaaO5Jp5vqnbQSaeYqiPGKGx07IAhRKDq
         2VyC6TqTHecbOtQGmZQ4FQetwvWbB7MCC8atuWVX6mhiSaZIjU2JpeKPT2WamAatxPql
         QPwEYpNwFuLOWBTubiCV5jL+auYD0ILdi+3I6HvWtXr4pxlQup/lfJB1VuhndRqHu7ML
         MOHHtaIkc+IS5GuSJOj+M293GdqUrcdM7jMRz8BHZmd4v5sXhWZ880Rl1kokCA6DQ4oF
         DugtnNdErNp3rO1moDyy2VCnycHEIMjhIKSM30OKXPIr8VEQ7UrkEAP5FDjLg/JEFosP
         bLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sfab9HgfAOoADvsUwSkk4m+M1h+ar5bTh7JdIRbhQUM=;
        b=UOmx6eF3MxWzJfzCfukFrGe1L0hqsI0qnlPqBkAUS+MoyK+enMdcEXlTMaGzeHCcNZ
         +k3xeBFqRcLfMvRpH1myh4/bzvehdg+96LUcIfmBbwxyZKQbMtHGtjO2dSJE1GCJ/JBH
         aB1ABriIu6Ca9Plh0/7HujcBae9jEWpNiM5+5a7/BejuRDB7mrUNRNBgvbHjzIqRJS3L
         EyaYAXG6wXuZiqWPdikz5Tr742UtanQGEj/7DMTAXHlkMQoUIiCsU6ujFHZ5iEnXiuIX
         QgUTl34MFWi85DzMI7FqcUwjW/p/lYasVci9l8ujcjEy1zVVqD4syx9mf8Q3dp4iJt49
         nHgQ==
X-Gm-Message-State: AJIora8BcT2gthi2Dio4u6il5ojzNE8/sDE1ZCbdbEADyOx8jovewuvT
        FdFvZNd2hRVHJxDKAA6HZhU=
X-Google-Smtp-Source: AGRyM1trQsDgFAgjZCDM6+LfX2t/95nmgyXMYlWVjHe4Y++0mi52iclKRU1r5EvC8sNf+1WcdB+vpQ==
X-Received: by 2002:a05:6402:270a:b0:437:63ea:f2b5 with SMTP id y10-20020a056402270a00b0043763eaf2b5mr27486657edd.33.1656789125939;
        Sat, 02 Jul 2022 12:12:05 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640204d200b00435a08a3557sm17349318edw.27.2022.07.02.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:12:05 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] soc: sunxi: mbus: Only build the driver on ARM/ARM64
Date:   Sat, 02 Jul 2022 21:12:04 +0200
Message-ID: <8122293.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20220702032520.22129-1-samuel@sholland.org>
References: <20220702032520.22129-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 02. julij 2022 ob 05:25:20 CEST je Samuel Holland napisal(a):
> This driver exists as a workaround for old devicetrees which are missing
> interconnects properties, so it is only useful for those specific
> platforms, which all happen to be ARM or ARM64.
> 
> This solves the issue that the driver fails to build on RISC-V, where
> PHYS_OFFSET is not defined.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


