Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2AC50D7A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbiDYDmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiDYDmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:42:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04D2ED76;
        Sun, 24 Apr 2022 20:39:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bg9so12316793pgb.9;
        Sun, 24 Apr 2022 20:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vfSyP/DWZUBUQz8x7MGMvd9tqfyWW3U2ltzQHY64VAo=;
        b=PhEAS7QdJd8hmzgyi1QjL86rAvq8jAyiJ/1Rapt+CkGJCdz3DV6A0S5PSMnNyo/IlT
         VEFAng1vjIuM1BbQkg+/neEd8xVTRO3Dyt7PDf2gVXkBvRhKHMTtPO0FYbbgpembPmWp
         WffOO2KaSMYQYdf8B/Ybw92ngpzVu0cZrkowXC5ORcBv6DbQucm5udtHEMAwiMT5O/p4
         o9Ph9nBxBngyHRqt6coOWQNKqz7AfzJ1SUjLMQAQfo7kOSxuwwrU8Bpw627mH2xY0JLF
         CI+1vSdCxRC6fq0xlsA6/zeftC3zNHrzS/PZYzARJ8PZfkQiHNFA+NWX8psu2czzQDkD
         83yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vfSyP/DWZUBUQz8x7MGMvd9tqfyWW3U2ltzQHY64VAo=;
        b=2BgLAL8z9WXHRPCMRjD4/yUK5iS80kBe8HpN1Tz+XlEsq8oSSVvCEuhLU/ES3t/Ui4
         W1zl6B11JQf7CJaKnaJJ/8oQOfJa+xiPqZZ5k3KtDi+3CJPpM7PSGzmGf0SQsrQZQs5R
         iCXOzPkncsRstbIwrKv+cIwYwp8HF3CYrCyvjdzusEx7uWK1qmxCae7ESsmE7w9uqdRw
         pA+U72roYLDfddslmJVKhmXXVYeS2LYlZy+VH/3pwEluXh4SbAA5wKfAppIloHQUoIMg
         bvmE5ytBk+3lb++kLanl9FLFGLAd3+vFgv5SNxfqXkpDBIYKJQ+I0HVxg9lYAOPydl9t
         5d6A==
X-Gm-Message-State: AOAM532PptZQfWQ93bVOFE9yTtecEp4TS7KafKBASNRcuNIXBTeSkQxM
        7OP9nY74AgqgjvesTjC9rN3mmtCmFHU=
X-Google-Smtp-Source: ABdhPJzuqC7DYeTKdy1ppqG31rl4wgw95qlhLeIflCHPgBK/tqK2poFm+7gzSgShCx9E7+yorPtfNw==
X-Received: by 2002:aa7:9255:0:b0:505:a44b:275c with SMTP id 21-20020aa79255000000b00505a44b275cmr17046511pfp.40.1650857945202;
        Sun, 24 Apr 2022 20:39:05 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id d7-20020a62f807000000b0050d32c878f4sm3352589pfh.114.2022.04.24.20.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:39:04 -0700 (PDT)
Date:   Sun, 24 Apr 2022 20:39:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/3] dt-bindings: input: sun4i-lradc-keys: Add R329
 and D1 compatibles
Message-ID: <YmYX1c6iPNb8NtTe@google.com>
References: <20220414002349.24332-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414002349.24332-1-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 07:23:46PM -0500, Samuel Holland wrote:
> The R329 and D1 SoCs each contain an LRADC with a programming interface
> compatible to earlier LRADCs. However, the LRADC now has its own clock
> gate and reset line, instead of being always active.
> 
> To support this, add clock/reset properties to the binding, and require
> them for the variant in the new SoCs.
> 
> Acked-by: Maxime Ripard <maxime@cerno.tech>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thank you.

-- 
Dmitry
