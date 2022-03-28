Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7214EA05F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbiC1Tvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344149AbiC1TsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:48:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC2B6A04E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:44:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b43so16136757ljr.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yY5uf81qt+1I3vTlghdpq4T8dk4DpEDuV1Evhs9S7xk=;
        b=akIoitYH+autCWTeAaNEldmByYC482HSaca0P9IxLJj7fsaVSfNd42H+iwcxh4GRWL
         aypsLEJK3ATuIaNodb8n3qOF77dMiQykxpohirj3o8IItWcLV8RMBRa48/Hr6cAlS70z
         hLIa9bUOCy/VZS0n8MBlAqf1WrfAC7HgAd44A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yY5uf81qt+1I3vTlghdpq4T8dk4DpEDuV1Evhs9S7xk=;
        b=a7WMqg+E5KL9vmCedAybXfex5P7neNQSlCRs9qotx7yA8wTn/vujbNaUVywW8rrsqD
         MM4C25K3YnkZfcytQiN1sW5kGC8q4TSzVJYm01n4KZ04mOo9uLwMj99k+wSQ0V8BheRe
         queI5NxMts8Yo0uE/0XFw8cI5sDVafoINjCFjrJJH4TSkijw3U4XRnRmcPK6Ka7CwB9d
         wx3nCVjw/s6wJJlZPuE/mTEZOZ+1ljwucAves9OLyNthqTvlsim9Afke9+XtaNT9cdSF
         Ce2fidB5qslP3Wf/kmpFixzrQ0BUYKBmUqG6bqh6iM2vPbV9BSoD/me58AIqGn2nre5c
         nxPg==
X-Gm-Message-State: AOAM532ML5POOOiM4rKnphIgz0f6C9Uc6v3E24cCNNWx+bOQ931dDqaJ
        otBBOgOVabIn0s9Z9oc9DHhgwzOfdtp/YTYr5cM=
X-Google-Smtp-Source: ABdhPJwt+zDgU9qgFlb5woH5sVBdWNq/SD/iLhcJ+OPBVpMDM7CWMA4f0F+ef3gxNUhZl46ZL2Wzcw==
X-Received: by 2002:a2e:808d:0:b0:23e:f35:506b with SMTP id i13-20020a2e808d000000b0023e0f35506bmr22000998ljg.285.1648496636653;
        Mon, 28 Mar 2022 12:43:56 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id k12-20020a0565123d8c00b0044a3528a3cdsm1720151lfv.208.2022.03.28.12.43.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 12:43:56 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id v12so7944496ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:43:56 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr22434723lja.443.1648496635677; Mon, 28
 Mar 2022 12:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <YkG6qJsnjjzF0iFD@kroah.com>
In-Reply-To: <YkG6qJsnjjzF0iFD@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Mar 2022 12:43:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqY_5oWAFvp=zO_HqbdYsQLK+5O3DFgEpRM3MLjNZ9eQ@mail.gmail.com>
Message-ID: <CAHk-=wgqY_5oWAFvp=zO_HqbdYsQLK+5O3DFgEpRM3MLjNZ9eQ@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core changes for 5.18-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 6:39 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> There will be a merge conflict in drivers/power/supply/ab8500_chargalg.c
> with your tree, the merge conflict should be easy (take all the
> changes).

And by "take all the changes", I'm sure you mean "take none of them,
since the code was removed upstream in the meantime".

Easy typo to make.

              Linus
