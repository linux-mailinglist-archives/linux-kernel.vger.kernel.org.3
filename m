Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C881497F34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbiAXMV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbiAXMV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:21:27 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E14C061401
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:21:27 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so22018963otu.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HHwOHpu3DODX4uWQ1+JZsd1/iIv5h6cdRibus7mBoQ=;
        b=lf093PoaWmusMgbiWy/WDpNTxiGQ8V5bvGmNAVRCS7jWCTTUL3SvfmEUxY+2pcHc7x
         zhpDlcNUDYTQub/RIKGlX2iDEwmyowOkMcFSp1fD/sSe0PxMuEP6Iqx9L1voRUFeqlt2
         85EUPdAFScwMwM1thEV/3TbCbQ6SndwlDnZylNYQxLTJRMXIG5dOt7mCubuFU5zvZPeQ
         PCYslMpSLeZzcQbq+6ho807GRSEOEibqCUZ1e3hoD6Y0M7ifNYMJF2vyaBhBmdVXtsxY
         Oub8NhYRxSmPX+89FDlveehVTV9p+4MIjScv2djqoYjLokXFVW4wISpaV7KfHCGxmQ2/
         gAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HHwOHpu3DODX4uWQ1+JZsd1/iIv5h6cdRibus7mBoQ=;
        b=6LjI9WlkafwiIBTSWitH/qki+hxlcrboKX8bxW9DqH4YJLkXxZNSiY5AfkJ6/qmt+y
         CO/jcZXYBsol7/gkNHBOdj+iqgYAveado+PKBqCC+AO7nD8mfIe8eCwkEnXQ9LStlkBv
         SmDoSX5hHMlsJKRmKNXtr4xONqYDWKBlgLHovmdubFzvVSQQFEP//E0mTKIgKhApqoQT
         MewnoJNvbDHJBtQCO4BXEbJPGTeRFa4y2FHNTvKD9Fqo39qC7Q4Ab0CIh4mKVn3vzQbx
         qtGtYq2Kwa313EGVKvw9+H2qBMG1oz5JvancsHxSnL7nX4QZxF57l2YMZOWkYGG2XujX
         ea9w==
X-Gm-Message-State: AOAM531opm2MGsYVAcrV3PS+eSRLW7EQ9gpASRBW/Rtrk7wTIYN7LUIF
        ErFilEW68zJb38XmD4VDP37mQbVd3WiAdUFnXHap2Q==
X-Google-Smtp-Source: ABdhPJwPCK6JVvtPZA/qEwNUZFdTfKV6fNMlNE0y/mgV0d/FLXRv3yIuKlsLt0y/g/mEMvyfH8KcoRBGc9UjO+K2CWU=
X-Received: by 2002:a9d:58c7:: with SMTP id s7mr11139396oth.246.1643026886411;
 Mon, 24 Jan 2022 04:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20220124025205.329752-1-liupeng256@huawei.com>
 <20220124025205.329752-4-liupeng256@huawei.com> <CANpmjNNYG=izN12sqaB3dYbGmM=2yQ8gK=8_BMHkuoaKWMmYPw@mail.gmail.com>
 <261a5287-af0d-424e-d209-db887d952a74@huawei.com>
In-Reply-To: <261a5287-af0d-424e-d209-db887d952a74@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Jan 2022 13:21:15 +0100
Message-ID: <CANpmjNNc6F7tRVn=UqLaW0WAgTr67XFm=CUu5X2D0Xbt3nKXwA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] kfence: Make test case compatible with run time
 set sample interval
To:     "liupeng (DM)" <liupeng256@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 at 13:19, liupeng (DM) <liupeng256@huawei.com> wrote:
[...]
> When KFENCE pool size can be adjusted by boot parameters(assumption),
> automatically test and train KFENCE may be useful. So far, exporting
> kfence.sample_interval is not necessary.

I'm not opposed to the patch (I've also run into this issue, but not
too frequently) - feel free to just send it with EXPORT_SYMBOL_GPL.

Thanks,
-- Marco
