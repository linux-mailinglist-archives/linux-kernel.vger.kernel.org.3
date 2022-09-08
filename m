Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5061A5B16D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiIHIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiIHIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:24:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E6DEC0;
        Thu,  8 Sep 2022 01:24:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n17-20020a05600c3b9100b003b3235574dbso749256wms.2;
        Thu, 08 Sep 2022 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=/ohG8DwSItaCcxoY9t3BLCfb93uhCkZwCq+xnGDP9xw=;
        b=bqMso4RQbyQNgYUzQ+4Fk4CQujHDZMJZEIazWNBBqm6nqaRQTwEKcVjipeg6l3pIhu
         KUw2ysMcisuVn97nTzRcaSgNllcVT9V4hTpIRmFC0j3Q4sqVY8oWyCJqhSw/5jySrQmb
         2dKnjeAIVdtbmEcJD3+GT3dqhiI6sWGZEJWgFj00T74Wj9jKrc1Vm9zDb+zf/utFUd0W
         zpKxx2omRme6eRaZc3Q3X0VmyyFwf+IJGvkoKxEAfhoO6Y6iqVBFYe9nqeQUmP6R+lDQ
         w7IDZzD+tjGXzkV3Y86F12C6gnLuOy5+/tNE5RgB3ue9qID/ur9+g8UuB7PQ1ZM84yXo
         XARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/ohG8DwSItaCcxoY9t3BLCfb93uhCkZwCq+xnGDP9xw=;
        b=CKGfuy/W3En2U4jdPsinmTNXzJRqIpDq4XYhuLRXlUWpOckcvZAUaxY4/EnGII4JdM
         9o3qbXE3w/X31FoA4u6AcbXF6OShnYxwkjphk/2qP+2uMDrGOmEO9weH+jogBDZCYsEr
         6SFRaTBisFLBHFT+74rFo7xGr9wZozhCFJzwUBi4W1h0Seur9693RoPDNVFJDXDJDnzE
         iWxTr6VxdQFKY3lFmpMGO+0McvBNZsqEljIr3iSVCjlPXse5/7Q8lz5rAg/nlkgLY75P
         SQ+R2WjCb7KS5XHN6TIzkc6PffWZuPWovkbVagNO+DbRPalRZAvVK1IIGZdi0584kQpX
         w1XA==
X-Gm-Message-State: ACgBeo3n0qvJrFQqdH6Eg17VC92nhy2vc9bAs9zCFjDUKbuZeVmtqzgT
        1GKVasg5fAR89PFXmg8wdTQ=
X-Google-Smtp-Source: AA6agR4/Pxrf1WQ9mp4qqlP31Iz19Bi0knkCR4tItgQutaY2U7Vd9pbxJcyfJSexsdl12TyhJ7Wj8Q==
X-Received: by 2002:a7b:ce10:0:b0:3a5:3f91:e2fb with SMTP id m16-20020a7bce10000000b003a53f91e2fbmr1472519wmc.138.1662625469786;
        Thu, 08 Sep 2022 01:24:29 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c3b8600b003a846a014c1sm1926257wms.23.2022.09.08.01.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:24:29 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 8 Sep 2022 10:24:27 +0200
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf script: Fix Cannot print 'iregs' field for hybrid
 systems
Message-ID: <Yxmmu6eyO/baR0Vo@krava>
References: <20220908070030.3455164-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908070030.3455164-1-zhengjun.xing@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:00:30PM +0800, zhengjun.xing@linux.intel.com wrote:
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> Commit b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to
> collect metadata records") adds a dummy event on hybrid systems to fix the
> symbol "unknown" issue when the workload is created in a P-core but runs
> on an E-core. The added dummy event will cause "perf script -F iregs" to
> fail. Dummy events do not have "iregs" attribute set, so when we do
> evsel__check_attr, the "iregs" attribute check will fail, so the issue
> happened.
> 
> The following commit [1] has fixed a similar issue by skipping the attr
> check for the dummy event because it does not have any samples anyway. It
> works okay for the normal mode, but the issue still happened when running
> the test in the pipe mode. In the pipe mode, it calls process_attr() which
> still checks the attr for the dummy event. This commit fixed the issue by
> skipping the attr check for the dummy event in the API evsel__check_attr,
> Otherwise, we have to patch everywhere when evsel__check_attr() is called.
> 
> Before:
> 
>  #./perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf script -F iregs |head -5
> Samples for 'dummy:HG' event do not have IREGS attribute set. Cannot print 'iregs' field.
> 0x120 [0x90]: failed to process type: 64
> 
> After:
> 
>  # ./perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf script -F iregs |head -5
>  ABI:2    CX:0x55b8efa87000    DX:0x55b8efa7e000    DI:0xffffba5e625efbb0    R8:0xffff90e51f8ae100
>  ABI:2    CX:0x7f1dae1e4000    DX:0xd0    DI:0xffff90e18c675ac0    R8:0x71
>  ABI:2    CX:0xcc0    DX:0x1    DI:0xffff90e199880240    R8:0x0
>  ABI:2    CX:0xffff90e180dd7500    DX:0xffff90e180dd7500    DI:0xffff90e180043500    R8:0x1
>  ABI:2    CX:0x50    DX:0xffff90e18c583bd0    DI:0xffff90e1998803c0    R8:0x58
> 
> [1]https://lore.kernel.org/lkml/20220831124041.219925-1-jolsa@kernel.org/
> 
> Fixes: b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to collect metadata records")
> 
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-script.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 585171479876..1a8790385eba 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -445,6 +445,9 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  	struct perf_event_attr *attr = &evsel->core.attr;
>  	bool allow_user_set;
>  
> +	if (evsel__is_dummy_event(evsel))
> +		return 0;
> +
>  	if (perf_header__has_feat(&session->header, HEADER_STAT))
>  		return 0;
>  
> -- 
> 2.25.1
> 
