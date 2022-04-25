Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD650D7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiDYDqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbiDYDqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:46:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31618349;
        Sun, 24 Apr 2022 20:42:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b15so13640902pfm.5;
        Sun, 24 Apr 2022 20:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XJLiJZg5HG+ikEwaPWe7uEs1eOW08mcHB25PbbYNgpE=;
        b=Ps0zz82ktE7Sh2Vjle8I9BjPsQFxR7boyq1mTpomJGYUyyqlPFScxz4ijYuZcK0vxn
         me8y3q/aPtVKPG3L9FXZy4juMxVkvTek9NieNYaRKA6RzKfG6SyBto/PUXiAo1cPnp90
         3p6Xcz1WCZ70rML3a56N7/ddbsKvEKrPHi5ta/5oftx0xj2bNUijny1LJ+LrYxqsVR/5
         wWadMMFbDoHmWjX3ckF3XnuS7r6ud0vkWHlsaziNrUzcatdw7nnxb2h+EEqsC+bqo/iO
         xMeEQ3FCNRuVTXjl8IuUSCO3WLM7WOiVFEQQ/5pzV0qVM78jUqASTVEBbdM9Zld8wEdI
         hNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XJLiJZg5HG+ikEwaPWe7uEs1eOW08mcHB25PbbYNgpE=;
        b=5i7N6fw4GLtxag71U3ACuhCp9w8UQ8oive4IMuei+YLdKphWoNSVXePhaZJwfJ22+5
         sQAsozGRAClAVNRiUvH7sltdoUFjuHCWkduHq9hYvHxDnFrguPKZlyu93sx8RkeKhnZ6
         64jXwD3icq4qlyMKUlPY2/qVO+/05wqQ1d5JkdKD6VwOxnA4AfqWLhFbgNFdwe13K4xI
         FaTwxAzHeOlkrUjhp2MP7ytIzUkLEzJIBWJEU7hcP/P0aJy5QJuWTSXefzP9TiY2NZ94
         QeEVYtZjFgkmoa1JxYRZdhhshy+F8JJ+bBKOqtpPJoczVv/7bAZpFDw/vDSpgMQjbzeT
         5Chw==
X-Gm-Message-State: AOAM533Q/MMwF/5fz8izSw1Fa2nG4HnSQ3dMbQq4BI1g7SnPiq8Hrtho
        UOXhHdaSDiYvBfLDcKrJm4M=
X-Google-Smtp-Source: ABdhPJxkHTJzliONgUSJai4NnWk0TzAOhlUBTml/InhrGu34T+oNrz4tjBmW7Ox8B8RxuNsN0dP8GQ==
X-Received: by 2002:a63:290:0:b0:3aa:8b8b:1a3d with SMTP id 138-20020a630290000000b003aa8b8b1a3dmr13119908pgc.208.1650858157511;
        Sun, 24 Apr 2022 20:42:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id k15-20020a63ab4f000000b00381eef69bfbsm8025429pgp.3.2022.04.24.20.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:42:36 -0700 (PDT)
Date:   Sun, 24 Apr 2022 20:42:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/3] Input: sun4i-lradc-keys: Add support for R329 and
 D1
Message-ID: <YmYYqZLrymMzcLaH@google.com>
References: <20220414002349.24332-1-samuel@sholland.org>
 <20220414002349.24332-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414002349.24332-3-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 07:23:48PM -0500, Samuel Holland wrote:
> This LRADC variant uses the same 3/4*AVCC reference voltage as the A83T
> variant. The R329 and D1 LRADCs appear to be identical, so D1 support is
> accomplished through having the R329 LRADC as a fallback compatible.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thank you.

-- 
Dmitry
