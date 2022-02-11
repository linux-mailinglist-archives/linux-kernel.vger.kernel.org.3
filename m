Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830D04B28FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351344AbiBKPUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:20:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243420AbiBKPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:20:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD0CE1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:20:38 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id eg42so16951579edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A+pYq3gAvDRIBXzI8fOr1NWPq9Ez2hj6zeRc/MxGX5U=;
        b=XmIhBe0BW8s4Ne/ySLnWsQWfdi8M/ADrEQJrnY9xyXzT/oeRrWbnAaaPbsZsd/Thon
         ApfBEUIWpk/fY9kPrV0o6nd6jPQLWWBw5Kb5l53H/Ue7VgF97ZNjLGIObcxM8mdRlH97
         wGJD4a9OGsNDKB7gVIjnbWaGxtBmyq5EvSVmighL+7lYdWSu/0unIakZ+57yS2ZcwfD7
         kKRbwxmymXMhHSr9ppVsNcYIuudAD74mlMib6g0ZsTWNBoDOYCEPU5m5hlzFfOLeZvW8
         4m965OzMozN2Uk8O9QpZQ3AyuQPrtCFir0JktrAdzv1JLXdowNN1TR1nVn7criYg/kPL
         TOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A+pYq3gAvDRIBXzI8fOr1NWPq9Ez2hj6zeRc/MxGX5U=;
        b=KowyQyAggdFc0PLYEuK8DlmpaCfpTR8e6ix+rqAActly6PGIxf3c4BJDxc5ZoaoxkY
         9d6ufCLfRe8h845KvfBOQGtzZQgY504H6TxoUT/dVAW2YEm4AiYcccLXG7yeaBDGxGNM
         3ES+afOKHgKETK2rJMZU6CeF8iNwXPoRc/XYFHOU0ry3LC6WRc/idjeG3rJ33Y/O2jbN
         Qqlt0VMjitqFyVA21aRgcN5La7xBw2YFtdpsDl+5m2+ket1g4G9c3C1HmN2c7JjnuE9s
         iZC0p05DaaALNl56708eERMuJBmoeGanrknqWTB4zlNrEtgLFIXzleeN2Rjrm9c5jjQB
         U/5w==
X-Gm-Message-State: AOAM530HdKQNKEpcB3xts3Eua9GxB3iwlEDUgONKyqojGgCZuBrL9W//
        VY3aBq1v/EprsFf2H1ewohBCKrGFy4INd9y+Qys=
X-Google-Smtp-Source: ABdhPJwszJf8Sr9G+6mqytFUQlGUOUee0R8RNKRV/mCvOx3IsJhsrx0miYsUPgVbSRRKz/HPV1lxVg==
X-Received: by 2002:a05:6402:2284:: with SMTP id cw4mr2458951edb.436.1644592836609;
        Fri, 11 Feb 2022 07:20:36 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id z8sm7909941ejc.151.2022.02.11.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 07:20:35 -0800 (PST)
Date:   Fri, 11 Feb 2022 23:20:26 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: cs-etm: No-op refactor of synth opt usage
Message-ID: <20220211152026.GC475776@leoy-ThinkPad-X240s>
References: <20220210200620.1227232-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210200620.1227232-1-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 08:06:19PM +0000, James Clark wrote:
> sample_branches and sample_instructions are already saved in the
> synth_opts struct. Other usages like synth_opts.last_branch don't save
> a value, so make this more consistent by always going through synth_opts
> and not saving duplicate values.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

The patch looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
