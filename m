Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADBF5ADE91
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 06:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiIFEbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 00:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiIFEbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:31:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A8E5C354
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 21:31:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o15-20020a17090a3d4f00b002004ed4d77eso4715981pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 21:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TwGXpdoM7OeNK0fwpCzIsVwT/Hz9htnpHrj7Szi0kOw=;
        b=d/EC63uSRlXFOahRYs23o5mK5WCmA9ooP5KLOAGEr87tn/jfpYPQwjYIBMQfiSLDf0
         otaZpiAobLOglQuo7vZrPd7ULO2/oAagFZS+c85Wi9Bju72+8yoXbXjyN/ckgHyFBavx
         NxCsLqAe2QetFYwFOKmnrzVF3Jnw+qmrTZvERRoDwcoXQOHWqcSR2T23gO/+7LohA4zt
         eun63PhPAEqzvtYK4VxsnBWahAIHAnWxMbP9601ACSVzeS0uk4LBIGWiaVK59rrhpffp
         01AZjHHsOR/e/QQIVvn5arsomOBKYl9W5xdO2VwOkD4pO47aKl8Mf72fIz02atEgPdSy
         pidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TwGXpdoM7OeNK0fwpCzIsVwT/Hz9htnpHrj7Szi0kOw=;
        b=DMfowNFILUx2XWTJyQOA62yCi9W6PWXNp7R4mvdUPTzcBj4jbG4HeeAr4ketCJ1rF4
         uYIQke7OB2UgRPFPFHIY8yEmWMRtU5JytTYs64EsINeKyl8W7qGYSB4L+k6S8M4tC6fL
         fdhJGAM26emxPv20rvmfShoOYeAOSQUqy+Km7qKYvWNitdrVmoZvPPBx6moSOgtgLz+l
         NgcqE2mt6D6LkUQmJM0yQgrUzJLmxTjsS8FR4PSI3I4oArtLDQ52oukDmqSUqXl3PH0F
         J+blUroqMMiz2RSiCJZ5fCPB2UjVZlQCaeTHwf6f9wJm3xbgpsLNCb4FmGWLNqorEnfE
         u98Q==
X-Gm-Message-State: ACgBeo0f9kPUbCqUgi6OzL7bYuMqJ+r8s9UJYJnTKPOSRureTl0TGsAh
        ISWiA35YXc9ebK2RT3QWRikW+g==
X-Google-Smtp-Source: AA6agR7su2KTPdKO6Eb9JV1SS/P9HnqflAm/xsS4Yr9pnVIwnPou3W4tzevu/rux9yHXyTRNKIlOlQ==
X-Received: by 2002:a17:903:291:b0:172:ba83:71a8 with SMTP id j17-20020a170903029100b00172ba8371a8mr54066240plr.65.1662438707776;
        Mon, 05 Sep 2022 21:31:47 -0700 (PDT)
Received: from leoy-huanghe.lan ([204.124.182.10])
        by smtp.gmail.com with ESMTPSA id j13-20020a63ec0d000000b004340d105fd4sm5271356pgh.21.2022.09.05.21.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:31:47 -0700 (PDT)
Date:   Tue, 6 Sep 2022 12:31:42 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf c2c: Prevent potential memory leak in
 c2c_he_zalloc
Message-ID: <YxbNLphbuGjCezww@leoy-huanghe.lan>
References: <20220906032906.21395-1-shangxiaojing@huawei.com>
 <20220906032906.21395-4-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906032906.21395-4-shangxiaojing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:29:06AM +0800, Shang XiaoJing wrote:
> Free allocated resources when zalloc is failed for members in c2c_he, to
> prevent potential memory leak in c2c_he_zalloc.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
