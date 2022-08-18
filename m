Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3025988E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbiHRQbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbiHRQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:31:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDC86556A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:31:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so2348546wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Mj2W/9YQ8CSVcaLjuXP+DmmiR5MM9ERHw2BcymcGKFA=;
        b=kS4KpE0rlsabzWnpMDsVwTahuARW+OsaJWtYu0nSqaSJYtXJ3Inktf9oVEwqf5oBV7
         /5RTXa9UKdj2LbuQPGZRPN3IRXzOCkL4rDmuqTEsuHR5MAgE+VsVWZhp6lEXPtSWZrxi
         tiwtnj2jSsSNDMXmvaNaIf3r3yFUeuSLMsthc3ekMjSAnxCsWDVOdUr5M0iO4yxSsinH
         gcM0f0m2recGgtPRAiHhXGMr7enPlylCctjjbzG7lM+Cj4V++53YJGgEdBUEauSZGDlv
         O7rLKCVfQUZh9byFXh8HTW6yp0bervbaO3ldEdReGqy2Jo6UZrHavn7bwumbyOSDbo45
         Rw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Mj2W/9YQ8CSVcaLjuXP+DmmiR5MM9ERHw2BcymcGKFA=;
        b=DmZnHAvvo/I1tp6CIGs6qvR5dJgq0D1FglNdFByCZ3fuwjNiee21/n/hSOQX9SOsJU
         pYH7VMZuB6XrYBM7LYfKTcrcxCUFqR8OlKVNz0Jr73ZciQ8NoCkZjZ3Niy+Ufq90AsY1
         xTpXW8F2ygk1L8hffmbheh6auE0Q0uHe2Mh/tKgkpaUSzfklG2iVcLQ6Ne1BwWTV/sYT
         Prd/g2CFzE3IUMIbcdEjcg0SphItZ/WSfX7jHJCbSqPD14K0/lxs+1rYcokcyuzEpZLU
         lWUcqVnLstaglJm6rU8413brmcdabiu6MM7bidzbVPnOBLK5vIUOxYLZkSo+RDrYMdwI
         qBNg==
X-Gm-Message-State: ACgBeo1XlSy2hhUywVQYpiAF3bE3zgxmpBVi6eSThY68nhbeMg5r6bcK
        /mY94BkxmPX3WXkDYQ8u0eO2SmzT1pSqLB82GGtPxA==
X-Google-Smtp-Source: AA6agR7ptwgOiN9ve6GHG++tOZb69TaGwVq5lbuz8r6SbFoOXDjW/azm5vFAdP7Toc6aCziPDQNVRfS97n3nj3BrVAo=
X-Received: by 2002:a5d:4907:0:b0:21f:bc42:989 with SMTP id
 x7-20020a5d4907000000b0021fbc420989mr2074812wrq.375.1660840260654; Thu, 18
 Aug 2022 09:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
 <b42344bc-86f6-9047-b015-88ef3b58a619@intel.com> <CAP-5=fUq4N+X+3VMsT=he3Q9_4qHKkqxdPDcMdDE=_3qdV9aCg@mail.gmail.com>
 <YvzrYLx3RDHAmqbf@kernel.org> <CA+JHD90RuF+sjO7t40voiQrXbaH172Le=KeKGzTrK_tBquVbAg@mail.gmail.com>
In-Reply-To: <CA+JHD90RuF+sjO7t40voiQrXbaH172Le=KeKGzTrK_tBquVbAg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 18 Aug 2022 09:30:48 -0700
Message-ID: <CAP-5=fV1_JToqVDqjTcTpLZ48CzfGY-kmH_WOoAD8z+QNyRsaw@mail.gmail.com>
Subject: Re: perf tools man pages on the web
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Kacur <jkacur@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 9:24 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Wed, Aug 17, 2022, 10:21 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>> Em Wed, Aug 17, 2022 at 06:02:25AM -0700, Ian Rogers escreveu:
>> > On Wed, Aug 17, 2022 at 1:55 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>> > > Speaking of the wiki, anyone know how to change the
>> > > "Set $wgLogo to the URL path to your own logo image." image?
>>
>> > +1000
>>
>> > Someone at RedHat knows :-)
>>
>> Documentation is at the Media Wiki site, admin up to a point was John Kacur,
>> John?
>>
>> https://www.mediawiki.org/wiki/Manual:FAQ#Changing_the_interface>
>>
>> --------------------- 8< ----------------------------------
>>
>> How do I change the logo?
>>
>> The logo that appears in the top left of each page is determined by the $wgLogo configuration line in the LocalSettings.php file.
>>
>> There are two ways to change the logo:
>>
>>     Upload a picture to your wiki using the normal file uploading interface. This allows the logo to be replaced easily, so you may want to protect the page if you use this method.
>>
>>         Then add the $wgLogo line to LocalSettings.php, for example:
>>
>>         $wgLogo = "{$wgUploadPath}/6/62/mylogo.png";
>>
>>     Upload an image to your server by other means (such as FTP).
>>
>>         Add the $wgLogo line to LocalSettings.php, for example:
>>
>>         $wgLogo = "{$wgScriptPath}/mylogo.jpg";
>>
>>         (In this example, the image is in the same folder as the LocalSettings.php file.)
>>
>> If you want to change the logo in only specific pages, override #p-logo
>> css's background-image property or use third party extension like
>> Extension:LogoFunctions.  Caution! Caution:     Do not simply overwrite
>> the default logo installed with MediaWiki (/resources/assets/wiki.png);
>> this file will be overwritten when you upgrade.  A good size for a
>> square logo is 135x135px or 150x150px, but the logo need not be square,
>> especially if it contains text below an image. The maximum logo size in
>> Vector is ~160x160px, while MonoBook's is ~155x155px. A logo that is too
>> large will be cut off.
>>
>> --------------------- 8< ----------------------------------
>
>
> I got it sorted out with the kernel.org admins.
>
> Please force reload.

You made my day!

Thanks,
Ian

> - Arnaldo
