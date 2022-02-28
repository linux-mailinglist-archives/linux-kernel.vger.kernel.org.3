Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6B64C624E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 06:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiB1FB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 00:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiB1FBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 00:01:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E7D673D8;
        Sun, 27 Feb 2022 21:00:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s1so9675375plg.12;
        Sun, 27 Feb 2022 21:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iw3O7IY/4+VkiPHTXpF8iHviOWfwFfM/vA08fS1PzPM=;
        b=bKuCiLKQohgVE7rO3072agXXZOZ+eMQmaU8Yxze73FdxxbGEgufDDNod7k3tHC2o0X
         wa+g8/6eYAK0xO/bbHkJy3VU2e7ljMl2jJOL7Zgv6bmFyfRuM4Dq9+x9EW2iemnUfn+H
         D/Yoznp87fEaEVG561p3adZFJ3rFuDSabSvR9+rucT7vncvP6CC/ZJcAOtLxMPMZYG/e
         m1MuW2HO2HZKPSDaq1NCJNLsoSAPKupG62ENzZHSAgvfnplR3J+QfDM+HwlXlAkXXThb
         Z1h0HB977tkdu3sbdqNKfKe5DxZyK+vHmTzoINQmUteQuoH9p4C/4KPnxNH5M1gbP5lQ
         NDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iw3O7IY/4+VkiPHTXpF8iHviOWfwFfM/vA08fS1PzPM=;
        b=2g0J+JZx9pnRzxm7c7eefE42kuET0lvZqyw6vsjFojB9jd/lImKWDq5TRzKFJvWQd5
         +ilTKsW0B7wLYcg7AF/rshYNaiaKyv7SzJ/r/CaqbSlyhIh2Bo96bCS947qnHJzs1XCn
         xQHf0cfQa0fNvNKUokAaCp/NsnM0CudxtwLhuFjXCHRT13VTxg5hNoX/b/3DionMB0sN
         PSyb8Eq1eossKfc3qp/HctElBre/6Y8n+/tQ1wg4pbirQKG2BPp4OnQLa1e3rrQyCsA3
         LzH3bkiROH/tF5vWfZO5cmS/BprFkvJiZrzj1qumhaKlfbrryUp7nF3xCzTrI98o6d1L
         IjZw==
X-Gm-Message-State: AOAM532Y4Enm1MRrXKzpNlIaQvI2Q9sv8J8jDyxmPSMXWYbbLyU2EcI8
        5L7+fuvswmTQ8bqPSp39wog=
X-Google-Smtp-Source: ABdhPJy3uFQEYV2cK5wt3e38bld7oN5vokPpA0U5EcPe5JdjEa4N4ygUcG/CE5dur3ybTcCpMqWEmg==
X-Received: by 2002:a17:902:e882:b0:14f:f310:4ec7 with SMTP id w2-20020a170902e88200b0014ff3104ec7mr18305496plg.17.1646024439141;
        Sun, 27 Feb 2022 21:00:39 -0800 (PST)
Received: from google.com ([2620:15c:202:201:43a2:93b6:ebd7:94fd])
        by smtp.gmail.com with ESMTPSA id t11-20020a056a0021cb00b004ce1a7d5ce8sm11542326pfj.113.2022.02.27.21.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 21:00:37 -0800 (PST)
Date:   Sun, 27 Feb 2022 21:00:35 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH v2] Input: samsung-keypad - Properly state IOMEM
 dependency
Message-ID: <YhxW89ZYH6KgruvI@google.com>
References: <20220225041727.1902850-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225041727.1902850-1-davidgow@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:17:27PM +0800, David Gow wrote:
> Make the samsung-keypad driver explicitly depend on CONFIG_HAS_IOMEM, as it
> calls devm_ioremap(). This prevents compile errors in some configs (e.g,
> allyesconfig/randconfig under UML):
> 
> /usr/bin/ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
> samsung-keypad.c:(.text+0xc60): undefined reference to `devm_ioremap'
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Acked-by: anton ivanov <anton.ivanov@cambridgegreys.com>

Applied, thank you.

-- 
Dmitry
