Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E14ED38C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiCaFzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiCaFy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:54:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DBD36B49
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:53:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s11so20941992pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BrVp20BmQjd9WSbsMvWT5kt24UKCTLgZvgR7hPflW5I=;
        b=J0orAsxOAk3R3htaeofa12dEY09G1ZOT6xFMUw8eRPdblGAX+zKgalF+zG53xNIBfN
         JIdsxH0KeXhELtsIMEfbGGS8jMDN+ePq9zcaypxHtex4s+/DgPdLpCaI+/6Q6+GgWWKs
         KJEdpD76ISx4i9sPdkdNTpnORTU/yyvxrRPlPLbAYPe0AeCjVdFf7yGjU2RhRFTgms2/
         0RYnJfjAzMGceWUdQXG5RxDGdiaQYO94yuq3nKHFmfxpcOlFbLUCujyc7JzsG35ovPBW
         OeK74pluni7ZWl5BfCWtd2/Z/cENsuT48GSGZFcv3nsYh3EjxsvjTQNwnxUySCiQeBAn
         eTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BrVp20BmQjd9WSbsMvWT5kt24UKCTLgZvgR7hPflW5I=;
        b=5PCXFV5FOap6gyzGJgsbAuwLof1HLyJ7yN85besmWkrEybOOo93pwchA3ALRLjF23W
         ILAftjpmT25kXBV/07/H0PhLiHGg96zpiB+nZcs113iccpevoQ1VGGoxgZnRl2JdGzZJ
         CQXRbO5dnsMxdbLeDqKGqBWqAqQyAs2TG41kWkMnuS3N+LcYCchFgBMvlYCg4gmwXeEX
         qgdp+o544iY7WNvTBy0CPLEMtdPmSm9k+T0MobmgAxASQl/J+Pe6l4yIW2bwADklPe6d
         yz7rdfp+ga714JCQhDl1moWfE3/1jjyzqr9dLibFHQQ9lfwM+5eIjVuBfozcEwFSQdMH
         JiAA==
X-Gm-Message-State: AOAM530szjuTm7UcU7Eyq2BPLXD8FbTjtyrGprYVvTRIhzdI7g1pUE/W
        5xRefQhEheAOUrlV77M2NeXJyw==
X-Google-Smtp-Source: ABdhPJwpnANsxo4xZlJjPDa54Tplqd+KoCrSUKkTKC74/0HoCkJtQWqclS4PEP1Ao1Wh7C3CzDf7gg==
X-Received: by 2002:a63:6f44:0:b0:398:31d6:e37f with SMTP id k65-20020a636f44000000b0039831d6e37fmr9285910pgc.177.1648705990089;
        Wed, 30 Mar 2022 22:53:10 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n18-20020a056a0007d200b004fdac35672fsm1695461pfu.68.2022.03.30.22.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 22:53:09 -0700 (PDT)
Date:   Wed, 30 Mar 2022 22:53:09 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Mar 2022 21:15:09 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix fill_callchain return value
In-Reply-To: <20220311065815.9985-1-nikita.shubin@maquefel.me>
CC:     linux@yadro.com, n.shubin@yadro.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, han_mao@c-sky.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nikita.shubin@maquefel.me
Message-ID: <mhng-d348c041-9628-4aa2-af10-51604edbe48c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 22:58:15 PST (-0800), nikita.shubin@maquefel.me wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
>
> perf_callchain_store return 0 on success, -1 otherwise,
> fix fill_callchain to return correct bool value.
>
> Fixes: dbeb90b0c1eb ("riscv: Add perf callchain support")
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
>  arch/riscv/kernel/perf_callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index 1fc075b8f764..7aca6a238173 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -68,7 +68,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>
>  static bool fill_callchain(void *entry, unsigned long pc)
>  {
> -	return perf_callchain_store(entry, pc);
> +	return perf_callchain_store(entry, pc) == 0;
>  }
>
>  void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,

Thanks, this is on for-next.  Looks like we share some of this code with 
at least arm64, it might be worth refactoring this into something 
generic.
