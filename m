Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F758998D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiHDIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiHDIzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:55:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74E210E2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:55:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e13so5503035edj.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GclRhFTUyNB2tgBNOlgejkTwvXUteAeZEXRh3F16zHo=;
        b=VbEkzflj5QfHqlpWU1dZGrjIo5C+bO7jYt3m6aGPVcFC0g89cUV/v36vpWr4Hg3Dwo
         wqBuG2f15p9BO7BJnQLVAjhqumK7MPtyCj6nA0avInp2vqsjqNhqZbsuOwOB39ZUIOMx
         6H4lM0qPS/R4zjaQUmV0iLCPkrk9ZQtaMhQ7+zKbeKH6DQ/15kc3oK6qeIUOsbCCVlJe
         yad7dcEt1aGIITDh+cM/2cya5AAZWshwX13FdPI98u6nCmXadGZy8sxY12Y0c1sqL0rT
         Q13ZlDJkxDhY8cBoMk16uhMtogDJm0p6ra/OqRS8lJp1yoyNh1FCzRk57TfkkKW8NqaZ
         cQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GclRhFTUyNB2tgBNOlgejkTwvXUteAeZEXRh3F16zHo=;
        b=xorVYHoXKTuqbgdWYDia0J8PSTIVLrw+P+3ns+9zYLnkhs9Vz1/ehWik1uhMEhne2E
         YcdSRuAyaiHlw5HWShrShV9DhiJtUyFw5I7B2TyB6dwl+WFGnRAHwvmK5xx4Cbjf9P0Z
         taof48LkR8oUEz0qu3BlFzDJsWtcO9dRdXUJzMkp/Knf7GjDsAluUD+imQCGbqsc3bB+
         eVZ4KSESP+FExW7YaYuyIFveUl1bcBCfyZzJfJE2Q497I/Y1wW8CxidS0Q6bh2yXCHAU
         xqg8n/BuSl6pc1qLhJy7t9AymvXwdQuHXueNQ+l7sqxHl9FXgtpoV/qCupAqFDHkbQoS
         X9qg==
X-Gm-Message-State: ACgBeo2wsYN3mCOH61982duBSytT+InO2hkYnxIwWdagldhTI8NN54on
        gcCoQrkiVcpYMykh+ukfb0c=
X-Google-Smtp-Source: AA6agR74HlajCbQv9tj5xJ97SOm4pcdlgBeKH3VnBGfy2NRx7+zNnfOEhWWPJaEt9BFC6DDrR2DNfA==
X-Received: by 2002:a05:6402:3509:b0:43b:f09d:6517 with SMTP id b9-20020a056402350900b0043bf09d6517mr1043025edd.66.1659603315561;
        Thu, 04 Aug 2022 01:55:15 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id s9-20020a056402164900b0043cc66d7accsm342667edx.36.2022.08.04.01.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 01:55:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 4 Aug 2022 10:55:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Message-ID: <YuuJcFkUVUfDvcYB@gmail.com>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com>
 <YufUj4klPKmKNj26@gmail.com>
 <82620137-5aa5-6cf1-f7aa-6a298e2f7856@oracle.com>
 <Yuo9Y4KvQQvvLC/r@gmail.com>
 <a9d666ae-0aa4-d79e-aac2-02573577b530@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d666ae-0aa4-d79e-aac2-02573577b530@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Libo Chen <libo.chen@oracle.com> wrote:

> Oh yes, I have no issue with holding the patch back until the regression 
> is fully understood. I was just a little confused on your reference to 
> Mel's comments. [...]

Yeah, that was just me getting confused about which change Mel was 
referring to, as I was looking for external confirmation saying what I was 
thinking about the patch: in_task()/in_interrupt() heuristics rarely do 
well. ;-)

> Anyway, I will post my investigation soon.

Thx - and measurements will always be able to override any negative 
expectations of mine, so my comments weren't a NAK.

Thanks,

	Ingo
