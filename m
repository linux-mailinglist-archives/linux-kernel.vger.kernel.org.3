Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3425950D686
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbiDYB1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiDYB07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:26:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E4DC0E5A;
        Sun, 24 Apr 2022 18:23:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d15so23609705pll.10;
        Sun, 24 Apr 2022 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zUcfspQWuFNakeIGx6CmK3a/u4zfr1DWpzS9NwJkj0k=;
        b=GRn39ITW/vQuI0OhN501KHlqyOgSc2anudTUmsG3Ednce9Cpr1uhQTyfDa7hwrwKcu
         M3hb8ENp6XwKNf7DHZr8hA6WkIO45LQl1ZTdUFp4mG3YI4v7lPFA5r5M6wQDQB/VkYfO
         mciGssPqHdcB5PHlu+Ul7yy7WnmxglnstPTLxh4AaM2C72L4VS6dbgy0HgzafiW04ASA
         2Wz/FySeuho56inPHmwPPahDOyrJ3EBmIgNeQB81aIt22LUDyvaSqzmA7V0w17bjSdj4
         8j8hlRbbUcSTGI+2Xy4CcAAWW8xUkM5LeN/7v+efyIyJ/l3z8c+tbW3kPAov9ZskagYg
         Vs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUcfspQWuFNakeIGx6CmK3a/u4zfr1DWpzS9NwJkj0k=;
        b=yyx1naQq1h0xUqBMPiJXaFRcFAYBYP6T54dwozdQVdC6I5M/Tg4fSTMy4k+uuj6vZ0
         45vpIWfRHO4DxuehUa7eG4EBMpZECrosWsnFNMQZ4K992ip6Z3kDlaz45qwrjNI+G3H5
         oIhIYiW+RGf3Qm55oSg/5RvpjJ0ijnAcS7xBMharYcdrbIp8BQpCOhJd3JIL4GtsEkJk
         IpCSruD96zCg18mKPhcKZ/yqzJFm1VqkHY3WHDJ5LP4bFsAwVu7XzzAQV/GE3g02TdAF
         wJQO6FkkmtV3eKgIkrzOJ082BHtOC0hdhs7kSXA9FClFtI6G2Q/FMmKa4KjXeUQn3JAK
         OkYQ==
X-Gm-Message-State: AOAM532g3OFjje3XCnOWeAsP3vWYfbz/aRZstdOTh2yQLH95GEQeL59I
        GKe/eCDWjuU59kwyzU5+Z36wzb0sEms=
X-Google-Smtp-Source: ABdhPJy23A8efhfU9qDNVjEKp7NDcWNZtJI72SSZcHmCXqBQA3s6IL7Hj6ILjDXUAH01d00WXKr8BQ==
X-Received: by 2002:a17:90a:e7c1:b0:1d2:b8f8:ecc1 with SMTP id kb1-20020a17090ae7c100b001d2b8f8ecc1mr28532751pjb.176.1650849835535;
        Sun, 24 Apr 2022 18:23:55 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79472000000b0050ad180a4bbsm9367581pfq.1.2022.04.24.18.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 18:23:54 -0700 (PDT)
Date:   Sun, 24 Apr 2022 18:23:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     cgel.zte@gmail.com
Cc:     ran.jianping@zte.com.cn, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] Input: synaptics-rmi4: remove unnecessary
 flush_workqueue()
Message-ID: <YmX4KJNOceqgtbrp@google.com>
References: <20220422093304.2781183-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422093304.2781183-1-ran.jianping@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 09:33:04AM +0000, cgel.zte@gmail.com wrote:
> From: ran jianping <ran.jianping@zte.com.cn>
> 
> All work currently pending will be done first by calling destroy_workqueue,
> so there is unnecessary to flush it explicitly.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>

Applied, thank you.

-- 
Dmitry
