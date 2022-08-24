Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ACE59FD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiHXOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiHXOvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:51:10 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289CD77577
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:51:08 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id t6so5969059ilf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=0gxVg/KDyhxdV1eSbzdA4jZWqj89A0LA1523GlPTmsA=;
        b=eNVOzLm83UdttcrNkUm3kfGBC/NTg0duYBEf72QnV7erooW/V1B4FT05P/V6rkMlXV
         3qaW9jPf5fn/FGo7dWI+qFeaXO3tA1s4KNqQy+VXaIYenH8BXMS8cjj4BfjfhnuPN+Li
         kmqdHO+LCJ0nlCCrrXwdbRVjpQaMlhl8+4wMVTycAzVPjhkxMiJ4lcVxCQ5IPxSnu+wb
         aK4ZrqACD07PZo5Uux1vZK9cLZA+8Keua3GY6/GaR9l6B95rw+p614YdbAdQ+U4CopbN
         yn2aUzMJJjWUJ8gRENi2AT/B38ZVEiQSZ9xFNjd/1Hh9q6RAyA4xRbh2iyE18Dv0HUna
         N5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0gxVg/KDyhxdV1eSbzdA4jZWqj89A0LA1523GlPTmsA=;
        b=1xFNosoEIjKjJSSi4WB/42xLWGKmkCFDEj7ei/yPCng36z1DGBnseL5YAU8Z50Pgwz
         Q/CEFMmBG8zMiq7t2SI88/8JsdHBl9SIZMl9fDoJjKeW/SQtxZjWqtSsMN43UmPmoX38
         G4xPw0CMPLJu0Wwtq+L6f5m0SqNYNb4OB3KMczie/6YH6yPmr4Fi2RORDTGderefGYQd
         KX3tVzT/nfFI5F/NPjZWRJYiwpvM1SkEECTTXZ5bZ4SexzbYSa+3vqLtSONNFBbQBYE6
         QpJmzyBcdYyfmz69nZOehwTEbHhAg41C5qmHOUcyhP2r4CccsPwGgSDKCPvx42NB8dGN
         VD6Q==
X-Gm-Message-State: ACgBeo3+8b8gN+T6lJKrs29vSzKCDSdONe80A1mo0Mr9WzZXl+A0sfJR
        eg/cSNAN4Zn2oLqvCjvLZdnJXA==
X-Google-Smtp-Source: AA6agR6rBh2w/CHEuFg8gXuBvLsTxNWyRvIsj8VcNFi4+w7XWoPyDvk6rbMtFXdRwD/76DXx8XBikA==
X-Received: by 2002:a05:6e02:1e0a:b0:2e9:92eb:2f6e with SMTP id g10-20020a056e021e0a00b002e992eb2f6emr2360946ila.36.1661352667498;
        Wed, 24 Aug 2022 07:51:07 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c43-20020a02962e000000b00347c15bb6fasm6939145jai.59.2022.08.24.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:51:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     cgel.zte@gmail.com
Cc:     Zeal Robot <zealci@zte.com.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org, jinpu.wang@ionos.com,
        haris.iqbal@ionos.com, linux-block@vger.kernel.org
In-Reply-To: <20220824075213.221397-1-ye.xingchen@zte.com.cn>
References: <20220824075213.221397-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] block/rnbd-clt: Remove the unneeded result variable
Message-Id: <166135266642.7928.3451896126137693327.b4-ty@kernel.dk>
Date:   Wed, 24 Aug 2022 08:51:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 07:52:13 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value from rtrs_clt_rdma_cq_direct() directly instead of
> storing it in another redundant variable.
> 
> 

Applied, thanks!

[1/1] block/rnbd-clt: Remove the unneeded result variable
      commit: f2cc648e12285c53365c2bcacbcd919022f4d3a8

Best regards,
-- 
Jens Axboe


