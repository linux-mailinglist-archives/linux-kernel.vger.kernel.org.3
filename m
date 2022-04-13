Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF84FF1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiDMIXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiDMIXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:23:18 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED973123C;
        Wed, 13 Apr 2022 01:20:57 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 23D8KZEC023405;
        Wed, 13 Apr 2022 17:20:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 23D8KZEC023405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649838036;
        bh=en8iih+w2ZnwafPeo1FmApeOuQau/i4oP2CnYw08lQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TUVemrg79AlLnWo/ylHmAtbk8jc+l4B90t479+60gDWHz/YfJOK0PCrIFxDqtlML6
         fsj6EWWaOky0rjMpSXuCdzSiOnohq18eEb2C5/n0+X76s3IGqJcx5TpVYqmRV8RPEG
         v0VsG1CM1HPBIb48MllInFottyAmI2JaUViWgKm5fhEVxv+/+Pxex5W2+jKas+Uu3y
         pAc2NpXVYfALJBnAHpydQdbTFUlpFX5nJpWoIdTNZRG7rr1aYJSzyFnfAyHRHJbt97
         qbpKQU1NDCgeZ42QvPJiw1UoZUafu9q+zh5v1ZVYCoTiYq8OW5iTEMX4ExD+2b/s4W
         JaWqoqkVDi5tA==
X-Nifty-SrcIP: [209.85.214.178]
Received: by mail-pl1-f178.google.com with SMTP id c12so1324753plr.6;
        Wed, 13 Apr 2022 01:20:35 -0700 (PDT)
X-Gm-Message-State: AOAM530D3flJFt7qnAEbeEij8Qyjx2DTuQc9TUn4cJBaa+LnTD55fbXk
        qUfttLmlQ+w9Ln6bfQowTOD43XFn6QJ2OOolN58=
X-Google-Smtp-Source: ABdhPJwyZa70s+IXjWsWwHTDJ9N7P9YmnxE4D05HXGJhsJyA6sD63qvgowLDRtG4Izyfi0CEq/JNmgcihdCR8PCgiaQ=
X-Received: by 2002:a17:90a:de87:b0:1cb:b207:a729 with SMTP id
 n7-20020a17090ade8700b001cbb207a729mr9429054pjv.144.1649838034888; Wed, 13
 Apr 2022 01:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <20220406153023.500847-6-masahiroy@kernel.org>
 <CAKwvOdnHneCy6YeanmvDrabYMWysfQ=WMopsT_gRyrruT8=1Dw@mail.gmail.com>
 <CAK7LNATUv2YqGLGMTjzoCWf2tVkeYe6O9xa==wdDr0pgvSnnLQ@mail.gmail.com> <CAKwvOdnj77+8OHGZcJ-pAMcFW1FzjhkPsvs90PPD+L64t0+Mpw@mail.gmail.com>
In-Reply-To: <CAKwvOdnj77+8OHGZcJ-pAMcFW1FzjhkPsvs90PPD+L64t0+Mpw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 13 Apr 2022 17:19:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQM3m-g=b_MGjr-VefTu4q5ByWYB8VdHqGXwNktZNY1xA@mail.gmail.com>
Message-ID: <CAK7LNAQM3m-g=b_MGjr-VefTu4q5ByWYB8VdHqGXwNktZNY1xA@mail.gmail.com>
Subject: Re: [PATCH 5/7] kbuild: get rid of duplication in *.mod files
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 5:43 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Apr 7, 2022 at 5:08 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Fri, Apr 8, 2022 at 2:55 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Wed, Apr 6, 2022 at 8:31 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > > index 6ae92d119dfa..f7a30f378e20 100644
> > > > --- a/scripts/Makefile.build
> > > > +++ b/scripts/Makefile.build
> > > > @@ -303,7 +303,8 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
> > > >         $(call if_changed,cc_prelink_modules)
> > > >  endif
> > > >
> > > > -cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) > $@
> > > > +cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) | \
> > > > +       $(AWK) -v RS='( |\n)' '!x[$$0]++' > $@
> > >
> > > God AWK is unreadable. Any reason we can't use GNU make's sort builtin?
> > > https://www.gnu.org/software/make/manual/html_node/Text-Functions.html
> >
> >
> > I did that in the previous submission.
> > https://lore.kernel.org/lkml/20220405113359.2880241-8-masahiroy@kernel.org/
> >
> >
> > After some thoughts, I decided to drop duplicates without sorting.
> >
> > If I alphabetically sorted the object list,
> > 7/7 of this series would be impossible.
> >
> >
> > I am not a big fan of AWK, but I do not know a cleaner way.
> > If you know a better idea, please tell me.
>
> ```
> # stable_dedup.py
> from sys import argv
>
> wordset = set()
> argv.pop(0)
> for word in argv: wordset.add(word)
> for word in wordset: print(word)
> ```
> If that ever shows up in a profile of a kernel build, <set> in C++
> looks pretty similar.  Then that script can be reused in a couple of
> other places, and has a more descriptive name that hints at what it
> does.
>
> Compare that with `$(AWK) -v RS='( |\n)' '!x[$$0]++'`.


