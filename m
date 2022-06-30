Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A1561E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiF3O4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiF3O4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:56:43 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E5C1D303
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:56:42 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id u20so19370767iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=j8i0CmQFu4oh9izqSE0cuzTurgmheFgs9TAW3kZ1cds=;
        b=cJV2xRxJ5+NPFoK84lFxnTGQlBNuoTNHa39T+LFztHGGFUFWZPXK7yGpk88CksSghL
         e8EXK0xp74gfxl7nSTYDEiU9yOJ4751l1VH93WhL7Yx6LV23ZrNjC4QDAP7f0FNOLh1p
         cdcAn/VDWRdjaM1i/BXHxzeq0O6U2eRLR5fcbnkkE4jMdSJzNURcBxKLGkP/XLVmKDPa
         ZZsAozV0SMlMXVYAaW/aM0coHh7KUqLZvuf87yVsssTzf397Q7lUAIF0lqvgR6ojl/27
         WgRqaJ7CPZ8KRdqrICb13Ydwt3GJQy0ftu9n+6sEFD4q3lqX5/bk17ElFdqp3ifL5h6n
         2v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=j8i0CmQFu4oh9izqSE0cuzTurgmheFgs9TAW3kZ1cds=;
        b=2vdIfpsH+ps64T+zuSiKazkpGQVmGWVwz8lir4CVyjr3Vc9KePUPYZkZERDNFzqW1I
         58kA1uYzN81p06omTIZz0KjGTO01UMgMaZsfJ7G+MGfis1aScFMHpfXVcDJ1f5mym+CC
         vU9rvzi4SRXM8uzMON8KFdIf4GKQ6f3Dz/jGDaoCjqsP+QcjREq8KDoabbpC3I0fndcS
         ipjXm0SegxbliPohBJRQa0siWqNLZgNEcvgKMf4QZeKs3gy3YHp8fQMr1jZpOnHf4kWm
         mtEzvx6ytCoTFtGpNAxcUUM9Z8TFw86fWQQJCP8oX5pUfKoX9OaCAMhJJGdvoYbrh8Mb
         EGrQ==
X-Gm-Message-State: AJIora9NDFiQg8wYeTUlUtnvLTneSqXpqRIdf/pFOGXWLcMXgKPB/I7C
        7egkmsR4fOdhl6EcB8KZvD0EY2y2goqv/A==
X-Google-Smtp-Source: AGRyM1u+Zs15UVbpI+1bsaHbTe/K7iQVPpQZZpvYDP8DlD/XYlH2HvwvmAhk2fMreBtHJj426gbm7A==
X-Received: by 2002:a02:ccd3:0:b0:33c:8da4:b147 with SMTP id k19-20020a02ccd3000000b0033c8da4b147mr5578119jaq.21.1656601001756;
        Thu, 30 Jun 2022 07:56:41 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a11-20020a92d58b000000b002d8f2385d56sm8114297iln.63.2022.06.30.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:56:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     dylany@fb.com, asml.silence@gmail.com, io-uring@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kernel-team@fb.com
In-Reply-To: <20220630132006.2825668-1-dylany@fb.com>
References: <20220630132006.2825668-1-dylany@fb.com>
Subject: Re: [PATCH 5.19] io_uring: fix provided buffer import
Message-Id: <165660100106.535585.6996984430706147142.b4-ty@kernel.dk>
Date:   Thu, 30 Jun 2022 08:56:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 06:20:06 -0700, Dylan Yudaken wrote:
> io_import_iovec uses the s pointer, but this was changed immediately
> after the iovec was re-imported and so it was imported into the wrong
> place.
> 
> Change the ordering.
> 
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix provided buffer import
      commit: ee10e6851a687c58f516dc924034cb62c7a01e14

Best regards,
-- 
Jens Axboe


