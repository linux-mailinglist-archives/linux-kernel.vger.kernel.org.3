Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34A4ACD03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345154AbiBHBEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbiBGXX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:23:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4E3C061355;
        Mon,  7 Feb 2022 15:23:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so806273pjh.3;
        Mon, 07 Feb 2022 15:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q4NGVfnZcTyTN7uyU45OoCJgZ8qSuaDFnbB0+R0yaoU=;
        b=J9okMS8ibcD1d6kJ2AV43EegsSK00dpFoJfenatFVPg3mCkxf6l0+R3KeKcPlGYez+
         vQgnpulyimR7MCNqt+YXLjIlKV4LHj03g6aGZoMAqs4bcns2qnl0gaUP59bcSVXBHzL/
         tkWNYc/PKe/hrSnSZRyBEYR6Wee615vJTjgOERc241bmGaQY/4EwN6uvacVIbTKN0klS
         5BhbvzJklY71KS1pj+/lXpLopOIyPTqGIH+/MK5NP9ySZANtgrTtCeOQa0+lcWicw2bl
         loIsuUo2QSUSZEaofaom3wAidnQ0/QA2nR+U50syrh/GwTkTFBTgyzcIFCHW/RGcL2PE
         asmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q4NGVfnZcTyTN7uyU45OoCJgZ8qSuaDFnbB0+R0yaoU=;
        b=qZ26S2aPK/BFav5nuPedhnca6DgASy6QdZEYR81n2BJcE1lyukuN6Bq6HqvBTUVdU+
         87nqHZsi0gPzq0G9QYFKwyIHw7RPS7HHBm/Cjx//etupKbahJn5CaeiKFzSod5Kjzh1b
         18RRHJqTD1GHF8Km8l66MB3iDyMDnmPKPbMadrrdCF2dX7+gH3bxn9d74aEkhCfWRYyy
         ySjcuywNt/RFnoU3ZK1HSrXogfeCSqYzJAVhl0JWYbdlIU7aQRGajrhPvUkLEMRoSXnX
         IvkrIdKuiNm6nyJQkKbnYmUq+drThEAuQhlCPN/dGf4LFaFiCjaespVO2DI25WlkTEAQ
         FvGQ==
X-Gm-Message-State: AOAM530nEOUT1JlKBTvmBSdLyS0LujuZqlXJKfPoFhrjvwsPbH5iEBaB
        /ZvuJ01AsubpkZ3CIkfuS4A=
X-Google-Smtp-Source: ABdhPJzPi+18QP61QkBD3QrQXZf2jGk9fBmgd2jZB23uHQUcVAWcdNe2AYk0ZeYIUsujebh3SGrVlQ==
X-Received: by 2002:a17:902:e545:: with SMTP id n5mr1855955plf.129.1644276236236;
        Mon, 07 Feb 2022 15:23:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id md9sm429343pjb.6.2022.02.07.15.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 15:23:55 -0800 (PST)
Subject: Re: [PATCH v3] serial: 8250_bcm2835aux: Add ACPI support
To:     Adrien Thierry <athierry@redhat.com>, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220207232129.402882-1-athierry@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8b19f824-cd4f-10fc-c13b-0b177324294c@gmail.com>
Date:   Mon, 7 Feb 2022 15:23:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220207232129.402882-1-athierry@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 2/7/22 3:21 PM, Adrien Thierry wrote:
> Add ACPI support to 8250_bcm2835aux driver. This makes it possible to
> use the miniuart on the Raspberry Pi with the tianocore/edk2 UEFI
> firmware.
> 
> Signed-off-by: Adrien Thierry <athierry@redhat.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Looks a lot better, thanks!
-- 
Florian
