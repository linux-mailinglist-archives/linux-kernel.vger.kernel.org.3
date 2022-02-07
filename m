Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164BB4ABBC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385750AbiBGLc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383090AbiBGLVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:21:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3811C03FEEB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:21:18 -0800 (PST)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7F2FD3F328
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644232877;
        bh=8Y9yNV8EX7NTdignHPRQY252HgYt0mlpY9TRr3lWof4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=F0F2Xr8uFPF/P72nYBy25C0XD37eYZqgWoyyoZWQ5cgL1bcVhDHIpPvv4z2STveJM
         kcJg1Beoneg+P6T57TKe6YL25Iz2j0OlYh73LCjEazpO+ovAu0f0NpELYneoXh9lQ1
         X/9QV4K0YYGjGJAk2qH6/22iZBDm92nQYWo4cZu2QBH5Tydrxbx36GqSgNdRrolAJc
         waFbeFyuLewMO8LOKr82hg6O4M/Xiab7JoKPpfOqx9uLeuP329eyI4UkwwT0diiyPW
         vNKjNSaUnnPKJKaM3aglBoNKH0dj/JauwVrZnhwWkn1YoScYcJaZk9oSI8FXvAcipa
         byV309cZO40SA==
Received: by mail-lf1-f69.google.com with SMTP id z24-20020a056512371800b0043ea4caa07cso4017729lfr.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 03:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Y9yNV8EX7NTdignHPRQY252HgYt0mlpY9TRr3lWof4=;
        b=FA8iEZeT/YYbIjXdDVcoKJkxFGI9XJZfn9F7QjZkRTjsoJiOGLZlVP8k71r+XF1q3X
         4Lfn9D5km7Q79UqjSa2HEKRzyuyr40wNkYTGfU9Cx6RiLGDbjUkryb99zFTPHKrlWSVP
         J8aO2zeFOhQBMKcpsTCyjouVQbtr/KzXnPifV8IgWUySKSKIlbkKxmeR30msQRHAL32b
         KUEkyX8JWLJhUt6tb359vWiLjVeHrOZY3kyF2Wbek8T+v+3RuDG1jc6qW055GXn7c+pl
         mZtRJGiOmii8dpvguLy1CRELv/5CsG68Q1xnGa7ywt4ssnc1jaeEdlZWCDEfZp475tEy
         vgfA==
X-Gm-Message-State: AOAM531slMMCzNRlSF3UfpkQaPF72j5x+HdzODl2D00k5BfquLH0QGQT
        X5Wp9OKZIz3e5bDpbGwCGDkLpYIzqXJE01ySLlAUNyejjCh6LcP0Zx+NNW8vRDQksZMjlkGHO2v
        1AO3poXEnSculHBqBdpvKbcxT9nnmyV0VsUjsAWtQYQ==
X-Received: by 2002:a5d:6603:: with SMTP id n3mr9256732wru.20.1644232866048;
        Mon, 07 Feb 2022 03:21:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz28bw0iWdum97UqccNObiTCl0E42zll9NAhEqs1JdVzu878pa6CnjxT2SeV0Ew8TU0VtcspA==
X-Received: by 2002:a5d:6603:: with SMTP id n3mr9256693wru.20.1644232865857;
        Mon, 07 Feb 2022 03:21:05 -0800 (PST)
Received: from [192.168.0.87] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b4sm2321525wrw.100.2022.02.07.03.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 03:21:05 -0800 (PST)
Message-ID: <776e1b61-678d-6686-06fe-a74b7ff68b85@canonical.com>
Date:   Mon, 7 Feb 2022 12:21:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 2/6] i2c: npcm: Fix timeout calculation
Content-Language: en-US
To:     Tyrone Ting <warp5tw@gmail.com>, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        semen.protsenko@linaro.org, yangyicong@hisilicon.com,
        wsa@kernel.org, jie.deng@intel.com, sven@svenpeter.dev,
        bence98@sch.bme.hu, lukas.bulwahn@gmail.com, arnd@arndb.de,
        olof@lixom.net, andriy.shevchenko@linux.intel.com,
        tali.perry@nuvoton.com, Avi.Fishman@nuvoton.com,
        tomer.maimon@nuvoton.com, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        kfting@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207063338.6570-1-warp5tw@gmail.com>
 <20220207063338.6570-3-warp5tw@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220207063338.6570-3-warp5tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 07:33, Tyrone Ting wrote:
> From: Tali Perry <tali.perry1@gmail.com>
> 
> Use adap.timeout for timeout calculation instead of hard-coded
> value of 35ms.
> Use syscon to access gcr, instead of "compatible".

One commit = one fix/feature/logical change, so requirement of syscon
should be a separate commit.


Best regards,
Krzysztof
