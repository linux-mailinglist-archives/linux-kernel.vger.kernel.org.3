Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636525782C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiGRMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiGRMwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:52:00 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E1222BA;
        Mon, 18 Jul 2022 05:51:59 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id r12so8642932qvm.3;
        Mon, 18 Jul 2022 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4uXCnri7wkZqApftIfl++Q32cRWGI8+outdITbrGHc=;
        b=mfwU1MrXxoUE9k8PRf1ghXzDyHkUuq7wH5bE/Iie7YAGNDnffmXTNlGee4El/zADOu
         HMaXGJvyJ4tN8bAs62/cQCCuQh+PS4OunuuB2EHqlPamTfb5UgqWOdd6xsR4pI0GM9sh
         L+AbQgyT7FLKBR91CL9Oirc5o/jsRWGmkFMbh1xZfekjrM1sVJUtoaxLLSaxs6UqxKVq
         F4jfK19USZ8Pwnu/ZtdI/2Snfw3HByfa8T4ncy7mM2pjSCIQYlVTAZsHWcdEbEYvmmUR
         MD5N/iatkvSBkw+x80i1wtg60ZEQmegYiLYMoT9ft7RE9dKKjc7kHjzN7Ci5IQ3YzeMI
         /vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=Q4uXCnri7wkZqApftIfl++Q32cRWGI8+outdITbrGHc=;
        b=lRQvaPbVchSzdJpZvtTheXhVe1I95ADhI2Yu+61gYTbR3zzhWCzWK0R8U4WSQnszDS
         6elDRBggluJzlQPrchXGk1rXaSal0/vTpYohCMY9PL8bnfUc0DQcTPdpGnZe6MxoPO+u
         elAiHib7LBgYZtojqIvLn2Q4C8ghamKURHTYybQcpTF/cKxB4XskCDQ1FimdB6fLQCp4
         OmRdHfOswSobC9z9j0URcUUPhVnhU1xYZAvuQOy+nXk1dw0FAuuzhENGaH3ttbA6piAF
         hPYCBRrS0ZfeUcEWh0qkYgNzHvwRA+JpMq62JwKzmjmSOThjz8osnf++0Iqak2OTjIPb
         /mJg==
X-Gm-Message-State: AJIora9nAwr5Haef7ML5g000YI5n+LqkERiYE6yRCkGxeOU+t5YFzWgK
        4mr0lSbDZDnT/QTyIw/Z7g==
X-Google-Smtp-Source: AGRyM1vse5BUOdsqfBrG9qrwaKVpJOQ5Sqbh1uVY6hhCSsFT/ffcNioVZq5UoaiRMiyDIrZlg2oWwA==
X-Received: by 2002:a05:6214:410a:b0:473:38b7:e09c with SMTP id kc10-20020a056214410a00b0047338b7e09cmr21024496qvb.26.1658148717955;
        Mon, 18 Jul 2022 05:51:57 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006b46a78bc0fsm10984027qko.118.2022.07.18.05.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 05:51:57 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5961:4f8c:df98:38fc])
        by serve.minyard.net (Postfix) with ESMTPSA id 2C0A61800BB;
        Mon, 18 Jul 2022 12:51:56 +0000 (UTC)
Date:   Mon, 18 Jul 2022 07:51:55 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/2] char: ipmi: kcs: add Arbel NPCM8XX support
Message-ID: <20220718125155.GA40038@minyard.net>
Reply-To: minyard@acm.org
References: <20220717121124.154734-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717121124.154734-1-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 03:11:22PM +0300, Tomer Maimon wrote:
> This patch set adds Arbel NPCM8XX Keyboard Controller Style (KCS) support to 
> KCS NPCM driver.
> 
> The NPCM KCS driver tested on NPCM845 evaluation board.

This seems reasonable, I've pulled it into my tree.  If anyone has any
issues with this, please respond.

-corey

> 
> Tomer Maimon (2):
>   dt-bindings: ipmi: Add npcm845 compatible
>   char: ipmi: modify NPCM KCS configuration
> 
>  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 5 +++--
>  drivers/char/ipmi/Kconfig                                  | 6 +++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> -- 
> 2.33.0
> 
