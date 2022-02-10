Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5614B0392
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiBJCxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:53:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiBJCxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:53:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE092409C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:53:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id on2so3915775pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 18:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H8yuowP1mvnDP9KBlBJhs+EnqVN/L7/OeGc4T0MUUiI=;
        b=g3Y3erdYSib9j/KQ5dVDkf9MH5o6tk7fSy3xi0e7V484U3gvKLCnVzajg8vgMbwvX1
         Jjnrv+KBTSKJQDdGJbzVPu7uadccKPxqe4E2p99bdkQOVJTvNA5AhIBxn1wFhRuK/weP
         9IYh32uj8DKIO1dyV7kxJg9k3xnMFL3G7baZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H8yuowP1mvnDP9KBlBJhs+EnqVN/L7/OeGc4T0MUUiI=;
        b=VaGNI+Y1CJh4LcTzPCuKVz8w2e+bRqKVNkcz0au3o++9q/Ulv/P+ll7sFM+sNhK17i
         f1o3qoeCmgJAwNtYKoqOZdRp2mg7uMZv+yerF+L+h9m0WEZutHnNy9KOW0iNo4Z7XP40
         W4ylMTaPts96AtRjAF+VKF4S4+6HZkH5G6N9zY675VK3lQ7nEGJ455zeYQS29G0dBW9r
         SLgPO2ajdFRuSR9DJW4906bI+NyVmPjdJVQ1bRqRB57/CezoWCeDAEc8zlz41oRxAWo0
         9bBN/tD2RwOS18ItaiBfxn0LJTiGXAM3UlouvtN5XyFEpQMWFiohJX8OfJu4dxb3ReMY
         t5AQ==
X-Gm-Message-State: AOAM533W3U41l3cm6Z7yvYpUfAe8x+0ZepLg29XiZ4IuiGm/nnurqoOQ
        /AVUR+3SgQxbAP4HUZk+vHnrbg==
X-Google-Smtp-Source: ABdhPJyL8cIqzqClp86dbDBLCDXuzRTYQHVGbS1hWszwpQyFYwKZ3Z+2yLCflwC+36gHOAlNqTd1JQ==
X-Received: by 2002:a17:902:c24d:: with SMTP id 13mr5363988plg.22.1644461603571;
        Wed, 09 Feb 2022 18:53:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i10sm676425pjd.2.2022.02.09.18.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:53:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Date:   Wed,  9 Feb 2022 18:53:18 -0800
Message-Id: <20220210025321.787113-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; h=from:subject; bh=hTr0tOO4h3lt/wmDEd+6435u89taCT0sXulysY0LXCw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiBH4gQ43Wy8/NXcOkUg/7VSRgkMgvhZk6QoYYYdXd mO5Dn9eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgR+IAAKCRCJcvTf3G3AJtu6D/ 9Qs9NPuLfVzVfEw8ZNSLED2BCppQF666ohGTYmyF6E1tkcRI4mFt87GMbc7/B+wLkWc2UcnK+lhCcC XoYNMKZ0e4yh+6EcfHj3UPpOVsMJVImlbfnQe2lzlENx0eUD3Psh/i2MNykflD/nDXYGMeR3i0URVS QtvJz2vXvRFAZNf3PluThlzT1YU6gy+SXSf1UF9y3hFrmLDAVpdfM9mAVlS4Ur1zgIlYKZsUOAqNUg 3NUGZ6cMj1Zaap9Hd+PgMDZW/2b2jbAgwbIFvG1cjqrtH1K0wamutZVA9rHieLCId8m3A9+78e+K4I L7m5SuS48W1jq6TxHhb8YXgPaQDl9uN+67ff8F4hnWXz+zoa0LvkiLwWdxmGE5OG7WoZ0blf+DJx3T z04beNzndFVKYD+rI73h7xQ0UjzsXUeRiyNm73yeSxufBCGEeyHT+zQ3GffJD2IlqIL5oonq6pkP8c q4fW2+5DpUAfkHr7xrCeZKqn2sUJZ9MReYGyoeVHjiyTZx2IMBFER4FDA/tUU9jE6d6QvtbeWM6NzM eGMpWqlVnFnfVkTG27QUfboS+FmB7PYW/4M3Rs7gXL1iwn9xkqbz6F4eDrZI3fBFaQnkzW/MTwmBhk tIS4f3zFRoSi1f+lE7DjclN2KQB3mEOiDP09xXX2C0RJU/ggN8Dov4F7cOOQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes the signal refactoring to actually kill unkillable processes
when receiving a fatal SIGSYS from seccomp. Thanks to Robert for the
report and Eric for the fix! I've also tweaked seccomp internal a bit to
fail more safely. This was a partial seccomp bypass, in the sense that
SECCOMP_RET_KILL_* didn't kill the process, but it didn't bypass other
aspects of the filters. (i.e. the syscall was still blocked, etc.)

I'll be sending this to Linus after a bit more testing...

Thanks,

-Kees

Kees Cook (3):
  signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
  seccomp: Invalidate seccomp mode to catch death failures
  samples/seccomp: Adjust sample to also provide kill option

 kernel/seccomp.c          | 10 ++++++++++
 kernel/signal.c           |  5 +++--
 samples/seccomp/dropper.c |  9 +++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.30.2

