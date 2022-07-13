Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD42573B24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiGMQZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiGMQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:25:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B300923E;
        Wed, 13 Jul 2022 09:25:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so4486914pjo.3;
        Wed, 13 Jul 2022 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NJbO4Rf7TW4PsWVYRG0jsf+QfXdUdOnvfPpzJkjdl10=;
        b=K8CFPKXrzo/+w4DR3qbs+AiJ2G6A4nqZ+W4+EHcQsmTCrdVX0IOiIU/XHhgP1MEeoA
         zlCphALP5QjYKNpWvxH0XoPDDCqEpDMuII/dpHBo6sUOc4KdlmAPZNHDnsIBMDMU17xk
         mb94nVNeBorOUKnatbyq9HGsDF3Tkl2rJ9EYLM9M/X7k23Q+FypiNb9mSFv+9u2fcBsg
         eS5JatyHkL9Yrrxq18JfoSRZ+ZOCNB+Kzl395OLZ+tPTmBkYywt1qSEFcV7N5O6n1I59
         omX+FsBqhSPRvkjCsAuN/+79Xlq8OuT4BIvV975qQ4z+174YbAtMo6Z2G8q8qJ+IQEUB
         bkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NJbO4Rf7TW4PsWVYRG0jsf+QfXdUdOnvfPpzJkjdl10=;
        b=M6CDqppVua3h2GJw38lG3c8WTfner6/9WzDlXo7SlrfIcT7mLoFfuZO5jRl2yQeHDV
         H6Rg5cIzPv05sa6VnvdRwvf2r7sJOjFHPQgdOAJiO1MQep8Nl82v+6dc1krxO7/VErCP
         x2cl91aoi9RCzmPMA9imRwcfurNG8sPSCx+qXY8dD+r7TYIteld6u/E8Ywu49IMTTjXO
         rGEHEgePcCy2UNfdJy1zy8/EHenRaV5CiV3ze9meyvlbxS9z9/O9hdt3tbpMkFZWhZGc
         hvo6a28mojyi0hVvI+RpHQR6MXoQ5QnSEfPXEbiaUBH7PkJjRax+WP1EoKQBG8A/qLWF
         RwtA==
X-Gm-Message-State: AJIora/kq/emMDa/vXl46Mi+P+gAFM/rrLE5cIyZiVz3CVjVGgAjz9qt
        oil5KKIZ46efIgf1tWPuLNQ=
X-Google-Smtp-Source: AGRyM1t5Ax5K3CFQ3IF1WTrSs4a59LOEuvGzfrnm9dnPEmKoOGt7ak6BqP/SE9amKPrt/ZHvrLpXew==
X-Received: by 2002:a17:90a:eb09:b0:1ef:7df7:cdf7 with SMTP id j9-20020a17090aeb0900b001ef7df7cdf7mr4640215pjz.185.1657729535064;
        Wed, 13 Jul 2022 09:25:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u5-20020a63d345000000b0041245ccb6b1sm8100098pgi.62.2022.07.13.09.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:25:34 -0700 (PDT)
Message-ID: <8dbb8841-6592-98c0-1da2-0673a28cb149@gmail.com>
Date:   Wed, 13 Jul 2022 09:25:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] clk: bcm: rpi: Prevent out-of-bounds access
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>
References: <20220713154953.3336-1-stefan.wahren@i2se.com>
 <20220713154953.3336-2-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220713154953.3336-2-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 08:49, Stefan Wahren wrote:
> The while loop in raspberrypi_discover_clocks() relies on the assumption
> that the id of the last clock element is zero. Because this data comes
> from the Videocore firmware and it doesn't guarantuee such a behavior
> this could lead to out-of-bounds access. So fix this by providing
> a sentinel element.
> 
> Fixes: 93d2725affd6 ("clk: bcm: rpi: Discover the firmware clocks")
> Link: https://github.com/raspberrypi/firmware/issues/1688
> Suggested-by: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
