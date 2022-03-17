Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE954DBC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358312AbiCQB2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358301AbiCQB1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:27:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3CD1E3F1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:26:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qx21so7663702ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pg72bDDMXKgIFi4/3pJ510z+c/iucl3unZbSLqSuVPE=;
        b=D1BJhdsQ8C0/EXJsr5prdMYV5Iy4RSwkDYjHmUKFnj2CZKCBGkzkAXu4Rs7DIr/+Z4
         ZfSM/kuOa35PMdjptMxhHqP2t3+VNoupShB1xXjFBk2DzX2cUzoIjI7XT6JJODM/tYIf
         8lA6KtoFMhwT3j+PcPePSF9MOQeW3WwSzzks8E+NX55uvktEGS5MWcESDp9pUYBUVPsq
         6pa2CviNGYWuBVueLigdwYK4kL52uaysCvcWIbWphWhVeFY8OjFosN0Iy/flCQqmQP8U
         IrSh3kH82dc44rF5DEX70LabAkVZhbxhKhFez87gath/Ru7xG+g8/aKc+mC+hshrjnPh
         iZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pg72bDDMXKgIFi4/3pJ510z+c/iucl3unZbSLqSuVPE=;
        b=VSCngrUeQs3JIfqFbuM4+toMn6Ke2abt8oRxfKBhF/7IbjrTEsv+Ng+9Mw+kwLB5lD
         gf3826iDb248BhIMGxlBwcVI2d8L/cdG9D7jvz6OkoIzXKeXqDqg68KXgJSwllwg/xQy
         mvK0yKZogxG6g3S34T+i6ZHbGATYn55NGjgJE6zA2nLpAxjU1ISG55SbzGxY6QZvUTuL
         w/b2Fz/RIMDWv9n10oT4QHPyGsXSaTaHpSvt6VZVKP+MMOP8sYsCeD5hTyQw5WGdPGbc
         vnv8uKJ3T1kE0m27N9M0S8fG7QHK/K3ehAZDtuZYjDSosnbu61IzkDq7Qa9m6zcHQepL
         5tVA==
X-Gm-Message-State: AOAM531vS87wUVsjM+lFH5tkoPQ6Svh4c1anSTrzYChjGLVaYyq1kMF8
        LjJll33Xl05DaedpsPTv8bN8xBNTetDgvSxqqSsI
X-Google-Smtp-Source: ABdhPJzpu6lp6njiy52N0zdfBqZGt9nd46eib4HOnCsGmHdwyVJiXgdilrP0Ia8kUmKFsYygmbE/G+cWMPcsCXk/jHw=
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr2251417ejp.12.1647480393427; Wed, 16 Mar
 2022 18:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-4-mic@digikod.net>
In-Reply-To: <20220221212522.320243-4-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Mar 2022 21:26:22 -0400
Message-ID: <CAHC9VhTF4j+z-kp5apB2MYK0zk9q4RNu2ou9yWm7jBNk7BG1=Q@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] landlock: Create find_rule() from unmask_layers()
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> This refactoring will be useful in a following commit.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221212522.320243-4-mic@digikod.net
> ---
>  security/landlock/fs.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
