Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53645190DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbiECWFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbiECWFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:05:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174D424B8;
        Tue,  3 May 2022 15:02:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a11so15829831pff.1;
        Tue, 03 May 2022 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BML3fCwKAkemWPuJ7hEIxFoVzk3CNeF2ywdelTSnmIQ=;
        b=owiQWKJ4ZQJAcwCHFiQaYjtX3YmVXpcq8zcYGfq/c9VRE6z6kbjmjaRH1GrbY3bjrq
         m/dKA+gBL/bv5dD9qStTUM1WA6v3jrmw9ghlDfVH7F0L9aZ05LSHkJkuBDxtL7nTITSE
         t1xYE14wP20tl3mvkN7YTu5TdPyyPYvgPWEg1icBb/BeYxWjdD4KzNcSCeC0YRAam2EM
         AZ1IQJoMrXOVmYDPutlC/o/3kQbYTEmpXY5lq1Cyt3X9b0OKlagbWAjVp0GO+vlqEnWF
         SnGjLXHe46VAqMbWCyDdHS082T8hCuIX1Oip0+RLYnJHxB4wUAajIR07X2DAgx+wB+6K
         /40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BML3fCwKAkemWPuJ7hEIxFoVzk3CNeF2ywdelTSnmIQ=;
        b=Vk8xLZW74JpiTYM8z3AU9aRU9dYc4em/t1t7ES6hxg30wBM6pfIlqdvpeB++nZc3+B
         2pGF0MAF5GvSStI90f+5Y3EkIKreNz+AeGSlckyokDLq2sBWbOZJ6c6X6U0xmzDfFpx+
         0stALtd3eDMT2/ZXWYUTMn8hX7gPXtWgM7DUTAx7OT/j/A+9C/h+bW9FRU1JMQVnG7PY
         5+BE4TzkAqNGEuZR40RTz0LNmdMEf9Y0oLXrZD9Oc16WIk+9I/7NstHPyrtg1iff0bAm
         yDvdJWOBybMKXkG4pNhlsIi16xmyNCXiQLIqZv9niXy74CpKitzgn9CRugC5M0Yrzpv5
         9FoA==
X-Gm-Message-State: AOAM5337/NocdfktCye+EcyV2yu7LJoAX/0/kGLWqnPSwDd42dMUCAxY
        hemq9TzAiqZoHB+70Qx4yNo=
X-Google-Smtp-Source: ABdhPJzP6mUzXABdoFH1ZVeSaq/TMAPgJIb1k9QSNLAFmv5nzlKhGgUDeL8CPA1fwrylMwXwwXOOJg==
X-Received: by 2002:a63:cc53:0:b0:372:7d69:49fb with SMTP id q19-20020a63cc53000000b003727d6949fbmr15398440pgi.21.1651615334498;
        Tue, 03 May 2022 15:02:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902b20500b0015e8d4eb29asm6794268plr.228.2022.05.03.15.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 15:02:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: BCM5301X: Add DT for WZR-1166DHP,DHP2
Date:   Tue,  3 May 2022 15:02:12 -0700
Message-Id: <20220503220212.1676263-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421151055.6851-1-takayoshi.shimamoto.360@gmail.com>
References: <20220421151055.6851-1-takayoshi.shimamoto.360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 00:10:54 +0900, SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com> wrote:
>   Buffalo WZR-1166DHP/WZR-1166DHP2  wireless router with
> 
>     - BCM4708A0
>     - 128MiB NAND flash
>     - 2T2R 11ac/a/b/g/n Wi-Fi
>     - 4x 10/100/1000M ethernet switch
>     - 1x USB 3.0 port
> 
>   WZR-1166DHP and WZR-1166DHP2 have different memory capacity.
> 
>   WZR-1166DHP
>     - 512 MiB DDR2 SDRAM
> 
>   WZR-1166DHP2
>     - 256 MiB DDR2 SDRAM
> 
>   These hardware components are very similar to the WZR-1750DHP
>    except for the number of antennas.
> 
> Signed-off-by: SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