As I said, I want to drop duplicates without changing the argument order.

Your python code shuffles the order since it adds arguments to set() first.


    $ cat stable_dedup.py
    #!/usr/bin/python3
    from sys import argv
    wordset = set()
    argv.pop(0)
    for word in argv: wordset.add(word)
    for word in wordset: print(word)

    $ ./stable_dedup.py  c b a a b
    c
    a
    b



Here, the output I expect is "c b a".


If I am allowed to change the order, I would use
Make's $(sort ...) function or "sort -u" shell command.




Of course, it is pretty easy to write a python script
that dedups arguments without changing the order.


    $ cat dedup-by-python
    #!/usr/bin/python3
    import sys
    wordset = set()

    for x in sys.argv[1:]:
        if x not in wordset:
            print(x)
        wordset.add(x)

    $ ./dedup-by-python c b a a b
    c
    b
    a


Even this script looks like a bad approach.


Please note cmd_mod is invoked as many times
as the number of modules.
So, this happens many times, especially for allmodconfig.


Python takes a lot of overhead times for initialization.


AWK implementation is much faster.
It is apparent from perf.




[1] AWK implementation

    $ cat test-data.txt
    c b a a b

    $ cat dedup-by-awk
    #!/usr/bin/awk -f
    BEGIN { RS="( |\n)" }
    !x[$0]++ { print($0) }


    # perf stat  -- ./dedup-by-awk < test-data.txt
    c
    b
    a

 Performance counter stats for './dedup-by-awk':

              1.06 msec task-clock                #    0.790 CPUs
utilized
                 0      context-switches          #    0.000 /sec
                 0      cpu-migrations            #    0.000 /sec
               201      page-faults               #  189.755 K/sec
         3,671,995      cycles                    #    3.467 GHz
         3,932,770      instructions              #    1.07  insn per
cycle
           754,811      branches                  #  712.582 M/sec
            21,154      branch-misses             #    2.80% of all
branches
        18,350,660      slots                     #   17.324 G/sec
         4,173,875      topdown-retiring          #     22.7% retiring
         2,230,864      topdown-bad-spec          #     12.2% bad
speculation
         5,757,069      topdown-fe-bound          #     31.4% frontend
bound
         6,188,850      topdown-be-bound          #     33.7% backend
bound

       0.001341605 seconds time elapsed

       0.001476000 seconds user
       0.000000000 seconds sys



[2]  Python implementation

    # perf stat  -- ./dedup-by-python   c b a a b
   c
   b
   a

 Performance counter stats for './dedup-by-python c b a a b':

              9.34 msec task-clock                #    0.967 CPUs
utilized
                 0      context-switches          #    0.000 /sec
                 0      cpu-migrations            #    0.000 /sec
               756      page-faults               #   80.947 K/sec
        31,045,653      cycles                    #    3.324 GHz
        39,175,531      instructions              #    1.26  insn per
cycle
         8,488,886      branches                  #  908.929 M/sec
           326,947      branch-misses             #    3.85% of all
branches
       152,587,445      slots                     #   16.338 G/sec
        37,698,074      topdown-retiring          #     24.7% retiring
        32,911,017      topdown-bad-spec          #     21.6% bad
speculation
        55,051,156      topdown-fe-bound          #     36.1% frontend
bound
        26,927,196      topdown-be-bound          #     17.6% backend
bound

       0.009661105 seconds time elapsed

       0.006485000 seconds user
       0.003242000 seconds sys





> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
