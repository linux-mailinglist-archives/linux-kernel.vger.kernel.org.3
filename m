Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E654A55290B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbiFUBgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 21:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244545AbiFUBgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:36:20 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A6E1CB10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:36:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e63so10232574pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waymo.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vZ6F4wvpDGbWdv9LDQ/ImSRBscJ3ks5pTk2NeSqUUQw=;
        b=tJG880RA9r3Y4xwm+Il6qBFQ5sGJONzFwHJOvHSjt9EUe58fjyRvokq+3360x4fLNF
         VPWqi1ZwtRu3zjadlMB+qE7QoXLwbnroS7HqeI1bL5TUWPgZ1PEaMOlifwrDD+HfTplE
         S6b4Qiur8J8lGfSm6i0KqW2kfeX4n8t9Iy7PYnO6NEoEeg8eG5G0nXxg8SOSRrfU5wPX
         YaVf1xILZUfWPmsBWrIrmqOTnscBpOndXjZHLbNuyjtNBOa6dIP357EdGwVOQ1Y9TPRC
         PURHCWcOumCZVvhlmU8j9fKwAQsr4CUxcJGfg7YKAZdEzOOXOKF6pUeYjNtqc+RkB7xI
         Xlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vZ6F4wvpDGbWdv9LDQ/ImSRBscJ3ks5pTk2NeSqUUQw=;
        b=gP0Mivahtscv8cvA+R59gNhzXEwYcUU9LvQIc4/Jsje/Bv4o8XdoxK91t5OdIVwxd3
         xkllLSkkQe+y5tgwTs6xcJHfuU1AqWEsIOpIvgkP+1Hs79CTyqlpLnD/7v6Vvorxp297
         MkaDuBavuuuOqLsJ0a0Bvxp3D8Q688J0V71fBHT+aPFYtx2Nl/4+mVG0MPavpzR45GJA
         YEkfpcMnAPIOK3cLH5hbRWxg1eTSrv8UgZekZhly3i3jA1nwnL5iTafJc41fTziMTz6e
         INuDqjitgM+Nd7f1GxcxAPCzm93TIn02fjHxNBnGHmVBakklwBDwteX/J86yCluemRMS
         Ixcg==
X-Gm-Message-State: AJIora90utsH9DFNY/vjpg55HhcF58QpnuT0DYdcv2cYLzXgd8zlti8M
        388Cvzz75+/HGo/lnmtPslb/lX84JTZDgtN+UN9YzA==
X-Google-Smtp-Source: AGRyM1vo2+viWwqM95mm8E1n776io1sCuKmRDR4PjLs+kEY83xdRYdxsBIAlI4Xv7MYzTijsJFKJrRInYFfmwYhtOUY=
X-Received: by 2002:a63:a841:0:b0:40c:b1f6:a876 with SMTP id
 i1-20020a63a841000000b0040cb1f6a876mr7774889pgp.578.1655775378560; Mon, 20
 Jun 2022 18:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220620164953.1503934-1-rsilvera@google.com> <a651ca26-6aae-fe7f-66b1-18fdbad40f41@intel.com>
In-Reply-To: <a651ca26-6aae-fe7f-66b1-18fdbad40f41@intel.com>
Reply-To: rsilvera@waymo.com
From:   Raul Silvera <rsilvera@waymo.com>
Date:   Mon, 20 Jun 2022 18:35:52 -0700
Message-ID: <CA+PGoB_H2iKwvTA1xEGmyqccefipdrnS_GxZBixZTAe2bvkDrg@mail.gmail.com>
Subject: Re: [PATCH] perf: Adjust perf-inject output data offset for backward compatibility
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Colin Ian King <colin.king@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:54 AM Adrian Hunter <adrian.hunter@intel.com> wr=
ote:
>
> This looks too late since, although the header comes before the data,
> it also gets written afterwards (at_exit =3D=3D true).  It would be
> better if we could rely on header->data_offset at this point.
>

Thank you. You're right. We can rely on header->data_offset at this
point as it is
adjusted upfront in __cmd_inject. Will send an updated patch.

Ra=C3=BAl E. Silvera
Software Engineer
waymo.com
