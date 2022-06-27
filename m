Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8255CB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbiF0UYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiF0UYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:24:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296451A80D;
        Mon, 27 Jun 2022 13:24:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id pk21so21549157ejb.2;
        Mon, 27 Jun 2022 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kOow9vitS6PwBDRVMXZUrJIKbzM8TurUiTbE4cjhJ4=;
        b=A0Enxr6I6cTRhN63dLpe6rDqZ3D79PzQxc9oz1zz2lIrHjLxPZCVurJiXm89ZWhHH/
         m4YNqRqNgvXWdIUg450/RJlldqXJ34xjWFVlbdJiVCj3oTmUeD2V77j9hmhXKnlo3zf5
         RiEZ2bw+Fd6FzWkC8jGWdNJ1gGsAJVAItAuMW/dvgWAzfhPNlmkvDK57sBJGPeXk2brY
         YYAqaDimsa9Te3WTRN82SuXqzEYfaByw/OSQBUgio4JrmGWkjVLf6J1k0Id2mR5NEHIy
         QMZORRdWigc4xtfmDZE0YDXwVHc+U6BRHGIj+Dp91NZhGRJiRZULn+CBoB83oZmjYk7x
         75FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kOow9vitS6PwBDRVMXZUrJIKbzM8TurUiTbE4cjhJ4=;
        b=hJtIEEkmh7grDXcUUaIz/IgSr6AdqBFiTYPESIJeav3uy/hjkEiILD+3ZCDS29fHG9
         SZ4ppwaHMzbKwraEHm6Wnxao0lqNxIGno1pIH7QUCJHwdshwfUM1WHOJSl09CkXjz8Jd
         BwL2AarKv/qRsMclzEqegWG5JhHDWxHS8m8/p1TxAgPkBgH+7vG4cBiITJLbTHNyEzsF
         ZHEPeajto4UIytFxH53bjy8qDAqE+8p6lmYTlZsXb7yrHICH5K772ivPT863E4IzAGO7
         L1DvsAn/D8vRMHKiOtXrGMK2Vp3raKjXvAFs2ODDqKObk2fW+K7qs8F7LAgrN+o5Lxij
         B8xg==
X-Gm-Message-State: AJIora+mHqzQ02gKrc6kY0+11poJNU61Am6xZeU8AgXK7aRQQeXw0ZV1
        ETVNcqn91O43QrXFL9zvcxk=
X-Google-Smtp-Source: AGRyM1ucO41refGoDSFrPDo7tl8WOhspo5azxD7hXvL5SqjtjYyW8BRdSebUwVQIweoQxmtDlm9+AA==
X-Received: by 2002:a17:906:7007:b0:6ff:8028:42e with SMTP id n7-20020a170906700700b006ff8028042emr14573895ejj.278.1656361490665;
        Mon, 27 Jun 2022 13:24:50 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id p22-20020a170906605600b00722c44f9301sm5311968ejj.224.2022.06.27.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:24:49 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [RESEND PATCH] rtc: sun6i: add support for R329 RTC
Date:   Mon, 27 Jun 2022 22:24:48 +0200
Message-ID: <12003397.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20220626042756.58961-1-samuel@sholland.org>
References: <20220626042756.58961-1-samuel@sholland.org>
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

Dne nedelja, 26. junij 2022 ob 06:27:56 CEST je Samuel Holland napisal(a):
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner R329 has a RTC with a similar time storage with H616 but a
> slightly different clock part.
> 
> As we have already handled the R329 RTC clocks in the CCU driver, add a
> compatible string to RTC driver to allow probing of the RTC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


