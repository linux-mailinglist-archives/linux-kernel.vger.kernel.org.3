Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E461494979
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359274AbiATIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359234AbiATI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:29:53 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A23C061401
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:29:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so6319607wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8tEExfe2TjU1utTkKmpF2Z2tqEW48Z+Xz8Z/j98YFQ=;
        b=gcCC4nhFDZ090TxvYVsjpyos6CdVR+pJR/SbxNDCTGfEoMghQBZaa54tqlF4aoRdUz
         YmCszEWIzjA2YeDJr2g7ERBvO8awUPyw8D+EMYpA4nWPtega8EVbn5RBwcM6m44OwKVO
         qf50v4ByPHNaLOA9/ZXAKLwakupWkBmRFDhwwG+gJvIKXjo/qFuHRFb/i4TKltd2/MGA
         1iYaR1lP00WQFp6Yud3KHsyvTbZeXecVZcjfczVrpnmnxC9Mcy6pkGiP/22quppgjuZh
         2/dBzsLM0vsx9i3NmDYer5Dfhf33Ccj8hkHNH4ik+hluHBqd3paWQeuci3Fk4sM5nQIb
         phmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8tEExfe2TjU1utTkKmpF2Z2tqEW48Z+Xz8Z/j98YFQ=;
        b=5S3UZhXnvy3+RjX5pknmVqDRkDFadwp+zxCj2oERh5a4UwA0IryVjgvLf1E3h1rmYM
         /c2UcymyZtL6Q2rkMBDZtGdkd+ztiUM/1a1hvsqzWhO63viaFba44TagNbWIK93lWwQu
         qelCYf8S0Mpe4W6qsfqod7C9bnPYoWT/138e5doRBK+afDSvelB6RP8AisbYFQ1rUwn9
         q7PjHWSyqj/admZSEMdGM0x/6x7BFGbewdkDJ9y/YnUocEc+r9mSIISitoveYBTULJSC
         HAfED0sSMhXcoe6zjaFa8u6zsx00NWd8h8YN0mtwvoiS9dMb8DsknODoObqsQWhElU9d
         06tg==
X-Gm-Message-State: AOAM5300LqS0Bt/S2DOUsTaFzR/bCFZ/NG2cj52+3+WNzSC9nvyIqEAh
        g6WGuyoUP8WxALLDICEHPXA6buEshkgjotvQP3EASg==
X-Google-Smtp-Source: ABdhPJxKxmtRVZ6AbKQmd+X1bENvurd+XCC76QQk7xSudxeN+J1tqZ1QvrCnCg/1anW0JxlVUtzqWnnLMTRS1JiuLvs=
X-Received: by 2002:adf:a34c:: with SMTP id d12mr10459898wrb.80.1642667391675;
 Thu, 20 Jan 2022 00:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <20220118190922.1557074-2-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 20 Jan 2022 16:29:40 +0800
Message-ID: <CABVgOSmkfq0K_yNXzo82cxVCUz=-vSeT9qp2fkFo6=0Gc3wujg@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: tool: make --json handling a bit clearer
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently kunit_json.get_json_result() will output the JSON-ified test
> output to json_path, but iff it's not "stdout".
>
> Instead, move the responsibility entirely over to the one caller.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/kunit.py           | 12 ++++++++----
>  tools/testing/kunit/kunit_json.py      | 12 ++----------
>  tools/testing/kunit/kunit_tool_test.py |  3 +--
>  3 files changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 9274c6355809..bd2f7f088c72 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -216,13 +216,17 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[
>         parse_end = time.time()
>
>         if request.json:
> -               json_obj = kunit_json.get_json_result(
> +               json_str = kunit_json.get_json_result(
>                                         test=test_result,
>                                         def_config='kunit_defconfig',
> -                                       build_dir=request.build_dir,
> -                                       json_path=request.json)
> +                                       build_dir=request.build_dir)
>                 if request.json == 'stdout':
> -                       print(json_obj)
> +                       print(json_str)
> +               else:
> +                       with open(request.json, 'w') as f:
> +                               f.write(json_str)
> +                       kunit_parser.print_with_timestamp("Test results stored in %s" %
> +                               os.path.abspath(request.json))
>
>         if test_result.status != kunit_parser.TestStatus.SUCCESS:
>                 return KunitResult(KunitStatus.TEST_FAILURE, parse_end - parse_start), test_result
> diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
> index 6862671709bc..61091878f51e 100644
> --- a/tools/testing/kunit/kunit_json.py
> +++ b/tools/testing/kunit/kunit_json.py
> @@ -51,15 +51,7 @@ def _get_group_json(test: Test, def_config: str,
>         return test_group
>
>  def get_json_result(test: Test, def_config: str,
> -               build_dir: Optional[str], json_path: str) -> str:
> +               build_dir: Optional[str]) -> str:
>         test_group = _get_group_json(test, def_config, build_dir)
>         test_group["name"] = "KUnit Test Group"
> -       json_obj = json.dumps(test_group, indent=4)
> -       if json_path != 'stdout':
> -               with open(json_path, 'w') as result_path:
> -                       result_path.write(json_obj)
> -               root = __file__.split('tools/testing/kunit/')[0]
> -               kunit_parser.print_with_timestamp(
> -                       "Test results stored in %s" %
> -                       os.path.join(root, result_path.name))
> -       return json_obj
> +       return json.dumps(test_group, indent=4)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 352369dffbd9..f7cbc248a405 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -469,8 +469,7 @@ class KUnitJsonTest(unittest.TestCase):
>                         json_obj = kunit_json.get_json_result(
>                                 test=test_result,
>                                 def_config='kunit_defconfig',
> -                               build_dir=None,
> -                               json_path='stdout')
> +                               build_dir=None)
>                 return json.loads(json_obj)
>
>         def test_failed_test_json(self):
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
