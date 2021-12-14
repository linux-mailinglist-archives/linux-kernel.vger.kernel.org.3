Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F1474D52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhLNVl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhLNVl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:41:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5398CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:41:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 36-20020a17090a09a700b001b103e48cfaso82131pjo.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ksbw7wzte8Tmh9S3RxYMIuueBCNiof9dhDqnVIFaQDg=;
        b=X2P4dXXxEmCuPazognWtAaFQyi9it5wHHJI/qXb91GIxLyrE1a8CLUHN5pSC0IUGow
         lSWEFwrxe38fjO3oWHGVohI4Us+0aew7hhB68sYh7pUUU2SmFLqtgAucx458qJidAF+H
         DnnB2PoOFKVNx3hoDnll3wIP6XBJVxTyVI6PbkF7KFpH65YAuxL8PD8SJFPp7UIRVApz
         +4FyC4wRkf0Xxns05kKCHYKT/cDniT3Ll/fhnL0Jv4S+zWG9wEYFgMvUtVGaWeOFM5aV
         BnDvJsbiyMsnZFnL9WhiJ2d8i2iRR708ddAx9w+q/wpaRVIrCAEb3fgIjR9CMxdRasJz
         wXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ksbw7wzte8Tmh9S3RxYMIuueBCNiof9dhDqnVIFaQDg=;
        b=ES75cLaEnTjA89Gzw0gBJr2IvrQKGJcE1bZVBSBRxhxtvQ6xU6YBirONWAehgZMeiX
         FWc909MFjVBMJ0pH80v/gcuxNSHwhxnHpUAMuli766KbZaalaoJwnFzCnJZXC+7Dei7O
         fBv4DAGiM/Wk9dQ70m4jdVyn0OzWg/0VtCB+lr3MkGrl7g0tiVTs7ISnbsXg28SLNwlF
         njvJFt9zLYj/3xPC75J0zRSKVNvpalRR6Af1Z3QAKXtb3FPtZlgATs1vy34wy+tbfIYa
         7Uun4C+pGzhI24iyIWDcUQ/DMP/3PXbkk06RL0QVmtthGuY8Yos3BufDD8nFm2o055/Y
         BsxA==
X-Gm-Message-State: AOAM532XveuqTiaQcVXLefIb/U7VtUM4gQqADet1qLNLzJHJBaApV3/O
        C0UDu0PW1yiFg597ed9RFDP8vDIlSItgCSul+loU5Q==
X-Google-Smtp-Source: ABdhPJxk2PxVM18I3QoYtZH1ZI5/KUEcIdC7GyFKUAVr7z4yub9s2UbRDfX/2lw09PYf6hYDrQ0+VWiohOydTBhE7hY=
X-Received: by 2002:a17:902:a717:b0:142:76bc:da69 with SMTP id
 w23-20020a170902a71700b0014276bcda69mr8592428plq.12.1639518117501; Tue, 14
 Dec 2021 13:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20211214195203.174080-1-dlatypov@google.com>
In-Reply-To: <20211214195203.174080-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Dec 2021 16:41:33 -0500
Message-ID: <CAFd5g47LUiAhUgHCaaqbRRDdJyZTpk4MrWB+VkaLLHU0O5me2A@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix newly introduced typechecker errors
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 2:52 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> After upgrading mypy and pytype from pip, we see 2 new errors when
> running ./tools/testing/kunit/run_checks.py.
>
> Error #1: mypy and pytype
> They now deduce that importlib.util.spec_from_file_location() can return
> None and note that we're not checking for this.
>
> We validate that the arch is valid (i.e. the file exists) beforehand.
> Add in an `asssert spec is not None` to appease the checkers.
>
> Error #2: pytype bug https://github.com/google/pytype/issues/1057
> It doesn't like `from datetime import datetime`, specifically that a
> type shares a name with a module.
>
> We can workaround this by either
> * renaming the import or just using `import datetime`
> * passing the new `--fix-module-collisions` flag to pytype.
>
> We pick the first option for now because
> * the flag is quite new, only in the 2021.11.29 release.
> * I'd prefer if people can just run `pytype <file>`
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
