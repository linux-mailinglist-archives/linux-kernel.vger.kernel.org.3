Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1105A6706
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiH3PNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiH3PND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:13:03 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2211286F2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:12:59 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id v15so3335604iln.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=jB+HPX2oArApFPJU2cCo5o8zJ4MyZs1p/xij1A0cJxU=;
        b=rWn/3C6DnRYx5a6tE9CRjUj0cU4gDoBTpMDPqJ+B8ACW/xPyDJLXQWtPZCw+gbp976
         e0Fg26HAZUwK+LXlVPhl/QDuTwDlhTMoJ5KXVTTmovkh1KZ0adwnG+U9ImYBeF31Z7dY
         UiNhUnu2L9Shg0ti7FZGWBnw8SNDDJDUmLmgUMdMqO3CflBJNpoKh2oIMpH5TNRCqkxA
         +3W5m0LpJ+HMu1casdu0o3pA25TixILkc8CKn3QgzCFCqt/THTpYFGA2PK2qtwfKfRRt
         fChYslS3pZBd6iy7VmOj2kObSJqHZpnrA/3MjKFXp0G3xwO657i9ht7L6JhcMugaJIj0
         irtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jB+HPX2oArApFPJU2cCo5o8zJ4MyZs1p/xij1A0cJxU=;
        b=Tn5+HUc7qBaeZ69+t2YskuBV0aqVZ4dDnzdQK/IiHfE69tYHHdLJ08QiF9wm5LmTly
         61F6P1ZsKIoF3sbASzGkKqx7m/rJu2QaklyAhdNo/UI8xyYZXYla+ZgGHxPHppkZvAmX
         wJhQcTk5sxZtIjtFdf4a5IUfEuUIAjgCLIpH20+z5Mv3ggpT1j0Ff+FzeJ4F1PyJzY5B
         qSqydazxAfpxB0WsRLpsXAAcsOkGY1tlR7JYYYSGwwLfRa1pfIJgw5YAJtz80UonLKp+
         WvgLDC4xlFjG8WEyIZj5RFP6cIqGgu4RnSBPItURml6bNKq9aAqpSP40hNeXhshmBvfM
         RgJQ==
X-Gm-Message-State: ACgBeo2M7oNW8mRw4CqQ7CWN7CA2UeE/JqwS19ExdwKmxWK1kbo3aQCK
        VYznCwXXAeuuX4qnK9K0VFYnKw==
X-Google-Smtp-Source: AA6agR5LNjG4uM5ZYU/ORSrfrN1ADrAYwEnovVHtxsd8HU8mSR07F4iTWrCeR8Z3EK3z7qdNuy6eYQ==
X-Received: by 2002:a92:130f:0:b0:2e4:22c9:7721 with SMTP id 15-20020a92130f000000b002e422c97721mr13053524ilt.34.1661872379302;
        Tue, 30 Aug 2022 08:12:59 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z2-20020a02cea2000000b003476640caf8sm5696012jaq.173.2022.08.30.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:12:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Dylan Yudaken <dylany@fb.com>, bcrl@kvack.org,
        viro@zeniv.linux.org.uk
Cc:     Kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220816135959.1490641-1-dylany@fb.com>
References: <20220816135959.1490641-1-dylany@fb.com>
Subject: Re: [PATCH] eventfd: guard wake_up in eventfd fs calls as well
Message-Id: <166187237835.55711.10817834766770223688.b4-ty@kernel.dk>
Date:   Tue, 30 Aug 2022 09:12:58 -0600
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

On Tue, 16 Aug 2022 06:59:59 -0700, Dylan Yudaken wrote:
> Guard wakeups that the user can trigger, and that may end up triggering a
> call back into eventfd_signal. This is in addition to the current approach
> that only guards in eventfd_signal.
> 
> Rename in_eventfd_signal -> in_eventfd at the same time to reflect this.
> 
> Without this there would be a deadlock in the following code using libaio:
> 
> [...]

Applied, thanks!

[1/1] eventfd: guard wake_up in eventfd fs calls as well
      commit: 07106d2635a6d1eb55bb13e6c89c92ae5483b050

Best regards,
-- 
Jens Axboe


