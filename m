Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE065835C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiG0XpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiG0XpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:45:10 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7249E55A6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:45:09 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id t82so147381vkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QX15C/cRjIIovRKvx8W4155J59etdzJ2q+y0+vxvYBc=;
        b=G++tRHl0yTFNevRFkdRyQdMTJarlIzF6hI95rVItM1MHA/OSaMwnTaoVOgxSP3b/+D
         AUSRvEnk6Rfvkyf6zb1esVrFS2Wp1/044LaC8Kk1OR6YGCH/5MrP8wiyp0N9ogK8wzZy
         TmX+y5JmsQ5SqHdJptl8Ti/+OEKpnpuDMpl935ldWWu1xUa+KCcICRsBkVkiUN8QfY8o
         R15wlyYU5EpSfpvk6kvneSQ9z0R5OYyhD3tJ2stX8Iyg+QQ3bUKBWh1GM8EZaCOSUrBs
         cJE12BJozEuA9q637jSg+B1RKnwzOX4t1N3BdCWCwILeo/v0HKMAbsgZDcp0uAE+TVBk
         LF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QX15C/cRjIIovRKvx8W4155J59etdzJ2q+y0+vxvYBc=;
        b=kd58ikhp7KpCcB3jxIyJTYRe+uXmndn1PCDEOZxW65/NI5LdBHjJ7p/9KLlQTCUQFY
         rtRgUbISFeBPOW0r354/uUEKow8w3FSvVFZmNTwRnEIUQffDWGk2qK7u4MFz/w2ERIeo
         XT+yYfaZ834kmxZ4apZlT0F7uYw1dEMQ4FeENN6HdJw+zuQ/+HdkZZU3qgXPJ5k7wvMx
         5FLZlGBNSx3/6KW1Y81M0Atk5Edvo3sK0QK/OjGF4J3LGS1Meyyd7xuGHCng0+Q/PZwA
         zI17MG24gz9qvvXrDWGM9wiSZWceUN8lV3y/o5Jj5SjpknAcaRCYUOCX/0946BmlapVd
         6e+w==
X-Gm-Message-State: AJIora92A67ECL3XOjwKPaAmZcQtLNK2BwCejRYFaz1SK74RH6UwNGLW
        oVrc0mfEUZkO5A22ckWBU/+Ip2n6Zl1+r3cm32T+uw==
X-Google-Smtp-Source: AGRyM1tsWaGlWDHmxvH3zUB62BDxcWrdHz42qr4efY7Bf7LvG5dgYcZd/qUImq4EQCRDIeoUcjoXAcjEU8lyAFTg6fo=
X-Received: by 2002:a1f:38c8:0:b0:376:353e:cb5c with SMTP id
 f191-20020a1f38c8000000b00376353ecb5cmr6853368vka.33.1658965508087; Wed, 27
 Jul 2022 16:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com> <20220715063653.3203761-16-irogers@google.com>
 <CAM9d7cigU9Sq2T3i3M1vA_vU+MrqCEbhOZPQ4D13dO+WomKP_A@mail.gmail.com>
 <CAP-5=fWqJkytGTCRsxUzJgAOUYmqwgh_bp_01HrwLQMPZmiOig@mail.gmail.com> <CAM9d7ciB+d3d7ZRtcBcb-fkAx2SJ84hrhXLazt6YLNieZzORGg@mail.gmail.com>
