Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCEF5B2200
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiIHPXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiIHPXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:23:18 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF8EB2E1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:23:05 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z191so239021iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date;
        bh=stK1ht9fWSnkQnXFo8JZT/Y7GNru1MpSHx0zpqkAgbY=;
        b=3GtqgllRYHFE1EKMM4aLp2V3LO6mztidY6CaAc0cBNDFL6E0tOtaB32CesPnQ4fDUT
         IGSuxb3ohIQbDS286JrW4OjbvTG7MEysVGk28xp/9P4fw9MoahHDZXYIGUv57YJhrV7i
         b4+IevOoO6xjyjkKUl5USvCsaf4rbm22ej5LjDy00KS5zUZu2OHksAnyeH+XoByxPfVE
         r2BN15nFslkG3EQpx47cIzKv+PH4fuVLa6yXBLEwSoSd3bDMfwpfNb5eck5VEfxWtm+z
         Ux7GOF5+rSABkqmy+TMGP2wFj9z5To5HtHZNzTA1WK910cM/Wcr3l5xVKbXQrVGEFt/h
         D27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=stK1ht9fWSnkQnXFo8JZT/Y7GNru1MpSHx0zpqkAgbY=;
        b=K8KkxewJ/q8HiN46WPpSGuVA/egrCQS0RT1Mp8bwv+N0Lz3DFXia3EXlvCBZM46Qyn
         b6MPily77d6si5pj9zxWlRAwPacpZwMsAV1hDDe9ksh4xV4tbdeoj8a/X6X0BlOqgR5L
         vqY0KhBmT1C4IQpe5yDl6kS8ytRNnT1NWPa+CJ7r8FjfDraEZByeJsUX25+YeFzRSjpk
         lNOTkupq+t1MTrOaCQqXdZjbKMTTLTSELvH+xP8YPyo20R6FbbVy97RCY3LZC2x/KWD7
         DIs5tLcNj/Pr6dhVp8Ic4J52oPcwSYJ73/4nrYlz1rJVWfdRrsMNUYcpWsSxUQpftn6q
         ZedA==
X-Gm-Message-State: ACgBeo0BABeUEOCrKhzM7rjzWN4xR5dGhKkQ9NJzhpEaII2A3XHYdqqd
        iEe3UCRwbyeeiMSCe0EO4rkePA==
X-Google-Smtp-Source: AA6agR72hquCJ6QUfzARtnsu8muIHNWRd2t/J5teQumDMXgyYRFYtmyjgoV0fM5KZnJzhxupuBkrEw==
X-Received: by 2002:a05:6602:3407:b0:688:e4bd:afc with SMTP id n7-20020a056602340700b00688e4bd0afcmr4352189ioz.24.1662650584167;
        Thu, 08 Sep 2022 08:23:04 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j17-20020a056e02125100b002f1e45896c4sm979749ilq.35.2022.09.08.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:23:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20220908151200.9993-1-ubizjak@gmail.com>
References: <20220908151200.9993-1-ubizjak@gmail.com>
Subject: Re: [PATCH RESEND v2] sbitmap: Use atomic_long_try_cmpxchg in __sbitmap_queue_get_batch
Message-Id: <166265058355.492758.3474516202964637778.b4-ty@kernel.dk>
Date:   Thu, 08 Sep 2022 09:23:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 17:12:00 +0200, Uros Bizjak wrote:
> Use atomic_long_try_cmpxchg instead of
> atomic_long_cmpxchg (*ptr, old, new) == old in __sbitmap_queue_get_batch.
> x86 CMPXCHG instruction returns success in ZF flag, so this change
> saves a compare after cmpxchg (and related move instruction in front
> of cmpxchg).
> 
> Also, atomic_long_cmpxchg implicitly assigns old *ptr value to "old"
> when cmpxchg fails, enabling further code simplifications, e.g.
> an extra memory read can be avoided in the loop.
> 
> [...]

Applied, thanks!

[1/1] sbitmap: Use atomic_long_try_cmpxchg in __sbitmap_queue_get_batch
      commit: c35227d4e8cbc70a6622cc7cc5f8c3bff513f1fa

Best regards,
-- 
Jens Axboe


