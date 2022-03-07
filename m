Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4F4CF30C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiCGH6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiCGH6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:58:07 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D779160DA8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:57:13 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A65613F5FD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646639832;
        bh=AHjs0QVNDIis7IjbqKISlEAz1swFuZig4/uG4UShOyE=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=nEl8mjnZiB5/FVWjTbsg3JhHK7FC8C3VzYGfG0Mf6jidLCTgGxlI0RnJtb6wfZfDr
         XhQTHPJycROyzCG+Z2KMA7UBuN3rcMxhh9xhm/NqJz6aYyncDGLsSL8SRfh6HM2oQW
         oSKSfGBJDLyIwTRsaea+lGJKj+sarZeAdlJR4QpD/UExgDRumSXLZs3jRlYKtXB/1Q
         FMONPV5OgEmrHDkbFbpQYyde8I5JZqqANKww0aWpWcAZIpruPZNnJSmtjd3zRoIF1d
         9ABQVFCrf+uAB8WvGWD4JTDLTzHwxXUqT4fI8cNJ5kqtMfrKe7SOXpdoNs69FrO43K
         MhihBAjFhRvPQ==
Received: by mail-ed1-f71.google.com with SMTP id b24-20020a50e798000000b0041631767675so2238836edn.23
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 23:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AHjs0QVNDIis7IjbqKISlEAz1swFuZig4/uG4UShOyE=;
        b=qPu0vJ5sVWkTNPMepP/Pcc8PbzNCtU/KgFH4Lj21Q9l5J45h2nhOgY++2lV0ETu3JT
         ML+65WL57xxwEPv5HjziLUa3rVrjvd9wcSo89sYGpn9wNqlnN2GKZGoOcF3wqAMHHohI
         e/1U/mWP9e4vHZEZzdvcoQD6xO6EBE76ULC2YuCTCIO1UIRYbdkinOmh7Ai2maTd4S+3
         5uSYBwD20suT+5VdyCtCt15EFmAxjCsKZiQX28Yfp2EU2UoDeMJLM0Muwfjg5AdQCtQn
         UcHwNTcstFwvBYusG4GUXO2xRE0fnmRM8e5LlcnePrje8amKNffALi/qUXysGiwBtXtA
         vjzg==
X-Gm-Message-State: AOAM5326kKFyjQXsr4OjW8WajZm6Ls23vhjUo/dmJYuFbkKUXhT3LcjL
        gp60ELU79sC14tfReNsSATvDwrpDiVLxPSjooNM+v3MgR/hjj7gx4dQI4URNx3ObDe+2kDGLOOg
        4cffDIlpX0D7hpz4iDsaMk4nnVnwhZggGynj8aywvdQ==
X-Received: by 2002:a50:cc89:0:b0:400:8f82:99e8 with SMTP id q9-20020a50cc89000000b004008f8299e8mr9972844edi.7.1646639831759;
        Sun, 06 Mar 2022 23:57:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygdn8fB+C/23DihWZly2xL8YqfCrN9GvsUhuY2VVyKRBR/TZrb3zslpnePuPyHobQpUacerg==
X-Received: by 2002:a50:cc89:0:b0:400:8f82:99e8 with SMTP id q9-20020a50cc89000000b004008f8299e8mr9972836edi.7.1646639831624;
        Sun, 06 Mar 2022 23:57:11 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id u9-20020a170906124900b006ce88a505a1sm4573922eja.179.2022.03.06.23.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 23:57:10 -0800 (PST)
Message-ID: <a41fb0e8-ce9e-9bdf-c583-a0b6098d70d6@canonical.com>
Date:   Mon, 7 Mar 2022 08:57:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] media: exynos4-is: Fix PM disable depth imbalance in
 fimc_is_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Younghwan Joo <yhwan.joo@samsung.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220307075206.10737-1-linmq006@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307075206.10737-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 08:52, Miaoqian Lin wrote:
> If probe fails then we need to call pm_runtime_disable() to balance
> out the previous pm_runtime_enable() call.
> 
> Fixes: 9a761e436843 ("[media] exynos4-is: Add Exynos4x12 FIMC-IS driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/media/platform/exynos4-is/fimc-is.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
