Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2421A5A7317
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiHaBAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaBAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:00:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37724BD1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:00:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so6498268pja.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=EKaCusKrUMmUdYgV+RE5dMEIlByAJkWkmFwdae5DlEQ=;
        b=btq7EqQ+NExHYyt/XH6T/v6YaECa+tUGhHQt8hPCSqQ7BG4i4vpRO6ErZtk4reJa6i
         hnFUfUFRx8Ir3lwkUTUJLV07ahigG9UOjmsYXDWx2nWX+NqrbtglP9jjGThPPMbkrT95
         irNXYudVLUbXSjG9xjYQf/QgS8S/DysHX2yAeAPAVlqxOEo5nwkmUibuXIcxlNVY9+8s
         avrAcy9PZngFFQWhBx1YTGuHtxnDQb3ShZ5D5tzFwB1jod8Ulalr97r80JNmwK3jczS7
         BCQhdViXgzMo5Bo7+YSFqieKGNlNEv/RNBK0o451hZm8ZhUB2uAvgvMK7WsPv37FZXcQ
         MV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EKaCusKrUMmUdYgV+RE5dMEIlByAJkWkmFwdae5DlEQ=;
        b=7Dt9LhFEMURdwExQF8IqQhtQ5zwKnFU1GakFKGgYaJo0NJXRTODHfHefr/UfSEgAJh
         RhSY+1npCM5a3UwRjFPryadgF2PgSRy4OmQl9QvrsXJsOfqYkjXkCdywtrCeMlYwNNBL
         fa/l0GoNj9J3g92aZoJzJe7qKsY46Z8YS5wW7IzMA2uHEP3hEtHzdaBPcBgbp6PlUlpb
         oMkpUkuE+lRvddwNwZxzSmVrv2m4F0BkJ7eeIJEE6eBrTsuXZqm6iI4KSvdAtyXGpKAG
         JFZLE/d+vHkmQLHC8Fewikc0rItNf8sIZAZ98bOt8y4jgQoHojzg1HKESNxXJK1Hzfcn
         j4qw==
X-Gm-Message-State: ACgBeo0kCFvJYDzNZOkU80J2GdR1fmIVMjL8loVU+i73ixRmkpvZsGl9
        0ZKvazB1YKMkdVbKEZvTR2eDlCCY1hdxww==
X-Google-Smtp-Source: AA6agR7a5zAVNO6sD+JcahD7MGt/j0QWodScLzTDCmAfYtFUUbO117ixXjjNKe0mu1HfnwcDFslD1A==
X-Received: by 2002:a17:903:18a:b0:16f:8a63:18fe with SMTP id z10-20020a170903018a00b0016f8a6318femr23973511plg.174.1661907630816;
        Tue, 30 Aug 2022 18:00:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y30-20020aa793de000000b00536fc93b569sm5366077pff.200.2022.08.30.18.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:00:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>
In-Reply-To: <20220831004449.2619220-1-ammar.faizi@intel.com>
References: <20220831004449.2619220-1-ammar.faizi@intel.com>
Subject: Re: [PATCH liburing v1 0/3] liburing updates
Message-Id: <166190762985.21736.2188244397193332170.b4-ty@kernel.dk>
Date:   Tue, 30 Aug 2022 19:00:29 -0600
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

On Wed, 31 Aug 2022 07:48:14 +0700, Ammar Faizi wrote:
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Hi Jens,
> 
> Just small liburing updates this time.
> 
> 1) github bot: Upgrade clang version to 16.
> 
> [...]

Applied, thanks!

[1/3] github bot: Upgrade clang version to 16
      commit: 43cc51831a602cae3b9424dc762e3bff9f87a291
[2/3] CHANGELOG: Note about `io_uring_{enter,enter2,register,setup}`
      commit: 56d72cb2ce23ec06b8c96ec94a1be92339859dea
[3/3] queue: Remove unnecessary goto and label
      commit: a71d56ef3259216739677473ddb17ad861c3a964

Best regards,
-- 
Jens Axboe


