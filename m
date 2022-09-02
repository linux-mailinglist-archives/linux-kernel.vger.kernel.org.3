Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC465AA51E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiIBBeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBBeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:34:09 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B910CA7A8A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:34:08 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11f4e634072so1423379fac.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 18:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ki23OQtFQrTAglGOpw8HcotZCRLZ/PqH8DqT5PWCgGM=;
        b=6qnN9/eyw4E8KFNa49jk8WDg8vwsDy21261hlNC81G7gNT1f/vjyS76C+77EXOOoVI
         yBMkDdYzbihIt2b3LK51BsoJgTvvIX9rjFQqSJgLEzKkTa1M3UaoTn7cL/oFDgKXEI/u
         YDlT9D3+FeKve5zjNSsgpNkAgoUS2d2WKSydaWdKuZaKlSoC40j9WrBjbbNcbDNDM4yM
         xcBbG+lZe3je/8KAK1XUqIgKlLmJAi14BIJSiEn4kVTihjag1nM1mtpv8/UlyLCq6yRa
         rUCrlawACOvC+H3bc3tT8t+wyYLWJQV8YWhS+svKTkVAeRs6cBk46oKTuoZ2ujRTAcvI
         BOAw==
X-Gm-Message-State: ACgBeo0ahjsdQxnV2t2WKF63rV/Ixufqj4LRgb9gav/FZTrEX6f4Dit1
        ITLDrH+Z5DdxbPIgAuXc3NNC0HuoLXowQdBFlQF55+R3
X-Google-Smtp-Source: AA6agR43EWIn3oUmnNtaR41mP1SSiJ9KPrLMQYOI9jQW5v6h3G1LuPJ3cmxcSJWoodA92pBmn7tnJJ1uz97bY647ZNA=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr1081287oab.92.1662082448032; Thu, 01
 Sep 2022 18:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220901110032.9226-1-adrian.hunter@intel.com>
 <20220901110032.9226-6-adrian.hunter@intel.com> <dadd6179-4867-211a-ad6e-30fcd66a8e0a@linux.intel.com>
 <1a7aaa51-1858-bb59-834c-7e8f6a58bc39@intel.com>
In-Reply-To: <1a7aaa51-1858-bb59-834c-7e8f6a58bc39@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Sep 2022 18:34:00 -0700
Message-ID: <CAM9d7chiutXEZfpQbayJ3bgraLZ_YFGC15yDn7sQBT4asdEfjA@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf intel-pt: Support itrace option flag d+e to log
 on error
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 9:29 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 1/09/22 17:31, Andi Kleen wrote:
> >
> > On 9/1/2022 4:00 AM, Adrian Hunter wrote:

[SNIP]
> >> +
> >> +static void log_buf__dump(struct log_buf *b)
> >> +{
> >> +    if (!b->buf)
> >> +        return;
> >> +
> >> +    fflush(f);
> >> +    fprintf(b->backend, "Dumping debug log buffer (first line may be sliced)\n");
> >
> >
> > Should be easy to skip the first line, no?
>
> Not as easy as typing " (first line may be sliced)" ;-)
>
> Still not sure it is worth having the extra complication, but here
> is the change as a separate patch:
>
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Thu, 1 Sep 2022 19:01:33 +0300
> Subject: [PATCH] perf intel-pt: Remove first line of log dumped on error
>
> Instead of printing "(first line may be sliced)", always remove the
> first line of the debug log when dumping on error.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../perf/util/intel-pt-decoder/intel-pt-log.c | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
> index ea96dcae187a7..6cc465d1f7a9e 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
> @@ -143,16 +143,37 @@ static FILE *log_buf__open(struct log_buf *b, FILE *backend, unsigned int sz)
>         return file;
>  }
>
> +static bool remove_first_line(const char **p, size_t *n)
> +{
> +       for (; *n && **p != '\n'; ++*p, --*n)
> +               ;
> +       if (*n) {
> +               *p += 1;
> +               *n -= 1;
> +               return true;
> +       }
> +       return false;
> +}
> +
> +static void write_lines(const char *p, size_t n, FILE *fp, bool *remove_first)
> +{
> +       if (*remove_first)
> +               *remove_first = !remove_first_line(&p, &n);
> +       fwrite(p, n, 1, fp);
> +}
> +
>  static void log_buf__dump(struct log_buf *b)
>  {
> +       bool remove_first = true;

Isn't it only required when the buf is wrapped?

Thanks,
Namhyung


> +
>         if (!b->buf)
>                 return;
>
>         fflush(f);
> -       fprintf(b->backend, "Dumping debug log buffer (first line may be sliced)\n");
> +       fprintf(b->backend, "Dumping debug log buffer\n");
>         if (b->wrapped)
> -               fwrite(b->buf + b->head, b->buf_sz - b->head, 1, b->backend);
> -       fwrite(b->buf, b->head, 1, b->backend);
> +               write_lines(b->buf + b->head, b->buf_sz - b->head, b->backend, &remove_first);
> +       write_lines(b->buf, b->head, b->backend, &remove_first);
>         fprintf(b->backend, "End of debug log buffer dump\n");
>
>         b->head = 0;
> --
> 2.34.1
>
