Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9B509258
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382670AbiDTVvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiDTVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:51:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850BA4349A;
        Wed, 20 Apr 2022 14:48:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso3325732pjj.2;
        Wed, 20 Apr 2022 14:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y6aVLPsG4Asmj//M6g1qncMDEenM4pAY90v3oWnc06A=;
        b=eGKMdGifvA9FjgM/7vPgq9R7Z69W/p+BqnSkagQDeCR5l4BX4ltpyf93FzyyDijiGG
         Ebsz0r+LRRkftflxmyR3GOkL1vkyZd2gidvmkSZEKnSbiKpraxW7Y6D1Ygrkk+4fRmA+
         aFUO+IN/LcwKKw/hey8R5JA9RLINn/z/4uN2bwslKCXiv0+M1/zrg9xKh0fCv9jNRUxT
         dyv9BPph+ffbUP0BSzBJciqGubH42oWVK7WbeiorJJnkK46HzteKnTSLATsBcC/a59FQ
         erjR/eQAIoYWvxtP2qLbQr6HqhZlTHRKDTKLd3iLC3r6E90MijFyf503ttBp4l6ICpoQ
         1QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y6aVLPsG4Asmj//M6g1qncMDEenM4pAY90v3oWnc06A=;
        b=oqhS34C+QVs3fQgYP2EihlSI648J8QlZSRaMcbXVuEINnOscRe51qyQyS6AipHWGoC
         PJbA0Ie8Jr20yKz3IpvG8ucjFdau5D+Iaaj3V8wMQ5JyzZDOQtiip+AyrsyNO6XD/WJX
         sw5eqbAby8ZJjchp5M2U4f4OGrqo+sIBDcc20S2QvyNsRRMFaKDfhVKiKr6cO70V3QM1
         LdcdiyvQspzf/GFfFvnY/sGwC2jEWUeJ8cDqpTgqwb+FX5ODeFHanfRO8fsXKpYpLYpI
         AldNy3144P8XAdOogZU5VmqcAC2+CBQBnVxIpg2Nd2SMI1CrXnnXnX4Zc9htYXgXUMkK
         8OLQ==
X-Gm-Message-State: AOAM5301uq0tspKrb9E6UmRZzBp0zHRPXv8YYMKPYO9SnoxbmhNfL9bs
        ANQTqBAdsysUzB403xwLdY4=
X-Google-Smtp-Source: ABdhPJwbUP/0QN9Rmq6LTSn1m0b8+LQQqoPXPFnWoUEGWRc8+TVeiPe6fmh5z3G63yZ8p/diRpT/Lg==
X-Received: by 2002:a17:903:248:b0:155:e660:b774 with SMTP id j8-20020a170903024800b00155e660b774mr22814285plh.174.1650491314960;
        Wed, 20 Apr 2022 14:48:34 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:fe4b:9301:599b:d734])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a4bc900b001d26f134e43sm154376pjl.51.2022.04.20.14.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:48:33 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:48:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     cgel.zte@gmail.com
Cc:     alexander.sverdlin@gmail.com, lv.ruyi@zte.com.cn,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] input: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <YmB/ryd7TvBEd1yO@google.com>
References: <20220418015036.2556731-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418015036.2556731-1-lv.ruyi@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 01:50:36AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.Make the
> code simpler without functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Applied, thank you.

-- 
Dmitry
