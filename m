Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE08A4E6A29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355072AbiCXVU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355056AbiCXVUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:20:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C92136B72
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:18:50 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b16so6931348ioz.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnbgqLOTG+5hHU3g7Jzj7aZPIyJgNTDTLENYpZPQ1Pk=;
        b=jRiwsJKaOQAU2T7ZlBP9cvqGwbi86q52zxQs+4qBJLmMKIUDifclJXOaWlvJaBg5vP
         C8AOSOwKJO3KonaUrkMwpMR9LnmktD8/86ransj73ulWidklQZL1PbqsHbwy55oVBVwi
         S+ioh90m37Eun5tK/vqDCrp4eyy9VzAO8Fpea/GMFU7bUZ2bBw4O1gO6qB2W0U1AHIj1
         uoQKFkiopR60ZeYqU5soQaOqb1f8DFN59yK+8PD/U86hkQuLKfA97CuKy52d7DNINiQ+
         xRgTXo72NsyVl3VFB7FMKM5R4Pi0PjP+BbRtFKvGrwN0ZMF2oQHSMHhyeyaiGqGNqR2H
         LTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnbgqLOTG+5hHU3g7Jzj7aZPIyJgNTDTLENYpZPQ1Pk=;
        b=DiMrW2O5FK194EpO0N2eBn6+k8mB52arOK1tKt5IA2APAvMbR2JqCqb176Kx2QzjNT
         MxnG71+OHkXwoWgZrEryqLBI7yjL3TU7WHODD182YoDrfDYaK2CJPeouipsGuTm7a2Xc
         y4ZTLDktrfH5PwsBlCJE4FQxubcqV5fytNEnd5tnbxg+ZT+dCmjqaZeSStBjFv0hOlOz
         mQmc2pBJA+IabG59P7fuyE8INclqv9k+dL7zS6NczzinXx5XBOF48JysOemurlm33EV1
         NZJ5uWQ4Yyk3NAojsLLF/KX2m6XsTGJlvRocJhD08QVpX7XenGETkn6G+cv4oh4gK2S1
         zxCQ==
X-Gm-Message-State: AOAM533WyTkBEM4PXKXeBa2vORKh+QX28GlfUWrtmMMIta3Px32RiDlX
        7OlMDBwJ7pODX+rzrCKZ1uWDWw/Aaa/hp2wnq/U=
X-Google-Smtp-Source: ABdhPJzEjs/42FQWILQ6XwMyw+H2YMIxy6QwdRT8YJsRgyqyh/7EfTBDRzbMxZm/hZVCMn56PwNDtWEWzEkFwaRkiO0=
X-Received: by 2002:a05:6638:dce:b0:31a:256b:6b92 with SMTP id
 m14-20020a0566380dce00b0031a256b6b92mr3991019jaj.308.1648156729838; Thu, 24
 Mar 2022 14:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220324170929.542348-1-steve@sk2.org>
In-Reply-To: <20220324170929.542348-1-steve@sk2.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 24 Mar 2022 22:18:39 +0100
Message-ID: <CANiq72mQXV0sfh6-LKYjc9fMDuJR=t4dMdBD-6y=-Bq3YHDysw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: lcd2s: use simple i2c probe function
To:     Stephen Kitt <steve@sk2.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Mar 24, 2022 at 6:10 PM Stephen Kitt <steve@sk2.org> wrote:
>
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>
> This avoids scanning the identifier tables during probes.

Thanks for the patch -- Andy submitted an equivalent one which I
queued for -next some days ago.

Cheers,
Miguel
