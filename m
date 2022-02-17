Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF614BA735
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbiBQRd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:33:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiBQRdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:33:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE1316040B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:33:41 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id p8so253599pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=1+wuSPGqInJTXF1WSMnW5S9JPVd8nQUvsA9MXOgLl5Y=;
        b=Wkc2oSrjSh4TA0XpeyKv0Bm4R4h/s30wRvOf8CT4gKf6jVrd4pDNFrIVpJM4DeIXrb
         ZLfuIXPRjPP3BnxrFR95/39P48/R4v+Od/x83dS9YbbBmyRaKZJoWb5DagXVHMsVAF7z
         8A27B+FqTyQTJuxibjSTuA+WKhsu6p6Ysx6hdyAEe0iIYcWiDR0iHJ1081+iPFmvsEdA
         OKDnPIfvEyumyRef/6hPzkS3YsSGEn6gWPGzjPO/upatf1OMOcyJpVCT0Nyze7Utpzux
         G5TRfWhBqD1sOgTGRslQEVt9nRyKsk3J5w6sTBWi++cg3f55nEelbLonP9+4B708D6aI
         +GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=1+wuSPGqInJTXF1WSMnW5S9JPVd8nQUvsA9MXOgLl5Y=;
        b=sZ5ScrpjWnUh/7bf/xP9G+i6xWzmL7sf46sZRxEM4PK1umHweH5Won+SMtgs2F2Dkb
         rYzU+nVEz/MurfAGx17CBpj21UZyTrmGqwqzICwDdBDB/1UGMJp8eE5S7Qq04QumbNTA
         Bq1F+kQwpvLl9H3e/7nVAG6pY8BpXt/PKeFfNJiDvNvcx50aMXm7cFX9INN0MAHRn/N8
         RmaSP+bLw/ryswMeZlTgMzF96dGJ4o5KnTyxXsk0Le7Uz8BQTDosX3O3ExxwqHoth8Wv
         rYc9VCuvNzbcJ8ssyuDMk789pjR4BWfGrb9/A32CWwdOGAPXBb4lTVFk5qV6C4BTMXh1
         ecQg==
X-Gm-Message-State: AOAM533RcX5LoQzu8qeIbU0adHBFQFJzwKKq2sFshbH4t4ay4RFsJPVn
        1c0iymhMmvBBzbFK58Gmb5xoWw==
X-Google-Smtp-Source: ABdhPJze4gieq0ct1TT7Ps/SdFLgZ8xxBvl3uLHHh/hPaULz3jZY14KfmoWmBaWhGUX5Y5kj1PqEcw==
X-Received: by 2002:a63:2ac4:0:b0:373:6cfb:fc77 with SMTP id q187-20020a632ac4000000b003736cfbfc77mr3231847pgq.529.1645119220927;
        Thu, 17 Feb 2022 09:33:40 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id q4sm8854188pgn.42.2022.02.17.09.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:33:40 -0800 (PST)
Message-ID: <d9b6c79b-3bd9-579d-59f4-bd1f0e9eaa4c@linaro.org>
Date:   Thu, 17 Feb 2022 09:33:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, zhangqiao22@huawei.com,
        tj@kernel.org, dietmar.eggemann@arm.com
References: <Ygj7feK+vdtPw6zj@zn.tnic>
 <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
 <YgoWoh6pIzlsQx6d@hirez.programming.kicks-ass.net>
 <YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net>
 <Yg4MdYLBqiw8zFaF@hirez.programming.kicks-ass.net>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] sched: Fix yet more sched_fork() races
In-Reply-To: <Yg4MdYLBqiw8zFaF@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 00:51, Peter Zijlstra wrote:
> On Mon, Feb 14, 2022 at 10:16:57AM +0100, Peter Zijlstra wrote:
>> Zhang, Tadeusz, TJ, how does this look?
> 
> *sigh* I was hoping for some Tested-by, since I've no idea how to
> operate this cgroup stuff properly.
> 
> Anyway, full patch below. I'll go stick it in sched/urgent.

Just tested it on 5.17.0-rc4 and it looks ok.

Tested-by: Tadeusz Struk <tadeusz.struk@linaro.org>

-- 
Thanks,
Tadeusz