In-Reply-To: <CAM9d7ciB+d3d7ZRtcBcb-fkAx2SJ84hrhXLazt6YLNieZzORGg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 27 Jul 2022 16:44:56 -0700
Message-ID: <CAP-5=fX8hUiin0y9kuqJK7tXFQHr8+OxERd9Ob--1UFbEKq_bQ@mail.gmail.com>
Subject: Re: [PATCH v1 15/15] perf jevents: Compress the pmu_events_table
To:     Namhyung Kim <namhyung@kernel.org>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 4:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Jul 26, 2022 at 9:53 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Jul 26, 2022 at 9:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Thu, Jul 14, 2022 at 11:37 PM Ian Rogers <irogers@google.com> wrote:
> > > > +def c_len(s: str) -> int:
> > > > +  """Return the length of s a C string
> > > > +
> > > > +  This doesn't handle all escape characters properly. It first assumes
> > > > +  all \ are for escaping, it then adjusts as it will have over counted
> > > > +  \\. The code uses \000 rather than \0 as a terminator as an adjacent
> > > > +  number would be folded into a string of \0 (ie. "\0" + "5" doesn't
> > > > +  equal a terminator followed by the number 5 but the escape of
> > > > +  \05). The code adjusts for \000 but not properly for all octal, hex
> > > > +  or unicode values.
> > > > +  """
> > > > +  try:
> > > > +    utf = s.encode(encoding='utf-8',errors='strict')
> > > > +  except:
> > > > +    print(f'broken string {s}')
> > > > +    raise
> > > > +  return len(utf) - utf.count(b'\\') + utf.count(b'\\\\') - (utf.count(b'\\000') * 2)
> > >
> > > Sorry, I don't understand why it needs the last utf.count * 2.
> > > Could you elaborate more?
> >
> > Yep, so
> > 1) start with the length of the string
> > 2) \ will escape the next character, e.g. \n, so instead of counting
> > that as 2 count it as 1
> > 3) but, \\ will now get counted as 0 and it should be 1
> > 4) but also, a numeric escape like \000 will get counted as 3 rather
> > than 1 so adjust that.
>
> Ah, ok.  Thanks for the explanation.  I think it'd be nice to
> have it in the comment.

Ack. will add to v2.

> >
> > Obviously this isn't full C string parsing, but it is sufficient for
> > what comes in the json files.
> >
> > >
> > > > +
> > > > +class BigCString:
> > > > +  """A class to hold many strings concatenated together.
> > > > +
> > > > +  Generating a large number of stand-alone C strings creates a large
> > > > +  number of relocations in position independent code. The BigCString
> > > > +  is a helper for this case. It builds a single string which within it
> > > > +  are all the other C strings (to avoid memory issues the string
> > > > +  itself is held as a list of strings). The offsets within the big
> > > > +  string are recorded and when stored to disk these don't need
> > > > +  relocation. To reduce the size of the string further, identical
> > > > +  strings are merged. If a longer string ends-with the same value as a
> > > > +  shorter string, these entries are also merged.
> > > > +  """
> > > > +  strings: Set[str]
> > > > +  big_string: Sequence[str]
> > > > +  offsets: Dict[str, int]
> > > > +
> > > > +  def __init__(self):
> > > > +    self.strings = set()
> > > > +
> > > > +  def add(self, s: str) -> None:
> > > > +    """Called to add to the big string."""
> > > > +    self.strings.add(s)
> > > > +
> > > > +  def compute(self) -> None:
> > > > +    """Called once all strings are added to compute the string and offsets."""
> > > > +
> > > > +    folded_strings = {}
> > > > +    # Determine if two strings can be folded, ie. let 1 string use the
> > > > +    # end of another. First reverse all strings and sort them.
> > > > +    sorted_reversed_strings = sorted([x[::-1] for x in self.strings])
> > >
> > > I think some blank lines would increase readability a bit.
> >
> > Ack. Can add in v2.
> >
> > > IIUC these strings are already concatenated with \\000
> > > by build_c_string(), right?
> >
> > They are, but this code is agnostic to that. The code must give every
> > string an offset, but it also tries as much as possible to combine
> > strings. The \\000 defeats that in all but 1 case for x86, but if we
> > were to have 1 offset per field it does better.
>
> Do you want to have per field offset on other arch?

Not really, there isn't a huge difference with the bits of json being
used across architectures. The non-python empty-pmu-events.c is still
using per field C strings.

