Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3A465743
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353031AbhLAUpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352976AbhLAUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:42:59 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C725C061756;
        Wed,  1 Dec 2021 12:39:33 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z6so25749951pfe.7;
        Wed, 01 Dec 2021 12:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mCS7DhZJVCTwjtJYd4FYNKX3PCW+VVYxovDq0WixHo4=;
        b=cNF4mXIpVXWzwhC/EoG9eUp3RHxUuadKqD6/vD95CgIlrj3pqDrfoil4g0BnozBFH0
         ZvzH5RHhm0zVgzdxA6JYY531g8iMgd0z0ARv0ecAjMdllt/f1GBZlS79DOp11LtJJdMJ
         uwcLHN3uS8BLRBXPrBucuqFJCO25m1/vucJcqzWvifM375jRMncJoNJL4o4RfoIgZDxS
         Jc++SxPu0wgYp2sdIisowMBGqU7EaQsEERxAtfWuGJ42WFLJXSmf2NN8Hj7swKd53FeL
         5lIeNEMZ+0pqi7n2ZO5uWdyq6EOZ6BMPE6UzY/Glh8WBr2G58joMwDSPJA4cRSc+5wNx
         L3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mCS7DhZJVCTwjtJYd4FYNKX3PCW+VVYxovDq0WixHo4=;
        b=X3BoenHle/H7ww4Jb0I0tIbcnx+NCFK7RDNq8mrhuEe2iahLitbG3hTFQOkLGBBxWe
         jp7iG2cOwwZphgf/PrwxYhOTdEr2N0BNqrnmF9OiMalPAgy3x8yHTxhYlwaRIK1GKfGj
         In3KjvrmdXy5Uoea5tpESfcG0TtzKxmxBLx1i9T4clPz7lg/mJo6ytkfOnQC0yoG7v9H
         ka/72KAzqgcKd4cqprc2Iqg6M6rkfWOWqdXQr+P13PPnRvGHd99lVv3G03zw/Ozaq6+J
         kuR9vl24t7lTe6LSGDS2niTyqX3xDAYpQ2s8lNegwaOvNO+di7H4pNAo5T7T2g7NOC0k
         NBvg==
X-Gm-Message-State: AOAM532a9my/5hGUKrPbOiz3gXIM+eRC0kPyuIWXeDmGk79iavAZH7DN
        4HNfT6FdGvF9whtdtTFxSb69adl0W7M=
X-Google-Smtp-Source: ABdhPJxgP8XbXSYplVdFYpxH8S6f4JuuJ6c0U105XPRj4j86VvEmcg4CgXNt+blV3CEcQeT7Mg4ZlA==
X-Received: by 2002:a05:6a00:a23:b0:4a4:e9f5:d890 with SMTP id p35-20020a056a000a2300b004a4e9f5d890mr8725695pfh.82.1638391172653;
        Wed, 01 Dec 2021 12:39:32 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z4sm684027pfg.101.2021.12.01.12.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 12:39:32 -0800 (PST)
Subject: Re: [PATCH] serial: 8250_bcm7271: UART errors after resuming from S2
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
References: <20211201201402.47446-1-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <847997ca-1a24-485e-010b-9cba35ff2b0c@gmail.com>
Date:   Wed, 1 Dec 2021 12:39:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201201402.47446-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 12:14 PM, Al Cooper wrote:
> There is a small window in time during resume where the hardware
> flow control signal RTS can be asserted (which allows a sender to
> resume sending data to the UART) but the baud rate has not yet
> been restored. This will cause corrupted data and FRAMING, OVERRUN
> and BREAK errors. This is happening because the MCTRL register is
> shadowed in uart_port struct and is later used during resume to set
> the MCTRL register during both serial8250_do_startup() and
> uart_resume_port(). Unfortunately, serial8250_do_startup()
> happens before the UART baud rate is restored. The fix is to clear
> the shadowed mctrl value at the end of suspend and restore it at the
> end of resume.
> 
> Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
