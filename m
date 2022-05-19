Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D89252DC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiESSQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbiESSQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:16:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590883F32E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:16:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g12so7992389edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIMVZQoCIemSsbsHURC+HmjbtA2W6+O4xwzn3khP5yI=;
        b=TR1CHisSIWo8+anX1kgZb1JfyNU7BAHCjjch2YFDwHG9ik3+6rIEXePjiwMYSLJzl/
         OLPVxnB8GuMHDbLjcN0gyWrnXg5J7mFqf/AluIdECJuXHdHMgX8OwpTEsXKZf2Uro8WN
         ocWIDBEPtyYvEvCDSe1UWNKSZ+0LOUvTquCTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIMVZQoCIemSsbsHURC+HmjbtA2W6+O4xwzn3khP5yI=;
        b=an2xUbEAaSNPZBcAP1c+yYKHXXC1Goatz8tmSWN0LRh+RCEydovYQCG20ztf+7QXiY
         zkb2yEMVD4HMvmpyy0ZYBMhJ06jj7380Nh2vOkUaf53SNdYvLGoRuD1OOsfXo1DvhRMW
         U3Z+xaUBEN4+W92RLQ1rlpGxNQhOTINKKtVF/1FrPEA8wKh9pBVKvuY1269Q1d6Gkctx
         F5UlfO0SH2y7UicKxDL+Xr2folgjeMZUi7n6X0k/BsIFZCAUMv3yHQt60kPbMjw8ANjG
         HutbAf18uU4XKIJIAFtg1S0CNojwFp2IMl9qIKV2XHwcw735mfSXeOEXhfSn/wof28Br
         MHog==
X-Gm-Message-State: AOAM530iaMLq4lUD9tKRw2UpziHqMZrlLkvWAvcyVJbfIudOXMo41SlY
        LRujcID9CsZOqtOnLCSXDD3U/OF/vuArfV1lGCViWqiwSF3sw7fE
X-Google-Smtp-Source: ABdhPJxIwNjyGJ7pNTrIuMzLwq1/zvvPIriJMeIFMeBZT712aJniPfHgJD3Pt3r/pjNYHiozis6QP4mQNUVq6SB4waQ=
X-Received: by 2002:a05:6402:1453:b0:42a:ae31:310c with SMTP id
 d19-20020a056402145300b0042aae31310cmr6633034edx.382.1652984183002; Thu, 19
 May 2022 11:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com> <f3555e3c-06d9-4d19-d3a2-9a2779937e83@ddn.com>
In-Reply-To: <f3555e3c-06d9-4d19-d3a2-9a2779937e83@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 19 May 2022 20:16:11 +0200
Message-ID: <CAJfpegsJijCeNZ9ES72e=gDNDisK5itG67GK8xNWRar=HMm6gA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 at 19:42, Bernd Schubert <bschubert@ddn.com> wrote:

> Can you help me a bit to understand what we should change? I had also
> already thought to merge CREATE_EXT and OPEN_ATOMIC - so agreed.
> Shall we make the other cases more visible?

Make it clear in the code flow if we are using the new request or the
old; e.g. rename current fuse_atomic_open() to fuse_open_nonatomic()
and do

static int fuse_open_atomic(...)
{
    ...
    args.opcode = FUSE_OPEN_ATOMIC;
    ...
    err = fuse_simple_request(...);
    if (err == -ENOSYS)
        goto fallback;
    ...
fallback:
    return fuse_open_nonatomic();
}

static int fuse_atomic_open(...)
{
    if (fc->no_open_atomic)
        return fuse_open_nonatomic();
    else
        return fuse_open_atomic();
}

Also we can tweak fuse_dentry_revalidate() so it always invalidates
negative dentries if the new atomic open is available, and possibly
for positive dentries as well, if the rfc patch makes it.

Thanks,
Miklos
