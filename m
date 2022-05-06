Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3DD51CF68
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388528AbiEFD1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352476AbiEFD1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:27:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE75EDF3
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:23:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fv2so5901908pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RXZWdwx6fV83qlkDGVYAGi/h0fzn5mo6WSbGj2n//Z4=;
        b=Ig1AeI6oboKQdDcqCbOIcQdz7jyUFdOn/aI+iG6SaixNaffYk8MS18fL/7jBEqL0hy
         AffnA79ugiw28R6w//oMuYp4usDbRPQTTD/FR/VFOLkovP6ksGNdrkoTNYjsF6f5sHWI
         m2bg2JYCw8MHdwx2dL0M2sgjsoAm5l7fWqi/PhJQQwN7pW4XtM4Zubs6tKZhwIEJPem9
         IFGOMHbbnWcxpeY1ft4m6DixCZtFJRu18vwJyNkfsKvaqMnOPzXRns6cNLgc85hhXmb2
         i6m4tKMaL057XnaBkUaaa5gMTiWttlDZP/h5FwWdsjpaMOIyvPlrw2UAWm/K/sD8T4op
         PrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RXZWdwx6fV83qlkDGVYAGi/h0fzn5mo6WSbGj2n//Z4=;
        b=AeJvuTNL1GddTU+ccobbCkbwQNNQublosHdlg9u0sbb3dec+LqynJgrVgbEY8B6Qwu
         v1SD+SWxCRGX+P6nc/HKZbT/1JJdJdIh0oVULaL2NWct0cP/TWC744Y7+75nOxt8cm2G
         aNzGl1EgynJ6H+OeE4VTO91uPZGX5cwFymuISSfKtxVdjS8rJjdttgZvuBpDH3U7JaVr
         e6g7xAlbgEdxyVrS+NgcT4/MXpgS+r87miVkVB40v2/gHPDZJ2RpkInnAJvtCgBm6MBo
         j0LzJBPXarozxrOtLU6q/2RtvNVxoNEshzLTQGs0gfAp5hxpa79xvVDLIaxVAi+N4lxj
         u/FQ==
X-Gm-Message-State: AOAM5309XnAtAu29Yu1PQ/t76TUj5TeqW0z4xagufw6n9VcWjsa0YJGc
        YqbxodRwwuaTfSzh1pANnWU=
X-Google-Smtp-Source: ABdhPJyFuwJCywqrwmSYEelXIxZw9ZCojTKyGzzu4KWY0Z6b+HSp3o0jU3SYSutHzFQwmW3WWItXng==
X-Received: by 2002:a17:902:ce8b:b0:15e:c249:1bf0 with SMTP id f11-20020a170902ce8b00b0015ec2491bf0mr1440712plg.125.1651807438229;
        Thu, 05 May 2022 20:23:58 -0700 (PDT)
Received: from localhost.localdomain ([183.14.31.73])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a194a00b001d7dd00c231sm2304598pjh.22.2022.05.05.20.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:23:57 -0700 (PDT)
From:   Puyou Lu <puyou.lu@gmail.com>
To:     puyou.lu@gmail.com
Cc:     akpm@linux-foundation.org, andy@kernel.org, chris@chrisdown.name,
        keescook@chromium.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, pmladek@suse.com
Subject: Re: [PATCH] lib/string_helpers: add allocated strarray to device
Date:   Fri,  6 May 2022 11:23:33 +0800
Message-Id: <20220506032333.28249-1-puyou.lu@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506022845.26750-1-puyou.lu@gmail.com>
References: <20220506022845.26750-1-puyou.lu@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:
I think this should be added, am I got wrong?
