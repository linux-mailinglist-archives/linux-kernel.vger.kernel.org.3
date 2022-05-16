Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11A9527C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiEPDQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiEPDQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:16:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072E711C0F;
        Sun, 15 May 2022 20:16:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so13089965pjq.2;
        Sun, 15 May 2022 20:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=Hmv8s3pg0s+t1LiaHpZrqkhy3HWwUgg1fDUaxrSwS08=;
        b=Irzlzcr3mwoYbc31kXoQqhC+sCDPEZ5cCZP2+CiteYTXqFoaRIrSKSI2fWPdQKyiro
         08Y50UgI0J1MSuQiLJZ4jjsJwWdCjytqtSnavtjh0nJ1UYCoeljxuGrkwFU6WMlRK/r7
         SVCVtAi6qzv0cmVLOzesfknOTzqd32Ea8IZXU9vnUfBJ0Yonie69sZZIqfCCNFsWIAM4
         JOrR1PGZBa8ISfMh6gtW/tjBBcJrqWxzexsX04GiJ7AAyquaGJZP86prGmW8jXIuZjoU
         20Fer/3q5mvphJXhw2fwXudQUaDNst7dnHmIpZ2LvkZbA4yVnrbYUYpk5KsoR0xDjPDC
         SOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=Hmv8s3pg0s+t1LiaHpZrqkhy3HWwUgg1fDUaxrSwS08=;
        b=25cW2iz3flfcWygW0OLUNxye/x9v8CKRBOngoRpyQBw6F+7U376/eY6wN+ns+9guTT
         Y7YunK9eIhmqyE39vfXyd8ZrStvFgXOq0yAo0QpIovTbohfLDXniA/3UgmGyCQA/10Tm
         YaP29otNZOvY30GOm6SMmonmV4BqjAlJyyrp8krB0kNFtXWUFhpJIQmBfoyWczrnwYpc
         KrKM2AuzhAjiMHHsCe0X/G6j8IY9OnC85EvN7ChRBva+wtjGwv5WEm31XWePFW77F7zv
         Owt6FKKxrq87rFpVooQYuZFBbfqXu710KLnHs6u5VNgqDOP0mwVrNA2Oz+A6snuEp3vT
         ThNQ==
X-Gm-Message-State: AOAM531bPrwt/MMCCWdpD8FJ00gnItO5BITjQY13PyEwM7ZjWujgnNRN
        q51mgA3I1kyU1e7+Q7ZqUEw=
X-Google-Smtp-Source: ABdhPJz24m0NujvIKiNUDrKXYHAwM1HNDnsRD1t+Jvl6lD/uJuPtxoSlzDxd0quuZJRRar6vTN71lQ==
X-Received: by 2002:a17:90a:2f84:b0:1dd:940:50e7 with SMTP id t4-20020a17090a2f8400b001dd094050e7mr28050921pjd.210.1652671007531;
        Sun, 15 May 2022 20:16:47 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b0015e8d4eb25fsm5782228pll.169.2022.05.15.20.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 20:16:47 -0700 (PDT)
References: <20220516024448.14637-1-schspa@gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: Re: [PATCH v6 1/2] cpufreq: Abort show/store for half initialized
 policy
Date:   Mon, 16 May 2022 11:15:11 +0800
In-reply-to: <20220516024448.14637-1-schspa@gmail.com>
Message-ID: <m2o7zytbeb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please ignore this patch, it forgets to add the Change logs.

--
BRs
Schspa Shi
