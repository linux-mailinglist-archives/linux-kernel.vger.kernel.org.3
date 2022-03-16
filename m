Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4294DAC58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354492AbiCPIVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbiCPIVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:21:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C163529
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:19:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r6so1813131wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eB3Qa08xe5yQrsvIPU/lEi8D81kJpMa1SMOqC0T8EyI=;
        b=KMgh5POQkPgJPtD8jFWJk5a5SH1QA1cwyg8ql04PZnvTkkU9yfAkqlCYaHSd54Y2XE
         rti8sLyNq1VbL0MuuSYl/vkm89LJ5DtvjC+kxhbnWEXPXcD7g4JH6Bmic2LL5B7Y7agt
         6RCrLY2AdJj8OYIKfqFw2Up9M4j/SsahasYIdoouI8wONF5uoB9W/uWNpqRLiLz17BnX
         eo01QqcerJRs8lY2vWi2LlQ1h8aSDbXiiYvr1CMNRG4ruasA5hnjar+cU4qOc7n/4Rqe
         KQ+ArjwSBaAkZsZmWgmngAg6TfN7KamEue76wnY4vzfUXnX0QdZ5eK0B2cpcGlLSQixQ
         qoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eB3Qa08xe5yQrsvIPU/lEi8D81kJpMa1SMOqC0T8EyI=;
        b=n1j8XBerOs/w2YjRyhwyNVoRnr+3E6FRuDcQQiVXCQAOb0DnP0dGFhXec2DtFVeemc
         wJrnJUki46fNHm45EyBM3OSKJr+1GsJyEcHT/We2r7Ph6cbTKkdx5Gur9BgBzaGjcHDs
         BpvCxSZYdrcT8osjxqXsaDGgYnEx8AITA3jB5N/WsdiWczNJX25mMeYb6eZ04xvx0Trg
         m965Iec7SltE2Q31jyLJFu3P4g3JOzmV9L9oecI/QXGhzVW7vBfmLkjBIt02lUKNKIvg
         NjbJ+ty0rLSNro4Pa38oboVh1HcSeiPewznrWHrrll/oIqZp0cfYLLrEeJSFAQ0vIcWs
         KOmw==
X-Gm-Message-State: AOAM530pTnJCoHmnB5EMfnm3s8eY/hj2R4MlhoLCBfHKF1jPXDoXYFxw
        us62WXykL8oHlV+kSfeaw0axww==
X-Google-Smtp-Source: ABdhPJwrWBZdB7018LH8H2J5v0WSvKptIeZpUnF7AAPZMrxFp93OwZ6yln++zheKXJ8gFgNLU75vKw==
X-Received: by 2002:a05:6000:1868:b0:203:732e:6a96 with SMTP id d8-20020a056000186800b00203732e6a96mr23454156wri.39.1647418788344;
        Wed, 16 Mar 2022 01:19:48 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm1616426wri.0.2022.03.16.01.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:19:47 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:19:44 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <YjGdoGy4Z2UUG9S9@google.com>
References: <20220310093844.982656-1-sesse@google.com>
 <586de5fc-858b-2693-1986-5c77e8c0e3d0@intel.com>
 <YiuKAk7SaXP7B7Ee@google.com>
 <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
 <YjBnet2813sEGjZY@google.com>
 <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
 <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
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

On Tue, Mar 15, 2022 at 10:11:54PM +0200, Adrian Hunter wrote:
> Sorry, my first suggestion has issues, but the second is better.

I tried your second one, but can't see much difference. The original and
your patched version still differ by a lot, and I still see various
non-branch instructions getting very tiny fractions. (PSB packets
_might_ be it, as there are ~1000 of them in the 165M-cycle trace.)

I guess the good news is that the perf report coming out of your version
looks more likely to me; I have some functions that are around 1% that
shouldn't intuitively be that much (and, if I write some Perl to sum up
the cycles from the IPC lines in perf script, are more around 0.1%).
So perhaps we should stop chasing the difference? I don't know.

/* Steinar */
