Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A25B4D06BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbiCGSlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244834AbiCGSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:41:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BFE83002
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:40:15 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gb39so33914922ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Yvj/Y0KMt9OVE/6hi/oWDvNcBCLjB9hWP/8iIxL+Tjo=;
        b=Kq2/ZdORQ7Z+x6uRxBOXq8UsPu3bx1kq/viB3BjbjsvzpCVUWGHa78Ry9AzHfyF/DB
         1rBm4RrQZvocJRm1h3DKFV/cqGKQ339p7bIl/tqV0PnmbFQh6OPSDXQzmF34juoL3VLi
         hxa5nN77RzPtUvwLFP1cWnWHa4gsyBgRhbh7qfnyZ2j049UCli6iqyyRuvhxWz+GS7lu
         cdc7xEiEGEnQRSYhZd0tcHhTEm8zHM5j8eHClnBSzEAn9IjW4SR5hYV/REHpOX4+eWwh
         SUhvUUWUh3qTcLRAd1ViHrYp0sq63lC6vS5/34dVGaMYKsHaTLLG0HQW2O70XEricT0J
         39Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Yvj/Y0KMt9OVE/6hi/oWDvNcBCLjB9hWP/8iIxL+Tjo=;
        b=Q37uGmc7C9bapIa792Q5xWEs4bMnfna4ECSitmLCt0A+RZRrcRO37QgJWr1N8v2vD7
         s94Uplsowv581khxAn6KswdJKdLBoCBWtIRp8alZB4Dhq/G9ivaxqf00YzUodSmtf5x8
         ki5maMkOWSYDGvonnf/5I+BXWutseRr2TP+8v6fSf0JjFfaWdCmziXapqQ4kzfgXdKEA
         ppVhpS3FXlYjOTuMDNDPJzLsHzVnBDFimeUIbQbKz3T8jC9gpJHMtEr1KIwv6DdxlYpE
         t/lFdL0iRC9h+ls1nVfY7yQJbMRhQUSZIl9sTjMVXTnZ8Ff0eSMGhB7prbrTqxDLiJ79
         fdtQ==
X-Gm-Message-State: AOAM532bn1SZ9c8cMyxZdT4YgDbM5AAjtRPxQJL/isikOGpf9ZLXExus
        ycyRgBUhvS5OQHx798VjqH8xhaHedGPSvA==
X-Google-Smtp-Source: ABdhPJw6w54WXXkvrkiQ1WMXbKsgiqsevEpqns90W8ZCA46c2MXKop5DCg7S0cCQFGokeYODMyMOfQ==
X-Received: by 2002:a17:907:97c5:b0:6da:c285:44f5 with SMTP id js5-20020a17090797c500b006dac28544f5mr10193136ejc.208.1646678413033;
        Mon, 07 Mar 2022 10:40:13 -0800 (PST)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id u9-20020a170906124900b006ce88a505a1sm5151639eja.179.2022.03.07.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:40:12 -0800 (PST)
Date:   Mon, 7 Mar 2022 19:40:11 +0100
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     mhiramat@kernel.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: tracing : bootconfig : Early boot config for non intrd systems
Message-ID: <20220307184011.GA2570@pswork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masami Hiramatsu,

Thanks for detailed explanation on boot time tracing using early boot configuration file.
https://linuxfoundation.org/wp-content/uploads/boottrace-LF-live-2021-update.pdf

Also for https://lwn.net/Articles/806002/.

Latter link also states we can embed boot config into the kernel image for non intrd based system.

I tried searching mailing lists not able to find pointer for same.

A hint/pointer on how-to will be very helpful. 

Thanks and Regards,
Padmanabha.S

