Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9227150333D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiDPCtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiDPCtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:49:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BA9F59;
        Fri, 15 Apr 2022 19:46:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 11so6771666edw.0;
        Fri, 15 Apr 2022 19:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BB7JqP0IMspOiNPtVlkKz2TQYIOLmMUJSaWVZFfwwsk=;
        b=FTSjMdedlTHpjpaBmiowrdJqQOdk5PnHCUoQ0z9y9btrmozxk21CFf1ctaA1wN/l1U
         J6AUNpDVYoKLfI0EwZsDuePfxmzdqxFSoOGnCYO53hGTHZv9t3rYNSgxFthfExer9Aei
         kz9ybr830iPIQrRlzMuVb/AwJou+JoKRFnzlklNqZYoBaHxmT7UcQLD4xWnaoFwT1iP0
         z7QuRCRWEtaeJHiTa9fKtksuRpqUWufufFyWCgpUu9+OCKlYPaVwY5X3FUWYe/DcOG9u
         kW8OkmHRySVaDgNN/j5GvuTDgRElA4vljY027Z5ezft3lY8I4aU+TM9Z5sdfIe5xTwpT
         5aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BB7JqP0IMspOiNPtVlkKz2TQYIOLmMUJSaWVZFfwwsk=;
        b=IJQCL9KIhtA53lzm4dafOj8lJXQYOSQVErXE2IgeISg9KRrdC1ayEIjNzffVqEyzY0
         HZfJyWDsrvHKDt9CmC9+CFmxF9oca78bmguemGAvn5CJWa07jIE7MalWOrX9RhZ6O7O4
         Ko6lcFxxALFL/oGt9CXa9rK2B5tFrp/MEhdQ0vFR4oNCjfg6Ng5DyocldiZdELCFwYTm
         YEJeGN9SRN+S+GQF3gpfq4Uwsl2g606peqlHYxjaWrOJWP4pQDaWJZ7rOYiwPl2w0MCR
         bSA9t3NtaZKfYaM8XkQ7uPUlA/oeitwEQxp/mefVCfs1aPiS1nitPMx6zd7bjLZV7tHi
         wuZw==
X-Gm-Message-State: AOAM531jmcgC5X4qoaIT31VC+tA5/1FIrKkYRvPcALFYOdkKIOikMyMk
        x1lrmWCng6Rx6Ybc6fNY148=
X-Google-Smtp-Source: ABdhPJzgALX8qBpfCgXIoetMUkzbdqo/rgoL1gLeekTBHUkDx/L3I7E21koDur5nLC8yaCHwjUF4OA==
X-Received: by 2002:a05:6402:210:b0:41c:9ca7:7660 with SMTP id t16-20020a056402021000b0041c9ca77660mr1944732edv.145.1650077210700;
        Fri, 15 Apr 2022 19:46:50 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709063bc800b006e898cfd926sm2197718ejf.134.2022.04.15.19.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:46:50 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Add support for MSM8996 Pro
Date:   Sat, 16 Apr 2022 06:44:31 +0400
Message-Id: <20220416024431.82110-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220412191750.0C00DC385A1@smtp.kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <yassine.oudjana@gmail.com>

On Tue, 12 Apr 2022 12:17:48 -0700, Stephen Boyd wrote:
> Quoting Yassine Oudjana (2022-04-08 21:01:27)
> > MSM8996 Pro (also known as MSM8996SG) is a newer revision of MSM8996
> > with different CPU/CBF/GPU frequencies and CPR parameters. Its CBF clock
> > also has a different divisor.
> >
> > This series handles the difference in the CBF clock and adds a new DTSI for
> > MSM8996 Pro with CPU and GPU OPPs. It also removes reading msm-id from SMEM
> > in qcom-cpufreq-nvmem as it becomes no longer necessary with the introduction.
> > of a separate device tree. Separating MSM8996 and MSM8996 Pro will help with
> > implementing CBF scaling and CPR; as they have different CPR parameters
> > and CPU:CBF OPP mapping which is difficult to implement in the same cluster
> > OPP tables.
>
> Some of the patches are encrypted? Please resend.

Sorry about that, I had some issues with the SMTP bridge I use with Protonmail
and had to use the web client, which apparently did something funny.

I'll resend through a different provider with git send-email.

