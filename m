Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB16583597
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiG0XVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiG0XUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:20:52 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039252FE1;
        Wed, 27 Jul 2022 16:20:50 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id l9-20020a056830268900b006054381dd35so102666otu.4;
        Wed, 27 Jul 2022 16:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2JTmq+1X28LPGAmzTd38TcIzshbob0NrRj+A202vME=;
        b=A0sv2pjxLoxoaFYZ0F+sroPWMh4VPiUdjVfb25swtI00uJGI/Nc2XSeODFDUTkjW1m
         1Sw0JYCfInDakt9+KPeeVZ5igiqDAYiPgApDlb1ZgwRzZ7LDkCrvAgjiN8YV+Z2C+w7F
         109N8vicBCnqsNntG0IK5oJXkMnacOB7cbOAvM35rsQfYTqZC4cgmOzfhPgcNFNNkDW6
         JFwycU4740hIIxgBGoVcm3wAd7weTb1QRCqmrik3qLKgPFGBUGndDldimeU0zlP9tnBI
         t2T+ziW9ebZ++aklok4ym/lDkwuXKtHTL1TaUJ/MooA1satVNhvej1KtSXL7jN6nhSUf
         oljQ==
X-Gm-Message-State: AJIora/5EvaXKE/96BskGGmWcI86q68SxCCJbFJl8iGYBaDj9oT2+jvQ
        Keog/vFXfYirMJzNafE7sMz4MsSiK0ppCAbmG8A=
X-Google-Smtp-Source: AGRyM1uhQ+9fd0LaVu6oL7FJixoUp2Lt/Tf22opt/zS1DEXnsHQGuGQdi1aV9+8BnpZUMo49nQgTMg+EPjmz0D0cpuY=
X-Received: by 2002:a9d:3cc:0:b0:61c:7d1d:2056 with SMTP id
 f70-20020a9d03cc000000b0061c7d1d2056mr9626340otf.247.1658964050223; Wed, 27
 Jul 2022 16:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com> <20220715063653.3203761-16-irogers@google.com>
 <CAM9d7cigU9Sq2T3i3M1vA_vU+MrqCEbhOZPQ4D13dO+WomKP_A@mail.gmail.com> <CAP-5=fWqJkytGTCRsxUzJgAOUYmqwgh_bp_01HrwLQMPZmiOig@mail.gmail.com>
In-Reply-To: <CAP-5=fWqJkytGTCRsxUzJgAOUYmqwgh_bp_01HrwLQMPZmiOig@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jul 2022 16:20:39 -0700
Message-ID: <CAM9d7ciB+d3d7ZRtcBcb-fkAx2SJ84hrhXLazt6YLNieZzORGg@mail.gmail.com>
Subject: Re: [PATCH v1 15/15] perf jevents: Compress the pmu_events_table
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 9:53 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Jul 26, 2022 at 9:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Jul 14, 2022 at 11:37 PM Ian Rogers <irogers@google.com> wrote:
> > > +def c_len(s: str) -> int:
> > > +  """Return the length of s a C string
> > > +
> > > +  This doesn't handle all escape characters properly. It first assumes
> > > +  all \ are for escaping, it then adjusts as it will have over counted
> > > +  \\. The code uses \000 rather than \0 as a terminator as an adjacent
> > > +  number would be folded into a string of \0 (ie. "\0" + "5" doesn't
> > > +  equal a terminator followed by the number 5 but the escape of
> > > +  \05). The code adjusts for \000 but not properly for all octal, hex
> > > +  or unicode values.
> > > +  """
> > > +  try:
> > > +    utf = s.encode(encoding='utf-8',errors='strict')
> > > +  except:
> > > +    print(f'broken string {s}')
> > > +    raise
> > > +  return len(utf) - utf.count(b'\\') + utf.count(b'\\\\') - (utf.count(b'\\000') * 2)
> >
> > Sorry, I don't understand why it needs the last utf.count * 2.
> > Could you elaborate more?
>
> Yep, so
> 1) start with the length of the string
> 2) \ will escape the next character, e.g. \n, so instead of counting
> that as 2 count it as 1
> 3) but, \\ will now get counted as 0 and it should be 1
> 4) but also, a numeric escape like \000 will get counted as 3 rather
> than 1 so adjust that.

Ah, ok.  Thanks for the explanation.  I think it'd be nice to
have it in the comment.

