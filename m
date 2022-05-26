Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127425352D2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbiEZRnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242892AbiEZRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:43:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85D1270B;
        Thu, 26 May 2022 10:43:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x2-20020a17090a1f8200b001e07a64c461so5000821pja.4;
        Thu, 26 May 2022 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2XeapTZ9AYKVkthRNYl2ZLs0CeHmxaKPJGRg8UNRmDo=;
        b=RRN6/cM/5alZYcT4Q7unSO/QARtxQA2DRNjbcBoXInVHKMxULX5JM0UeZp49ag4zW/
         +r7Ch+nPFE1vNgNts3LU4IlcgotndwOJHiFVsqKO5bUT3CJkMzizLVRRnRbbUTKddIIR
         nPBgPAKdOhqDAOwEoKHV9Clr+K9mI07Sek0txBNbB6btWepAJ219tS+DtO8exTYD5Ntq
         hDUTXnhQDCHzSpVLgrcUL0F5fLXm+CcRVSZa5flWNsPHcinq/wXEHG/jNosNYMllEnnF
         fp3XrfrHuRZ8sH8yXTjxjrCPJY6EfHeRzHwtIRFNcmLRn1dWzmbaWtjcOe5j/ZrBLHGg
         kVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2XeapTZ9AYKVkthRNYl2ZLs0CeHmxaKPJGRg8UNRmDo=;
        b=fFwwCY+beyBYtSOP+Hl7r92XVjn65M2q238VbpR8SS0Z+2XBX08MSTKI0PV2sVaYH4
         fit2Rc48IZ6QCZiBQCh38Fsw8JhZ/XrVuJF3fFJN19KtCOhyC0yWPCz0ZXWaJwS0z1bD
         aWEskKKe1QvLcTcXKv63ZHRhu2fHfvT7bRvFVIF73K1u8TIkM7IP1xfoumbGitqTBpIG
         etCCkeePqY/i4ljnQ12ZPgt+Av9LfsZOAkYpphYg1YHLwY5BwD3RIpONC2qPDtN06WRp
         LvBRQrgRwQyxnoSFa8mXiU2dWzLps27ouQ1RZnFlqgYK4OK4XNi8gnw5JpkZzKK+5nOn
         h7VA==
X-Gm-Message-State: AOAM533SCg3/155d4C/CDoVUiVdZHk1NZppxK+Ccy/nvPTPj5lOiqNt+
        xzBLVUNLhXmL+7gOkhtH144=
X-Google-Smtp-Source: ABdhPJz6XchIDONnL7DWL+UWcroBquxNIGOhuG0OOR7akl8esZgT2sPROWEUMvIgqv3z8OuQqqIo7g==
X-Received: by 2002:a17:90a:2f84:b0:1dd:940:50e7 with SMTP id t4-20020a17090a2f8400b001dd094050e7mr3743560pjd.210.1653586988958;
        Thu, 26 May 2022 10:43:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id y17-20020aa79e11000000b0050e0dadb28dsm1771212pfq.205.2022.05.26.10.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 10:43:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 May 2022 07:43:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: fix false positive lagging
Message-ID: <Yo+8K9MrFMl59BGj@slm.duckdns.org>
References: <20220526133554.21079-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526133554.21079-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 26, 2022 at 09:35:54PM +0800, Chengming Zhou wrote:
> I found many false positive lagging during iocost test.
> 
> Since iocg->vtime will be advanced to (vnow - margins.target)
> in hweight_after_donation(), which called throw away excess,
> the iocg->done_vtime will also be advanced that much.
> 
>        period_at_vtime  <--period_vtime-->  vnow
>               |                              |
>   --------------------------------------------------->
>         |<--->|
>      margins.target
>         |->
>   vtime, done_vtime

All it does is shifting the vtime (and done_vtime) within the current window
so that we don't build up budget too lage a budget possibly spanning
multiple periods. The lagging detection is supposed to detect IOs which are
issued two+ periods ago which didn't finish in the last period. So, I don't
think the above sliding up the window affects that detection given that the
lagging detection is done before the window sliding. All it's checking is
whether there still are in-flight IOs which were issued two+ windows ago, so
how the last window has been fast forwarded shouldn't affect the detection,
no?

Thanks.

-- 
tejun
