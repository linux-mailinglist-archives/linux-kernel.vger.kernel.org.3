Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CA94B7CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245548AbiBPBiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:38:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbiBPBh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:37:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED79F19C29
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:37:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m7so1131552pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vZVv1ogxeGB/tMAdmK5at+J4W8ez8n3jP7SjDQ5qgg=;
        b=cMc473ICFpscrz6Kg2TEINUfuiiCr7n79NNtBniP8KGkOAF9b9J6ETkih1Hf2OjAaY
         zra7/J1LRD1WVCT266kbSOhNePQTQlSfBQLJZxrHOBeKJGQTbkktK4afhTx62f9qaxUt
         M3bS42hVoqOTo+uWBcluZdMV2jxZLwDujKeQj034WXVqpgt0IyZn1+CxFAH7VvntEie7
         NERFRXNHElKR54xfwdMvbtorHfsJcITMYqzhJ/9/IL3SNbXXflV/aIJBKhjKQFEFApQ7
         RGyj8lNGy2O9KfPT9ksA0Nr0Xxft2xo3mbl4FQaPh8pNq66yD3XEDCxjjKAu4dHCbhFh
         ZxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vZVv1ogxeGB/tMAdmK5at+J4W8ez8n3jP7SjDQ5qgg=;
        b=ML08dJkSvut3WcLlx0gpOIFXES8LDqex+qL66Cee1lSJ1tyBY9pyI4m/iVQ4pl/6Ov
         tke66eCdzuOgRvFzOHMCHgB5mBEJ6u0niglahljwxI5H06OZXlqjK+xay+HtORIKzAq3
         RUZSIj91HyB/UbZA2vZFq5ciDfvcH9qfl/8Kb7dHanBhchZi/KSb1wuKDQj4eMPjX8nU
         ZjAY0RX8pO2c9ixfWcMaXA2XaKhhtCBtZvaE9EgVnB92FwR7qCpj48bzblEGU+I6/VEU
         EaLjctjW/Tl8fVtGIzv0rilIYUpdOzlUSpl5SuL7xOYAglTvwalSIETtfUVywaAPcidC
         qEAA==
X-Gm-Message-State: AOAM531Llgo0V84P5k7fOC+yh+BqHSwjsefS4UIOK+C67FhTLbY6rx7w
        6X1/xP1s6xia10a15DwieQhuKU2xH4wY+04oRSNAtA==
X-Google-Smtp-Source: ABdhPJyfbGOj2LEZYcd2Uhpx0um1C9tckAPR54JZv8aduFLaOPEJOttLOkO5/aF3ENQOMFJJx594Yf87mhQv1RvvLQI=
X-Received: by 2002:a17:90a:f28d:b0:1b9:975f:1a9f with SMTP id
 fs13-20020a17090af28d00b001b9975f1a9fmr265331pjb.220.1644975466504; Tue, 15
 Feb 2022 17:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com> <20220127124058.1172422-7-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220127124058.1172422-7-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 17:37:40 -0800
Message-ID: <CAPcyv4iJnOYfdc41nNtteidMtvt0fLS5RxZkRfk4Y=9vx_pf4A@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] mm: move pgoff_address() to vma_pgoff_address()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:41 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> Since it is not a DAX-specific function, move it into mm and rename it
> to be a generic helper.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks ok to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