>
> Obviously this isn't full C string parsing, but it is sufficient for
> what comes in the json files.
>
> >
> > > +
> > > +class BigCString:
> > > +  """A class to hold many strings concatenated together.
> > > +
> > > +  Generating a large number of stand-alone C strings creates a large
> > > +  number of relocations in position independent code. The BigCString
> > > +  is a helper for this case. It builds a single string which within it
> > > +  are all the other C strings (to avoid memory issues the string
> > > +  itself is held as a list of strings). The offsets within the big
> > > +  string are recorded and when stored to disk these don't need
> > > +  relocation. To reduce the size of the string further, identical
> > > +  strings are merged. If a longer string ends-with the same value as a
> > > +  shorter string, these entries are also merged.
> > > +  """
> > > +  strings: Set[str]
> > > +  big_string: Sequence[str]
> > > +  offsets: Dict[str, int]
> > > +
> > > +  def __init__(self):
> > > +    self.strings = set()
> > > +
> > > +  def add(self, s: str) -> None:
> > > +    """Called to add to the big string."""
> > > +    self.strings.add(s)
> > > +
> > > +  def compute(self) -> None:
> > > +    """Called once all strings are added to compute the string and offsets."""
> > > +
> > > +    folded_strings = {}
> > > +    # Determine if two strings can be folded, ie. let 1 string use the
> > > +    # end of another. First reverse all strings and sort them.
> > > +    sorted_reversed_strings = sorted([x[::-1] for x in self.strings])
> >
> > I think some blank lines would increase readability a bit.
>
> Ack. Can add in v2.
>
> > IIUC these strings are already concatenated with \\000
> > by build_c_string(), right?
>
> They are, but this code is agnostic to that. The code must give every
> string an offset, but it also tries as much as possible to combine
> strings. The \\000 defeats that in all but 1 case for x86, but if we
> were to have 1 offset per field it does better.

Do you want to have per field offset on other arch?

>
> > > +    # Strings 'xyz' and 'yz' will now be [ 'zy', 'zyx' ]. Scan forward
> > > +    # for each string to see if there is a better candidate to fold it
> > > +    # into, in the example rather than using 'yz' we can use'xyz' at
> > > +    # an offset of 1.
> > > +    for pos,s in enumerate(sorted_reversed_strings):
> > > +      best_pos = pos
> > > +      for check_pos in range(pos + 1, len(sorted_reversed_strings)):
> > > +        if sorted_reversed_strings[check_pos].startswith(s):
> > > +          best_pos = check_pos
> > > +        else:
> > > +          break
> >
> > That means the best pos is the last match?  I guess python
> > string comparison can deal with strings with NUL bytes in it.
> >
> > Also I'm not sure how much it actually hits?
>
> Once for x86 currently. The code runs quickly so I didn't disable it.
> In other situations it hits more, as mentioned above.
>
> > In my understanding, each string contains a name, description
> > and many other fields.  Does it have some duplication?
>
> There may be, and having an offset per variable would mean we could
> take advantage of that. What I found was that a majority of the
> variables are empty/NULL so what we lose by not having sharing is more
> than gained by reducing a variable down to 1 byte rather than 4 (in
> the order of 100s of KB).
>
> > Maybe I'm missing but not sure it's worth the complexity.
>
> Agreed. There's limited utility in finding 1 string inside another for
> the current string representation. The code is still necessary to give
> every string an offset. The code to find 1 string inside another isn't
> that large nor that slow, so I kept it around.

But my main concern is code complexity.  Although it's not very
complex, it'd be better to start with something simple.  We can
always add it back if needed. :)

Thanks,
Namhyung

> >
> >
> > > +      if pos != best_pos:
> > > +        folded_strings[s[::-1]] = sorted_reversed_strings[best_pos][::-1]
> > > +    # Compute reverse mappings for debugging.
> > > +    fold_into_strings = collections.defaultdict(set)
> > > +    for key, val in folded_strings.items():
> > > +      if key != val:
> > > +        fold_into_strings[val].add(key)
> > > +    # big_string_offset is the current location within the C string
> > > +    # being appended to - comments, etc. don't count. big_string is
> > > +    # the string contents represented as a list. Strings are immutable
> > > +    # in Python and so appending to one causes memory issues, while
> > > +    # lists are mutable.
> > > +    big_string_offset = 0
> > > +    self.big_string = []
> > > +    self.offsets = {}
> > > +    # Emit all strings that aren't folded in a sorted manner.
> > > +    for s in sorted(self.strings):
> > > +      if s not in folded_strings:
> > > +        self.offsets[s] = big_string_offset
> > > +        self.big_string.append(f'/* offset={big_string_offset} */ "')
> > > +        self.big_string.append(s)
> > > +        self.big_string.append('"')
> > > +        if s in fold_into_strings:
> > > +          self.big_string.append(' /* also: ' + ', '.join(fold_into_strings[s]) + ' */')
> > > +        self.big_string.append('\n')
> > > +        big_string_offset += c_len(s)
> > > +        continue
> > > +    # Compute the offsets of the folded strings.
> > > +    for s in folded_strings.keys():
> > > +      assert s not in self.offsets
> > > +      folded_s = folded_strings[s]
> > > +      self.offsets[s] = self.offsets[folded_s] + c_len(folded_s) - c_len(s)
> > > +
> > > +_bcs = BigCString()
