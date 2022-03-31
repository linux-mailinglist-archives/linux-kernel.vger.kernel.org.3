Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375EA4EE058
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiCaS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiCaSZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:25:54 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6109FCF;
        Thu, 31 Mar 2022 11:24:06 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-df22f50e0cso169322fac.3;
        Thu, 31 Mar 2022 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=yesPU3SDbBcDd4ReUs2XnnvnmEg173VZaD473ojDehs=;
        b=J0J4NOhkg5bdBbJzCSkDU3m/kcPRAx/ko4v97JVuN4KBTzB/lk09drXtP1I/evhksb
         xsV2nY9EAeb8Ck2LhWxR8B8WthLKZpw17/jwnhgvyz7909q7HG5E3603VxBoZfeKk/Ce
         HuYrn19XwIBo56eNMiglhWbZrLs4+e4Eu3If6wNWMyCg9NksCFQAIxhqccxLIA4RK3zX
         Kp/d13W+xfe21KjuwkZo+gi332ipskuoFBU7Ap4tQYrK2mq4KnPu90aLe4+MnQbUCd3u
         MbntmJtzDx4RVPVHITbwv8RgUWaYpqbz8uBzsUXV6CjMIK1cl5eV/WlmqS7ZEXIY8EU3
         1i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=yesPU3SDbBcDd4ReUs2XnnvnmEg173VZaD473ojDehs=;
        b=Oq0r8oL8PjywRqG4cZ1YsVVgaDgCFn+HwuZ70WG0GB0Qu59+s7zToDotRropzYlMSI
         V2aYuFtUu+SCGmjLJX7voWuMCI0ykuPFrjXxEmbAv8BcCZ4FpHCrea6lBh6dlUuhbLpl
         A68B2/bFMdIXK6MUCPfnR1JE20RBAJ5jo3vGH/0Fq+62NgbeytIPHhG3sRQuW6MdrVT1
         eI9ZAiHizToFc7cwKw6fyCdI5igUMFgxSXnn26q9ZNSivf5FIYqGw8QAg9RsHbyDTsJo
         ggnDBFlGfm4oDSTBszgsxpJCLorZk7JJmv/Lk4GERDIZ///fPXDiWmJ6NdJyzeext+qS
         iW9w==
X-Gm-Message-State: AOAM530cz9KRWDqTgbpAUy2SInw1XbDg1iiacKzCNBRSQh2AvTWlfMNE
        UVZKD7EqRUcKoqN2K9BGaKoe1yM6nuA=
X-Google-Smtp-Source: ABdhPJyyuVXBByD2St086u49lFqjEA8VvNAkZU4nudV0TshbJkvbacrg8Xqt6md4gM11vi23Y4VtfQ==
X-Received: by 2002:a05:6871:728:b0:dd:c167:4393 with SMTP id f40-20020a056871072800b000ddc1674393mr3314045oap.108.1648751045900;
        Thu, 31 Mar 2022 11:24:05 -0700 (PDT)
Received: from [127.0.0.1] (187-24-193-62.3g.claro.net.br. [187.24.193.62])
        by smtp.gmail.com with ESMTPSA id fl12-20020a056870494c00b000ddd5a37614sm61964oab.8.2022.03.31.11.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 11:24:05 -0700 (PDT)
Date:   Thu, 31 Mar 2022 15:23:01 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Andres Freund <andres@anarazel.de>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>, mptcp@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf] perf tools: .git/ORIG_HEAD might not exist
User-Agent: K-9 Mail for Android
In-Reply-To: <20220331173344.xvhp4yi67fv6p6t5@alap3.anarazel.de>
References: <20220329093120.4173283-1-matthieu.baerts@tessares.net> <20220331173344.xvhp4yi67fv6p6t5@alap3.anarazel.de>
Message-ID: <5B37F7F6-CDFD-49B9-9BF6-CEA726E5F0CF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 31, 2022 2:33:44 PM GMT-03:00, Andres Freund <andres@anarazel=2Ed=
e> wrote:
>Hi,
>
>On 2022-03-29 11:31:20 +0200, Matthieu Baerts wrote:
>> It seems it cannot be assumed =2Egit/ORIG_HEAD exists if =2Egit/HEAD is
>> there=2E
>>=20
>> Indeed, recently our public CI reported[1] the following error when
>> compiling Perf tool:
>>=20
>>   $ cd tools/perf
>>   $ make -j4 -l4 O=3D/tmp/(=2E=2E=2E)/perf DESTDIR=3D/usr install
>>   (=2E=2E=2E)
>>   make[2]: *** No rule to make target '=2E=2E/=2E=2E/=2Egit/ORIG_HEAD',=
 needed by '/tmp/(=2E=2E=2E)/perf/PERF-VERSION-FILE'=2E
>>=20
>> This is because apparently[2] Cirrus Ci uses a Git client implemented
>> purely in Go[3] to perform a clone=2E Most likely, this tool doesn't
>> create any =2Egit/ORIG_HEAD file but =2Egit/HEAD is there=2E The error =
can
>> indeed be reproduced by renaming this =2Egit/ORIG_HEAD file while keepi=
ng
>> =2Egit/HEAD=2E In other words, it means it is not enough to check the
>> presence of =2Egit/HEAD to assume =2Egit/ORIG_HEAD exists as well=2E
>
>FWIW, It's not just custom git implementations, stock git doesn't ensure =
it's
>there either=2E I build a nightly VM image with Linus' kernel for postgre=
s
>testing, and as part of that I do a minimal clone:
>  git clone --single-branch --depth 1 git://git=2Ekernel=2Eorg/pub/scm/li=
nux/kernel/git/torvalds/linux=2Egit /usr/src/linux
>and then build the kernel=2E The build recently started failing like this=
:
>https://cirrus-ci=2Ecom/task/4648999113195520?logs=3Dbuild_image#L3121
>
>It's not a question of "--single-branch --depth 1" - ORIG_HEAD just isn't
>there in a new clone=2E Which makes sense, because there's no previous va=
lue for
>HEAD=2E

I merged the patch that stops looking for =2Egit files, as soon as I fix a=
 libperl feature test with CC=3Dclang I'll send a pull req to Linus to get =
rid of this =2Egit perf --version related regression=2E

- Arnaldo
>
>Greetings,
>
>Andres Freund
