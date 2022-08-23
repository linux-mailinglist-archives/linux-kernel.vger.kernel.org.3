Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E071459D210
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiHWH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbiHWH0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:26:23 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0C262AB2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:26:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bn9so5142519ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=J8u6XOZ3+5OnWV7Suub07jp0shX2a4U6qT+9ErWtKF8=;
        b=rdiAI00J4m73YNSjc72UGiqtKoXAQu6Yr/rrpWO2d/NmA8N3/OVbQKAJGlNRvPZSgs
         zEUWfUoX6uYAPAIUWydf/YGyzuW7oEbDFlDUQG5g+cZ9sFsjuDhbafJJHQjQho7IQBjG
         EcmYhL6p9ixjHE1NXHoU49fmuq+hXqI09eoVJ5qDw/ojjM7ZBEETWci2y0xo8iAS1G5+
         iBZRpilSP4wxjYPRqh77mWtQlK9iA2ujsYvICpiyuUT/On2FO3vc26n8qxR5UwNAmK6K
         Jaz7WS/rCUBNPEnau0phXbWDJYxjJyBXSn4QFwDCNV18iLTSkN/2cVuJS8jzbQOhKfby
         0Rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=J8u6XOZ3+5OnWV7Suub07jp0shX2a4U6qT+9ErWtKF8=;
        b=4rluDLW3FTsc+cBqJd8m9ejwkcFroY/+cbWfvBMTCbZdcBUOJCi2engV5JN3m/Ug94
         XCGUDV+WrBqYCy0MDmZaaElbVyDS/wTBs7SrZVL6KBuUHGJp+Vls6MeXvW5nPMvVNWtL
         V//TOmR5XahgON5/+nfeb4AdzpZR3UtNh+UqI7UBreS5QRT1pxVVRIU1K0sHG88mE8QQ
         Wl2Ydv+JhvuysgWc5HjuNpddSi/+2/9QgwfuS9nNCcMPAgLTaGErmoRMgVW1xkbET9Rm
         Ns7DbyvBwmclJ6V7MYHDDiadRQTrhSaPMDhe4HhvgCPWXs4Qd2riWCnAMsIQz5lr4B6L
         ft1w==
X-Gm-Message-State: ACgBeo0LfZfbVpO4/Xvo7teQ15ZpQg9fHDkepb8yFvBsnrtP5AfxBHnw
        PpKLRi1jXcTJPPgV/thIifwxPA==
X-Google-Smtp-Source: AA6agR4ZZMX/TIi9KSCwYaiXNNouo3uMLZC2yG375OWN8koaYIlump3d0dtq6WBYXtoVvZD+/f1nSA==
X-Received: by 2002:a05:651c:a08:b0:25f:dc16:2161 with SMTP id k8-20020a05651c0a0800b0025fdc162161mr6967570ljq.165.1661239580417;
        Tue, 23 Aug 2022 00:26:20 -0700 (PDT)
Received: from krzk-bin.. (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id i24-20020a196d18000000b0047f8e9826a1sm2357410lfc.31.2022.08.23.00.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:26:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     cgel.zte@gmail.com, s.nawrocki@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        chi.minghao@zte.com.cn, Krzysztof Kozlowski <krzk@kernel.org>,
        cw00.choi@samsung.com, linux-samsung-soc@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, alim.akhtar@samsung.com,
        linux-clk@vger.kernel.org, tomasz.figa@gmail.com
Subject: Re: [PATCH V2] clk/samsung: Use of_device_get_match_data()
Date:   Tue, 23 Aug 2022 10:26:13 +0300
Message-Id: <166123956379.357728.9628049310036670425.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307033546.2075097-1-chi.minghao@zte.com.cn>
References: <20220307033546.2075097-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 03:35:46 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> v1->v2:
>   Add a judgment for returning variant to NULL
> 
> [...]

Applied, thanks!

[1/1] clk/samsung: Use of_device_get_match_data()
      https://git.kernel.org/krzk/linux/c/777aaf3d1daf793461269b49c063aca1cee06a44

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
