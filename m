Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE14A7144
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344264AbiBBNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBBNLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:11:44 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A9C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:11:44 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id k17so60833106ybk.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRxmddxUqjtmE1SAQlXRcVL9E92uGA2bWan95kfPEMA=;
        b=SO5gIgkGEb8LupYQiu4GL7MTyNPKJ0PgjOXjzSiCRxRjE5nCySCNlz759gi2mdGV3W
         8G4yss+TXVvymiKTi9gvzKN81VD22fQBHpG7FoXeOWFEgjGpMvM74G7yde49/IiP/BO6
         ctDChANbtzA/kE+FimaadEpc0JZ9Ra0orzgbAjIa3JQ/F1uISo8hSjmIE8N65QR1vwzF
         eH9LrUqL8MiQ/VXM+jwDZHGeYxHNIm90mAMwE5ITCWGGTPZWXHuAVr4tKkIzlgkmw+77
         evGkFIwJEC9X73EBsUq4gx5S2VxfP9vPEiU/fJ8zqa98LqKvHE+IDjDWluqPkp56bvbY
         hSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRxmddxUqjtmE1SAQlXRcVL9E92uGA2bWan95kfPEMA=;
        b=stlyviI6UkHX8jPozjFFLmahukefYfY16ppgEm41umYJXbFnhb4Hxm8ocHQV5Jjh7V
         OjpVvmN9azvOrGFVhvt8e47oC9GgsLPXqynndI0sybkChg+6ZOfk6oB0tcnX5BttKeS0
         dAzr5+scplfWz7tazlVBzlkOCiDIDcHHhaZkUjV0rEqiNZ6IQaw6P73R4dkP2NwsQJ8B
         W8YQ1Yza2ObZSmUnGkeWVLg5rodnKUi8oEvR3/5uwqJdlXsZLXXUwUSfO48PHTV6p/6Q
         06NhlveOLF96DaIi7Qk7s2OYo7olvzvH7giEcztZjz0uK2kDU7Ty0OJyPltscgC6izbR
         m2Kw==
X-Gm-Message-State: AOAM532b9XmNOWy/tDdfeHrZxZ/euu+X38FFSn24+OE9wyxO7/PsaG3Z
        FBMG0lkpDuroUF1IJsr6ncGUMxAIv4aYH63yty1oZA==
X-Google-Smtp-Source: ABdhPJyGi0HVzpQAXkQH5WyhLX6hcqoFpVpchwrEQc6BSOc8lH12vDoOKZMr2EGx5hYytnj8YdUCCkU7YA12pJeNZDo=
X-Received: by 2002:a25:6b4e:: with SMTP id o14mr30120276ybm.485.1643807503770;
 Wed, 02 Feb 2022 05:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20220201033459.156944-1-mike.kravetz@oracle.com>
In-Reply-To: <20220201033459.156944-1-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 2 Feb 2022 21:11:05 +0800
Message-ID: <CAMZfGtXTWK-1G1Qm_Zqmd--5bcDtm4YzA6SSHHRutefgC7KXAQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: cleanup hugetlb file after mremap test
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 11:35 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The hugepage-mremap test will create a file in a hugetlb filesystem.
> In a default 'run_vmtests' run, the file will contain all the hugetlb
> pages.  After the test, the file remains and there are no free hugetlb
> pages for subsequent tests. This causes those hugetlb tests to fail.
>
> Change hugepage-mremap to take the name of the hugetlb file as an
> argument.  Unlink the file within the test, and just to be sure remove
> the file in the run_vmtests script.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
[...]
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index e09040a3dc08..e10d50e0b8e8 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -111,13 +111,14 @@ fi
>  echo "-----------------------"
>  echo "running hugepage-mremap"
>  echo "-----------------------"
> -./hugepage-mremap 256
> +./hugepage-mremap $mnt/huge_mremap
>  if [ $? -ne 0 ]; then
>         echo "[FAIL]"
>         exitcode=1
>  else
>         echo "[PASS]"
>  fi
> +rm -f $mnt/huge_mremap
>

A little strange (since file creation and deletion are not in the same place).
I know $mnt/huge_mremap is created in hugepage-mremap. But I think
hugepage-mremap should do the housekeeping instead of deleting the file
here. Or we can create the file before doing the test. Like:

 + touch $mnt/huge_mremap
 -./hugepage-mremap 256
 +./hugepage-mremap $mnt/huge_mremap
 +rm -f $mnt/huge_mremap

Otherwise LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
