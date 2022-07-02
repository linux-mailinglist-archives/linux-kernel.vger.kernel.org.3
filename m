Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F086564260
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiGBTK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGBTKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:10:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63ACE2D;
        Sat,  2 Jul 2022 12:10:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ej4so6708214edb.7;
        Sat, 02 Jul 2022 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJWlBpt+Os9VSBvRo2e/skaQ1cvHZOQHuCjAGyhuyPw=;
        b=Zh0ZKdt3rHXANFz38Aylc49cbOlEXMz/vDbBIeLvIzyyBK0L5IVWIIWWMlOjjcrINB
         Re9B7YvR8KTuP3c/zsxXpQUrcIQ/8IaJO8VcfXolR2t8OTFiFETd/M7aD7FeDp8T+k6j
         /WwkrafU6tRzmXho/Crt3BcXxUMS1v5OR0hOvrq+LJnnmOJfarj5cSoh7mYvqCluJmVE
         3ThCf5mhHNewOe7dwj/0TFfZeT32fox+pCI94bwAaQMUH6jsCordmv2vZB6NhG2Un7pc
         v9s40ZWJX02EVtd4tQ0RqZJWtgQoGTehoULlOynga9qDPzS05bFC3USAFO6TF6OSuKYg
         b91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJWlBpt+Os9VSBvRo2e/skaQ1cvHZOQHuCjAGyhuyPw=;
        b=IxhFRphkfLPa+0AUm9xDv8ai3sUhUEGe72cfTuKFSXkegp41DXkLfbwVb+s2GrGog8
         YYdKYq08kMWtUo4+25dwZc0Lebnbto+llnDPCHE3NND+VU7Wec45l6jWT2MpK3c9VoQe
         XRGuvMKNBteBD2tqVvQF8ZcQgDif2Uw24XkVQjimXx+ks2PWBpYqnqnjCxFtKtfEbjO8
         LUzkuuvymzIJ+hWZLMd+lLaS15/UwaruqPxiAzL9mRYzHQQGNU/70VetoKkHl768fZCE
         nxlzxbjM7Z/1HtQOiD2WKrQ4djQ0KDaTzKe3cSxY0BnZdyaEppUnToVyjpBL6Xzlk+7U
         jhmg==
X-Gm-Message-State: AJIora/fjSl63O6STWhui6cPxc8Cs/mdl2GhHuqYfdnXi9DK5jHE7HaE
        8qHI0dbbHwpXn8OAX8hTr4A=
X-Google-Smtp-Source: AGRyM1veNLYsqyxkP9J6ypKlqwBrT0s7i8IRXbIqDNfN/1ELacSMYeqk5kXKoeVj6P8AkpFWag0YDw==
X-Received: by 2002:a05:6402:3785:b0:435:5d0e:2a2e with SMTP id et5-20020a056402378500b004355d0e2a2emr28146324edb.307.1656789023118;
        Sat, 02 Jul 2022 12:10:23 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id a21-20020a056402169500b004357063bf60sm17228262edv.41.2022.07.02.12.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:10:22 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/2] clk: sunxi: Do not select the PRCM MFD
Date:   Sat, 02 Jul 2022 21:10:21 +0200
Message-ID: <5733611.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20220702190135.51744-2-samuel@sholland.org>
References: <20220702190135.51744-1-samuel@sholland.org> <20220702190135.51744-2-samuel@sholland.org>
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

Dne sobota, 02. julij 2022 ob 21:01:35 CEST je Samuel Holland napisal(a):
> The PRCM MFD driver is already selected by the two platforms where it is
> actually used (MACH_SUN6I and MACH_SUN8I). Selecting it here builds it
> unnecessarily on the rest of the Allwinner platforms.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


