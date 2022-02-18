Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2144BB5D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiBRJno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:43:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiBRJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:43:43 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006E23BCF;
        Fri, 18 Feb 2022 01:43:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k1so13526659wrd.8;
        Fri, 18 Feb 2022 01:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mS4LgDgn7RWAOaBoEfxml6SAyAPFqdzmOTJ3SaSVOeg=;
        b=PhqWKMWWgeeQJMoOwP2sGYFnaiME8Py4XuKv/FNLg+oxrBvgIDzFl40h94ciw66Zaz
         pf285sm3W9ykpH0bXPqgasO0fz01ELbf9U3MObUpmvhS8H1Sp8JNVrIGkJwfFrVCJb17
         lysDexqtrpQuwQop8Irtmxa+frUY3lWXvzdZAuqUEnQRL3hMfYWRFg/zWE05Gjs3x81C
         so+6NCG9GFbQuNclXgd5MO0n/mWkyusTQ0vwKm+N7i4iUM8UU+ao4zwbxBDm7xSHP0zX
         1pX1gs8WXB9y0DZTIbhfmMxJ7eLx7h71Df/uTvwos3woFRVaYzbjvSd9Trin+Hm4gzl4
         uKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mS4LgDgn7RWAOaBoEfxml6SAyAPFqdzmOTJ3SaSVOeg=;
        b=DBQ/L6EDz73Vck1VSJ3+JuFZFSgFi+q8RSV7gq9VwrnfNkw8hnDBLYVf+bK/Fyw0G0
         SAnKaZ+q5N2KjJw9+txrlehz/vwhvccZjkK0ajKEa3/N0ch/c+B+xMMxoDptfHKBNko5
         B0h6spB/q7TnkFNHJ+IMEcBvJgBFEf92lZ9/XA9zVTuNnxPsFgXeOdTZYH3TYvQ9Z+5p
         m9l3UupcMfYJdPce+k39FQZ2pg/siNj5ZFLmHzhaP1z0RotiFUlYsFHclij32rUWKonk
         tynB+9UEZF8j9+nBV44YNidiScluaDTSPUfxayBwZtsSSqhzh2WgV0FPrXE+wjNu676o
         pQjA==
X-Gm-Message-State: AOAM5304JCca+ByB+0tZxzqVuBn5u4+FPwOZ+PwEbM/DVPpIeTjSU9L0
        5iVf3HTAAKJfT+QHGMFEnjcV36G8jLs=
X-Google-Smtp-Source: ABdhPJw0vAAQkT0x994IAxnaYkD6Qnca5fJ5t1ZmQuM0sNSlBj6amqw5jRZoC1o5/oKHQSt0hgqjwQ==
X-Received: by 2002:a5d:59a6:0:b0:1e8:580f:9f5b with SMTP id p6-20020a5d59a6000000b001e8580f9f5bmr5345961wrr.64.1645177405752;
        Fri, 18 Feb 2022 01:43:25 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id c9sm20846026wrn.51.2022.02.18.01.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 01:43:25 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:43:22 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Harsha <harsha.harsha@xilinx.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, michals@xilinx.com,
        saratcha@xilinx.com, harshj@xilinx.com, git@xilinx.com
Subject: Re: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3
 functionality
Message-ID: <Yg9qOrjJuttVSetN@Red>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
 <1645125264-11033-3-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1645125264-11033-3-git-send-email-harsha.harsha@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Feb 18, 2022 at 12:44:22AM +0530, Harsha a écrit :
> This patch adds zynqmp_pm_sha_hash API in the ZynqMP firmware to compute
> SHA3 hash of given data.
> 
> Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---

Hello

Your signed-off should contain your real name.
Furthermore why did you drop copyright from previous poster ?
See https://patchwork.kernel.org/project/linux-crypto/cover/1556793282-17346-1-git-send-email-kalyani.akula@xilinx.com/ for reference.

Furthermore, the previous poster didnt answered my questions about parallel processing and tests.

Regards
