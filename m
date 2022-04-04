Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19DB4F1092
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbiDDIOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377923AbiDDIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:14:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F6031DF6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:12:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso5080040wmz.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlztPl2Mn5Z9b75a8aDKzDu8XcFOxiCHfCOqKuF/Txc=;
        b=WaqThE047oI6XlBTwAMpdom+WsP5k066IK7/CLPkUOSQ9DSj54oUqeP4dEyciYqu6A
         Ld71Kl93t4tS2ymQPTBpFA68E8RqJaIbscIAFuNTbhoHcA3f6RdHc4loEj5QHaAGzYfM
         YM7FtjhHoJUpn3ZCSpaJI422roKG8l7M221GcOckTYNlmTFkqqDHOqBZDBtBCIo7giOZ
         5Jur2Udwfel1nM1Xhm5isqjPCaXueaFSZkFaeqqtP5YBejcTYWh/fV8hQVZ2DQ+cCiol
         E/pHDax6+q7DAzl0k9GumrYme4gC5ImRZU0peR0QtEBDX78zIJD1ka23XW5HiUCQnSra
         wwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlztPl2Mn5Z9b75a8aDKzDu8XcFOxiCHfCOqKuF/Txc=;
        b=lPZ6c48UbMg2bCcFbDIJT+j4dacWavC6p4ouWLGWL6fT8r2jzr97tJ8hxeqAvWm8eM
         OzRXi0O9qR/xooU4ZwHlP9sdDRqr4OVxvECw8U6H50WUxfq5umIrJvyTJE21/l/vBVPb
         M3vCLQ//fpbPMVMhJ2Prst+vy0NKGL/6KNCpJM9UTEhm7lyYjAV0OQYuoB7HekagKWPF
         b9Ebslrj9BPH/kfeHPw48akgHy/PIV3bTaXBClq4x7GLdIjM1ie4J3EkvUr0itE8/FXo
         zS77zxkbV9A5sJPmkxWTKd9DNDCNfBvQYj0LKFocuS4t4M5Ec+k+7GgK3A9eXRLm24mg
         iIyg==
X-Gm-Message-State: AOAM533tcmZdt2g5WdXT3dc0dBFTw12rn2v9apA9psJC2sF+DrhJNYE2
        7lFAWRJgXBLgdcd66YcwT8cc3A==
X-Google-Smtp-Source: ABdhPJyl7Y99PyLWCJ09Fd3yDwSg/hDgVeGVWjBXSX9o5YLMjDvlRHKIofbJGxYdJQ6gzvUMTNIn7A==
X-Received: by 2002:a05:600c:2213:b0:38e:7138:de13 with SMTP id z19-20020a05600c221300b0038e7138de13mr2975996wml.26.1649059958397;
        Mon, 04 Apr 2022 01:12:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b0038e708d163dsm3297510wmj.0.2022.04.04.01.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:12:37 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Qianggui Song <qianggui.song@amlogic.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-s4: add pinctrl node
Date:   Mon,  4 Apr 2022 10:12:33 +0200
Message-Id: <164905994876.1805420.17725203100639956158.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310030410.718-1-qianggui.song@amlogic.com>
References: <20220310030410.718-1-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Mar 2022 11:04:10 +0800, Qianggui Song wrote:
> Add pinctrl node for mesonn-s4
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.19/dt64)

[1/1] arm64: dts: meson-s4: add pinctrl node
      https://git.kernel.org/amlogic/c/6383f5a212a6b569ff15bc98ba8b3041a35db6ee

-- 
Neil
