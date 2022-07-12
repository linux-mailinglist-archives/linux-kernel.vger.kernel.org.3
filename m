Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52828572784
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiGLUkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiGLUkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:40:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5E8CD3CB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:39:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v7so6400212pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=OLmzDzmTPzMJ38g54k0QU/ejd1TogD/xDNa2/MNxm8Y=;
        b=4S57N1Dp6yzh3XLZSy5FPy2xCSspLu5nsV+/x1gMHo5unctBf5APbeNGoJ5CcQz5ce
         E4fgelVwI1LfT1apnNBWVrNjNMZXlrmcMvRyGey8lRtfHq1D5GYFNUsVSgIs3S9DY4Ry
         pjuZwC3sCNTwShONX2njsmi3sHcscnWgwtThDMIqhoUTaqwzOVuKTXD3lZTfC1jI1X+u
         rY+YAEiTfSgMsGBp86XkeAhww2EJpo++SXHolzsQ3a10q7B9+mU50SUKKeU5G3TZx/6X
         R81Brwd4eNlVhJnLsYuv2oO8T0NkyGHwPsup+TM5i/svdTGU8AcnxSbVTXHj1yaAbODG
         5OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OLmzDzmTPzMJ38g54k0QU/ejd1TogD/xDNa2/MNxm8Y=;
        b=sj4asZHw7mwI5Zu8Swc1lhkzDwu9v/1un+c47wrOyOZpUvAyLl30w34gi3yWABdn8p
         MDx37gVT3asYGQjbaUX4kOfgu7ol9X/3nMz9mPvzProKZupAyqSw/AAvVWJHtkkmEe9w
         hXx5yU3fM5OknKNGnJ2ccx/ILrRNlEoqFGDwgSyfZ2vdKvh/OMCXB9pz4UjdkKlXBb7U
         bPU3Qt7seD+ooiC59VNz8cNaMZ/Eh3jMj6UhDhuRh4LDNkU7OUeZAEKdmjbt+Mcawku4
         YI5qPD+2L++51rzO/ewFTorsOHKpxH6x5etiLLIg7YZIBA8ZEKFtBIuofWAAURepgzAm
         aNZA==
X-Gm-Message-State: AJIora+FdriEfP93I2jOjXPCuAArV/jZKDPY3CDz9ZTqFWAxGmGZZYwW
        J9WdiaTERgbeFft+BmYyMDObDw6YhUnH6A==
X-Google-Smtp-Source: AGRyM1tS4ymO9bj84U+iUu64WK1ti9Ajgly7NrpGjGA4RcoUW3UQW4BCmTK6GYR7i6vj6V5Dv2Vi8Q==
X-Received: by 2002:a63:540d:0:b0:412:9fb2:4d4 with SMTP id i13-20020a63540d000000b004129fb204d4mr41273pgb.475.1657658399182;
        Tue, 12 Jul 2022 13:39:59 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a930800b001e292e30129sm19266pjo.22.2022.07.12.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:39:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ubizjak@gmail.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20220712150547.5786-1-ubizjak@gmail.com>
References: <20220712150547.5786-1-ubizjak@gmail.com>
Subject: Re: [PATCH v2] block/rq_qos: Use atomic_try_cmpxchg in atomic_inc_below
Message-Id: <165765839842.44219.4233753152017615209.b4-ty@kernel.dk>
Date:   Tue, 12 Jul 2022 14:39:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 17:05:47 +0200, Uros Bizjak wrote:
> Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old in
> atomic_inc_below. x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg).
> 
> Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old" when
> cmpxchg fails, enabling further code simplifications.
> 
> [...]

Applied, thanks!

[1/1] block/rq_qos: Use atomic_try_cmpxchg in atomic_inc_below
      commit: f4b1e27db49c8b985b116aa99481b4c6a4342ed4

Best regards,
-- 
Jens Axboe


