Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3250C5808D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiGZAzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZAz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:55:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A20252BD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:55:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id oy13so23516591ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ILf1h5u1nM9ffsTeHOVxXz+E3MwVXVmsI4fPGP1KKw=;
        b=zPFG/2GOaR/DN0ilqBdjYm0XIP9wkDh4fBPTbZ8eGcFFCaO6w99PdaXUgbF+Ns2gg5
         kaXL+NjmkYRGrg/FOE2KS8FDCWDJW3Lun09UkE/8CG0Vj7NQ+XMg+Ut8ki6Iqt7Gr/6U
         s6Xa0Sr/dGNR/mSZk4ZHJaBSTVywrxfhaKYrJJ7qaEG4pegFYCzRvuyDJkg8G8hYakb7
         P4AdfTTKgBCjr4aJCHdRYNWKXKvopVoM1oDSXuQxnAejbX+yFYVyRFj12+KkFuQuQINH
         zA0PWQxNmiZ+cIbDBztMJ9O8Edin1hPjsqiVt4uEnVtxDOLHxlbk9eYlkRRQhBU2s4bH
         a1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ILf1h5u1nM9ffsTeHOVxXz+E3MwVXVmsI4fPGP1KKw=;
        b=qpbbgDpXId4HCpDqLAZ5/YudPUGAgOah6InNmP52BEpw1AA5O8O9umvdzWRXFar5Jp
         q381sqtNaffb1Pa2XNNl7m08vS2s6KFP2WLVV6d8R5mGEBMfwcgdRb+lH6v0O/z+O5bB
         Ay0suYHJZixuL2/hM1Cvh6aupUF7DIMk0GzC7FmCxBPVNS6wO54V92WUMEKejWerBYva
         g8bzl30FT+N9tzdlIbaZI5XLPe1eJvepxv2/64+7g6i5U1IlLIOM+g+YweyXjF+vJ87C
         WVX6pKqBrp4d6SGXN93yu4W0IoFzoijebXAWudLz9S2CX47BXrdnXM1vJYkJiw3bDrtu
         pLEg==
X-Gm-Message-State: AJIora/IGRLWn1NeZ5NdILRfkYL9SReyhUXYLgVKack1aHpNfoCsRAaY
        jbC0Z6JOdHdBN16/8nieVbITOg==
X-Google-Smtp-Source: AGRyM1sreX/ffzyrEmA/aUBlxPJLFoGG39ka/uwfVU+GJRvz7mCLAzjPa4nOFzacaioGLh8ukPH+Zw==
X-Received: by 2002:a17:906:8477:b0:72b:3e65:55c5 with SMTP id hx23-20020a170906847700b0072b3e6555c5mr11706963ejc.255.1658796927399;
        Mon, 25 Jul 2022 17:55:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.97.243])
        by smtp.gmail.com with ESMTPSA id g20-20020a17090669d400b00727c6da69besm5948091ejs.38.2022.07.25.17.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 17:55:27 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:55:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] perf symbol: Minor fixing
Message-ID: <20220726005522.GB36862@leoy-ThinkPad-X240s>
References: <20220724060013.171050-1-leo.yan@linaro.org>
 <CAM9d7chkrqr4P5AMRYw48JcDNsrGSMRKhwyamY5NAWbuF6jttw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chkrqr4P5AMRYw48JcDNsrGSMRKhwyamY5NAWbuF6jttw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 09:54:21AM -0700, Namhyung Kim wrote:

[...]

> > This patch set contains two minor fixing for parsing symbols.

> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for reviewing, Namhyung.

Leo
