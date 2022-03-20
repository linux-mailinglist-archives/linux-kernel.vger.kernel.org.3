Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24484E1C5A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbiCTPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiCTPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:52:07 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3703A4B428
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:50:43 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by gnuweeb.org (Postfix) with ESMTPSA id 960437E324
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647791443;
        bh=DrWgZ38PquuHSGxjZUS3cpQF4U4/ehYfTH8o3ux34qI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BS61PPnLUTTd6D5sqKoO0MxLinu4DP6IXwzoox1fSTuSaZgCp9r4HCJoxAZ71prDz
         sLojXHFpE3xWba+b4ELIC1v3KDeflTumEEgoitQ8mHV13Z16oXLD4UfDvYPl3gDFwk
         VSXP/PoctDiVsV1j6nBCq7a05+vFFIGUzUE0QP9ZQY1Ly9XLFN0djOWMLq0aWlSGzJ
         kuRbzRhiE41YqqHLx6p9a4CZIh3lTbMlFR0f6eldYGIlCVeXlZcMPAzybRv7xjoIQv
         G4j5TQMlVLb/QxNP8AuS+9P4ugU3tJWRx9BQqI6OFHWNrojz8/egAU9IBOU3b2Vg4G
         4bdii8ggDCQcw==
Received: by mail-lf1-f48.google.com with SMTP id w7so21207007lfd.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:50:43 -0700 (PDT)
X-Gm-Message-State: AOAM532gUOA4Ftqn66ATd6r810DGrpC0mviUxzhrcbDPxFtqPmT31k67
        pjByOXCujFFm+1lNXqlG5AcmXggVfjZrc+1hAEY=
X-Google-Smtp-Source: ABdhPJx4soqBEdPe9BsBWRodarFmFvffwnL8gJNGNWxLdPiwvnRyf9uPClxnIIPxrfeO5I1WrJjrhE+gwbDK5jDzzi0=
X-Received: by 2002:a05:6512:32c8:b0:44a:27fd:cd06 with SMTP id
 f8-20020a05651232c800b0044a27fdcd06mr1979767lfg.239.1647791441629; Sun, 20
 Mar 2022 08:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org> <20220320093750.159991-6-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220320093750.159991-6-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sun, 20 Mar 2022 22:50:30 +0700
X-Gmail-Original-Message-ID: <CAOG64qMoDjLer_OgRn2edGLMLMVfA5Lv3CZSU2VeOkgzPWNVUA@mail.gmail.com>
Message-ID: <CAOG64qMoDjLer_OgRn2edGLMLMVfA5Lv3CZSU2VeOkgzPWNVUA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/6] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 4:37 PM Ammar Faizi wrote:
> +void *realloc(void *old_ptr, size_t new_size)
> +{
> +       struct nolibc_heap *heap;
> +       void *ret;
> +
> +       if (!old_ptr)
> +               return malloc(new_size);
> +
> +       ret = malloc(new_size);
> +       if (__builtin_expect(!ret, 0))
> +               return NULL;
> +
> +       heap = container_of(old_ptr, struct nolibc_heap, user_p);
> +       memcpy(ret, heap->user_p, heap->len);
> +       munmap(heap, heap->len);
> +       return ret;
> +}

This better be simplified like this, so only have 1 malloc() call that
applies to both branches.

  void *realloc(void *old_ptr, size_t new_size)
  {
         struct nolibc_heap *heap;
         void *ret;

         ret = malloc(new_size);
         if (__builtin_expect(!ret, 0))
                 return NULL;

         if (!old_ptr)
                 return ret;

         heap = container_of(old_ptr, struct nolibc_heap, user_p);
         memcpy(ret, heap->user_p, heap->len);
         munmap(heap, heap->len);
         return ret;
  }

-- Viro
