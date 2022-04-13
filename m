Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239314FF767
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiDMNJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiDMNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:09:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680B5DA4E;
        Wed, 13 Apr 2022 06:07:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x3so1033913wmj.5;
        Wed, 13 Apr 2022 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kafA4Cp/nvsG1AFf16x4P3arNB/XPl6avUTek6th6LM=;
        b=JhqMhVM5H/AR7I/KTvaWwpyBIGvDRUUSTX73lauZ64L74/VO1bBrYLO4kOCXiDsp9b
         0eYtRMoZ7x+ck797cRJmAfBS061I5aDnEewWtvDE6jhHf8tUivNI/chCSIiU2fvRcrR/
         tRVSChnBJZ5SsIri4tfjbW9sM5U/BrgcSRF0tzmvBtL75oV4ALTkPWPmLfIHfc1bLnew
         /Ge8zb3nnBu8FVVJjy63m44WkE5gpeahe5Xy1imr0aH8pYOpFTrFXd7Mf9Tz+fXBqDnN
         1hjMXg6TlCD/sv/8Vsfi03n2aPOgXeeS0Beh55YH84A3mRAFlePkZiEjp95iKeWOgWSg
         Ah8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kafA4Cp/nvsG1AFf16x4P3arNB/XPl6avUTek6th6LM=;
        b=KFPJAyfw+6jxzI3PLt4g6JhWF6Khjyp0nIkR7jz+rAXrsv9jvNzR8ZuCmT8Ebs+2ZU
         PVfiyAXECjakHTKgEw7F6AHFyB9JHAOrY1Q4ys8n3XS5e673EB35kWCLToT0Xk+TwpsZ
         E17E1YsOQt395vT28QGpQLpAKwBxiNQxq53yKoe6jBsvgPQ1tmzt+Egp3x5Q248etYaa
         Lw5qZew12mnCofJFkJSavK/fQcCW2IJ3Be09jx8NErHkegADjOIXeZtzRgZqzW+6NV0y
         i5m102/eGfZmDmLyLcVAvcXOo1dfVOX/XFl1s8YOQJw2bK7oPxjBefHOuyHWJ5kbjX4I
         OY9w==
X-Gm-Message-State: AOAM533Bg8nMkFHJUZfvqt/pY1p9G1epQtNLdJZdn+9BHkf4np+piglR
        oQWiIEW1IEsE0aWtoTYOh3HMkJ3BKA7idA==
X-Google-Smtp-Source: ABdhPJz38kWLFzpnLGk8019rjJMv35e3WlH7WmyVRBX8+qR51s+Kqeuhii9sqjD11yXqjzhXO47SZg==
X-Received: by 2002:a1c:6a02:0:b0:38b:3661:47f1 with SMTP id f2-20020a1c6a02000000b0038b366147f1mr8455676wmc.5.1649855240054;
        Wed, 13 Apr 2022 06:07:20 -0700 (PDT)
Received: from nz.home (host81-147-8-147.range81-147.btcentralplus.com. [81.147.8.147])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b0038cd5074c83sm2749187wmq.34.2022.04.13.06.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:07:18 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
        id 8D7CC2CBD6EC9; Wed, 13 Apr 2022 14:07:17 +0100 (BST)
Date:   Wed, 13 Apr 2022 14:07:17 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     amd-gfx@lists.freedesktop.org, Joe Perches <joe@perches.com>,
        linux-kbuild@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: gcc inserts __builtin_popcount, causes 'modpost: "__popcountdi2"
 ... amdgpu.ko] undefined'
Message-ID: <YlbLBUJxMDUBFo+z@nz>
References: <YlSYv3d9a5cZR9KE@nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlSYv3d9a5cZR9KE@nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:08:15PM +0100, Sergei Trofimovich wrote:
> Current linux-5.17.1 on fresh gcc-12 fails to build with errors like:
> 
>     ERROR: modpost: "__popcountdi2" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] undefined!
>     ERROR: modpost: "__popcountdi2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> 
> It is occasionally seen by others on previous gcc versions as well:
> 
>     https://lkml.org/lkml/2021/7/11/261
>     https://lkml.org/lkml/2018/10/24/403
> 
> '__popcountdi2' are inserted by gcc for code like the following
> from 'drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c':
> 
>     static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
>     {
>         uint64_t n = 0;
>         uint8_t count = 0;
>         u8 bksv[sizeof(n)] = { };
> 
>         memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
>         n = *(uint64_t *)bksv;
> 
>         /* Here gcc inserts 'count = __builtin_popcount(n);' */
>         while (n) {
>                 count++;
>                 n &= (n - 1);
>         }
> 
>         return (count == 20) ? MOD_HDCP_STATUS_SUCCESS :
>                                MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
>     }
> 
> Note that gcc can insert it regardless of -mno-* options.
> 
> How should linux.git handle it? A few options come to mind:
> 
> - Perhaps use libgcc.a directly.
> - Just implement '__popcountdi2'. Example definition from libgcc:
>   https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=libgcc/libgcc2.c;hb=HEAD#l846
> - Or workaround it with -fno-builtin-popcount in Makefiles.
> 
> CCing people who can help routing it and/or deciding on the fix:
> amd-gfx@lists.freedesktop.org, Joe Perches, linux-kbuild@vger.kernel.org,
> Jakub Jelinek, Segher Boessenkool, Thomas Gleixner,Peter Zijlstra, Andy
> Lutomirski.

There is now a discussion in gcc bugzilla:

    https://gcc.gnu.org/PR105253

-- 

  Sergei
