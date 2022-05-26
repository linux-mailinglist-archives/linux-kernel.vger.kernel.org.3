Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5EE535111
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbiEZOzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiEZOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:55:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5A6004A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:55:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o10-20020a17090a4e8a00b001df2fcdc165so4655928pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j5JOHDXUI7FQ8JXc4lii8SXeiFfUzVXvQhcvWoaLXbY=;
        b=wvUwJIxJ8EzyTbR5AOM0+Jfw4VwKYsR8I2VaYthXdLN6jgv9f438bZevsDXKds0eTM
         8OUkxIKITmmEyRQtAL1U09ntB0NEjP9OCO9oLzLx64aV3B/2sH1CzofNMwwnsKqA8lZ3
         4cE4aIvo4MBVN6bqDiQBOL6sNPShYPnoqgG9E6XyqSCPk7O20+shJJ/hWW7tSReJWXDx
         zM1lx/5tmTeEmfXaZ9q/Cexu7b+6EcY15O1KfiDdlQEB4L5Msn70IKkjuSosuCtreX5q
         Kvl279/jNPkDPQd8OcAFkP0/jxX/PNo6il3VdB6FwDrkETaWNwnYg4hvGnTD7pmccTnr
         O/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j5JOHDXUI7FQ8JXc4lii8SXeiFfUzVXvQhcvWoaLXbY=;
        b=EZouXHMPlq6bILHWH619A9fDS/eMzIbsPLuGDQaAO7KxpDGD7dhacNwNIUKharlgdw
         +lBHZnWB45gew0mJE4dCz5PsJIG/njAi3OFV9wVahPwjV5B2J0T+CT1/t95KjQVTyhYm
         BQKuIBGz+t8wW1lxUopdWm2AtWl3dXd+i1YvHR+U+PLwyePf3d7Mx2ZfY6j335h8d4Ta
         L3FCTyRUPAF/D2zSo+pgdsGca3tD15auYXYazUJZDTOL38f1qSQkLumsDeDW1dAfjHgC
         MSNFsX3b2xnn2fSQh+t5YT9CcrEHVg2l5ucRaN7atwrgoYbY6+p0Z8QQgUXw0bI2skaz
         crNA==
X-Gm-Message-State: AOAM53134Gr5q5Gku6TspE0usg1rxkRGR+c+bqyNek1yyuDDT06rlk9D
        xAYxUTQiiwsQ3dV+Ue6+Qk0kHg==
X-Google-Smtp-Source: ABdhPJxkxE65mjMHVy0QbdI+2D7itKo338sypKD5ahEJqg2dVLkjkGQeaDMhsHUj+4CTX6Uat3Orcw==
X-Received: by 2002:a17:903:244c:b0:162:4b19:a0e7 with SMTP id l12-20020a170903244c00b001624b19a0e7mr12637690pls.44.1653576947031;
        Thu, 26 May 2022 07:55:47 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a2a8200b001d92e2e5694sm3875763pjd.1.2022.05.26.07.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:55:46 -0700 (PDT)
Date:   Thu, 26 May 2022 22:55:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf c2c: Use stdio interface if slang is not
 supported
Message-ID: <20220526145540.GD795802@leoy-ThinkPad-X240s>
References: <20220526143917.607928-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526143917.607928-1-leo.yan@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:39:17PM +0800, Leo Yan wrote:
> If slang lib is not installed on the system, perf c2c tool disables
> TUI mode and roll back to use stdio mode;  but the flag 'c2c.use_stdio'
> is missed to set true and thus it wrongly applies UI quirks in the
> function ui_quirks().

Have sent out v2 for adding fixes and reported tags.  Sorry for
spamming.

Leo
