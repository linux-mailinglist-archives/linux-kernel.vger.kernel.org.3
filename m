Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19BB534D19
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347034AbiEZKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346966AbiEZKOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:14:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AD7CC14F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:14:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y1so1327540pfr.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RSEr13eh+b6fOF4AIQVIdh/mTfAE/d0o6HTViH73RH4=;
        b=AhqRwWOd7vPwSK0WdCEI/mtADZ0WYUYDxoOYNpK0cJ+qeb3asr/jmkQ++hwgkcwnSB
         38ucsbXU16c8+Zeyd2igfIIyCbZDxG4HcUppsnLaCljtbC5jdgWNLIm8ZBU8JzzKjUTk
         nrwMZT9NmI/8rLEdsV185mOXplXQsj/n1SZAVdcQyBGF1x6NKuuSy+8dlA8w9D0PmHID
         vXMWF6dbyuwM3OZzyQVMVA8SETBoHv5LTNsG40AgiE8PwLSkrZd5HxRQuD2kFs2GeC30
         njIzMQG87fwF0lv1MvSPpllVsUvI27iogOqkkuwWd4CfElnWn3nvMdVHhSQXTo7Tf9XU
         AlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSEr13eh+b6fOF4AIQVIdh/mTfAE/d0o6HTViH73RH4=;
        b=vl6VcGNTLm+ilQBNDAbE7bNIn3CI3Ws3MuIsYQCkhIWhRGl2oU3mVJE8aOeHumfOBW
         G+WD7BigdgaWozeRdybLkUYSFdVHdgP+k27u54gdc1zA4ewkPMiFiDucVxF5z/UZYsNV
         gr0bXwRMR3EkPQaygGsRW/62pXwyv7hGsfpNK7h4DYCsqvhC6GnF03R9W+zplhGtZDAs
         pzJpfIY9utDvwulaHEys4oXMSy7bLO37SqU8GAsOOYwE7PKC7aBgtdekmvxK1s4Rcqh/
         H8LE+ZLmSQppIyfRDvBy8ejA4uO8BTF4ljR2Q5tHko3GuYKN1j9+svoHQMCOiqsWfgBH
         SUiQ==
X-Gm-Message-State: AOAM533vVTS8iQjApUaLBwUtQiQt0Kb8zS1ONQVKlsM1Tb8Cpfewvm4e
        fKXE+BWto97u0mu2xTODYdyjK5bEldw1ap9McI8=
X-Google-Smtp-Source: ABdhPJz3Z9xMwYQfC2QoP5WeL+fHK/zSti7f5Ovbj4z8bi0pBo7Myi8IR9qR2GZovHZ+KIH5C+l+5Q==
X-Received: by 2002:a63:69c2:0:b0:3fa:78b5:d991 with SMTP id e185-20020a6369c2000000b003fa78b5d991mr14981430pgc.40.1653560069174;
        Thu, 26 May 2022 03:14:29 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id b14-20020a62a10e000000b00512ee2f22acsm1109545pff.97.2022.05.26.03.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:14:28 -0700 (PDT)
Date:   Thu, 26 May 2022 18:14:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 2/3] perf test: Shell - only run .sh shell files to skip
 other files
Message-ID: <20220526101423.GB795802@leoy-ThinkPad-X240s>
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
 <20220309122859.31487-2-carsten.haitzler@foss.arm.com>
 <20220410022846.GB14326@leoy-ThinkPad-X240s>
 <9ab780aa-7e78-b0f9-21ed-cf30f41f8fab@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab780aa-7e78-b0f9-21ed-cf30f41f8fab@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 05:21:27PM +0100, Carsten Haitzler wrote:
> On 4/10/22 03:28, Leo Yan wrote:
> > On Wed, Mar 09, 2022 at 12:28:58PM +0000, carsten.haitzler@foss.arm.com wrote:
> > > From: Carsten Haitzler <carsten.haitzler@arm.com>
> > > 
> > > You edit your scripts in the tests and end up with your usual shell
> > > backup files with ~ or .bak or something else at the end, but then your
> > > next perf test run wants to run the backups too. You might also have perf
> > > .data files in the directory or something else undesireable as well. You end
> > > up chasing which test is the one you edited and the backup and have to keep
> > > removing all the backup files, so automatically skip any files that are
> > > not plain *.sh scripts to limit the time wasted in chasing ghosts.
> > > 
> > > Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> > > 
> > > ---
> > >   tools/perf/tests/builtin-test.c | 17 +++++++++++++++--
> > >   1 file changed, 15 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > > index 3c34cb766724..3a02ba7a7a89 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -296,9 +296,22 @@ static const char *shell_test__description(char *description, size_t size,
> > >   #define for_each_shell_test(entlist, nr, base, ent)	                \
> > >   	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
> > > -		if (!is_directory(base, ent) && \
> > > +		if (ent->d_name[0] != '.' && \
> > > +			!is_directory(base, ent) && \
> > >   			is_executable_file(base, ent) && \
> > > -			ent->d_name[0] != '.')
> > > +			is_shell_script(ent->d_name))
> > 
> > Just nitpick: since multiple conditions are added, seems to me it's good
> > to use a single function is_executable_shell_script() to make decision
> > if a file is an executable shell script.
> 
> I'd certainly make a function if this was being re-used, but as the "coding
> pattern" was to do all the tests already inside the if() in only one place,
> I kept with the style there and didn't change the code that didn't need
> changing. I can rewrite this code and basically make a function that is just
> an if ...:
> 
> bool is_exe_shell_script(const char *base, struct dirent *ent) {
>    return ent->d_name[0] != '.'         && !is_directory(base, ent) &&
>           is_executable_file(base, ent) && is_shell_script(ent->d_name);
> }
> 
> And macro becomes:
> 
> #define for_each_shell_test(entlist, nr, base, ent) \
>   for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++) \
>     if (is_shell(base, ent))

Sorry for long latency.

If the condition checking gets complex, seems to me it is reasonable to
use a static function (or a macro?) to encapsulate the logics.

> But one catch... it really should be is_non_hidden_exe_shell_script() as
> it's checking that it's not a hidden file AND is a shell script. Or do I
> keep the hidden file test outside of the function in the if? If we're nit
> picking then I need to know exactly what you want here as your suggested
> name is actually incorrect.

I personally prefer to use the condition:

  if (is_exe_shell_script() && ent->d_name[0] != '.')
      do_something...

The reason is the function is_exe_shell_script() is more common and we
use it easily in wider scope.

> > And the condition checking 'ent->d_name[0] != '.'' would be redundant
> > after we have checked the file suffix '.sh'.
> 
> This isn't actually redundant. You can have .something.sh :) If the idea is
> we skip anything with a . at the start first always... then the if (to me)
> is obvious.

Yeah, I agree the checking the start char '.' is the right thing
to do.

Thanks,
Leo
