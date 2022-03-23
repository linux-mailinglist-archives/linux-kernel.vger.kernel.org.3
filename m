Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A924E5A06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbiCWUqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344780AbiCWUqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:46:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AA915A3E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:44:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id p15so5242416ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fku+6iImykDpE+CdH3YcTn8A/1C3dv28NZDezDdlHeA=;
        b=rimwbpV92tuw99iYIZcPP347gpbCZyZKY7+HLhuMNjxqBEIUJGedYOaKWL8CI0zcSk
         vOvurYQQum/fciyrg2WsD7KRdnRN+pzyneThjc5hZ4p9KDQDjUebNPa79cw/O9ozgLDp
         Xpx0l5+IGUamRixms2I6vIeLiwe2x5bynRPuvNsf0deVj9wqEHDUfNnJZ4XuLEuj4P0a
         7hZSB07TRVp/DXAvi9PttVy1r+lhb5gU36RkkslV7ZcBHZ3fRi7KfYhodu9VYeqBivYX
         PcYIHKbjf1soCUSz2Z9y0OcvGrWzlU4lPgxesOi8bu2G6ItZi5AFOCcH+eeSON/HlZK2
         MmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fku+6iImykDpE+CdH3YcTn8A/1C3dv28NZDezDdlHeA=;
        b=ZHPSx1F39ETiMAfzcrEmuWt96EW8/l2g2WXTs5xEKVNGyupHszGzgPjU9SdIR0s2+v
         eM4NjWzJidTL0CBracj+BvE0kdgUksLe+Mdvk4mI3uernXBMH8ZfpqybWnhvzGfkVeVd
         8of9Q8d9oH6M/qy+F8WkSy+WIiUSIIUrQ+RFJVDeKxt6Vc0uqUOuT3F9delBJl85N4Qa
         VtcTx1nBJ4d6ZTfnFt+EE3Kc+0OybIY9XPvoAXt81stY1tJxRrUPtr7h7+YbK2RNGRs+
         MPhGwO+TK7A9MtlFNz+5ubFirWJl6gX8CjT3AT18VrWRo1bWPuSD0gZEJT6Pnq1Jslta
         6tWw==
X-Gm-Message-State: AOAM532iA/bdkoc9fI5MNnx5ywcZSMDzQ0Ss0r3j5fvCsWoz45eW5MSc
        wKIK5216T9j5yvf3t95roZwVzmzayluuVeJ+JiZWPg==
X-Google-Smtp-Source: ABdhPJzbgI6L52aqCemnXWTbsdkQBP6+95otwHdTetv5DDL4bb/WZyoNa0gq2syjMy8NySL4wZvNGMiG7HH+7xh7pL0=
X-Received: by 2002:a17:907:c018:b0:6df:e31b:d912 with SMTP id
 ss24-20020a170907c01800b006dfe31bd912mr2121035ejc.196.1648068273445; Wed, 23
 Mar 2022 13:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <20220118190922.1557074-2-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 16:44:21 -0400
Message-ID: <CAFd5g44Er-cy=uRENk3Myc_Hq1H9uxqWOzQ7A+3+F4_rU8DezQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: tool: make --json handling a bit clearer
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 2:09 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently kunit_json.get_json_result() will output the JSON-ified test
> output to json_path, but iff it's not "stdout".
>
> Instead, move the responsibility entirely over to the one caller.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
