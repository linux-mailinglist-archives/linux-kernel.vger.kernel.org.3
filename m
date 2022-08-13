Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1D59186E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 05:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiHMDIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 23:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiHMDIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 23:08:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0832601
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 20:08:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w19so4834678ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FOjkNd1xVbJqVfY8UU3UGqnX4Y9P4jNlc+hF+lbTxj8=;
        b=CGqOaiP0INUys49T9Soj1g/hXp8XrX3vKSK9EDxc+qSSPlrTDokeZpmJjOfOg/VEhy
         Ddosef03tn79JDqtphwXUwNzxzNm2Gn17PW3452sIqf65rPIwufbxHwZI46blovZjrRY
         8ZxB1XBp0k3dQMKFoEUxlkZwbG9Wyw5AaZqdD6Z4rHLEHLnlCHTaipss5tbuSxTf+bEc
         EXhzyNUkWXnahKPZoiKKl5Wvkc9UCkrUfsTRgCGPlIuu9bKp9Swrn+6Jg3R7accoFrgC
         SP280fkjw3lfEBy8tgzPZSitwgg/1o/UYI1OyoV7ulsWpGTcs9Pc3iGq+viHiV5ksaFI
         Bzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FOjkNd1xVbJqVfY8UU3UGqnX4Y9P4jNlc+hF+lbTxj8=;
        b=jATFWeLwlAcXMNY/MGUTQ8QnPrpJwNNR1byAUFOdvZuq+f1F41aXFQ9wVEnrieQ0lT
         zEHPGj8MrkCIwmKACQ5KgjU+/0+FqFWXz78X4C/2TczV3JTP6Sq3gP2N9n6BJ4WcHAm0
         t1LgbYL0rBMVd/HSXk6aQsiGNYL5qSAZr/JsAq1Fd+E+7R0/dVGbpPXIKI+mZs9wHAI7
         UgKeFbvTLIYNz6MJRBs2se8PeZ40wUiul7UwAOXmJWsv7ZGHRBTVstASigdvx8Cfx78+
         btorEdiaRhOtKc4F5e+rN+HcN89ms2nR4PL8qmYwqIdESaVZ8eBuuK6XnboEctcxLzbK
         8gQQ==
X-Gm-Message-State: ACgBeo19tYZwcsAkq7Clzq+e340sym2Xc/vj3DG4QvVeqfA1L0c5VAWG
        KoX4e1TgNBgdlUZWfvElv5Ykyw==
X-Google-Smtp-Source: AA6agR4rpMYubzwMwCgXF+kZTc7AFFRuwGRLRj5ZQm649WyeBGV8FRlpJUJ/JwwIu/iX98SWDjExDQ==
X-Received: by 2002:a17:907:60c7:b0:731:2be4:f72d with SMTP id hv7-20020a17090760c700b007312be4f72dmr4329113ejc.639.1660360107980;
        Fri, 12 Aug 2022 20:08:27 -0700 (PDT)
Received: from leoy-huanghe ([104.245.96.132])
        by smtp.gmail.com with ESMTPSA id z7-20020a170906d00700b00726c0e63b94sm1415941ejy.27.2022.08.12.20.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 20:08:27 -0700 (PDT)
Date:   Sat, 13 Aug 2022 11:08:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf test: Introduce script for java symbol testing
Message-ID: <20220813030822.GE74978@leoy-huanghe>
References: <20220806033434.121908-1-leo.yan@linaro.org>
 <20220806033434.121908-3-leo.yan@linaro.org>
 <YvauX7u69u9AeID/@kernel.org>
 <CAP-5=fUJxMz0C61Y1qwptc+M6rT=J3ztvguB+9bJBaQrYEQZ3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUJxMz0C61Y1qwptc+M6rT=J3ztvguB+9bJBaQrYEQZ3w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:08:43PM -0700, Ian Rogers wrote:

[...]

> > > +if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
> > > +     LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so
> >
> >
> > Will this only work if we do a:
> >
> > make -C tools/perf

Yes, I think so.

> >
> > ?
> 
> Perhaps, I'm not sure on the correct way to detect the install location.
> The only similar example I know of is:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/builtin-test.c?h=perf/core#n308

Yes, I refered the code in this link.

If user works under Linux source folder, the test will search lib in
the folder $LINUX or $LINUX/tools/perf; and it searchs the installed
libperf-jvmti.so in the folder "$PREFIX/lib64" or "$PREFIX/lib".

I think I can add a more path for searching system lib (e.g. the
libperf-jvmti.so is under /usr/lib/linux-tools-xxx/):

  elif [ -e "/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so" ]; then
       LIBJVMTI= /usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so

> > +elif [ -e "$PWD/libperf-jvmti.so" ]; then
> > > +     LIBJVMTI=$PWD/libperf-jvmti.so
> > > +elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
> > > +     LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
> > > +elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
> > > +     LIBJVMTI=$PREFIX/lib/libperf-jvmti.so
> > > +else
> > > +     echo "Fail to find libperf-jvmti.so"
> > > +     exit 1
> >
> 
> JVMTI is a build option so this should probably be "exit 2" for skip.

Sure, will fix.

Thanks,
Leo
