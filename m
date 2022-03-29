Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853144EAD36
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiC2MdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiC2MdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:33:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093AB5E15A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:31:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i4so5750292wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y9RUNc9u4NDcWzkzWpNKYsTxGVbukHkl4DrmNzDmOrM=;
        b=hlBOatvIQkfNLpHHQsqkeaqrF/vl5iO2zvTCN65flMcbf741w5RUPcJZpqNmzIqriI
         SsPAeScVhnDBFnt1AGXNEH5ugBtcSohfRpJyNFkpHSfeRBpSULLaclDOH/bzjt5ou+Q0
         Qzmx25AMCN8bjeowkUU/mfrMZ6Scb8XW4lzm6SaK7QXadh7pb3Hm0lCm8Aa3Ezwy6Pjo
         n2I2lYJ1wr+JC0NXQpfnrLRDDnw5Rl9KRh6Y0+OcJ307B79ikNOaPLv2/CzZVFTEi8Ru
         IxiEf2TNJbt1f5oeUpPMPF9gy9uVwsVGxDG4jq1mRd11aXNsUS9tfOa7vus37KGgrP8L
         ZMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y9RUNc9u4NDcWzkzWpNKYsTxGVbukHkl4DrmNzDmOrM=;
        b=UlB/ox3ySFY8wuZdDbsJt5UChv2pdKI3p8odCKOSi0/H2A48fxKh/o3L+uyLHE8LDm
         mz3ar9r0+rIN5i1oLDTA6+eVsnUSe9+3NWLr+0iKFa95pGu3IyoPCgM3XURdYcVHaVSD
         HaKmKSRKdq1cdqyNARTE7CyR3gYyBRfdsp1g8hGA5F4M1SNwt9WXZ4w6Xu65v4lO83OJ
         fOb3TAF+qZFVUdJjp99CVqExw7naAm+7FBCJde5yS4Rie5Xge8EQJd0FKjDICBawJDID
         Ax4FIRw8IohW9A/pArunvlngLB+DTg6veXGkSvh87c1FeG20S1eWPDD/5RrX0MtjDK6n
         pvZw==
X-Gm-Message-State: AOAM533W9zFvLrSboNTp0u2TEaoQQTQelTN2W7xrB9iWj/Ipnmm6ZJz2
        94V1W/yiqPiUsSQJIZMP8f/1rQ==
X-Google-Smtp-Source: ABdhPJy72PAhTXZFXupmbBsCmVeopApvYCfXr8IgWNONOJ/JYSPSNiev16r0QIGal9vCCZsc/AI4yA==
X-Received: by 2002:adf:e346:0:b0:205:97d0:50db with SMTP id n6-20020adfe346000000b0020597d050dbmr28982595wrj.257.1648557079428;
        Tue, 29 Mar 2022 05:31:19 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id m2-20020a1c2602000000b0038ca9ffac53sm2136981wmm.11.2022.03.29.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 05:31:18 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:31:14 +0200
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        He Kuang <hekuang@huawei.com>
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <YkL8EpWaeZ1US8t2@google.com>
References: <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
 <YjHfGrZovk3N/H0f@google.com>
 <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
 <YjhUjotmo+kYvoNP@google.com>
 <ffa56520-09b5-9c5d-7733-6767d2f8e350@intel.com>
 <YjiuoEUL6jH32cBi@google.com>
 <Yjm5stBpRC0g4G8s@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjm5stBpRC0g4G8s@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 12:57:38PM +0100, Steinar H. Gunderson wrote:
> and this is evidently fatal. So for whatever reason, the sample address
> is attributed to some symbol, and that symbol is assumed to have a
> single range (is this even necessarily true?), we refuse the event,
> and then we fail the entire report. (It doesn't happen with --stdio,
> though!)

I think I traced this. The basic issue is this routine, which compares
two symbols (to see if they should be combined for the sake of perf
report):

  int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
  {
          if (!sym_l || !sym_r)
                  return cmp_null(sym_l, sym_r);

          if (sym_l == sym_r)
                  return 0;

          if (sym_l->inlined || sym_r->inlined) {
                  int ret = strcmp(sym_l->name, sym_r->name);

                  if (ret)
                          return ret;
                  if ((sym_l->start <= sym_r->end) && (sym_l->end >= sym_r->start))
                          return 0;
          }

          if (sym_l->start != sym_r->start)
                  return (int64_t)(sym_r->start - sym_l->start);

          return (int64_t)(sym_r->end - sym_l->end);
  }

The problem is that part comparing sym_l->start and sym_r->end. I'm not
entirely sure what the logic here is, but it seems to me that the
intention is that if sym_l is a subset of sym_r, it collapses them.
However, it seems to assume that [start,end] is inclusive, whereas it is
generally [start,end) in later code. This means that if you have e.g.
a symbol [0x1000,0x1010) which is then inlined as the very first thing
in the adjacent function [0x1010,0x1030) (say, sym_r is the inlined
symbol [0x1010,0x1020)), _sort__sym_cmp will indeed collapse them.
This causes the ERANGE problem later, as you can have 0x1005 being
mapped to a hist_entry correpsonding to the symbol [0x1010,0x1030).
It seems this logic was indeed added to fix ERANGE problems in 2019
(see 7346195e8), but it is seemingly incomplete.

If I change <= to < and >= to >, it stops erroring out; however, I'm
still not sure whether this is actually right. Doesn't the collapsing
then depend on what order the entries happen to be added in, ie.,
whether the larger symbol comes first or last?

/* Steinar */
