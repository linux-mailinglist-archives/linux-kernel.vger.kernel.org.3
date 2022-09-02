Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD585AB8B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiIBTG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiIBTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:06:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BECCC0BE6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E50DB82D6B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 19:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A96AC433D7;
        Fri,  2 Sep 2022 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662145579;
        bh=k5wsC2EtA2qPdI2VARsKQScfF7UKJPtHLB+KhAUijSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SltpM44bF4EWEqGNxpLsa5nIijpVpuQpEjnSwVeBxnnB3rYIVHPAedLLhkHsvePub
         S7sLqD8q5fRmK58WrN825uY7e0c5e9bOK4wPkt9PxNJC5hF+9mjlf9XP53pUWxCU9E
         LfALBBgrFrVNjral1F7yJQ932wRDIJ1KhM1DlSIgtApksQYd0lL5WA7cXJlIGBLSyd
         7F6tY7b+AUIWMV0g1smcamqZt3CLa57qaJMsy1w8DHuplQmBnmoGqWqRzRJOO0CFbK
         pJs/VB91bfrHKUfVJ/asVUzGy8AUaEkssbKFtP1iLep6HxZ/OkVY7+HOdVEkIdG9/d
         m2LCsfHUUWP8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B9175404A1; Fri,  2 Sep 2022 16:06:16 -0300 (-03)
Date:   Fri, 2 Sep 2022 16:06:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] perf intel-pt: Support itrace option flag d+e to log
 on error
Message-ID: <YxJUKLJwOjH3MNqs@kernel.org>
References: <20220901110032.9226-1-adrian.hunter@intel.com>
 <20220901110032.9226-6-adrian.hunter@intel.com>
 <dadd6179-4867-211a-ad6e-30fcd66a8e0a@linux.intel.com>
 <1a7aaa51-1858-bb59-834c-7e8f6a58bc39@intel.com>
 <CAM9d7chiutXEZfpQbayJ3bgraLZ_YFGC15yDn7sQBT4asdEfjA@mail.gmail.com>
 <bf500303-394a-4806-361a-7cc559d80e98@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf500303-394a-4806-361a-7cc559d80e98@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 02, 2022 at 03:01:01PM +0300, Adrian Hunter escreveu:
> On 2/09/22 04:34, Namhyung Kim wrote:
> > On Thu, Sep 1, 2022 at 9:29 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 1/09/22 17:31, Andi Kleen wrote:
> >>>
> >>> On 9/1/2022 4:00 AM, Adrian Hunter wrote:
> > 
> > [SNIP]
> >>>> +
> >>>> +static void log_buf__dump(struct log_buf *b)
> >>>> +{
> >>>> +    if (!b->buf)
> >>>> +        return;
> >>>> +
> >>>> +    fflush(f);
> >>>> +    fprintf(b->backend, "Dumping debug log buffer (first line may be sliced)\n");
> >>>
> >>>
> >>> Should be easy to skip the first line, no?
> >>
> >> Not as easy as typing " (first line may be sliced)" ;-)
> >>
> >> Still not sure it is worth having the extra complication, but here
> >> is the change as a separate patch:
> >>
> >> From: Adrian Hunter <adrian.hunter@intel.com>
> >> Date: Thu, 1 Sep 2022 19:01:33 +0300
> >> Subject: [PATCH] perf intel-pt: Remove first line of log dumped on error
> >>
> >> Instead of printing "(first line may be sliced)", always remove the
> >> first line of the debug log when dumping on error.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  .../perf/util/intel-pt-decoder/intel-pt-log.c | 27 ++++++++++++++++---
> >>  1 file changed, 24 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
> >> index ea96dcae187a7..6cc465d1f7a9e 100644
> >> --- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
> >> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
> >> @@ -143,16 +143,37 @@ static FILE *log_buf__open(struct log_buf *b, FILE *backend, unsigned int sz)
> >>         return file;
> >>  }
> >>
> >> +static bool remove_first_line(const char **p, size_t *n)
> >> +{
> >> +       for (; *n && **p != '\n'; ++*p, --*n)
> >> +               ;
> >> +       if (*n) {
> >> +               *p += 1;
> >> +               *n -= 1;
> >> +               return true;
> >> +       }
> >> +       return false;
> >> +}
> >> +
> >> +static void write_lines(const char *p, size_t n, FILE *fp, bool *remove_first)
> >> +{
> >> +       if (*remove_first)
> >> +               *remove_first = !remove_first_line(&p, &n);
> >> +       fwrite(p, n, 1, fp);
> >> +}
> >> +
> >>  static void log_buf__dump(struct log_buf *b)
> >>  {
> >> +       bool remove_first = true;
> > 
> > Isn't it only required when the buf is wrapped?
> 
> Very true! Thanks for spotting that!
> 
> I will send a new version.

Ok, I'll remove the one I've been testing, please fix the problems below, found with several compilers/distros:

The 'struct log_buf' definition is coming after its usage on a static variable,
please move the variable to after the definition.

  80    56.88 ubuntu:22.10                  : FAIL gcc version 11.3.0 (Ubuntu 11.3.0-5ubuntu1) 
    util/intel-pt-decoder/intel-pt-log.c:30:23: error: tentative definition of variable with internal linkage has incomplete non-array type 'struct log_buf' [-Werror,-Wtentative-definition-incomplete-type]
    static struct log_buf log_buf;
                          ^
    util/intel-pt-decoder/intel-pt-log.c:30:15: note: forward declaration of 'struct log_buf'
    static struct log_buf log_buf;
                  ^
    1 error generated.
    error: unknown warning option '-Wno-format-overflow'; did you mean '-Wno-shift-overflow'? [-Werror,-Wunknown-warning-option]
    make[4]: *** [/git/perf-6.0.0-rc3/tools/build/Makefile.build:139: intel-pt-decoder] Error 2
    make[3]: *** [/git/perf-6.0.0-rc3/tools/build/Makefile.build:139: util] Error 2


This one also appeared in some builds, just as a warning:

dlfilters/dlfilter-show-cycles.c: In function 'print_vals':
dlfilters/dlfilter-show-cycles.c:101:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
  101 |   printf("%10llu %10llu ", cycles, delta);
      |           ~~~~~^           ~~~~~~
      |                |           |
      |                |           __u64 {aka long unsigned int}
      |                long long unsigned int
      |           %10lu
dlfilters/dlfilter-show-cycles.c:101:23: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
  101 |   printf("%10llu %10llu ", cycles, delta);
      |                  ~~~~~^            ~~~~~
      |                       |            |
      |                       |            __u64 {aka long unsigned int}
      |                       long long unsigned int
      |                  %10lu
dlfilters/dlfilter-show-cycles.c:103:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
  103 |   printf("%10llu %10s ", cycles, "");
      |           ~~~~~^         ~~~~~~
      |                |         |
      |                |         __u64 {aka long unsigned int}
      |                long long unsigned int
      |           %10lu


