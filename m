Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F124497848
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbiAXE6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbiAXE6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:58:34 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39631C06173D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:58:34 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id t7so2887838ljc.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FXFmxDQy5UQl/OJS+xVXq8kS8ITCXJeU6yfRYQPHIR4=;
        b=IAAnzfbBZCvY6XrMxJf/FhkYFyrrQ6JcDQXvBwGTARxIhvIqMQIz+jx3CkiD3bAYZC
         tZSuk9frdxlLTmnD7yahnmXJVib6LlaRdAa9TBotdxZ82vMZtCBNHcehk2nHPQqlhSlC
         MQ4trjLAxNNjQjvwEjudMSZHC+iF+k/4U06BZXs4t+iKsBG+TMhMtQt1X+ie9XPEw8yC
         y0fsZ5Anfpe7CBfTE8C2pDERPM3lTZkTuWDI1n56EgFya4NHxFCfKGwR7gTswW1ti+nv
         WAXBChFefvkRifmQbK7p+3+J/6GHeVxGzhlryrtWEqX1Ille/IiN+GyhhwSAQvoi8WmX
         XDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FXFmxDQy5UQl/OJS+xVXq8kS8ITCXJeU6yfRYQPHIR4=;
        b=ngk33kjmijH671yE5ubC1NZ7H1m1gqWrGIq5iWvvBIcYm1Zx8Q82TgMJwWIFLzC3oE
         aY1gH2e52r6k+uIT7HMgMjhtRJgu6O0643DiwJ8hxlryydHelEKT8NHENOPpnBW8T1c2
         J3PpWvQ/qQRvM2BNb0OKM2nMk/scsSx7abR7RYy/8wSs19AkiBDCzMf00DTVI+8D2DsB
         /cnzVAF+Aji0x8HeFKdL8VtFLHWCHDvfTkHBitlJAzuHa+2kifU+3RYn9LFx4FbbFiVY
         4Fsg1kKtZv5mGaQ3uYGMZarrM1ncFnC1Yai8k1QGj9gUQzmFJUZD0YU/cMY/6zCEnXad
         Ea+Q==
X-Gm-Message-State: AOAM530pMtzukbr11h+s2sd5nua7CXcXSHo09bJsnfiGfVTFc5qFJcFe
        CLs/RCIi08XlRO5lAdf6t83jNA==
X-Google-Smtp-Source: ABdhPJzSmjj79qwcfBkc9iBrhtt2KBsfla9CnBnKbXJdkyL4UZY6dx7csn18EoOVBXcyDKHOgdGYKQ==
X-Received: by 2002:a2e:9001:: with SMTP id h1mr5355353ljg.273.1643000312478;
        Sun, 23 Jan 2022 20:58:32 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id r13sm1044312lfi.238.2022.01.23.20.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 20:58:31 -0800 (PST)
Message-ID: <7bfc1e3e-c4e4-cdde-6e2a-0f05369b6af5@cogentembedded.com>
Date:   Mon, 24 Jan 2022 07:58:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] media: vsp1: mask interrupts before enabling
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220120081530.799399-1-nikita.yoush@cogentembedded.com>
 <Ye3MfnICIv0PeqT9@pendragon.ideasonboard.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Ye3MfnICIv0PeqT9@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you're fine with those two changes, there's no need for a v3, I can
> handle this when applying the patch.

Ok, please do that.

Nikita
