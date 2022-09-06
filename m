Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4C85AF060
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiIFQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiIFQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:29:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D474E08;
        Tue,  6 Sep 2022 08:59:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso7747830wmb.0;
        Tue, 06 Sep 2022 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=jA2IQHHMaFldBSM4/bundv/Eq7jbKvYhPDu/CYs+BIA=;
        b=bRqQ8iZ22SMbm8bwPTWjuMyrSo81qe7+2UUim0fjAn1T1llE12n1XoxMVqjG74J5gk
         zGweAhIbQ+qd3iv1jKO9gHsgjnJtD+Qgbj5gUQ4F34yUQFrD5pbQrjqABUpDz7D1obwj
         uNKXZezHnp7Hm9iQDtLrFzOyFY9zIFPjo/Ouo2xw4qPSvoFdi3P+FNZldCvanMNUNUfK
         HJ4f3bFOhcg0RYujYgsAtUcp1QBK64mOlePQGmf+E3Xk2OcvEBPSQYpi9NhTmVyOYK9w
         S0S0RHv05StXiq8A1FHA7mHskdYw2ucgKLzLmmmSQK+yN/4D2Gbo4tDnKdrrts1t6rCS
         34Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jA2IQHHMaFldBSM4/bundv/Eq7jbKvYhPDu/CYs+BIA=;
        b=2RMb5OTenENPwsyOhE0yCQgZ7zIecKwIebOFUH6mOdYKygbr2/SDo1GUMAiyTXx8O4
         qFrL8xKs81YZUWUCw1qzteEs79GXx3T5YjL+hvxbES4nFTyXuWnygtYz5b2DSwbqFaMJ
         p9HjumQ0foi//z3t9l5gkjBY5c3BHWU4K+kutgZB3JP0ZelRLYFF/3wxtaoVz0+VH04e
         zaEt2nKw2CqERMfk4q+ES5TIDnbwX8SMzcfv3qy5excabbFRvkP4OJxcuIkbELHUw4eY
         VLLjeIMWvDecPkRfjOZ8OORD7gnfsLr4VOMEakmnKHChTJn0EwXmr68VeUvFrgbs9WJn
         ve8Q==
X-Gm-Message-State: ACgBeo0tQKuHJ1eFz8w3aqTepDqoax2mqu3wCCezYEirvnexhdb8S1rs
        v437SjBtQoWmcQhkAqkl23zK0dHp+yY=
X-Google-Smtp-Source: AA6agR6jH4Rk+Gk+VBXvjus6DqzaBo8vlayw4Wv8+MoRZTHigH745wno+BTD4FW4NE09uKuQcZ/g2Q==
X-Received: by 2002:a05:600c:34c5:b0:3a5:fd9d:7b2b with SMTP id d5-20020a05600c34c500b003a5fd9d7b2bmr14256505wmq.1.1662479988571;
        Tue, 06 Sep 2022 08:59:48 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003adf0ae0048sm12150346wmq.45.2022.09.06.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:59:48 -0700 (PDT)
Date:   Tue, 6 Sep 2022 16:59:46 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220906 for vkms
Message-ID: <YxducgSzR6/zyHD7@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of next-20220906 fails for mips, xtensa and arm allmodconfig.

The errors in mips and xtensa are:

ERROR: modpost: "__divdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
ERROR: modpost: "__udivdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!

The error in arm is:

ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!


Trying to do a git bisect to find out the offending commit.

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip

