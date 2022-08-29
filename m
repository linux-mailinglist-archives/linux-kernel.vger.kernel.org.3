Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F325A5740
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiH2WrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiH2WrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:47:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABD59DB63
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:47:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c59so5741600edf.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=V/M5FUjrEob5ej+OqEpDo02TSYHpwIt8jpmg0gkXTx4=;
        b=sOJVkokQcLOD4abmd4qLfRaR+Rw0pUE71XY+IGJrQ8RaLOwdY8uwPIn/rgoD1Si5Yk
         yTxOrRom1nx8nlddGSxcZwArVGMZFQg+o5CaQmOz9veDtIqh8gnhPM/1oSmvY9M3FB1k
         1OTlux+Wu5ShAeRhrcQSS4JefrRp973WuBJ2p5XGY7SuTHXpQt/aSYcJsyJZ5P13nJZw
         BLSiX9gjp4xxywAjFX3RUUtVZLhFTF7AYCGOWsP+hRum7mznn7QbPsbTIX3Q/KvwXpjJ
         UKCiOGFoS8QEdhi03AHtu95bHgOoU4wD1aZmJphVz3IiOY7Ouyvbc3aDuPwD/uPh8dgn
         /DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=V/M5FUjrEob5ej+OqEpDo02TSYHpwIt8jpmg0gkXTx4=;
        b=Cy5pzhQbnk6Vc0+BAuDivB7JXNdjnPBuvPX/cTbONWAmHqdBGLutwxzG2M3K3fwX2u
         BZBd8pzkwNgi3/VpnT7FUyDiWn5xWVFz+ERlJqpxpaTYLCFTnfM5CG/Of1NIfuiLjK4t
         xm3FiTnG9kdqzwRZlwtm6KRBfebC8XGbtTE8fhIUtfZK8U18pcPVCpBR5D55Pd2HG5Vv
         BeyIOTHs0O/ShRaPFUvHSyMA3biUwjkiEzrfUkQc/WA2ErYgN8qvF4Jj4T2gncGfWDK/
         D4YjtHqeGO0BjzaYvcVHf0NZJL2vCCPXr6sz1hCx+CcdZ/owPfUx7ix14wkqJWbTztZP
         KvWQ==
X-Gm-Message-State: ACgBeo09LbczcrYdLKvjjQdfpD2HdkOS8kcF5OCjYou7Idm/F0LH9pTZ
        kvdQWRM1xwkVMmJ0poeaXjtxkYQtQFRSsbfL2Lk+2w==
X-Google-Smtp-Source: AA6agR5zO3QJuGJn4NhtFW434xMjmiJtCirmEp6Sf+yaYoV7Pvgi/pDUKk/yFmud7OVmauvf6ncG+jbC3n/VIFfG/Ws=
X-Received: by 2002:a05:6402:3507:b0:448:b672:55ee with SMTP id
 b7-20020a056402350700b00448b67255eemr1148399edd.107.1661813229655; Mon, 29
 Aug 2022 15:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220824041933.822838-1-joefradley@google.com>
In-Reply-To: <20220824041933.822838-1-joefradley@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 29 Aug 2022 15:46:58 -0700
Message-ID: <CAFd5g46z9C3eq1L4etKvCaO3RK-hS4_N7enofNyW=jt8XHVBsQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools: Add new "test" taint to kernel-chktaint
To:     Joe Fradley <joefradley@google.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        corbet@lwn.net, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 9:19 PM Joe Fradley <joefradley@google.com> wrote:
>
> Commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
> added a new taint flag for when in-kernel tests run. This commit adds
> recognition of this new flag in kernel-chktaint.
>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Joe Fradley <joefradley@google.com>

Thanks!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