> >
> > > > +    # Strings 'xyz' and 'yz' will now be [ 'zy', 'zyx' ]. Scan forward
> > > > +    # for each string to see if there is a better candidate to fold it
> > > > +    # into, in the example rather than using 'yz' we can use'xyz' at
> > > > +    # an offset of 1.
> > > > +    for pos,s in enumerate(sorted_reversed_strings):
> > > > +      best_pos = pos
> > > > +      for check_pos in range(pos + 1, len(sorted_reversed_strings)):
> > > > +        if sorted_reversed_strings[check_pos].startswith(s):
> > > > +          best_pos = check_pos
> > > > +        else:
> > > > +          break
> > >
> > > That means the best pos is the last match?  I guess python
> > > string comparison can deal with strings with NUL bytes in it.
> > >
> > > Also I'm not sure how much it actually hits?
> >
> > Once for x86 currently. The code runs quickly so I didn't disable it.
> > In other situations it hits more, as mentioned above.
> >
> > > In my understanding, each string contains a name, description
> > > and many other fields.  Does it have some duplication?
> >
> > There may be, and having an offset per variable would mean we could
> > take advantage of that. What I found was that a majority of the
> > variables are empty/NULL so what we lose by not having sharing is more
> > than gained by reducing a variable down to 1 byte rather than 4 (in
> > the order of 100s of KB).
> >
> > > Maybe I'm missing but not sure it's worth the complexity.
> >
> > Agreed. There's limited utility in finding 1 string inside another for
> > the current string representation. The code is still necessary to give
> > every string an offset. The code to find 1 string inside another isn't
> > that large nor that slow, so I kept it around.
>
> But my main concern is code complexity.  Although it's not very
> complex, it'd be better to start with something simple.  We can
> always add it back if needed. :)

Agreed. There is some minimum functionality to get some compression to
work and then things that will bring us to where we are in this patch.
I was thinking of the BigCString as a general purpose utility, hence
doing the string within a string offset finding. It is a win for just
1 string on x86 as in this patch today and not as useful as just
deduplicating strings (or renaming the topic of <arch>-metric to just
be metric). I could separate the offset within a string into a
separate patch if you think it is useful. I'd be tempted just to leave
it, the truly troublesome/brittle bit of code is the C string length
computation. Getting that wrong results in lots of empty fields.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > >
> > >
> > > > +      if pos != best_pos:
> > > > +        folded_strings[s[::-1]] = sorted_reversed_strings[best_pos][::-1]
> > > > +    # Compute reverse mappings for debugging.
> > > > +    fold_into_strings = collections.defaultdict(set)
> > > > +    for key, val in folded_strings.items():
> > > > +      if key != val:
> > > > +        fold_into_strings[val].add(key)
> > > > +    # big_string_offset is the current location within the C string
> > > > +    # being appended to - comments, etc. don't count. big_string is
> > > > +    # the string contents represented as a list. Strings are immutable
> > > > +    # in Python and so appending to one causes memory issues, while
> > > > +    # lists are mutable.
> > > > +    big_string_offset = 0
> > > > +    self.big_string = []
> > > > +    self.offsets = {}
> > > > +    # Emit all strings that aren't folded in a sorted manner.
> > > > +    for s in sorted(self.strings):
> > > > +      if s not in folded_strings:
> > > > +        self.offsets[s] = big_string_offset
> > > > +        self.big_string.append(f'/* offset={big_string_offset} */ "')
> > > > +        self.big_string.append(s)
> > > > +        self.big_string.append('"')
> > > > +        if s in fold_into_strings:
> > > > +          self.big_string.append(' /* also: ' + ', '.join(fold_into_strings[s]) + ' */')
> > > > +        self.big_string.append('\n')
> > > > +        big_string_offset += c_len(s)
> > > > +        continue
> > > > +    # Compute the offsets of the folded strings.
> > > > +    for s in folded_strings.keys():
> > > > +      assert s not in self.offsets
> > > > +      folded_s = folded_strings[s]
> > > > +      self.offsets[s] = self.offsets[folded_s] + c_len(folded_s) - c_len(s)
> > > > +
> > > > +_bcs = BigCString()
